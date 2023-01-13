Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0C66A70D
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAMX1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAMX1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:27:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85F8CBE3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:36 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so13052864oto.5
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doH5pfEhKyXp0YMTNNNIQAEkD7VY0qN/u2wnPS9b96M=;
        b=PI5AsCC2VXqqKpRm1Vb4cBQ1P5qrMVYS+GJQNk6BiF7eNSwYZPSSQFaOxoj8WmkSy/
         XE/4xvQ9GFSTitHWYVWxCDlMF6RlRqkgknpB0ptu2hNcdlGTQEkA6ZkF0HQ87Cq0Hmf3
         zyV41Uq6EEtiXmtU3tB5nMwff7GijpLZwqchLC6mvZ5L4AgWJ7X3BHwq0f9zsYfK+G3R
         k9QuOFrgsguf2Q4n6jIPZrMn1505x9lCmB1st6ghYxiIDflhyWOddt61sS5tARAnL2/s
         mer+znYvcluqxVOmXyXTCy2h+9OxANiQgwK0rtfOwf9dYnRlfap9dQlnkrWJiV3DZZIc
         mIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doH5pfEhKyXp0YMTNNNIQAEkD7VY0qN/u2wnPS9b96M=;
        b=N74QmS5C6eFdtGfkAAH9OZ95/Df2qwYaWeMkDUSChFVcHRLA7dxlSz2dKxyyTdLGXc
         0kgAAhFYNiakTbHKJ2jRp0tYoqBjcwimIylrAK/338V/TXvHmZg6xe4w1LdUZGN97RcZ
         X3YoY7mK3+ylKJp6Yg1MQkwW701kMG6AzHqCovZ4hS2c12JprSgx7EiehqrU7RLv2N9p
         MAjYKWHnkJuzxMFMANgA14RJkFevgIMp8KSBV1NwjPniNZ7dPLppRsYBei/Znu4JBXxp
         admQ5KOZZL6zYrA+AKecC3ukBcAfuHjIEXmTkdoTGNB7M7g+A9XzUUFKDyb2/sXLl6/3
         BQwA==
X-Gm-Message-State: AFqh2kr8iDuOuIB7ixDZSzwIly0nXjUNmCV8Fz+BNEtgY+YSwqpwezEM
        uGmoBXY8PcCZXeFpqaU2uTQ=
X-Google-Smtp-Source: AMrXdXtAPHsTsGBg1nKjxy6SLc/cOtXLjjT6nnKHqge9xltOzrnAAa0fckdECQa8725PtIDRVvMV8Q==
X-Received: by 2002:a05:6830:698e:b0:684:c941:9e1f with SMTP id cy14-20020a056830698e00b00684c9419e1fmr3487629otb.15.1673652455861;
        Fri, 13 Jan 2023 15:27:35 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:35 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 3/6] RDMA-rxe: Isolate mr code from atomic_reply()
Date:   Fri, 13 Jan 2023 17:27:02 -0600
Message-Id: <20230113232704.20072-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113232704.20072-1-rpearsonhpe@gmail.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
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

