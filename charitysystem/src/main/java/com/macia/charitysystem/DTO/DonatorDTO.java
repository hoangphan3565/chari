package com.macia.charitysystem.DTO;
import lombok.*;
import java.util.List;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DonatorDTO {
    private Integer DNT_ID;
    private String fullName;
    private String address;
    private String phoneNumber;
    private String sumDonate;
}
