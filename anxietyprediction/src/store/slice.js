import {createSlice} from '@reduxjs/toolkit';
import { createAsyncThunk } from '@reduxjs/toolkit';
import axios from "axios";

const initialState = {
   data:null,
   predictedValue:null
}

export const sendData = createAsyncThunk('ml/sendData',async(data)=>{
   try{

      console.log(data)
   const result = await axios.post("http://127.0.0.1:8000/postdata",JSON.stringify(data))
   console.log(result.data)

   return result.data
   }
   catch(e){
   return e.message
   }
  
})

export const getData = createAsyncThunk('ml/getData',async()=>{
   try{
   const result = await axios.get("http://localhost:8000/")

   return result.data
   }
   catch(error){
   return "Hey! Error Occured"
   }
})



const counterSlice = createSlice({
   name:'counter',
   initialState,
   reducers:{

   },
   extraReducers:(builder)=>{
     builder
     .addCase(getData.pending,(state)=>{
      state.data="Loading"
     
     })
     .addCase(getData.fulfilled,(state,action)=>{
      state.data=action.payload
     })
     .addCase(getData.rejected,(state,action)=>{
      state.data="error"
     })
     .addCase(sendData.pending, (state) => {
      state.predictedValue ='Posting data...';
      console.log("Inside Pending")
   })
   .addCase(sendData.fulfilled, (state, action) => {
     state.predictedValue = action.payload;
     console.log("Inside Fullfiled")

   })
   .addCase(sendData.rejected, (state, action) => {
      state.predictedValue = action.payload
   })
   }
})

export default counterSlice.reducer