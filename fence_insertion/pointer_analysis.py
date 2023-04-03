import subprocess
from enum import Enum


class MemAccessDirection(Enum):
    READ = 0
    WRITE = 1


class MemoryAccess:
    def __init__(self, location: str, function_name: str, direction: MemAccessDirection, instr_txt: str):
        """
        Makes a new memory access object.
        :param location: The location being accessed.
        :param function_name: The function that performed the access
         (none if the access happened outside a function scope).
        :param direction: The direction of the access (read/write).
        :param instr_txt: The textual form of the instruction that performed the access.
        """
        self.location = location
        self.function_name = function_name
        self.direction = direction
        self.instr_txt = instr_txt


class SVF:
    def __init__(self, path_to_wpa: str):
        self.location = path_to_wpa

    def run(self, path_to_file: str) -> list:
        """
        Runs the SVF tool on a given bitcode file,
        and extracts the required analysis results.
        :param path_to_file: The path to the file to be analysed.
        :return: A list of memory accesses.
        """
        cmd = f"{self.location} -ander -svfg -dump-mssa {path_to_file}"
        # Run SVF and extract the output
        cmd_output = str(subprocess.check_output(cmd, shell=True))
        cmd_output = cmd_output.split('\\n')
        mem_ssa = cmd_output[cmd_output.index("****Memory SSA Statistics****"):]
        mem_ssa = mem_ssa[
                  mem_ssa.index('#######################################################') + 1:
                  mem_ssa.index('****SVFG Statistics****')]
        results = []
        curr_func = ""
        for i, log in enumerate(mem_ssa):
            if "FUNCTION" in log:
                # Extract function name
                curr_func = log[log.index(':') + 2:]
                curr_func = curr_func[:curr_func.index("=")]
            elif "LDMU" in log:
                # Parse LDMU annotation and get corresponding instruction
                location = log[5: log.index(")")]
                instr = mem_ssa[i + 1].strip()
                results.append(MemoryAccess(location, curr_func, MemAccessDirection.READ, instr))
            elif "STCHI" in log:
                # Parse STCHI annotation and get corresponding instruction
                location = log[log.index("STCHI") + 6: log.index(")")]
                instr = mem_ssa[i - 1].strip()
                results.append(MemoryAccess(location, curr_func, MemAccessDirection.WRITE, instr))
        return results
