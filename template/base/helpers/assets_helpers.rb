module AssetsHelpers
  def stylesheet(filename)
    "<link rel='stylesheet' href='/assets/#{filename}.css' />"
  end

  def javascript(filename)
    "<script type='application/javascript' src='/assets/#{filename}.js'></script>"
  end
end
