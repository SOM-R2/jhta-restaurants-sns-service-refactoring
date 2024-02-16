package kr.co.jhta.restaurants_service.controller.command;

import kr.co.jhta.restaurants_service.vo.store.Food;
import lombok.Getter;

@Getter
public class FoodCommand {

    private String foodName;
    private String foodPrice;
    public static Food toFood(FoodCommand foodCommand) {
        return new Food(foodCommand.getFoodName(), Integer.parseInt(foodCommand.getFoodPrice()));
    }
}
