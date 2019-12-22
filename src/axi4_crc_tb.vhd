----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2016 22:14:27
-- Design Name: 
-- Module Name: rgmii_tx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity axi4_crc_tb is

end axi4_crc_tb;

architecture Behavioral of axi4_crc_tb is
	
	component axi4_crc is
	Port (  
		s_axi_aclk : IN STD_LOGIC;
		s_axi_aresetn : IN STD_LOGIC;
		s_axi4_aclk : IN STD_LOGIC;
		s_axi4_aresetn : IN STD_LOGIC;
		s_axi_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		s_axi_awvalid : IN STD_LOGIC;
		s_axi_awready : IN STD_LOGIC;
		s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi_wvalid : IN STD_LOGIC;
		s_axi_wready : IN STD_LOGIC;
		s_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_bvalid : IN STD_LOGIC;
		s_axi_bready : IN STD_LOGIC;
		s_axi_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		s_axi_arvalid : IN STD_LOGIC;
		s_axi_arready : IN STD_LOGIC;
		s_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_rvalid : IN STD_LOGIC;
		s_axi_rready : IN STD_LOGIC;
		s_axi4_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi4_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_awlock : IN STD_LOGIC;
		s_axi4_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_awvalid : IN STD_LOGIC;
		s_axi4_awready : IN STD_LOGIC;
		s_axi4_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_wlast : IN STD_LOGIC;
		s_axi4_wvalid : IN STD_LOGIC;
		s_axi4_wready : IN STD_LOGIC;
		s_axi4_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_bvalid : IN STD_LOGIC;
		s_axi4_bready : IN STD_LOGIC;
		s_axi4_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi4_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_arlock : IN STD_LOGIC;
		s_axi4_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi4_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi4_arvalid : IN STD_LOGIC;
		s_axi4_arready : IN STD_LOGIC;
		s_axi4_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s_axi4_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi4_rlast : IN STD_LOGIC;
		s_axi4_rvalid : IN STD_LOGIC;
		s_axi4_rready : IN STD_LOGIC
	);
	end component;

	signal s_axi_aclk : STD_LOGIC;
	signal s_axi_aresetn : STD_LOGIC;
	signal s_axi4_aclk : STD_LOGIC;
	signal s_axi4_aresetn : STD_LOGIC := '0';
	signal s_axi_awaddr : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal s_axi_awvalid : STD_LOGIC;
	signal s_axi_awready : STD_LOGIC;
	signal s_axi_wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi_wstrb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal s_axi_wvalid : STD_LOGIC;
	signal s_axi_wready : STD_LOGIC;
	signal s_axi_bresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi_bvalid : STD_LOGIC;
	signal s_axi_bready : STD_LOGIC;
	signal s_axi_araddr : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal s_axi_arvalid : STD_LOGIC;
	signal s_axi_arready : STD_LOGIC;
	signal s_axi_rdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi_rresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi_rvalid : STD_LOGIC;
	signal s_axi_rready : STD_LOGIC;
	signal s_axi4_awaddr : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi4_awlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal s_axi4_awsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal s_axi4_awburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi4_awlock : STD_LOGIC;
	signal s_axi4_awcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal s_axi4_awprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal s_axi4_awvalid : STD_LOGIC;
	signal s_axi4_awready : STD_LOGIC;
	signal s_axi4_wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi4_wstrb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal s_axi4_wlast : STD_LOGIC;
	signal s_axi4_wvalid : STD_LOGIC;
	signal s_axi4_wready : STD_LOGIC;
	signal s_axi4_bresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi4_bvalid : STD_LOGIC;
	signal s_axi4_bready : STD_LOGIC;
	signal s_axi4_araddr : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi4_arlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal s_axi4_arsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal s_axi4_arburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi4_arlock : STD_LOGIC;
	signal s_axi4_arcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal s_axi4_arprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal s_axi4_arvalid : STD_LOGIC;
	signal s_axi4_arready : STD_LOGIC;
	signal s_axi4_rdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal s_axi4_rresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal s_axi4_rlast : STD_LOGIC;
	signal s_axi4_rvalid : STD_LOGIC;
	signal s_axi4_rready : STD_LOGIC;
	
begin

axi4_crc_i: axi4_crc port map (
		s_axi_aclk 			=> s_axi_aclk,
		s_axi_aresetn 		=>  s_axi_aresetn,
		s_axi4_aclk 		=>  s_axi_aresetn,
		s_axi4_aresetn 		=>  s_axi_aresetn,
		s_axi_awaddr 		=>  s_axi_awaddr,
		s_axi_awvalid 		=>  s_axi_awvalid,
		s_axi_awready 		=>  s_axi_awready,
		s_axi_wdata 		=>  s_axi_wdata,
		s_axi_wstrb 		=>  s_axi_wstrb,
		s_axi_wvalid 		=>  s_axi_wvalid,
		s_axi_wready 		=>  s_axi_wready,
		s_axi_bresp 		=>  s_axi_bresp,
		s_axi_bvalid 		=>  s_axi_bvalid,
		s_axi_bready 		=>  s_axi_bready,
		s_axi_araddr 		=>  s_axi_araddr,
		s_axi_arvalid 		=>  s_axi_arvalid,
		s_axi_arready 		=>  s_axi_arready,
		s_axi_rdata 		=>  s_axi_rdata,
		s_axi_rresp 		=>  s_axi_rresp,
		s_axi_rvalid 		=>  s_axi_rvalid,
		s_axi_rready 		=>  s_axi_rready,
		s_axi4_awaddr 		=>  s_axi4_awaddr,
		s_axi4_awlen 		=>  s_axi4_awlen,
		s_axi4_awsize 		=>  s_axi4_awsize,
		s_axi4_awburst 		=>  s_axi4_awburst,
		s_axi4_awlock 		=>  s_axi4_awlock,
		s_axi4_awcache 		=>  s_axi4_awcache,
		s_axi4_awprot 		=>  s_axi4_awprot,
		s_axi4_awvalid 		=>  s_axi4_awvalid,
		s_axi4_awready 		=>  s_axi4_awready,
		s_axi4_wdata 		=>  s_axi4_wdata,
		s_axi4_wstrb 		=>  s_axi4_wstrb,
		s_axi4_wlast 		=>  s_axi4_wlast,
		s_axi4_wvalid 		=>  s_axi4_wvalid,
		s_axi4_wready 		=>  s_axi4_wready,
		s_axi4_bresp 		=>  s_axi4_bresp,
		s_axi4_bvalid 		=>  s_axi4_bvalid,
		s_axi4_bready 		=>  s_axi4_bready,
		s_axi4_araddr 		=>  s_axi4_araddr,
		s_axi4_arlen 		=>  s_axi4_arlen,
		s_axi4_arsize 		=>  s_axi4_arsize,
		s_axi4_arburst 		=>  s_axi4_arburst,
		s_axi4_arlock 		=>  s_axi4_arlock,
		s_axi4_arcache 		=>  s_axi4_arcache,
		s_axi4_arprot 		=>  s_axi4_arprot,
		s_axi4_arvalid 		=>  s_axi4_arvalid,
		s_axi4_arready 		=>  s_axi4_arready,
		s_axi4_rdata 		=>  s_axi4_rdata,
		s_axi4_rresp 		=>  s_axi4_rresp,
		s_axi4_rlast 		=>  s_axi4_rlast,
		s_axi4_rvalid 		=>  s_axi4_rvalid,
		s_axi4_rready 		=>  s_axi4_rready
);


process
begin
	s_axi_aclk <= '1';
	wait for 5 ns;
	s_axi_aclk <= '0';
	wait for 5 ns;
end process;

s_axi4_aresetn <= '1' after 100 ns;

process
begin
	wait for 100 ns;
	wait until rising_edge(s_axi_aclk);
	for i in 0 to 1 loop
		s_axi4_rvalid <= '1';
		s_axi4_rready <= '1';
		s_axi4_rdata <= std_logic_vector(to_unsigned(i, s_axi_rdata'length));
		wait until rising_edge(s_axi_aclk);
	end loop;
	s_axi4_rvalid <= '0';
	s_axi4_rready <= '0';
	wait until rising_edge(s_axi_aclk);
	wait for 1000 ms;
end process;
end Behavioral;
