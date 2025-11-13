import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ExternalLink, Download, Star, FileCode } from "lucide-react";

export interface SearchResult {
  id: string;
  repository: string;
  owner: string;
  fileName: string;
  filePath: string;
  stars: number;
  description: string;
  codePreview: string;
  url: string;
  downloadUrl: string;
  language: "AHK v1" | "AHK v2";
}

interface SearchResultCardProps {
  result: SearchResult;
  onDownload: (result: SearchResult) => void;
}

export default function SearchResultCard({ result, onDownload }: SearchResultCardProps) {
  return (
    <div className="relative group">
      <div className="absolute inset-0 bg-gradient-to-r from-emerald-500 to-teal-500 rounded-xl blur opacity-0 group-hover:opacity-20 transition-opacity duration-300"></div>
      <Card className="relative overflow-hidden bg-gradient-to-br from-slate-800 to-slate-900 border-2 border-emerald-500/20 group-hover:border-emerald-500/40 transition-all duration-300 shadow-lg shadow-emerald-500/5" data-testid={`card-result-${result.id}`}>
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-emerald-500 to-teal-500 rounded-t-xl" />
        
        <CardHeader className="space-y-3 pb-4 pt-6">
          <div className="flex items-start justify-between gap-3">
            <div className="flex-1 min-w-0">
              <CardTitle className="text-xl font-black flex items-center gap-3 flex-wrap tracking-tight text-slate-100">
                <div className="p-2.5 rounded-lg bg-emerald-500/10 ring-2 ring-emerald-500/20 group-hover:ring-emerald-500/30 transition-all">
                  <FileCode className="h-5 w-5 text-emerald-400" />
                </div>
                <span className="truncate">{result.fileName}</span>
              </CardTitle>
              <CardDescription className="text-sm mt-2 flex items-center gap-2 text-slate-300">
                <span className="font-semibold">{result.owner}</span>
                <span className="text-slate-500">/</span>
                <span className="font-medium">{result.repository}</span>
              </CardDescription>
            </div>
            <Badge variant="secondary" className="shrink-0 bg-gradient-to-r from-emerald-500 to-teal-500 text-white shadow-md shadow-emerald-500/20 border-0">
              {result.language}
            </Badge>
          </div>
          
          <p className="text-xs font-mono text-slate-400 bg-slate-800/50 rounded px-3 py-1.5 truncate" data-testid={`text-filepath-${result.id}`}>
            {result.filePath}
          </p>
        </CardHeader>
      
        <CardContent className="space-y-4">
          {result.description && (
            <p className="text-sm leading-relaxed text-slate-300">{result.description}</p>
          )}
          
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <span className="text-xs font-bold text-emerald-400 uppercase tracking-wide">Code Preview</span>
              <div className="flex items-center gap-2 text-xs text-slate-400">
                <Star className="h-3 w-3 fill-amber-400 text-amber-400" />
                <span className="font-semibold" data-testid={`text-stars-${result.id}`}>{result.stars.toLocaleString()}</span>
              </div>
            </div>
            <div className="bg-slate-950/50 rounded-lg p-4 overflow-x-auto border border-emerald-500/20 shadow-inner">
              <pre className="text-xs font-mono text-emerald-100/90">
                <code>{result.codePreview}</code>
              </pre>
            </div>
          </div>
        </CardContent>
        
        <CardFooter className="flex gap-2 flex-wrap border-t border-slate-700/50 pt-4">
          <Button
            variant="outline"
            size="sm"
            asChild
            data-testid={`button-view-${result.id}`}
            className="flex-1 min-w-[140px] border-emerald-500/30 text-emerald-300 hover:bg-emerald-500/10 hover:border-emerald-500/50"
          >
            <a href={result.url} target="_blank" rel="noopener noreferrer">
              <ExternalLink className="h-4 w-4 mr-2" />
              View on GitHub
            </a>
          </Button>
          <Button
            size="sm"
            onClick={() => onDownload(result)}
            data-testid={`button-download-${result.id}`}
            className="flex-1 min-w-[140px] bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-600 hover:to-teal-600 text-white shadow-md shadow-emerald-500/20"
          >
            <Download className="h-4 w-4 mr-2" />
            Download
          </Button>
        </CardFooter>
      </Card>
    </div>
  );
}