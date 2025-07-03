Return-Path: <linux-rdma+bounces-11874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CFAF7ECC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B957417A8DF
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096728934E;
	Thu,  3 Jul 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="i5w4TDcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83F288C92
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563642; cv=none; b=EdbjLP+81GMgJBDb2UVwSDmtm0bHMjobJWZGJ/N+X/UbBz+j07E6flzc/ZfNMTG7A1mWQDf2Yr5D1dJR3osBnqCyaQTOv+DAHOUu1htjKlyFUwSU+R5D4ieW0j8kklDUrDLS3946yV4i1rLApcRfQPnS99MK8s4+8gqMDfz/o/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563642; c=relaxed/simple;
	bh=Tdras9N3qBYdmyJHXNaRUVGISVENXmc5pBvtQ0dP6p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kX+o63hAjE2TYXRSuAat4mAh3G3OB9fDB1odZWB7L3lNA9/zTYy+Je6yi5gekNPJqFK++qTaKHw4PIZKSnrrBeG8vM1DDC/22+cB7HLGzCtg6oY+11NhGdj1TYGL3HbTbLiZA5FgLe1VZHNOYbrh0j87Y3wqb3XMobA6j8GVFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=i5w4TDcr; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=uCw5ZVS+7qFZU9UOpgI7XTvVobmSGv4hF8+aqqf3PkE=; b=i5w4TDcrAu82DQRZ1ZpRN+SBmi
	Ej4AqMgwU4oz9hmmjBkmDIE3G/ivDNFgGG7aNmiE5eTGvmBiwkBRaVChc6//2iUJX9f1RFo1J1JAy
	6xqzzuvxx9rU4dG6/F6dtmVCeBcaQ3v6oqFVX7CtDtJ1y7QMLs/u2qyqpHvY9/JWO9oCZ8SCEB+dd
	rUXC7MZ4X+biSSl178WC0oGH1AtXcrbZR3QXATWLyu7pKLrKhoMaBgsQDfVEuIyUVWJkGkRkhfGAg
	XggBsut2/J8+EGBweYY4XdZJZZuQl4rw3l3LutgcwAyW7bfmyWKcDpqxxNNVcpIFxUV25D5BUBREs
	ZJeDdViDJ/8u7immaArbBXt6dwIQ/9tyPqle7gZYhs6LQsaoVF+BzzzS23mpQtVqsvDPwdhR8U6n/
	fajn5LP5RrUxVbQ7L6yTeo8Hr26WAGxNwnOdVYI1GZolk6CUDCt60A4zjZcZ5gnWpd2+AT/Ya+K9A
	N5CekwDKLeznOVdcrzmmJpeL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNiP-00Dp2k-0H;
	Thu, 03 Jul 2025 17:27:17 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 4/8] RDMA/siw: make use of sdev->options.* and avoid globals
Date: Thu,  3 Jul 2025 19:26:15 +0200
Message-Id: <de30b582ad26f61a5d67d2dd62b650c0a005c5f2.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1751561826.git.metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw_cm.c    | 42 +++++++++++++++++----------
 drivers/infiniband/sw/siw/siw_qp_tx.c |  3 +-
 drivers/infiniband/sw/siw/siw_verbs.c |  2 +-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index aba97d674402..9640450e1f87 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -601,6 +601,9 @@ static int siw_recv_mpa_rr(struct siw_cep *cep)
  */
 static int siw_proc_mpareq(struct siw_cep *cep)
 {
+	struct siw_device *sdev = cep->sdev;
+	const bool local_crc_required = sdev->options.crc_required;
+	const bool local_crc_strict = sdev->options.crc_strict;
 	struct mpa_rr *req;
 	int version, rv;
 	u16 pd_len;
@@ -648,11 +651,11 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 		 * connection with CRC if local CRC off enforced by
 		 * 'mpa_crc_strict' module parameter.
 		 */
-		if (!mpa_crc_required && mpa_crc_strict)
+		if (!local_crc_required && local_crc_strict)
 			goto reject_conn;
 
 		/* Enable CRC if requested by module parameter */
-		if (mpa_crc_required)
+		if (local_crc_required)
 			req->params.bits |= MPA_RR_FLAG_CRC;
 	}
 	if (cep->enhanced_rdma_conn_est) {
@@ -705,13 +708,13 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 reject_conn:
 	siw_dbg_cep(cep, "reject: crc %d:%d:%d, m %d:%d\n",
 		    req->params.bits & MPA_RR_FLAG_CRC ? 1 : 0,
-		    mpa_crc_required, mpa_crc_strict,
+		    local_crc_required, local_crc_strict,
 		    req->params.bits & MPA_RR_FLAG_MARKERS ? 1 : 0, 0);
 
 	req->params.bits &= ~MPA_RR_FLAG_MARKERS;
 	req->params.bits |= MPA_RR_FLAG_REJECT;
 
-	if (!mpa_crc_required && mpa_crc_strict)
+	if (!local_crc_required && local_crc_strict)
 		req->params.bits &= ~MPA_RR_FLAG_CRC;
 
 	if (pd_len)
@@ -729,6 +732,9 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 	struct siw_qp_attrs qp_attrs;
 	enum siw_qp_attr_mask qp_attr_mask;
 	struct siw_qp *qp = cep->qp;
+	struct siw_device *sdev = cep->sdev;
+	const bool local_crc_required = sdev->options.crc_required;
+	const bool local_crc_strict = sdev->options.crc_strict;
 	struct mpa_rr *rep;
 	int rv;
 	u16 rep_ord;
@@ -762,17 +768,17 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 
 		return -ECONNRESET;
 	}
-	if (try_gso && rep->params.bits & MPA_RR_FLAG_GSO_EXP) {
+	if (sdev->options.try_gso && rep->params.bits & MPA_RR_FLAG_GSO_EXP) {
 		siw_dbg_cep(cep, "peer allows GSO on TX\n");
 		qp->tx_ctx.gso_seg_limit = 0;
 	}
 	if ((rep->params.bits & MPA_RR_FLAG_MARKERS) ||
-	    (mpa_crc_required && !(rep->params.bits & MPA_RR_FLAG_CRC)) ||
-	    (mpa_crc_strict && !mpa_crc_required &&
+	    (local_crc_required && !(rep->params.bits & MPA_RR_FLAG_CRC)) ||
+	    (local_crc_strict && !local_crc_required &&
 	     (rep->params.bits & MPA_RR_FLAG_CRC))) {
 		siw_dbg_cep(cep, "reply unsupp: crc %d:%d:%d, m %d:%d\n",
 			    rep->params.bits & MPA_RR_FLAG_CRC ? 1 : 0,
-			    mpa_crc_required, mpa_crc_strict,
+			    local_crc_required, local_crc_strict,
 			    rep->params.bits & MPA_RR_FLAG_MARKERS ? 1 : 0, 0);
 
 		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -ECONNREFUSED);
@@ -920,6 +926,7 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 static void siw_accept_newconn(struct siw_cep *cep)
 {
 	struct socket *s = cep->sock;
+	struct siw_device *sdev = cep->sdev;
 	struct socket *new_s = NULL;
 	struct siw_cep *new_cep = NULL;
 	int rv = 0; /* debug only. should disappear */
@@ -927,7 +934,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
 	if (cep->state != SIW_EPSTATE_LISTENING)
 		goto error;
 
-	new_cep = siw_cep_alloc(cep->sdev);
+	new_cep = siw_cep_alloc(sdev);
 	if (!new_cep)
 		goto error;
 
@@ -960,7 +967,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
 	siw_cep_get(new_cep);
 	new_s->sk->sk_user_data = new_cep;
 
-	if (siw_tcp_nagle == false)
+	if (sdev->options.tcp_nagle == false)
 		tcp_sock_set_nodelay(new_s->sk);
 	new_cep->state = SIW_EPSTATE_AWAIT_MPAREQ;
 
@@ -1357,9 +1364,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	struct socket *s = NULL;
 	struct sockaddr *laddr = (struct sockaddr *)&id->local_addr,
 			*raddr = (struct sockaddr *)&id->remote_addr;
-	bool p2p_mode = peer_to_peer, v4 = true;
+	bool p2p_mode = sdev->options.peer_to_peer;
+	bool v4 = true;
 	u16 pd_len = params->private_data_len;
-	int version = mpa_version, rv;
+	int version = sdev->options.mpa_version;
+	int rv;
 
 	if (pd_len > MPA_MAX_PRIVDATA)
 		return -EINVAL;
@@ -1405,7 +1414,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		siw_dbg_qp(qp, "kernel_bindconnect: error %d\n", rv);
 		goto error;
 	}
-	if (siw_tcp_nagle == false)
+	if (sdev->options.tcp_nagle == false)
 		tcp_sock_set_nodelay(s->sk);
 	cep = siw_cep_alloc(sdev);
 	if (!cep) {
@@ -1456,10 +1465,10 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->mpa.hdr.params.bits = 0;
 	__mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);
 
-	if (try_gso)
+	if (sdev->options.try_gso)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_GSO_EXP;
 
-	if (mpa_crc_required)
+	if (sdev->options.crc_required)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_CRC;
 
 	/*
@@ -1577,7 +1586,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error_unlock;
 	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
-	if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
+	if (sdev->options.try_gso &&
+	    cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
 		siw_dbg_cep(cep, "peer allows GSO on TX\n");
 		qp->tx_ctx.gso_seg_limit = 0;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 3a08f57d2211..b12fc5ec656e 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -794,6 +794,7 @@ static int siw_check_sgl_tx(struct ib_pd *pd, struct siw_wqe *wqe,
 static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 {
 	struct siw_iwarp_tx *c_tx = &qp->tx_ctx;
+	struct siw_device *sdev = qp->sdev;
 	struct socket *s = qp->attrs.sk;
 	int rv = 0, burst_len = qp->tx_ctx.burst;
 	enum rdmap_ecode ecode = RDMAP_ECODE_CATASTROPHIC_STREAM;
@@ -868,7 +869,7 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 		enum siw_opcode tx_type = tx_type(wqe);
 		unsigned int msg_flags;
 
-		if (siw_sq_empty(qp) || !siw_tcp_nagle || burst_len == 1)
+		if (siw_sq_empty(qp) || !sdev->options.tcp_nagle || burst_len == 1)
 			/*
 			 * End current TCP segment, if SQ runs empty,
 			 * or siw_tcp_nagle is not set, or we bail out
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 2b2a7b8e93b0..1ca85b10e807 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -434,7 +434,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 	/* Make those two tunables fixed for now. */
 	qp->tx_ctx.gso_seg_limit = 1;
-	qp->tx_ctx.zcopy_tx = zcopy_tx;
+	qp->tx_ctx.zcopy_tx = sdev->options.zcopy_tx;
 
 	qp->attrs.state = SIW_QP_STATE_IDLE;
 
-- 
2.34.1


