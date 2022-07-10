----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2022 09:31:55 PM
-- Design Name: 
-- Module Name: a3 - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity a3 is    -- make a entity with name as a3
    Port ( clk : in STD_LOGIC;      --define a clock 
           B : in STD_LOGIC_VECTOR (15 downto 0);   --define a vector of length 16 that contains input 4 length for each display
           segment : out STD_LOGIC_VECTOR (6 downto 0); --define a vector of length 7 that contains output of 7 segment display 
           anode : out STD_LOGIC_VECTOR (3 downto 0)); -- define a vector of size 4 for the 4 seven segment display
end a3;

architecture Behavioral of a3 is

signal Bt:std_logic_vector(3 downto 0):="0000"; --define a signal for handle the input given by the switches
signal refresh_rate:integer range 0 to 60000:=0; --define an integer for apply the timer to the clock 
signal clk_input:std_logic_vector( 1 downto 0):="00"; -- define a signal of size 2-bit for selecting a anode.

begin

-- Define a process of a combinational circuit using the logical expressions for each output segment
process(Bt)
begin
segment(0) <= (not Bt(3) and not Bt(2) and not Bt(1) and Bt(0)) or(not Bt(3) and Bt(2) and not Bt(1) and not Bt(0)) or (Bt(3) and Bt(2) and not Bt(1) and Bt(0)) or (Bt(3) and not Bt(2) and Bt(1) and Bt(0));
segment(1) <= (Bt(2) and Bt(1) and not Bt(0)) or (Bt(3) and Bt(1) and Bt(0)) or (not Bt(3) and Bt(2) and not Bt(1) and Bt(0)) or (Bt(3) and Bt(2) and not Bt(1) and not Bt(0));
segment(2) <= ((NOT Bt(3)) AND (NOT Bt(2)) AND Bt(1) AND (NOT Bt(0))) OR (Bt(3) AND Bt(2) AND Bt(1)) OR (Bt(3) AND Bt(2) AND (NOT Bt(0)));
segment(3) <= ((NOT Bt(3)) AND (NOT Bt(2)) AND (NOT Bt(1)) AND Bt(0)) OR ((NOT Bt(3)) AND Bt(2) AND (NOT Bt(1)) AND (NOT Bt(0))) OR (Bt(3) AND (NOT Bt(2)) AND Bt(1) AND (NOT Bt(0))) OR (Bt(2) AND Bt(1) AND Bt(0));
segment(4) <= ((NOT Bt(2)) AND (NOT Bt(1)) AND Bt(0)) OR ((NOT Bt(3)) AND Bt(0)) OR ((NOT Bt(3)) AND Bt(2) AND (NOT Bt(1)));
segment(5) <= ((NOT Bt(3)) AND (NOT Bt(2)) AND Bt(0)) OR ((NOT Bt(3)) AND (NOT Bt(2)) AND (Bt(1))) OR ((NOT Bt(3)) AND Bt(1) AND Bt(0)) OR (Bt(3) AND Bt(2) AND (NOT Bt(1)) AND Bt(0));
segment(6) <= ((NOT Bt(3)) AND (NOT Bt(2)) AND (NOT Bt(1))) OR ((NOT Bt(3)) AND Bt(2) AND Bt(1) AND Bt(0)) OR (Bt(3) AND Bt(2) AND (NOT Bt(1)) AND (NOT Bt(0)));

end process;

-- process over clock for showing the output to the seven segment display only at the rising rising_edge
process(clk)
begin
if rising_edge(clk) then
    refresh_rate <= refresh_rate +1;
    if refresh_rate = 60000 then
        refresh_rate <= 0;
        clk_input <= clk_input + '1';
        case( clk_input ) is
            -- case when we need to show the output on he display on the left
            when "00" =>
                anode <= "0111";
                Bt<=B(15 downto 12);
            
            -- case when we need to show the output on he display on the 2nd left
            when "01" =>
                anode <= "1011";
                Bt<=B(11 downto 8);
            
            -- case when we need to show the output on he display on the 2nd right
            when "10" =>
                anode <= "1101";
                Bt<=B(7 downto 4);
            
            -- case when we need to show the output on he display on the right
            when "11" =>
                anode <= "1110";
                Bt<=B(3 downto 0);
    
        
            when others =>
                anode <= "0000";
        end case ;
    end if ;
end if;
end process;

end Behavioral;