Return-Path: <linux-rdma+bounces-2229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2F68BA60A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 06:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B62283AE9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 04:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9864C8F;
	Fri,  3 May 2024 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BU+LV8ny"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FE634;
	Fri,  3 May 2024 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714710706; cv=fail; b=F37PcjyOIxPAQVfcmZ+E5P7yGp9JFckL0M9Baf9oW/ZBCJP7zQ+O5m4K6xKc1b0JQTr6GLfhglU2WvwgnaourFzLYucO6lflaOPXqA9yXb8o1P1BXtkUPc65ZVxiUDl9uqQUec0XQ3OyjB0Q522G0Q1O/B9yurGJrHuULBdxD0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714710706; c=relaxed/simple;
	bh=51kjt+hCIAgodL0LC6lKjJ32ynUG0tgC+2EjuBwT9M0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5oRmRCNpBnHZ4VVs4oZKQQ+LY+sxhnw1fWjsX0SM8mHlw2/+AQeccKUQl77SuUBbAtWhrDjpPheEyz9miTusWDTAGKe8A+e21YO1avjliRUV3+5/Sf1dHaeJgwu0p11G5J6rBLwwZWSfBwQef6ieunACWYAtGTsjsCT49x9g5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BU+LV8ny; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWs9Vq+g3M7oCt2Blf6dQD20vCP9m0iELP+pjeKBrv5fhCC2FiN8+2r/eYO4bUL3gBf9iSNKiunLFP6D9eMzPieX1aGsDamd0i69uUrY71tMu/3dXvyi2rCT9yYy1Zy4tKHLeGyGJtPSUIZ57lnLVj8xlWgpbh3oTPa7Z1C5XcvGGNO4wgHNoQu3v6X5J2fYBDETD6wvCilx8+NgtrxnwhzbjjN0LCU+5+ajfIUrnRNUcjYw/ml2glbo2fUjsYRqOBrIvqXizf40jOExv2eO8t139+nfscLv2XBtJi1Gw7rzehglEp8GC9PaH4zRMnYsn7DABUvWzOa5G5OizK4sHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o43M//Q3E05qemzg04xcarxPSMabLzzu2UyTxhGyd6o=;
 b=CIIEZag6qvfe2gEZ+QgxIGKpfizsGkA/GLiTglxrCO8jpm9Mhlz6PRQQK5qS7rb8Mk7wm11FLruUdyu/XLz6Ve+bl5m/Lp0u3WuDr++0VfnssogMZbKEth/L9LdDbfvLBw0le/bI6AhS0vADHVWsqkFPlIpOkGZni9BUuplwtxoQEZEOUqWpB0TFoBm2gbUKhCb/s14UrrxdxJUCqvZSAVlAqBBH4ha4k1X4mzI0oy11MoRpMDGL7ZRjVlQOeaggUGLcN2tVvT79SgDEvZBdI/Vg1KJD0uWAf+ZD4E4zimn+MCgvUSiKd/mUeMImiTtCQtZCtdSKpF97h9tybZu9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o43M//Q3E05qemzg04xcarxPSMabLzzu2UyTxhGyd6o=;
 b=BU+LV8nySsKLtdIBbGjNTx7yk8hA8N85wDFivWflIBMnTbMA+43K4dQ9xpsnsHczjZDuIuHVOX8yRrRtAsVpY3Oa/ShpD4lbeCnD6QHyA9HOV8UN+i64ZLdJG1cdW8Rqe5M50LVdPqeL50jD49RhepM0LWW/YmEFXNRQPdV9XPrdt7kQH8s0cDb0ikLNZT96vphz6hp9ahouvQqfczEC/GoZ/DoYs1wLUCO7eWDMKfatX1RB+T6knpJ4R0tc2/SJR62Gyz/FYMttFDv0dolIzTeARK4rTE+RPWhKsDdt6duwQBdkvn01IktKAAbRwBgxN2feqVYJ5oRmg6t2YpCo2Q==
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 04:31:41 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::e9) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32 via Frontend
 Transport; Fri, 3 May 2024 04:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 04:31:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 21:31:25 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 May 2024 21:31:20 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Fri, 3 May 2024 07:31:03 +0300
Message-ID: <20240503043104.381938-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240503043104.381938-1-shayd@nvidia.com>
References: <20240503043104.381938-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b35903e-2cdf-4717-e8c5-08dc6b29ee0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ONkJnB4jGkjOcOZOyptoOFKepwl+ELWK2WzEKRA/8LyybxupXiEt5z+RtOr?=
 =?us-ascii?Q?wkEPOjnDoWPVl/NGcXLEpwrbyZ+qEH+yTHRhLnbUnbCbrIcTlFZtmFS8nBvS?=
 =?us-ascii?Q?dn390ggqPqtEugcC64uk37DL9ftcM2iwDAtF6Z2WzLMVuYvx/xWHqqMXDhxa?=
 =?us-ascii?Q?Qa4UQq9kFYl7KfVfvpWOLhDKJJVVc79aBC36QAObG/TP22BzRsiDSksfiZYC?=
 =?us-ascii?Q?88AdnAkcnIZO/4iBOeUkPG5Yb2NX1kY3SSDGwE+R+ngUGHUCo5NQ9UHnUxAm?=
 =?us-ascii?Q?FIvSskQbE6Sy536FlYv0HbMSZ38tOpmJBex22pi3yIxsPM73MEAVv8uFvNgw?=
 =?us-ascii?Q?8ZiGzxc3IrSSd4wNGFozL9dRq/8IFG0etohTJDzb0uP5QnlFnPhtIYUb1vTm?=
 =?us-ascii?Q?tlux2pSa4ZWVq+eDgZ3hkHfTD0e02cEXEOSpQOsATUHL+fBgMj4kfCBlyXRw?=
 =?us-ascii?Q?EbPe5DVB5v4XK88dBKnNByuWgIDMhLPbbIDMcbBKlwBuC2kyAE8DCQDEzI+6?=
 =?us-ascii?Q?LJhFHpKa6E3GSO06ObQhgQhytg+gqpSbXz5gl2M59loc4kUXcqL8KZE37Y2h?=
 =?us-ascii?Q?pv7sWE2wlzhqd5oZYB6iN7+kY0rzMfH8O/Fpw3EQr+JKazNpuqGw0gi3SG1Q?=
 =?us-ascii?Q?N2Q38Ly09PiBjfYLo9PMTbt+K2EplgzXGiSoXHwYZFU/eC60X4/cd2+jhIWa?=
 =?us-ascii?Q?BdFjegKlCO0oB9PN7uqFE7jdoqqWxCRIJFVmufAb6OXZPjQd/SOdcTe3w0FS?=
 =?us-ascii?Q?4UyJwFn/t6Rc3F7qK5pobCvYhbnYuiGDMykXK2SMXYE2wj3nuk0cfTCat+UR?=
 =?us-ascii?Q?KwWPXFlw7aL+KpDcBgndlR2bGkrkzcPOF+CQvw9AAqsBEaWJaNKemJmQMj+6?=
 =?us-ascii?Q?yfBG8Qh5tG1BpOH6QcTc81Ve9TFfrz76OIymLplcwAXgqdRoklA9BNj0F+4p?=
 =?us-ascii?Q?9tqvr25M6+OpXiHYuo/8oXKUcShuhD8kQWE/5ZGRQeM3k7DWKjg50pdmdu3a?=
 =?us-ascii?Q?9ZK3xGNtbPYW+quRwhnj0v/nyaEwa728wDFvDZaQJYp1J2A6exh7T9+bcqEw?=
 =?us-ascii?Q?uk2agGRP9XzBFPbeqWrHgmARDuAURT5gwTGywgR0Zh0UcGX7vehfJdF8tcdv?=
 =?us-ascii?Q?fQrY6jI8WQM7YtO5Nx61IFNx5C03wkkmRTwZi47S5qy9fWi0edxP8J0dSY42?=
 =?us-ascii?Q?DKiPvgr4dTpmMUMqA3C94i9Q2iAO3AZToquDeMFv86p/wvWXNEaSFJ0c6HZQ?=
 =?us-ascii?Q?8TsRPNES0MiEJs/u3/xAvDe7/wBRzu7vSes4Uv4vPjsJv5pvZ+nUMH2v/BAu?=
 =?us-ascii?Q?WF7+rzG9FVTaj0u0BehyfC0VVQjsET2lE5u60i2vguYM4tIeKfEx0SQpd3oo?=
 =?us-ascii?Q?dRmoHRRJzoNFq+7Op4ZKcYVwY+7z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:31:40.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b35903e-2cdf-4717-e8c5-08dc6b29ee0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
and virtual functions are anchored on the PCI bus;  the irq information
of each such function is visible to users via sysfs directory "msi_irqs"
containing file for each irq entry. However, for PCI SFs such information
is unavailable. Due to this users have no visibility on IRQs used by the
SFs.
Secondly, an SF is a multi function device supporting rdma, netdevice
and more. Without irq information at the bus level, the user is unable
to view or use the affinity of the SF IRQs.

Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
for supporting auxiliary devices, containing file for each irq entry.

Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
information is also not available to the users. To overcome this
limitation, each irq sysfs entry shows if irq is exclusive or shared.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58
$ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
exclusive

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 170 +++++++++++++++++-
 include/linux/auxiliary_bus.h                 |  15 +-
 3 files changed, 196 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary

diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
new file mode 100644
index 000000000000..3b8299d49d9e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
@@ -0,0 +1,14 @@
+What:		/sys/bus/auxiliary/devices/.../irqs/
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		The /sys/devices/.../irqs directory contains a variable set of
+		files, with each file is named as irq number similar to PCI PF
+		or VF's irq number located in msi_irqs directory.
+
+What:		/sys/bus/auxiliary/devices/.../irqs/<N>
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		auxiliary devices can share IRQs. This attribute indicates if
+		the irq is shared with other SFs or exclusively used by the SF.
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..5c0efa2081b8 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,167 @@
  *	};
  */
 
+#ifdef CONFIG_SYSFS
+/* Xarray of irqs to determine if irq is exclusive or shared. */
+static DEFINE_XARRAY(irqs);
+/* Protects insertions into the irtqs xarray. */
+static DEFINE_MUTEX(irqs_lock);
+
+struct auxiliary_irq_info {
+	struct device_attribute sysfs_attr;
+	int irq;
+};
+
+static struct attribute *auxiliary_irq_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group auxiliary_irqs_group = {
+	.name = "irqs",
+	.attrs = auxiliary_irq_attrs,
+};
+
+/**
+ * Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
+ * shared or exclusive.
+ */
+static ssize_t auxiliary_irq_mode_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct auxiliary_irq_info *info =
+		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
+
+	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
+		return sysfs_emit(buf, "%s\n", "shared");
+	else
+		return sysfs_emit(buf, "%s\n", "exclusive");
+}
+
+static void auxiliary_irq_destroy(int irq)
+{
+	refcount_t *ref;
+
+	xa_lock(&irqs);
+	ref = xa_load(&irqs, irq);
+	if (refcount_dec_and_test(ref)) {
+		__xa_erase(&irqs, irq);
+		kfree(ref);
+	}
+	xa_unlock(&irqs);
+}
+
+static int auxiliary_irq_create(int irq)
+{
+	refcount_t *ref;
+	int ret = 0;
+
+	mutex_lock(&irqs_lock);
+	ref = xa_load(&irqs, irq);
+	if (ref && refcount_inc_not_zero(ref))
+		goto out;
+
+	ref = kzalloc(sizeof(ref), GFP_KERNEL);
+	if (!ref) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	refcount_set(ref, 1);
+	ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
+	if (ret)
+		kfree(ref);
+
+out:
+	mutex_unlock(&irqs_lock);
+	return ret;
+}
+
+/**
+ * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: The associated Linux interrupt number.
+ *
+ * This function should be called after auxiliary device have successfully
+ * received the irq.
+ */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	struct device *dev = &auxdev->dev;
+	struct auxiliary_irq_info *info;
+	int ret;
+
+	ret = auxiliary_irq_create(irq);
+	if (ret)
+		return ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto info_err;
+	}
+
+	sysfs_attr_init(&info->sysfs_attr.attr);
+	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
+	if (!info->sysfs_attr.attr.name) {
+		ret = -ENOMEM;
+		goto name_err;
+	}
+	info->irq = irq;
+	info->sysfs_attr.attr.mode = 0444;
+	info->sysfs_attr.show = auxiliary_irq_mode_show;
+
+	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
+	if (ret)
+		goto auxdev_xa_err;
+
+	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
+				      auxiliary_irqs_group.name);
+	if (ret)
+		goto sysfs_add_err;
+
+	return 0;
+
+sysfs_add_err:
+	xa_erase(&auxdev->irqs, irq);
+auxdev_xa_err:
+	kfree(info->sysfs_attr.attr.name);
+name_err:
+	kfree(info);
+info_err:
+	auxiliary_irq_destroy(irq);
+	return ret;
+}
+EXPORT_SYMBOL(auxiliary_device_sysfs_irq_add);
+
+/**
+ * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: the IRQ to remove.
+ *
+ * This function should be called to remove an IRQ sysfs entry.
+ */
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
+	struct device *dev = &auxdev->dev;
+
+	if (WARN_ON(!info))
+		return;
+
+	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
+				     auxiliary_irqs_group.name);
+	xa_erase(&auxdev->irqs, irq);
+	kfree(info->sysfs_attr.attr.name);
+	kfree(info);
+	auxiliary_irq_destroy(irq);
+}
+EXPORT_SYMBOL(auxiliary_device_sysfs_irq_remove);
+
+#else /* CONFIG_SYSFS */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq) {return 0; }
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+#endif
+
 static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
 							    const struct auxiliary_device *auxdev)
 {
@@ -295,6 +456,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +472,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +488,11 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
 		return ret;
 	}
+	if (irqs_sysfs_enable) {
+		auxdev->groups[0] = &auxiliary_irqs_group;
+		xa_init(&auxdev->irqs);
+		dev->groups = auxdev->groups;
+	}
 
 	ret = device_add(dev);
 	if (ret)
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..c95c46bacfc7 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,6 +58,9 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
+ * @irqs: irqs xarray contains irq indices which are used by the device,
+ * @groups: first group is for irqs sysfs directory; it is a NULL terminated
+ *          array,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -138,6 +141,8 @@
 struct auxiliary_device {
 	struct device dev;
 	const char *name;
+	struct xarray irqs;
+	const struct attribute_group *groups[2];
 	u32 id;
 };
 
@@ -209,8 +214,14 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
 }
 
 int auxiliary_device_init(struct auxiliary_device *auxdev);
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
-#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable);
+#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
+#define auxiliary_device_add_with_irqs(auxdev) \
+	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
+
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq);
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-- 
2.38.1


