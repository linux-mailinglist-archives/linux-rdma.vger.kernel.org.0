Return-Path: <linux-rdma+bounces-2335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20B8BF522
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 06:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974D11F262B3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 04:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034F14AB0;
	Wed,  8 May 2024 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWtQfFq0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA61640B;
	Wed,  8 May 2024 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141137; cv=fail; b=Smcopu1Cs4mn7yuZ07RI3mOzMOOdTdkTRpFRLJBFRCWHnleCC1BE9podR8pC2GuHJBFDhYols4sxcuAVvU5d+clHLPRYyPSbzIcWfwtwff1+RxHZKkv5aehfaVcjqRd0LV5TLvbTXnx4kNWLxUMqFrjenIFSPCXW//NbLKdSbnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141137; c=relaxed/simple;
	bh=f9YAetu7nf+KuavN2cUSHcGefTDUYNygebaNTttCfUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpGk+Sni0ynls0/eyXm06TYljEulGmso0uSZ1eey5eZBpe7/WNXdJj30cf/1MDPYdsGCC35OGnQV9RAMwBi0QMgaLVPiHCmNH7R0ceU5q5+nObc5yE8ntjj325a04eLMuN3SLn362SC47zNekS5C7iacgZVfDsyZIq9hfOW5L5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YWtQfFq0; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLwNXocGFyAGpr6GrLAWlNDWZnc2G78IQocJjqMFDoOfZQMXJhWnqeHWtLxKtkRSfywRHHWsTjWZOxGmubBnd4RkEmA3l71jcf5fwIfAivIQvEnEVo64r4EMyXIY/0z9FXYLV2hKSmWhursSvU9iFlQirQj1fA2xBJ7zozCBBeXDJHBTqL4iYbngXqoLy5fYyN0aQw04OmYgjxPstmk+qo/KHzoD6epGhlP4t+hJgs9zW9gJ6rpHZdkRGCfI80wP2aYj2RFs4jUJn2QbDg8zLVsFYj7zer8utpGlcpJuDTxLUaYLlsRsdD2cfHz2r76Ol8sQEYW9EZ2dMO6p2zeKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahz00TAC11CVoKkjUQ+uWzJ7+qyE8ZNQuFnxT0xXudg=;
 b=XvDyOeRRUnhdR1UADH+xhuLzv5NoEP6h6eEturImRu9PVi06+kWULA8pwN59CNaYsUjS65KV/dZux7SFp+73elOSk3BaFUivGaMGyssDkkmzH0zJtar9o8qQWk+VTXkSFyvTZ6g9SLp2xg3eNW2zs01kJ56HWo8TFFxwawJodnBSrMyJ+W0u3aXh6tHrcJFpRofWNYhE38M+uYFPLZfQpi4D+ueZpMXKzETMxU6z5SN015bdNCLGhraWnyvHYTzl4DseiOJ1/7W6LS2lS6PNein5SQWHVojmwnFi9cGyW1e6Xij4+tv9DVsaEqt4C6weDSaa8Hm1I+I0juXjUx9OpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahz00TAC11CVoKkjUQ+uWzJ7+qyE8ZNQuFnxT0xXudg=;
 b=YWtQfFq0TjsxYOQBGMZt+wjft0JDBEtHCV81ny62Z2SvxI3vsIMLo2VtekLNC0l//mJ7J71VgGFdOogWCWPl9jLY4loS0IuehAligToHVaPn4B5WW7R4GCSu1Zx7Jh6YGKWX1eu+N4DoMyv1NnLmtX/713Oz9wpZ3ruYmKVKg7F4mxL95LDNoBJo7eIRTvKXRLdP5LezYQ99elhgLTcNMJ1f4Va3QWze3Gw5gczruA4u3NixUetC+QhsHeIRTTJ3sO6fs7iu82hRj7zT4/x8Ei2G3ki3PZVvgcJJJ0oCnIvbu9Etl+8tcCqRrhxZRvTqRMXxpNbIw+ulF+vduZ8SxQ==
Received: from MN2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:d4::15)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 04:05:29 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::6a) by MN2PR04CA0002.outlook.office365.com
 (2603:10b6:208:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 04:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 04:05:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 21:05:13 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 21:05:09 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v3 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Wed, 8 May 2024 07:04:52 +0300
Message-ID: <20240508040453.602230-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240508040453.602230-1-shayd@nvidia.com>
References: <20240508040453.602230-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: a85f9825-de5f-4e53-8c90-08dc6f14194c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4U6nKDcx1clkr5RWQUxfKwRV3DcBtf0l3TtFXjEMyZzfng3RIEbmciffFbm?=
 =?us-ascii?Q?KWpziQsIIXT2YoYzQRtQYijMAr1XbEl0+OFFmZhaNL9oH6RBs0kCUAtHEEU9?=
 =?us-ascii?Q?B6q2mQV6pJnk4fICg7sZDJK87gDfwicsXNNfy/13oZ2pbrks1j4ThQkbL5uU?=
 =?us-ascii?Q?b1R9cRdu4bEx8wt5TqxVZKs6/RU0UEVGCvUyDElC60jL9LPv9Qr/OV9ibBcY?=
 =?us-ascii?Q?tFjzPmtGVsTL8J2fUpND98nfFf6FUQZVFwruFGsSWcVp4W/kfIfmysitUexo?=
 =?us-ascii?Q?MGUPhffc1p0e2Rw5SYv9rqFNSqZdybUjIVrRF9VSiap53G82EDICw5xgnWVu?=
 =?us-ascii?Q?Y+Dn8NApAARgV5EWa32xyOQxd9p04hJlCmaUL8J1UGwFIxlSAMfsTiM14bKx?=
 =?us-ascii?Q?agWf5qsK3f8MnGoSnsbvD3H10OVYrWa0NIz2g0CYqhuHR0SGphsw+BjJPh17?=
 =?us-ascii?Q?BxEkLGTLCoC2iw7veq5J65TPkEBKb+Ykh9f/6b1QN1fT0mEYhRmw3jSQHwIO?=
 =?us-ascii?Q?wMn/3ZM5E2mmoX4YUwi6r8suTp1Yf5Jd0hdhcpcbuML+NuEBH7LlyresOB/N?=
 =?us-ascii?Q?HRicNZrHqEnzQogw9MSwuUbrqsmjNWAbrggQcGMrCo5bVHcWjCCElm1W1IzU?=
 =?us-ascii?Q?+iCPo01P5Yp0FvL3vjK5V9l+UDfmVhord8viHcVwJpGULWMELDJehdklFR3X?=
 =?us-ascii?Q?lXe93V/mQLbzsadWI7Zoy0Sgu9ENwNpham961OK6BXLtlq8W3Ae9TQeWlqir?=
 =?us-ascii?Q?U7EHmrxXK3kyX+vCxBpvyPSf8froNiSPHD6bsLaueCHjAHMfEr5oHjx7C6dC?=
 =?us-ascii?Q?suQ+so9wY0u/r6cFmzWuXRGDpzM3gKX1k0t6TYWZn/jB1SPFxaiXmxyK4y1/?=
 =?us-ascii?Q?4BNfpd0G9nC29QazqrJCvwSctx5+uWwBeDIpu2onBjycA2r31ywJ0+wFB13F?=
 =?us-ascii?Q?zn3XQng/jJszQtlnTJfDC2+K2rDbnL0bWHa81psrfxAI1lUYcx3ApAv9TrML?=
 =?us-ascii?Q?oac0xMoaqTiBMlp93RiY5bTlQ0S4NS1tQTWi9VNljvJk2eKqC0eA1fLctLCd?=
 =?us-ascii?Q?gP5Ox91s4Kv5onki/UAkB7kTtkZPnoenzlRtCKYY7KdPy9qtfdiDEG1sf7yq?=
 =?us-ascii?Q?AyIHoVCp+hcGW13qiUsFU2mnFVaw9rt0D4aHi/halt1qTeIfEDZLd3pDGT5C?=
 =?us-ascii?Q?KQttAy0CtbGzaWYw1h6myKa+vAoAB7jkExsjr+O6BtkhpatGMkPXjWjTozav?=
 =?us-ascii?Q?mtZq0cqbQ3aCmoxeQnrjdqEAQXo9gzQTtQwGPM9n1R2qCbwPToXuB09syB6W?=
 =?us-ascii?Q?kCBXy7rCkXf1tjyiCk/esfD5v1A9JuuA308HmaHDNieS7KeGbpoB/1DXrjq7?=
 =?us-ascii?Q?vLd8mlL61Cnqh9wEr3WOyTT2Aqs0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:05:29.2212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85f9825-de5f-4e53-8c90-08dc6f14194c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137

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
 drivers/base/auxiliary.c                      | 171 +++++++++++++++++-
 include/linux/auxiliary_bus.h                 |  24 ++-
 3 files changed, 206 insertions(+), 3 deletions(-)
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
index d3a2c40c2f12..6293c6707e1e 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,169 @@
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
+	refcount_t *ref;
+	int ret = 0;
+
+	mutex_lock(&irqs_lock);
+	ref = xa_load(&irqs, irq);
+	if (ref && refcount_inc_not_zero(ref))
+		goto out;
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
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
@@ -295,6 +458,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +474,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +490,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
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


