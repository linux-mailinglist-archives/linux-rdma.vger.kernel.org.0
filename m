Return-Path: <linux-rdma+bounces-9172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F0A7D7BD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1382C16CFE8
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5E226D1E;
	Mon,  7 Apr 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ru4/Ogvi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zqPouQz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B11226D11;
	Mon,  7 Apr 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014319; cv=none; b=nCzjc8PiN+GxSet7go2O+KCLdVdJQ1jaF43gOmnSYxXJ+/CbZAElBr7qZyE+oLGb0mMWTXxh79gKLvwHqUR+py4y87O/Y6Dvzf3NZVZXY2fw4EXaS9bOj530RcqsAc9v1yp46kM0+N5LRZDwR3YpxdRuJl9FEj/6YwOUvAUyTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014319; c=relaxed/simple;
	bh=3+k79a/2sQfHNTdFYGaSA09bqsx67Vm5FpJsl1jxaCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I1IgHDyEA/pWKVaZg4Os2o60ybfTyYADQ+/pdIfTvaeC0MjObKj2y3erqf7D4C+4mNQw5LcJwz11lv3Y/GCNrDck3KpZtIrTDQ/aR9uSaRtO92fPVbK7SPL7HDD8oC59vL0dztucPVrTeSCr2uwvSgvV+YEmwWefEPLXHFNEHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ru4/Ogvi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zqPouQz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744014314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DnjYap4atApGOWMvIPqJqeN4q+zZIEl85aJTKJMvdSo=;
	b=Ru4/OgvijuiYAGGENlM3l3iF0TDpyIUqYFojnI5VC9yKsa2n72cOLuvZywMxIj6p9uN1M/
	R1bmQBZZE155RZomH/WpKn1j7z8I19xjQaUghlHxmCxvaeQG12SU9TdNFrGVmlSz1nv8Yf
	nHUkqvj8Muvd/uooPpbh3aUMkk6g2qwG044bm4DKa1VbmPbl7Q/bokNt5ykVxU6weB8XvS
	jOQ8+jF3HdcyHY9nazPLLgdw0+mGerCmX4NtBgVhss3OMFKcuJ1T9sSC3L32nT6hSIpoq/
	0+Uscl1AE8aXEpwDwACxCVP5y0sbfkDoZFnDy7b9HfEHMR346yFniCGXfmdSVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744014314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DnjYap4atApGOWMvIPqJqeN4q+zZIEl85aJTKJMvdSo=;
	b=2zqPouQzr7WMX7qXJZ63KWJ0SxJ6kX+4Ufx+t/BFXO7RtChfnKdtaElxOgJOHiA/M5QZ/W
	i3n1ZNdV3eD2hxCA==
Date: Mon, 07 Apr 2025 10:25:09 +0200
Subject: [PATCH] RDMA: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-restricted-pointers-infiniband-v1-1-22b20504b84d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAOSL82cC/x3NSwrDMAxF0a0EjSuwTUI/WykdJLbcvokSJFMCI
 Xuv6fBM7j3IxSBOj+Egky8cq3bEy0D5M+tbGKWbUkhTGMPIJt4MuUnhbYU2MWdohWKZtXC6x7j
 Itd7ClKlHNpOK/T94vs7zByM2HNNwAAAA
X-Change-ID: 20250404-restricted-pointers-infiniband-2911be7f805c
To: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744014313; l=8479;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3+k79a/2sQfHNTdFYGaSA09bqsx67Vm5FpJsl1jxaCA=;
 b=VQUTwEyj9V5tuJZ57xT2wXnVK41OXVu5bScbwdudI12x6kntw9p2oRThwse1V7q1RWyH3cfG8
 ipWqED95cUNBLjgC4uesl54g9oyl63IYK/LhQZ6jcC4UGRtXRJwLS54
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/infiniband/hw/irdma/ctrl.c       | 2 +-
 drivers/infiniband/hw/irdma/pble.c       | 2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c | 2 +-
 drivers/infiniband/sw/siw/siw.h          | 2 +-
 drivers/infiniband/sw/siw/siw_cq.c       | 2 +-
 drivers/infiniband/sw/siw/siw_mem.c      | 4 ++--
 drivers/infiniband/sw/siw/siw_qp_rx.c    | 8 ++++----
 drivers/infiniband/sw/siw/siw_verbs.c    | 6 +++---
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 6aed6169c07d7d5154b69708dedb39416bca26f2..99a7f1a6c0b587a6b53280456aad0389a708a72d 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3131,7 +3131,7 @@ int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	writel(0, cqp->dev->hw_regs[IRDMA_CCQPSTATUS]);
 
 	ibdev_dbg(to_ibdev(cqp->dev),
-		  "WQE: sq_size[%04d] hw_sq_size[%04d] sq_base[%p] sq_pa[%pK] cqp[%p] polarity[x%04x]\n",
+		  "WQE: sq_size[%04d] hw_sq_size[%04d] sq_base[%p] sq_pa[%p] cqp[%p] polarity[x%04x]\n",
 		  cqp->sq_size, cqp->hw_sq_size, cqp->sq_base,
 		  (u64 *)(uintptr_t)cqp->sq_pa, cqp, cqp->polarity);
 	return 0;
diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index e7ce6840755fdf3d88b5140d486c771800c7554d..37ce35cb10e743a5db835fa81938b94580463636 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -108,7 +108,7 @@ static int add_sd_direct(struct irdma_hmc_pble_rsrc *pble_rsrc,
 	chunk->vaddr = sd_entry->u.bp.addr.va + offset;
 	chunk->fpm_addr = pble_rsrc->next_fpm_addr;
 	ibdev_dbg(to_ibdev(dev),
-		  "PBLE: chunk_size[%lld] = 0x%llx vaddr=0x%pK fpm_addr = %llx\n",
+		  "PBLE: chunk_size[%lld] = 0x%llx vaddr=0x%p fpm_addr = %llx\n",
 		  chunk->size, chunk->size, chunk->vaddr, chunk->fpm_addr);
 
 	return 0;
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index f948b76f984dbb5e816fa006b07c5a16b6a1df1d..3fbf99757b11486f42e2a340e0023b1ac239811a 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -56,7 +56,7 @@ static int usnic_uiom_dma_fault(struct iommu_domain *domain,
 				unsigned long iova, int flags,
 				void *token)
 {
-	usnic_err("Device %s iommu fault domain 0x%pK va 0x%lx flags 0x%x\n",
+	usnic_err("Device %s iommu fault domain 0x%p va 0x%lx flags 0x%x\n",
 		dev_name(dev),
 		domain, iova, flags);
 	return -ENOSYS;
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 385067e07faf190c05f478bb8a29479e38af8562..e49c8a76e22e9eec84aee8238b7e15d2f57cecc9 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -738,7 +738,7 @@ static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 		  "MEM[0x%08x] %s: " fmt, mem->stag, __func__, ##__VA_ARGS__)
 
 #define siw_dbg_cep(cep, fmt, ...)                                             \
-	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%pK] %s: " fmt,                 \
+	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%p] %s: " fmt,                 \
 		  cep, __func__, ##__VA_ARGS__)
 
 void siw_cq_flush(struct siw_cq *cq);
diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index f3c2226aff9452046ad83482829439fd22ac81a1..25b3c741b66b50fb871233565439fe9ebb391820 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -72,7 +72,7 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 			wc->opcode = map_wc_opcode[cqe->opcode];
 			wc->status = map_cqe_status[cqe->status].ib;
 			siw_dbg_cq(cq,
-				   "idx %u, type %d, flags %2x, id 0x%pK\n",
+				   "idx %u, type %d, flags %2x, id 0x%p\n",
 				   cq->cq_get % cq->num_cqe, cqe->opcode,
 				   cqe->flags, (void *)(uintptr_t)cqe->id);
 		} else {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index dcb963607c8b931dd79d1cc65639237e84fd56ba..b17156995595c20397c4628a22b3584ae183222c 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -181,10 +181,10 @@ int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
 	 */
 	if (addr < mem->va || addr + len > mem->va + mem->len) {
 		siw_dbg_pd(pd, "MEM interval len %d\n", len);
-		siw_dbg_pd(pd, "[0x%pK, 0x%pK] out of bounds\n",
+		siw_dbg_pd(pd, "[0x%p, 0x%p] out of bounds\n",
 			   (void *)(uintptr_t)addr,
 			   (void *)(uintptr_t)(addr + len));
-		siw_dbg_pd(pd, "[0x%pK, 0x%pK] STag=0x%08x\n",
+		siw_dbg_pd(pd, "[0x%p, 0x%p] STag=0x%08x\n",
 			   (void *)(uintptr_t)mem->va,
 			   (void *)(uintptr_t)(mem->va + mem->len),
 			   mem->stag);
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 32554eba1eac7c1cce2f63a8ffc2ef07e737cfc6..a10820e3388782ad4380496187043dac385266be 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -38,7 +38,7 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 
 		p = siw_get_upage(umem, dest_addr);
 		if (unlikely(!p)) {
-			pr_warn("siw: %s: [QP %u]: bogus addr: %pK, %pK\n",
+			pr_warn("siw: %s: [QP %u]: bogus addr: %p, %p\n",
 				__func__, qp_id(rx_qp(srx)),
 				(void *)(uintptr_t)dest_addr,
 				(void *)(uintptr_t)umem->fp_addr);
@@ -51,7 +51,7 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 		pg_off = dest_addr & ~PAGE_MASK;
 		bytes = min(len, (int)PAGE_SIZE - pg_off);
 
-		siw_dbg_qp(rx_qp(srx), "page %pK, bytes=%u\n", p, bytes);
+		siw_dbg_qp(rx_qp(srx), "page %p, bytes=%u\n", p, bytes);
 
 		dest = kmap_atomic(p);
 		rv = skb_copy_bits(srx->skb, srx->skb_offset, dest + pg_off,
@@ -105,11 +105,11 @@ static int siw_rx_kva(struct siw_rx_stream *srx, void *kva, int len)
 {
 	int rv;
 
-	siw_dbg_qp(rx_qp(srx), "kva: 0x%pK, len: %u\n", kva, len);
+	siw_dbg_qp(rx_qp(srx), "kva: 0x%p, len: %u\n", kva, len);
 
 	rv = skb_copy_bits(srx->skb, srx->skb_offset, kva, len);
 	if (unlikely(rv)) {
-		pr_warn("siw: [QP %u]: %s, len %d, kva 0x%pK, rv %d\n",
+		pr_warn("siw: [QP %u]: %s, len %d, kva 0x%p, rv %d\n",
 			qp_id(rx_qp(srx)), __func__, len, kva, rv);
 
 		return rv;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index fd7b266a221b2ccd95dc4abcf9561e9dda8155f5..7ce0035c54fac123397df811af0618c0d55fa1e8 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -936,7 +936,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			rv = -EINVAL;
 			break;
 		}
-		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%pK\n",
+		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
 			   sqe->opcode, sqe->flags,
 			   (void *)(uintptr_t)sqe->id);
 
@@ -1332,7 +1332,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	int rv;
 
-	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
+	siw_dbg_pd(pd, "start: 0x%p, va: 0x%p, len: %llu\n",
 		   (void *)(uintptr_t)start, (void *)(uintptr_t)rnic_va,
 		   (unsigned long long)len);
 
@@ -1525,7 +1525,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 		mem->len = base_mr->length;
 		mem->va = base_mr->iova;
 		siw_dbg_mem(mem,
-			"%llu bytes, start 0x%pK, %u SLE to %u entries\n",
+			"%llu bytes, start 0x%p, %u SLE to %u entries\n",
 			mem->len, (void *)(uintptr_t)mem->va, num_sle,
 			pbl->num_buf);
 	}

---
base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
change-id: 20250404-restricted-pointers-infiniband-2911be7f805c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


