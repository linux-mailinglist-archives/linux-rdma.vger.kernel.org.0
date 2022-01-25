Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A436E49AE9B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453125AbiAYIwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:52:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7819 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452460AbiAYItA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:49:00 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A0XLwJaO14O30vSjvrR2qlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQS/0Gkig2QPymRLUGnTMv2MZGOhfdwgaI/lpkpUvpKDm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yElj/zQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZf0dqeSYeRBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTDQC/k5TJbbTqPFzd9F1?=
 =?us-ascii?q?Sg9h4ZFGvO2T8YQb3xtKgvBZxlOM1IMIJM4gOqswHL4dlVwtFWQrLElpWfJywl?=
 =?us-ascii?q?43KruMfLUfMCHQYNemUPwjmbL+GLRARwAMtGbjz2f/RqEj+/GhyT9XKoUCry09?=
 =?us-ascii?q?/csi1qWrkQWAhkRXluTp+e4hk+3HdlYLiQ85i0rhbQ78FSmX5/2WBjQiHqFuAM?=
 =?us-ascii?q?MHtldCes37CmTxafOpQWUHG4JSnhGctNOnMs3QyE6k0WFmtrBGzNiqvuWRGib+?=
 =?us-ascii?q?7PSqim9UQAXImAqdy4JVQZD6NCLnW2ZpnojVf46SOjs0IKzQmq2nli3QOEFr+1?=
 =?us-ascii?q?7paY2O2+ToTgrWw6Rm6U=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4CtgrK3VDR4i/gjMcaTpAAqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839370"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 74EC44D169C7;
        Tue, 25 Jan 2022 16:44:31 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:31 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:28 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 6/9] RDMA/rxe: Implement flush execution in responder side
Date:   Tue, 25 Jan 2022 16:50:38 +0800
Message-ID: <20220125085041.49175-7-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 74EC44D169C7.A03C8
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

The responder will check the remote requested placement types by checking
the registered access flags.
+------------------------+------------------+--------------+
|                        |     registered flags            |
| remote requested types +------------------+--------------+
|                        |global visibility |  persistence |
|------------------------+------------------+--------------+
| global visibility      |        O         |      x       |
+------------------------+------------------+--------------+
| persistence            |        X         |      O       |
+------------------------+------------------+--------------+
O: allow to request such placement type
X: otherwise

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

After the execution, responder would reply a responded successfully by
RDMA READ response of zero size.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2:
 # from Tom
 - adjust start for WHOLE MR level
 - don't support DMA mr for flush
 - check flush return value
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  28 ++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 136 +++++++++++++++++++++++++--
 include/uapi/rdma/ib_user_verbs.h    |  10 ++
 5 files changed, 172 insertions(+), 8 deletions(-)

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
index 89a3bb4e8b71..cd55fcc00e65 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -298,8 +298,8 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
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
index e0093fad4e0f..3277a36f506f 100644
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
@@ -400,6 +405,25 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	}
 }
 
+static enum resp_states check_placement_type(struct rxe_qp *qp,
+					     struct rxe_pkt_info *pkt)
+{
+	struct rxe_mr *mr = qp->resp.mr;
+	u32 plt = feth_plt(pkt);
+
+	if ((plt & IB_EXT_PLT_GLB_VIS &&
+	    !(mr->access & IB_ACCESS_FLUSH_GLOBAL_VISIBILITY)) ||
+	    (plt & IB_EXT_PLT_PERSIST &&
+	    !(mr->access & IB_ACCESS_FLUSH_PERSISTENT))) {
+		pr_info("Target MR didn't support this placement type, is_pmem: %s, registered flag: %x, requested flag: %x\n",
+		        mr->ibmr.is_pmem ? "true" : "false",
+		        (mr->access & IB_ACCESS_FLUSHABLE) >> 8, plt);
+		return RESPST_ERR_PLT_VIOLATION;
+	}
+
+	return RESPST_EXECUTE;
+}
+
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -413,7 +437,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_FLUSH_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -421,8 +445,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 			qp->resp.resid = reth_len(pkt);
 			qp->resp.length = reth_len(pkt);
 		}
-		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
-						     : IB_ACCESS_REMOTE_WRITE;
+		if (pkt->mask & RXE_FLUSH_MASK)
+			access = IB_ACCESS_FLUSHABLE;
+		else if (pkt->mask & RXE_READ_MASK)
+			access = IB_ACCESS_REMOTE_READ;
+		else
+			access = IB_ACCESS_REMOTE_WRITE;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		qp->resp.va = atmeth_va(pkt);
 		qp->resp.offset = 0;
@@ -434,8 +462,10 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 	/* A zero-byte op is not required to set an addr or rkey. */
+	/* RXE_FETH_MASK carraies zero-byte playload */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
+	    !(pkt->mask & RXE_FETH_MASK) &&
 	    reth_len(pkt) == 0) {
 		return RESPST_EXECUTE;
 	}
@@ -503,7 +533,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	WARN_ON_ONCE(qp->resp.mr);
 
 	qp->resp.mr = mr;
-	return RESPST_EXECUTE;
+	return pkt->mask & RXE_FETH_MASK ? RESPST_CHK_PLT : RESPST_EXECUTE;
 
 err:
 	if (mr)
@@ -549,6 +579,93 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	return rc;
 }
 
+static int nvdimm_flush_iova(struct rxe_mr *mr, u64 iova, int length)
+{
+	int err;
+	int bytes;
+	u8 *va;
+	struct rxe_map **map;
+	struct rxe_phys_buf *buf;
+	int m;
+	int i;
+	size_t offset;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->type == IB_MR_TYPE_DMA) {
+		err = -EFAULT;
+		goto err1;
+	}
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
+	buf = map[0]->buf + i;
+
+	while (length > 0) {
+		va = (u8 *)(uintptr_t)buf->addr + offset;
+		bytes = buf->size - offset;
+
+		if (bytes > length)
+			bytes = length;
+
+		arch_wb_cache_pmem(va, bytes);
+
+		length -= bytes;
+
+		offset = 0;
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
+	u64 length, start;
+	u32 sel = feth_sel(pkt);
+	u32 plt = feth_plt(pkt);
+	struct rxe_mr *mr = qp->resp.mr;
+
+	if (sel == IB_EXT_SEL_MR_RANGE) {
+		start = qp->resp.va;
+		length = qp->resp.length;
+	} else { /* sel == IB_EXT_SEL_MR_WHOLE */
+		start = mr->cur_map_set->iova;
+		length = mr->cur_map_set->length;
+	}
+
+	if (plt & IB_EXT_PLT_PERSIST) {
+		if (nvdimm_flush_iova(mr, start, length))
+			return RESPST_ERR_RKEY_VIOLATION;
+		wmb();
+	} else if (plt & IB_EXT_PLT_GLB_VIS)
+		wmb();
+
+	/* Prepare RDMA READ response of zero */
+	qp->resp.resid = 0;
+
+	return RESPST_READ_REPLY;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
@@ -801,6 +918,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		err = process_atomic(qp, pkt);
 		if (err)
 			return err;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return process_flush(qp, pkt);
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1061,7 +1180,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* SEND. Ack again and cleanup. C9-105. */
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
-	} else if (pkt->mask & RXE_READ_MASK) {
+	} else if (pkt->mask & RXE_READ_MASK || pkt->mask & RXE_FLUSH_MASK) {
 		struct resp_res *res;
 
 		res = find_resource(qp, pkt->psn);
@@ -1100,7 +1219,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			/* Reset the resource, except length. */
 			res->read.va_org = iova;
 			res->read.va = iova;
-			res->read.resid = resid;
+			res->read.resid = pkt->mask & RXE_FLUSH_MASK ? 0 : resid;
 
 			/* Replay the RDMA read reply. */
 			qp->resp.res = res;
@@ -1247,6 +1366,9 @@ int rxe_responder(void *arg)
 		case RESPST_CHK_RKEY:
 			state = check_rkey(qp, pkt);
 			break;
+		case RESPST_CHK_PLT:
+			state = check_placement_type(qp, pkt);
+			break;
 		case RESPST_EXECUTE:
 			state = execute(qp, pkt);
 			break;
@@ -1301,6 +1423,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
+		/* oA19-13 8 */
+		case RESPST_ERR_PLT_VIOLATION:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index c4131913ef6a..be1f9dca08a8 100644
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



