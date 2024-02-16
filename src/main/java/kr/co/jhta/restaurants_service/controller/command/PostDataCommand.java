package kr.co.jhta.restaurants_service.controller.command;

import lombok.Getter;
import lombok.ToString;

import org.springframework.web.multipart.MultipartFile;

@Getter
@ToString
public class PostDataCommand {

    MultipartFile chooseFile;
    int storeId;
    String content;
    int dataId;
    String uuidPrefixedFileName;

    public PostDataCommand(MultipartFile chooseFile, int storeId, String content, int dataId) {
        this.chooseFile = chooseFile;
        this.storeId = storeId;
        this.content = content;
        this.dataId = dataId;
    }

    public PostDataCommand(MultipartFile chooseFile, int storeId, String content, int dataId, String uuidPrefixedFileName) {
        this.chooseFile = chooseFile;
        this.storeId = storeId;
        this.content = content;
        this.dataId = dataId;
        this.uuidPrefixedFileName = uuidPrefixedFileName;
    }
}
