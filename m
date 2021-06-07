Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A939D70B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFGIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhFGIUL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582D560FF1;
        Mon,  7 Jun 2021 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053900;
        bh=Nf+bTG3O8MGyyVyyfv2aXxeV4I51PtfyJ13mcjwvEKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbTVsaGDotUqYf+JBE1ANeFXyjWTSKCx/2W15a7hbvv+HCB/eLYod/jnzfoOJ6jMJ
         Ncc5NotugrGFND/hHkbdMW9bR+ucVMh8pbucMxBC2NZ9HLEAwhP+u9x2p6liNTro2I
         2727+9K1XS4Td/JFKCClM1kDHw1A/znxDNeqJS40sJuIqx/O1STH43stqEjnKACbsR
         S7kvo7HVQVnSqDedYhjpp5PEAVLHHVANmI+cmxBO+ibOOpiAzm8J3Qvz6ASPwNzSI5
         MMgjljxWj+PuHQVZW1QUXOINeU1kKauWU+6S5N5m1mqGd3jk+0jux/rsKs4+0gjdxv
         m+B5L9LRUSqOQ==
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
Subject: [PATCH rdma-next v1 05/15] RDMA/core: Simplify how the gid_attrs sysfs is created
Date:   Mon,  7 Jun 2021 11:17:30 +0300
Message-Id: <3773a64b8e0daab573e23438f4c1e0ae85cace84.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Instead of having an whole bunch of different allocations to create the
gid_attr kobjects reduce it to three, one for the kobj struct plus the
attributes, and one for the attribute list for each of the two
groups.

Move the freeing of all allocations to the release function.

Reorder the operations so all the allocations happen first then the
kobject & sysfs operations are last.

This removes the majority of the complicated error unwind since the
release function will always undo all the memory allocations. Freeing the
memory is also much simpler since there is a lot less of it.

Consolidate creating the "group of array indexes" pattern into one helper
function. Ensure kobject_del is used.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 170 +++++++++++++++++---------------
 1 file changed, 89 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index d2a089a6f666..006bf759e890 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -47,23 +47,6 @@
 
 struct ib_port;
 
-struct gid_attr_group {
-	struct ib_port		*port;
-	struct kobject		kobj;
-	struct attribute_group	ndev;
-	struct attribute_group	type;
-};
-struct ib_port {
-	struct kobject         kobj;
-	struct ib_device      *ibdev;
-	struct gid_attr_group *gid_attr_group;
-	struct attribute_group gid_group;
-	struct attribute_group *pkey_group;
-	const struct attribute_group *pma_table;
-	struct hw_stats_port_data *hw_stats_data;
-	u32                     port_num;
-};
-
 struct port_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
@@ -84,6 +67,25 @@ struct port_table_attribute {
 	__be16			attr_id;
 };
 
+struct gid_attr_group {
+	struct ib_port *port;
+	struct kobject kobj;
+	struct attribute_group groups[2];
+	const struct attribute_group *groups_list[3];
+	struct port_table_attribute attrs_list[];
+};
+
+struct ib_port {
+	struct kobject kobj;
+	struct ib_device *ibdev;
+	struct gid_attr_group *gid_attr_group;
+	struct attribute_group gid_group;
+	struct attribute_group *pkey_group;
+	const struct attribute_group *pma_table;
+	struct hw_stats_port_data *hw_stats_data;
+	u32 port_num;
+};
+
 struct hw_stats_device_attribute {
 	struct device_attribute attr;
 	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
@@ -776,26 +778,13 @@ static void ib_port_release(struct kobject *kobj)
 
 static void ib_port_gid_attr_release(struct kobject *kobj)
 {
-	struct gid_attr_group *g = container_of(kobj, struct gid_attr_group,
-						kobj);
-	struct attribute *a;
+	struct gid_attr_group *gid_attr_group =
+		container_of(kobj, struct gid_attr_group, kobj);
 	int i;
 
-	if (g->ndev.attrs) {
-		for (i = 0; (a = g->ndev.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(g->ndev.attrs);
-	}
-
-	if (g->type.attrs) {
-		for (i = 0; (a = g->type.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(g->type.attrs);
-	}
-
-	kfree(g);
+	for (i = 0; i != ARRAY_SIZE(gid_attr_group->groups); i++)
+		kfree(gid_attr_group->groups[i].attrs);
+	kfree(gid_attr_group);
 }
 
 static struct kobj_type port_type = {
@@ -1178,6 +1167,41 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
+static int alloc_port_table_group(
+	const char *name, struct attribute_group *group,
+	struct port_table_attribute *attrs, size_t num,
+	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf))
+{
+	struct attribute **attr_list;
+	int i;
+
+	attr_list = kcalloc(num + 1, sizeof(*attr_list), GFP_KERNEL);
+	if (!attr_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		struct port_table_attribute *element = &attrs[i];
+
+		if (snprintf(element->name, sizeof(element->name), "%d", i) >=
+		    sizeof(element->name))
+			goto err;
+
+		sysfs_attr_init(&element->attr.attr);
+		element->attr.attr.name = element->name;
+		element->attr.attr.mode = 0444;
+		element->attr.show = show;
+		element->index = i;
+
+		attr_list[i] = &element->attr.attr;
+	}
+	group->name = name;
+	group->attrs = attr_list;
+	return 0;
+err:
+	kfree(attr_list);
+	return -EINVAL;
+}
+
 /*
  * Create the sysfs:
  *  ibp0s9/ports/XX/gid_attrs/{ndevs,types}/YYY
@@ -1188,60 +1212,44 @@ static int setup_gid_attrs(struct ib_port *port,
 {
 	struct gid_attr_group *gid_attr_group;
 	int ret;
-	int i;
 
-	gid_attr_group = kzalloc(sizeof(*gid_attr_group), GFP_KERNEL);
+	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
+					     attr->gid_tbl_len * 2),
+				 GFP_KERNEL);
 	if (!gid_attr_group)
 		return -ENOMEM;
-
 	gid_attr_group->port = port;
-	ret = kobject_init_and_add(&gid_attr_group->kobj, &gid_attr_type,
-				   &port->kobj, "gid_attrs");
-	if (ret)
-		goto err_put_gid_attrs;
-
-	gid_attr_group->ndev.name = "ndevs";
-	gid_attr_group->ndev.attrs =
-		alloc_group_attrs(show_port_gid_attr_ndev, attr->gid_tbl_len);
-	if (!gid_attr_group->ndev.attrs) {
-		ret = -ENOMEM;
-		goto err_put_gid_attrs;
-	}
+	kobject_init(&gid_attr_group->kobj, &gid_attr_type);
 
-	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
+	ret = alloc_port_table_group("ndevs", &gid_attr_group->groups[0],
+				     gid_attr_group->attrs_list,
+				     attr->gid_tbl_len,
+				     show_port_gid_attr_ndev);
 	if (ret)
-		goto err_free_gid_ndev;
-
-	gid_attr_group->type.name = "types";
-	gid_attr_group->type.attrs = alloc_group_attrs(
-		show_port_gid_attr_gid_type, attr->gid_tbl_len);
-	if (!gid_attr_group->type.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_gid_ndev;
-	}
+		goto err_put;
+	gid_attr_group->groups_list[0] = &gid_attr_group->groups[0];
 
-	ret = sysfs_create_group(&gid_attr_group->kobj, &gid_attr_group->type);
+	ret = alloc_port_table_group(
+		"types", &gid_attr_group->groups[1],
+		gid_attr_group->attrs_list + attr->gid_tbl_len,
+		attr->gid_tbl_len, show_port_gid_attr_gid_type);
 	if (ret)
-		goto err_free_gid_type;
+		goto err_put;
+	gid_attr_group->groups_list[1] = &gid_attr_group->groups[1];
 
+	ret = kobject_add(&gid_attr_group->kobj, &port->kobj, "gid_attrs");
+	if (ret)
+		goto err_put;
+	ret = sysfs_create_groups(&gid_attr_group->kobj,
+				  gid_attr_group->groups_list);
+	if (ret)
+		goto err_del;
 	port->gid_attr_group = gid_attr_group;
 	return 0;
 
-err_free_gid_type:
-	for (i = 0; i < attr->gid_tbl_len; ++i)
-		kfree(gid_attr_group->type.attrs[i]);
-
-	kfree(gid_attr_group->type.attrs);
-	gid_attr_group->type.attrs = NULL;
-err_remove_gid_ndev:
-	sysfs_remove_group(&gid_attr_group->kobj, &gid_attr_group->ndev);
-err_free_gid_ndev:
-	for (i = 0; i < attr->gid_tbl_len; ++i)
-		kfree(gid_attr_group->ndev.attrs[i]);
-
-	kfree(gid_attr_group->ndev.attrs);
-	gid_attr_group->ndev.attrs = NULL;
-err_put_gid_attrs:
+err_del:
+	kobject_del(&gid_attr_group->kobj);
+err_put:
 	kobject_put(&gid_attr_group->kobj);
 	return ret;
 }
@@ -1250,10 +1258,10 @@ static void destroy_gid_attrs(struct ib_port *port)
 {
 	struct gid_attr_group *gid_attr_group = port->gid_attr_group;
 
-	sysfs_remove_group(&gid_attr_group->kobj,
-			   &gid_attr_group->ndev);
-	sysfs_remove_group(&gid_attr_group->kobj,
-			   &gid_attr_group->type);
+	if (!gid_attr_group)
+		return;
+	sysfs_remove_groups(&gid_attr_group->kobj, gid_attr_group->groups_list);
+	kobject_del(&gid_attr_group->kobj);
 	kobject_put(&gid_attr_group->kobj);
 }
 
-- 
2.31.1

