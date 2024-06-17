import React from "react";
import { Squircle } from "@squircle-js/react"
import { SquircleNoScript } from "@squircle-js/react"
import { IoIosCalendar } from "react-icons/io";
import { PiBankFill } from "react-icons/pi";
import { BiDollar } from "react-icons/bi";
import { MdWork } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { FaLock } from "react-icons/fa";
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { MulticharProps } from "../../typings/multichar";

const Multichar: React.FC = () => {
    const [activeUserIndex, setActiveUserIndex] = React.useState<number | null>(0);
    const [data, setData] = React.useState<MulticharProps>({
       users: [
        {
            nome: 'samu',
            cognome: 'Tatical',
            bday: '17 Agosto, 2000',
            thumbnail: 'https://media.discordapp.net/attachments/1063113222531596398/1250960895194955886/samu.gif?ex=667174df&is=6670235f&hm=ab7c55407827e0888deec30ebcc9bf6965924d68aae71d939af0a2c3f6277bb0&=',
            lavoro: 'Disoccupato',
            bank_account: 0,
            wallet: 0
        },
       ]
    });
    const [visible, setVisible] = React.useState(false);

    useNuiEvent<MulticharProps>('Multichar', (data) => {
        setData(data);
        setVisible(true);
    });

    useNuiEvent('MulticharHide', () => setVisible(false));

    return (
        <>
            <SquircleNoScript />
            <div className={`w-full h-screen overflow-hidden m-0 select-none bg-center bg-cover ${visible ? 'opacity-[1] relative' : 'opacity-[0] absolute'} bg-gradient-to-t from-black/80 to-*`}>
                <div className="w-full h-screen flex flex-wrap items-center justify-between p-10">
                    <span className="w-1/2 h-full flex items-center justify-center pr-32">
                        <Squircle className="bg-zinc-900/70 p-8 scale-125" asChild cornerRadius={25} cornerSmoothing={0.6}>
                            {activeUserIndex !== null && (
                                <span className="flex flex-col w-fit h-fit items-center justify-center gap-y-6">
                                    <div className="flex flex-col gap-y-2 items-center justify-center text-center">
                                        <img alt="" width={120} height={120} className="rounded-full" src={data.users[activeUserIndex].thumbnail} />
                                        <span className="flex flex-col text-center items-center justify-center">
                                            <h1 className="text-xl text-white">{data.users[activeUserIndex].nome}</h1>
                                            <h2 className="text-md text-zinc-300">{data.users[activeUserIndex].cognome}</h2>
                                        </span>
                                    </div>
                                    <div className='w-fit h-fit flex flex-col gap-y-2'>
                                    <Squircle className='w-72 h-fit bg-zinc-700/80 p-2' asChild cornerRadius={15} cornerSmoothing={0.6}>
                                        <span className='flex flex-col w-full h-fit'>
                                            <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                                <span className='flex flex-wrap h-fit gap-x-2'>
                                                    <Squircle className='bg-red-500/20 p-2 text-lg flex items-center justify-center text-center' cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                        <span className='text-lg text-red-500'><IoIosCalendar /></span>
                                                    </Squircle>
                                                    <span className='flex flex-col h-full justify-between text-left'>
                                                        <h1 className='text-sm text-white font-semibold'>Data di nascita</h1>
                                                        <p className="text-zinc-400 text-xs">{data.users[activeUserIndex].bday}</p>
                                                    </span>
                                                </span>
                                            </div>
                                        </span>
                                    </Squircle>
                                    <Squircle className='w-72 h-fit bg-zinc-700/80 p-2' asChild cornerRadius={15} cornerSmoothing={0.6}>
                                        <span className='flex flex-col w-full h-fit'>
                                            <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                                <span className='flex flex-wrap h-fit gap-x-2'>
                                                    <Squircle className='bg-orange-500/20 p-2 text-lg flex items-center justify-center text-center' cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                        <span className='text-lg text-orange-500'><MdWork /></span>
                                                    </Squircle>
                                                    <span className='flex flex-col h-full justify-between text-left'>
                                                        <h1 className='text-sm text-white font-semibold'>Lavoro</h1>
                                                        <p className="text-zinc-400 text-xs">{data.users[activeUserIndex].lavoro}</p>
                                                    </span>
                                                </span>
                                            </div>
                                        </span>
                                    </Squircle>
                                    <Squircle className='w-72 h-fit bg-zinc-700/80 p-2' asChild cornerRadius={15} cornerSmoothing={0.6}>
                                        <span className='flex flex-col w-full h-fit gap-y-2'>
                                            <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                                <span className='flex flex-wrap h-fit gap-x-2'>
                                                    <Squircle className='bg-yellow-500/20 p-2 text-lg flex items-center justify-center text-center' cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                        <span className='text-lg text-yellow-500'><PiBankFill /></span>
                                                    </Squircle>
                                                    <span className='flex flex-col h-full justify-between text-left'>
                                                        <h1 className='text-sm text-white font-semibold'>Bank account</h1>
                                                        <p className="text-zinc-400 text-xs">{data.users[activeUserIndex].bank_account} USD</p>
                                                    </span>
                                                </span>
                                            </div>
                                            <hr className="opacity-20"/>
                                            <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                                <span className='flex flex-wrap h-fit gap-x-2'>
                                                    <Squircle className='bg-teal-500/20 p-2 text-lg flex items-center justify-center text-center' cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                        <span className='text-lg text-teal-500'><BiDollar /></span>
                                                    </Squircle>
                                                    <span className='flex flex-col h-full justify-between text-left'>
                                                        <h1 className='text-sm text-white font-semibold'>Wallet</h1>
                                                        <p className="text-zinc-400 text-xs">{data.users[activeUserIndex].wallet} USD</p>
                                                    </span>
                                                </span>
                                            </div>
                                        </span>                           
                                    </Squircle>
                                    </div>
                                </span>
                            )}
                        </Squircle>
                    </span>
                    <span className="w-1/2 h-full flex flex-col pl-32 items-center justify-center">
                        <div className="absolute flex flex-col gap-y-4 scale-125">
                            <h1 className="text-2xl text-white font-semibold flex flex-wrap items-center gap-x-2"><FaUsers /> Personaggi:</h1>
                            <div className="flex gap-x-4 w-fit h-fit">
                                {data.users.map((user, index) => (
                                    <Squircle
                                        key={index}
                                        className={`max-w-32 bg-gradient-to-t from-red-900/90 to-* py-4 px-6 cursor-pointer hover:opacity-80 transition-all duration-200 ease-linear ${activeUserIndex === index ? 'opacity-80' : ''}`}
                                        asChild
                                        cornerRadius={25}
                                        cornerSmoothing={0.6}
                                        onClick={() => setActiveUserIndex(index)}
                                    >
                                        <span className="w-32 flex flex-col gap-y-4">
                                            <div className="h-full w-full flex items-center justify-center">
                                                <img alt="" width={80} height={80} className="rounded-full" src={user.thumbnail} />
                                            </div>
                                            <div className="h-fit flex flex-col text-center justify-center">
                                                <h1 className="text-sm text-white font-semibold text-ellipsis whitespace-nowrap break-words w-full overflow-hidden">{user.nome}</h1>
                                                <h2 className="text-sm text-zinc-300 text-ellipsis whitespace-nowrap break-words w-full overflow-hidden">{user.cognome}</h2>
                                            </div>
                                        </span>
                                    </Squircle>
                                ))}

                            <Squircle className="max-w-32 bg-gradient-to-t from-zinc-900/90 to-* py-4 px-6 cursor-pointer hover:opacity-80 transition-all duration-200 ease-linear" asChild cornerRadius={25} cornerSmoothing={0.6}>
                                <span className="w-32 flex flex-col gap-y-4">
                                    <div className="h-full w-full flex items-center justify-center">
                                        <span className="text-4xl p-4 bg-zinc-500/20 text-zinc-500 rounded-full"><FaLock /></span>
                                    </div>
                                    <div className="h-fit flex flex-col text-center justify-center">
                                        <h1 className="text-sm text-white font-semibold text-ellipsis whitespace-nowrap break-words w-full overflow-hidden">Slot #2</h1>
                                        <h2 className="text-sm text-zinc-300 text-ellipsis whitespace-nowrap break-words  w-full overflow-hidden">Acquistabile</h2>
                                    </div>
                                </span>
                            </Squircle>
                            </div>
                        </div>
                    </span>
                </div>
            </div>
        </>
    );
    
}

export default Multichar;