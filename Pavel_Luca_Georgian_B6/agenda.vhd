library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;			

entity agenda is
port (clock : in std_logic;
	reset : in std_logic:='1';
	
	hour_tens : in std_logic_vector(3 downto 0):="0001";
	hour_units : in std_logic_vector(3 downto 0):="0110";	 
	min_tens : in std_logic_vector(3 downto 0):="0000";	 
	min_units : in std_logic_vector(3 downto 0):="0000";	
	day_tens : in std_logic_vector(3 downto 0):="0000";	 
	day_units : in std_logic_vector(3 downto 0):="0111";	
	month_tens : in std_logic_vector(3 downto 0):="0000";   
	month_units : in std_logic_vector(3 downto 0):="0110";	
	year_1 : in std_logic_vector(3 downto 0):="0010";	 
	year_0 : in std_logic_vector(3 downto 0):="0100";	  	  
	al_hour_tens : in std_logic_vector(3 downto 0):="0010";
	al_hour_units : in std_logic_vector(3 downto 0):="0001";	 
	al_min_tens : in std_logic_vector(3 downto 0):="0101";	 
	al_min_units : in std_logic_vector(3 downto 0):="0000";	 
	
	al_on : in std_logic:='1';
	
	temp_1 : in std_logic_vector(3 downto 0):="0010";	
	temp_0 : in std_logic_vector(3 downto 0):="0101";
	
	hour_tens_out : out std_logic_vector(3 downto 0);
	hour_units_out : out std_logic_vector(3 downto 0); 
	min_tens_out : out std_logic_vector(3 downto 0);	 
	min_units_out : out std_logic_vector(3 downto 0);	
	day_tens_out : out std_logic_vector(3 downto 0);	 
	day_units_out : out std_logic_vector(3 downto 0);	
	month_tens_out : out std_logic_vector(3 downto 0);   
	month_units_out : out std_logic_vector(3 downto 0);	
	year_1_out : out std_logic_vector(3 downto 0);	 
	year_0_out : out std_logic_vector(3 downto 0);  
	day_lett : out string(3 downto 1); 
	
	alarm : out std_logic;
	
	temp_1_out : out std_logic_vector(3 downto 0);
	temp_0_out : out std_logic_vector(3 downto 0));
end;

architecture arch_ag of  agenda is 
component alarma is 
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
end component;

component calendar_orar is 
	port (
		clk : in std_logic;	
		reset : in std_logic:='0';
		
		minute_1 : in std_logic_vector(3 downto 0);
		minute_0: in std_logic_vector(3 downto 0);
		hour_1 : in std_logic_vector(3 downto 0); 
		hour_0 : in std_logic_vector(3 downto 0);
		day_in_1 : in std_logic_vector(3 downto 0); 
		day_in_0 : in std_logic_vector(3 downto 0);
		month_in_1 : in std_logic_vector(3 downto 0); 
		month_in_0 : in std_logic_vector(3 downto 0);
		year_in_1 : in std_logic_vector(3 downto 0); 
		year_in_0 : in std_logic_vector(3 downto 0);
		
		day_lett: out string (3 downto 1);
		
		minute_out_1: out std_logic_vector(3 downto 0);
		minute_out_0: out std_logic_vector(3 downto 0);
		hour_out_1:	out std_logic_vector(3 downto 0);
		hour_out_0:	out std_logic_vector(3 downto 0);
		day_out_1 : out std_logic_vector(3 downto 0); 
		day_out_0 : out std_logic_vector(3 downto 0);
		month_out_1 : out std_logic_vector(3 downto 0); 
		month_out_0 : out std_logic_vector(3 downto 0);
		year_out_1 : out std_logic_vector(3 downto 0); 
		year_out_0 : out std_logic_vector(3 downto 0));
end component; 

begin 
    alrm: alarma port map (
        clk => clock, 
        reset => reset, 
        alarm_h1 => al_hour_tens, 
        alarm_h0 => al_hour_units, 
        alarm_m1 => al_min_tens, 
        alarm_m0 => al_min_units, 
        ceas_h1 => hour_tens, 
        ceas_h0 => hour_units, 
        ceas_m1 => min_tens, 
        ceas_m0 => min_units,
        alarm_on => al_on,  
        alarma_o => alarm 
    );

    data_si_ora: calendar_orar port map (
        clk => clock, 
        reset => reset, 
        minute_1 => min_tens, 
        minute_0 => min_units, 
        hour_1 => hour_tens, 
        hour_0 => hour_units, 
        day_in_1 => day_tens, 
        day_in_0 => day_units, 
        month_in_1 => month_tens, 
        month_in_0 => month_units, 
        year_in_1 => year_1, 
        year_in_0 => year_0, 
        day_lett => day_lett, 
        minute_out_1 => min_tens_out, 
        minute_out_0 => min_units_out, 
        hour_out_1 => hour_tens_out, 
        hour_out_0 => hour_units_out, 
        day_out_1 => day_tens_out, 
        day_out_0 => day_units_out, 
        month_out_1 => month_tens_out, 
        month_out_0 => month_units_out, 
        year_out_1 => year_1_out, 
        year_out_0 => year_0_out 
    );
    temp_1_out <= temp_1;
    temp_0_out <= temp_0;
end;



