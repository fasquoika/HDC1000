local HDC1000 = {}
--Sets up sensor by writing to register 0x02, the config register on the HDC1000
function HDC1000.begin(dev_addr)
    --default to 0x40 as device address
    if dev_addr == nil then dev_addr = 0x40 end

    --write pointer to config register
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, 0x02)
    --wait for connection to proper register? Idk, doesn't work without though
    tmr.delay(1000)

    --set reset bit (bit[15]) and aquisition bit (bit[12]) high
    i2c.write(id, 0x9)
    i2c.stop(id)
    --wait for measurement
    tmr.delay(15000)
end


--function reads from register 0x00, temperature output on HDC1000
function HDC1000.temp(dev_addr)
    --default to 0x40 as device address
    if dev_addr == nil then dev_addr = 0x40 end

    --write pointer to temperature output
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, 0x00)
    i2c.stop(id)
    --wait for connection to proper register? Idk, doesn't work without though
    tmr.delay(20000)
    
    --read the register bits and return string, requires conversion to decimal
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    local r = i2c.read(id, 2) 
    i2c.stop(id)

    --conversion from string to decimal
    x, y = string.byte(r, 1, 2) --turn the string into 2 decimal ascii values
    value = (x * 256) + y  --convert to 2 byte single value
    
    --convert the decimal to deg celsius as per the datasheet
    temperature = (( value / 65536 ) * 165) - 40 

    return temperature
end


--function reads from register 0x01, humidity output on HDC1000
function HDC1000.hum(dev_addr)
    --default to 0x40 as device address
    if dev_addr == nil then dev_addr = 0x40 end

    --write pointer to humidity output
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, 0x01)
    i2c.stop(id)
    --wait for connection to proper register? Idk, doesn't work without this though
    tmr.delay(20000)
    
    --read the register bits and return string, requires complex conversion to decimal
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    local r = i2c.read(id, 2) 
    i2c.stop(id)

    --conversion from string to decimal
    x, y = string.byte(r, 1, 2) --turn the string into 2 decimal ascii values
    value = (x * 256) + y  --convert to 2 byte single value
    
    --convert the decimal to percent relative humidity as per the datasheet
    humidity = ( value / 65536 ) * 100

    return humidity
end

return HDC1000
