export const getUploadUrl = (projectId: string, bucketName: string, filePath: string) => {
    return `https://${projectId}.supabase.co/storage/v1/object/public/${bucketName}/${filePath}`
}