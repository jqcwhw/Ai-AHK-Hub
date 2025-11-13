import AIGenerator from '../AIGenerator';
import { useState } from 'react';

export default function AIGeneratorExample() {
  const [prompt, setPrompt] = useState('');
  const [isGenerating, setIsGenerating] = useState(false);
  
  const handleGenerate = () => {
    setIsGenerating(true);
    setTimeout(() => setIsGenerating(false), 2000);
    console.log('Generate:', prompt);
  };
  
  return (
    <AIGenerator 
      prompt={prompt}
      onPromptChange={setPrompt}
      onGenerate={handleGenerate}
      isGenerating={isGenerating}
    />
  );
}