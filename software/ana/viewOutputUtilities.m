%% Configuration
clear all;close all;

run('../conf/initConf.m');
[status, RPCRUNMODE] = system('echo $RPCRUNMODE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run([HOME 'software/conf/loadGeneralConf.m']);


%% Load configuration
conf = initSystem();
conf = loadConfiguration({conf,HOSTNAME,SYSTEMNAME,HOME,SYS,INTERPRETER,OS});

b = conf.bar;

% View vars in  anaPlaneStrips
%nPlanes = conf.ana.param.strips.planes;
nStrips = conf.ana.param.strips.strips;
nPlanes = conf.ana.param.strips.planes;
load([conf.daq.raw2var.path.lookUpTables conf.ana.calibration.QPEDParam])



load('/home/alberto/tmp/m3/dabc24247142059.mat');

%XY distribution
figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    title(['Plane ' num2str(p)]);
    imagesc(outputVarsPlane{p}{16});
end

%Q mean distribution
figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    title(['Plane ' num2str(p)]);
    imagesc(outputVarsPlane{p}{17});
end

%ST mean distribution
figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    title(['Plane ' num2str(p)]);
    imagesc(outputVarsPlane{p}{19}./outputVarsPlane{p}{16});
end

figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    title(['Plane ' num2str(p)]);
    histf(outputVarsPlane{p}{7},-10:0.1:200);
end


figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    title(['Plane ' num2str(p)]);
    histf(outputVarsPlane{p}{7},-10:1:200);logy;xaxis(-10,200);yaxis(0,max(outputVarsPlane{p}{7})*1.1);
end


figure;
for p = 1:nPlanes
    subplot(ceil(sqrt(nPlanes)),ceil(sqrt(nPlanes)),p);hold on
    imagesc(outPutVarsTelescope{3}(:,:,p)./outPutVarsTelescope{2}(:,:,p));
end

return






