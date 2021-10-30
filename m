Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3A4406FD
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Oct 2021 04:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhJ3Cyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 22:54:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:37494 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhJ3Cym (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 22:54:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="229518332"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="229518332"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 19:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="499153928"
Received: from unknown (HELO intel-100.bj.intel.com) ([10.238.154.100])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2021 19:52:10 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCHv2 1/1] RDMA/irdma: optimize rx path by removing unnecessary copy
Date:   Sat, 30 Oct 2021 06:42:26 -0400
Message-Id: <20211030104226.253346-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the function irdma_post_recv, the function irdma_copy_sg_list is
not needed since the struct irdma_sge and ib_sge have the similar
member variables. The struct irdma_sge can be replaced with the
struct ib_sge totally.

This can increase the rx performance of irdma.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: remove the unnecessary typecast.
---
 drivers/infiniband/hw/irdma/uk.c    | 38 +++++++++++++-------------
 drivers/infiniband/hw/irdma/user.h  | 23 ++++++----------
 drivers/infiniband/hw/irdma/verbs.c | 42 +++++++++--------------------
 3 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 5fb92de1f015..0abbfa2538f1 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -13,16 +13,16 @@
  * @sge: sge length and stag
  * @valid: The wqe valid
  */
-static void irdma_set_fragment(__le64 *wqe, u32 offset, struct irdma_sge *sge,
+static void irdma_set_fragment(__le64 *wqe, u32 offset, struct ib_sge *sge,
 			       u8 valid)
 {
 	if (sge) {
 		set_64bit_val(wqe, offset,
-			      FIELD_PREP(IRDMAQPSQ_FRAG_TO, sge->tag_off));
+			      FIELD_PREP(IRDMAQPSQ_FRAG_TO, sge->addr));
 		set_64bit_val(wqe, offset + 8,
 			      FIELD_PREP(IRDMAQPSQ_VALID, valid) |
-			      FIELD_PREP(IRDMAQPSQ_FRAG_LEN, sge->len) |
-			      FIELD_PREP(IRDMAQPSQ_FRAG_STAG, sge->stag));
+			      FIELD_PREP(IRDMAQPSQ_FRAG_LEN, sge->length) |
+			      FIELD_PREP(IRDMAQPSQ_FRAG_STAG, sge->lkey));
 	} else {
 		set_64bit_val(wqe, offset, 0);
 		set_64bit_val(wqe, offset + 8,
@@ -38,14 +38,14 @@ static void irdma_set_fragment(__le64 *wqe, u32 offset, struct irdma_sge *sge,
  * @valid: wqe valid flag
  */
 static void irdma_set_fragment_gen_1(__le64 *wqe, u32 offset,
-				     struct irdma_sge *sge, u8 valid)
+				     struct ib_sge *sge, u8 valid)
 {
 	if (sge) {
 		set_64bit_val(wqe, offset,
-			      FIELD_PREP(IRDMAQPSQ_FRAG_TO, sge->tag_off));
+			      FIELD_PREP(IRDMAQPSQ_FRAG_TO, sge->addr));
 		set_64bit_val(wqe, offset + 8,
-			      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_LEN, sge->len) |
-			      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_STAG, sge->stag));
+			      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_LEN, sge->length) |
+			      FIELD_PREP(IRDMAQPSQ_GEN1_FRAG_STAG, sge->lkey));
 	} else {
 		set_64bit_val(wqe, offset, 0);
 		set_64bit_val(wqe, offset + 8, 0);
@@ -289,7 +289,7 @@ enum irdma_status_code irdma_uk_rdma_write(struct irdma_qp_uk *qp,
 		return IRDMA_ERR_INVALID_FRAG_COUNT;
 
 	for (i = 0; i < op_info->num_lo_sges; i++)
-		total_size += op_info->lo_sg_list[i].len;
+		total_size += op_info->lo_sg_list[i].length;
 
 	read_fence |= info->read_fence;
 
@@ -310,7 +310,7 @@ enum irdma_status_code irdma_uk_rdma_write(struct irdma_qp_uk *qp,
 	irdma_clr_wqes(qp, wqe_idx);
 
 	set_64bit_val(wqe, 16,
-		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.tag_off));
+		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.addr));
 
 	if (info->imm_data_valid) {
 		set_64bit_val(wqe, 0,
@@ -339,7 +339,7 @@ enum irdma_status_code irdma_uk_rdma_write(struct irdma_qp_uk *qp,
 			++addl_frag_cnt;
 	}
 
-	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.stag) |
+	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt) |
@@ -391,7 +391,7 @@ enum irdma_status_code irdma_uk_rdma_read(struct irdma_qp_uk *qp,
 		return IRDMA_ERR_INVALID_FRAG_COUNT;
 
 	for (i = 0; i < op_info->num_lo_sges; i++)
-		total_size += op_info->lo_sg_list[i].len;
+		total_size += op_info->lo_sg_list[i].length;
 
 	ret_code = irdma_fragcnt_to_quanta_sq(op_info->num_lo_sges, &quanta);
 	if (ret_code)
@@ -426,8 +426,8 @@ enum irdma_status_code irdma_uk_rdma_read(struct irdma_qp_uk *qp,
 			++addl_frag_cnt;
 	}
 	set_64bit_val(wqe, 16,
-		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.tag_off));
-	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.stag) |
+		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.addr));
+	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE,
@@ -477,7 +477,7 @@ enum irdma_status_code irdma_uk_send(struct irdma_qp_uk *qp,
 		return IRDMA_ERR_INVALID_FRAG_COUNT;
 
 	for (i = 0; i < op_info->num_sges; i++)
-		total_size += op_info->sg_list[i].len;
+		total_size += op_info->sg_list[i].length;
 
 	if (info->imm_data_valid)
 		frag_cnt = op_info->num_sges + 1;
@@ -705,9 +705,9 @@ irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *in
 
 	read_fence |= info->read_fence;
 	set_64bit_val(wqe, 16,
-		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.tag_off));
+		      FIELD_PREP(IRDMAQPSQ_FRAG_TO, op_info->rem_addr.addr));
 
-	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.stag) |
+	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
@@ -826,7 +826,7 @@ irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 	u64 hdr;
 	u32 wqe_idx;
 	bool local_fence = false;
-	struct irdma_sge sge = {};
+	struct ib_sge sge = {};
 
 	info->push_wqe = qp->push_db ? true : false;
 	op_info = &info->op.inv_local_stag;
@@ -839,7 +839,7 @@ irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 
 	irdma_clr_wqes(qp, wqe_idx);
 
-	sge.stag = op_info->target_stag;
+	sge.lkey = op_info->target_stag;
 	qp->wqe_ops.iw_set_fragment(wqe, 0, &sge, 0);
 
 	set_64bit_val(wqe, 16, 0);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index e0e9512ad3d5..2af5986039e2 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -16,7 +16,6 @@
 #define irdma_access_privileges u32
 #define irdma_physical_fragment u64
 #define irdma_address_list u64 *
-#define irdma_sgl struct irdma_sge *
 
 #define	IRDMA_MAX_MR_SIZE       0x200000000000ULL
 
@@ -151,12 +150,6 @@ struct irdma_cq_uk;
 struct irdma_qp_uk_init_info;
 struct irdma_cq_uk_init_info;
 
-struct irdma_sge {
-	irdma_tagged_offset tag_off;
-	u32 len;
-	irdma_stag stag;
-};
-
 struct irdma_ring {
 	u32 head;
 	u32 tail;
@@ -172,7 +165,7 @@ struct irdma_extended_cqe {
 };
 
 struct irdma_post_send {
-	irdma_sgl sg_list;
+	struct ib_sge *sg_list;
 	u32 num_sges;
 	u32 qkey;
 	u32 dest_qp;
@@ -189,26 +182,26 @@ struct irdma_post_inline_send {
 
 struct irdma_post_rq_info {
 	u64 wr_id;
-	irdma_sgl sg_list;
+	struct ib_sge *sg_list;
 	u32 num_sges;
 };
 
 struct irdma_rdma_write {
-	irdma_sgl lo_sg_list;
+	struct ib_sge *lo_sg_list;
 	u32 num_lo_sges;
-	struct irdma_sge rem_addr;
+	struct ib_sge rem_addr;
 };
 
 struct irdma_inline_rdma_write {
 	void *data;
 	u32 len;
-	struct irdma_sge rem_addr;
+	struct ib_sge rem_addr;
 };
 
 struct irdma_rdma_read {
-	irdma_sgl lo_sg_list;
+	struct ib_sge *lo_sg_list;
 	u32 num_lo_sges;
-	struct irdma_sge rem_addr;
+	struct ib_sge rem_addr;
 };
 
 struct irdma_bind_window {
@@ -306,7 +299,7 @@ enum irdma_status_code irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 struct irdma_wqe_uk_ops {
 	void (*iw_copy_inline_data)(u8 *dest, u8 *src, u32 len, u8 polarity);
 	u16 (*iw_inline_data_size_to_quanta)(u32 data_size);
-	void (*iw_set_fragment)(__le64 *wqe, u32 offset, struct irdma_sge *sge,
+	void (*iw_set_fragment)(__le64 *wqe, u32 offset, struct ib_sge *sge,
 				u8 valid);
 	void (*iw_set_mw_bind_wqe)(__le64 *wqe,
 				   struct irdma_bind_window *op_info);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 02ca1f80968e..7f5f1ac0bed0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3039,24 +3039,6 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	return 0;
 }
 
-/**
- * irdma_copy_sg_list - copy sg list for qp
- * @sg_list: copied into sg_list
- * @sgl: copy from sgl
- * @num_sges: count of sg entries
- */
-static void irdma_copy_sg_list(struct irdma_sge *sg_list, struct ib_sge *sgl,
-			       int num_sges)
-{
-	unsigned int i;
-
-	for (i = 0; (i < num_sges) && (i < IRDMA_MAX_WQ_FRAGMENT_COUNT); i++) {
-		sg_list[i].tag_off = sgl[i].addr;
-		sg_list[i].len = sgl[i].length;
-		sg_list[i].stag = sgl[i].lkey;
-	}
-}
-
 /**
  * irdma_post_send -  kernel application wr
  * @ibqp: qp ptr for wr
@@ -3133,8 +3115,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 				ret = irdma_uk_inline_send(ukqp, &info, false);
 			} else {
 				info.op.send.num_sges = ib_wr->num_sge;
-				info.op.send.sg_list = (struct irdma_sge *)
-						       ib_wr->sg_list;
+				info.op.send.sg_list = ib_wr->sg_list;
 				if (iwqp->ibqp.qp_type == IB_QPT_UD ||
 				    iwqp->ibqp.qp_type == IB_QPT_GSI) {
 					ah = to_iwah(ud_wr(ib_wr)->ah);
@@ -3169,15 +3150,18 @@ static int irdma_post_send(struct ib_qp *ibqp,
 
 			if (ib_wr->send_flags & IB_SEND_INLINE) {
 				info.op.inline_rdma_write.data = (void *)(uintptr_t)ib_wr->sg_list[0].addr;
-				info.op.inline_rdma_write.len = ib_wr->sg_list[0].length;
-				info.op.inline_rdma_write.rem_addr.tag_off = rdma_wr(ib_wr)->remote_addr;
-				info.op.inline_rdma_write.rem_addr.stag = rdma_wr(ib_wr)->rkey;
+				info.op.inline_rdma_write.len =
+						ib_wr->sg_list[0].length;
+				info.op.inline_rdma_write.rem_addr.addr =
+						rdma_wr(ib_wr)->remote_addr;
+				info.op.inline_rdma_write.rem_addr.lkey =
+						rdma_wr(ib_wr)->rkey;
 				ret = irdma_uk_inline_rdma_write(ukqp, &info, false);
 			} else {
 				info.op.rdma_write.lo_sg_list = (void *)ib_wr->sg_list;
 				info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
-				info.op.rdma_write.rem_addr.tag_off = rdma_wr(ib_wr)->remote_addr;
-				info.op.rdma_write.rem_addr.stag = rdma_wr(ib_wr)->rkey;
+				info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
+				info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
 				ret = irdma_uk_rdma_write(ukqp, &info, false);
 			}
 
@@ -3198,8 +3182,8 @@ static int irdma_post_send(struct ib_qp *ibqp,
 				break;
 			}
 			info.op_type = IRDMA_OP_TYPE_RDMA_READ;
-			info.op.rdma_read.rem_addr.tag_off = rdma_wr(ib_wr)->remote_addr;
-			info.op.rdma_read.rem_addr.stag = rdma_wr(ib_wr)->rkey;
+			info.op.rdma_read.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
+			info.op.rdma_read.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
 			info.op.rdma_read.lo_sg_list = (void *)ib_wr->sg_list;
 			info.op.rdma_read.num_lo_sges = ib_wr->num_sge;
 
@@ -3286,7 +3270,6 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 	struct irdma_qp *iwqp;
 	struct irdma_qp_uk *ukqp;
 	struct irdma_post_rq_info post_recv = {};
-	struct irdma_sge sg_list[IRDMA_MAX_WQ_FRAGMENT_COUNT];
 	enum irdma_status_code ret = 0;
 	unsigned long flags;
 	int err = 0;
@@ -3301,8 +3284,7 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 	while (ib_wr) {
 		post_recv.num_sges = ib_wr->num_sge;
 		post_recv.wr_id = ib_wr->wr_id;
-		irdma_copy_sg_list(sg_list, ib_wr->sg_list, ib_wr->num_sge);
-		post_recv.sg_list = sg_list;
+		post_recv.sg_list = ib_wr->sg_list;
 		ret = irdma_uk_post_receive(ukqp, &post_recv);
 		if (ret) {
 			ibdev_dbg(&iwqp->iwdev->ibdev,
-- 
2.27.0

