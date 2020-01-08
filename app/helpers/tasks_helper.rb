module TasksHelper
  def display_priority(priority)
    case priority
    when '3' then
      p '高'
    when '2' then
      p '中'
    when '1' then
      p '低'
    else
      p '優先度を選択してください。'
    end
  end
end