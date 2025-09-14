import {
  isSavedToFirebase,
  loadFilesFromFirebase,
  loadFromFirebase,
  saveFilesToFirebase,
  saveSceneToFirebaseForMigration,
  saveToFirebase,
} from "./firebase";
import {
  isSavedToHttpStorage,
  loadFilesFromHttpStorage,
  loadFromHttpStorage,
  saveFilesToHttpStorage,
  saveSceneForMigration as saveSceneToHttpStorageForMigration,
  saveToHttpStorage,
} from "./httpStorage";
import type { StorageBackend } from "./StorageBackend";

const firebaseStorage: StorageBackend = {
  isSaved: isSavedToFirebase,
  saveToStorageBackend: async (portal, elements, appState) => {
    // saveToFirebase returns either null or stored elements array; adapt to interface
    const res = await saveToFirebase(portal, elements, appState);
    if (!res) {
      return false;
    }
    return { reconciledElements: res };
  },
  loadFromStorageBackend: loadFromFirebase,
  saveFilesToStorageBackend: async ({ prefix, files }) => {
    // saveFilesToFirebase returns arrays; convert to Maps per interface
    const { savedFiles, erroredFiles } = await saveFilesToFirebase({
      prefix,
      files,
    });
    return {
      savedFiles: new Map(savedFiles.map((id) => [id, true] as const)),
      erroredFiles: new Map(erroredFiles.map((id) => [id, true] as const)),
    };
  },
  loadFilesFromStorageBackend: loadFilesFromFirebase,
  saveSceneForMigration: saveSceneToFirebaseForMigration,
};

const httpStorage: StorageBackend = {
  isSaved: isSavedToHttpStorage,
  saveToStorageBackend: saveToHttpStorage,
  loadFromStorageBackend: loadFromHttpStorage,
  saveFilesToStorageBackend: saveFilesToHttpStorage,
  loadFilesFromStorageBackend: loadFilesFromHttpStorage,
  saveSceneForMigration: saveSceneToHttpStorageForMigration,
};

const storageBackends = new Map<string, StorageBackend>()
  .set("firebase", firebaseStorage)
  .set("http", httpStorage);

export let storageBackend: StorageBackend | null = null;

export async function getStorageBackend() {
  if (storageBackend) {
    return storageBackend;
  }

  const storageBackendName = import.meta.env.VITE_APP_STORAGE_BACKEND || "";

  if (storageBackends.has(storageBackendName)) {
    storageBackend = storageBackends.get(storageBackendName) as StorageBackend;
  } else {
    console.warn("No storage backend found, default to firebase");
    storageBackend = firebaseStorage;
  }

  return storageBackend;
}
