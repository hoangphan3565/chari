package com.macia.charitysystem.DTO;

import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AppUserDTO {
    private String username;
    private String password1;
    private String password2;
    private String usertype;
}
