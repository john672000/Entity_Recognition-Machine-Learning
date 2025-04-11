# Emergency Entity_Extraction

## Getting Started

This Project works soely on the idea of how machine learning models can extract defined entities with no waste of time. If properly implemented can tone down a lot of time in creating a descriptive data on the offenders.

The project is about a Front_End Framework written in Flutter and used a Pre-Trained BERT model and extensively trained on random data that mimics 911 call transcripts that I have generated using Python Random and BIO-Tagged them based on what the machine have to learn and identify and in this use case I wanted it to identify 6 main things in a conversation
1. Names
2. Location
3. Emenrgency Type
4. Phone Numbers
5. Description of the Offender (if described)

using this trained model with impressive f1 scores I have used a whisper model to transcribe the audio that mimics a 911 call and have tested it on various cases and have reached a 0.92f1 on extraction could make it better but find the datasets for this use case are a pain in the SaaS. Hopefully this could be a begging on how to train Transformer models for personal use cases #######


