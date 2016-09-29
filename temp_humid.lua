id  = 0
sda = 2
scl = 1

-- initialize i2c, set pin1 as sda, set pin2 as scl
i2c.setup(id, sda, scl, i2c.SLOW)

local HDC1000 = require "HDC1000"

HDC1000.begin()


function print_temp_hum()
    humid = HDC1000.hum()
    print("Humidity: "..humid)
    temp = HDC1000.temp()
    temp = (temp * 1.8) + 32
    print("Temperature: "..temp)
end

tmr.register(0, 5000, tmr.ALARM_AUTO, function() print_temp_hum() end)
tmr.start(0)
