FactoryBot.define do

    factory :budget do
      start_date { '2021-10-01' }
      end_date { '2021-11-01' }
      amount {'150000'}
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
        need { 'food' }
        amount {'5000'}
        date { '2021-11-01' }
        description {'I just buy pizza'}
    end
  
  end