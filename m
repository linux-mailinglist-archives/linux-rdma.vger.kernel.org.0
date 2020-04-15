Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3973D1A98BB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895379AbgDOJYS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895375AbgDOJWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:22:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85253C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b11so6848394wrs.6
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU68bYZll0mzggjcp/THbKrh4n5hlEmB9/xKZTuuEY8=;
        b=XcHoGvnyHSUjTQwE5xur3DtRsbAZB2tf74ELZdzlvaMxA/F6FiMhIj8WdqLRAyqpX8
         nRSm57v1dpwZF+zxsHcvGW4INVkqC6xkzHr2tX4mTW5Orj2T+batL2E/WSIHdxgqTtTA
         zw/uwtK8G2Jjv3gZv+7G9gNYk/bPB1bgrQC4O4/U920gAXn7gBzwhkY2mlMq56YcAE1k
         M/aQkDlraecUEhow5jbGwjuPu2aTAGcRy2ylTbaFk7Y5JCfjcqgDo+8O5prI8a/nfe9N
         Dzi3x/1DZJ/ve+h6PPDNo5kDjCa7W4uy2RrIc8KWvxpNqFBOLxetCyBCS0lOFkfCQ8v1
         ZGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU68bYZll0mzggjcp/THbKrh4n5hlEmB9/xKZTuuEY8=;
        b=tzNluKshlBiUaa0cQeJwpn9OD5v1mXq4o8gU/mJxG9yNMM7zSLR/VraynjCwmAywfo
         Pqh8aBcHAUCaVgJg/lHJjRxVNToHccAMt0KYSFGh3cYYcCnaPueNWDkvrZgYccfhkzx7
         Sfsbbnd8TDRdT6fURftVDl39bmseAnZM7YWhjQvZynZhHwq/2r95u5b1SI5ZcGZZAF2W
         ceWV0pOu1yhXrpGEAKI8YJQi2YczNvIyyB+Tf4G0Z1/UkeBHQQKjwIsw9m3KgPIN8ASI
         P1gIiOD7x4a+IFOiu5qnc7UiBIGbb0BuhmFRARdwqGUenTipr9kAqacgch4G7V5xpUFW
         Tedg==
X-Gm-Message-State: AGi0PuYjiwvFO+EDRqX+3lpXT94KH7tMFm23TCYPS5CVF1vfOWBE6685
        CFBtbYBUldfsVKyNefUzLgdW
X-Google-Smtp-Source: APiQypI+EOQp42aUw1dcmrmwxvr483FQu4bCaOgqrulm00JGTB6RQIc3eUpjpLOAFBN6qOdm4HqVPw==
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr6119794wru.416.1586942567998;
        Wed, 15 Apr 2020 02:22:47 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:22:47 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 08/25] RDMA/rtrs: client: sysfs interface functions
Date:   Wed, 15 Apr 2020 11:20:28 +0200
Message-Id: <20200415092045.4729-9-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rtrs sessions on client side:

  /sys/class/rtrs-client/<SESS-NAME>/
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
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 481 +++++++++++++++++++
 1 file changed, 481 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
new file mode 100644
index 000000000000..4310130ee3bb
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -0,0 +1,481 @@
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
+static void rtrs_clt_sess_release(struct kobject *kobj)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+
+	free_sess(sess);
+}
+
+static struct kobj_type ktype_sess = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = rtrs_clt_sess_release
+};
+
+static void rtrs_clt_sess_stats_release(struct kobject *kobj)
+{
+	struct rtrs_clt_stats *stats;
+
+	stats = container_of(kobj, struct rtrs_clt_stats, kobj_stats);
+
+	kfree(stats);
+}
+
+static struct kobj_type ktype_stats = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = rtrs_clt_sess_stats_release,
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
+STAT_ATTR(struct rtrs_clt_stats, cpu_migration,
+	  rtrs_clt_stats_migration_cnt_to_str,
+	  rtrs_clt_reset_cpu_migr_stats);
+
+STAT_ATTR(struct rtrs_clt_stats, reconnects,
+	  rtrs_clt_stats_reconnects_to_str,
+	  rtrs_clt_reset_reconnects_stat);
+
+STAT_ATTR(struct rtrs_clt_stats, rdma,
+	  rtrs_clt_stats_rdma_to_str,
+	  rtrs_clt_reset_rdma_stats);
+
+STAT_ATTR(struct rtrs_clt_stats, reset_all,
+	  rtrs_clt_reset_all_help,
+	  rtrs_clt_reset_all_stats);
+
+static struct attribute *rtrs_clt_stats_attrs[] = {
+	&cpu_migration_attr.attr,
+	&reconnects_attr.attr,
+	&rdma_attr.attr,
+	&reset_all_attr.attr,
+	NULL
+};
+
+static struct attribute_group rtrs_clt_stats_attr_group = {
+	.attrs = rtrs_clt_stats_attrs,
+};
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
+	err = kobject_init_and_add(&sess->kobj, &ktype_sess, clt->kobj_paths,
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
+	err = kobject_init_and_add(&sess->stats->kobj_stats, &ktype_stats,
+				   &sess->kobj, "stats");
+	if (err) {
+		pr_err("kobject_init_and_add: %d\n", err);
+		goto remove_group;
+	}
+
+	err = sysfs_create_group(&sess->stats->kobj_stats,
+				 &rtrs_clt_stats_attr_group);
+	if (err) {
+		pr_err("failed to create stats sysfs group, err: %d\n", err);
+		goto put_kobj_stats;
+	}
+
+	return 0;
+
+put_kobj_stats:
+	kobject_del(&sess->stats->kobj_stats);
+	kobject_put(&sess->stats->kobj_stats);
+remove_group:
+	sysfs_remove_group(&sess->kobj, &rtrs_clt_sess_attr_group);
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
+	kobject_del(&sess->stats->kobj_stats);
+	kobject_put(&sess->stats->kobj_stats);
+	if (sysfs_self)
+		sysfs_remove_file_self(&sess->kobj, sysfs_self);
+	kobject_del(&sess->kobj);
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
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt)
+{
+	return sysfs_create_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+}
+
+void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt)
+{
+	if (clt->kobj_paths) {
+		kobject_del(clt->kobj_paths);
+		kobject_put(clt->kobj_paths);
+	}
+}
+
+void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt)
+{
+	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+}
-- 
2.20.1

