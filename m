Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49B39D714
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFGIUY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFGIUY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6967B61029;
        Mon,  7 Jun 2021 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053913;
        bh=c37feApLc7hkuYbRXAYGuRMLsi4+Mqu/0USL3biW6nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Auw5UB7M61EF6/aMW2/VbQSkxlDxTAVVPEX0UUvId6+2JIaTGuR9CzPJE2/z/PCGg
         mhx20GlxfOykKxroFufIoxfNbMCdjUJuruj0JuY/3ojDhtkW0QBH/KVfZEkvrKxRUi
         LBlxeoJ0GIexqtHjBEAJ1YP7yYxWL8sQkMGZyQi69R26cEF5e7quxvXLBazMxKcTpn
         EexTHVPN8TJhzdw10pJ2FMHBUIblLd8kGcAwAe5rDEaMX/d6nCrNgWTnu6GUNfZOvp
         r6URKyAsI9J5JpoHLMy3cvigFduA7JZQwpHcj6Gvxdkbj2gu1rq6f60ekpvQ6XL9pg
         FPbzoSJBbC9uQ==
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
Subject: [PATCH rdma-next v1 06/15] RDMA/core: Simplify how the port sysfs is created
Date:   Mon,  7 Jun 2021 11:17:31 +0300
Message-Id: <c623ef36124434c22a00bf0beeb996b9c2c7256a.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Use the same technique as gid_attrs now uses to manage the port
sysfs. Bundle everything into three allocations and use a single
sysfs_create_groups() to build everything in one shot.

All the memory is always freed in the kobj release function, removing most
of the error unwinding.

The gid_attr technique and the hw_counters are very similar, merge the two
together and combine the sysfs_create_group() call for hw_counters with
the single sysfs group setup.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 322 ++++++++++----------------------
 1 file changed, 103 insertions(+), 219 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 006bf759e890..2631c179e004 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -79,11 +79,12 @@ struct ib_port {
 	struct kobject kobj;
 	struct ib_device *ibdev;
 	struct gid_attr_group *gid_attr_group;
-	struct attribute_group gid_group;
-	struct attribute_group *pkey_group;
-	const struct attribute_group *pma_table;
 	struct hw_stats_port_data *hw_stats_data;
+
+	struct attribute_group groups[3];
+	const struct attribute_group *groups_list[5];
 	u32 port_num;
+	struct port_table_attribute attrs_list[];
 };
 
 struct hw_stats_device_attribute {
@@ -112,7 +113,6 @@ struct hw_stats_device_data {
 };
 
 struct hw_stats_port_data {
-	struct attribute_group group;
 	struct rdma_hw_stats *stats;
 	struct hw_stats_port_attribute attrs[];
 };
@@ -750,30 +750,15 @@ static const struct attribute_group pma_group_noietf = {
 
 static void ib_port_release(struct kobject *kobj)
 {
-	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-	struct attribute *a;
+	struct ib_port *port = container_of(kobj, struct ib_port, kobj);
 	int i;
 
-	if (p->gid_group.attrs) {
-		for (i = 0; (a = p->gid_group.attrs[i]); ++i)
-			kfree(a);
-
-		kfree(p->gid_group.attrs);
-	}
-
-	if (p->pkey_group) {
-		if (p->pkey_group->attrs) {
-			for (i = 0; (a = p->pkey_group->attrs[i]); ++i)
-				kfree(a);
-
-			kfree(p->pkey_group->attrs);
-		}
-
-		kfree(p->pkey_group);
-		p->pkey_group = NULL;
-	}
-
-	kfree(p);
+	for (i = 0; i != ARRAY_SIZE(port->groups); i++)
+		kfree(port->groups[i].attrs);
+	if (port->hw_stats_data)
+		kfree(port->hw_stats_data->stats);
+	kfree(port->hw_stats_data);
+	kfree(port);
 }
 
 static void ib_port_gid_attr_release(struct kobject *kobj)
@@ -798,49 +783,6 @@ static struct kobj_type gid_attr_type = {
 	.release        = ib_port_gid_attr_release
 };
 
-static struct attribute **
-alloc_group_attrs(ssize_t (*show)(struct ib_port *,
-				  struct port_attribute *, char *buf),
-		  int len)
-{
-	struct attribute **tab_attr;
-	struct port_table_attribute *element;
-	int i;
-
-	tab_attr = kcalloc(1 + len, sizeof(struct attribute *), GFP_KERNEL);
-	if (!tab_attr)
-		return NULL;
-
-	for (i = 0; i < len; i++) {
-		element = kzalloc(sizeof(struct port_table_attribute),
-				  GFP_KERNEL);
-		if (!element)
-			goto err;
-
-		if (snprintf(element->name, sizeof(element->name),
-			     "%d", i) >= sizeof(element->name)) {
-			kfree(element);
-			goto err;
-		}
-
-		element->attr.attr.name  = element->name;
-		element->attr.attr.mode  = S_IRUGO;
-		element->attr.show       = show;
-		element->index		 = i;
-		sysfs_attr_init(&element->attr.attr);
-
-		tab_attr[i] = &element->attr.attr;
-	}
-
-	return tab_attr;
-
-err:
-	while (--i >= 0)
-		kfree(tab_attr[i]);
-	kfree(tab_attr);
-	return NULL;
-}
-
 /*
  * Figure out which counter table to use depending on
  * the device capabilities.
@@ -1051,7 +993,8 @@ static void destroy_hw_device_stats(struct ib_device *ibdev)
 	ibdev->hw_stats_data = NULL;
 }
 
-static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
+static struct hw_stats_port_data *
+alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 {
 	struct ib_device *ibdev = port->ibdev;
 	struct hw_stats_port_data *data;
@@ -1073,13 +1016,13 @@ static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
-	data->group.attrs = kcalloc(stats->num_counters + 2,
-				    sizeof(*data->group.attrs), GFP_KERNEL);
-	if (!data->group.attrs)
+	group->attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*group->attrs), GFP_KERNEL);
+	if (!group->attrs)
 		goto err_free_data;
 
 	mutex_init(&stats->lock);
-	data->group.name = "hw_counters";
+	group->name = "hw_counters";
 	data->stats = stats;
 	return data;
 
@@ -1090,20 +1033,14 @@ static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_hw_stats_port(struct hw_stats_port_data *data)
-{
-	kfree(data->group.attrs);
-	kfree(data->stats);
-	kfree(data);
-}
-
-static int setup_hw_port_stats(struct ib_port *port)
+static int setup_hw_port_stats(struct ib_port *port,
+			       struct attribute_group *group)
 {
 	struct hw_stats_port_attribute *attr;
 	struct hw_stats_port_data *data;
 	int i, ret;
 
-	data = alloc_hw_stats_port(port);
+	data = alloc_hw_stats_port(port, group);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1112,9 +1049,10 @@ static int setup_hw_port_stats(struct ib_port *port)
 					    data->stats->num_counters);
 	if (ret != data->stats->num_counters) {
 		if (WARN_ON(ret >= 0))
-			ret = -EINVAL;
-		goto err_free;
+			return -EINVAL;
+		return ret;
 	}
+
 	data->stats->timestamp = jiffies;
 
 	for (i = 0; i < data->stats->num_counters; i++) {
@@ -1124,7 +1062,7 @@ static int setup_hw_port_stats(struct ib_port *port)
 		attr->attr.attr.mode = 0444;
 		attr->attr.show = hw_stat_port_show;
 		attr->show = show_hw_stats;
-		data->group.attrs[i] = &attr->attr.attr;
+		group->attrs[i] = &attr->attr.attr;
 	}
 
 	attr = &data->attrs[i];
@@ -1135,27 +1073,10 @@ static int setup_hw_port_stats(struct ib_port *port)
 	attr->show = show_stats_lifespan;
 	attr->attr.store = hw_stat_port_store;
 	attr->store = set_stats_lifespan;
-	data->group.attrs[i] = &attr->attr.attr;
+	group->attrs[i] = &attr->attr.attr;
 
 	port->hw_stats_data = data;
-	ret = sysfs_create_group(&port->kobj, &data->group);
-	if (ret)
-		goto err_free;
 	return 0;
-
-err_free:
-	free_hw_stats_port(data);
-	port->hw_stats_data = NULL;
-	return ret;
-}
-
-static void destroy_hw_port_stats(struct ib_port *port)
-{
-	if (!port->hw_stats_data)
-		return;
-	sysfs_remove_group(&port->kobj, &port->hw_stats_data->group);
-	free_hw_stats_port(port->hw_stats_data);
-	port->hw_stats_data = NULL;
 }
 
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
@@ -1265,68 +1186,42 @@ static void destroy_gid_attrs(struct ib_port *port)
 	kobject_put(&gid_attr_group->kobj);
 }
 
-static int add_port(struct ib_core_device *coredev, int port_num)
+/*
+ * Create the sysfs:
+ *  ibp0s9/ports/XX/{gids,pkeys,counters}/YYY
+ */
+static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
+				  const struct ib_port_attr *attr)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
 	bool is_full_dev = &device->coredev == coredev;
+	const struct attribute_group **cur_group;
 	struct ib_port *p;
-	struct ib_port_attr attr;
-	int i;
 	int ret;
 
-	ret = ib_query_port(device, port_num, &attr);
-	if (ret)
-		return ret;
-
-	p = kzalloc(sizeof *p, GFP_KERNEL);
+	p = kzalloc(struct_size(p, attrs_list,
+				attr->gid_tbl_len + attr->pkey_tbl_len),
+		    GFP_KERNEL);
 	if (!p)
-		return -ENOMEM;
-
-	p->ibdev      = device;
-	p->port_num   = port_num;
+		return ERR_PTR(-ENOMEM);
+	p->ibdev = device;
+	p->port_num = port_num;
+	kobject_init(&p->kobj, &port_type);
 
-	ret = kobject_init_and_add(&p->kobj, &port_type,
-				   coredev->ports_kobj,
-				   "%d", port_num);
+	cur_group = p->groups_list;
+	ret = alloc_port_table_group("gids", &p->groups[0], p->attrs_list,
+				     attr->gid_tbl_len, show_port_gid);
 	if (ret)
 		goto err_put;
+	*cur_group++ = &p->groups[0];
 
-	if (device->ops.process_mad && is_full_dev) {
-		p->pma_table = get_counter_table(device, port_num);
-		ret = sysfs_create_group(&p->kobj, p->pma_table);
+	if (attr->pkey_tbl_len) {
+		ret = alloc_port_table_group("pkeys", &p->groups[1],
+					     p->attrs_list + attr->gid_tbl_len,
+					     attr->pkey_tbl_len, show_port_pkey);
 		if (ret)
 			goto err_put;
-	}
-
-	p->gid_group.name  = "gids";
-	p->gid_group.attrs = alloc_group_attrs(show_port_gid, attr.gid_tbl_len);
-	if (!p->gid_group.attrs) {
-		ret = -ENOMEM;
-		goto err_remove_pma;
-	}
-
-	ret = sysfs_create_group(&p->kobj, &p->gid_group);
-	if (ret)
-		goto err_free_gid;
-
-	if (attr.pkey_tbl_len) {
-		p->pkey_group = kzalloc(sizeof(*p->pkey_group), GFP_KERNEL);
-		if (!p->pkey_group) {
-			ret = -ENOMEM;
-			goto err_remove_gid;
-		}
-
-		p->pkey_group->name  = "pkeys";
-		p->pkey_group->attrs = alloc_group_attrs(show_port_pkey,
-							 attr.pkey_tbl_len);
-		if (!p->pkey_group->attrs) {
-			ret = -ENOMEM;
-			goto err_free_pkey_group;
-		}
-
-		ret = sysfs_create_group(&p->kobj, p->pkey_group);
-		if (ret)
-			goto err_free_pkey;
+		*cur_group++ = &p->groups[1];
 	}
 
 	/*
@@ -1335,66 +1230,45 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	 * counter initialization.
 	 */
 	if (port_num && is_full_dev) {
-		ret = setup_hw_port_stats(p);
+		ret = setup_hw_port_stats(p, &p->groups[2]);
 		if (ret && ret != -EOPNOTSUPP)
-			goto err_remove_pkey;
+			goto err_put;
+		if (!ret)
+			*cur_group++ = &p->groups[2];
 	}
-	ret = setup_gid_attrs(p, &attr);
-	if (ret)
-		goto err_remove_stats;
 
-	if (device->ops.init_port && is_full_dev) {
-		ret = device->ops.init_port(device, port_num, &p->kobj);
-		if (ret)
-			goto err_remove_gid_attrs;
-	}
+	if (device->ops.process_mad && is_full_dev)
+		*cur_group++ = get_counter_table(device, port_num);
+
+	ret = kobject_add(&p->kobj, coredev->ports_kobj, "%d", port_num);
+	if (ret)
+		goto err_put;
+	ret = sysfs_create_groups(&p->kobj, p->groups_list);
+	if (ret)
+		goto err_del;
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
 		device->port_data[port_num].sysfs = p;
 
-	kobject_uevent(&p->kobj, KOBJ_ADD);
-	return 0;
-
-err_remove_gid_attrs:
-	destroy_gid_attrs(p);
-
-err_remove_stats:
-	destroy_hw_port_stats(p);
-
-err_remove_pkey:
-	if (p->pkey_group)
-		sysfs_remove_group(&p->kobj, p->pkey_group);
-
-err_free_pkey:
-	if (p->pkey_group) {
-		for (i = 0; i < attr.pkey_tbl_len; ++i)
-			kfree(p->pkey_group->attrs[i]);
-
-		kfree(p->pkey_group->attrs);
-		p->pkey_group->attrs = NULL;
-	}
-
-err_free_pkey_group:
-	kfree(p->pkey_group);
-
-err_remove_gid:
-	sysfs_remove_group(&p->kobj, &p->gid_group);
-
-err_free_gid:
-	for (i = 0; i < attr.gid_tbl_len; ++i)
-		kfree(p->gid_group.attrs[i]);
-
-	kfree(p->gid_group.attrs);
-	p->gid_group.attrs = NULL;
-
-err_remove_pma:
-	if (p->pma_table)
-		sysfs_remove_group(&p->kobj, p->pma_table);
+	return p;
 
+err_del:
+	kobject_del(&p->kobj);
 err_put:
 	kobject_put(&p->kobj);
-	return ret;
+	return ERR_PTR(ret);
+}
+
+static void destroy_port(struct ib_port *port)
+{
+	if (port->ibdev->port_data &&
+	    port->ibdev->port_data[port->port_num].sysfs == port)
+		port->ibdev->port_data[port->port_num].sysfs = NULL;
+	list_del(&port->kobj.entry);
+	sysfs_remove_groups(&port->kobj, port->groups_list);
+	kobject_del(&port->kobj);
+	kobject_put(&port->kobj);
 }
 
 static const char *node_type_string(int node_type)
@@ -1511,25 +1385,13 @@ const struct attribute_group ib_dev_attr_group = {
 
 void ib_free_port_attrs(struct ib_core_device *coredev)
 {
-	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	bool is_full_dev = &device->coredev == coredev;
 	struct kobject *p, *t;
 
 	list_for_each_entry_safe(p, t, &coredev->port_list, entry) {
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
-		list_del(&p->entry);
-		destroy_hw_port_stats(port);
-		if (device->port_data && is_full_dev)
-			device->port_data[port->port_num].sysfs = NULL;
-
-		if (port->pma_table)
-			sysfs_remove_group(p, port->pma_table);
-		if (port->pkey_group)
-			sysfs_remove_group(p, port->pkey_group);
-		sysfs_remove_group(p, &port->gid_group);
 		destroy_gid_attrs(port);
-		kobject_put(p);
+		destroy_port(port);
 	}
 
 	kobject_put(coredev->ports_kobj);
@@ -1538,7 +1400,8 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 int ib_setup_port_attrs(struct ib_core_device *coredev)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
-	u32 port;
+	bool is_full_dev = &device->coredev == coredev;
+	u32 port_num;
 	int ret;
 
 	coredev->ports_kobj = kobject_create_and_add("ports",
@@ -1546,12 +1409,33 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 	if (!coredev->ports_kobj)
 		return -ENOMEM;
 
-	rdma_for_each_port (device, port) {
-		ret = add_port(coredev, port);
+	rdma_for_each_port (device, port_num) {
+		struct ib_port_attr attr;
+		struct ib_port *port;
+
+		ret = ib_query_port(device, port_num, &attr);
 		if (ret)
 			goto err_put;
-	}
 
+		port = setup_port(coredev, port_num, &attr);
+		if (IS_ERR(port)) {
+			ret = PTR_ERR(port);
+			goto err_put;
+		}
+
+		ret = setup_gid_attrs(port, &attr);
+		if (ret)
+			goto err_put;
+
+		if (device->ops.init_port && is_full_dev) {
+			ret = device->ops.init_port(device, port_num,
+						    &port->kobj);
+			if (ret)
+				goto err_put;
+		}
+
+		kobject_uevent(&port->kobj, KOBJ_ADD);
+	}
 	return 0;
 
 err_put:
-- 
2.31.1

