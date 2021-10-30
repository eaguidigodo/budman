FactoryBot.define do

  factory :budget do
    start_date { '2022-10-01' }
    end_date { '2022-11-01' }
    amount {'150000'}
  end

  factory :budget2, class: Budget do
    start_date { '2023-10-01' }
    end_date { '2023-11-01' }
    amount {'5327889'}
  end

  factory :need do
      name { 'food' }
      amount {'35000'}
      priority {'Very important'}
    end

  factory :need_2, class: Need do
      name { 'fluel' }
      amount {'55000'}
      priority {'Very important'}
  end

  factory :expense do
      day {'Wednesday'}
      need { 'fluel' }
      amount {'5000'}
      date { '2022-10-02' }
      description {'I just buy pizza'}
  end

end