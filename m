Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88739D71A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFGIUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230468AbhFGIUe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A6E46136E;
        Mon,  7 Jun 2021 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053923;
        bh=JjdF7KHps2jdlelXnhE/le3U6OHgk+R1w+i/2ieZA04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpm68+Yc7lMHGKJkvrqDKsJvHq0D6/Oq9wZEWS51L2y1c4KdhW2RvpWXVu/M8H+Un
         PN1ZleDW+dA3wXMAoaiiyytXsxv/iU76SmvgYPUSZ6wGwZUNj21kUiEYn9mVCtpltZ
         /L+gC/Q8LknTYJ7oNglWFcebg+Q+BXl+D3OGZ2tF52RXwURWEbnYMzEU9g9Pgl5oIt
         fqtcBjTIPwq1bq/RURER0W350u2IjrE+pFfwp76GppdjGxITZ6d679Dcvl3AwT6oew
         EksjDq+MnALCF2BEHvFRp/Cfe/Ugfa+iARD32vgfdptqf4k5L45ytZaafbj6b9IHFL
         y10Hpnt6I7Gsg==
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
Subject: [PATCH rdma-next v1 09/15] RDMA/core: Expose the ib port sysfs attribute machinery
Date:   Mon,  7 Jun 2021 11:17:34 +0300
Message-Id: <d95ab4c9fc9f79403d6265a24410404b04505c64.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Other things outside the core code are creating attributes against the
port. This patch exposes the basic machinery to do this.

The ib_port_attribute type allows creating groups of attributes attatched
to the port and comes with the usual machinery to do this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 217 +++++++++++++++++---------------
 include/rdma/ib_sysfs.h         |  41 ++++++
 2 files changed, 158 insertions(+), 100 deletions(-)
 create mode 100644 include/rdma/ib_sysfs.h

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 14b838863b5d..3c5541c39bf6 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -44,24 +44,10 @@
 #include <rdma/ib_pma.h>
 #include <rdma/ib_cache.h>
 #include <rdma/rdma_counter.h>
-
-struct ib_port;
-
-struct port_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
-	ssize_t (*store)(struct ib_port *, struct port_attribute *,
-			 const char *buf, size_t count);
-};
-
-#define PORT_ATTR(_name, _mode, _show, _store) \
-struct port_attribute port_attr_##_name = __ATTR(_name, _mode, _show, _store)
-
-#define PORT_ATTR_RO(_name) \
-struct port_attribute port_attr_##_name = __ATTR_RO(_name)
+#include <rdma/ib_sysfs.h>
 
 struct port_table_attribute {
-	struct port_attribute	attr;
+	struct ib_port_attribute attr;
 	char			name[8];
 	int			index;
 	__be16			attr_id;
@@ -97,7 +83,7 @@ struct hw_stats_device_attribute {
 };
 
 struct hw_stats_port_attribute {
-	struct port_attribute attr;
+	struct ib_port_attribute attr;
 	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 			unsigned int index, unsigned int port_num, char *buf);
 	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
@@ -119,29 +105,55 @@ struct hw_stats_port_data {
 static ssize_t port_attr_show(struct kobject *kobj,
 			      struct attribute *attr, char *buf)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->show)
 		return -EIO;
 
-	return port_attr->show(p, port_attr, buf);
+	return port_attr->show(p->ibdev, p->port_num, port_attr, buf);
 }
 
 static ssize_t port_attr_store(struct kobject *kobj,
 			       struct attribute *attr,
 			       const char *buf, size_t count)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->store)
 		return -EIO;
-	return port_attr->store(p, port_attr, buf, count);
+	return port_attr->store(p->ibdev, p->port_num, port_attr, buf, count);
 }
 
+int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
+				const struct attribute_group **groups)
+{
+	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
+}
+EXPORT_SYMBOL_GPL(ib_port_sysfs_create_groups);
+
+void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
+				 const struct attribute_group **groups)
+{
+	return sysfs_remove_groups(&ibdev->port_data[port_num].sysfs->kobj,
+				   groups);
+}
+EXPORT_SYMBOL_GPL(ib_port_sysfs_remove_groups);
+
+struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
+					       u32 *port_num)
+{
+	struct ib_port *port = container_of(kobj, struct ib_port, kobj);
+
+	*port_num = port->port_num;
+	return port->ibdev;
+}
+EXPORT_SYMBOL(ib_port_sysfs_get_ibdev_kobj);
+
 static const struct sysfs_ops port_sysfs_ops = {
 	.show	= port_attr_show,
 	.store	= port_attr_store
@@ -171,25 +183,27 @@ static ssize_t hw_stat_device_store(struct device *dev,
 				count);
 }
 
-static ssize_t hw_stat_port_show(struct ib_port *port,
-				 struct port_attribute *attr, char *buf)
+static ssize_t hw_stat_port_show(struct ib_device *ibdev, u32 port_num,
+				 struct ib_port_attribute *attr, char *buf)
 {
 	struct hw_stats_port_attribute *stat_attr =
 		container_of(attr, struct hw_stats_port_attribute, attr);
+	struct ib_port *port = ibdev->port_data[port_num].sysfs;
 
-	return stat_attr->show(port->ibdev, port->hw_stats_data->stats,
+	return stat_attr->show(ibdev, port->hw_stats_data->stats,
 			       stat_attr - port->hw_stats_data->attrs,
 			       port->port_num, buf);
 }
 
-static ssize_t hw_stat_port_store(struct ib_port *port,
-				  struct port_attribute *attr, const char *buf,
-				  size_t count)
+static ssize_t hw_stat_port_store(struct ib_device *ibdev, u32 port_num,
+				  struct ib_port_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct hw_stats_port_attribute *stat_attr =
 		container_of(attr, struct hw_stats_port_attribute, attr);
+	struct ib_port *port = ibdev->port_data[port_num].sysfs;
 
-	return stat_attr->store(port->ibdev, port->hw_stats_data->stats,
+	return stat_attr->store(ibdev, port->hw_stats_data->stats,
 				stat_attr - port->hw_stats_data->attrs,
 				port->port_num, buf, count);
 }
@@ -197,23 +211,23 @@ static ssize_t hw_stat_port_store(struct ib_port *port,
 static ssize_t gid_attr_show(struct kobject *kobj,
 			     struct attribute *attr, char *buf)
 {
-	struct port_attribute *port_attr =
-		container_of(attr, struct port_attribute, attr);
+	struct ib_port_attribute *port_attr =
+		container_of(attr, struct ib_port_attribute, attr);
 	struct ib_port *p = container_of(kobj, struct gid_attr_group,
 					 kobj)->port;
 
 	if (!port_attr->show)
 		return -EIO;
 
-	return port_attr->show(p, port_attr, buf);
+	return port_attr->show(p->ibdev, p->port_num, port_attr, buf);
 }
 
 static const struct sysfs_ops gid_attr_sysfs_ops = {
 	.show = gid_attr_show
 };
 
-static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
-			  char *buf)
+static ssize_t state_show(struct ib_device *ibdev, u32 port_num,
+			  struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
@@ -227,7 +241,7 @@ static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
 		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
 	};
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -238,81 +252,80 @@ static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
 				  "UNKNOWN");
 }
 
-static ssize_t lid_show(struct ib_port *p, struct port_attribute *unused,
-			char *buf)
+static ssize_t lid_show(struct ib_device *ibdev, u32 port_num,
+			struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%x\n", attr.lid);
 }
 
-static ssize_t lid_mask_count_show(struct ib_port *p,
-				   struct port_attribute *unused,
-				   char *buf)
+static ssize_t lid_mask_count_show(struct ib_device *ibdev, u32 port_num,
+				   struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d\n", attr.lmc);
 }
 
-static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
-			   char *buf)
+static ssize_t sm_lid_show(struct ib_device *ibdev, u32 port_num,
+			   struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%x\n", attr.sm_lid);
 }
 
-static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
-			  char *buf)
+static ssize_t sm_sl_show(struct ib_device *ibdev, u32 port_num,
+			  struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d\n", attr.sm_sl);
 }
 
-static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
-			     char *buf)
+static ssize_t cap_mask_show(struct ib_device *ibdev, u32 port_num,
+			     struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "0x%08x\n", attr.port_cap_flags);
 }
 
-static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
-			 char *buf)
+static ssize_t rate_show(struct ib_device *ibdev, u32 port_num,
+			 struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 	char *speed = "";
 	int rate;		/* in deci-Gb/sec */
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -379,14 +392,14 @@ static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
 	return "<unknown>";
 }
 
-static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
-			       char *buf)
+static ssize_t phys_state_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *unused, char *buf)
 {
 	struct ib_port_attr attr;
 
 	ssize_t ret;
 
-	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
@@ -394,12 +407,12 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 			  phys_state_to_str(attr.phys_state));
 }
 
-static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
-			       char *buf)
+static ssize_t link_layer_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *unused, char *buf)
 {
 	const char *output;
 
-	switch (rdma_port_get_link_layer(p->ibdev, p->port_num)) {
+	switch (rdma_port_get_link_layer(ibdev, port_num)) {
 	case IB_LINK_LAYER_INFINIBAND:
 		output = "InfiniBand";
 		break;
@@ -414,26 +427,26 @@ static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
 	return sysfs_emit(buf, "%s\n", output);
 }
 
-static PORT_ATTR_RO(state);
-static PORT_ATTR_RO(lid);
-static PORT_ATTR_RO(lid_mask_count);
-static PORT_ATTR_RO(sm_lid);
-static PORT_ATTR_RO(sm_sl);
-static PORT_ATTR_RO(cap_mask);
-static PORT_ATTR_RO(rate);
-static PORT_ATTR_RO(phys_state);
-static PORT_ATTR_RO(link_layer);
+static IB_PORT_ATTR_RO(state);
+static IB_PORT_ATTR_RO(lid);
+static IB_PORT_ATTR_RO(lid_mask_count);
+static IB_PORT_ATTR_RO(sm_lid);
+static IB_PORT_ATTR_RO(sm_sl);
+static IB_PORT_ATTR_RO(cap_mask);
+static IB_PORT_ATTR_RO(rate);
+static IB_PORT_ATTR_RO(phys_state);
+static IB_PORT_ATTR_RO(link_layer);
 
 static struct attribute *port_default_attrs[] = {
-	&port_attr_state.attr,
-	&port_attr_lid.attr,
-	&port_attr_lid_mask_count.attr,
-	&port_attr_sm_lid.attr,
-	&port_attr_sm_sl.attr,
-	&port_attr_cap_mask.attr,
-	&port_attr_rate.attr,
-	&port_attr_phys_state.attr,
-	&port_attr_link_layer.attr,
+	&ib_port_attr_state.attr,
+	&ib_port_attr_lid.attr,
+	&ib_port_attr_lid_mask_count.attr,
+	&ib_port_attr_sm_lid.attr,
+	&ib_port_attr_sm_sl.attr,
+	&ib_port_attr_cap_mask.attr,
+	&ib_port_attr_rate.attr,
+	&ib_port_attr_phys_state.attr,
+	&ib_port_attr_link_layer.attr,
 	NULL
 };
 
@@ -457,7 +470,8 @@ static ssize_t print_gid_type(const struct ib_gid_attr *gid_attr, char *buf)
 }
 
 static ssize_t _show_port_gid_attr(
-	struct ib_port *p, struct port_attribute *attr, char *buf,
+	struct ib_device *ibdev, u32 port_num, struct ib_port_attribute *attr,
+	char *buf,
 	ssize_t (*print)(const struct ib_gid_attr *gid_attr, char *buf))
 {
 	struct port_table_attribute *tab_attr =
@@ -465,7 +479,7 @@ static ssize_t _show_port_gid_attr(
 	const struct ib_gid_attr *gid_attr;
 	ssize_t ret;
 
-	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
+	gid_attr = rdma_get_gid_attr(ibdev, port_num, tab_attr->index);
 	if (IS_ERR(gid_attr))
 		/* -EINVAL is returned for user space compatibility reasons. */
 		return -EINVAL;
@@ -475,15 +489,15 @@ static ssize_t _show_port_gid_attr(
 	return ret;
 }
 
-static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
-			     char *buf)
+static ssize_t show_port_gid(struct ib_device *ibdev, u32 port_num,
+			     struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	const struct ib_gid_attr *gid_attr;
 	int len;
 
-	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
+	gid_attr = rdma_get_gid_attr(ibdev, port_num, tab_attr->index);
 	if (IS_ERR(gid_attr)) {
 		const union ib_gid zgid = {};
 
@@ -504,28 +518,30 @@ static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
 	return len;
 }
 
-static ssize_t show_port_gid_attr_ndev(struct ib_port *p,
-				       struct port_attribute *attr, char *buf)
+static ssize_t show_port_gid_attr_ndev(struct ib_device *ibdev, u32 port_num,
+				       struct ib_port_attribute *attr,
+				       char *buf)
 {
-	return _show_port_gid_attr(p, attr, buf, print_ndev);
+	return _show_port_gid_attr(ibdev, port_num, attr, buf, print_ndev);
 }
 
-static ssize_t show_port_gid_attr_gid_type(struct ib_port *p,
-					   struct port_attribute *attr,
+static ssize_t show_port_gid_attr_gid_type(struct ib_device *ibdev,
+					   u32 port_num,
+					   struct ib_port_attribute *attr,
 					   char *buf)
 {
-	return _show_port_gid_attr(p, attr, buf, print_gid_type);
+	return _show_port_gid_attr(ibdev, port_num, attr, buf, print_gid_type);
 }
 
-static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
-			      char *buf)
+static ssize_t show_port_pkey(struct ib_device *ibdev, u32 port_num,
+			      struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	u16 pkey;
 	int ret;
 
-	ret = ib_query_pkey(p->ibdev, p->port_num, tab_attr->index, &pkey);
+	ret = ib_query_pkey(ibdev, port_num, tab_attr->index, &pkey);
 	if (ret)
 		return ret;
 
@@ -594,8 +610,8 @@ static int get_perf_mad(struct ib_device *dev, int port_num, __be16 attr,
 	return ret;
 }
 
-static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
-				char *buf)
+static ssize_t show_pma_counter(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, char *buf)
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
@@ -605,7 +621,7 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 	u8 data[8];
 	int len;
 
-	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
+	ret = get_perf_mad(ibdev, port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
 	if (ret < 0)
 		return ret;
@@ -1077,10 +1093,11 @@ struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
 	return ibdev->port_data[port_num].sysfs->hw_stats_data->stats;
 }
 
-static int alloc_port_table_group(
-	const char *name, struct attribute_group *group,
-	struct port_table_attribute *attrs, size_t num,
-	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf))
+static int
+alloc_port_table_group(const char *name, struct attribute_group *group,
+		       struct port_table_attribute *attrs, size_t num,
+		       ssize_t (*show)(struct ib_device *ibdev, u32 port_num,
+				       struct ib_port_attribute *, char *buf))
 {
 	struct attribute **attr_list;
 	int i;
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
new file mode 100644
index 000000000000..f869d0e4fd30
--- /dev/null
+++ b/include/rdma/ib_sysfs.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (c) 2021 Mellanox Technologies Ltd.  All rights reserved.
+ */
+#ifndef DEF_RDMA_IB_SYSFS_H
+#define DEF_RDMA_IB_SYSFS_H
+
+#include <linux/sysfs.h>
+
+struct ib_device;
+
+struct ib_port_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct ib_device *ibdev, u32 port_num,
+			struct ib_port_attribute *attr, char *buf);
+	ssize_t (*store)(struct ib_device *ibdev, u32 port_num,
+			 struct ib_port_attribute *attr, const char *buf,
+			 size_t count);
+};
+
+#define IB_PORT_ATTR_RW(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_RW(_name)
+
+#define IB_PORT_ATTR_ADMIN_RW(_name)                                           \
+	struct ib_port_attribute ib_port_attr_##_name =                        \
+		__ATTR_RW_MODE(_name, 0600)
+
+#define IB_PORT_ATTR_RO(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_RO(_name)
+
+#define IB_PORT_ATTR_WO(_name)                                                 \
+	struct ib_port_attribute ib_port_attr_##_name = __ATTR_WO(_name)
+
+int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
+				const struct attribute_group **groups);
+void ib_port_sysfs_remove_groups(struct ib_device *ibdev, u32 port_num,
+				 const struct attribute_group **groups);
+struct ib_device *ib_port_sysfs_get_ibdev_kobj(struct kobject *kobj,
+					       u32 *port_num);
+
+#endif
-- 
2.31.1

