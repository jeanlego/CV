% Intro Options
\ProvidesClass{deedy-resume-openfont}[2014/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

\usepackage[document]{ragged2e}
% Package Imports
\usepackage[top=1.75cm, right=1.75cm, left=1.75cm, bottom=1.75cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage{xstring}
\usepackage{setspace}
\usepackage[utf8]{inputenc}
\usepackage{babel,csquotes,xpatch}% recommended
\usepackage[backend=biber,maxcitenames=10]{biblatex}


% Color definitions
\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{2b2b2b} 
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts
\usepackage{fontspec}
\usepackage{lmodern}

\setmainfont[Color=primary, Path = fonts/lato/,BoldItalicFont=Lato-RegIta,BoldFont=Lato-Reg,ItalicFont=Lato-LigIta]{Lato-Lig}

% Name command
\newcommand{\namesection}[3]{
\centering{
\fontsize{40pt}{60pt}
\fontspec[Path = fonts/lato/]{Lato-Hai}\selectfont #1 
\fontspec[Path = fonts/lato/]{Lato-Lig}\selectfont #2
} \\[5pt]
\centering{
\color{headings}
\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{12pt}{12pt}\selectfont #3}
\noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}
}

\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
\newcommand{\runsection}[1]{%
\vspace*{8pt}
\begin{minipage}{\textwidth}\hspace*{-0.5cm}\color{headings}\scshape\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{16pt}{24pt}\selectfont\uppercase{#1}\end{minipage}
\normalfont
\hspace*{0.5cm}
}

% Subeadings command
\newcommand{\runsubsection}[1]{%
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Reg}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase{#1} 
\normalfont
}

% Descriptors command
\newcommand{\descript}[1]{%
\color{subheadings}\scshape\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{12pt}{12pt}\selectfont {#1} \normalfont}

% Location command
\newcommand{\location}[1]{%
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Reg}\fontsize{10pt}{12pt}\selectfont {#1} \normalfont}

% Location command
\newcommand{\normaltext}[1]{%
\color{primary}\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{10pt}{12pt}\selectfont {#1} \normalfont}


% better underline
\usepackage{contour}
\contourlength{0.8pt}
\newcommand{\uline}[1]{%
  \underline{\smash{#1}\vphantom{T}}\vphantom{#1}%
  \llap{\contour{white}{#1}}%
}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}

% Custom cite command with a newline for authors and journal
\DeclareCiteCommand{\singlecite}
    {\begin{minipage}{\textwidth}%
    \singlespacing%
    \usebibmacro{maintitle+title}\\
    \hspace{-1pt}\nopunct % fix punctuation at start of authorship
    \usebibmacro{author}\\
    {\color{headings}\fontspec[Path = fonts/lato/]{Lato-Reg}\fontsize{10pt}{12pt}\selectfont%
        \usebibmacro{date}~|~\printlist{organization}\printlist{publisher}~|~\printlist{location} \normalfont\\}
    \normaltext{\printfield{eventtitle}\printfield{booktitle}\usebibmacro{journal}}\\
    \usebibmacro{postnote}
    \end{minipage}
    }


% comma separated citations

\usepackage{xparse}
\ExplSyntaxOn
\NewDocumentCommand{\mycite}{ m }
 {
  \clist_map_inline:nn { #1 } { \singlecite{##1} }
 }
\ExplSyntaxOff

% Make the titles in bold and uppercase
\DeclareFieldFormat
    [article,book,inbook,incollection,inproceedings,patent,thesis,unpublished]
    {title}{\bf\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Reg}\fontsize{12pt}{12pt}\selectfont #1 \normalfont}

\DeclareFieldFormat
    [article,book,inbook,incollection,inproceedings,patent,thesis,unpublished]
    {titlecase}{\MakeUppercase{#1}}

\DeclareNameFormat
[article,book,inbook,incollection,inproceedings,patent,thesis,unpublished]
{author}{%
    \bf\color{subheadings}\scshape\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{12pt}{12pt}\selectfont%
    \ifnumequal{\value{listcount}}{1}
    {\ifgiveninits
        {\usebibmacro{name:family-given}
            {\namepartfamily}
            {\namepartgiveni}
            {\namepartprefix}
            {\namepartsuffix}}
        {\usebibmacro{name:family-given}
            {\namepartfamily}
            {\namepartgiven}
            {\namepartprefix}
            {\namepartsuffix}}%
        \ifboolexpe{%
        test {\ifdefvoid\namepartgiven}
        and
        test {\ifdefvoid\namepartprefix}}
        {}
        {\usebibmacro{name:revsdelim}}}
    {\ifgiveninits
        {\usebibmacro{name:given-family}
            {\namepartfamily}
            {\namepartgiveni}
            {\namepartprefix}
            {\namepartsuffix}}
        {\usebibmacro{name:given-family}
            {\namepartfamily}
            {\namepartgiven}
            {\namepartprefix}
            {\namepartsuffix}}}%
    \usebibmacro{name:andothers}
    \normalfont
    }

% bulleted list
\usepackage{etoolbox}
\usepackage{pgffor}
\newtoggle{firstmember}
\newcommand*{\bulletedlist}[2]{%
\begin{minipage}{\textwidth}
\sloppy
\runsubsection{#1~|}\\
    \global\toggletrue{firstmember}%
    \foreach \member in {#2} {%
        \normaltext{\iftoggle{firstmember}{\member}{ \textbullet{} \member}}%
        \global\togglefalse{firstmember}%
    }%
\end{minipage}

\sectionsep

}

% employement
\newcommand{\employement}[5]{
\begin{minipage}{\textwidth}
\runsubsection{#1~| }\descript{ #2}\\
\location{#3}\\
#4 
\end{minipage}

\sectionsep

}

% publications
\newcommand{\publication}[2]{%
\runsection{#1}
\mycite{#2}

\sectionsep

}

% footnote without marker
\makeatletter
\def\blfootnote{\gdef\@thefnmark{}\@footnotetext}
\makeatother

%no page number
\pagenumbering{gobble}
