Return-Path: <linux-rdma+bounces-7504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B79A2B9C9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 04:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B923A6418
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A61624FF;
	Fri,  7 Feb 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYAUPMTz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC12417E7;
	Fri,  7 Feb 2025 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899448; cv=none; b=rXYib14H3TmTD7douLlqxVRPXLIf+wtugqaU0gmzq8VK82pPXCh9Rt73aRE9P1OPqBgq6wsyRq16z/P0xLE3DH7ajEaPDsY0hPvI5KuL2XU7U4aLN3XKNquPl+csB0YnVsH+uIKeoZeEIuLZwxnlo6Zc3cpGQK22vNcBqqdetjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899448; c=relaxed/simple;
	bh=JVsh83ozxhGPGGffsLq9Ab3W/d2pxVcmEvBOnUHmPws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ38TlAe7HvVtm0TQSx2Tn88XRYzaCPoBA3hOr795iRxJvPNtrSFMWE2vV395+gL1iF0Rj6TOTJ2UlfNLh4wdbwXR4pPKwnx6E/Rz8J9o0QYFdw9oHQcxQ5I5mFJe6a1+BhEFnRMdDkF1TDWU9yB2VjuoqTB7uKmA8e8QRxKl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYAUPMTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC8C4CED1;
	Fri,  7 Feb 2025 03:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738899448;
	bh=JVsh83ozxhGPGGffsLq9Ab3W/d2pxVcmEvBOnUHmPws=;
	h=From:To:Cc:Subject:Date:From;
	b=aYAUPMTzn0lB7q8LTzoNn5h/Yezhu4zobNJD1uO8n5rBHrcdrwRl+vZIHUGhgCEoo
	 pNA6wED+e4C3FK4q7y7XuP1oMzU3ns0+Hc1PDQ9RyYLH0UJXAeNUrNMV+87ztb66OU
	 7OPyaeKayhM5qCTP65SJRBLx9B2HK084yMuos9TFNHsen/9+4J6vgYQGKw/4szZlZW
	 Y4+HTxOqsTcWQGV0I4iKqdG7+mnFewtiw3rNoXbvoaTZV7eqW3eYdEEpYFtgaLbSB7
	 gjSL44hNcZp1TTkYdS2MNYRlIgy34e4MbdYVOgIjdUrcH4NiUwDHcEeIH8x0Kbkrc9
	 vnodmqO/J4/Dg==
From: Eric Biggers <ebiggers@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/irdma: switch to using the crc32c library
Date: Thu,  6 Feb 2025 19:36:43 -0800
Message-ID: <20250207033643.59904-1-ebiggers@kernel.org>
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

Note that for crc32c specifically, the correct replacement for
crypto_shash_digest() is ~crc32c(~0, ...), since crypto_shash_digest()
had before and after inversions built-in whereas crc32c() does not.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: Resent as standalone patch and improved the commit message.
    No code changes.

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
 

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1


