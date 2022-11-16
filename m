Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855B62BB8C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiKPLYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiKPLY0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:26 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D6DB1E0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmD9qh1FqlWYgBEpeyOXm9cT2kOzIyPuX0R2CFN4980=;
        b=n06pxyCBvRfNdswAjqS6YO9yLM//l3R6iSVVKuYEXowYlYMGqJkBKl0c17tEWwnTh8jdYC
        nWGNiX9aj1wvdXUjyslztwEihURdyzWWIrQDfHGV/0X1A+bICqGfrDP8GWu9gdekxEux/5
        mJ2W7spJ6kg6/D5+wi9GghZkm+wDNLM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 6/8] RDMA/rtrs: Clean up rtrs_rdma_dev_pd_ops
Date:   Wed, 16 Nov 2022 19:13:58 +0800
Message-Id: <20221116111400.7203-7-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-1-guoqing.jiang@linux.dev>
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Let's remove them since the three members are not used.

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  3 ---
 drivers/infiniband/ulp/rtrs/rtrs.c     | 22 ++++------------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index a2420eecaf5a..ab25619261d2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -68,10 +68,7 @@ enum {
 struct rtrs_ib_dev;
 
 struct rtrs_rdma_dev_pd_ops {
-	struct rtrs_ib_dev *(*alloc)(void);
-	void (*free)(struct rtrs_ib_dev *dev);
 	int (*init)(struct rtrs_ib_dev *dev);
-	void (*deinit)(struct rtrs_ib_dev *dev);
 };
 
 struct rtrs_rdma_dev_pd {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ed324b47d93a..4bf9d868cc52 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -557,7 +557,6 @@ EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
 void rtrs_rdma_dev_pd_init(enum ib_pd_flags pd_flags,
 			    struct rtrs_rdma_dev_pd *pool)
 {
-	WARN_ON(pool->ops && (!pool->ops->alloc ^ !pool->ops->free));
 	INIT_LIST_HEAD(&pool->list);
 	mutex_init(&pool->mutex);
 	pool->pd_flags = pd_flags;
@@ -583,15 +582,8 @@ static void dev_free(struct kref *ref)
 	list_del(&dev->entry);
 	mutex_unlock(&pool->mutex);
 
-	if (pool->ops && pool->ops->deinit)
-		pool->ops->deinit(dev);
-
 	ib_dealloc_pd(dev->ib_pd);
-
-	if (pool->ops && pool->ops->free)
-		pool->ops->free(dev);
-	else
-		kfree(dev);
+	kfree(dev);
 }
 
 int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
@@ -618,11 +610,8 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
 			goto out_unlock;
 	}
 	mutex_unlock(&pool->mutex);
-	if (pool->ops && pool->ops->alloc)
-		dev = pool->ops->alloc();
-	else
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(dev))
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
 		goto out_err;
 
 	kref_init(&dev->ref);
@@ -644,10 +633,7 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
 out_free_pd:
 	ib_dealloc_pd(dev->ib_pd);
 out_free_dev:
-	if (pool->ops && pool->ops->free)
-		pool->ops->free(dev);
-	else
-		kfree(dev);
+	kfree(dev);
 out_err:
 	return NULL;
 }
-- 
2.31.1

