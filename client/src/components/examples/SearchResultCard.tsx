import SearchResultCard, { SearchResult } from '../SearchResultCard';

const mockResult: SearchResult = {
  id: '1',
  repository: 'awesome-ahk-scripts',
  owner: 'john-doe',
  fileName: 'anti-afk.ahk',
  filePath: 'scripts/gaming/anti-afk.ahk',
  stars: 1250,
  description: 'Prevents being kicked for inactivity in games by simulating mouse movements',
  codePreview: `#Persistent\nSetTimer, AntiAFK, 300000\nreturn\n\nAntiAFK:\n  MouseMove, 1, 0, 0, R\n  Sleep, 100\n  MouseMove, -1, 0, 0, R\nreturn`,
  url: 'https://github.com/john-doe/awesome-ahk-scripts',
  downloadUrl: 'https://raw.githubusercontent.com/john-doe/awesome-ahk-scripts/main/anti-afk.ahk',
  language: 'AHK v1'
};

export default function SearchResultCardExample() {
  return (
    <SearchResultCard 
      result={mockResult}
      onDownload={(result) => console.log('Download:', result.fileName)}
    />
  );
}