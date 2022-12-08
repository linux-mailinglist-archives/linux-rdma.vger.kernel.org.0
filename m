Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6086477A5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLHVGX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLHVGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:21 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4645A55CAB
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:19 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so3319820fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OJYdjDARobolHECRntd+ljS9KueGSdGES7AKt0DFFQ=;
        b=OI7Agi5IQBR7DLZZk0iyzCHi0ebiaFBsMTba6TXOLPlgzE9/rj9Lzeq1xGNkLCr5KO
         NkgswnMJm28PEtZziWDglOiyWtyqn43taRQjesA0HE9QG7uVzJ4gm8FFlUDhvls9GU5Q
         /hYiuzCMc3aMzhHF1b3NqdokYXAnxfYhRrqz61Cqi9BRhIlsSjKrbNEYMvfj9srokB9x
         miG4T376nKinkvNoWTVyzZrQke+pDMl04K3F3H8an1BFT/Z2UqRSeBdcdsvLp4nHCW8m
         VD13xOufx/ReCmFW9aZfYIrA0NN0zTZ5glEp+QyhJZgPPkuMe42Oe7pmEmRk/B4YRKga
         pMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OJYdjDARobolHECRntd+ljS9KueGSdGES7AKt0DFFQ=;
        b=w3nmjRUBZBAoizxy5fzotpqee0DNgbkcmXH65WcyhMmM73vIvN5jVq9MEPxjJ549K/
         CJWdwMuK/dz6s+87e8C7JjYJtLIZRgicnCth9UiwghoPfQCzPNlzGRdrUfewZQDiWQwM
         6ZQoc2hh+zrb/vQv9XlE83EqC4a/9npkx7TAfFFMmsrsRxmxUcXzaYdF8E8NNOyhe1zD
         6WE1Z7cDUkMmwMq5H3tVBOuDu8q5LiAPS/J1xz29XwLPegcIRReqaigdcEIhzNuvWHy6
         BbvjJ0B8n5eQdIg4a1bNamTxa8KNI3+NmYuIDOsLEwH0s1FylmW2xPbgWyJy3jget/z+
         ynjA==
X-Gm-Message-State: ANoB5pkjYM+/T1x79QFfA8crzk21PJDZeRhFLCqBqgH4OVsxlEeyMKXH
        AkD5k2cIamQs8ocAnDv1/QAZOwF4Qek=
X-Google-Smtp-Source: AA0mqf4Fs7MvvJTB4vUPkM6EUVTBQ7okMKNvMv9eDwqbj/jpSLoAi7uPVl/PtvW7A5yE7LOufcAEkQ==
X-Received: by 2002:a05:6871:420a:b0:144:935c:6333 with SMTP id li10-20020a056871420a00b00144935c6333mr2159834oab.6.1670533578608;
        Thu, 08 Dec 2022 13:06:18 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:18 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/6] RDMA-rxe: Isolate mr code from atomic_reply()
Date:   Thu,  8 Dec 2022 15:05:45 -0600
Message-Id: <20221208210547.28562-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208210547.28562-1-rpearsonhpe@gmail.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c   | 30 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 47 +++++++---------------------
 3 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 11106c181e74..b14607bb54b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,6 +71,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
+int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			u64 compare, u64 swap_add, u64 *orig_val);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0dabd3897028..ec3c8e6e8318 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -484,6 +484,36 @@ int copy_data(
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
+	if (vaddr & 7)
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
index 6ac544477f3f..17192e768a2d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -616,17 +616,12 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
 	return res;
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
@@ -634,32 +629,16 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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
+		u64 iova = qp->resp.va + qp->resp.offset;
 
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
+		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
+					  atmeth_comp(pkt),
+					  atmeth_swap_add(pkt),
+					  &res->atomic.orig_val);
+		if (err == -EINVAL)
+			return RESPST_ERR_MISALIGNED_ATOMIC;
+		else if (err)
+			return RESPST_ERR_RKEY_VIOLATION;
 
 		qp->resp.msn++;
 
@@ -671,9 +650,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		qp->resp.status = IB_WC_SUCCESS;
 	}
 
-	ret = RESPST_ACKNOWLEDGE;
-out:
-	return ret;
+	return RESPST_ACKNOWLEDGE;
 }
 
 static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-- 
2.37.2

