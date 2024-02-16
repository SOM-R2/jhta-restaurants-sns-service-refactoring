package kr.co.jhta.restaurants_service.controller.command;

import kr.co.jhta.restaurants_service.vo.store.StoreOpenTime;
import lombok.Getter;

@Getter
public class StoreOpenTimeCommand {

    private String day;
    private String openingTime;
    private String closingTime;

    public StoreOpenTimeCommand(String day, String openingTime, String closingTime) {
        this.day = day;
        this.openingTime = openingTime;
        this.closingTime = closingTime;
    }

    public static StoreOpenTime toStoreOpenTime(StoreOpenTimeCommand storeOpenTimeCommand) {
        return new StoreOpenTime(
                storeOpenTimeCommand.getDay(),
                storeOpenTimeCommand.getOpeningTime(),
                storeOpenTimeCommand.getClosingTime()
        );
    }
}
