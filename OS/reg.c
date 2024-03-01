/*==========================================================*/
/* Programme de régulation du niveau de la cuve             */
/*__________________________________________________________*/
/* Jacques BOONAERT-LEPERS                                   */
/* Évaluation AMSE 2023-2024                                 */
/*==========================================================*/
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

/* Constante de la cuve */
#define LEVEL_SECTION   "LEVEL_SECTION"

/* Seuil du niveau de la cuve à surveiller */
#define THRESHOLD_LEVEL 0.8

/* Prototypes des fonctions locales */
void levelMonitor(int);

/* Gestionnaire pour la surveillance du niveau de la cuve */
void levelMonitor(int signal) {
    double *level;
    int fd;

    /* Ouverture de la zone partagée */
    fd = shm_open(LEVEL_SECTION, O_RDONLY, 0600);
    if (fd < 0) {
        fprintf(stderr, "Erreur dans l'ouverture de la zone partagée.\n");
        exit(EXIT_FAILURE);
    }

    /* Mapping de la zone partagée */
    level = (double *)mmap(NULL, sizeof(double), PROT_READ, MAP_SHARED, fd, 0);
    if (level == MAP_FAILED) {
        fprintf(stderr, "Erreur dans le mappage de la zone partagée.\n");
        exit(EXIT_FAILURE);
    }

    /* Vérification du niveau */
    if (*level >= THRESHOLD_LEVEL) {
        printf("Le niveau de la cuve a atteint le seuil critique.\n");
        kill(getpid(), SIGUSR1); /* Envoie du signal */
    }

    /* Fermeture de la zone partagée */
    close(fd);
}

int main() {
    struct sigaction sa;

    /* Mise en place du gestionnaire de signal */
    sa.sa_handler = levelMonitor;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGALRM, &sa, NULL) == -1) {
        fprintf(stderr, "Erreur lors de la mise en place du gestionnaire de signal.\n");
        exit(EXIT_FAILURE);
    }

    while (1) {
        pause(); /* Attente des signaux */
    }

    return 0;
}
