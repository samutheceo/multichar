import React, { useState } from 'react';
import { Squircle } from '@squircle-js/react';
import { IoIosCalendar } from "react-icons/io";
import { FaMale, FaFemale } from "react-icons/fa";
import { IoIosArrowDown, IoIosArrowUp } from "react-icons/io";
import { RxHeight } from "react-icons/rx";
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { IdentityProps } from '../../typings/identity';
import { SquircleNoScript } from "@squircle-js/react";
import { fetchNui } from '../../utils/fetchNui';

const Identity: React.FC = () => {
    const [gender, setGender] = useState('Maschio');
    const [dropdownOpen, setDropdownOpen] = useState(true);
    const [PopupPfp, setPopupPfp] = useState(false);
    const [currentPfp, setCurrentPfp] = useState('https://media.discordapp.net/attachments/1063113222531596398/1250960895194955886/samu.gif?ex=667174df&is=6670235f&hm=ab7c55407827e0888deec30ebcc9bf6965924d68aae71d939af0a2c3f6277bb0&=');
    const [newPfpUrl, setNewPfpUrl] = useState('');

    const [nome, setNome] = useState('');
    const [cognome, setCognome] = useState('');
    const [dataDiNascita, setDataDiNascita] = useState('');
    const [height, setHeight] = useState('170');

    const [data, setData] = React.useState<IdentityProps>({
        button_text: 'Crea Personaggio',
    });
    const [visible, setVisible] = React.useState(false);

    useNuiEvent<IdentityProps>('Identity', (data) => {
        if (!data.button_text) data.button_text = 'Crea Personaggio';
        setData(data);
        setVisible(true);
    });

    useNuiEvent('IdentityHide', () => setVisible(false));

    const handleGenderChange = (newGender: string) => {
        setGender(newGender);
        setDropdownOpen(false);
    };

    const toggleDropdown = () => {
        setDropdownOpen(!dropdownOpen);
    };

    const incrementHeight = () => {
        const currentHeight = parseInt(height) || 140;
        if (currentHeight < 200) {
            setHeight((currentHeight + 1).toString());
        }
    };

    const decrementHeight = () => {
        const currentHeight = parseInt(height) || 140;
        if (currentHeight > 140) {
            setHeight((currentHeight - 1).toString());
        }
    };

    const confirmNewPfp = () => {
        setCurrentPfp(newPfpUrl);
        setPopupPfp(false);
    };

    const editPfp = () => {
        setPopupPfp(true);
    };

    const createPersonaggio = () => {
        fetchNui('creaPersonaggio', {
            nome,
            cognome,
            dataDiNascita,
            gender,
            height,
            currentPfp,
        }).catch();
    };

    return (
    <>
        <SquircleNoScript />
        <div className={`w-full h-screen select-none overflow-hidden m-0 ${visible ? 'opacity-[1] relative' : 'opacity-[0] absolute'}`}>
            <div className="w-full h-screen bg-gradient-to-t from-black/90 to-* z-20 flex items-center justify-center">
                <Squircle className="bg-zinc-900/70 p-8 scale-125" cornerRadius={25} cornerSmoothing={0.6} asChild>
                    <span className="w-fit h-fit flex flex-col gap-y-8 items-center justify-center">
                        <div className='flex flex-col items-center justify-center gap-y-6'>
                            <span className='flex flex-col items-center justify-center'>
                                <div className="w-[120px] h-[120px] overflow-hidden rounded-full relative group mb-3">
                                    <img
                                        alt=""
                                        width={120}
                                        height={120}
                                        className="rounded-full object-cover cursor-pointer hover:opacity-80 transition-all duration-200 ease-linear"
                                        src={currentPfp}
                                        onClick={editPfp}
                                    />
                                </div>
                                <input
                                    type="text"
                                    className="bg-transparent px-2 outline-none caret-rose-400/80 text-white placeholder:text-zinc-50 text-lg flex items-center justify-center text-center"
                                    placeholder="Nome"
                                    value={nome}
                                    onChange={(e) => setNome(e.target.value)}
                                />
                                <input
                                    type="text"
                                    className="bg-transparent px-2 outline-none caret-rose-400/80 text-zinc-200 placeholder:text-zinc-200/90 text-md flex items-center justify-center text-center"
                                    placeholder="Cognome"
                                    value={cognome}
                                    onChange={(e) => setCognome(e.target.value)}
                                />
                            </span>
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
                                                    <input
                                                        type='text'
                                                        className='text-zinc-400 text-xs bg-transparent w-56 outline-none caret-red-400'
                                                        placeholder='17 Agosto, 2000'
                                                        value={dataDiNascita}
                                                        onChange={(e) => setDataDiNascita(e.target.value)}
                                                    />
                                                </span>
                                            </span>
                                        </div>
                                    </span>
                                </Squircle>
                                <Squircle className={`w-72 bg-zinc-700/80 p-2`} asChild cornerRadius={15} cornerSmoothing={0.6}>
                                    <span className='flex flex-col w-full h-fit gap-y-1'>
                                        <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                            <span className='flex flex-wrap h-fit gap-x-2'>
                                                <Squircle className={`${ gender === 'Maschio' ? 'bg-blue-500/20' : 'bg-pink-500/20'} p-2 text-lg flex items-center justify-center text-center`} cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                    <span className={`text-lg ${ gender === 'Maschio' ? 'text-blue-500' : 'text-pink-500'}`}>
                                                        {gender === 'Maschio' ? <FaMale /> : <FaFemale />}
                                                    </span>
                                                </Squircle>
                                                <span className='flex flex-col h-full justify-between text-left'>
                                                    <h1 className='text-sm text-white font-semibold'>Sesso</h1>
                                                    <p className='text-zinc-400 text-xs bg-transparent'>{gender}</p>
                                                </span>
                                            </span>
                                            <span onClick={toggleDropdown} className={`flex items-center justify-center h-full w-fit text-xl text-zinc-500 cursor-pointer transition-all transform ${dropdownOpen ? 'rotate-180' : 'rotate-0'}`}>
                                                <IoIosArrowDown />
                                            </span>
                                        </div>
                                        <Squircle className={`w-full h-fit p-1 bg-zinc-800/90 ${ dropdownOpen === true ? 'flex' : 'hidden' } transition-all duration-200 ease-linear`} asChild cornerSmoothing={0.6} cornerRadius={15}>
                                                <span className='flex flex-col gap-y-1'>
                                                    <Squircle cornerSmoothing={0.6} cornerRadius={12} asChild className={`text-white text-sm w-full h-fit p-2 flex items-center text-left bg-${gender === 'Maschio' ? 'zinc-100/20' : 'transparent'} hover:bg-zinc-100/20 hover:text-white cursor-pointer transition-all duration-200 ease-linear`} onClick={() => handleGenderChange('Maschio')}>
                                                        <span className={`text-${gender === 'Maschio' ? 'zinc-50' : 'zinc-500'}`}>Maschio</span>
                                                    </Squircle>
                                                    <Squircle cornerSmoothing={0.6} cornerRadius={12} asChild className={`text-white text-sm w-full h-fit p-2 flex items-center text-left bg-${gender === 'Femmina' ? 'zinc-100/20' : 'transparent'} hover:bg-zinc-100/20 hover:text-white cursor-pointer transition-all duration-200 ease-linear`} onClick={() => handleGenderChange('Femmina')}>
                                                        <span className={`text-${gender === 'Femmina' ? 'zinc-50' : 'zinc-500'}`}>Femmina</span>
                                                    </Squircle>
                                                </span>
                                        </Squircle>
                                    </span>
                                </Squircle>
                                <Squircle className='w-72 h-fit bg-zinc-700/80 p-2' asChild cornerRadius={15} cornerSmoothing={0.6}>
                                    <span className='flex flex-col w-full h-fit'>
                                        <div className='w-full h-fit flex flex-wrap justify-between items-center'>
                                            <span className='flex flex-wrap h-fit gap-x-2'>
                                                <Squircle className='bg-yellow-500/20 p-2 text-lg flex items-center justify-center text-center' cornerRadius={10} cornerSmoothing={0.6} asChild>
                                                    <span className='text-lg text-yellow-500'><RxHeight /></span>
                                                </Squircle>
                                                <span className='flex flex-col h-full justify-between text-left'>
                                                    <h1 className='text-sm text-white font-semibold'>Altezza</h1>
                                                    <input
                                                        type='text'
                                                        className='text-zinc-400 text-xs bg-transparent w-40 outline-none caret-red-400'
                                                        placeholder='120-200'
                                                        value={height + ' cm'}
                                                        onChange={(e) => setHeight(e.target.value)}
                                                        readOnly
                                                    />
                                                </span>
                                            </span>
                                            <span className='h-full w-fit flex items-center justify-center'>
                                                <Squircle className='bg-zinc-50/40 h-full px-2 py-1' asChild cornerRadius={10} cornerSmoothing={0.9}>
                                                    <span className='flex flex-col items-center justfiy-between text-sm text-white gap-y-1'>
                                                        <span className="cursor-pointer" onClick={incrementHeight}><IoIosArrowUp /></span>
                                                        <span className='w-full h-[0.5px] bg-zinc-500/50'></span>
                                                        <span className="cursor-pointer" onClick={decrementHeight}><IoIosArrowDown /></span>
                                                    </span>
                                                </Squircle>
                                            </span>
                                        </div>
                                    </span>
                                </Squircle>
                            </div>
                        </div>
                        <div className='w-full h-fit flex items-center justfiy-center'>
                            <Squircle onClick={() => createPersonaggio()}  asChild className='w-full h-fit p-2 flex items-center justify-center text-rose-500 bg-rose-500/20 hover:opacity-80 transition-all duration-200 ease-linear cursor-pointer' cornerRadius={15} cornerSmoothing={0.6}>
                                { data.button_text &&
                                    <span>{data.button_text}</span>
                                }
                            </Squircle>
                        </div>
                    </span>
                </Squircle>
                <div className={`absolute w-screen h-screen bg-black/50 flex items-center justify-center text-center transition-all duration-200 ease-linear ${ PopupPfp === true ? 'opacity-[1] z-50' : 'opacity-[0] -z-10'}`}>
                    <Squircle className={`absolute bg-black/80 p-4 transition-all duration-200 ease-linear`} cornerRadius={25} cornerSmoothing={0.6} asChild>
                        <span className='flex flex-col gap-y-4'>
                            <header className='text-xl text-white text-center gap-y-2 flex flex-col items-center justify-center'>
                                <img alt="" src={currentPfp} className='rounded-full' width={120} height={120} />
                                Foto Profilo
                            </header>
                            <input
                                placeholder='URL Foto profilo'
                                className='bg-transparent outline-none p-2 w-72 text-white placeholder:text-zinc-400 caret-rose-400/80 font-mono ring-1 ring-rose-400 rounded-md text-xs placeholder:text-xs flex text-center transition-all duration-200 ease-linear cursor-pointer'
                                type="text"
                                value={newPfpUrl}
                                onChange={(e) => setNewPfpUrl(e.target.value)}
                            />
                            <Squircle cornerRadius={15} cornerSmoothing={0.6} asChild className='bg-rose-500/20 text-rose-500 p-2 flex items-center justify-center text-center cursor-pointer transition-all duration-200 ease-linear hover:opacity-90' onClick={confirmNewPfp}>
                                <span className='text-rose-500 text-md'>
                                    Conferma
                                </span>
                            </Squircle>
                        </span>
                    </Squircle>                  
                </div>
            </div>
        </div>
    </>
    );
}

export default Identity;
