Return-Path: <linux-rdma+bounces-2625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCE8D1700
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964B11F23554
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883513D8BC;
	Tue, 28 May 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4yqUVUy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACD13D88B;
	Tue, 28 May 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887618; cv=fail; b=GQLNR89RgbU9ilrQ94GWsbL/GiL7hmSayXAErolDP1WLAFwWBGvPrbFvGoSZR1CB0ZBE35XQgTMNOv/mtGxZI4xYLZ82Bb/Q1y6z+EazJ5S/Fl5Qna7mC+VWdyUdkwoAIWTi/rfm1ORi9D0Duc2mjUwfvlJQcezCI2YszTeI6ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887618; c=relaxed/simple;
	bh=aeG5DSwKI1qvZWWUEloBaRseOkSpGd90Kqy2o4kUTP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhxiTToi2BY/fM3U2RJQKGtSdf0cpdHNFHZVa0BUViYVTG6f9i6B2lVM5Qf2rvbvN8XWJLvkGD9SOhIWA7cUMv4NTwggoUDKNRdjXhIbEMbDyPaGoU9i4OuwpIUtllU2RQqQCdjZbrCri5i92iWA36t25kA4PsrwbxkTD2dK2oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4yqUVUy; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/pL7xcpgtmwdTlNFrxioE1lON6OtlVrGpAt3g9/AqEBhXSwl8enAYsx8oP4hO2/GtJhxvBlD5/+3fidC9erXc1w6lrShc4YDSjGwm1qq+0RvKORru/O1F6TnGyGsAJbG2RjUIDuEHpl/lCddg31/dmzcGczsGFcYPXFLK9sCAR0cmMBQ9VHbJhG1IEi8xMocBZuw/HFHHdlFxlaTDisrbn6Tb/6HxQlMXoSlaW1MdnHkMDesd0I9gqgBzK+v1mPNyHfgOD7bWNe+BXqzECtT73B9MEUdtdSIX7FX0SrbwDjkWfoQtZ5nApuFMw0GBuGN1l1d6hjLFD2jQpGgTUn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkhVCncTnYv2Lf8v780RAuo2c+qvvd5mBfTO3k+3dKY=;
 b=g20TvuDVoyCFD/scKwMk+ZUhVuLJ4FVS2evZvx2Gkq4whol0/Dc0yXQk3TcLDzhTCQm0BaYLO+REsZINniIp4CZlaFFaaZvn90R1JBatyu1Y1bojUbSwsY+vKWvfpVJYMEjjH0wiP0FDX+VkXcYm/yUp3w5DCd1XjQRY8qzpJoUaBAppJJkhPQ8tzbex6bDm9SBl8uEaaTll6zH3uYN+LrwQqx/cv0yM8Vl0VEyEFWTmtoVRvVSzul+JqHydK3WsNua0TvkuGQ2t4VGpN7fDUkCEsYS1pLJODPbIIL+2C84LnE30zDcOyDX+wAY7rs8jcZwA5/dOQUr8n8d9iLkS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkhVCncTnYv2Lf8v780RAuo2c+qvvd5mBfTO3k+3dKY=;
 b=A4yqUVUyaBZAb8LLS7XBekn2zw1DEGoiU7THklROiD1YHQ6CwUQQmUIVz7c5IFBOgelSzub1xsLIpmK12ScP3M/fX8V12FUgiIoxQTIDGC8hAf3N3RBL1gIuF+inRsMS8olkRLNY7tZmLufCdV88RX1yLSN2OqM4sjh5ILjzK54+4sZwBQAzyTOMhlm6ktbbsOyQzXqgRseS0ox70YKUHPphMkxuBjvxxDuv20fLY5wRNo8T3yqH89MXhwEnQp6Rq3SN+zuwFCAcRwi/ogaRipICJFG6JRtZvf8PHF/+AeePnIm7BIT8KQ2yFyfmBEpgeqIvrZf4r0us5Hj42PftPw==
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:13:32 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::3c) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 09:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 09:13:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 02:13:14 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 02:13:10 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v5 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Tue, 28 May 2024 12:11:43 +0300
Message-ID: <20240528091144.112829-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528091144.112829-1-shayd@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 61875bed-4ef7-4ae0-565e-08dc7ef6725b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ETHEGW4lHXZbUpJApCfTOGLkTLi0dSOygVqFWZ+o+Rf7tvt8hhm2oMumckK9?=
 =?us-ascii?Q?JbVOaESggoAjH3KJ3p0nQpcrVvER4p4+TLY6pVO/xadjJ6m1HAbDhoyCAubh?=
 =?us-ascii?Q?48QiVaKAHWqFgtZKY7meHIdcYso9rEPVs/1Y6ZaA9bU7GV0OBvDizeAYLoIU?=
 =?us-ascii?Q?OA1hyp+pdP0ugYEAiToZRhz035hp8dFxtRqTW6H3i0R70J5w8w1OVywSp1GT?=
 =?us-ascii?Q?1NcVtZ3ghd9bCT/p+8DSV7uFuhRs5dWkq4CxJm4/Q2nv9UnERaqpw+pvYHDU?=
 =?us-ascii?Q?KemZFR2CevDDzKjE9xriFJoQ+he+k4MsLT5jntan9jOfAyWIQJJHVKnENr42?=
 =?us-ascii?Q?TV3D48dbz/CwGrIvULKNXgJoJ4efta/7BS7r1yfbRFbxGzapS4ckHWTFNP7Z?=
 =?us-ascii?Q?p128vuyvXIT/N7nfycliqRYK+s9JYfkhfOM8jyyH6iJdupklq98AQugvebAy?=
 =?us-ascii?Q?lAcdG/8imbH292wPzwAWFbS7uWHw3ztrqEWeGfgWk+Rnct9D0aEThnwCWKPD?=
 =?us-ascii?Q?LhnCqojQY2qVweborkj2SKWHqjCg6yKnThVONUgk9pgdk5aNfikH+8tWO2g8?=
 =?us-ascii?Q?/H/f8A5XRjcbDiZ2ScBsB5wzGBfNUUyJZcGtiXeCIRV/AMHJJk/AiCfovxSG?=
 =?us-ascii?Q?FOYcePskpdLlMfjUGJmyCkkq2I5yhwE7LbkTsmd4ABmfudrL4QClHj9i0TLI?=
 =?us-ascii?Q?R1913KgBYZ8jUVCs7epfW+UWyN6adD59iFhMPwALqinuV7mnlhaNnvKSa21E?=
 =?us-ascii?Q?BlGQ84IGl2IJJ74bLjmID2/vH9OJ5SLZkWxttWOGAYNy7CKyUme3z3742QPd?=
 =?us-ascii?Q?PO23IgZE9ADUQB95OkveOs+cg4ZT4hIATVHD8nXB4JK7AKNT0HsEDjknF9kV?=
 =?us-ascii?Q?lnmUuiXh9Qh5jA2HNtsnNMHULiIERbDGHAYVJmH3MWp1+lIYLM6mSba8X7l4?=
 =?us-ascii?Q?AVuhCVXNFmT+PYmoE77KHrt4Je06XosAWtRQ5juEKBFMSLIhtTiB1aU1+pEF?=
 =?us-ascii?Q?TXYiikTQNIz71KBPZfA7wv3hpdG1f8v2t22jElGgRmRg3z1tHvIA5ZSYnhHB?=
 =?us-ascii?Q?pvdfeF9UPKDJbcO9BC+Qv0Gp3YA/LJEjWLHZisu829yfsZXudZTPwEdBdINQ?=
 =?us-ascii?Q?sSDFShHkg0+qtFWAxTLnFPPcGtj3OsoSojpofVngdaJPin2YSqlPdrLL4zYF?=
 =?us-ascii?Q?ILik4dJhvvr7eXNnZsu0opjfcsVCmdKdqFO3JCD3mTvrf2Bn/4X0YATHiVte?=
 =?us-ascii?Q?DSovezanMu9f97ZuJx9mhPo9S/S48HP0dRAQODgVb3TeHE7ijRkIjHyuMdEk?=
 =?us-ascii?Q?g4+WAFvet65H+E3lurInCL4kX6uF3uh/8mo0hpdefCksdbLYR3SgmPD459jY?=
 =?us-ascii?Q?XMbGBjHVS2UKFfNKjlB2lF6fzR9I?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:13:32.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61875bed-4ef7-4ae0-565e-08dc7ef6725b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Some PCI subfunctions (SF) are anchored on the auxiliary bus. PCI
physical and virtual functions are anchored on the PCI bus. The irq
information of each such function is visible to users via sysfs
directory "msi_irqs" containing file for each irq entry. However, for
PCI SFs such information is unavailable. Due to this users have no
visibility on IRQs used by the SFs.
Secondly, an SF can be multi function device supporting rdma, netdevice
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
 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 165 +++++++++++++++++-
 include/linux/auxiliary_bus.h                 |  24 ++-
 3 files changed, 200 insertions(+), 3 deletions(-)
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
index d3a2c40c2f12..579d755dcbee 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -158,6 +158,163 @@
  *	};
  */
 
+#ifdef CONFIG_SYSFS
+/* Xarray of irqs to determine if irq is exclusive or shared. */
+static DEFINE_XARRAY(irqs);
+/* Protects insertions into the irqs xarray. */
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
+static const struct attribute_group *auxiliary_irqs_groups[] = {
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
+	int ref = xa_to_value(xa_load(&irqs, info->irq));
+
+	if (!ref)
+		return -ENOENT;
+	if (ref > 1)
+		return sysfs_emit(buf, "%s\n", "shared");
+	else
+		return sysfs_emit(buf, "%s\n", "exclusive");
+}
+
+static void auxiliary_irq_destroy(int irq)
+{
+	int ref;
+
+	mutex_lock(&irqs_lock);
+	ref = xa_to_value(xa_load(&irqs, irq));
+	if (!(--ref))
+		xa_erase(&irqs, irq);
+	else
+		xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
+	mutex_unlock(&irqs_lock);
+}
+
+static int auxiliary_irq_create(int irq)
+{
+	int ret = 0;
+	int ref;
+
+	mutex_lock(&irqs_lock);
+	ref = xa_to_value(xa_load(&irqs, irq));
+	if (ref) {
+		ref++;
+		xa_store(&irqs, irq, xa_mk_value(ref), GFP_KERNEL);
+		goto out;
+	}
+
+	ret = xa_insert(&irqs, irq, xa_mk_value(1), GFP_KERNEL);
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
@@ -295,6 +452,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * __auxiliary_device_add - add an auxiliary bus device
  * @auxdev: auxiliary bus device to add to the bus
  * @modname: name of the parent device's driver module
+ * @irqs_sysfs_enable: whether to enable IRQs sysfs
  *
  * This is the third step in the three-step process to register an
  * auxiliary_device.
@@ -310,7 +468,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
  * parameter.  Only if a user requires a custom name would this version be
  * called directly.
  */
-int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
+int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
+			   bool irqs_sysfs_enable)
 {
 	struct device *dev = &auxdev->dev;
 	int ret;
@@ -325,6 +484,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
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


