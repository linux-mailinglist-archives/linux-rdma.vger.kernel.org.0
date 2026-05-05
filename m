Return-Path: <linux-rdma+bounces-19999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBZRJKqh+Wn3+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:52:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D254C849D
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80444304039B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B73EFD09;
	Tue,  5 May 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iaouXt76"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8B3EAC90
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967261; cv=none; b=LAB3r1zdw7jshzq78LhkZ/EsNwdHLNjwnI/ewHIfIybVpyygYaFT6XhwlCBoaBBgus2FNe30swB6tH4PjrDSq5DVRKGG0hPc4vtpOhWKqiqDstBVIu+4y+LHy5fsVF0tBrO19oX6dJXYVoovo0SZNjBNri67Ot7gNKV0jyrBaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967261; c=relaxed/simple;
	bh=rq0+Z93obv5Grwn3XTm3Uy3Bjfophr5ZveAClvQUGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmmAubKKNmhmzHUps1CTdHbbJfVbm0EXAEj57GEMNHkkbhdreWiEiySQgIwq2y3Q8/PwFivahZl/ZHjCG7GFdwnpT+5CaL1wM75ePWLOmHplaBlVTJu2gTZ/KSDbPMdNQWE6mkCvo9cn3hsUiGw/3hRJbb6t8tqy1rf6sN++ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iaouXt76; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b150559bso33473935e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967257; x=1778572057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpmOvPSjAFgS0P/3F7aPn9za6o6h9Wu4IxiKRKRNKUY=;
        b=iaouXt766ZjYdl0TkOOT5T4G3s394wOzusH3PVVrH2yE60AdktCjFLLN3VLLhGkHe/
         FRFJ4YNnworfjcOmfXNNU7is6dNOPwHbRoe+caulK77Cfh1zzgkc8FgO1bvWCL+p1rsf
         xogMfmVo76z+Yq6dQxpY2G78letwol8WLLmBEmR7UERrKAzkfDtjrF7LjFKPgIHGOBTr
         qsM7HS6y8sopBCEe+++ppSdrcU6JWzjRTcJmqJbKyqZeZBqJ17aE5zmEvjlQlL6WptpY
         xaZhTnFTN64Vm9ZbEq9/Y4SRUb5E/CfE+yQdoon6zCiy7U+Ii8chPXZ0308XA7gLixbO
         P/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967257; x=1778572057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpmOvPSjAFgS0P/3F7aPn9za6o6h9Wu4IxiKRKRNKUY=;
        b=nF3wPNU7v3SurWwiAfbwsv4MxAxNS69laDRgfkzBdt6SYoJu75eEPrCPcDhErsBCZR
         X4QttgBf/1k8scaFr+QuPshhCuOv9qJCwge8l0nZu6/czZ0CmJAQ+WJxAuANX4VOKWCM
         XIEXVYJgOj2Jz0EvyuZnwHIFZy4Lq0+TfC+YN+TNOhUoxS7eznXI6bons9b0Xq9kC9ZG
         JcgiNeQ/1BVDOJhNxJ4XtyiUWEcIXMis45B4OljlKqBO8pL3u4B/cSaRqm5zSKBdnir8
         Tbiqx4666iUF21cM48xCGqKH/NiF7z2BG54mbzNh5Aj0RKkglYg3vfntwpV6yz+MnBO9
         vmxg==
X-Forwarded-Encrypted: i=1; AFNElJ/lubX0XbZnnWLQBgLbg2ArV9CkfqCANgmq+RrFLABIGt2LKU9yVic5/ZWkrRpofn7EV6csT6a19ttv@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKiM3cnA6OWJKpLiGdnQbe4xD5h8I3lYFq9t5F0O3ySuofazD
	bJhpUG4jbz7UWJu7YbFzTBYK25chiOpY3oiPFvAta6kMyJ+lrP1/OUOpqsZxER4cE7A=
X-Gm-Gg: AeBDieuEHGIWTcY0ks232bKybZkA0bq3FIgkdMh63pIn2b/pQxOzP8FbZoyEPgizNdW
	54t/FQAaN2UJvvaUiXHI/acunLy8L9VnRj/QL/GMPI8KWYlvTDizKLjFHiBDkU3kA5B/wJBgBnm
	b+P8Wux1YEFWbp27SyIOj5FLouWoa2DUMFtr1Dt+fDNOI595TQTVMOMSkmTNzbwbe7fjLR2RZDI
	QTRDy0ArQKrboqVoRuA9knmIrXHk+sD+mr571AeUjrF0pAyrGVrWC4o4jJdfagVOg1t1NVv+Knw
	PIaSYXJCnevSXx42GnbtZxgynvF+0oh8sQc4X9kaoM0acLOc/P6U112uAjzrAKbKt/luVfyQo9s
	7rBaYKFHQt1b5yI8dTJTLM7EY6z5jLd+48vz2ngIWtYpS/91EJrsiLXAw3yE5hXyddgAmpb5UE8
	ma4tLEErw/OvirdnYrp9/HT+ZOWFb9Ld8d+K3B4jYRv3gpPs92zlTJuwRBspdJTrWFzMAWPIJc4
	yE30FTQ43ux2i9eWmHlYqjesp8dZ3ACDPvVLqo39vXUqdbLqej/Ad6W
X-Received: by 2002:a05:600c:a118:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48a9865e188mr159801435e9.14.1777967257408;
        Tue, 05 May 2026 00:47:37 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:37 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jia Li <jia.li@ionos.com>
Subject: [PATCH 10/13] block/brmr: client: sysfs interface functions
Date: Tue,  5 May 2026 09:46:22 +0200
Message-ID: <20260505074644.195453-11-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62D254C849D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19999-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ionos.com:email,ionos.com:dkim,ionos.com:mid]

Add the BRMR client sysfs interface used to map and unmap remote
devices.  Writes to /sys/devices/virtual/brmr-client/ctl/map_device
trigger creation of a /dev/brmrN gendisk backed by the named RMR
pool; per-device attribute groups expose the device state and
statistics, and accept unmap requests.

This file is not compiled until the modules are wired into the
build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/block/brmr/brmr-clt-sysfs.c | 463 ++++++++++++++++++++++++++++
 1 file changed, 463 insertions(+)
 create mode 100644 drivers/block/brmr/brmr-clt-sysfs.c

diff --git a/drivers/block/brmr/brmr-clt-sysfs.c b/drivers/block/brmr/brmr-clt-sysfs.c
new file mode 100644
index 000000000000..7d2435acac6a
--- /dev/null
+++ b/drivers/block/brmr/brmr-clt-sysfs.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/parser.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/device.h>
+
+#include "brmr-clt.h"
+
+static struct device *brmr_dev;
+static struct class *brmr_dev_class;
+static struct kobject *brmr_devs_kobj;
+
+enum {
+	BRMR_OPT_ERR		= 0,
+	BRMR_OPT_POOL		= 1 << 1,
+	BRMR_OPT_SIZE		= 1 << 2,
+};
+
+static int brmr_clt_create_dev_sysfs_files(struct brmr_clt_dev *dev);
+static int brmr_add_dev_symlink(struct brmr_clt_dev *dev);
+
+static unsigned int brmr_opt_mandatory[] = {
+	BRMR_OPT_POOL,
+};
+
+static const match_table_t brmr_opt_tokens = {
+	{	BRMR_OPT_POOL,		"pool=%s"	},
+	{	BRMR_OPT_SIZE,		"size=%s"	},
+	{	BRMR_OPT_ERR,		NULL		},
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
+static int brmr_clt_parse_options(const char *buf,
+			      char *pool,
+			      unsigned long *size)
+{
+	char *options, *sep_opt;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int opt_mask = 0;
+	int token;
+	int ret = -EINVAL;
+	int i;
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
+		token = match_token(p, brmr_opt_tokens, args);
+		opt_mask |= token;
+
+		switch (token) {
+		case BRMR_OPT_POOL:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) > NAME_MAX) {
+				pr_err("poolname too long\n");
+				ret = -EINVAL;
+				kfree(p);
+				goto out;
+			}
+			strscpy(pool, p, NAME_MAX);
+			kfree(p);
+			break;
+
+		case BRMR_OPT_SIZE:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			/*
+			 * The conventional semantics are that if the number begins with 0x, it will
+			 * be parsed as hexadecimal; if it begins with 0, it will be parsed as
+			 * octal; otherwise, it will be parsed as decimal.
+			 */
+			ret = kstrtoul(p, 0, size);
+			if (ret) {
+				pr_err("size '%s' isn't an integer: %d\n", p, ret);
+				kfree(p);
+				goto out;
+			}
+			kfree(p);
+			break;
+
+
+		default:
+			pr_err("unknown parameter or missing value"
+			       " '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(brmr_opt_mandatory); i++) {
+		if ((opt_mask & brmr_opt_mandatory[i])) {
+			ret = 0;
+		} else {
+			pr_err("parameters missing\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+out:
+	kfree(options);
+	return ret;
+}
+
+static ssize_t brmr_map_device_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo \""
+			 "pool=<name of the RMR pool> "
+			 "size=<size of the volume in sectors>\" > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t brmr_map_device_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct brmr_clt_dev *dev;
+	char pool[NAME_MAX];
+	unsigned long size = 0;
+	int ret;
+
+	ret = brmr_clt_parse_options(buf, pool, &size);
+	if (ret)
+		goto err;
+
+	dev = find_and_get_device(pool);
+	if (dev) {
+		pr_err("Device exists and opened as %s\n",
+		       dev->gd->disk_name);
+		brmr_clt_put_dev(dev);
+		ret = -EEXIST;
+		goto err;
+	}
+
+	dev = brmr_clt_map_device(pool, size);
+	if (IS_ERR(dev)) {
+		pr_err("Error mapping device to pool %s\n", pool);
+		ret = PTR_ERR(dev);
+		goto err;
+	}
+	ret = brmr_clt_create_dev_sysfs_files(dev);
+	if (ret)
+		goto close_device;
+
+	ret = brmr_add_dev_symlink(dev);
+	if (ret)
+		goto destroy_sysfs;
+
+	return count;
+
+destroy_sysfs:
+	sysfs_remove_link(&dev->kobj, BRMR_LINK_NAME);
+	brmr_clt_destroy_dev_sysfs_files(dev, NULL);
+close_device:
+	brmr_clt_close_device(dev, NULL);
+err:
+	return ret;
+}
+
+static struct kobj_attribute brmr_map_device_attr =
+	__ATTR(map_device, 0644,
+	       brmr_map_device_show, brmr_map_device_store);
+
+static struct attribute *default_attrs[] = {
+	&brmr_map_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group default_attr_group = {
+	.attrs = default_attrs,
+};
+
+static ssize_t brmr_unmap_device_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo <normal|force> > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t brmr_unmap_device_store(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct brmr_clt_dev *dev;
+	int err;
+
+	dev = container_of(kobj, struct brmr_clt_dev, kobj);
+
+	if (!sysfs_streq(buf, "1")) {
+		pr_err("%s: unknown value: '%s'\n", attr->attr.name, buf);
+		return -EINVAL;
+	}
+
+	pr_info("Closing device %s.\n", dev->gd->disk_name);
+
+	/*
+	 * We take explicit module reference only for one reason: do not
+	 * race with lockless ibnbd_destroy_sessions().
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		return -ENODEV;
+	}
+	err = brmr_clt_close_device(dev, &attr->attr);
+	if (unlikely(err)) {
+		if (unlikely(err != -EALREADY))
+			pr_err("unmap_device %s: %d\n",
+			       dev->gd->disk_name, err);
+		goto module_put;
+	}
+
+	/*
+	 * Here device can be vanished!
+	 */
+	err = count;
+
+module_put:
+	module_put(THIS_MODULE);
+
+	return err;
+}
+
+static struct kobj_attribute brmr_unmap_device_attr =
+	__ATTR(unmap_device, 0644,
+	       brmr_unmap_device_show, brmr_unmap_device_store);
+
+static ssize_t brmr_clt_device_state_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *page)
+{
+	struct brmr_clt_dev *dev;
+	int cnt;
+
+	dev = container_of(kobj, struct brmr_clt_dev, kobj);
+
+	switch (dev->dev_state) {
+	case DEV_STATE_INIT:
+		cnt = sysfs_emit(page, "init\n");
+		break;
+	case DEV_STATE_READY:
+		cnt = sysfs_emit(page, "ready\n");
+		break;
+	case DEV_STATE_DISCONNECTED:
+		cnt = sysfs_emit(page, "disconnected\n");
+		break;
+	case DEV_STATE_CLOSING:
+		cnt = sysfs_emit(page, "closing\n");
+		break;
+	default:
+		cnt = sysfs_emit(page, "unknown\n");
+		break;
+	}
+
+	if (dev->map_incomplete)
+		cnt += sysfs_emit_at(page, cnt, "degraded\n");
+
+	return cnt;
+}
+
+static struct kobj_attribute brmr_clt_device_state =
+	__ATTR(state, 0444, brmr_clt_device_state_show, NULL);
+
+static struct attribute *brmr_clt_dev_attrs[] = {
+	&brmr_unmap_device_attr.attr,
+	&brmr_clt_device_state.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(brmr_clt_dev);
+
+static struct kobj_type brmr_clt_device_ktype = {
+	.sysfs_ops      = &kobj_sysfs_ops,
+	.default_groups  = brmr_clt_dev_groups,
+};
+
+static struct kobj_type brmr_clt_stats_ktype = {
+	.sysfs_ops      = &kobj_sysfs_ops,
+};
+
+static int brmr_clt_create_stats_files(struct kobject *kobj,
+				   struct kobject *kobj_stats);
+
+static int brmr_clt_create_dev_sysfs_files(struct brmr_clt_dev *dev)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&dev->kobj, &brmr_clt_device_ktype,
+				   brmr_devs_kobj,
+				   "%s", dev->gd->disk_name);
+	if (ret)
+		pr_err("Failed to create sysfs dir for device '%s': %d\n",
+		       dev->gd->disk_name, ret);
+
+	ret = brmr_clt_create_stats_files(&dev->kobj, &dev->kobj_stats);
+	if (unlikely(ret)) {
+		pr_err("Failed to create sysfs stats files "
+		       "for device '%s': %d\n", dev->gd->disk_name, ret);
+		kobject_del(&dev->kobj);
+		kobject_put(&dev->kobj);
+	}
+	return ret;
+}
+
+static int brmr_add_dev_symlink(struct brmr_clt_dev *dev)
+{
+	struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, gd_kobj, BRMR_LINK_NAME);
+	if (ret) {
+		pr_err("Creating symlink for %s failed, err: %d\n",
+		       dev->gd->disk_name, ret);
+	}
+
+	return ret;
+}
+
+void brmr_clt_destroy_dev_sysfs_files(struct brmr_clt_dev *dev,
+				     const struct attribute *sysfs_self)
+{
+	if (dev->kobj.state_in_sysfs) {
+
+		kobject_del(&dev->kobj_stats);
+		kobject_put(&dev->kobj_stats);
+		if (sysfs_self)
+			sysfs_remove_file_self(&dev->kobj, sysfs_self);
+		kobject_del(&dev->kobj);
+		kobject_put(&dev->kobj);
+	}
+}
+
+int brmr_clt_create_sysfs_files(void)
+{
+	int err;
+
+	brmr_dev_class = class_create("brmr-client");
+	if (IS_ERR(brmr_dev_class))
+		return PTR_ERR(brmr_dev_class);
+
+	brmr_dev = device_create(brmr_dev_class, NULL,
+				 MKDEV(0, 0), NULL, "ctl");
+	if (IS_ERR(brmr_dev)) {
+		err = PTR_ERR(brmr_dev);
+		goto cls_destroy;
+	}
+	brmr_devs_kobj = kobject_create_and_add("devices", &brmr_dev->kobj);
+	if (unlikely(!brmr_devs_kobj)) {
+		err = -ENOMEM;
+		goto dev_destroy;
+	}
+	err = sysfs_create_group(&brmr_dev->kobj, &default_attr_group);
+	if (unlikely(err))
+		goto put_devs_kobj;
+
+	return 0;
+
+put_devs_kobj:
+	kobject_del(brmr_devs_kobj);
+	kobject_put(brmr_devs_kobj);
+dev_destroy:
+	device_unregister(brmr_dev);
+cls_destroy:
+	class_destroy(brmr_dev_class);
+
+	return err;
+}
+
+void brmr_clt_destroy_sysfs_files(void)
+{
+	sysfs_remove_group(&brmr_dev->kobj, &default_attr_group);
+	kobject_del(brmr_devs_kobj);
+	kobject_put(brmr_devs_kobj);
+	device_unregister(brmr_dev);
+	class_destroy(brmr_dev_class);
+}
+
+STAT_ATTR(struct brmr_clt_dev, requests,
+	  brmr_clt_stats_rq_to_str, brmr_clt_reset_submitted_req);
+STAT_ATTR(struct brmr_clt_dev, request_sizes,
+	  brmr_clt_stats_sizes_to_str, brmr_clt_reset_req_sizes);
+STAT_ATTR(struct brmr_clt_dev, sts_resource,
+	  brmr_stats_sts_resource_to_str, brmr_clt_reset_sts_resource);
+STAT_ATTR(struct brmr_clt_dev, sts_resource_per_cpu,
+	  brmr_stats_sts_resource_per_cpu_to_str, brmr_clt_reset_sts_resource);
+
+static struct attribute *brmr_stats_attrs[] = {
+	&requests_attr.attr,
+	&request_sizes_attr.attr,
+	&sts_resource_attr.attr,
+	&sts_resource_per_cpu_attr.attr,
+	NULL,
+};
+
+static struct attribute_group brmr_stats_attr_group = {
+	.attrs = brmr_stats_attrs,
+};
+
+static int brmr_clt_create_stats_files(struct kobject *kobj,
+				   struct kobject *kobj_stats)
+{
+	int ret;
+
+	ret = kobject_init_and_add(kobj_stats, &brmr_clt_stats_ktype, kobj, "stats");
+	if (ret) {
+		pr_err("Failed to init and add stats kobject, err: %d\n",
+		       ret);
+		return ret;
+	}
+
+	ret = sysfs_create_group(kobj_stats, &brmr_stats_attr_group);
+	if (ret) {
+		pr_err("failed to create stats sysfs group, err: %d\n",
+		       ret);
+		goto put_stats_obj;
+	}
+
+	return 0;
+
+put_stats_obj:
+	kobject_del(kobj_stats);
+	kobject_put(kobj_stats);
+
+	return ret;
+}
-- 
2.43.0


