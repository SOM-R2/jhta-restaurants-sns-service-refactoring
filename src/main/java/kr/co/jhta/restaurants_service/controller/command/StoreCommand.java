package kr.co.jhta.restaurants_service.controller.command;

import kr.co.jhta.restaurants_service.vo.store.Store;
import lombok.Getter;

@Getter
public class StoreCommand {

    private String name;
    private String phone;
    private String businessLicense;
    private String description;
    private String category;
    private String address;
    private String zipCode;
    private String addressDetail;
    private Double longitude;
    private Double latitude;

    public static Store toStore(StoreCommand storeCommand) {
        return new Store(
                storeCommand.getName(),
                storeCommand.getPhone(),
                storeCommand.getBusinessLicense(),
                storeCommand.getDescription(),
                storeCommand.getCategory(),
                storeCommand.getAddress(),
                storeCommand.getZipCode(),
                storeCommand.getAddressDetail(),
                storeCommand.getLatitude(),
                storeCommand.getLongitude()
        );
    }
}
