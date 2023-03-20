#foreach($b in $(cat $env:tmp\z -En by)){foreach($a in

#@x8O , 0x40, 0x20, 0x10, 0x08 , 0x04, 0x02 ,0x01){if( $b-band$a){$o+='%{NUMLOCK}' }elsef{$o
#+='%{CAPSLOCK}'}}}; $ot='%{SCROLLLOCK}!;echo $0 >$env:tmp\z




for b in $(cat -en thing.txt); do
    for a in 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01; do
        if [$b-band$a] 
        then 
            $o+='%{NUMLOCK}'
        else 
            $o+='%{CAPSLOCK}'
        fi;
    done
    $o+='%{SCROLLLOCK}';
done

echo $o > thing.txt
