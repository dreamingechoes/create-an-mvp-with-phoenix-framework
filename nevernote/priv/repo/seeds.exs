alias Nevernote.Accounts
alias Nevernote.Content

# Create an example user
{:ok, user} =
  Accounts.create_user(%{
    email: "example@nevernote.com",
    username: "Example",
    password: "123456"
  })

# Create a blocknote
{:ok, blocknote} =
  Content.create_blocknote(%{title: "Example Blocknote", user_id: user.id})

# Create some notes
Enum.each([1, 2, 3], fn index ->
  Content.create_note(%{
    title: "Note Number #{index}",
    description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque maximus sodales pharetra. Maecenas nibh tellus, tincidunt nec blandit a, tincidunt vitae tortor.",
    blocknote_id: blocknote.id
  })
end)
