const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const { onSchedule } = require('firebase-functions/v2/scheduler');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();

exports.onRegistrationCreated = onDocumentCreated('registrations/{registrationId}', async (event) => {
  const data = event.data?.data();
  if (!data?.userId || !data?.eventId) return;
  await db.collection('notifications').add({
    userId: data.userId,
    title: 'Registration successful',
    body: 'Your Eventra registration has been confirmed.',
    type: 'registration',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    read: false,
  });
});

// Starter scheduled job. Add FCM token querying and event-date filtering here.
exports.eventReminderJob = onSchedule('every 24 hours', async () => {
  const snap = await db.collection('events').where('status', '==', 'approved').get();
  console.log(`Checked ${snap.size} approved events for reminders.`);
  // Production implementation: find events happening tomorrow, read user FCM tokens,
  // and call messaging.sendEachForMulticast().
  return null;
});
