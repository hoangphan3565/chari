import Api from "./Api"

const list = () => Api.get(Api.url.supportedpeoples);

const get = id => Api.get(`${Api.url.supportedpeoples}/${id}`);
const add = data => Api.post(Api.url.supportedpeoples,data);
const update = (id,data) => Api.put(`${Api.url.supportedpeoples}/${id}`,data);
const remove = id => Api.delete(`${Api.url.supportedpeoples}/${id}`)


export default {
    list: list,
    get: get,
    add:add,
    update:update,
    delete:remove
};