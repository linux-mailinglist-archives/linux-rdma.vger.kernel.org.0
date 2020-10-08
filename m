Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55A8286CD5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgJHCgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:36:53 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:48316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727663AbgJHCgx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:36:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 87DBD180A8127;
        Thu,  8 Oct 2020 02:36:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:327:355:379:541:800:960:968:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1605:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2895:2898:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:4250:4321:4605:5007:6119:6261:6691:6737:7903:7904:7974:8603:8660:9036:9592:10004:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12679:12698:12712:12737:12895:12986:13148:13230:13894:14394:21060:21080:21324:21433:21451:21627:21939:21972:21990:30012:30029:30034:30045:30054:30070:30075:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: room46_2d0b235271d4
X-Filterd-Recvd-Size: 30229
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:36:47 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
Date:   Wed,  7 Oct 2020 19:36:26 -0700
Message-Id: <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1602122879.git.joe@perches.com>
References: <cover.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to use sysfs_emit in the RDMA code as cocci scripts can not
be written to handle _all_ the possible variants of various sprintf family
uses in sysfs show functions.

While there, make the code more legible and update its style to be more
like the typical kernel styles.

Miscellanea:

o Use intermediate pointers for dereferences
o Add and use string lookup functions
o return early when any intermediate call fails so normal return is
  at the bottom of the function
o mlx4/mcg.c:sysfs_show_group: use scnprintf to format intermediate strings

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/infiniband/core/sysfs.c              | 60 +++++++-------
 drivers/infiniband/hw/cxgb4/provider.c       |  5 +-
 drivers/infiniband/hw/hfi1/sysfs.c           | 38 ++++-----
 drivers/infiniband/hw/mlx4/main.c            |  5 +-
 drivers/infiniband/hw/mlx4/mcg.c             | 82 +++++++++++---------
 drivers/infiniband/hw/mlx4/sysfs.c           | 47 ++++++-----
 drivers/infiniband/hw/mlx5/main.c            |  4 +-
 drivers/infiniband/hw/mthca/mthca_provider.c | 29 ++++---
 drivers/infiniband/hw/qib/qib_sysfs.c        | 45 +++++------
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 66 +++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 21 +++--
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 13 ++--
 drivers/infiniband/ulp/srp/ib_srp.c          |  4 +
 13 files changed, 206 insertions(+), 213 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 79327200da70..cbc8326b935d 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1224,30 +1224,27 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	return ret;
 }
 
+static const char *node_type_string(int node_type)
+{
+	switch (node_type) {
+	case RDMA_NODE_IB_CA:		return "CA";
+	case RDMA_NODE_IB_SWITCH:	return "switch";
+	case RDMA_NODE_IB_ROUTER:	return "router";
+	case RDMA_NODE_RNIC:		return "RNIC";
+	case RDMA_NODE_USNIC:		return "usNIC";
+	case RDMA_NODE_USNIC_UDP:	return "usNIC UDP";
+	case RDMA_NODE_UNSPECIFIED:	return "unspecified";
+	}
+	return "<unknown>";
+}
+
 static ssize_t node_type_show(struct device *device,
 			      struct device_attribute *attr, char *buf)
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
-	switch (dev->node_type) {
-	case RDMA_NODE_IB_CA:	  return sysfs_emit(buf, "%d: CA\n",
-							 dev->node_type);
-	case RDMA_NODE_RNIC:	  return sysfs_emit(buf, "%d: RNIC\n",
-							dev->node_type);
-	case RDMA_NODE_USNIC:	  return sysfs_emit(buf, "%d: usNIC\n",
-							 dev->node_type);
-	case RDMA_NODE_USNIC_UDP: return sysfs_emit(buf, "%d: usNIC UDP\n",
-						    dev->node_type);
-	case RDMA_NODE_UNSPECIFIED: return sysfs_emit(buf,
-						      "%d: unspecified\n",
-						      dev->node_type);
-	case RDMA_NODE_IB_SWITCH: return sysfs_emit(buf, "%d: switch\n",
-						    dev->node_type);
-	case RDMA_NODE_IB_ROUTER: return sysfs_emit(buf, "%d: router\n",
-						    dev->node_type);
-	default:		  return sysfs_emit(buf, "%d: <unknown>\n",
-						    dev->node_type);
-	}
+	return sysfs_emit(buf, "%d: %s\n",
+			  dev->node_type, node_type_string(dev->node_type));
 }
 static DEVICE_ATTR_RO(node_type);
 
@@ -1255,12 +1252,13 @@ static ssize_t sys_image_guid_show(struct device *device,
 				   struct device_attribute *dev_attr, char *buf)
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
+	__be16 *guid = (__be16 *)&dev->attrs.sys_image_guid;
 
 	return sysfs_emit(buf, "%04x:%04x:%04x:%04x\n",
-			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[0]),
-			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[1]),
-			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[2]),
-			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[3]));
+			  be16_to_cpu(guid[0]),
+			  be16_to_cpu(guid[1]),
+			  be16_to_cpu(guid[2]),
+			  be16_to_cpu(guid[3]));
 }
 static DEVICE_ATTR_RO(sys_image_guid);
 
@@ -1268,12 +1266,13 @@ static ssize_t node_guid_show(struct device *device,
 			      struct device_attribute *attr, char *buf)
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
+	__be16 *node_guid = (__be16 *)&dev->node_guid;
 
 	return sysfs_emit(buf, "%04x:%04x:%04x:%04x\n",
-			  be16_to_cpu(((__be16 *) &dev->node_guid)[0]),
-			  be16_to_cpu(((__be16 *) &dev->node_guid)[1]),
-			  be16_to_cpu(((__be16 *) &dev->node_guid)[2]),
-			  be16_to_cpu(((__be16 *) &dev->node_guid)[3]));
+			  be16_to_cpu(node_guid[0]),
+			  be16_to_cpu(node_guid[1]),
+			  be16_to_cpu(node_guid[2]),
+			  be16_to_cpu(node_guid[3]));
 }
 static DEVICE_ATTR_RO(node_guid);
 
@@ -1309,10 +1308,11 @@ static ssize_t fw_ver_show(struct device *device, struct device_attribute *attr,
 			   char *buf)
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
+	char version[IB_FW_VERSION_NAME_MAX] = {};
+
+	ib_get_device_fw_str(dev, version);
 
-	ib_get_device_fw_str(dev, buf);
-	strlcat(buf, "\n", IB_FW_VERSION_NAME_MAX);
-	return strlen(buf);
+	return sysfs_emit(buf, "%s\n", version);
 }
 static DEVICE_ATTR_RO(fw_ver);
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index b312a7ec40bf..080f34625145 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -337,6 +337,7 @@ static ssize_t hca_type_show(struct device *dev,
 
 	pr_debug("dev 0x%p\n", dev);
 	lldev->ethtool_ops->get_drvinfo(lldev, &info);
+
 	return sysfs_emit(buf, "%s\n", info.driver);
 }
 static DEVICE_ATTR_RO(hca_type);
@@ -348,7 +349,9 @@ static ssize_t board_id_show(struct device *dev, struct device_attribute *attr,
 			rdma_device_to_drv_device(dev, struct c4iw_dev, ibdev);
 
 	pr_debug("dev 0x%p\n", dev);
-	return sysfs_emit(buf, "%x.%x\n", c4iw_dev->rdev.lldi.pdev->vendor,
+
+	return sysfs_emit(buf, "%x.%x\n",
+			  c4iw_dev->rdev.lldi.pdev->vendor,
 			  c4iw_dev->rdev.lldi.pdev->device);
 }
 static DEVICE_ATTR_RO(board_id);
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index e2a88f3cea7f..6b545f0f065f 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -510,13 +510,11 @@ static ssize_t board_id_show(struct device *device,
 	struct hfi1_ibdev *dev =
 		rdma_device_to_drv_device(device, struct hfi1_ibdev, rdi.ibdev);
 	struct hfi1_devdata *dd = dd_from_dev(dev);
-	int ret;
 
 	if (!dd->boardname)
-		ret = -EINVAL;
-	else
-		ret = sysfs_emit(buf, "%s\n", dd->boardname);
-	return ret;
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", dd->boardname);
 }
 static DEVICE_ATTR_RO(board_id);
 
@@ -570,6 +568,7 @@ static ssize_t serial_show(struct device *device,
 		rdma_device_to_drv_device(device, struct hfi1_ibdev, rdi.ibdev);
 	struct hfi1_devdata *dd = dd_from_dev(dev);
 
+	/* dd->serial is already newline terminated in chip.c */
 	return sysfs_emit(buf, "%s", dd->serial);
 }
 static DEVICE_ATTR_RO(serial);
@@ -598,9 +597,8 @@ static DEVICE_ATTR_WO(chip_reset);
  * Convert the reported temperature from an integer (reported in
  * units of 0.25C) to a floating point number.
  */
-#define temp2str(temp, buf, size, idx)					\
-	scnprintf((buf) + (idx), (size) - (idx), "%u.%02u ",		\
-			      ((temp) >> 2), ((temp) & 0x3) * 25)
+#define temp_d(t)	((t) >> 2)
+#define temp_f(t)	(((t) & 0x3) * 25u)
 
 /*
  * Dump tempsense values, in decimal, to ease shell-scripts.
@@ -615,19 +613,17 @@ static ssize_t tempsense_show(struct device *device,
 	int ret;
 
 	ret = hfi1_tempsense_rd(dd, &temp);
-	if (!ret) {
-		int idx = 0;
-
-		idx += temp2str(temp.curr, buf, PAGE_SIZE, idx);
-		idx += temp2str(temp.lo_lim, buf, PAGE_SIZE, idx);
-		idx += temp2str(temp.hi_lim, buf, PAGE_SIZE, idx);
-		idx += temp2str(temp.crit_lim, buf, PAGE_SIZE, idx);
-		idx += scnprintf(buf + idx, PAGE_SIZE - idx,
-				"%u %u %u\n", temp.triggers & 0x1,
-				temp.triggers & 0x2, temp.triggers & 0x4);
-		ret = idx;
-	}
-	return ret;
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u.%02u %u.%02u %u.%02u %u.%02u %u %u %u\n",
+			  temp_d(temp.curr), temp_f(temp.curr),
+			  temp_d(temp.lo_lim), temp_f(temp.lo_lim),
+			  temp_d(temp.hi_lim), temp_f(temp.hi_lim),
+			  temp_d(temp.crit_lim), temp_f(temp.crit_lim),
+			  temp.triggers & 0x1,
+			  temp.triggers & 0x2,
+			  temp.triggers & 0x4);
 }
 static DEVICE_ATTR_RO(tempsense);
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ad3c8f985921..ce4f8e263c58 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2024,6 +2024,7 @@ static ssize_t hca_type_show(struct device *device,
 {
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
+
 	return sysfs_emit(buf, "MT%d\n", dev->dev->persist->pdev->device);
 }
 static DEVICE_ATTR_RO(hca_type);
@@ -2033,6 +2034,7 @@ static ssize_t hw_rev_show(struct device *device,
 {
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
+
 	return sysfs_emit(buf, "%x\n", dev->dev->rev_id);
 }
 static DEVICE_ATTR_RO(hw_rev);
@@ -2043,8 +2045,7 @@ static ssize_t board_id_show(struct device *device,
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
 
-	return sysfs_emit(buf, "%.*s\n", MLX4_BOARD_ID_LEN,
-			  dev->dev->board_id);
+	return sysfs_emit(buf, "%.*s\n", MLX4_BOARD_ID_LEN, dev->dev->board_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/mlx4/mcg.c b/drivers/infiniband/hw/mlx4/mcg.c
index 5e4ec9786081..e4e480bffdfa 100644
--- a/drivers/infiniband/hw/mlx4/mcg.c
+++ b/drivers/infiniband/hw/mlx4/mcg.c
@@ -988,53 +988,63 @@ int mlx4_ib_mcg_multiplex_handler(struct ib_device *ibdev, int port,
 }
 
 static ssize_t sysfs_show_group(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct mcast_group *group =
 		container_of(attr, struct mcast_group, dentry);
 	struct mcast_req *req = NULL;
-	char pending_str[40];
 	char state_str[40];
-	ssize_t len = 0;
-	int f;
+	char pending_str[40];
+	int len;
+	int i;
+	u32 hoplimit;
 
 	if (group->state == MCAST_IDLE)
-		sprintf(state_str, "%s", get_state_string(group->state));
+		scnprintf(state_str, sizeof(state_str), "%s",
+			  get_state_string(group->state));
 	else
-		sprintf(state_str, "%s(TID=0x%llx)",
-				get_state_string(group->state),
-				be64_to_cpu(group->last_req_tid));
+		scnprintf(state_str, sizeof(state_str), "%s(TID=0x%llx)",
+			  get_state_string(group->state),
+			  be64_to_cpu(group->last_req_tid));
+
 	if (list_empty(&group->pending_list)) {
-		sprintf(pending_str, "No");
+		scnprintf(pending_str, sizeof(pending_str), "No");
 	} else {
-		req = list_first_entry(&group->pending_list, struct mcast_req, group_list);
-		sprintf(pending_str, "Yes(TID=0x%llx)",
-				be64_to_cpu(req->sa_mad.mad_hdr.tid));
+		req = list_first_entry(&group->pending_list,
+				       struct mcast_req, group_list);
+		scnprintf(pending_str, sizeof(pending_str), "Yes(TID=0x%llx)",
+			  be64_to_cpu(req->sa_mad.mad_hdr.tid));
+	}
+
+	len = sysfs_emit(buf, "%1d [%02d,%02d,%02d] %4d %4s %5s     ",
+			 group->rec.scope_join_state & 0xf,
+			 group->members[2],
+			 group->members[1],
+			 group->members[0],
+			 atomic_read(&group->refcount),
+			 pending_str,
+			 state_str);
+
+	for (i = 0; i < MAX_VFS; i++) {
+		if (group->func[i].state == MCAST_MEMBER)
+			len += sysfs_emit_at(buf, len, "%d[%1x] ",
+					     i, group->func[i].join_state);
 	}
-	len += sprintf(buf + len, "%1d [%02d,%02d,%02d] %4d %4s %5s     ",
-			group->rec.scope_join_state & 0xf,
-			group->members[2], group->members[1], group->members[0],
-			atomic_read(&group->refcount),
-			pending_str,
-			state_str);
-	for (f = 0; f < MAX_VFS; ++f)
-		if (group->func[f].state == MCAST_MEMBER)
-			len += sprintf(buf + len, "%d[%1x] ",
-					f, group->func[f].join_state);
-
-	len += sprintf(buf + len, "\t\t(%4hx %4x %2x %2x %2x %2x %2x "
-		"%4x %4x %2x %2x)\n",
-		be16_to_cpu(group->rec.pkey),
-		be32_to_cpu(group->rec.qkey),
-		(group->rec.mtusel_mtu & 0xc0) >> 6,
-		group->rec.mtusel_mtu & 0x3f,
-		group->rec.tclass,
-		(group->rec.ratesel_rate & 0xc0) >> 6,
-		group->rec.ratesel_rate & 0x3f,
-		(be32_to_cpu(group->rec.sl_flowlabel_hoplimit) & 0xf0000000) >> 28,
-		(be32_to_cpu(group->rec.sl_flowlabel_hoplimit) & 0x0fffff00) >> 8,
-		be32_to_cpu(group->rec.sl_flowlabel_hoplimit) & 0x000000ff,
-		group->rec.proxy_join);
+
+	hoplimit = be32_to_cpu(group->rec.sl_flowlabel_hoplimit);
+	len += sysfs_emit_at(buf, len,
+			     "\t\t(%4hx %4x %2x %2x %2x %2x %2x %4x %4x %2x %2x)\n",
+			     be16_to_cpu(group->rec.pkey),
+			     be32_to_cpu(group->rec.qkey),
+			     (group->rec.mtusel_mtu & 0xc0) >> 6,
+			     (group->rec.mtusel_mtu & 0x3f),
+			     group->rec.tclass,
+			     (group->rec.ratesel_rate & 0xc0) >> 6,
+			     (group->rec.ratesel_rate & 0x3f),
+			     (hoplimit & 0xf0000000) >> 28,
+			     (hoplimit & 0x0fffff00) >> 8,
+			     (hoplimit & 0x000000ff),
+			     group->rec.proxy_join);
 
 	return len;
 }
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 26c717a4911f..75d50383da89 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -117,22 +117,25 @@ static ssize_t show_port_gid(struct device *dev,
 	struct mlx4_ib_iov_port *port = mlx4_ib_iov_dentry->ctx;
 	struct mlx4_ib_dev *mdev = port->dev;
 	union ib_gid gid;
-	ssize_t ret;
+	int ret;
+	__be16 *raw;
 
 	ret = __mlx4_ib_query_gid(&mdev->ib_dev, port->num,
 				  mlx4_ib_iov_dentry->entry_num, &gid, 1);
 	if (ret)
 		return ret;
-	ret = sysfs_emit(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-			 be16_to_cpu(((__be16 *) gid.raw)[0]),
-			 be16_to_cpu(((__be16 *) gid.raw)[1]),
-			 be16_to_cpu(((__be16 *) gid.raw)[2]),
-			 be16_to_cpu(((__be16 *) gid.raw)[3]),
-			 be16_to_cpu(((__be16 *) gid.raw)[4]),
-			 be16_to_cpu(((__be16 *) gid.raw)[5]),
-			 be16_to_cpu(((__be16 *) gid.raw)[6]),
-			 be16_to_cpu(((__be16 *) gid.raw)[7]));
-	return ret;
+
+	raw = (__be16 *)gid.raw;
+
+	return sysfs_emit(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+			  be16_to_cpu(raw[0]),
+			  be16_to_cpu(raw[1]),
+			  be16_to_cpu(raw[2]),
+			  be16_to_cpu(raw[3]),
+			  be16_to_cpu(raw[4]),
+			  be16_to_cpu(raw[5]),
+			  be16_to_cpu(raw[6]),
+			  be16_to_cpu(raw[7]));
 }
 
 static ssize_t show_phys_port_pkey(struct device *dev,
@@ -542,14 +545,11 @@ static ssize_t sysfs_show_smi_enabled(struct device *dev,
 {
 	struct mlx4_port *p =
 		container_of(attr, struct mlx4_port, smi_enabled);
-	ssize_t len = 0;
 
-	if (mlx4_vf_smi_enabled(p->dev->dev, p->slave, p->port_num))
-		len = sysfs_emit(buf, "%d\n", 1);
-	else
-		len = sysfs_emit(buf, "%d\n", 0);
-
-	return len;
+	return sysfs_emit(buf, "%d\n",
+			  !!mlx4_vf_smi_enabled(p->dev->dev,
+						p->slave,
+						p->port_num));
 }
 
 static ssize_t sysfs_show_enable_smi_admin(struct device *dev,
@@ -558,14 +558,11 @@ static ssize_t sysfs_show_enable_smi_admin(struct device *dev,
 {
 	struct mlx4_port *p =
 		container_of(attr, struct mlx4_port, enable_smi_admin);
-	ssize_t len = 0;
-
-	if (mlx4_vf_get_enable_smi_admin(p->dev->dev, p->slave, p->port_num))
-		len = sysfs_emit(buf, "%d\n", 1);
-	else
-		len = sysfs_emit(buf, "%d\n", 0);
 
-	return len;
+	return sysfs_emit(buf, "%d\n",
+			  !!mlx4_vf_get_enable_smi_admin(p->dev->dev,
+							 p->slave,
+							 p->port_num));
 }
 
 static ssize_t sysfs_store_enable_smi_admin(struct device *dev,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8b9f6f857120..453eaf35dec7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2669,8 +2669,8 @@ static ssize_t board_id_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sysfs_emit(buf, "%.*s\n", MLX5_BOARD_ID_LEN,
-			  dev->mdev->board_id);
+	return sysfs_emit(buf, "%.*s\n",
+			  MLX5_BOARD_ID_LEN, dev->mdev->board_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index b6e4254e4558..fd5d4e1e5b8b 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -965,25 +965,30 @@ static ssize_t hw_rev_show(struct device *device,
 }
 static DEVICE_ATTR_RO(hw_rev);
 
-static ssize_t hca_type_show(struct device *device,
-			     struct device_attribute *attr, char *buf)
+static const char *hca_type_string(int hca_type)
 {
-	struct mthca_dev *dev =
-		rdma_device_to_drv_device(device, struct mthca_dev, ib_dev);
-
-	switch (dev->pdev->device) {
+	switch (hca_type) {
 	case PCI_DEVICE_ID_MELLANOX_TAVOR:
-		return sysfs_emit(buf, "MT23108\n");
+		return "MT23108";
 	case PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT:
-		return sysfs_emit(buf, "MT25208 (MT23108 compat mode)\n");
+		return "MT25208 (MT23108 compat mode)";
 	case PCI_DEVICE_ID_MELLANOX_ARBEL:
-		return sysfs_emit(buf, "MT25208\n");
+		return "MT25208";
 	case PCI_DEVICE_ID_MELLANOX_SINAI:
 	case PCI_DEVICE_ID_MELLANOX_SINAI_OLD:
-		return sysfs_emit(buf, "MT25204\n");
-	default:
-		return sysfs_emit(buf, "unknown\n");
+		return "MT25204";
 	}
+
+	return "unknown";
+}
+
+static ssize_t hca_type_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	struct mthca_dev *dev =
+		rdma_device_to_drv_device(device, struct mthca_dev, ib_dev);
+
+	return sysfs_emit(buf, "%s\n", hca_type_string(dev->pdev->device));
 }
 static DEVICE_ATTR_RO(hca_type);
 
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 2963915d0851..02ad73ffcd5e 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -575,13 +575,11 @@ static ssize_t hca_type_show(struct device *device,
 	struct qib_ibdev *dev =
 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
 	struct qib_devdata *dd = dd_from_dev(dev);
-	int ret;
 
 	if (!dd->boardname)
-		ret = -EINVAL;
-	else
-		ret = sysfs_emit(buf, "%s\n", dd->boardname);
-	return ret;
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", dd->boardname);
 }
 static DEVICE_ATTR_RO(hca_type);
 static DEVICE_ATTR(board_id, 0444, hca_type_show, NULL);
@@ -653,10 +651,7 @@ static ssize_t serial_show(struct device *device,
 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
 	struct qib_devdata *dd = dd_from_dev(dev);
 
-	buf[sizeof(dd->serial)] = '\0';
-	memcpy(buf, dd->serial, sizeof(dd->serial));
-	strcat(buf, "\n");
-	return strlen(buf);
+	return sysfs_emit(buf, "%s\n", dd->serial);
 }
 static DEVICE_ATTR_RO(serial);
 
@@ -689,27 +684,27 @@ static ssize_t tempsense_show(struct device *device,
 	struct qib_ibdev *dev =
 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
 	struct qib_devdata *dd = dd_from_dev(dev);
-	int ret;
-	int idx;
+	int i;
 	u8 regvals[8];
 
-	ret = -ENXIO;
-	for (idx = 0; idx < 8; ++idx) {
-		if (idx == 6)
+	for (i = 0; i < 8; i++) {
+		int ret;
+
+		if (i == 6)
 			continue;
-		ret = dd->f_tempsense_rd(dd, idx);
+		ret = dd->f_tempsense_rd(dd, i);
 		if (ret < 0)
-			break;
-		regvals[idx] = ret;
+			return ret;	/* return error on bad read */
+		regvals[i] = ret;
 	}
-	if (idx == 8)
-		ret = sysfs_emit(buf, "%d %d %02X %02X %d %d\n",
-				 *(signed char *)(regvals),
-				 *(signed char *)(regvals + 1),
-				 regvals[2], regvals[3],
-				 *(signed char *)(regvals + 5),
-				 *(signed char *)(regvals + 7));
-	return ret;
+
+	return sysfs_emit(buf, "%d %d %02X %02X %d %d\n",
+			  (signed char)regvals[0],
+			  (signed char)regvals[1],
+			  regvals[2],
+			  regvals[3],
+			  (signed char)regvals[5],
+			  (signed char)regvals[7]);
 }
 static DEVICE_ATTR_RO(tempsense);
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index 38da539c61e0..eddad4f0bd2d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -57,7 +57,7 @@ static ssize_t board_id_show(struct device *device,
 	subsystem_device_id = us_ibdev->pdev->subsystem_device;
 	mutex_unlock(&us_ibdev->usdev_lock);
 
-	return sysfs_emit(buf, "%hu\n", subsystem_device_id);
+	return sysfs_emit(buf, "%u\n", subsystem_device_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
@@ -69,19 +69,13 @@ config_show(struct device *device, struct device_attribute *attr, char *buf)
 {
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
-	char *ptr;
-	unsigned left;
-	unsigned n;
 	enum usnic_vnic_res_type res_type;
-
-	/* Buffer space limit is 1 page */
-	ptr = buf;
-	left = PAGE_SIZE;
+	int len;
 
 	mutex_lock(&us_ibdev->usdev_lock);
 	if (kref_read(&us_ibdev->vf_cnt) > 0) {
 		char *busname;
-
+		char *sep = "";
 		/*
 		 * bus name seems to come with annoying prefix.
 		 * Remove it if it is predictable
@@ -90,39 +84,36 @@ config_show(struct device *device, struct device_attribute *attr, char *buf)
 		if (strncmp(busname, "PCI Bus ", 8) == 0)
 			busname += 8;
 
-		n = scnprintf(ptr, left,
-			"%s: %s:%d.%d, %s, %pM, %u VFs\n Per VF:",
-			dev_name(&us_ibdev->ib_dev.dev),
-			busname,
-			PCI_SLOT(us_ibdev->pdev->devfn),
-			PCI_FUNC(us_ibdev->pdev->devfn),
-			netdev_name(us_ibdev->netdev),
-			us_ibdev->ufdev->mac,
-			kref_read(&us_ibdev->vf_cnt));
-		UPDATE_PTR_LEFT(n, ptr, left);
+		len = sysfs_emit(buf, "%s: %s:%d.%d, %s, %pM, %u VFs\n",
+				 dev_name(&us_ibdev->ib_dev.dev),
+				 busname,
+				 PCI_SLOT(us_ibdev->pdev->devfn),
+				 PCI_FUNC(us_ibdev->pdev->devfn),
+				 netdev_name(us_ibdev->netdev),
+				 us_ibdev->ufdev->mac,
+				 kref_read(&us_ibdev->vf_cnt));
 
+		len += sysfs_emit_at(buf, len, " Per VF:");
 		for (res_type = USNIC_VNIC_RES_TYPE_EOL;
-				res_type < USNIC_VNIC_RES_TYPE_MAX;
-				res_type++) {
+		     res_type < USNIC_VNIC_RES_TYPE_MAX;
+		     res_type++) {
 			if (us_ibdev->vf_res_cnt[res_type] == 0)
 				continue;
-			n = scnprintf(ptr, left, " %d %s%s",
-				us_ibdev->vf_res_cnt[res_type],
-				usnic_vnic_res_type_to_str(res_type),
-				(res_type < (USNIC_VNIC_RES_TYPE_MAX - 1)) ?
-				 "," : "");
-			UPDATE_PTR_LEFT(n, ptr, left);
+			len += sysfs_emit_at(buf, len, "%s %d %s",
+					     sep,
+					     us_ibdev->vf_res_cnt[res_type],
+					     usnic_vnic_res_type_to_str(res_type));
+			sep = ",";
 		}
-		n = scnprintf(ptr, left, "\n");
-		UPDATE_PTR_LEFT(n, ptr, left);
+		len += sysfs_emit_at(buf, len, "\n");
 	} else {
-		n = scnprintf(ptr, left, "%s: no VFs\n",
-				dev_name(&us_ibdev->ib_dev.dev));
-		UPDATE_PTR_LEFT(n, ptr, left);
+		len = sysfs_emit(buf, "%s: no VFs\n",
+				 dev_name(&us_ibdev->ib_dev.dev));
 	}
+
 	mutex_unlock(&us_ibdev->usdev_lock);
 
-	return ptr - buf;
+	return len;
 }
 static DEVICE_ATTR_RO(config);
 
@@ -132,8 +123,7 @@ iface_show(struct device *device, struct device_attribute *attr, char *buf)
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
 
-	return sysfs_emit(buf, "%s\n",
-			  netdev_name(us_ibdev->netdev));
+	return sysfs_emit(buf, "%s\n", netdev_name(us_ibdev->netdev));
 }
 static DEVICE_ATTR_RO(iface);
 
@@ -143,8 +133,7 @@ max_vf_show(struct device *device, struct device_attribute *attr, char *buf)
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
 
-	return sysfs_emit(buf, "%u\n",
-			  kref_read(&us_ibdev->vf_cnt));
+	return sysfs_emit(buf, "%u\n", kref_read(&us_ibdev->vf_cnt));
 }
 static DEVICE_ATTR_RO(max_vf);
 
@@ -158,8 +147,7 @@ qp_per_vf_show(struct device *device, struct device_attribute *attr, char *buf)
 	qp_per_vf = max(us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_WQ],
 			us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_RQ]);
 
-	return sysfs_emit(buf,
-				"%d\n", qp_per_vf);
+	return sysfs_emit(buf, "%d\n", qp_per_vf);
 }
 static DEVICE_ATTR_RO(qp_per_vf);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 0c767582286b..51ba82fc425c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -196,11 +196,10 @@ static struct kobj_attribute rtrs_clt_state_attr =
 	__ATTR(state, 0444, rtrs_clt_state_show, NULL);
 
 static ssize_t rtrs_clt_reconnect_show(struct kobject *kobj,
-					struct kobj_attribute *attr,
-					char *buf)
+				       struct kobj_attribute *attr,
+				       char *buf)
 {
-	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
-			  attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
 }
 
 static ssize_t rtrs_clt_reconnect_store(struct kobject *kobj,
@@ -228,11 +227,10 @@ static struct kobj_attribute rtrs_clt_reconnect_attr =
 	       rtrs_clt_reconnect_store);
 
 static ssize_t rtrs_clt_disconnect_show(struct kobject *kobj,
-					 struct kobj_attribute *attr,
-					 char *buf)
+					struct kobj_attribute *attr,
+					char *buf)
 {
-	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
-			  attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
 }
 
 static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
@@ -260,11 +258,10 @@ static struct kobj_attribute rtrs_clt_disconnect_attr =
 	       rtrs_clt_disconnect_store);
 
 static ssize_t rtrs_clt_remove_path_show(struct kobject *kobj,
-					  struct kobj_attribute *attr,
-					  char *buf)
+					 struct kobj_attribute *attr,
+					 char *buf)
 {
-	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
-			  attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
 }
 
 static ssize_t rtrs_clt_remove_path_store(struct kobject *kobj,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 381a776ce404..6e7bebe4e064 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -27,11 +27,10 @@ static struct kobj_type ktype = {
 };
 
 static ssize_t rtrs_srv_disconnect_show(struct kobject *kobj,
-					 struct kobj_attribute *attr,
-					 char *buf)
+					struct kobj_attribute *attr,
+					char *buf)
 {
-	return sysfs_emit(buf, "Usage: echo 1 > %s\n",
-			  attr->attr.name);
+	return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
 }
 
 static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
@@ -72,8 +71,7 @@ static ssize_t rtrs_srv_hca_port_show(struct kobject *kobj,
 	sess = container_of(kobj, typeof(*sess), kobj);
 	usr_con = sess->s.con[0];
 
-	return sysfs_emit(page, "%u\n",
-			  usr_con->cm_id->port_num);
+	return sysfs_emit(page, "%u\n", usr_con->cm_id->port_num);
 }
 
 static struct kobj_attribute rtrs_srv_hca_port_attr =
@@ -87,8 +85,7 @@ static ssize_t rtrs_srv_hca_name_show(struct kobject *kobj,
 
 	sess = container_of(kobj, struct rtrs_srv_sess, kobj);
 
-	return sysfs_emit(page, "%s\n",
-			  sess->s.dev->ib_dev->name);
+	return sysfs_emit(page, "%s\n", sess->s.dev->ib_dev->name);
 }
 
 static struct kobj_attribute rtrs_srv_hca_name_attr =
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index c9284f767ec1..4a5a4f522fd5 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2925,6 +2925,7 @@ static ssize_t show_pkey(struct device *dev, struct device_attribute *attr,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
+
 	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(target->ib_cm.pkey));
 }
 
@@ -2944,6 +2945,7 @@ static ssize_t show_dgid(struct device *dev, struct device_attribute *attr,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
+
 	return sysfs_emit(buf, "%pI6\n", ch->ib_cm.path.dgid.raw);
 }
 
@@ -2954,6 +2956,7 @@ static ssize_t show_orig_dgid(struct device *dev,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
+
 	return sysfs_emit(buf, "%pI6\n", target->ib_cm.orig_dgid.raw);
 }
 
@@ -2968,6 +2971,7 @@ static ssize_t show_req_lim(struct device *dev,
 		ch = &target->ch[i];
 		req_lim = min(req_lim, ch->req_lim);
 	}
+
 	return sysfs_emit(buf, "%d\n", req_lim);
 }
 
-- 
2.26.0

