%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer CV
% LaTeX Class
% Version 1.0 (28/1/19)
%
% This class originates from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Jan Vorisek (jan@vorisek.me)
% Based on a template by Jan Küster (info@jankuester.com)
% Modified for LaTeX Templates by Vel (vel@LaTeXTemplates.com)
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[2019/01/28 Developer CV class v1.0]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0mm} % Suppress paragraph indentation

\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links

\newcommand{\lorem}{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.} % Dummy text

\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)

\usepackage[none]{hyphenat} % avoid hyphenating words

\usepackage{lastpage} % to get the last page number
\usepackage{fancyhdr} % to change header and footers
\pagestyle{fancy} % use header and footer
\fancyhf{} % clear header and footer
\renewcommand{\headrulewidth}{0pt} % stop the top line

\usepackage[bottom]{footmisc}

\usepackage[document]{ragged2e}

% \sloppy is too much, try to force wrap sentences using microtype (play with kerning)
\usepackage{microtype}
\emergencystretch 3em

% create refs without all the garbage
\usepackage[backend=biber,maxnames=999,style=numeric,sorting=ydnt]{biblatex}
\DeclareFieldFormat{labelnumberwidth}{}
\setlength{\biblabelsep}{0pt}

\usepackage{setspace} % Provide doublespace and single space

\usepackage{ifthen} % check if arguments is empty

\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{linecolor}{HTML}{BEBEBE} 

%----------------------------------------------------------------------------------------
%	PAGE LAYOUT
%----------------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

\geometry{
	paper=letterpaper, % Paper size, change to letterpaper for US letter size
	top=1.25cm, % Top margin
	bottom=2.25cm, % Bottom margin
	left=1.25cm, % Left margin
	right=1.25cm, % Right margin
	headheight=0cm, % Header height
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0cm, % Space from the top margin to the baseline of the header
}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters

\usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
%\usepackage[default]{gillius}
%\usepackage{roboto}

\renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used

%------------------------------------------------

% Command to vertically centre adjacent content
\newcommand{\vcenteredhbox}[1]{% The only parameter is for the content to centre
	\begingroup%
		\setbox0=\hbox{#1}\parbox{\wd0}{\box0}%
	\endgroup%
}

\usepackage{fontawesome} % Required for FontAwesome icons

% Command to output an icon in a black square box with text to the right
\newcommand{\icon}[3]{% The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
	\vcenteredhbox{\large\csname fa#1\endcsname}% Icon and box
	\hspace{0.2cm}% Whitespace
	\vcenteredhbox{#3}% Text
	\vspace*{0.1cm}
}

%----------------------------------------------------------------------------------------
%	GRAPHICS DEFINITIONS
%---------------------------------------------------------------------------------------- 

\usepackage{tikz} % Required for creating the plots
\usetikzlibrary{shapes, backgrounds}
\tikzset{x=1cm, y=1cm} % Default tikz units



%----------------------------------------------------------------------------------------
%	CUSTOM SECTIONS
%----------------------------------------------------------------------------------------

% Command to output section title headings
\newcommand{\cvsect}[1]{% The only parameter is the section text
	\colorbox{black}{\textcolor{white}{\MakeUppercase{\textbf{#1}}}}%
	\vspace{6pt}
}

% Environment to hold a new list of entries
\newenvironment{smallQuote}{
	\begin{quoting}\footnotesize
}{
	\end{quoting}\normalsize
}

\newlength\GoldenTextWidth%
\newlength\GoldenTextMargin%
\renewenvironment{quote}[1]{%
	\GetTextWidth{\GoldenTextWidth}{#1}
	\setlength{\GoldenTextMargin}{\textwidth - \GoldenTextWidth}
	\setlength{\GoldenTextMargin}{0.5\GoldenTextMargin}
	\list{}{%
	  \leftmargin\GoldenTextMargin   % this is the adjusting screw
	  \rightmargin\leftmargin
	}
	\item\relax
 }
 {\endlist}

\newcommand{\tightentry}[3]{%
	\begin{minipage}[t]{0.195\textwidth}%
		{\footnotesize#1} \hfill%
	\end{minipage}%
	\begin{minipage}[t]{0.805\textwidth}%
		{%
			\textbf{#2} \hfill {\footnotesize \textbf{\textcolor{black}{#3}}}%
		}%
	\end{minipage}%
	}

\newcommand{\entrys}[4]{%
	\begin{minipage}[t]{0.195\textwidth}%
		{\footnotesize#1} \hfill%
	\end{minipage}%
	\begin{minipage}[t]{0.805\textwidth}%
		{%
			\textbf{#2} \hfill {\footnotesize \textbf{\textcolor{black}{#3}}} \\
			{#4} \hfill%
		}%
	\end{minipage} \\

	}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{%
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}


\newcommand{\timestamp}[1]{%
	\item[]{\footnotesize#1}%
	}

% bulleted list
\usepackage{etoolbox}
\usepackage{pgffor}
\newtoggle{firstmember}
\newcommand*{\bulletedlist}[1]{%
    \global\toggletrue{firstmember}%
    \foreach \member in {#1} {%
        \iftoggle{firstmember}{\member}{ \textbullet{} \member}%
        \global\togglefalse{firstmember}%
    	}%
	}

% justify but dont break words
\def\sloppy{%
  \tolerance 9999%
  \emergencystretch 3em%
  \hfuzz .5\p@
  \vfuzz\hfuzz}

%stop indenting items
\setlength{\itemindent}{-2em}


% comma separated citations

\usepackage{xparse}
\ExplSyntaxOn
\NewDocumentCommand{\mycite}{ m }{
    \clist_map_inline:nn{#1}{
		\fullcite{##1}\\
		\vspace*{6pt}
		}
    }
\ExplSyntaxOff

% publications
\newcommand{\publication}[2]{
\cvsect{#1}

\indent\mycite{#2}

}


% footnote without marker
\makeatletter
\def\blfootnote{\gdef\@thefnmark{}\@footnotetext}
\makeatother

% better underline
\usepackage{contour}
\contourlength{0.8pt}
\newcommand{\uline}[1]{%
  \underline{\smash{#1}\vphantom{T}}\vphantom{#1}%
  \llap{\contour{white}{#1}}%
}

\newcommand{\RTLpar}{% right-to-left paragraph alignment
	\justifying%
	\leftskip=0pt plus .5fil%
	\rightskip=0pt plus -.5fil%
	\parfillskip=0pt plus .5fil%'
}

\usepackage{quoting}
\quotingsetup{vskip=0pt}

% catch the the text width
\newcommand*\GetTextWidth[3][\normalfont]{{#1%
    \settowidth{#2}{abcdefghijklmnopqrstuvwxyz}%
    \setlength{#2}{0.03193#2}%
    \addtolength{#2}{0.44961pt}%
    \setlength{#2}{#3#2}%
	\global#2=#2}}
	
	