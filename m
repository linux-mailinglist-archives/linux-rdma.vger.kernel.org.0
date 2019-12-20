Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60C127FE4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLTPvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfLTPvb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so9731737wma.1;
        Fri, 20 Dec 2019 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O8gMMLU3WwvAIwyvKTr/YqtxwKZ1feiWbEtOVGG2ChM=;
        b=iGHsdTr6k6Fa/MnWfFkY8Cfbor8Uy04zJDjAvWlnfsZV1cqQjlAN/gmUP3Y2Ylbox+
         bR3EVqG9P9CE2yFCtI/+8UQ9Apt/aYeZ9ip2K7V06Jxj8EJ3elfXinN+plgNbmtlpurm
         Glbpgtg8NQV9QvEC5hAckEkqqYbYshvtthX5BIxVzNfCpRqVFqnh2TjFGQTDT+8orLZf
         tQ7hkSmN75ST6/IzkXmZ5tf0tQIE7Y32rRIUbkUJnsu/Yp85XHrMQjSVJ/Xha7VrrNam
         MlZc7wDT32mteUFxF+kl+D9iUxDvD+o890mAj1SV9QLZkvdJYjAb1LJdGD1Ik/3GN1LT
         1pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O8gMMLU3WwvAIwyvKTr/YqtxwKZ1feiWbEtOVGG2ChM=;
        b=q4Z3PcThMoZrVuA7BfUMvIu04zEJhDMPcIU4iJB4kB59e6FDdR/RW0WlZwT4/0fL6X
         wQbMBnchBka6jl75kHd28gLrkkbidUO8vASS/KTQVg2AOtXPkN4Iv5I3SfHzMQwls7vw
         tV4C+mQM4iFp90fJwtwY3JsEy2tnhQz78IEbUY21GHHYcf7YNj43jxxXugcJT5qyhKEB
         3G7igMqqoOHNvGL1HQ/kmN3EN6APeKrEEnhvVkjrY8AZ3z5DKIHh9VQF2lHHbuOun7NP
         3pzLBlpETuqUiaRg4GATVzkXsQI/8r7SAEk+l9HnrBv8yDb29osnmx7ghVizMrb0UEaA
         le3g==
X-Gm-Message-State: APjAAAWv1oJNxTmS0Q/mbPTFaTqdhhNiw0dPXsTMhUu9EO3hZs+ZM/X4
        627IbMo8ZHHEBE18bvz7WfaTBrGmkHw=
X-Google-Smtp-Source: APXvYqyHd1OkxgFOueqlBcOuyt8qZeShoAi88+qQTPxkqAVrOhFqGc/mtVw7okE5QFwHX1OQvz3EvA==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr17086599wmq.65.1576857088174;
        Fri, 20 Dec 2019 07:51:28 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:27 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 12/25] rtrs: server: sysfs interface functions
Date:   Fri, 20 Dec 2019 16:50:56 +0100
Message-Id: <20191220155109.8959-13-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is the sysfs interface to rtrs sessions on server side:

  /sys/devices/virtual/rtrs-server/<SESS-NAME>/
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
	  |- reset_all
	  |- wc_completions

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 315 +++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
new file mode 100644
index 000000000000..07f2caa13cdb
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -0,0 +1,315 @@
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
+ *          Jinpu Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+ *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "rtrs-pri.h"
+#include "rtrs-srv.h"
+#include "rtrs-log.h"
+
+static struct kobj_type ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
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
+STAT_ATTR(struct rtrs_srv_sess, rdma,
+	  rtrs_srv_stats_rdma_to_str,
+	  rtrs_srv_reset_rdma_stats);
+
+STAT_ATTR(struct rtrs_srv_sess, wc_completion,
+	  rtrs_srv_stats_wc_completion_to_str,
+	  rtrs_srv_reset_wc_completion_stats);
+
+STAT_ATTR(struct rtrs_srv_sess, reset_all,
+	  rtrs_srv_reset_all_help,
+	  rtrs_srv_reset_all_stats);
+
+static struct attribute *rtrs_srv_stats_attrs[] = {
+	&rdma_attr.attr,
+	&wc_completion_attr.attr,
+	&reset_all_attr.attr,
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
+		 * Just increase device reference.  We can't use get_device()
+		 * because we need to unregister device when ref goes to 0,
+		 * not just to put it.
+		 */
+		goto unlock;
+	}
+	srv->dev.class = rtrs_dev_class;
+	srv->dev.release = rtrs_srv_dev_release;
+	dev_set_name(&srv->dev, "%s", sess->s.sessname);
+
+	err = device_register(&srv->dev);
+	if (unlikely(err)) {
+		pr_err("device_register(): %d\n", err);
+		goto unlock;
+	}
+	err = kobject_init_and_add(&srv->kobj_paths, &ktype,
+				   &srv->dev.kobj, "paths");
+	if (unlikely(err)) {
+		pr_err("kobject_init_and_add(): %d\n", err);
+		device_unregister(&srv->dev);
+		goto unlock;
+	}
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
+		kobject_del(&srv->kobj_paths);
+		kobject_put(&srv->kobj_paths);
+		device_unregister(&srv->dev);
+	}
+	mutex_unlock(&srv->paths_mutex);
+}
+
+static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
+{
+	int err;
+	struct rtrs_sess *s = &sess->s;
+
+	err = kobject_init_and_add(&sess->kobj_stats, &ktype,
+				   &sess->kobj, "stats");
+	if (unlikely(err)) {
+		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->kobj_stats,
+				 &rtrs_srv_stats_attr_group);
+	if (unlikely(err)) {
+		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kobject_del(&sess->kobj_stats);
+	kobject_put(&sess->kobj_stats);
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
+	if (unlikely(err))
+		return err;
+
+	err = kobject_init_and_add(&sess->kobj, &ktype, &srv->kobj_paths,
+				   "%s", str);
+	if (unlikely(err)) {
+		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		goto destroy_root;
+	}
+	err = sysfs_create_group(&sess->kobj, &rtrs_srv_sess_attr_group);
+	if (unlikely(err)) {
+		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = rtrs_srv_create_stats_files(sess);
+	if (unlikely(err))
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
+		kobject_del(&sess->kobj_stats);
+		kobject_put(&sess->kobj_stats);
+		kobject_del(&sess->kobj);
+		kobject_put(&sess->kobj);
+
+		rtrs_srv_destroy_once_sysfs_root_folders(sess);
+	}
+}
-- 
2.17.1

