Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003CF4D164
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfFTPD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:03:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33282 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbfFTPD4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:03:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so5228236edq.0;
        Thu, 20 Jun 2019 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fVE0087Lu9Zok4Bknogj9DTtSn+xzAiVyTROjrKfAc4=;
        b=HzD9ZKUqF2Av7OnHg7xbiYWL2CI0Snp21ZD1ERVb5GSiZuANLxP9gOTIzBrn4C8QI+
         73AUcSveCS3/gHV6NZr7C+PrL4fYHI7Ky8CzCj5Wb7mLFpHL6FJ3GF/EDp6dBFKvw96z
         YTThP9X0EFJUdmqy4/w4aGT9QKugsl96eKjxxCsPILMbho7fDZmhCjZkBJSMOWg3Gp3l
         1rwUn4tzwu/SQWwU6FoUmIYundnkc9G9e7kn2cwbm4TWkWf9L/LNHAJf/pDYcCFUGQij
         uezvHsPzkV9ro7tcdOyqj47WLP8ICE0fonkWvhR6OZ9NDrkwTXjm7OYA1JbRyNyOMlRr
         YDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fVE0087Lu9Zok4Bknogj9DTtSn+xzAiVyTROjrKfAc4=;
        b=tt2HlM5UbAr4GSWe3Peqdrykxi0rh86frv4447hZJLqlLwj13p0bPCTcWfuydsKssw
         S3CDkqB+23H8x9bZouUhSz7mleqpX3k+AdMWgd0hk1zCzo8DXLjUqBuLL3saMCW8VrF/
         RIvtTg+SowD25T8UmTg6Hz4rcteOUtzlDLAfATngbIIXiD30bBTKvBrqfr7PkgdQ9sqg
         gymIP0biHO2tmz3yGVlAaa5OnQIYtbNaNT0lnioRPrVp+oZutFhAH7hRrf2c2G8hyLSu
         1jMeUAyuivu6RfPTn9E36SCZU6KMXUSAasg7G8tWwfT6V5j0hqYxcYlSVcYDrixrnORd
         7vmQ==
X-Gm-Message-State: APjAAAWboxxXAHilD0xjo6sQtXUe+cS3R0AWw+Zm5PZta8UMzRFyE5CZ
        zWvxi6bTJmGfgHKpzO020j50fJcuYL0=
X-Google-Smtp-Source: APXvYqwCNxvv6AUyZ+6i7aBySzbs5k3JhRtPvy2hpPdg9wq+l86RQv3Uc7IoezNs2Xp1cEo0GqDwww==
X-Received: by 2002:a50:91ef:: with SMTP id h44mr111985377eda.276.1561043034546;
        Thu, 20 Jun 2019 08:03:54 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:54 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 12/25] ibtrs: server: sysfs interface functions
Date:   Thu, 20 Jun 2019 17:03:24 +0200
Message-Id: <20190620150337.7847-13-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

This is the sysfs interface to IBTRS sessions on server side:

  /sys/devices/virtual/ibtrs-server/<SESS-NAME>/
    *** IBTRS session accepted from a client peer
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
 .../infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c    | 303 ++++++++++++++++++
 1 file changed, 303 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c
new file mode 100644
index 000000000000..c48c368c1906
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-sysfs.c
@@ -0,0 +1,303 @@
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
+#include "ibtrs-srv.h"
+#include "ibtrs-log.h"
+
+static struct kobj_type ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+static ssize_t ibtrs_srv_disconnect_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
+			 attr->attr.name);
+}
+
+static ssize_t ibtrs_srv_disconnect_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ibtrs_srv_sess *sess;
+	char str[MAXHOSTNAMELEN];
+
+	sess = container_of(kobj, struct ibtrs_srv_sess, kobj);
+	if (!sysfs_streq(buf, "1")) {
+		ibtrs_err(sess, "%s: invalid value: '%s'\n",
+			  attr->attr.name, buf);
+		return -EINVAL;
+	}
+
+	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr, str, sizeof(str));
+
+	ibtrs_info(sess, "disconnect for path %s requested\n", str);
+	ibtrs_srv_queue_close(sess);
+
+	return count;
+}
+
+static struct kobj_attribute ibtrs_srv_disconnect_attr =
+	__ATTR(disconnect, 0644,
+	       ibtrs_srv_disconnect_show, ibtrs_srv_disconnect_store);
+
+static ssize_t ibtrs_srv_hca_port_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_srv_sess *sess;
+	struct ibtrs_con *usr_con;
+
+	sess = container_of(kobj, typeof(*sess), kobj);
+	usr_con = sess->s.con[0];
+
+	return scnprintf(page, PAGE_SIZE, "%u\n",
+			 usr_con->cm_id->port_num);
+}
+
+static struct kobj_attribute ibtrs_srv_hca_port_attr =
+	__ATTR(hca_port, 0444, ibtrs_srv_hca_port_show, NULL);
+
+static ssize_t ibtrs_srv_hca_name_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_srv_sess *sess;
+
+	sess = container_of(kobj, struct ibtrs_srv_sess, kobj);
+
+	return scnprintf(page, PAGE_SIZE, "%s\n",
+			 sess->s.dev->ib_dev->name);
+}
+
+static struct kobj_attribute ibtrs_srv_hca_name_attr =
+	__ATTR(hca_name, 0444, ibtrs_srv_hca_name_show, NULL);
+
+static ssize_t ibtrs_srv_src_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_srv_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct ibtrs_srv_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute ibtrs_srv_src_addr_attr =
+	__ATTR(src_addr, 0444, ibtrs_srv_src_addr_show, NULL);
+
+static ssize_t ibtrs_srv_dst_addr_show(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       char *page)
+{
+	struct ibtrs_srv_sess *sess;
+	int cnt;
+
+	sess = container_of(kobj, struct ibtrs_srv_sess, kobj);
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			      page, PAGE_SIZE);
+	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+}
+
+static struct kobj_attribute ibtrs_srv_dst_addr_attr =
+	__ATTR(dst_addr, 0444, ibtrs_srv_dst_addr_show, NULL);
+
+static struct attribute *ibtrs_srv_sess_attrs[] = {
+	&ibtrs_srv_hca_name_attr.attr,
+	&ibtrs_srv_hca_port_attr.attr,
+	&ibtrs_srv_src_addr_attr.attr,
+	&ibtrs_srv_dst_addr_attr.attr,
+	&ibtrs_srv_disconnect_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ibtrs_srv_sess_attr_group = {
+	.attrs = ibtrs_srv_sess_attrs,
+};
+
+STAT_ATTR(struct ibtrs_srv_sess, rdma,
+	  ibtrs_srv_stats_rdma_to_str,
+	  ibtrs_srv_reset_rdma_stats);
+
+STAT_ATTR(struct ibtrs_srv_sess, wc_completion,
+	  ibtrs_srv_stats_wc_completion_to_str,
+	  ibtrs_srv_reset_wc_completion_stats);
+
+STAT_ATTR(struct ibtrs_srv_sess, reset_all,
+	  ibtrs_srv_reset_all_help,
+	  ibtrs_srv_reset_all_stats);
+
+static struct attribute *ibtrs_srv_stats_attrs[] = {
+	&rdma_attr.attr,
+	&wc_completion_attr.attr,
+	&reset_all_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ibtrs_srv_stats_attr_group = {
+	.attrs = ibtrs_srv_stats_attrs,
+};
+
+static void ibtrs_srv_dev_release(struct device *dev)
+{
+	/* Nobody plays with device references, so nop */
+}
+
+static int ibtrs_srv_create_once_sysfs_root_folders(struct ibtrs_srv_sess *sess)
+{
+	struct ibtrs_srv *srv = sess->srv;
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
+	srv->dev.class = ibtrs_dev_class;
+	srv->dev.release = ibtrs_srv_dev_release;
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
+ibtrs_srv_destroy_once_sysfs_root_folders(struct ibtrs_srv_sess *sess)
+{
+	struct ibtrs_srv *srv = sess->srv;
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
+static int ibtrs_srv_create_stats_files(struct ibtrs_srv_sess *sess)
+{
+	int err;
+
+	err = kobject_init_and_add(&sess->kobj_stats, &ktype,
+				   &sess->kobj, "stats");
+	if (unlikely(err)) {
+		ibtrs_err(sess, "kobject_init_and_add(): %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->kobj_stats,
+				 &ibtrs_srv_stats_attr_group);
+	if (unlikely(err)) {
+		ibtrs_err(sess, "sysfs_create_group(): %d\n", err);
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
+int ibtrs_srv_create_sess_files(struct ibtrs_srv_sess *sess)
+{
+	struct ibtrs_srv *srv = sess->srv;
+	char str[NAME_MAX];
+	int err, cnt;
+
+	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+			      str, sizeof(str));
+	cnt += scnprintf(str + cnt, sizeof(str) - cnt, "@");
+	sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+			str + cnt, sizeof(str) - cnt);
+
+	err = ibtrs_srv_create_once_sysfs_root_folders(sess);
+	if (unlikely(err))
+		return err;
+
+	err = kobject_init_and_add(&sess->kobj, &ktype, &srv->kobj_paths,
+				   "%s", str);
+	if (unlikely(err)) {
+		ibtrs_err(sess, "kobject_init_and_add(): %d\n", err);
+		goto destroy_root;
+	}
+	err = sysfs_create_group(&sess->kobj, &ibtrs_srv_sess_attr_group);
+	if (unlikely(err)) {
+		ibtrs_err(sess, "sysfs_create_group(): %d\n", err);
+		goto put_kobj;
+	}
+	err = ibtrs_srv_create_stats_files(sess);
+	if (unlikely(err))
+		goto remove_group;
+
+	return 0;
+
+remove_group:
+	sysfs_remove_group(&sess->kobj, &ibtrs_srv_sess_attr_group);
+put_kobj:
+	kobject_del(&sess->kobj);
+	kobject_put(&sess->kobj);
+destroy_root:
+	ibtrs_srv_destroy_once_sysfs_root_folders(sess);
+
+	return err;
+}
+
+void ibtrs_srv_destroy_sess_files(struct ibtrs_srv_sess *sess)
+{
+	if (sess->kobj.state_in_sysfs) {
+		kobject_del(&sess->kobj_stats);
+		kobject_put(&sess->kobj_stats);
+		kobject_del(&sess->kobj);
+		kobject_put(&sess->kobj);
+
+		ibtrs_srv_destroy_once_sysfs_root_folders(sess);
+	}
+}
-- 
2.17.1

