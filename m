Return-Path: <linux-rdma+bounces-16789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QETkFC4Ejmlf+gAAu9opvQ
	(envelope-from <linux-rdma+bounces-16789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:47:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DA12F947
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0148D3192E2C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42C35DCE8;
	Thu, 12 Feb 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="isLhFQ8c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EB35CBBF
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914674; cv=none; b=sEP6fbGTgpryT5P0rOwAvVh+p/UU4NYXJ+qD4+fiV2YPQCtzyYjHyU6sVp9rjQuKKhnBQ3iLOxF2WZYgQ0edXI/lQVSD0EaCRBHcMtcBHLbPXlaEYgVxliLsmBA+2f/rL7RiWuXxW9/jJf/2eRl+a33ooposSwwchURps8iY20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914674; c=relaxed/simple;
	bh=edDk8FSDT3aST/KwRQEPB/qYHJ7MQSbFxVlImtf8vJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRKDtgJ7U8Lpgq5NjtsTvxRftYepzpizin2y3LMWcJW9M9p2bCV59j1HNEIWmJ8QNaiZ5/BGxlr14nQVQlGQKQX+s/KtNlAsEVCpEyz+ynO1lVzIF4G0XFturh/W2ReIB1IK4PTZWAop4qS5s0pB2f3HTfXukfy71k7dZ9l6v00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=isLhFQ8c; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CCciwQ3778085
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 08:44:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=VeTEuG3ALrXwY2sPTm
	omG7PdDpuw5RWshDXjGXpC/nc=; b=isLhFQ8cInHSBIFIDkm0f/l/4QnQ4GoI+T
	Pz+3j2StCEwBTO1bqjjsuTShS8Lsw8rhwcz89R4X3O1JfROSx5uh6LGKWh6+3Gv5
	aa9/nGki3u/KaSo08nps7wKS7mMfwVevhJnGREnm9x7FpH95eC86wThX1/OSECvQ
	2zbRUdcDgj1kabAK8dwg77emJiUF+vA7h+d2V0326HT4/3gTOyzQpIMWGuvs96cd
	qo9bD2CPLqARK9XSd9rPpDOywpBBP9KEfRdTgjduVIfZ1rpIXEgLACEEbbOWiyki
	qt2fig5SUa+9wJtH1aqLwgxw03FRpcrEGfmCpW2FGDH02S57khRw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9f23am00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 08:44:30 -0800 (PST)
Received: from twshared76186.04.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 16:44:29 +0000
Received: by devvm20390.cco0.facebook.com (Postfix, from userid 721290)
	id 103B4950AC5F; Thu, 12 Feb 2026 08:44:16 -0800 (PST)
From: Evan Green <evgreen@meta.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: <wguay@meta.com>, Evan Green <evgreen@meta.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/rxe: Generate async error for r_key violations
Date: Thu, 12 Feb 2026 08:43:18 -0800
Message-ID: <20260212164355.3585961-1-evgreen@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pb1teb6hqbTYfuHNbzRgWRZlVs4fdXdh
X-Authority-Analysis: v=2.4 cv=fOI0HJae c=1 sm=1 tr=0 ts=698e036e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=AXoXSInycaPchh_YMvUA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Pb1teb6hqbTYfuHNbzRgWRZlVs4fdXdh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyNiBTYWx0ZWRfX5zx6lxAAWsmV
 AfbdfNMG1VeCmms6RXSnRGvzPaIJGQznOmQ0fZ9XqgkAZ2z5hL1DkvUg9INsO3kf14Tm2PMqnZj
 0ACMI4iDTUAT9p3DEmdz8+WZ3G35cxdRQdFcxJmvhisHEcZ892Z/8mqUjcl6BhpgYChl1VrG4pr
 2wXXB+6UvkvLCIHI2krkntwyZiNXa9omhCR6t+RV9rjS5npojTTNaypEEUpZIk2bWfuK7Ebwq/F
 Cx5cBgUMTya20ZBON7ZdeH5Ln4V77xvvq6purOYoxi01mYhZoy5H24iBK7+/YmRJOeFfGEURjCN
 q6ThAoNuUc5JFLpav4TLQX6e0qwGvqcFPabUdEAFZOIC0m3gKpe2p79kQZmd1hQVG5K5lKfcyWv
 /47O27hJsyisEIGfsT04rTxKMr4aSrkIIaGv6zFEd4f/ZbrynXubRHDwY6FDVCibrZQ7/x1gPiE
 haIpla9URFRjhHueqFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16789-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evgreen@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,meta.com:email];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D74DA12F947
X-Rspamd-Action: no action

Table 63 of the IBTA spec lists R_Key violations as a class C
error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
affiliated asynchronous error should be generated at the responder
if the error can be associated to a QP but not a particular RX WQE.

Generate an affiliated asynchronous error upon Rkey violations
if the opcode does not carry an immediate. This causes async
events at the responder for all ops that generate R_Key violations
except WRITE_WITH_IMM, where the error can ride in with the RX WQE.

Signed-off-by: Evan Green <evgreen@meta.com>

---

 drivers/infiniband/sw/rxe/rxe_resp.c  | 56 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw=
/rxe/rxe_resp.c
index 711f73e0bbb1..9faf8c09aa8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -37,6 +37,7 @@ static char *resp_state_name[] =3D {
 	[RESPST_ERR_MISSING_OPCODE_LAST_D1E]	=3D "ERR_MISSING_OPCODE_LAST_D1E",
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	=3D "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			=3D "ERR_RNR",
+	[RESPST_ERR_RKEY_VIOLATION_EVENT]	=3D "ERR_RKEY_VIOLATION_EVENT",
 	[RESPST_ERR_RKEY_VIOLATION]		=3D "ERR_RKEY_VIOLATION",
 	[RESPST_ERR_INVALIDATE_RKEY]		=3D "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			=3D "ERR_LENGTH",
@@ -423,6 +424,19 @@ static void qp_resp_from_atmeth(struct rxe_qp *qp, s=
truct rxe_pkt_info *pkt)
 	qp->resp.resid =3D sizeof(u64);
 }
=20
+/* Transition to an rkey violation state. C9-222.1 requires an async eve=
nt
+ * at the responder, but only if the error cannot be attached to an RX W=
QE.
+ * WRITE_WITH_IMM is the only op that might have that more precise RX WQ=
E
+ * to pin the error on.
+ */
+static enum resp_states get_rkey_violation_state(struct rxe_pkt_info *pk=
t)
+{
+	if (pkt->mask & RXE_IMMDT_MASK)
+		return RESPST_ERR_RKEY_VIOLATION;
+
+	return RESPST_ERR_RKEY_VIOLATION_EVENT;
+}
+
 /* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
  * if an invalid rkey is received or the rdma length is zero. For middle
  * or last packets use the stored value of mr.
@@ -486,14 +500,14 @@ static enum resp_states check_rkey(struct rxe_qp *q=
p,
 		mw =3D rxe_lookup_mw(qp, access, rkey);
 		if (!mw) {
 			rxe_dbg_qp(qp, "no MW matches rkey %#x\n", rkey);
-			state =3D RESPST_ERR_RKEY_VIOLATION;
+			state =3D get_rkey_violation_state(pkt);
 			goto err;
 		}
=20
 		mr =3D mw->mr;
 		if (!mr) {
 			rxe_dbg_qp(qp, "MW doesn't have an MR\n");
-			state =3D RESPST_ERR_RKEY_VIOLATION;
+			state =3D get_rkey_violation_state(pkt);
 			goto err;
 		}
=20
@@ -507,7 +521,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		mr =3D lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
 			rxe_dbg_qp(qp, "no MR matches rkey %#x\n", rkey);
-			state =3D RESPST_ERR_RKEY_VIOLATION;
+			state =3D get_rkey_violation_state(pkt);
 			goto err;
 		}
 	}
@@ -521,7 +535,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
=20
 	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
-		state =3D RESPST_ERR_RKEY_VIOLATION;
+		state =3D get_rkey_violation_state(pkt);
 		goto err;
 	}
=20
@@ -586,7 +600,7 @@ static enum resp_states write_data_in(struct rxe_qp *=
qp,
 	err =3D rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
 			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
 	if (err) {
-		rc =3D RESPST_ERR_RKEY_VIOLATION;
+		rc =3D get_rkey_violation_state(pkt);
 		goto out;
 	}
=20
@@ -667,7 +681,7 @@ static enum resp_states process_flush(struct rxe_qp *=
qp,
=20
 	if (res->flush.type & IB_FLUSH_PERSISTENT) {
 		if (rxe_flush_pmem_iova(mr, start, length))
-			return RESPST_ERR_RKEY_VIOLATION;
+			return get_rkey_violation_state(pkt);
 		/* Make data persistent. */
 		wmb();
 	} else if (res->flush.type & IB_FLUSH_GLOBAL) {
@@ -1383,6 +1397,20 @@ static enum resp_states duplicate_request(struct r=
xe_qp *qp,
 	return rc;
 }
=20
+static void do_qp_event(struct rxe_qp *qp, enum ib_event_type etype)
+{
+	struct ib_event event;
+	struct ib_qp *ibqp =3D &qp->ibqp;
+
+	event.event =3D etype;
+	event.device =3D ibqp->device;
+	event.element.qp =3D ibqp;
+	if (ibqp->event_handler) {
+		rxe_dbg_qp(qp, "reporting QP event %d\n", etype);
+		ibqp->event_handler(&event, ibqp->qp_context);
+	}
+}
+
 /* Process a class A or C. Both are treated the same in this implementat=
ion. */
 static void do_class_ac_error(struct rxe_qp *qp, u8 syndrome,
 			      enum ib_wc_status status)
@@ -1476,14 +1504,9 @@ static void flush_recv_queue(struct rxe_qp *qp, bo=
ol notify)
 	int err;
=20
 	if (qp->srq) {
-		if (notify && qp->ibqp.event_handler) {
-			struct ib_event ev;
+		if (notify && qp->ibqp.event_handler)
+			do_qp_event(qp, IB_EVENT_QP_LAST_WQE_REACHED);
=20
-			ev.device =3D qp->ibqp.device;
-			ev.element.qp =3D &qp->ibqp;
-			ev.event =3D IB_EVENT_QP_LAST_WQE_REACHED;
-			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
-		}
 		return;
 	}
=20
@@ -1613,6 +1636,13 @@ int rxe_receiver(struct rxe_qp *qp)
 			state =3D RESPST_CLEANUP;
 			break;
=20
+		case RESPST_ERR_RKEY_VIOLATION_EVENT:
+			if (qp_type(qp) =3D=3D IB_QPT_RC)
+				do_qp_event(qp, IB_EVENT_QP_ACCESS_ERR);
+
+			state =3D RESPST_ERR_RKEY_VIOLATION;
+			break;
+
 		case RESPST_ERR_RKEY_VIOLATION:
 			if (qp_type(qp) =3D=3D IB_QPT_RC) {
 				/* Class C */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/s=
w/rxe/rxe_verbs.h
index fd48075810dd..981f521960e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -154,6 +154,7 @@ enum resp_states {
 	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION_EVENT,
 	RESPST_ERR_RKEY_VIOLATION,
 	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
--=20
2.47.3

base-commit: c22e26bd0906e9c8325462993f01adb16b8ea2c0
branch: 260211-rxe-async-linus

