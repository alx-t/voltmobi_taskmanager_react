module SharedExampleMacros
  def do_request(http_path, http_method, options = {})
    send http_method.to_sym, http_path, {}.merge(options)
  end
end

