class CreateStyles < ActiveRecord::Migration
  def change

    create_table :styles do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end

    Style.reset_column_information

    collect_styles = Beer.all.map{ |b| b.style}.uniq

    collect_styles.each do |style|
    	Style.new(name: style, description:"empty")
	end

	change_table :beers do |t|
		t.rename :style, :old_style
		t.integer :style_id
	end
  end
end