Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3439EDAF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFHE23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHE2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A3CC0617A6
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t140so15092047oih.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=AkzjcBJz9pG+lr8OJSuurLWfoXkyd1etMgRIb8/Iu+5wTOqTwJy+kgpg7uoVOy6CEM
         /dN9mxnnDO4Lnn5D7uiBOSM0OShame0LX53sNqQm0qQrYZOHjMiRxn2aRU3Doa//RG8D
         fwsH3eV63vXYDrCrJ+8GcZRTzPEFeLN4vODBesH4mUJfIdgU4N/Th2FvDDy33ogXANrm
         ZzRatMboVsCoM5TnWVTAds598VugFJvs411ZCH1Fki2oU0jx0h7Ww3TIjvTP8ZyxQ6CA
         VlstFU/Dp/qWmOaTiA1aR5rkEuDzrnk8zOzYLZJqnLczAOQTAc112mpVgyZ5ZM9oqZv3
         YW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=XPKi1C0uA2ghr0ONV+wKYrdy7754U9KRO18vm6Dq0iQaQFWpqZutMq2pNeOA/KKzME
         qgowjzREjLMTYhdCv97BdguFtt1Yx3KG+B4PCqTFOH1g2whGeKAiOxEWectDHsvrDZpB
         t/cUYn6MDYfYFvWcyWYjbaS8p1epYw4IT61okZcJbi+csCV6EaRcqxGwKcAzJhnUqqQT
         B9siYB1tmOcAEOOGsB0yYu0eT5OSMbnqwyIm5jlXfC94RAYZJQUxX/PnLxFGdAPoy9yC
         YuVa1xaEPley+EwJKZhkjAoBzh3rg8JXw3TwyPQpXpaErUxMKxvJaaLAKO9aklz4qY8s
         EYaQ==
X-Gm-Message-State: AOAM531PoBxCcimuxdvcFJNMScHBuC5Gtheooi+PGUXY26IuhcrHnbFR
        vgvhSfoZIz4v0bHmgZDihNQ=
X-Google-Smtp-Source: ABdhPJz9m+q0XF95C2feoWxHBoc9C52oa1Ovh2iV+ccIoBgb2qSEkklHu1AHekYTmvq2Z78vzTWs8A==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr1641579oik.104.1623126379880;
        Mon, 07 Jun 2021 21:26:19 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id 7sm1254573oip.56.2021.06.07.21.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Mon,  7 Jun 2021 23:25:53 -0500
Message-Id: <20210608042552.33275-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
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

