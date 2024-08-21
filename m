Return-Path: <linux-rdma+bounces-4444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46D9593E1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4D1F218DC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E249166F02;
	Wed, 21 Aug 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YcHfZLMY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5915747C
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217046; cv=fail; b=ALcLdu4nS51CAOLsx23fwxnHsBjbqw0UhwqLlpVKyYmZvdvNL/orcScC69S+zx1VQnGS8s6S7/0x3Yr6y4M9vAtj4pV9L0RlAj2jg6w6jiQa8csuJYy8CBMHU5/27SgmzFVhfx/XRB4z9zcspQyWvXrc4mqVhM0zoK49Vy5yP8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217046; c=relaxed/simple;
	bh=lLEMnxsxyqW9JKAvem3D0RAljr/RlvLLG90QJIOYFXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnY6PQMRx/pCSTI9AzOtc0lG67YfR28NvCU8f32Jv6wOHfqPDyvIbbKOjf8Tme8NSL2ZLo2sw8wN6l8VWF0KcD/RllX4OpLt5chFfHfsGBim55JQWq4qYFsOtktW8MVUsEOb43IMwDOvmskoCKi2rZzkk1liq10aHVbr3Qa3X+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcHfZLMY; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa84oWmE0prvwfwqi5egm++1LlAB52WXhuokAtX9PnX+1Vta86mLdHQEaxanuFv+Ne/YeeQaDrHuCw85h+GCx8uSfQqgmzLu9aiFaKxwcPSQOt/pgX2jLjHFrNGpOMKC2MfA4WoPPDd8Cx1wahNU1Uxa/RAyNG7WQ+FZy2xnGC+3sQ+iP4oYc9cPclIIq1xKkrv9OFodEspcibRMcqTGE8knidqB9Hv9Ddga63OOnZctbKHzRz3LAhgGOGN4pfMghMPZnWefATqVBS/olsIoYpv2ozIKH1wn2lCRrYBUdX3aTFqcIEKxtOYQtmC+tcFgELQSbBaaWp9T72tsRepNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=N839+XdMXA0Wp27HZcBPA6xdzqVrgBrSkboCu59J9LqpbkkshfNShjntGxvqzDfPrJ0ieCgdX+HglvjvwU/ZzafPhbXRdSjFGs+AT36cpcjdfETHcUHZcUYgBJaJEovZQ1dWxfKOwexyt/ZwKCk6qRGbjFYegrbNcX3rE1aJhYzluBtFUmyvlRm+j7r6Gk2eRjERsCfqTxKsxuHJq3uaclXZYSbEkr04RknDjhrZMEErOG+Q3x3Ych6yohLcCEvVQ1vZYyrc78Sbg8WEJlLtTIWXwkXArCvtW/WloHusF792OkKZN8AmspUMxs5tcX4qXgMzP//q6bSJOdceTRvGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2OqhVHk8El4CAjcA45dc2j34faTtRc0H2tjll4NbU0=;
 b=YcHfZLMYYNtdd+41wp1Bv5YcN1A54kkxBh544PTCINhYrm6H1do14SVVmS7XtJB2xi/0swdbv/VRIXPlY8yPar2lypwhvjUvhbCmEYI/txRDw5dwQ7T4DpIR8IYHbi2nr7o7prQ5OH8ZvWsTm5HJEMIr2OburuR1BYiq7+e1EWZRZy03qHzHLloiK2YX1nqc8PN4Zme0PmzU2VyNuf6NqafCO3xiZiV239pFGpFY3xdMecWLcrP2Eg0kLbtTm+6wS8ttgtcTzZt5Ho2P5wPMzMfu7Qu4csZDSdpK6OIYmluH/fcCSffSeeyUyd2hlTEMOhOw7iT8CAYiSGtgrA7Ktg==
Received: from BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40) by
 DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 05:10:39 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::5d) by BYAPR01CA0063.outlook.office365.com
 (2603:10b6:a03:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:29 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:26 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/7] RDMA/mlx5: Obtain upper net device only when needed
Date: Wed, 21 Aug 2024 08:10:12 +0300
Message-ID: <20240821051017.7730-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 00802951-2f4e-4eae-36f6-08dcc19f9919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1xV2ue2AdUXW+pR3QOjI431SsxK3JnHndtwsW6gcYUwpdCTiEw90fU1WO6R?=
 =?us-ascii?Q?bsLo6Zt9Z8TKYWY9sWZRgwRo66z2hjnOlLkVoDDplBDj5IFJYqnXwTc+9PAe?=
 =?us-ascii?Q?atKTgrdKvfFjFe+oAF5RzPu0LzoQA3LNTAa9TL98UGMwc0wsHCf5vzrlvnKp?=
 =?us-ascii?Q?lZS20SKD78BsrtSI2K4DRuiy4hUPharL6uo+S3recnAfp7NafePKVGq4Ymkv?=
 =?us-ascii?Q?53X1ke0V29VJg6KdfBjyg5UmaGpqyqnUDXNVk+LvN0Wtg7/F7Q+AxkiMjnRi?=
 =?us-ascii?Q?ek3nOABb3KWRJZutlJJXvbBeaAnvbeF1rB9Hd1PzAbU49BWk0mQXdLWyLfIw?=
 =?us-ascii?Q?UjxkNvf0tM/5b46U3hRSr8AVucs7uPlucB4LvyRKp9oz+Pn//O0bYJgwxKQT?=
 =?us-ascii?Q?7SgPNomSQrV4SYC7MWjFhXy0SNvmy0x39IYW5tuJvHidnGCpMDIIlheLIBXP?=
 =?us-ascii?Q?QFYtP9eznXH10Tn56phKSrlm65lADNHnBWyyoR4pGPPDWJ37VWsTDSmZEoXI?=
 =?us-ascii?Q?e/SNxtfCv5FUGig76TgiFAT7cEGl8idnrXB7KNPCN7+qDUHRVfzoT3RwomP4?=
 =?us-ascii?Q?+1EMbtOHsx26SenSW2ZbRjPh7LXqrhnvH9P5QwMLjOm4TVLWpEALcdvTgf/i?=
 =?us-ascii?Q?RVxrDSSwfeDQ2+bs2o4g6QMzLIKOvfIfc3KoxnZ6UXZPlLp1chBOuU2h628R?=
 =?us-ascii?Q?/jMbx5nk9c2X/eeIMaBXdtI67S7PdbCxCNx3L/ubPIJo0DtAfRAt285WoLoO?=
 =?us-ascii?Q?U/bLUEstP/Wr2eWrtdshcgrjD/seizTcNYXJHf1HpV7RFCF/mB9suSVUFZLT?=
 =?us-ascii?Q?PN68H7hortvcYpjh3oMKXiYWYhGf4254bRuxGyRYz3S0lQ7zQvQf3ivALhAc?=
 =?us-ascii?Q?xMzQtk7J0Ed4O0oT932lB31deyEQZxrD9mV4ddcU1tnSqRCiK9qsCtTjYI5A?=
 =?us-ascii?Q?3BEst4RO5hi8J1mJtUx0mHUqsuzJzvFaqAT13PqOWyqhnvi7ArZmm8aKbJ4S?=
 =?us-ascii?Q?d0E+C5duQ+1fjEYrC3oFsYh9AnCdEVRATihVD0giGxJMTS7dcdgzN3XEv3GN?=
 =?us-ascii?Q?alz5S7VOCK4K5DU94blKZcMZxpJSrwJBRxMgh6HtY76dIDxCgngXsnlGMMGZ?=
 =?us-ascii?Q?G7cHVfsuDbzCZnjEOlr0UA0PsG/TOoskFI2fDGM+KDNgE0N3y+B4JMiL034h?=
 =?us-ascii?Q?fzogPjLJuz25qadVINaNwBzvT/QqGpc010FoLGCIgpQ/WKa2xc2MW85KtPk3?=
 =?us-ascii?Q?z2JSL07VB3VfzCtsBwkAyckTqAYNI+cJcICjjK+WDtgj+gr/qYPWnkIyrSHA?=
 =?us-ascii?Q?BhC7JKqJIjMc5PrxogvB6o6VKXvIC2tVLPXyMCAtgayYstAJZPze2epV9uEh?=
 =?us-ascii?Q?dgOtghyWNRA8rBh+D49phAzp/SzI4oLT5MNXUVTl2vNywi1NGeCwljfm3hLW?=
 =?us-ascii?Q?xsUJ8Sp7UYuSOmRj6KJ9u8dWRMrYOqHb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:39.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00802951-2f4e-4eae-36f6-08dcc19f9919
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

From: Mark Bloch <mbloch@nvidia.com>

Report the upper device's state as the RDMA port state only in RoCE LAG or
switchdev LAG.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index cdf1ce0f6b34..c75cc3d14e74 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -558,7 +558,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!ndev)
 		goto out;
 
-	if (dev->lag_active) {
+	if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 		rcu_read_lock();
 		upper = netdev_master_upper_dev_get_rcu(ndev);
 		if (upper) {
-- 
2.17.2


