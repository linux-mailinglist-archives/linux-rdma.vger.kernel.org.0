Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6F628F0E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKOBRP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 20:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiKOBRK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 20:17:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7512ADC
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475029; x=1700011029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+h1SDXTmTVLIA/wVceHbR5rHMBFmOwUNl0iAOgxUpw=;
  b=jbk+MjkzjN1wa7Dm3rpIILdSWp4SvpKtaN/KMEr2bVA0/JJWkezQh2U7
   0Q7pHkLKzhwofGPdxxooIXgzmbaVec3Eu+AyuIxKD+y4HHmVSHK+gyVZE
   lwHgrF6QDuw/qj4AH8LG7YFlSCUxnSJR0joiIgQX83WeKsBhJNJ0+Dps0
   Ws5WF/grfR+GfegjZOuX8pFZzraXWf/6D/7/ykGdwNRUbLcWsiLBGJ8GK
   QgxO7X7R0IOZDG7S7GQ0QlM/qsF8tpsVj8Z0zFq7SHDWnDOe9Zm/s6yaP
   dPXXQU2WvG3KmSTXJZIhNk4+dEoCzGyzGWb+TOLcs3FvWsMWHF9gyOknj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309755407"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309755407"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727755016"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727755016"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:08 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 1/3] RDMA/irdma: Fix inline for multiple SGE's
Date:   Mon, 14 Nov 2022 19:16:59 -0600
Message-Id: <20221115011701.1379-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221115011701.1379-1-shiraz.saleem@intel.com>
References: <20221115011701.1379-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/infiniband/hw/irdma/uk.c    | 149 ++++++++++++++++++++++++------------
 drivers/infiniband/hw/irdma/user.h  |  19 +----
 drivers/infiniband/hw/irdma/verbs.c |  55 +++++--------
 3 files changed, 119 insertions(+), 104 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a6e5d35..1a57ed9 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -566,21 +566,37 @@ static void irdma_set_mw_bind_wqe_gen_1(__le64 *wqe,
 
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
+		u32 sge_len = sge_list[i].length;
+
+		while (sge_len) {
+			u32 bytes_copied;
+
+			bytes_copied = min(sge_len, quanta_bytes_remaining);
+			memcpy(wqe, cur_sge, bytes_copied);
+			wqe += bytes_copied;
+			cur_sge += bytes_copied;
+			quanta_bytes_remaining -= bytes_copied;
+			sge_len -= bytes_copied;
+
+			if (!quanta_bytes_remaining) {
+				/* Remaining inline bytes reside after hdr */
+				wqe += 16;
+				quanta_bytes_remaining = 32;
+			}
+		}
 	}
 }
 
@@ -612,35 +628,51 @@ static void irdma_set_mw_bind_wqe(__le64 *wqe,
 
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
+static void irdma_copy_inline_data(u8 *wqe, struct ib_sge *sge_list,
+				   u32 num_sges, u8 polarity)
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
+		u32 sge_len = sge_list[i].length;
+
+		while (sge_len) {
+			u32 bytes_copied;
+
+			bytes_copied = min(sge_len, quanta_bytes_remaining);
+			memcpy(wqe, cur_sge, bytes_copied);
+			wqe += bytes_copied;
+			cur_sge += bytes_copied;
+			quanta_bytes_remaining -= bytes_copied;
+			sge_len -= bytes_copied;
+
+			if (!quanta_bytes_remaining) {
+				quanta_bytes_remaining = 31;
+
+				/* Remaining inline bytes reside after hdr */
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
@@ -679,20 +711,27 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
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
+
+	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
+		return -EINVAL;
 
-	if (op_info->len > qp->max_inline_data)
+	for (i = 0; i < op_info->num_lo_sges; i++)
+		total_size += op_info->lo_sg_list[i].length;
+
+	if (unlikely(total_size > qp->max_inline_data))
 		return -EINVAL;
 
-	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(op_info->len);
-	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, op_info->len,
+	quanta = qp->wqe_ops.iw_inline_data_size_to_quanta(total_size);
+	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
 					 info);
 	if (!wqe)
 		return -ENOMEM;
@@ -705,7 +744,7 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 
 	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, op_info->rem_addr.lkey) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
-	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
+	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid ? 1 : 0) |
@@ -719,7 +758,8 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 		set_64bit_val(wqe, 0,
 			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
 
-	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
+	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->lo_sg_list,
+					op_info->num_lo_sges,
 					qp->swqe_polarity);
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
@@ -745,20 +785,27 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
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
@@ -773,7 +820,7 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	hdr = FIELD_PREP(IRDMAQPSQ_REMSTAG, info->stag_to_inv) |
 	      FIELD_PREP(IRDMAQPSQ_AHID, op_info->ah_id) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
-	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, op_info->len) |
+	      FIELD_PREP(IRDMAQPSQ_INLINEDATALEN, total_size) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG,
 			 (info->imm_data_valid ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
@@ -789,8 +836,8 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	if (info->imm_data_valid)
 		set_64bit_val(wqe, 0,
 			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
-	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->data, op_info->len,
-					qp->swqe_polarity);
+	qp->wqe_ops.iw_copy_inline_data((u8 *)wqe, op_info->sg_list,
+					op_info->num_sges, qp->swqe_polarity);
 
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 2ef6192..424d4aa 100644
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
 
@@ -291,7 +275,8 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 				   bool post_sq);
 
 struct irdma_wqe_uk_ops {
-	void (*iw_copy_inline_data)(u8 *dest, u8 *src, u32 len, u8 polarity);
+	void (*iw_copy_inline_data)(u8 *dest, struct ib_sge *sge_list,
+				    u32 num_sges, u8 polarity);
 	u16 (*iw_inline_data_size_to_quanta)(u32 data_size);
 	void (*iw_set_fragment)(__le64 *wqe, u32 offset, struct ib_sge *sge,
 				u8 valid);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 4342417..e252f43 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3136,30 +3136,20 @@ static int irdma_post_send(struct ib_qp *ibqp,
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
@@ -3176,22 +3166,15 @@ static int irdma_post_send(struct ib_qp *ibqp,
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
+			info.op.rdma_write.rem_addr.addr =
+				rdma_wr(ib_wr)->remote_addr;
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

