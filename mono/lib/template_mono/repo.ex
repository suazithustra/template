defmodule Template.Mono.Repo do
  use Ecto.Repo,
    otp_app: :template_mono,
    adapter: Ecto.Adapters.Postgres
end
