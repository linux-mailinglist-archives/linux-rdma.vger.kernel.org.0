Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12DC181D59
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgCKQNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39571 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgCKQND (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:13:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id r15so3390623wrx.6
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E4zkpfWHIG+YIiGxvZMNtmHLFuUYu26i7X8D60LEnso=;
        b=b1rlvc4J2fgjz/ASuiDwEc5lUhEnYALvnCQvOK+iyRxdqlWoZtzSPrn3r8OzxIBInU
         3pzKX/CXULsKVnqIYIMkbRjxCozk8ZIPc8Bjjj50rbUCgXoyB8rZOCQ9DlXka/VU3jGU
         lQGVGRc3CRbUHRZc5vGtuxrE+XJN+mg6oYM79U9dptvO0kBzst7mmX9h+DQjlTr6wnEk
         xdjFNT161KtcVwy25VJSUvgsyOI5aJwlHOPJyR3twojWr9G7XGTFJeY1+uZMrSe2oK1/
         +2HUJaSKTfoQgZ3yWSTF69bC2kjxH5NR54XbInkaFfLKnZ6GKH9vckN5iD4XVdZN7i5N
         fOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E4zkpfWHIG+YIiGxvZMNtmHLFuUYu26i7X8D60LEnso=;
        b=nrnGa0B7y8xksFjzcvoNmM4pAYvmCdPbxU+3rnGGuUKKO+emiuNjXviCFOAhZ6sAs2
         9XizpaQ/CVQ1FopIIC6uZjbPhwxVGd18cjEFpjPKUn7yryQW6hcrU3/RiOccsF5u/oYA
         p1hGlxCHc//ck4LEv0qFi3ty5tm6kTgc17vIxExxL2Gfb66PmV7Yyma0b14lkvAH6dUU
         TvDGH8U6J/H8Xiqs1G4X9FR204+vIEy1/baOimondfaR/t6VHv9kBP86lIftps+ZES7z
         Jj+hyEQBs/mG04y3LJgsnk+m3OlxStO1zc7pQ6OxADk2Bsa2OLuSS6GjZNM5+ZAenXrY
         yXew==
X-Gm-Message-State: ANhLgQ1qS/2h2sSIaVIf3DwSvXNfckGGMaUk+k8HtjFXX17GlxJglpYK
        uJ+ljTfeCQlGyw3Jgo28R9nzrg==
X-Google-Smtp-Source: ADFU+vtuGU8BI7tEcoRConf9+jx/Z6048pfsRmvEpNRuKWqA+xjFR0qcZTjrP8WszsM1yxnf2I17aQ==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr5154644wrn.319.1583943181744;
        Wed, 11 Mar 2020 09:13:01 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:01 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 12/26] RDMA/rtrs: server: sysfs interface functions
Date:   Wed, 11 Mar 2020 17:12:26 +0100
Message-Id: <20200311161240.30190-13-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 285 +++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
new file mode 100644
index 000000000000..f418c82cb358
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -0,0 +1,285 @@
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
+	if (err) {
+		pr_err("device_register(): %d\n", err);
+		goto unlock;
+	}
+	err = kobject_init_and_add(&srv->kobj_paths, &ktype,
+				   &srv->dev.kobj, "paths");
+	if (err) {
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
+	if (err) {
+		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		return err;
+	}
+	err = sysfs_create_group(&sess->kobj_stats,
+				 &rtrs_srv_stats_attr_group);
+	if (err) {
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
+	if (err)
+		return err;
+
+	err = kobject_init_and_add(&sess->kobj, &ktype, &srv->kobj_paths,
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

