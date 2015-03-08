<?php

function _new_size($max_width, $max_height, $picture)
{

    $ratio = $picture['ratio'];


    $new_width = $max_width;
    $new_height = round($new_width * $ratio);

    if ($new_height > $max_height) {
        $new_height = $max_height;
        $new_width = round($new_height / $ratio);
    }

    if ($new_width > $max_width) {

        $new_width = $max_width;
        $new_height = round($new_width * $ratio);
    }


    $sizes['width'] = $new_width;
    $sizes['height'] = $new_height;
    $sizes['ratio'] = $new_width . 'x' . $new_height;


    return $sizes;
}

function smarty_function_slir($param)
{


    extract($param);

    $picture = (!empty($offer['thumbs'][$t])) ? $offer['thumbs'][$t] : $offer['picture'];


    if ($picture) {

        $path = $picture['src'];

        $sizes = _new_size($w, $h, $picture);

        extract($sizes);

        $slir = '/img/w' . $width . '-h' . $height . '-c' . $ratio;

        $src = $slir . '/' . $path;



        $img = '<img src="' . $src . '" alt="' . $picture['alt'] . '" width="' . $width . '" height="' . $height . '" />';


        if ($b) {

            $sizes = _new_size($b, $b, $picture);

            extract($sizes);

            $slir = '/img/w' . $width . '-h' . $height;

            $href = $slir . '/' . $path;

         //   $zoom = ' data-zoom-image="' .$href . '"';

            $tpl = '<a href="' . $href . '">';
            $tpl .= $img;
           //$tpl .= str_replace(' />', $zoom.' />', $img);
            $tpl .= '</a>';

        } else {

            $tpl = $img;
        }


        return $tpl;

    }
}


?>
