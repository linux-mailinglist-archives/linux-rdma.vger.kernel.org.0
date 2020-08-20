Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DED24C7F1
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHTWrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B70C061343
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v21so140284otj.9
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNNLhHMuTkosGM+oSqV4BFDJMo8IszBmm6kyU70iy1k=;
        b=BZIaBcQfpult5FtPo9n052rz6pYB8Q4FRCteCMKLqrEccLfCREa2R5vISQvqed9vEe
         Zz5ANnDsFlKMDmRJwNVGgdWqyEo4/ZVJTLlhLfJo2VpoAMh7+l6UjBhIvdyvf43FPJAf
         bBC8EtPPWGZIODvemHL4zABk/wdTNf3m0bhWHzJ6Qxdny2Klq2gOb8rJtP9J3lwpU+ya
         g0cve/6bjdtOsZaGbLvqPzjfX8jojNjDHznLMdci5HTcJYcxmX/YXuZXu8fHGKmjxXvM
         8AGhSE1B1oKXuXVv0iXEITDa9BI0inyAWJRe1p9WpfhpykUPxtw7HaNuftcYdzn+da46
         Op8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNNLhHMuTkosGM+oSqV4BFDJMo8IszBmm6kyU70iy1k=;
        b=MEqVhuHleEEFARgV68k0Ii8Fh60b5AWD8rA0RtXiKgDr8D/DwJ/9ZVD+8xL+rLjye8
         AKkUZSaXyGG2M+0gnYZfFLcxUiJHp+Tn8LADAZUoAw6tDSDJyM9hduszMzdmzicpD3jF
         zY05F/YsO8yNdZ3GDIOQFyNJUz7pQZs1jAgGbPZKLk4mXdPwD+YNjlDAEyBEmNl74U7T
         0XksFjzIribezRY7ehP+4igWatzLKNqphrcfaM9/L1KsUY0bOP9rv7sGizGXItydTmgD
         sOiME0X1gFdoyfWamWv05kuc4FiCE2W237sIhEiWUPbg62yMBwJpV4EzjOyMQ3h5J5XM
         3pcA==
X-Gm-Message-State: AOAM532ilL4TckcTdHxuR3d4cGzbt34KR3CHs+QxYU0U8HbikFD5iv5f
        CToupX4h98EvQnNjna4M7nqS5kBlzDpuxg==
X-Google-Smtp-Source: ABdhPJxy1e4pRI8Y39OK4NIunU0Dx7hQxUuFa9VMV9ijGcSO07QgnH/q0o+nQQmpk5QAbrL+tLRWtg==
X-Received: by 2002:a9d:7389:: with SMTP id j9mr647804otk.263.1597963641046;
        Thu, 20 Aug 2020 15:47:21 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id v3sm684266oig.30.2020.08.20.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 10/17] rdma_rxe: Implemented functional alloc_mw and dealloc_mw APIs
Date:   Thu, 20 Aug 2020 17:46:31 -0500
Message-Id: <20200820224638.3212-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Created basic functional alloc_mw and dealloc_mw funnctions.
This change supports running user space test cases for these APIs.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    | 55 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 +++
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index f5df5e0b714f..ea8510044fbe 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -8,15 +8,62 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* this temporary code to test ibv_alloc_mw, ibv_dealloc_mw */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return ERR_PTR(-EINVAL);
+	struct rxe_pd *pd = to_rpd(ibpd);
+	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_mw *mw;
+	u32 rkey;
+
+	if (unlikely((type != IB_MW_TYPE_1) &&
+		     (type != IB_MW_TYPE_2)))
+		return ERR_PTR(-EINVAL);
+
+	rxe_add_ref(pd);
+
+	mw = rxe_alloc(&rxe->mw_pool);
+	if (unlikely(!mw)) {
+		rxe_drop_ref(pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* pick a random rkey for now */
+	get_random_bytes(&rkey, sizeof(rkey));
+
+	rxe_add_index(mw);
+	rxe_add_key(mw, &rkey);
+
+	spin_lock_init(&mw->lock);
+	mw->qp			= NULL;
+	mw->mr			= NULL;
+	mw->addr		= 0;
+	mw->length		= 0;
+	mw->ibmw.pd		= ibpd;
+	mw->ibmw.type		= type;
+	mw->ibmw.rkey		= rkey;
+	mw->state		= (type == IB_MW_TYPE_2) ?
+					RXE_MEM_STATE_FREE :
+					RXE_MEM_STATE_VALID;
+
+	return &mw->ibmw;
 }
 
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
-	pr_err_once("%s: not implemented\n", __func__);
-	return -EINVAL;
+	struct rxe_mw *mw = to_rmw(ibmw);
+	struct rxe_pd *pd = to_rpd(ibmw->pd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mw->lock, flags);
+	mw->state = RXE_MEM_STATE_INVALID;
+	spin_unlock_irqrestore(&mw->lock, flags);
+
+	rxe_drop_ref(pd);
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+	rxe_drop_ref(mw);
+
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f9f16e7ed0f7..5679714827ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -61,7 +61,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 	},
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 44da74a41ccb..922fab9df6f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -444,6 +444,11 @@ static inline struct rxe_mr *to_rmr(struct ib_mr *mr)
 	return mr ? container_of(mr, struct rxe_mr, ibmr) : NULL;
 }
 
+static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
+{
+	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.25.1

