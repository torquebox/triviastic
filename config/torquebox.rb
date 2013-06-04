TorqueBox.configure do

  web do
    host 'localhost'
    context '/'
  end

  stomplet Responses do
    route '/game/responses'
  end

  stomplet Questions do
    route '/game/questions'
  end

  stomplet Control do
    route '/game/control'
  end

  stomplet Roster do
    route '/game/roster'
  end

  stomplet Scorekeeper do
    route '/game/scorekeeper'
  end

  topic '/topics/roster'
  topic '/topics/questions'
  topic '/topics/responses'
  #topic '/topics/scorekeeper'

end
