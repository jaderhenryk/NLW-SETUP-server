import WebPush from 'web-push'
import { FastifyInstance } from 'fastify'
import { z } from 'zod'

const publicKey = 'BO6fL5EZJXGS3_Vu5vaIiDcgmU95zwV9fJLqSfqxp1ovKhVITfnTGdQ4vAHUPTxDMceogOcdVfwglrXx1SWDL9k'
const privateKey = 'f7ft-MAO7ckP5_o4UYN63EbZhawPO_VeOH05Q1pULSU'

WebPush.setVapidDetails(
  'http://localhost:3333',
  publicKey,
  privateKey
)

export async function notificationsRoutes(app: FastifyInstance) {
  app.get('/push/public_key', () => {
    return { publicKey }
  })

  app.post('/push/register', (req, reply) => {
    return reply.status(201).send()
  })

  app.post('/push/send', async (req, reply) => {
    const sendPushBody = z.object({
      subscription: z.object({
        endpoint: z.string(),
        keys: z.object({
          p256dh: z.string(),
          auth: z.string()
        })
      })
    })
    const { subscription } = sendPushBody.parse(req.body)
    WebPush.sendNotification(subscription, 'Testando uma nova notificação')
    return reply.status(201).send()
  })
}