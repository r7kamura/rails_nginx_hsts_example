class StrictTransportSecurityRemover
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |_, headers, _|
      headers.delete "Strict-Transport-Security"
    end
  end
end
