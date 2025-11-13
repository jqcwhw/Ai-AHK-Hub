import ScriptCard, { Script } from '../ScriptCard';

const mockScript: Script = {
  id: '1',
  name: 'Window Manager',
  description: 'Quickly move and resize windows with keyboard shortcuts. Supports multi-monitor setups.',
  tags: ['productivity', 'windows', 'shortcuts'],
  downloadCount: 5420,
  content: '; Window management script',
  version: 'v2',
  isPersonal: false
};

export default function ScriptCardExample() {
  return (
    <ScriptCard 
      script={mockScript}
      onDownload={(script) => console.log('Download:', script.name)}
      onPreview={(script) => console.log('Preview:', script.name)}
    />
  );
}