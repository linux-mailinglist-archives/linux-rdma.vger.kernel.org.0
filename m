Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33941390BA7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhEYVkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhEYVkJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F75C06175F
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b25so31756010oic.0
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=ulIyfKjHTJEBstBpD8nKwYA+G6Tg870t4KcTNQmpVRmKDuVO63w8JiamFujiS0nCc9
         uulYtYlTo34jdMM2m3uBbM6dVV5JsIJJDsXHcGyiq9kKSQbwKM+xcYredaAqrJQJ+Qt1
         F+TG6D3dgZ2WoZU5nckJfN2uyg9pebK63qcLKs2Qtjv8UYHQ+8VCCKlUwmloKezszVuz
         oq+El8ckMIGiakRwFrwkWr7HePGLZzPWzJ5QqGySn4NzT0o7CbFeGaA41WOwJC5bO+sL
         7tfVcUdh1DvUX6E9REzm/BzT3hUYMqOSPqCUdSxFY+qe78f2bFeWyBgrsaxdy3qrFwBR
         7zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cE7E6256nwQASA75N374ABr0fpgsDymtSFvOShfQN9I=;
        b=HySibKoyWHVpllXfhTcXoTyKiiROTd+rm/4JwVzTStYdt6DIqgrxNQ1KMZV63bewAT
         /DyDzXcewvKdjLXyRB0ld5LrI25tIdRLQnReVamsDsAUq6E/ZX5D4FAvvDwMS8wmBxc8
         olh3kcAS3qYjF7gYcMTCf+8NuCJGFXCCZl0iuiMadpjThYh+taT8CrBRnpgLNsDhRw8X
         ZrO7irHUUgmItymb03t5khiabmpKgyuq4hmh8aEPU1MaXi2g7x8+LJsJDsIPjF9bLp7c
         dxh4xEVQqxzsggC6btu4xDmlOXQNbpHfOEDwQ58XvH/PO8IJHWsCiQfnmr+O6egsa+Le
         fMtQ==
X-Gm-Message-State: AOAM533GoZsacsCFKJJyd3FlxKZW+iXXtIiU7CIVhpeioNjjKVFFMrVQ
        dyCpmXsRpCCbG81p/Jf6ihs=
X-Google-Smtp-Source: ABdhPJxmLrzC8Ste33EsqOoDkZoE3MLNx8D6PDWFQRn3x3rvQ4gbpqEwU08rsq3OPztsl5X6Ow6TjQ==
X-Received: by 2002:aca:75c6:: with SMTP id q189mr274748oic.124.1621978717486;
        Tue, 25 May 2021 14:38:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id e22sm3949961otl.74.2021.05.25.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 10/10] RDMA/rxe: Disallow MR dereg and invalidate when bound
Date:   Tue, 25 May 2021 16:37:52 -0500
Message-Id: <20210525213751.629017-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
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

