class Monster
  attr_reader :name, :attack_point
  
  def initialize(name, hitpoint, attack_point)
    @name = name
    @hitpoint = hitpoint
    @attack_point = attack_point
  end

  def to_s
    if @hitpoint > 0
      "#{@name}[#{@hitpoint}]"
    else
      "#{@name}[X]"
    end
  end

  def attack(monster)
    monster.take_damage(@attack_point)
    take_damage(0.5 * monster.attack_point)

    puts "#{@name} attacks enemy's #{monster.name}, deals #{@attack_point.to_f} damage and takes #{0.5 * monster.attack_point} damage"
  end

  def take_damage(amount)
    @hitpoint -= amount
  end

  def take_effect(effect, save_damage)
    @debuff = effect
    if effect == "burnt"
      # That's because @counter is nil, you need to set it to 0 first. example below
      @counter ||= 0
      @counter += 3
      @save_damage = save_damage
    elsif effect == "frozen"
      @counter += 1
    end
  end

  def new_turn
    # That's because @counter is nil, you need to set it to 0 first. example below
    @counter ||= 0
    if @debuff != "" && @counter > 0
      @counter -= 1
      if @debuff == "burnt"
        @hitpoint -= @save_damage
      end
    elsif @counter == 0
      @debuff = ""
      @save_damage = 0
    end
  end
end