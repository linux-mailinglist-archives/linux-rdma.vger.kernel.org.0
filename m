Return-Path: <linux-rdma+bounces-7260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A8A200B3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B234A163AF9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848671DDA34;
	Mon, 27 Jan 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYSg7QUI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2771DD889;
	Mon, 27 Jan 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017540; cv=none; b=SaaKRdly3pME4xdGmN9AoHFeq2E+WxKftG8aMVfg9hrawiH74UQ2Xg30Uz7Yg+c+UUUbN55cUJ2FsbTZ7J/ncNAk1c03u0+5vLmCdJmC8eMaPXulMS+RFE9VxCVR7fDqI9D0quY0yx8tgVvJyVry/hnRImRXHqslD1Z5Q1Lqp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017540; c=relaxed/simple;
	bh=b91klK3SDu77umDEst57kH6XXlYgewr0E6J0kuKTk0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYZFWXjf4CMAn04go2pYGuE9oWxzznZA0/HdVtiLqP+60FVpI4RJXrNiVGATbUKgu2lE6r33yii6hMS4hQzaNj+WS/jI9wcNpEnkwA2I7TncCwX+x44Lv4oIU3nIQIVydoNTZbJ6sFN3x6Dm/zmRnoUUbX/aNWQhCUcwUpLTSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYSg7QUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE741C4CEEA;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017540;
	bh=b91klK3SDu77umDEst57kH6XXlYgewr0E6J0kuKTk0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYSg7QUIbRisEBkWvEqE8+BjW44ZKvV685FKZMox4q/vqJXnb4DGC8CptA3TBipB/
	 Imx5CeES0q0vtQwNIDMtxJ3FSAS5Up46efvzofdpn2yQf5ZtbTFqfEiwfoa5d/qqrL
	 KrVKpiJ0EMCDc6VixUkXwBg0pglUu3RRbAbn4CwKGtKdkGKGcWzkRBYObzN70y0HHx
	 TzxzfkzagHR5oR/mrbnMJyD399pUUS/0NV/b/CP5/wLVs2gH3xafnQjcb5u51S6F3h
	 xaVfoOPQ0FAao0bwR2DdFDJf472R5R8rWbwFlAs0QVTdNFOYfN/YDbv0PpSTGj5+vS
	 MLkFkiHTGsG+A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] RDMA/siw: fix type of CRC field
Date: Mon, 27 Jan 2025 14:38:39 -0800
Message-ID: <20250127223840.67280-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127223840.67280-1-ebiggers@kernel.org>
References: <20250127223840.67280-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The usual big endian convention of InfiniBand does not apply to the MPA
CRC field, whose transmission is specified in terms of the CRC32
polynomial coefficients.  The coefficients are transmitted in descending
order from the x^31 coefficient to the x^0 one.  When the result is
interpreted as a 32-bit integer using the required reverse mapping
between bits and polynomial coefficients, it's a __le32.

Fix the code to use the correct type.

The endianness conversion to little endian was actually already done in
crypto_shash_final().  Therefore this patch does not change any
behavior, except for adding the missing le32_to_cpu() to the pr_warn()
message in siw_get_trailer() which makes the correct values be printed
on big endian systems.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/siw/iwarp.h     |  2 +-
 drivers/infiniband/sw/siw/siw.h       |  8 ++++----
 drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c | 16 +++++++++++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c |  2 +-
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
index 8cf69309827d6..afebb5d8643e3 100644
--- a/drivers/infiniband/sw/siw/iwarp.h
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -79,11 +79,11 @@ struct mpa_marker {
 /*
  * maximum MPA trailer
  */
 struct mpa_trailer {
 	__u8 pad[4];
-	__be32 crc;
+	__le32 crc;
 };
 
 #define MPA_HDR_SIZE 2
 #define MPA_CRC_SIZE 4
 
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index ea5eee50dc39d..50649971f6254 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -336,26 +336,26 @@ struct siw_rx_fpdu {
  * Shorthands for short packets w/o payload
  * to be transmitted more efficient.
  */
 struct siw_send_pkt {
 	struct iwarp_send send;
-	__be32 crc;
+	__le32 crc;
 };
 
 struct siw_write_pkt {
 	struct iwarp_rdma_write write;
-	__be32 crc;
+	__le32 crc;
 };
 
 struct siw_rreq_pkt {
 	struct iwarp_rdma_rreq rreq;
-	__be32 crc;
+	__le32 crc;
 };
 
 struct siw_rresp_pkt {
 	struct iwarp_rdma_rresp rresp;
-	__be32 crc;
+	__le32 crc;
 };
 
 struct siw_iwarp_tx {
 	union {
 		union iwarp_hdr hdr;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index da92cfa2073d7..ea7d2f5c8b8ee 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -394,11 +394,11 @@ void siw_send_terminate(struct siw_qp *qp)
 	struct iwarp_terminate *term = NULL;
 	union iwarp_hdr *err_hdr = NULL;
 	struct socket *s = qp->attrs.sk;
 	struct siw_rx_stream *srx = &qp->rx_stream;
 	union iwarp_hdr *rx_hdr = &srx->hdr;
-	u32 crc = 0;
+	__le32 crc = 0;
 	int num_frags, len_terminate, rv;
 
 	if (!qp->term_info.valid)
 		return;
 
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index ed4fc39718b49..098e32fb36fb1 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -951,11 +951,11 @@ int siw_proc_terminate(struct siw_qp *qp)
 static int siw_get_trailer(struct siw_qp *qp, struct siw_rx_stream *srx)
 {
 	struct sk_buff *skb = srx->skb;
 	int avail = min(srx->skb_new, srx->fpdu_part_rem);
 	u8 *tbuf = (u8 *)&srx->trailer.crc - srx->pad;
-	__wsum crc_in, crc_own = 0;
+	__le32 crc_in, crc_own = 0;
 
 	siw_dbg_qp(qp, "expected %d, available %d, pad %u\n",
 		   srx->fpdu_part_rem, srx->skb_new, srx->pad);
 
 	skb_copy_bits(skb, srx->skb_offset, tbuf, avail);
@@ -969,20 +969,26 @@ static int siw_get_trailer(struct siw_qp *qp, struct siw_rx_stream *srx)
 	if (!srx->mpa_crc_hd)
 		return 0;
 
 	if (srx->pad)
 		crypto_shash_update(srx->mpa_crc_hd, tbuf, srx->pad);
+
 	/*
-	 * CRC32 is computed, transmitted and received directly in NBO,
-	 * so there's never a reason to convert byte order.
+	 * The usual big endian convention of InfiniBand does not apply to the
+	 * CRC field, whose transmission is specified in terms of the CRC32
+	 * polynomial coefficients.  The coefficients are transmitted in
+	 * descending order from the x^31 coefficient to the x^0 one.  When the
+	 * result is interpreted as a 32-bit integer using the required reverse
+	 * mapping between bits and polynomial coefficients, it's a __le32.
 	 */
 	crypto_shash_final(srx->mpa_crc_hd, (u8 *)&crc_own);
-	crc_in = (__force __wsum)srx->trailer.crc;
+	crc_in = srx->trailer.crc;
 
 	if (unlikely(crc_in != crc_own)) {
 		pr_warn("siw: crc error. in: %08x, own %08x, op %u\n",
-			crc_in, crc_own, qp->rx_stream.rdmap_op);
+			le32_to_cpu(crc_in), le32_to_cpu(crc_own),
+			qp->rx_stream.rdmap_op);
 
 		siw_init_terminate(qp, TERM_ERROR_LAYER_LLP,
 				   LLP_ETYPE_MPA,
 				   LLP_ECODE_RECEIVED_CRC, 0);
 		return -EINVAL;
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index a034264c56698..f9db69a82cdd5 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -242,11 +242,11 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 			else
 				c_tx->pkt.c_tagged.ddp_to =
 					cpu_to_be64(wqe->sqe.raddr);
 		}
 
-		*(u32 *)crc = 0;
+		*(__le32 *)crc = 0;
 		/*
 		 * Do complete CRC if enabled and short packet
 		 */
 		if (c_tx->mpa_crc_hd &&
 		    crypto_shash_digest(c_tx->mpa_crc_hd, (u8 *)&c_tx->pkt,
-- 
2.48.1


