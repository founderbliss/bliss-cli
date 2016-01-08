Bliss CLI
--------
The Bliss CLI is a Ruby command-line application to collect repository and commit data for your Bliss projects.

Information Required
--------
You will need the following information before using Bliss's Collector:
*  Your Bliss API Key - You can find this by logging into bliss.ai, clicking on the Settings wheel, scrolling the the bottom and clicking "Show" on the API Key bar
*  The path of the directory where all of your repositories are located
*  Your git organization name

Dependencies
--------
Our CLI tool uses Docker to run our analysis in a controlled environment and Git to track your projects' histories.

The following is a list of required dependencies:
*  Git
*  Docker

#### Git ####

For Ubuntu/Debian machines, execute the following in terminal:
`````````
sudo apt-get install git
`````````

For RPM-based systems such as Yum, execute the following in terminal:
`````````
sudo yum install -y git
`````````

For other Operating Systems, you can download Git from:
https://git-scm.com/download

#### Docker - Windows or OSX ####
We recommend installing Docker by installing Docker Toolbox, which is located at:
https://www.docker.com/docker-toolbox

This package contains everything needed to run Docker on Windows or OSX.

#### Docker - Linux ####
To install Docker on Linux Operating Systems, follow the official Docker documentation for your Linux flavor at:
https://docs.docker.com/engine/installation/

Installation
------------
#### Homebrew ####
You can install the Bliss CLI using Homebrew:
``````
brew update
brew doctor
``````
fix any issues reported by doctor, then once brew is working perfectly
``````
brew tap founderbliss/homebrew-bliss-cli
brew install bliss
``````

Usage
--------
You will need to make sure that Docker is running and accessible before running the Bliss CLI.
Docker Machine (Windows or OSX) users can do this by executing:
```````````````
docker-machine create default
eval "$(docker-machine env default)"
```````````````

Linux users should ensure the Docker daemon is started:
```````````````
sudo service docker start
```````````````

#### Homebrew ####
If you installed Bliss CLI with Homebrew, you can run the tool using:
``````
bliss
``````

#### Unix ####
To run our Bliss CLI, navigate (cd) to the Collector directory in a shell, and type:
`````
ruby blisscollector.rb
`````

<!-- #### Windows ####
To run the CLI, navigate (cd) to the Collector directory in a shell, and type:
`````
jruby blisscollector.rb
````` -->

Configuration
------------

The first time the CLI is run, you will be prompted for the information set out in the 'Information Required' section above.
This information will be stored in a YAML file, $USER/.bliss/config.yml for future use. You can remove any of these entries to be prompted again, or you can updated the information stored in the config file.

The commands available through the CLI tool are:
*  Collector (C) - this command will collect metadata about your repositories and post them to Bliss
*  Stats (S) - this command will log all of your commits with Bliss, and calculate data such as Lines of Code, Test Lines of Code etc.
*  Linter (L) - this command will run linters over all of your outstanding commits and send the linting data to Bliss for analysis

These should be run in the following order:

Collector -> Stats -> Linter

Task scheduling (Unix)
----------------------
We recommend using cron to run Bliss on a schedule.

More information about cron can be found here:
https://en.wikipedia.org/wiki/Cron

Notes
-----
*  You will need to make sure that the machine the CLI runs on has the appropriate SSH keys setup, so that the application can 'git pull' without being prompted for a username/password combination.
*  The first time you run this tool, it will take some time to go over each commit of each repository. We suggest running the tool through once before setting up a scheduled job.

Issues
--------
Issues are reported via github "Issues":

https://github.com/founderbliss/bliss-cli/issues

To start working on an issue, take one that you can handle from the issue list. Assign it to yourself and start to work on it. Please close issues before taking new ones.

Commit guidelines
--------

Please include the issue number in the commit preceded by the hash (#) character (see https://github.com/blog/831-issues-2-0-the-next-generation). This does not need to follow a 'fixes' or 'closed' but just include
it so that we can see what commits are for which issues.

You must keep your diffs down the the minimum. Do not add extra spaces or remove extra spaces on lines that you do not need to change. Also, keep the tab set as two spaces and not reformat the code unless you are changing it. If your IDE reformats code, please disable this feature so that only the minimum diff is committed to keep the issue clean and self contained. We code review almost every commit so if the diffs are bigger than they need to be, we will be spending time looking into lines that just contain space changes which takes extra time and therefore money.

Don't break the build
--------

If you are working on a long change, you can commit locally but do not push until you have the tests passing. If you push code with broken tests, this will break our continuous build and send alerts to our team.

Authors
--------

Copyright (c) 2015 by Bliss.ai Inc

Contact
--------

Bliss.ai Inc
San Francisco, CA, USA

License
--------

Copyright (c) 2015 Bliss.ai Inc - all rights reserved

Confidential Agreement
--------

By using this code and agreeing to work on this, you agree to treat is as private and confidential information.

“Confidential Information” shall mean any and all information and documents relating to the business of the Disclosing Party that are (or are reasonably understood to be) of a confidential or proprietary nature and are provided by the Disclosing Party to the Receiving Party, whether before, on or after the date of this Agreement, either directly or indirectly, in writing, electronically, orally, by inspection of tangible objects, or otherwise.  "Confidential Information" includes, without limitation, products and services under development, source codes, software and software technology, computer programs, related documentation and manuals, formulas, inventions, techniques, processes, programs, prototypes, diagrams, schematics, technical information, customer and financial information, sales and marketing plans, any business strategies or arrangements, editorial plans, systems architecture, intellectual property, technical data, trade secrets or know-how, research initiatives, customer and subscriber lists, email directories and databases, user databases and other data about users, and engineering and hardware configuration information. Confidential Information of the Disclosing Party may also include such information disclosed to the Receiving Party by third parties.  Confidential Information disclosed to the Receiving Party by any officer, director, employee, agent or affiliate of the Disclosing Party is covered by this Agreement.  
Use of Confidential Information.  The Receiving Party shall not use or disclose and shall keep confidential any and all Confidential Information other than to explore a potential business relationship between the parties and/or to perform its obligations under any such relationship entered into by the parties, and shall use the same care as the Receiving Party uses to maintain the confidentiality of its confidential information, but in no event less than reasonable care.  The Receiving Party may disclose Confidential Information only to its officers, directors, employees, consultants, agents or advisors to whom such disclosure is necessary to evaluate, and engage in discussions concerning, the potential business relationship and/or for the Receiving Party to perform its obligations under any such relationship, and who are bound by the terms hereof or similar confidentiality obligations. The Receiving Party acknowledges that the remedy at law for any breach of the foregoing provisions of this paragraph shall be inadequate and that the Disclosing Party shall be entitled to obtain injunctive relief against any such breach or threatened breach, without posting any bond, in addition to any other remedy available to it.  Notwithstanding any other provision of this Agreement, the Receiving Party may disclose Confidential Information pursuant to any governmental, judicial or administrative order, subpoena or discovery request, provided that the Receiving Party uses reasonable efforts to notify the Disclosing Party sufficiently in advance of such order, subpoena, or discovery request so that the Disclosing Party may seek to object to such order, subpoena or request, or to make such disclosure subject to a protective order or confidentiality agreement. The Receiving Party shall not reverse engineer, disassemble or decompile any prototypes, software or other tangible objects which embody the Disclosing Party's Confidential Information and which are provided to the Receiving Party hereunder. The Receiving Party agrees that it shall take reasonable measures to protect the secrecy of and avoid disclosure and unauthorized use of the Confidential Information of the Disclosing Party. The Receiving Party shall reproduce the Disclosing Party's proprietary rights notices on any copies of Confidential Information, in the same manner in which such notices were set forth in or on the original.
“Confidential Information” shall not include information that (a) at the time of use or disclosure by the Receiving Party, is in the public domain through no fault of, action or failure to act by the Receiving Party; (b) becomes known to the Receiving Party from a third-party source without violation of any obligation of confidentiality or other wrongful or tortious act; (c) was known by the Receiving Party prior to disclosure of such information by the Disclosing Party to the Receiving Party; or (d) was independently developed by the Receiving Party without any use of Confidential Information.
Warranty.  ALL CONFIDENTIAL INFORMATION IS PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND. THE RECEIVING PARTY AGREES THAT THE DISCLOSING PARTY SHALL NOT BE LIABLE FOR ANY DAMAGES WHATSOEVER RELATING TO THE RECEIVING PARTY'S USE OF SUCH CONFIDENTIAL INFORMATION.
Return of Confidential Information.  The Receiving Party shall immediately destroy or return all tangible and, to the extent practicable, intangible material in its possession or control embodying the Disclosing Party’s Confidential Information (in any form and including, without limitation, all summaries, copies and excerpts of Confidential Information) upon the earlier of (a) the completion or termination of the dealings between the parties or (b) such time as the Disclosing Party may so request. The Disclosing Party may require that the Receiving Party will provide a certificate stating that the Receiving Party has complied with the foregoing requirements.
Notice of Breach.  The Receiving Party shall notify the Disclosing Party immediately upon discovery of any unauthorized use or disclosure of Confidential Information and shall cooperate with the Disclosing Party in every reasonable way to help the Disclosing Party regain possession of Confidential Information and prevent its further unauthorized use.
Publicity; Relationship.  Neither party shall make any representations, give any warranties or enter into any negotiations or agreements with third parties on behalf of the other party. Each party agrees that all press releases, announcements or other forms of publicity made by such party concerning any joint activity or business relationship between the parties must be pre-approved in writing by the other party.
Non-waiver.  Any failure by the Disclosing Party to enforce the Receiving Party’s strict performance, or any waiver by the Disclosing Party, of any provision of this Agreement shall not constitute a waiver of the Disclosing Party’s right to subsequently enforce such provision or any other provision of this Agreement.
No License.  Nothing in this Agreement is intended to grant any ownership or other rights to either party under any patent, trademark or copyright of the other party, nor shall this Agreement grant any party any ownership or other rights in or to the Confidential Information of the other party except as expressly set forth herein.
No Obligation.  Nothing in this Agreement shall impose any obligation upon either party to consummate a transaction with the other or upon either party to enter into discussions or negotiations with respect thereto.
Term.  The obligations of each Receiving Party hereunder shall survive until the earlier of (a) two (2) years from the date of this Agreement, or (b) such time as all Confidential Information disclosed hereunder is in the public domain through no fault of, action or failure to act by the Receiving Party.
Miscellaneous.

This Agreement shall be governed by and construed in accordance with the laws of the State of California without regard to the conflicts of law principles of such State.  All actions in connection with this Agreement shall be brought only in the state or federal courts sitting in the City, County and State of New York.  Those courts shall have jurisdiction over the parties in connection with any such lawsuit and venue shall be appropriate in those courts.  Process may be served in any manner permitted by the rules of the court having jurisdiction.
Any notice required or permitted under this Agreement shall be in writing and delivered by personal delivery, a nationally-recognized express courier assuring overnight delivery, confirmed facsimile transmission or first-class certified or registered mail, return receipt requested, and will be deemed given (i) upon personal delivery; (ii) one (1) business day after deposit with the express courier or confirmation of receipt of facsimile; or (iii) five (5) days after deposit in the mail.  Such notice shall be sent to the party for which intended at the address set forth below its signature hereto or at such other address as that party may specify in writing pursuant to this section, and, in the case of the worker via email or odes notification,  and in the case of Bliss.ai Inc, with a copy to: 500 Westover Dr #1415, Sanford NC 27330, Attn: Ian Connor, CTO or via email to ian@bliss.ai
In the event that any one or more of the provisions of this Agreement shall be held invalid, illegal or unenforceable in any respect, or the validity, legality and enforceability of any one or more of the provisions contained herein shall be held to be excessively broad as to duration, activity or subject, such provision shall be construed by limiting and reducing such provision so as to be enforceable to the maximum extent compatible with applicable law.
In any action to enforce any of the terms or provisions of this Agreement or on account of the breach hereof, the prevailing party shall be entitled to recover all its expenses, including, without limitation, reasonable attorneys’ fees.
This Agreement shall inure to the benefit of, and be binding upon, the parties and their respective successors and assigns; provided that neither party may assign this Agreement without the prior, written consent of the other party.
Execution and acceptance of this agreement may be evidenced by pulling the git repository from github or downloading any portion except the README by web browser or any other means.
