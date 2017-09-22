
// include CARLsim user interface
#include <carlsim.h>
//#include <carlsim_datastructures.h>
// include stopwatch for timing
#include <stopwatch.h>
//#include <string>
#include <sstream>


int main() {
	//bool is_pstut = false;
	// keep track of execution time
	Stopwatch watch;
	// ---------------- CONFIG STATE -------------------
	int nNeurons_exc = 1000;
	int nNeurons_inh = 100;
	int nNeurons_psn = 100;
	double weight_min = 0;
	double weight_max_exc = 15;
	double weight_max_inh = 15;
	double weight_init = 15;
	int randSeed = 1505420798;
	
	CARLsim network("chaos", GPU_MODE, USER, 0, randSeed);
	int grp_in_exc=network.createSpikeGeneratorGroup("psn_exc_fs", nNeurons_psn, EXCITATORY_NEURON);
	//int grp_in_exc_pstut=network.createSpikeGeneratorGroup("psn_exc_pstut", nNeurons_psn, EXCITATORY_NEURON);
	//int grp_dis=network.createSpikeGeneratorGroup("psn_dis", 1000, EXCITATORY_NEURON);
	//int grp_exc_fs=network.createGroup("EXC_fs", nNeurons_exc, EXCITATORY_NEURON);
	//int grp_exc_pstut=network.createGroup("EXC_pstut", nNeurons_exc, EXCITATORY_NEURON);
//	int grp_inh=-1;
	//if(is_pstut)
	//int	grp_fs=network.createGroup("FS", nNeurons_inh, INHIBITORY_NEURON);
	int	grp_pstut=network.createGroup("FS", nNeurons_inh, INHIBITORY_NEURON);
	//else
	

//pstut model
	float k0=3.5916956523848826;
	float a0=0.009873755940151841;
	float b0=-10.914911940624444;
	float d0=120.0;
	float C0=195.0;
	float vr0=-63.500227564101365;
	float vt0=-46.58951988218102;
	float vpeak0=11.38098396907138;
	float c0=-50.61623937186045;
/*
//4-080-1
k0=3.0587634381147932;
a0=0.026098736010710277;
b0=7.363427418000718;
d0=4.0;
C0=208.0;
vr0=-64.94459578998348;
vt0=-44.575737574886304;
vpeak0=-0.4169370067716045;
c0=-51.08807348679976;

//2-019
k0=6.847157838153083;
a0=0.005269930497356339;
b0=-27.333905960628684;
d0=96.0;
C0=495.0;
vr0=-69.9748902389951;
vt0=-53.67973497851608;
vpeak0=34.12157579957278;
c0=-59.25594286053275;
*/
//fs model. asp.sln
	float k1=0.9951729;
	float a1=0.0038461864;
	float b1=9.2642765;
	float d1=-6.0;
	float C1=45.0;
	float vr1=-57.28488;
	float vt1=-23.15752;
	float vpeak1=18.676178;
	float c1=-47.334415;
	//if(!is_pstut)
		network.setNeuronParameters(grp_pstut, C1, k1, vr1, vt1, a1, b1, vpeak1, c1, d1);
	//else
		//network.setNeuronParameters(grp_pstut, C0, k0, vr0, vt0, a0, b0, vpeak0, c0, d0);

//asp. model -- CA1 Pyramidal
		float k2=0.7592354903875517;
		float a2=7.272902135842586E-4;
		float b2=18.92836201498369;
		float d2=24.0;
		float C2=1169.0;
		float vr2=-63.20652292061775;
		float vt2=-32.94386718002039;
		float vpeak2=59.92250499219622;
		float c2=-41.14667371696301;
	//network.setNeuronParameters(grp_exc_pstut, C2, k2, vr2, vt2, a2, b2, vpeak2, c2, d2);
	//network.setNeuronParameters(grp_exc_fs, C2, k2, vr2, vt2, a2, b2, vpeak2, c2, d2);
	
	//for FS circuit
	//network.connect(grp_in_exc, grp_exc_fs, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.75, RangeDelay(1), RadiusRF(-1),SYN_PLASTIC);

	//network.connect(grp_exc_fs, grp_exc_fs, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.75, RangeDelay(1),  RadiusRF(-1),SYN_PLASTIC);
	//network.connect(grp_exc_fs, grp_fs, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.95,  RangeDelay(1), RadiusRF(-1),SYN_PLASTIC);

	//network.connect(grp_fs, grp_fs, "random", RangeWeight(weight_min, weight_init, weight_max_inh), 0.55,RangeDelay(1), RadiusRF(-1),SYN_FIXED);
	//network.connect(grp_fs, grp_exc_fs, "random", RangeWeight(weight_min, weight_init, weight_max_inh), 0.5, RangeDelay(1), RadiusRF(-1),SYN_PLASTIC);

	//for PSTUT circuit
	network.connect(grp_in_exc, grp_pstut, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.99, RangeDelay(1),RadiusRF(-1),SYN_FIXED);

	//network.connect(grp_exc_pstut, grp_exc_pstut, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.95, RangeDelay(1),RadiusRF(-1),SYN_PLASTIC);
	//network.connect(grp_exc_pstut, grp_pstut, "random", RangeWeight(weight_min, weight_init, weight_max_exc), 0.95, RangeDelay(1),RadiusRF(-1),SYN_PLASTIC);

	network.connect(grp_pstut, grp_pstut, "random", RangeWeight(weight_min, weight_init, weight_max_inh), 0.55, RangeDelay(1),RadiusRF(-1),SYN_FIXED);
	//network.connect(grp_pstut, grp_exc_pstut, "random", RangeWeight(weight_min, weight_init, weight_max_inh), 0.25, RangeDelay(1), RadiusRF(-1),SYN_PLASTIC);
	
	
	// ---------------- SETUP STATE -------------------
	// build the network
	watch.lap("setupNetwork");

	//------------PLASTICITY--------------
	//network.setESTDP(grp_exc_fs, true, STANDARD, ExpCurve(2e-4f,20.0f, -6.6e-5f,60.0f));
	//network.setESTDP(grp_fs, true, STANDARD, ExpCurve(2e-4f,20.0f, -6.6e-5f,60.0f));
	//network.setHomeostasis(grp_exc_fs, true, 10.0f, 1000.0f);  // homeo scaling factor, avg time scale
	//network.setHomeoBaseFiringRate(grp_exc_fs, 100.0f, 0.0f); // target firing, target firing st.d.

	//network.setESTDP(grp_exc_pstut, true, STANDARD, ExpCurve(2e-4f,20.0f, -6.6e-5f,60.0f));
	//network.setESTDP(grp_pstut, true, STANDARD, ExpCurve(2e-4f,20.0f, -6.6e-5f,60.0f));
	//network.setHomeostasis(grp_exc_pstut, true, 10.0f, 1000.0f);  // homeo scaling factor, avg time scale
	//network.setHomeoBaseFiringRate(grp_exc_pstut, 100.0f, 0.0f); // target firing, target firing st.d.

	network.setConductances(false);

	//------------PLASTICITY--------------

	network.setIntegrationMethod(RUNGE_KUTTA4, 100);
	network.setupNetwork();

	/*network.recordVoltage(grp_fs, 0, "results/grp_fs_0.v");
	network.recordVoltage(grp_fs, 100, "results/grp_fs_100.v");
	network.recordVoltage(grp_fs, 551, "results/grp_fs_551.v");
	network.recordVoltage(grp_fs, 800, "results/grp_fs_800.v");
	*/

	for(int i=0;i<100;i++){

		std::stringstream stream;
		stream << i;


		network.recordVoltage(grp_pstut, i, "results/grp_pstut_"+stream.str());

	}
	
	network.setExternalCurrent(grp_pstut, 500);
	//network.setExternalCurrent(grp_fs, 500);
	
	//network.setSpikeMonitor(grp_exc_fs, "DEFAULT");
	//network.setSpikeMonitor(grp_fs, "DEFAULT");

	//network.setSpikeMonitor(grp_exc_pstut, "DEFAULT");
	network.setSpikeMonitor(grp_pstut, "DEFAULT");



	// ---------------- RUN STATE -------------------
	watch.lap("runNetwork");
	PoissonRate in(nNeurons_psn);
	in.setRates(0);
	network.setSpikeRate(grp_in_exc,&in);

	network.runNetwork(2,0);

	for(int i=0;i<100;i++){

			std::stringstream stream;
			stream << i;


			network.recordVoltage(grp_pstut, i, "results/grp_pstut_"+stream.str());

		}


	in.setRates(1000.0f);
	network.setSpikeRate(grp_in_exc,&in);

	network.runNetwork(0,100);

	for(int i=0;i<100;i++){

			std::stringstream stream;
			stream << i;


			network.recordVoltage(grp_pstut, i, "results/grp_pstut_"+stream.str());

		}

	in.setRates(0);
	network.setSpikeRate(grp_in_exc,&in);

	//in.setRates(0.0f);
	//network.setSpikeRate(grp_in_exc,&in);
	network.runNetwork(2,900);

	watch.stop();

	return 0;
}
