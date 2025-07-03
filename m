Return-Path: <linux-rdma+bounces-11878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15FAF7ED4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566973B33F5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BED289E0B;
	Thu,  3 Jul 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="nV8oVr1V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE1288C8E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563675; cv=none; b=fusCR+iMy4gO3LROE7Bi8vybLztX+zA+PTdw3xcAtfYVbRAKJF/1jUmMyLHSzYVZSnJ4fnbQI4r4NWg3SSLGQ8f0mEk8YaXTi/KK7pdJLJaQrUpyRdszg8t+gOCMj62z7sHrPzenB5JZraBFfi/tpmV5MLm7uogW9tW9doukUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563675; c=relaxed/simple;
	bh=QseT0nrd4+qv/UGZQs/jJYVHtMXZeyFp9/kWKgJh068=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSV0tH3gzqdE30WoSxl3q6SOYxvYutvkY7XF0i3azIjVFyPOxItxVJtINbFi5hSV4r2n5zF4HC44X8D4hoBsw+RrvHspDkbMxTe3pvpILxmzE5anu+ZBqIfuaZEpkJqCldwEZe+Y0xxFvRrSJ3tZ8CvejR/b0W+Dx5jiBiQbw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=nV8oVr1V; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=8BvJq6bLoS4HHi3zKwL92qRkWjG0FdvU8+G6D5B0yYw=; b=nV8oVr1VToklSZ9ZJP7n544X4E
	Q+8sMdJNzF4Yt5SFnkCLWjZJ2Pg4kWpJ9IcjNdjr2q8OBk8ZCHhN2wzMunSwr1jKrDljdtZ3thbJ1
	xIpOGT/Ql9WwHJvRgyE9frUxHmE1UJKYQx/cS/kmdCs5HIaoHs4iAqqKEeLt6TfLUkerBFzIRq33z
	gTkvaGDj0ZpSFy9TByYjp8SoXSieLQh8bZ4lJIUOiLZ4k5kbPoXI6gPok3Crpr4BFlofsMzzY30xW
	8is2whb51wBzqT2ixGEuCHL5B9JL44R8jv9AK/3HY5hPM4NfWiM5gcTRhheKz9Vh7fbMcus7ZvcR3
	zsDQtATax2lRaABV6fIiBFuMag7m51KbB/i2d5/bJwFf7+IRExde031iDC0TZLOI49YcD6MB2Zfnd
	Y+oK+eoeWTLxA66fc2yxHl/x4baH+ra+OJ+ds5t8Vq/FdUXGIso1GoMZ3hI8tf2Qhw1V9K0g57Z6l
	FD3aBrvO2tlaxOIm0xA7Ihg+;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNix-00Dp3I-14;
	Thu, 03 Jul 2025 17:27:51 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 8/8] RDMA/siw: add support for MPA V1 and IRD/ORD negotiation based on [MS-SMBD]
Date: Thu,  3 Jul 2025 19:26:19 +0200
Message-Id: <b8df72241c683ed6dcc2118318fd3e1a4df1af7e.1751561826.git.metze@samba.org>
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

This is needed in order to interop with the Chelsio T404-BT card
it needs this:

  echo 1 > /sys/module/siw/parameters/mpa_crc_required
  echo 1 > /sys/module/siw/parameters/mpa_crc_strict
  echo 0 > /sys/module/siw/parameters/mpa_rdma_write_rtr
  echo 1 > /sys/module/siw/parameters/mpa_peer_to_peer
  echo 1 > /sys/module/siw/parameters/mpa_version

before calling 'rdma link add siw_eth0 type siw netdev eth0'.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/iwarp.h    |   8 +
 drivers/infiniband/sw/siw/siw_cm.c   | 214 ++++++++++++++++++++++++---
 drivers/infiniband/sw/siw/siw_cm.h   |   2 +
 drivers/infiniband/sw/siw/siw_main.c |   2 +-
 4 files changed, 204 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
index 8cf69309827d..b30d9289950d 100644
--- a/drivers/infiniband/sw/siw/iwarp.h
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -71,6 +71,14 @@ struct mpa_v2_data {
 	__be16 ord;
 };
 
+/*
+ * [MS-SMBD] 6 Appendix A: RDMA Provider IRD/ORD Negotiation
+ */
+struct mpa_v1_smbd_data {
+	__be32 ird;
+	__be32 ord;
+};
+
 struct mpa_marker {
 	__be16 rsvd;
 	__be16 fpdu_hmd; /* FPDU header-marker distance (= MPA's FPDUPTR) */
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7feed4a02d58..b8b9bf70fb60 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -27,6 +27,8 @@
 
 static const bool relaxed_ird_negotiation = true;
 
+static size_t siw_cep_mpa_vX_ctrl_len(struct siw_cep *cep);
+
 static void siw_cm_llp_state_change(struct sock *s);
 static void siw_cm_llp_data_ready(struct sock *s);
 static void siw_cm_llp_write_space(struct sock *s);
@@ -330,18 +332,18 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 		u16 pd_len = be16_to_cpu(cep->mpa.hdr.params.pd_len);
 
 		if (pd_len) {
+			size_t hide_len = siw_cep_mpa_vX_ctrl_len(cep);
+
 			/*
 			 * hand over MPA private data
 			 */
 			event.private_data_len = pd_len;
 			event.private_data = cep->mpa.pdata;
 
-			/* Hide MPA V2 IRD/ORD control */
-			if (cep->enhanced_rdma_conn_est) {
-				event.private_data_len -=
-					sizeof(struct mpa_v2_data);
-				event.private_data +=
-					sizeof(struct mpa_v2_data);
+			/* Hide MPA IRD/ORD control */
+			if (event.private_data_len >= hide_len) {
+				event.private_data_len -= hide_len;
+				event.private_data += hide_len;
 			}
 		}
 		getname_local(cep->sock, &event.local_addr);
@@ -454,6 +456,40 @@ void siw_cep_get(struct siw_cep *cep)
 	kref_get(&cep->ref);
 }
 
+static u8 *siw_cep_mpa_vX_ctrl_ptr(struct siw_cep *cep)
+{
+	if (!cep->enhanced_rdma_conn_est) {
+		return NULL;
+	}
+
+	switch (cep->sdev->options.mpa_version) {
+	case MPA_REVISION_2:
+		return (u8 *)&cep->mpa.v2_ctrl;
+
+	case MPA_REVISION_1:
+		return (u8 *)&cep->mpa.v1_ctrl;
+	}
+
+	return NULL;
+}
+
+static size_t siw_cep_mpa_vX_ctrl_len(struct siw_cep *cep)
+{
+	if (!cep->enhanced_rdma_conn_est) {
+		return 0;
+	}
+
+	switch (cep->sdev->options.mpa_version) {
+	case MPA_REVISION_2:
+		return sizeof(cep->mpa.v2_ctrl);
+
+	case MPA_REVISION_1:
+		return sizeof(cep->mpa.v1_ctrl);
+	}
+
+	return 0;
+}
+
 /*
  * Expects params->pd_len in host byte order
  */
@@ -466,6 +502,8 @@ static int siw_send_mpareqrep(struct siw_cep *cep, const void *pdata, u8 pd_len)
 	int rv;
 	int iovec_num = 0;
 	int mpa_len;
+	u8 *vX_ctrl = siw_cep_mpa_vX_ctrl_ptr(cep);
+	size_t vX_ctrl_len = siw_cep_mpa_vX_ctrl_len(cep);
 
 	memset(&msg, 0, sizeof(msg));
 
@@ -473,11 +511,11 @@ static int siw_send_mpareqrep(struct siw_cep *cep, const void *pdata, u8 pd_len)
 	iov[iovec_num].iov_len = sizeof(*rr);
 	mpa_len = sizeof(*rr);
 
-	if (cep->enhanced_rdma_conn_est) {
+	if (vX_ctrl) {
 		iovec_num++;
-		iov[iovec_num].iov_base = &cep->mpa.v2_ctrl;
-		iov[iovec_num].iov_len = sizeof(cep->mpa.v2_ctrl);
-		mpa_len += sizeof(cep->mpa.v2_ctrl);
+		iov[iovec_num].iov_base = vX_ctrl;
+		iov[iovec_num].iov_len = vX_ctrl_len;
+		mpa_len += vX_ctrl_len;
 	}
 	if (pd_len) {
 		iovec_num++;
@@ -485,8 +523,8 @@ static int siw_send_mpareqrep(struct siw_cep *cep, const void *pdata, u8 pd_len)
 		iov[iovec_num].iov_len = pd_len;
 		mpa_len += pd_len;
 	}
-	if (cep->enhanced_rdma_conn_est)
-		pd_len += sizeof(cep->mpa.v2_ctrl);
+	if (vX_ctrl)
+		pd_len += vX_ctrl_len;
 
 	rr->params.pd_len = cpu_to_be16(pd_len);
 
@@ -611,6 +649,8 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 
 	version = __mpa_rr_revision(req->params.bits);
 	pd_len = be16_to_cpu(req->params.pd_len);
+	siw_dbg_cep(cep, "GOT MPA REQUEST: version got %d local %d pd_len=%u\n",
+		version, sdev->options.mpa_version, pd_len);
 
 	if (version > MPA_REVISION_2)
 		/* allow for 0, 1, and 2 only */
@@ -635,6 +675,18 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 		cep->enhanced_rdma_conn_est = true;
 	}
 
+	if (version == MPA_REVISION_1 &&
+	    sdev->options.peer_to_peer) {
+		/*
+		 * MPA version 1 must signal IRD/ORD values and P2P mode
+		 * in private data.
+		 */
+		if (pd_len < sizeof(struct mpa_v1_smbd_data))
+			goto reject_conn;
+
+		cep->enhanced_rdma_conn_est = true;
+	}
+
 	/* MPA Markers: currently not supported. Marker TX to be added. */
 	if (req->params.bits & MPA_RR_FLAG_MARKERS)
 		goto reject_conn;
@@ -653,7 +705,7 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 		if (local_crc_required)
 			req->params.bits |= MPA_RR_FLAG_CRC;
 	}
-	if (cep->enhanced_rdma_conn_est) {
+	if (cep->enhanced_rdma_conn_est && version == MPA_REVISION_2) {
 		struct mpa_v2_data *v2 = (struct mpa_v2_data *)cep->mpa.pdata;
 
 		/*
@@ -689,8 +741,42 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 				cep->mpa.v2_ctrl.ord |= MPA_V2_RDMA_WRITE_RTR;
 		}
 	}
+	if (cep->enhanced_rdma_conn_est && version == MPA_REVISION_1) {
+		struct mpa_v1_smbd_data *v1 = (struct mpa_v1_smbd_data *)cep->mpa.pdata;
 
+		/*
+		 * Peer requested ORD becomes requested local IRD,
+		 * peer requested IRD becomes requested local ORD.
+		 * IRD and ORD get limited by global maximum values.
+		 */
+		cep->ord = ntohl(v1->ird);
+		cep->ord = min(cep->ord, SIW_MAX_ORD_QP);
+		cep->ird = ntohl(v1->ord);
+		cep->ird = min(cep->ird, SIW_MAX_IRD_QP);
+
+		/* May get overwritten by locally negotiated values */
+		cep->mpa.v1_ctrl.ird = htons(cep->ird);
+		cep->mpa.v1_ctrl.ord = htons(cep->ord);
+
+		/*
+		 * Keep the v2 values in sync.
+		 */
+		req->params.bits |= MPA_RR_FLAG_ENHANCED;
+		cep->mpa.v2_ctrl.ird = htons(cep->ird);
+		cep->mpa.v2_ctrl.ord = htons(cep->ord);
+		cep->mpa.v2_ctrl.ird |= MPA_V2_PEER_TO_PEER;
+		cep->mpa.v2_ctrl.ord |= MPA_V2_RDMA_READ_RTR;
+	}
+
+	siw_dbg_cep(cep, "set SIW_EPSTATE_RECVD_MPAREQ\n");
 	cep->state = SIW_EPSTATE_RECVD_MPAREQ;
+	siw_dbg_cep(
+		cep,
+		"ord (cep %d) (max %d), ird (cep %d) (max %d)\n",
+		cep->ord,
+		sdev->attrs.max_ord,
+		cep->ird,
+		sdev->attrs.max_ird);
 
 	/* Keep reference until IWCM accepts/rejects */
 	siw_cep_get(cep);
@@ -736,6 +822,8 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 	u16 rep_ird;
 	bool ird_insufficient = false;
 	enum mpa_v2_ctrl mpa_p2p_mode = MPA_V2_RDMA_NO_RTR;
+	int version;
+	u16 pd_len;
 
 	rv = siw_recv_mpa_rr(cep);
 	if (rv)
@@ -745,6 +833,11 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 
 	rep = &cep->mpa.hdr;
 
+	version = __mpa_rr_revision(rep->params.bits);
+	pd_len = be16_to_cpu(rep->params.pd_len);
+	siw_dbg_cep(cep, "GOT MPA REPLY: version got %d local %d pd_len=%u\n",
+		version, sdev->options.mpa_version, pd_len);
+
 	if (__mpa_rr_revision(rep->params.bits) > MPA_REVISION_2) {
 		/* allow for 0, 1,  and 2 only */
 		rv = -EPROTO;
@@ -781,10 +874,34 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 		return -EINVAL;
 	}
 	if (cep->enhanced_rdma_conn_est) {
-		struct mpa_v2_data *v2;
+		struct mpa_v2_data *v2 = NULL;
+
+		v2 = (struct mpa_v2_data *)cep->mpa.pdata;
+		if (version == MPA_REVISION_1) {
+			struct mpa_v1_smbd_data *v1 = (struct mpa_v1_smbd_data *)cep->mpa.pdata;
+
+			/*
+			 * Peer requested ORD becomes requested local IRD,
+			 * peer requested IRD becomes requested local ORD.
+			 * IRD and ORD get limited by global maximum values.
+			 */
+			cep->ord = ntohl(v1->ird);
+			cep->ord = min(cep->ord, SIW_MAX_ORD_QP);
+			cep->ird = ntohl(v1->ord);
+			cep->ird = min(cep->ird, SIW_MAX_IRD_QP);
+
+			/*
+			 * Keep the v2 values in sync.
+			 */
+			rep->params.bits |= MPA_RR_FLAG_ENHANCED;
+			cep->mpa.v2_ctrl.ird = htons(cep->ird);
+			cep->mpa.v2_ctrl.ord = htons(cep->ord);
+			cep->mpa.v2_ctrl.ird |= MPA_V2_PEER_TO_PEER;
+			cep->mpa.v2_ctrl.ord |= MPA_V2_RDMA_READ_RTR;
+			v2 = &cep->mpa.v2_ctrl;
+		}
 
-		if (__mpa_rr_revision(rep->params.bits) < MPA_REVISION_2 ||
-		    !(rep->params.bits & MPA_RR_FLAG_ENHANCED)) {
+		if (!(rep->params.bits & MPA_RR_FLAG_ENHANCED)) {
 			/*
 			 * Protocol failure: The responder MUST reply with
 			 * MPA version 2 and MUST set MPA_RR_FLAG_ENHANCED.
@@ -799,7 +916,6 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 				      -ECONNRESET);
 			return -EINVAL;
 		}
-		v2 = (struct mpa_v2_data *)cep->mpa.pdata;
 		rep_ird = ntohs(v2->ird) & MPA_IRD_ORD_MASK;
 		rep_ord = ntohs(v2->ord) & MPA_IRD_ORD_MASK;
 
@@ -1442,7 +1558,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->ird = params->ird;
 	cep->ord = params->ord;
 
-	if (p2p_mode && cep->ord == 0)
+	if (p2p_mode && rtr_type & MPA_V2_RDMA_WRITE_RTR && cep->ord == 0)
 		cep->ord = 1;
 
 	cep->state = SIW_EPSTATE_CONNECTING;
@@ -1461,7 +1577,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->mpa.hdr.params.bits = 0;
 	__mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);
 
-	if (sdev->options.try_gso)
+	if (sdev->options.try_gso && version >= MPA_REVISION_2)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_GSO_EXP;
 
 	if (sdev->options.crc_required)
@@ -1488,6 +1604,26 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.v2_ctrl_req.ird = cep->mpa.v2_ctrl.ird;
 		cep->mpa.v2_ctrl_req.ord = cep->mpa.v2_ctrl.ord;
 	}
+	if (version == MPA_REVISION_1 && p2p_mode) {
+		cep->enhanced_rdma_conn_est = true;
+
+		cep->mpa.v1_ctrl.ird = htonl(cep->ird);
+		cep->mpa.v1_ctrl.ord = htonl(cep->ord);
+		/* Remember own P2P mode requested */
+		cep->mpa.v1_ctrl_req.ird = cep->mpa.v1_ctrl.ird;
+		cep->mpa.v1_ctrl_req.ord = cep->mpa.v1_ctrl.ord;
+
+		/*
+		 * Also setup the v2 values in order
+		 * to allow the callers to be unchanged
+		 */
+		cep->mpa.v2_ctrl.ird = htons(cep->ird);
+		cep->mpa.v2_ctrl.ord = htons(cep->ord);
+		cep->mpa.v2_ctrl.ird |= MPA_V2_PEER_TO_PEER;
+		cep->mpa.v2_ctrl.ord |= MPA_V2_RDMA_READ_RTR;
+		cep->mpa.v2_ctrl_req.ird = cep->mpa.v2_ctrl.ird;
+		cep->mpa.v2_ctrl_req.ord = cep->mpa.v2_ctrl.ord;
+	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
 	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
@@ -1551,6 +1687,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 {
 	struct siw_device *sdev = to_siw_dev(id->device);
 	struct siw_cep *cep = (struct siw_cep *)id->provider_data;
+	size_t hide_len = siw_cep_mpa_vX_ctrl_len(cep);
 	struct siw_qp *qp;
 	struct siw_qp_attrs qp_attrs;
 	int rv = -EINVAL, max_priv_data = MPA_MAX_PRIVDATA;
@@ -1582,6 +1719,17 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error_unlock;
 	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
+	siw_dbg_cep(
+		cep,
+		"[QP %u]: START ord (params %d) (cep %d) (max %d), ird (params %d) (cep %d) (max %d)\n",
+		qp_id(qp),
+		params->ord,
+		cep->ord,
+		sdev->attrs.max_ord,
+		params->ird,
+		cep->ird,
+		sdev->attrs.max_ird);
+
 	if (sdev->options.try_gso &&
 	    cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
 		siw_dbg_cep(cep, "peer allows GSO on TX\n");
@@ -1596,8 +1744,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			params->ird, sdev->attrs.max_ird);
 		goto error_unlock;
 	}
-	if (cep->enhanced_rdma_conn_est)
-		max_priv_data -= sizeof(struct mpa_v2_data);
+	if (max_priv_data >= hide_len)
+		max_priv_data -= hide_len;
 
 	if (params->private_data_len > max_priv_data) {
 		siw_dbg_cep(
@@ -1637,10 +1785,24 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		cep->mpa.v2_ctrl.ird =
 			htons(params->ird & MPA_IRD_ORD_MASK) |
 			(cep->mpa.v2_ctrl.ird & ~MPA_V2_MASK_IRD_ORD);
+
+		cep->mpa.v1_ctrl.ord = htonl(params->ord & MPA_IRD_ORD_MASK);
+		cep->mpa.v1_ctrl.ird = htonl(params->ird & MPA_IRD_ORD_MASK);
 	}
 	cep->ird = params->ird;
 	cep->ord = params->ord;
 
+	siw_dbg_cep(
+		cep,
+		"[QP %u]: NEGOTIATED ord (params %d) (cep %d) (max %d), ird (params %d) (cep %d) (max %d)\n",
+		qp_id(qp),
+		params->ord,
+		cep->ord,
+		sdev->attrs.max_ord,
+		params->ird,
+		cep->ird,
+		sdev->attrs.max_ird);
+
 	cep->cm_id = id;
 	id->add_ref(id);
 
@@ -1675,6 +1837,16 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg_cep(cep, "[QP %u]: send mpa reply, %d byte pdata\n",
 		    qp_id(qp), params->private_data_len);
 
+	siw_dbg_cep(
+		cep,
+		"[QP %u]: MPA RESPONSE ord (params %d) (cep %d) (qp_attrs %d), ird (params %d) (cep %d) (qp_attrs %d)\n",
+		qp_id(qp),
+		params->ord,
+		cep->ord,
+		qp_attrs.orq_size,
+		params->ird,
+		cep->ird,
+		qp_attrs.irq_size);
 	rv = siw_send_mpareqrep(cep, params->private_data,
 				params->private_data_len);
 	if (rv != 0)
diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
index 7011c8a8ee7b..506de01a701b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -28,6 +28,8 @@ struct siw_mpa_info {
 	struct mpa_rr hdr; /* peer mpa hdr in host byte order */
 	struct mpa_v2_data v2_ctrl;
 	struct mpa_v2_data v2_ctrl_req;
+	struct mpa_v1_smbd_data v1_ctrl;
+	struct mpa_v1_smbd_data v1_ctrl_req;
 	char *pdata;
 	int bytes_rcvd;
 };
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index c7d1e44ec8fa..208a6366e9e9 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -169,7 +169,7 @@ static int siw_mpa_version_set(const char *val, const struct kernel_param *kp)
 
 	switch (uval) {
 	case MPA_REVISION_2:
-	/* TODO case MPA_REVISION_1: */
+	case MPA_REVISION_1:
 		siw_default_options.mpa_version = uval;
 		return 0;
 	}
-- 
2.34.1


