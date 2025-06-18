import axios from 'axios';

export const getImagesByProduct = (productId) =>
    axios.get(`/api/products/${productId}/images`);

export const addImage = (image) =>
    axios.post(`/api/products/${image.productId}/images`, image);

export const updateImage = (id, image) =>
    axios.put(`/api/images/${id}`, image);

export const deleteImage = (id) =>
    axios.delete(`/api/images/${id}`);
