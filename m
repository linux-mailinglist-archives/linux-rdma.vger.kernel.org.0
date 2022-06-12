Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0463A547CD4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 00:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiFLWfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jun 2022 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiFLWfS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jun 2022 18:35:18 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029C2252E
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:17 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1011df6971aso3869780fac.1
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgS1BRhsKF+JItx7znCicMAXBi246AuO09yAKjTZPiI=;
        b=j+FpEizm37MgrLLFWHlhiCOKrvzD84wDHakZhzSXUND43KY44GoLRJarnAr7ZSvxkR
         N/p0b12mQGRQJihv/SVGo4BHYB4R3EPUr1o9H8KXThrDOeixp8rpV+FmBizwElpVK7yQ
         mHaeL+4buu0exxWYykMHHSgVcOnFjooTqSOGJk/XWvwRDCbPVCvFpPHVg6vD7V6NudIg
         rtNtzRJfbElwx36Mw71VbLp7dpcjh+zZfAfzlWWhDFRdCT79hbhMLqRxO6ggd/Vsb8Um
         dIa9kG/BlsQqaY9mXgffkJ7yw0PSz1hbsLP0LDOQgdt2gxNz71OFl7biBhJMrdiUB2Vf
         qPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgS1BRhsKF+JItx7znCicMAXBi246AuO09yAKjTZPiI=;
        b=HKx1F+7lh/pqv9rimA1SsBa676JxvA+ako2QVaEs8YkotpKHlKp6l14iFOLo8Fz9Cz
         m0Zbni5g6e1WEzvVwV5DGjnctX3r1gVRZ+HFoIaMnzkfPX1CLfJDx4m2r9oPYBWd272Z
         D/6/jBtqSYW9FbbHq+5JgGq0W9PgEWT11iRtPb1P4LYo2u3mNIiBCZPVZqUBzMmw5h5r
         MG0zBa2MjpdoKjA1tpWEGUROM6WlSaSo6XSsioq4tMj00ZvNrrhT3TV2cbSKdrcGQKR1
         l1J4Kv5aN4hkUwiSMzYe6f1LzlPZHMF506zZXG6zHgjXxK8n4PnCRzjVu7poUz67LhQd
         HzfQ==
X-Gm-Message-State: AOAM533xcCOvmzlEauL+NgdfmuY0bsFhwVjc1KV8xz+E79oybRbhBgQU
        1wxKzwcqSYOdMKLT2BYc5vs=
X-Google-Smtp-Source: ABdhPJz9rteROqC74JQYM4WaR4JXhBuGNeqkPVod2L2uXHHQM1etBvU7FqPL+ZostxQw9+Exy/qEgA==
X-Received: by 2002:a05:6870:912a:b0:fe:1981:b15a with SMTP id o42-20020a056870912a00b000fe1981b15amr6242914oae.77.1655073316779;
        Sun, 12 Jun 2022 15:35:16 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id y185-20020aca32c2000000b00326414c1bb7sm2562421oiy.35.2022.06.12.15.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:35:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, frank.zago@hpe.com,
        ian.ziemba@hpe.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu
Date:   Sun, 12 Jun 2022 17:34:35 -0500
Message-Id: <20220612223434.31462-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220612223434.31462-1-rpearsonhpe@gmail.com>
References: <20220612223434.31462-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use rcu_read_lock() for protecting read side operations in rxe_pool.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 8d8f5e409585..f50620f5a0a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -197,16 +197,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
-	unsigned long flags;
 	void *obj;
 
-	xa_lock_irqsave(xa, flags);
+	rcu_read_lock();
 	elem = xa_load(xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	xa_unlock_irqrestore(xa, flags);
+	rcu_read_unlock();
 
 	return obj;
 }
@@ -223,16 +222,16 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
 	static int timeout = RXE_POOL_TIMEOUT;
-	unsigned long flags;
 	int ret, err = 0;
 	void *xa_ret;
 
+	if (sleepable)
+		might_sleep();
+
 	/* erase xarray entry to prevent looking up
 	 * the pool elem from its index
 	 */
-	xa_lock_irqsave(xa, flags);
-	xa_ret = __xa_erase(xa, elem->index);
-	xa_unlock_irqrestore(xa, flags);
+	xa_ret = xa_erase(xa, elem->index);
 	WARN_ON(xa_err(xa_ret));
 
 	/* if this is the last call to rxe_put complete the
@@ -277,7 +276,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 		pool->cleanup(elem);
 
 	if (pool->type == RXE_TYPE_MR)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
@@ -296,12 +295,8 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
-	struct xarray *xa = &elem->pool->xa;
-	unsigned long flags;
-	void *ret;
-
-	xa_lock_irqsave(xa, flags);
-	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
-	xa_unlock_irqrestore(xa, flags);
-	WARN_ON(xa_err(ret));
+	void *xa_ret;
+
+	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	WARN_ON(xa_err(xa_ret));
 }
-- 
2.34.1

