import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Download, Eye, Trash2, FileCode } from "lucide-react";

export interface Macro {
  id: string;
  name: string;
  description: string;
  tags: string[];
  downloadCount?: number;
  content: string;
  version: "v1" | "v2";
  isPersonal?: boolean;
}

interface MacroCardProps {
  macro: Macro;
  onDownload: (macro: Macro) => void;
  onPreview: (macro: Macro) => void;
  onDelete?: (macro: Macro) => void;
}

export default function MacroCard({ macro, onDownload, onPreview, onDelete }: MacroCardProps) {
  return (
    <div className="relative group">
      <div className="absolute inset-0 bg-gradient-to-r from-emerald-500 to-teal-500 rounded-xl blur opacity-0 group-hover:opacity-20 transition-opacity duration-300"></div>
      <Card className="relative flex flex-col bg-gradient-to-br from-slate-800 to-slate-900 border-2 border-emerald-500/20 group-hover:border-emerald-500/40 transition-all duration-300 shadow-lg shadow-emerald-500/5" data-testid={`card-macro-${macro.id}`}>
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-emerald-500 to-teal-500 rounded-t-xl" />
        
        <CardHeader className="space-y-3 pb-4 pt-6">
          <div className="flex items-start justify-between gap-3">
            <div className="flex items-center gap-3">
              <div className="p-2.5 rounded-lg bg-emerald-500/10 ring-2 ring-emerald-500/20 group-hover:ring-emerald-500/30 transition-all">
                <FileCode className="h-5 w-5 text-emerald-400" />
              </div>
              <Badge variant="secondary" className="bg-gradient-to-r from-emerald-500 to-teal-500 text-white shadow-md shadow-emerald-500/20 border-0">
                AHK {macro.version}
              </Badge>
            </div>
          </div>
          <CardTitle className="text-xl font-black text-slate-100 tracking-tight" data-testid={`text-macroname-${macro.id}`}>
            {macro.name}
          </CardTitle>
          <CardDescription className="text-slate-300 text-sm leading-relaxed min-h-[2.5rem]">
            {macro.description}
          </CardDescription>
        </CardHeader>
      
        <CardContent className="flex-1 space-y-4">
          <div className="flex flex-wrap gap-2">
            {macro.tags.map((tag) => (
              <Badge key={tag} variant="outline" className="text-xs border-emerald-500/30 bg-emerald-500/5 text-emerald-300 hover:bg-emerald-500/10 transition-colors">
                {tag}
              </Badge>
            ))}
          </div>
          
          <div className="space-y-2">
            <span className="text-xs font-bold text-emerald-400 uppercase tracking-wide">Code Preview</span>
            <div className="bg-slate-950/50 rounded-lg p-4 max-h-48 overflow-auto border border-emerald-500/20 shadow-inner">
              <pre className="text-xs font-mono text-emerald-100/90 whitespace-pre-wrap">
                <code>{macro.content.slice(0, 300)}{macro.content.length > 300 ? '...' : ''}</code>
              </pre>
            </div>
          </div>
          
          {macro.downloadCount !== undefined && (
            <div className="flex items-center gap-2 text-xs text-slate-400 bg-slate-800/50 rounded-md px-3 py-2">
              <Download className="h-3 w-3 text-emerald-400" />
              <span className="font-semibold">{macro.downloadCount.toLocaleString()} downloads</span>
            </div>
          )}
        </CardContent>
        
        <CardFooter className="flex gap-2 flex-wrap border-t border-slate-700/50 pt-4">
          <Button
            variant="outline"
            size="sm"
            onClick={() => onPreview(macro)}
            data-testid={`button-preview-${macro.id}`}
            className="flex-1 min-w-[100px] border-emerald-500/30 text-emerald-300 hover:bg-emerald-500/10 hover:border-emerald-500/50"
          >
            <Eye className="h-4 w-4 mr-2" />
            Preview Code
          </Button>
          <Button
            size="sm"
            onClick={() => onDownload(macro)}
            data-testid={`button-download-${macro.id}`}
            className="flex-1 min-w-[100px] bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-600 hover:to-teal-600 text-white shadow-md shadow-emerald-500/20"
          >
            <Download className="h-4 w-4 mr-2" />
            Download
          </Button>
          {macro.isPersonal && onDelete && (
            <Button
              variant="destructive"
              size="sm"
              onClick={() => onDelete(macro)}
              data-testid={`button-delete-${macro.id}`}
              className="w-full"
            >
              <Trash2 className="h-4 w-4 mr-2" />
              Delete Macro
            </Button>
          )}
        </CardFooter>
      </Card>
    </div>
  );
}