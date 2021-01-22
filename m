Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28D72FFBB5
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 05:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbhAVEYQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 23:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbhAVEYM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 23:24:12 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C4C061786
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:32 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 15so4714282oix.8
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZIB4bhhVzzmVHf7mkoTM4mwy1zZee3d8vYisOnp3Zc=;
        b=f1GtO4Q5Qx4w7moEELOtijAmhlZuLXF86JjXiPJ/3RJsYUQhH0y+kuaiYsFbng8dkV
         rX4GR55eJNIcyIW+lqKA/2i1QHO8SkqN1EBfgSIL1z4InPXyyRnpWxFWAVlDE3MUgVCg
         iuSKKfKP8fL0v9JFy9AvVrBzS09evZy6zGnA/QqbB/qu3kjQ4dGPtNJ9rRIMgt7h8e+m
         uS6DEQZ//BWG1dQCDtSR5mC7FJjFJF9FC/eHzRFIcqfEV6k1Vtg+Zvy+5F3p+ISn+srt
         bqDSMf46Rqe55z2dT2j74n1sU8hcluY2RlYNHubpDv4tM9Re+dEO/yRVJ9Ffua3Yt4W3
         pc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZIB4bhhVzzmVHf7mkoTM4mwy1zZee3d8vYisOnp3Zc=;
        b=dXtfBI0D+Dc+qBZRVfrWduRErGA0Ky1FJLU5sungevR7w9a13rfWUiUhX3QoLKbVZj
         YBwq77SeSc8P7j9xiEgFdHUeuygMtwOKJksMFxA9ReLBtVxcYf9ePbPLNt2j2ygsjN69
         V4EvwPQiNupe/p8y1Fw6kKlBZop4ZfDN0Hg+dEfR8T1sMftRr6/txo+k+QPTisDNDjf3
         FgWL6JbI/V9M5Kb3vqoZopGWCGpIdq4+GBa50jNKSEA+n6xjknKgtGHLCOl8oPvbwS54
         Snh3rM7IGVlyVjyXMFfxfJRC933bciUFGSogZmrb7T7ltrls0Huef8AObVy2cWxvKWEu
         3Ryg==
X-Gm-Message-State: AOAM533ltavIlk/2kmnvzpRIjliskZ1v74DcQREMC14tha5tlD6ag7A+
        Uvqv36rxGIH3ixbWe/M5eJc=
X-Google-Smtp-Source: ABdhPJwJQ4JEutFQizhb3Du+UDY/SvtSHrUS6PiM05MU1QCa9uqWOpP9cJaV5i7A4zK8h054Pn9svQ==
X-Received: by 2002:aca:c448:: with SMTP id u69mr2035943oif.129.1611289411719;
        Thu, 21 Jan 2021 20:23:31 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5689-5322-9983-137f.res6.spectrum.com. [2603:8081:140c:1a00:5689:5322:9983:137f])
        by smtp.gmail.com with ESMTPSA id q26sm14244otg.28.2021.01.21.20.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:23:31 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 4/5] RDMA/rxe: Remove calls to ib_device_try_get/put
Date:   Thu, 21 Jan 2021 22:23:12 -0600
Message-Id: <20210122042313.3336-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122042313.3336-1-rpearson@hpe.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_pool.c had redundant attempts to reference count
rxe objects taking references to the pools and also the
ib_device. This patch eliminates the references to the
ib_device which add no value.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7e68f99558a7..157fb340a3fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -347,9 +347,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 
 	kref_get(&pool->ref_cnt);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -366,7 +363,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
 	rxe_pool_put(pool);
 	return NULL;
@@ -388,9 +384,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -407,7 +400,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
 	rxe_pool_put(pool);
 	return NULL;
@@ -425,9 +417,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -438,7 +427,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
 	rxe_pool_put(pool);
 	return -EINVAL;
@@ -461,7 +449,6 @@ void rxe_elem_release(struct kref *kref)
 	}
 
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
 }
 
-- 
2.27.0

