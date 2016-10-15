class Phase1 < ActiveRecord::Base
    require "simple-spreadsheet"
    
    def self.import(file)
        spreadsheet = Roo::Spreadsheet.open(file.path)
        school = spreadsheet.cell(4,3)
        staff = spreadsheet.cell(5,3)
        mobile_number = spreadsheet.cell(6,3)
        email = spreadsheet.cell(7,3)
        workshop = []
        (7..spreadsheet.last_column).each do |i|
            workshop.push(spreadsheet.cell(11,i))
        end

        (12..spreadsheet.last_row).each do |i|
            name = spreadsheet.cell(i,2)
            nric = spreadsheet.cell(i,3)
            class_name = spreadsheet.cell(i,4)
            email = spreadsheet.cell(i,5)
            phone = spreadsheet.cell(i,6)
            if name == nil
                break
            end
            choices = []
            (7..spreadsheet.last_column).each do |j|
                choices.push(spreadsheet.cell(i,j))
            end
            chosen = []
            (0..(choices.length - 1)).each do |choice|
                if choices[choice] != nil && choices[choice].length > 0
                    chosen.push(workshop[choice])
                end
            end

            Phase1.create(:name=>name, :nric=>nric, :school=>school, :class_name=>class_name, :email=>email, :phone=>phone, :choice_1=>chosen[0], :choice_2=>chosen[1], :choice_3=>chosen[2], :choice_4=>chosen[3], :choice_5=>chosen[4])

        end
    end
end