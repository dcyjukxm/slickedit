////////////////////////////////////////////////////////////////////////////////////
// $Revision: 38578 $
////////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 SlickEdit Inc.
////////////////////////////////////////////////////////////////////////////////////
#ifndef SLICKEDIT_TAG_INFORMATION_H
#define SLICKEDIT_TAG_INFORMATION_H

#include "vsdecl.h"
#include "slickedit/SEString.h"
#include "slickedit/SEHashSet.h"

namespace slickedit {

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
class VSDLLEXPORT SETagInformation : public SEMemory 
{
public:
   /**
    * Default constructor
    */
   SETagInformation();

   /**
    * Simple constructor
    */
   SETagInformation(const slickedit::SEString &tagName, 
                    const slickedit::SEString &tagClass, 
                    unsigned short tagType,
                    unsigned int tagFlags=0);

   /**
    * All information constructor 
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
    */
   SETagInformation( const slickedit::SEString &tagName,
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
    * Copy constructor
    */
   SETagInformation(const SETagInformation& src);

   /**
    * Destructor
    */
   virtual ~SETagInformation();

   /**
    * Assignment operator
    */
   SETagInformation &operator = (const SETagInformation &src);

   /**
    * Comparison operators
    */
   bool operator == (const SETagInformation &src) const;
   bool operator != (const SETagInformation &src) const;
   bool operator <  (const SETagInformation &src) const;
   bool operator <= (const SETagInformation &src) const;
   bool operator >  (const SETagInformation &src) const;
   bool operator >= (const SETagInformation &src) const;

   /**
    * Hash function,used by SEHashSet
    */
   unsigned int hash() const;

   /**
    * Compare two tags for file-position independent equality 
    * (including all fields except line numbers and seek positions). 
    * <p> 
    * It also does not compare language ID, tag file name, 
    * and the tag flags set. 
    */
   static int compareExceptLocations(const SETagInformation &lhs, const SETagInformation &rhs);

   /**
    * Clear the contents of this symbol.
    */
   void clear();

   /**
    * Compare two tag information objects by seek position and containment.
    * 
    * @param c1 
    * @param c2 
    */
   static int compareTags(const SETagInformation *c1, const SETagInformation *c2);

   /**
    * Get symbol tag name
    */
   const slickedit::SEString &getTagName() const;
   /**
    * Set symbol tag name 
    */
   void setTagName(const slickedit::SEString &tagName);
   /**
    * Append text to the tag name, typically used for statement tagging.
    */
   void appendTagName(const slickedit::SEString &str);
   
   /**
    * Get the symbol class and namespace name
    */
   const slickedit::SEString &getClassName() const;
   /**
    * Set the symbol class and namespace name
    */
   void setClassName(const slickedit::SEString &className);
   /**
    * Get just the package name part of the class name 
    */
   const slickedit::SEString getPackageNameOnly() const;
   /**
    * Get just the class name part of the class name
    */
   const slickedit::SEString getClassNameOnly() const;

   /**
    * Get the symbol tag type VS_TAGTYPE_*
    */
   unsigned int getTagType() const;
   /**
    * Get the symbol string associatated with the given tag type
    */
   const char *getTagTypeName() const;
   /**
    * Set the symbol tag type
    */
   void setTagType(unsigned short tagType);
   void setTagType(const char *typeName);
   /**
    * Is this a statement tag?
    */
   bool isStatementType() const;
   /**
    * Is the given type a statement tag?
    */
   static bool isStatementType(unsigned short tagType);

   /**
    * Get the symbol tag flags, which are a bitset of VS_TAGFLAG_*
    */
   unsigned int getTagFlags() const;
   /**
    * Set the symbol tag flags, which are a bitset of VS_TAGFLAG_*
    */
   void setTagFlags(unsigned int tagFlags);
   /**
    * Set the given tag flags if they are not already set (OR them in to bitset).
    */
   void addTagFlags(unsigned int tagFlags);
   /**
    * Unset the given tag flags if they are set (NAND them out of bitset).
    */
   void removeTagFlags(unsigned int tagFlags);

   /**
    * Set general symbol information
    */
   void setSymbolInformation(const slickedit::SEString &tagName, 
                             const slickedit::SEString &tagClass, 
                             unsigned short tagType,
                             unsigned int tagFlags=0,
                             const slickedit::SEString &tagSignature = (const char *)0);

   /**
    * Return the ID of the symbol which encloses this symbol. 
    * This only applies to locals and the current context. 
    */
   int getContextId() const;
   /**
    * Set the ID of the symbol which encloses this symbol.
    * This only applies to locals and the current context. 
    */
   void setContextId(int contextId);

   /**
    * Return the file name which this symbol belongs to. 
    * <p> 
    * Note that a file name can have multiple parts, an originating file, 
    * and a current file. 
    */
   const slickedit::SEString &getFileName() const;
   /**
    * Set the file name which this symbol belongs to.
    * <p> 
    * Note that a file name can have multiple parts, an originating file, 
    * and a current file. 
    */
   void setFileName(const slickedit::SEString &fileName);

   /**
    * Return the language ID for the source code this symbol is in.
    */
   const slickedit::SEString &getLanguageId() const;
   /**
    * Set the language ID for the source code this symbol is in.
    */
   void setLanguageId(const slickedit::SEString &langId); 

   /**
    * Get the start seek position of this symbol 
    */
   unsigned int getStartSeekPosition() const;
   /**
    * Get the start line number of this symbol
    */
   unsigned int getStartLineNumber() const;
   /**
    * Set the start location for this symbol 
    */
   void setStartLocation(unsigned int seekPosition, unsigned int lineNumber);
                                                       
   /**
    * Get the seek position of the name of this symbol
    */
   unsigned int getNameSeekPosition() const;
   /**
    * Get the line number where the name of this symbol is located.
    */
   unsigned int getNameLineNumber() const;
   /**
    * Set the loation of the name of this symbol
    */
   void setNameLocation(unsigned int seekPosition, unsigned int lineNumber);

   /**
    * Get the scope seek position for this symbol.  This is the seek position 
    * where the scope of a symbol begins, such as the open brace for a C/C++ 
    * function definition. 
    */
   unsigned int getScopeSeekPosition() const;
   /**
    * Get the scope line number for this symbol.
    */
   unsigned int getScopeLineNumber() const;
   /**
    * Set the start scope location for this symbol.
    */
   void setScopeLocation(unsigned int seekPosition, unsigned int lineNumber);

   /**
    * Get the end seek position for this symbol.
    */
   unsigned int getEndSeekPosition() const;
   /**
    * Get the end line number for this symbol.
    */
   unsigned int getEndLineNumber() const;
   /**
    * Set the end location for this symbol 
    */
   void setEndLocation(unsigned int seekPosition, unsigned int lineNumber);

   /**
    * Get the name of the tag database which this symbol was discovered 
    * in (used when searching for symbols).
    */
   const slickedit::SEString &getTagFileName() const;
   /**
    * Set the name of the tag database which this symbol was discovered in
    */
   void setTagFileName(const slickedit::SEString &tagFileName);

   /**
    * Set all location information for this symbol
    */
   void setLocationInformation(const slickedit::SEString &fileName,
                               const slickedit::SEString &langId,
                               unsigned int startSeekPosition, unsigned int startLineNumber,
                               unsigned int nameSeekPosition,  unsigned int nameLineNumber,
                               unsigned int scopeSeekPosition, unsigned int scopeLineNumber,
                               unsigned int endSeekPosition,   unsigned int endLineNumber,
                               const slickedit::SEString &tagFilename = (const char *)0);

   /**
    * Get the symbol signature or argument list
    */
   const slickedit::SEString &getSignature() const;
   /**
    * Set the symbol signature or argument list
    */
   void setSignature(const slickedit::SEString &argumentList);

   /**
    * Get the template signature or argument list
    */
   const slickedit::SEString &getTemplateSignature() const;
   /**
    * Set the template signature or argument list
    */
   void setTemplateSignature(const slickedit::SEString templateSignature);

   /**
    * Get the symbol return type
    */
   const slickedit::SEString &getReturnType() const;
   /**
    * Set the symbol return type or declared symbol type
    */
   void setReturnType(const slickedit::SEString &returnType);

   /**
    * Get the symbol class parents (separated by semicolons)
    */
   const slickedit::SEString &getClassParents() const;
   /**
    * Set the symbol class parents (separated by semicolons)
    */
   void setClassParents(const slickedit::SEString &classParents);

   /**
    * Get the function exception list
    */
   const slickedit::SEString &getExceptions();
   /**
    * Set the function exception list
    */
   void setExceptions(const slickedit::SEString &exceptions);

   /**
    * Get composite return type and signature and exceptions information.
    */
   const slickedit::SEString getCompositeSignature() const;
   /**
    * Save composit return type and signature and exceptions information.
    */
   void setCompositeSignature(const slickedit::SEString &signature);

   /**
    * Export this object to the given Slick-C VS_TAG_BROWSE_INFO struct 
    */
   void getBrowseInformation(VSHREFVAR browseInfoHvar) const;
   /**
    * Copy the given Slick-C VS_TAG_BROWSE_INFO struct to this object.
    */
   void setBrowseInformation(VSHREFVAR browseInfoHvar);

   /**
    * Export this object to the given Slick-C se.tags.SymbolInfo class.
    */
   void getSymbolInfo(VSHREFVAR symbolInfoHvar) const;
   /**
    * Copy the given Slick-C se.tags.SymbolInfo class instance to this object.
    */
   void setSymbolInfo(VSHREFVAR symbolInfoHvar);

   /**
    * Load this symbol from the tag database.
    */
   int loadTagFromDatabase(int dbHandle, size_t recordLoc);

   /**
    * Insert the symbol into the tagging databse for the currently open database.
    */
   int insertTagInDatabase(int dbHandle) const;

   /**
    * Propagate tag flags from this symbol to other related symbols, and vice-versa
    */
   int propagateTagFlags(int dbHandle, int &newTagFlags,
                         const slickedit::SEHashSet<SETagInformation> *oldTags = NULL) const;

   /**
    * Insert the symbol into the current context.
    */
   int insertTagInContext(bool allowStatements=true) const;

   /**
    * Insert the symbol into the set of locals.
    */
   int insertTagInLocals() const;

   /**
    * Insert the symbol into a tree control.
    */
   int insertInTree(int treeWid, 
                    int treeIndex,
                    int treeFlags,
                    bool includeTab, 
                    bool forceLeafNode, 
                    bool includeSignature, 
                    bool includeClassName, 
                    VSHVAR user_info=0) const;


   /**
    * Find an exact match for this tag in the tagging database.
    * 
    * @param dbHandle   tag database handle 
    * @param recordLoc  (output) set to record location in database on success
    * 
    * @return 0 on success, <0 on error. 
    */
   int findInDatabase(int dbHandle, size_t &recordLoc) const;

   /**
    * Remove one tag from the database exactly matching this tag.
    * 
    * @param dbHandle   tag database handle
    * 
    * @return 0 on success, <0 on error. 
    */
   int removeFromDatabase(int dbHandle) const;

   /**
    * Update the file location for this tag in the database. 
    * This is used only to change the tag's start line number. 
    * Since that doesn't effect any indexing, it is done in place 
    * on the database for effeciency. 
    * 
    * @param dbHandle   tag database handle 
    * @param line_no    new line number to plug in 
    * @param tagFLags   new tag flags set to plug in 
    * 
    * @return 0 on success, <0 on error. 
    */
   int updateLineAndFlagsInDatabase(int dbHandle, int line_no, int tag_flags) const;


private:

   // tag name and class name
   slickedit::SEString mTagName;               // tag name or description
   slickedit::SEString mClassName;             // name of class scope tag is in

   // tag type, one of VS_TAGTYPE_* or a custom user tag type
   // tag flags, a bitset of VS_TAGFLAG_*
   unsigned short mTagType;
   unsigned int   mTagFlags;

   // outer context ID which this tag belongs to
   int mContextId;

   // filename information
   slickedit::SEString mFileName;
   slickedit::SEString mLanguageId;

   // tag database which this symbol was discovered in (used when searching)
   slickedit::SEString mTagFileName;

   // location information
   unsigned int mStartSeekPosition;          // seek position of start of symbol
   unsigned int mStartLineNumber;            // line where symbol starts
   unsigned int mNameSeekPosition;           // seek position of name of symbol
   unsigned int mNameLineNumber;             // line where symbol name is
   unsigned int mScopeSeekPosition;          // seek position of start of symbol scope
   unsigned int mScopeLineNumber;            // line where symbol scope starts
   unsigned int mEndSeekPosition;            // seek position of end of symbol
   unsigned int mEndLineNumber;              // line where symbol ends

   // tag signature or argument list
   slickedit::SEString mSignature;

   // template signature or template argument list
   slickedit::SEString mTemplateSignature;

   // symbol return type or declared type
   slickedit::SEString mReturnType;

   // class parents for symbol
   slickedit::SEString mClassParents;

   // symbol exceptions
   slickedit::SEString mExceptions;

};


//==================================================================================
inline const slickedit::SEString & 
slickedit::SETagInformation::getTagName() const 
{
   return mTagName;
}
inline void 
slickedit::SETagInformation::setTagName(const slickedit::SEString &tagName) 
{
   mTagName = tagName;
   mTagName.breakLinkToExternalBuffer();
}
inline void 
slickedit::SETagInformation::appendTagName(const slickedit::SEString &str) 
{
   mTagName.append(str);
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getClassName() const 
{
   return mClassName;
}
inline void 
slickedit::SETagInformation::setClassName(const slickedit::SEString &className) 
{
   mClassName = className;
   mClassName.breakLinkToExternalBuffer();
}

inline unsigned int 
slickedit::SETagInformation::getTagType() const 
{
   return mTagType;
}
inline void 
slickedit::SETagInformation::setTagType(unsigned short tagType) 
{
   mTagType = tagType;
}

inline unsigned int 
slickedit::SETagInformation::getTagFlags() const 
{
   return mTagFlags;
}
inline void 
slickedit::SETagInformation::setTagFlags(unsigned int tagFlags) 
{
   mTagFlags = tagFlags;
}
inline void 
slickedit::SETagInformation::addTagFlags(unsigned int tagFlags) 
{
   mTagFlags |= tagFlags;
}
inline void 
slickedit::SETagInformation::removeTagFlags(unsigned int tagFlags) 
{
   mTagFlags &= ~(tagFlags);
}

inline int 
slickedit::SETagInformation::getContextId() const 
{
   return mContextId;
}
inline void 
slickedit::SETagInformation::setContextId(int contextId) 
{
   mContextId = contextId;
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getFileName() const 
{
   return mFileName;
}

inline void 
slickedit::SETagInformation::setFileName(const slickedit::SEString &fileName) 
{
   mFileName = fileName;
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getLanguageId() const 
{
   return mLanguageId;
}
inline void 
slickedit::SETagInformation::setLanguageId(const slickedit::SEString &langId) 
{
   mLanguageId = langId;
}

inline unsigned int 
slickedit::SETagInformation::getStartSeekPosition() const 
{
   return mStartSeekPosition;
}
inline unsigned int 
slickedit::SETagInformation::getStartLineNumber() const 
{
   return mStartLineNumber;
}
inline void 
slickedit::SETagInformation::setStartLocation(unsigned int seekPosition, unsigned int lineNumber) 
{
   mStartSeekPosition = seekPosition;
   mStartLineNumber = lineNumber;
}

inline unsigned int 
slickedit::SETagInformation::getNameSeekPosition() const 
{
   return mNameSeekPosition;
}
inline unsigned int 
slickedit::SETagInformation::getNameLineNumber() const 
{
   return mNameLineNumber;
}
inline void 
slickedit::SETagInformation::setNameLocation(unsigned int seekPosition, unsigned int lineNumber) 
{
   mNameSeekPosition = seekPosition;
   mNameLineNumber = lineNumber;
}

inline unsigned int 
slickedit::SETagInformation::getScopeSeekPosition() const 
{
   return mScopeSeekPosition;
}
inline unsigned int 
slickedit::SETagInformation::getScopeLineNumber() const 
{
   return mScopeLineNumber;
}
inline void 
slickedit::SETagInformation::setScopeLocation(unsigned int seekPosition, unsigned int lineNumber) 
{
   mScopeSeekPosition = seekPosition;
   mScopeLineNumber = lineNumber;
}

inline unsigned int 
slickedit::SETagInformation::getEndSeekPosition() const 
{
   return mEndSeekPosition;
}
inline unsigned int 
slickedit::SETagInformation::getEndLineNumber() const 
{
   return mEndLineNumber;
}
inline void 
slickedit::SETagInformation::setEndLocation(unsigned int seekPosition, unsigned int lineNumber) 
{
   mEndSeekPosition = seekPosition;
   mEndLineNumber = lineNumber;
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getTagFileName() const 
{
   return mTagFileName;
}
inline void 
slickedit::SETagInformation::setTagFileName(const slickedit::SEString &tagFileName) 
{
   mTagFileName = tagFileName;
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getSignature() const 
{
   return mSignature;
}
inline void 
slickedit::SETagInformation::setSignature(const slickedit::SEString &argumentList) 
{
   mSignature = argumentList;
   mSignature.breakLinkToExternalBuffer();
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getTemplateSignature() const 
{
   return mTemplateSignature;
}
inline void 
slickedit::SETagInformation::setTemplateSignature(const slickedit::SEString templateSignature) 
{
   mTemplateSignature = templateSignature;
   mTemplateSignature.breakLinkToExternalBuffer();
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getReturnType() const 
{
   return mReturnType;
}
inline void 
slickedit::SETagInformation::setReturnType(const slickedit::SEString &returnType)
{
   mReturnType = returnType;
   mReturnType.breakLinkToExternalBuffer();
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getClassParents() const 
{
   return mClassParents;
}
inline void 
slickedit::SETagInformation::setClassParents(const slickedit::SEString &classParents) 
{
   mClassParents = classParents;
   mClassParents.breakLinkToExternalBuffer();
}

inline const slickedit::SEString & 
slickedit::SETagInformation::getExceptions() 
{
   return mExceptions;
}
inline void 
slickedit::SETagInformation::setExceptions(const slickedit::SEString &exceptions) 
{
   mExceptions = exceptions;
   mExceptions.breakLinkToExternalBuffer();
}


}

#endif // SLICKEDIT_TAG_INFORMATION_H

