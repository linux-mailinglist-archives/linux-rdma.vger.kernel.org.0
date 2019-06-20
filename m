Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0E4D17A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTPEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43250 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbfFTPEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so5134438edr.10;
        Thu, 20 Jun 2019 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shzL9IkYidg8upIuiSIY+WOqsjZAZ9RY3XPXw5DHcXg=;
        b=NntFg8HKdfk0vlJA87yDnBg2dpvyBXOndPdKUK8AHjGQRhJYdPO/K0OvxtI2bI8R73
         X6/OrXwKtsJZjER6N10QMtzWWjOx/tI0DJT1M+N2jyX0KwxIzdhx0aeEgLWStEFngPC8
         Sz5B705hnLefEkL//OQJMTDaiBEwGQwi3I06AZITStdfocqKYtRtr4W6J9ebeWGcvbik
         4rkLsdrgGPj/m3irTi/ZMDeeJGIR/jluOPNK6PSMJ+6Q1dOi4Qtf9UmXSYdt4hRhzBxX
         CSEK6zbIUN+4L/h3bETPzgwYvm5wd2BG7AAQen7Tx6jWSzDlP+3ZJ2MmPdyIJT7Dz5k9
         rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shzL9IkYidg8upIuiSIY+WOqsjZAZ9RY3XPXw5DHcXg=;
        b=YSqlG9ct0ph8TdT2ylQxS8GRLE6bvsINUqBw9wgSwdn0NuB9qkgOGK9U6O1kfFgqT1
         PfMF9M0cm7H8onAfI++/h6kMUD9j0Kqh4Ag7ahyH6+BNXF39U7sP6bcqiWTKw6xMUStV
         vhqsJKR+bBxvDd4TDicf6EijbwUHXqChOSnHOJn8h8BYjf7wy4AdK7qFVQ+Tg9urH0Nh
         kT4eTrww6aB23cjARwOIwRxYcbnKIDb+gK/20bjpUdYuqBHxK1njj+yvmeFmWGJ/kHFR
         20/lz2gznvsFf36s2GG9zBarRmC+5Bw0wQUfhvVZnRab26fafrmhP3z+LmcZDWXf2Hvt
         MWbA==
X-Gm-Message-State: APjAAAXbgZXUuXzZizZJAK7YkvwWbDEGItbT/WIwJs2XzBeBLAljhRWa
        ErHVX52TDfl9jBQALuuyCnufCbo3BHU=
X-Google-Smtp-Source: APXvYqwvWCaB6riMSxCWBc3igSkUhm8yWvFgf0p0HDChj4kYOxi8AqOllm/4f0TLqzHdRG1DPKNQxw==
X-Received: by 2002:a50:bd83:: with SMTP id y3mr2462612edh.120.1561043047244;
        Thu, 20 Jun 2019 08:04:07 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:06 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 22/25] ibnbd: server: sysfs interface functions
Date:   Thu, 20 Jun 2019 17:03:34 +0200
Message-Id: <20190620150337.7847-23-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This is the sysfs interface to IBNBD mapped devices on server side:

  /sys/devices/virtual/ibnbd-server/ctl/devices/<device_name>/
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
 drivers/block/ibnbd/ibnbd-srv-sysfs.c | 270 ++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 drivers/block/ibnbd/ibnbd-srv-sysfs.c

diff --git a/drivers/block/ibnbd/ibnbd-srv-sysfs.c b/drivers/block/ibnbd/ibnbd-srv-sysfs.c
new file mode 100644
index 000000000000..2b40514950ed
--- /dev/null
+++ b/drivers/block/ibnbd/ibnbd-srv-sysfs.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
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
+#include "ibnbd-srv.h"
+
+static struct device *ibnbd_dev;
+static struct class *ibnbd_dev_class;
+static struct kobject *ibnbd_devs_kobj;
+
+static ssize_t ibnbd_srv_dev_mode_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibnbd_srv_dev *srv_dev;
+
+	srv_dev = container_of(kobj, struct ibnbd_srv_dev, dev_kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 ibnbd_io_mode_str(srv_dev->mode));
+}
+
+static struct kobj_attribute ibnbd_srv_dev_mode_attr =
+	__ATTR(io_mode, 0444, ibnbd_srv_dev_mode_show, NULL);
+
+static struct attribute *ibnbd_srv_default_dev_attrs[] = {
+	&ibnbd_srv_dev_mode_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ibnbd_srv_default_dev_attr_group = {
+	.attrs = ibnbd_srv_default_dev_attrs,
+};
+
+static struct kobj_type ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+int ibnbd_srv_create_dev_sysfs(struct ibnbd_srv_dev *dev,
+			       struct block_device *bdev,
+			       const char *dir_name)
+{
+	struct kobject *bdev_kobj;
+	int ret;
+
+	ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
+				   ibnbd_devs_kobj, dir_name);
+	if (ret)
+		return ret;
+
+	ret = kobject_init_and_add(&dev->dev_sessions_kobj,
+				   &ktype,
+				   &dev->dev_kobj, "sessions");
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_group(&dev->dev_kobj,
+				 &ibnbd_srv_default_dev_attr_group);
+	if (ret)
+		goto err2;
+
+	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
+	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
+	if (ret)
+		goto err3;
+
+	return 0;
+
+err3:
+	sysfs_remove_group(&dev->dev_kobj,
+			   &ibnbd_srv_default_dev_attr_group);
+err2:
+	kobject_del(&dev->dev_sessions_kobj);
+	kobject_put(&dev->dev_sessions_kobj);
+err:
+	kobject_del(&dev->dev_kobj);
+	kobject_put(&dev->dev_kobj);
+	return ret;
+}
+
+void ibnbd_srv_destroy_dev_sysfs(struct ibnbd_srv_dev *dev)
+{
+	sysfs_remove_link(&dev->dev_kobj, "block_dev");
+	sysfs_remove_group(&dev->dev_kobj, &ibnbd_srv_default_dev_attr_group);
+	kobject_del(&dev->dev_sessions_kobj);
+	kobject_put(&dev->dev_sessions_kobj);
+	kobject_del(&dev->dev_kobj);
+	kobject_put(&dev->dev_kobj);
+}
+
+static ssize_t ibnbd_srv_dev_session_ro_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     char *page)
+{
+	struct ibnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct ibnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 (sess_dev->open_flags & FMODE_WRITE) ? "0" : "1");
+}
+
+static struct kobj_attribute ibnbd_srv_dev_session_ro_attr =
+	__ATTR(read_only, 0444,
+	       ibnbd_srv_dev_session_ro_show,
+	       NULL);
+
+static ssize_t
+ibnbd_srv_dev_session_access_mode_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct ibnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 ibnbd_access_mode_str(sess_dev->access_mode));
+}
+
+static struct kobj_attribute ibnbd_srv_dev_session_access_mode_attr =
+	__ATTR(access_mode, 0444,
+	       ibnbd_srv_dev_session_access_mode_show,
+	       NULL);
+
+static ssize_t
+ibnbd_srv_dev_session_mapping_path_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	struct ibnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct ibnbd_srv_sess_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", sess_dev->pathname);
+}
+
+static struct kobj_attribute ibnbd_srv_dev_session_mapping_path_attr =
+	__ATTR(mapping_path, 0444,
+	       ibnbd_srv_dev_session_mapping_path_show,
+	       NULL);
+
+static struct attribute *ibnbd_srv_default_dev_sessions_attrs[] = {
+	&ibnbd_srv_dev_session_access_mode_attr.attr,
+	&ibnbd_srv_dev_session_ro_attr.attr,
+	&ibnbd_srv_dev_session_mapping_path_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ibnbd_srv_default_dev_session_attr_group = {
+	.attrs = ibnbd_srv_default_dev_sessions_attrs,
+};
+
+void ibnbd_srv_destroy_dev_session_sysfs(struct ibnbd_srv_sess_dev *sess_dev)
+{
+	DECLARE_COMPLETION_ONSTACK(sysfs_compl);
+
+	sysfs_remove_group(&sess_dev->kobj,
+			   &ibnbd_srv_default_dev_session_attr_group);
+
+	sess_dev->sysfs_release_compl = &sysfs_compl;
+	kobject_del(&sess_dev->kobj);
+	kobject_put(&sess_dev->kobj);
+	wait_for_completion(&sysfs_compl);
+}
+
+static void ibnbd_srv_sess_dev_release(struct kobject *kobj)
+{
+	struct ibnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kobj, struct ibnbd_srv_sess_dev, kobj);
+	if (sess_dev->sysfs_release_compl)
+		complete_all(sess_dev->sysfs_release_compl);
+}
+
+static struct kobj_type ibnbd_srv_sess_dev_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= ibnbd_srv_sess_dev_release,
+};
+
+int ibnbd_srv_create_dev_session_sysfs(struct ibnbd_srv_sess_dev *sess_dev)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&sess_dev->kobj, &ibnbd_srv_sess_dev_ktype,
+				   &sess_dev->dev->dev_sessions_kobj, "%s",
+				   sess_dev->sess->sessname);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&sess_dev->kobj,
+				 &ibnbd_srv_default_dev_session_attr_group);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kobject_del(&sess_dev->kobj);
+	kobject_put(&sess_dev->kobj);
+
+	return ret;
+}
+
+int ibnbd_srv_create_sysfs_files(void)
+{
+	int err;
+
+	ibnbd_dev_class = class_create(THIS_MODULE, "ibnbd-server");
+	if (unlikely(IS_ERR(ibnbd_dev_class)))
+		return PTR_ERR(ibnbd_dev_class);
+
+	ibnbd_dev = device_create(ibnbd_dev_class, NULL,
+				  MKDEV(0, 0), NULL, "ctl");
+	if (unlikely(IS_ERR(ibnbd_dev))) {
+		err = PTR_ERR(ibnbd_dev);
+		goto cls_destroy;
+	}
+	ibnbd_devs_kobj = kobject_create_and_add("devices", &ibnbd_dev->kobj);
+	if (unlikely(!ibnbd_devs_kobj)) {
+		err = -ENOMEM;
+		goto dev_destroy;
+	}
+
+	return 0;
+
+dev_destroy:
+	device_destroy(ibnbd_dev_class, MKDEV(0, 0));
+cls_destroy:
+	class_destroy(ibnbd_dev_class);
+
+	return err;
+}
+
+void ibnbd_srv_destroy_sysfs_files(void)
+{
+	kobject_del(ibnbd_devs_kobj);
+	kobject_put(ibnbd_devs_kobj);
+	device_destroy(ibnbd_dev_class, MKDEV(0, 0));
+	class_destroy(ibnbd_dev_class);
+}
-- 
2.17.1

