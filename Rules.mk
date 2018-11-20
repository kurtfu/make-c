#------------------------------------------------------------------------------
# BUILD RULES
#------------------------------------------------------------------------------

${EXEC}:
	${CL} ${CL_FLAG} -o $@ ${OBJ}

${SLIB}:
	${AR} -crv $@ ${OBJ}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAG} ${INC} -c -o $@ $<

${BIN_PATH}/%.o: ${PROJ_PATH}/%.s
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAG} ${INC} -c -o $@ $<

${BIN_PATH}/%.s: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${CC_FLAG} ${INC} -S -o $@ $<
