Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A46747C5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjATADx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 19:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjATADd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 19:03:33 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCEA1036
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:53 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id r205so3110678oib.9
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+gP/lvHHKv8wsim8rUNS15T+ZqyfL9oBJpF9AVIHZA=;
        b=o+pXYGbd0v7U+Pg87pi0lcGlh3M+YgaykGuHka9NnOkubotlhRCw/jlH8o/OeNvn7m
         TBdvZrvYnHpCmR8cYFd+zfUFexP2QFahTJS+8lux3YFsHouKeL6VrGvzjyfAHJo0YlP9
         cHcqcq1Eva23zkBl2sMLDH26XXyRd2OrM6KLQ+bxGbFrxrb6FULsd1tTyFu7T1h0w05n
         /B//5mOCbFGbs2LcWqD+ucZO6ZHiLYJV+3u+W82ab+mzn2MMF8YhR5f60F4332ERLoLo
         n8WeLwj4tHh9hezA6GpFYZ3/EBmZuapCH3lQguv7WCiSYsA5ykdozRSEIB1uKM6uC03W
         dsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+gP/lvHHKv8wsim8rUNS15T+ZqyfL9oBJpF9AVIHZA=;
        b=gJObNiUqnEjWvDMI3QpFyV8IgQ0LTsujc8/ydS/shmEiNeZ0/9oTGNem9oKa/GiLfR
         TYqztMBbGSnFvpFpcoVZ7a/GkhQonn9sqGANlZPSu2wEgx6FUUvLog0sgbAb0BoKe5CR
         o59qMBL5fuGDHj02UKENbS2vM6AnJ1/XlqK0P2EOgJYJF7Y1JuHoHXfolD/KxSxAsGme
         M5AUzkS1CFkxZ9BrynlrHVsxREgW2BJbRaRGlXY/1ULiOunXfhXkKejqwHs8FILpcV/g
         n5HekdUUfNZAc4FyTz+Rc6pY3c6oop1DHXqyElK6nz3IE4T55PoDb3fny5GlPuoUwBBa
         mwMg==
X-Gm-Message-State: AFqh2krBpNTxkES9kV2C7STZLmJKYvIX1uOodP5Uf751uyxxPdmSZYJY
        WNEJ3H5/wA6Q8D5gO2GuXos=
X-Google-Smtp-Source: AMrXdXuF6Q9e8XsvkoaxHKZ5YoVX66wz3SSuvGQHju+w/rlSe579eE7FEvZkq3coYuLeTK9srasLFg==
X-Received: by 2002:a54:4009:0:b0:364:3792:97aa with SMTP id x9-20020a544009000000b00364379297aamr6274782oie.10.1674172972654;
        Thu, 19 Jan 2023 16:02:52 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id bj23-20020a056808199700b0036718f58b7esm6139394oib.15.2023.01.19.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:02:52 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 3/6] RDMA-rxe: Isolate mr code from atomic_reply()
Date:   Thu, 19 Jan 2023 17:59:34 -0600
Message-Id: <20230119235936.19728-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230119235936.19728-1-rpearsonhpe@gmail.com>
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Isolate mr specific code from atomic_reply() in rxe_resp.c into
a subroutine rxe_mr_do_atomic_op() in rxe_mr.c.
Minor cleanups to rxe_check_range() and iova_to_vaddr().
Move enum resp_state to rxe.h

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h      | 38 +++++++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +
 drivers/infiniband/sw/rxe/rxe_mr.c   | 83 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_resp.c | 82 ++++-----------------------
 4 files changed, 105 insertions(+), 100 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index ab334900fcc3..2415f3704f57 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -57,6 +57,44 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
+/* responder states */
+enum resp_states {
+	RESPST_NONE,
+	RESPST_GET_REQ,
+	RESPST_CHK_PSN,
+	RESPST_CHK_OP_SEQ,
+	RESPST_CHK_OP_VALID,
+	RESPST_CHK_RESOURCE,
+	RESPST_CHK_LENGTH,
+	RESPST_CHK_RKEY,
+	RESPST_EXECUTE,
+	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
+	RESPST_COMPLETE,
+	RESPST_ACKNOWLEDGE,
+	RESPST_CLEANUP,
+	RESPST_DUPLICATE_REQUEST,
+	RESPST_ERR_MALFORMED_WQE,
+	RESPST_ERR_UNSUPPORTED_OPCODE,
+	RESPST_ERR_MISALIGNED_ATOMIC,
+	RESPST_ERR_PSN_OUT_OF_SEQ,
+	RESPST_ERR_MISSING_OPCODE_FIRST,
+	RESPST_ERR_MISSING_OPCODE_LAST_C,
+	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
+	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
+	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
+	RESPST_ERR_LENGTH,
+	RESPST_ERR_CQ_OVERFLOW,
+	RESPST_ERROR,
+	RESPST_RESET,
+	RESPST_DONE,
+	RESPST_EXIT,
+};
+
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 29b6c2143045..bcb1bbcf50df 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -72,6 +72,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
+int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			u64 compare, u64 swap_add, u64 *orig_val);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 229c7259644c..df9741474f1f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -32,13 +32,15 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	case IB_MR_TYPE_USER:
 	case IB_MR_TYPE_MEM_REG:
-		if (iova < mr->ibmr.iova || length > mr->ibmr.length ||
-		    iova > mr->ibmr.iova + mr->ibmr.length - length)
-			return -EFAULT;
+		if (iova < mr->ibmr.iova ||
+		    iova + length > mr->ibmr.iova + mr->ibmr.length) {
+			rxe_dbg_mr(mr, "iova/length out of range");
+			return -EINVAL;
+		}
 		return 0;
 
 	default:
-		rxe_dbg_mr(mr, "type (%d) not supported\n", mr->ibmr.type);
+		rxe_dbg_mr(mr, "mr type not supported\n");
 		return -EINVAL;
 	}
 }
@@ -299,37 +301,22 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
 	int m, n;
-	void *addr;
 
-	if (mr->state != RXE_MR_STATE_VALID) {
-		rxe_dbg_mr(mr, "Not in valid state\n");
-		addr = NULL;
-		goto out;
-	}
+	if (mr->state != RXE_MR_STATE_VALID)
+		return NULL;
 
-	if (!mr->map) {
-		addr = (void *)(uintptr_t)iova;
-		goto out;
-	}
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		return (void *)(uintptr_t)iova;
 
-	if (mr_check_range(mr, iova, length)) {
-		rxe_dbg_mr(mr, "Range violation\n");
-		addr = NULL;
-		goto out;
-	}
+	if (mr_check_range(mr, iova, length))
+		return NULL;
 
 	lookup_iova(mr, iova, &m, &n, &offset);
 
-	if (offset + length > mr->map[m]->buf[n].size) {
-		rxe_dbg_mr(mr, "Crosses page boundary\n");
-		addr = NULL;
-		goto out;
-	}
-
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+	if (offset + length > mr->map[m]->buf[n].size)
+		return NULL;
 
-out:
-	return addr;
+	return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
 }
 
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
@@ -538,6 +525,46 @@ int copy_data(
 	return err;
 }
 
+/* Guarantee atomicity of atomic operations at the machine level. */
+static DEFINE_SPINLOCK(atomic_ops_lock);
+
+int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			u64 compare, u64 swap_add, u64 *orig_val)
+{
+	u64 *va;
+	u64 value;
+
+	if (mr->state != RXE_MR_STATE_VALID) {
+		rxe_dbg_mr(mr, "mr not in valid state");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	va = iova_to_vaddr(mr, iova, sizeof(u64));
+	if (!va) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	if ((uintptr_t)va & 0x7) {
+		rxe_dbg_mr(mr, "iova not aligned");
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
+
+	spin_lock_bh(&atomic_ops_lock);
+	value = *orig_val = *va;
+
+	if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+		if (value == compare)
+			*va = swap_add;
+	} else {
+		value += swap_add;
+		*va = value;
+	}
+	spin_unlock_bh(&atomic_ops_lock);
+
+	return 0;
+}
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c74972244f08..9d4b4e9b42fc 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -10,43 +10,6 @@
 #include "rxe_loc.h"
 #include "rxe_queue.h"
 
-enum resp_states {
-	RESPST_NONE,
-	RESPST_GET_REQ,
-	RESPST_CHK_PSN,
-	RESPST_CHK_OP_SEQ,
-	RESPST_CHK_OP_VALID,
-	RESPST_CHK_RESOURCE,
-	RESPST_CHK_LENGTH,
-	RESPST_CHK_RKEY,
-	RESPST_EXECUTE,
-	RESPST_READ_REPLY,
-	RESPST_ATOMIC_REPLY,
-	RESPST_ATOMIC_WRITE_REPLY,
-	RESPST_PROCESS_FLUSH,
-	RESPST_COMPLETE,
-	RESPST_ACKNOWLEDGE,
-	RESPST_CLEANUP,
-	RESPST_DUPLICATE_REQUEST,
-	RESPST_ERR_MALFORMED_WQE,
-	RESPST_ERR_UNSUPPORTED_OPCODE,
-	RESPST_ERR_MISALIGNED_ATOMIC,
-	RESPST_ERR_PSN_OUT_OF_SEQ,
-	RESPST_ERR_MISSING_OPCODE_FIRST,
-	RESPST_ERR_MISSING_OPCODE_LAST_C,
-	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
-	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
-	RESPST_ERR_RNR,
-	RESPST_ERR_RKEY_VIOLATION,
-	RESPST_ERR_INVALIDATE_RKEY,
-	RESPST_ERR_LENGTH,
-	RESPST_ERR_CQ_OVERFLOW,
-	RESPST_ERROR,
-	RESPST_RESET,
-	RESPST_DONE,
-	RESPST_EXIT,
-};
-
 static char *resp_state_name[] = {
 	[RESPST_NONE]				= "NONE",
 	[RESPST_GET_REQ]			= "GET_REQ",
@@ -725,17 +688,12 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	return RESPST_ACKNOWLEDGE;
 }
 
-/* Guarantee atomicity of atomic operations at the machine level. */
-static DEFINE_SPINLOCK(atomic_ops_lock);
-
 static enum resp_states atomic_reply(struct rxe_qp *qp,
-					 struct rxe_pkt_info *pkt)
+				     struct rxe_pkt_info *pkt)
 {
-	u64 *vaddr;
-	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
-	u64 value;
+	int err;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
@@ -743,32 +701,14 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	}
 
 	if (!res->replay) {
-		if (mr->state != RXE_MR_STATE_VALID) {
-			ret = RESPST_ERR_RKEY_VIOLATION;
-			goto out;
-		}
-
-		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
-					sizeof(u64));
-
-		/* check vaddr is 8 bytes aligned. */
-		if (!vaddr || (uintptr_t)vaddr & 7) {
-			ret = RESPST_ERR_MISALIGNED_ATOMIC;
-			goto out;
-		}
-
-		spin_lock_bh(&atomic_ops_lock);
-		res->atomic.orig_val = value = *vaddr;
-
-		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-			if (value == atmeth_comp(pkt))
-				value = atmeth_swap_add(pkt);
-		} else {
-			value += atmeth_swap_add(pkt);
-		}
+		u64 iova = qp->resp.va + qp->resp.offset;
 
-		*vaddr = value;
-		spin_unlock_bh(&atomic_ops_lock);
+		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
+					  atmeth_comp(pkt),
+					  atmeth_swap_add(pkt),
+					  &res->atomic.orig_val);
+		if (err)
+			return err;
 
 		qp->resp.msn++;
 
@@ -780,9 +720,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		qp->resp.status = IB_WC_SUCCESS;
 	}
 
-	ret = RESPST_ACKNOWLEDGE;
-out:
-	return ret;
+	return RESPST_ACKNOWLEDGE;
 }
 
 #ifdef CONFIG_64BIT
-- 
2.37.2

