Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060D84D15C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFTPDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42659 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731980AbfFTPDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so5159922edq.9;
        Thu, 20 Jun 2019 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2yNcc8ZaMu8TtuEuh5OtY4U6SuUz17nXMGfipxJihnA=;
        b=HC7sekV14waH9OjfpPn3ea90UTF6oYW/1VCZZnouZ4I8Bu4DF9rjaCMaG66Pa+d4hv
         0fcEU/5GevvHubCjH28nEO1vJqvrJcb8aKZ/i6FBijz0NW05iXKl2J+NLxE6nh1TH3Np
         r11Przujy992bcIidrc2ihZHTzRUpKwNoY1epLMtxKa67pL5mi95Ze1luL2Lip7c5kEF
         +zelQobLuUvL1RIz7am/93o2GGRk9/xIegu6OStoAhuZm1bWGQ1S1It6AiN9yd+lYQOz
         V5RnYWYf2ZhefXuWgI6brR7DBhEmljNPDOJBCm5iS6AZBTF99qknY+oksVnyPwYXya1n
         jAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2yNcc8ZaMu8TtuEuh5OtY4U6SuUz17nXMGfipxJihnA=;
        b=MkwdI/sOxmatrb6ObU3Kp+pk7XF4Duxx0xGQwi4JKekcvmOg1eQovidynLa+eW+lPw
         vm0mHObfJanMW1IfTQ+yWxHfp0J6jM55SRwvdkj2do6+bvYLZHCxO6CfXgaQlTL8AZeF
         xhb9WjzEvaQVCVPXObB6hRS0G1XXGhBOBPEBV1EeqbP9DCnuf/WMAfk5PZbgx1Xxix9A
         Yn3oRq1brw0SEHbyFrkLBb/YN5GonoP2JwDFWa2Ok/j2V+vprMF9SB6Uh256otvXcH8m
         7TbEOcybp5MPkQtfHEbvebah/hBZiC0mDlY6gUnfrzwH2BeAL8h02rEFFOyhFJFRbH1H
         xK7g==
X-Gm-Message-State: APjAAAXSymJKIZPWkGE2sn8tB1ZTOtE5QeqoBY3JxG1dtT6NCwwB7NSz
        83ndJ9sExnL2sR5rHR5veg+Fae/QTb4=
X-Google-Smtp-Source: APXvYqxrkEfaYmUWV53VmyAKTIjUguZKfw+zA/Tftbn7ZC2q8gXYzXSggc45vQQ8w5AraaduWb3U/w==
X-Received: by 2002:a17:906:7e4b:: with SMTP id z11mr56387274ejr.214.1561043029724;
        Thu, 20 Jun 2019 08:03:49 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:49 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 08/25] ibtrs: client: sysfs interface functions
Date:   Thu, 20 Jun 2019 17:03:20 +0200
Message-Id: <20190620150337.7847-9-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This is the sysfs interface to IBTRS sessions on client side:

  /sys/devices/virtual/ibtrs-client/<SESS-NAME>/
    *** IBTRS session created by ibtrs_clt_open() API call
    |
    |- max_reconnect_attempts
    |  *** number of reconnect attempts for session
    |
    |- add_path
    |  *** adds another connection path into IBTRS session
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
 .../infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c    | 514 ++++++++++++++++++
 1 file changed, 514 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c b/drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c
new file mode 100644
index 000000000000..1f7b6c28e6b4
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-clt-sysfs.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * InfiniBand Transport Layer
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
+#include "ibtrs-pri.h"
+#include "ibtrs-clt.h"
+#include "ibtrs-log.h"
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
+	struct ibtrs_clt *clt;
+
+	clt = container_of(dev, struct ibtrs_clt, dev);
+
+	return sprintf(page, "%d\n", ibtrs_clt_get_max_reconnect_attempts(clt));
+}
+
+static ssize_t max_reconnect_attempts_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t count)
+{
+	struct ibtrs_clt *clt;
+	int value;
+	int ret;
+
+	clt = container_of(dev, struct ibtrs_clt, dev);
+
+	ret = kstrtoint(buf, 10, &value);
+	if (unlikely(ret)) {
+		ibtrs_err(clt, "%s: failed to convert string '%s' to int\n",
+			  attr->attr.name, buf);
+		return ret;
+	}
+	if (unlikely(value > MAX_MAX_RECONN_ATT ||
+		     value < MIN_MAX_RECONN_ATT)) {
+		ibtrs_err(clt, "%s: invalid range"
+			  " (provided: '%s', accepted: min: %d, max: %d)\n",
+			  attr->attr.name, buf, MIN_MAX_RECONN_ATT,
+			  MAX_MAX_RECONN_ATT);
+		return -EINVAL;
+	}
+	ibtrs_clt_set_max_reconnect_attempts(clt, value);
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
+	struct ibtrs_clt *clt;
+
+	clt = container_of(dev, struct ibtrs_clt, dev);
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
+	struct ibtrs_clt *clt;
+	int value;
+	int ret;
+
+	clt = container_of(dev, struct ibtrs_clt, dev);
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
+	return scnprintf(page, PAGE_SIZE, "Usage: echo"
+			 " [<source addr>,]<destination addr> > %s\n\n"
+			"*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]\n",
+			 attr->attr.name);
+}
+
+static ssize_t add_path_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct sockaddr_storage srcaddr, dstaddr;
+	struct ibtrs_addr addr = {
+		.src = &srcaddr,
+		.dst = &dstaddr
+	};
+	struct ibtrs_clt *clt;
+	const char *nl;
+	size_t len;
+	int err;
+
+	clt = container_of(dev, struct ibtrs_clt, dev);
+
+	nl = strchr(buf, '\n');
+	if (nl)
+		len = nl - buf;
+	else
+		len = count;
+	err = ibtrs_addr_to_sockaddr(buf, len, clt->port, &addr);
+	if (unlikely(err))
+		return -EINVAL;
+
+	err = ibtrs_clt_create_path_from_sysfs(clt, &addr);
+	if (unlikely(err))
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(add_path);
+
+static ssize_t ibtrs_clt_state_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *page)
+{
+	struct ibtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	if (ibtrs_clt_sess_is_connected(sess))
+		return sprintf(page, "connected\n");
+
+	return sprintf(page, "disconnected\n");
+}
+
+static struct kobj_attribute ibtrs_clt_state_attr =
+	__ATTR(state, 0444, ibtrs_clt_state_show, NULL);
+
+static ssize_t ibtrs_clt_reconnect_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t ibtrs_clt_reconnect_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct ibtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		ibtrs_err(sess, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = ibtrs_clt_reconnect_from_sysfs(sess);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute ibtrs_clt_reconnect_attr =
+	__ATTR(reconnect, 0644, ibtrs_clt_reconnect_show,
+	       ibtrs_clt_reconnect_store);
+
+static ssize_t ibtrs_clt_disconnect_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t ibtrs_clt_disconnect_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ibtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		ibtrs_err(sess, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = ibtrs_clt_disconnect_from_sysfs(sess);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute ibtrs_clt_disconnect_attr =
+	__ATTR(disconnect, 0644, ibtrs_clt_disconnect_show,
+	       ibtrs_clt_disconnect_store);
+
+static ssize_t ibtrs_clt_remove_path_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t ibtrs_clt_remove_path_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct ibtrs_clt_sess *sess;
+	int ret;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		ibtrs_err(sess, "%s: unknown value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+	ret = ibtrs_clt_remove_path_from_sysfs(sess, &attr->attr);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute ibtrs_clt_remove_path_attr =
+	__ATTR(remove_path, 0644, ibtrs_clt_remove_path_show,
+	       ibtrs_clt_remove_path_store);
+
+STAT_ATTR(struct ibtrs_clt_sess, cpu_migration,
+	  ibtrs_clt_stats_migration_cnt_to_str,
+	  ibtrs_clt_reset_cpu_migr_stats);
+
+STAT_ATTR(struct ibtrs_clt_sess, sg_entries,
+	  ibtrs_clt_stats_sg_list_distr_to_str,
+	  ibtrs_clt_reset_sg_list_distr_stats);
+
+STAT_ATTR(struct ibtrs_clt_sess, reconnects,
+	  ibtrs_clt_stats_reconnects_to_str,
+	  ibtrs_clt_reset_reconnects_stat);
+
+STAT_ATTR(struct ibtrs_clt_sess, rdma_lat,
+	  ibtrs_clt_stats_rdma_lat_distr_to_str,
+	  ibtrs_clt_reset_rdma_lat_distr_stats);
+
+STAT_ATTR(struct ibtrs_clt_sess, wc_completion,
+	  ibtrs_clt_stats_wc_completion_to_str,
+	  ibtrs_clt_reset_wc_comp_stats);
+
+STAT_ATTR(struct ibtrs_clt_sess, rdma,
+	  ibtrs_clt_stats_rdma_to_str,
+	  ibtrs_clt_reset_rdma_stats);
+
+STAT_ATTR(struct ibtrs_clt_sess, reset_all,
+	  ibtrs_clt_reset_all_help,
+	  ibtrs_clt_reset_all_stats);
+
+static struct attribute *ibtrs_clt_stats_attrs[] = {
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
+static struct attribute_group ibtrs_clt_stats_attr_group = {
+	.attrs = ibtrs_clt_stats_attrs,
+};
+
+static int ibtrs_clt_create_stats_files(struct kobject *kobj,
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
+	ret = sysfs_create_group(kobj_stats, &ibtrs_clt_stats_attr_group);
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
+static ssize_t ibtrs_clt_hca_port_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_clt_sess *sess;
+
+	sess = container_of(kobj, typeof(*sess), kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%u\n", sess->hca_port);
+}
+
+static struct kobj_attribute ibtrs_clt_hca_port_attr =
+	__ATTR(hca_port, 0444, ibtrs_clt_hca_port_show, NULL);
+
+static ssize_t ibtrs_clt_hca_name_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n", sess->hca_name);
+}
+
+static struct kobj_attribute ibtrs_clt_hca_name_attr =
+	__ATTR(hca_name, 0444, ibtrs_clt_hca_name_show, NULL);
+
+static ssize_t ibtrs_clt_src_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_clt_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute ibtrs_clt_src_addr_attr =
+	__ATTR(src_addr, 0444, ibtrs_clt_src_addr_show, NULL);
+
+static ssize_t ibtrs_clt_dst_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_clt_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct ibtrs_clt_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute ibtrs_clt_dst_addr_attr =
+	__ATTR(dst_addr, 0444, ibtrs_clt_dst_addr_show, NULL);
+
+static struct attribute *ibtrs_clt_sess_attrs[] = {
+	&ibtrs_clt_hca_name_attr.attr,
+	&ibtrs_clt_hca_port_attr.attr,
+	&ibtrs_clt_src_addr_attr.attr,
+	&ibtrs_clt_dst_addr_attr.attr,
+	&ibtrs_clt_state_attr.attr,
+	&ibtrs_clt_reconnect_attr.attr,
+	&ibtrs_clt_disconnect_attr.attr,
+	&ibtrs_clt_remove_path_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ibtrs_clt_sess_attr_group = {
+	.attrs = ibtrs_clt_sess_attrs,
+};
+
+int ibtrs_clt_create_sess_files(struct ibtrs_clt_sess *sess)
+{
+	struct ibtrs_clt *clt = sess->clt;
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
+	err = sysfs_create_group(&sess->kobj, &ibtrs_clt_sess_attr_group);
+	if (unlikely(err)) {
+		pr_err("sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = ibtrs_clt_create_stats_files(&sess->kobj, &sess->kobj_stats);
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
+void ibtrs_clt_destroy_sess_files(struct ibtrs_clt_sess *sess,
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
+static struct attribute *ibtrs_clt_attrs[] = {
+	&dev_attr_max_reconnect_attempts.attr,
+	&dev_attr_mpath_policy.attr,
+	&dev_attr_add_path.attr,
+	NULL,
+};
+
+static struct attribute_group ibtrs_clt_attr_group = {
+	.attrs = ibtrs_clt_attrs,
+};
+
+int ibtrs_clt_create_sysfs_root_folders(struct ibtrs_clt *clt)
+{
+	return kobject_init_and_add(&clt->kobj_paths, &ktype,
+				    &clt->dev.kobj, "paths");
+}
+
+int ibtrs_clt_create_sysfs_root_files(struct ibtrs_clt *clt)
+{
+	return sysfs_create_group(&clt->dev.kobj, &ibtrs_clt_attr_group);
+}
+
+void ibtrs_clt_destroy_sysfs_root_folders(struct ibtrs_clt *clt)
+{
+	if (clt->kobj_paths.state_in_sysfs) {
+		kobject_del(&clt->kobj_paths);
+		kobject_put(&clt->kobj_paths);
+	}
+}
+
+void ibtrs_clt_destroy_sysfs_root_files(struct ibtrs_clt *clt)
+{
+	sysfs_remove_group(&clt->dev.kobj, &ibtrs_clt_attr_group);
+}
-- 
2.17.1

