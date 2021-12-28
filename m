Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C493948073B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhL1ICZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235499AbhL1ICX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:23 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AercpgKPcO46kp9LvrR37lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQi5gG8qgjUHzWUaUTvSOPrZMDfwLY9/PdzioEoG65GHm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79CAmj/HQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnbPMbp+OefhBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTDQC/k5TJbbTqPFzd9F1?=
 =?us-ascii?q?Sg9h4ZFGvO2T84YdjdubB3GbDVPJ14IBZN4l+Ct7lH7fjpegFGYv6w65y7U1gM?=
 =?us-ascii?q?Z+LHtOcDSfNiiQ9tUkkeR4GnB+gzRBxseM9ef4Tyb836tj6nEmiaTcIYTEqCos?=
 =?us-ascii?q?/1nmluewkQNBxAME1i2u/+0jgi5Qd03A0gV/Dc+6LI+8UWDUNbwRVu7rWSCsxp?=
 =?us-ascii?q?aXMBfe8U45w6l2KvZ+wvfDWFsc9LrQLTKr+dvHXpziADPxIivWFRSXHSuYSr13?=
 =?us-ascii?q?t+pQfmaYHl9wbc+WBI5?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AO5RRV6xplBwui8LOMMP0KrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+U8ssR4b+exoVJPtfZqYz+8R3WBzB8bEYOCFgh?=
 =?us-ascii?q?rKEGgK1+KLqFeMJ8S9zJ846U4KSclD4bPLYmSS9fyKgjVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657417"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id DC4A84D15A2C;
        Tue, 28 Dec 2021 16:01:52 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:51 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:50 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution in responder side
Date:   Tue, 28 Dec 2021 16:07:15 +0800
Message-ID: <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DC4A84D15A2C.A2D95
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In contrast to other opcodes, after a series of sanity checking, FLUSH
opcode will do a Placement Type checking before it really do the FLUSH
operation. Responder will also reply NAK "Remote Access Error" if it
found a placement type violation.

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

After the execution, responder would reply a responded successfully by
RDMA READ response of zero size.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  28 ++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 131 ++++++++++++++++++++++++++-
 include/uapi/rdma/ib_user_verbs.h    |  10 ++
 5 files changed, 169 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e37aa1944b18..cdfd393b8bd8 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -630,6 +630,34 @@ static inline void feth_init(struct rxe_pkt_info *pkt, u32 type, u32 level)
 	*p = cpu_to_be32(feth);
 }
 
+static inline u32 __feth_plt(void *arg)
+{
+	u32 *fethp = arg;
+	u32 feth = be32_to_cpu(*fethp);
+
+	return (feth & FETH_PLT_MASK) >> FETH_PLT_SHIFT;
+}
+
+static inline u32 __feth_sel(void *arg)
+{
+	u32 *fethp = arg;
+	u32 feth = be32_to_cpu(*fethp);
+
+	return (feth & FETH_SEL_MASK) >> FETH_SEL_SHIFT;
+}
+
+static inline u32 feth_plt(struct rxe_pkt_info *pkt)
+{
+	return __feth_plt(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+}
+
+static inline u32 feth_sel(struct rxe_pkt_info *pkt)
+{
+	return __feth_sel(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+}
+
 /******************************************************************************
  * Atomic Extended Transport Header
  ******************************************************************************/
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1e174afb1d4..73c39ff11e28 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -80,6 +80,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
+void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
+		 size_t *offset_out);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 21616d058f29..2cb530305392 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -325,8 +325,8 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
-			size_t *offset_out)
+void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
+		 size_t *offset_out)
 {
 	struct rxe_map_set *set = mr->cur_map_set;
 	size_t offset = iova - set->iova + set->offset;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e8f435fa6e4d..6730336037d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/skbuff.h>
+#include <linux/libnvdimm.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
@@ -19,6 +20,7 @@ enum resp_states {
 	RESPST_CHK_RESOURCE,
 	RESPST_CHK_LENGTH,
 	RESPST_CHK_RKEY,
+	RESPST_CHK_PLT,
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
 	RESPST_COMPLETE,
@@ -35,6 +37,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_PLT_VIOLATION,
 	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
@@ -53,6 +56,7 @@ static char *resp_state_name[] = {
 	[RESPST_CHK_RESOURCE]			= "CHK_RESOURCE",
 	[RESPST_CHK_LENGTH]			= "CHK_LENGTH",
 	[RESPST_CHK_RKEY]			= "CHK_RKEY",
+	[RESPST_CHK_PLT]			= "CHK_PLACEMENT_TYPE",
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_COMPLETE]			= "COMPLETE",
@@ -69,6 +73,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_PLT_VIOLATION]		= "ERR_PLACEMENT_TYPE_VIOLATION",
 	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
@@ -400,6 +405,30 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	}
 }
 
+static enum resp_states check_placement_type(struct rxe_qp *qp,
+					     struct rxe_pkt_info *pkt)
+{
+	struct rxe_mr *mr = qp->resp.mr;
+	u32 plt = feth_plt(pkt);
+
+	// no FLUSH access flag MR
+	if ((mr->access & IB_ACCESS_FLUSH) == 0) {
+		pr_err("This mr isn't registered any flush access permission\n");
+		return RESPST_ERR_PLT_VIOLATION;
+	}
+
+	if ((plt & IB_EXT_PLT_GLB_VIS &&
+	    !(mr->access & IB_ACCESS_FLUSH_GLOBAL_VISIBILITY)) ||
+	    (plt & IB_EXT_PLT_PERSIST &&
+	    !(mr->access & IB_ACCESS_FLUSH_PERSISTENT))) {
+		pr_err("Target MR don't allow this placement type, is_pmem: %d, register flag: %x, request flag: %x\n",
+		       mr->ibmr.is_pmem, mr->access >> 8, plt);
+		return RESPST_ERR_PLT_VIOLATION;
+	}
+
+	return RESPST_EXECUTE;
+}
+
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -413,7 +442,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_FLUSH_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -434,8 +463,10 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 	/* A zero-byte op is not required to set an addr or rkey. */
+	/* RXE_FETH_MASK carraies zero-byte playload */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
+	    !(pkt->mask & RXE_FETH_MASK) &&
 	    reth_len(pkt) == 0) {
 		return RESPST_EXECUTE;
 	}
@@ -503,7 +534,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	WARN_ON_ONCE(qp->resp.mr);
 
 	qp->resp.mr = mr;
-	return RESPST_EXECUTE;
+	return pkt->mask & RXE_FETH_MASK ? RESPST_CHK_PLT : RESPST_EXECUTE;
 
 err:
 	if (mr)
@@ -549,6 +580,91 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	return rc;
 }
 
+static int nvdimm_flush_iova(struct rxe_mr *mr, u64 iova, int length)
+{
+	int			err;
+	int			bytes;
+	u8			*va;
+	struct rxe_map		**map;
+	struct rxe_phys_buf	*buf;
+	int			m;
+	int			i;
+	size_t			offset;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->type == IB_MR_TYPE_DMA) {
+		arch_wb_cache_pmem((void *)iova, length);
+		return 0;
+	}
+
+	WARN_ON_ONCE(!mr->cur_map_set);
+
+	err = mr_check_range(mr, iova, length);
+	if (err) {
+		err = -EFAULT;
+		goto err1;
+	}
+
+	lookup_iova(mr, iova, &m, &i, &offset);
+
+	map = mr->cur_map_set->map + m;
+	buf	= map[0]->buf + i;
+
+	while (length > 0) {
+		va	= (u8 *)(uintptr_t)buf->addr + offset;
+		bytes	= buf->size - offset;
+
+		if (bytes > length)
+			bytes = length;
+
+		arch_wb_cache_pmem(va, bytes);
+
+		length	-= bytes;
+
+		offset	= 0;
+		buf++;
+		i++;
+
+		if (i == RXE_BUF_PER_MAP) {
+			i = 0;
+			map++;
+			buf = map[0]->buf;
+		}
+	}
+
+	return 0;
+
+err1:
+	return err;
+}
+
+static enum resp_states process_flush(struct rxe_qp *qp,
+				       struct rxe_pkt_info *pkt)
+{
+	u64 length = 0, start = qp->resp.va;
+	u32 sel = feth_sel(pkt);
+	u32 plt = feth_plt(pkt);
+	struct rxe_mr *mr = qp->resp.mr;
+
+	if (sel == IB_EXT_SEL_MR_RANGE)
+		length = qp->resp.length;
+	else if (sel == IB_EXT_SEL_MR_WHOLE)
+		length = mr->cur_map_set->length;
+
+	if (plt == IB_EXT_PLT_PERSIST) {
+		nvdimm_flush_iova(mr, start, length);
+		wmb(); // clwb follows by a sfence
+	} else if (plt == IB_EXT_PLT_GLB_VIS)
+		wmb(); // sfence is enough
+
+	/* set RDMA READ response of zero */
+	qp->resp.resid = 0;
+
+	return RESPST_READ_REPLY;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
@@ -801,6 +917,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		err = process_atomic(qp, pkt);
 		if (err)
 			return err;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return process_flush(qp, pkt);
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1059,7 +1177,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* SEND. Ack again and cleanup. C9-105. */
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
-	} else if (pkt->mask & RXE_READ_MASK) {
+	} else if (pkt->mask & RXE_READ_MASK || pkt->mask & RXE_FLUSH_MASK) {
 		struct resp_res *res;
 
 		res = find_resource(qp, pkt->psn);
@@ -1098,7 +1216,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			/* Reset the resource, except length. */
 			res->read.va_org = iova;
 			res->read.va = iova;
-			res->read.resid = resid;
+			res->read.resid = pkt->mask & RXE_FLUSH_MASK ? 0 : resid;
 
 			/* Replay the RDMA read reply. */
 			qp->resp.res = res;
@@ -1244,6 +1362,9 @@ int rxe_responder(void *arg)
 		case RESPST_CHK_RKEY:
 			state = check_rkey(qp, pkt);
 			break;
+		case RESPST_CHK_PLT:
+			state = check_placement_type(qp, pkt);
+			break;
 		case RESPST_EXECUTE:
 			state = execute(qp, pkt);
 			break;
@@ -1298,6 +1419,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
+		/* oA19-13 8 */
+		case RESPST_ERR_PLT_VIOLATION:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 4b7093f58259..efa06f53c7c6 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -105,6 +105,16 @@ enum {
 	IB_USER_VERBS_EX_CMD_MODIFY_CQ
 };
 
+enum ib_ext_placement_type {
+	IB_EXT_PLT_GLB_VIS = 1 << 0,
+	IB_EXT_PLT_PERSIST = 1 << 1,
+};
+
+enum ib_ext_selectivity_level {
+	IB_EXT_SEL_MR_RANGE = 0,
+	IB_EXT_SEL_MR_WHOLE,
+};
+
 /*
  * Make sure that all structs defined in this file remain laid out so
  * that they pack the same way on 32-bit and 64-bit architectures (to
-- 
2.31.1



