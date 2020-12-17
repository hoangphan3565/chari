import Api from "./Api"

const list = () => Api.get(Api.url.instructors);

const get = id => Api.get(`${Api.url.instructors}/${id}`);
const add = data => Api.post(Api.url.instructors,data);
const update = (id,data) => Api.put(`${Api.url.instructors}/${id}`,data);
const remove = id => Api.delete(`${Api.url.instructors}/${id}`)


export default {
    list: list,
    get: get,
    add:add,
    update:update,
    delete:remove
};