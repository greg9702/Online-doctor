import pysmile
# pysmile_license is your license key
import pysmile_license


net = pysmile.Network()
net.read_file("Network2.xdsl")

net.set_evidence("bol_glowy", "tak")
net.update_beliefs()

beliefs = net.get_node_value("grypa")

for i in range(0, len(beliefs)):
    print(net.get_outcome_id("grypa", i) + "=" + str(beliefs[i]))


for node in net.get_all_nodes():
    print(node)
    