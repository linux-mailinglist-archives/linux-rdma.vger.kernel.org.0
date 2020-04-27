Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727921BA5E4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgD0OLl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgD0OLk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 10:11:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB6C0610D5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so19727992wmc.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkffJNStOBvRAiOGwO+3XR0/SnMIarXv0c30avQ1rKg=;
        b=BExPtTmvDKE2vJjFpK6nUJUxMhP9NEld3l8DJ0tTZFaN6uKyhtXC0mrluDzKSkBYIp
         0xn2/yrni54XpppAModtf7uD0ryIPCvlFYUX30ZC7QTyi1WSQ3aaoId+j+7Q5AaNkrfJ
         WY2lPGZPEKCNoToTqy4T4RwT7SU2L0O1TgtDEoOegwQzr9WSKmFnpUY3mBWDxlK7IADB
         ng7PyQE8j5s0aoC12asfn6VwWCcsfJh9ESNsNkrjXmpxnT4rOO7pLbRFeQNRBaXm4KhQ
         g/hK7XGM92aRqAT5Rp6t4TD/0diNza0w5BR1FYOIF4xt8Maytb42nxAhkM/GsJC1lYvM
         3Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkffJNStOBvRAiOGwO+3XR0/SnMIarXv0c30avQ1rKg=;
        b=FmYddvPKuMgt8DDZ4oO8IyY2ytosqQf6HpCi9oD1cDoTuKRnzY87pI0yK5nndF3+IQ
         w7bxQ13Tqb3N3lzveYvg8Dd/Nt5kq+j8zIyhog1WYuYimImfeaz7W8oopV1zqMMycVao
         Op4ikehVBtlWHCdHM8GytEJfvbCQaYgXnloSLhPirfo2sp7/PuS8on8sH5IfnNtSVcWb
         f28uJtuR0709atzfBXawkYFmFi8Q7lLWMdSvKzDRit97kTGamrwX0a6yqEypnB1ppcVR
         DxKR21mgdqKuU3uho1whfSERAz6bJk7lkVzrrDX5IFEiW21knXWsubrgm3tQhBfMk7mO
         3KtQ==
X-Gm-Message-State: AGi0PuZ4kAu75qd1ncXgSYxaIE6RJtMnTlkAljUjG0cQBxQcK0hfDSvs
        dRFh4dEcn/RrQx5kcaHflToA
X-Google-Smtp-Source: APiQypJj8RyyricEoxmjzeEAw45GVhWrcysbS8gtKTLjtaQqdThAVXIL0IcoXl0RmUF3JaSCWd04Ug==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr25780035wmh.29.1587996699337;
        Mon, 27 Apr 2020 07:11:39 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:38 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 22/25] block/rnbd: server: sysfs interface functions
Date:   Mon, 27 Apr 2020 16:10:17 +0200
Message-Id: <20200427141020.655-23-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rnbd mapped devices on server side:

  /sys/class/rnbd-server/ctl/devices/<device_name>/
    |- block_dev
    |  *** link pointing to the corresponding block device sysfs entry
    |
    |- sessions/<session-name>/
    |  *** sessions directory
       |
       |- read_only
       |  *** is devices mapped as read only
       |
       |- mapping_path
          *** relative device path provided by the client during mapping

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 215 ++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
new file mode 100644
index 000000000000..106775c074d1
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <uapi/linux/limits.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/stat.h>
+#include <linux/genhd.h>
+#include <linux/list.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+
+#include "rnbd-srv.h"
+
+static struct device *rnbd_dev;
+static struct class *rnbd_dev_class;
+static struct kobject *rnbd_devs_kobj;
+
+static void rnbd_srv_dev_release(struct kobject *kobj)
+{
+	struct rnbd_srv_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_srv_dev, dev_kobj);
+
+	kfree(dev);
+}
+
+static struct kobj_type dev_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = rnbd_srv_dev_release
+};
+
+int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
+			       struct block_device *bdev,
+			       const char *dev_name)
+{
+	struct kobject *bdev_kobj;
+	int ret;
+
+	ret = kobject_init_and_add(&dev->dev_kobj, &dev_ktype,
+				   rnbd_devs_kobj, dev_name);
+	if (ret)
+		return ret;
+
+	dev->dev_sessions_kobj = kobject_create_and_add("sessions",
+							&dev->dev_kobj);
+	if (!dev->dev_sessions_kobj)
+		goto put_dev_kobj;
+
+	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
+	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
+	if (ret)
+		goto put_sess_kobj;
+
+	return 0;
+
+put_sess_kobj:
+	kobject_put(dev->dev_sessions_kobj);
+put_dev_kobj:
+	kobject_put(&dev->dev_kobj);
+	return ret;
+}
+
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev)
+{
+	sysfs_remove_link(&dev->dev_kobj, "block_dev");
+	kobject_del(dev->dev_sessions_kobj);
+	kobject_put(dev->dev_sessions_kobj);
+	kobject_del(&dev->dev_kobj);
+	kobject_put(&dev->dev_kobj);
+}
+
+static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *page)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%d\n",
+			 !(sess_dev->open_flags & FMODE_WRITE));
+}
+
+static struct kobj_attribute rnbd_srv_dev_session_ro_attr =
+	__ATTR_RO(read_only);
+
+static ssize_t access_mode_show(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				char *page)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 rnbd_access_mode_str(sess_dev->access_mode));
+}
+
+static struct kobj_attribute rnbd_srv_dev_session_access_mode_attr =
+	__ATTR_RO(access_mode);
+
+static ssize_t mapping_path_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", sess_dev->pathname);
+}
+
+static struct kobj_attribute rnbd_srv_dev_session_mapping_path_attr =
+	__ATTR_RO(mapping_path);
+
+static struct attribute *rnbd_srv_default_dev_sessions_attrs[] = {
+	&rnbd_srv_dev_session_access_mode_attr.attr,
+	&rnbd_srv_dev_session_ro_attr.attr,
+	&rnbd_srv_dev_session_mapping_path_attr.attr,
+	NULL,
+};
+
+static struct attribute_group rnbd_srv_default_dev_session_attr_group = {
+	.attrs = rnbd_srv_default_dev_sessions_attrs,
+};
+
+void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
+{
+	sysfs_remove_group(&sess_dev->kobj,
+			   &rnbd_srv_default_dev_session_attr_group);
+
+	kobject_del(&sess_dev->kobj);
+	kobject_put(&sess_dev->kobj);
+}
+
+static void rnbd_srv_sess_dev_release(struct kobject *kobj)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+	rnbd_destroy_sess_dev(sess_dev);
+}
+
+static struct kobj_type rnbd_srv_sess_dev_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= rnbd_srv_sess_dev_release,
+};
+
+int rnbd_srv_create_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&sess_dev->kobj, &rnbd_srv_sess_dev_ktype,
+				   sess_dev->dev->dev_sessions_kobj, "%s",
+				   sess_dev->sess->sessname);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&sess_dev->kobj,
+				 &rnbd_srv_default_dev_session_attr_group);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kobject_put(&sess_dev->kobj);
+
+	return ret;
+}
+
+int rnbd_srv_create_sysfs_files(void)
+{
+	int err;
+
+	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-server");
+	if (IS_ERR(rnbd_dev_class))
+		return PTR_ERR(rnbd_dev_class);
+
+	rnbd_dev = device_create(rnbd_dev_class, NULL,
+				  MKDEV(0, 0), NULL, "ctl");
+	if (IS_ERR(rnbd_dev)) {
+		err = PTR_ERR(rnbd_dev);
+		goto cls_destroy;
+	}
+	rnbd_devs_kobj = kobject_create_and_add("devices", &rnbd_dev->kobj);
+	if (!rnbd_devs_kobj) {
+		err = -ENOMEM;
+		goto dev_destroy;
+	}
+
+	return 0;
+
+dev_destroy:
+	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+cls_destroy:
+	class_destroy(rnbd_dev_class);
+
+	return err;
+}
+
+void rnbd_srv_destroy_sysfs_files(void)
+{
+	kobject_del(rnbd_devs_kobj);
+	kobject_put(rnbd_devs_kobj);
+	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+	class_destroy(rnbd_dev_class);
+}
-- 
2.20.1

