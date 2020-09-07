Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9F25F851
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgIGKbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgIGKbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 06:31:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC53C061573
        for <linux-rdma@vger.kernel.org>; Mon,  7 Sep 2020 03:31:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z15so4299854plo.7
        for <linux-rdma@vger.kernel.org>; Mon, 07 Sep 2020 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tyre4GHU3JiTkocI1Nl1h1N4AyZJY3fbiybTRaNmVHQ=;
        b=OqWn4BYyFop7UmMBVs5FWHfE5JsNQ6ix7CI3pxj60SwmzY0gAwxT/ei79zQJ7dLntj
         NmERJUV1Bj4mTnUgV5akhz5mm1zIlfoKCFqWBmF9vNqhwMmlkufgxUNEW7tEQVnZYwxh
         T2nzSiQgVbfdvY2+/cAkVsny8ZM4ex+yYoksWQ5H2IHDXuzE1nKKY1F1P/z6OrabElR7
         TD/EWWVTEU1Nj6s80RNrVI10S73PNQ0V0dOLZqWFKqfMa18Kfb79dShj/plwjKShXvQ/
         /JI9GE6sBaELgf9Bd6LI5izvtW6jrtvcOIYd72rNBkRl/kDLvn5sjn18LeGetZJPYBTC
         4vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tyre4GHU3JiTkocI1Nl1h1N4AyZJY3fbiybTRaNmVHQ=;
        b=Mlh4dNP/GAob8mrvrfPd8kodg/HO0GhzBDh14N1dbw4Z057ObWeiHwmn9pHhBTW35h
         fXOKRcnXF6ojc8pH05HndBde/vYVNrJ0/TzYLEcl19AJD2nFJ8l41g2d6/6Yz1VvOn2N
         rvPiRjzZ4bnO0bar0oNQS1VRVmd7hGJMR7D541h2Ym4iG9uiq37Hl/piNa3xS7QUsAUE
         KSRywHDhHJY1/T9BIW7O3fAQMDHWC4A8smqwtEwIRNKgUGRJGZ3rPSZQw2kywBbyzHJK
         UfOuee8/OaWQWh/9+81goQpORtpB0LeeYd2QeTRecNHEx4ltSoE8XA9QZKsxWMKg1J5k
         eW/w==
X-Gm-Message-State: AOAM533cnEETgO9AzGDbVb5kers/ybqVUfgzLX6jBrdshahKtH4Cqgt8
        p4hZ0+CPTEFlLnzIVB2WuJkAXXZkt9gIDuEi
X-Google-Smtp-Source: ABdhPJyVcTuAv4xszjXre58qYP02Lyroq1eKoGuonn8RJKrMR61f9BGQapAoMGXawuxhfqgIHcpXYQ==
X-Received: by 2002:a17:902:c392:: with SMTP id g18mr929827plg.41.1599474678587;
        Mon, 07 Sep 2020 03:31:18 -0700 (PDT)
Received: from nb01533.domain.name ([43.224.130.246])
        by smtp.gmail.com with ESMTPSA id 67sm15082573pfv.173.2020.09.07.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:31:18 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH v4] RDMA/rtrs-srv: Incorporate ib_register_client into rtrs server init
Date:   Mon,  7 Sep 2020 16:01:06 +0530
Message-Id: <20200907103106.104530-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rnbd_server module's communication manager (cm) initialization depends
on the registration of the "network namespace subsystem" of the RDMA CM
agent module. As such, when the kernel is configured to load the
rnbd_server and the RDMA cma module during initialization; and if the
rnbd_server module is initialized before RDMA cma module, a null ptr
dereference occurs during the RDMA bind operation.

Call trace below,

[    1.904782] Call Trace:
[    1.904782]  ? xas_load+0xd/0x80
[    1.904782]  xa_load+0x47/0x80
[    1.904782]  cma_ps_find+0x44/0x70
[    1.904782]  rdma_bind_addr+0x782/0x8b0
[    1.904782]  ? get_random_bytes+0x35/0x40
[    1.904782]  rtrs_srv_cm_init+0x50/0x80
[    1.904782]  rtrs_srv_open+0x102/0x180
[    1.904782]  ? rnbd_client_init+0x6e/0x6e
[    1.904782]  rnbd_srv_init_module+0x34/0x84
[    1.904782]  ? rnbd_client_init+0x6e/0x6e
[    1.904782]  do_one_initcall+0x4a/0x200
[    1.904782]  kernel_init_freeable+0x1f1/0x26e
[    1.904782]  ? rest_init+0xb0/0xb0
[    1.904782]  kernel_init+0xe/0x100
[    1.904782]  ret_from_fork+0x22/0x30
[    1.904782] Modules linked in:
[    1.904782] CR2: 0000000000000015
[    1.904782] ---[ end trace c42df88d6c7b0a48 ]---

All this happens cause the cm init is in the call chain of the module init,
which is not a preferred practice.

So remove the call to rdma_create_id() from the module init call chain.
Instead register rtrs-srv as an ib client, which makes sure that the
rdma_create_id() is called only when an ib device is added.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
Change in v4:
	Add mutex lock to prevent the add/remove of ib device from racing
Change in v3:
	Remove RDMA init error check while rtrs server open
	Remove -1 assignment for ib_dev_count on RDMA init error
Change in v2:
        Use only single variable to track number of IB devices and failure
        Change according to kernel coding style

 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index a219bd1bdbc2..72a9692d098a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -16,6 +16,7 @@
 #include "rtrs-srv.h"
 #include "rtrs-log.h"
 #include <rdma/ib_cm.h>
+#include <rdma/ib_verbs.h>
 
 MODULE_DESCRIPTION("RDMA Transport Server");
 MODULE_LICENSE("GPL");
@@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
 static struct rtrs_rdma_dev_pd dev_pd;
 static mempool_t *chunk_pool;
 struct class *rtrs_dev_class;
+static struct rtrs_srv_ib_ctx ib_ctx;
 
 static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
 static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
@@ -2033,6 +2035,71 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
 	kfree(ctx);
 }
 
+static int rtrs_srv_add_one(struct ib_device *device)
+{
+	struct rtrs_srv_ctx *ctx;
+	int ret;
+
+	mutex_lock(&ib_ctx.ib_dev_mutex);
+	ret = 0;
+	if (ib_ctx.ib_dev_count)
+		goto out;
+
+	/*
+	 * Since our CM IDs are NOT bound to any ib device we will create them
+	 * only once
+	 */
+	ctx = ib_ctx.srv_ctx;
+	ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
+	if (ret) {
+		/*
+		 * We errored out here.
+		 * According to the ib code, if we encounter an error here then the
+		 * error code is ignored, and no more calls to our ops are made.
+		 */
+		pr_err("Failed to initialize RDMA connection");
+		goto err_out;
+	}
+
+out:
+	/*
+	 * Keep a track on the number of ib devices added
+	 */
+	ib_ctx.ib_dev_count++;
+
+err_out:
+	mutex_unlock(&ib_ctx.ib_dev_mutex);
+	return ret;
+}
+
+static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
+{
+	struct rtrs_srv_ctx *ctx;
+
+	mutex_lock(&ib_ctx.ib_dev_mutex);
+	ib_ctx.ib_dev_count--;
+
+	if (ib_ctx.ib_dev_count)
+		goto out;
+
+	/*
+	 * Since our CM IDs are NOT bound to any ib device we will remove them
+	 * only once, when the last device is removed
+	 */
+	ctx = ib_ctx.srv_ctx;
+	rdma_destroy_id(ctx->cm_id_ip);
+	rdma_destroy_id(ctx->cm_id_ib);
+
+out:
+	mutex_unlock(&ib_ctx.ib_dev_mutex);
+}
+
+static struct ib_client rtrs_srv_client = {
+	.name	= "rtrs_server",
+	.add	= rtrs_srv_add_one,
+	.remove	= rtrs_srv_remove_one
+};
+
 /**
  * rtrs_srv_open() - open RTRS server context
  * @ops:		callback functions
@@ -2051,7 +2118,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	err = rtrs_srv_rdma_init(ctx, port);
+	mutex_init(&ib_ctx.ib_dev_mutex);
+	ib_ctx.srv_ctx = ctx;
+	ib_ctx.port = port;
+
+	err = ib_register_client(&rtrs_srv_client);
 	if (err) {
 		free_srv_ctx(ctx);
 		return ERR_PTR(err);
@@ -2090,8 +2161,8 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
  */
 void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
 {
-	rdma_destroy_id(ctx->cm_id_ip);
-	rdma_destroy_id(ctx->cm_id_ib);
+	ib_unregister_client(&rtrs_srv_client);
+	mutex_destroy(&ib_ctx.ib_dev_mutex);
 	close_ctx(ctx);
 	free_srv_ctx(ctx);
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index dc95b0932f0d..08b0b8a6eebe 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -118,6 +118,13 @@ struct rtrs_srv_ctx {
 	struct list_head srv_list;
 };
 
+struct rtrs_srv_ib_ctx {
+	struct rtrs_srv_ctx	*srv_ctx;
+	u16			port;
+	struct mutex            ib_dev_mutex;
+	int			ib_dev_count;
+};
+
 extern struct class *rtrs_dev_class;
 
 void close_sess(struct rtrs_srv_sess *sess);
-- 
2.25.1

