library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PCK_CRC32_D32.ALL;

entity axi4_crc is
	Port (  
	
		s_axi4_aclk 			: IN STD_LOGIC;
		s_axi4_aresetn 			: IN STD_LOGIC;
		s_axi4_awaddr 			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_awlen 			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi4_awsize 			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_awburst 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_awlock 			: IN STD_LOGIC;
		s_axi4_awcache 			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_awprot 			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_awvalid 			: IN STD_LOGIC;
		s_axi4_awready 			: IN STD_LOGIC;
		s_axi4_wdata 			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_wstrb 			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_wlast 			: IN STD_LOGIC;
		s_axi4_wvalid 			: IN STD_LOGIC;
		s_axi4_wready 			: IN STD_LOGIC;
		s_axi4_bresp 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_bvalid 			: IN STD_LOGIC;
		s_axi4_bready 			: IN STD_LOGIC;
		s_axi4_araddr 			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_arlen 			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi4_arsize 			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_arburst 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_arlock 			: IN STD_LOGIC;
		s_axi4_arcache 			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_arprot 			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_arvalid 			: IN STD_LOGIC;
		s_axi4_arready 			: IN STD_LOGIC;
		s_axi4_rdata 			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_rresp 			: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_rlast 			: IN STD_LOGIC;
		s_axi4_rvalid 			: IN STD_LOGIC;
		s_axi4_rready 			: IN STD_LOGIC;
		
		S_AXILITE_ACLK			: in std_logic;
		S_AXILITE_ARESETN		: in std_logic;
		S_AXILITE_AWADDR		: in std_logic_vector(6-1 downto 0);
		S_AXILITE_AWPROT		: in std_logic_vector(2 downto 0);
		S_AXILITE_AWVALID		: in std_logic;
		S_AXILITE_AWREADY		: out std_logic;
		S_AXILITE_WDATA			: in std_logic_vector(32-1 downto 0);
		S_AXILITE_WSTRB			: in std_logic_vector((32/8)-1 downto 0);
		S_AXILITE_WVALID		: in std_logic;
		S_AXILITE_WREADY		: out std_logic;
		S_AXILITE_BRESP			: out std_logic_vector(1 downto 0);
		S_AXILITE_BVALID		: out std_logic;
		S_AXILITE_BREADY		: in std_logic;
		S_AXILITE_ARADDR		: in std_logic_vector(6-1 downto 0);
		S_AXILITE_ARPROT		: in std_logic_vector(2 downto 0);
		S_AXILITE_ARVALID		: in std_logic;
		S_AXILITE_ARREADY		: out std_logic;
		S_AXILITE_RDATA			: out std_logic_vector(32-1 downto 0);
		S_AXILITE_RRESP			: out std_logic_vector(1 downto 0);
		S_AXILITE_RVALID		: out std_logic;
		S_AXILITE_RREADY		: in std_logic
	);
end axi4_crc;

architecture Behavioral of axi4_crc is	
	signal crc : std_logic_vector(31 downto 0) := (others=>'1');
	signal crc_out : std_logic_vector(31 downto 0) := (others=>'0');
	
	signal clear_crc : std_logic_vector(31 downto 0);
	
	signal word_cnt	 : unsigned(31 downto 0) := to_unsigned(0, 32);
	
	-- https://groups.google.com/d/msg/comp.lang.vhdl/eBZQXrw2Ngk/4H7oL8hdHMcJ
	function reverse_any_vector (a: in std_logic_vector)
	return std_logic_vector is
	  variable result: std_logic_vector(a'RANGE);
	  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
	begin
	  for i in aa'RANGE loop
		result(i) := aa(i);
	  end loop;
	  return result;
	end; -- function reverse_any_vector
	
	component axi_crc_axilite is
        generic (
            C_S_AXI_DATA_WIDTH    : integer    := 32;
            C_S_AXI_ADDR_WIDTH    : integer    := 6
        );
        port (
            S_AXI_ACLK                  : in std_logic;
            S_AXI_ARESETN               : in std_logic;
            S_AXI_AWADDR                : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_AWPROT                : in std_logic_vector(2 downto 0);
            S_AXI_AWVALID               : in std_logic;
            S_AXI_AWREADY               : out std_logic;
            S_AXI_WDATA                 : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_WSTRB                 : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
            S_AXI_WVALID                : in std_logic;
            S_AXI_WREADY                : out std_logic;
            S_AXI_BRESP                 : out std_logic_vector(1 downto 0);
            S_AXI_BVALID                : out std_logic;
            S_AXI_BREADY                : in std_logic;
            S_AXI_ARADDR                : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_ARPROT                : in std_logic_vector(2 downto 0);
            S_AXI_ARVALID               : in std_logic;
            S_AXI_ARREADY               : out std_logic;
            S_AXI_RDATA                 : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_RRESP                 : out std_logic_vector(1 downto 0);
            S_AXI_RVALID                : out std_logic;
            S_AXI_RREADY                : in std_logic;
            
            reg_crc                     : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            clear_crc                   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            word_cnt					: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)
        );
    end component;
	
begin

process(s_axi4_aclk)	

begin
	if rising_edge(s_axi4_aclk) then
		if (s_axi4_aresetn = '0' or clear_crc(0) = '1') then
			-- reset		
			crc <= (others=>'1');
			crc_out <= (others=>'0');
			word_cnt <= to_unsigned(0, word_cnt'length);
		else
			-- output crc must be reversed and inverted
			crc_out <= not reverse_any_vector(crc);
			-- if read is valid, the master is ready and the read response is OKAY or EXOKAY
			if (s_axi4_rvalid = '1' and s_axi4_rready = '1' and (s_axi4_rresp = "00" or s_axi4_rresp = "01")) then
				crc <= nextCRC32_D32(reverse_any_vector(s_axi4_rdata), crc);
				word_cnt <= word_cnt + 1;
			end if;
		end if;
	end if; 
end process;


-- insantiate module for axilite
i_axi_crc : axi_crc_axilite 
	port map (
		S_AXI_ACLK		=> S_AXILITE_ACLK,
		S_AXI_ARESETN	=> S_AXILITE_ARESETN,
		S_AXI_AWADDR	=> S_AXILITE_AWADDR,
		S_AXI_AWPROT	=> S_AXILITE_AWPROT,
		S_AXI_AWVALID	=> S_AXILITE_AWVALID,
		S_AXI_AWREADY	=> S_AXILITE_AWREADY,
		S_AXI_WDATA		=> S_AXILITE_WDATA,
		S_AXI_WSTRB		=> S_AXILITE_WSTRB,
		S_AXI_WVALID	=> S_AXILITE_WVALID,
		S_AXI_WREADY	=> S_AXILITE_WREADY,
		S_AXI_BRESP		=> S_AXILITE_BRESP,
		S_AXI_BVALID	=> S_AXILITE_BVALID,
		S_AXI_BREADY	=> S_AXILITE_BREADY,
		S_AXI_ARADDR	=> S_AXILITE_ARADDR,
		S_AXI_ARPROT	=> S_AXILITE_ARPROT,
		S_AXI_ARVALID	=> S_AXILITE_ARVALID,
		S_AXI_ARREADY	=> S_AXILITE_ARREADY,
		S_AXI_RDATA		=> S_AXILITE_RDATA,
		S_AXI_RRESP		=> S_AXILITE_RRESP,
		S_AXI_RVALID	=> S_AXILITE_RVALID,
		S_AXI_RREADY	=> S_AXILITE_RREADY,
        
		reg_crc			=> crc_out,
		clear_crc		=> clear_crc,
		word_cnt		=> std_logic_vector(word_cnt)
	);

end Behavioral;
