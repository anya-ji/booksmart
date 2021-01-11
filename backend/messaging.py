from db import db
import datetime

class Message(db.Model):
  __tablename__ = 'message'
  id = db.Column(db.Integer, primary_key = True)
  body = db.Column(db.String, nullable = False)
  createdAt = db.Column(db.DateTime, nullable=False)
  sender_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
  recipient_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
  read = db.Column(db.Boolean, nullable=False, default=False) # True when recipient has read the message

def __init__(self, **kwargs):
  self.body = kwargs.get('body', '')
  self.createdAt = datetime.datetime.now()
  self.sender_id = kwargs.get('senderId')
  self.recipient_id = kwargs.get('recipientId')

def serialize(self):
  return{
    'id': self.id,
    'body': self.body,
    'createdAt': str(self.createdAt),
    'senderId': self.sender_id,
    'recipientId': self.recipient_id,
    'read': self.read
  }
