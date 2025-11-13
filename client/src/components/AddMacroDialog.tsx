import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useState } from "react";
import { Macro } from "./MacroCard";

interface AddMacroDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onSave: (macro: Omit<Macro, 'id'>) => void;
}

export default function AddMacroDialog({ open, onOpenChange, onSave }: AddMacroDialogProps) {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [content, setContent] = useState("");
  const [tags, setTags] = useState("");
  const [version, setVersion] = useState<"v1" | "v2">("v2");

  const handleSave = () => {
    if (name && content) {
      onSave({
        name,
        description,
        content,
        tags: tags.split(',').map(t => t.trim()).filter(Boolean),
        version,
        isPersonal: true,
      });
      setName("");
      setDescription("");
      setContent("");
      setTags("");
      onOpenChange(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>Add New Macro</DialogTitle>
          <DialogDescription>
            Add a macro to your personal library
          </DialogDescription>
        </DialogHeader>
        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">Macro Name</Label>
            <Input
              id="name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="My Custom Macro"
              data-testid="input-macro-name"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="description">Description</Label>
            <Textarea
              id="description"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="What does this macro do?"
              className="resize-none"
              rows={2}
              data-testid="input-macro-description"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="tags">Tags (comma-separated)</Label>
            <Input
              id="tags"
              value={tags}
              onChange={(e) => setTags(e.target.value)}
              placeholder="gaming, automation, productivity"
              data-testid="input-macro-tags"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="version">AutoHotkey Version</Label>
            <div className="flex gap-4">
              <Button
                variant={version === "v1" ? "default" : "outline"}
                onClick={() => setVersion("v1")}
                data-testid="button-version-v1"
              >
                v1
              </Button>
              <Button
                variant={version === "v2" ? "default" : "outline"}
                onClick={() => setVersion("v2")}
                data-testid="button-version-v2"
              >
                v2
              </Button>
            </div>
          </div>
          <div className="space-y-2">
            <Label htmlFor="content">Macro Code</Label>
            <Textarea
              id="content"
              value={content}
              onChange={(e) => setContent(e.target.value)}
              placeholder="Paste your AutoHotkey macro code here..."
              className="font-mono text-sm resize-none"
              rows={10}
              data-testid="input-macro-content"
            />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} data-testid="button-cancel">
            Cancel
          </Button>
          <Button onClick={handleSave} disabled={!name || !content} data-testid="button-save">
            Save Macro
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}