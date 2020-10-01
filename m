Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E982805E2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgJARtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733004AbgJARtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB7C0613E7
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so6336403otb.2
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkz4VuuQcCYH1Nquft/UukRxtklX3/y0RNHvRWeURDw=;
        b=lWwrjsg9/DTGO+J/jBBWCp9DyXf6ukh0Qq/wUBRrDQTIVQL4UDedyGb1sNkvz4raPS
         mKyP+OiXf0718hBOnGbPMpuLw3H3q0lx518sDS+ZmEjM+SdqyPdOvrT4L7JmukjCM/9N
         ac+D29Z75no0eZK028lKm0lC7cfTcm9tzqDZ0nQi9la6dckVvesc0rAqvNndYRPpYREM
         hbJIX8Q2pkFY3OfdrVIkzGk0X/z30L2h+0Y/OG+cRWkNJ5qKKEaov1Lx3OzIGqyzvGii
         GUuXxFliFLg4ErkpUeBSgg4l/C6x6rf/RueKIJxkJFs6K6XxCG8Hdozn6CSkvJEjI0Su
         rjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkz4VuuQcCYH1Nquft/UukRxtklX3/y0RNHvRWeURDw=;
        b=bh5oHav6/Hs5sxCqOuEK9kL+bfDDZk0V3oKaub9Tf9cnkriAhT5gcYdbpRIiNRx8JQ
         jMQ9IrdbKlZbdGoA62yO0YcCwiADG+YLHdfE76NtT7cf60BOYBAbbw6Y6WaPcAFbKgcq
         8MJSXp+7xh+ZTVaZINtXcO5uBQp4MKItc3a67jFIklPh0Ah0UODlCkvruc2+U6jvmllr
         0tYrTDCirvfxc/51iBYPlzwkFaNKRKEgPEwgqmlLwukTo4NIweeUusWV3K874ty99bcN
         khx+CgWXTPQkkdEJUZGZtLmjuQuiY9r8GhYJroKQYpvKpaZlLMsAPsKFU2n34fRwNBz/
         fFlQ==
X-Gm-Message-State: AOAM530a9tmPpnvt/8+HcTYPk0nwoR9yu+DZ6gJZYOgAOMMkrEQqqmoZ
        AJNUIsO+HAOZ+rQ5SuvpdlXeo8X3m90=
X-Google-Smtp-Source: ABdhPJwXAH/VV+ree2utOeLQbG86cH0vPf18PKxfc6oskxs7szNBhWaQCLAkHLlEpNT/Rr+QwoqEJQ==
X-Received: by 2002:a05:6830:1191:: with SMTP id u17mr5622650otq.335.1601574547876;
        Thu, 01 Oct 2020 10:49:07 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id k16sm1179724oij.56.2020.10.01.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 16/19] rdma_rxe: remove duplicate entries in struct rxe_mr
Date:   Thu,  1 Oct 2020 12:48:44 -0500
Message-Id: <20201001174847.4268-17-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
  - Struct rxe_mr had lkey and rkey values both in itself and in
    the struct ib_mr. These are deleted and references replaced
    to the ones in ibmr.
  - Removed the struct rxe_pd pointer from struct rxe_mr.
    This duplicates the pd pointer in struct ib_mr which was also
    present. Added a mr_pd() macro which extracts the pd pointer
    from mr.
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 11 +++--------
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 ++++----
 5 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index e3eb0f4bb2a0..f96f908644b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -51,8 +51,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	if (access & IB_ACCESS_REMOTE)
 		mr->ibmr.rkey = mr->ibmr.lkey;
 
-	mr->lkey		= mr->ibmr.lkey;
-	mr->rkey		= mr->ibmr.rkey;
 	mr->state		= RXE_MEM_STATE_INVALID;
 	mr->type		= RXE_MR_TYPE_NONE;
 	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
@@ -101,7 +99,6 @@ void rxe_mr_init_dma(struct rxe_pd *pd,
 {
 	rxe_mr_init(access, mr);
 
-	mr->pd			= pd;
 	mr->access		= access;
 	mr->state		= RXE_MEM_STATE_VALID;
 	mr->type		= RXE_MR_TYPE_DMA;
@@ -170,7 +167,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
 		}
 	}
 
-	mr->pd			= pd;
 	mr->umem		= umem;
 	mr->access		= access;
 	mr->length		= length;
@@ -200,7 +196,6 @@ int rxe_mr_init_fast(struct rxe_pd *pd,
 	if (err)
 		goto err1;
 
-	mr->pd			= pd;
 	mr->max_buf		= max_pages;
 	mr->state		= RXE_MEM_STATE_FREE;
 	mr->type		= RXE_MR_TYPE_MR;
@@ -320,7 +315,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		memcpy(dest, src, length);
 
 		if (crcp)
-			*crcp = rxe_crc32(to_rdev(mr->pd->ibpd.device),
+			*crcp = rxe_crc32(to_rdev(mr->ibmr.device),
 					*crcp, dest, length);
 
 		return 0;
@@ -354,7 +349,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		memcpy(dest, src, bytes);
 
 		if (crcp)
-			crc = rxe_crc32(to_rdev(mr->pd->ibpd.device),
+			crc = rxe_crc32(to_rdev(mr->ibmr.device),
 					crc, dest, bytes);
 
 		length	-= bytes;
@@ -389,7 +384,7 @@ static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
 	if (IS_ERR(mr) || !mr)
 		return NULL;
 
-	if (unlikely((mr->ibmr.lkey != lkey) || (mr->pd != pd) ||
+	if (unlikely((mr_lkey(mr) != lkey) || (mr_pd(mr) != pd) ||
 		     (access && !(access & mr->access)) ||
 		     (mr->state != RXE_MEM_STATE_VALID))) {
 		rxe_drop_ref(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3e815158df55..128ec5d79501 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -638,8 +638,8 @@ int rxe_requester(void *arg)
 			mr = to_rmr(wqe->wr.wr.reg.mr);
 			mr->state = RXE_MEM_STATE_VALID;
 			mr->access = wqe->wr.wr.reg.access;
-			mr->lkey = wqe->wr.wr.reg.key;
-			mr->rkey = wqe->wr.wr.reg.key;
+			mr->ibmr.lkey = wqe->wr.wr.reg.key;
+			mr->ibmr.rkey = wqe->wr.wr.reg.key;
 			mr->iova = wqe->wr.wr.reg.mr->iova;
 			break;
 		case IB_WR_BIND_MW:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 47d863c4dd48..b8eb4f43c312 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -466,7 +466,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_drop_ref(mw);
 	} else {
 		mr = rxe_get_key(&rxe->mr_pool, &rkey);
-		if (IS_ERR(mr) || !mr || (mr->rkey != rkey)) {
+		if (IS_ERR(mr) || !mr || (mr_rkey(mr) != rkey)) {
 			pr_err_once("no MR found with rkey = 0x%08x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 58a3b66e6283..fc00231627e7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -937,7 +937,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct rxe_mr *mr = to_rmr(ibmr);
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
-	rxe_drop_ref(mr->pd);
+	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_ref(mr);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 54429d8a06fb..847f80d7a1b6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -293,12 +293,8 @@ struct rxe_mr {
 	struct rxe_pool_entry	pelem;
 	struct ib_mr		ibmr;
 
-	struct rxe_pd		*pd;
 	struct ib_umem		*umem;
 
-	u32			lkey;
-	u32			rkey;
-
 	enum rxe_mem_state	state;
 	enum rxe_mr_type	type;
 	u64			va;
@@ -323,6 +319,10 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+#define mr_pd(mr) to_rpd((mr)->ibmr.pd)
+#define mr_lkey(mr) ((mr)->ibmr.lkey)
+#define mr_rkey(mr) ((mr)->ibmr.rkey)
+
 enum rxe_send_flags {
 	/* flag indicaes bind call came through verbs API */
 	RXE_BIND_MW		= (1 << 0),
-- 
2.25.1

