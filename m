Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E532C12CEE5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfL3KaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46406 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfL3KaL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so32177965edi.13;
        Mon, 30 Dec 2019 02:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZa2bj/+htcNbMNrqbimU6vzq/MqaghjVfdFooZ4/tw=;
        b=vSzZ+1Brhz2Cg3crgfBCkfiuq/odT8XtUHNtvS/uUljPTikA/iPWA7Kv54IPUch9vS
         kCvP2Zm8FW5AfYpDjEhkUD5ME8cImtna94BnhpVm3AAVHpFzWUHaUS3cBCxN8+ujwltc
         Cep1RA76o/GCubRj9Aolw2teZpp83VH71y47bTxH6xIhgOuchZISIFk5ohPp5dF0Qo6T
         PKFZsMNpYqpE2q9YU65abtv88ozVMx5i97n7x2iXnqbDN8EkjvU4DqLjeD666zbrM7tw
         W49OIrVgWzJsxRe4f9SP9f7rYO8IFuPxG2U+P822ghMavFxZss5+4XLpgxPRZYU9mP/y
         PAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oZa2bj/+htcNbMNrqbimU6vzq/MqaghjVfdFooZ4/tw=;
        b=CSd2E2JrhOq9FO/Nrtx2bb43Li4DonyNwbYArAUXorJQF9GWYLPKxrRMLqfItjQQJj
         1HVzENatXqy5RIMuFoUybM6aE1/EtIgFafrajnSHRpsZTK6MZs5inyrWqp2w660fgQlP
         Uu8ceOaxIJtkiTzirlHcDgQMj8NusJd3DAyL9t6hn4P0ePrAL6/MwK2wUWHAeP5Ozhjn
         ZWoJJRmwl1ULogiyWXnAUZf2iGNdm0K7K0dzzesRcIDUI58xCBdDZB3buitKSrqcVOoc
         +GBak4SQQusgGZ0SCH7IgioXDZsXZU4AW5qeo8XFJFYp5JHXAbGV1D1pInWFpT+lJ/mT
         1Saw==
X-Gm-Message-State: APjAAAUSFrnbIADo4aFWqmCiEAYFLx9WAnJtAu+npT+w8AtL3vIdKlTN
        zNMdH5PEyoAA6B9uoKO2e6OwUNpV
X-Google-Smtp-Source: APXvYqykykUPeHEbqwNJ+TML9FxodVIDVcyH7dwxz4JcIpdaaixx7Cu62O3uuZHiDSqgc3RwDw9KCA==
X-Received: by 2002:aa7:c74f:: with SMTP id c15mr71250684eds.304.1577701808864;
        Mon, 30 Dec 2019 02:30:08 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:08 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 22/25] rnbd: server: sysfs interface functions
Date:   Mon, 30 Dec 2019 11:29:39 +0100
Message-Id: <20191230102942.18395-23-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
 drivers/block/rnbd/rnbd-srv-sysfs.c | 213 ++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
new file mode 100644
index 000000000000..31d0ff520b3b
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
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
+	if (unlikely(!rnbd_devs_kobj)) {
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

