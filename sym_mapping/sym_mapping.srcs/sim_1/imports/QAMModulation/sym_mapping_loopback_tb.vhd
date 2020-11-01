 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
 
 entity sym_map_tb is 
 end sym_map_tb;
 
 
 architecture behavioral of sym_map_tb is 
 
	constant clk_period : time := 10 ns;
	signal clk : std_logic;
	signal rst : std_logic;
	
	signal two_bit_cnt : unsigned(1 downto 0);
	signal tx_bits : std_logic_vector (1 downto 0);
 begin 
 
 
 -----------------------------------------------
 -- Clock and reset generation
 -----------------------------------------------
	clk_gen : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	rst_gen : process
	begin 
		rst <= '1';
		wait for 2*clk_period;
		rst <= '0';
		wait;
	end process;
	
 -----------------------------------------------
 -- 2 bit counter
 -----------------------------------------------
	-- Pass both clock and reset signal to sensitivity list:
	cnt_proc : process (clk,rst)
	begin 
		if (rst = '1') then 
			two_bit_cnt <= (others => '0');
		elsif (rising_edge(clk)) then 
			two_bit_cnt <= two_bit_cnt +1;
		end if;		
	end process;
	
	tx_bits <= std_logic_vector(two_bit_cnt);
	
 -----------------------------------------------
 -- Tx QAM Mapper Block
 -----------------------------------------------
	
	qam4_mapper_i : entity work.qam4_mapper
		port map(
			bits_in    => tx_bits,
			sym_out_re => open, 
			sym_out_im => open
			
		);

 end behavioral;