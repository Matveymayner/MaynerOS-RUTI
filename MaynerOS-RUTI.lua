local component = require("component")
local event = require("event")
local gpu = component.gpu
local computer = require("computer")
local os = require("os")

-- Функция для вывода сообщения на экран
local function message(str)
  gpu.setForeground(0xFFFFFF)
  gpu.setBackground(0x000000)
  gpu.fill(1, 1, 80, 25, " ")
  gpu.set(1, 1, str)
end

-- Функция для вывода кнопки
local function drawButton(x, y, width, height, text, foreground, background)
  gpu.setForeground(foreground)
  gpu.setBackground(background)
  gpu.fill(x, y, width, height, " ")
  local textX = x + math.floor((width - #text) / 2)
  local textY = y + math.floor(height / 2)
  gpu.set(textX, textY, text)
end

-- Функция для обработки команд
local function handleCommand(command)
  if command == "1" then
    message("Shutting down...")
    os.sleep(2)
    computer.shutdown()
  elseif command == "2" then
    message("Rebooting...")
    os.sleep(2)
    computer.shutdown(true)
  elseif command == "3" then
    message("Random number: " .. tostring(math.random(1, 100)))
  elseif command == "4" then
    message("Are you sure you want to delete the OS? (y/n)")
    local _, _, _, _, _, response = event.pull("key_down")
    if response == 21 then
      os.remove("/os.lua")
      os.exit()
    else
      message("OS delete aborted.")
      os.sleep(2)
    end
  elseif command == "5" then
          gpu.setForeground(0xFFFFFF)
    gpu.setBackground(0x0000FF)
    gpu.fill(1, 1, 80, 25, " ")
    gpu.set(32, 12, "your pc dead sorry :(")
    gpu.setBackground(0x000000)
    while true do
      os.sleep(1)
    end

  elseif command == "6" then
    message("Are you sure you want to shutdown the computer? (y/n)")
    while true do
      local _, _, _, _, _, response = event.pull("key_down")
      if response == 21 then
        message("Shutting down...")
        os.sleep(2)
        computer.shutdown()
      elseif response == 49 then
        message("Shutdown aborted.")
        os.sleep(2)
        break
      end
    end
  else
    message("Invalid command.")
    os.sleep(2)
  end
end

-- Очищаем экран
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x000000)
gpu.fill(1, 1, 80, 25, " ")

-- Выводим кнопки
drawButton(25, 8, 30, 3, "Shutdown", 0xFFFFFF, 0x555555)
drawButton(25, 12, 30, 3, "Reboot", 0xFFFFFF, 0x555555)
drawButton(25, 16, 30, 3, "Random Number", 0xFFFFFF, 0x555555)
drawButton(25, 20, 30, 3, "Delete OS", 0xFFFFFF, 0x555555)
drawButton(25, 24, 30, 3, "Blue Screen", 0xFFFFFF, 0x555555)
drawButton(25, 28, 30, 3, "Eternal Shutdown", 0xFFFFFF, 0x555555)

-- Ожидаем нажатия кнопки
while true do
  local _, _, x, y = event.pull("touch")
  if x >= 25 and x <= 54 then
    if y == 8 then
      handleCommand("1")
    elseif y == 12 then
      handleCommand("2")
    elseif y == 16 then
      handleCommand("3")
    elseif y == 20 then
      handleCommand("4")
    elseif y == 24 then
      handleCommand("5")
    elseif y == 28 then
      handleCommand("6")
    end
  end
end
