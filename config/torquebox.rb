TorqueBox.configure do

  stomplet Responses do
    route '/game/responses'
  end

  stomplet Questions do
    route '/game/questions'
  end

  stomplet Control do
    route '/game/control'
  end

  topic '/topics/questions'
  queue '/queues/responses'

end
