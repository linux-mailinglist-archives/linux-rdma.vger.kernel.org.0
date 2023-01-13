Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89968668859
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAMAWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjAMAWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:01 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFA5E0A0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:00 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e205so16581391oif.11
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doH5pfEhKyXp0YMTNNNIQAEkD7VY0qN/u2wnPS9b96M=;
        b=gJeW9NDLOivbFzS56FJSOPYJ3aZlw5IAhjbohXXS5uWuNxtcLTtHcFOWXoW2Ureh50
         KYRomxYcEQHSQLxw7Kve1uAo9IRS8bOdH+T+lanK3y7bMO8xxUWSPKUhHhubGFm+6nLt
         0+AH2s7YAXQA+EL3O8QBbjyHyVtisiA3QZ91vCg/yqZIVpG7xTRDzdQgMMEP6/MgDbXs
         v2V+MaHWYd3aLeQM6QetvpQNGzmeOdcl8GTCvHjjI3Izlwcy58GBT4HKSyTsEnyHXbNg
         fyjMAXNH+v+7wtdA5fQk36RzU6kLP+tyBwHzTumWvNdG8aIM23a4a0KrlcFzj9uNl4Fm
         U2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doH5pfEhKyXp0YMTNNNIQAEkD7VY0qN/u2wnPS9b96M=;
        b=qMeNcmb0Av36gquynP2K11zTUKs88w54Wmnd/Xku4p+NHlHRslB2o62tH6BrUy4L/e
         EWYrhexFfabqoLiT0u7ajaWruKPpzpx+XvN3uTJxnZFglXWmoGaiIMtk7MdrgGQJYIbu
         uomjScsusoVnjxelIcqkBhY90d2of4tkIC1IZ0xtgywi2USFCawrKmjjZIFaYVHJuRZd
         1yKqUvAzg7UIG6RR/CzL/zfsuYpJCJXlfaoundpIyWOVuyfOYBFO8pWEQeJzkwdjdJAu
         3Ghoqb+wkKPGu0Qjc8G/0x1AkK2Fypt3WLUznn8tpGCnrgGJ1HRPnvxTd1xISMo6wDCk
         /35w==
X-Gm-Message-State: AFqh2koDtQ/W8CAGgpvMTQWD46mX74OXXoRGGaRVakHCds0llQSl/1JY
        fA1Pzda6wCkHRffiQ/ECrwg=
X-Google-Smtp-Source: AMrXdXuxXJuNKow8UDkFq5Oypt8u+Em1eGDS7TOPKhgEogGEe4fdPHAJ7ckWSv+hc6h3jfE4iXQ0Kw==
X-Received: by 2002:a05:6808:298c:b0:360:d2eb:47c6 with SMTP id ex12-20020a056808298c00b00360d2eb47c6mr33442088oib.8.1673569319898;
        Thu, 12 Jan 2023 16:21:59 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:21:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 3/6] RDMA-rxe: Isolate mr code from atomic_reply()
Date:   Thu, 12 Jan 2023 18:21:13 -0600
Message-Id: <20230113002116.457324-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113002116.457324-1-rpearsonhpe@gmail.com>
References: <20230113002116.457324-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c   | 30 +++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 49 ++++++++--------------------
 3 files changed, 45 insertions(+), 36 deletions(-)

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
index 229c7259644c..791731be6067 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -538,6 +538,36 @@ int copy_data(
 	return err;
 }
 
+static DEFINE_SPINLOCK(atomic_ops_lock);
+
+int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			u64 compare, u64 swap_add, u64 *orig_val)
+{
+	u64 *vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	u64 value;
+
+	/* needs to match rxe_resp.c */
+	if (mr->state != RXE_MR_STATE_VALID || !vaddr)
+		return -EFAULT;
+	if ((uintptr_t)vaddr & 0x7)
+		return -EINVAL;
+
+	spin_lock_bh(&atomic_ops_lock);
+	value = *orig_val = *vaddr;
+
+	if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+		if (value == compare)
+			value = swap_add;
+	} else {
+		value += swap_add;
+	}
+
+	*vaddr = value;
+	spin_unlock_bh(&atomic_ops_lock);
+
+	return 0;
+}
+
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
 	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c74972244f08..02301e3f343c 100644
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
@@ -743,32 +738,16 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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
-
-		*vaddr = value;
-		spin_unlock_bh(&atomic_ops_lock);
+		u64 iova = qp->resp.va + qp->resp.offset;
+
+		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
+					  atmeth_comp(pkt),
+					  atmeth_swap_add(pkt),
+					  &res->atomic.orig_val);
+		if (err == -EINVAL)
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+		else if (err)
+			return RESPST_ERR_RKEY_VIOLATION;
 
 		qp->resp.msn++;
 
@@ -780,9 +759,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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

