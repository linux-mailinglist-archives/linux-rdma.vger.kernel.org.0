Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291D2450CA
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFNAiY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:38:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36137 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfFNAiY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:38:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so609382qtl.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5+MuWMmqvvi4WZWb5MbkQ/yvubQXuul1IxMKkOhuYI=;
        b=Z3xhuFKdLX+CVud4yh3kRqXUKUwaHRPlFKfCEYLpHk+NyxVxQ3OIwMBzjDtD+1h7Oj
         H9dxAhsUU9n82AbKOWC7jsuE8a529yrw4Lx22JyF0F7h8BPkTcwMiQC389dzXN+zOIB1
         X87o9/+8ptx/jP6otRyuVBGItrY9XMWh0WScgX3UUonxcFclHGrvkxta06fMfBPHTV1M
         rh+MING+VSrqWbMyMpwsLZDcNS0Vl8CLG2720pc7V1Y07bbDBbvrjtmiKaE2k47s4ExI
         L/t46xxzqcIEdXN2/6YAT30PHF1Adi//rRHKmRP4ULle7d1lX57URPX6euTMvsH/kidk
         TbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5+MuWMmqvvi4WZWb5MbkQ/yvubQXuul1IxMKkOhuYI=;
        b=WKr2SnbzlEjeNSt9XWUrQ0lq9dpfIhaw9u+wXjHTJL+Mx19flApI1EEUMLqMXDLkE8
         qZSbLyLx6kUwZ/jsdhr5bpQ092ezpcgZj8UyuVg9Psl9s+5CvT3WXUevobw6CSzgjD2D
         biHa2R9ay438E/EqlFkS/IGErla4iblpwqWrCMGuymy6SNF/xwVdaxxgbDx2FWaRSPO9
         MZYl9D5HTEWJnuiLlduiUU5vVa0DC+PsAyRDwBWGUJv/z/06pKMRMEgkpU1mIrFz7/2C
         2Md14UZnkXRNKaX+7wocygn0cy1Fo6PWUAeT6OlD8gjkw9YmGYPHNqbD40fLZi84E7/0
         LXKg==
X-Gm-Message-State: APjAAAWf5budOkD4S4Zq1OYj/4Vdv4TSr3M+ZxDQDl7PRjEBSq4oNUi4
        nfUBZyk+icn2498L3ObwakeA89+4rrZR8g==
X-Google-Smtp-Source: APXvYqwgrIC3SpVW/vYMuf/oI+ZLDoADLg//8IzvFuEuH27lQvdREkg5+lj0odcMqsnZxn0gwCbNxQ==
X-Received: by 2002:a0c:8927:: with SMTP id 36mr6091324qvp.131.1560472703036;
        Thu, 13 Jun 2019 17:38:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e66sm539194qtb.55.2019.06.13.17.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:38:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaEX-0005EC-3p; Thu, 13 Jun 2019 21:38:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH v2 3/3] RDMA: Report available cdevs through RDMA_NLDEV_CMD_GET_CHARDEV
Date:   Thu, 13 Jun 2019 21:38:19 -0300
Message-Id: <20190614003819.19974-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614003819.19974-1-jgg@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Update the struct ib_client for all modules exporting cdevs related to the
ibdevice to also implement RDMA_NLDEV_CMD_GET_CHARDEV. All cdevs are now
autoloadable and discoverable by userspace over netlink instead of relying
on sysfs.

uverbs also exposes the DRIVER_ID for drivers that are able to support
driver id binding in rdma-core.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c             |  3 ++
 drivers/infiniband/core/ucma.c               | 23 +++++++++
 drivers/infiniband/core/user_mad.c           | 51 ++++++++++++++++++--
 drivers/infiniband/core/uverbs_main.c        | 32 +++++++++++-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c    |  1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |  1 +
 include/rdma/ib_verbs.h                      |  1 +
 include/uapi/rdma/rdma_netlink.h             |  1 +
 9 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7db8566cdb8904..1de4ae5d5e0ef6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2428,6 +2428,9 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	if (ops->uverbs_abi_ver)
 		dev_ops->uverbs_abi_ver = ops->uverbs_abi_ver;
 
+	dev_ops->uverbs_no_driver_id_binding |=
+		ops->uverbs_no_driver_id_binding;
+
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, advise_mr);
 	SET_DEVICE_OP(dev_ops, alloc_dm);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 39823c842202db..0274e9b704be59 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -52,6 +52,8 @@
 #include <rdma/rdma_cm_ib.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib.h>
+#include <rdma/rdma_netlink.h>
+#include "core_priv.h"
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("RDMA Userspace Connection Manager Access");
@@ -1788,6 +1790,19 @@ static struct miscdevice ucma_misc = {
 	.fops		= &ucma_fops,
 };
 
+static int ucma_get_global_nl_info(struct ib_client_nl_info *res)
+{
+	res->abi = RDMA_USER_CM_ABI_VERSION;
+	res->cdev = ucma_misc.this_device;
+	return 0;
+}
+
+static struct ib_client rdma_cma_client = {
+	.name = "rdma_cm",
+	.get_global_nl_info = ucma_get_global_nl_info,
+};
+MODULE_ALIAS_RDMA_CLIENT("rdma_cm");
+
 static ssize_t show_abi_version(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -1816,7 +1831,14 @@ static int __init ucma_init(void)
 		ret = -ENOMEM;
 		goto err2;
 	}
+
+	ret = ib_register_client(&rdma_cma_client);
+	if (ret)
+		goto err3;
+
 	return 0;
+err3:
+	unregister_net_sysctl_table(ucma_ctl_table_hdr);
 err2:
 	device_remove_file(ucma_misc.this_device, &dev_attr_abi_version);
 err1:
@@ -1826,6 +1848,7 @@ static int __init ucma_init(void)
 
 static void __exit ucma_cleanup(void)
 {
+	ib_unregister_client(&rdma_cma_client);
 	unregister_net_sysctl_table(ucma_ctl_table_hdr);
 	device_remove_file(ucma_misc.this_device, &dev_attr_abi_version);
 	misc_deregister(&ucma_misc);
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 671f07ba1fad66..547090b41cfbb7 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -54,6 +54,7 @@
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_user_mad.h>
+#include <rdma/rdma_netlink.h>
 
 #include "core_priv.h"
 
@@ -1124,11 +1125,48 @@ static const struct file_operations umad_sm_fops = {
 	.llseek	 = no_llseek,
 };
 
+static int ib_umad_get_nl_info(struct ib_device *ibdev, void *client_data,
+			       struct ib_client_nl_info *res)
+{
+	struct ib_umad_device *umad_dev = client_data;
+
+	if (!rdma_is_port_valid(ibdev, res->port))
+		return -EINVAL;
+
+	res->abi = IB_USER_MAD_ABI_VERSION;
+	res->cdev = &umad_dev->ports[res->port - rdma_start_port(ibdev)].dev;
+
+	return 0;
+}
+
 static struct ib_client umad_client = {
 	.name   = "umad",
 	.add    = ib_umad_add_one,
-	.remove = ib_umad_remove_one
+	.remove = ib_umad_remove_one,
+	.get_nl_info = ib_umad_get_nl_info,
 };
+MODULE_ALIAS_RDMA_CLIENT("umad");
+
+static int ib_issm_get_nl_info(struct ib_device *ibdev, void *client_data,
+			       struct ib_client_nl_info *res)
+{
+	struct ib_umad_device *umad_dev =
+		ib_get_client_data(ibdev, &umad_client);
+
+	if (!rdma_is_port_valid(ibdev, res->port))
+		return -EINVAL;
+
+	res->abi = IB_USER_MAD_ABI_VERSION;
+	res->cdev = &umad_dev->ports[res->port - rdma_start_port(ibdev)].sm_dev;
+
+	return 0;
+}
+
+static struct ib_client issm_client = {
+	.name = "issm",
+	.get_nl_info = ib_issm_get_nl_info,
+};
+MODULE_ALIAS_RDMA_CLIENT("issm");
 
 static ssize_t ibdev_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -1387,13 +1425,17 @@ static int __init ib_umad_init(void)
 	}
 
 	ret = ib_register_client(&umad_client);
-	if (ret) {
-		pr_err("couldn't register ib_umad client\n");
+	if (ret)
 		goto out_class;
-	}
+
+	ret = ib_register_client(&issm_client);
+	if (ret)
+		goto out_client;
 
 	return 0;
 
+out_client:
+	ib_unregister_client(&umad_client);
 out_class:
 	class_unregister(&umad_class);
 
@@ -1411,6 +1453,7 @@ static int __init ib_umad_init(void)
 
 static void __exit ib_umad_cleanup(void)
 {
+	ib_unregister_client(&issm_client);
 	ib_unregister_client(&umad_client);
 	class_unregister(&umad_class);
 	unregister_chrdev_region(base_umad_dev,
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 870b3dd35aac63..11c13c1381cf5c 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -51,6 +51,7 @@
 
 #include <rdma/ib.h>
 #include <rdma/uverbs_std_types.h>
+#include <rdma/rdma_netlink.h>
 
 #include "uverbs.h"
 #include "core_priv.h"
@@ -1148,12 +1149,41 @@ static const struct file_operations uverbs_mmap_fops = {
 	.compat_ioctl = ib_uverbs_ioctl,
 };
 
+static int ib_uverbs_get_nl_info(struct ib_device *ibdev, void *client_data,
+				 struct ib_client_nl_info *res)
+{
+	struct ib_uverbs_device *uverbs_dev = client_data;
+	int ret;
+
+	if (res->port != -1)
+		return -EINVAL;
+
+	res->abi = ibdev->ops.uverbs_abi_ver;
+	res->cdev = &uverbs_dev->dev;
+
+	/*
+	 * To support DRIVER_ID binding in userspace some of the driver need
+	 * upgrading to expose their PCI dependent revision information
+	 * through get_context instead of relying on modalias matching. When
+	 * the drivers are fixed they can drop this flag.
+	 */
+	if (!ibdev->ops.uverbs_no_driver_id_binding) {
+		ret = nla_put_u32(res->nl_msg, RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,
+				  ibdev->ops.driver_id);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static struct ib_client uverbs_client = {
 	.name   = "uverbs",
 	.no_kverbs_req = true,
 	.add    = ib_uverbs_add_one,
-	.remove = ib_uverbs_remove_one
+	.remove = ib_uverbs_remove_one,
+	.get_nl_info = ib_uverbs_get_nl_info,
 };
+MODULE_ALIAS_RDMA_CLIENT("uverbs");
 
 static ssize_t ibdev_show(struct device *device, struct device_attribute *attr,
 			  char *buf)
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index acba96f289cc06..810fa96af2e9fd 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1230,6 +1230,7 @@ static const struct ib_device_ops iwch_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_CXGB3,
 	.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION,
+	.uverbs_no_driver_id_binding = 1,
 
 	.alloc_hw_stats	= iwch_alloc_stats,
 	.alloc_mr = iwch_alloc_mr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 3e45b119b0eba7..c0e819ed8c9be9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -417,6 +417,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HNS,
 	.uverbs_abi_ver = 1,
+	.uverbs_no_driver_id_binding = 1,
 
 	.add_gid = hns_roce_add_gid,
 	.alloc_pd = hns_roce_alloc_pd,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index efd4e3d13ae22c..d97124bee703d7 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1147,6 +1147,7 @@ static const struct ib_device_ops mthca_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MTHCA,
 	.uverbs_abi_ver = MTHCA_UVERBS_ABI_VERSION,
+	.uverbs_no_driver_id_binding = 1,
 
 	.alloc_pd = mthca_alloc_pd,
 	.alloc_ucontext = mthca_alloc_ucontext,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1265e9ce2d11f..6f09fcc21d7a41 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2321,6 +2321,7 @@ struct ib_device_ops {
 	struct module *owner;
 	enum rdma_driver_id driver_id;
 	u32 uverbs_abi_ver;
+	unsigned int uverbs_no_driver_id_binding:1;
 
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 			 const struct ib_send_wr **bad_send_wr);
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 9903db21a42c58..b27c02185dcc19 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -504,6 +504,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
 	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
 	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
+	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */
 
 	/*
 	 * Always the end
-- 
2.21.0

