Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E615A58A748
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiHEHk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiHEHkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:40:14 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D522F;
        Fri,  5 Aug 2022 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685209; i=@fujitsu.com;
        bh=IZ98BgtTmjYOfpTuaMf9/yrmDSoKEaBVEWxvduNhSFk=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=OQn/NObv0U+ag6azMY1/znyFKJZihZ4uNiBlVR7iGHYPjZBtOJtigSVoydyVkaqls
         ZMz8rsp21BQN8q7ETCNqqLlguaCQ74sR3gmFOTS0mpBLEIWKyoWUxKTh+n74vHXKmf
         7FF77MaakkZR5ZxcteKAE5b7D/TBNTX+XsApqwCTsQVahZtDc33ZNmtto5hR2WfvLJ
         nFX4uA+81vJrEeqa953sWWXJKwZpDf76UjSN/c3DYUYCha+n1ZcM0tlLuwJ/IKYBK1
         kJDXuFPKTFrR/yIuQBMKezVE+SF8tubiLSV1ZCNiipoFsk+6Vp2Umr4q7G7k+pBdrp
         JoqGz2qScyXFQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRWlGSWpSXmKPExsViZ8MxSTfi5Js
  kg3u3xC3mfpezmD71AqPFzBknGC2m/FrKbHF51xw2i2eHelksPkw9wmzxZeo0ZotTv04xWfy9
  9I/N4vyxfnYHbo+ds+6yeyze85LJY9OqTjaP3uZ3bB6Xn1xh9Pi8Sc5j6+fbLAHsUayZeUn5F
  QmsGafPPmYteJBdseXvDbYGxoORXYxcHEICWxglLv3ZzNLFyAnkLGeSuH49BSKxn1Hi6++z7C
  AJNgENiXstNxlBEiICnYwSj/qPsYE4zALnmSSmbfoHViUs4Cuxdu43VhCbRUBFYt2Ku4wgNq+
  Ao8SWI2vYQGwJAQWJKQ/fM4PYnAJOEpu+rWKEWO0ocbRlIQtEvaDEyZlPwGxmAQmJgy9eANVz
  APUqSczsjocYUyExa1YbE4StJnH13CbmCYyCs5B0z0LSvYCRaRWjVVJRZnpGSW5iZo6uoYGBr
  qGhqa6xpa6FkV5ilW6iXmqpbnlqcYkukFterJdaXKxXXJmbnJOil5dasokRGGMpxepBOxi/rf
  ipd4hRkoNJSZT33PE3SUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeINOAOUEi1LTUyvSMnOA8Q6
  TluDgURLhXQfSyltckJhbnJkOkTrFqMsxdfa//cxCLHn5ealS4rxGIEUCIEUZpXlwI2Cp5xKj
  rJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd57IFN4MvNK4Da9AjqCCegIrv+vQY4oSURISTUwF
  SQVnm59q/nNUy79xX6FJtaeaQvdNs/9rZ/OfGlL4YsFl65tTVjUb+2a8euSlajjfU+7zOhpQT
  xxIgWbYuSrw7TvnytS0H3aqf+62C9Iut7Zau37bx997tvLak401i+U5nhQnLOA4dA0sYUKlw8
  d0f0dYRwZtzTo2bTU+oMRLwQqtK/GCae8mNunfszGNsV9y8/Qxs8Juy4xain8fpXUKV2fWB7M
  xh/fP3GewgzNpftqal6Vdhuttvgb1Pg8OSt62UzBqx4nBdWWL/m+feKDEqmI99ka5pOSp506E
  MmR9699+TYu4+8iv1k5sk9tVjpmt8ZnW3TV8aD4IweqXbqu7t8zc+uk8MAjVvvfPnFSYinOSD
  TUYi4qTgQAenHkuLgDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-2.tower-571.messagelabs.com!1659685208!174122!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6637 invoked from network); 5 Aug 2022 07:40:08 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-2.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:40:08 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id EFBE71000C2;
        Fri,  5 Aug 2022 08:40:07 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E17EB100077;
        Fri,  5 Aug 2022 08:40:07 +0100 (BST)
Received: from 4084fd6ad2a8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:40:02 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 4/6] RDMA/rxe: Implement flush execution in responder side
Date:   Fri, 5 Aug 2022 07:46:17 +0000
Message-ID: <1659685579-2-5-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In contrast to other opcodes, after a series of sanity checking, FLUSH
opcode will do a Placement Type checking before it really do the FLUSH
operation. Only the requesting placement types that also registered in
the destination memory region are acceptable.

Otherwise, responder will also reply NAK "Remote Access Error" if it
found a placement type violation.

We will persist data via arch_wb_cache_pmem(), which could be
architecture specific.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
v4: add send_read_response_ack and flush resource
---
 drivers/infiniband/sw/rxe/rxe_hdr.h   |  28 ++++
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 187 +++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +
 include/uapi/rdma/ib_user_verbs.h     |  10 ++
 6 files changed, 231 insertions(+), 6 deletions(-)

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
index 22f6cc31d1d6..a77266cdc066 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -72,6 +72,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
+void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
+		 size_t *offset_out);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 24ca014cdecd..98460fde7332 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -238,8 +238,8 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
-static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
-			size_t *offset_out)
+void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
+		 size_t *offset_out)
 {
 	size_t offset = iova - mr->iova + mr->offset;
 	int			map_index;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4c398fa220fa..4602cfbab78f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/skbuff.h>
+#include <linux/libnvdimm.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
@@ -19,9 +20,11 @@ enum resp_states {
 	RESPST_CHK_RESOURCE,
 	RESPST_CHK_LENGTH,
 	RESPST_CHK_RKEY,
+	RESPST_CHK_PLT,
 	RESPST_EXECUTE,
 	RESPST_READ_REPLY,
 	RESPST_ATOMIC_REPLY,
+	RESPST_PROCESS_FLUSH,
 	RESPST_COMPLETE,
 	RESPST_ACKNOWLEDGE,
 	RESPST_CLEANUP,
@@ -36,6 +39,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_PLT_VIOLATION,
 	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
@@ -54,9 +58,11 @@ static char *resp_state_name[] = {
 	[RESPST_CHK_RESOURCE]			= "CHK_RESOURCE",
 	[RESPST_CHK_LENGTH]			= "CHK_LENGTH",
 	[RESPST_CHK_RKEY]			= "CHK_RKEY",
+	[RESPST_CHK_PLT]			= "CHK_PLACEMENT_TYPE",
 	[RESPST_EXECUTE]			= "EXECUTE",
 	[RESPST_READ_REPLY]			= "READ_REPLY",
 	[RESPST_ATOMIC_REPLY]			= "ATOMIC_REPLY",
+	[RESPST_PROCESS_FLUSH]			= "PROCESS_FLUSH",
 	[RESPST_COMPLETE]			= "COMPLETE",
 	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
 	[RESPST_CLEANUP]			= "CLEANUP",
@@ -71,6 +77,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_PLT_VIOLATION]		= "ERR_PLACEMENT_TYPE_VIOLATION",
 	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
@@ -402,6 +409,24 @@ static enum resp_states check_length(struct rxe_qp *qp,
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
+			(mr->access & IB_ACCESS_FLUSHABLE) >> 8, plt);
+		return RESPST_ERR_PLT_VIOLATION;
+	}
+
+	return RESPST_EXECUTE;
+}
+
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
@@ -415,7 +440,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_FLUSH_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -423,8 +448,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
@@ -436,8 +465,10 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	}
 
 	/* A zero-byte op is not required to set an addr or rkey. */
+	/* RXE_FETH_MASK carraies zero-byte payload */
 	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
 	    (pkt->mask & RXE_RETH_MASK) &&
+	    !(pkt->mask & RXE_FETH_MASK) &&
 	    reth_len(pkt) == 0) {
 		return RESPST_EXECUTE;
 	}
@@ -507,7 +538,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	WARN_ON_ONCE(qp->resp.mr);
 
 	qp->resp.mr = mr;
-	return RESPST_EXECUTE;
+	return pkt->mask & RXE_FETH_MASK ? RESPST_CHK_PLT : RESPST_EXECUTE;
 
 err:
 	if (mr)
@@ -553,6 +584,64 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
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
 static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 					struct rxe_pkt_info *pkt,
 					int type)
@@ -587,11 +676,60 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
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
+	if (res->flush.level == IB_EXT_SEL_MR_RANGE) {
+		start = res->flush.va;
+		length = res->flush.length;
+	} else { /* level == IB_EXT_SEL_MR_WHOLE */
+		start = mr->iova;
+		length = mr->length;
+	}
+
+	if (res->flush.type & IB_EXT_PLT_PERSIST) {
+		if (nvdimm_flush_iova(mr, start, length))
+			return RESPST_ERR_RKEY_VIOLATION;
+		/* Make data persistent. */
+		wmb();
+	} else if (res->flush.type & IB_EXT_PLT_GLB_VIS)
+		/* Make data global visibility. */
+		wmb();
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
 
@@ -892,6 +1030,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_READ_REPLY;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		return RESPST_ATOMIC_REPLY;
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		return RESPST_PROCESS_FLUSH;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -1065,6 +1205,19 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
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
@@ -1075,6 +1228,8 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
 	else if (pkt->mask & RXE_ATOMIC_MASK)
 		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
+	else if (pkt->mask & RXE_FLUSH_MASK)
+		send_read_response_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
@@ -1131,6 +1286,22 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
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
 
@@ -1312,6 +1483,9 @@ int rxe_responder(void *arg)
 		case RESPST_CHK_RKEY:
 			state = check_rkey(qp, pkt);
 			break;
+		case RESPST_CHK_PLT:
+			state = check_placement_type(qp, pkt);
+			break;
 		case RESPST_EXECUTE:
 			state = execute(qp, pkt);
 			break;
@@ -1324,6 +1498,9 @@ int rxe_responder(void *arg)
 		case RESPST_ATOMIC_REPLY:
 			state = atomic_reply(qp, pkt);
 			break;
+		case RESPST_PROCESS_FLUSH:
+			state = process_flush(qp, pkt);
+			break;
 		case RESPST_ACKNOWLEDGE:
 			state = acknowledge(qp, pkt);
 			break;
@@ -1369,6 +1546,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
+		/* oA19-13 8 */
+		case RESPST_ERR_PLT_VIOLATION:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 96af3e054f4d..ac04cd275400 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -165,6 +165,12 @@ struct resp_res {
 			u64		va;
 			u32		resid;
 		} read;
+		struct {
+			u32		length;
+			u64		va;
+			u8 		type;
+			u8		level;
+		} flush;
 	};
 };
 
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 808cf7a39498..4efa3d76d71d 100644
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

