import Api from "./Api"

const login = (username,password) => {
    const data = {username,password};
    return Api.post(Api.url.login,data);
}

export default {
    login: login,
};