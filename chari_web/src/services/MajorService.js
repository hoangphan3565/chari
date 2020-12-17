import Api from "./Api"

const list = () => Api.get(Api.url.majors);

const get = id => Api.get(`${Api.url.majors}/${id}`);
const add = data => Api.post(Api.url.majors,data);
const update = (id,data) => Api.put(`${Api.url.majors}/${id}`,data);
const remove = id => Api.delete(`${Api.url.majors}/${id}`)


export default {
    list: list,
    get: get,
    add:add,
    update:update,
    delete:remove
};