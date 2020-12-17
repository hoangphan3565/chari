import Api from "./Api"

const list = () => Api.get(Api.url.students);

const get = id => Api.get(`${Api.url.students}/${id}`);
const add = data => Api.post(Api.url.students,data);
const update = (id,data) => Api.put(`${Api.url.students}/${id}`,data);
const remove = id => Api.delete(`${Api.url.students}/${id}`)


export default {
    list: list,
    get: get,
    add:add,
    update:update,
    delete:remove
};