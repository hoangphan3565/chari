package com.macia.charitysystem.DTO;

import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChangePassDTO {
    private String username;
    private String cur_password;
    private String password1;
    private String password2;
    private String user_type;
}
