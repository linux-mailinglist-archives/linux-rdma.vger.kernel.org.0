Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1C2FFBB6
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 05:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbhAVEYO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 23:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbhAVEYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 23:24:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DDC0613ED
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:31 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i30so3932408ota.6
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyfsrg0WcwUJ4gBjz9SeNw+/uhMhz7C6FbWShe2pYj8=;
        b=KiLLEdkCaz/BSv+4m3pw8Efs0RV5oqFHU1cCD5l6CbzjlLmm/KtT11SD6kp6cxELc/
         ZpZnWpvEI6zLe4guSdqxWy2g7gL2xGBlxe/Eo1nz5o2qYwC6NgAL8Iheyj5M9FhqWBXO
         TyJdc1PIWWbKw3tUsl2TjasW6gevoKkQVJ/rEJEXSgIwF+I5IP+mmAGjvY26BBws9DZi
         49IgDpIKUQhTgWdAkwV0NnMSAd+niU6L9GD89l8IteABV/FJ+Wjiodic9NxbMhjKifNI
         FrhFCXCNLYYQ/GigUbccQfABvRq8xVMrNjgXkCyadueEAA8OHIMm232XqLNyi3ExSSyR
         CX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyfsrg0WcwUJ4gBjz9SeNw+/uhMhz7C6FbWShe2pYj8=;
        b=jlgOxNzlG0OzazrI6Q644c41oe4A28Pb8ubmu9X1dYXWW4qVTTDh+16Ns++bP0iQhl
         PKymxwhePxVmyy3NRy35YZfvDJdWLaY2TQ34iNY63RQSYXPMnAH7y53BPnZ6LG6vUGDV
         gHclg1G6PluC9isCyxXrt0oEh7ue9hJDIFjtbfG//F3rjNmtDpSPu+rOnA1QHsL2ynCT
         cYS0nzGyXs3Pxo/zK/Btl254n5lS/glftEZnvjx1Z4XGEpB2QmluTzfYJbnwX6JOfBLj
         0W+X5tko70V+lQB+2yvWxtGjHhQqkoEyowRZ8s6H2lO5042EDP7p8vnktbpC84sG8BcM
         jliA==
X-Gm-Message-State: AOAM5331vN6VZlFPfIoaTNINgyydM8mDQzrN+LpecI97/Y39bZ+TVkF6
        6F2XmoPoZQ1DNpqS/ApXZSPUup1ZuMA=
X-Google-Smtp-Source: ABdhPJxiyDuH1Pf25gEws9u5JFWII5hyx/l6tzQ7YcepT2xwUbGYrYerPgc0nx1ULsPx6I8mTJQeuQ==
X-Received: by 2002:a9d:6393:: with SMTP id w19mr1964335otk.204.1611289410847;
        Thu, 21 Jan 2021 20:23:30 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5689-5322-9983-137f.res6.spectrum.com. [2603:8081:140c:1a00:5689:5322:9983:137f])
        by smtp.gmail.com with ESMTPSA id q26sm14244otg.28.2021.01.21.20.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:23:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 3/5] RDMA/rxe: Remove RXE_POOL_ATOMIC
Date:   Thu, 21 Jan 2021 22:23:11 -0600
Message-Id: <20210122042313.3336-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122042313.3336-1-rpearson@hpe.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_alloc() used the RXE_POOL_ATOMIC flag in rxe_type_info
to select GFP_ATOMIC in calls to kzalloc(). This was intended
to handle cases where an object could be created in interrupt
context. This no longer occurs since allocating those objects
has moved into the core so this flag is not necessary. An
incorrect use of this flag was still present for rxe_mc_elem
objects and is removed.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 6 +-----
 drivers/infiniband/sw/rxe/rxe_pool.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 80deec1e2924..7e68f99558a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -84,7 +84,6 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
 		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
-		.flags		= RXE_POOL_ATOMIC,
 	},
 };
 
@@ -380,8 +379,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
 	read_lock_irqsave(&pool->pool_lock, flags);
 	if (pool->state != RXE_POOL_STATE_VALID) {
 		read_unlock_irqrestore(&pool->pool_lock, flags);
@@ -397,8 +394,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
-		      GFP_ATOMIC : GFP_KERNEL);
+	obj = kzalloc(info->size, GFP_KERNEL);
 	if (!obj)
 		goto out_cnt;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b9680f9e907c..f916ad4d0406 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -11,7 +11,6 @@
 #define RXE_POOL_CACHE_FLAGS	(0)
 
 enum rxe_pool_flags {
-	RXE_POOL_ATOMIC		= BIT(0),
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_NO_ALLOC	= BIT(4),
-- 
2.27.0

