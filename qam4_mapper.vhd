 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
 
 entity qam4_mapper
 
	port(
		bits_in : in std_logic_vector (1 downto 0);
		sym_out_re: out std_logic_vector (1 downto 0);
		sym_out_im : out std_logic_vector (1 downto 0)
		
	);
	
end qam4_mapper;

architecture behavioral of qam4_mapper is 
	
	-- Constellation size:
	constant const_size : integer := 4;
	type constellation is array (0 to const_size-1) of signed (1 downto 0);

	-- Constellation
	-- Bits In | Output symbol
	--            Re, Im 
	-- (00)    | (+1,+1)
	-- (01)    | (-1,+1)
	-- (10)    | (+1,-1)
	-- (11)    | (-1,-1)

	-- Real part of the constellation
	constant qam4_const_re : constellation := (
		to_signed(1,2),
		to_signed(-1,2),
		to_signed(1,2),
		to_signed(-1,2)
		);
		
	-- Imaginary part of the constellation	
	constant qam4_const_im : constellation := (
		to_signed(1,2),
		to_signed(1,2),
		to_signed(-1,2),
		to_signed(-1,2)
		);
	-- Signal 
	signal  bits_in_unsigned : unsigned (1 downto 0);
	
begin
	
	-- Using the input bits to index the constellation array
	bits_in_unsigned <= unsigned(bits_in);
	-- Map the input bits to QAM symbols
	sym_out_re <= std_logic_vector(qam4_const_re(to_integer(bits_in_unsigned)));
	sym_out_im <= std_logic_vector(qam4_const_re(to_integer(bits_in_unsigned)));
	
end behavioral;