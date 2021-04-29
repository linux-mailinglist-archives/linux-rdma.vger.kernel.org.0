Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE036EFB1
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhD2SuF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbhD2SuF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:50:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CAC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso7278079otn.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcDczA81N59JOUA4+nyxBXcfhrqAYLYY+OocJlGyOXg=;
        b=UeoS7VmX5laEBquYqG9mNjSkLoj++WHh/c040VA/Qn8s9iLUmP2B6ggZHBgCCJL3LU
         gSXQ0eyxk61L9Uw9Qq+AL2T0fFrvG6wMDY5ZCwkiiHAEiiC1iJOFDVgjr7WfcMw0gSdF
         PL5wJQsDIsBLSXfJ+WXDW3BgO+2OakndVVjDSwaGUwKdP4x809qNroQc5OGxq+LXG1On
         Th67xX/5MOG3EZuEbUr/sNokFtQWVraLnYD0dliPvEWIhBNsdsAUU21qM7kM/5VAb3/3
         ei8jKQLvQx0LqUUzP/P3p9+AXtpkcd3TDMXlAZ7cvPJVZrZPRm8+gv0MgA5CwCXQi40U
         QhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcDczA81N59JOUA4+nyxBXcfhrqAYLYY+OocJlGyOXg=;
        b=bc89uadrvRkWlvHPnGwDshZYOD3XXSL51cIVq+xG6lJG8ne/nnhsE0vixgjGsZMIHy
         8t8M+5QDpqfdjMpvOgZd7ogmcDbOvWAx9mNj+UCMRTzVGvX9Elhm6hI8+bMjIA+F/dCi
         +KFzqR/WPTK1O34fApYyiaSVzL8a1QCt9A8GyMhr7xSBXZz04EA6TvJ5XwXBOLn1nlSK
         +OhviMouUCzVM7KJmM9+fbFUIFsK3NP6eN6GPR8dRTJUPRFHSe3PsHqT6m1xif4irrQh
         1bUHIX13bhGVZx60HWeHR86jP5pBfVJztzqHneHkJbIuyJfR1CF0iIKvrvfea52P0aWz
         HytQ==
X-Gm-Message-State: AOAM5311XXmvGL4egiNopTBE9mRe4gtgKbzRclV5M5yEqpc9IvQHEy9V
        WuAkJ/OYQn/t2d4Go44GtT/OtmWnreogSg==
X-Google-Smtp-Source: ABdhPJxur8+AeCPuIADxVxbo/b4iRXel89koNYNpuhAo7snXmQfjK+ZPU244vS8PBJCBjpM5qDC3ww==
X-Received: by 2002:a9d:2787:: with SMTP id c7mr628594otb.105.1619722158211;
        Thu, 29 Apr 2021 11:49:18 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id q130sm172409oif.40.2021.04.29.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Thu, 29 Apr 2021 13:48:55 -0500
Message-Id: <20210429184855.54939-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
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
  Fixed a typo in v4.
v4:
  Added this patch to check mr->num_mw to disallow
  dereg and invalidate operations when MR has MW's
  bound.
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 25 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 -----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4624033d8dce..a167ae3c3514 100644
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

