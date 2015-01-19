def user_response_uppercase
  gets.strip.upcase
end

def agrees?(input)
  input == 'Y'
end

def yes_instructions
  "(Y for yes)"
end