Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88833181D55
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgCKQNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgCKQM7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:12:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so3408394wrd.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d7+EWWXSEfRbV5Skcb92PHVygDqqpP7J0KBuqEMlJdE=;
        b=aQlgm00UZ3FW9KfNzdKFYantkitbSJ8j3020j4TtSibGMg/rPPEud8F+ypO/2QFTsh
         dUu8NgiiGxwVGukbi9n92iTEqrDq6cHUmowVr4uNVk/S09mOSorugAWFYRMJFCN55B2y
         t3jGuwMgE5WG1DSrv/Ov5sIonnwDjC6qHY5eTCjL3/s7A0FdzXU7d4rfn/nf74PnhYQH
         1HkNXOtsPAilsp4K03ofW+lF6UT7IDLC17rQKQkPtvmMpbJKiGCMIFO4ycoeaPP3pdM8
         809rD35kQUAEX2LTMZEMstYbIaewv9hCP70pcimovhuvmv1NHRtxYbwbA7VwNW4ouneU
         /hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d7+EWWXSEfRbV5Skcb92PHVygDqqpP7J0KBuqEMlJdE=;
        b=dP4Q6Sc+K5sjn61ekcAGdi4eJpZd/yj/pik9Kuo8/x9RU4QRJxDuFmSoszcEJU3ZxJ
         bnC8+Gr1am+IXCLqY6pWBMrGvF7EPMcxnsSmni9l5pwPzx4Zvfv9oAPScMYLdo0PLYLi
         GGoxBQX2zodE+7mKqimpBuMo37A01k/Ide77syj2QC8BXzUtLV6TfIc9LHP5klcM3Tn6
         om5dRwPQ6yNrzS9TelJGRUGqzrHuN/EgFGM38h3AWyx1gf9jJ5sHvWSJKHJDJTxfuvzc
         S9s0IVCHfT49IvSbXKu9iTF1tIrWHZ11ARSo24l5qXvtD/7KaB5FYeE3wX//Ny9515/c
         UTWw==
X-Gm-Message-State: ANhLgQ3FKEU20oZ4cgk13fecUiBTkUczxFykSx4g7GAc1aKbvM71qOJE
        uNYiwHcZPU/h2m0z4QRHMKHQCQ==
X-Google-Smtp-Source: ADFU+vsGIW1AULXG5WOyjfy3xYhFL3zd/SQdInvbZei6EDkHcn060Funk5rUlXQqt7nIMukp9f3NeA==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr5577151wrr.276.1583943175992;
        Wed, 11 Mar 2020 09:12:55 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:12:55 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 08/26] RDMA/rtrs: client: sysfs interface functions
Date:   Wed, 11 Mar 2020 17:12:22 +0100
Message-Id: <20200311161240.30190-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

