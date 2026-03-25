library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alarma is 
	port (
		clk: in std_logic;
		reset: in std_logic;
		
		alarm_h1: in std_logic_vector(3 downto 0);
		alarm_h0: in std_logic_vector(3 downto 0);
		alarm_m1: in std_logic_vector(3 downto 0);
		alarm_m0: in std_logic_vector(3 downto 0); 
		
		ceas_h1: in std_logic_vector (3 downto 0);
		ceas_h0: in std_logic_vector (3 downto 0);
		ceas_m1: in std_logic_vector (3 downto 0);
		ceas_m0: in std_logic_vector (3 downto 0);
		
		alarm_on: in std_logic;
		alarma_o: out std_logic
		);
end;

architecture arh_alarm of alarma is
	signal h1: std_logic_vector(3 downto 0):= "0000";
	signal h0: std_logic_vector(3 downto 0):= "0000";
	signal m1: std_logic_vector(3 downto 0):= "0000";
	signal m0: std_logic_vector(3 downto 0):= "0000";	
begin
	alarma: process (clk, reset)
	begin
		if reset = '1' then
			alarma_o<='0';
			h1<=ceas_h1;
			h0<=ceas_h0;
			m1<=ceas_m1;
			m0<=ceas_m0;
		else  
			-- if alarm is turned on, then the component will turn alarm 1 when the current time is equal to the time set on the alarm inputs
			if alarm_on='1' then
				if rising_edge(clk) then
					m0<= m0 + "0001";
					if m0= "1001" then
						m0<= "0000";
						m1<= m1 + "0001";
					end if;
					if m1 = "0101" and m0 = "1001" then 
						m1<="0000";
						m0<= "0000";
						h0 <=h0+ "0001";
					end if;
					if 	m1 = "0101" and m0 = "1001" and h0 = "1001" then
						h0<="0000";
						h1<=h1+"0001";
					end if;
					-- if the time reaches 23:59, the timer will go back to 00:00
					if 	m1 = "0101" and m0 = "1001" and h0 = "0011" and h1 = "0010"	then 
						h1<="0000";
						h0<="0000";
					end if;
					-- verify the condition to "ring" the alarm
					if (alarm_h1=h1) and (alarm_h0=h0) and  (alarm_m1 = m1) and (alarm_m0 = m0) then 
						alarma_o<= '1';
					else
						alarma_o <= '0';	 
					end if;
					
				end if;
				else alarma_o<='0';
			end if;
		end if;
		
	end process;
	
end;
