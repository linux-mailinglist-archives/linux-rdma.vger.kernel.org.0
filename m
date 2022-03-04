Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C24CCA92
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiCDAJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiCDAJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:38 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B7496B7
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:50 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso7635758ooc.12
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tGaRck6qxPlRe7H4OEd7Bs+y0ag3+BMfJRalDFQg38=;
        b=fOc1poDEwEhgV0EbjYpuwSZuDmAvRE1H63G9vW0b/CGlbRyZtGG88qYalz4G56dA9I
         T1EJOywkHh+ZyhMuzYWr2JH3YLw5EpYwhX8oRhZ0AzZPjN/uYt4hn3hgrLBWU4SJHpEh
         7bss/EIjqyRaqWdldJ10nHO7d5In3RWPJ0JT2JKGinLGiQGzmXkLA/fYvWW+zhUrqhtJ
         XR0S8A2/mi1sMxKcqQ6+FZI6kU3kUaIF1bYZUhlPDZREh7Y1gHAuKpsW9CcknljhAs9O
         2q96+rURid1kHK1yb+IBMSzh5KsLoDlNVZcA39fQbyX6BKk6Uf2ENTyX6BA98jFGCmBy
         AAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tGaRck6qxPlRe7H4OEd7Bs+y0ag3+BMfJRalDFQg38=;
        b=AIbAjLYttk/92AVvdYipUlJ0tNpJBO+DSDrhP6D7C8y6YHQ3SZ4aMQovDjHDfEn2fg
         l5Pe2w2LXZCgCx/WqkhI5o+9PJeX+/dIpXnBQ2WoPFKYUQz3C/wzZYSCY2AdL16JMQBi
         FVezdz5yJP+oZpSCDw5J+2Lp1XYaK36aC+JMinshYT0ElteXRFjUYuYMO/kYa4za+tHv
         UY2jkgGPGiCch5Bd2Ji337gPSk2w1vRacoVKLmW96MxrVg2TaCsqYupxD7HSOBHoowcQ
         e/PyA9GX3fx5SUIftiSIcHB4upHG7nbbZNTWXIdwV+5NlPADpr8R7xYMVF6CpApwrPXc
         lLYg==
X-Gm-Message-State: AOAM533XI4/Xts/Jt1sNACYSsypCNF7kTKXN5q2oMQDhmZlnii5P8CWT
        WWcv6P3Q7fwScOqsgPawzVY=
X-Google-Smtp-Source: ABdhPJwUbuG2AX3Vpzt9cLMgi86M0jQeWDXzrY3pDTFCy0l0Y+SF1RQRt1a21nJSEXeQGnrDaszZsQ==
X-Received: by 2002:a05:6870:220a:b0:ca:d34e:ae77 with SMTP id i10-20020a056870220a00b000cad34eae77mr6121886oaf.164.1646352530005;
        Thu, 03 Mar 2022 16:08:50 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 12/13] RDMA/rxe: Convert read side locking to rcu
Date:   Thu,  3 Mar 2022 18:08:08 -0600
Message-Id: <20220304000808.225811-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4fb6c7dd32ad..ec464b03d120 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -207,16 +207,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
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
@@ -259,7 +258,7 @@ int __rxe_wait(struct rxe_pool_elem *elem)
 		pool->cleanup(elem);
 
 	if (pool->flags & RXE_POOL_ALLOC)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
-- 
2.32.0

