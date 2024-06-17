export interface MulticharProps {
    users: {
        nome: string;
        cognome: string;
        bday: string;
        thumbnail?: string;
        lavoro?: string | 'disoccupato'; 
        bank_account: number;
        wallet: number;
    }[]
}