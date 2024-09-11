##################### CREATE MESH #############################################
# TODO dsm filtering
gdal_translate -ot float64 -srcwin 1505 891 390 372 data/Challenge1_Lidar_medfilt2.tif out/small_dsm.tif
bin/create_mesh out/small_dsm.tif out/scaled_mesh.off out/scaled_mesh.ply
bin/refine out/scaled_mesh.off out/refined_mesh.off --res 0.3
# TODO add trimesh2/mesh_filter for a smoother mesh (https://gfx.cs.princeton.edu/proj/trimesh2/)

############ COLOURISATION AND SHADOWS LOCALISATION (ONE IMAGE) ################
set im 37

# TODO: get offset from stereo dsm with registration algorithm 
set offset -14 -17 0.5 # trouvés à la main avec vpv pour l'instant

# TODO: add rpc extraction to pipeline (s2plib python script)
# s2plib.rpc_utils: rpc_from_geotiff(dataset/pan$im.ntf, '/tmp/pan.rpc')
bin/get_utm_normal_shadow out/refined_mesh.off 0.300000011920929 -0.300000011920929 354052.375 6182702 -21 /tmp/pan.rpc 074.483 60.839 /tmp/utm_coord_$im.tif /tmp/light_projection_$im.tif /tmp/scalars_$im.tif /tmp/visibility_$im.tif  -xmin 1505 -ymin 891 -ox $offset[1] -oy $offset[2] -oz $offset[3]

bin/colorize_vertices_from_one_image out/refined_mesh.off dataset/pan$im.ntf  /tmp/pan.rpc dataset/msi$im.ntf /tmp/msi.rpc -21 /tmp/utm_coord_$im.tif /tmp/light_projection_$im.tif /tmp/pan$im.tif /tmp/msi$im.tif /tmp/rgb$im.tif /tmp/real_sun.tif 

plambda /tmp/rgb$im.tif "x log" | qauto -v -p 0.1 -i - | bin/write_coloured_ply out/refined_mesh.off - out/rgb.ply; and mesh_view out/rgb.ply

# N.B. : on peut regarder les ombres en utilisant /tmp/real_sun.tif à la place de /tmp/rgb$im.tif. 



