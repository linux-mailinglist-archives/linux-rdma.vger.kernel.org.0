Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF3615328
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKAUX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiKAUXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:55 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73751EC42
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t62so6330733oib.12
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxVPpFHYKbZEACwtxYU811ZotzxpSaoA/gJpi0jRUas=;
        b=Etf+hH26/14xHjdX6PsCBB4ihQSXLfDD/oJ0a4ex+UXDvTNX7LQ9+7LfiR0FN9rE1a
         mhD8iswPN8O6ngESn79pZNNtheiuAOHwN954+CWTNP8B5PBqs/9PypdNCEzSrSbzsyc2
         2yac5fQJ9bgUiC684ESZqgHhvMFjqU0plAMVT7wGVgm0XOMUCoI+9dZ/jmB/FH/Y6KhI
         oYuD53Gv1Akv/1qoerMAv+JGohqRYCCD9kxu39WNrkzfO4E3jALFL+scoDEtKH2pi2nF
         kNvZaGCoGsvn5aKltLEzNKr8YxkJCQrepXq7zMKmp+OEbiMY81WJTso826OpEtOPOte4
         uTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxVPpFHYKbZEACwtxYU811ZotzxpSaoA/gJpi0jRUas=;
        b=r63V+vuT+M+MKggOLAAYSTU51I7DENZnUlA0ctpNYBVqzVixrFWJOluF7S7Z+fDXo7
         /yBKC8+wdUQdDQVQUM5FXWy8WuufPSQWGRIzd18mB8AMLiEWjvlUVFbM5VGnnZPwhZUH
         wRqnXml57K8hXWbhh5Rgw8X8rzy2/1kkfrYH3aGhMtNMci8BAJQpUwvLOn1btShvmu1V
         x69JkT3QdK4CD9vEwIdRsfugGSZJz3p+rgpLjNCjN7pe74Lj6hKJ6xMXclEXKucwzgG9
         fzP7ATCgbLca3IkpKeIWAz2rGUPsEi/jkRIhcGJgj+rKcXPCGP5ew9KHnk37wgTIWICi
         zAHg==
X-Gm-Message-State: ACrzQf1s9nCGUxzTbclW8bo5B4ZZXtNh8dnSgZvZbzGQoA4AJyk0t29g
        aVy7RhfBxrGiQGiqj5cTWhc=
X-Google-Smtp-Source: AMsMyM54+L/jFsW53zlrExNikGv5P+F3hAPpxo6C6DgUaV+24oV5jLAzcxEzHXTcF29ayk+ZlVlVdA==
X-Received: by 2002:a05:6808:3007:b0:351:3de7:82f4 with SMTP id ay7-20020a056808300700b003513de782f4mr18355199oib.103.1667334231164;
        Tue, 01 Nov 2022 13:23:51 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_mr in rxe_mr.c
Date:   Tue,  1 Nov 2022 15:22:29 -0500
Message-Id: <20221101202238.32836-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_err/warn() in rxe_mr.c by rxe_dbg_mr().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 40 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 ++
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bc081002bddc..cd846cf82a84 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -38,8 +38,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 		return 0;
 
 	default:
-		pr_warn("%s: mr type (%d) not supported\n",
-			__func__, mr->ibmr.type);
+		rxe_dbg_mr(mr, "type (%d) not supported\n", mr->ibmr.type);
 		return -EFAULT;
 	}
 }
@@ -125,8 +124,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
-		pr_warn("%s: Unable to pin memory region err = %d\n",
-			__func__, (int)PTR_ERR(umem));
+		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
+			(int)PTR_ERR(umem));
 		err = PTR_ERR(umem);
 		goto err_out;
 	}
@@ -137,8 +136,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	err = rxe_mr_alloc(mr, num_buf);
 	if (err) {
-		pr_warn("%s: Unable to allocate memory for map\n",
-				__func__);
+		rxe_dbg_mr(mr, "Unable to allocate memory for map\n");
 		goto err_release_umem;
 	}
 
@@ -159,8 +157,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
-						__func__);
+				rxe_dbg_mr(mr, "Unable to get virtual address\n");
 				err = -ENOMEM;
 				goto err_cleanup_map;
 			}
@@ -255,7 +252,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	void *addr;
 
 	if (mr->state != RXE_MR_STATE_VALID) {
-		pr_warn("mr not in valid state\n");
+		rxe_dbg_mr(mr, "Not in valid state\n");
 		addr = NULL;
 		goto out;
 	}
@@ -266,7 +263,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	}
 
 	if (mr_check_range(mr, iova, length)) {
-		pr_warn("range violation\n");
+		rxe_dbg_mr(mr, "Range violation\n");
 		addr = NULL;
 		goto out;
 	}
@@ -274,7 +271,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	lookup_iova(mr, iova, &m, &n, &offset);
 
 	if (offset + length > mr->map[m]->buf[n].size) {
-		pr_warn("crosses page boundary\n");
+		rxe_dbg_mr(mr, "Crosses page boundary\n");
 		addr = NULL;
 		goto out;
 	}
@@ -527,27 +524,26 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		pr_err("%s: No MR for key %#x\n", __func__, key);
+		rxe_dbg_mr(mr, "No MR for key %#x\n", key);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
-		pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
-			__func__, key, (mr->rkey ? mr->rkey : mr->lkey));
+		rxe_dbg_mr(mr, "wr key (%#x) doesn't match mr key (%#x)\n",
+			key, (mr->rkey ? mr->rkey : mr->lkey));
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
 	if (atomic_read(&mr->num_mw) > 0) {
-		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
-			__func__);
+		rxe_dbg_mr(mr, "Attempt to invalidate an MR while bound to MWs\n");
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
 
 	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);
+		rxe_dbg_mr(mr, "Type (%d) is wrong\n", mr->ibmr.type);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
@@ -576,22 +572,20 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	/* user can only register MR in free state */
 	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
-		pr_warn("%s: mr->lkey = 0x%x not free\n",
-			__func__, mr->lkey);
+		rxe_dbg_mr(mr, "mr->lkey = 0x%x not free\n", mr->lkey);
 		return -EINVAL;
 	}
 
 	/* user can only register mr with qp in same protection domain */
 	if (unlikely(qp->ibqp.pd != mr->ibmr.pd)) {
-		pr_warn("%s: qp->pd and mr->pd don't match\n",
-			__func__);
+		rxe_dbg_mr(mr, "qp->pd and mr->pd don't match\n");
 		return -EINVAL;
 	}
 
 	/* user is only allowed to change key portion of l/rkey */
 	if (unlikely((mr->lkey & ~0xff) != (key & ~0xff))) {
-		pr_warn("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
-			__func__, key, mr->lkey);
+		rxe_dbg_mr(mr, "key = 0x%x has wrong index mr->lkey = 0x%x\n",
+			key, mr->lkey);
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bcdfdadaebbc..510ae471ac7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -875,6 +875,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
+	mr->ibmr.device = ibpd->device;
 
 	rxe_mr_init_dma(access, mr);
 	rxe_finalize(mr);
@@ -899,6 +900,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
+	mr->ibmr.device = ibpd->device;
 
 	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err)
@@ -930,6 +932,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
+	mr->ibmr.device = ibpd->device;
 
 	err = rxe_mr_init_fast(max_num_sg, mr);
 	if (err)
-- 
2.34.1

