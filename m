Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3112A21F986
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgGNSei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSei (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 14:34:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27BC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so23984041wrn.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvGkLwWeuJtAW6VGduH8+m4dkLZrSU0VWJlGtY5Rjdo=;
        b=XLMIg4L0kf+P7Xzh+G03+uqineK514OfchMxCkRlLJGREcdeV0lSXXsSi4A3UqJTlf
         7di4mzE/JA4yI+EtcrE/M4AYOiHNYIT5Pu8GBqeHL5e3CxzTet5N/U4YtH1jcnCPMTRz
         Ip9AlJH9gbDErTku9qai0+YrVqJ7EqYxvf9WcvRUw1b5CTQE8k01RZgZLhhlsKDhS6cY
         HyTxb8wPWHT7GC5F8AMpUfaC7Rd0BmvqyZhGPYtFG4w+T10JVbZn5XcoTue63AANHxXD
         LltqNjIfltcf49neXSY98/UMGOasDYPzTmPywviUK8pDg3yQYn8pOOQA9GeD97/svCxY
         zNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvGkLwWeuJtAW6VGduH8+m4dkLZrSU0VWJlGtY5Rjdo=;
        b=pg9wypdtLbdQQVPI7w4EfHO8icmzO1w5GSTctkb/EFu5QXPlycoqf9KPs2OQrtN1HT
         2ZFNxpe1YgX7O81PsW58MeQeTT6Qd2zO1bHGg6qdIqwnl0cC+vhgtSzafHnqrh+iJuSy
         ewY7xqf3JZgf5nbJ7Qa0IRD9g5YPNhs50G8IJEihpLrr5DFwRYDJGkbm1QRXW4QQOjrp
         rqBFwR9FLVbKyfS4iwu7BHFiK4GilKZV/NTRsK6LVzRTp/ibSdR4b9OKT9uu/3aO2zbP
         sLQIV0Szv9O3sn7nzax8DegvkACJR3IPmPAOetBtjpjGOMn7MpI9LygyGu3BHfW6V4Px
         +Nsw==
X-Gm-Message-State: AOAM532LYdKTGXrypqDCK148/92pvPii5xXC+UBuZY/mU1S/Qw4vjgEx
        P+Qdw63MJZKUU3MO010zyV+7VEH+JF4=
X-Google-Smtp-Source: ABdhPJzzoB13rQgqDbNCLj3Vyd1v8vYO99CAsRaR1gKSgF34cG6H3ZauJpMzHr88BbYdc6S0J5qRyg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr7239570wrt.174.1594751676317;
        Tue, 14 Jul 2020 11:34:36 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:35 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 1/7] RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
Date:   Tue, 14 Jul 2020 21:34:08 +0300
Message-Id: <20200714183414.61069-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Expose the pkeys sysfs files only if the pkey_tbl_len is set by the
providers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/sysfs.c | 64 ++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index defe9cd4c5ee..38507e5529ba 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -58,7 +58,7 @@ struct ib_port {
 	struct ib_device      *ibdev;
 	struct gid_attr_group *gid_attr_group;
 	struct attribute_group gid_group;
-	struct attribute_group pkey_group;
+	struct attribute_group *pkey_group;
 	struct attribute_group *pma_table;
 	struct attribute_group *hw_stats_ag;
 	struct rdma_hw_stats   *hw_stats;
@@ -681,11 +681,16 @@ static void ib_port_release(struct kobject *kobj)
 		kfree(p->gid_group.attrs);
 	}
 
-	if (p->pkey_group.attrs) {
-		for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
-			kfree(a);
+	if (p->pkey_group) {
+		if (p->pkey_group->attrs) {
+			for (i = 0; (a = p->pkey_group->attrs[i]); ++i)
+				kfree(a);
+
+			kfree(p->pkey_group->attrs);
+		}
 
-		kfree(p->pkey_group.attrs);
+		kfree(p->pkey_group);
+		p->pkey_group = NULL;
 	}
 
 	kfree(p);
@@ -1118,17 +1123,26 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_free_gid_type;
 
-	p->pkey_group.name  = "pkeys";
-	p->pkey_group.attrs = alloc_group_attrs(show_port_pkey,
-						attr.pkey_tbl_len);
-	if (!p->pkey_group.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_type;
+	if (attr.pkey_tbl_len) {
+		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
+		if (!p->pkey_group) {
+			ret = -ENOMEM;
+			goto err_remove_gid_type;
+		}
+
+		p->pkey_group->name  = "pkeys";
+		p->pkey_group->attrs = alloc_group_attrs(show_port_pkey,
+							 attr.pkey_tbl_len);
+		if (!p->pkey_group->attrs) {
+			ret = -ENOMEM;
+			goto err_free_pkey_group;
+		}
+
+		ret = sysfs_create_group(&p->kobj, p->pkey_group);
+		if (ret)
+			goto err_free_pkey;
 	}
 
-	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
-	if (ret)
-		goto err_free_pkey;
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
@@ -1150,14 +1164,23 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	return 0;
 
 err_remove_pkey:
-	sysfs_remove_group(&p->kobj, &p->pkey_group);
+	if (p->pkey_group)
+		sysfs_remove_group(&p->kobj, p->pkey_group);
 
 err_free_pkey:
-	for (i = 0; i < attr.pkey_tbl_len; ++i)
-		kfree(p->pkey_group.attrs[i]);
+	if (p->pkey_group) {
+		for (i = 0; i < attr.pkey_tbl_len; ++i)
+			kfree(p->pkey_group->attrs[i]);
 
-	kfree(p->pkey_group.attrs);
-	p->pkey_group.attrs = NULL;
+		kfree(p->pkey_group->attrs);
+		p->pkey_group->attrs = NULL;
+	}
+
+err_free_pkey_group:
+	if (p->pkey_group) {
+		kfree(p->pkey_group);
+		p->pkey_group = NULL;
+	}
 
 err_remove_gid_type:
 	sysfs_remove_group(&p->gid_attr_group->kobj,
@@ -1317,7 +1340,8 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 
 		if (port->pma_table)
 			sysfs_remove_group(p, port->pma_table);
-		sysfs_remove_group(p, &port->pkey_group);
+		if (port->pkey_group)
+			sysfs_remove_group(p, port->pkey_group);
 		sysfs_remove_group(p, &port->gid_group);
 		sysfs_remove_group(&port->gid_attr_group->kobj,
 				   &port->gid_attr_group->ndev);
-- 
2.25.4

