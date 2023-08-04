Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389E37703E5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjHDPFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjHDPFo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 11:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3C49F3;
        Fri,  4 Aug 2023 08:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACAB6204A;
        Fri,  4 Aug 2023 15:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652D7C433C8;
        Fri,  4 Aug 2023 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691161536;
        bh=Lp1Qs8ByJyHcY/oWm72FarFhOl0WVjDkRb6QN+qdPJw=;
        h=From:To:Cc:Subject:Date:From;
        b=NC1C5biGN8hoo97HzphtL2XhwO7z3+bwPOD02ABMGlZDqL+tR71B0YxVP9KNNwX1Y
         SgVOMOj/Gi7k86u8OWy6ladNUVfHGAuOMtESe4pkAfeG4L96Y8a844ot0sQbfI+2Me
         0WiePtGhwSVjkxS+usxTK88JMge9jQD0LgDjOL44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] infiniband: make all 'class' structures const
Date:   Fri,  4 Aug 2023 17:05:28 +0200
Message-ID: <2023080427-commuting-crewless-cbee@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Lines:  420
X-Developer-Signature: v=1; a=openpgp-sha256; l=13222; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=x1TiTpFQGLP2r/d1XyA/DxK+XWsDSrx6Zo2RnD8S76s=; b=owGbwMvMwCRo6H6F97bub03G02pJDClnhbc/klrOasa5XX+u0LQ31clGgvUrNO7mf95r36d2c Mce578XOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiEZ8YFjTpbZJ645znNIOL 0+vanpg/U+7+ecIwPzEshoGrb9fmAk+eAi9b4w2LOmfNBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_main.c        | 35 +++++-----
 drivers/infiniband/hw/hfi1/device.c          | 72 +++++++++-----------
 drivers/infiniband/hw/qib/qib_file_ops.c     | 17 +++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 19 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 15 ++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  2 +-
 7 files changed, 79 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7c9c79c13941..bf800f8cb3e4 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -72,12 +72,23 @@ enum {
 #define IB_UVERBS_BASE_DEV	MKDEV(IB_UVERBS_MAJOR, IB_UVERBS_BASE_MINOR)
 
 static dev_t dynamic_uverbs_dev;
-static struct class *uverbs_class;
 
 static DEFINE_IDA(uverbs_ida);
 static int ib_uverbs_add_one(struct ib_device *device);
 static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
 
+static char *uverbs_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
+}
+
+static const struct class uverbs_class = {
+	.name = "infiniband_verbs",
+	.devnode = uverbs_devnode,
+};
+
 /*
  * Must be called with the ufile->device->disassociate_srcu held, and the lock
  * must be held until use of the ucontext is finished.
@@ -1117,7 +1128,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
 	}
 
 	device_initialize(&uverbs_dev->dev);
-	uverbs_dev->dev.class = uverbs_class;
+	uverbs_dev->dev.class = &uverbs_class;
 	uverbs_dev->dev.parent = device->dev.parent;
 	uverbs_dev->dev.release = ib_uverbs_release_dev;
 	uverbs_dev->groups[0] = &dev_attr_group;
@@ -1235,13 +1246,6 @@ static void ib_uverbs_remove_one(struct ib_device *device, void *client_data)
 	put_device(&uverbs_dev->dev);
 }
 
-static char *uverbs_devnode(const struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode = 0666;
-	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
-}
-
 static int __init ib_uverbs_init(void)
 {
 	int ret;
@@ -1262,16 +1266,13 @@ static int __init ib_uverbs_init(void)
 		goto out_alloc;
 	}
 
-	uverbs_class = class_create("infiniband_verbs");
-	if (IS_ERR(uverbs_class)) {
-		ret = PTR_ERR(uverbs_class);
+	ret = class_register(&uverbs_class);
+	if (ret) {
 		pr_err("user_verbs: couldn't create class infiniband_verbs\n");
 		goto out_chrdev;
 	}
 
-	uverbs_class->devnode = uverbs_devnode;
-
-	ret = class_create_file(uverbs_class, &class_attr_abi_version.attr);
+	ret = class_create_file(&uverbs_class, &class_attr_abi_version.attr);
 	if (ret) {
 		pr_err("user_verbs: couldn't create abi_version attribute\n");
 		goto out_class;
@@ -1286,7 +1287,7 @@ static int __init ib_uverbs_init(void)
 	return 0;
 
 out_class:
-	class_destroy(uverbs_class);
+	class_unregister(&uverbs_class);
 
 out_chrdev:
 	unregister_chrdev_region(dynamic_uverbs_dev,
@@ -1303,7 +1304,7 @@ static int __init ib_uverbs_init(void)
 static void __exit ib_uverbs_cleanup(void)
 {
 	ib_unregister_client(&uverbs_client);
-	class_destroy(uverbs_class);
+	class_unregister(&uverbs_class);
 	unregister_chrdev_region(IB_UVERBS_BASE_DEV,
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index 05be0d119f79..b0a00b7aaec5 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -10,8 +10,29 @@
 #include "hfi.h"
 #include "device.h"
 
-static struct class *class;
-static struct class *user_class;
+static char *hfi1_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0600;
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+static const struct class class = {
+	.name = "hfi1",
+	.devnode = hfi1_devnode,
+};
+
+static char *hfi1_user_devnode(const struct device *dev, umode_t *mode)
+{
+	if (mode)
+		*mode = 0666;
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+static const struct class user_class = {
+	.name = "hfi1_user",
+	.devnode = hfi1_user_devnode,
+};
 static dev_t hfi1_dev;
 
 int hfi1_cdev_init(int minor, const char *name,
@@ -37,9 +58,9 @@ int hfi1_cdev_init(int minor, const char *name,
 	}
 
 	if (user_accessible)
-		device = device_create(user_class, NULL, dev, NULL, "%s", name);
+		device = device_create(&user_class, NULL, dev, NULL, "%s", name);
 	else
-		device = device_create(class, NULL, dev, NULL, "%s", name);
+		device = device_create(&class, NULL, dev, NULL, "%s", name);
 
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
@@ -72,26 +93,6 @@ const char *class_name(void)
 	return hfi1_class_name;
 }
 
-static char *hfi1_devnode(const struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode = 0600;
-	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
-}
-
-static const char *hfi1_class_name_user = "hfi1_user";
-static const char *class_name_user(void)
-{
-	return hfi1_class_name_user;
-}
-
-static char *hfi1_user_devnode(const struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode = 0666;
-	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
-}
-
 int __init dev_init(void)
 {
 	int ret;
@@ -102,27 +103,21 @@ int __init dev_init(void)
 		goto done;
 	}
 
-	class = class_create(class_name());
-	if (IS_ERR(class)) {
-		ret = PTR_ERR(class);
+	ret = class_register(&class);
+	if (ret) {
 		pr_err("Could not create device class (err %d)\n", -ret);
 		unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
 		goto done;
 	}
-	class->devnode = hfi1_devnode;
 
-	user_class = class_create(class_name_user());
-	if (IS_ERR(user_class)) {
-		ret = PTR_ERR(user_class);
+	ret = class_register(&user_class);
+	if (ret) {
 		pr_err("Could not create device class for user accessible files (err %d)\n",
 		       -ret);
-		class_destroy(class);
-		class = NULL;
-		user_class = NULL;
+		class_unregister(&class);
 		unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
 		goto done;
 	}
-	user_class->devnode = hfi1_user_devnode;
 
 done:
 	return ret;
@@ -130,11 +125,8 @@ int __init dev_init(void)
 
 void dev_cleanup(void)
 {
-	class_destroy(class);
-	class = NULL;
-
-	class_destroy(user_class);
-	user_class = NULL;
+	class_unregister(&class);
+	class_unregister(&user_class);
 
 	unregister_chrdev_region(hfi1_dev, HFI1_NMINORS);
 }
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index ef85bc8d9384..152952127f13 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2250,7 +2250,9 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return qib_user_sdma_writev(rcd, pq, iter_iov(from), from->nr_segs);
 }
 
-static struct class *qib_class;
+static const struct class qib_class = {
+	.name = "ipath",
+};
 static dev_t qib_dev;
 
 int qib_cdev_init(int minor, const char *name,
@@ -2281,7 +2283,7 @@ int qib_cdev_init(int minor, const char *name,
 		goto err_cdev;
 	}
 
-	device = device_create(qib_class, NULL, dev, NULL, "%s", name);
+	device = device_create(&qib_class, NULL, dev, NULL, "%s", name);
 	if (!IS_ERR(device))
 		goto done;
 	ret = PTR_ERR(device);
@@ -2325,9 +2327,8 @@ int __init qib_dev_init(void)
 		goto done;
 	}
 
-	qib_class = class_create("ipath");
-	if (IS_ERR(qib_class)) {
-		ret = PTR_ERR(qib_class);
+	ret = class_register(&qib_class);
+	if (ret) {
 		pr_err("Could not create device class (err %d)\n", -ret);
 		unregister_chrdev_region(qib_dev, QIB_NMINORS);
 	}
@@ -2338,10 +2339,8 @@ int __init qib_dev_init(void)
 
 void qib_dev_cleanup(void)
 {
-	if (qib_class) {
-		class_destroy(qib_class);
-		qib_class = NULL;
-	}
+	if (class_is_registered(&qib_class))
+		class_unregister(&qib_class);
 
 	unregister_chrdev_region(qib_dev, QIB_NMINORS);
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b32941dd67cb..b6ee801fd0ff 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -45,7 +45,9 @@ static struct rtrs_rdma_dev_pd dev_pd = {
 };
 
 static struct workqueue_struct *rtrs_wq;
-static struct class *rtrs_clt_dev_class;
+static const struct class rtrs_clt_dev_class = {
+	.name = "rtrs-client",
+};
 
 static inline bool rtrs_clt_is_connected(const struct rtrs_clt_sess *clt)
 {
@@ -2698,7 +2700,7 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	clt->dev.class = rtrs_clt_dev_class;
+	clt->dev.class = &rtrs_clt_dev_class;
 	clt->dev.release = rtrs_clt_dev_release;
 	uuid_gen(&clt->paths_uuid);
 	INIT_LIST_HEAD_RCU(&clt->paths_list);
@@ -3151,16 +3153,17 @@ static const struct rtrs_rdma_dev_pd_ops dev_pd_ops = {
 
 static int __init rtrs_client_init(void)
 {
-	rtrs_rdma_dev_pd_init(0, &dev_pd);
+	int ret = 0;
 
-	rtrs_clt_dev_class = class_create("rtrs-client");
-	if (IS_ERR(rtrs_clt_dev_class)) {
+	rtrs_rdma_dev_pd_init(0, &dev_pd);
+	ret = class_register(&rtrs_clt_dev_class);
+	if (ret) {
 		pr_err("Failed to create rtrs-client dev class\n");
-		return PTR_ERR(rtrs_clt_dev_class);
+		return ret;
 	}
 	rtrs_wq = alloc_workqueue("rtrs_client_wq", 0, 0);
 	if (!rtrs_wq) {
-		class_destroy(rtrs_clt_dev_class);
+		class_unregister(&rtrs_clt_dev_class);
 		return -ENOMEM;
 	}
 
@@ -3170,7 +3173,7 @@ static int __init rtrs_client_init(void)
 static void __exit rtrs_client_exit(void)
 {
 	destroy_workqueue(rtrs_wq);
-	class_destroy(rtrs_clt_dev_class);
+	class_unregister(&rtrs_clt_dev_class);
 	rtrs_rdma_dev_pd_deinit(&dev_pd);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 5adba0f754b6..3f305e694fe8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -164,7 +164,7 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_pat
 		 */
 		goto unlock;
 	}
-	srv->dev.class = rtrs_dev_class;
+	srv->dev.class = &rtrs_dev_class;
 	err = dev_set_name(&srv->dev, "%s", srv_path->s.sessname);
 	if (err)
 		goto unlock;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index c38901e2c8f4..75e56604e462 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -27,7 +27,9 @@ MODULE_LICENSE("GPL");
 #define MAX_HDR_SIZE PAGE_SIZE
 
 static struct rtrs_rdma_dev_pd dev_pd;
-struct class *rtrs_dev_class;
+const struct class rtrs_dev_class = {
+	.name = "rtrs-server",
+};
 static struct rtrs_srv_ib_ctx ib_ctx;
 
 static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
@@ -2253,11 +2255,10 @@ static int __init rtrs_server_init(void)
 		       err);
 		return err;
 	}
-	rtrs_dev_class = class_create("rtrs-server");
-	if (IS_ERR(rtrs_dev_class)) {
-		err = PTR_ERR(rtrs_dev_class);
+	err = class_register(&rtrs_dev_class);
+	if (err)
 		goto out_err;
-	}
+
 	rtrs_wq = alloc_workqueue("rtrs_server_wq", 0, 0);
 	if (!rtrs_wq) {
 		err = -ENOMEM;
@@ -2267,7 +2268,7 @@ static int __init rtrs_server_init(void)
 	return 0;
 
 out_dev_class:
-	class_destroy(rtrs_dev_class);
+	class_unregister(&rtrs_dev_class);
 out_err:
 	return err;
 }
@@ -2275,7 +2276,7 @@ static int __init rtrs_server_init(void)
 static void __exit rtrs_server_exit(void)
 {
 	destroy_workqueue(rtrs_wq);
-	class_destroy(rtrs_dev_class);
+	class_unregister(&rtrs_dev_class);
 	rtrs_rdma_dev_pd_deinit(&dev_pd);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 2f8a638e36fa..5e325b82ff33 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -129,7 +129,7 @@ struct rtrs_srv_ib_ctx {
 	int			ib_dev_count;
 };
 
-extern struct class *rtrs_dev_class;
+extern const struct class rtrs_dev_class;
 
 void close_path(struct rtrs_srv_path *srv_path);
 
-- 
2.41.0

