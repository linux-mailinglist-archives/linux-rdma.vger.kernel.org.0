Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B054939D70A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGIUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFGIUH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EBB260FEF;
        Mon,  7 Jun 2021 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053897;
        bh=nQJrnyUptPppe56TF1U2FI5YFtqG7oMgx9SHiNklliE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5WJSweNjmABya3M8Pmc4qIQ3l3Y0tesXPfJPO6HZV0o/hgPaxudsx2uuZktm/XVs
         SdZmEGgn9tHi9JjlGL7ojI8SpGi2Pe9q9i8Vij20q6meH5pVNxUBBFm6/EUNgSZI6f
         LovMxXSnxL2kY0YoQspG0IJMKqOP52dP1hTsQZLVeHz+ikVsThMJgtDGOsUn9g1JzB
         7ili13O4mX/1BGLrTZl4uJWwb88Qh2a1N2hA//ibc1/f7Ks2y90QeAss1FmIetD8iu
         +jlNAMp4ks/2yVESlyjgOJX0Swh0xnBHWZWniGDb/f568Q85c7Vvqt3paBBLktNI4a
         hKdJuMTXeogMw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 04/15] RDMA/core: Split gid_attrs related sysfs from add_port()
Date:   Mon,  7 Jun 2021 11:17:29 +0300
Message-Id: <2dfb8ae0c0ffb639590e42917311adc9c36a8451.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The gid_attrs directory is a dedicated kobj nested under the port,
construct/destruct it with its own pair of functions for
understandability. This is much more readable than having it weirdly
inlined out of order into the add_port() function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 160 ++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 114fecda9764..d2a089a6f666 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1178,6 +1178,85 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
+/*
+ * Create the sysfs:
+ *  ibp0s9/ports/XX/gid_attrs/{ndevs,types}/YYY
+ * YYY is the gid table index in decimal
+ */
+static int setup_gid_attrs(struct ib_port *port,
+			   const struct ib_port_attr *attr)
+{
+	struct gid_attr_group *gid_attr_group;
+	int ret;
+	int i;
+
+	gid_attr_group = kzalloc(sizeof(*gid_attr_group), GFP_KERNEL);
+	if (!gid_attr_group)
+		return -ENOMEM;
+
+	gid_attr_group->port = port;
+	ret = kobject_init_and_add(&gid_attr_group->kobj, &gid_attr_type,
+				   &port->kobj, "gid_attrs");
+	if (ret)
+		goto err_put_gid_attrs;
+
+	gid_attr_group->ndev.name = "ndevs";
+	gid_attr_group->ndev.attrs =
+		alloc_group_attrs(show_port_gid_attr_ndev, attr->gid_tbl_len);
+	if (!gid_attr_group->ndev.attrs) {
+		ret = -ENOMEM;
+		goto err_put_gid_attrs;
+	}
+
+	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+	if (ret)
+		goto err_free_gid_ndev;
+
+	gid_attr_group->type.name = "types";
+	gid_attr_group->type.attrs = alloc_group_attrs(
+		show_port_gid_attr_gid_type, attr->gid_tbl_len);
+	if (!gid_attr_group->type.attrs) {
+		ret = -ENOMEM;
+		goto err_remove_gid_ndev;
+	}
+
+	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->type);
+	if (ret)
+		goto err_free_gid_type;
+
+	port->gid_attr_group = gid_attr_group;
+	return 0;
+
+err_free_gid_type:
+	for (i = 0; i < attr->gid_tbl_len; ++i)
+		kfree(gid_attr_group->type.attrs[i]);
+
+	kfree(gid_attr_group->type.attrs);
+	gid_attr_group->type.attrs = NULL;
+err_remove_gid_ndev:
+	sysfs_remove_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+err_free_gid_ndev:
+	for (i = 0; i < attr->gid_tbl_len; ++i)
+		kfree(gid_attr_group->ndev.attrs[i]);
+
+	kfree(gid_attr_group->ndev.attrs);
+	gid_attr_group->ndev.attrs = NULL;
+err_put_gid_attrs:
+	kobject_put(&gid_attr_group->kobj);
+	return ret;
+}
+
+static void destroy_gid_attrs(struct ib_port *port)
+{
+	struct gid_attr_group *gid_attr_group = port->gid_attr_group;
+
+	sysfs_remove_group(&gid_attr_group->kobj,
+			   &gid_attr_group->ndev);
+	sysfs_remove_group(&gid_attr_group->kobj,
+			   &gid_attr_group->type);
+	kobject_put(&gid_attr_group->kobj);
+}
+
 static int add_port(struct ib_core_device *coredev, int port_num)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
@@ -1204,23 +1283,11 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_put;
 
-	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
-	if (!p->gid_attr_group) {
-		ret = -ENOMEM;
-		goto err_put;
-	}
-
-	p->gid_attr_group->port = p;
-	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
-				   &p->kobj, "gid_attrs");
-	if (ret)
-		goto err_put_gid_attrs;
-
 	if (device->ops.process_mad && is_full_dev) {
 		p->pma_table = get_counter_table(device, port_num);
 		ret = sysfs_create_group(&p->kobj, p->pma_table);
 		if (ret)
-			goto err_put_gid_attrs;
+			goto err_put;
 	}
 
 	p->gid_group.name  = "gids";
@@ -1234,37 +1301,11 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (ret)
 		goto err_free_gid;
 
-	p->gid_attr_group->ndev.name = "ndevs";
-	p->gid_attr_group->ndev.attrs = alloc_group_attrs(show_port_gid_attr_ndev,
-							  attr.gid_tbl_len);
-	if (!p->gid_attr_group->ndev.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid;
-	}
-
-	ret = sysfs_create_group(&p->gid_attr_group->kobj,
-				 &p->gid_attr_group->ndev);
-	if (ret)
-		goto err_free_gid_ndev;
-
-	p->gid_attr_group->type.name = "types";
-	p->gid_attr_group->type.attrs = alloc_group_attrs(show_port_gid_attr_gid_type,
-							  attr.gid_tbl_len);
-	if (!p->gid_attr_group->type.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_ndev;
-	}
-
-	ret = sysfs_create_group(&p->gid_attr_group->kobj,
-				 &p->gid_attr_group->type);
-	if (ret)
-		goto err_free_gid_type;
-
 	if (attr.pkey_tbl_len) {
 		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
 		if (!p->pkey_group) {
 			ret = -ENOMEM;
-			goto err_remove_gid_type;
+			goto err_remove_gid;
 		}
 
 		p->pkey_group->name  = "pkeys";
@@ -1290,11 +1331,14 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 		if (ret && ret != -EOPNOTSUPP)
 			goto err_remove_pkey;
 	}
+	ret = setup_gid_attrs(p, &attr);
+	if (ret)
+		goto err_remove_stats;
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
-			goto err_remove_stats;
+			goto err_remove_gid_attrs;
 	}
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1304,6 +1348,9 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
 
+err_remove_gid_attrs:
+	destroy_gid_attrs(p);
+
 err_remove_stats:
 	destroy_hw_port_stats(p);
 
@@ -1323,28 +1370,6 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 err_free_pkey_group:
 	kfree(p->pkey_group);
 
-err_remove_gid_type:
-	sysfs_remove_group(&p->gid_attr_group->kobj,
-			   &p->gid_attr_group->type);
-
-err_free_gid_type:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_attr_group->type.attrs[i]);
-
-	kfree(p->gid_attr_group->type.attrs);
-	p->gid_attr_group->type.attrs = NULL;
-
-err_remove_gid_ndev:
-	sysfs_remove_group(&p->gid_attr_group->kobj,
-			   &p->gid_attr_group->ndev);
-
-err_free_gid_ndev:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_attr_group->ndev.attrs[i]);
-
-	kfree(p->gid_attr_group->ndev.attrs);
-	p->gid_attr_group->ndev.attrs = NULL;
-
 err_remove_gid:
 	sysfs_remove_group(&p->kobj, &p->gid_group);
 
@@ -1359,9 +1384,6 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	if (p->pma_table)
 		sysfs_remove_group(&p->kobj, p->pma_table);
 
-err_put_gid_attrs:
-	kobject_put(&p->gid_attr_group->kobj);
-
 err_put:
 	kobject_put(&p->kobj);
 	return ret;
@@ -1498,11 +1520,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		if (port->pkey_group)
 			sysfs_remove_group(p, port->pkey_group);
 		sysfs_remove_group(p, &port->gid_group);
-		sysfs_remove_group(&port->gid_attr_group->kobj,
-				   &port->gid_attr_group->ndev);
-		sysfs_remove_group(&port->gid_attr_group->kobj,
-				   &port->gid_attr_group->type);
-		kobject_put(&port->gid_attr_group->kobj);
+		destroy_gid_attrs(port);
 		kobject_put(p);
 	}
 
-- 
2.31.1

