Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626C626D32
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiKMBIm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMBIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:42 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76125C7
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv032lrzlN9ChNEAvXxauoX7CEIDjAQVR47zbEM1hqA=;
        b=MZntfJDfQgGD+gdCYIMKlcd0gnPPaRIplLTZXKlhrRjgzYeiiDJMPjj6YT89ONae6ZYeP/
        ZLkWgyaIj91as1NYbuldoIjHr6XXcl80bfyzyteGeNt/VrtkTe7v8r5rmZLAVuA7JT7kZs
        Kw0M9Z70j/5nyVc4+sAgLmpkJSU9VcQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
Date:   Sun, 13 Nov 2022 09:08:12 +0800
Message-Id: <20221113010823.6436-2-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ib_dev_count is supposed to track the number of added ib devices
which is only used in rtrs_srv_{add,remove}_one.

However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
-> rtrs_srv_open -> ib_register_client -> client->add which should
happen only once. And so is rtrs_srv_close since it is only called
by unload rnbd-server or failure case when load rnbd-server.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 16 ----------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 22d7ba05e9fe..79504aaef0cc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2097,8 +2097,6 @@ static int rtrs_srv_add_one(struct ib_device *device)
 	int ret = 0;
 
 	mutex_lock(&ib_ctx.ib_dev_mutex);
-	if (ib_ctx.ib_dev_count)
-		goto out;
 
 	/*
 	 * Since our CM IDs are NOT bound to any ib device we will create them
@@ -2108,21 +2106,12 @@ static int rtrs_srv_add_one(struct ib_device *device)
 	ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
 	if (ret) {
 		/*
-		 * We errored out here.
 		 * According to the ib code, if we encounter an error here then the
 		 * error code is ignored, and no more calls to our ops are made.
 		 */
 		pr_err("Failed to initialize RDMA connection");
-		goto err_out;
 	}
 
-out:
-	/*
-	 * Keep a track on the number of ib devices added
-	 */
-	ib_ctx.ib_dev_count++;
-
-err_out:
 	mutex_unlock(&ib_ctx.ib_dev_mutex);
 	return ret;
 }
@@ -2132,10 +2121,6 @@ static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
 	struct rtrs_srv_ctx *ctx;
 
 	mutex_lock(&ib_ctx.ib_dev_mutex);
-	ib_ctx.ib_dev_count--;
-
-	if (ib_ctx.ib_dev_count)
-		goto out;
 
 	/*
 	 * Since our CM IDs are NOT bound to any ib device we will remove them
@@ -2145,7 +2130,6 @@ static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
 	rdma_destroy_id(ctx->cm_id_ip);
 	rdma_destroy_id(ctx->cm_id_ib);
 
-out:
 	mutex_unlock(&ib_ctx.ib_dev_mutex);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 2f8a638e36fa..eccc432b0715 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -126,7 +126,6 @@ struct rtrs_srv_ib_ctx {
 	struct rtrs_srv_ctx	*srv_ctx;
 	u16			port;
 	struct mutex            ib_dev_mutex;
-	int			ib_dev_count;
 };
 
 extern struct class *rtrs_dev_class;
-- 
2.31.1

