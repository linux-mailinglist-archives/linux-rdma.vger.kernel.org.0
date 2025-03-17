Return-Path: <linux-rdma+bounces-8739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E856A64A23
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 11:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDBA18855C0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9E2236FD;
	Mon, 17 Mar 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BVhqciW5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7D214A8F;
	Mon, 17 Mar 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207616; cv=fail; b=VS75QpEh81PUWA/IPsI4q1gdXGaYw/B40x/tSrzU0+Kk22qxirfZw9kUUkUcWa7asVYO61YGrescfhRbg0IRYGt6c6XI6Hk0L9AYwDQXYCewpnbXdqKhXnlUCzR/7MgQSxnnqiCo6EcwIIgxiuJ6+Ywobia6CEM4La5AsAukFDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207616; c=relaxed/simple;
	bh=m/cK2PgFQMcQXJA9tFAwPyw9303ZIRlki/CVZ/PfrWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0VOeDJoheAwBAHXNCnVOvBHTPdZt2/BiIM8ZcvhO3Td/pv9lJFaLVj+DKNt3S+dh0iXCxKLrcG1YiziRHG5PzO0Z2Tp6S7qbQDzinqUFcradq2hqXzYQ053qY7bAKq3jqkuZb/rkEpjEqnkfGtYuV5cjs4z/YZ39MukxoCs8X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BVhqciW5; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks+n4b0tIfH/KNs3hlx4eVeJytk6MxHAUJwbX3sabOMnHkX7T8DVnYgi4acVl5htif5EdEv508FFxcrebJm8GAAaT491omGHqpme8x0vtCbCny854Ix2nOvWqf92rmBH0jGaNXZHRd34HVM07JicIU5Tm5uC+LtGLVo2pQ0tD1cEJrhbk8gmQwwqNfXb+cqNEE+7Qi4I4jCUQiH6IwXqiWvk98deQPw+kqdThxW90BvZv6MmVMjPozxEmn4pT0VzhT/aii5k73QAiojlsTUd2x4DK0WgjVM3LO966Hskq3a5BnHWVAEyyjIq2oygM1Ejy/z4/8NXYl9Tyxo3RJxaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PbfuUevHsiD6B+DyNV7b2GBuUHvgVf/9KNUBm31Cl8=;
 b=sU7ILOmDZ8c2Pk+qD4v695WuzOCqrBjJOqVvzQnZ1J7UvJ1pUTw1j04YIds9KmRlG9HmmPRDhlLWVhMz192WYmk1j8wRLzOWNI6lpYXzDjkBVPNIJOmCdF+Avx4F3mU40xhlxXG3jATdJB+ou/YaK6cdUldfi1HIG+4png0Q6cfXq0obO64cLeUHfHMIm5HASw0FjqfZuaH4kksh3AteN19nqufAvv0PW41QD0i6gUh6U1qRAEMlbCP7jsfcdBE97tvptVCZURNkq4jP75ICZ6lacbUEWdVbunqkaCrIpZFqs7VTcudeC57JPcg98fs3mWsyx59YkNIj706TUEeLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PbfuUevHsiD6B+DyNV7b2GBuUHvgVf/9KNUBm31Cl8=;
 b=BVhqciW5nAsAnE2XbSdfMwBpdLniVAMD2dRyZmk4K+YKY5l/sVRCjLaZFULP5uSWMW2iXjC75HAY/XvnBV7VdOdTwEEavYtlegoTwj+aec/ORMCmahxUKtrOZxewtutFMUxV+vn6Y/BVwuwGMefGZNYBY5UXJ6oBgquV5fIyONh8oJRXxm/4TtSJjBu9FyI5ClgkGonEF5hDUhRv9c54g72MglmyY6LtxrcjO/WFUCetGvDpMa498PGJToMSFVyavejCAdLwi1Nd4Sw5HaRz3ScD3pypxfXqmeStOcZjDGRKcvbtiKP7i+nkIBTcu8uzrIbBCupqtzF6VEC8utllpw==
Received: from MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16) by
 SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 10:33:26 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::f8) by MW2PR16CA0003.outlook.office365.com
 (2603:10b6:907::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 10:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 10:33:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 03:33:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 03:33:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 17
 Mar 2025 03:33:09 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
	<david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <leon@kernel.org>,
	<shayd@nvidia.com>, <przemyslaw.kitszel@intel.com>, <parav@nvidia.com>, "Amir
 Tzin" <amirtz@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on bind
Date: Mon, 17 Mar 2025 12:32:54 +0200
Message-ID: <20250317103254.573985-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fc0a80-98e6-4bb0-3dd9-08dd653f2679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nf09BBF1XWEN5ONw86+rZhA+qfOCG0aOPmF5fMA8YDqiTVgecm68HfuOsUXX?=
 =?us-ascii?Q?4nMvSy9zOrpSqGDlgZESz54VVr1WsY/IVZq3dCIhgbovjWzYcbtI5Rn0ys5R?=
 =?us-ascii?Q?z+SpT5q0jzIHCv/cVprO1HIWNzUAIw1p8ZsBSkVR9AAQub+IE8QU3RCZkfvS?=
 =?us-ascii?Q?hcxceBUysjJJittOPPFaZ318aRmUl1jkDW2DkBtzT6AdsmW6Jsf1Jt2ZneAM?=
 =?us-ascii?Q?Katk00xBkb4JFk8wl9EwWnJqR2bcmg91ON0vXsBQ9gvpAqcxCYmIBa7CzGS/?=
 =?us-ascii?Q?bDPeSokxh58R636HhflEJXujgsTgvGLQ2lyCQbhAEF+GWHnpX/YXDTGGihhm?=
 =?us-ascii?Q?Kag/whZDml7DDFmvL9rN/2xtKqeeD1yy3Qky2Sl3DDjqJQWqD1m4Cri7Xpsy?=
 =?us-ascii?Q?tArHfVttxMcZ3tCJNRTxg3h++2xfNwFFPNR3De3KpxCB/wTwK+fx31crcris?=
 =?us-ascii?Q?XODYjsHx2j1pXUFkzsU0sKE0NvZ6Z5nBOinPCU9M6fHaJG+BF7vMehINNQau?=
 =?us-ascii?Q?EqxV/GXQRa+wgYo4sNLTye2xCQUP8XuNvVWbCNWmqT1sjVI3Mc5wjvtOrzAx?=
 =?us-ascii?Q?604gs/rdO8U953c6M833C9KzdoVKCCz8C/I7b6cEOThnQ1+0XWtLjB6aNVQW?=
 =?us-ascii?Q?C9qL/LdWz0p8z44favzsPGwoIlX9A5ywRmqseUVp7EoOpumQvj9HwcopVnPB?=
 =?us-ascii?Q?voCDcU+L5PT+3T+ce1u5GNQZBd7LbhlrAmNXFRDDG65+XsuN+ltH05K++tWG?=
 =?us-ascii?Q?zyufOPzUas0sKLV6Te86y0ToLhTLs1/h9GsZdw1OJv2ZS/gx8MoyRB6v+GHF?=
 =?us-ascii?Q?yyqVEDwh01flUfn0LauV875moax0S5Wruan7etYujNrEitusad3zgmQKMeiI?=
 =?us-ascii?Q?b4MyiKRPMDRoJu8XCpE2gp7r0vWWmWJXeyPwq0uarBauYlWEbOJfrOHdQCIw?=
 =?us-ascii?Q?ygELWrkBowaBoylZwi/SreKiaJCHqTGy7pVtGRl+USfeq8OEALwzJtVdJdNr?=
 =?us-ascii?Q?EFSMTwb1u/xlACYoxJpa1IQ6rt+LHhD3BQXpzPBtWke+c8ziAtTUAjAXiSbH?=
 =?us-ascii?Q?HaU4Br8pmWlZuRR5VO8l6LRYdZerVvVtrFY8ho5UtOmRr9Eqabw+OUvFfVOH?=
 =?us-ascii?Q?YNApmu4eG8rofHE+OOi97Utyjv1LUW508u8h3Gdx0DH1NGSuSP9B/pBuqP33?=
 =?us-ascii?Q?FSzz+bkRBwmhuRX/CHc97XK2jhNjGJyooeRFhjgu00EYhGHitBudXNBmjxVt?=
 =?us-ascii?Q?2TbAu1cBoyAQMCZ55x3aTWmpRTA4J2XAbJiROILYbu1mWPRvAsKrk1tnCwQf?=
 =?us-ascii?Q?MbTqLYGhcdTYXfbc7blv8UQMTMzYhT4LEFD64DDRBk+h6xiYzWOmBfBq2gUW?=
 =?us-ascii?Q?xk360rwvtQ1UbA94sZ9fEGKBsZgCsylU2TcIwhvutyZ3mP0NYmpBboO3VYZF?=
 =?us-ascii?Q?x0ELhwk0a+Ov6DnoysT+HS0PfPcpdr5x6CWdT3N5ICcQXoFNbdBRMVE3wet1?=
 =?us-ascii?Q?osTMfKBB9VgSBPWljuWYDNgs8B004lYU6yrb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:33:25.8990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fc0a80-98e6-4bb0-3dd9-08dd653f2679
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

From: Amir Tzin <amirtz@nvidia.com>

In case an auxiliary device with IRQs directory is unbinded, the
directory is released, but auxdev->sysfs.irq_dir_exists remains true.
This leads to a failure recreating the directory on bind.

Remove flag auxdev->sysfs.irq_dir_exists, add an API for updating
managed attributes group and use it to create the IRQs attribute group
as it does not fail if the group exists. Move initialization of the
sysfs xarray to auxiliary device probe.

Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/base/auxiliary.c       | 20 +++++++++--
 drivers/base/auxiliary_sysfs.c | 13 +------
 drivers/base/core.c            | 65 +++++++++++++++++++++++++++-------
 include/linux/auxiliary_bus.h  |  2 --
 include/linux/device.h         |  2 ++
 5 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index afa4df4c5a3f..56a487fce053 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -201,6 +201,18 @@ static const struct dev_pm_ops auxiliary_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
 };
 
+static void auxiliary_bus_sysfs_probe(struct auxiliary_device *auxdev)
+{
+	mutex_init(&auxdev->sysfs.lock);
+	xa_init(&auxdev->sysfs.irqs);
+}
+
+static void auxiliary_bus_sysfs_remove(struct auxiliary_device *auxdev)
+{
+	xa_destroy(&auxdev->sysfs.irqs);
+	mutex_destroy(&auxdev->sysfs.lock);
+}
+
 static int auxiliary_bus_probe(struct device *dev)
 {
 	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
@@ -213,10 +225,12 @@ static int auxiliary_bus_probe(struct device *dev)
 		return ret;
 	}
 
+	auxiliary_bus_sysfs_probe(auxdev);
 	ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
-	if (ret)
+	if (ret) {
+		auxiliary_bus_sysfs_remove(auxdev);
 		dev_pm_domain_detach(dev, true);
-
+	}
 	return ret;
 }
 
@@ -227,6 +241,7 @@ static void auxiliary_bus_remove(struct device *dev)
 
 	if (auxdrv->remove)
 		auxdrv->remove(auxdev);
+	auxiliary_bus_sysfs_remove(auxdev);
 	dev_pm_domain_detach(dev, true);
 }
 
@@ -287,7 +302,6 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 
 	dev->bus = &auxiliary_bus_type;
 	device_initialize(&auxdev->dev);
-	mutex_init(&auxdev->sysfs.lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
index 754f21730afd..fa0eb4009f4d 100644
--- a/drivers/base/auxiliary_sysfs.c
+++ b/drivers/base/auxiliary_sysfs.c
@@ -24,19 +24,8 @@ static const struct attribute_group auxiliary_irqs_group = {
 
 static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
 {
-	int ret = 0;
-
 	guard(mutex)(&auxdev->sysfs.lock);
-	if (auxdev->sysfs.irq_dir_exists)
-		return 0;
-
-	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
-	if (ret)
-		return ret;
-
-	auxdev->sysfs.irq_dir_exists = true;
-	xa_init(&auxdev->sysfs.irqs);
-	return 0;
+	return devm_device_update_group(&auxdev->dev, &auxiliary_irqs_group);
 }
 
 /**
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2fde698430df..5cc89528ffd2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2835,17 +2835,8 @@ static void devm_attr_group_remove(struct device *dev, void *res)
 	sysfs_remove_group(&dev->kobj, group);
 }
 
-/**
- * devm_device_add_group - given a device, create a managed attribute group
- * @dev:	The device to create the group for
- * @grp:	The attribute group to create
- *
- * This function creates a group for the first time.  It will explicitly
- * warn and error if any of the attribute files being created already exist.
- *
- * Returns 0 on success or error code on failure.
- */
-int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
+static int __devm_device_add_group(struct device *dev, const struct attribute_group *grp,
+				   bool sysfs_update)
 {
 	union device_attr_group_devres *devres;
 	int error;
@@ -2855,7 +2846,8 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
 	if (!devres)
 		return -ENOMEM;
 
-	error = sysfs_create_group(&dev->kobj, grp);
+	error = sysfs_update ? sysfs_update_group(&dev->kobj, grp) :
+			       sysfs_create_group(&dev->kobj, grp);
 	if (error) {
 		devres_free(devres);
 		return error;
@@ -2865,8 +2857,57 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
 	devres_add(dev, devres);
 	return 0;
 }
+
+/**
+ * devm_device_add_group - given a device, create a managed attribute group
+ * @dev:	The device to create the group for
+ * @grp:	The attribute group to create
+ *
+ * This function creates a group for the first time.  It will explicitly
+ * warn and error if any of the attribute files being created already exist.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
+{
+	return __devm_device_add_group(dev, grp, false);
+}
 EXPORT_SYMBOL_GPL(devm_device_add_group);
 
+static int devm_device_group_match(struct device *dev, void *res, void *grp)
+{
+	union device_attr_group_devres *devres = res;
+
+	return devres->group == grp;
+}
+
+/**
+ * devm_device_update_group - given a device, update managed attribute group
+ * @dev:	The device to update the group for
+ * @grp:	The attribute group to update
+ *
+ * This function updates a managed attribute group, create it if it does not
+ * exist and converts an unmanaged attributes group into a managed attributes
+ * group. Unlike devm_device_add_group it will explicitly not warn or error if
+ * any of the attribute files being created already exist. Furthermore, if the
+ * visibility of the files has changed through the is_visible() callback, it
+ * will update the permissions and add or remove the relevant files. Changing a
+ * group's name (subdirectory name under kobj's directory in sysfs) is not
+ * allowed.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int devm_device_update_group(struct device *dev, const struct attribute_group *grp)
+{
+	union device_attr_group_devres *devres;
+
+	devres = devres_find(dev, devm_attr_group_remove, devm_device_group_match, (void *)grp);
+
+	return devres ? sysfs_update_group(&dev->kobj, grp) :
+			__devm_device_add_group(dev, grp, true);
+}
+EXPORT_SYMBOL_GPL(devm_device_update_group);
+
 static int device_add_attrs(struct device *dev)
 {
 	const struct class *class = dev->class;
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 65dd7f154374..d8684cbff54e 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -146,7 +146,6 @@ struct auxiliary_device {
 	struct {
 		struct xarray irqs;
 		struct mutex lock; /* Synchronize irq sysfs creation */
-		bool irq_dir_exists;
 	} sysfs;
 };
 
@@ -238,7 +237,6 @@ auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-	mutex_destroy(&auxdev->sysfs.lock);
 	put_device(&auxdev->dev);
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..faec7a3fab68 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1273,6 +1273,8 @@ static inline void device_remove_group(struct device *dev,
 
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
+int __must_check devm_device_update_group(struct device *dev,
+					  const struct attribute_group *grp);
 
 /*
  * get_device - atomically increment the reference count for the device.
-- 
2.34.1


