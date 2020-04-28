Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCD1BCCE2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1UB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 16:01:26 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:10664 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD1UBD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Apr 2020 16:01:03 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 03SK0j9G027832;
        Tue, 28 Apr 2020 13:00:51 -0700
Date:   Wed, 29 Apr 2020 01:30:44 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
Message-ID: <20200428200043.GA930@chelsio.com>
References: <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard Metzler wrote:
Hi Bernard,

The attached patches enables the GSO negotiation code in SIW with
few modifications, and also allows hardware iwarp drivers to advertise
their max length(in 16/32/64KB granularity) that they can accept.
The logic is almost similar to how TCP SYN MSS announcements works while
3-way handshake.

Please see if this approach works better for softiwarp <=> hardiwarp
case.

Thanks,
Krishna. 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="siw.patch"

diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
index e8a04d9c89cb..fa7d93be5d18 100644
--- a/drivers/infiniband/sw/siw/iwarp.h
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -18,12 +18,34 @@
 #define MPA_KEY_REQ "MPA ID Req Frame"
 #define MPA_KEY_REP "MPA ID Rep Frame"
 #define MPA_IRD_ORD_MASK 0x3fff
+#define MPA_FPDU_LEN_MASK 0x000c
 
 struct mpa_rr_params {
 	__be16 bits;
 	__be16 pd_len;
 };
 
+/*
+ * MPA reserved bits[4:5] are used to advertise the maximum FPDU length that an
+ * endpoint is willing to accept, like TCP SYN MSS announcement. This is an
+ * experimental enhancement to RDMA connection establishment. Both local and
+ * remote endpoints must use these flags, if at least, one endpoint wants to
+ * advertise it's capability to receive large FPDU length.
+ * As SIW driver sits on top of TCP/IP stack it can use GSO for sending large
+ * FPDUs(upto 64K - 1, capped due to 16bit MPA len), thus improves performance.
+ * Making use of bits[4:5] backwards compatibility with the original MPA Frame
+ * format, IE, rules defined in RFC5044, regarding FDPU length, should be
+ * followed when these bits are zero.
+ * TODO make this experimental feature tunable via module params, as the remote
+ * endpoint might also be using these reserve bits for other experiments.
+ */
+enum {
+	MPA_FPDU_LEN_DEFAULT = cpu_to_be16(0x0000),
+	MPA_FPDU_LEN_16K = cpu_to_be16(0x0400),
+	MPA_FPDU_LEN_32K = cpu_to_be16(0x0800),
+	MPA_FPDU_LEN_64K = cpu_to_be16(0x0c00)
+};
+
 /*
  * MPA request/response header bits & fields
  */
@@ -32,7 +54,6 @@ enum {
 	MPA_RR_FLAG_CRC = cpu_to_be16(0x4000),
 	MPA_RR_FLAG_REJECT = cpu_to_be16(0x2000),
 	MPA_RR_FLAG_ENHANCED = cpu_to_be16(0x1000),
-	MPA_RR_FLAG_GSO_EXP = cpu_to_be16(0x0800),
 	MPA_RR_MASK_REVISION = cpu_to_be16(0x00ff)
 };
 
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index dba4535494ab..a8e08f675cf4 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -415,7 +415,7 @@ struct siw_iwarp_tx {
 	u8 orq_fence : 1; /* ORQ full or Send fenced */
 	u8 in_syscall : 1; /* TX out of user context */
 	u8 zcopy_tx : 1; /* Use TCP_SENDPAGE if possible */
-	u8 gso_seg_limit; /* Maximum segments for GSO, 0 = unbound */
+	u16 large_fpdulen; /* max outbound FPDU len, capped by 16bit MPA len */
 
 	u16 fpdu_len; /* len of FPDU to tx */
 	unsigned int tcp_seglen; /* remaining tcp seg space */
@@ -505,7 +505,6 @@ struct iwarp_msg_info {
 
 /* Global siw parameters. Currently set in siw_main.c */
 extern const bool zcopy_tx;
-extern const bool try_gso;
 extern const bool loopback_enabled;
 extern const bool mpa_crc_required;
 extern const bool mpa_crc_strict;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 8c1931a57f4a..abeed777006f 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -712,6 +712,38 @@ static int siw_proc_mpareq(struct siw_cep *cep)
 	return -EOPNOTSUPP;
 }
 
+/*
+ * Sets/limits max outbound FPDU length based on the length advertised
+ * by the peer.
+ */
+static void siw_set_outbound_fpdulen(struct siw_cep *cep,
+				     struct mpa_rr_params *params,
+				     u16 *outbound_fpdulen)
+{
+	switch (params->bits & MPA_FPDU_LEN_MASK) {
+	case MPA_FPDU_LEN_16K:
+		*outbound_fpdulen = SZ_16K - 1;
+		break;
+	case MPA_FPDU_LEN_32K:
+		*outbound_fpdulen = SZ_32K - 1;
+		break;
+	case MPA_FPDU_LEN_64K:
+		*outbound_fpdulen = SZ_64K - 1;
+		break;
+	default:
+		WARN(1,
+		  "Peer advertised invalid FPDU len:0x%x, proceeding w/o GSO\n",
+		  (params->bits & MPA_FPDU_LEN_MASK) & 0xffff);
+
+		/* fpdulen '0' here disables sending large FPDUs */
+		*outbound_fpdulen = 0;
+		return;
+	}
+	siw_dbg_cep(cep, "Max outbound FPDU length set to: %d\n",
+			*outbound_fpdulen);
+	return;
+}
+
 static int siw_proc_mpareply(struct siw_cep *cep)
 {
 	struct siw_qp_attrs qp_attrs;
@@ -750,10 +782,12 @@ static int siw_proc_mpareply(struct siw_cep *cep)
 
 		return -ECONNRESET;
 	}
-	if (try_gso && rep->params.bits & MPA_RR_FLAG_GSO_EXP) {
-		siw_dbg_cep(cep, "peer allows GSO on TX\n");
-		qp->tx_ctx.gso_seg_limit = 0;
-	}
+	if (rep->params.bits & MPA_FPDU_LEN_MASK)
+		siw_set_outbound_fpdulen(cep, &rep->params,
+					 &qp->tx_ctx.large_fpdulen);
+	else
+		qp->tx_ctx.large_fpdulen = 0;
+
 	if ((rep->params.bits & MPA_RR_FLAG_MARKERS) ||
 	    (mpa_crc_required && !(rep->params.bits & MPA_RR_FLAG_CRC)) ||
 	    (mpa_crc_strict && !mpa_crc_required &&
@@ -1469,8 +1503,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	__mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);
 
-	if (try_gso)
-		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_GSO_EXP;
+	cep->mpa.hdr.params.bits |= MPA_FPDU_LEN_64K;
 
 	if (mpa_crc_required)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_CRC;
@@ -1602,10 +1635,12 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
-	if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
-		siw_dbg_cep(cep, "peer allows GSO on TX\n");
-		qp->tx_ctx.gso_seg_limit = 0;
-	}
+	if (cep->mpa.hdr.params.bits & MPA_FPDU_LEN_MASK)
+		siw_set_outbound_fpdulen(cep, &cep->mpa.hdr.params,
+					 &qp->tx_ctx.large_fpdulen);
+	else
+		qp->tx_ctx.large_fpdulen = 0;
+
 	if (params->ord > sdev->attrs.max_ord ||
 	    params->ird > sdev->attrs.max_ird) {
 		siw_dbg_cep(
@@ -1676,6 +1711,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	qp_attrs.sk = cep->sock;
 	if (cep->mpa.hdr.params.bits & MPA_RR_FLAG_CRC)
 		qp_attrs.flags = SIW_MPA_CRC;
+	cep->mpa.hdr.params.bits |= MPA_FPDU_LEN_64K;
 	qp_attrs.state = SIW_QP_STATE_RTS;
 
 	siw_dbg_cep(cep, "[QP%u]: moving to rts\n", qp_id(qp));
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..28c256e52454 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -31,12 +31,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 /* transmit from user buffer, if possible */
 const bool zcopy_tx = true;
 
-/* Restrict usage of GSO, if hardware peer iwarp is unable to process
- * large packets. try_gso = true lets siw try to use local GSO,
- * if peer agrees.  Not using GSO severly limits siw maximum tx bandwidth.
- */
-const bool try_gso;
-
 /* Attach siw also with loopback devices */
 const bool loopback_enabled = true;
 
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 5d97bba0ce6d..d95bb0ed0d7c 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -662,13 +662,17 @@ static void siw_update_tcpseg(struct siw_iwarp_tx *c_tx,
 {
 	struct tcp_sock *tp = tcp_sk(s->sk);
 
-	if (tp->gso_segs) {
-		if (c_tx->gso_seg_limit == 0)
-			c_tx->tcp_seglen = tp->mss_cache * tp->gso_segs;
-		else
+	if (tp->gso_segs && c_tx->large_fpdulen) {
+		if (tp->mss_cache >  c_tx->large_fpdulen) {
+			c_tx->tcp_seglen = c_tx->large_fpdulen;
+		} else {
+			u8 gso_seg_limit;
+			gso_seg_limit = c_tx->large_fpdulen / tp->mss_cache;
+
 			c_tx->tcp_seglen =
 				tp->mss_cache *
-				min_t(u16, c_tx->gso_seg_limit, tp->gso_segs);
+				min_t(u16, gso_seg_limit, tp->gso_segs);
+		}
 	} else {
 		c_tx->tcp_seglen = tp->mss_cache;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index b18a677832e1..208557f91ff4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -444,8 +444,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	qp->attrs.sq_max_sges = attrs->cap.max_send_sge;
 	qp->attrs.rq_max_sges = attrs->cap.max_recv_sge;
 
-	/* Make those two tunables fixed for now. */
-	qp->tx_ctx.gso_seg_limit = 1;
+	/* Make this tunable fixed for now. */
 	qp->tx_ctx.zcopy_tx = zcopy_tx;
 
 	qp->attrs.state = SIW_QP_STATE_IDLE;

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cxgb4.patch"

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index ee1182f..8941b64 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -135,6 +135,16 @@
 module_param(snd_win, int, 0644);
 MODULE_PARM_DESC(snd_win, "TCP send window in bytes (default=128KB)");
 
+/*
+ * Experimental large FPDU length support.
+ * This improves overall throughput while interop with SoftiWARP.
+ * Note that iw_cxgb4 advertises it's receiving capability only and ignores
+ * the remote peer's large FPDU length announcement, due to T6 HW limitaton.
+ */
+static int large_fpdulen;
+module_param(large_fpdulen, int, 0644);
+MODULE_PARM_DESC(large_fpdulen, "Experimental large FPDU length");
+
 static struct workqueue_struct *workq;
 
 static struct sk_buff_head rxq;
@@ -978,6 +988,12 @@ static int send_mpa_req(struct c4iw_ep *ep, struct sk_buff *skb,
 	mpa->flags = 0;
 	if (crc_enabled)
 		mpa->flags |= MPA_CRC;
+	if (large_fpdulen) {
+		if (CHELSIO_CHIP_VERSION(ep->com.dev->rdev.lldi.adapter_type) >=
+				CHELSIO_T6)
+			mpa->flags |= MPA_FPDU_LEN_16K;
+	}
+
 	if (markers_enabled) {
 		mpa->flags |= MPA_MARKERS;
 		ep->mpa_attr.recv_marker_enabled = 1;
@@ -1166,6 +1182,11 @@ static int send_mpa_reply(struct c4iw_ep *ep, const void *pdata, u8 plen)
 		mpa->flags |= MPA_CRC;
 	if (ep->mpa_attr.recv_marker_enabled)
 		mpa->flags |= MPA_MARKERS;
+	if (large_fpdulen) {
+		if (CHELSIO_CHIP_VERSION(ep->com.dev->rdev.lldi.adapter_type) >=
+				CHELSIO_T6)
+			mpa->flags |= MPA_FPDU_LEN_16K;
+	}
 	mpa->revision = ep->mpa_attr.version;
 	mpa->private_data_size = htons(plen);
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 7d06b0f..051830e 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -688,6 +688,15 @@ enum c4iw_mmid_state {
 #define MPA_V2_RDMA_READ_RTR            0x4000
 #define MPA_V2_IRD_ORD_MASK             0x3FFF
 
+/* Following experimental bits should be in sync with SoftiWARP bits */
+#define MPA_FPDU_LEN_MASK 0x000c
+enum {
+	MPA_FPDU_LEN_DEFAULT = cpu_to_be16(0x0000),
+	MPA_FPDU_LEN_16K = cpu_to_be16(0x0400),
+	MPA_FPDU_LEN_32K = cpu_to_be16(0x0800),
+	MPA_FPDU_LEN_64K = cpu_to_be16(0x0c00)
+};
+
 #define c4iw_put_ep(ep) {						\
 	pr_debug("put_ep ep %p refcnt %d\n",		\
 		 ep, kref_read(&((ep)->kref)));				\

--G4iJoqBmSsgzjUCe--
