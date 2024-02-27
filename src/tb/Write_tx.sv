class write_tx extends uvm_sequence_item;
  rand bit [7:0] data;

 `uvm_object_utils_begin(write_tx)
 `uvm_field_int(data,UVM_ALL_ON)
 `uvm_object_utils_end

 `NEW_OBJ

endclass