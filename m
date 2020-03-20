Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0BA18CDBC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCTMRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgCTMRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so6259771wmk.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWYVguxunQdebWrL1qmXzLqFVxg5PNnLmnX2OSEzxOo=;
        b=SeWx41Z3LgncZ/5MXOT38MhYn3RS8XMC6bsBqF3HEmsPVuWiFWMxGljlshIppG1nT9
         OaqlDWENVlLh5kaXAdPOLMZ3J9yn2kxWkI9jPjuC1pLVSxoQgeMv6bTN7FA6HeD2xB5R
         XLtFNAGKGYdydoDcjKizWnSHK3UEPbAUcXB7JH+2tsI2RzBQlYdkM5rKmg4jxeo6HMvO
         io2QPmxXQzUhpo7bFQdMOKFz/R8+EIehyqTzfYs3kepllv+VawyOHUrnKbSUvTi8+3xe
         UFEWkyYemGqfLZ+M7DB0lqdjhlO0z9N7KZkbjCRop5MCqv4g62UwXIkIb2LCBWUkhCpT
         oSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWYVguxunQdebWrL1qmXzLqFVxg5PNnLmnX2OSEzxOo=;
        b=CKFLcH0DAVyRfQbrumFNsfZYJt5SfNISyP7K/QIq47Ersvl1TssBJHy9wAtXN4qcbs
         HQUe08KkzeEqkVgdC7DwXKczkIZTRoSY2IzJbaAffr9ILhfY/mK6HJ2BgVZmsrhdSifF
         gnoSSosQFY5PAbjkc++/JNXiDu9RJ5zVMXasU8HkBlOz3+NkPiHPE3bDE+Rqk46Hjw1m
         +0FnbfH6veiJsCp8iHfl2oZl6HRDEPqc7hrsZNPw4Xo4uJuBIsRtvAM1xVeP6o7EgCri
         gXzt9/eFdcS9lUC6yZep3xbf89/GE2H4RnZh2YUcNRyDDBZ7JLo3T8/JlD6UA8PX0v0T
         5MkQ==
X-Gm-Message-State: ANhLgQ3ROV3lyJH1yNUUAM3m2Cvs7JeWUpKRIPziR4aw7OfMdQt3sfLM
        e/MZ99BsEEI6oDckSJdYVm0Mjg==
X-Google-Smtp-Source: ADFU+vsEzGxMAtPoogWeoJyVMPdIihNk1xvZr8IaUBNAgTIIsY7kieuyjLDXLV8ysligeNAFS+TG7Q==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr9893248wmc.30.1584706656522;
        Fri, 20 Mar 2020 05:17:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:36 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 23/26] block/rnbd: server: sysfs interface functions
Date:   Fri, 20 Mar 2020 13:16:54 +0100
Message-Id: <20200320121657.1165-24-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the sysfs interface to rnbd mapped devices on server side:

  /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
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
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 211 ++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
new file mode 100644
index 000000000000..15dff4ede37e
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -0,0 +1,211 @@
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
+static struct kobj_type ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
+			       struct block_device *bdev,
+			       const char *dir_name)
+{
+	struct kobject *bdev_kobj;
+	int ret;
+
+	ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
+				   rnbd_devs_kobj, dir_name);
+	if (ret)
+		return ret;
+
+	ret = kobject_init_and_add(&dev->dev_sessions_kobj,
+				   &ktype,
+				   &dev->dev_kobj, "sessions");
+	if (ret)
+		goto err;
+
+	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
+	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
+	if (ret)
+		goto err2;
+
+	return 0;
+
+err2:
+	kobject_put(&dev->dev_sessions_kobj);
+err:
+	kobject_put(&dev->dev_kobj);
+	return ret;
+}
+
+void rnbd_srv_destroy_dev_sysfs(struct rnbd_srv_dev *dev)
+{
+	sysfs_remove_link(&dev->dev_kobj, "block_dev");
+	kobject_del(&dev->dev_sessions_kobj);
+	kobject_put(&dev->dev_sessions_kobj);
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
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 (sess_dev->open_flags & FMODE_WRITE) ? "0" : "1");
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
+	DECLARE_COMPLETION_ONSTACK(sysfs_compl);
+
+	sysfs_remove_group(&sess_dev->kobj,
+			   &rnbd_srv_default_dev_session_attr_group);
+
+	sess_dev->sysfs_release_compl = &sysfs_compl;
+	kobject_del(&sess_dev->kobj);
+	kobject_put(&sess_dev->kobj);
+	wait_for_completion(&sysfs_compl);
+}
+
+static void rnbd_srv_sess_dev_release(struct kobject *kobj)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
+	if (sess_dev->sysfs_release_compl)
+		complete_all(sess_dev->sysfs_release_compl);
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
+				   &sess_dev->dev->dev_sessions_kobj, "%s",
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
2.17.1

