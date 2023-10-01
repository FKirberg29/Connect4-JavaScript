# Fabian Kirberg

require 'spec_helper'

describe 'C4 on Standard Board' do
    #P1 Horizontal Win
    it 'detects P1 winning horizontally in row 0 on standard board' do
        result = test_c4('aabbccd')
        expect(result).to declare_win_for 1
    end
    #P1 Vertical Win
    it 'detects P1 winning vertically in column 0 on standard board' do
        result = test_c4('abababa')
        expect(result).to declare_win_for 1
    end
    #P1 Up-Right Diagonal Win
    it 'detects P1 winning up right diagonally on standard board' do
        result = test_c4('abbccdcddgd')
        expect(result).to declare_win_for 1
    end
    #P1 Down-Right Diagonal Win
    it 'detects P1 winning down right diagonally on standard board' do
        result = test_c4('aaaaababbbbccccddfd')
        expect(result).to declare_win_for 1
    end
    #P2 Horizontal Win
    it 'detects P2 winning horizontally in row 0 on standard board' do
        result = test_c4('eaabbccd')
        expect(result).to declare_win_for 2
    end
    #P2 Vertical Win
    it 'detects P2 winning vertically in column 0 on standard board' do
        result = test_c4('eabababa')
        expect(result).to declare_win_for 2
    end
    #P2 Up-Right Diagonal Win
    it 'detects P2 winning up right diagonally on standard board' do
        result = test_c4('gabbccdcddgd')
        expect(result).to declare_win_for 2
    end
    #P2 Down-Right Diagonal Win
    it 'detects P2 winning down right diagonally on standard board' do
        result = test_c4('gaaaaababbbbccccddfd')
        expect(result).to declare_win_for 2
    end
#Edge Cases for Standard Board
    #Invalid column
    it 'ignores invalid input and asks for next input on standard board' do
        result = test_c4('abababka')
        expect(result).to declare_win_for 1
    end
    #Full column
    it 'ignores input and asks until input is in a non-full column on standard board' do
        result = test_c4('aaaaaaabcbcbcb')
        expect(result).to declare_win_for 1
    end
    #Quitting mid-game
    it 'quits before declaring a winner in column 0 on standard board' do
        result = test_c4('abababq')
        expect(result).to be_abandoned
    end
end

describe 'Connect 4 on Big Board: 9x9 
                           Win Length: 7'   do
    #P1 Horizontal Win
    it 'detects player 1 winning horizontally on a big board' do
        result = test_c4('aabbccddeeffg', 9, 9, 7)
        expect(result).to declare_win_for 1
    end
    #P1 Vertical Win
    it 'detects player 1 winning vertically on a big board' do
        result = test_c4('aiaiaiaiaiaia', 9, 9, 7)
        expect(result).to declare_win_for 1
    end
    #P1 Up-Right Diagonal Win
    it 'detects player 1 winning up right diagonal on a big board p1' do
        result = test_c4('abbccdcddideeeefeffffifggggggig', 9, 9, 7)
        expect(result).to declare_win_for 1
    end
    #P1 Down-Right Diagonal Win
    it 'detects player 1 winning down right diagonal on a big board' do
        result = test_c4('aaaaaaaaabbbbbbbbccccccicddddddieeeeeffffggigq', 9, 9, 7)
        expect(result).to declare_win_for 1
    end

    #P2 Horizontal Win
    it 'detects player 2 winning horizontally on a big board' do
        result = test_c4('iaabbccddeeffgq', 9, 9, 7)
        expect(result).to declare_win_for 2
    end
    #P2 Vertical Win
    it 'detects player 2 winning vertically on a big board' do
        result = test_c4('iaiaiaiaiaiabaq', 9, 9, 7)
        expect(result).to declare_win_for 2
    end
    #P2 Up-Right Diagonal Win
    it 'detects player 1 winning up right diagonal on a big board p2' do
        result = test_c4('iabbccdcddideeeefeffffifggggggig', 9, 9, 7)
        expect(result).to declare_win_for 2
    end
    #P2 Down-Right Diagonal Win
    it 'detects player 1 winning down right on a big board' do
        result = test_c4('iaaaaaaaaabbbbbbbbccccccicddddddieeeeeffffggigq', 9, 9, 7)
        expect(result).to declare_win_for 2
    end

#Edge Cases for Big Board
    #Invalid column
    it 'ignores invalid input and asks for next input on big board' do
        result = test_c4('abababambababa', 9, 9, 7)
        expect(result).to declare_win_for 1
    end
    #Full column
    it 'ignores input and asks until input is in a non-full column on big board' do
        result = test_c4('aaaaaaaaaabcbcbcbcbcbcb', 9, 9, 7)
        expect(result).to declare_win_for 2
    end
    #Quitting mid-game
    it 'quits before declaring a winner in column 0 on big board' do
        result = test_c4('abababqq', 9, 9, 7)
        expect(result).to be_abandoned
    end
end

describe 'Connect 4 Tall Skinny Board: 12x6
                           Win Length: 4'   do
    #P1 Horizontal Win
    it 'detects P1 winning horizontally in row 0 on tall skinny board' do
        result = test_c4('aabbccdq',12,6,4)
        expect(result).to declare_win_for 1
    end
    #P1 Vertical Win
    it 'detects P1 winning vertically in column 0 on tall skinny board' do
        result = test_c4('abababaq',12,6,4)
        expect(result).to declare_win_for 1
    end
    #P1 Up-Right Diagonal Win
    it 'detects P1 winning up right diagonally on tall skinny board' do
        result = test_c4('abbccdcddfd',12,6,4)
        expect(result).to declare_win_for 1
    end
    #P1 Down-Right Diagonal Win
    it 'detects P1 winning down right diagonally on tall skinny board' do
        result = test_c4('aaaaababbbbccccddadq',12,6,4)
        expect(result).to declare_win_for 1
    end

    #P2 Horizontal Win
    it 'detects P2 winning horizontally in row 0 on tall skinny board' do
        result = test_c4('aabbccadadq',12,6,4)
        expect(result).to declare_win_for 2
    end
    #P2 Vertical Win
    it 'detects P2 winning vertically in column 0 on tall skinny board' do
        result = test_c4('dabababaq',12,6,4)
        expect(result).to declare_win_for 2
    end
    #P2 Up-Right Diagonal Win
    it 'detects P2 winning up right diagonally on tall skinny board' do
        result = test_c4('fabbccdcddfd',12,6,4)
        expect(result).to declare_win_for 2
    end
    #P2 Down-Right Diagonal Win
    it 'detects P2 winning down right diagonally on tall skinny board' do
        result = test_c4('faaaaababbbbccccddfdq',12,6,4)
        expect(result).to declare_win_for 2
    end

#Edge Cases for Tall Skinny Board
    #Invalid column
    it 'ignores invalid input and asks for next input on tall skinny board' do
        result = test_c4('abababkaq',12,6,4)
        expect(result).to declare_win_for 1
    end
    #Full column
    it 'ignores input and asks until input is in a non-full column on tall skinny board' do
        result = test_c4('aaaaaaaaaaaaabcbcbcbq',12,6,4)
        expect(result).to declare_win_for 1
    end
    #Quitting mid-game
    it 'quits before declaring a winner in column 0 on tall skinny board' do
        result = test_c4('abababq',12,6,4)
        expect(result).to be_abandoned
    end
end