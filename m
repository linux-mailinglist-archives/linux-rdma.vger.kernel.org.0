Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FD23BB44
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Aug 2020 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHDNkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Aug 2020 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgHDNiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Aug 2020 09:38:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD16C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  4 Aug 2020 06:38:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so10589997pgc.8
        for <linux-rdma@vger.kernel.org>; Tue, 04 Aug 2020 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pyecBUdSTxOaT88VZLKkXXTtyvRsXL/Ln/dnYub868=;
        b=Yg9IL2oOgU7wF91bQvONv4/ZcjV6NvVoCVpbmv5PL0Igc+hwv3bANDff0VlUtpzk9f
         qn04QSKG/X4d5hRnCQQd5hNQNdFvGpz+fnwwNyktfoTpZVJT5ORbowni9x2ODqqqmyvp
         JTgeybuXgSmHfNc0ncOsgtq5Zs3LS9bwbHuHerqKLvA8/4K05cNMwAuIyQbtIyuqkkxX
         a9eto0DqrRp/93Ol4ccjH8vwsZVOn3IW1ESikw9KXtO0jGQabAwmFQrK1k+izqjzeq/Z
         yvtSgazVwvU6l5vORp0AIQ8DnswiW4KzBRSBfRJJEZ4L8j3FUqmWY6K9pB8x+2a7BmPa
         YgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pyecBUdSTxOaT88VZLKkXXTtyvRsXL/Ln/dnYub868=;
        b=QG91CEesLnGBwwzLf7y9CXF3MZwaDbWFSzSXiPd3bxnWzLgZ9/ej2sY4dEf7pRBJTm
         +4ITxWHY7w3Mo6f708/JxnZlMbJflaFZ6KJuPzZ5ZqeSVywkj95U2EwWUj24PNIFfTdr
         yLdEKf9MZLrSgTgB+4B3y2qc18knYMc+m4hV6b1C5+ehxWEY6FzDlOOeX7TzHBT640Fy
         GDUIE6ZwKLYQ3ER3L07D42UqvpBejxyRWJwu30SB3RI5wy+ImMVUqE6OnfuP6HfdzzC9
         Q9dn0/ijWtNNYGxBOp1FiV8GtZjb06k3761d95xC8gPmoDKjpxZjKNFdU5mSLV2FAJpK
         OTMg==
X-Gm-Message-State: AOAM53331e0KNCAnX1bxw7cAyq9vBfRnEx02BVvzRVz6P4vCsbK1s8pV
        tg7/GXO5guk3FW27X0Zj/kjlmA==
X-Google-Smtp-Source: ABdhPJyjnrvq39vYDyFXBlWaAQDCa+YVPn5HNzQq0Z7BuCiLgBph1VvPMWaB3L+d55J1aLpy5mxuZA==
X-Received: by 2002:a63:1116:: with SMTP id g22mr11724403pgl.257.1596548296839;
        Tue, 04 Aug 2020 06:38:16 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.247])
        by smtp.gmail.com with ESMTPSA id n12sm25275595pfj.99.2020.08.04.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 06:38:16 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org
Cc:     rong.a.chen@intel.com, Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into rtrs server init
Date:   Tue,  4 Aug 2020 19:07:58 +0530
Message-Id: <20200804133759.377950-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623172321.GC6578@ziepe.ca>
References: <20200623172321.GC6578@ziepe.ca>
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
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0d9241f5d9e6..916f99464d09 100644
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
@@ -2033,6 +2035,62 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
 	kfree(ctx);
 }
 
+static int rtrs_srv_add_one(struct ib_device *device)
+{
+	struct rtrs_srv_ctx *ctx;
+	int ret;
+
+	/*
+	 * Keep a track on the number of ib devices added
+	 */
+	ib_ctx.ib_dev_count++;
+
+	if (!ib_ctx.rdma_init) {
+		/*
+		 * Since our CM IDs are NOT bound to any ib device we will create them
+		 * only once
+		 */
+		ctx = ib_ctx.srv_ctx;
+		ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
+		if (ret) {
+			/*
+			 * We errored out here.
+			 * According to the ib code, if we encounter an error here then the
+			 * error code is ignored, and no more calls to our ops are made.
+			 */
+			pr_err("Failed to initialize RDMA connection");
+			return ret;
+		}
+		ib_ctx.rdma_init = true;
+	}
+
+	return 0;
+}
+
+static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
+{
+	struct rtrs_srv_ctx *ctx;
+
+	ib_ctx.ib_dev_count--;
+
+	if (!ib_ctx.ib_dev_count && ib_ctx.rdma_init) {
+		/*
+		 * Since our CM IDs are NOT bound to any ib device we will remove them
+		 * only once, when the last device is removed
+		 */
+		ctx = ib_ctx.srv_ctx;
+		rdma_destroy_id(ctx->cm_id_ip);
+		rdma_destroy_id(ctx->cm_id_ib);
+		ib_ctx.rdma_init = false;
+	}
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
@@ -2051,12 +2109,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	err = rtrs_srv_rdma_init(ctx, port);
+	ib_ctx = (struct rtrs_srv_ib_ctx) {
+		.srv_ctx	= ctx,
+		.port		= port,
+	};
+
+	err = ib_register_client(&rtrs_srv_client);
 	if (err) {
 		free_srv_ctx(ctx);
 		return ERR_PTR(err);
 	}
 
+	/*
+	 * Since ib_register_client does not propagate the device add error
+	 * we check if the RDMA connection init was successful or not
+	 */
+	if (!ib_ctx.rdma_init) {
+		free_srv_ctx(ctx);
+		return NULL;
+	}
+
 	return ctx;
 }
 EXPORT_SYMBOL(rtrs_srv_open);
@@ -2090,8 +2162,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
  */
 void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
 {
-	rdma_destroy_id(ctx->cm_id_ip);
-	rdma_destroy_id(ctx->cm_id_ib);
+	ib_unregister_client(&rtrs_srv_client);
 	close_ctx(ctx);
 	free_srv_ctx(ctx);
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index dc95b0932f0d..6e9d9000cd8d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -118,6 +118,13 @@ struct rtrs_srv_ctx {
 	struct list_head srv_list;
 };
 
+struct rtrs_srv_ib_ctx {
+	struct rtrs_srv_ctx	*srv_ctx;
+	u16			port;
+	int			ib_dev_count;
+	bool			rdma_init;
+};
+
 extern struct class *rtrs_dev_class;
 
 void close_sess(struct rtrs_srv_sess *sess);
-- 
2.25.1

