Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9836437E7E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhJVTVv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhJVTVt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF084C061766
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so5599936otr.7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8W28ffYZk4hShSglpsETM7Rcy0s2YqTOcOdvMh3sWY=;
        b=MbVEAwZCas7+RV/k/4FRF1UcLx7/nkgzTYN7z1ToyYu2CXy6gG/9ogTMoFWgVjmB2f
         1WWKqA6CnQpix9U5wQkPWWRpVBoNqSlfRt8PSNlhdnOyeqC1KHhs5GHDd+KNX8xgreT2
         JMv3mQkdos5K4LytJ6KJpGC97b3NEAmYf8e19XRBb8bdMQpW4h4M+0fiRPPzltkfbBva
         2ZS6UzCHXUTv/ZV+EdUUgddcyRC2O2nSr9iHTysl5FEs1RzWE4ZGh6S7gUi3tbZN/wDl
         3s82JQ7xlbdFulbIu0E5WW+Jp1sGhkOMgVC4lVBOAzmAYTENgY6a1wLjt7vqnxME2EHN
         1yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8W28ffYZk4hShSglpsETM7Rcy0s2YqTOcOdvMh3sWY=;
        b=aNJPEAReOOIDot7TqU4iz3P3tGaRCb7U4LYK4dyDKjee1/ukGAkOsmvLeG+Sm1SjOH
         ejQ2/d2RLA1LA3lxS3yb7oaxR5zPkaHdJx9tj2BpcKZOGjjY9krHCSVlVU4sOG+5uNiV
         BJE+1EmyPVefqV7vQblAwSHR9jLiN0rZBO2sw+4yr3MnQxZjsFVaNH48ycFGGuhzhbdd
         o1yWXJhAcXj6ZQMbRKSkplTfMfiCWsxI6yE+Q26yiHFiNxCo+osncXk+oX9ItSyuU83d
         MEXy7SWT5yS7utAcfxeEutTnwzhIl2jOD2H3DbkvaTz3rCdUOGESqT+nEFsP+wUXAL0i
         dpoA==
X-Gm-Message-State: AOAM530NE3WOiYYrBQCg1Fd61bXFaY4Jbk9wERFW5P848B6+fMkA6AtP
        8q1yiJ4OVJO2XIwwDzy0G0M=
X-Google-Smtp-Source: ABdhPJzUDGFVRo5zbnFaLb3l5393RvMc7w0cHMCnjWWO1Eo0K8HYfy1UZWuc3VnAlYtzwWRjjMIf0w==
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr1414788otu.257.1634930371314;
        Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 01/10] RDMA/rxe: Make rxe_alloc() take pool lock
Date:   Fri, 22 Oct 2021 14:18:16 -0500
Message-Id: <20211022191824.18307-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c there are two separate pool APIs for creating a new object
rxe_alloc() and rxe_alloc_locked(). Currently they are identical except
for GFP_KERNEL vs GFP_ATOMIC. Make rxe_alloc() take the pool lock which
is in line with the other APIs in the library and was the original intent.
Keep kzalloc() outside of the lock to avoid using GFP_ATOMIC.
Make similar change to rxe_add_to_pool. The code checking the pool limit
is potentially racy without a lock. The lock around finishing the pool
element provides a memory barrier before 'publishing' the object.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3
  Kept rxe_alloc and rxe_alloc_locked separate to allow use of GFP_KERNEL
  in rxe_alloc

 drivers/infiniband/sw/rxe/rxe_pool.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7b4cb46edfd9..8138e459b6c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -356,39 +356,51 @@ void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
+	unsigned long flags;
 	u8 *obj;
 
+	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	obj = kzalloc(info->size, GFP_KERNEL);
-	if (!obj)
-		goto out_cnt;
+	if (!obj) {
+		atomic_dec(&pool->num_elem);
+		return NULL;
+	}
 
+	write_lock_irqsave(&pool->pool_lock, flags);
 	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
-
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	unsigned long flags;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return 0;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	return -EINVAL;
 }
 
-- 
2.30.2

