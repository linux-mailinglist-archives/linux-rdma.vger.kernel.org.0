Return-Path: <linux-rdma+bounces-2279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6A8BC189
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F21F214A1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2C2D054;
	Sun,  5 May 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FE8oSdrU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77F2D051;
	Sun,  5 May 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920829; cv=fail; b=DEhp2g2TRd5NLX9isX0grZYn/tw+dbKEwi3VOrRgE0Xab4b+0aNLUOhs7t7JJOXEOL2utTFuwtdYblFD3Bs7LkugsIST+TSMe2johtS53m/BToaPxphholWnd1PJJperQ0yH2nMHpAGcqqruxxAvP45G6XuzpsUhN3Wnapp3bho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920829; c=relaxed/simple;
	bh=RK1qF7cdpJD8UwxAw5FJ1MfQF4i2T7DRZDze7HIEJyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAJ1BmLKPUUGCnrrH4ulc2HLht1CLkcdmAXYApUjG/0IZFKb50py+5S/V6k23Sc9TpAe/AV0/EaIYMN1pfZTpk+yDWfd0/EtV1waxM3fZeEUEdUJ/DzKKIHsMWNQbPoHIbe7MXvRXHbgSdNe6JfCNnRrihcwB47bLHvb4TfIcwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FE8oSdrU; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmk7N6Xxj4so7p9DLdrc2W5Mt9pbERO3sXEhoepk1APFC1037F21NDE3szkqDK1jSlIsv0ee92Dl34DT/WapZEhM88qsCZMaMWrmLSFhjju+XKGo5PslHb/4NndruaBP2nnIWUFIXNmHj1D2/AupRaGIP7zywaBeNWold200dK7gUE1o/FwcUf4bXsYYfApPtMriyVOffDkq2odsbHunEIl8YQ5KXe2th0Tdad1X3cf5mCD34r+UMObjDRsIxim3aTpLUiuW9/akZZxcpV8JvJUAOVijdL9gKI9/hmjnvkCbgrYnSk3dTN/NjbKsU6j/KrYXcKHbY392Zu/EGHCf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khCh2ZimHPrRWyymsHyyonF9grNFsWQ9xTiB+frEWjw=;
 b=ZgkSXGvV1ltpDN5a8yXq4RePIwVtMLYZAgyfOJcmPCARmDUBHY8K4RyxAy+z71kkfS9GncW26luEovfm8GONNAB6GS0OCnumzvlxLXpGQ9cTh0uTb4+v4A3W5iL3ignWtFVJM5g1yGrP8OWmh7i64Y/hb2b8gfKEv0tCujp+l/eBHP+7trgQ9DsWyZmR6x0MD0+5qCjHflsJJi5KtaC6g9EtVR1sLQJjNEDI5DIE8PC6hzyYIVtGZFlSFDGcgr7Ae6etCbJvVdZ1Zx+7350lBQB/KildrV4bCiNMHo0MnQeR6IKxpOru244HKopcZab8yRHvLdDGxI8nRPtCp7BT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khCh2ZimHPrRWyymsHyyonF9grNFsWQ9xTiB+frEWjw=;
 b=FE8oSdrUABTXwLkA453L5FwGbJX+upnJAPJP5mT+jnRR0vTmCn06w8wQwc27I93iSQioZtLmDaYbkBLNbV6NHtPECjFr+pCfBAk0dv2+w45kegV4XARypeuJH7OacqGEwWHfDtmnbOb4AWZJsXwWTtcl9sIAkAI3n89Tjn60HOsGtT8oWmwt1rSX63mukz/aj2Xl+rNameQYKZPwCZ1VNfJPX7szfmiqDHKPV+v7HjBDc6k+eIqmh18yafCWVHmtOmXV4p0vkECxNn8ML45fFiTiohinxASvRvlrUwYdCaKuoTdhQr7yWqokL4gSUJH2Ijy1HG7G8cnutlF1jArJ7g==
Received: from PH0PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:e::14)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 14:53:40 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::bc) by PH0PR07CA0039.outlook.office365.com
 (2603:10b6:510:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.37 via Frontend
 Transport; Sun, 5 May 2024 14:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Sun, 5 May 2024 14:53:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 May 2024
 07:53:37 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 07:53:32 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v2 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Sun, 5 May 2024 17:53:17 +0300
Message-ID: <20240505145318.398135-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240505145318.398135-1-shayd@nvidia.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 097d6e28-72f5-49c4-2d1b-08dc6d132702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wO+kTINHAvlqnEEILMZyxVH7T30o7AEBcg4i66o8Wk/k8zNEkaSEuJHiOjJ?=
 =?us-ascii?Q?et8yX6sd2r/2xUsIwhowzYz1y8qOV33hSvJE649qobq6/Z5J+l2+IFaUjKtZ?=
 =?us-ascii?Q?7ybjDloJdRP/ghSaaXcBLKyitZ9CPKDbFfPrmtv1K18ir+bSUIieBcSwIRnt?=
 =?us-ascii?Q?BUqu6o7KtGF8vZMswefMJAlkBmZ38gTxTp4M2pzlbQ05DkIz37JotcnoV/6+?=
 =?us-ascii?Q?XJtTkGaDHhpORVbGIIfF0GhwrZOPbSCOXNFN+Epe3Zo31RrrPt9JNc11bFce?=
 =?us-ascii?Q?1BYK8PmdQyv2lhVmZtcOm6g6c/AI3mdaYhbLg+BOSDdQlMgVgnlRpF5S3IYZ?=
 =?us-ascii?Q?MEfTHde0ugyfy/bSIzcPWKMTXuoqFUIC0xdgyaT1hiQcVzzxdNtPnSCcnWZx?=
 =?us-ascii?Q?EXtMNkCdO9t7Bl+u3/lD2s8UQFuMom9tGN7748go3vfmoZioiRObZ1EeAMJr?=
 =?us-ascii?Q?Kgq4Z55DtEUWo/2u/iiOzl4jmoiU5Debe17R1IbTouTmWGPawtl0EI0hlfp8?=
 =?us-ascii?Q?fQ2AdCZb38KtAQgbBNobW8U6GgnGhxuMdOYQTinHalRNSO8H25L3Ky7E/FSG?=
 =?us-ascii?Q?LktIt994teeMaAAbUg887f0eP/1PEB4dsFUup/fuVLvoLcs4fXc3iV7m8WM7?=
 =?us-ascii?Q?PhKDfO+7xmYPhBD3zTtEVuht9ZyjQHdIjzs0cEHHuuJo1z7lMq8qH5XJCJIe?=
 =?us-ascii?Q?DUpUfB0e9aKA0n16Pdb1T3ZSZnN66dk8VZSNyyOu+IireL0/3GUrcq2lxj8Z?=
 =?us-ascii?Q?VG/FKocVRTqvB+fB+t/sdTabIDEkMc1uUOcNf6lV32JjrnxyIdeo44xo/Wl3?=
 =?us-ascii?Q?u9zAoFVKueXlVXzMRwN9FfdPuZGT8DIHTdVBEaecJ8rMG/E9aIgUtrFsKXDA?=
 =?us-ascii?Q?kEPmMlPd2D9CLqE8a5rdwQdU6ke062ESoo6o9L7NPf/2eTeQjEsiZ2SohpN4?=
 =?us-ascii?Q?HYl3X/6qbFiPpP8qQZD0u/0gRh/ZywBEFAuNDZPpn+XhNL4BXNRIoefr/S5h?=
 =?us-ascii?Q?P9ryE7S8F0IhvnM0qpeKP2SGEV7jdtaqu+G6PEWHVVSP+R0fbYktR5DMEfrn?=
 =?us-ascii?Q?3SfmawzLL0QsUEyXgIEuq3/UDl8i19SgeDHX2uzbclat9QPhLoZ97uHKD9WB?=
 =?us-ascii?Q?oepefmY+JmaanBW3uaBe3VUGgQHVHew/tFsMkcYf7Q52nf+6Pq+aUMGhAOro?=
 =?us-ascii?Q?YZLpZvLKt2Xq8vqPVBI3UA2rpFLnWC6h61LHZAm4g1RmbC8jDFV1SobGJCct?=
 =?us-ascii?Q?5/EbEJ4bp25gwcHTVQEf+C9orM5gsJPquCHNiL0XqrlZqfuTuZdpcVIhhQbK?=
 =?us-ascii?Q?NUHEy6zNSJve7t9arps9nJ5A90CarSPZD+0GuTX+HjLIzLWRmb3kMN8zBNoE?=
 =?us-ascii?Q?B9ZKl+XrY5BzNDhS+YFDEYAoBug3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:53:40.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097d6e28-72f5-49c4-2d1b-08dc6d132702
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

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
v1->v2:
- move #ifdefs from drivers/base/auxiliary.c to
  include/linux/auxiliary_bus.h (Greg)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
- Fix kzalloc(ref) to kzalloc(*ref) (Simon)
- Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
- Fix auxiliary_irq_mode_show doc (kernel test boot)
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 167 +++++++++++++++++-
 include/linux/auxiliary_bus.h                 |  20 ++-
 3 files changed, 198 insertions(+), 3 deletions(-)
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
index d3a2c40c2f12..43d12a147f1f 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,164 @@
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
@@ -295,6 +453,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +469,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +485,11 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
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
index de21d9d24a95..fe2c438c0217 100644
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
 
@@ -209,8 +214,19 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
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
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq);
+#else /* CONFIG_SYSFS */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq) {return 0; }
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+#endif
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-- 
2.38.1


