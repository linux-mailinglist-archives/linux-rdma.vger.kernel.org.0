Return-Path: <linux-rdma+bounces-8180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C441A47515
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 06:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6201887EF2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 05:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636481E8355;
	Thu, 27 Feb 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcMge+6x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3A3209;
	Thu, 27 Feb 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633268; cv=none; b=S4hy4lsYqa6D4V6xhNynKpzl79SL4LE9bxCifeO9D1Rm0hYj9N+ZS3/TyHDstRAhmo1J+7yU+g7eSwaQENgFnz2qYjc6YOTvHhzZwd2rJMzMURNiMbK1qC+S9Nm4QpMhr/MLrwDLydggW1b3Jbvvkts+BKJxdoXDX0PlDl86nLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633268; c=relaxed/simple;
	bh=6WtAl7foVY7Wao+5eq4clmnZlUR3UHyxadEKTDvemM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VaR7M9ns2GBeiOPcSDP025LwHbn/TiYYl1nNeeW18HcJi104IgzdfmtF7iz7zf8QXsEFE4yGrx2eHGuQ7iTWgQ/iv2dH+WLUoXS3p+8xppN/Dv1zrtSbTVbVJZRvjFVCNE2E/R2ffRIgifqzeYzSpUPSD+9Hgf7zGPvqI17Bnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcMge+6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC17C4CEDD;
	Thu, 27 Feb 2025 05:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740633267;
	bh=6WtAl7foVY7Wao+5eq4clmnZlUR3UHyxadEKTDvemM4=;
	h=From:To:Cc:Subject:Date:From;
	b=GcMge+6xj71wWmNpBel4lVifhL2GtYtv8+yHjhO284GuKQqo7AF43tAYiaoDuxWtc
	 ExHM7SzXB52jwfSolTvq5zZgVeIeaIOxIEcb2i8dksmK/pQQ48MDNb6KVRbr3HyG67
	 BkV5yO9iL2ZWfIzY0y6mB6uozFTVnWXpywPHyAQmZ+KLTj3Y/pJ/sbv2ocza5I3xTm
	 /hRoWrLgt84SMWWiful1QchaFYbiykTzSsco4q6qKfqyMJmMnMjYQZCer/WfkR9z/q
	 hSXyFuRljrW7FAAZFIJ9Jx2X4Dmpn5huwbtREsfIHcTFwEN836qYAneoDfMYtjEOwk
	 EQ7MqQ9gZKnpQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/siw: switch to using the crc32c library
Date: Wed, 26 Feb 2025 21:12:07 -0800
Message-ID: <20250227051207.19470-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32c().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: Dropped the patch "RDMA/siw: fix type of CRC field" and went with a
    more minimal conversion to use crc32c().  Also replaced bitfields
    with bools.

 drivers/infiniband/sw/siw/Kconfig     |  4 +-
 drivers/infiniband/sw/siw/siw.h       | 37 +++++++++++++++---
 drivers/infiniband/sw/siw/siw_main.c  | 22 +----------
 drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++---------------------
 drivers/infiniband/sw/siw/siw_qp_rx.c | 23 ++++++------
 drivers/infiniband/sw/siw/siw_qp_tx.c | 44 ++++++++++------------
 drivers/infiniband/sw/siw/siw_verbs.c |  3 --
 7 files changed, 74 insertions(+), 113 deletions(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index 81b70a3eeb878..ae4a953e2a039 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,12 +1,10 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND
 	depends on INFINIBAND_VIRT_DMA
-	select LIBCRC32C
-	select CRYPTO
-	select CRYPTO_CRC32C
+	select CRC32
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
 	standard Ethernet adapter to interoperate with a iWARP
 	adapter or with another system running the SIW driver.
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index ea5eee50dc39d..21238746716a9 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -8,13 +8,13 @@
 
 #include <rdma/ib_verbs.h>
 #include <rdma/restrack.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
-#include <crypto/hash.h>
 #include <linux/crc32.h>
 #include <linux/crc32c.h>
+#include <linux/unaligned.h>
 
 #include <rdma/siw-abi.h>
 #include "iwarp.h"
 
 #define SIW_VENDOR_ID 0x626d74 /* ascii 'bmt' for now */
@@ -287,11 +287,12 @@ struct siw_rx_stream {
 
 	enum siw_rx_state state;
 
 	union iwarp_hdr hdr;
 	struct mpa_trailer trailer;
-	struct shash_desc *mpa_crc_hd;
+	u32 mpa_crc;
+	bool mpa_crc_enabled;
 
 	/*
 	 * For each FPDU, main RX loop runs through 3 stages:
 	 * Receiving protocol headers, placing DDP payload and receiving
 	 * trailer information (CRC + possibly padding).
@@ -388,11 +389,12 @@ struct siw_iwarp_tx {
 	u16 ctrl_len; /* ddp+rdmap hdr */
 	u16 ctrl_sent;
 	int burst;
 	int bytes_unsent; /* ddp payload bytes */
 
-	struct shash_desc *mpa_crc_hd;
+	u32 mpa_crc;
+	bool mpa_crc_enabled;
 
 	u8 do_crc : 1; /* do crc for segment */
 	u8 use_sendpage : 1; /* send w/o copy */
 	u8 tx_suspend : 1; /* stop sending DDP segs. */
 	u8 pad : 2; /* # pad in current fpdu */
@@ -494,11 +496,10 @@ extern const bool mpa_crc_strict;
 extern const bool siw_tcp_nagle;
 extern u_char mpa_version;
 extern const bool peer_to_peer;
 extern struct task_struct *siw_tx_thread[];
 
-extern struct crypto_shash *siw_crypto_shash;
 extern struct iwarp_msg_info iwarp_pktinfo[RDMAP_TERMINATE + 1];
 
 /* QP general functions */
 int siw_qp_modify(struct siw_qp *qp, struct siw_qp_attrs *attr,
 		  enum siw_qp_attr_mask mask);
@@ -666,10 +667,34 @@ static inline struct siw_sqe *irq_alloc_free(struct siw_qp *qp)
 		return irq_e;
 	}
 	return NULL;
 }
 
+static inline void siw_crc_init(u32 *crc)
+{
+	*crc = ~0;
+}
+
+static inline void siw_crc_update(u32 *crc, const void *data, size_t len)
+{
+	*crc = crc32c(*crc, data, len);
+}
+
+static inline void siw_crc_final(u32 *crc, u8 out[4])
+{
+	put_unaligned_le32(~*crc, out);
+}
+
+static inline void siw_crc_oneshot(const void *data, size_t len, u8 out[4])
+{
+	u32 crc;
+
+	siw_crc_init(&crc);
+	siw_crc_update(&crc, data, len);
+	return siw_crc_final(&crc, out);
+}
+
 static inline __wsum siw_csum_update(const void *buff, int len, __wsum sum)
 {
 	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
 }
 
@@ -684,15 +709,15 @@ static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 {
 	const struct skb_checksum_ops siw_cs_ops = {
 		.update = siw_csum_update,
 		.combine = siw_csum_combine,
 	};
-	__wsum crc = *(u32 *)shash_desc_ctx(srx->mpa_crc_hd);
+	__wsum crc = (__force __wsum)srx->mpa_crc;
 
 	crc = __skb_checksum(srx->skb, srx->skb_offset, len, crc,
 			     &siw_cs_ops);
-	*(u32 *)shash_desc_ctx(srx->mpa_crc_hd) = crc;
+	srx->mpa_crc = (__force u32)crc;
 }
 
 #define siw_dbg(ibdev, fmt, ...)                                               \
 	ibdev_dbg(ibdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index b17752bd1ecc1..5168307229a9e 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -57,11 +57,10 @@ u_char mpa_version = MPA_REVISION_2;
  * setup, if true.
  */
 const bool peer_to_peer;
 
 struct task_struct *siw_tx_thread[NR_CPUS];
-struct crypto_shash *siw_crypto_shash;
 
 static int siw_device_register(struct siw_device *sdev, const char *name)
 {
 	struct ib_device *base_dev = &sdev->base_dev;
 	static int dev_id = 1;
@@ -465,24 +464,11 @@ static __init int siw_init_module(void)
 	if (!siw_create_tx_threads()) {
 		pr_info("siw: Could not start any TX thread\n");
 		rv = -ENOMEM;
 		goto out_error;
 	}
-	/*
-	 * Locate CRC32 algorithm. If unsuccessful, fail
-	 * loading siw only, if CRC is required.
-	 */
-	siw_crypto_shash = crypto_alloc_shash("crc32c", 0, 0);
-	if (IS_ERR(siw_crypto_shash)) {
-		pr_info("siw: Loading CRC32c failed: %ld\n",
-			PTR_ERR(siw_crypto_shash));
-		siw_crypto_shash = NULL;
-		if (mpa_crc_required) {
-			rv = -EOPNOTSUPP;
-			goto out_error;
-		}
-	}
+
 	rv = register_netdevice_notifier(&siw_netdev_nb);
 	if (rv)
 		goto out_error;
 
 	rdma_link_register(&siw_link_ops);
@@ -491,13 +477,10 @@ static __init int siw_init_module(void)
 	return 0;
 
 out_error:
 	siw_stop_tx_threads();
 
-	if (siw_crypto_shash)
-		crypto_free_shash(siw_crypto_shash);
-
 	pr_info("SoftIWARP attach failed. Error: %d\n", rv);
 
 	siw_cm_exit();
 	siw_destroy_cpulist(siw_cpu_info.num_nodes);
 
@@ -514,13 +497,10 @@ static void __exit siw_exit_module(void)
 
 	siw_cm_exit();
 
 	siw_destroy_cpulist(siw_cpu_info.num_nodes);
 
-	if (siw_crypto_shash)
-		crypto_free_shash(siw_crypto_shash);
-
 	pr_info("SoftiWARP detached\n");
 }
 
 module_init(siw_init_module);
 module_exit(siw_exit_module);
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index da92cfa2073d7..c1e6e7d6e32f8 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -224,37 +224,10 @@ static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
 	qp->attrs.orq_size = orq_size;
 	siw_dbg_qp(qp, "ORD %d, IRD %d\n", orq_size, irq_size);
 	return 0;
 }
 
-static int siw_qp_enable_crc(struct siw_qp *qp)
-{
-	struct siw_rx_stream *c_rx = &qp->rx_stream;
-	struct siw_iwarp_tx *c_tx = &qp->tx_ctx;
-	int size;
-
-	if (siw_crypto_shash == NULL)
-		return -ENOENT;
-
-	size = crypto_shash_descsize(siw_crypto_shash) +
-		sizeof(struct shash_desc);
-
-	c_tx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
-	c_rx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
-	if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {
-		kfree(c_tx->mpa_crc_hd);
-		kfree(c_rx->mpa_crc_hd);
-		c_tx->mpa_crc_hd = NULL;
-		c_rx->mpa_crc_hd = NULL;
-		return -ENOMEM;
-	}
-	c_tx->mpa_crc_hd->tfm = siw_crypto_shash;
-	c_rx->mpa_crc_hd->tfm = siw_crypto_shash;
-
-	return 0;
-}
-
 /*
  * Send a non signalled READ or WRITE to peer side as negotiated
  * with MPAv2 P2P setup protocol. The work request is only created
  * as a current active WR and does not consume Send Queue space.
  *
@@ -581,32 +554,26 @@ void siw_send_terminate(struct siw_qp *qp)
 		rx_hdr->ctrl.mpa_len = cpu_to_be16(real_ddp_len);
 	}
 
 	term->ctrl.mpa_len =
 		cpu_to_be16(len_terminate - (MPA_HDR_SIZE + MPA_CRC_SIZE));
-	if (qp->tx_ctx.mpa_crc_hd) {
-		crypto_shash_init(qp->tx_ctx.mpa_crc_hd);
-		if (crypto_shash_update(qp->tx_ctx.mpa_crc_hd,
-					(u8 *)iov[0].iov_base,
-					iov[0].iov_len))
-			goto out;
-
+	if (qp->tx_ctx.mpa_crc_enabled) {
+		siw_crc_init(&qp->tx_ctx.mpa_crc);
+		siw_crc_update(&qp->tx_ctx.mpa_crc,
+			       iov[0].iov_base, iov[0].iov_len);
 		if (num_frags == 3) {
-			if (crypto_shash_update(qp->tx_ctx.mpa_crc_hd,
-						(u8 *)iov[1].iov_base,
-						iov[1].iov_len))
-				goto out;
+			siw_crc_update(&qp->tx_ctx.mpa_crc,
+				       iov[1].iov_base, iov[1].iov_len);
 		}
-		crypto_shash_final(qp->tx_ctx.mpa_crc_hd, (u8 *)&crc);
+		siw_crc_final(&qp->tx_ctx.mpa_crc, (u8 *)&crc);
 	}
 
 	rv = kernel_sendmsg(s, &msg, iov, num_frags, len_terminate);
 	siw_dbg_qp(qp, "sent TERM: %s, layer %d, type %d, code %d (%d bytes)\n",
 		   rv == len_terminate ? "success" : "failure",
 		   __rdmap_term_layer(term), __rdmap_term_etype(term),
 		   __rdmap_term_ecode(term), rv);
-out:
 	kfree(term);
 	kfree(err_hdr);
 }
 
 /*
@@ -641,13 +608,14 @@ static int siw_qp_nextstate_from_idle(struct siw_qp *qp,
 	int rv = 0;
 
 	switch (attrs->state) {
 	case SIW_QP_STATE_RTS:
 		if (attrs->flags & SIW_MPA_CRC) {
-			rv = siw_qp_enable_crc(qp);
-			if (rv)
-				break;
+			siw_crc_init(&qp->tx_ctx.mpa_crc);
+			qp->tx_ctx.mpa_crc_enabled = true;
+			siw_crc_init(&qp->rx_stream.mpa_crc);
+			qp->rx_stream.mpa_crc_enabled = true;
 		}
 		if (!(mask & SIW_QP_ATTR_LLP_HANDLE)) {
 			siw_dbg_qp(qp, "no socket\n");
 			rv = -EINVAL;
 			break;
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index ed4fc39718b49..32554eba1eac7 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -65,14 +65,14 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 			pr_warn("siw: [QP %u]: %s, len %d, page %p, rv %d\n",
 				qp_id(rx_qp(srx)), __func__, len, p, rv);
 
 			return -EFAULT;
 		}
-		if (srx->mpa_crc_hd) {
+		if (srx->mpa_crc_enabled) {
 			if (rdma_is_kernel_res(&rx_qp(srx)->base_qp.res)) {
-				crypto_shash_update(srx->mpa_crc_hd,
-					(u8 *)(dest + pg_off), bytes);
+				siw_crc_update(&srx->mpa_crc, dest + pg_off,
+					       bytes);
 				kunmap_atomic(dest);
 			} else {
 				kunmap_atomic(dest);
 				/*
 				 * Do CRC on original, not target buffer.
@@ -112,12 +112,12 @@ static int siw_rx_kva(struct siw_rx_stream *srx, void *kva, int len)
 		pr_warn("siw: [QP %u]: %s, len %d, kva 0x%pK, rv %d\n",
 			qp_id(rx_qp(srx)), __func__, len, kva, rv);
 
 		return rv;
 	}
-	if (srx->mpa_crc_hd)
-		crypto_shash_update(srx->mpa_crc_hd, (u8 *)kva, len);
+	if (srx->mpa_crc_enabled)
+		siw_crc_update(&srx->mpa_crc, kva, len);
 
 	srx->skb_offset += len;
 	srx->skb_copied += len;
 	srx->skb_new -= len;
 
@@ -964,20 +964,20 @@ static int siw_get_trailer(struct siw_qp *qp, struct siw_rx_stream *srx)
 	srx->fpdu_part_rem -= avail;
 
 	if (srx->fpdu_part_rem)
 		return -EAGAIN;
 
-	if (!srx->mpa_crc_hd)
+	if (!srx->mpa_crc_enabled)
 		return 0;
 
 	if (srx->pad)
-		crypto_shash_update(srx->mpa_crc_hd, tbuf, srx->pad);
+		siw_crc_update(&srx->mpa_crc, tbuf, srx->pad);
 	/*
 	 * CRC32 is computed, transmitted and received directly in NBO,
 	 * so there's never a reason to convert byte order.
 	 */
-	crypto_shash_final(srx->mpa_crc_hd, (u8 *)&crc_own);
+	siw_crc_final(&srx->mpa_crc, (u8 *)&crc_own);
 	crc_in = (__force __wsum)srx->trailer.crc;
 
 	if (unlikely(crc_in != crc_own)) {
 		pr_warn("siw: crc error. in: %08x, own %08x, op %u\n",
 			crc_in, crc_own, qp->rx_stream.rdmap_op);
@@ -1091,17 +1091,16 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 	 * the current tagged or untagged message gets eventually completed
 	 * w/o intersection from another message of the same type
 	 * (tagged/untagged). E.g., a WRITE can get intersected by a SEND,
 	 * but not by a READ RESPONSE etc.
 	 */
-	if (srx->mpa_crc_hd) {
+	if (srx->mpa_crc_enabled) {
 		/*
 		 * Restart CRC computation
 		 */
-		crypto_shash_init(srx->mpa_crc_hd);
-		crypto_shash_update(srx->mpa_crc_hd, (u8 *)c_hdr,
-				    srx->fpdu_part_rcvd);
+		siw_crc_init(&srx->mpa_crc);
+		siw_crc_update(&srx->mpa_crc, c_hdr, srx->fpdu_part_rcvd);
 	}
 	if (frx->more_ddp_segs) {
 		frx->first_ddp_seg = 0;
 		if (frx->prev_rdmap_op != opcode) {
 			pr_warn("siw: packet intersection: %u : %u\n",
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index a034264c56698..6432bce7d0831 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -246,14 +246,12 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 
 		*(u32 *)crc = 0;
 		/*
 		 * Do complete CRC if enabled and short packet
 		 */
-		if (c_tx->mpa_crc_hd &&
-		    crypto_shash_digest(c_tx->mpa_crc_hd, (u8 *)&c_tx->pkt,
-					c_tx->ctrl_len, (u8 *)crc) != 0)
-			return -EINVAL;
+		if (c_tx->mpa_crc_enabled)
+			siw_crc_oneshot(&c_tx->pkt, c_tx->ctrl_len, (u8 *)crc);
 		c_tx->ctrl_len += MPA_CRC_SIZE;
 
 		return PKT_COMPLETE;
 	}
 	c_tx->ctrl_len += MPA_CRC_SIZE;
@@ -480,13 +478,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			iov[seg].iov_base =
 				ib_virt_dma_to_ptr(sge->laddr + sge_off);
 			iov[seg].iov_len = sge_len;
 
 			if (do_crc)
-				crypto_shash_update(c_tx->mpa_crc_hd,
-						    iov[seg].iov_base,
-						    sge_len);
+				siw_crc_update(&c_tx->mpa_crc,
+					       iov[seg].iov_base, sge_len);
 			sge_off += sge_len;
 			data_len -= sge_len;
 			seg++;
 			goto sge_done;
 		}
@@ -514,19 +511,18 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					kmap_mask |= BIT(seg);
 					iov[seg].iov_base = kaddr + fp_off;
 					iov[seg].iov_len = plen;
 
 					if (do_crc)
-						crypto_shash_update(
-							c_tx->mpa_crc_hd,
+						siw_crc_update(
+							&c_tx->mpa_crc,
 							iov[seg].iov_base,
 							plen);
 				} else if (do_crc) {
 					kaddr = kmap_local_page(p);
-					crypto_shash_update(c_tx->mpa_crc_hd,
-							    kaddr + fp_off,
-							    plen);
+					siw_crc_update(&c_tx->mpa_crc,
+						       kaddr + fp_off, plen);
 					kunmap_local(kaddr);
 				}
 			} else {
 				/*
 				 * Cast to an uintptr_t to preserve all 64 bits
@@ -534,14 +530,13 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				 */
 				u64 va = sge->laddr + sge_off;
 
 				page_array[seg] = ib_virt_dma_to_page(va);
 				if (do_crc)
-					crypto_shash_update(
-						c_tx->mpa_crc_hd,
-						ib_virt_dma_to_ptr(va),
-						plen);
+					siw_crc_update(&c_tx->mpa_crc,
+						       ib_virt_dma_to_ptr(va),
+						       plen);
 			}
 
 			sge_len -= plen;
 			sge_off += plen;
 			data_len -= plen;
@@ -574,18 +569,18 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	}
 
 	if (c_tx->pad) {
 		*(u32 *)c_tx->trailer.pad = 0;
 		if (do_crc)
-			crypto_shash_update(c_tx->mpa_crc_hd,
-				(u8 *)&c_tx->trailer.crc - c_tx->pad,
-				c_tx->pad);
+			siw_crc_update(&c_tx->mpa_crc,
+				       (u8 *)&c_tx->trailer.crc - c_tx->pad,
+				       c_tx->pad);
 	}
-	if (!c_tx->mpa_crc_hd)
+	if (!c_tx->mpa_crc_enabled)
 		c_tx->trailer.crc = 0;
 	else if (do_crc)
-		crypto_shash_final(c_tx->mpa_crc_hd, (u8 *)&c_tx->trailer.crc);
+		siw_crc_final(&c_tx->mpa_crc, (u8 *)&c_tx->trailer.crc);
 
 	data_len = c_tx->bytes_unsent;
 
 	if (c_tx->use_sendpage) {
 		rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
@@ -734,14 +729,13 @@ static void siw_prepare_fpdu(struct siw_qp *qp, struct siw_wqe *wqe)
 		htons(c_tx->ctrl_len + data_len - MPA_HDR_SIZE);
 
 	/*
 	 * Init MPA CRC computation
 	 */
-	if (c_tx->mpa_crc_hd) {
-		crypto_shash_init(c_tx->mpa_crc_hd);
-		crypto_shash_update(c_tx->mpa_crc_hd, (u8 *)&c_tx->pkt,
-				    c_tx->ctrl_len);
+	if (c_tx->mpa_crc_enabled) {
+		siw_crc_init(&c_tx->mpa_crc);
+		siw_crc_update(&c_tx->mpa_crc, &c_tx->pkt, c_tx->ctrl_len);
 		c_tx->do_crc = 1;
 	}
 }
 
 /*
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 5ac8bd450d240..fd7b266a221b2 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -629,13 +629,10 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 		siw_cep_put(qp->cep);
 		qp->cep = NULL;
 	}
 	up_write(&qp->state_lock);
 
-	kfree(qp->tx_ctx.mpa_crc_hd);
-	kfree(qp->rx_stream.mpa_crc_hd);
-
 	qp->scq = qp->rcq = NULL;
 
 	siw_qp_put(qp);
 	wait_for_completion(&qp->qp_free);
 

base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


