Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2860E287DF3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJHV2W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgJHV2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 17:28:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DDC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 14:28:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id q136so6747851oic.8
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jT9pQBFsUKhZ3y60CD1xIThlw/z/jAxmyuepCIHVGLM=;
        b=GWTL5TA5wwoQyFuTSf4swZRAIUyqkbEbhnFW7aVHcfkBOb935i0x52nOxVuN+0PP0C
         5lrPVleneEylkaFhhORTd2cP7j3HvaEJET6rXYuTZgLTHP2zQ86iRJAIB7jsc+OLUuHL
         /5MLNSIHUF05WHzvlClRNxXxBOwkFpMuEbsb1GVyWGuFxJYzsyDioZnz9+GHk+RAl4wA
         8WlT+laM6hZ3B/ML7IRv/EJFkFTVdXl0EfPkpr1nBwD4Zjb9UFPf1RXQ188BtQeCJ19u
         eVEjvyQZHasanOyEtTAjNqkZORJUqLMeukupTsETf9h1VLzRC98wR5JyOAZfy4iFvSyc
         aTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jT9pQBFsUKhZ3y60CD1xIThlw/z/jAxmyuepCIHVGLM=;
        b=Y70jsYk0HYN9COLdn1FQxYhUglUhKnk87gcQR/CpLdf22ZU3p4VzgGO0aTdaomVvRv
         1s/CjjClFQZyUFWaUo+gsesY2Id+ehSRAZCDs8QDdfJkoGeGliW1hkOhhH6StzxqXo5S
         yA4SWqoUET/Rz6yNlFLFZiFoAXSh352FgbdqSEHk76dhkBv4t/ixE7GJ7edgX1QUJio0
         EihAdvFvzMnVBTf1ZE1Y9AUZxh036SL/MD7ZiZq5Je8AigIhIJfwufXz/zBqhMR87H2L
         BRpp0YVHQcg4/YBftxsyKqvwHltQwBUDDKfKy4JHYzMtrZbHM0eAPpAbDoooB5xmep7j
         0KHw==
X-Gm-Message-State: AOAM531Bk+U0pcVQrh0TzC9ESvo4bZUywEKykv+DOgFWaayb8vdzGhn6
        d5OGLfQqsL1Ip0kkddoLzMj83Lb8xZQ=
X-Google-Smtp-Source: ABdhPJyD82CZXDuFTUlwTN2KIe7mh4OBlHP/jh18rLjluY0d2GFpVPYmMvompnm8a3T2ht2jj22sVw==
X-Received: by 2002:aca:b144:: with SMTP id a65mr497114oif.53.1602192500846;
        Thu, 08 Oct 2020 14:28:20 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b5fa:2b2f:81e9:e2a0])
        by smtp.gmail.com with ESMTPSA id j10sm1487723ota.56.2020.10.08.14.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:28:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 4/4] rdma_rxe: remove duplicate entries in struct rxe_mr
Date:   Thu,  8 Oct 2020 16:28:18 -0500
Message-Id: <20201008212818.265303-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  - Struct rxe_mem had pd, lkey and rkey values both in itself
    and in the struct ib_mr which is also included in rxe_mem.
  - Delete these entries and replace references with ones in ibmr.
  - Add mr_lkey and mr_rkey macros which extract these values from mr.
  - Added mr_pd macro which extracts pd from mr.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 25 ++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 ++++----
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 390d8e6629ad..6e8c41567ba0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -51,13 +51,8 @@ static void rxe_mem_init(int access, struct rxe_mem *mem)
 	u32 lkey = mem->pelem.index << 8 | rxe_get_key();
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
-	if (mem->pelem.pool->type == RXE_TYPE_MR) {
-		mem->ibmr.lkey		= lkey;
-		mem->ibmr.rkey		= rkey;
-	}
-
-	mem->lkey		= lkey;
-	mem->rkey		= rkey;
+	mem->ibmr.lkey		= lkey;
+	mem->ibmr.rkey		= rkey;
 	mem->state		= RXE_MEM_STATE_INVALID;
 	mem->type		= RXE_MEM_TYPE_NONE;
 	mem->map_shift		= ilog2(RXE_BUF_PER_MAP);
@@ -121,7 +116,7 @@ void rxe_mem_init_dma(struct rxe_pd *pd,
 {
 	rxe_mem_init(access, mem);
 
-	mem->pd			= pd;
+	mem->ibmr.pd		= &pd->ibpd;
 	mem->access		= access;
 	mem->state		= RXE_MEM_STATE_VALID;
 	mem->type		= RXE_MEM_TYPE_DMA;
@@ -190,7 +185,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 		}
 	}
 
-	mem->pd			= pd;
+	mem->ibmr.pd		= &pd->ibpd;
 	mem->umem		= umem;
 	mem->access		= access;
 	mem->length		= length;
@@ -220,7 +215,7 @@ int rxe_mem_init_fast(struct rxe_pd *pd,
 	if (err)
 		goto err1;
 
-	mem->pd			= pd;
+	mem->ibmr.pd		= &pd->ibpd;
 	mem->max_buf		= max_pages;
 	mem->state		= RXE_MEM_STATE_FREE;
 	mem->type		= RXE_MEM_TYPE_MR;
@@ -340,7 +335,7 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
 		memcpy(dest, src, length);
 
 		if (crcp)
-			*crcp = rxe_crc32(to_rdev(mem->pd->ibpd.device),
+			*crcp = rxe_crc32(to_rdev(mem->ibmr.device),
 					*crcp, dest, length);
 
 		return 0;
@@ -374,7 +369,7 @@ int rxe_mem_copy(struct rxe_mem *mem, u64 iova, void *addr, int length,
 		memcpy(dest, src, bytes);
 
 		if (crcp)
-			crc = rxe_crc32(to_rdev(mem->pd->ibpd.device),
+			crc = rxe_crc32(to_rdev(mem->ibmr.device),
 					crc, dest, bytes);
 
 		length	-= bytes;
@@ -547,9 +542,9 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
 	if (!mem)
 		return NULL;
 
-	if (unlikely((type == lookup_local && mem->lkey != key) ||
-		     (type == lookup_remote && mem->rkey != key) ||
-		     mem->pd != pd ||
+	if (unlikely((type == lookup_local && mr_lkey(mem) != key) ||
+		     (type == lookup_remote && mr_rkey(mem) != key) ||
+		     mr_pd(mem) != pd ||
 		     (access && !(access & mem->access)) ||
 		     mem->state != RXE_MEM_STATE_VALID)) {
 		rxe_drop_ref(mem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e27585ce9eb7..af3923bf0a36 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -617,8 +617,8 @@ int rxe_requester(void *arg)
 
 			rmr->state = RXE_MEM_STATE_VALID;
 			rmr->access = wqe->wr.wr.reg.access;
-			rmr->lkey = wqe->wr.wr.reg.key;
-			rmr->rkey = wqe->wr.wr.reg.key;
+			rmr->ibmr.lkey = wqe->wr.wr.reg.key;
+			rmr->ibmr.rkey = wqe->wr.wr.reg.key;
 			rmr->iova = wqe->wr.wr.reg.mr->iova;
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f368dc16281a..ba8faa34969b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -921,7 +921,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct rxe_mem *mr = to_rmr(ibmr);
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
-	rxe_drop_ref(mr->pd);
+	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 658b9b1ebc62..efe5d9f34fc1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -294,12 +294,8 @@ struct rxe_mem {
 		struct ib_mw		ibmw;
 	};
 
-	struct rxe_pd		*pd;
 	struct ib_umem		*umem;
 
-	u32			lkey;
-	u32			rkey;
-
 	enum rxe_mem_state	state;
 	enum rxe_mem_type	type;
 	u64			va;
@@ -333,6 +329,10 @@ struct rxe_mc_grp {
 	u16			pkey;
 };
 
+#define mr_pd(mr) to_rpd((mr)->ibmr.pd)
+#define mr_lkey(mr) ((mr)->ibmr.lkey)
+#define mr_rkey(mr) ((mr)->ibmr.rkey)
+
 struct rxe_mc_elem {
 	struct rxe_pool_entry	pelem;
 	struct list_head	qp_list;
-- 
2.25.1

