Return-Path: <linux-rdma+bounces-3122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF642907829
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD6C1C2376E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C561494AB;
	Thu, 13 Jun 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jsUYa83p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFD145FFA;
	Thu, 13 Jun 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295651; cv=fail; b=ercqcAhLMBvZIeCS6GlUWDlYWfE2vVirvcW3JKFyvmkunAo/BHRI0YgHAx+xAVtbs/kcb7z+Uz+JPiObT05SvTWjRErZEPTog9ZfzN8fvDx39hLNMTAY3xSxNHuttAe3m1ldxUUQS9SFIkE1EA8wG0UWWkTy1fIjzxmxGcF2KeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295651; c=relaxed/simple;
	bh=vunm7dTNqU+5RweOiadIS9i/qyF52gHsEGJAFIPwxQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLTi29/+aM2o0MZhF8dZ82zVGyK69rG0gkzv6fhjkzQTTdG+/1Tpqh/tty1u+BR0KeTX2TGr7rj2+U1zRq+pJIJP79ZwjcGjlIsEZJOi3gZiuAh8+zjzREP1hz9A0GybQlks4/2XAfD8vSpk40uUy52zT8q/GcmNLHl8XnP7JvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jsUYa83p; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBkuJ/4YZqJl0xzZ9MC4Zv55bSCgYhW9Syxwjj3G9wU4iwK/SxuTPWyAfin3DCR5g8rmgvf+jrpRterTmggv4p2qFi/fgwJtN7m/KuDmeUsrQgw0Xcmdw03dNsH+lqodEkJ1ZQzsLBT0uyFKXP2j6RaosQNWShLIcFvIFqc7tRFiAexcFwbJ8C0ZH/P6ZbTGvqlZM3Z+4QjNCbZf/k7LQpqH2NLreQOPQkdPuJ91MNKco5IHDSJTatuSWGpq1+MhxxxvN/bvOa86XFA1GfYzwr2vzRhOsv0xEBMINv2vFWTLtDxYDXJvu5PegI7krl8bMxNkQ46rhouZvv1eLSfSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtTXyjERU28Wk/GcorWoIQ5GPwcw1c1SAZkK149ebSM=;
 b=T9I4V7NzFdAEi5itK8T4ZujnU/jYtX7oL+GuheQV7aP9RRPBqh/WcyCNW2WMmenAVxjYMoWLwyIAb6gzvnwCBezpkycIA76rOVPGs3Ln6eT/Xe4h9uanq0ct4XeD8woxkbLGdskMtgXmrAYdAEuLo2I9HzVS8h5JYGd9q4GbxJZpXXZxUcmXu083cVlhZYygsDris1SfnCoh+MQtqHiOtaQQMWN3u723625FFxVBxHvMto3+Kmy1ylyziCacVqrlaUF79fy8yiJaVIrdbh9Xq9duKZHNP6/xMsgplFPNAoWTSN9/9SEpP1AWaJBrbo3q6wObfLkJW+lBNk06EbmtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtTXyjERU28Wk/GcorWoIQ5GPwcw1c1SAZkK149ebSM=;
 b=jsUYa83pj4Kr6Zf04SqFM7Cur5oYU2S4XpCA2VB2HYsysR+1rEenpwsuJkEBiJW+x9utL2CXgcR+UaoJH3Feo7AUZgB/ZNlmwFvhJ7r76SDrzukn5KEQ9LsekH8PjGadfk5fEbAIcBxJ6ShihbPhCRN55pFltGpee0HlA3ajKpd2R+k+QpN8qA49o/2Ky0H/9kPr2tapog5N2f1Wr41BNREEiBfhUax3wH6Lcw0yXBHVRakS9imaOsuSi9djHLaLcfEQzuT7gadaD1TAOIKQoRaMTi/zbQlLoL3g5u3ibXOSXcfOHJWj3DwgrKCHxLuizIkBN2yH6RFu7msi2voiaQ==
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 16:20:46 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::65) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 16:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 16:20:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 09:20:25 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 09:20:21 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v6 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Thu, 13 Jun 2024 19:19:11 +0300
Message-ID: <20240613161912.300785-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240613161912.300785-1-shayd@nvidia.com>
References: <20240613161912.300785-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: a100fbca-40ae-4d14-acc3-08dc8bc4c721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|82310400021|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ahp3bpXQYwAXEvNIZP5SwuwECC8F14UIhT7cjF0lBOseNXHUHcLizVJ+f5Lv?=
 =?us-ascii?Q?kdRhri9YEaw75HP9jbBMvI1bTGxlL7uo7HRje8YK+E9Xtrse1uEbRsk3E11G?=
 =?us-ascii?Q?9YSMv7Sbv9RnGhe4ZFehWHTbe3Ylc069/vx7WC/OvRBdwiuRhSdoTrbHYwIc?=
 =?us-ascii?Q?4NrucWWtnWg3TssM27mkPvQ9YZKaPONQEkhRf0SQqbp2QlVTswNoGUHAQI9U?=
 =?us-ascii?Q?Bh08eC5bDyisZmH2ZNQ5zetIuE8oexnvLxchG0y7W+Q8ou5iLbHuoTLkLXq6?=
 =?us-ascii?Q?X0Apkud9RYF68ZkEq7y6BV122BTO6qLNVgthn/XHbMUniDHLQlViRVcAfNyP?=
 =?us-ascii?Q?6Ab/5psO4an1vaNEgQftIVWslM3oOGIpAn+YMK5Uyqf/FZUqNSZhzP96rgNK?=
 =?us-ascii?Q?fcIqxe+kHmvdeSRwC/D9SMlOeoJQTw87uiyPi8kdDmzLjCdEdV0fzMpuj8wa?=
 =?us-ascii?Q?/OG92krxP0rugDqf5jTjoXUxlYvH7LufIJ5kVbRdbMk7SCuLnOiZCF1qZJ/E?=
 =?us-ascii?Q?6nE1m29RghH/lAdGuorCurjUvFliZNI2HMMGQWfWYKbyosZD0pCyJIgF8c2Z?=
 =?us-ascii?Q?uV6QnNcYLOe3TutJd5MpMg7aCwrRbRMhBxQS/o8bSSfNCmkEgm8ZYlGdehm1?=
 =?us-ascii?Q?64eTbdWnuhYB8fJLcL82Uf6a0y3ezwVwoMuUIM9p/9aI3pMpo/AM7aYovIuv?=
 =?us-ascii?Q?kMfUEWfNJRGqKnPV/hExQ5mTuQoDXvae4P5v9A9eS0AwKFwrNCwY2drrM0xU?=
 =?us-ascii?Q?xbTA4mZAr1TJbMwaZMAdr77StdJiqhRsPZdLe8IXw0roVTzztBbtqLWIOOt8?=
 =?us-ascii?Q?TeIvyqa11v1WcCfq+3BuLkBT9TgwtZv3Yx8NC8H8hloTeZ4QSG1byQ3zGpvF?=
 =?us-ascii?Q?6D2g0LlD7JSPjpwI1BPQFReYHPZdyD3xBafZd2YVgDGh15m3x8NXlN7EMF1k?=
 =?us-ascii?Q?17Xg+sYdpq/JNocZf8Zil67BaYfnKQgKaOUw8cDNTwou9HJ4D7PG7u1x045J?=
 =?us-ascii?Q?98lUg9kZzybAYa1uRA5ExIIMlNpKVJz4r9Bz+KIlb2h9dUukLl4MIWwsargQ?=
 =?us-ascii?Q?gK5Cr1h1kNwBXxOcEdNG/njrNtfK/MJfjkGDYg6O3/HYBGTBLUcpmFu9GuL8?=
 =?us-ascii?Q?ujC54HHtglH8FAj3FNhQpUi65PN2AOwjxU1f4uLkgCrNoLkHRveLdUSw0TKI?=
 =?us-ascii?Q?bYNv7nhrlWLW44gIBk38Wc3NoCeuLV5JyCDXvoB84xwIUjUdpINPbxtJ1Cm+?=
 =?us-ascii?Q?52szO4Avp9P61v4LzUPIekz4V27WOYnt2TpgR34mWbUi2zevpcMrjsHFy8AQ?=
 =?us-ascii?Q?fgt/1CwpMqfHHSAb76Zel76Tk7s/f1YnVH7b2ATTwsr+YAycmOVMSKewIhUa?=
 =?us-ascii?Q?8BUf3/Cgwwm31p1BQBnpuSTZJCOi1MMgTwE+Q6wFGlyIc+RQGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(82310400021)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:20:44.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a100fbca-40ae-4d14-acc3-08dc8bc4c721
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
and virtual functions are anchored on the PCI bus. The irq information
of each such function is visible to users via sysfs directory "msi_irqs"
containing files for each irq entry. However, for PCI SFs such
information is unavailable. Due to this users have no visibility on IRQs
used by the SFs.
Secondly, an SF can be multi function device supporting rdma, netdevice
and more. Without irq information at the bus level, the user is unable
to view or use the affinity of the SF IRQs.

Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
for supporting auxiliary devices, containing file for each irq entry.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v5-v6:
- removed concept of shared and exclusive and hence global xarray (Greg)
v4-v5:
- restore global mutex and replace refcount_t with simple integer (Greg)
v3->4:
- remove global mutex (Przemek)
v2->v3:
- fix function declaration in case SYSFS isn't defined
v1->v2:
- move #ifdefs from drivers/base/auxiliary.c to
  include/linux/auxiliary_bus.h (Greg)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
- Fix kzalloc(ref) to kzalloc(*ref) (Simon)
- Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
- Fix auxiliary_irq_mode_show doc (kernel test boot)
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
 drivers/base/auxiliary.c                      | 96 ++++++++++++++++++-
 include/linux/auxiliary_bus.h                 | 24 ++++-
 3 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary

diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
new file mode 100644
index 000000000000..e8752c2354bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
@@ -0,0 +1,7 @@
+What:		/sys/bus/auxiliary/devices/.../irqs/
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		The /sys/devices/.../irqs directory contains a variable set of
+		files, with each file is named as irq number similar to PCI PF
+		or VF's irq number located in msi_irqs directory.
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..fcd7dbf20f88 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,94 @@
  *	};
  */
 
+#ifdef CONFIG_SYSFS
+struct auxiliary_irq_info {
+	struct device_attribute sysfs_attr;
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
+static const struct attribute_group *auxiliary_irqs_groups[] = {
+	&auxiliary_irqs_group,
+	NULL
+};
+
+/**
+ * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: The associated interrupt number.
+ *
+ * This function should be called after auxiliary device have successfully
+ * received the irq.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	struct device *dev = &auxdev->dev;
+	struct auxiliary_irq_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	sysfs_attr_init(&info->sysfs_attr.attr);
+	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
+	if (!info->sysfs_attr.attr.name) {
+		ret = -ENOMEM;
+		goto name_err;
+	}
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
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
+	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
+				     auxiliary_irqs_group.name);
+	xa_erase(&auxdev->irqs, irq);
+	kfree(info->sysfs_attr.attr.name);
+	kfree(info);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
+#endif
+
 static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
 							    const struct auxiliary_device *auxdev)
 {
@@ -295,6 +383,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +399,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +415,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
 		return ret;
 	}
+	if (irqs_sysfs_enable) {
+		dev->groups = auxiliary_irqs_groups;
+		xa_init(&auxdev->irqs);
+	}
 
 	ret = device_add(dev);
 	if (ret)
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..760fadb26620 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,6 +58,7 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
+ * @irqs: irqs xarray contains irq indices which are used by the device,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -138,6 +139,7 @@
 struct auxiliary_device {
 	struct device dev;
 	const char *name;
+	struct xarray irqs;
 	u32 id;
 };
 
@@ -209,8 +211,26 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
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
+#ifdef CONFIG_SYSFS
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
+				       int irq);
+#else /* CONFIG_SYSFS */
+static inline int
+auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	return 0;
+}
+
+static inline void
+auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+#endif
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-- 
2.38.1


