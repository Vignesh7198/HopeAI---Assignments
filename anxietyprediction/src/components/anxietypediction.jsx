import { useEffect, useState } from "react"
// import {fields,categories} from "./data.js"
import {useDispatch, useSelector} from "react-redux"
import "./style.css"
import { getData, sendData } from "../store/slice.js"


export default function AnxietyPrediction(){

    const [selectedOptions,setSelectedOptions]=useState([])

    const statevar = useSelector((state)=>state.user.data)
    const predictedValue = useSelector((state)=>state.user.predictedValue)

    const dispatch =  useDispatch()
    function submitPrediction(){  
        console.log(selectedOptions)
        dispatch(sendData(selectedOptions))
    }

    useEffect(()=>{
        dispatch(getData())
    },[dispatch])

    function handleChange(fieldname, value){

        const test = {
            ...selectedOptions,
            
            [fieldname]:value
        }

        setSelectedOptions(test)

    }
     
    const categories=statevar?.categories
    const fields=statevar?.fields


    return (
        <>
         {
            (statevar && statevar!="error" && statevar!="Loading") ? <div className="form-container w-sm pt-5 bg-violet-300">
            <div className="form">
                
                    {
                 fields.map((field,index)=>{
                   return <div className="flex flex-col justify-between" key={index}>
                    <label className="fieldname text-center text-xl">{field}</label>
                   
                   <select name={field} onChange={(e)=>handleChange(field,e.target.value)} className="options border border-black">
                    {
                        categories[fields[index]].map(item=>{
                           return <option value={item} className="text-l" key={item+index}>{item}</option>
                        })
                    }
                </select>
                </div>
                  
                 })
                    }
                    <div className="flex justify-center">
                    <button className="button p-2 mt-2 mb-2 border border-orange-200 bg-red-100 rounded-lg" onClick={submitPrediction}>Predict</button>
                    </div>
            </div>    

        </div>:<div className="flex justify-center"><h1 className="text-4xl mt-20 text-red-500">Loading..</h1></div>
         }
         {
            predictedValue!=null&&predictedValue!="Hey! Error Occured"?<h1 className="text-4xl text-center mt-10 text-green-800">🔮Prediction: {predictedValue.message==0?"Less Anxious":"More Anxious"}!!</h1>:""
         }
             
        </>
                
                   
                            
                     
    )
}