Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA933A508
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCNNjl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 09:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhCNNjV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Mar 2021 09:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B1164EB3;
        Sun, 14 Mar 2021 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615729160;
        bh=xO4uu3IeJwNnDyXG2LSEeLLAh1qvAkPTvSeqsWCiZKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/PdubkQE7At+B5RxCaqvENF/SuQOdXtH4TbpuivaBUduMZd0d/6WtL4iZBVF9e6+
         XYu+tdb36vbn+pJqUCxGB049H7bpg6yF32NcAgFWjcCWXBEQJVFkprn3t3co19qUMe
         DDonrjaThILOjnurO3FwUhygUGTBkoQKSFMfpTC1VZQ36rVa/S0U4UUyP8GzMLScnb
         51IQDgaZtHzAo36Pw3xkVLPiyt9k+o2THAx1462mNTE99seqBtpkTKUJor2CapneNb
         cwJy5IyE38E8FbI3+XJhtQU4Zv5EDd27VKzRs0D7CGbW+M5R2XosCxDhApGlRhk+MY
         zSPYiA9vKmATA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH rdma-next 2/2] RDMA: Delete not-used static inline functions
Date:   Sun, 14 Mar 2021 15:39:08 +0200
Message-Id: <20210314133908.291945-3-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314133908.291945-1-leon@kernel.org>
References: <20210314133908.291945-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Perform mass deletion of static inline functions that are not used.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        | 11 ------
 drivers/infiniband/hw/cxgb4/t4.h              | 33 -----------------
 drivers/infiniband/hw/hfi1/chip.h             |  5 ---
 drivers/infiniband/hw/hfi1/hfi.h              |  6 ----
 drivers/infiniband/hw/hfi1/verbs_txreq.h      |  5 ---
 drivers/infiniband/hw/i40iw/i40iw.h           |  9 -----
 drivers/infiniband/hw/i40iw/i40iw_osdep.h     | 22 ------------
 drivers/infiniband/hw/qib/qib.h               | 26 --------------
 drivers/infiniband/hw/qib/qib_common.h        |  7 ----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h     | 10 ------
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 35 -------------------
 drivers/infiniband/sw/siw/iwarp.h             | 13 -------
 drivers/infiniband/sw/siw/siw_mem.h           |  5 ---
 13 files changed, 187 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index f85477f3b037..cdec5deb37a1 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -341,11 +341,6 @@ static inline struct c4iw_dev *to_c4iw_dev(struct ib_device *ibdev)
 	return container_of(ibdev, struct c4iw_dev, ibdev);
 }
 
-static inline struct c4iw_dev *rdev_to_c4iw_dev(struct c4iw_rdev *rdev)
-{
-	return container_of(rdev, struct c4iw_dev, rdev);
-}
-
 static inline struct c4iw_cq *get_chp(struct c4iw_dev *rhp, u32 cqid)
 {
 	return xa_load(&rhp->cqs, cqid);
@@ -659,12 +654,6 @@ static inline u32 c4iw_ib_to_tpt_access(int a)
 	       FW_RI_MEM_ACCESS_LOCAL_READ;
 }
 
-static inline u32 c4iw_ib_to_tpt_bind_access(int acc)
-{
-	return (acc & IB_ACCESS_REMOTE_WRITE ? FW_RI_MEM_ACCESS_REM_WRITE : 0) |
-	       (acc & IB_ACCESS_REMOTE_READ ? FW_RI_MEM_ACCESS_REM_READ : 0);
-}
-
 enum c4iw_mmid_state {
 	C4IW_STAG_STATE_VALID,
 	C4IW_STAG_STATE_INVALID
diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
index b170817b2741..c3b0e2896475 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -487,11 +487,6 @@ static inline int t4_rq_empty(struct t4_wq *wq)
 	return wq->rq.in_use == 0;
 }
 
-static inline int t4_rq_full(struct t4_wq *wq)
-{
-	return wq->rq.in_use == (wq->rq.size - 1);
-}
-
 static inline u32 t4_rq_avail(struct t4_wq *wq)
 {
 	return wq->rq.size - 1 - wq->rq.in_use;
@@ -534,11 +529,6 @@ static inline int t4_sq_empty(struct t4_wq *wq)
 	return wq->sq.in_use == 0;
 }
 
-static inline int t4_sq_full(struct t4_wq *wq)
-{
-	return wq->sq.in_use == (wq->sq.size - 1);
-}
-
 static inline u32 t4_sq_avail(struct t4_wq *wq)
 {
 	return wq->sq.size - 1 - wq->sq.in_use;
@@ -679,11 +669,6 @@ static inline void t4_enable_wq_db(struct t4_wq *wq)
 	wq->rq.queue[wq->rq.size].status.db_off = 0;
 }
 
-static inline int t4_wq_db_enabled(struct t4_wq *wq)
-{
-	return !wq->rq.queue[wq->rq.size].status.db_off;
-}
-
 enum t4_cq_flags {
 	CQ_ARMED	= 1,
 };
@@ -817,19 +802,6 @@ static inline int t4_next_hw_cqe(struct t4_cq *cq, struct t4_cqe **cqe)
 	return ret;
 }
 
-static inline struct t4_cqe *t4_next_sw_cqe(struct t4_cq *cq)
-{
-	if (cq->sw_in_use == cq->size) {
-		pr_warn("%s cxgb4 sw cq overflow cqid %u\n",
-			__func__, cq->cqid);
-		cq->error = 1;
-		return NULL;
-	}
-	if (cq->sw_in_use)
-		return &cq->sw_queue[cq->sw_cidx];
-	return NULL;
-}
-
 static inline int t4_next_cqe(struct t4_cq *cq, struct t4_cqe **cqe)
 {
 	int ret = 0;
@@ -843,11 +815,6 @@ static inline int t4_next_cqe(struct t4_cq *cq, struct t4_cqe **cqe)
 	return ret;
 }
 
-static inline int t4_cq_in_error(struct t4_cq *cq)
-{
-	return *cq->qp_errp;
-}
-
 static inline void t4_set_cq_in_error(struct t4_cq *cq)
 {
 	*cq->qp_errp = 1;
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 2c6f2de74d4d..ac26649d4463 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -822,11 +822,6 @@ int acquire_lcb_access(struct hfi1_devdata *dd, int sleep_ok);
 int release_lcb_access(struct hfi1_devdata *dd, int sleep_ok);
 #define LCB_START DC_LCB_CSRS
 #define LCB_END   DC_8051_CSRS /* next block is 8051 */
-static inline int is_lcb_offset(u32 offset)
-{
-	return (offset >= LCB_START && offset < LCB_END);
-}
-
 extern uint num_vls;
 
 extern uint disable_integrity;
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index e17387e0e24c..0b923044761e 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -717,12 +717,6 @@ static inline void incr_cntr64(u64 *cntr)
 		(*cntr)++;
 }
 
-static inline void incr_cntr32(u32 *cntr)
-{
-	if (*cntr < (u32)-1LL)
-		(*cntr)++;
-}
-
 #define MAX_NAME_SIZE 64
 struct hfi1_msix_entry {
 	enum irq_type type;
diff --git a/drivers/infiniband/hw/hfi1/verbs_txreq.h b/drivers/infiniband/hw/hfi1/verbs_txreq.h
index d2d526c5a756..4bdfc7932376 100644
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.h
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.h
@@ -99,11 +99,6 @@ static inline struct verbs_txreq *get_txreq(struct hfi1_ibdev *dev,
 	return tx;
 }
 
-static inline struct sdma_txreq *get_sdma_txreq(struct verbs_txreq *tx)
-{
-	return &tx->txreq;
-}
-
 static inline struct verbs_txreq *get_waiting_verbs_txreq(struct iowait_work *w)
 {
 	struct sdma_txreq *stx;
diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 6a79502c8b53..be4094ac4fac 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -504,15 +504,6 @@ static inline void i40iw_free_resource(struct i40iw_device *iwdev,
 	spin_unlock_irqrestore(&iwdev->resource_lock, flags);
 }
 
-/**
- * to_iwhdl - Get the handler from the device pointer
- * @iwdev: device pointer
- **/
-static inline struct i40iw_handler *to_iwhdl(struct i40iw_device *iw_dev)
-{
-	return container_of(iw_dev, struct i40iw_handler, device);
-}
-
 struct i40iw_handler *i40iw_find_netdev(struct net_device *netdev);
 
 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_osdep.h b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
index d474aad62a81..d938ccb195b1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_osdep.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
@@ -50,17 +50,6 @@ static inline void set_64bit_val(u64 *wqe_words, u32 byte_index, u64 value)
 	wqe_words[byte_index >> 3] = value;
 }
 
-/**
- * set_32bit_val - set 32 value to hw wqe
- * @wqe_words: wqe addr to write
- * @byte_index: index in wqe
- * @value: value to write
- **/
-static inline void set_32bit_val(u32 *wqe_words, u32 byte_index, u32 value)
-{
-	wqe_words[byte_index >> 2] = value;
-}
-
 /**
  * get_64bit_val - read 64 bit value from wqe
  * @wqe_words: wqe addr
@@ -72,17 +61,6 @@ static inline void get_64bit_val(u64 *wqe_words, u32 byte_index, u64 *value)
 	*value = wqe_words[byte_index >> 3];
 }
 
-/**
- * get_32bit_val - read 32 bit value from wqe
- * @wqe_words: wqe addr
- * @byte_index: index to reaad from
- * @value: return 32 bit value
- **/
-static inline void get_32bit_val(u32 *wqe_words, u32 byte_index, u32 *value)
-{
-	*value = wqe_words[byte_index >> 2];
-}
-
 struct i40iw_dma_mem {
 	void *va;
 	dma_addr_t pa;
diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 9b13f668b31f..88497739029e 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1303,11 +1303,6 @@ int qib_sdma_verbs_send(struct qib_pportdata *, struct rvt_sge_state *,
 /* ppd->sdma_lock should be locked before calling this. */
 int qib_sdma_make_progress(struct qib_pportdata *dd);
 
-static inline int qib_sdma_empty(const struct qib_pportdata *ppd)
-{
-	return ppd->sdma_descq_added == ppd->sdma_descq_removed;
-}
-
 /* must be called under qib_sdma_lock */
 static inline u16 qib_sdma_descq_freecnt(const struct qib_pportdata *ppd)
 {
@@ -1364,27 +1359,6 @@ static inline u32 qib_get_rcvhdrtail(const struct qib_ctxtdata *rcd)
 		*((volatile __le64 *)rcd->rcvhdrtail_kvaddr)); /* DMA'ed */
 }
 
-static inline u32 qib_get_hdrqtail(const struct qib_ctxtdata *rcd)
-{
-	const struct qib_devdata *dd = rcd->dd;
-	u32 hdrqtail;
-
-	if (dd->flags & QIB_NODMA_RTAIL) {
-		__le32 *rhf_addr;
-		u32 seq;
-
-		rhf_addr = (__le32 *) rcd->rcvhdrq +
-			rcd->head + dd->rhf_offset;
-		seq = qib_hdrget_seq(rhf_addr);
-		hdrqtail = rcd->head;
-		if (seq == rcd->seq_cnt)
-			hdrqtail++;
-	} else
-		hdrqtail = qib_get_rcvhdrtail(rcd);
-
-	return hdrqtail;
-}
-
 /*
  * sysfs interface.
  */
diff --git a/drivers/infiniband/hw/qib/qib_common.h b/drivers/infiniband/hw/qib/qib_common.h
index f91f23e02283..cf652831d8e7 100644
--- a/drivers/infiniband/hw/qib/qib_common.h
+++ b/drivers/infiniband/hw/qib/qib_common.h
@@ -795,11 +795,4 @@ static inline __u32 qib_hdrget_use_egr_buf(const __le32 *rbuf)
 {
 	return __le32_to_cpu(rbuf[0]) & QLOGIC_IB_RHF_L_USE_EGR;
 }
-
-static inline __u32 qib_hdrget_qib_ver(__le32 hdrword)
-{
-	return (__le32_to_cpu(hdrword) >> QLOGIC_IB_I_VERS_SHIFT) &
-		QLOGIC_IB_I_VERS_MASK;
-}
-
 #endif                          /* _QIB_COMMON_H */
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index de57f2fed743..763ddc6f25d1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -344,11 +344,6 @@ static inline enum ib_port_state pvrdma_port_state_to_ib(
 	return (enum ib_port_state)state;
 }
 
-static inline int ib_port_cap_flags_to_pvrdma(int flags)
-{
-	return flags & PVRDMA_MASK(PVRDMA_PORT_CAP_FLAGS_MAX);
-}
-
 static inline int pvrdma_port_cap_flags_to_ib(int flags)
 {
 	return flags;
@@ -410,11 +405,6 @@ static inline enum pvrdma_qp_type ib_qp_type_to_pvrdma(enum ib_qp_type type)
 	return (enum pvrdma_qp_type)type;
 }
 
-static inline enum ib_qp_type pvrdma_qp_type_to_ib(enum pvrdma_qp_type type)
-{
-	return (enum ib_qp_type)type;
-}
-
 static inline enum pvrdma_qp_state ib_qp_state_to_pvrdma(enum ib_qp_state state)
 {
 	return (enum pvrdma_qp_state)state;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index e28525a8c275..544b94d97c3a 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -70,30 +70,6 @@ enum pvrdma_mtu {
 	PVRDMA_MTU_4096 = 5,
 };
 
-static inline int pvrdma_mtu_enum_to_int(enum pvrdma_mtu mtu)
-{
-	switch (mtu) {
-	case PVRDMA_MTU_256:	return  256;
-	case PVRDMA_MTU_512:	return  512;
-	case PVRDMA_MTU_1024:	return 1024;
-	case PVRDMA_MTU_2048:	return 2048;
-	case PVRDMA_MTU_4096:	return 4096;
-	default:		return   -1;
-	}
-}
-
-static inline enum pvrdma_mtu pvrdma_mtu_int_to_enum(int mtu)
-{
-	switch (mtu) {
-	case 256:	return PVRDMA_MTU_256;
-	case 512:	return PVRDMA_MTU_512;
-	case 1024:	return PVRDMA_MTU_1024;
-	case 2048:	return PVRDMA_MTU_2048;
-	case 4096:
-	default:	return PVRDMA_MTU_4096;
-	}
-}
-
 enum pvrdma_port_state {
 	PVRDMA_PORT_NOP			= 0,
 	PVRDMA_PORT_DOWN		= 1,
@@ -138,17 +114,6 @@ enum pvrdma_port_width {
 	PVRDMA_WIDTH_12X	= 8,
 };
 
-static inline int pvrdma_width_enum_to_int(enum pvrdma_port_width width)
-{
-	switch (width) {
-	case PVRDMA_WIDTH_1X:	return  1;
-	case PVRDMA_WIDTH_4X:	return  4;
-	case PVRDMA_WIDTH_8X:	return  8;
-	case PVRDMA_WIDTH_12X:	return 12;
-	default:		return -1;
-	}
-}
-
 enum pvrdma_port_speed {
 	PVRDMA_SPEED_SDR	= 1,
 	PVRDMA_SPEED_DDR	= 2,
diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
index e8a04d9c89cb..3f1dedb50a0d 100644
--- a/drivers/infiniband/sw/siw/iwarp.h
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -114,13 +114,6 @@ static inline u8 __ddp_get_version(struct iwarp_ctrl *ctrl)
 	return be16_to_cpu(ctrl->ddp_rdmap_ctrl & DDP_MASK_VERSION) >> 8;
 }
 
-static inline void __ddp_set_version(struct iwarp_ctrl *ctrl, u8 version)
-{
-	ctrl->ddp_rdmap_ctrl =
-		(ctrl->ddp_rdmap_ctrl & ~DDP_MASK_VERSION) |
-		(cpu_to_be16((u16)version << 8) & DDP_MASK_VERSION);
-}
-
 static inline u8 __rdmap_get_version(struct iwarp_ctrl *ctrl)
 {
 	__be16 ver = ctrl->ddp_rdmap_ctrl & RDMAP_MASK_VERSION;
@@ -128,12 +121,6 @@ static inline u8 __rdmap_get_version(struct iwarp_ctrl *ctrl)
 	return be16_to_cpu(ver) >> 6;
 }
 
-static inline void __rdmap_set_version(struct iwarp_ctrl *ctrl, u8 version)
-{
-	ctrl->ddp_rdmap_ctrl = (ctrl->ddp_rdmap_ctrl & ~RDMAP_MASK_VERSION) |
-			       (cpu_to_be16(version << 6) & RDMAP_MASK_VERSION);
-}
-
 static inline u8 __rdmap_get_opcode(struct iwarp_ctrl *ctrl)
 {
 	return be16_to_cpu(ctrl->ddp_rdmap_ctrl & RDMAP_MASK_OPCODE);
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index db138c8423da..f911287576d1 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -29,11 +29,6 @@ static inline void siw_mem_put(struct siw_mem *mem)
 	kref_put(&mem->ref, siw_free_mem);
 }
 
-static inline struct siw_mr *siw_mem2mr(struct siw_mem *m)
-{
-	return container_of(m, struct siw_mr, mem);
-}
-
 static inline void siw_unref_mem_sgl(struct siw_mem **mem, unsigned int num_sge)
 {
 	while (num_sge) {
-- 
2.30.2

