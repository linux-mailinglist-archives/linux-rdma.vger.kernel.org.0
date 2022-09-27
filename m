Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB05EBA3A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiI0F4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI0F4G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:56:06 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 22:55:17 PDT
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B78DA74D6;
        Mon, 26 Sep 2022 22:55:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="89987500"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="89987500"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:08 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A1B98D432A;
        Tue, 27 Sep 2022 14:54:06 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BB0D7D947A;
        Tue, 27 Sep 2022 14:54:05 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 906D911403D7;
        Tue, 27 Sep 2022 14:54:04 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 08/11] RDMA/rxe: Implement flush execution in responder side
Date:   Tue, 27 Sep 2022 13:53:34 +0800
Message-Id: <20220927055337.22630-9-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--10.118100-10.000000
X-TMASE-MatchedRID: /y6RQ8BxlhUYQkBYLWi1BUXBhxFdFgcQltF+xW+zhUiPaLJ/Ca3ST6Yn
        mMLJRh+Ja+o/S6GsElBoVm4pXGYZ6dTgNUieJDkRjhXy0Khej9IJlr1xKkE5ucC5DTEMxpeQfiq
        1gj2xET/gr0WZ6u+ypYSu6NlkfR1/MhccbogzjSS/QNwZdfw3FTKEtjy6tQe+z1qdVCu81fdDJi
        enRpkiMnP+9mhbDjvtsFECQAI2evsR3RjJbq0tuYQTwECUVvOpeF+F9LT9kRKKS8s/FMqmOEwsE
        sMM8cGPtI3VVXMQt02+t9N8LjXJkxhts3z4zPFRJTyMiqml0ik5NozJyIvWPl/8lGqVstJXWzrM
        Xigb0Gm7KTpurpkj8ZRGJCkc1j8t0J+zUQd7y572TmdnNlUFIHiywgNDw+2oSI4EpE9G42qjxYy
        RBa/qJft6/2HgfIgDVymkLM+r7VQ7AFczfjr/7ElofInmj+mfv8FQTAy2hG1E/URDqU+7yE7N6H
        ER0HOtb07M+SvDMKs=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

This commit also add 2 helpers to update qp.resp from the incoming packet.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
v5: add QP attr check for flush access
    rename flush_nvdimm_iova -> rxe_flush_pmem_iova()
v4: add send_read_response_ack and flush resource
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |  60 +++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 180 ++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +
 4 files changed, 225 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..944d564a11cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,6 +68,7 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1da3ad5eba64..fa7e71074233 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/libnvdimm.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -305,6 +307,64 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	return addr;
 }
 
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
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
+	map = mr->map + m;
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
 /* copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova.
  */
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..0b68e5d8e1d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -22,6 +22,7 @@ enum resp_states {
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
 	RESPST_ATOMIC_REPLY,
+	RESPST_PROCESS_FLUSH,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -57,6 +58,7 @@ static char *resp_state_name[] = {
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
+	[RESPST_PROCESS_FLUSH]			= "PROCESS_FLUSH",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -253,19 +255,38 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
 	}
 }
 
+static bool check_qp_attr_access(struct rxe_qp *qp,
+				 struct rxe_pkt_info *pkt)
+{
+	if (((pkt->mask & RXE_READ_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
+	    ((pkt->mask & RXE_WRITE_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
+	    ((pkt->mask & RXE_ATOMIC_MASK) &&
+	     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
+		return false;
+	}
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
-		    ((pkt->mask & RXE_WRITE_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
-		    ((pkt->mask & RXE_ATOMIC_MASK) &&
-		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
+		if (!check_qp_attr_access(qp, pkt))
 			return RESPST_ERR_UNSUPPORTED_OPCODE;
-		}
 
 		break;
 
@@ -402,6 +423,23 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	}
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
@@ -413,23 +451,26 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	u32 pktlen;
 	int mtu = qp->mtu;
 	enum resp_states state;
-	int access;
+	int access = 0;
 
 	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
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
@@ -450,7 +491,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	if (rkey_is_mw(rkey)) {
 		mw = rxe_lookup_mw(qp, access, rkey);
 		if (!mw) {
-			pr_debug("%s: no MW matches rkey %#x\n",
+			pr_err("%s: no MW matches rkey %#x\n",
 					__func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
@@ -458,7 +499,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 		mr = mw->mr;
 		if (!mr) {
-			pr_err("%s: MW doesn't have an MR\n", __func__);
+			pr_debug("%s: MW doesn't have an MR\n", __func__);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -478,12 +519,21 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
 
-	if (pkt->mask & RXE_WRITE_MASK)	 {
+skip_check_range:
+	if (pkt->mask & RXE_WRITE_MASK) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
@@ -587,11 +637,61 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
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
 
@@ -888,6 +988,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_READ_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		return RESPST_ATOMIC_REPLY;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return RESPST_PROCESS_FLUSH;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1061,6 +1163,19 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 	return ret;
 }
 
+static int send_read_response_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
+{
+	int ret = send_common_ack(qp, syndrome, psn,
+			IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY,
+			"RDMA READ response of length zero ACK");
+
+	/* have to clear this since it is used to trigger
+	 * long read replies
+	 */
+	qp->resp.res = NULL;
+	return ret;
+}
+
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
@@ -1071,6 +1186,8 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
 		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
+	else if (pkt->mask & RXE_FLUSH_MASK)
+		send_read_response_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1127,6 +1244,22 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
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
 
@@ -1320,6 +1453,9 @@ int rxe_responder(void *arg)
 		case RESPST_ATOMIC_REPLY:
 			state = atomic_reply(qp, pkt);
 			break;
+		case RESPST_PROCESS_FLUSH:
+			state = process_flush(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5f5cbfcb3569..4cfe4d8b0aaa 100644
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

