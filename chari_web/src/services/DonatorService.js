import Api from "./Api"

const list = () => Api.get(Api.url.donators);

const get = id => Api.get(`${Api.url.donators}/${id}`);
const add = data => Api.post(Api.url.donators,data);
const update = (id,data) => Api.put(`${Api.url.donators}/${id}`,data);
const remove = id => Api.delete(`${Api.url.donators}/${id}`)


export default {
    list: list,
    get: get,
    add:add,
    update:update,
    delete:remove
};