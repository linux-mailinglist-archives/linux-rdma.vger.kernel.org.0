Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2B6443E2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiLFNDC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiLFNCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:22 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20ED5E;
        Tue,  6 Dec 2022 05:02:19 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="98847119"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="98847119"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C1973DE51A;
        Tue,  6 Dec 2022 22:02:17 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E87C3D35F7;
        Tue,  6 Dec 2022 22:02:16 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id C17452340E31;
        Tue,  6 Dec 2022 22:02:15 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 07/10] RDMA/rxe: Implement flush execution in responder side
Date:   Tue,  6 Dec 2022 21:01:58 +0800
Message-Id: <20221206130201.30986-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--6.450000-10.000000
X-TMASE-MatchedRID: QsbaRgs5dOYYQkBYLWi1BUXBhxFdFgcQltF+xW+zhUiPaLJ/Ca3STw/D
        Z+ACFMnIPkMuv44QRz2fpS8fdiMxuZcLewwAa76fP0HVIeixJdBZDdHiTk9OcDYnGCpPrrgS6Ch
        K9oqyX+Qi+t+0AiFaYvL3NxFKQpq1QCG80HkHq4oZgmFGHqyx61gv+2jH1dCRGW7AFHmXEc850Y
        kGzAMooc4b571oAikeJ5jyXFEJmvXzXojwcywrzHV7tdtvoiban5nfR7I2dFNX2b43f+DxR4fA3
        Ao58IsTPH5gckpEMW9bwwxVC7XRyhhts3z4zPFRJTyMiqml0ik5NozJyIvWPl/8lGqVstJXWzrM
        Xigb0Glg6ZEqxAl4VsadPHWaFCxqdYlaOEy4HByeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+ICq
        uNi0WJEvqD+3+IPJBPIR+8f58nVUFz8h2EBKAmNAD2emRiTwVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Only the requested placement types that also registered in the destination
memory region are acceptable.
Otherwise, responder will also reply NAK "Remote Access Error" if it
found a placement type violation.

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

This commit also adds 2 helpers to update qp.resp from the incoming packet.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
v6: call iova_to_vaddr to transform iova
v5: add QP attr check for flush access
    rename flush_nvdimm_iova -> rxe_flush_pmem_iova()
v4: add send_read_response_ack and flush resource
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |  36 ++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 160 ++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +
 4 files changed, 183 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a22476d27b38..948ce4902b10 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -64,6 +64,7 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 81a438e5010a..072eac4b65d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/libnvdimm.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -192,6 +194,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
+	mr->ibmr.page_size = PAGE_SIZE;
 
 	return 0;
 
@@ -295,6 +298,39 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	return addr;
 }
 
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
+{
+	size_t offset;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		return -EFAULT;
+
+	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
+	while (length > 0) {
+		u8 *va;
+		int bytes;
+
+		bytes = mr->ibmr.page_size - offset;
+		if (bytes > length)
+			bytes = length;
+
+		va = iova_to_vaddr(mr, iova, length);
+		if (!va)
+			return -EFAULT;
+
+		arch_wb_cache_pmem(va, bytes);
+
+		length -= bytes;
+		iova += bytes;
+		offset = 0;
+	}
+
+	return 0;
+}
+
 /* copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova.
  */
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 12a699ffa323..798fb36ee867 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -23,6 +23,7 @@ enum resp_states {
 	RESPST_READ_REPLY,
 	RESPST_ATOMIC_REPLY,
 	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -59,6 +60,7 @@ static char *resp_state_name[] = {
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
 	[RESPST_ATOMIC_WRITE_REPLY]		= "ATOMIC_WRITE_REPLY",
+	[RESPST_PROCESS_FLUSH]			= "PROCESS_FLUSH",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -258,19 +260,37 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
 	}
 }
 
+static bool check_qp_attr_access(struct rxe_qp *qp,
+				 struct rxe_pkt_info *pkt)
+{
+	if (((pkt->mask & RXE_READ_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
+	    ((pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
+	    ((pkt->mask & RXE_ATOMIC_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)))
+		return false;
+
+	if (pkt->mask & RXE_FLUSH_MASK) {
+		u32 flush_type = feth_plt(pkt);
+
+		if ((flush_type & IB_FLUSH_GLOBAL &&
+		     !(qp->attr.qp_access_flags & IB_ACCESS_FLUSH_GLOBAL)) ||
+		    (flush_type & IB_FLUSH_PERSISTENT &&
+		     !(qp->attr.qp_access_flags & IB_ACCESS_FLUSH_PERSISTENT)))
+			return false;
+	}
+
+	return true;
+}
+
 static enum resp_states check_op_valid(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (((pkt->mask & RXE_READ_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
-		    ((pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
-		    ((pkt->mask & RXE_ATOMIC_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
+		if (!check_qp_attr_access(qp, pkt))
 			return RESPST_ERR_UNSUPPORTED_OPCODE;
-		}
 
 		break;
 
@@ -427,6 +447,23 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	return RESPST_CHK_RKEY;
 }
 
+static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	qp->resp.va = reth_va(pkt);
+	qp->resp.offset = 0;
+	qp->resp.rkey = reth_rkey(pkt);
+	qp->resp.resid = reth_len(pkt);
+	qp->resp.length = reth_len(pkt);
+}
+
+static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	qp->resp.va = atmeth_va(pkt);
+	qp->resp.offset = 0;
+	qp->resp.rkey = atmeth_rkey(pkt);
+	qp->resp.resid = sizeof(u64);
+}
+
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -438,23 +475,26 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	u32 pktlen;
 	int mtu = qp->mtu;
 	enum resp_states state;
-	int access;
+	int access = 0;
 
 	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
-		if (pkt->mask & RXE_RETH_MASK) {
-			qp->resp.va = reth_va(pkt);
-			qp->resp.offset = 0;
-			qp->resp.rkey = reth_rkey(pkt);
-			qp->resp.resid = reth_len(pkt);
-			qp->resp.length = reth_len(pkt);
-		}
+		if (pkt->mask & RXE_RETH_MASK)
+			qp_resp_from_reth(qp, pkt);
+
 		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
 						     : IB_ACCESS_REMOTE_WRITE;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		u32 flush_type = feth_plt(pkt);
+
+		if (pkt->mask & RXE_RETH_MASK)
+			qp_resp_from_reth(qp, pkt);
+
+		if (flush_type & IB_FLUSH_GLOBAL)
+			access |= IB_ACCESS_FLUSH_GLOBAL;
+		if (flush_type & IB_FLUSH_PERSISTENT)
+			access |= IB_ACCESS_FLUSH_PERSISTENT;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
-		qp->resp.va = atmeth_va(pkt);
-		qp->resp.offset = 0;
-		qp->resp.rkey = atmeth_rkey(pkt);
-		qp->resp.resid = sizeof(u64);
+		qp_resp_from_atmeth(qp, pkt);
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		return RESPST_EXECUTE;
@@ -501,11 +541,20 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		}
 	}
 
+	if (pkt->mask & RXE_FLUSH_MASK) {
+		/* FLUSH MR may not set va or resid
+		 * no need to check range since we will flush whole mr
+		 */
+		if (feth_sel(pkt) == IB_FLUSH_MR)
+			goto skip_check_range;
+	}
+
 	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
 
+skip_check_range:
 	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
@@ -611,11 +660,61 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 		res->last_psn = pkt->psn;
 		res->cur_psn = pkt->psn;
 		break;
+	case RXE_FLUSH_MASK:
+		res->flush.va = qp->resp.va + qp->resp.offset;
+		res->flush.length = qp->resp.length;
+		res->flush.type = feth_plt(pkt);
+		res->flush.level = feth_sel(pkt);
 	}
 
 	return res;
 }
 
+static enum resp_states process_flush(struct rxe_qp *qp,
+				       struct rxe_pkt_info *pkt)
+{
+	u64 length, start;
+	struct rxe_mr *mr = qp->resp.mr;
+	struct resp_res *res = qp->resp.res;
+
+	/* oA19-14, oA19-15 */
+	if (res && res->replay)
+		return RESPST_ACKNOWLEDGE;
+	else if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_FLUSH_MASK);
+		qp->resp.res = res;
+	}
+
+	if (res->flush.level == IB_FLUSH_RANGE) {
+		start = res->flush.va;
+		length = res->flush.length;
+	} else { /* level == IB_FLUSH_MR */
+		start = mr->ibmr.iova;
+		length = mr->ibmr.length;
+	}
+
+	if (res->flush.type & IB_FLUSH_PERSISTENT) {
+		if (rxe_flush_pmem_iova(mr, start, length))
+			return RESPST_ERR_RKEY_VIOLATION;
+		/* Make data persistent. */
+		wmb();
+	} else if (res->flush.type & IB_FLUSH_GLOBAL) {
+		/* Make data global visibility. */
+		wmb();
+	}
+
+	qp->resp.msn++;
+
+	/* next expected psn, read handles this separately */
+	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
+
+	qp->resp.opcode = pkt->opcode;
+	qp->resp.status = IB_WC_SUCCESS;
+
+	return RESPST_ACKNOWLEDGE;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 static DEFINE_SPINLOCK(atomic_ops_lock);
 
@@ -970,6 +1069,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_ATOMIC_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
 		return RESPST_ATOMIC_WRITE_REPLY;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return RESPST_PROCESS_FLUSH;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1166,7 +1267,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
 		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
-	else if (pkt->mask & RXE_ATOMIC_WRITE_MASK)
+	else if (pkt->mask & (RXE_FLUSH_MASK | RXE_ATOMIC_WRITE_MASK))
 		send_read_response_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
@@ -1224,6 +1325,22 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 		/* SEND. Ack again and cleanup. C9-105. */
 		send_ack(qp, AETH_ACK_UNLIMITED, prev_psn);
 		return RESPST_CLEANUP;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		struct resp_res *res;
+
+		/* Find the operation in our list of responder resources. */
+		res = find_resource(qp, pkt->psn);
+		if (res) {
+			res->replay = 1;
+			res->cur_psn = pkt->psn;
+			qp->resp.res = res;
+			rc = RESPST_PROCESS_FLUSH;
+			goto out;
+		}
+
+		/* Resource not found. Class D error. Drop the request. */
+		rc = RESPST_CLEANUP;
+		goto out;
 	} else if (pkt->mask & RXE_READ_MASK) {
 		struct resp_res *res;
 
@@ -1421,6 +1538,9 @@ int rxe_responder(void *arg)
 		case RESPST_ATOMIC_WRITE_REPLY:
 			state = atomic_write_reply(qp, pkt);
 			break;
+		case RESPST_PROCESS_FLUSH:
+			state = process_flush(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..19ddfa890480 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -165,6 +165,12 @@ struct resp_res {
 			u64		va;
 			u32		resid;
 		} read;
+		struct {
+			u32		length;
+			u64		va;
+			u8		type;
+			u8		level;
+		} flush;
 	};
 };
 
-- 
2.31.1

