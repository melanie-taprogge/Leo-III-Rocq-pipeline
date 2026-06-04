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
Axiom exu_def : exu = (fun v111620 : nat -> o => ex_ nat (fun v111621 : nat => (v111620 v111621) /\ (@all nat (fun v111622 : nat => (v111620 v111622) -> v111621 = v111622)))).
Axiom setextAx_def : setextAx = (@all nat (fun v111623 : nat => @all nat (fun v111624 : nat => (@all nat (fun v111625 : nat => (in_ v111625 v111623) = (in_ v111625 v111624))) -> v111623 = v111624))).
Axiom emptysetAx_def : emptysetAx = (@all nat (fun v111626 : nat => ~ (in_ v111626 emptyset))).
Axiom setadjoinAx_def : setadjoinAx = (@all nat (fun v111627 : nat => @all nat (fun v111628 : nat => @all nat (fun v111629 : nat => (in_ v111629 (setadjoin v111627 v111628)) = ((v111629 = v111627) \/ (in_ v111629 v111628)))))).
Axiom powersetAx_def : powersetAx = (@all nat (fun v111630 : nat => @all nat (fun v111631 : nat => (in_ v111631 (powerset v111630)) = (@all nat (fun v111632 : nat => (in_ v111632 v111631) -> in_ v111632 v111630))))).
Axiom setunionAx_def : setunionAx = (@all nat (fun v111633 : nat => @all nat (fun v111634 : nat => (in_ v111634 (setunion v111633)) = (ex_ nat (fun v111635 : nat => (in_ v111634 v111635) /\ (in_ v111635 v111633)))))).
Axiom omega0Ax_def : omega0Ax = (in_ emptyset omega).
Axiom omegaSAx_def : omegaSAx = (@all nat (fun v111636 : nat => (in_ v111636 omega) -> in_ (setadjoin v111636 v111636) omega)).
Axiom omegaIndAx_def : omegaIndAx = (@all nat (fun v111637 : nat => ((in_ emptyset v111637) /\ (@all nat (fun v111638 : nat => ((in_ v111638 omega) /\ (in_ v111638 v111637)) -> in_ (setadjoin v111638 v111638) v111637))) -> @all nat (fun v111639 : nat => (in_ v111639 omega) -> in_ v111639 v111637))).
Axiom replAx_def : replAx = (@all (nat -> nat -> o) (fun v111640 : nat -> nat -> o => @all nat (fun v111641 : nat => (@all nat (fun v111642 : nat => (in_ v111642 v111641) -> exu (v111640 v111642))) -> ex_ nat (fun v111643 : nat => @all nat (fun v111644 : nat => (in_ v111644 v111643) = (ex_ nat (fun v111645 : nat => (in_ v111645 v111641) /\ (v111640 v111645 v111644)))))))).
Axiom foundationAx_def : foundationAx = (@all nat (fun v111646 : nat => (ex_ nat (fun v111647 : nat => in_ v111647 v111646)) -> ex_ nat (fun v111648 : nat => (in_ v111648 v111646) /\ (~ (ex_ nat (fun v111649 : nat => (in_ v111649 v111648) /\ (in_ v111649 v111646))))))).
Axiom wellorderingAx_def : wellorderingAx = (@all nat (fun v111650 : nat => ex_ nat (fun v111651 : nat => (@all nat (fun v111652 : nat => (in_ v111652 v111651) -> @all nat (fun v111653 : nat => (in_ v111653 v111652) -> in_ v111653 v111650))) /\ ((@all nat (fun v111654 : nat => @all nat (fun v111655 : nat => ((in_ v111654 v111650) /\ (in_ v111655 v111650)) -> (@all nat (fun v111656 : nat => (in_ v111656 v111651) -> (in_ v111654 v111656) = (in_ v111655 v111656))) -> v111654 = v111655))) /\ ((@all nat (fun v111657 : nat => @all nat (fun v111658 : nat => ((in_ v111657 v111651) /\ (in_ v111658 v111651)) -> (@all nat (fun v111659 : nat => (in_ v111659 v111657) -> in_ v111659 v111658)) \/ (@all nat (fun v111660 : nat => (in_ v111660 v111658) -> in_ v111660 v111657))))) /\ (@all nat (fun v111661 : nat => ((@all nat (fun v111662 : nat => (in_ v111662 v111661) -> in_ v111662 v111650)) /\ (ex_ nat (fun v111663 : nat => in_ v111663 v111661))) -> ex_ nat (fun v111664 : nat => ex_ nat (fun v111665 : nat => (in_ v111664 v111651) /\ ((in_ v111665 v111661) /\ ((~ (ex_ nat (fun v111666 : nat => (in_ v111666 v111664) /\ (in_ v111666 v111661)))) /\ (@all nat (fun v111667 : nat => (in_ v111667 v111651) -> (@all nat (fun v111668 : nat => (in_ v111668 v111667) -> in_ v111668 v111664)) \/ (in_ v111665 v111667)))))))))))))).
Axiom descrp_def : descrp = (@all (nat -> o) (fun v111669 : nat -> o => (exu v111669) -> v111669 (descr v111669))).
Axiom dsetconstrI_def : dsetconstrI = (@all nat (fun v111670 : nat => @all (nat -> o) (fun v111671 : nat -> o => @all nat (fun v111672 : nat => (in_ v111672 v111670) -> (v111671 v111672) -> in_ v111672 (dsetconstr v111670 v111671))))).
Axiom dsetconstrEL_def : dsetconstrEL = (@all nat (fun v111673 : nat => @all (nat -> o) (fun v111674 : nat -> o => @all nat (fun v111675 : nat => (in_ v111675 (dsetconstr v111673 v111674)) -> in_ v111675 v111673)))).
Axiom dsetconstrER_def : dsetconstrER = (@all nat (fun v111676 : nat => @all (nat -> o) (fun v111677 : nat -> o => @all nat (fun v111678 : nat => (in_ v111678 (dsetconstr v111676 v111677)) -> v111677 v111678)))).
Axiom exuE1_def : exuE1 = (@all (nat -> o) (fun v111679 : nat -> o => (exu v111679) -> ex_ nat (fun v111680 : nat => (v111679 v111680) /\ (@all nat (fun v111681 : nat => (v111679 v111681) -> v111680 = v111681))))).
Axiom prop2set_def : prop2set = (fun v111682 : o => dsetconstr (powerset emptyset) (fun v111683 : nat => v111682)).
Axiom prop2setE_def : prop2setE = (@all o (fun v111684 : o => @all nat (fun v111685 : nat => (in_ v111685 (prop2set v111684)) -> v111684))).
Axiom emptysetE_def : emptysetE = (@all nat (fun v111686 : nat => (in_ v111686 emptyset) -> @all o (fun v111687 : o => v111687))).
Axiom emptysetimpfalse_def : emptysetimpfalse = (@all nat (fun v111688 : nat => (in_ v111688 emptyset) -> False)).
Axiom notinemptyset_def : notinemptyset = (@all nat (fun v111689 : nat => ~ (in_ v111689 emptyset))).
Axiom exuE3e_def : exuE3e = (@all (nat -> o) (fun v111690 : nat -> o => (exu v111690) -> ex_ nat (fun v111691 : nat => v111690 v111691))).
Axiom setext_def : setext = (@all nat (fun v111692 : nat => @all nat (fun v111693 : nat => (@all nat (fun v111694 : nat => (in_ v111694 v111692) -> in_ v111694 v111693)) -> (@all nat (fun v111695 : nat => (in_ v111695 v111693) -> in_ v111695 v111692)) -> v111692 = v111693))).
Axiom emptyI_def : emptyI = (@all nat (fun v111696 : nat => (@all nat (fun v111697 : nat => ~ (in_ v111697 v111696))) -> v111696 = emptyset)).
Axiom noeltsimpempty_def : noeltsimpempty = (@all nat (fun v111698 : nat => (@all nat (fun v111699 : nat => ~ (in_ v111699 v111698))) -> v111698 = emptyset)).
Axiom setbeta_def : setbeta = (@all nat (fun v111700 : nat => @all (nat -> o) (fun v111701 : nat -> o => @all nat (fun v111702 : nat => (in_ v111702 v111700) -> (in_ v111702 (dsetconstr v111700 v111701)) = (v111701 v111702))))).
Axiom nonempty_def : nonempty = (fun v111703 : nat => ~ (v111703 = emptyset)).
Axiom nonemptyE1_def : nonemptyE1 = (@all nat (fun v111704 : nat => (nonempty v111704) -> ex_ nat (fun v111705 : nat => in_ v111705 v111704))).
Axiom nonemptyI_def : nonemptyI = (@all nat (fun v111706 : nat => @all (nat -> o) (fun v111707 : nat -> o => @all nat (fun v111708 : nat => (in_ v111708 v111706) -> (v111707 v111708) -> nonempty (dsetconstr v111706 v111707))))).
Axiom nonemptyI1_def : nonemptyI1 = (@all nat (fun v111709 : nat => (ex_ nat (fun v111710 : nat => in_ v111710 v111709)) -> nonempty v111709)).
Axiom setadjoinIL_def : setadjoinIL = (@all nat (fun v111711 : nat => @all nat (fun v111712 : nat => in_ v111711 (setadjoin v111711 v111712)))).
Axiom emptyinunitempty_def : emptyinunitempty = (in_ emptyset (setadjoin emptyset emptyset)).
Axiom setadjoinIR_def : setadjoinIR = (@all nat (fun v111713 : nat => @all nat (fun v111714 : nat => @all nat (fun v111715 : nat => (in_ v111715 v111714) -> in_ v111715 (setadjoin v111713 v111714))))).
Axiom setadjoinE_def : setadjoinE = (@all nat (fun v111716 : nat => @all nat (fun v111717 : nat => @all nat (fun v111718 : nat => (in_ v111718 (setadjoin v111716 v111717)) -> @all o (fun v111719 : o => ((v111718 = v111716) -> v111719) -> ((in_ v111718 v111717) -> v111719) -> v111719))))).
Axiom setadjoinOr_def : setadjoinOr = (@all nat (fun v111720 : nat => @all nat (fun v111721 : nat => @all nat (fun v111722 : nat => (in_ v111722 (setadjoin v111720 v111721)) -> (v111722 = v111720) \/ (in_ v111722 v111721))))).
Axiom setoftrueEq_def : setoftrueEq = (@all nat (fun v111723 : nat => (dsetconstr v111723 (fun v111724 : nat => True)) = v111723)).
