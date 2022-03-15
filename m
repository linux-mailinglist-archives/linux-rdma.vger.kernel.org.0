Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6164D9884
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiCOKO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbiCOKO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:28 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B78E13D18;
        Tue, 15 Mar 2022 03:13:13 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Ago5uHaoQoYMQnxqE7kS8F/Lhl61eBmIXZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjFNWGzXafuNZDbwKd50ad+1pBlTvpPczNMySFBkrHg1QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHl65LPnxSfKBMAxN0rVinaJ7Yw4P56CHt?=
 =?us-ascii?q?V8voYMD0lYRWKhubwy7W+IsF+l8YxPcuxZNtHkn5lxDDdS/0hRPjrR6TD49BH0?=
 =?us-ascii?q?TEoi8ZBNfbDbtUUaHxkaxGoSxFGPBEVTo0/mOOpj3zkWzxetF+R46Ew5gD70At?=
 =?us-ascii?q?02aP/dtXPfdmDSddWn26ZoH7L+yLyBRRyHNiSzjyt8X+2gOLL2yThV+o6Hb2x7?=
 =?us-ascii?q?PlshHWV2G0fCRRQXly+ydG8gEq5UNJ3LVIV9isn66M18SSDUt74dwGxpGaJr1g?=
 =?us-ascii?q?XXN84O+k77hydj6nZ+QCUAkAaQTNbLt8rrsk7QXotzFDht9foAyF/9aeZTHu16?=
 =?us-ascii?q?LiZt3WxNDITIGtEYjULJSMH7NbLsoA+lh+JRd8LLUIfprUZAhmpm3bT8nd43O5?=
 =?us-ascii?q?V0KY2O2yA1Qivq1qRSlLhEmbZPjnqY18=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArYOS1qOkDZL5/sBcTq+jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7SFMoHNuHvBw+/rEoB1573HJYVQqN03I8OroUJVoKkmwyXca2+MsAYs=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648113"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:09 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 129CD4D16FD6;
        Tue, 15 Mar 2022 18:13:04 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:05 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:13:02 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 4/7] RDMA/rxe: Implement flush execution in responder side
Date:   Tue, 15 Mar 2022 18:18:42 +0800
Message-ID: <20220315101845.4166983-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 129CD4D16FD6.A3676
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In contrast to other opcodes, after a series of sanity checking, FLUSH
opcode will do a Placement Type checking before it really do the FLUSH
operation.

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: Fix sparse: incorrect type in assignment; Reported-by: kernel test robot <lkp@intel.com>
V2:
 # from Tom
 - adjust start for WHOLE MR level
 - don't support DMA mr for flush
 - check flush return value
 - FLUSH only requires FLUSH access flags, not READ nor WRITE
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  28 ++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 135 +++++++++++++++++++++++++--
 include/uapi/rdma/ib_user_verbs.h    |  10 ++
 5 files changed, 171 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index 8063b5018445..2fe98146130e 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -626,6 +626,34 @@ static inline void feth_init(struct rxe_pkt_info *pkt, u8 type, u8 level)
 	*p = cpu_to_be32(feth);
 }
 
+static inline u32 __feth_plt(void *arg)
+{
+	__be32 *fethp = arg;
+	u32 feth = be32_to_cpu(*fethp);
+
+	return (feth & FETH_PLT_MASK) >> FETH_PLT_SHIFT;
+}
+
+static inline u32 __feth_sel(void *arg)
+{
+	__be32 *fethp = arg;
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
index 4f5c4af19fe0..28bef8a39cd7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -297,8 +297,8 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
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
index e0093fad4e0f..8ad35667a476 100644
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
@@ -400,6 +405,24 @@ static enum resp_states check_length(struct rxe_qp *qp,
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
+		pr_info("Target MR didn't support this placement type, registered flag: %x, requested flag: %x\n",
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
@@ -413,7 +436,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_FLUSH_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -421,8 +444,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
@@ -434,8 +461,10 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 	/* A zero-byte op is not required to set an addr or rkey. */
+	/* RXE_FETH_MASK carraies zero-byte playload */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
+	    !(pkt->mask & RXE_FETH_MASK) &&
 	    reth_len(pkt) == 0) {
 		return RESPST_EXECUTE;
 	}
@@ -503,7 +532,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	WARN_ON_ONCE(qp->resp.mr);
 
 	qp->resp.mr = mr;
-	return RESPST_EXECUTE;
+	return pkt->mask & RXE_FETH_MASK ? RESPST_CHK_PLT : RESPST_EXECUTE;
 
 err:
 	if (mr)
@@ -549,6 +578,93 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
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
 
@@ -801,6 +917,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		err = process_atomic(qp, pkt);
 		if (err)
 			return err;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return process_flush(qp, pkt);
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1061,7 +1179,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* SEND. Ack again and cleanup. C9-105. */
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
-	} else if (pkt->mask & RXE_READ_MASK) {
+	} else if (pkt->mask & RXE_READ_MASK || pkt->mask & RXE_FLUSH_MASK) {
 		struct resp_res *res;
 
 		res = find_resource(qp, pkt->psn);
@@ -1100,7 +1218,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			/* Reset the resource, except length. */
 			res->read.va_org = iova;
 			res->read.va = iova;
-			res->read.resid = resid;
+			res->read.resid = pkt->mask & RXE_FLUSH_MASK ? 0 : resid;
 
 			/* Replay the RDMA read reply. */
 			qp->resp.res = res;
@@ -1247,6 +1365,9 @@ int rxe_responder(void *arg)
 		case RESPST_CHK_RKEY:
 			state = check_rkey(qp, pkt);
 			break;
+		case RESPST_CHK_PLT:
+			state = check_placement_type(qp, pkt);
+			break;
 		case RESPST_EXECUTE:
 			state = execute(qp, pkt);
 			break;
@@ -1301,6 +1422,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
+		/* oA19-13 8 */
+		case RESPST_ERR_PLT_VIOLATION:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index c4131913ef6a..69a04bb828a0 100644
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
+	IB_EXT_SEL_MR_RANGE = 0, /* select a MR range */
+	IB_EXT_SEL_MR_WHOLE, /* select the whole MR */
+};
+
 /*
  * Make sure that all structs defined in this file remain laid out so
  * that they pack the same way on 32-bit and 64-bit architectures (to
-- 
2.31.1



