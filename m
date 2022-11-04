Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CF61A619
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Nov 2022 00:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKDXsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Nov 2022 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKDXsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Nov 2022 19:48:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C02EF2E
        for <linux-rdma@vger.kernel.org>; Fri,  4 Nov 2022 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667605685; x=1699141685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cH9GUhLG1V4hOzpC2A4jsxR1hInqBVLtqQuqtJhj4ns=;
  b=gGSDplbfHOLf5fK/2/SmZ+ourEqxIl+kCsZZwHQGsN3dSgy9yobW7Dl6
   ZUq9ulkUXmXbdtzGmlWe4JBb19QxwhxD0LIxKHSkISNptb0L5x1f+NBRs
   OBGubXRXehWyeBjEyQ+sgRRpIT/uJo8HYwB6q7nq4CQQgllMoqi4iAiik
   q/QDZRybbis906e4/ZWOnt4jMDFn9yYFF+IXY8VKj7ReOfeWXpudL892B
   B+AhDJjmSOUb+f+DyM+6Zr90naXq9PMkp5u2ZwS8smtyNF99N/GBa/iJ2
   VaB9gLXfMqnpVPFB1HErG5gZ8arJYTSJ4LrK8g2GuLDIVvMHCNojn7x3p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289826781"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="289826781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:48:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="586352308"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="586352308"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.38.106])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:48:03 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/3] RDMA/irdma: Fix inline for multiple SGE's
Date:   Fri,  4 Nov 2022 18:47:47 -0500
Message-Id: <20221104234749.1084-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221104234749.1084-1-shiraz.saleem@intel.com>
References: <20221104234749.1084-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently, inline send and inline write assume a single
SGE and only copy data from the first one. Add support
for multiple SGE's.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c    | 148 +++++++++++++++++++++++-------------
 drivers/infiniband/hw/irdma/user.h  |  18 +----
 drivers/infiniband/hw/irdma/verbs.c |  54 +++++--------
 3 files changed, 115 insertions(+), 105 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a6e5d35..4424224 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -566,21 +566,36 @@ static void irdma_set_mw_bind_wqe_gen_1(__le64 *wqe,
 
 /**
  * irdma_copy_inline_data_gen_1 - Copy inline data to wqe
- * @dest: pointer to wqe
- * @src: pointer to inline data
- * @len: length of inline data to copy
+ * @wqe: pointer to wqe
+ * @sge_list: table of pointers to inline data
+ * @num_sges: Total inline data length
  * @polarity: compatibility parameter
  */
-static void irdma_copy_inline_data_gen_1(u8 *dest, u8 *src, u32 len,
-					 u8 polarity)
+static void irdma_copy_inline_data_gen_1(u8 *wqe, struct ib_sge *sge_list,
+					 u32 num_sges, u8 polarity)
 {
-	if (len <= 16) {
-		memcpy(dest, src, len);
-	} else {
-		memcpy(dest, src, 16);
-		src += 16;
-		dest = dest + 32;
-		memcpy(dest, src, len - 16);
+	u32 quanta_bytes_remaining = 16;
+	int i;
+
+	for (i = 0; i < num_sges; i++) {
+		u8 *cur_sge = (u8 *)(uintptr_t)sge_list[i].addr;
+
+		while (sge_list[i].length) {
+			u32 bytes_copied;
+
+			bytes_copied = min(sge_list[i].length, quanta_bytes_remaining);
+			memcpy(wqe, cur_sge, bytes_copied);
+			wqe += bytes_copied;
+			cur_sge += bytes_copied;
+			quanta_bytes_remaining -= bytes_copied;
+			sge_list[i].length -= bytes_copied;
+
+			if (!quanta_bytes_remaining) {
+				/* Remaining inline bytes reside after the hdr */
+				wqe += 16;
+				quanta_bytes_remaining = 32;
+			}
+		}
 	}
 }
 
@@ -612,35 +627,50 @@ static void irdma_set_mw_bind_wqe(__le64 *wqe,
 
 /**
  * irdma_copy_inline_data - Copy inline data to wqe
- * @dest: pointer to wqe
- * @src: pointer to inline data
- * @len: length of inline data to copy
+ * @wqe: pointer to wqe
+ * @sge_list: table of pointers to inline data
+ * @num_sges: number of SGE's
  * @polarity: polarity of wqe valid bit
  */
-static void irdma_copy_inline_data(u8 *dest, u8 *src, u32 len, u8 polarity)
+static void irdma_copy_inline_data(u8 *wqe, struct ib_sge *sge_list, u32 num_sges,
+				   u8 polarity)
 {
 	u8 inline_valid = polarity << IRDMA_INLINE_VALID_S;
-	u32 copy_size;
-
-	dest += 8;
-	if (len <= 8) {
-		memcpy(dest, src, len);
-		return;
-	}
-
-	*((u64 *)dest) = *((u64 *)src);
-	len -= 8;
-	src += 8;
-	dest += 24; /* point to additional 32 byte quanta */
-
-	while (len) {
-		copy_size = len < 31 ? len : 31;
-		memcpy(dest, src, copy_size);
-		*(dest + 31) = inline_valid;
-		len -= copy_size;
-		dest += 32;
-		src += copy_size;
+	u32 quanta_bytes_remaining = 8;
+	bool first_quanta = true;
+	int i;
+
+	wqe += 8;
+
+	for (i = 0; i < num_sges; i++) {
+		u8 *cur_sge = (u8 *)(uintptr_t)sge_list[i].addr;
+
+		while (sge_list[i].length) {
+			u32 bytes_copied;
+
+			bytes_copied = min(sge_list[i].length, quanta_bytes_remaining);
+			memcpy(wqe, cur_sge, bytes_copied);
+			wqe += bytes_copied;
+			cur_sge += bytes_copied;
+			quanta_bytes_remaining -= bytes_copied;
+			sge_list[i].length -= bytes_copied;
+
+			if (!quanta_bytes_remaining) {
+				quanta_bytes_remaining = 31;
+
+				/* Remaining inline bytes reside after the hdr */
+				if (first_quanta) {
+					first_quanta = false;
+					wqe += 16;
+				} else {
+					*wqe = inline_valid;
+					wqe++;
+				}
+			}
+		}
 	}
+	if (!first_quanta && quanta_bytes_remaining < 31)
+		*(wqe + quanta_bytes_remaining) = inline_valid;
 }
 
 /**
@@ -679,20 +709,27 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 			       struct irdma_post_sq_info *info, bool post_sq)
 {
 	__le64 *wqe;
-	struct irdma_inline_rdma_write *op_info;
+	struct irdma_rdma_write *op_info;
 	u64 hdr = 0;
 	u32 wqe_idx;
 	bool read_fence = false;
+	u32 i, total_size = 0;
 	u16 quanta;
 
 	info->push_wqe = qp->push_db ? true : false;
-	op_info = &info->op.inline_rdma_write;
+	op_info = &info->op.rdma_write;
 
-	if (op_info->len > qp->max_inline_data)
+	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
 		return -EINVAL;
 
-	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(op_info->len);
-	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, op_info->len,
+	for (i = 0; i < op_info->num_lo_sges; i++)
+		total_size += op_info->lo_sg_list[i].length;
+
+	if (unlikely(total_size > qp->max_inline_data))
+		return -EINVAL;
+
+	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(total_size);
+	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
 					 info);
 	if (!wqe)
 		return -ENOMEM;
@@ -705,7 +742,7 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 
 	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
-	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
+	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid ? 1 : 0) |
@@ -719,8 +756,8 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 		set_64bit_val(wqe, 0,
 			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
 
-	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
-					qp->swqe_polarity);
+	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->lo_sg_list,
+					op_info->num_lo_sges, qp->swqe_polarity);
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
 	set_64bit_val(wqe, 24, hdr);
@@ -745,20 +782,27 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 			 struct irdma_post_sq_info *info, bool post_sq)
 {
 	__le64 *wqe;
-	struct irdma_post_inline_send *op_info;
+	struct irdma_post_send *op_info;
 	u64 hdr;
 	u32 wqe_idx;
 	bool read_fence = false;
+	u32 i, total_size = 0;
 	u16 quanta;
 
 	info->push_wqe = qp->push_db ? true : false;
-	op_info = &info->op.inline_send;
+	op_info = &info->op.send;
 
-	if (op_info->len > qp->max_inline_data)
+	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
 		return -EINVAL;
 
-	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(op_info->len);
-	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, op_info->len,
+	for (i = 0; i < op_info->num_sges; i++)
+		total_size += op_info->sg_list[i].length;
+
+	if (unlikely(total_size > qp->max_inline_data))
+		return -EINVAL;
+
+	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(total_size);
+	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
 					 info);
 	if (!wqe)
 		return -ENOMEM;
@@ -773,7 +817,7 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, info->stag_to_inv) |
 	      FIELD_PREP(IRDMAQPSQ_AHID, op_info->ah_id) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
-	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
+	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG,
 			 (info->imm_data_valid ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
@@ -789,8 +833,8 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	if (info->imm_data_valid)
 		set_64bit_val(wqe, 0,
 			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
-	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
-					qp->swqe_polarity);
+	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->sg_list,
+					op_info->num_sges, qp->swqe_polarity);
 
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 2ef6192..f5d3a7c 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -173,14 +173,6 @@ struct irdma_post_send {
 	u32 ah_id;
 };
 
-struct irdma_post_inline_send {
-	void *data;
-	u32 len;
-	u32 qkey;
-	u32 dest_qp;
-	u32 ah_id;
-};
-
 struct irdma_post_rq_info {
 	u64 wr_id;
 	struct ib_sge *sg_list;
@@ -193,12 +185,6 @@ struct irdma_rdma_write {
 	struct ib_sge rem_addr;
 };
 
-struct irdma_inline_rdma_write {
-	void *data;
-	u32 len;
-	struct ib_sge rem_addr;
-};
-
 struct irdma_rdma_read {
 	struct ib_sge *lo_sg_list;
 	u32 num_lo_sges;
@@ -241,8 +227,6 @@ struct irdma_post_sq_info {
 		struct irdma_rdma_read rdma_read;
 		struct irdma_bind_window bind_window;
 		struct irdma_inv_local_stag inv_local_stag;
-		struct irdma_inline_rdma_write inline_rdma_write;
-		struct irdma_post_inline_send inline_send;
 	} op;
 };
 
@@ -291,7 +275,7 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 				   bool post_sq);
 
 struct irdma_wqe_uk_ops {
-	void (*iw_copy_inline_data)(u8 *dest, u8 *src, u32 len, u8 polarity);
+	void (*iw_copy_inline_data)(u8 *dest, struct ib_sge *sge_list, u32 num_sges, u8 polarity);
 	u16 (*iw_inline_data_size_to_quanta)(u32 data_size);
 	void (*iw_set_fragment)(__le64 *wqe, u32 offset, struct ib_sge *sge,
 				u8 valid);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a22afbb..b2006a0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3165,30 +3165,20 @@ static int irdma_post_send(struct ib_qp *ibqp,
 				info.stag_to_inv = ib_wr->ex.invalidate_rkey;
 			}
 
-			if (ib_wr->send_flags & IB_SEND_INLINE) {
-				info.op.inline_send.data = (void *)(unsigned long)
-							   ib_wr->sg_list[0].addr;
-				info.op.inline_send.len = ib_wr->sg_list[0].length;
-				if (iwqp->ibqp.qp_type == IB_QPT_UD ||
-				    iwqp->ibqp.qp_type == IB_QPT_GSI) {
-					ah = to_iwah(ud_wr(ib_wr)->ah);
-					info.op.inline_send.ah_id = ah->sc_ah.ah_info.ah_idx;
-					info.op.inline_send.qkey = ud_wr(ib_wr)->remote_qkey;
-					info.op.inline_send.dest_qp = ud_wr(ib_wr)->remote_qpn;
-				}
+			info.op.send.num_sges = ib_wr->num_sge;
+			info.op.send.sg_list = ib_wr->sg_list;
+			if (iwqp->ibqp.qp_type == IB_QPT_UD ||
+			    iwqp->ibqp.qp_type == IB_QPT_GSI) {
+				ah = to_iwah(ud_wr(ib_wr)->ah);
+				info.op.send.ah_id = ah->sc_ah.ah_info.ah_idx;
+				info.op.send.qkey = ud_wr(ib_wr)->remote_qkey;
+				info.op.send.dest_qp = ud_wr(ib_wr)->remote_qpn;
+			}
+
+			if (ib_wr->send_flags & IB_SEND_INLINE)
 				err = irdma_uk_inline_send(ukqp, &info, false);
-			} else {
-				info.op.send.num_sges = ib_wr->num_sge;
-				info.op.send.sg_list = ib_wr->sg_list;
-				if (iwqp->ibqp.qp_type == IB_QPT_UD ||
-				    iwqp->ibqp.qp_type == IB_QPT_GSI) {
-					ah = to_iwah(ud_wr(ib_wr)->ah);
-					info.op.send.ah_id = ah->sc_ah.ah_info.ah_idx;
-					info.op.send.qkey = ud_wr(ib_wr)->remote_qkey;
-					info.op.send.dest_qp = ud_wr(ib_wr)->remote_qpn;
-				}
+			else
 				err = irdma_uk_send(ukqp, &info, false);
-			}
 			break;
 		case IB_WR_RDMA_WRITE_WITH_IMM:
 			if (ukqp->qp_caps & IRDMA_WRITE_WITH_IMM) {
@@ -3205,22 +3195,14 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			else
 				info.op_type = IRDMA_OP_TYPE_RDMA_WRITE;
 
-			if (ib_wr->send_flags & IB_SEND_INLINE) {
-				info.op.inline_rdma_write.data = (void *)(uintptr_t)ib_wr->sg_list[0].addr;
-				info.op.inline_rdma_write.len =
-						ib_wr->sg_list[0].length;
-				info.op.inline_rdma_write.rem_addr.addr =
-						rdma_wr(ib_wr)->remote_addr;
-				info.op.inline_rdma_write.rem_addr.lkey =
-						rdma_wr(ib_wr)->rkey;
+			info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
+			info.op.rdma_write.lo_sg_list = ib_wr->sg_list;
+			info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
+			info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
+			if (ib_wr->send_flags & IB_SEND_INLINE)
 				err = irdma_uk_inline_rdma_write(ukqp, &info, false);
-			} else {
-				info.op.rdma_write.lo_sg_list = (void *)ib_wr->sg_list;
-				info.op.rdma_write.num_lo_sges = ib_wr->num_sge;
-				info.op.rdma_write.rem_addr.addr = rdma_wr(ib_wr)->remote_addr;
-				info.op.rdma_write.rem_addr.lkey = rdma_wr(ib_wr)->rkey;
+			else
 				err = irdma_uk_rdma_write(ukqp, &info, false);
-			}
 			break;
 		case IB_WR_RDMA_READ_WITH_INV:
 			inv_stag = true;
-- 
1.8.3.1

