Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88C368495
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDVQO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhDVQO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6C7C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso9685243otp.7
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgxF8pYrzUty8z/71s+N+84ZSN+0Ih8OKBvEoPf+qLE=;
        b=TWlOqU/08XS+vP3kYRIen6pNmngyfvoNBhkLmeoKBUutwpXqVu10DEJ3oZVropFz6D
         pE19tqaJwFSWj727Abh6zrrpXs5KbZYChYYO2TpNpGOfXHrMGxUAWj7rNN5u7fcf5Tzs
         itso3jm2ExMhag3a2WGo7fQneYuVzdN1avr2NPm1xbm+elOIgjby+7KvEsvq5ib30ryE
         CT1r8/dD7ywpAag13JEe1+fdFghOm8CBHzNjIWGiXE0pV1WqPn+L7t3n2L1Yztaa95wK
         E69ukI1V5qfmgfKTeo+u9z3g1TSKzVLdfiuitOixSc8QBnkx1kKf0ZjS59n3YQEwAuUT
         /6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgxF8pYrzUty8z/71s+N+84ZSN+0Ih8OKBvEoPf+qLE=;
        b=p0moaYNmgoh/1pPq12A3XoPO+le3JpLLDST8QIF392dNxCyenIe1E+Gth21pxHimA3
         blVOtujFHy8TD66WbLzOaVTKNLQKStsKCdZ4YG/BfxY8a84EpSqriyQCyiyLT97bHfrd
         x6w1eegBXXYEm+K4rXr2fxQlU5HpZBVEUB4qKhkbUf3MOGHtSTkFO15oXrC2M9xjp8C+
         jyPwm6Bb5upj1hZrARA29lxkmSI+ax0RSchTV6Ey+LcVEHXpg9xrfrbvF0cGVqO41xRe
         lZigFtPlv8++hTUKbATm52E9vbK+xwIA9KEf2QnjaItvbkoteX9LytF9HTpZ4hYjfpVN
         0cVQ==
X-Gm-Message-State: AOAM532ZpECXcFJznFV/sXA7Vy9TIkq80h8nydg5qCHD4wslcc+wneZM
        +3c1CSEx4o5PkAla90iTWzU=
X-Google-Smtp-Source: ABdhPJzWpEeNrL+8kGCFLaMlioTYqfBnnf3H1t0pAvtv1pcJaXOqh52iFYVWS48EGdJVZ/0tSZlLdA==
X-Received: by 2002:a05:6830:1046:: with SMTP id b6mr3385714otp.317.1619108033982;
        Thu, 22 Apr 2021 09:13:53 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id b21sm630317oov.6.2021.04.22.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH for-next v5 10/10] Subject: [PATCH for-next v4 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Thu, 22 Apr 2021 11:13:41 -0500
Message-Id: <20210422161341.41929-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422161341.41929-1-rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Check that an MR has no bound MWs before allowing a dereg or invalidate
operation.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v5:
  Fix typo in v4 fix.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

v4:
  Added this patch to check mr->num_mw to disallow
  dereg and invalidate operations when MR has MW's
  bound.

Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 25 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 -----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 076e1460577f..93dbd81222e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -87,6 +87,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f871879e5f80..6a2377030f52 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -546,6 +546,13 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 		goto err_drop_ref;
 	}
 
+	if (atomic_read(&mr->num_mw) > 0) {
+		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+			__func__);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
 	mr->state = RXE_MR_STATE_FREE;
 	ret = 0;
 
@@ -555,6 +562,24 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
+int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+
+	if (atomic_read(&mr->num_mw) > 0) {
+		pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	mr->state = RXE_MR_STATE_ZOMBIE;
+	rxe_drop_ref(mr_pd(mr));
+	rxe_drop_index(mr);
+	rxe_drop_ref(mr);
+
+	return 0;
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d22f011a20f3..89f8f00215d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -913,17 +913,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return ERR_PTR(err);
 }
 
-static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-
-	mr->state = RXE_MR_STATE_ZOMBIE;
-	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
-	return 0;
-}
-
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
-- 
2.27.0

