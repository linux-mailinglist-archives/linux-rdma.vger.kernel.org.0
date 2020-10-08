Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF82286CD4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgJHCgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:36:48 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:47254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727663AbgJHCgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:36:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id ECA2F1822408A;
        Thu,  8 Oct 2020 02:36:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:327:355:379:541:960:966:968:973:982:988:989:1260:1311:1314:1345:1359:1437:1461:1515:1605:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:2736:3138:3139:3140:3141:3142:3865:3866:3867:3868:3871:3872:3874:4321:4385:4605:5007:6261:6737:6738:7903:7974:8957:10004:10848:11026:11657:11914:12043:12048:12295:12296:12297:12438:12555:12712:12737:12895:12986:13894:14394:21080:21325:21433:21451:21611:21627:21773:21795:21939:21987:21990:30029:30034:30051:30054:30056:30075:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:120,LUA_SUMMARY:none
X-HE-Tag: man69_1f090a1271d4
X-Filterd-Recvd-Size: 45139
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:36:39 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 1/4] RDMA: Convert sysfs device * show functions to use sysfs_emit()
Date:   Wed,  7 Oct 2020 19:36:24 -0700
Message-Id: <7f406fa8e3aa2552c022bec680f621e38d1fe414.1602122879.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1602122879.git.joe@perches.com>
References: <cover.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Done with cocci script:

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/infiniband/core/sysfs.c               | 47 +++++++++++--------
 drivers/infiniband/core/ucma.c                |  2 +-
 drivers/infiniband/core/user_mad.c            |  4 +-
 drivers/infiniband/core/uverbs_main.c         |  4 +-
 drivers/infiniband/hw/bnxt_re/main.c          |  4 +-
 drivers/infiniband/hw/cxgb4/provider.c        | 10 ++--
 drivers/infiniband/hw/hfi1/sysfs.c            | 16 +++----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  6 +--
 drivers/infiniband/hw/mlx4/main.c             |  8 ++--
 drivers/infiniband/hw/mlx4/sysfs.c            | 30 ++++++------
 drivers/infiniband/hw/mlx5/main.c             | 13 ++---
 drivers/infiniband/hw/mthca/mthca_provider.c  | 14 +++---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  4 +-
 drivers/infiniband/hw/qedr/main.c             | 10 ++--
 drivers/infiniband/hw/qib/qib_sysfs.c         | 30 ++++++------
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  | 16 +++----
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       |  4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  7 +--
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c     |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 17 ++++---
 drivers/infiniband/ulp/srp/ib_srp.c           | 41 ++++++++--------
 23 files changed, 156 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 914cddea525d..79327200da70 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1230,14 +1230,23 @@ static ssize_t node_type_show(struct device *device,
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
 	switch (dev->node_type) {
-	case RDMA_NODE_IB_CA:	  return sprintf(buf, "%d: CA\n", dev->node_type);
-	case RDMA_NODE_RNIC:	  return sprintf(buf, "%d: RNIC\n", dev->node_type);
-	case RDMA_NODE_USNIC:	  return sprintf(buf, "%d: usNIC\n", dev->node_type);
-	case RDMA_NODE_USNIC_UDP: return sprintf(buf, "%d: usNIC UDP\n", dev->node_type);
-	case RDMA_NODE_UNSPECIFIED: return sprintf(buf, "%d: unspecified\n", dev->node_type);
-	case RDMA_NODE_IB_SWITCH: return sprintf(buf, "%d: switch\n", dev->node_type);
-	case RDMA_NODE_IB_ROUTER: return sprintf(buf, "%d: router\n", dev->node_type);
-	default:		  return sprintf(buf, "%d: <unknown>\n", dev->node_type);
+	case RDMA_NODE_IB_CA:	  return sysfs_emit(buf, "%d: CA\n",
+							 dev->node_type);
+	case RDMA_NODE_RNIC:	  return sysfs_emit(buf, "%d: RNIC\n",
+							dev->node_type);
+	case RDMA_NODE_USNIC:	  return sysfs_emit(buf, "%d: usNIC\n",
+							 dev->node_type);
+	case RDMA_NODE_USNIC_UDP: return sysfs_emit(buf, "%d: usNIC UDP\n",
+						    dev->node_type);
+	case RDMA_NODE_UNSPECIFIED: return sysfs_emit(buf,
+						      "%d: unspecified\n",
+						      dev->node_type);
+	case RDMA_NODE_IB_SWITCH: return sysfs_emit(buf, "%d: switch\n",
+						    dev->node_type);
+	case RDMA_NODE_IB_ROUTER: return sysfs_emit(buf, "%d: router\n",
+						    dev->node_type);
+	default:		  return sysfs_emit(buf, "%d: <unknown>\n",
+						    dev->node_type);
 	}
 }
 static DEVICE_ATTR_RO(node_type);
@@ -1247,11 +1256,11 @@ static ssize_t sys_image_guid_show(struct device *device,
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
-	return sprintf(buf, "%04x:%04x:%04x:%04x\n",
-		       be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[0]),
-		       be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[1]),
-		       be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[2]),
-		       be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[3]));
+	return sysfs_emit(buf, "%04x:%04x:%04x:%04x\n",
+			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[0]),
+			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[1]),
+			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[2]),
+			  be16_to_cpu(((__be16 *) &dev->attrs.sys_image_guid)[3]));
 }
 static DEVICE_ATTR_RO(sys_image_guid);
 
@@ -1260,11 +1269,11 @@ static ssize_t node_guid_show(struct device *device,
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
-	return sprintf(buf, "%04x:%04x:%04x:%04x\n",
-		       be16_to_cpu(((__be16 *) &dev->node_guid)[0]),
-		       be16_to_cpu(((__be16 *) &dev->node_guid)[1]),
-		       be16_to_cpu(((__be16 *) &dev->node_guid)[2]),
-		       be16_to_cpu(((__be16 *) &dev->node_guid)[3]));
+	return sysfs_emit(buf, "%04x:%04x:%04x:%04x\n",
+			  be16_to_cpu(((__be16 *) &dev->node_guid)[0]),
+			  be16_to_cpu(((__be16 *) &dev->node_guid)[1]),
+			  be16_to_cpu(((__be16 *) &dev->node_guid)[2]),
+			  be16_to_cpu(((__be16 *) &dev->node_guid)[3]));
 }
 static DEVICE_ATTR_RO(node_guid);
 
@@ -1273,7 +1282,7 @@ static ssize_t node_desc_show(struct device *device,
 {
 	struct ib_device *dev = rdma_device_to_ibdev(device);
 
-	return sprintf(buf, "%.64s\n", dev->node_desc);
+	return sysfs_emit(buf, "%.64s\n", dev->node_desc);
 }
 
 static ssize_t node_desc_store(struct device *device,
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 08a628246bd6..4368d4e4d6c3 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1824,7 +1824,7 @@ static ssize_t show_abi_version(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	return sprintf(buf, "%d\n", RDMA_USER_CM_ABI_VERSION);
+	return sysfs_emit(buf, "%d\n", RDMA_USER_CM_ABI_VERSION);
 }
 static DEVICE_ATTR(abi_version, S_IRUGO, show_abi_version, NULL);
 
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index b0d0b522cc76..7e759f5b2a75 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1191,7 +1191,7 @@ static ssize_t ibdev_show(struct device *dev, struct device_attribute *attr,
 	if (!port)
 		return -ENODEV;
 
-	return sprintf(buf, "%s\n", dev_name(&port->ib_dev->dev));
+	return sysfs_emit(buf, "%s\n", dev_name(&port->ib_dev->dev));
 }
 static DEVICE_ATTR_RO(ibdev);
 
@@ -1203,7 +1203,7 @@ static ssize_t port_show(struct device *dev, struct device_attribute *attr,
 	if (!port)
 		return -ENODEV;
 
-	return sprintf(buf, "%d\n", port->port_num);
+	return sysfs_emit(buf, "%d\n", port->port_num);
 }
 static DEVICE_ATTR_RO(port);
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 4bb7c642f80c..f173ecd102dc 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1046,7 +1046,7 @@ static ssize_t ibdev_show(struct device *device, struct device_attribute *attr,
 	srcu_key = srcu_read_lock(&dev->disassociate_srcu);
 	ib_dev = srcu_dereference(dev->ib_dev, &dev->disassociate_srcu);
 	if (ib_dev)
-		ret = sprintf(buf, "%s\n", dev_name(&ib_dev->dev));
+		ret = sysfs_emit(buf, "%s\n", dev_name(&ib_dev->dev));
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
 
 	return ret;
@@ -1065,7 +1065,7 @@ static ssize_t abi_version_show(struct device *device,
 	srcu_key = srcu_read_lock(&dev->disassociate_srcu);
 	ib_dev = srcu_dereference(dev->ib_dev, &dev->disassociate_srcu);
 	if (ib_dev)
-		ret = sprintf(buf, "%u\n", ib_dev->ops.uverbs_abi_ver);
+		ret = sysfs_emit(buf, "%u\n", ib_dev->ops.uverbs_abi_ver);
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
 
 	return ret;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 53aee5a42ab8..202a0e229d44 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -608,7 +608,7 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct bnxt_re_dev *rdev =
 		rdma_device_to_drv_device(device, struct bnxt_re_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", rdev->en_dev->pdev->vendor);
+	return sysfs_emit(buf, "0x%x\n", rdev->en_dev->pdev->vendor);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -618,7 +618,7 @@ static ssize_t hca_type_show(struct device *device,
 	struct bnxt_re_dev *rdev =
 		rdma_device_to_drv_device(device, struct bnxt_re_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", rdev->ibdev.node_desc);
+	return sysfs_emit(buf, "%s\n", rdev->ibdev.node_desc);
 }
 static DEVICE_ATTR_RO(hca_type);
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 4b76f2f3f4e4..b312a7ec40bf 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -322,8 +322,8 @@ static ssize_t hw_rev_show(struct device *dev,
 			rdma_device_to_drv_device(dev, struct c4iw_dev, ibdev);
 
 	pr_debug("dev 0x%p\n", dev);
-	return sprintf(buf, "%d\n",
-		       CHELSIO_CHIP_RELEASE(c4iw_dev->rdev.lldi.adapter_type));
+	return sysfs_emit(buf, "%d\n",
+			  CHELSIO_CHIP_RELEASE(c4iw_dev->rdev.lldi.adapter_type));
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -337,7 +337,7 @@ static ssize_t hca_type_show(struct device *dev,
 
 	pr_debug("dev 0x%p\n", dev);
 	lldev->ethtool_ops->get_drvinfo(lldev, &info);
-	return sprintf(buf, "%s\n", info.driver);
+	return sysfs_emit(buf, "%s\n", info.driver);
 }
 static DEVICE_ATTR_RO(hca_type);
 
@@ -348,8 +348,8 @@ static ssize_t board_id_show(struct device *dev, struct device_attribute *attr,
 			rdma_device_to_drv_device(dev, struct c4iw_dev, ibdev);
 
 	pr_debug("dev 0x%p\n", dev);
-	return sprintf(buf, "%x.%x\n", c4iw_dev->rdev.lldi.pdev->vendor,
-		       c4iw_dev->rdev.lldi.pdev->device);
+	return sysfs_emit(buf, "%x.%x\n", c4iw_dev->rdev.lldi.pdev->vendor,
+			  c4iw_dev->rdev.lldi.pdev->device);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 074ec71772d2..e2a88f3cea7f 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -500,7 +500,7 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct hfi1_ibdev *dev =
 		rdma_device_to_drv_device(device, struct hfi1_ibdev, rdi.ibdev);
 
-	return sprintf(buf, "%x\n", dd_from_dev(dev)->minrev);
+	return sysfs_emit(buf, "%x\n", dd_from_dev(dev)->minrev);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -515,7 +515,7 @@ static ssize_t board_id_show(struct device *device,
 	if (!dd->boardname)
 		ret = -EINVAL;
 	else
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", dd->boardname);
+		ret = sysfs_emit(buf, "%s\n", dd->boardname);
 	return ret;
 }
 static DEVICE_ATTR_RO(board_id);
@@ -528,7 +528,7 @@ static ssize_t boardversion_show(struct device *device,
 	struct hfi1_devdata *dd = dd_from_dev(dev);
 
 	/* The string printed here is already newline-terminated. */
-	return scnprintf(buf, PAGE_SIZE, "%s", dd->boardversion);
+	return sysfs_emit(buf, "%s", dd->boardversion);
 }
 static DEVICE_ATTR_RO(boardversion);
 
@@ -545,9 +545,9 @@ static ssize_t nctxts_show(struct device *device,
 	 * and a receive context, so returning the smaller of the two counts
 	 * give a more accurate picture of total contexts available.
 	 */
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 min(dd->num_user_contexts,
-			     (u32)dd->sc_sizes[SC_USER].count));
+	return sysfs_emit(buf, "%u\n",
+			  min(dd->num_user_contexts,
+			      (u32)dd->sc_sizes[SC_USER].count));
 }
 static DEVICE_ATTR_RO(nctxts);
 
@@ -559,7 +559,7 @@ static ssize_t nfreectxts_show(struct device *device,
 	struct hfi1_devdata *dd = dd_from_dev(dev);
 
 	/* Return the number of free user ports (contexts) available. */
-	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->freectxts);
+	return sysfs_emit(buf, "%u\n", dd->freectxts);
 }
 static DEVICE_ATTR_RO(nfreectxts);
 
@@ -570,7 +570,7 @@ static ssize_t serial_show(struct device *device,
 		rdma_device_to_drv_device(device, struct hfi1_ibdev, rdi.ibdev);
 	struct hfi1_devdata *dd = dd_from_dev(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s", dd->serial);
+	return sysfs_emit(buf, "%s", dd->serial);
 }
 static DEVICE_ATTR_RO(serial);
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 747b4de6faca..4f4c9f7097fe 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2056,7 +2056,7 @@ static ssize_t hw_rev_show(struct device *dev,
 		rdma_device_to_drv_device(dev, struct i40iw_ib_device, ibdev);
 	u32 hw_rev = iwibdev->iwdev->sc_dev.hw_rev;
 
-	return sprintf(buf, "%x\n", hw_rev);
+	return sysfs_emit(buf, "%x\n", hw_rev);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -2066,7 +2066,7 @@ static DEVICE_ATTR_RO(hw_rev);
 static ssize_t hca_type_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "I40IW\n");
+	return sysfs_emit(buf, "I40IW\n");
 }
 static DEVICE_ATTR_RO(hca_type);
 
@@ -2076,7 +2076,7 @@ static DEVICE_ATTR_RO(hca_type);
 static ssize_t board_id_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%.*s\n", 32, "I40IW Board ID");
+	return sysfs_emit(buf, "%.*s\n", 32, "I40IW Board ID");
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 753c70402498..ad3c8f985921 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2024,7 +2024,7 @@ static ssize_t hca_type_show(struct device *device,
 {
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
-	return sprintf(buf, "MT%d\n", dev->dev->persist->pdev->device);
+	return sysfs_emit(buf, "MT%d\n", dev->dev->persist->pdev->device);
 }
 static DEVICE_ATTR_RO(hca_type);
 
@@ -2033,7 +2033,7 @@ static ssize_t hw_rev_show(struct device *device,
 {
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
-	return sprintf(buf, "%x\n", dev->dev->rev_id);
+	return sysfs_emit(buf, "%x\n", dev->dev->rev_id);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -2043,8 +2043,8 @@ static ssize_t board_id_show(struct device *device,
 	struct mlx4_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx4_ib_dev, ib_dev);
 
-	return sprintf(buf, "%.*s\n", MLX4_BOARD_ID_LEN,
-		       dev->dev->board_id);
+	return sysfs_emit(buf, "%.*s\n", MLX4_BOARD_ID_LEN,
+			  dev->dev->board_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index ea1f3a081b05..26c717a4911f 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -56,7 +56,7 @@ static ssize_t show_admin_alias_guid(struct device *dev,
 					      mlx4_ib_iov_dentry->entry_num,
 					      port->num);
 
-	return sprintf(buf, "%llx\n", be64_to_cpu(sysadmin_ag_val));
+	return sysfs_emit(buf, "%llx\n", be64_to_cpu(sysadmin_ag_val));
 }
 
 /* store_admin_alias_guid stores the (new) administratively assigned value of that GUID.
@@ -123,15 +123,15 @@ static ssize_t show_port_gid(struct device *dev,
 				  mlx4_ib_iov_dentry->entry_num, &gid, 1);
 	if (ret)
 		return ret;
-	ret = sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-		      be16_to_cpu(((__be16 *) gid.raw)[0]),
-		      be16_to_cpu(((__be16 *) gid.raw)[1]),
-		      be16_to_cpu(((__be16 *) gid.raw)[2]),
-		      be16_to_cpu(((__be16 *) gid.raw)[3]),
-		      be16_to_cpu(((__be16 *) gid.raw)[4]),
-		      be16_to_cpu(((__be16 *) gid.raw)[5]),
-		      be16_to_cpu(((__be16 *) gid.raw)[6]),
-		      be16_to_cpu(((__be16 *) gid.raw)[7]));
+	ret = sysfs_emit(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+			 be16_to_cpu(((__be16 *) gid.raw)[0]),
+			 be16_to_cpu(((__be16 *) gid.raw)[1]),
+			 be16_to_cpu(((__be16 *) gid.raw)[2]),
+			 be16_to_cpu(((__be16 *) gid.raw)[3]),
+			 be16_to_cpu(((__be16 *) gid.raw)[4]),
+			 be16_to_cpu(((__be16 *) gid.raw)[5]),
+			 be16_to_cpu(((__be16 *) gid.raw)[6]),
+			 be16_to_cpu(((__be16 *) gid.raw)[7]));
 	return ret;
 }
 
@@ -151,7 +151,7 @@ static ssize_t show_phys_port_pkey(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "0x%04x\n", pkey);
+	return sysfs_emit(buf, "0x%04x\n", pkey);
 }
 
 #define DENTRY_REMOVE(_dentry)						\
@@ -545,9 +545,9 @@ static ssize_t sysfs_show_smi_enabled(struct device *dev,
 	ssize_t len = 0;
 
 	if (mlx4_vf_smi_enabled(p->dev->dev, p->slave, p->port_num))
-		len = sprintf(buf, "%d\n", 1);
+		len = sysfs_emit(buf, "%d\n", 1);
 	else
-		len = sprintf(buf, "%d\n", 0);
+		len = sysfs_emit(buf, "%d\n", 0);
 
 	return len;
 }
@@ -561,9 +561,9 @@ static ssize_t sysfs_show_enable_smi_admin(struct device *dev,
 	ssize_t len = 0;
 
 	if (mlx4_vf_get_enable_smi_admin(p->dev->dev, p->slave, p->port_num))
-		len = sprintf(buf, "%d\n", 1);
+		len = sysfs_emit(buf, "%d\n", 1);
 	else
-		len = sprintf(buf, "%d\n", 0);
+		len = sysfs_emit(buf, "%d\n", 0);
 
 	return len;
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 7082172b5b61..8b9f6f857120 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2628,7 +2628,7 @@ static ssize_t fw_pages_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sprintf(buf, "%d\n", dev->mdev->priv.fw_pages);
+	return sysfs_emit(buf, "%d\n", dev->mdev->priv.fw_pages);
 }
 static DEVICE_ATTR_RO(fw_pages);
 
@@ -2638,7 +2638,8 @@ static ssize_t reg_pages_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sprintf(buf, "%d\n", atomic_read(&dev->mdev->priv.reg_pages));
+	return sysfs_emit(buf, "%d\n",
+			  atomic_read(&dev->mdev->priv.reg_pages));
 }
 static DEVICE_ATTR_RO(reg_pages);
 
@@ -2648,7 +2649,7 @@ static ssize_t hca_type_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sprintf(buf, "MT%d\n", dev->mdev->pdev->device);
+	return sysfs_emit(buf, "MT%d\n", dev->mdev->pdev->device);
 }
 static DEVICE_ATTR_RO(hca_type);
 
@@ -2658,7 +2659,7 @@ static ssize_t hw_rev_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sprintf(buf, "%x\n", dev->mdev->rev_id);
+	return sysfs_emit(buf, "%x\n", dev->mdev->rev_id);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -2668,8 +2669,8 @@ static ssize_t board_id_show(struct device *device,
 	struct mlx5_ib_dev *dev =
 		rdma_device_to_drv_device(device, struct mlx5_ib_dev, ib_dev);
 
-	return sprintf(buf, "%.*s\n", MLX5_BOARD_ID_LEN,
-		       dev->mdev->board_id);
+	return sysfs_emit(buf, "%.*s\n", MLX5_BOARD_ID_LEN,
+			  dev->mdev->board_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 31b558ff8218..b6e4254e4558 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -961,7 +961,7 @@ static ssize_t hw_rev_show(struct device *device,
 	struct mthca_dev *dev =
 		rdma_device_to_drv_device(device, struct mthca_dev, ib_dev);
 
-	return sprintf(buf, "%x\n", dev->rev_id);
+	return sysfs_emit(buf, "%x\n", dev->rev_id);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -973,16 +973,16 @@ static ssize_t hca_type_show(struct device *device,
 
 	switch (dev->pdev->device) {
 	case PCI_DEVICE_ID_MELLANOX_TAVOR:
-		return sprintf(buf, "MT23108\n");
+		return sysfs_emit(buf, "MT23108\n");
 	case PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT:
-		return sprintf(buf, "MT25208 (MT23108 compat mode)\n");
+		return sysfs_emit(buf, "MT25208 (MT23108 compat mode)\n");
 	case PCI_DEVICE_ID_MELLANOX_ARBEL:
-		return sprintf(buf, "MT25208\n");
+		return sysfs_emit(buf, "MT25208\n");
 	case PCI_DEVICE_ID_MELLANOX_SINAI:
 	case PCI_DEVICE_ID_MELLANOX_SINAI_OLD:
-		return sprintf(buf, "MT25204\n");
+		return sysfs_emit(buf, "MT25204\n");
 	default:
-		return sprintf(buf, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	}
 }
 static DEVICE_ATTR_RO(hca_type);
@@ -993,7 +993,7 @@ static ssize_t board_id_show(struct device *device,
 	struct mthca_dev *dev =
 		rdma_device_to_drv_device(device, struct mthca_dev, ib_dev);
 
-	return sprintf(buf, "%.*s\n", MTHCA_BOARD_ID_LEN, dev->board_id);
+	return sysfs_emit(buf, "%.*s\n", MTHCA_BOARD_ID_LEN, dev->board_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index d8c47d24d6d6..e95641b26653 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -119,7 +119,7 @@ static ssize_t hw_rev_show(struct device *device,
 	struct ocrdma_dev *dev =
 		rdma_device_to_drv_device(device, struct ocrdma_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dev->nic_info.pdev->vendor);
+	return sysfs_emit(buf, "0x%x\n", dev->nic_info.pdev->vendor);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -129,7 +129,7 @@ static ssize_t hca_type_show(struct device *device,
 	struct ocrdma_dev *dev =
 		rdma_device_to_drv_device(device, struct ocrdma_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", &dev->model_number[0]);
+	return sysfs_emit(buf, "%s\n", &dev->model_number[0]);
 }
 static DEVICE_ATTR_RO(hca_type);
 
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 7c0aac3e635b..c1eaceac5016 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -124,7 +124,7 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct qedr_dev *dev =
 		rdma_device_to_drv_device(device, struct qedr_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dev->attr.hw_ver);
+	return sysfs_emit(buf, "0x%x\n", dev->attr.hw_ver);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -134,10 +134,10 @@ static ssize_t hca_type_show(struct device *device,
 	struct qedr_dev *dev =
 		rdma_device_to_drv_device(device, struct qedr_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "FastLinQ QL%x %s\n",
-			 dev->pdev->device,
-			 rdma_protocol_iwarp(&dev->ibdev, 1) ?
-			 "iWARP" : "RoCE");
+	return sysfs_emit(buf, "FastLinQ QL%x %s\n",
+			  dev->pdev->device,
+			  rdma_protocol_iwarp(&dev->ibdev, 1) ?
+			  "iWARP" : "RoCE");
 }
 static DEVICE_ATTR_RO(hca_type);
 
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 021df0654ba7..2963915d0851 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -565,7 +565,7 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct qib_ibdev *dev =
 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
 
-	return sprintf(buf, "%x\n", dd_from_dev(dev)->minrev);
+	return sysfs_emit(buf, "%x\n", dd_from_dev(dev)->minrev);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
@@ -580,7 +580,7 @@ static ssize_t hca_type_show(struct device *device,
 	if (!dd->boardname)
 		ret = -EINVAL;
 	else
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", dd->boardname);
+		ret = sysfs_emit(buf, "%s\n", dd->boardname);
 	return ret;
 }
 static DEVICE_ATTR_RO(hca_type);
@@ -590,7 +590,7 @@ static ssize_t version_show(struct device *device,
 			    struct device_attribute *attr, char *buf)
 {
 	/* The string printed here is already newline-terminated. */
-	return scnprintf(buf, PAGE_SIZE, "%s", (char *)ib_qib_version);
+	return sysfs_emit(buf, "%s", (char *)ib_qib_version);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -602,7 +602,7 @@ static ssize_t boardversion_show(struct device *device,
 	struct qib_devdata *dd = dd_from_dev(dev);
 
 	/* The string printed here is already newline-terminated. */
-	return scnprintf(buf, PAGE_SIZE, "%s", dd->boardversion);
+	return sysfs_emit(buf, "%s", dd->boardversion);
 }
 static DEVICE_ATTR_RO(boardversion);
 
@@ -614,7 +614,7 @@ static ssize_t localbus_info_show(struct device *device,
 	struct qib_devdata *dd = dd_from_dev(dev);
 
 	/* The string printed here is already newline-terminated. */
-	return scnprintf(buf, PAGE_SIZE, "%s", dd->lbus_info);
+	return sysfs_emit(buf, "%s", dd->lbus_info);
 }
 static DEVICE_ATTR_RO(localbus_info);
 
@@ -628,9 +628,9 @@ static ssize_t nctxts_show(struct device *device,
 	/* Return the number of user ports (contexts) available. */
 	/* The calculation below deals with a special case where
 	 * cfgctxts is set to 1 on a single-port board. */
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			(dd->first_user_ctxt > dd->cfgctxts) ? 0 :
-			(dd->cfgctxts - dd->first_user_ctxt));
+	return sysfs_emit(buf, "%u\n",
+			  (dd->first_user_ctxt > dd->cfgctxts) ? 0 :
+			  (dd->cfgctxts - dd->first_user_ctxt));
 }
 static DEVICE_ATTR_RO(nctxts);
 
@@ -642,7 +642,7 @@ static ssize_t nfreectxts_show(struct device *device,
 	struct qib_devdata *dd = dd_from_dev(dev);
 
 	/* Return the number of free user ports (contexts) available. */
-	return scnprintf(buf, PAGE_SIZE, "%u\n", dd->freectxts);
+	return sysfs_emit(buf, "%u\n", dd->freectxts);
 }
 static DEVICE_ATTR_RO(nfreectxts);
 
@@ -703,12 +703,12 @@ static ssize_t tempsense_show(struct device *device,
 		regvals[idx] = ret;
 	}
 	if (idx == 8)
-		ret = scnprintf(buf, PAGE_SIZE, "%d %d %02X %02X %d %d\n",
-				*(signed char *)(regvals),
-				*(signed char *)(regvals + 1),
-				regvals[2], regvals[3],
-				*(signed char *)(regvals + 5),
-				*(signed char *)(regvals + 7));
+		ret = sysfs_emit(buf, "%d %d %02X %02X %d %d\n",
+				 *(signed char *)(regvals),
+				 *(signed char *)(regvals + 1),
+				 regvals[2], regvals[3],
+				 *(signed char *)(regvals + 5),
+				 *(signed char *)(regvals + 7));
 	return ret;
 }
 static DEVICE_ATTR_RO(tempsense);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index c85d48ae7442..38da539c61e0 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -57,7 +57,7 @@ static ssize_t board_id_show(struct device *device,
 	subsystem_device_id = us_ibdev->pdev->subsystem_device;
 	mutex_unlock(&us_ibdev->usdev_lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%hu\n", subsystem_device_id);
+	return sysfs_emit(buf, "%hu\n", subsystem_device_id);
 }
 static DEVICE_ATTR_RO(board_id);
 
@@ -132,8 +132,8 @@ iface_show(struct device *device, struct device_attribute *attr, char *buf)
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n",
-			netdev_name(us_ibdev->netdev));
+	return sysfs_emit(buf, "%s\n",
+			  netdev_name(us_ibdev->netdev));
 }
 static DEVICE_ATTR_RO(iface);
 
@@ -143,8 +143,8 @@ max_vf_show(struct device *device, struct device_attribute *attr, char *buf)
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			kref_read(&us_ibdev->vf_cnt));
+	return sysfs_emit(buf, "%u\n",
+			  kref_read(&us_ibdev->vf_cnt));
 }
 static DEVICE_ATTR_RO(max_vf);
 
@@ -158,7 +158,7 @@ qp_per_vf_show(struct device *device, struct device_attribute *attr, char *buf)
 	qp_per_vf = max(us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_WQ],
 			us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_RQ]);
 
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 				"%d\n", qp_per_vf);
 }
 static DEVICE_ATTR_RO(qp_per_vf);
@@ -169,8 +169,8 @@ cq_per_vf_show(struct device *device, struct device_attribute *attr, char *buf)
 	struct usnic_ib_dev *us_ibdev =
 		rdma_device_to_drv_device(device, struct usnic_ib_dev, ib_dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_CQ]);
+	return sysfs_emit(buf, "%d\n",
+			  us_ibdev->vf_res_cnt[USNIC_VNIC_RES_TYPE_CQ]);
 }
 static DEVICE_ATTR_RO(cq_per_vf);
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 780fd2dfc07e..f7fbe2044571 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -68,21 +68,21 @@ static int pvrdma_del_gid(const struct ib_gid_attr *attr, void **context);
 static ssize_t hca_type_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "VMW_PVRDMA-%s\n", DRV_VERSION);
+	return sysfs_emit(buf, "VMW_PVRDMA-%s\n", DRV_VERSION);
 }
 static DEVICE_ATTR_RO(hca_type);
 
 static ssize_t hw_rev_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", PVRDMA_REV_ID);
+	return sysfs_emit(buf, "%d\n", PVRDMA_REV_ID);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
 static ssize_t board_id_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", PVRDMA_BOARD_ID);
+	return sysfs_emit(buf, "%d\n", PVRDMA_BOARD_ID);
 }
 static DEVICE_ATTR_RO(board_id);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f368dc16281a..afa9674aa35c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1033,7 +1033,7 @@ static ssize_t parent_show(struct device *device,
 	struct rxe_dev *rxe =
 		rdma_device_to_drv_device(device, struct rxe_dev, ib_dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", rxe_parent_name(rxe, 1));
+	return sysfs_emit(buf, "%s\n", rxe_parent_name(rxe, 1));
 }
 
 static DEVICE_ATTR_RO(parent);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 8f0b598a46ec..d5d592bdab35 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1514,9 +1514,9 @@ static ssize_t show_mode(struct device *d, struct device_attribute *attr,
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	if (test_bit(IPOIB_FLAG_ADMIN_CM, &priv->flags))
-		return sprintf(buf, "connected\n");
+		return sysfs_emit(buf, "connected\n");
 	else
-		return sprintf(buf, "datagram\n");
+		return sysfs_emit(buf, "datagram\n");
 }
 
 static ssize_t set_mode(struct device *d, struct device_attribute *attr,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index abfab89423f4..a6f413491321 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2266,7 +2266,7 @@ static ssize_t show_pkey(struct device *dev,
 	struct net_device *ndev = to_net_dev(dev);
 	struct ipoib_dev_priv *priv = ipoib_priv(ndev);
 
-	return sprintf(buf, "0x%04x\n", priv->pkey);
+	return sysfs_emit(buf, "0x%04x\n", priv->pkey);
 }
 static DEVICE_ATTR(pkey, S_IRUGO, show_pkey, NULL);
 
@@ -2276,7 +2276,8 @@ static ssize_t show_umcast(struct device *dev,
 	struct net_device *ndev = to_net_dev(dev);
 	struct ipoib_dev_priv *priv = ipoib_priv(ndev);
 
-	return sprintf(buf, "%d\n", test_bit(IPOIB_FLAG_UMCAST, &priv->flags));
+	return sysfs_emit(buf, "%d\n",
+			  test_bit(IPOIB_FLAG_UMCAST, &priv->flags));
 }
 
 void ipoib_set_umcast(struct net_device *ndev, int umcast_val)
@@ -2446,7 +2447,7 @@ static ssize_t dev_id_show(struct device *dev,
 			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
 			current->comm);
 
-	return sprintf(buf, "%#x\n", ndev->dev_id);
+	return sysfs_emit(buf, "%#x\n", ndev->dev_id);
 }
 static DEVICE_ATTR_RO(dev_id);
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4c50a87ed7cc..5958840dbeed 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -46,7 +46,7 @@ static ssize_t show_parent(struct device *d, struct device_attribute *attr,
 	struct net_device *dev = to_net_dev(d);
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
-	return sprintf(buf, "%s\n", priv->parent->name);
+	return sysfs_emit(buf, "%s\n", priv->parent->name);
 }
 static DEVICE_ATTR(parent, S_IRUGO, show_parent, NULL);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index ac4c49cbf153..7f71f10126fc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -52,7 +52,8 @@ static ssize_t max_reconnect_attempts_show(struct device *dev,
 {
 	struct rtrs_clt *clt = container_of(dev, struct rtrs_clt, dev);
 
-	return sprintf(page, "%d\n", rtrs_clt_get_max_reconnect_attempts(clt));
+	return sysfs_emit(page, "%d\n",
+			  rtrs_clt_get_max_reconnect_attempts(clt));
 }
 
 static ssize_t max_reconnect_attempts_store(struct device *dev,
@@ -95,11 +96,13 @@ static ssize_t mpath_policy_show(struct device *dev,
 
 	switch (clt->mp_policy) {
 	case MP_POLICY_RR:
-		return sprintf(page, "round-robin (RR: %d)\n", clt->mp_policy);
+		return sysfs_emit(page, "round-robin (RR: %d)\n",
+				  clt->mp_policy);
 	case MP_POLICY_MIN_INFLIGHT:
-		return sprintf(page, "min-inflight (MI: %d)\n", clt->mp_policy);
+		return sysfs_emit(page, "min-inflight (MI: %d)\n",
+				  clt->mp_policy);
 	default:
-		return sprintf(page, "Unknown (%d)\n", clt->mp_policy);
+		return sysfs_emit(page, "Unknown (%d)\n", clt->mp_policy);
 	}
 }
 
@@ -138,9 +141,9 @@ static DEVICE_ATTR_RW(mpath_policy);
 static ssize_t add_path_show(struct device *dev,
 			     struct device_attribute *attr, char *page)
 {
-	return scnprintf(page, PAGE_SIZE,
-			 "Usage: echo [<source addr>@]<destination addr> > %s\n\n*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]\n",
-			 attr->attr.name);
+	return sysfs_emit(page,
+			  "Usage: echo [<source addr>@]<destination addr> > %s\n\n*addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]\n",
+			  attr->attr.name);
 }
 
 static ssize_t add_path_store(struct device *dev,
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index d8fcd21ab472..c9284f767ec1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2896,7 +2896,7 @@ static ssize_t show_id_ext(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "0x%016llx\n", be64_to_cpu(target->id_ext));
+	return sysfs_emit(buf, "0x%016llx\n", be64_to_cpu(target->id_ext));
 }
 
 static ssize_t show_ioc_guid(struct device *dev, struct device_attribute *attr,
@@ -2904,7 +2904,7 @@ static ssize_t show_ioc_guid(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "0x%016llx\n", be64_to_cpu(target->ioc_guid));
+	return sysfs_emit(buf, "0x%016llx\n", be64_to_cpu(target->ioc_guid));
 }
 
 static ssize_t show_service_id(struct device *dev,
@@ -2914,8 +2914,8 @@ static ssize_t show_service_id(struct device *dev,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
-	return sprintf(buf, "0x%016llx\n",
-		       be64_to_cpu(target->ib_cm.service_id));
+	return sysfs_emit(buf, "0x%016llx\n",
+			  be64_to_cpu(target->ib_cm.service_id));
 }
 
 static ssize_t show_pkey(struct device *dev, struct device_attribute *attr,
@@ -2925,7 +2925,7 @@ static ssize_t show_pkey(struct device *dev, struct device_attribute *attr,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(target->ib_cm.pkey));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(target->ib_cm.pkey));
 }
 
 static ssize_t show_sgid(struct device *dev, struct device_attribute *attr,
@@ -2933,7 +2933,7 @@ static ssize_t show_sgid(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%pI6\n", target->sgid.raw);
+	return sysfs_emit(buf, "%pI6\n", target->sgid.raw);
 }
 
 static ssize_t show_dgid(struct device *dev, struct device_attribute *attr,
@@ -2944,7 +2944,7 @@ static ssize_t show_dgid(struct device *dev, struct device_attribute *attr,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
-	return sprintf(buf, "%pI6\n", ch->ib_cm.path.dgid.raw);
+	return sysfs_emit(buf, "%pI6\n", ch->ib_cm.path.dgid.raw);
 }
 
 static ssize_t show_orig_dgid(struct device *dev,
@@ -2954,7 +2954,7 @@ static ssize_t show_orig_dgid(struct device *dev,
 
 	if (target->using_rdma_cm)
 		return -ENOENT;
-	return sprintf(buf, "%pI6\n", target->ib_cm.orig_dgid.raw);
+	return sysfs_emit(buf, "%pI6\n", target->ib_cm.orig_dgid.raw);
 }
 
 static ssize_t show_req_lim(struct device *dev,
@@ -2968,7 +2968,7 @@ static ssize_t show_req_lim(struct device *dev,
 		ch = &target->ch[i];
 		req_lim = min(req_lim, ch->req_lim);
 	}
-	return sprintf(buf, "%d\n", req_lim);
+	return sysfs_emit(buf, "%d\n", req_lim);
 }
 
 static ssize_t show_zero_req_lim(struct device *dev,
@@ -2976,7 +2976,7 @@ static ssize_t show_zero_req_lim(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%d\n", target->zero_req_lim);
+	return sysfs_emit(buf, "%d\n", target->zero_req_lim);
 }
 
 static ssize_t show_local_ib_port(struct device *dev,
@@ -2984,7 +2984,7 @@ static ssize_t show_local_ib_port(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%d\n", target->srp_host->port);
+	return sysfs_emit(buf, "%d\n", target->srp_host->port);
 }
 
 static ssize_t show_local_ib_device(struct device *dev,
@@ -2992,8 +2992,8 @@ static ssize_t show_local_ib_device(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%s\n",
-		       dev_name(&target->srp_host->srp_dev->dev->dev));
+	return sysfs_emit(buf, "%s\n",
+			  dev_name(&target->srp_host->srp_dev->dev->dev));
 }
 
 static ssize_t show_ch_count(struct device *dev, struct device_attribute *attr,
@@ -3001,7 +3001,7 @@ static ssize_t show_ch_count(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%d\n", target->ch_count);
+	return sysfs_emit(buf, "%d\n", target->ch_count);
 }
 
 static ssize_t show_comp_vector(struct device *dev,
@@ -3009,7 +3009,7 @@ static ssize_t show_comp_vector(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%d\n", target->comp_vector);
+	return sysfs_emit(buf, "%d\n", target->comp_vector);
 }
 
 static ssize_t show_tl_retry_count(struct device *dev,
@@ -3017,7 +3017,7 @@ static ssize_t show_tl_retry_count(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%d\n", target->tl_retry_count);
+	return sysfs_emit(buf, "%d\n", target->tl_retry_count);
 }
 
 static ssize_t show_cmd_sg_entries(struct device *dev,
@@ -3025,7 +3025,7 @@ static ssize_t show_cmd_sg_entries(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%u\n", target->cmd_sg_cnt);
+	return sysfs_emit(buf, "%u\n", target->cmd_sg_cnt);
 }
 
 static ssize_t show_allow_ext_sg(struct device *dev,
@@ -3033,7 +3033,8 @@ static ssize_t show_allow_ext_sg(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%s\n", target->allow_ext_sg ? "true" : "false");
+	return sysfs_emit(buf, "%s\n",
+			  target->allow_ext_sg ? "true" : "false");
 }
 
 static DEVICE_ATTR(id_ext,	    S_IRUGO, show_id_ext,	   NULL);
@@ -3893,7 +3894,7 @@ static ssize_t show_ibdev(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
-	return sprintf(buf, "%s\n", dev_name(&host->srp_dev->dev->dev));
+	return sysfs_emit(buf, "%s\n", dev_name(&host->srp_dev->dev->dev));
 }
 
 static DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
@@ -3903,7 +3904,7 @@ static ssize_t show_port(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
-	return sprintf(buf, "%d\n", host->port);
+	return sysfs_emit(buf, "%d\n", host->port);
 }
 
 static DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
-- 
2.26.0

