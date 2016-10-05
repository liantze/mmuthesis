%% mmuthesis.cls 2016/10/05 version V1.4
%% 
%% This is the unofficial MMU thesis LaTeX class for postgraduate research
%% students of Multimedia University, Cyberjaya/Malacca, Malaysia, formatted
%% according to the Guide for Preparation of Thesis published by MMU's
%% Institute for Postgraduate Studies
%% 
%% 
%% The latest version and documentation of mmu can be obtained at
%% http://liantze.penguinattack.org/latextypesetting.html.
%% Contact liantze AT gmail DOT com if you have any questions or
%% assistance or feedback.  Apologies if I can't respond immediately, but
%% I'll always try.
%%
%%
%% Copyright (c) 2010-2016 by Lim Lian Tze
%%
%% Current maintainer: Lim Lian Tze (liantze@gmail.com)
%
%  BRIEF CHANGELOG
%  ===============
% v1.4 October 5 2016
%     - Updated copyright declaration page.
%
% v1.3 September 22 2012
%     - Chapter headings are now 12pt.
%     - Appendices text is now 10pt.
%     - Table and figure captions are now bold.
%     - Publication List now has separate sections Journal Articles and
%       Conference Proceedings.
%
% v1.2 June 9 2012
%     - PDF bookmarks are now numbered (main chapters and appendices)
%     - There is now an ``Appendices'' PDF bookmark
%     - Fixed indent of quote and quotation
%
% v1.1 July 7 2011
%     - Fixed inter-paragraph spacing to be really double.
%     - Used \setstretch{1.5} instead of \OnehalfSpacing to mimic fully Word output.
%     - Increased \afterchaptitleskip, \aftersecskip etc etc to mimic fully Word output.
%
% v1.0 July 12 2010
%     - First release (with a really awful manual)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mmuthesis}[2011/07/07 LaTeX2e class for MMU Thesis v1.1.  Copyright (c) 2011 Lim Lian Tze (liantze@gmail.com)]

\LoadClass[12pt,a4paper,oneside]{memoir}
\RequirePackage{textcomp}

\def\theauthor{\textbf{!INSERT AUTHOR!}}
\def\thetitle{\textbf{!INSERT TITLE!}}
\def\@mtsubmissionmonth{\textbf{!INSERT MONTH!}}
\def\@mtsubmissionyear{\textbf{!INSERT YEAR!}}
\def\@mtfaculty{\textbf{!INSERT FACULTY!}}
\def\@mtdegree{\textbf{!INSERT DEGREE!}}
\def\@mtquali{\textbf{!INSERT QUALIFICATION!}}

\newcommand{\submissionyear}[1]{\def\@mtsubmissionyear{#1}}
\newcommand{\submissionmonth}[1]{\def\@mtsubmissionmonth{#1}}
\newcommand{\faculty}[1]{\def\@mtfaculty{#1}}
\newcommand{\degree}[1]{\def\@mtdegree{#1}}
\newcommand{\qualification}[1]{\def\@mtquali{#1}}


%%%%%%%%%%%%
% Page layout
%
% Margins: T - 20mm; B - 40mm; L - 40mm; R - 25mm
% No running headers.
% Running footers are 15mm from bottom edge of paper
% i.e. (40 - 15)mm = 25mm from bottom edge of typeblock.
%%%%%%%%%%%%
\settrimmedsize{297mm}{210mm}{*}
\setlrmarginsandblock{40mm}{25mm}{*}
\setulmarginsandblock{20mm}{40mm}{*}
\setheadfoot{\baselineskip}{25mm}
\addtolength\footskip{-6pt}
\pagestyle{plain}
\makeevenfoot{plain}{}{\fontsize{10pt}{12pt}\selectfont\thepage}{}
\makeoddfoot{plain}{}{\fontsize{10pt}{12pt}\selectfont\thepage}{}
\checkandfixthelayout

%%%%%%%%%%%%
% Simulate MS Windows fonts
% Invoking Helvetica and Times
% NOT Courier because, well, I hate it.
%
% TODO: TeX Gyre fonts + Math Times Pro with "altfonts" option
%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet}
\RequirePackage{mathptmx}
%\RequirePackage{courier}
\renewcommand\ttdefault{lmvtt}


%%%%%%%%%%%%
% Line and paragraph spacing
% - 1.5 spacing for normal text (but need to tweak to exactly simulate Word
% - Leave one line between paragraphs
% - 12.7mm paragraph indent
%%%%%%%%%%%%
%\OnehalfSpacing
\DisemulatePackage{setspace}
\RequirePackage{setspace}
\setstretch{1.5}
\abnormalparskip{1.5\onelineskip}
\setlength\parindent{12.7mm}
\RequirePackage{etoolbox}
\patchcmd{\quote}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}
\patchcmd{\quotation}{\rightmargin}{\leftmargin 20mm \rightmargin}{}{}

%%%%%%%%%%%%
% Footnotes
% - Font size = 8pt = \tiny for 12pt body font in memoir
% - Double spacing between footnotes
%%%%%%%%%%%%
\renewcommand{\foottextfont}{\tiny}
\setlength\footnotesep{\onelineskip}
% But they should all be endnotes!!
\RequirePackage{endnotes}
\renewcommand\enotesize{\tiny}
%\let\footnote=\endnote
\renewcommand\enoteheading{\chapter{\notesname}\mbox{}\vskip-4\onelineskip}
\renewcommand\enoteformat{\rightskip\z@ \leftskip\z@ \parindent=1.8em
  \leavevmode\llap{\makebox[1.8em][l]{\theenmark.}}}

%%%%%%%%%%%%%
% Algorithms
%%%%%%%%%%%%%
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{caption}
\DeclareCaptionFormat{algorithm}{\vspace{0ex}{%
   \parbox[c][1.75em][c]{\textwidth}{#1#2\hspace{1em}#3}}\par}%\rule{\linewidth}{0.5pt}}
\captionsetup[algorithm]{format=algorithm}
\captionsetup[figure]{font=bf}
\captionsetup[table]{font=bf,position=top}

\AtBeginEnvironment{algorithmic}{\setstretch{1.5}}

\RequirePackage[breaklinks,pdfborder={0 0 0},bookmarksopen,bookmarksnumbered,pdfprintscaling=None]{hyperref}
\addtoiargdef\author{}{\hypersetup{pdfauthor={\theauthor}}}
\addtoiargdef\title{}{\hypersetup{pdftitle={\thetitle}}}


%%%%%%%%%%%%
% 10pt = \footnotesize for backmatter
% And add a PDF bookmark
%%%%%%%%%%%%
\cftinsertcode{narrowertoc}{\setlength\cftbeforechapterskip{.75em}}

\patchcommand{\backmatter}{}{\footnotesize%
\cftinserthook{toc}{narrowertoc}%
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\ifpdf\pdfbookmark[-1]{Back Matter}{back}\fi}
\patchcommand{\frontmatter}{}{\ifpdf\pdfbookmark[-1]{Front Matter}{front}\fi}
\patchcommand{\mainmatter}{}{\ifpdf\pdfbookmark[-1]{Main Chapters}{main}\fi}

%%%%%%%%%%%%
% The Cover and Title page
%%%%%%%%%%%%
\newcommand{\makecoverandtitlepage}{%
\ignorespaces
%\changepage{-20mm}{-15mm}{15mm}{0em}{0em}{20mm}{0em}{0em}{0em}
\changepage{-40mm}{-15mm}{15mm}{0em}{0em}{40mm}{0em}{0em}{0em}
\begin{titlingpage}
\centering\SingleSpacing%
\renewcommand\ttdefault{lmtt}%
\fontfamily{phv}\fontseries{mc}%\LARGE%
%\fontfamily{qhv}\fontseries{cr}%
\fontsize{18pt}{20pt}
\selectfont%
\MakeUppercase{\thetitle}\par%
\vfill%
\MakeUppercase{\theauthor}\par%
\vfill%
\MakeUppercase{\@mtdegree}\par%
MULTIMEDIA UNIVERSITY\par%
\MakeUppercase{\@mtsubmissionmonth}\ \@mtsubmissionyear\par%
\end{titlingpage}%
\clearpage\hspace{1em}\thispagestyle{empty}\clearpage%%Hack to insert blank page
{\centering\thispagestyle{empty}\setcounter{page}{1}%
{\SingleSpacing\LARGE\MakeUppercase{\thetitle}\par}%
\vfill%
{\setstretch{2} BY\\%
{\fontsize{16pt}{18pt}\selectfont\MakeUppercase{\theauthor}}\\\@mtquali\par}%
\vfill%
{\setstretch{2} THESIS SUBMITTED IN FULFILMENT OF THE\\%
REQUIREMENT FOR THE DEGREE OF\\%
\MakeUppercase{\@mtdegree}\\%
(by Research)\\%
in the\\%
\@mtfaculty\par}%
\vfill%
{\SingleSpacing\fontsize{16pt}{18pt}\selectfont MULTIMEDIA UNIVERSITY\\%
MALAYSIA}\\[1em]%
\@mtsubmissionmonth\ \@mtsubmissionyear%\\[3em]%
\par\clearpage}%
%\changepage{20mm}{15mm}{-15mm}{0em}{0em}{-20mm}{0em}{0em}{0em}%
\changepage{40mm}{15mm}{-15mm}{0em}{0em}{-40mm}{0em}{0em}{0em}
\renewcommand\ttdefault{lmvtt}%
}


%%%%%%%%%%%%
% The Copyright page
%%%%%%%%%%%%
\newcommand{\copyrightpage}{\hspace{1em}%
\phantomsection%
\ifpdf\pdfbookmark{Copyright Page}{copyright}\fi%
\cftaddtitleline{toc}{chapter}{COPYRIGHT PAGE}{\thepage}%
\begin{vplace}[1]
\fontsize{14pt}{16pt}\selectfont %The copyright of this thesis belongs to the author under the terms of the Copyright Act 1987 as qualified by Regulation 4(1) of the Multimedia University Intellectual Property Regulations. Due acknowledgement shall always be made of the use of any material contained in, or derived from, this thesis.\par\vskip\onelineskip%
%{\raggedleft%
%\begin{tabular}{@{}r@{ }l@{}}
%\textcopyright & \theauthor, \@mtsubmissionyear\\
%& All rights reserved
%\end{tabular}%
%\par}
\setlength{\parindent}{0pt}
\textcopyright \@mtsubmissionyear{} submission Universiti Telekom Sdn.\ Bhd. ALL RIGHTS RESERVED.\par
Copyright of this thesis belongs to Universiti Telekom Sdn.\ Bhd. as qualified by Regulation 7.2 (c) of the Multimedia University Intellectual Property and Commercialisation Policy. No part of this publication may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Universiti Telekom Sdn.\ Bhd. Due acknowledgement shall always be made of the use of any material contained in, or derived from, this thesis.
\end{vplace}\clearpage%
}


%%%%%%%%%%%%
% The Declaration page
%%%%%%%%%%%%
\newcommand{\declarationpage}{%
\chapter{Declaration}\vskip-\onelineskip
I hereby declare that the work has been done by myself and no portion of the work contained in this Thesis has been submitted in support of any application for any other degree or qualification on this or any other university or institution of learning.\\[3\onelineskip]
\newlength\siglinelength
\settowidth{\siglinelength}{\bfseries\normalsize\theauthor}
\noindent\rule{\siglinelength}{.6pt}\\{\bfseries\normalsize\theauthor}\par\clearpage
}

%%%%%%%%%%%%
% The Acknowledgements (typeset like chapter?)
%%%%%%%%%%%%
\newcommand{\acknowledgements}[1]{\chapter{Acknowledgements}\vskip-\onelineskip #1}
\newcommand{\acknowlfromfile}[1]{\acknowledgements{\input{#1}}}

%%%%%%%%%%%%
% The dedication (??? formatting???)
%%%%%%%%%%%%
\newcommand{\dedication}[1]{\newpage\hspace{1em}%
\phantomsection%
\ifpdf\pdfbookmark{Dedication}{dedication}\fi%
\cftaddtitleline{toc}{chapter}{DEDICATION}{\thepage}%
\begin{vplace}[.5]\centering#1\end{vplace}%
\clearpage}


%%%%%%%%%%%%
% The Abstract
%%%%%%%%%%%%
\abstractintoc
\renewcommand*\abstractname{\texorpdfstring{ABSTRACT}{Abstract}}
\renewcommand*\absnamepos{center}
%\setlength\abstitleskip{0pt}
\setlength\abstitleskip{-\onelineskip}
\renewcommand\abstractnamefont{\normalsize\bfseries}
\renewcommand\abstracttextfont{\normalsize}
\setlength\absleftindent{0pt}
\setlength\absrightindent{0pt}
\newcommand{\abstractfromfile}[1]{\begin{abstract}\input{#1}\end{abstract}}

%%%%%%%%%%%%
% The Preface
%%%%%%%%%%%%
\newenvironment{preface}{\chapter{Preface}\vskip-\onelineskip}{}
\newcommand{\prefacefromfile}[1]{\begin{preface}\input{#1}\end{preface}}

%%%%%%%%%%%%
% Chapter headings
%%%%%%%%%%%%
\renewcommand\chapterheadstart{\normalsize\vskip\beforechapskip}
\setlength\beforechapskip{0pt}
\setlength\midchapskip{3\onelineskip}
\setlength\afterchapskip{2\onelineskip minus \onelineskip}
\renewcommand*\chapnamefont{\normalsize\bfseries}
\renewcommand*\chapnumfont{\normalsize\bfseries\centering}
\renewcommand*\chaptitlefont{\normalsize\bfseries\centering}
\renewcommand{\printchaptername}{{\chapnamefont\MakeUppercase{\chaptername}}}
\renewcommand*{\afterchapternum}{\vskip\midchapskip}
\renewcommand*{\printchaptertitle}[1]{{\chaptitlefont\MakeUppercase{#1}\par}}


%%%%%%%%%%%%
% The Appendices
%%%%%%%%%%%%
\renewcommand*\appendixname{Appendix}
%\addtodef\appendix{}{%
\patchcommand{\appendix}{}{%
\footnotesize%
\renewcommand\chaptername{\appendixname}%
\ifpdf\pdfbookmark[-1]{Appendices}{appendix}\fi%
\let\normalchapter\chapter
\renewcommand{\chapter}[1]{\normalchapter{##1}\footnotesize}
}

%%%%%%%%%%%%
% Sectional headings
%%%%%%%%%%%%
\setsecnumdepth{subsubsection}
\setsecheadstyle{\normalsize\bfseries}
%\setbeforesecskip{2.5ex plus 1ex minus .2ex}
\setbeforesecskip{\onelineskip}
%\setaftersecskip{0.1ex plus .2ex}
%\setaftersecskip{1em plus .2ex minus .2ex}
\setaftersecskip{\onelineskip}
\setsubsecheadstyle{\normalsize\bfseries}
%\setbeforesubsecskip{2.5ex plus .1ex minus .2ex}
\setbeforesubsecskip{\onelineskip}
%\setaftersubsecskip{0.1ex plus .2ex}
%\setaftersubsecskip{1em plus .2ex minus .2ex}
\setaftersubsecskip{\onelineskip}
\setsubsubsecheadstyle{\normalsize\itshape}
%\setbeforesubsubsecskip{1.5ex plus 1ex minus .2ex}
\setbeforesubsubsecskip{\onelineskip}
\renewcommand\thesubsubsection{\thesubsection\space(\alph{subsubsection})}
\setsubsubsecheadstyle{\normalsize\itshape}
%\setbeforesubsubsecskip{2.5ex plus .2ex minus .2ex}
\setbeforesubsubsecskip{\onelineskip}
%\setaftersubsubsecskip{0.1ex plus .2ex}
%\setaftersubsubsecskip{1em plus .1ex minus .2ex}
\setaftersubsubsecskip{\onelineskip}


%%%%%%%%%%%
% ToC etc
%%%%%%%%%%%
\newsubfloat{figure}
\setcounter{lofdepth}{2}
\newsubfloat{table}
\setcounter{lotdepth}{2}
\settocdepth{subsection}
\renewcommand*\contentsname{\texorpdfstring{TABLE OF CONTENTS}{Table of Contents}}
\renewcommand*\listtablename{\texorpdfstring{LIST OF TABLES}{List of Tables}}
\renewcommand*\listfigurename{\texorpdfstring{LIST OF FIGURES}{List of Figures}}
\renewcommand*\indexname{\texorpdfstring{INDEX}{Index}}
\renewcommand*\glossaryname{\texorpdfstring{GLOSSARY}{Glossary}}
\renewcommand\cftdotsep{\cftnodots}
\setrmarg{3.55em plus 1fil}
\renewcommand*{\cftchaptername}{\MakeUppercase{\chaptername}\space}
\renewcommand*{\cftchapteraftersnum}{:\space}
\renewcommand*{\cftchapterafterpnum}{\vspace*{4pt}}
\renewcommand*{\cftappendixname}{\MakeUppercase{\appendixname}\space}
\setlength\cftsectionindent{0pt}
\let\orichapter\chapter
\renewcommand\chapter{\@ifstar{\mystarchap}{\mychap}}
\newcommand\mychap[1]{\orichapter[\texorpdfstring{\MakeUppercase{#1}}{#1}]{#1}}
\newcommand\mystarchap[1]{\orichapter*{#1}}
%\renewcommand*\cftsectionafterpnum{\vskip 3pt}
\setlength\cftbeforesectionskip{3pt}
\setlength\cftbeforechapterskip{1.5em}
\setlength\cftsubsectionindent{\cftsectionnumwidth}
\renewcommand*\cftfigurename{\figurename\space}
\newlength\fignamelength
\settowidth\fignamelength{\cftfigurename}
\setlength\cftsubfigureindent{\fignamelength}
\setlength\cftsubfigurenumwidth{2em}
%\renewcommand*\cftfigureafterpnum{\vskip 3pt}
\setlength\cftbeforefigureskip{3pt}
%\renewcommand*\cftsubfigureafterpnum{\vskip 3pt}
\setlength\cftbeforesubfigureskip{3pt}
\renewcommand*\cfttablename{\tablename\space}
\newlength\tabnamelength
\settowidth\tabnamelength{\cfttablename}
\setlength\cftsubtableindent{\tabnamelength}
%\renewcommand*\cfttableafterpnum{\vskip 3pt}
\setlength\cftbeforetableskip{3pt}
%\renewcommand*\cftsubtableafterpnum{\vskip 3pt}
\setlength\cftbeforesubtableskip{3pt}

\addtodef{\insertchapterspace}{}%
{\addtocontents{toc}{\protect\vspace*{-4pt}}}

%%%%%%%%%%%
% Indexing
%%%%%%%%%%%
\RequirePackage{makeidx}
\RequirePackage[notesep=.5\onelineskip]{idxlayout}
\setindexprenote{}
\makeindex

%%%%%%%%%%%%
% Bibliograpy
% - Font size = 10pt = \footnotesize
% - Double spacing between entries
%%%%%%%%%%%%
\RequirePackage[nosectionbib]{apacite}
% new counter for enumerating bibitems
\newcounter{lbibcount} 
\bibliographystyle{apacite}
\renewcommand\bibliographytypesize{\footnotesize}
\setlength\bibitemsep{\onelineskip}
%\setlength\bibleftmargin{12.7mm}
\setlength\bibleftmargin{2em}
\setlength\bibindent{-\bibleftmargin}
% Add a counter label to each bibitem per MMU's requirement
\def\@lbibitem[#1]#2{%
    \def\BBA{\BBAA}%    ``\&''
    \item[\hyper@natanchorstart{#2\APAC@extra@b@citeb}%
          \@biblabel{#1}{\protect\makebox[\bibleftmargin][l]{[\arabic{lbibcount}]}}% added numeric label here
          \hyper@natanchorend]%
    \if@filesw{%
        \def\BBA{\string\BBA}%
        \let\protect\noexpand
        \immediate\write\@newciteauxhandle{\string\bibcite{#2}{#1}}%
        \immediate\write\@newciteauxhandle{\string\APACbibcite{#2}{#1}}%
        \def\BBA{\BBAA}%
    }%
    \fi
    \ignorespaces
}
% step counter at each bibitem
\patchcommand{\bibitem}{\addtocounter{lbibcount}{1}}{}
% reset label width to 0 and reset bibitem counter.
\addtoiargdef{\thebibliography}{}{\setcounter{lbibcount}{0}\labelwidth=0pt}
\renewcommand{\bibliographyprenote}{\vspace*{-\onelineskip}} % Ugly, ugly hack
\AtBeginDocument{\renewcommand*\bibname{\texorpdfstring{REFERENCES}{References}}}

\RequirePackage{multibib}
%\newcites{own}{\texorpdfstring{PUBLICATION LIST}{Publication List}}
%\newcites{own}{Publication List}
%\bibliographystyleown{apacite}
%\addtoiargdef{\bibliographyown}{}{\setcounter{lbibcount}{0}}
%{\renewcommand*\bibname{\texorpdfstring{PUBLICATION LIST}{Publication List}}}

\newcites{jour,conf}{Journal Articles,Conference Proceedings}
\bibliographystylejour{apacite}
\bibliographystyleconf{apacite}
\newcommand\ownpubs{%
\settocdepth{chapter}
\chapter{Publication List}
\undef\chapter
}

%\RequirePackage{relsize}
\RequirePackage[toc,nonumberlist,description,shortcuts]{glossaries}
\renewcommand*{\acrnameformat}[2]{#2 (\acronymfont{#1})}
\renewcommand{\glsgroupskip}{}
\renewcommand{\glossarypreamble}{\footnotesize\vspace*{-\onelineskip}}
\renewcommand{\glossarypostamble}{\normalsize}
\makeglossaries

%%%%%%%%%%%%
% Floats
%%%%%%%%%%%%
\setlength{\intextsep}{2\onelineskip}
\setlength{\textfloatsep}{2\onelineskip}
\setlength{\floatsep}{2\onelineskip}

\AtEndDocument{\clearpage\hspace{1em}\thispagestyle{empty}\clearpage}
