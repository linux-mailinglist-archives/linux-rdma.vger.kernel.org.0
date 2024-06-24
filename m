Return-Path: <linux-rdma+bounces-3463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF454915A18
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7650A283620
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05C1A38D6;
	Mon, 24 Jun 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEPFunku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4D1A2FC1;
	Mon, 24 Jun 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269270; cv=fail; b=KReeM6BfqKJE+D8vou0UDd726nMNZ+HQ7hfxE296SJqWZXUtUWOd3CP5s2kOYE4ZgjMbLFyR0fjZ5foYOC0T/EJbJyuqNf+q3lDS/2x6Cn83KsZ6J/mw6rGyGaza9ZY7uZo9l8wZhb+rDn7FQ1ZBwbri9nB/5M6B2CbStomxxBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269270; c=relaxed/simple;
	bh=8OD2Hfx/2G14AFgglBk1QAzWsKVoply2tS4MrhiZpkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTacyTCRuV/f+N1lwoP+BJ+Ev+DFmBsQ7xzwwEUCu3sHUBsvU0xZld77mz4fn/TKZ+eYUd4afPE09S8cdP0A2Dbwtpc10T4nFYyfDxGw5MfTjoDoEMYw1iAI75qCnz/uStI5EqxgKyXjhcdTZNYsnxuXtWKxmzaMuowXAwE+oFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEPFunku; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9nBXT3lp6mrakV9OWtqBE4L8A2JrVKaCCN1HUlK57boFBLtAbocn9AFzy+N6dQzPjxHf8CtkpVW/eQzEBknGsW+SMprtBcQ2vC2mFJ2drwDybZ/hbl25WstLusKaUHaem8wa17WLfvELb/Zk7KQn6H/ZJjcYncCV5iLECDyva57ODMqfP9uLhUQ7BoOqJba4AoFZ2ghUtjjDKQb1XQYbTQLR+jQyiCza+Buw3q1s7xJ1K8PZJBXi9kEcSN7K7tcUH7qJcISlPQe5Axr+69bua6Rc39LK87/qmyjXCsGWe7L0bdmIImb031jraW4tUwo9K0ep7A/x3eQStdQgdUx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCI4chK7kbXXkpq7Y0mXZ5pHELGxM+ZuWnWxVCW7XP8=;
 b=Z8+B31TuFS76PzoyGzCm95oBzrN6bfjb7UHFqt59ZLQ6/P7Tzq1hguBwgO8zXW12PMzkUARpIxOZD2sBOqLld9XXzjwEGIR4D52iED93OraLj4sAKOQvviZWIO93wHdHhmsugPwv2o037NWXMqrp31AhBeyE4l3Hx7og8UzKjFHwPg21sBJyBLrp9nk6BcgTvCHEzzWD1c1jkffZkiUOKSrZvfC6pwkCMzKucNi80mjUqj2va12iA5cPCvtZ7mHgPza1Ode58aHkI9ROHZNZADkBs2LTneNTrfGQY7nOIJ5X5x1n2NkRmQ270rUZNzmjMEG4Kg/D3YBHpBVxuf9wOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCI4chK7kbXXkpq7Y0mXZ5pHELGxM+ZuWnWxVCW7XP8=;
 b=AEPFunkuyYpnEZDlRAFfTKpJ5+PKULq8Bh5R8rv92PaEd1pyKQkc9T2Wuyqh0lHd7YLij2hJZXAhgdaXHJU4SkrtqWISDF33NvBlMM8xtdsUQt+yHMKCxQdaxzt3UKaudzkWrAXm45/B1NeqwsuxQ2S3+aJ7P3nyKFgLI2MJT+2rhSvtx9mIFESnUQDJsBO22/8YTZcIXvLYf9naqPt8wkwMPELBzc1HgiFnwOVvvt4TtBE5CoPXkJgpOuJsjnPZ0mGPpM7YG6RycjGBLA1cy1IrG8ityqfzpduIHPwP6qCaseRrFHJou8MbS5eyfaiUI4a5GaeVX9kc83YIsxyc/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:38 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v2 8/8] mlx5: Create an auxiliary device for fwctl_mlx5
Date: Mon, 24 Jun 2024 19:47:32 -0300
Message-ID: <8-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: f201e901-df8d-42d4-176d-08dc949fa34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5qqx8Af2Z4wK5YbT91++zpdljiy1xSm3XiujLtRf7cUJl1ueUQtkKkEzTlG?=
 =?us-ascii?Q?NhjGzDB277f+dmdd2WceMFuzuS7AEC4x5PB2EVC22/LcEsxPj0GrBPIw0WMZ?=
 =?us-ascii?Q?jWLm0vKu43SSN1PQ9JljHTg/1yXUR8WQsAqhD2bvNVA3D24xlou3cAlE5lfD?=
 =?us-ascii?Q?rr0q45yhWw0SgdIfW4vGi9RI88/XsTnw2cCtww4gV7FljUWeLHEBwUBMd1xg?=
 =?us-ascii?Q?i9eKOQ6TWS3+rSvshpg/5W9amachIY4DO1dXyxjgqv2kbY1ztkvPfolj8kui?=
 =?us-ascii?Q?onzrwWDbPaOmHjmP2kAVhtZIG4awYtMZEGjiJVxtfoG0qDSnKbFKEaWi7T/Z?=
 =?us-ascii?Q?vO16IyF88ToXPvzTsp30mgNKEPSCbcOYbRlCqyyWWyFA9sqsnCHuMPzKrndV?=
 =?us-ascii?Q?aH11YOJiSThn0v88LUiP/kQtyrVJmq+3LK2ser7UunLNZI0LMIFUCc4+ED+0?=
 =?us-ascii?Q?/jf+s9qpxDAxVi82gebHRCQptrUrfQtoswT+wUIdSKEJW6cB0BXGZnwjbTLH?=
 =?us-ascii?Q?T4D8hybntWSiHMr6O4ttSZuuFzihlu/suXExWh6wARSIFK41GQfEghtSDlPR?=
 =?us-ascii?Q?/5ZvMln7tkNjjL//g2d7cy5ofLBSUn9dzmGvQMfT8net2dTKfPvKeEPfuVzt?=
 =?us-ascii?Q?z6mB4154oDgCCzXHI2fV52z5E/EA3rVOaDn6nGFlYnLaMITagA2BGvLJL3+R?=
 =?us-ascii?Q?5xD1TNHwfLDu6imhOI9mv7uIX4vu4BBievpfnCXC2SNNr6/hN8Ksczsqf+uq?=
 =?us-ascii?Q?N01KVRyG33C/KK3xfLERTz27CnSf5ySWVKVA5LZWJVU6XP2Qceg+rf1j/sFQ?=
 =?us-ascii?Q?sAn6xqzKOxTRbSM7Ft3EsdQOfpXkS0eVEAMZ+he5YtvR1oa7TeZ46xSBMySa?=
 =?us-ascii?Q?645Lyk6SjSu0byLHxVAzC/9bIXOm6YVSuTwEZFAS26SwfTcK9btKov5IUBS+?=
 =?us-ascii?Q?rYDIJkTd1aacgeSHWo0tMn80T8Y92Np+9fz5+Lf5/m3CVO8M8jGXM82+M3wx?=
 =?us-ascii?Q?2B5bFJNPuaVkLToiUgTN3oxqtasfGLp2TXB+S+KG4oJAlsa6ja38+gJx5qH7?=
 =?us-ascii?Q?i2o5PuoVU/RUbELrZTTky+Rx+MI4STv30AoVirQKjtZA20JwHeAmYggNb+sE?=
 =?us-ascii?Q?FL66y980DNf4Pi41BlMYpT9k5ZBjuFPqP8XdeN0SF92MLrJ39cuOXs9yRayQ?=
 =?us-ascii?Q?RqRBHfhpXxBhkzgk8V7kM37dgLZ6UVdTUUgMUbh14dF4XHXEMOFUhSquBG6o?=
 =?us-ascii?Q?9i9rwynILpV7FU1G+PMonOpzYA8rC8Xwt421wthTUhly5SKMuWE3ZTlRpiMi?=
 =?us-ascii?Q?UOtBQBgJV0CNrfjqWZ9muxctI+wA8H2Zy+rYr8AM++5ZHho2G/xSE0ueI4yt?=
 =?us-ascii?Q?TmaN87M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFVGX2tjKRw26bFmxWZ4o1xiRUz5iJQuYO8fDdaq3BLTJIBB9CGviBSJVI0e?=
 =?us-ascii?Q?ziRNBW6C3m7aJ1zdH70g3sYz4l101Zk2QQwpBFO1CaZ5x4aagTnaUcsL85rc?=
 =?us-ascii?Q?8XvzDIDnbrcU+eeV+ON01hJCRq09SOYRj0ABBZy7wXVhjM3QqdUBD9AY8M18?=
 =?us-ascii?Q?aVYHSP+v2TJoC4Rc7qY0sICcdnhMYjFbeITEm+plACsvbotiqmxUVTcIYnma?=
 =?us-ascii?Q?wzI+vKjvrMuANCMS/KuBRz1kaO9o5/og7KDpbsYWAfj22ffWx1vYqFxKpMHz?=
 =?us-ascii?Q?oJN/sjWZ5ICFMJ6hbqQC3yT5D7kJTtAzTn+xjT0ActwpENClQFeL+qjiGpEJ?=
 =?us-ascii?Q?hiJGdJlMuDnbaozXQCGwSK1qVvJHjWS1LWqDYOi1LiKqY0L2/Q7LzvSXoPqu?=
 =?us-ascii?Q?tmC7wxd78JTnzxo3IEyBuUt81qR92dk6Aj4CSaIag/UcJyOhwJjroV75letA?=
 =?us-ascii?Q?gzLGMJJcSfiie5hXkYk+6NHUfWVjEl8ibNWD+aQp5GWlyZjbRYdNj5dMDtA9?=
 =?us-ascii?Q?+LTSbbLsfM+KY3psc7ybA1i5FI/miEgqtDV2zXpdlVXbapSHLlxco8tfnM0Z?=
 =?us-ascii?Q?3xBXDwPREX6ZoeEQUV5oDXuM9i1PAHlIgPEH5+n82Rnt6dGQqlJVexl54CzS?=
 =?us-ascii?Q?UDuG23FXva1WTUgiR9mE+gOUa+XmOKz6xbpTRsocl9X7Bo/69YKwxDPnyUgM?=
 =?us-ascii?Q?tPQ1mEvmSqOArTM/yMZ6s/c4Ko9SO4u8rqs6CUz7xtAHl2ZECUXFsG4TP5Dp?=
 =?us-ascii?Q?0OxjsdV/QYHb11ZqKJcfMtlNxuKLpGtJyXwudUUlSRUMrQdrxJu1MLVtKluG?=
 =?us-ascii?Q?xWgVr2PePMrA8k5k/vwxZOvNrO/IlRCosvfg9CC/Eecg4PhrgWJK3gjcUExl?=
 =?us-ascii?Q?XnQP8uIt6ObiqJMJM5NRqkk590T7QeVl3iuhJqi6xg6elD/SQJnx+Kvs/bWu?=
 =?us-ascii?Q?mGajxdeUsGtypV02dRCR2K6wxM0qbWdL/yCljSG2Ig9jPIrSn9l4Nmz4g8+R?=
 =?us-ascii?Q?yS2uc7y7ohKJDLeU3fbIojLWT/NgN3s3uDAB0qu56AF3J6+NHxYr2hSXMAuT?=
 =?us-ascii?Q?RUkrORNAqKqEQFoOPGDYw7PzntPjKIQuk5Ez/EqhjUBDMW6kdMUmFsSmnb2O?=
 =?us-ascii?Q?lYkLCKJYcWyiMjhfbWCkNwXCCLo9ZthjfFMX0/8ehbb7gNWmNArMQ2aRsrNK?=
 =?us-ascii?Q?HooL7EbUNYRUc8UK9QHAOBy2yyBM9iM4+HeuSmsJ22zyUXYQabmcy/6GFKwg?=
 =?us-ascii?Q?vh1ponduJJaysPFx3bm9zLcmYg2WaEmYlVXGf397O00xbRDjzZD47TBRiFCe?=
 =?us-ascii?Q?VC3oTm8nLUaoHzGOPe1laKTGr/QAvFylcHwuMk3NObGecoULSMqoyWB9EDaq?=
 =?us-ascii?Q?bvjqmfepFDY/k/ny6W/BN065G0r2CoMxcCShFut+/ChY1zRRuWKTwi1qvw5N?=
 =?us-ascii?Q?uPmdx6Cd2erwt+Sn+cBdNEopYieN0RJZxqZyLv/UXUjT47Vni80yKU8kHSk0?=
 =?us-ascii?Q?3ZyUugauwkvFH5DNsivR2spP+Ea+1BwKpBiQzzw/Vg3FLqpz/XfJk9y/FSXz?=
 =?us-ascii?Q?fFoLCeWyb+I0OvYGY/jIIgeVwpN4EH2MQeK1CPm5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f201e901-df8d-42d4-176d-08dc949fa34a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:34.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtBr1mZRKP7YzAVc3mlyK1SVNGS6lgG66hWgRi5AaA76H97t+oi0jINQtgiDkNl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

From: Saeed Mahameed <saeedm@nvidia.com>

If the device supports User Context then it can support fwctl. Create an
auxiliary device to allow fwctl to bind to it.

Create a sysfs like:

$ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 47e7c2639774fd..6781ddb090c475 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_FWCTL,
 };
 
+static bool is_fwctl_supported(struct mlx5_core_dev *dev)
+{
+	return MLX5_CAP_GEN(dev, uctx_cap);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +258,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_FWCTL] = { .suffix = "fwctl",
+					    .is_supported = &is_fwctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.45.2


