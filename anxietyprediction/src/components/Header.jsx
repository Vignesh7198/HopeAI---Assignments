import { useSelector } from "react-redux"

// import { title } from "./data"
export default function Header(){
    const statevar = useSelector((state)=>state.user.data)

    return(
        <div>
           <h1 className="title p-3 font-bold text-center text-2xl bg-orange-400">{statevar!=null?statevar.title:""}</h1>
        </div>
    )
}