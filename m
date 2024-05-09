Return-Path: <linux-rdma+bounces-2367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D543E8C0D51
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB22281EFA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370B149E09;
	Thu,  9 May 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afYiV43t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5D149C7C;
	Thu,  9 May 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246095; cv=fail; b=fUr6g/uD3ahE71MXTQZ1i9kZOYPC2BVUkfBOedz4qLoXe/KL0YGfmDhgnAYWyTxQwEasnVpXeCGF0Haikyd/s7tfK0YM9MJzNLGp1IoUAaoaIffab7U5mYGvkZDZkeH33ErFv0KMkrSgjcJvRACeg0SyHf2XrgOi78PSJIVh+io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246095; c=relaxed/simple;
	bh=4kM+T1W0NvlE6cZfzph/Sl/FSmwKu7AHJUq4gHLFn0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TctrU2wiFtMYPpB2zbf/h4ELIT40ykeBvSEn05mZ0x4cEi4N/yjW/fWFTg3eMrhrbvkw+m6O+g6hlSP2YMa6WgHpgb4MvK20wQkVB2E2nTecJyv2Y9rUB9t8kjAz20+TiTT5gxAnJxggs+KZ63ps9wDzFV/UWGkBLaWIPaIUMM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=afYiV43t; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP0Xgb873Zlvu1ZVTObpnn0D0bCJRHzidKehydUAX4GoA5eDWrBAblpcQ3WPiHFRaksWZPZw88LVmIPC2FXNf8/Y3tL7McWfhENJY/0MFZx+n5rEbISWaJVtOg7xazdbJL5JgO9XvBe4gTjMPg6ESWvFo5LgRTcGzN1Q/xZ6qqcKKSumQ0dJTtsMJRShtshHIFh1HvsO8t4wZ7BtRaHOxlIFuq4m3ecgcvZQ4Kf4PCn4bzgWpiQqTjtIcAHdF7HCJaC/d4Gkn96men+TzNfux9EYMEWdyJuVvDlP7b8Z75WVWDBQ+vnHxjVnIoDdT3fW+j0sd1g3c2tZ37+uhMRyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1VjFCe2p+VFVD1Sc4nFZhfj7H1/X2DpLxisGjil7Rg=;
 b=EKVKYjfCW22XL7r2QksM532ptFqHvSXzznnx76VUSZbkK3etlzEB3RajU6ANx935mpi188mQlM6ypK9fq9/MvX0UNbk3Loa3S8lIjfv2MtRvP/OpjdvQSpEml15f2pfpYdMDTuabTkOkemtWI9BxvKxNYmjEhYznRy0fi+frq/Tti4hQhu3IS/TWmNmNXBq8E9EFcCB6dLJvZB4BMzVvk8y8bxJVZPw0hJWt6HvYzD+ssLSFrV3HcWPMeAZBTd+i1XhE6alfY1L6iKpgJDcAvdmH/snPng78mcHoQXIjkf8c5vAM1WkVSvxPzhWgmX6IDh1jmW8JYlMMZf/e5DCH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1VjFCe2p+VFVD1Sc4nFZhfj7H1/X2DpLxisGjil7Rg=;
 b=afYiV43tCCjBg8wJEAQvwvKVT8yGqOCTFuTcdsit3SShTNcHCV4njA2XMtiTxYUlxFuYcmIuIvWwgkLP/Kxt2QtfSxIqqNhfo3jnA8pz1/NxQmwwNQliq4DrrtK1YGVQaMK8pv9c1fUv3xhD+redRo0svFNe9brHQLaFeCJEaI9e/yKAp2ny6WaDz1uY0T0OP5OqfSMW67pcpZQaUe8cAU58hRrz4NIfKkFhn22h7R+2tbH6jI02DtKgydIQCCR+eRRn6Wn1OW+8ysYYikk9JXEF9yLDwHwT1Z8TYVrAnkKaR35/sBt7WuHDH6cd3DrS+xjy2mnq9Bpdx2/LfTooHw==
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:14:50 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::36) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Thu, 9 May 2024 09:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:14:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:14:38 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 02:14:33 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v4 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Thu, 9 May 2024 12:14:10 +0300
Message-ID: <20240509091411.627775-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240509091411.627775-1-shayd@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 997cc52f-ca88-4f6f-2eae-08dc70087ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PpBsxqGfRzyLCjkHBU4rRjl1jTGRu5aSxy2Oo57QG1A51Rw3Db0PbyHStA+i?=
 =?us-ascii?Q?jsR+TaUSEMPqY8Lcn80DivU1bIDCDUX8sdDjHfKpWjTrniO5wO8yMXR8JS8F?=
 =?us-ascii?Q?pyePooYbNvKufe5tBR9pe2rlim+uWTwn2vyWzIor787xZuzk2YXLBh6YOQeK?=
 =?us-ascii?Q?NvKLAH0HLNanSOOMfRbwfJKY0xp+Yged5pObLCHA4DZ55RMjkLxFDaWHhoH2?=
 =?us-ascii?Q?KKhwI2/r8TTLwP+xXUKXluAjNTIbko4Ne8HfRL2FFAtkPRNn75tRErDsOQE7?=
 =?us-ascii?Q?DCYdryGu7zi0tu+YAkVtR/5x8sHJY+E64BtzHsDS1qEQJ1NOHOYfLB0aDERl?=
 =?us-ascii?Q?NjKhHPnktHdmH5q2ZSqT4cUvX5vAGZDTo8/dysyt51/Ni6Kom3n2WNhONAOU?=
 =?us-ascii?Q?U2+KQuOuakN8iPBqHa++MqQHH+ngP0qDhklJTNH6rBKxQSBkS+RKLeB3O2h+?=
 =?us-ascii?Q?9efXadoAG42lGFA2jELqROCChPmSaV3Mpe0S9VXbsejWbJxu/22TS53vNrMq?=
 =?us-ascii?Q?qTUH68tCkJM6ueiS+t31XLMw+QPT5oRMkeip92HjMd+Xw6rC0q5E6AyghKxH?=
 =?us-ascii?Q?rkERFsw9FJfYXO20+2q5RVdYwv1OUEhx2Cbj4yU5kNwl2YBZFSDqPCsMri/G?=
 =?us-ascii?Q?DFiCNl4ueKSsnDieLwPlO0eWYv06vuWI9+04QVABT4ZhKbMpbC7kPnzUT8CH?=
 =?us-ascii?Q?GMBsMz1OAZIrKVhZM0vkK+4PDJ4CmunmyorrCQikuYtoT7GlYkClP9L9SNGd?=
 =?us-ascii?Q?k8EyeNvgJQNAaTFST98VjYAL8YyXrpyiI2ECRMVJGFZRrp9tEZnLc8ukCJCX?=
 =?us-ascii?Q?z3LsFBxTq73xKhvBK8RdCKsbz/q1+48NxU23Ziz86FOClwojuFOFQ0HaWhZb?=
 =?us-ascii?Q?D7VzSGktBvDhJ3fp3/f09kjOQ6Ah/0TxiWH9ANxUFvGvsv+DMEokmVsuSYGh?=
 =?us-ascii?Q?3wQe3H7Gi758L726XDjE8XzEvVfspIu62FHVuawqVf5ncH4oD28xU0kgZEmQ?=
 =?us-ascii?Q?rs6YTBMcyn9POpZTFrtjdVzD/JP7IxO0761lYHWV+jRqv+rdnhPTnb0QbYss?=
 =?us-ascii?Q?338LZv0ai7GArL4pQqSeaJipcicRRp7u+8qhDfCv6+4tLtcxRELKQU3LbyA3?=
 =?us-ascii?Q?pZ7Chn6bdpNIXMbTbL1DI41tQ88E+pEZ3zhc9jrA2uH7EgTEF5e2NrlemqNm?=
 =?us-ascii?Q?cTiYkkfjOW0VVa9t3ELarzTiutpTSys5AEGAsjNvbQwvzUd9uivXexeCLFZ0?=
 =?us-ascii?Q?iJCKgPloyP63xY8ofoQWZ9PoML46UIE0jeBfFSz+vvFr55Yj4+Ja9cS5HlVf?=
 =?us-ascii?Q?ylXEZxWKzCRPOT/HcdflGfNfnTmFTQ9pMeowYcy1sshI14v6Wn+HjtqVMi7z?=
 =?us-ascii?Q?9/0e7l3wZdrmptIOe1IIzBU2Cmt+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:14:50.1898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997cc52f-ca88-4f6f-2eae-08dc70087ae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

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
v3->4:
- remove global mutex (Przemek)
v2->v3:
- fix function declaration in case SYSFS isn't defined (Parav)
- convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
v1->v2:
- move #ifdefs from drivers/base/auxiliary.c to
  include/linux/auxiliary_bus.h (Greg)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
- Fix kzalloc(ref) to kzalloc(*ref) (Simon)
- Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
- Fix auxiliary_irq_mode_show doc (kernel test boot)
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 178 +++++++++++++++++-
 include/linux/auxiliary_bus.h                 |  24 ++-
 3 files changed, 213 insertions(+), 3 deletions(-)
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
index d3a2c40c2f12..def02f5f1220 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,176 @@
  *	};
  */
 
+#ifdef CONFIG_SYSFS
+/* Xarray of irqs to determine if irq is exclusive or shared. */
+static DEFINE_XARRAY(irqs);
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
+static const struct attribute_group *auxiliary_irqs_groups[2] = {
+	&auxiliary_irqs_group,
+	NULL
+};
+
+/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
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
+	refcount_t *new_ref = kzalloc(sizeof(*new_ref), GFP_KERNEL);
+	refcount_t *ref;
+	int ret = 0;
+
+	if (!new_ref)
+		return -ENOMEM;
+
+	xa_lock(&irqs);
+	ref = xa_load(&irqs, irq);
+	if (ref) {
+		kfree(new_ref);
+		refcount_inc(ref);
+		goto out;
+	}
+
+	refcount_set(new_ref, 1);
+	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
+	if (ref) {
+		kfree(new_ref);
+		if (xa_is_err(ref)) {
+			ret = xa_err(ref);
+			goto out;
+		}
+
+		/* Another thread beat us to creating the enrtry. */
+		refcount_inc(ref);
+	}
+
+out:
+	xa_unlock(&irqs);
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
+ *
+ * Return: zero on success or an error code on failure.
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
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
+#endif
+
 static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
 							    const struct auxiliary_device *auxdev)
 {
@@ -295,6 +465,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +481,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +497,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
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


