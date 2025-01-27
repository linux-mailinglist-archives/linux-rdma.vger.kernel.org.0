Return-Path: <linux-rdma+bounces-7259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668FA200B2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB91884E22
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43B1DDA09;
	Mon, 27 Jan 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdzbnMPS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2F1DD0F6;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017540; cv=none; b=cvuIy/hUcY1c61AaVBI9bOp3sIkNNuwwSTziAusi/iVu7WqJdGzosIBmwzaNo76hUOlAdEnoxbwuSVPrInpYF6oen6Rr0e5iZJi2TluLJimNXA6EtxBXR/MBcvT5Ghnjk7xxlsK8poSSpCzCkpd1SvpATNWj9ng6Qxd9zaPkS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017540; c=relaxed/simple;
	bh=wXKtkxdknQtnti8i4l7gtaPVUVhUdaUIoxQBxtfduBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohQyXQ8KbO4lOYGqeFel17WJ313V1UQXB5JkKq/wU0AGpywyPU2u1If+1I1XqMu1yCuc3qLzAi2rCRJBRLbB9wPD9in+2B9hTigLAlE9UeLr1NMV6mMOrLsxOMt2JUZDeeRbGUe53PxPYUJO6zs9zwGoKMIzbepaoEFqZwv21pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdzbnMPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EAC4CEE8;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017539;
	bh=wXKtkxdknQtnti8i4l7gtaPVUVhUdaUIoxQBxtfduBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdzbnMPSe+PYR7PpBXDlvwhdxdoGHV0yPQRIfr692XN0V4eRrdmC0B0KN+mvLrexD
	 USB5lp1e+95v5w3VLy/RQac+Ic4KL0ngQ4/QyyAEqVV+pNdlWrIC6DsmtOqH/nnfl8
	 hdfB/sZptCCGEP0pRD9c7+ArkFlcR+bUwYl6BfALyP2WxX6clJLAL2eniY2fTKWmNa
	 qcVzHZOfDcBxyko3Ef59gV4pPpmk1VgQDbv3mBrho/rCECXFluMCsYua80t8YEb17w
	 aSF2l2i4FMNR1obBHXcKU8+4qm+HgNUBt3FcQPLPUYEgv3rpoOr9ITR3HGPsrZlrUt
	 qZj6/cGprsYNg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] RDMA/irdma: switch to using the crc32c library
Date: Mon, 27 Jan 2025 14:38:38 -0800
Message-ID: <20250127223840.67280-5-ebiggers@kernel.org>
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

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32c().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/hw/irdma/Kconfig |  1 +
 drivers/infiniband/hw/irdma/main.h  |  1 -
 drivers/infiniband/hw/irdma/osdep.h |  6 +---
 drivers/infiniband/hw/irdma/puda.c  | 19 +++++-------
 drivers/infiniband/hw/irdma/puda.h  |  5 +--
 drivers/infiniband/hw/irdma/utils.c | 47 ++---------------------------
 6 files changed, 12 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index b6f9c41bca51d..5f49a58590ed7 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -5,8 +5,9 @@ config INFINIBAND_IRDMA
 	depends on IPV6 || !IPV6
 	depends on PCI
 	depends on ICE && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
+	select CRC32
 	help
 	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
 	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 9f0ed6e844711..0705ef3d72a93 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -28,11 +28,10 @@
 #ifndef CONFIG_64BIT
 #include <linux/io-64-nonatomic-lo-hi.h>
 #endif
 #include <linux/auxiliary_bus.h>
 #include <linux/net/intel/iidc.h>
-#include <crypto/hash.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_pack.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/iw_cm.h>
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index ddf02a462efa2..4b4f78288d12e 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -4,11 +4,10 @@
 #define IRDMA_OSDEP_H
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
 #include <linux/net/intel/iidc.h>
-#include <crypto/hash.h>
 #include <rdma/ib_verbs.h>
 
 #define STATS_TIMER_DELAY	60000
 
 struct irdma_dma_info {
@@ -41,19 +40,16 @@ struct ib_device *to_ibdev(struct irdma_sc_dev *dev);
 void irdma_ieq_mpa_crc_ae(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp);
 enum irdma_status_code irdma_vf_wait_vchnl_resp(struct irdma_sc_dev *dev);
 bool irdma_vf_clear_to_send(struct irdma_sc_dev *dev);
 void irdma_add_dev_ref(struct irdma_sc_dev *dev);
 void irdma_put_dev_ref(struct irdma_sc_dev *dev);
-int irdma_ieq_check_mpacrc(struct shash_desc *desc, void *addr, u32 len,
-			   u32 val);
+int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val);
 struct irdma_sc_qp *irdma_ieq_get_qp(struct irdma_sc_dev *dev,
 				     struct irdma_puda_buf *buf);
 void irdma_send_ieq_ack(struct irdma_sc_qp *qp);
 void irdma_ieq_update_tcpip_info(struct irdma_puda_buf *buf, u16 len,
 				 u32 seqnum);
-void irdma_free_hash_desc(struct shash_desc *hash_desc);
-int irdma_init_hash_desc(struct shash_desc **hash_desc);
 int irdma_puda_get_tcpip_info(struct irdma_puda_cmpl_info *info,
 			      struct irdma_puda_buf *buf);
 int irdma_cqp_sds_cmd(struct irdma_sc_dev *dev,
 		      struct irdma_update_sds_info *info);
 int irdma_cqp_manage_hmc_fcn_cmd(struct irdma_sc_dev *dev,
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 7e3f9bca2c235..694e5a9ed15d0 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -921,12 +921,10 @@ void irdma_puda_dele_rsrc(struct irdma_sc_vsi *vsi, enum puda_rsrc_type type,
 		return;
 	}
 
 	switch (rsrc->cmpl) {
 	case PUDA_HASH_CRC_COMPLETE:
-		irdma_free_hash_desc(rsrc->hash_desc);
-		fallthrough;
 	case PUDA_QP_CREATED:
 		irdma_qp_rem_qos(&rsrc->qp);
 
 		if (!reset)
 			irdma_puda_free_qp(rsrc);
@@ -1093,19 +1091,16 @@ int irdma_puda_create_rsrc(struct irdma_sc_vsi *vsi,
 	ret = irdma_puda_replenish_rq(rsrc, true);
 	if (ret)
 		goto error;
 
 	if (info->type == IRDMA_PUDA_RSRC_TYPE_IEQ) {
-		if (!irdma_init_hash_desc(&rsrc->hash_desc)) {
-			rsrc->check_crc = true;
-			rsrc->cmpl = PUDA_HASH_CRC_COMPLETE;
-			ret = 0;
-		}
+		rsrc->check_crc = true;
+		rsrc->cmpl = PUDA_HASH_CRC_COMPLETE;
 	}
 
 	irdma_sc_ccq_arm(&rsrc->cq);
-	return ret;
+	return 0;
 
 error:
 	irdma_puda_dele_rsrc(vsi, info->type, false);
 
 	return ret;
@@ -1394,12 +1389,12 @@ static int irdma_ieq_handle_partial(struct irdma_puda_rsrc *ieq,
 	irdma_ieq_update_tcpip_info(txbuf, fpdu_len, seqnum);
 
 	crcptr = txbuf->data + fpdu_len - 4;
 	mpacrc = *(u32 *)crcptr;
 	if (ieq->check_crc) {
-		status = irdma_ieq_check_mpacrc(ieq->hash_desc, txbuf->data,
-						(fpdu_len - 4), mpacrc);
+		status = irdma_ieq_check_mpacrc(txbuf->data, fpdu_len - 4,
+						mpacrc);
 		if (status) {
 			ibdev_dbg(to_ibdev(ieq->dev), "IEQ: error bad crc\n");
 			goto error;
 		}
 	}
@@ -1463,12 +1458,12 @@ static int irdma_ieq_process_buf(struct irdma_puda_rsrc *ieq,
 			break;
 		}
 		crcptr = datap + fpdu_len - 4;
 		mpacrc = *(u32 *)crcptr;
 		if (ieq->check_crc)
-			ret = irdma_ieq_check_mpacrc(ieq->hash_desc, datap,
-						     fpdu_len - 4, mpacrc);
+			ret = irdma_ieq_check_mpacrc(datap, fpdu_len - 4,
+						     mpacrc);
 		if (ret) {
 			list_add(&buf->list, rxlist);
 			ibdev_dbg(to_ibdev(ieq->dev),
 				  "ERR: IRDMA_ERR_MPA_CRC\n");
 			return -EINVAL;
diff --git a/drivers/infiniband/hw/irdma/puda.h b/drivers/infiniband/hw/irdma/puda.h
index bc6d9514c9c10..2fc638f2b1434 100644
--- a/drivers/infiniband/hw/irdma/puda.h
+++ b/drivers/infiniband/hw/irdma/puda.h
@@ -117,11 +117,10 @@ struct irdma_puda_rsrc {
 	u64 *rq_wrid_array;
 	u32 compl_rxwqe_idx;
 	u32 rx_wqe_idx;
 	u32 rxq_invalid_cnt;
 	u32 tx_wqe_avail_cnt;
-	struct shash_desc *hash_desc;
 	struct list_head txpend;
 	struct list_head bufpool; /* free buffers pool list for recv and xmit */
 	u32 alloc_buf_count;
 	u32 avail_buf_count; /* snapshot of currently available buffers */
 	spinlock_t bufpool_lock;
@@ -161,14 +160,12 @@ int irdma_puda_poll_cmpl(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq,
 
 struct irdma_sc_qp *irdma_ieq_get_qp(struct irdma_sc_dev *dev,
 				     struct irdma_puda_buf *buf);
 int irdma_puda_get_tcpip_info(struct irdma_puda_cmpl_info *info,
 			      struct irdma_puda_buf *buf);
-int irdma_ieq_check_mpacrc(struct shash_desc *desc, void *addr, u32 len, u32 val);
-int irdma_init_hash_desc(struct shash_desc **desc);
+int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val);
 void irdma_ieq_mpa_crc_ae(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp);
-void irdma_free_hash_desc(struct shash_desc *desc);
 void irdma_ieq_update_tcpip_info(struct irdma_puda_buf *buf, u16 len, u32 seqnum);
 int irdma_cqp_qp_create_cmd(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp);
 int irdma_cqp_cq_create_cmd(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq);
 int irdma_cqp_qp_destroy_cmd(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp);
 void irdma_cqp_cq_destroy_cmd(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 0e594122baa78..57c3335be103c 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1271,62 +1271,19 @@ void irdma_ieq_mpa_crc_ae(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp)
 	info.ae_code = IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR;
 	info.ae_src = IRDMA_AE_SOURCE_RQ;
 	irdma_gen_ae(rf, qp, &info, false);
 }
 
-/**
- * irdma_init_hash_desc - initialize hash for crc calculation
- * @desc: cryption type
- */
-int irdma_init_hash_desc(struct shash_desc **desc)
-{
-	struct crypto_shash *tfm;
-	struct shash_desc *tdesc;
-
-	tfm = crypto_alloc_shash("crc32c", 0, 0);
-	if (IS_ERR(tfm))
-		return -EINVAL;
-
-	tdesc = kzalloc(sizeof(*tdesc) + crypto_shash_descsize(tfm),
-			GFP_KERNEL);
-	if (!tdesc) {
-		crypto_free_shash(tfm);
-		return -EINVAL;
-	}
-
-	tdesc->tfm = tfm;
-	*desc = tdesc;
-
-	return 0;
-}
-
-/**
- * irdma_free_hash_desc - free hash desc
- * @desc: to be freed
- */
-void irdma_free_hash_desc(struct shash_desc *desc)
-{
-	if (desc) {
-		crypto_free_shash(desc->tfm);
-		kfree(desc);
-	}
-}
-
 /**
  * irdma_ieq_check_mpacrc - check if mpa crc is OK
- * @desc: desc for hash
  * @addr: address of buffer for crc
  * @len: length of buffer
  * @val: value to be compared
  */
-int irdma_ieq_check_mpacrc(struct shash_desc *desc, void *addr, u32 len,
-			   u32 val)
+int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val)
 {
-	u32 crc = 0;
-
-	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
-	if (crc != val)
+	if (~crc32c(~0, addr, len) != val)
 		return -EINVAL;
 
 	return 0;
 }
 
-- 
2.48.1


