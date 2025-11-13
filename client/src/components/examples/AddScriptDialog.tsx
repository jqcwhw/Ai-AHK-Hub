import AddScriptDialog from '../AddScriptDialog';
import { useState } from 'react';
import { Button } from '@/components/ui/button';

export default function AddScriptDialogExample() {
  const [open, setOpen] = useState(false);
  
  return (
    <div>
      <Button onClick={() => setOpen(true)}>Open Dialog</Button>
      <AddScriptDialog 
        open={open}
        onOpenChange={setOpen}
        onSave={(script) => console.log('Save script:', script)}
      />
    </div>
  );
}