////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38578 $
////////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 SlickEdit Inc.
////////////////////////////////////////////////////////////////////////////////////
#ifndef SLICKEDIT_LIST_TAGS_TARGET_H
#define SLICKEDIT_LIST_TAGS_TARGET_H

#include "vsdecl.h"
#include "vs.h"
#include "tagsmain.h"
#include "tags/SETagInformation.h"
#include "slickedit/SEString.h"
#include "slickedit/SEArray.h"
#include "slickedit/SEStack.h"
#include "slickedit/SEHashSet.h"
#include "slickedit/SEHashTable.h"
#include "slickedit/SEStringTable.h"

namespace slickedit {

enum SEEmbeddedTaggingOption
{
   // collate all sections with this language ID and parse as one section
   SE_EMBEDDED_COLLATE_AND_TAG,
   // parse each one of these sections individually
   SE_EMBEDDED_TAG_INDIVIDUALLY,
   // parse this embedded section immediately, return error if not possible
   SE_EMBEDDED_TAG_IMMEDIATELY,
   // do not parse this embedded section
   SE_EMBEDDED_DO_NOT_TAG
};

/**
 * This class represents a symbol, also known as a "tag" that is identified 
 * by the symbol parsing system as a declaration of a symbol, definition of 
 * a symbol, or a general statement as discovered by the language specific 
 * parsing engine. 
 *  
 * The class is used to represent the symbol in memory, and also to 
 * set and query it's properties.  It can also map itself to the tag information 
 * used in the interpreter. 
 */
class VSDLLEXPORT SEListTagsTarget : public SEMemory 
{
public:
   /**
    * Default constructor
    */
   SEListTagsTarget();

   /**
    * Simple constructor 
    *  
    * @param fileName      name of file which we are tagging 
    * @param taggingFlags  bitset of VSLTF_* 
    * @param bufferId      buffer ID if tagging from an editor control 
    * @param tagDatabase   name and path of tag database to update 
    * @param startLine     first line to begin parsing on (for local variables) 
    * @param startSeekPos  seek position to start parsing at 
    * @param stopLine      last line to stop parsing at (for local variables) 
    * @param stopSeekPos   seek position to stop parsing at 
    * @param currentLine    line number cursor when parsing starts 
    * @param currentSeekPos position of cursor when parsing starts 
    * @param contextId      context Id of symbol being parsed for locals 
    */
   SEListTagsTarget(const slickedit::SEString &fileName, 
                    const unsigned int taggingFlags = 0,
                    const unsigned int bufferId = 0,
                    const slickedit::SEString &tagDatabase = (const char *)0,
                    const unsigned int startLine = 0,
                    const unsigned int startSeekPosition = 0,
                    const unsigned int stopLine = 0,
                    const unsigned int stopSeekPosition = 0,
                    const unsigned int currentLine = 0,
                    const unsigned int currentSeekPosition = 0,
                    const unsigned int contextId = 0);

   /**
    * Copy constructor
    */
   SEListTagsTarget(const SEListTagsTarget& src);

   /**
    * Destructor
    */
   virtual ~SEListTagsTarget();

   /**
    * Assignment operator
    */
   SEListTagsTarget &operator = (const SEListTagsTarget &src);

   /**
    * Comparison operators
    */
   bool operator == (const SEListTagsTarget &lhs) const;
   bool operator != (const SEListTagsTarget &lhs) const;

   /**
    * Hash function for using in SEHashSet 
    */
   unsigned int hash() const;

   /** 
    * Based on the arguments passed into a list-tags or list-locals function, 
    * get the buffer contents and information such as the start and stop 
    * seek position, initial line number and tagging flags, and store that 
    * information within this object. 
    * <p>
    * NOTE: This function is NOT thread-safe. 
    *  
    * @param fileName      name of buffer passed to list-tags function 
    * @param langId        language ID to parse file using 
    * 
    * @return 0 on success, <0 on error. 
    */
   int getListTagsBufferInformation(const slickedit::SEString &fileName,
                                    const slickedit::SEString &langId);

   /** 
    * Set up this tagging target to tag the given file on disk using 
    * the language specified's tagging target. 
    * <p>
    * NOTE: This function is thread-safe. 
    *  
    * @param tagDatabase   name and path of tag database to update 
    * @param fileName      name of buffer passed to list-tags function 
    * @param langId        language ID to parse file using 
    * @param taggingFlags  bitset of VSLTF_* 
    * 
    * @return 0 on success, <0 on error. 
    */
   int setListTagsFileInformation(const slickedit::SEString &tagDatabase,
                                  const slickedit::SEString &fileName,
                                  const slickedit::SEString &langId,
                                  unsigned int taggingFlags = 0);

   /**
    * Generic function for listing tags in the given file and language. 
    * You must first call getListTagsBufferInformation() or otherwise 
    * set up the context information, including the filename and language ID. 
    *  
    * return 0 on success, <0 on error. 
    */
   int doGenericListTags();

   /**
    * Return the full, absolute file path for the file being parsed.
    */
   const slickedit::SEString &getFileName() const;
   /**
    * Set the full, absolute file path for the file being parsed.
    */
   void setFileName(const slickedit::SEString &fileName);

   /**
    * Return the language ID for the tagging callback. 
    * <p> 
    * Because of tagging callback inheritance, this may not be the actual 
    * langauge ID, it may be the language ID of a parent language whose callback 
    * we are using. 
    */
   const slickedit::SEString &getLanguageId() const;
   /**
    * Set the language ID for the tagging callback.
    */
   void setLanguageId(const slickedit::SEString &langId);

   /**
    * Add the given file to the list of files which are 
    * considered as include files or sub-files but that were tagged
    * independently, so they should be factored out of the results 
    * when we updated tagging for this file. 
    */
   int addNestedFile(const slickedit::SEString &fileName);

   /**
    * Return the date of the file at the time it was parsed.
    */
   const VSINT64 getFileDate() const;
   /**
    * Set the date of the file at the time it was parsed. 
    * <p> 
    * The file date is a binary date string, as returned by p_file_date. 
    */
   void setFileDate(const VSINT64 fileDate);

   /**
    * Return the date of the file at the time it was last tagged.
    */
   const VSINT64 getTaggedDate() const;
   /**
    * Set the date of the file at the time it was last tagged. 
    * <p> 
    * The file date is a binary date string, as returned by p_file_date. 
    */
   void setTaggedDate(const VSINT64 fileDateInDatabase);

   /**
    * Return the buffer ID for the file being parsed.
    */
   const unsigned int getBufferId() const;
   /**
    * Save the buffer ID for the file being parsed.
    */
   void setBufferId(const unsigned int bufferId);

   /**
    * Return the generation counter indicating when the buffer was last modified 
    * at the time in which it was parsed. 
    */
   const unsigned int getBufferLastModified() const;
   /**
    * Save the generation counter indicating when the buffer was last modified 
    * at the time in which it was parsed. 
    */
   void setBufferLastModified(const unsigned int lastModified);

   /**
    * Return the buffer modify flags at the time in which it was parsed. 
    */
   const unsigned int getBufferModifyFlags() const;
   /**
    * Save the buffer modify flags at the time in which it was parsed. 
    */
   void setBufferModifyFlags(const unsigned int modifyFlags);

   /**
    * Set the file/buffer information for the file being parsed.
    */
   void setFileInformation( const slickedit::SEString &fileName,
                            const VSINT64 fileDate,
                            const unsigned int bufferId=0,
                            const unsigned int lastModified=0,
                            const unsigned int modifyFlags=0 );

   /**
    * Set the file encoding flag for loading this file buffer from disk. 
    * This should be one of VSENCODING_AUTO*, usually VSENCODING_AUTOXML. 
    */
   void setFileEncoding(int encoding);

   /**
    * Return the file contents which we are going to be parsing.
    */
   const slickedit::SEString &getFileContents() const;
   /**
    * Save the file contents for the buffer or file we will be parsing.
    */
   void setFileContents(const slickedit::SEString &fileContents);
   /**
    * Load the file contents from disk (for asynchronous parsing)
    */
   int loadFileContents();

   /**
    * Return the line number to start parsing at.
    */
   const unsigned int getParseStartLineNumber() const;
   /**
    * Set the line number to start parsing at.  Default is 0. 
    */
   void setParseStartLineNumber(const unsigned int lineNumber);

   /**
    * Return the seek position to start parsing at.
    */
   const unsigned int getParseStartSeekPosition() const;
   /**
    * Set the seek position to start parsing at.  Default is 0. 
    */
   void setParseStartSeekPosition(const unsigned int seekPos);

   /**
    * Set the seek position and line number to start parsing at. 
    */
   void setParseStartLocation(const unsigned int seekPos, const unsigned int lineNumber);

   /**
    * Return the line number to stop parsing at or near. 
    * The actual position the parse stops searching for locals at can 
    * vary depending on language specific scoping rules. 
    */
   const unsigned int getParseStopLineNumber() const;
   /**
    * Set the seek position to stop parsing at.  Default is 0, which 
    * means to parse to the end of the file. 
    */
   void setParseStopLineNumber(const unsigned int lineNumber);

   /**
    * Return the seek position to stop parsing at or near. 
    * The actual position the parse stops searching for locals at can 
    * vary depending on language specific scoping rules. 
    */
   const unsigned int getParseStopSeekPosition() const;
   /**
    * Set the seek position to stop parsing at.  Default is 0, which 
    * means to parse to the end of the file. 
    */
   void setParseStopSeekPosition(const unsigned int seekPos);

   /**
    * Set the seek position and line number to stop parsing at. 
    */
   void setParseStopLocation(const unsigned int seekPos, const unsigned int lineNumber);

   /**
    * Return the line number where the cursor is sitting when this local 
    * variable tagging job starts.
    */
   const unsigned int getParseCurrentLineNumber() const;
   /**
    * Set the line number where the cursor is sitting when this local 
    * variable tagging job starts.
    */
   void setParseCurrentLineNumber(const unsigned int lineNumber);

   /**
    * Return the seek position where the cursor is sitting when this local 
    * variable tagging job starts.
    */
   const unsigned int getParseCurrentSeekPosition() const;
   /**
    * Set the seek position where the cursor is sitting when this local 
    * variable tagging job starts.
    */
   void setParseCurrentSeekPosition(const unsigned int seekPos);

   /**
    * Set the seek position and line number where the cursor is 
    * sitting when this local variable tagging job starts.
    */
   void setParseCurrentLocation(const unsigned int seekPos, const unsigned int lineNumber);

   /**
    * Return the context ID of the symbol being parsed for local variables. 
    */
   const unsigned int getParseCurrentContextId() const;
   /**
    * Set the context ID of the symbol being parsed for local variables. 
    */
   void setParseCurrentContextId(const unsigned int contextId);

   /**
    * Return the tagging mode flags.  This is a bitset of the constants VSLTF_* 
    * <p> 
    * There are three general tagging modes possible: 
    * <ul> 
    *    <li><b>context</b>  -- load the tags and statement information for the current buffer
    *    <li><b>locals</b>   -- parse for local variables in the current function context
    *    <li><b>database</b> -- parse for tags and references to update the current buffer in the tag database
    * </ul> 
    */
   const unsigned int getTaggingFlags() const;
   /**
    * Set the tagging mode flags.  This is a bitset of the constants VSLTF_*
    * <p> 
    * There are three general tagging modes possible: 
    * <ul> 
    *    <li><b>context</b>  -- load the tags and statement information for the current buffer
    *    <li><b>locals</b>   -- parse for local variables in the current function context
    *    <li><b>database</b> -- parse for tags and references to update the current buffer in the tag database
    * </ul> 
    */
   void setTaggingFlags(const unsigned int ltfFlags);


   /**
    * Return the full, absolute file path to the tagging database to be updated.
    */
   const slickedit::SEString &getTagDatabase() const;
   /**
    * Return the full, absolute file path to the tagging database to be updated.
    */
   void setTagDatabase(const slickedit::SEString &fileName);

   /**
    * Return 'true' if the tagging target is to insert tags into a tag database.
    */
   bool isTargetDatabase() const;
   void setTargetDatabase();

   /**
    * Return 'true' if the tagging target is to update the tags found in 
    * the current file. 
    */
   bool isTargetContext() const;
   void setTargetContext();
   void setTargetStatements();

   /**
    * Return 'true' if the tagging target is to update the current list of 
    * local variables. 
    */
   bool isTargetLocals() const;
   void setTargetLocals();


   /**
    * Return 'true' if the tagging job is currently running. 
    */
   bool isTargetRunning() const;
   /**
    * Indicate that the target is being operated on by a thread. 
    */
   void setTargetRunning();
   /**
    * Indicate that the target is no longer being operated on by a thread
    */
   void setTargetIdle();
   /**
    * Return '1' if the tagging job is completely finished 
    * and the context, locals, statements, or tag database have also 
    * been updated (on the thread). 
    * <p> 
    * Return EMBEDDED_TAGGING_NOT_SUPPORTED_RC if the tagging job is 
    * not finished and the context, locals, or tag database still need 
    * to be updated synchronously.  This is typically because the file 
    * contains embedded code. 
    * <p> 
    * Return an error code <0 if the file can not be tagged in the 
    * background, either because it's language does not support background 
    * tagging, or because the file does not exist. 
    */
   int isUpdateFinished() const;
   /** 
    * Flag target to indicate that file corresponding to the tagging job 
    * is being read from disk.
    */
   void setFileReadingRunning();
   /** 
    * Flag target to indicate that file corresponding to the tagging job 
    * has been read from disk.
    */
   void setFileReadingFinished();
   /** 
    * Flag target to indicate that the parsing job has started running.
    */
   void setParsingRunning();
   /** 
    * Flag target to indicate that tagging job has finished 
    * parsing, but it still needs to insert tags in the database.
    */
   void setParsingFinished();
   /** 
    * Flag target to indicate that tagging job has started running.
    */
   void setTaggingRunning();
   /** 
    * Flag target to indicate that tagging job has completely finished.
    */
   void setTaggingFinished();
   /**
    * Return 'true' if the tagging job is completely finished. 
    */
   bool isTaggingFinished() const;
   /**
    * Flag target to indicate that the tagging job is completely finished, 
    * including updating the context, locals, statements, or tag database. 
    * <p> 
    * Pass in a FILE_NOT_FOUND_RC to indicate that the file does not exist 
    * and that it was removed from the tag file. 
    * <p> 
    * Pass in BACKGROUND_TAGGING_NOT_SUPPORTED_RC to indicate that the file does 
    * not support background tagging and needs to be tagged synchronously. 
    * <p> 
    * Pass in EMBEDDED_TAGGING_NOT_SUPPORTED_RC to indicate that the file 
    * has been parsed and contains embedded sections which need to be 
    * tagged synchronously. 
    * <p> 
    * Pass in a status < 0 to indicate that the file could not be tagged 
    * in the background. 
    */
   void setUpdateFinished(int status=1);

   /**
    * Indicate that a tagging remove was started for this file. 
    * At this time, this only effects tagging logging.
    */
   void setTaggingRemoveStarted();
   /**
    * Indicate that a tagging remove is finished for this file. 
    * At this time, this only effects tagging logging.
    */
   void setTaggingRemoveFinished(int status=0);

   /**
    * Set a specific message code for this job.  This is used to differentiate 
    * this job from others with the same filename and a different message code.
    */
   void setMessageCode(int status);
   /**
    * Return the specific message code for this job.
    */
   int getMessageCode() const;

   /**
    * Set a flag to indicate that this item is the last one to be finished 
    * in a multi-part tag file build. 
    */
   void setLastItemScheduled(bool isLastItem=true);
   /**
    * Is this tagging target the last item of a multi-part tag file build?
    */
   bool isLastItemScheduled() const;

   /**
    * Return 'true' if statement tagging is supported for this language.
    */
   bool isStatementTaggingSupported() const;
   /**
    * Return 'true' if local variable tagging is supported for this language.
    */
   bool isLocalTaggingSupported() const;
   /**
    * Flag target to indicate that statement tagging is supported for this language.
    */
   void setStatementTaggingSupported();
   /**
    * Flag target to indicate that local variable tagging is supported for this language.
    */
   void setLocalTaggingSupported();


   /**
    * If we are tagging the current context, return 'true' if statement-level 
    * tagging is enabled and we should insert tags for control statements. 
    */
   bool getStatementTaggingMode() const;

   /**
    * If we are inserting tags into a tag database, return 'true' if we need 
    * to list occurrences of identifiers for building the symbol cross-reference. 
    */
   bool getListOccurrencesMode() const;

   /**
    * Return 'true' if listing local variables and we should skip locals which 
    * have fallen out of scope per the language specific local variable 
    * scoping rules. 
    */
   bool getSkipOutOfScopeLocals() const;

   /**
    * Return 'true' if listing local variables and we need to start right 
    * from where the cursor is located rather than parsing from the beginning 
    * of a function. 
    */
   bool getStartLocalsInCode() const;

   /** 
    * Return 'true' if we are reading input data from a string rather than 
    * a file or an editor buffer. 
    */
   bool getReadFromStringMode() const;
   /** 
    * Return 'true' if we are reading input data from an editor control
    */
   bool getReadFromEditorMode() const;
   /** 
    * Return 'true' if we are reading input data from a file.
    */
   bool getReadFromFileMode() const;

   /**
    * Return 'true' if the tagging information is being updated asynchronously. 
    */
   const bool getAsynchronousMode() const;
   /**
    * Turn on asynchronous tagging.  This can only be done as an initial setup, 
    * not after parsing and tagging has already started. 
    */
   void setAsynchronousMode(const bool async);

   /**
    * Parse the contents of the current file for tags. 
    * This will call the parsing callback function configured for this object. 
    */
   int parseFileForTags();

   /**
    * Typedef for type of the parsing function callback.
    */
   typedef int (*ParsingCallbackType)(slickedit::SEListTagsTarget &context);

   /**
    * Set a callback function for listing tags from the current file.
    */
   void setParsingCallback(ParsingCallbackType parseFun);
   /**
    * Check if we have a parsing callback for this target language. 
    * You must set the target language first. 
    */
   bool hasParsingCallback() const;
   static bool hasParsingCallback(const slickedit::SEString &langId);
   /**
    * Register a callback function for listing tags for the given language type.
    */
   static int registerParsingCallback(const char *langId, ParsingCallbackType parseFun); 
   /**
    * Clear out all parsing callbacks (this is done to reset the DLL).
    */
   static int clearRegisteredParsingCallbacks();

   /**
    * If tagging is writing to a tagging database, make sure the database 
    * is open for writing. 
    *  
    * @return 0 on success, <0 on error. 
    */
   int openTagDatabase();
   /**
    * Close the tag database (actually, just switch to read mode) after we are 
    * finished writing to an open tag database. 
    *  
    * @return 0 on success, <0 on error. 
    */
   int closeTagDatabase();

   /**
    * Merge the tagging information from the given file into this items 
    * tagging information. 
    * 
    * @param context 
    * 
    * @return 0 on success, <0 on error. 
    */
   int mergeTarget(const slickedit::SEListTagsTarget &context);

public:

   /**
    * Insert a tag into the list of tags collected.
    * <p> 
    * Depending on the tagging mode, and whether we are doing synchronous 
    * or asynchronous tagging, this will either insert an item into the current 
    * context, the locals, the tag database, or cache the information to be 
    * inserted synchronously into the database later.
    * 
    * @param tagInfo    symbol information to add to the context. 
    * 
    * @return >= 0 on success, <0 on error. 
    *         If tagging locals or the current context, this will return
    *         the context ID or local ID on success. 
    */
   int insertTag(const slickedit::SETagInformation &tagInfo);

   /**
    * Insert a tag into the list of tags collected.
    * <p> 
    * Depending on the tagging mode, and whether we are doing synchronous 
    * or asynchronous tagging, this will either insert an item into the current 
    * context, the locals, the tag database, or cache the information to be 
    * inserted synchronously into the database later.
    * 
    * @param tagName             symbol name
    * @param tagClass            current package and class name
    * @param tagType             type of symbol (VS_TAGTYPE_*)
    * @param tagFlags            tag flags (bitset of VS_TAGFLAG_*)
    * @param fileName            name of file being tagged 
    * @param startLineNumber     start line number        
    * @param startSeekPosition   start seek position      
    * @param nameLineNumber      name line number         
    * @param nameSeekPosition    name seek position       
    * @param scopeLineNumber     scope start line number  
    * @param scopeSeekPosition   scope start seek position
    * @param endLineNumber       end line number          
    * @param endSeekPosition     end seek position        
    * @param tagSignature        function return type and arguments
    * @param classParents        parents of class (inheritance)
    * @param templateSignature   template signature for template classes and functions
    * @param tagExceptions       function exceptions clause
    * 
    * @return >= 0 on success, <0 on error. 
    *         If tagging locals or the current context, this will return
    *         the context ID or local ID on success. 
    */
   int insertTag(const slickedit::SEString &tagName,
                 const slickedit::SEString &tagClass,
                 unsigned short tagType,
                 unsigned int tagFlags,
                 const slickedit::SEString &fileName,
                 unsigned int startLineNumber, unsigned int startSeekPosition,
                 unsigned int nameLineNumber,  unsigned int nameSeekPosition,
                 unsigned int scopeLineNumber, unsigned int scopeSeekPosition,
                 unsigned int endLineNumber,   unsigned int endSeekPosition,
                 const slickedit::SEString &tagSignature = (const char *)0,
                 const slickedit::SEString &classParents = (const char *)0,
                 const slickedit::SEString &templateSignature = (const char *)0, 
                 const slickedit::SEString &tagExceptions = (const char *)0 ); 

   /**
    * Returns negative status or error code if there was an error status 
    * returned by insertTag() when inserting tags into a tagging database. 
    */
   const int getInsertTagStatus() const;
   void setInsertTagStatus(const int status);

   /**
    * Insert an embedded code section found in the current tagging target.
    * 
    * @param startLineNumber  start line number of embedded section
    * @param startSeekPosition   start seek position      
    * @param endLineNumber    end line number of embedded section
    * @param endSeekPosition     end seek position        
    * @param fileName            name of file being tagged 
    * @param langId              language ID for embedded code 
    * @param parseOption         collate, tag later, tag now, or ignore? 
    * 
    * @return 0 on success, <0 on error. 
    */
   int insertEmbeddedSection(unsigned int startLineNumber,
                             unsigned int startSeekPosition,
                             unsigned int endLineNumber,
                             unsigned int endSeekPosition,
                             const slickedit::SEString &fileName,
                             const slickedit::SEString &langId = (const char *)0,
                             const SEEmbeddedTaggingOption parseOption = SE_EMBEDDED_COLLATE_AND_TAG);

   /**
    * @return Return the number of embedded sections in the current context.
    */
   size_t getNumEmbeddedSections() const;

   /**
    * @return Return the number of embedded sections in the current context.
    */
   size_t getNumUnparsedEmbeddedSections() const;


   /**
    * Returns info for the embedded section indexed by 'index'
    *  
    * @param index            index of embedded section 
    *                         [0..getNumEmbeddedSections()]
    * @param startLineNumber  start line number of embedded section
    * @param endLineNumber    end line number of embedded section
    * @param startSeekPosition start seek position
    * @param endSeekPosition  end seek position
    * @param langid           language ID for embedded code
    * @param parseOption      collate, tag, or ignore? 
    * @param taggingFinished  does this section still require tagging?
    */
   void getEmbeddedSectionInfo(size_t index,
                               unsigned int& startLineNumber,
                               unsigned int& endLineNumber,
                               unsigned int& startSeekPosition,
                               unsigned int& endSeekPosition,
                               slickedit::SEString& langid,
                               SEEmbeddedTaggingOption &parseOption,
                               bool &taggingFinished);

   /**
    * Insert information about the date of an included file. 
    * 
    * @param fileName         name of file to insert file date information for
    * @param fileDate         date of the file (17 character string)
    * @param parentFileName   name of source file this was included by
    * @param fileType         type of file (include, source, or references)
    * 
    * @return 0 on success, <0 on error. 
    */
   int insertFileDate(const slickedit::SEString &fileName,
                      const VSINT64 fileDate,
                      const slickedit::SEString &parentFileName,
                      unsigned int fileType=VS_FILETYPE_include);

   /**
    * Return 'true' if this tagging target should stop parsing now 
    * because the tagging job was cancelled. 
    */
   bool isTargetCancelled() const;
   /**
    * Indicate that tagging needs to be stopped because we are aborting 
    * this tagging operation. 
    */
   void cancelTarget();

   /**
    * Turn on tagging logging for this item.
    */
   void enableTaggingLogging();

   /**
    * Return 'true' if tagging logging is turned on.
    */
   bool isTaggingLogging() const;

   /**
    * Returns 'true' if the tagging should allow dupliate global 
    * declarations (variables with the same name in the same scope). 
    * <p> 
    * If this option is disabled, then only the first variable with a 
    * unique name will be retained. 
    */
   const bool allowDuplicateGlobalVariables() const;
   void setAllowDuplicateGlobalVariables(const bool onOff);

   /**
    * Returns 'true' if the tagging should allow dupliate local 
    * declarations (local variables with the same name). 
    * <p> 
    * If this option is disabled, then only the first variable with a 
    * unique name will be retained. 
    */
   const bool allowDuplicateLocalVariables() const;
   void setAllowDuplicateLocalVariables(const bool onOff);

   /**
    * Set's the last local variable ID.
    */
   void setLastLocalVariableId(unsigned int localId);

   /**
    * Add the given identifier to the list of identifiers
    * 
    * @return 0 on success, <0 on error.
    */
   int insertIdOccurrence(const slickedit::SEString &idName);
   int insertIdOccurrence(const slickedit::SEString &idName, const slickedit::SEString &fileName);


   /**
    * Some symbols need to be inserted before they are entirely parsed, in which 
    * case, we will need to stack them up and then adjust their end positions 
    * when we are done parsing them.  This call indicates that the given symbol 
    * still needs and ending seek position to be set later. 
    * 
    * @param contextId  ID of symbol to push onto context stack. 
    */
   int pushContext(int contextId);
   /**
    * After a symbol has been pushed onto the symbol stack, when we are done 
    * parsing it and we know it's end location, we call popContext() to patch 
    * in the end location and complete the symbol. 
    * 
    * @param endLineNumber       end line number          
    * @param endSeekPosition     end seek position        
    */
   void popContext(unsigned int endLineNumber, unsigned int endSeekPosition);
   /**
    * If we need to adjust the end seek position of a specific context item 
    * which was not pushed onto the context stack, we can do it using this 
    * function.  This only applies in the context and locals modes of tagging. 
    *  
    * @param contextId           ID of symbol already inserted
    * @param endLineNumber       end line number          
    * @param endSeekPosition     end seek position        
    */
   void endContext(int contextId, 
                   unsigned int endLineNumber, 
                   unsigned int endSeekPosition);

   /**
    * Some preprocessing statementss need to be inserted before they are entirely 
    * parsed, in which case, we will need to stack them up and then adjust their 
    * end positions when we are done parsing them.  This call indicates that the 
    * given preprocessing statement still needs and ending seek position. 
    * 
    * @param contextId  ID of preprocessing statement to push onto context stack. 
    */
   int pushPPContext(int contextId);
   /**
    * After a preprocessing statement has been pushed onto the symbol stack, when 
    * we are done parsing it and we know it's end location, we call popPPContext() 
    * to patch in the end location and complete the statement. 
    * 
    * @param endLineNumber       end line number          
    * @param endSeekPosition     end seek position        
    */
   void popPPContext(unsigned int endLineNumber, unsigned int endSeekPosition);

   /**
    * Push the local variable scope onto the stack.  This allows us to capitate 
    * off local variables when they go out of scope. 
    */
   int pushLocals();
   /**
    * Pop the local variable scope from the stack.  If we are skipping out of 
    * scope variables, all the variables inserted since the last pushLocals() 
    * will be removed from the local variable list. 
    */
   void popLocals();

   /**
    * Set the class inheritance information for the given class name.
    * 
    * @param className        name of class to save class inheritance information for     
    * @param classNarents     list of parent classes to store for this class
    * 
    * @return 0 on success, <0 on error. 
    */
   int setClassInheritance(const slickedit::SEString &className, 
                           const slickedit::SEString &classParents);

   /**
    * Set the type signature for the given symbol.
    * 
    * @param tagName         name of variable to modify
    * @param typeName        type signature of the local item 
    * @param caseSensitive   use case-sensitive search to find tag name? 
    * 
    * @return 0 on success, <0 on error. 
    */
   int setTypeSignature(const slickedit::SEString &tagName, 
                        const slickedit::SEString &typeName,
                        bool caseSensitive=false);

   /**
    * Start parsing a statement. 
    *  
    * @param tagType       tag type of statement (VS_TAGTYPE_*) 
    * @param tokenType     language specific token associated with statement 
    * @param lineNumber    start line number        
    * @param seekPosition  start seek position      
    */
   int startStatement(int tagType, int tokenType,
                      int lineNumber, int seekPosition);
   
   /**
    * Return the depth of the statement parsing stack. 
    */
   size_t getStatementStackDepth() const;

   /**
    * Returns the token type of the topmost statement on the statement stack. 
    * i.e. FOR_TLTK
    * 
    * @param depth   default is to get the one on top of the stack 
    */
   unsigned int getStatementToken(size_t depth=0) const;
   /**
    * Set the token type for the topmost statement on the statement stack.
    * i.e. FOR_TLTK
    * 
    * @param tokenType  language specific token associated with statement 
    */
   void setStatementToken(unsigned int tokenType);

   /**
    * Return the type of statement tag (VS_TAGTYPE_*) 
    * for a statement on the statement stack. 
    *  
    * @param depth   default is to get the one on top of the stack 
    */
   int getStatementTagType(size_t depth=0) const;
   /**
    * Set the type of statement tag (VS_TAGTYPE_*) 
    * for the topmost statement on the statement stack. 
    * 
    * @param tag_type 
    */
   void setStatementTagType(int tagType);
   
   /**
    * Append text to the topmost statement on the statement stack.
    */
   void setStatementString(const slickedit::SEString& str);
   /**
    * Append text to the topmost statement on the statement stack.
    */
   void appendStatementString(const slickedit::SEString& str);
   
   /**
    * Save the statement start location for the topmost statement on 
    * the statement stack. 
    * 
    * @param lineNumber    start line number        
    * @param seekPosition  start seek position      
    */
   void setStatementStartLocation(int lineNumber, int seekPosition);
   
   /**
    * Save the statement scope start location for the topmost statement on 
    * the statement stack. 
    * 
    * @param lineNumber    scope line number        
    * @param seekPosition  scope seek position      
    */
   void setStatementScopeLocation(int lineNumber, int seekPosition);
   
   /**
    * Set the end of the statement at the top of the stack to the 
    * given location and then call insertTag and pop this statement 
    * off the stack. 
    * 
    * @param lineNumber    scope line number        
    * @param seekPosition  scope seek position      
    */
   void finishStatement(int lineNumber, int seekPosition);

   /**
    * Cancel parsing and tagging the topmost statement and 
    * pop it off of the stateement stack.
    */
   void cancelStatement();
   
   
   /**
    * Clear all statement labels inserted during local variable search.
    */
   void clearStatementLabels();

   /**
    * Insert a statement label.  Used only during local variable search. 
    *  
    * @param labelName 
    * @param startLineNumber     start line number        
    * @param startSeekPosition   start seek position      
    * @param nameLineNumber      name line number         
    * @param nameSeekPosition    name seek position       
    * @param endLineNumber       end line number          
    * @param endSeekPosition     end seek position        
    */
   int insertStatementLabel(const slickedit::SEString &labelName,
                            const slickedit::SEString &fileName,
                            unsigned int startLineNumber, unsigned int startSeekPosition,
                            unsigned int nameLineNumber,  unsigned int nameSeekPosition,
                            unsigned int endLineNumber,   unsigned int endSeekPosition);

   /**
    * Insert all the statement labels found during local variable search. 
    * Statement labels may operate outside of the normal scoping rules. 
    * This is why they can not be treated the same way that local variables 
    * are handled. 
    */
   void insertAllStatementLabels();

   /**
    * Sort the list of tags by seek position.
    */
   int sortAsynchronousTags();

   /**
    * Insert all the tags which were cached to be inserted later asynchrounously. 
    */
   int insertAsynchronousTags(bool (*pfnIsCancelled)(void* data)=NULL, void *userData=NULL) const;
   int insertAsynchronousTagsInDatabase(bool (*pfnIsCancelled)(void* data)=NULL, void *userData=NULL) const;
   int insertAsynchronousTagsInContext(bool (*pfnIsCancelled)(void* data)=NULL, void *userData=NULL) const;
   int insertAsynchronousTagsInLocals(bool (*pfnIsCancelled)(void* data)=NULL, void *userData=NULL) const;

   /**
    * Clear all the tags which were cached to be inserted later asynchronously.
    */
   void clearAsynchronousTags();

protected:

   /**
    * Release our lock on the database and let other threads use it temporarily.
    * 
    * @param dbHandle   (in/out) database handle  
    * @param startTime  (in/out) start time in ms
    * @param timeSlice  (in) time slice to check
    * 
    * @return 0 on success, <0 on error or cancellation
    */
   int yieldDatabaseAndCheckForCancel(int &dbHandle, 
                                      size_t &startTime, size_t timeSlice,
                                      bool (*pfnIsCancelled)(void* data) = NULL, 
                                      void *userData = NULL,
                                      bool isClonedWriterDB = false) const;
      
   /**
    * Information about embedded code blocks.
    */
   struct EmbeddedSectionInformation {
      slickedit::SEString mFileName;
      slickedit::SEString mLanguageId;
      unsigned int mStartSeekPosition;
      unsigned int mEndSeekPosition;
      unsigned int mStartLineNumber;
      unsigned int mEndLineNumber;
      SEEmbeddedTaggingOption mParseOption;
      bool mTaggingFinished;
   };

   /**
    * Parse the embedded sections that we can parse directly.
    * 
    * @return 0 on success, <0 on error
    */
   int parseEmbeddedSections();

   /**
    * Parse one embedded section. 
    *  
    * @param sect          embedded section to parse
    * @param embeddedText  text found in this section
    * 
    * @return 0 on success, <0 on error
    */
   int parseEmbeddedText(struct SEListTagsTarget::EmbeddedSectionInformation &sect,
                         const slickedit::SEString &embeddedText);

private:

   /**
    * Name of the source file being tagged.
    */
   slickedit::SEString mFileName;

   /**
    * Name of the language ID corresponding to the tagging callback being called. 
    * Because of tagging callback inheritance, this may not be the actual 
    * langauge ID, it may be the language ID of a parent language whose callback 
    * we are using. 
    */
   slickedit::SEString mLanguageId;

   /**
    * File date or buffer date for the source file being tagged, if applicable.
    */
   VSINT64 mFileDate;

   /**
    * File date or buffer date for the source file the last time it was tagged.
    */
   VSINT64 mTaggedDate;

   /**
    * File encoding
    */
   int mFileEncoding;

   /**
    * File contents.
    */
   slickedit::SEString mFileContents;

   /**
    * Buffer ID for the source file being tagged, if applicable.
    */
   unsigned int mBufferId;

   /**
    * Last modified time stamp for buffers.
    */
   unsigned int mLastModified;
   /**
    * Modify flags for buffer at time tagging job is started
    */
   unsigned int mModifyFlags;

   /**
    * Line number to start parsing at.
    */
   unsigned int mStartLineNumber;
   /**
    * Seek position to start parsing at.
    */
   unsigned int mStartSeekPosition;
   /**
    * Line number to stop parsing at or around depending on language 
    * specific scoping rules. 
    */
   unsigned int mStopLineNumber;
   /**
    * Seek position to stop parsing at or around depending on language 
    * specific scoping rules. 
    */
   unsigned int mStopSeekPosition;
   /**
    * Current line number that the cursor is sitting at when tagging is started. 
    */
   unsigned int mCurrentLineNumber;
   /**
    * Current seek position that the cursor is sitting at when tagging is started. 
    */
   unsigned int mCurrentSeekPosition;
   /**
    * Context ID for the symbol being parsed for local variables.
    */
   unsigned int mCurrentContextId;

   /**
    * Indicates that a thread is currently processing this tagging target.
    * 
    * @author dbrueni (5/23/2011)
    */
   bool mTargetRunning;

   /**
    * Indicates if the tagging job is currently running or already finished
    */
   enum SETargetRunState {
      TAGGING_TARGET_QUEUED_FILE,
      TAGGING_TARGET_READING_FILE,
      TAGGING_TARGET_READING_DONE,
      TAGGING_TARGET_PARSING_FILE,
      TAGGING_TARGET_PARSING_DONE,
      TAGGING_TARGET_INSERTING_TAGS,
      TAGGING_TARGET_INSERTING_DONE,
      TAGGING_TARGET_UPDATED_FINISHED
   };
   SETargetRunState mTaggingState;

   /**
    * Indicates if we should log progess with tagging this item
    */
   bool mDoTaggingLogging;

   /**
    * Indicates the status of the tagging job after it is completely finished.
    */
   int mUpdateFinished;
   /**
    * Contains the error message code if the tagging job failed.
    */
   int mMessageCode;

   /**
    * Was this the last item scheduled for a tag file? 
    * If so, then after processing it, we should send a message to indicate 
    * that the tag file is done building. 
    */
   bool mLastItemScheduled;

   /**
    * Indicates if statement tagging or local variable tagging is support for 
    * this language. 
    */
   bool mStatementTaggingSupported;
   bool mLocalTaggingSupported;

   /**
    * Contains value < 0 if there was an error inserting tags into the tagging database.
    */
   int mInsertTagStatus;
   /**
    * Set to true if tagging should be terminated immediately.  This is used 
    * to terminate a background thread. 
    */
   bool mStopTagging;

   /**
    * ALlow dupliate global variable declarations?
    */
   bool mAllowDuplicateGlobalVariables;
   /**
    * Allow duplicate local variable declarations?
    */
   bool mAllowDuplicateLocalVariables;

   /**
    * Tagging mode flags: locals, context, or database update? 
    * Bitset of VSLTF_* 
    */
   unsigned int mTaggingFlags;

   /**
    * The full, absolute file path for the tag database being updated 
    * in the case that we are updating a tagging database and not just 
    * the current context or locals variables. 
    */
   slickedit::SEString mTagDatabase;

   /**
    * Parsing callback.  This is called to do the actual parsing 
    * of the data configured to be parsed by this item. 
    */
   int (*mParseFunction)(slickedit::SEListTagsTarget &context);
   
   /**
    * Array of context items to save when we are tagging asynchronously 
    * in order to delay actually inserting in the database or current context. 
    */
   slickedit::SEArray<slickedit::SETagInformation> *mTags;

   /**
    * Hash set of global variables inserted thus far. 
    * Used to filter out dupliate declarations or implicit declarations. 
    */
   slickedit::SEHashSet<slickedit::SEString> *mGlobalVariableNames;

   /**
    * Hash set of locals variables inserted thus far. 
    * Used to filter out dupliate declarations or implicit declarations. 
    */
   slickedit::SEHashSet<slickedit::SEString> *mLocalVariableNames;

   /**
    * Set of identifiers found in this source file.  This is used for building 
    * the symbol cross reference when inserting tags into the tagging database. 
    * <p> 
    * The table is indexed by mapping file names to sets of identifiers. 
    */
   slickedit::SEStringTable<slickedit::SEStringSet> *mReferences;

   /**
    * Set of class names mapped to the list of parent classes.
    */
   slickedit::SEHashTable<slickedit::SEString, slickedit::SEString> *mInheritances;

   /**
    * Set of tag names mapped to the type signatures for those classes.
    */
   slickedit::SEHashTable<slickedit::SEString, slickedit::SEString> *mTypeSignatures;
   bool mTypeSignaturesCaseSensitive;

   /**
    * Stack of context ID's for updating context information.
    */
   slickedit::SEStack<int> *mContextIdStack;

   /**
    * Stack of context ID's for updating context information for preprocessing 
    * statements, which can follow a different thread of nesting from regular 
    * statements. 
    */
   slickedit::SEStack<int> *mContextPPStack;

   /**
    * Used for tracking the last local variable inserted.
    */
   int mLastLocalVariableId;

   /**
    * Stack of token ID's associated with statements
    */
   slickedit::SEStack<int> *mStatementTokenStack;
   /**
    * Stack of statements being tagged.
    */
   slickedit::SEStack<slickedit::SETagInformation> *mStatementStack;

   /**
    * List of statement labels found during local variable parsing.
    */
   slickedit::SEArray<slickedit::SETagInformation> *mStatementLabels;

   /**
    * List of embedded sections:
    */
   slickedit::SEArray<EmbeddedSectionInformation> *mEmbeddedSections;

   /**
    * Information about file dates
    */
   struct FileDateInformation {
      slickedit::SEString mFileName;
      VSINT64 mFileDate;
      slickedit::SEString mParentFile;
      unsigned int mFileType;
   };
   /**
    * List of file dates saved for include files.
    */
   slickedit::SEArray<FileDateInformation> *mFileDateInfo;

   /**
    * List of nested (or included) files which were parsed 
    * separately.
    */
   slickedit::SEStringSet *mNestedFiles;

};


inline const slickedit::SEString & slickedit::SEListTagsTarget::getFileName() const 
{
   return mFileName;
}

inline void slickedit::SEListTagsTarget::setFileName(const slickedit::SEString &fileName) 
{
   mFileName = fileName;
}

inline const slickedit::SEString & slickedit::SEListTagsTarget::getLanguageId() const 
{
   return mLanguageId;
}

inline void slickedit::SEListTagsTarget::setLanguageId(const slickedit::SEString &langId) 
{
   mLanguageId = langId;
}

inline const VSINT64 slickedit::SEListTagsTarget::getFileDate() const 
{
   return mFileDate;
}

inline void slickedit::SEListTagsTarget::setFileDate(VSINT64 fileDate) 
{
   mFileDate = fileDate;
}

inline const VSINT64 slickedit::SEListTagsTarget::getTaggedDate() const 
{
   return mTaggedDate;
}

inline void slickedit::SEListTagsTarget::setTaggedDate(const VSINT64 fileDateInDatabase) 
{
   mTaggedDate = fileDateInDatabase;
}

inline const slickedit::SEString & slickedit::SEListTagsTarget::getFileContents() const 
{
   return mFileContents;
}

inline void slickedit::SEListTagsTarget::setFileContents(const slickedit::SEString &fileContents) 
{
   mFileContents = fileContents;
   mFileContents.breakLinkToExternalBuffer();
}

inline const unsigned int slickedit::SEListTagsTarget::getBufferId() const 
{
   return mBufferId;
}

inline void slickedit::SEListTagsTarget::setBufferId(const unsigned int bufferId) 
{
   mBufferId = bufferId;
}

inline const unsigned int slickedit::SEListTagsTarget::getBufferLastModified() const 
{
   return mLastModified;
}

inline void slickedit::SEListTagsTarget::setBufferLastModified(const unsigned int lastModified) 
{
   mLastModified = lastModified;
}

inline const unsigned int slickedit::SEListTagsTarget::getBufferModifyFlags() const 
{
   return mModifyFlags;
}

inline void slickedit::SEListTagsTarget::setBufferModifyFlags(const unsigned int modifyFlags) 
{
   mModifyFlags = modifyFlags;
}

inline const unsigned int slickedit::SEListTagsTarget::getParseStartLineNumber() const
{
   return mStartLineNumber;
}
inline void slickedit::SEListTagsTarget::setParseStartLineNumber(const unsigned int lineNumber)
{
   mStartLineNumber = lineNumber;
}
inline const unsigned int slickedit::SEListTagsTarget::getParseStartSeekPosition() const
{
   return mStartSeekPosition;
}
inline void slickedit::SEListTagsTarget::setParseStartSeekPosition(const unsigned int seekPos)
{
   mStartSeekPosition = seekPos;
}
inline void slickedit::SEListTagsTarget::setParseStartLocation(const unsigned int seekPos, const unsigned int lineNumber)
{
   mStartSeekPosition = seekPos;
   mStartLineNumber = lineNumber;
}

inline const unsigned int slickedit::SEListTagsTarget::getParseStopLineNumber() const
{
   return mStopLineNumber;
}
inline void slickedit::SEListTagsTarget::setParseStopLineNumber(const unsigned int lineNumber)
{
   mStopLineNumber = lineNumber;
}
inline const unsigned int slickedit::SEListTagsTarget::getParseStopSeekPosition() const
{
   return mStopSeekPosition;
}
inline void slickedit::SEListTagsTarget::setParseStopSeekPosition(const unsigned int seekPos)
{
   mStopSeekPosition = seekPos;
}
inline void slickedit::SEListTagsTarget::setParseStopLocation(const unsigned int seekPos, const unsigned int lineNumber)
{
   mStopSeekPosition = seekPos;
   mStopLineNumber = lineNumber;
}

inline const unsigned int slickedit::SEListTagsTarget::getParseCurrentLineNumber() const
{
   return mCurrentLineNumber;
}
inline void slickedit::SEListTagsTarget::setParseCurrentLineNumber(const unsigned int lineNumber)
{
   mCurrentLineNumber = lineNumber;
}

inline const unsigned int slickedit::SEListTagsTarget::getParseCurrentSeekPosition() const
{
   return mCurrentSeekPosition;
}
inline void slickedit::SEListTagsTarget::setParseCurrentSeekPosition(const unsigned int seekPos)
{
   mCurrentSeekPosition = seekPos;
}

inline void slickedit::SEListTagsTarget::setParseCurrentLocation(const unsigned int seekPos, const unsigned int lineNumber)
{
   mCurrentSeekPosition = seekPos;
   mCurrentLineNumber = lineNumber;
}

inline const unsigned int slickedit::SEListTagsTarget::getParseCurrentContextId() const
{
   return mCurrentContextId;
}
inline void slickedit::SEListTagsTarget::setParseCurrentContextId(const unsigned int contextId)
{
   mCurrentContextId = contextId;
}

inline const unsigned int slickedit::SEListTagsTarget::getTaggingFlags() const 
{
   return mTaggingFlags;
}

inline void slickedit::SEListTagsTarget::setTaggingFlags(const unsigned int ltfFlags) 
{
   mTaggingFlags = ltfFlags;
}

inline bool slickedit::SEListTagsTarget::isStatementTaggingSupported() const
{
   return mStatementTaggingSupported;
}
inline bool slickedit::SEListTagsTarget::isLocalTaggingSupported() const
{
   return mLocalTaggingSupported;
}
inline void slickedit::SEListTagsTarget::setStatementTaggingSupported()
{
   mStatementTaggingSupported = true;
}
inline void slickedit::SEListTagsTarget::setLocalTaggingSupported()
{
   mLocalTaggingSupported = true;
}

inline bool slickedit::SEListTagsTarget::isTargetLocals() const 
{
   return (mTaggingFlags & VSLTF_LIST_LOCALS) != 0;
}
inline bool slickedit::SEListTagsTarget::isTargetContext() const 
{
   return (mTaggingFlags & (VSLTF_SET_TAG_CONTEXT|VSLTF_LIST_LOCALS)) == VSLTF_SET_TAG_CONTEXT;
}
inline bool slickedit::SEListTagsTarget::isTargetDatabase() const 
{
   return (mTaggingFlags & (VSLTF_LIST_LOCALS|VSLTF_SET_TAG_CONTEXT)) == 0;
}

inline void slickedit::SEListTagsTarget::setTargetLocals()
{
   mTaggingFlags |= VSLTF_LIST_LOCALS;
   //mTaggingFlags |= VSLTF_SKIP_OUT_OF_SCOPE;
}
inline void slickedit::SEListTagsTarget::setTargetContext()
{
   mTaggingFlags &= ~VSLTF_LIST_LOCALS;
   mTaggingFlags |= VSLTF_SET_TAG_CONTEXT;
}
inline void slickedit::SEListTagsTarget::setTargetStatements()
{
   mTaggingFlags &= ~VSLTF_LIST_LOCALS;
   mTaggingFlags |= VSLTF_SET_TAG_CONTEXT;
   mTaggingFlags |= VSLTF_LIST_STATEMENTS;
}
inline void slickedit::SEListTagsTarget::setTargetDatabase()
{
   mTaggingFlags &= ~VSLTF_LIST_LOCALS;
   mTaggingFlags &= ~VSLTF_SET_TAG_CONTEXT;
}

inline bool slickedit::SEListTagsTarget::getStatementTaggingMode() const 
{
   return (mTaggingFlags & VSLTF_LIST_STATEMENTS) != 0;
}
inline bool slickedit::SEListTagsTarget::getListOccurrencesMode() const 
{
   return (mTaggingFlags & VSLTF_LIST_OCCURRENCES) != 0;
}

inline bool slickedit::SEListTagsTarget::getSkipOutOfScopeLocals() const 
{
   return (mTaggingFlags & VSLTF_SKIP_OUT_OF_SCOPE) != 0;
}
inline bool slickedit::SEListTagsTarget::getStartLocalsInCode() const 
{
   return (mTaggingFlags & VSLTF_START_LOCALS_IN_CODE) != 0;
}

inline bool slickedit::SEListTagsTarget::getReadFromStringMode() const 
{
   return (mTaggingFlags & VSLTF_READ_FROM_STRING) != 0;
}
inline bool slickedit::SEListTagsTarget::getReadFromEditorMode() const 
{
   return (mTaggingFlags & VSLTF_READ_FROM_EDITOR) != 0;
}
inline bool slickedit::SEListTagsTarget::getReadFromFileMode() const 
{
   return (mTaggingFlags & (VSLTF_READ_FROM_EDITOR|VSLTF_READ_FROM_STRING)) == 0;
}

inline const bool slickedit::SEListTagsTarget::getAsynchronousMode() const 
{
   return (mTaggingFlags & VSLTF_ASYNCHRONOUS) != 0;
}
inline void slickedit::SEListTagsTarget::setAsynchronousMode(const bool async) 
{
   if (async) {
      mTaggingFlags |= VSLTF_ASYNCHRONOUS;
   } else {
      mTaggingFlags &= ~VSLTF_ASYNCHRONOUS;
   }
}

inline const slickedit::SEString &slickedit::SEListTagsTarget::getTagDatabase() const
{
   return mTagDatabase;
}
inline void slickedit::SEListTagsTarget::setTagDatabase(const slickedit::SEString &fileName)
{
   mTagDatabase = fileName;
}

inline const int slickedit::SEListTagsTarget::getInsertTagStatus() const
{
   return mInsertTagStatus;
}
inline void slickedit::SEListTagsTarget::setInsertTagStatus(const int status)
{
   mInsertTagStatus = status;
}

inline bool slickedit::SEListTagsTarget::isTargetCancelled() const
{
   return mStopTagging;
}
inline void slickedit::SEListTagsTarget::cancelTarget()
{
   mStopTagging = true;
}

inline void slickedit::SEListTagsTarget::enableTaggingLogging()
{
   mDoTaggingLogging = true;
}

inline bool slickedit::SEListTagsTarget::isTaggingLogging() const
{
   return mDoTaggingLogging;
}

inline const bool slickedit::SEListTagsTarget::allowDuplicateGlobalVariables() const
{
   return mAllowDuplicateGlobalVariables;
}
inline void slickedit::SEListTagsTarget::setAllowDuplicateGlobalVariables(const bool onOff)
{
   mAllowDuplicateGlobalVariables = onOff;
}
inline const bool slickedit::SEListTagsTarget::allowDuplicateLocalVariables() const
{
   return mAllowDuplicateLocalVariables;
}
inline void slickedit::SEListTagsTarget::setAllowDuplicateLocalVariables(const bool onOff)
{
   mAllowDuplicateLocalVariables = onOff;
}

inline void slickedit::SEListTagsTarget::setLastLocalVariableId(unsigned int localId)
{
   mLastLocalVariableId = localId;
}

inline void slickedit::SEListTagsTarget::setParsingCallback(ParsingCallbackType parseFun)
{
   mParseFunction = parseFun;
}

inline void slickedit::SEListTagsTarget::setFileEncoding(int encoding)
{
   mFileEncoding = encoding;
}


EXTERN_C
int VSAPI SETagCheckCachedContext(const slickedit::SEListTagsTarget &context);

EXTERN_C int VSAPI
SETagCheckCachedLocals(const slickedit::SEListTagsTarget &context, int contextId);

}

#endif // SLICKEDIT_LIST_TAGS_TARGET_H

