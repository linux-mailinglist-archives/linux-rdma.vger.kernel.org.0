Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D85214BDF
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgGEKnd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKnd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:43:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE4C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:43:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so37640535wrs.11
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAGRW9RG5J5eOxJ/N27IiokN4JQ6OOliqfQ8Tu8usyg=;
        b=R1tmn8dOwQ6tFpBOkczeoP7+R2d9Y9I0FLaWlWM0RlQtoJrvXYXZyxuUXXg4ytghhl
         J7BzJ9dbcKFfjaimZ9kvEC3e/IeN0A7/sKvxjj4GSE5McNQtUQNKH5CSDV2DyRiAjYgs
         XPkN5JZDn6xERvrJW2ZMIebG/0eXBvj7nfqyKRiMcDaWBMFSBmr/t7pZQXj4x7deM0CY
         uSuLZxk7Ur1d2aHnrA9iDyUszfO9tvDDw4SJUyilrFpZpQnHmzfEIIbIfkgCGAVPMtkR
         BgzifiwvWLpmSOSnFGVq7kcPXyu/khqJv9AsBWf8EQCLNQ9j0t48B8obtqtva0jAFlL3
         piPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAGRW9RG5J5eOxJ/N27IiokN4JQ6OOliqfQ8Tu8usyg=;
        b=sn7Az+lDi+PJ+HteaZxQS4I3Sihn8jVBNBxcHtinlIUIGZ864pD0Pw8pgJth8bf01Q
         kl1MLrGwOAeG67Y2n+BC7VgFIvNzvDtpRdYrlV7Tis3GJUIIp++7SxznUnHEkfcM9eZd
         yEALaVVUL8Jwd+OMnuS85tVs1ndbqFLQYbKzgX4r0Ju8L1vD87XIzdqVIO9OWGUkIBBH
         OxyFN4NaiGr7yYWd1fStUmF/SKzOxLLmYeqkVXEo9m/58wclEUxIdd69VBIsTIL+9zP6
         5QkmxWIZv5LlxEihZvGocrafnt8y4/lJ/WVUqQFSot11dYNqFRR7uDJhbFAFxOAARyaq
         3lug==
X-Gm-Message-State: AOAM533QrCBY8WYMsiEjQ53VV7+wg6r3cNRbvpkgHychG95GQ9/Urtr6
        QOhSrsyZHb7lTiv68nbXb503KRdowp0=
X-Google-Smtp-Source: ABdhPJxTDZeXy8B39nPwYXo5lR6mLMWzyPC8D4vYFXT1T3aBjQo10Rw45DQ9t6CTZegZtg0lix3gHA==
X-Received: by 2002:adf:b312:: with SMTP id j18mr41452490wrd.195.1593945811491;
        Sun, 05 Jul 2020 03:43:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 51sm14828083wrc.44.2020.07.05.03.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:43:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 3/4] RDMA/rxe: Return void from rxe_mem_init_dma()
Date:   Sun,  5 Jul 2020 13:43:12 +0300
Message-Id: <20200705104313.283034-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from rxe_mem_init_dma() is always 0 - change it to be
void and fix the callers accordingly.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 20 +++-----------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 238d6a357aac..0688928cf2b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -103,8 +103,8 @@ enum copy_direction {
 	from_mem_obj,
 };
 
-int rxe_mem_init_dma(struct rxe_pd *pd,
-		     int access, struct rxe_mem *mem);
+void rxe_mem_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mem *mem);
 
 int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		      u64 length, u64 iova, int access, struct ib_udata *udata,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a63cb5fac01f..cdd811a45120 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -144,8 +144,8 @@ static int rxe_mem_alloc(struct rxe_mem *mem, int num_buf)
 	return -ENOMEM;
 }
 
-int rxe_mem_init_dma(struct rxe_pd *pd,
-		     int access, struct rxe_mem *mem)
+void rxe_mem_init_dma(struct rxe_pd *pd,
+		      int access, struct rxe_mem *mem)
 {
 	rxe_mem_init(access, mem);
 
@@ -153,8 +153,6 @@ int rxe_mem_init_dma(struct rxe_pd *pd,
 	mem->access		= access;
 	mem->state		= RXE_MEM_STATE_VALID;
 	mem->type		= RXE_MEM_TYPE_DMA;
-
-	return 0;
 }
 
 int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b8a22af724e8..ee80b8862db8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -901,30 +901,16 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mem *mr;
-	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
-
-	err = rxe_mem_init_dma(pd, access, mr);
-	if (err)
-		goto err2;
+	rxe_mem_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
-
-err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
-err1:
-	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
-- 
2.25.4

