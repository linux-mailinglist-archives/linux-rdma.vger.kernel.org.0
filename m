Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F2240576
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgHJLvL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJLvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 07:51:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99BC061756
        for <linux-rdma@vger.kernel.org>; Mon, 10 Aug 2020 04:51:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so8806824pjn.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Aug 2020 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtBiv33Rt64LixQ+c0lyCswxqEdvztonGsUnxeKFkx0=;
        b=fmXLIgqKw0SvbbOGHMlnS3yItguWrAy8/4zjQN96fJ65vQOcvhIFkV817TOAU/JqV7
         74xjAgZDMt1iYlGdOJzrS5xchgQ4FOLRsbu0gZW6gzaj+uEd1TBgE33D55RqADK2W05p
         i6NMXHXW4BX1j7ATRULP3IoByF1PkekW9wjqaVXKXccnyDdQM2BiJDrgv1U5jn+onbNi
         DkKIDcWj+rReHa+FvgHGl09XSufb4k3utB6jwriv3QS3Vp2YTdryzgMvoHZ36y67SEFb
         yf5PcF1ie50PRabIgou0Q9x3KU3Ev+8qclsajRTr5Mz+lDkrEysJ+84Io6opcSPvXEk2
         H2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtBiv33Rt64LixQ+c0lyCswxqEdvztonGsUnxeKFkx0=;
        b=gqS3qenEkmg9tdAS+o/+pNAJBGlEAu80ZsAAZkFvcN7jhogzyG6twrYGDTDK9eYopN
         SRKvcfv6xvyl1LTTia6myfuMkhDM4scdMMiCfHHudoJGtjU6SslFfm/EDXAbVhL9u4Gm
         MJMS1t/LoAs0+YX8VGQsOfomlpZQnwcsjO1xNFsDfvKDVVXH5SvsCgHukcPyjzAhfnji
         E9ijBBIsqR3AdOfJXC6yxsWIrui+z03szIH38uRk6HNX2GtsrikvRrB3X27JgvWm2hK/
         5+zaPZwQOelETyBhZdAxWfOqfWtKlbw9tCkSP+Rf5jCNSM2veFnGK7Q178L5FCDsCaks
         FH2Q==
X-Gm-Message-State: AOAM531CYFsZYVLpf6E0PW+CrpusDgKEM9W6zd27svEcUtEUuU9LVkgR
        +n9lajer13DeBuuojfH4ByYhKw==
X-Google-Smtp-Source: ABdhPJxxA7sEqVqGEA+J09rwIPsr5xrCVbnc+w3JtXVzOCxDtbgP7xAKbMO9fV6GK4NlP/MXe6qvHQ==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr8737461pjo.74.1597060268177;
        Mon, 10 Aug 2020 04:51:08 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.251])
        by smtp.gmail.com with ESMTPSA id m3sm19513304pjs.22.2020.08.10.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 04:51:07 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into rtrs server init
Date:   Mon, 10 Aug 2020 17:20:49 +0530
Message-Id: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
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
---
Change in v2:
        Use only single variable to track number of IB devices and failure
        Change according to kernel coding style

 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 0d9241f5d9e6..69a37ce73b0c 100644
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
@@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
 	kfree(ctx);
 }
 
+static int rtrs_srv_add_one(struct ib_device *device)
+{
+	struct rtrs_srv_ctx *ctx;
+	int ret;
+
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
+		ib_ctx.ib_dev_count = -1;
+		return ret;
+	}
+
+out:
+	/*
+	 * Keep a track on the number of ib devices added
+	 */
+	ib_ctx.ib_dev_count++;
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
+	if (ib_ctx.ib_dev_count)
+		return;
+
+	/*
+	 * Since our CM IDs are NOT bound to any ib device we will remove them
+	 * only once, when the last device is removed
+	 */
+	ctx = ib_ctx.srv_ctx;
+	rdma_destroy_id(ctx->cm_id_ip);
+	rdma_destroy_id(ctx->cm_id_ib);
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
@@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
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
+	 * we check if .add was called and the RDMA connection init failed
+	 */
+	if (ib_ctx.ib_dev_count < 0) {
+		free_srv_ctx(ctx);
+		return ERR_PTR(-ENODEV);
+	}
+
 	return ctx;
 }
 EXPORT_SYMBOL(rtrs_srv_open);
@@ -2090,8 +2164,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
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
index dc95b0932f0d..e8f7e99a9a6e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -118,6 +118,12 @@ struct rtrs_srv_ctx {
 	struct list_head srv_list;
 };
 
+struct rtrs_srv_ib_ctx {
+	struct rtrs_srv_ctx	*srv_ctx;
+	u16			port;
+	int			ib_dev_count;
+};
+
 extern struct class *rtrs_dev_class;
 
 void close_sess(struct rtrs_srv_sess *sess);
-- 
2.25.1

