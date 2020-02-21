Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE53E167B44
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBUKrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgBUKrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so1760905edv.9;
        Fri, 21 Feb 2020 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q49D5wtmPkLEU9bMBMJ1eUv6mUGzSxHs0fHeSj8fZas=;
        b=X2AjA2vq5ZrSa6ZcA9cfkvcCzlW3c94W6onsvw41kALraW7kwreTMH/M7iaovBTY+R
         D88EDCvm4BPyfX68xLDod5NGISad3Et+I0BYsLHkssXaFk6+ZZiNewfoUhYM+PFCXjqY
         pDXQAPDVEkFf6eC5Rkxb9GjHlza/Bof4io35nT2HJBm3F0KoWItD7+JArJc+lRH5v85h
         O3m5hpYbe6w4K6z0G1WX4sQIoZ2QL/saaeDffwcBb7sPR9IKBGMUcKIk3BcfpNzWxiDl
         RhvH9tZlaGluf6SCydX/tNPksQnMMOkwJIGgaLqcackq0zNY8RkqIhJO96LoENWQT7VT
         oFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q49D5wtmPkLEU9bMBMJ1eUv6mUGzSxHs0fHeSj8fZas=;
        b=umHEWcgM0SCz7V78tQD0wR0lky5TvvD5uXH1J0ajXQkK84MQCq6v1Nn0k9MSmnRbEP
         RjgVxKO+rX1Jp4b7U9dNUckdNPJYAvq1QiywS1tEyWg65ngf1XwqWg/z5hjO0xiqMgrp
         lCNrhO36+V/8ODT9wLtSMJ31oHww/fl5SDUqnN2Z8Wsd61cQak5pYF9jVsMJmxwOZ+Hk
         AYTmOz6BwBN/O7e7CALZuQGkn+jBKF4S6VShldhFZuWEKqcvtqokaPhV+HbJ6VHKggh+
         cGIYhN/98LWReZBjFxOjZ07PDc7fHQct84zGJpwlsIGnvaBQWPzlRvcuRPMjkmw7J1/E
         75NA==
X-Gm-Message-State: APjAAAV8AwY2LO5S9j0g5nHcKiSyxiUrTinouLuNpiGDjPZTFmqxcxXF
        k25OMkWvNT3yPjyIJdxaZRYGmIxv
X-Google-Smtp-Source: APXvYqxuLA9lYQminqThNS3DNcthRScmBMEprilGIT6Gn/w0U4vLcfxCilqA0nJ66tO9Gv2OmJkJAA==
X-Received: by 2002:aa7:d055:: with SMTP id n21mr13915111edo.312.1582282066667;
        Fri, 21 Feb 2020 02:47:46 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:46 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 22/25] block/rnbd: server: sysfs interface functions
Date:   Fri, 21 Feb 2020 11:47:18 +0100
Message-Id: <20200221104721.350-23-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

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

