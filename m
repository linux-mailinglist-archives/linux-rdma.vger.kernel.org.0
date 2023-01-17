Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44EC66E4F5
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjAQRco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAQR2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:28:17 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407DB34C3A
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:03 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322d768ba7so32676543fac.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvP4brhSKKKaTYSsFNVN6n6xmS4jKZwxx2cs0lp69cA=;
        b=nk6vlDQPXq9rOuan3jUp7AAJ0LbL+9n10mNlbZ1A0WeFaq8/dB8w3siQC4TqtFm68z
         GI1O3gNuVk7UR5z0rJ7x6TTFnfdgf7vB2VszTKvBEiex4dcugQHSdxTas9fBt7AHWJAX
         uYPTLbcveHTT99Jm9PFT3I18OB5OpZOt6S7dys7Vi0iRQ7Z40OxGe3yQ3jiPMaaYNP7X
         /bCC9mQvbjjo0DVHNrorl8pC4FhqB/c+FO7dnDzY62C9g2d9A7wy+uwTTNwEEYTAvZeQ
         3/ZUsk1wQ/IRPrCZXmBZLhhF06UaDzATzYUH0ZWU2vgCozwJUCddWSEyBtBJS0e7RVhs
         Xoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvP4brhSKKKaTYSsFNVN6n6xmS4jKZwxx2cs0lp69cA=;
        b=KYEe731SD0zH3ZwqqRbD5kaxVk/qlF3i5AJC6eKkBXm4J3xnWSmXpNUwGvIE42G6+P
         c0k3J6xHs0Jw89Z9JLUOukYo2TDTGDc0TzmtLKUtdr8F/aOu22+CO7SVzHtWWUZ4B2yL
         UY8MuXELjITp+6hhJMzBiBByg/QcM4pO1TARRuhOQlGzuRKWnkGt5EB2W8BpI87diRob
         pSX9u+YCLExPc3ZztBF8oYzEpLnGTRBEn6N0ftDPv8sMeVSNEfiyB6c/eKuBN7NwH6a/
         485WxgPLb8hJHnBjvc//nYWILvFTmHitimPCNm//bTDkZaNbUtsLCROfj52LM3CXhqSh
         r/uA==
X-Gm-Message-State: AFqh2kpg93O8JA0jX2W0P77r7Goe4bpXykcsasOEFqZBOnY6vQMjlyG+
        UGqdMET2gqYNUvT1yK5PCVQnH+AxRp2HzA==
X-Google-Smtp-Source: AMrXdXtxgxjxWaT0bT24P1TDpbzLS5W8YQqlUp/b214AAdHSke0/bwZBUASGj5Ofafq6FIcCAFIe5Q==
X-Received: by 2002:a05:6870:b909:b0:152:f9d3:20a1 with SMTP id gx9-20020a056870b90900b00152f9d320a1mr2203945oab.52.1673976423067;
        Tue, 17 Jan 2023 09:27:03 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm16936489oae.34.2023.01.17.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:27:02 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 3/6] RDMA-rxe: Isolate mr code from atomic_reply()
Date:   Tue, 17 Jan 2023 11:25:38 -0600
Message-Id: <20230117172540.33205-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230117172540.33205-1-rpearsonhpe@gmail.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
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

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 83 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 49 +++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 ++
 4 files changed, 76 insertions(+), 63 deletions(-)

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
index 229c7259644c..15a8d44daa35 100644
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
+			return -ERANGE;
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
+		return -EINVAL;
+	}
+
+	va = iova_to_vaddr(mr, iova, sizeof(u64));
+	if (!va) {
+		rxe_dbg_mr(mr, "iova out of range");
+		return -ERANGE;
+	}
+
+	if ((uintptr_t)va & 0x7) {
+		rxe_dbg_mr(mr, "iova not aligned");
+		return RXE_ERR_NOT_ALIGNED;
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
index c74972244f08..1e38e5da1f4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -725,17 +725,12 @@ static enum resp_states process_flush(struct rxe_qp *qp,
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
@@ -743,33 +738,19 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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
+		u64 iova = qp->resp.va + qp->resp.offset;
+
+		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
+					  atmeth_comp(pkt),
+					  atmeth_swap_add(pkt),
+					  &res->atomic.orig_val);
+		if (unlikely(err)) {
+			if (err == -RXE_ERR_NOT_ALIGNED)
+				return RESPST_ERR_MISALIGNED_ATOMIC;
+			else
+				return RESPST_ERR_RKEY_VIOLATION;
 		}
 
-		*vaddr = value;
-		spin_unlock_bh(&atomic_ops_lock);
-
 		qp->resp.msn++;
 
 		/* next expected psn, read handles this separately */
@@ -780,9 +761,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		qp->resp.status = IB_WC_SUCCESS;
 	}
 
-	ret = RESPST_ACKNOWLEDGE;
-out:
-	return ret;
+	return RESPST_ACKNOWLEDGE;
 }
 
 #ifdef CONFIG_64BIT
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 19ddfa890480..691200d99d6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -273,6 +273,11 @@ enum rxe_mr_state {
 	RXE_MR_STATE_VALID,
 };
 
+/* some rxe specific error conditions */
+enum rxe_mr_error {
+	RXE_ERR_NOT_ALIGNED = 0x1001,	/* misaligned address */
+};
+
 enum rxe_mr_copy_dir {
 	RXE_TO_MR_OBJ,
 	RXE_FROM_MR_OBJ,
-- 
2.37.2

