Return-Path: <linux-rdma+bounces-7506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F520A2BA00
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 05:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071C31889696
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 04:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F54231CAE;
	Fri,  7 Feb 2025 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv4HfJ4U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2767E9;
	Fri,  7 Feb 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901418; cv=none; b=IRBFCPr4zwnt/tmcWjq9ji3xdqjIr0CjW28KR1ZkmtPSeNN46fyx1bLOv98AvahE0uTkSz9rZUjmOhT3igAU2bfi7SK3eleRlPkDRwp7W6co+5+Ps26DF74+6n4zP65yMGf+zUpytMT1/ZTfgnfIv7Rpzzo0quK/Bx0oYbxnTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901418; c=relaxed/simple;
	bh=HtCNjSH8Ryfa0ku1LVrTtGZFWTFYVMgJPQ0+bK607CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCGz2f73VxH97Ugi5MG6mSnFk+NnANInbL/St7gD/mYswbowFgUgVeC/3yUiSb+d1VLUjTMpnoHjGZB7hiDMjR4pOqFjUMdPm7+H8Yf5F59fMVVYOnkZTBL6nT9TQ5yO6cZitfvkVOFi4TF1jLmx3VLjYAaNN/XUeAJVxUFY4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv4HfJ4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE3C4CED1;
	Fri,  7 Feb 2025 04:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738901417;
	bh=HtCNjSH8Ryfa0ku1LVrTtGZFWTFYVMgJPQ0+bK607CE=;
	h=From:To:Cc:Subject:Date:From;
	b=Rv4HfJ4U46+hO2PlImFD47ipe0JxNRBDA7sjqXZdFoMcs8zQtiVni7RGVtpaLIyUl
	 4nQ3Al5+ijNirS7CB+1mQRkGdTgZDS0jZQB/3d3ETwN1zXVoN73ESN+DaTbVZeyWI/
	 lNF13Lbh96S8Omb5qSkMUfGrTbyU8/mSRqT00QJKApbtNiABNof5fBoTGgxeJS2H2a
	 uF0+OQECtuQGSfkJCIfAIrb2YCYpHKSg/oM7BP8d94JJAjx0VWezpuUWkVvbTaZoqW
	 zIrfIyRSvkDiKH2cp0WtpeHn5euGaiRpCeOGn24gkvbhV9glK9Svifp+Osz9s7DRsc
	 IYGJcfCakD7bQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] RDMA/irdma: switch to using the crc32c library
Date: Thu,  6 Feb 2025 20:08:16 -0800
Message-ID: <20250207040816.69163-1-ebiggers@kernel.org>
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

Note that for crc32c the equivalent of crypto_shash_digest() is
cpu_to_le32(~crc32c(~0, ...)), considering that crypto_shash_digest()
had before and inversions as well as a cpu_to_le32() built-in.  This
means that this driver is using u32 for fixed-endian types; this patch
does not try to fix that but rather just keep the exact same behavior.

Link: https://lore.kernel.org/r/20250207033643.59904-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: Resent as standalone patch and improved the commit message.
v3: Added cpu_to_le32() to match the existing behavior exactly.

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
index 0e594122baa78..e73b14fd95ef1 100644
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
+	if ((__force u32)cpu_to_le32(~crc32c(~0, addr, len)) != val)
 		return -EINVAL;
 
 	return 0;
 }
 

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1


