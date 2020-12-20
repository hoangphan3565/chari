import Api from "./Api"

const list = () => Api.get(Api.url.projectTypes);

const get = id => Api.get(`${Api.url.projectTypes}/${id}`);
const add = data => Api.post(Api.url.projectTypes,data);
const update = (id,data) => Api.put(`${Api.url.projectTypes}/${id}`,data);
const remove = id => Api.delete(`${Api.url.projectTypes}/${id}`)


export default {
    list: list,
    get: get,
    add: add,
    update: update,
    delete: remove
};