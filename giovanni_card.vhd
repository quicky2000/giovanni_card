--
--    This file is part of giovanni_card
--    Copyright (C) 2011  Julien Thevenon ( julien_thevenon at yahoo.fr )
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity giovanni_card is
  Port ( w1a : inout  STD_LOGIC_VECTOR (15 downto 0);
         w1b : inout  STD_LOGIC_VECTOR (15 downto 0);
         scr_red : in  STD_LOGIC_VECTOR (5 downto 0);
         scr_green : in  STD_LOGIC_VECTOR (5 downto 0);
         scr_blue : in  STD_LOGIC_VECTOR (5 downto 0);
         scr_clk : in  STD_LOGIC;
         scr_hsync : in  STD_LOGIC;
         scr_vsync : in  STD_LOGIC;
         scr_enable : in  STD_LOGIC;
         scr_right_left : in  STD_LOGIC;
         scr_up_down : in  STD_LOGIC;
         audio_right : in  STD_LOGIC; --pin 2 audio
         audio_left : in  STD_LOGIC; -- pin 3 audio
         audio_stereo_ok : out  STD_LOGIC; -- pin 4 audio
         audio_plugged : out  STD_LOGIC; -- pin 5 audio
         io : inout  STD_LOGIC_VECTOR (3 downto 0));
end giovanni_card;

architecture Behavioral of giovanni_card is
  signal reg_scr_red : std_logic_vector(5 downto 0) := (others => '0');
  signal reg_scr_green : std_logic_vector(5 downto 0) := (others => '0');
  signal reg_scr_blue : std_logic_vector(5 downto 0) := (others => '0');
  signal reg_scr_hsync : std_logic := '0';
  signal reg_scr_vsync : std_logic := '0';
  signal reg_scr_enable : std_logic := '0';
begin

  screens_signals_register : process(scr_clk)
  begin
    if rising_edge(scr_clk) then
      reg_scr_red <= scr_red;
      reg_scr_green <= scr_green;
      reg_scr_blue <= scr_blue;
      reg_scr_hsync <= scr_hsync;
      reg_scr_vsync <= scr_vsync;
      reg_scr_enable <= scr_enable;
    end if;
  end process;

  w1a(0) <= io(0);
  w1a(1) <= io(1);
  w1a(2) <= scr_up_down;  -- LCD_31
  w1a(3) <= reg_scr_enable;   -- LCD_27
  w1a(4) <= reg_scr_blue(5);  -- LCD_25
  w1a(5) <= reg_scr_blue(3);  -- LCD_23
  w1a(6) <= reg_scr_blue(1);  -- LCD_21
  w1a(7) <= reg_scr_green(4); -- LCD_17
  w1a(8) <= reg_scr_green(2); -- LCD_15
  w1a(9) <= reg_scr_green(0); -- LCD_13
  w1a(10) <= reg_scr_red(5);  -- LCD_11
  w1a(11) <= reg_scr_red(3);  -- LCD_9
  w1a(12) <= reg_scr_red(1);  -- LCD_7
  w1a(13) <= reg_scr_hsync;   -- LCD_3
  w1a(14) <= audio_right;
  w1a(15) <= audio_left;

  audio_stereo_ok <= w1b(0);
  audio_plugged <= w1b(1);
  w1b(2) <= scr_clk;      -- LCD 2
  w1b(3) <= reg_scr_vsync;    -- LCD 4
  w1b(4) <= reg_scr_red(0);   -- LCD_6
  w1b(5) <= reg_scr_red(2);   -- LCD_8
  w1b(6) <= reg_scr_red(4);   -- LCD_10
  w1b(7) <= reg_scr_green(1); -- LCD_14
  w1b(8) <= reg_scr_green(3); -- LCD_16
  w1b(9) <= reg_scr_green(5); -- LCD_18
  w1b(10) <= reg_scr_blue(0); -- LCD_20
  w1b(11) <= reg_scr_blue(2); -- LCD_22
  w1b(12) <= reg_scr_blue(4); -- LCD_24
  w1b(13) <= scr_right_left; --LCD_30
  w1b(14) <= io(2);
  w1b(15) <= io(3);

end Behavioral;

