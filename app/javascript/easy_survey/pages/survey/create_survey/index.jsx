import Button from 'react-bootstrap/Button';
import React from 'react'
import Form from 'react-bootstrap/Form';
import { useForm } from "react-hook-form";
import useCreateSurvey from './hooks/useCreateSurvey';

function CreateSurvey() {

  const { register, handleSubmit, watch, formState: { errors } } = useForm();
  const [onSubmit] = useCreateSurvey();

  return (
    <Form onSubmit={handleSubmit(onSubmit)} className='container mt-4'>
      <Form.Group className="mb-3" controlId="name.group">
        <Form.Label>Name</Form.Label>
        <Form.Control type="text" {...register("name", {required: true})} />
        {errors.name?.type === 'required' && <p className='text-danger'>Name is required</p>}
      </Form.Group>
      <Form.Group className="mb-3" controlId="description.group">
        <Form.Label>Description</Form.Label>
        <Form.Control as="textarea" rows={3}  {...register("description")}/>
      </Form.Group>
      <Button variant="primary" type="submit">Create</Button>
    </Form>
  )
}

export default CreateSurvey;