loop do
  std_out = IO::Memory.new
  std_err = IO::Memory.new

  battery_status = Process.run("cat", args: ["/sys/class/power_supply/BAT0/capacity"], output: std_out, error: std_err)

  if battery_status.success?
    baterry_level = Int32.new(std_out.to_s)

    case baterry_level
    when 5
      Process.run("notify-send", args: ["BATERIA DESCARREGANDO #{baterry_level}%", "Conecte um carregador imediatamente!"])
    when 10
      Process.run("notify-send", args: ["BATERIA DESCARREGANDO #{baterry_level}%"])
    when 100
      Process.run("notify-send", args: ["BATERIA CARREGADA #{baterry_level}%", "Desconecte o carregador!"])
    end
  end

  sleep 120.seconds
end
