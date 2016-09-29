# HDC1000
This is a NodeMCU module for the HDC1000 temperature and humidity sensor. The HDC1000.lua file is the module, and 
temp_humid.lua is an example program that takes and prints temperature and humidity measurements every 5 seconds. The 
file HDC1000_src.lua is included for ease of debugging/reading code from the module. The two .lua files are functionally 
identical, but I used LuaSrcDiet to obtain HDC1000.lua, so there is no whitespace, comments, or meaningful variable 
names in that file. HDC1000_src.lua contains all those things, and as a result is 3x the size.
