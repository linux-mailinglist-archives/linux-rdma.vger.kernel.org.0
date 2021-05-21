Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7155F38CED6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhEUUUp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhEUUUo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:44 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E45C06138D
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c196so12602201oib.9
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=qbcUpUi6CHsbe770Wf9mCGAK2u95HAHCnjvsPGvgQYDR9oZjBWIjRZUHnVp/1HZVlR
         49APDRcBvnmKcfKSKW5gPAr6+MOX7HdS1gdc1LVp5CcnyfsSuGYTocoBsjqPf4Uirf9/
         6ncclKMRvhRxHA/SfBWQV2VEIIeiI+oeF5TiMG+Ncqeqix6tJxwEgTzsmB8vKXgasBoZ
         bEgcSQ4HuucgjV7kTLt+meLZi3cupcAmv6tbINNoPRXsWnymW/qzN2GIv3Esmg4ZBSvv
         +jd79zytQv/46whrTie8F8qx8PPqABYmuVFvTCc1/9NojCKJkuey2fQuFtrnsTjUTO9t
         MVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=NlNW//9+FrF1X+89X/+nXXqggwv0SeCi4eMIOZC2lY/GdAL57BgMGSBoGuTX+qSKSy
         VgCyxFte3dWq6rCqEN2l4qAAWsBx/WyId8LWS7ULg0HJqgTnvfmuB3Mu25hCoMvt3PiN
         zOO6mmt2kKfDhvappHNmA7+bq7HNuMJuiDRjTMmAOd0Brj2Vg3x7gmefFBqqfUcGIsDZ
         YnWmemEzOnGP6OFJzJ9wFgA8qh1PWYobZJvwqtFo094x4nb6Ie9+Q7hZhU8EJGuKT1f0
         ZZ6CXJX65mpI/vYNBHqKfwkrYUc4QY3YGXDblsKEWXdVAwPviwtZU2TIxZuwoqSp1yji
         7iVg==
X-Gm-Message-State: AOAM530FOZ2XdcVISq023CK3vQp8Gh5D+9wGVVGL1dXPxi+E+MKr2uGb
        5jvLJQ7Kq2Cv3jsGMZ8H7Wc=
X-Google-Smtp-Source: ABdhPJwJOZNfvTWU5q93l7CrHfYDm/LVKLXocpQaZfuM4fyw53IDw+Bp6PhxedQazaxwyocMMfUXFg==
X-Received: by 2002:aca:c085:: with SMTP id q127mr3283457oif.7.1621628360797;
        Fri, 21 May 2021 13:19:20 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id e21sm1348412oie.32.2021.05.21.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Fri, 21 May 2021 15:18:25 -0500
Message-Id: <20210521201824.659565-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Check that an MR has no bound MWs before allowing a dereg or invalidate
operation.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 25 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 -----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 6e4b5e22541e..1ddb20855dee 100644
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
index 3fb58d2c7814..7f169329a8bf 100644
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
index 4860e8ab378e..3e0bab4994d1 100644
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
2.30.2

