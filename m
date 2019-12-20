Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4921127FFA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfLTPvl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfLTPvk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so9741987wmb.0;
        Fri, 20 Dec 2019 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRcbpHCPxHtQd752MbT74D5jaFLaKOKJQNwjPW9bHVo=;
        b=kqKAJ1ZLhqQxiKflz0UM8V4crjpMfoYD3wvnEjacxgp+D+v8hkQVcfTGpAZPxS81kB
         9SYhJarnjQuZU6MyJ3YyN552kVIlL8jLG9kRfPaW/bk8wYxAz78DvBJJwpO2F1mZ5YoQ
         l6J9PLcQyrVg0StC/slhsu2B0+zCiuOPKJONzmG0dvcN02O5hEWCd+BNXaEEa8zMRKbS
         7uUbJPOpCsci9V2vaIeZUQ3N0aXcOys4KYpoEzs3IHwd5ezGPNkNFiKN9ukrXZU5hIHG
         lFtkHgy//Y8BSAuOTx965qiqmVTC188Ka5AqHvQK8LMFWsjbAQFnC0vgDH00m+eqjfdB
         NTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRcbpHCPxHtQd752MbT74D5jaFLaKOKJQNwjPW9bHVo=;
        b=W7PugdVVdjbMBDMtq51rW8DmDHHq0tko3dE8VhmsHlDhMQmzz36Dc9h0Z2VkNaE9vt
         aBDwT2CQW+vR/JaigNk829ssA8RnNo3/MiaYe4n474sOo+gAoQS/Q/Hbv6iCa5I6KSSX
         DDJB2CZhBPu1AyguY3WSaxBkhuhc7pLi4aI0JlOxy3XcwEsQaqdUiYkKCUYX0olaNvub
         HuDYGxMSGC2hjDDptYUmyYy8aGFzMXDsQplF7R61k0KfYvSPv7gqEzjmGDHcJW3y8gLW
         xT15YfzJb4iznn1sVCmaI8AFxtZ+XQQiUDu7ApJYuuOiulz4VA2BOqUO5PRtkYfSwG9h
         Lr6w==
X-Gm-Message-State: APjAAAVzbrKdaNlKXKWM8iWJ98LyB8i4OmhrLw8N5fMwkGLRx11jgTQZ
        FRFRWxXmswKYYRj0KLdBhbHLhoVYnR4=
X-Google-Smtp-Source: APXvYqyAlroFr0Op7OIp7LrThGyAfQk6JSUghw1DL9M/crW8uKiDZ+nvKfMirTOty7Z4Dc1zqj1ung==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr16772514wml.173.1576857096844;
        Fri, 20 Dec 2019 07:51:36 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:36 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 18/25] rnbd: client: sysfs interface functions
Date:   Fri, 20 Dec 2019 16:51:02 +0100
Message-Id: <20191220155109.8959-19-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rnbd block devices on client side:

  /sys/devices/virtual/rnbd-client/ctl/
    |- map_device
    |  *** maps remote device
    |
    |- devices/
       *** all mapped devices

  /sys/block/rnbd<N>/rnbd/
    |- unmap_device
    |  *** unmaps device
    |
    |- state
    |  *** device state
    |
    |- session
    |  *** session name
    |
    |- mapping_path
       *** path of the dev that was mapped on server

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 659 ++++++++++++++++++++++++++++
 1 file changed, 659 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
new file mode 100644
index 000000000000..91aecafdce61
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -0,0 +1,659 @@
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
+ *          Swapnil Ingle <swapnil.ingle@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/parser.h>
+#include <linux/module.h>
+#include <linux/in6.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/device.h>
+#include <rdma/ib.h>
+#include <rdma/rdma_cm.h>
+
+#include "rnbd-clt.h"
+
+static struct device *rnbd_dev;
+static struct class *rnbd_dev_class;
+static struct kobject *rnbd_devs_kobj;
+
+enum {
+	RNBD_OPT_ERR		= 0,
+	RNBD_OPT_PATH		= 1 << 0,
+	RNBD_OPT_DEV_PATH	= 1 << 1,
+	RNBD_OPT_ACCESS_MODE	= 1 << 3,
+	RNBD_OPT_SESSNAME	= 1 << 6,
+};
+
+static const unsigned int rnbd_opt_mandatory[] = {
+	RNBD_OPT_PATH,
+	RNBD_OPT_DEV_PATH,
+	RNBD_OPT_SESSNAME,
+};
+
+static const match_table_t rnbd_opt_tokens = {
+	{	RNBD_OPT_PATH,		"path=%s"		},
+	{	RNBD_OPT_DEV_PATH,	"device_path=%s"	},
+	{	RNBD_OPT_ACCESS_MODE,	"access_mode=%s"	},
+	{	RNBD_OPT_SESSNAME,	"sessname=%s"		},
+	{	RNBD_OPT_ERR,		NULL			},
+};
+
+/* remove new line from string */
+static void strip(char *s)
+{
+	char *p = s;
+
+	while (*s != '\0') {
+		if (*s != '\n')
+			*p++ = *s++;
+		else
+			++s;
+	}
+	*p = '\0';
+}
+
+struct rnbd_map_options {
+	char *sessname;
+	struct rtrs_addr *paths;
+	size_t *path_cnt;
+	char *pathname;
+	enum rnbd_access_mode *access_mode;
+};
+
+static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
+				       struct rnbd_map_options *opt)
+{
+	char *options, *sep_opt;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int opt_mask = 0;
+	int token;
+	int ret = -EINVAL;
+	int i;
+	int p_cnt = 0;
+
+	options = kstrdup(buf, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	sep_opt = strstrip(options);
+	strip(sep_opt);
+	while ((p = strsep(&sep_opt, " ")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, rnbd_opt_tokens, args);
+		opt_mask |= token;
+
+		switch (token) {
+		case RNBD_OPT_SESSNAME:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) > NAME_MAX) {
+				pr_err("map_device: sessname too long\n");
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+			strlcpy(opt->sessname, p, NAME_MAX);
+			kfree(p);
+			break;
+
+		case RNBD_OPT_PATH:
+			if (p_cnt >= max_path_cnt) {
+				pr_err("map_device: too many (> %zu) paths provided\n",
+				       max_path_cnt);
+				ret = -ENOMEM;
+				goto out;
+			}
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			ret = rtrs_addr_to_sockaddr(p, strlen(p), RTRS_PORT,
+						     &opt->paths[p_cnt]);
+			if (ret) {
+				pr_err("Can't parse path %s: %d\n", p, ret);
+				kfree(p);
+				goto out;
+			}
+
+			p_cnt++;
+
+			kfree(p);
+			break;
+
+		case RNBD_OPT_DEV_PATH:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) > NAME_MAX) {
+				pr_err("map_device: Device path too long\n");
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+			strlcpy(opt->pathname, p, NAME_MAX);
+			kfree(p);
+			break;
+
+		case RNBD_OPT_ACCESS_MODE:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			if (!strcmp(p, "ro")) {
+				*opt->access_mode = RNBD_ACCESS_RO;
+			} else if (!strcmp(p, "rw")) {
+				*opt->access_mode = RNBD_ACCESS_RW;
+			} else if (!strcmp(p, "migration")) {
+				*opt->access_mode = RNBD_ACCESS_MIGRATION;
+			} else {
+				pr_err("map_device: Invalid access_mode: '%s'\n",
+				       p);
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+
+			kfree(p);
+			break;
+
+		default:
+			pr_err("map_device: Unknown parameter or missing value '%s'\n",
+			       p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rnbd_opt_mandatory); i++) {
+		if ((opt_mask & rnbd_opt_mandatory[i])) {
+			ret = 0;
+		} else {
+			pr_err("map_device: Parameters missing\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+out:
+	*opt->path_cnt = p_cnt;
+	kfree(options);
+	return ret;
+}
+
+static ssize_t state_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	switch (dev->dev_state) {
+	case DEV_STATE_INIT:
+		return snprintf(page, PAGE_SIZE, "init\n");
+	case DEV_STATE_MAPPED:
+		/* TODO fix cli tool before changing to proper state */
+		return snprintf(page, PAGE_SIZE, "open\n");
+	case DEV_STATE_MAPPED_DISCONNECTED:
+		/* TODO fix cli tool before changing to proper state */
+		return snprintf(page, PAGE_SIZE, "closed\n");
+	case DEV_STATE_UNMAPPED:
+		return snprintf(page, PAGE_SIZE, "unmapped\n");
+	default:
+		return snprintf(page, PAGE_SIZE, "unknown\n");
+	}
+}
+
+static struct kobj_attribute rnbd_clt_state_attr = __ATTR_RO(state);
+
+static ssize_t mapping_path_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", dev->pathname);
+}
+
+static struct kobj_attribute rnbd_clt_mapping_path_attr =
+	__ATTR_RO(mapping_path);
+
+static ssize_t access_mode_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			rnbd_access_mode_str(dev->access_mode));
+}
+
+static struct kobj_attribute rnbd_clt_access_mode =
+	__ATTR_RO(access_mode);
+
+static ssize_t rnbd_clt_unmap_dev_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo <normal|force> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_unmap_dev_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	char *opt, *options;
+	bool force;
+	int err;
+
+	opt = kstrdup(buf, GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	options = strstrip(opt);
+	strip(options);
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	if (sysfs_streq(options, "normal")) {
+		force = false;
+	} else if (sysfs_streq(options, "force")) {
+		force = true;
+	} else {
+		rnbd_clt_err(dev,
+			      "unmap_device: Invalid value: %s\n",
+			      options);
+		err = -EINVAL;
+		goto out;
+	}
+
+	rnbd_clt_info(dev, "Unmapping device, option: %s.\n",
+		       force ? "force" : "normal");
+
+	/*
+	 * We take explicit module reference only for one reason: do not
+	 * race with lockless rnbd_destroy_sessions().
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		err = -ENODEV;
+		goto out;
+	}
+	err = rnbd_clt_unmap_device(dev, force, &attr->attr);
+	if (unlikely(err)) {
+		if (unlikely(err != -EALREADY))
+			rnbd_clt_err(dev, "unmap_device: %d\n",  err);
+		goto module_put;
+	}
+
+	/*
+	 * Here device can be vanished!
+	 */
+
+	err = count;
+
+module_put:
+	module_put(THIS_MODULE);
+out:
+	kfree(opt);
+
+	return err;
+}
+
+static struct kobj_attribute rnbd_clt_unmap_device_attr =
+	__ATTR(unmap_device, 0644, rnbd_clt_unmap_dev_show,
+	       rnbd_clt_unmap_dev_store);
+
+static ssize_t rnbd_clt_resize_dev_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE,
+			 "Usage: echo <new size in sectors> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int ret;
+	unsigned long sectors;
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	ret = kstrtoul(buf, 0, &sectors);
+	if (ret)
+		return ret;
+
+	ret = rnbd_clt_resize_disk(dev, (size_t)sectors);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute rnbd_clt_resize_dev_attr =
+	__ATTR(resize, 0644, rnbd_clt_resize_dev_show,
+	       rnbd_clt_resize_dev_store);
+
+static ssize_t rnbd_clt_remap_dev_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo <1> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rnbd_clt_remap_dev_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	char *opt, *options;
+	int err;
+
+	opt = kstrdup(buf, GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	options = strstrip(opt);
+	strip(options);
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+	if (!sysfs_streq(options, "1")) {
+		rnbd_clt_err(dev,
+			      "remap_device: Invalid value: %s\n",
+			      options);
+		err = -EINVAL;
+		goto out;
+	}
+	err = rnbd_clt_remap_device(dev);
+	if (likely(!err))
+		err = count;
+
+out:
+	kfree(opt);
+
+	return err;
+}
+
+static struct kobj_attribute rnbd_clt_remap_device_attr =
+	__ATTR(remap_device, 0644, rnbd_clt_remap_dev_show,
+	       rnbd_clt_remap_dev_store);
+
+static ssize_t session_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", dev->sess->sessname);
+}
+
+static struct kobj_attribute rnbd_clt_session_attr =
+	__ATTR_RO(session);
+
+static struct attribute *rnbd_dev_attrs[] = {
+	&rnbd_clt_unmap_device_attr.attr,
+	&rnbd_clt_resize_dev_attr.attr,
+	&rnbd_clt_remap_device_attr.attr,
+	&rnbd_clt_mapping_path_attr.attr,
+	&rnbd_clt_state_attr.attr,
+	&rnbd_clt_session_attr.attr,
+	&rnbd_clt_access_mode.attr,
+	NULL,
+};
+
+void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
+{
+	/*
+	 * The module_is_live() check is crucial and helps to avoid annoying
+	 * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
+	 * path was just removed, see rnbd_close_sessions().
+	 */
+	if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
+		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+}
+
+static struct kobj_type rnbd_dev_ktype = {
+	.sysfs_ops      = &kobj_sysfs_ops,
+	.default_attrs  = rnbd_dev_attrs,
+};
+
+static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
+{
+	int ret;
+	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
+
+	ret = kobject_init_and_add(&dev->kobj, &rnbd_dev_ktype, gd_kobj, "%s",
+				   "rnbd");
+	if (ret)
+		rnbd_clt_err(dev, "Failed to create device sysfs dir, err: %d\n",
+			      ret);
+
+	return ret;
+}
+
+static ssize_t rnbd_clt_map_device_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE,
+			 "Usage: echo \"sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
+			 attr->attr.name);
+}
+
+static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
+				   size_t len)
+{
+	int ret;
+	char pathname[NAME_MAX], *s;
+
+	strlcpy(pathname, dev->pathname, sizeof(pathname));
+	while ((s = strchr(pathname, '/')))
+		s[0] = '!';
+
+	ret = snprintf(buf, len, "%s", pathname);
+	if (ret >= len)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
+{
+	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
+	int ret;
+
+	ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
+				      sizeof(dev->blk_symlink_name));
+	if (ret) {
+		rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
+			      ret);
+		goto out_err;
+	}
+
+	ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
+				dev->blk_symlink_name);
+	if (ret) {
+		rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
+			      ret);
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	dev->blk_symlink_name[0] = '\0';
+	return ret;
+}
+
+static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct rnbd_clt_dev *dev;
+	struct rnbd_map_options opt;
+	int ret;
+	char pathname[NAME_MAX];
+	char sessname[NAME_MAX];
+	enum rnbd_access_mode access_mode = RNBD_ACCESS_RW;
+
+	struct sockaddr_storage *addrs;
+	struct rtrs_addr paths[6];
+	size_t path_cnt;
+
+	opt.sessname = sessname;
+	opt.paths = paths;
+	opt.path_cnt = &path_cnt;
+	opt.pathname = pathname;
+	opt.access_mode = &access_mode;
+	addrs = kcalloc(ARRAY_SIZE(paths) * 2, sizeof(*addrs), GFP_KERNEL);
+	if (!addrs)
+		return -ENOMEM;
+
+	for (path_cnt = 0; path_cnt < ARRAY_SIZE(paths); path_cnt++) {
+		paths[path_cnt].src = &addrs[path_cnt * 2];
+		paths[path_cnt].dst = &addrs[path_cnt * 2 + 1];
+	}
+
+	ret = rnbd_clt_parse_map_options(buf, ARRAY_SIZE(paths), &opt);
+	if (ret)
+		goto out;
+
+	pr_info("Mapping device %s on session %s, (access_mode: %s)\n",
+		pathname, sessname,
+		rnbd_access_mode_str(access_mode));
+
+	dev = rnbd_clt_map_device(sessname, paths, path_cnt, pathname,
+				   access_mode);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out;
+	}
+
+	ret = rnbd_clt_add_dev_kobj(dev);
+	if (unlikely(ret))
+		goto unmap_dev;
+
+	ret = rnbd_clt_add_dev_symlink(dev);
+	if (ret)
+		goto unmap_dev;
+
+	kfree(addrs);
+	return count;
+
+unmap_dev:
+	rnbd_clt_unmap_device(dev, true, NULL);
+out:
+	kfree(addrs);
+	return ret;
+}
+
+static struct kobj_attribute rnbd_clt_map_device_attr =
+	__ATTR(map_device, 0644,
+	       rnbd_clt_map_device_show, rnbd_clt_map_device_store);
+
+static struct attribute *default_attrs[] = {
+	&rnbd_clt_map_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group default_attr_group = {
+	.attrs = default_attrs,
+};
+
+static const struct attribute_group *default_attr_groups[] = {
+	&default_attr_group,
+	NULL,
+};
+
+int rnbd_clt_create_sysfs_files(void)
+{
+	int err;
+
+	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-client");
+	if (IS_ERR(rnbd_dev_class))
+		return PTR_ERR(rnbd_dev_class);
+
+	rnbd_dev = device_create_with_groups(rnbd_dev_class, NULL,
+					      MKDEV(0, 0), NULL,
+					      default_attr_groups, "ctl");
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
+void rnbd_clt_destroy_default_group(void)
+{
+	sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
+}
+
+void rnbd_clt_destroy_sysfs_files(void)
+{
+	kobject_del(rnbd_devs_kobj);
+	kobject_put(rnbd_devs_kobj);
+	device_destroy(rnbd_dev_class, MKDEV(0, 0));
+	class_destroy(rnbd_dev_class);
+}
-- 
2.17.1

