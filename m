Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4977712CEC9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfL3K35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38242 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfL3K34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so32194823edr.5;
        Mon, 30 Dec 2019 02:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLh1cAnrm60vXwBYO+SH+awIKh1kGfSZiN1XFqgkscc=;
        b=NfgnfDti7E9Svei/iHGmmaDybYIAYqunnfQx3FHWfpL4NW4PvlXIi7FEJPkXsAA0cm
         0EXY44hxwyaZC9tFjXR+5AqN34AhlgDWMlkYDpvuAZG/TBwSFxWxCWNuUgsTSB9rwnBp
         6zK7VGiW5ZSacM6zIjuvcUROevZAbWlTT4qV8jj8Z5ncEna+Cco8Klyw8gfvuCG4NkCQ
         tKk+rsJjTwzorv4BB0QxtLY7lLbn0BC8+C0Z9Uq0Lf0FMuzD7O+kUiDr6BhNFxrNZk7v
         THFHl9DqmacIvZqIjTs0MSDdC2nrsg6XQr6qgvkpKng0qmUtoUWvUbeBGq88w6k9bEfP
         HcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LLh1cAnrm60vXwBYO+SH+awIKh1kGfSZiN1XFqgkscc=;
        b=T6j1CTdwFJl+xwom1nPUgUDJ7W2tgzhSImLAUXyAFmGc7qTYEnaoanLPvDmH3x24xe
         k1V+rG4NCMvyQ9Er7J+OM/FLK3qNB0ZeU+E15g9414Grx04Xz+bjK9qKVj5lWQyILWMw
         1PSqGW58l6LQSZ7cU9ibXeb6HSnbBjBILU8m9/LIpY83kV4GVBfDy1Eb4oGKxR6RqVWo
         pu3VMOA1xQJijFV2XVzTLHybs3U4aXkz/of4xanXfuC9VVIX857nocPtJznOpy8+dSc9
         E6sCa6JrgD7BLGNVQH6AMyjZQOOONcoo7dcWUXvPZoLfKPdrgWuEoHtjYnnSj+K6+OnP
         4x4A==
X-Gm-Message-State: APjAAAUIxLjKaHVieBUq4+N5Qhr48f/0NuJTVEFfH0CkCKozr2AsvnNH
        w+yLZef30yorfaQga/60vd0j5G+I
X-Google-Smtp-Source: APXvYqySobkFHGpOYPKw8xZOItoeyAm+7RPUggia3/lnKtEKQ3QFX/KdLVdCotYL+fuDDKUpsuBvXw==
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr68581868ejz.272.1577701793751;
        Mon, 30 Dec 2019 02:29:53 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:53 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 08/25] rtrs: client: sysfs interface functions
Date:   Mon, 30 Dec 2019 11:29:25 +0100
Message-Id: <20191230102942.18395-9-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
	  |- rdma_lat
	  |- reconnects
	  |- reset_all
	  |- sg_entries
	  |- wc_completions

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 501 +++++++++++++++++++
 1 file changed, 501 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
new file mode 100644
index 000000000000..ad4eb2c58fb2
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
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
+	struct rtrs_clt *clt;
+
+	clt = container_of(dev, struct rtrs_clt, dev);
+
+	return sprintf(page, "%d\n", rtrs_clt_get_max_reconnect_attempts(clt));
+}
+
+static ssize_t max_reconnect_attempts_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	struct rtrs_clt *clt;
+	int value;
+	int ret;
+
+	clt = container_of(dev, struct rtrs_clt, dev);
+
+	ret = kstrtoint(buf, 10, &value);
+	if (unlikely(ret)) {
+		rtrs_err(clt, "%s: failed to convert string '%s' to int\n",
+			  attr->attr.name, buf);
+		return ret;
+	}
+	if (unlikely(value > MAX_MAX_RECONN_ATT ||
+		     value < MIN_MAX_RECONN_ATT)) {
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
+	if (unlikely(err))
+		return -EINVAL;
+
+	err = rtrs_clt_create_path_from_sysfs(clt, &addr);
+	if (unlikely(err))
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
+	if (unlikely(ret))
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
+	if (unlikely(ret))
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
+	if (unlikely(ret))
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
+STAT_ATTR(struct rtrs_clt_sess, sg_entries,
+	  rtrs_clt_stats_sg_list_distr_to_str,
+	  rtrs_clt_reset_sg_list_distr_stats);
+
+STAT_ATTR(struct rtrs_clt_sess, reconnects,
+	  rtrs_clt_stats_reconnects_to_str,
+	  rtrs_clt_reset_reconnects_stat);
+
+STAT_ATTR(struct rtrs_clt_sess, rdma_lat,
+	  rtrs_clt_stats_rdma_lat_distr_to_str,
+	  rtrs_clt_reset_rdma_lat_distr_stats);
+
+STAT_ATTR(struct rtrs_clt_sess, wc_completion,
+	  rtrs_clt_stats_wc_completion_to_str,
+	  rtrs_clt_reset_wc_comp_stats);
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
+	&sg_entries_attr.attr,
+	&cpu_migration_attr.attr,
+	&reconnects_attr.attr,
+	&rdma_lat_attr.attr,
+	&wc_completion_attr.attr,
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
+	if (unlikely(err)) {
+		pr_err("kobject_init_and_add: %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->kobj, &rtrs_clt_sess_attr_group);
+	if (unlikely(err)) {
+		pr_err("sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = rtrs_clt_create_stats_files(&sess->kobj, &sess->kobj_stats);
+	if (unlikely(err))
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

