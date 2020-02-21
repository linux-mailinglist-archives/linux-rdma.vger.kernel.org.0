Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5242E167B2D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgBUKrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41221 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgBUKrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so1771505eds.8;
        Fri, 21 Feb 2020 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqyDUKbNNYiCpB2X/T0btznuERvhSnS/zt39q4O6sAg=;
        b=LYcmpHfTkCKvoC6vLwV/9O9lGlWpK7NtXlpiraZ9pw0euyfoEkU6e+Fmk8+mDniqkw
         fWvmR37XiXDevaL0WyerOAMbNvcBwEH6J59ghLUGLPTUwNosq7FOFc9ZYP3aXF7jmiWX
         P3mkpVvWy4xXUySWVXnC1j4xTEG7BCvUo6fxaZptqdK1sO8WrwpgYlqu5yCj3eJfMQCv
         flxCqAiFORJ32pGQVM1/3311NPKpn91THLy2uE4uMox5zIEIpF3aEaQN7TUGHeRi49rf
         +k5ki5NJJeprNQ6Fb3d010I+cKl9jlnJjwlXruwCI5lqd76EplPcZ+uWWvzU/8LPacWJ
         H7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqyDUKbNNYiCpB2X/T0btznuERvhSnS/zt39q4O6sAg=;
        b=BXmKh9+bKFNjzteA8sQB3IGFyW8RnU5CXwjGWPjCnN7m4xLcv/0SgSeXyA1HHhydJG
         m3RMxubbtcufjz9n6C6t4FRFIwQYGa4+IeaJPM1tOO+zGXFs+MoeQbrzuH7083leuSAD
         p2BkxE+zu9Vao12fblDe6ai91Zjwq4kRFogN8iVWcgWEyNymHjcWDofMhMzTwwcFnWxI
         kRhmKVOpYe/d9lTKkfoF4Sk0PYy1a114BJbcybfypHo8YCNBXh2xBv9aYRc+EziLPzBI
         oLKHpR8fKKk+XlSYdPevGxS4KzSfTVqePSoxjBbuGuyb7VV4E/y8E8T5RWArVycP5n9d
         /S7w==
X-Gm-Message-State: APjAAAUXGL6Nu0yeSdRFZbE/1tIhXW28QaMSfRfrXxWTWy6SXwECJdVQ
        O980ms2yIIFT1O8OIhpmj2BZt+aV
X-Google-Smtp-Source: APXvYqwgugK0cSQWOy9Eorw+nvkBrqoaMRD8UZwTjmnvaYJjY0qOmRB1nlbLwvKw5zlYCQn7yCOfYg==
X-Received: by 2002:a05:6402:22f5:: with SMTP id dn21mr13053193edb.324.1582282051880;
        Fri, 21 Feb 2020 02:47:31 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:31 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 08/25] RDMA/rtrs: client: sysfs interface functions
Date:   Fri, 21 Feb 2020 11:47:04 +0100
Message-Id: <20200221104721.350-9-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rtrs sessions on client side:

  /sys/devices/virtual/rtrs-client/<SESS-NAME>/
    *** rtrs session created by rtrs_clt_open() API call
    |
    |- max_reconnect_attempts
    |  *** number of reconnect attempts for session
    |
    |- add_path
    |  *** adds another connection path into rtrs session
    |
    |- paths/<SRC@DST>/
       *** established paths to server in a session
       |
       |- disconnect
       |  *** disconnect path
       |
       |- reconnect
       |  *** reconnect path
       |
       |- remove_path
       |  *** remove current path
       |
       |- state
       |  *** retrieve current path state
       |
       |- hca_port
       |  *** HCA port number
       |
       |- hca_name
       |  *** HCA name
       |
       |- stats/
          *** current path statistics
          |
	  |- cpu_migration
	  |- rdma
	  |- reconnects
	  |- reset_all

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 480 +++++++++++++++++++
 1 file changed, 480 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
new file mode 100644
index 000000000000..d0aee797a535
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-pri.h"
+#include "rtrs-clt.h"
+#include "rtrs-log.h"
+
+#define MIN_MAX_RECONN_ATT -1
+#define MAX_MAX_RECONN_ATT 9999
+
+static struct kobj_type ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static ssize_t max_reconnect_attempts_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *page)
+{
+	struct rtrs_clt *clt = container_of(dev, struct rtrs_clt, dev);
+
+	return sprintf(page, "%d\n", rtrs_clt_get_max_reconnect_attempts(clt));
+}
+
+static ssize_t max_reconnect_attempts_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	int value;
+	int ret;
+	struct rtrs_clt *clt  = container_of(dev, struct rtrs_clt, dev);
+
+	ret = kstrtoint(buf, 10, &value);
+	if (ret) {
+		rtrs_err(clt, "%s: failed to convert string '%s' to int\n",
+			  attr->attr.name, buf);
+		return ret;
+	}
+	if (value > MAX_MAX_RECONN_ATT ||
+		     value < MIN_MAX_RECONN_ATT) {
+		rtrs_err(clt,
+			  "%s: invalid range (provided: '%s', accepted: min: %d, max: %d)\n",
+			  attr->attr.name, buf, MIN_MAX_RECONN_ATT,
+			  MAX_MAX_RECONN_ATT);
+		return -EINVAL;
+	}
+	rtrs_clt_set_max_reconnect_attempts(clt, value);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(max_reconnect_attempts);
+
+static ssize_t mpath_policy_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page)
+{
+	struct rtrs_clt *clt;
+
+	clt = container_of(dev, struct rtrs_clt, dev);
+
+	switch (clt->mp_policy) {
+	case MP_POLICY_RR:
+		return sprintf(page, "round-robin (RR: %d)\n", clt->mp_policy);
+	case MP_POLICY_MIN_INFLIGHT:
+		return sprintf(page, "min-inflight (MI: %d)\n", clt->mp_policy);
+	default:
+		return sprintf(page, "Unknown (%d)\n", clt->mp_policy);
+	}
+}
+
+static ssize_t mpath_policy_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
+{
+	struct rtrs_clt *clt;
+	int value;
+	int ret;
+
+	clt = container_of(dev, struct rtrs_clt, dev);
+
+	ret = kstrtoint(buf, 10, &value);
+	if (!ret && (value == MP_POLICY_RR ||
+		     value == MP_POLICY_MIN_INFLIGHT)) {
+		clt->mp_policy = value;
+		return count;
+	}
+
+	if (!strncasecmp(buf, "round-robin", 11) ||
+	    !strncasecmp(buf, "rr", 2))
+		clt->mp_policy = MP_POLICY_RR;
+	else if (!strncasecmp(buf, "min-inflight", 12) ||
+		 !strncasecmp(buf, "mi", 2))
+		clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(mpath_policy);
+
+static ssize_t add_path_show(struct device *dev,
+			     struct device_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE,
+			 "Usage: echo [<source addr>@]<destination addr> > %s\n\n*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]\n",
+			 attr->attr.name);
+}
+
+static ssize_t add_path_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct sockaddr_storage srcaddr, dstaddr;
+	struct rtrs_addr addr = {
+		.src = &srcaddr,
+		.dst = &dstaddr
+	};
+	struct rtrs_clt *clt;
+	const char *nl;
+	size_t len;
+	int err;
+
+	clt = container_of(dev, struct rtrs_clt, dev);
+
+	nl = strchr(buf, '\n');
+	if (nl)
+		len = nl - buf;
+	else
+		len = count;
+	err = rtrs_addr_to_sockaddr(buf, len, clt->port, &addr);
+	if (err)
+		return -EINVAL;
+
+	err = rtrs_clt_create_path_from_sysfs(clt, &addr);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(add_path);
+
+static ssize_t rtrs_clt_state_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *page)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	if (sess->state == RTRS_CLT_CONNECTED)
+		return sprintf(page, "connected\n");
+
+	return sprintf(page, "disconnected\n");
+}
+
+static struct kobj_attribute rtrs_clt_state_attr =
+	__ATTR(state, 0444, rtrs_clt_state_show, NULL);
+
+static ssize_t rtrs_clt_reconnect_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rtrs_clt_reconnect_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		rtrs_err(sess->clt, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = rtrs_clt_reconnect_from_sysfs(sess);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute rtrs_clt_reconnect_attr =
+	__ATTR(reconnect, 0644, rtrs_clt_reconnect_show,
+	       rtrs_clt_reconnect_store);
+
+static ssize_t rtrs_clt_disconnect_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct rtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		rtrs_err(sess->clt, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = rtrs_clt_disconnect_from_sysfs(sess);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute rtrs_clt_disconnect_attr =
+	__ATTR(disconnect, 0644, rtrs_clt_disconnect_show,
+	       rtrs_clt_disconnect_store);
+
+static ssize_t rtrs_clt_remove_path_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rtrs_clt_remove_path_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct rtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		rtrs_err(sess->clt, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = rtrs_clt_remove_path_from_sysfs(sess, &attr->attr);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute rtrs_clt_remove_path_attr =
+	__ATTR(remove_path, 0644, rtrs_clt_remove_path_show,
+	       rtrs_clt_remove_path_store);
+
+STAT_ATTR(struct rtrs_clt_sess, cpu_migration,
+	  rtrs_clt_stats_migration_cnt_to_str,
+	  rtrs_clt_reset_cpu_migr_stats);
+
+STAT_ATTR(struct rtrs_clt_sess, reconnects,
+	  rtrs_clt_stats_reconnects_to_str,
+	  rtrs_clt_reset_reconnects_stat);
+
+STAT_ATTR(struct rtrs_clt_sess, rdma,
+	  rtrs_clt_stats_rdma_to_str,
+	  rtrs_clt_reset_rdma_stats);
+
+STAT_ATTR(struct rtrs_clt_sess, reset_all,
+	  rtrs_clt_reset_all_help,
+	  rtrs_clt_reset_all_stats);
+
+static struct attribute *rtrs_clt_stats_attrs[] = {
+	&cpu_migration_attr.attr,
+	&reconnects_attr.attr,
+	&rdma_attr.attr,
+	&reset_all_attr.attr,
+	NULL,
+};
+
+static struct attribute_group rtrs_clt_stats_attr_group = {
+	.attrs = rtrs_clt_stats_attrs,
+};
+
+static int rtrs_clt_create_stats_files(struct kobject *kobj,
+					struct kobject *kobj_stats)
+{
+	int ret;
+
+	ret = kobject_init_and_add(kobj_stats, &ktype, kobj, "stats");
+	if (ret) {
+		pr_err("Failed to init and add stats kobject, err: %d\n",
+		       ret);
+		return ret;
+	}
+
+	ret = sysfs_create_group(kobj_stats, &rtrs_clt_stats_attr_group);
+	if (ret) {
+		pr_err("failed to create stats sysfs group, err: %d\n",
+		       ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kobject_del(kobj_stats);
+	kobject_put(kobj_stats);
+
+	return ret;
+}
+
+static ssize_t rtrs_clt_hca_port_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, typeof(*sess), kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%u\n", sess->hca_port);
+}
+
+static struct kobj_attribute rtrs_clt_hca_port_attr =
+	__ATTR(hca_port, 0444, rtrs_clt_hca_port_show, NULL);
+
+static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", sess->hca_name);
+}
+
+static struct kobj_attribute rtrs_clt_hca_name_attr =
+	__ATTR(hca_name, 0444, rtrs_clt_hca_name_show, NULL);
+
+static ssize_t rtrs_clt_src_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_clt_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute rtrs_clt_src_addr_attr =
+	__ATTR(src_addr, 0444, rtrs_clt_src_addr_show, NULL);
+
+static ssize_t rtrs_clt_dst_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_clt_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute rtrs_clt_dst_addr_attr =
+	__ATTR(dst_addr, 0444, rtrs_clt_dst_addr_show, NULL);
+
+static struct attribute *rtrs_clt_sess_attrs[] = {
+	&rtrs_clt_hca_name_attr.attr,
+	&rtrs_clt_hca_port_attr.attr,
+	&rtrs_clt_src_addr_attr.attr,
+	&rtrs_clt_dst_addr_attr.attr,
+	&rtrs_clt_state_attr.attr,
+	&rtrs_clt_reconnect_attr.attr,
+	&rtrs_clt_disconnect_attr.attr,
+	&rtrs_clt_remove_path_attr.attr,
+	NULL,
+};
+
+static struct attribute_group rtrs_clt_sess_attr_group = {
+	.attrs = rtrs_clt_sess_attrs,
+};
+
+int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
+{
+	struct rtrs_clt *clt = sess->clt;
+	char str[NAME_MAX];
+	int err, cnt;
+
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      str, sizeof(str));
+	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
+	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			str + cnt, sizeof(str) - cnt);
+
+	err = kobject_init_and_add(&sess->kobj, &ktype, &clt->kobj_paths,
+				   "%s", str);
+	if (err) {
+		pr_err("kobject_init_and_add: %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->kobj, &rtrs_clt_sess_attr_group);
+	if (err) {
+		pr_err("sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = rtrs_clt_create_stats_files(&sess->kobj, &sess->kobj_stats);
+	if (err)
+		goto put_kobj;
+
+	return 0;
+
+put_kobj:
+	kobject_del(&sess->kobj);
+	kobject_put(&sess->kobj);
+
+	return err;
+}
+
+void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
+				  const struct attribute *sysfs_self)
+{
+	if (sess->kobj.state_in_sysfs) {
+		kobject_del(&sess->kobj_stats);
+		kobject_put(&sess->kobj_stats);
+		if (sysfs_self)
+			/* To avoid deadlock firstly commit suicide */
+			sysfs_remove_file_self(&sess->kobj, sysfs_self);
+		kobject_del(&sess->kobj);
+		kobject_put(&sess->kobj);
+	}
+}
+
+static struct attribute *rtrs_clt_attrs[] = {
+	&dev_attr_max_reconnect_attempts.attr,
+	&dev_attr_mpath_policy.attr,
+	&dev_attr_add_path.attr,
+	NULL,
+};
+
+static struct attribute_group rtrs_clt_attr_group = {
+	.attrs = rtrs_clt_attrs,
+};
+
+int rtrs_clt_create_sysfs_root_folders(struct rtrs_clt *clt)
+{
+	return kobject_init_and_add(&clt->kobj_paths, &ktype,
+				    &clt->dev.kobj, "paths");
+}
+
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt)
+{
+	return sysfs_create_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+}
+
+void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt)
+{
+	if (clt->kobj_paths.state_in_sysfs) {
+		kobject_del(&clt->kobj_paths);
+		kobject_put(&clt->kobj_paths);
+	}
+}
+
+void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt)
+{
+	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+}
-- 
2.17.1

