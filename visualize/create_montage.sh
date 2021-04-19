function create_montage {

    plate=$1
    well=$2

    basedir=$3
    cachedir=$4
    montagedir=$5

    channel_map=( ["1"]="Mito" ["2"]="AGP" ["3"]="RNA" ["4"]="ER" ["5"]="DNA")
    
    outputdir=${basedir}/${montagedir}/${plate}
    
    output=${outputdir}/${well}_montage.jpg
    
    thumbnail_outputdir=${basedir}/${montagedir}/${plate}
    
    thumbnail_output=${thumbnail_outputdir}/${well}_montage_thumbnail.jpg
    
    options="-contrast-stretch 4%x2% -strip -interlace Plane -gaussian-blur 0.05 -quality 85%"

    # Don't create directories here
    # mkdir -p $outputdir

    for channel in $(seq 1 5); do
      convert \
        ${basedir}/${cachedir}/${plate}/${well}"f01p01-ch"${channel}"sk1fk1fl1.tiff" \
        ${options} -set label  ${channel_map[$channel]} miff:-  2>/dev/null
    done | montage miff: -tile x2 -geometry +1+1 -pointsize 60  $output

}
