import pysmile
import pysmile_license # pysmile_license is your license key

from typing import List

SYMPTOM_NODE_LABEL : int = 146
DISEASE_NODE_LABEL : int = 18

SCORE_TRESHOLD : float = 0.55

indirect_symptoms = ["goraczka"]

def load_network() -> pysmile.Network:
    net = pysmile.Network()

    try:
        net.read_file("Network2.xdsl")
    except Exception as e:
        print(e)
        return None

    return net

def set_evidences(network : pysmile.Network, evidences : List[str], patient_temperature: int) -> pysmile.Network:

    for ev in evidences:
        network.set_evidence(ev, "tak")

    if patient_temperature > 37:
        network.set_evidence("goraczka", "tak")

    return network


def get_all_dieseases() -> List[str]:

    net = load_network()

    if net == None:
        return []

    diesases_list : List[str] = []

    for node_handle in net.get_all_nodes():
        if net.get_node_type(node_handle) == DISEASE_NODE_LABEL:
            diesases_list.append(net.get_node_name(node_handle))

    return diesases_list


def get_all_symptoms() -> List[str]:

    net = load_network()

    if net == None:
        return []

    symptoms_list : List[str] = []

    for node_handle in net.get_all_nodes():
        if net.get_node_type(node_handle) == SYMPTOM_NODE_LABEL:
            if net.get_node_name(node_handle) not in indirect_symptoms:
                symptoms_list.append(net.get_node_name(node_handle))

    return symptoms_list


def get_diagnose(patient_age : int, patient_temperature : int, patient_symptoms : List[str]) -> str:

    net = load_network()

    if net == None:
        return None

    # TODO add handling of patient_age and patient_temperature
    set_evidences(net, patient_symptoms, patient_temperature)

    net.update_beliefs()

    # scores under 30 we ignore
    max_score : float = SCORE_TRESHOLD
    disease : str = None

    for dis in get_all_dieseases():
        beliefs = net.get_node_value(dis)
        print(dis)

        for i in range(0, len(beliefs)):
            if net.get_outcome_id(dis, i) == "tak":
                print(beliefs[i])
                if beliefs[i] > max_score:
                    max_score = beliefs[i]
                    disease = dis
        print("==========")

    return disease
