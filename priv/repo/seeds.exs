alias LiveBetting.Schema.{UserType, EventStatus, BetType, BetState}
alias LiveBetting.Repo

#seed user types

Repo.insert!(%UserType{
  type_name: "admin"
})

Repo.insert!(%UserType{
  type_name: "user"
})

# seed event statuses

Repo.insert!(%EventStatus{
  name: "upcoming"
})

Repo.insert!(%EventStatus{
  name: "live"
})


Repo.insert!(%EventStatus{
  name: "completed"
})


# seed bet types

Repo.insert!(%BetType{
  type: "win"
})


Repo.insert!(%BetType{
  type: "lose"
})


Repo.insert!(%BetType{
  type: "draw"
})

# seed bet states

Repo.insert!(%BetState{
  state: "pending"
})

Repo.insert!(%BetState{
  state: "won"
})

Repo.insert!(%BetState{
  state: "lost"
})
