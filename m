Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468581A98B7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895384AbgDOJYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895376AbgDOJW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:22:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35AC061A41
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so16548251wmk.5
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adYV9IgV4Vjf5+NRo1o2kFy6eGZv2y0lyJwNy38iGuY=;
        b=gu0yY3nqOR+LXJVMn8jGATIkCieR6FPTBz/aNuIlMoUb/UKmrnLLFLNRaEdoOmSw8s
         gk5fgCdaGnzv/Xe3Tey+a+3u+O8GPGhzFQbICeB4BMLdQAYUx/E/zzA7//swAyHuBO7m
         l3sLWlKW4WkhjbAX77DwIR4039TIaBPdgmG/ApoqUs/M6UPaW/mfp41SVAWT113lCp8M
         Ao2BQO2d0gG0MUcJgZLYZ0DCkSK2fgVIsH+tpQiSR17+gUMfZXQWooQEmBk+/+JO5W5+
         BTFwjX2p+xOwZTym+heu6aBn5gMOuNlGW0QHxJya9GXkZgSUY6j24gZ2IlB0m/zmI5BD
         xYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adYV9IgV4Vjf5+NRo1o2kFy6eGZv2y0lyJwNy38iGuY=;
        b=RutnLiB4JVHRDAruKsZMt/vzSH/eGKdX6zXvPZtQTSFOwzRGeCbZQqjeocogPALe5X
         XWINAqyI2gvhUWKsYJ2WIbyF5gOx0OEDmvb4uqnqolnDg3+T+Lwyl5BVoeb5zUdwUeH9
         uCUymBbRHsKkawu/G696NyDXx3VarWrO0TH5xG3mOgYZ6pAsqXrAwxyI3IvQMnhM4XHk
         X51+VJVhE0z1diW9iej7VwjePHgwVYG82fPlYQBksX8XgLYC2IJOSNosXNZc2wwnMJTH
         gN/IoG9fSGyulxMg0lZQZQHH8/lC/QhWRqomuarTheWKUmCWlwMEzYNiP7ye5ArpphC3
         tTkg==
X-Gm-Message-State: AGi0PuaxANVn2iZr5NZlGDCBrKYQXs/FQ4HpanpyChg6ERSMsMxGV6xi
        Tuk25z7luuNMxP5ZXhlv/yOq
X-Google-Smtp-Source: APiQypKps2px9In5ZyfJ7/6+NgQndAEmB04XcsVbQYyI5DM1FCfkAM0hoDOMhfcLG/KvqGZ4jNF3OA==
X-Received: by 2002:a05:600c:2941:: with SMTP id n1mr4334139wmd.25.1586942575084;
        Wed, 15 Apr 2020 02:22:55 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:22:54 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 12/25] RDMA/rtrs: server: sysfs interface functions
Date:   Wed, 15 Apr 2020 11:20:32 +0200
Message-Id: <20200415092045.4729-13-danil.kipnis@cloud.ionos.com>
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

This is the sysfs interface to rtrs sessions on server side:

  /sys/class/rtrs-server/<SESS-NAME>/
    *** rtrs session accepted from a client peer
    |
    |- paths/<SRC@DST>/
       *** established paths from a client in a session
       |
       |- disconnect
       |  *** disconnect path
       |
       |- hca_name
       |  *** HCA name
       |
       |- hca_port
       |  *** HCA port
       |
       |- stats/
          *** current path statistics
          |
	  |- rdma

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 320 +++++++++++++++++++
 1 file changed, 320 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
new file mode 100644
index 000000000000..0cf015634338
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -0,0 +1,320 @@
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
+#include "rtrs-srv.h"
+#include "rtrs-log.h"
+
+static void rtrs_srv_release(struct kobject *kobj)
+{
+	struct rtrs_srv_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
+	kfree(sess);
+}
+
+static struct kobj_type ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= rtrs_srv_release,
+};
+
+static ssize_t rtrs_srv_disconnect_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct rtrs_srv_sess *sess;
+	struct rtrs_sess *s;
+	char str[MAXHOSTNAMELEN];
+
+	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
+	s = &sess->s;
+	if (!sysfs_streq(buf, "1")) {
+		rtrs_err(s, "%s: invalid value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+
+	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr, str, sizeof(str));
+
+	rtrs_info(s, "disconnect for path %s requested\n", str);
+	close_sess(sess);
+
+	return count;
+}
+
+static struct kobj_attribute rtrs_srv_disconnect_attr =
+	__ATTR(disconnect, 0644,
+	       rtrs_srv_disconnect_show, rtrs_srv_disconnect_store);
+
+static ssize_t rtrs_srv_hca_port_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_srv_sess *sess;
+	struct rtrs_con *usr_con;
+
+	sess = container_of(kobj, typeof(*sess), kobj);
+	usr_con = sess->s.con[0];
+
+	return scnprintf(page, PAGE_SIZE, "%u\n",
+			 usr_con->cm_id->port_num);
+}
+
+static struct kobj_attribute rtrs_srv_hca_port_attr =
+	__ATTR(hca_port, 0444, rtrs_srv_hca_port_show, NULL);
+
+static ssize_t rtrs_srv_hca_name_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_srv_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 sess->s.dev->ib_dev->name);
+}
+
+static struct kobj_attribute rtrs_srv_hca_name_attr =
+	__ATTR(hca_name, 0444, rtrs_srv_hca_name_show, NULL);
+
+static ssize_t rtrs_srv_src_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_srv_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute rtrs_srv_src_addr_attr =
+	__ATTR(src_addr, 0444, rtrs_srv_src_addr_show, NULL);
+
+static ssize_t rtrs_srv_dst_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct rtrs_srv_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute rtrs_srv_dst_addr_attr =
+	__ATTR(dst_addr, 0444, rtrs_srv_dst_addr_show, NULL);
+
+static struct attribute *rtrs_srv_sess_attrs[] = {
+	&rtrs_srv_hca_name_attr.attr,
+	&rtrs_srv_hca_port_attr.attr,
+	&rtrs_srv_src_addr_attr.attr,
+	&rtrs_srv_dst_addr_attr.attr,
+	&rtrs_srv_disconnect_attr.attr,
+	NULL,
+};
+
+static struct attribute_group rtrs_srv_sess_attr_group = {
+	.attrs = rtrs_srv_sess_attrs,
+};
+
+STAT_ATTR(struct rtrs_srv_stats, rdma,
+	  rtrs_srv_stats_rdma_to_str,
+	  rtrs_srv_reset_rdma_stats);
+
+static struct attribute *rtrs_srv_stats_attrs[] = {
+	&rdma_attr.attr,
+	NULL,
+};
+
+static struct attribute_group rtrs_srv_stats_attr_group = {
+	.attrs = rtrs_srv_stats_attrs,
+};
+
+static void rtrs_srv_dev_release(struct device *dev)
+{
+	struct rtrs_srv *srv = container_of(dev, struct rtrs_srv, dev);
+
+	kfree(srv);
+}
+
+static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
+{
+	struct rtrs_srv *srv = sess->srv;
+	int err = 0;
+
+	mutex_lock(&srv->paths_mutex);
+	if (srv->dev_ref++) {
+		/*
+		 * Device needs to be registered only on the first session
+		 */
+		goto unlock;
+	}
+	srv->dev.class = rtrs_dev_class;
+	srv->dev.release = rtrs_srv_dev_release;
+	err = dev_set_name(&srv->dev, "%s", sess->s.sessname);
+	if (err)
+		goto unlock;
+
+	/*
+	 * Suppress user space notification until
+	 * sysfs files are created
+	 */
+	dev_set_uevent_suppress(&srv->dev, true);
+	err = device_register(&srv->dev);
+	if (err) {
+		pr_err("device_register(): %d\n", err);
+		goto put;
+	}
+	srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
+	if (!srv->kobj_paths) {
+		pr_err("kobject_create_and_add(): %d\n", err);
+		device_unregister(&srv->dev);
+		goto unlock;
+	}
+	dev_set_uevent_suppress(&srv->dev, false);
+	kobject_uevent(&srv->dev.kobj, KOBJ_ADD);
+	goto unlock;
+
+put:
+	put_device(&srv->dev);
+unlock:
+	mutex_unlock(&srv->paths_mutex);
+
+	return err;
+}
+
+static void
+rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
+{
+	struct rtrs_srv *srv = sess->srv;
+
+	mutex_lock(&srv->paths_mutex);
+	if (!--srv->dev_ref) {
+		kobject_del(srv->kobj_paths);
+		kobject_put(srv->kobj_paths);
+		mutex_unlock(&srv->paths_mutex);
+		device_unregister(&srv->dev);
+	} else {
+		mutex_unlock(&srv->paths_mutex);
+	}
+}
+
+static void rtrs_srv_sess_stats_release(struct kobject *kobj)
+{
+	struct rtrs_srv_stats *stats;
+
+	stats = container_of(kobj, struct rtrs_srv_stats, kobj_stats);
+
+	kfree(stats);
+}
+
+static struct kobj_type ktype_stats = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = rtrs_srv_sess_stats_release,
+};
+
+static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
+{
+	int err;
+	struct rtrs_sess *s = &sess->s;
+
+	err = kobject_init_and_add(&sess->stats->kobj_stats, &ktype_stats,
+				   &sess->kobj, "stats");
+	if (err) {
+		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->stats->kobj_stats,
+				 &rtrs_srv_stats_attr_group);
+	if (err) {
+		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kobject_del(&sess->stats->kobj_stats);
+	kobject_put(&sess->stats->kobj_stats);
+
+	return err;
+}
+
+int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess)
+{
+	struct rtrs_srv *srv = sess->srv;
+	struct rtrs_sess *s = &sess->s;
+	char str[NAME_MAX];
+	int err, cnt;
+
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      str, sizeof(str));
+	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
+	sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			str + cnt, sizeof(str) - cnt);
+
+	err = rtrs_srv_create_once_sysfs_root_folders(sess);
+	if (err)
+		return err;
+
+	err = kobject_init_and_add(&sess->kobj, &ktype, srv->kobj_paths,
+				   "%s", str);
+	if (err) {
+		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		goto destroy_root;
+	}
+	err = sysfs_create_group(&sess->kobj, &rtrs_srv_sess_attr_group);
+	if (err) {
+		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = rtrs_srv_create_stats_files(sess);
+	if (err)
+		goto remove_group;
+
+	return 0;
+
+remove_group:
+	sysfs_remove_group(&sess->kobj, &rtrs_srv_sess_attr_group);
+put_kobj:
+	kobject_del(&sess->kobj);
+	kobject_put(&sess->kobj);
+destroy_root:
+	rtrs_srv_destroy_once_sysfs_root_folders(sess);
+
+	return err;
+}
+
+void rtrs_srv_destroy_sess_files(struct rtrs_srv_sess *sess)
+{
+	if (sess->kobj.state_in_sysfs) {
+		kobject_del(&sess->stats->kobj_stats);
+		kobject_put(&sess->stats->kobj_stats);
+		kobject_del(&sess->kobj);
+		kobject_put(&sess->kobj);
+
+		rtrs_srv_destroy_once_sysfs_root_folders(sess);
+	}
+}
-- 
2.20.1

