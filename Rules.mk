#------------------------------------------------------------------------------
# COMPILER FLAGS
#------------------------------------------------------------------------------

# Add search path for header files.
CC_FLAGS += $(addprefix -I , ${INC_PATH})

#------------------------------------------------------------------------------
# BUILD RULES
#------------------------------------------------------------------------------

${EXEC}:
	${CL} ${CL_FLAGS} -o $@ ${OBJ}

${SLIB}:
	${AR} -crv $@ ${OBJ}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAGS} -c -o $@ $<

${BIN_PATH}/%.o: ${PROJ_PATH}/%.s
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAGS} -c -o $@ $<

${BIN_PATH}/%.s: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAGS} -S -o $@ $<
