id=0
sda=2
scl=1
i2c.setup(id,sda,scl,i2c.SLOW)
local e={}
function e.begin(e)
if e==nil then e=64 end
i2c.start(id)
i2c.address(id,e,i2c.TRANSMITTER)
i2c.write(id,2)
tmr.delay(1e3)
i2c.write(id,9)
i2c.stop(id)
tmr.delay(15e3)
end
function e.temp(e)
if e==nil then e=64 end
i2c.start(id)
i2c.address(id,e,i2c.TRANSMITTER)
i2c.write(id,0)
i2c.stop(id)
tmr.delay(2e4)
i2c.start(id)
i2c.address(id,e,i2c.RECEIVER)
local e=i2c.read(id,2)
i2c.stop(id)
x,y=string.byte(e,1,2)
value=(x*256)+y
temperature=((value/65536)*165)-40
return temperature
end
function e.hum(e)
if e==nil then e=64 end
i2c.start(id)
i2c.address(id,e,i2c.TRANSMITTER)
i2c.write(id,1)
i2c.stop(id)
tmr.delay(2e4)
i2c.start(id)
i2c.address(id,e,i2c.RECEIVER)
local e=i2c.read(id,2)
i2c.stop(id)
x,y=string.byte(e,1,2)
value=(x*256)+y
humidity=(value/65536)*100
return humidity
end
return e
