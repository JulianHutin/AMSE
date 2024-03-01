/*==========================================================*/
/* Programme pour ajuster le débit de la cuve en conséquence*/
/*__________________________________________________________*/
/* Jacques BOONAERT-LEPERS                                   */
/* Évaluation AMSE 2023-2024                                 */
/*==========================================================*/
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

/* Constante du débit */
#define FLOW_RATE_SECTION   "FLOW_RATE_SECTION"

/* Prototypes des fonctions locales */
void adjustFlowRate(double);

/* Ajuste le débit de la cuve en conséquence */
void adjustFlowRate(double newRate) {
    double *flowRate;
    int fd;

    /* Ouverture de la zone partagée */
    fd = shm_open(FLOW_RATE_SECTION, O_RDWR, 0600);
    if (fd < 0) {
        fprintf(stderr, "Erreur dans l'ouverture de la zone partagée.\n");
        exit(EXIT_FAILURE);
    }

    /* Mapping de la zone partagée */
    flowRate = (double *)mmap(NULL, sizeof(double), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (flowRate == MAP_FAILED) {
        fprintf(stderr, "Erreur dans le mappage de la zone partagée.\n");
        exit(EXIT_FAILURE);
    }

    /* Ajustement du débit */
    *flowRate = newRate;

    /* Fermeture de la zone partagée */
    close(fd);
}

int main(int argc, char *argv[]) {
    double newFlowRate;

    /* Vérification des arguments */
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <nouveau débit>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    /* Récupération du nouveau débit depuis les arguments */
    if (sscanf(argv[1], "%lf", &newFlowRate) != 1) {
        fprintf(stderr, "Erreur de format dans le débit entrant.\n");
        exit(EXIT_FAILURE);
    }

    /* Ajustement du débit de la cuve */
    adjustFlowRate(newFlowRate);

    return 0;
}
