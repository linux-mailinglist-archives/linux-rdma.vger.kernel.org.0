Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075DB302D75
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbhAYVTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbhAYVSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BEBC061788
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a109so14236718otc.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ak10mtEKMMemekcMv4+yfdQKMMStyMtW7BlCZsMxFLo=;
        b=aaFyttkx0Ad8A/9CM6wJRlU8aAS8qrqeHuvqu126lmog5IOSSWlbr+mTUruLV1gFqf
         CvKljhc77KwPnJ/kNslLlLQRUGEJUjcvNA3jCoW5HzWhfoxF2JPtam6MI7aLUUOcDE3n
         IP1pOFtT+G6IWjs6XmhcKW5ieuZz0LoVn5430r6TFVoIcOdE3AE39+VT52EeThfy8vAN
         2KNOtdweMoZRGgnuS/65d73f861r//VufNPgrhSVp5PC5piVF6BI5j3dXZng3YHVIJHD
         z5iSIF1sIAxNCWTvm/qnPoYRIEB4J9X8TkU/m20v0Xv/PiQ7PG3lAy8pu9Ds/wH706eA
         I1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ak10mtEKMMemekcMv4+yfdQKMMStyMtW7BlCZsMxFLo=;
        b=Qu6S0igVXhCN+MpArEbT2mrEnYVaCVAjur3qoh6fO1gUW1LHS/qxVR2zkfMuSBbawa
         KjhBD0jMZFfB2AGkRxkU7kNwL7PlQZH83hExrgJ3vKhXXmFat2BLIcNj/DiOvsrFwe3u
         WQDNvSLwMRBvyhYPnIVtkHWvg25vhk+ICcftXWMtGq8gouEC5XHER9UBjyr7IAXKdoiv
         zD2R3iuKgSZAo/rElOvKBb9TTfMjz/ZfrXvM8R+IhR3rfppr4bV6jNIVwuzK0qxJKZOW
         RHJDJHyjZJaj5I6KgZCpIZu+Tb+s0hgbButzEGP/El2uvDyOb4YsisfQ1ZD0dqLeTbyr
         e5RA==
X-Gm-Message-State: AOAM530GYEDPV9WDtMn8Q3POHGRryj60gerAarm4TPIiVWEYMPUaY8md
        51gPUOc0hqgH0gyXuGzAI0Q=
X-Google-Smtp-Source: ABdhPJwZvx+Of7khi6wAVRhPeC2DutpwhZ/HCh4uZoqOGlDOrEspXPYsulDaRkeYJ0d+27ywmYpEEA==
X-Received: by 2002:a9d:84d:: with SMTP id 71mr1770740oty.338.1611609406899;
        Mon, 25 Jan 2021 13:16:46 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 3/6] RDMA/rxe: Remove RXE_POOL_ATOMIC
Date:   Mon, 25 Jan 2021 15:16:38 -0600
Message-Id: <20210125211641.2694-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v2]
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
index 5ca54e09cd0e..0ca46bd8be51 100644
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
index a75ac2d2847a..22714dafe00d 100644
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

