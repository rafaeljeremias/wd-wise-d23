unit ATreeView;

interface

uses classes, comctrls, controls, messages;

{
TATreeView : recursing stateimages treeview (for checkboxes)
FREE delphi component D6
copyright Greg Lorriman 1999 greg@lorriman.demon.co.uk
http://www.lorriman.demon.co.uk

Bug reports/fixes welcomed
So is love and attention. If you like this component then tell me - I won't be
angry :)  greg@lorriman.demon.co.uk

Description :
   Recurses (propogates) the "state" of a node (ie no-tick,tick,greytick).
   This is useful for checkbox treeviews. Stateimages are user defined via
   an imageList (handy images are supplied in the archive).

Features :
      Design time functionality (important : read instructions before trying)
      State Persistence (statesSaveToFile etc)
      Recursive behaviour supported via normal stateindex property of nodes.
      Branch can be excluded from recursion by setting stateindex of parent to
      value of StateIgnore property (default 0).
      This help is available via 'Help' property.

Known Limitations :

   No facility for "conditional exclusion".
   No speed or persistence size optimisation

Basic Usage :

   a)Set the stateimages property to an imagelist with your chosen state images.
   b)The items in the imagelist should be ordered as follows :
      0=anything (use 'empty' for convenience)
      1=empty
      2=ticked
      3=grey tick
   When adding icons to imagelist in D2 use 'stretch' option
   c)Set StateRecursion:=true;
   d)add some nodes (leave their stateindex at -1)
   d)run and click on node state images to test

Programmatic usage :

   You can set the state of a node (and get the same affect as clicking) via
   the property "stateIndex" of each node.
   You can "re-sync" the states by toggling the StateRecursion property.

Design time usage :

   The standard node editor does some strange things so design time usage
   works as follows :

   Valid states are 2 (ticked) and StateIgnore (ignore branch, default=0).
   Do not use other states as they will be ignored.
   The states are recursed at run-time (if StateRecusion:=true).
   It'll look a bit messy at design time. Empty and grey ticks will appear in
   the appropriate places at run time.

Persistence :

   Streaming can be 'chained' with streaming of other info.

   Saved states are compatible only with tree exactly as when saved. You'll
   only get an exception when loading if there are more nodes than original and
   stream falls off end.

   When loading it is necessary to set StateRecursion to false and then back to
   true after load. This allows these methods to be usable even if you are
   not using state recursion.

   You can probabaly get a speed up by invoking beginupdate/endupdate.

   Persistence is StateIgnore aware. Temporarily Change StateIgnore to an
   unused value if you wish to load/save ignored branches. Loading does not
   write to the stateindex of the root of an ignored branch.

   Persistence does not save the StateIgnore Value to the stream. If you need
   to do this then use the stream methods (rather than file) and write/read
   the value before calling the state-streaming method.

Notes :

Use StateIgnore to define the state that blocks the algorithm (ignores node
and it's children). Default=0. Changing StateIgnore does not cause an update
of the tree. Do this by toggling the StateRecursion property.

Clicking a stateimage can cause collapse and expansion. Optionally use this
code to prevent (in the appropriate events) :

   allowcollapse:=not (TATreeView(sender).MouseOnStateImage);

and same again for the expand event. Why isn't this incorporated? Because it
would impose a change to the default behaviour of the treeview component.

SCROLL TO TOP FOR START OF HELP
//ignore message above (for property help generator)
}

type
   TATreeView=class(TTreeView)
   private
      FStateRecursion : boolean;
      FStateIgnore: integer;
      procedure propogateStateDown(node : TTreeNode);//usually child
      procedure propogateStateUp(node : TTreeNode);//usually parent
      procedure stateSaveToStream(node: TTreeNode; stream: Tstream);
      procedure stateLoadFromStream(node: TTreeNode; stream: TStream);
      procedure SetStateIgnore(const Value: integer);
   protected
      //for recursing the state change of a node
      procedure propogateState(node : TTreeNode);virtual;
      //for component editor support - normally items.getfirstnode
      procedure syncState(node : TTreeNode);virtual;
      //general
      procedure setStateRecursion(const Value : boolean); virtual;
      procedure WndProc(var Message : TMessage); override;
      procedure Loaded; override;
      procedure nodeStateChangeNotify(node : TTreeNode);virtual;
      //user interaction support
      procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
   public
      constructor Create(AOwner: Tcomponent);override;
      destructor Destroy;override;
      //persistence
      procedure statesSaveToStream(stream : Tstream);virtual;
      procedure statesLoadFromStream(stream : TStream);virtual;
      procedure StatesSaveToFile(filename : string);
      procedure StatesLoadFromFile(filename : string);
      //for user to stop expand/collapse if required
      function mouseOnStateImage : boolean;
   published
      property StateRecursion : boolean read FStateRecursion write SetStateRecursion;
      property StateIgnore    : integer read FStateIgnore    write SetStateIgnore;
   end;

procedure Register;

implementation

uses windows, commctrl, sysutils;

constructor TATreeView.create(AOwner: Tcomponent);
begin
   inherited create(AOwner);
end;

destructor TATreeView.destroy;
begin
   inherited;
end;

procedure TATreeView.SetStateRecursion(const Value : boolean);
begin
   if Value<>FStateRecursion then
   begin
      FStateRecursion:=Value;
      if value then
         syncState(items.getfirstnode);
   end;
end;

procedure TATreeView.nodeStateChangeNotify(node: TTreeNode);
begin
   propogateState(node);
end;

procedure TATreeView.MouseDown(Button : TMouseButton; Shift : TShiftState;
   X, Y : Integer);
var
   index : integer;
begin
   inherited;

   if not FStateRecursion then exit;

   if assigned(selected)then
   begin
      if(htonstateicon in gethittestinfoat(x, y))then
      begin
         index:=selected.stateindex;
         inc(index);
         if index>2 then
            index:=1;
         selected.stateindex:=index;
      end;
   end;
end;

function TATreeView.MouseOnStateImage : boolean;
var
   mousepos : Tpoint;
begin
   getcursorpos(mousepos);
   mousepos:=screentoclient(mousepos);
   result:=htonstateicon in gethittestinfoat(mousepos.x, mousepos.y);
end;

procedure TATreeView.wndproc(var Message : TMessage);
var
   node : TTreeNode;
begin
   inherited;
   if([csDesigning, csLoading, csReading]*componentstate)<>[] then exit;
   if not FStateRecursion then exit;

   if message.msg=TVM_SETITEM then
   begin
      if(PTVITEM(message.lparam).mask and(TVIF_STATE or TVIF_HANDLE))>0 then
      begin
         node:=items.getnode(PTVITEM(message.lparam).hitem);
         if node.stateindex in [1, 2] then
            nodeStateChangeNotify(node);
      end;
   end;
end;

procedure TATreeView.propogateState(node : TTreeNode);
begin
   FStateRecursion:=False;
   try
      propogateStateDown(node);
      if assigned(node.parent)then
         propogateStateUp(node.parent);
   finally
      FStateRecursion:=true;
   end;
end;

procedure TATreeView.propogateStateDown(node : TTreeNode);
var
   child : TTreeNode;
begin
   with node do
   begin
      if stateindex=FStateIgnore then exit;
      child:=getfirstchild;
      while assigned(child) do
      begin
         if child.stateindex<>stateindex then
         begin
            if child.stateindex<>FStateIgnore then
               child.stateindex:=stateindex;
            propogateStateDown(child);
         end;
         child:=getnextchild(child);
      end;
   end;
end;

procedure TATreeView.propogateStateUp(node : TTreeNode);
var
   flag : integer;
   child : TTreeNode;
begin
   with node do
   begin
      if stateindex=FStateIgnore then exit;

      flag:=0;
      child:=getfirstchild;
      while assigned(child) do
      begin
         case child.stateindex of
            -1 : flag:=flag or 1;
            1  : flag:=flag or 1;
            2  : flag:=flag or 2;
            3  : flag:=flag or 4;
         end;
         child:=getnextchild(child);
      end;

      case flag of
         1 : stateindex:=1;
         2 : stateindex:=2;
         else stateindex:=3;
      end;

      if assigned(parent)then
         propogateStateUp(parent);
   end;
end;

procedure TATreeView.loaded;
begin
   inherited;
   if csDesigning in componentstate then exit;

   if FStateRecursion then
      syncState(items.getfirstnode);
end;

procedure TATreeView.syncState(node : TTreeNode);
var
   child : TTreeNode;
begin
   while assigned(node)do
   begin
      if node.stateindex<>FStateIgnore then
      with node do
      begin
         if stateindex=2 then
            propogateState(node)
         else
         begin
            if stateindex=-1 then
            begin
               FStateRecursion:=false;
               stateindex:=1;
               FStateRecursion:=true;
            end;
            child:=getfirstchild;
            while assigned(child) do
            begin
               if child.stateindex<>FStateIgnore then
                  syncState(child);
               child:=getnextchild(child);
            end;
         end;
      end;
      node:=node.getNextSibling;
   end;
end;

procedure TATreeView.stateLoadFromStream(node : TTreeNode;stream: TStream);
var
   state : integer;
   child : TTreeNode;
begin
   while assigned(node) do
   begin
      with node do
      begin
         stream.read(state,sizeof(state));
         if state=StateIgnore then exit;
         stateIndex:=state;
         child:=getfirstchild;
         while assigned(child) do
         begin
            stateLoadFromStream(child,stream);
            child:=getnextchild(child);
         end;
      end;
      node:=node.getNextSibling;
   end;
end;

procedure TATreeView.stateSaveToStream(node : TTreeNode;stream: Tstream);
var
   state : integer;
   child : TTreeNode;
begin
   while assigned(node) do
   begin
      with node do
      begin
         state:=stateIndex;
         stream.write(state,sizeof(state));
         if state=StateIgnore then Exit;

         child:=getfirstchild;
         while assigned(child) do
         begin
            stateSaveToStream(child,stream);
            child:=getnextchild(child);
         end;
      end;
      node:=node.getNextSibling;
   end;
end;

procedure TATreeView.statesSaveToStream(stream: Tstream);
begin
   stateSaveToStream(items.getfirstnode,stream);
end;

procedure TATreeView.statesLoadFromStream(stream: TStream);
begin
   StateLoadFromStream(items.getfirstnode,stream);
end;

procedure TATreeView.StatesLoadFromFile(filename: string);
var
   stream : TFileStream;
begin
   stream:=TFileStream.create(filename,fmShareDenyNone + fmOpenRead);
   try
      statesLoadFromStream(stream);
   finally
      stream.free;
   end;
end;

procedure TATreeView.StatesSaveToFile(filename: string);
var
   stream : TFileStream;
begin
   stream:=TFileStream.create(filename,fmCreate);
   try
      statesSaveToStream(stream);
   finally
      stream.free;
   end;
end;

procedure TATreeView.SetStateIgnore(const Value: integer);
begin
  FStateIgnore := Value;
end;

procedure Register;
begin
   RegisterComponents('Wise Developer', [TATreeView]);
end;

end.
