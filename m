Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A739D70D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFGIUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFGIUO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2BB160FEF;
        Mon,  7 Jun 2021 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053903;
        bh=tQQB4PtxfCxw7kXjHJdc37cps7bFY5A2WnTx09kx/Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ7CxISHajFmVcKFezMmKGb+A75/DtwNmtzu2S4d3zJvnbu1VqliBQLZ8BbDsfCb6
         VYBHsgH/ohmuHR6eAaXlLbshFror/JZnUium0MKMtTOXBx+ShwE1wfXZ9zXAge3vgW
         wFEosldLOsQ5dh4DCbsL8IGb9z6Tl0H34fLVW2AYxeSaF/wUGoFyK3rKWhibtwQg63
         5RBKLOsaMzJMX4gBe9EeILDAlHQRV89X6RCTn3cGKTOVOZBHB7mXtn+HhYbmb3aXBp
         KXmjPN21Pnj7KWPawk8Ou9yxiTET58ca5InnAHjrys0eorMgIGiyW/1mzQoatFODXl
         JcX6QHWjyJbdA==
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
Subject: [PATCH rdma-next v1 03/15] RDMA/core: Split port and device counter sysfs attributes
Date:   Mon,  7 Jun 2021 11:17:28 +0300
Message-Id: <2276c833a9f6790224ad20e51be7a0a4427c2462.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This code creates a 'struct hw_stats_attribute' for each sysfs entry that
contains a naked 'struct attribute' inside.

It then proceeds to attach this same structure to a 'struct device' kobj
and a 'struct ib_port' kobj. However, this violates the typing
requirements.  'struct device' requires the attribute to be a 'struct
device_attribute' and 'struct ib_port' requires the attribute to be
'struct port_attribute'.

This happens to work because the show/store function pointers in all three
structures happen to be at the same offset and happen to be nearly the
same signature. This means when container_of() was used to go between the
wrong two types it still managed to work.

However clang CFI detection notices that the function pointers have a
slightly different signature. As with show/store this was only working
because the device and port struct layouts happened to have the kobj at
the front.

Correct this by have two independent sets of data structures for the port
and device case. The two different attributes correctly include the
port/device_attribute struct and everything from there up is kept
split. The show/store function call chains start with device/port unique
functions that invoke a common show/store function pointer.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 458 ++++++++++++++++++++------------
 include/rdma/ib_verbs.h         |   4 +-
 2 files changed, 292 insertions(+), 170 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index b153dee1e0fa..114fecda9764 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -60,8 +60,7 @@ struct ib_port {
 	struct attribute_group gid_group;
 	struct attribute_group *pkey_group;
 	const struct attribute_group *pma_table;
-	struct attribute_group *hw_stats_ag;
-	struct rdma_hw_stats   *hw_stats;
+	struct hw_stats_port_data *hw_stats_data;
 	u32                     port_num;
 };
 
@@ -85,16 +84,35 @@ struct port_table_attribute {
 	__be16			attr_id;
 };
 
-struct hw_stats_attribute {
-	struct attribute	attr;
-	ssize_t			(*show)(struct kobject *kobj,
-					struct attribute *attr, char *buf);
-	ssize_t			(*store)(struct kobject *kobj,
-					 struct attribute *attr,
-					 const char *buf,
-					 size_t count);
-	int			index;
-	u32			port_num;
+struct hw_stats_device_attribute {
+	struct device_attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			unsigned int index, unsigned int port_num, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 unsigned int index, unsigned int port_num,
+			 const char *buf, size_t count);
+};
+
+struct hw_stats_port_attribute {
+	struct port_attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			unsigned int index, unsigned int port_num, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			 unsigned int index, unsigned int port_num,
+			 const char *buf, size_t count);
+};
+
+struct hw_stats_device_data {
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
+	struct rdma_hw_stats *stats;
+	struct hw_stats_device_attribute attrs[];
+};
+
+struct hw_stats_port_data {
+	struct attribute_group group;
+	struct rdma_hw_stats *stats;
+	struct hw_stats_port_attribute attrs[];
 };
 
 static ssize_t port_attr_show(struct kobject *kobj,
@@ -128,6 +146,53 @@ static const struct sysfs_ops port_sysfs_ops = {
 	.store	= port_attr_store
 };
 
+static ssize_t hw_stat_device_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct hw_stats_device_attribute *stat_attr =
+		container_of(attr, struct hw_stats_device_attribute, attr);
+	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+
+	return stat_attr->show(ibdev, ibdev->hw_stats_data->stats,
+			       stat_attr - ibdev->hw_stats_data->attrs, 0, buf);
+}
+
+static ssize_t hw_stat_device_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct hw_stats_device_attribute *stat_attr =
+		container_of(attr, struct hw_stats_device_attribute, attr);
+	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+
+	return stat_attr->store(ibdev, ibdev->hw_stats_data->stats,
+				stat_attr - ibdev->hw_stats_data->attrs, 0, buf,
+				count);
+}
+
+static ssize_t hw_stat_port_show(struct ib_port *port,
+				 struct port_attribute *attr, char *buf)
+{
+	struct hw_stats_port_attribute *stat_attr =
+		container_of(attr, struct hw_stats_port_attribute, attr);
+
+	return stat_attr->show(port->ibdev, port->hw_stats_data->stats,
+			       stat_attr - port->hw_stats_data->attrs,
+			       port->port_num, buf);
+}
+
+static ssize_t hw_stat_port_store(struct ib_port *port,
+				  struct port_attribute *attr, const char *buf,
+				  size_t count)
+{
+	struct hw_stats_port_attribute *stat_attr =
+		container_of(attr, struct hw_stats_port_attribute, attr);
+
+	return stat_attr->store(port->ibdev, port->hw_stats_data->stats,
+				stat_attr - port->hw_stats_data->attrs,
+				port->port_num, buf, count);
+}
+
 static ssize_t gid_attr_show(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
@@ -835,56 +900,30 @@ static int print_hw_stat(struct ib_device *dev, int port_num,
 	return sysfs_emit(buf, "%llu\n", stats->value[index] + v);
 }
 
-static ssize_t show_hw_stats(struct kobject *kobj, struct attribute *attr,
-			     char *buf)
+static ssize_t show_hw_stats(struct ib_device *ibdev,
+			     struct rdma_hw_stats *stats, unsigned int index,
+			     unsigned int port_num, char *buf)
 {
-	struct ib_device *dev;
-	struct ib_port *port;
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int ret;
 
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		dev = container_of((struct device *)kobj,
-				   struct ib_device, dev);
-		stats = dev->hw_stats;
-	} else {
-		port = container_of(kobj, struct ib_port, kobj);
-		dev = port->ibdev;
-		stats = port->hw_stats;
-	}
 	mutex_lock(&stats->lock);
-	ret = update_hw_stats(dev, stats, hsa->port_num, hsa->index);
+	ret = update_hw_stats(ibdev, stats, port_num, index);
 	if (ret)
 		goto unlock;
-	ret = print_hw_stat(dev, hsa->port_num, stats, hsa->index, buf);
+	ret = print_hw_stat(ibdev, port_num, stats, index, buf);
 unlock:
 	mutex_unlock(&stats->lock);
 
 	return ret;
 }
 
-static ssize_t show_stats_lifespan(struct kobject *kobj,
-				   struct attribute *attr,
+static ssize_t show_stats_lifespan(struct ib_device *ibdev,
+				   struct rdma_hw_stats *stats,
+				   unsigned int index, unsigned int port_num,
 				   char *buf)
 {
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int msecs;
 
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		struct ib_device *dev = container_of((struct device *)kobj,
-						     struct ib_device, dev);
-
-		stats = dev->hw_stats;
-	} else {
-		struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-
-		stats = p->hw_stats;
-	}
-
 	mutex_lock(&stats->lock);
 	msecs = jiffies_to_msecs(stats->lifespan);
 	mutex_unlock(&stats->lock);
@@ -892,12 +931,11 @@ static ssize_t show_stats_lifespan(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", msecs);
 }
 
-static ssize_t set_stats_lifespan(struct kobject *kobj,
-				  struct attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t set_stats_lifespan(struct ib_device *ibdev,
+				   struct rdma_hw_stats *stats,
+				   unsigned int index, unsigned int port_num,
+				   const char *buf, size_t count)
 {
-	struct hw_stats_attribute *hsa;
-	struct rdma_hw_stats *stats;
 	int msecs;
 	int jiffies;
 	int ret;
@@ -908,17 +946,6 @@ static ssize_t set_stats_lifespan(struct kobject *kobj,
 	if (msecs < 0 || msecs > 10000)
 		return -EINVAL;
 	jiffies = msecs_to_jiffies(msecs);
-	hsa = container_of(attr, struct hw_stats_attribute, attr);
-	if (!hsa->port_num) {
-		struct ib_device *dev = container_of((struct device *)kobj,
-						     struct ib_device, dev);
-
-		stats = dev->hw_stats;
-	} else {
-		struct ib_port *p = container_of(kobj, struct ib_port, kobj);
-
-		stats = p->hw_stats;
-	}
 
 	mutex_lock(&stats->lock);
 	stats->lifespan = jiffies;
@@ -927,67 +954,125 @@ static ssize_t set_stats_lifespan(struct kobject *kobj,
 	return count;
 }
 
-static void free_hsag(struct kobject *kobj, struct attribute_group *attr_group)
+static struct hw_stats_device_data *
+alloc_hw_stats_device(struct ib_device *ibdev)
 {
-	struct attribute **attr;
+	struct hw_stats_device_data *data;
+	struct rdma_hw_stats *stats;
+
+	if (!ibdev->ops.alloc_hw_device_stats)
+		return ERR_PTR(-EOPNOTSUPP);
+	stats = ibdev->ops.alloc_hw_device_stats(ibdev);
+	if (!stats)
+		return ERR_PTR(-ENOMEM);
+	if (!stats->names || stats->num_counters <= 0)
+		goto err_free_stats;
+
+	/*
+	 * Two extra attribue elements here, one for the lifespan entry and
+	 * one to NULL terminate the list for the sysfs core code
+	 */
+	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+		       GFP_KERNEL);
+	if (!data)
+		goto err_free_stats;
+	data->group.attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*data->group.attrs), GFP_KERNEL);
+	if (!data->group.attrs)
+		goto err_free_data;
 
-	sysfs_remove_group(kobj, attr_group);
+	mutex_init(&stats->lock);
+	data->group.name = "hw_counters";
+	data->stats = stats;
+	data->groups[0] = &data->group;
+	return data;
 
-	for (attr = attr_group->attrs; *attr; attr++)
-		kfree(*attr);
-	kfree(attr_group);
+err_free_data:
+	kfree(data);
+err_free_stats:
+	kfree(stats);
+	return ERR_PTR(-ENOMEM);
 }
 
-static struct attribute *alloc_hsa(int index, u32 port_num, const char *name)
+static void free_hw_stats_device(struct hw_stats_device_data *data)
 {
-	struct hw_stats_attribute *hsa;
+	kfree(data->group.attrs);
+	kfree(data->stats);
+	kfree(data);
+}
 
-	hsa = kmalloc(sizeof(*hsa), GFP_KERNEL);
-	if (!hsa)
-		return NULL;
+static int setup_hw_device_stats(struct ib_device *ibdev)
+{
+	struct hw_stats_device_attribute *attr;
+	struct hw_stats_device_data *data;
+	int i, ret;
 
-	hsa->attr.name = (char *)name;
-	hsa->attr.mode = S_IRUGO;
-	hsa->show = show_hw_stats;
-	hsa->store = NULL;
-	hsa->index = index;
-	hsa->port_num = port_num;
+	data = alloc_hw_stats_device(ibdev);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	return &hsa->attr;
-}
+	ret = ibdev->ops.get_hw_stats(ibdev, data->stats, 0,
+				      data->stats->num_counters);
+	if (ret != data->stats->num_counters) {
+		if (WARN_ON(ret >= 0))
+			ret = -EINVAL;
+		goto err_free;
+	}
 
-static struct attribute *alloc_hsa_lifespan(char *name, u32 port_num)
-{
-	struct hw_stats_attribute *hsa;
+	data->stats->timestamp = jiffies;
 
-	hsa = kmalloc(sizeof(*hsa), GFP_KERNEL);
-	if (!hsa)
-		return NULL;
+	for (i = 0; i < data->stats->num_counters; i++) {
+		attr = &data->attrs[i];
+		sysfs_attr_init(&attr->attr.attr);
+		attr->attr.attr.name = data->stats->names[i];
+		attr->attr.attr.mode = 0444;
+		attr->attr.show = hw_stat_device_show;
+		attr->show = show_hw_stats;
+		data->group.attrs[i] = &attr->attr.attr;
+	}
+
+	attr = &data->attrs[i];
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = "lifespan";
+	attr->attr.attr.mode = 0644;
+	attr->attr.show = hw_stat_device_show;
+	attr->show = show_stats_lifespan;
+	attr->attr.store = hw_stat_device_store;
+	attr->store = set_stats_lifespan;
+	data->group.attrs[i] = &attr->attr.attr;
+
+	ibdev->hw_stats_data = data;
+	ret = device_add_groups(&ibdev->dev, data->groups);
+	if (ret)
+		goto err_free;
+	return 0;
 
-	hsa->attr.name = name;
-	hsa->attr.mode = S_IWUSR | S_IRUGO;
-	hsa->show = show_stats_lifespan;
-	hsa->store = set_stats_lifespan;
-	hsa->index = 0;
-	hsa->port_num = port_num;
+err_free:
+	free_hw_stats_device(data);
+	ibdev->hw_stats_data = NULL;
+	return ret;
+}
 
-	return &hsa->attr;
+static void destroy_hw_device_stats(struct ib_device *ibdev)
+{
+	if (!ibdev->hw_stats_data)
+		return;
+	device_remove_groups(&ibdev->dev, ibdev->hw_stats_data->groups);
+	free_hw_stats_device(ibdev->hw_stats_data);
+	ibdev->hw_stats_data = NULL;
 }
 
-static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
-			   u32 port_num)
+static struct hw_stats_port_data *alloc_hw_stats_port(struct ib_port *port)
 {
-	struct attribute_group *hsag;
+	struct ib_device *ibdev = port->ibdev;
+	struct hw_stats_port_data *data;
 	struct rdma_hw_stats *stats;
-	int i, ret;
 
-	if (port_num)
-		stats = device->ops.alloc_hw_port_stats(device, port_num);
-	else
-		stats = device->ops.alloc_hw_device_stats(device);
+	if (!ibdev->ops.alloc_hw_port_stats)
+		return ERR_PTR(-EOPNOTSUPP);
+	stats = ibdev->ops.alloc_hw_port_stats(port->ibdev, port->port_num);
 	if (!stats)
-		return;
-
+		return ERR_PTR(-ENOMEM);
 	if (!stats->names || stats->num_counters <= 0)
 		goto err_free_stats;
 
@@ -995,68 +1080,102 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	hsag = kzalloc(sizeof(*hsag) +
-		       sizeof(void *) * (stats->num_counters + 2),
+	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
 		       GFP_KERNEL);
-	if (!hsag)
+	if (!data)
 		goto err_free_stats;
+	data->group.attrs = kcalloc(stats->num_counters + 2,
+				    sizeof(*data->group.attrs), GFP_KERNEL);
+	if (!data->group.attrs)
+		goto err_free_data;
 
-	ret = device->ops.get_hw_stats(device, stats, port_num,
-				       stats->num_counters);
-	if (ret != stats->num_counters)
-		goto err_free_hsag;
+	mutex_init(&stats->lock);
+	data->group.name = "hw_counters";
+	data->stats = stats;
+	return data;
 
-	stats->timestamp = jiffies;
+err_free_data:
+	kfree(data);
+err_free_stats:
+	kfree(stats);
+	return ERR_PTR(-ENOMEM);
+}
 
-	hsag->name = "hw_counters";
-	hsag->attrs = (void *)hsag + sizeof(*hsag);
+static void free_hw_stats_port(struct hw_stats_port_data *data)
+{
+	kfree(data->group.attrs);
+	kfree(data->stats);
+	kfree(data);
+}
 
-	for (i = 0; i < stats->num_counters; i++) {
-		hsag->attrs[i] = alloc_hsa(i, port_num, stats->names[i]);
-		if (!hsag->attrs[i])
-			goto err;
-		sysfs_attr_init(hsag->attrs[i]);
-	}
+static int setup_hw_port_stats(struct ib_port *port)
+{
+	struct hw_stats_port_attribute *attr;
+	struct hw_stats_port_data *data;
+	int i, ret;
 
-	mutex_init(&stats->lock);
-	/* treat an error here as non-fatal */
-	hsag->attrs[i] = alloc_hsa_lifespan("lifespan", port_num);
-	if (hsag->attrs[i])
-		sysfs_attr_init(hsag->attrs[i]);
-
-	if (port) {
-		struct kobject *kobj = &port->kobj;
-		ret = sysfs_create_group(kobj, hsag);
-		if (ret)
-			goto err;
-		port->hw_stats_ag = hsag;
-		port->hw_stats = stats;
-	} else {
-		struct kobject *kobj = &device->dev.kobj;
-		ret = sysfs_create_group(kobj, hsag);
-		if (ret)
-			goto err;
-		device->hw_stats_ag = hsag;
-		device->hw_stats = stats;
+	data = alloc_hw_stats_port(port);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret = port->ibdev->ops.get_hw_stats(port->ibdev, data->stats,
+					    port->port_num,
+					    data->stats->num_counters);
+	if (ret != data->stats->num_counters) {
+		if (WARN_ON(ret >= 0))
+			ret = -EINVAL;
+		goto err_free;
+	}
+	data->stats->timestamp = jiffies;
+
+	for (i = 0; i < data->stats->num_counters; i++) {
+		attr = &data->attrs[i];
+		sysfs_attr_init(&attr->attr.attr);
+		attr->attr.attr.name = data->stats->names[i];
+		attr->attr.attr.mode = 0444;
+		attr->attr.show = hw_stat_port_show;
+		attr->show = show_hw_stats;
+		data->group.attrs[i] = &attr->attr.attr;
 	}
 
-	return;
+	attr = &data->attrs[i];
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = "lifespan";
+	attr->attr.attr.mode = 0644;
+	attr->attr.show = hw_stat_port_show;
+	attr->show = show_stats_lifespan;
+	attr->attr.store = hw_stat_port_store;
+	attr->store = set_stats_lifespan;
+	data->group.attrs[i] = &attr->attr.attr;
+
+	port->hw_stats_data = data;
+	ret = sysfs_create_group(&port->kobj, &data->group);
+	if (ret)
+		goto err_free;
+	return 0;
 
-err:
-	for (; i >= 0; i--)
-		kfree(hsag->attrs[i]);
-err_free_hsag:
-	kfree(hsag);
-err_free_stats:
-	kfree(stats);
+err_free:
+	free_hw_stats_port(data);
+	port->hw_stats_data = NULL;
+	return ret;
+}
+
+static void destroy_hw_port_stats(struct ib_port *port)
+{
+	if (!port->hw_stats_data)
+		return;
+	sysfs_remove_group(&port->kobj, &port->hw_stats_data->group);
+	free_hw_stats_port(port->hw_stats_data);
+	port->hw_stats_data = NULL;
 }
 
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 					   u32 port_num)
 {
-	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num))
+	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num) ||
+	    !ibdev->port_data[port_num].sysfs->hw_stats_data)
 		return NULL;
-	return ibdev->port_data[port_num].sysfs->hw_stats;
+	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
 static int add_port(struct ib_core_device *coredev, int port_num)
@@ -1161,21 +1280,23 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 			goto err_free_pkey;
 	}
 
+	/*
+	 * If port == 0, it means hw_counters are per device and not per
+	 * port, so holder should be device. Therefore skip per port
+	 * counter initialization.
+	 */
+	if (port_num && is_full_dev) {
+		ret = setup_hw_port_stats(p);
+		if (ret && ret != -EOPNOTSUPP)
+			goto err_remove_pkey;
+	}
 
 	if (device->ops.init_port && is_full_dev) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
-			goto err_remove_pkey;
+			goto err_remove_stats;
 	}
 
-	/*
-	 * If port == 0, it means hw_counters are per device and not per
-	 * port, so holder should be device. Therefore skip per port conunter
-	 * initialization.
-	 */
-	if (device->ops.alloc_hw_port_stats && port_num && is_full_dev)
-		setup_hw_stats(device, p, port_num);
-
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
 		device->port_data[port_num].sysfs = p;
@@ -1183,6 +1304,9 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
 
+err_remove_stats:
+	destroy_hw_port_stats(p);
+
 err_remove_pkey:
 	if (p->pkey_group)
 		sysfs_remove_group(&p->kobj, p->pkey_group);
@@ -1365,9 +1489,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
 		list_del(&p->entry);
-		if (port->hw_stats_ag)
-			free_hsag(&port->kobj, port->hw_stats_ag);
-		kfree(port->hw_stats);
+		destroy_hw_port_stats(port);
 		if (device->port_data && is_full_dev)
 			device->port_data[port->port_num].sysfs = NULL;
 
@@ -1419,18 +1541,18 @@ int ib_device_register_sysfs(struct ib_device *device)
 	if (ret)
 		return ret;
 
-	if (device->ops.alloc_hw_device_stats)
-		setup_hw_stats(device, NULL, 0);
+	ret = setup_hw_device_stats(device);
+	if (ret && ret != -EOPNOTSUPP) {
+		ib_free_port_attrs(&device->coredev);
+		return ret;
+	}
 
 	return 0;
 }
 
 void ib_device_unregister_sysfs(struct ib_device *device)
 {
-	if (device->hw_stats_ag)
-		free_hsag(&device->dev.kobj, device->hw_stats_ag);
-	kfree(device->hw_stats);
-
+	destroy_hw_device_stats(device);
 	ib_free_port_attrs(&device->coredev);
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7a4cb7022f91..0dc7ab1a8dcf 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -51,6 +51,7 @@ struct ib_usrq_object;
 struct ib_uwq_object;
 struct rdma_cm_id;
 struct ib_port;
+struct hw_stats_device_data;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2695,8 +2696,7 @@ struct ib_device {
 	u8                           node_type;
 	u32			     phys_port_cnt;
 	struct ib_device_attr        attrs;
-	struct attribute_group	     *hw_stats_ag;
-	struct rdma_hw_stats         *hw_stats;
+	struct hw_stats_device_data *hw_stats_data;
 
 #ifdef CONFIG_CGROUP_RDMA
 	struct rdmacg_device         cg_device;
-- 
2.31.1

