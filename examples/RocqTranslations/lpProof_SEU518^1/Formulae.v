Require Import CNFeq.
Require Import EPrules.
Require Import MetaTheorems.
Require Import Bool.
Require Import Classic.
Require Import Conj.
Require Import Disj.
Require Import Epsilon.
Require Import Eq.
Require Import FOL.
Require Import FunExt.
Require Import HOL.
Require Import Impred.
Require Import Prod.
Require Import PropExt.
Require Import Signature.
Require Import mappings.
Axiom exu_def : exu = (fun v113810 : iota_type -> o => ex_ iota_type (fun v113811 : iota_type => (v113810 v113811) /\ (@all iota_type (fun v113812 : iota_type => (v113810 v113812) -> v113811 = v113812)))).
Axiom setextAx_def : setextAx = (@all iota_type (fun v113813 : iota_type => @all iota_type (fun v113814 : iota_type => (@all iota_type (fun v113815 : iota_type => (in_ v113815 v113813) = (in_ v113815 v113814))) -> v113813 = v113814))).
Axiom emptysetAx_def : emptysetAx = (@all iota_type (fun v113816 : iota_type => ~ (in_ v113816 emptyset))).
Axiom setadjoinAx_def : setadjoinAx = (@all iota_type (fun v113817 : iota_type => @all iota_type (fun v113818 : iota_type => @all iota_type (fun v113819 : iota_type => (in_ v113819 (setadjoin v113817 v113818)) = ((v113819 = v113817) \/ (in_ v113819 v113818)))))).
Axiom powersetAx_def : powersetAx = (@all iota_type (fun v113820 : iota_type => @all iota_type (fun v113821 : iota_type => (in_ v113821 (powerset v113820)) = (@all iota_type (fun v113822 : iota_type => (in_ v113822 v113821) -> in_ v113822 v113820))))).
Axiom setunionAx_def : setunionAx = (@all iota_type (fun v113823 : iota_type => @all iota_type (fun v113824 : iota_type => (in_ v113824 (setunion v113823)) = (ex_ iota_type (fun v113825 : iota_type => (in_ v113824 v113825) /\ (in_ v113825 v113823)))))).
Axiom omega0Ax_def : omega0Ax = (in_ emptyset omega).
Axiom omegaSAx_def : omegaSAx = (@all iota_type (fun v113826 : iota_type => (in_ v113826 omega) -> in_ (setadjoin v113826 v113826) omega)).
Axiom omegaIndAx_def : omegaIndAx = (@all iota_type (fun v113827 : iota_type => ((in_ emptyset v113827) /\ (@all iota_type (fun v113828 : iota_type => ((in_ v113828 omega) /\ (in_ v113828 v113827)) -> in_ (setadjoin v113828 v113828) v113827))) -> @all iota_type (fun v113829 : iota_type => (in_ v113829 omega) -> in_ v113829 v113827))).
Axiom replAx_def : replAx = (@all (iota_type -> iota_type -> o) (fun v113830 : iota_type -> iota_type -> o => @all iota_type (fun v113831 : iota_type => (@all iota_type (fun v113832 : iota_type => (in_ v113832 v113831) -> exu (v113830 v113832))) -> ex_ iota_type (fun v113833 : iota_type => @all iota_type (fun v113834 : iota_type => (in_ v113834 v113833) = (ex_ iota_type (fun v113835 : iota_type => (in_ v113835 v113831) /\ (v113830 v113835 v113834)))))))).
Axiom foundationAx_def : foundationAx = (@all iota_type (fun v113836 : iota_type => (ex_ iota_type (fun v113837 : iota_type => in_ v113837 v113836)) -> ex_ iota_type (fun v113838 : iota_type => (in_ v113838 v113836) /\ (~ (ex_ iota_type (fun v113839 : iota_type => (in_ v113839 v113838) /\ (in_ v113839 v113836))))))).
Axiom wellorderingAx_def : wellorderingAx = (@all iota_type (fun v113840 : iota_type => ex_ iota_type (fun v113841 : iota_type => (@all iota_type (fun v113842 : iota_type => (in_ v113842 v113841) -> @all iota_type (fun v113843 : iota_type => (in_ v113843 v113842) -> in_ v113843 v113840))) /\ ((@all iota_type (fun v113844 : iota_type => @all iota_type (fun v113845 : iota_type => ((in_ v113844 v113840) /\ (in_ v113845 v113840)) -> (@all iota_type (fun v113846 : iota_type => (in_ v113846 v113841) -> (in_ v113844 v113846) = (in_ v113845 v113846))) -> v113844 = v113845))) /\ ((@all iota_type (fun v113847 : iota_type => @all iota_type (fun v113848 : iota_type => ((in_ v113847 v113841) /\ (in_ v113848 v113841)) -> (@all iota_type (fun v113849 : iota_type => (in_ v113849 v113847) -> in_ v113849 v113848)) \/ (@all iota_type (fun v113850 : iota_type => (in_ v113850 v113848) -> in_ v113850 v113847))))) /\ (@all iota_type (fun v113851 : iota_type => ((@all iota_type (fun v113852 : iota_type => (in_ v113852 v113851) -> in_ v113852 v113840)) /\ (ex_ iota_type (fun v113853 : iota_type => in_ v113853 v113851))) -> ex_ iota_type (fun v113854 : iota_type => ex_ iota_type (fun v113855 : iota_type => (in_ v113854 v113841) /\ ((in_ v113855 v113851) /\ ((~ (ex_ iota_type (fun v113856 : iota_type => (in_ v113856 v113854) /\ (in_ v113856 v113851)))) /\ (@all iota_type (fun v113857 : iota_type => (in_ v113857 v113841) -> (@all iota_type (fun v113858 : iota_type => (in_ v113858 v113857) -> in_ v113858 v113854)) \/ (in_ v113855 v113857)))))))))))))).
Axiom descrp_def : descrp = (@all (iota_type -> o) (fun v113859 : iota_type -> o => (exu v113859) -> v113859 (descr v113859))).
Axiom dsetconstrI_def : dsetconstrI = (@all iota_type (fun v113860 : iota_type => @all (iota_type -> o) (fun v113861 : iota_type -> o => @all iota_type (fun v113862 : iota_type => (in_ v113862 v113860) -> (v113861 v113862) -> in_ v113862 (dsetconstr v113860 v113861))))).
Axiom dsetconstrEL_def : dsetconstrEL = (@all iota_type (fun v113863 : iota_type => @all (iota_type -> o) (fun v113864 : iota_type -> o => @all iota_type (fun v113865 : iota_type => (in_ v113865 (dsetconstr v113863 v113864)) -> in_ v113865 v113863)))).
Axiom dsetconstrER_def : dsetconstrER = (@all iota_type (fun v113866 : iota_type => @all (iota_type -> o) (fun v113867 : iota_type -> o => @all iota_type (fun v113868 : iota_type => (in_ v113868 (dsetconstr v113866 v113867)) -> v113867 v113868)))).
Axiom exuE1_def : exuE1 = (@all (iota_type -> o) (fun v113869 : iota_type -> o => (exu v113869) -> ex_ iota_type (fun v113870 : iota_type => (v113869 v113870) /\ (@all iota_type (fun v113871 : iota_type => (v113869 v113871) -> v113870 = v113871))))).
Axiom prop2set_def : prop2set = (fun v113872 : o => dsetconstr (powerset emptyset) (fun v113873 : iota_type => v113872)).
Axiom prop2setE_def : prop2setE = (@all o (fun v113874 : o => @all iota_type (fun v113875 : iota_type => (in_ v113875 (prop2set v113874)) -> v113874))).
Axiom emptysetE_def : emptysetE = (@all iota_type (fun v113876 : iota_type => (in_ v113876 emptyset) -> @all o (fun v113877 : o => v113877))).
Axiom emptysetimpfalse_def : emptysetimpfalse = (@all iota_type (fun v113878 : iota_type => (in_ v113878 emptyset) -> False)).
Axiom notinemptyset_def : notinemptyset = (@all iota_type (fun v113879 : iota_type => ~ (in_ v113879 emptyset))).
Axiom exuE3e_def : exuE3e = (@all (iota_type -> o) (fun v113880 : iota_type -> o => (exu v113880) -> ex_ iota_type (fun v113881 : iota_type => v113880 v113881))).
Axiom setext_def : setext = (@all iota_type (fun v113882 : iota_type => @all iota_type (fun v113883 : iota_type => (@all iota_type (fun v113884 : iota_type => (in_ v113884 v113882) -> in_ v113884 v113883)) -> (@all iota_type (fun v113885 : iota_type => (in_ v113885 v113883) -> in_ v113885 v113882)) -> v113882 = v113883))).
Axiom emptyI_def : emptyI = (@all iota_type (fun v113886 : iota_type => (@all iota_type (fun v113887 : iota_type => ~ (in_ v113887 v113886))) -> v113886 = emptyset)).
Axiom noeltsimpempty_def : noeltsimpempty = (@all iota_type (fun v113888 : iota_type => (@all iota_type (fun v113889 : iota_type => ~ (in_ v113889 v113888))) -> v113888 = emptyset)).
Axiom setbeta_def : setbeta = (@all iota_type (fun v113890 : iota_type => @all (iota_type -> o) (fun v113891 : iota_type -> o => @all iota_type (fun v113892 : iota_type => (in_ v113892 v113890) -> (in_ v113892 (dsetconstr v113890 v113891)) = (v113891 v113892))))).
Axiom nonempty_def : nonempty = (fun v113893 : iota_type => ~ (v113893 = emptyset)).
Axiom nonemptyE1_def : nonemptyE1 = (@all iota_type (fun v113894 : iota_type => (nonempty v113894) -> ex_ iota_type (fun v113895 : iota_type => in_ v113895 v113894))).
Axiom nonemptyI_def : nonemptyI = (@all iota_type (fun v113896 : iota_type => @all (iota_type -> o) (fun v113897 : iota_type -> o => @all iota_type (fun v113898 : iota_type => (in_ v113898 v113896) -> (v113897 v113898) -> nonempty (dsetconstr v113896 v113897))))).
Axiom nonemptyI1_def : nonemptyI1 = (@all iota_type (fun v113899 : iota_type => (ex_ iota_type (fun v113900 : iota_type => in_ v113900 v113899)) -> nonempty v113899)).
Axiom setadjoinIL_def : setadjoinIL = (@all iota_type (fun v113901 : iota_type => @all iota_type (fun v113902 : iota_type => in_ v113901 (setadjoin v113901 v113902)))).
Axiom emptyinunitempty_def : emptyinunitempty = (in_ emptyset (setadjoin emptyset emptyset)).
Axiom setadjoinIR_def : setadjoinIR = (@all iota_type (fun v113903 : iota_type => @all iota_type (fun v113904 : iota_type => @all iota_type (fun v113905 : iota_type => (in_ v113905 v113904) -> in_ v113905 (setadjoin v113903 v113904))))).
Axiom setadjoinE_def : setadjoinE = (@all iota_type (fun v113906 : iota_type => @all iota_type (fun v113907 : iota_type => @all iota_type (fun v113908 : iota_type => (in_ v113908 (setadjoin v113906 v113907)) -> @all o (fun v113909 : o => ((v113908 = v113906) -> v113909) -> ((in_ v113908 v113907) -> v113909) -> v113909))))).
Axiom setadjoinOr_def : setadjoinOr = (@all iota_type (fun v113910 : iota_type => @all iota_type (fun v113911 : iota_type => @all iota_type (fun v113912 : iota_type => (in_ v113912 (setadjoin v113910 v113911)) -> (v113912 = v113910) \/ (in_ v113912 v113911))))).
Axiom setoftrueEq_def : setoftrueEq = (@all iota_type (fun v113913 : iota_type => (dsetconstr v113913 (fun v113914 : iota_type => True)) = v113913)).
