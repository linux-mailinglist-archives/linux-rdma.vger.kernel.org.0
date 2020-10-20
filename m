Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75200286CD6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgJHCg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:36:56 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:51428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727663AbgJHCg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:36:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A80CE181D341E;
        Thu,  8 Oct 2020 02:36:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:327:355:379:541:800:960:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3867:4321:4605:5007:6119:6261:6642:6737:7903:7904:8957:9036:9592:10004:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:13894:14394:14877:21080:21099:21433:21451:21611:21627:21990:30029:30045:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stamp15_320b755271d4
X-Filterd-Recvd-Size: 26707
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:36:52 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 4/4] RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit
Date:   Wed,  7 Oct 2020 19:36:27 -0700
Message-Id: <ecde7791467cddb570c6f6d2c908ffbab9145cac.1602122880.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1602122879.git.joe@perches.com>
References: <cover.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Manual changes for sysfs_emit as cocci scripts can't easily convert them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/infiniband/core/cm.c                 |  4 +-
 drivers/infiniband/core/cma_configfs.c       |  4 +-
 drivers/infiniband/core/sysfs.c              | 98 +++++++++++---------
 drivers/infiniband/core/user_mad.c           |  2 +-
 drivers/infiniband/hw/hfi1/sysfs.c           | 10 +-
 drivers/infiniband/hw/mlx4/sysfs.c           | 19 ++--
 drivers/infiniband/hw/qib/qib_sysfs.c        | 30 +++---
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 34 +++----
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 14 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  7 +-
 drivers/infiniband/ulp/srp/ib_srp.c          |  4 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c        | 14 +--
 12 files changed, 119 insertions(+), 121 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 5740d1ba3568..020136497459 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4271,8 +4271,8 @@ static ssize_t cm_show_counter(struct kobject *obj, struct attribute *attr,
 	group = container_of(obj, struct cm_counter_group, obj);
 	cm_attr = container_of(attr, struct cm_counter_attribute, attr);
 
-	return sprintf(buf, "%ld\n",
-		       atomic_long_read(&group->counter[cm_attr->index]));
+	return sysfs_emit(buf, "%ld\n",
+			  atomic_long_read(&group->counter[cm_attr->index]));
 }
 
 static const struct sysfs_ops cm_counter_ops = {
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 7ec4af2ed87a..7f70e5a7de10 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -115,7 +115,7 @@ static ssize_t default_roce_mode_show(struct config_item *item,
 	if (gid_type < 0)
 		return gid_type;
 
-	return sprintf(buf, "%s\n", ib_cache_gid_type_str(gid_type));
+	return sysfs_emit(buf, "%s\n", ib_cache_gid_type_str(gid_type));
 }
 
 static ssize_t default_roce_mode_store(struct config_item *item,
@@ -157,7 +157,7 @@ static ssize_t default_roce_tos_show(struct config_item *item, char *buf)
 	tos = cma_get_default_roce_tos(cma_dev, group->port_num);
 	cma_configfs_params_put(cma_dev);
 
-	return sprintf(buf, "%u\n", tos);
+	return sysfs_emit(buf, "%u\n", tos);
 }
 
 static ssize_t default_roce_tos_store(struct config_item *item,
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index cbc8326b935d..bffed464509d 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -165,9 +165,11 @@ static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d: %s\n", attr.state,
-		       attr.state >= 0 && attr.state < ARRAY_SIZE(state_name) ?
-		       state_name[attr.state] : "UNKNOWN");
+	return sysfs_emit(buf, "%d: %s\n",
+			  attr.state,
+			  attr.state >= 0 &&
+			  attr.state < ARRAY_SIZE(state_name) ?
+			  state_name[attr.state] : "UNKNOWN");
 }
 
 static ssize_t lid_show(struct ib_port *p, struct port_attribute *unused,
@@ -180,7 +182,7 @@ static ssize_t lid_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "0x%x\n", attr.lid);
+	return sysfs_emit(buf, "0x%x\n", attr.lid);
 }
 
 static ssize_t lid_mask_count_show(struct ib_port *p,
@@ -194,7 +196,7 @@ static ssize_t lid_mask_count_show(struct ib_port *p,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", attr.lmc);
+	return sysfs_emit(buf, "%d\n", attr.lmc);
 }
 
 static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
@@ -207,7 +209,7 @@ static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "0x%x\n", attr.sm_lid);
+	return sysfs_emit(buf, "0x%x\n", attr.sm_lid);
 }
 
 static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
@@ -220,7 +222,7 @@ static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", attr.sm_sl);
+	return sysfs_emit(buf, "%d\n", attr.sm_sl);
 }
 
 static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
@@ -233,7 +235,7 @@ static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "0x%08x\n", attr.port_cap_flags);
+	return sysfs_emit(buf, "0x%08x\n", attr.port_cap_flags);
 }
 
 static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
@@ -284,9 +286,9 @@ static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
 	if (rate < 0)
 		return -EINVAL;
 
-	return sprintf(buf, "%d%s Gb/sec (%dX%s)\n",
-		       rate / 10, rate % 10 ? ".5" : "",
-		       ib_width_enum_to_int(attr.active_width), speed);
+	return sysfs_emit(buf, "%d%s Gb/sec (%dX%s)\n",
+			  rate / 10, rate % 10 ? ".5" : "",
+			  ib_width_enum_to_int(attr.active_width), speed);
 }
 
 static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
@@ -318,21 +320,28 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d: %s\n", attr.phys_state,
-		       phys_state_to_str(attr.phys_state));
+	return sysfs_emit(buf, "%d: %s\n",
+			  attr.phys_state, phys_state_to_str(attr.phys_state));
 }
 
 static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
 			       char *buf)
 {
+	const char *output;
+
 	switch (rdma_port_get_link_layer(p->ibdev, p->port_num)) {
 	case IB_LINK_LAYER_INFINIBAND:
-		return sprintf(buf, "%s\n", "InfiniBand");
+		output = "InfiniBand";
+		break;
 	case IB_LINK_LAYER_ETHERNET:
-		return sprintf(buf, "%s\n", "Ethernet");
+		output = "Ethernet";
+		break;
 	default:
-		return sprintf(buf, "%s\n", "Unknown");
+		output = "Unknown";
+		break;
 	}
+
+	return sysfs_emit(buf, "%s\n", output);
 }
 
 static PORT_ATTR_RO(state);
@@ -358,27 +367,28 @@ static struct attribute *port_default_attrs[] = {
 	NULL
 };
 
-static size_t print_ndev(const struct ib_gid_attr *gid_attr, char *buf)
+static ssize_t print_ndev(const struct ib_gid_attr *gid_attr, char *buf)
 {
 	struct net_device *ndev;
-	size_t ret = -EINVAL;
+	int ret = -EINVAL;
 
 	rcu_read_lock();
 	ndev = rcu_dereference(gid_attr->ndev);
 	if (ndev)
-		ret = sprintf(buf, "%s\n", ndev->name);
+		ret = sysfs_emit(buf, "%s\n", ndev->name);
 	rcu_read_unlock();
 	return ret;
 }
 
-static size_t print_gid_type(const struct ib_gid_attr *gid_attr, char *buf)
+static ssize_t print_gid_type(const struct ib_gid_attr *gid_attr, char *buf)
 {
-	return sprintf(buf, "%s\n", ib_cache_gid_type_str(gid_attr->gid_type));
+	return sysfs_emit(buf, "%s\n",
+			  ib_cache_gid_type_str(gid_attr->gid_type));
 }
 
 static ssize_t _show_port_gid_attr(
 	struct ib_port *p, struct port_attribute *attr, char *buf,
-	size_t (*print)(const struct ib_gid_attr *gid_attr, char *buf))
+	ssize_t (*print)(const struct ib_gid_attr *gid_attr, char *buf))
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
@@ -401,7 +411,7 @@ static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	const struct ib_gid_attr *gid_attr;
-	ssize_t ret;
+	int len;
 
 	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
 	if (IS_ERR(gid_attr)) {
@@ -416,12 +426,12 @@ static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
 		 * space throwing such error on fail to read gid, return zero
 		 * GID as before. This maintains backward compatibility.
 		 */
-		return sprintf(buf, "%pI6\n", zgid.raw);
+		return sysfs_emit(buf, "%pI6\n", zgid.raw);
 	}
 
-	ret = sprintf(buf, "%pI6\n", gid_attr->gid.raw);
+	len = sysfs_emit(buf, "%pI6\n", gid_attr->gid.raw);
 	rdma_put_gid_attr(gid_attr);
-	return ret;
+	return len;
 }
 
 static ssize_t show_port_gid_attr_ndev(struct ib_port *p,
@@ -443,13 +453,13 @@ static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
 	u16 pkey;
-	ssize_t ret;
+	int ret;
 
 	ret = ib_query_pkey(p->ibdev, p->port_num, tab_attr->index, &pkey);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "0x%04x\n", pkey);
+	return sysfs_emit(buf, "0x%04x\n", pkey);
 }
 
 #define PORT_PMA_ATTR(_name, _counter, _width, _offset)			\
@@ -521,8 +531,9 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 		container_of(attr, struct port_table_attribute, attr);
 	int offset = tab_attr->index & 0xffff;
 	int width  = (tab_attr->index >> 16) & 0xff;
-	ssize_t ret;
+	int ret;
 	u8 data[8];
+	int len;
 
 	ret = get_perf_mad(p->ibdev, p->port_num, tab_attr->attr_id, &data,
 			40 + offset / 8, sizeof(data));
@@ -531,30 +542,27 @@ static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
 
 	switch (width) {
 	case 4:
-		ret = sprintf(buf, "%u\n", (*data >>
-					    (4 - (offset % 8))) & 0xf);
+		len = sysfs_emit(buf, "%u\n",
+				 (*data >> (4 - (offset % 8))) & 0xf);
 		break;
 	case 8:
-		ret = sprintf(buf, "%u\n", *data);
+		len = sysfs_emit(buf, "%u\n", *data);
 		break;
 	case 16:
-		ret = sprintf(buf, "%u\n",
-			      be16_to_cpup((__be16 *)data));
+		len = sysfs_emit(buf, "%u\n", be16_to_cpup((__be16 *)data));
 		break;
 	case 32:
-		ret = sprintf(buf, "%u\n",
-			      be32_to_cpup((__be32 *)data));
+		len = sysfs_emit(buf, "%u\n", be32_to_cpup((__be32 *)data));
 		break;
 	case 64:
-		ret = sprintf(buf, "%llu\n",
-				be64_to_cpup((__be64 *)data));
+		len = sysfs_emit(buf, "%llu\n", be64_to_cpup((__be64 *)data));
 		break;
-
 	default:
-		ret = 0;
+		len = 0;
+		break;
 	}
 
-	return ret;
+	return len;
 }
 
 static PORT_PMA_ATTR(symbol_error		    ,  0, 16,  32);
@@ -815,12 +823,12 @@ static int update_hw_stats(struct ib_device *dev, struct rdma_hw_stats *stats,
 	return 0;
 }
 
-static ssize_t print_hw_stat(struct ib_device *dev, int port_num,
-			     struct rdma_hw_stats *stats, int index, char *buf)
+static int print_hw_stat(struct ib_device *dev, int port_num,
+			 struct rdma_hw_stats *stats, int index, char *buf)
 {
 	u64 v = rdma_counter_get_hwstat_value(dev, port_num, index);
 
-	return sprintf(buf, "%llu\n", stats->value[index] + v);
+	return sysfs_emit(buf, "%llu\n", stats->value[index] + v);
 }
 
 static ssize_t show_hw_stats(struct kobject *kobj, struct attribute *attr,
@@ -877,7 +885,7 @@ static ssize_t show_stats_lifespan(struct kobject *kobj,
 	msecs = jiffies_to_msecs(stats->lifespan);
 	mutex_unlock(&stats->lock);
 
-	return sprintf(buf, "%d\n", msecs);
+	return sysfs_emit(buf, "%d\n", msecs);
 }
 
 static ssize_t set_stats_lifespan(struct kobject *kobj,
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 7e759f5b2a75..19104a675691 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1222,7 +1222,7 @@ static char *umad_devnode(struct device *dev, umode_t *mode)
 static ssize_t abi_version_show(struct class *class,
 				struct class_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", IB_USER_MAD_ABI_VERSION);
+	return sysfs_emit(buf, "%d\n", IB_USER_MAD_ABI_VERSION);
 }
 static CLASS_ATTR_RO(abi_version);
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 6b545f0f065f..dcea59e0721a 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -151,7 +151,7 @@ struct hfi1_port_attr {
 
 static ssize_t cc_prescan_show(struct hfi1_pportdata *ppd, char *buf)
 {
-	return sprintf(buf, "%s\n", ppd->cc_prescan ? "on" : "off");
+	return sysfs_emit(buf, "%s\n", ppd->cc_prescan ? "on" : "off");
 }
 
 static ssize_t cc_prescan_store(struct hfi1_pportdata *ppd, const char *buf,
@@ -296,7 +296,7 @@ static ssize_t sc2vl_attr_show(struct kobject *kobj, struct attribute *attr,
 		container_of(kobj, struct hfi1_pportdata, sc2vl_kobj);
 	struct hfi1_devdata *dd = ppd->dd;
 
-	return sprintf(buf, "%u\n", *((u8 *)dd->sc2vl + sattr->sc));
+	return sysfs_emit(buf, "%u\n", *((u8 *)dd->sc2vl + sattr->sc));
 }
 
 static const struct sysfs_ops hfi1_sc2vl_ops = {
@@ -401,7 +401,7 @@ static ssize_t sl2sc_attr_show(struct kobject *kobj, struct attribute *attr,
 		container_of(kobj, struct hfi1_pportdata, sl2sc_kobj);
 	struct hfi1_ibport *ibp = &ppd->ibport_data;
 
-	return sprintf(buf, "%u\n", ibp->sl_to_sc[sattr->sl]);
+	return sysfs_emit(buf, "%u\n", ibp->sl_to_sc[sattr->sl]);
 }
 
 static const struct sysfs_ops hfi1_sl2sc_ops = {
@@ -475,7 +475,7 @@ static ssize_t vl2mtu_attr_show(struct kobject *kobj, struct attribute *attr,
 		container_of(kobj, struct hfi1_pportdata, vl2mtu_kobj);
 	struct hfi1_devdata *dd = ppd->dd;
 
-	return sprintf(buf, "%u\n", dd->vld[vlattr->vl].mtu);
+	return sysfs_emit(buf, "%u\n", dd->vld[vlattr->vl].mtu);
 }
 
 static const struct sysfs_ops hfi1_vl2mtu_ops = {
@@ -813,7 +813,7 @@ static ssize_t sde_show_vl(struct sdma_engine *sde, char *buf)
 	if (vl < 0)
 		return vl;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", vl);
+	return sysfs_emit(buf, "%d\n", vl);
 }
 
 static SDE_ATTR(cpu_list, S_IWUSR | S_IRUGO,
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 75d50383da89..fc6c98b608d3 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -444,16 +444,17 @@ static ssize_t show_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
 {
 	struct port_table_attribute *tab_attr =
 		container_of(attr, struct port_table_attribute, attr);
-	ssize_t ret = -ENODEV;
+	int len;
+	struct pkey_mgt *m = &p->dev->pkeys;
+	u8 key = m->virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index];
 
-	if (p->dev->pkeys.virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index] >=
-	    (p->dev->dev->caps.pkey_table_len[p->port_num]))
-		ret = sprintf(buf, "none\n");
+	if (key >= p->dev->dev->caps.pkey_table_len[p->port_num])
+		len = sysfs_emit(buf, "none\n");
 	else
-		ret = sprintf(buf, "%d\n",
-			      p->dev->pkeys.virt2phys_pkey[p->slave]
-			      [p->port_num - 1][tab_attr->index]);
-	return ret;
+		len = sysfs_emit(buf, "%d\n",
+				 p->dev->pkeys.virt2phys_pkey[p->slave]
+				 [p->port_num - 1][tab_attr->index]);
+	return len;
 }
 
 static ssize_t store_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
@@ -491,7 +492,7 @@ static ssize_t store_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
 static ssize_t show_port_gid_idx(struct mlx4_port *p,
 				 struct port_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", p->slave);
+	return sysfs_emit(buf, "%d\n", p->slave);
 }
 
 static struct attribute **
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 02ad73ffcd5e..4b1e2ca0a0d0 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -43,11 +43,8 @@
 static ssize_t show_hrtbt_enb(struct qib_pportdata *ppd, char *buf)
 {
 	struct qib_devdata *dd = ppd->dd;
-	int ret;
 
-	ret = dd->f_get_ib_cfg(ppd, QIB_IB_CFG_HRTBT);
-	ret = scnprintf(buf, PAGE_SIZE, "%d\n", ret);
-	return ret;
+	return sysfs_emit(buf, "%d\n", dd->f_get_ib_cfg(ppd, QIB_IB_CFG_HRTBT));
 }
 
 static ssize_t store_hrtbt_enb(struct qib_pportdata *ppd, const char *buf,
@@ -106,14 +103,10 @@ static ssize_t store_led_override(struct qib_pportdata *ppd, const char *buf,
 
 static ssize_t show_status(struct qib_pportdata *ppd, char *buf)
 {
-	ssize_t ret;
-
 	if (!ppd->statusp)
-		ret = -EINVAL;
-	else
-		ret = scnprintf(buf, PAGE_SIZE, "0x%llx\n",
-				(unsigned long long) *(ppd->statusp));
-	return ret;
+		return -EINVAL;
+
+	return sysfs_emit(buf, "0x%llx\n", (unsigned long long)*(ppd->statusp));
 }
 
 /*
@@ -392,7 +385,7 @@ static ssize_t sl2vl_attr_show(struct kobject *kobj, struct attribute *attr,
 		container_of(kobj, struct qib_pportdata, sl2vl_kobj);
 	struct qib_ibport *qibp = &ppd->ibport_data;
 
-	return sprintf(buf, "%u\n", qibp->sl_to_vl[sattr->sl]);
+	return sysfs_emit(buf, "%u\n", qibp->sl_to_vl[sattr->sl]);
 }
 
 static const struct sysfs_ops qib_sl2vl_ops = {
@@ -501,17 +494,18 @@ static ssize_t diagc_attr_show(struct kobject *kobj, struct attribute *attr,
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, diagc_kobj);
 	struct qib_ibport *qibp = &ppd->ibport_data;
+	u64 val;
 
 	if (!strncmp(dattr->attr.name, "rc_acks", 7))
-		return sprintf(buf, "%llu\n", READ_PER_CPU_CNTR(rc_acks));
+		val = READ_PER_CPU_CNTR(rc_acks);
 	else if (!strncmp(dattr->attr.name, "rc_qacks", 8))
-		return sprintf(buf, "%llu\n", READ_PER_CPU_CNTR(rc_qacks));
+		val = READ_PER_CPU_CNTR(rc_qacks);
 	else if (!strncmp(dattr->attr.name, "rc_delayed_comp", 15))
-		return sprintf(buf, "%llu\n",
-					READ_PER_CPU_CNTR(rc_delayed_comp));
+		val = READ_PER_CPU_CNTR(rc_delayed_comp);
 	else
-		return sprintf(buf, "%u\n",
-				*(u32 *)((char *)qibp + dattr->counter));
+		val = *(u32 *)((char *)qibp + dattr->counter);
+
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t diagc_attr_store(struct kobject *kobj, struct attribute *attr,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index eddad4f0bd2d..7f971fed1cc0 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -205,43 +205,35 @@ struct qpn_attribute qpn_attr_##NAME = __ATTR_RO(NAME)
 
 static ssize_t context_show(struct usnic_ib_qp_grp *qp_grp, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "0x%p\n", qp_grp->ctx);
+	return sysfs_emit(buf, "0x%p\n", qp_grp->ctx);
 }
 
 static ssize_t summary_show(struct usnic_ib_qp_grp *qp_grp, char *buf)
 {
-	int i, j, n;
-	int left;
-	char *ptr;
+	int i, j;
 	struct usnic_vnic_res_chunk *res_chunk;
 	struct usnic_vnic_res *vnic_res;
+	int len;
 
-	left = PAGE_SIZE;
-	ptr = buf;
-
-	n = scnprintf(ptr, left,
-			"QPN: %d State: (%s) PID: %u VF Idx: %hu ",
-			qp_grp->ibqp.qp_num,
-			usnic_ib_qp_grp_state_to_string(qp_grp->state),
-			qp_grp->owner_pid,
-			usnic_vnic_get_index(qp_grp->vf->vnic));
-	UPDATE_PTR_LEFT(n, ptr, left);
+	len = sysfs_emit(buf, "QPN: %d State: (%s) PID: %u VF Idx: %hu ",
+			 qp_grp->ibqp.qp_num,
+			 usnic_ib_qp_grp_state_to_string(qp_grp->state),
+			 qp_grp->owner_pid,
+			 usnic_vnic_get_index(qp_grp->vf->vnic));
 
 	for (i = 0; qp_grp->res_chunk_list[i]; i++) {
 		res_chunk = qp_grp->res_chunk_list[i];
 		for (j = 0; j < res_chunk->cnt; j++) {
 			vnic_res = res_chunk->res[j];
-			n = scnprintf(ptr, left, "%s[%d] ",
-				usnic_vnic_res_type_to_str(vnic_res->type),
-				vnic_res->vnic_idx);
-			UPDATE_PTR_LEFT(n, ptr, left);
+			len += sysfs_emit_at(buf, len, "%s[%d] ",
+					     usnic_vnic_res_type_to_str(vnic_res->type),
+					     vnic_res->vnic_idx);
 		}
 	}
 
-	n = scnprintf(ptr, left, "\n");
-	UPDATE_PTR_LEFT(n, ptr, left);
+	len = sysfs_emit_at(buf, len, "\n");
 
-	return ptr - buf;
+	return len;
 }
 
 static QPN_ATTR_RO(context);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 51ba82fc425c..ebac1e87dd71 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -349,12 +349,13 @@ static ssize_t rtrs_clt_src_addr_show(struct kobject *kobj,
 				       char *page)
 {
 	struct rtrs_clt_sess *sess;
-	int cnt;
+	int len;
 
 	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
-	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+	len = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
 			      page, PAGE_SIZE);
-	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+	len += sysfs_emit_at(page, len, "\n");
+	return len;
 }
 
 static struct kobj_attribute rtrs_clt_src_addr_attr =
@@ -365,12 +366,13 @@ static ssize_t rtrs_clt_dst_addr_show(struct kobject *kobj,
 				       char *page)
 {
 	struct rtrs_clt_sess *sess;
-	int cnt;
+	int len;
 
 	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
-	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
+	len = sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr,
 			      page, PAGE_SIZE);
-	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+	len += sysfs_emit_at(page, len, "\n");
+	return len;
 }
 
 static struct kobj_attribute rtrs_clt_dst_addr_attr =
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 6e7bebe4e064..27a40b41c916 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -112,12 +112,13 @@ static ssize_t rtrs_srv_dst_addr_show(struct kobject *kobj,
 				       char *page)
 {
 	struct rtrs_srv_sess *sess;
-	int cnt;
+	int len;
 
 	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
-	cnt = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
+	len = sockaddr_to_str((struct sockaddr *)&sess->s.src_addr,
 			      page, PAGE_SIZE);
-	return cnt + scnprintf(page + cnt, PAGE_SIZE - cnt, "\n");
+	len += sysfs_emit_at(page, len, "\n");
+	return len;
 }
 
 static struct kobj_attribute rtrs_srv_dst_addr_attr =
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4a5a4f522fd5..c3ea036de661 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -169,9 +169,9 @@ static int srp_tmo_get(char *buffer, const struct kernel_param *kp)
 	int tmo = *(int *)kp->arg;
 
 	if (tmo >= 0)
-		return sprintf(buffer, "%d\n", tmo);
+		return sysfs_emit(buffer, "%d\n", tmo);
 	else
-		return sprintf(buffer, "off\n");
+		return sysfs_emit(buffer, "off\n");
 }
 
 static int srp_tmo_set(const char *val, const struct kernel_param *kp)
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0065eb17ae36..6017d525084a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3445,7 +3445,7 @@ static ssize_t srpt_tpg_attrib_srp_max_rdma_size_show(struct config_item *item,
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);
 	struct srpt_port *sport = srpt_tpg_to_sport(se_tpg);
 
-	return sprintf(page, "%u\n", sport->port_attrib.srp_max_rdma_size);
+	return sysfs_emit(page, "%u\n", sport->port_attrib.srp_max_rdma_size);
 }
 
 static ssize_t srpt_tpg_attrib_srp_max_rdma_size_store(struct config_item *item,
@@ -3482,7 +3482,7 @@ static ssize_t srpt_tpg_attrib_srp_max_rsp_size_show(struct config_item *item,
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);
 	struct srpt_port *sport = srpt_tpg_to_sport(se_tpg);
 
-	return sprintf(page, "%u\n", sport->port_attrib.srp_max_rsp_size);
+	return sysfs_emit(page, "%u\n", sport->port_attrib.srp_max_rsp_size);
 }
 
 static ssize_t srpt_tpg_attrib_srp_max_rsp_size_store(struct config_item *item,
@@ -3519,7 +3519,7 @@ static ssize_t srpt_tpg_attrib_srp_sq_size_show(struct config_item *item,
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);
 	struct srpt_port *sport = srpt_tpg_to_sport(se_tpg);
 
-	return sprintf(page, "%u\n", sport->port_attrib.srp_sq_size);
+	return sysfs_emit(page, "%u\n", sport->port_attrib.srp_sq_size);
 }
 
 static ssize_t srpt_tpg_attrib_srp_sq_size_store(struct config_item *item,
@@ -3556,7 +3556,7 @@ static ssize_t srpt_tpg_attrib_use_srq_show(struct config_item *item,
 	struct se_portal_group *se_tpg = attrib_to_tpg(item);
 	struct srpt_port *sport = srpt_tpg_to_sport(se_tpg);
 
-	return sprintf(page, "%d\n", sport->port_attrib.use_srq);
+	return sysfs_emit(page, "%d\n", sport->port_attrib.use_srq);
 }
 
 static ssize_t srpt_tpg_attrib_use_srq_store(struct config_item *item,
@@ -3646,7 +3646,7 @@ static struct rdma_cm_id *srpt_create_rdma_id(struct sockaddr *listen_addr)
 
 static ssize_t srpt_rdma_cm_port_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", rdma_cm_port);
+	return sysfs_emit(page, "%d\n", rdma_cm_port);
 }
 
 static ssize_t srpt_rdma_cm_port_store(struct config_item *item,
@@ -3702,7 +3702,7 @@ static ssize_t srpt_tpg_enable_show(struct config_item *item, char *page)
 	struct se_portal_group *se_tpg = to_tpg(item);
 	struct srpt_port *sport = srpt_tpg_to_sport(se_tpg);
 
-	return snprintf(page, PAGE_SIZE, "%d\n", sport->enabled);
+	return sysfs_emit(page, "%d\n", sport->enabled);
 }
 
 static ssize_t srpt_tpg_enable_store(struct config_item *item,
@@ -3809,7 +3809,7 @@ static void srpt_drop_tport(struct se_wwn *wwn)
 
 static ssize_t srpt_wwn_version_show(struct config_item *item, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "\n");
+	return sysfs_emit(buf, "\n");
 }
 
 CONFIGFS_ATTR_RO(srpt_wwn_, version);
-- 
2.26.0

