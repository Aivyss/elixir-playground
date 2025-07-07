defmodule PhxPlayground.Repo do
  use Ecto.Repo,
    otp_app: :phx_playground,
    adapter: Ecto.Adapters.Postgres
end

# ectoライブラリにより、RDSに接続・操作する。デフォルトプロジェクト設定時にはpostgresに指定される。
