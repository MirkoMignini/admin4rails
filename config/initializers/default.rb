Admin4rails.setup do
  config! do
    title! 'Admin4Rails'
    adapter! :activerecord
  end

  header! do
    visible! true
    logo! do
      text! '<strong>Admin</strong>4<i>Rails</i>'
      text_mini! '<strong>A</strong>4<i>R</i>'
      href! '#'
    end
  end

  sidebar do
    layout! do
      header text: 'Main'
      resources
    end
  end
end
