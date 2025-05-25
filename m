Return-Path: <linux-rdma+bounces-10687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B8AC3427
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8139718868D6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278C1F4CAB;
	Sun, 25 May 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8Rt/0gK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F711F1909;
	Sun, 25 May 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171768; cv=fail; b=r/g+95UxM6PsTvOosxjMk7wHu7iBkJY3ONCstuWpjlJAAVPKHdryOH0wPaivgFubYz2YxigOVm+P0T3RBeUQOSChm1okZwk3SfUy5O/DqLnhAtdPDWeOs4mjMSNv1bgY0w2n4uWh6EwLfqXHkbE6l1EdpsYYOvlry3Io1MXQ4Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171768; c=relaxed/simple;
	bh=t2Re+fhIG9Vd11xpR5C+NQ60x1bVgpdcN15CB09WaII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddnVjGz82r2w+vwqQtaj/mdB5g4gs48wPqBV5d2RPZkZNkV0bPxq4BeiTHbB1O4fz1+9e+DFH7g/ZWlZYZe+jyo9+j/vs6PJGlUkCkKNFexFbmSrd3v3iK2AW7DUMN1PV+4VF61AQWkhqjKH7MCt7zvIKD5mnXm67txayyo+PRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8Rt/0gK; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb5qpaCEqG5vc2JcQ4djW5Vq9Ao5wI9t+XmslxQDzWe386qziFjkIIZT8d27iBYelSjJcIP2sP+9oH47uDQ9mFv9uNty7LLbtTKF023LMm8brqVAV+8GSo33G+1789CaBt1ZioLkwyXjCv9C3rRHVLwt3TtyxQrDdf6OgkJv7n6SDsrcu0OcZMaF0ulGbDpVMbFQ7aWmaB8y0jhi8s4yqAE19GQlA/Yj1tkEYa22PbNG4U2VOLSRATEUHhYnDCtpu41Vfbl3MkAaWboQZArtTGgIFO0pAg4Ew+eBRmz8cfI9vkhuMmnXQ7CBQsHsScBAthDPFjWCiEmCu1M1aANZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u3ILOtCcE65M/+t2HdomvIArdFCwRvSHHk7KFMhcS4=;
 b=jrzxWJs7yUnxgJLxv4iHq6myJT8UgVqhZU20jEVFwKsZb9xgcWmmBMSp9cF7zpldbAjKak0tIr9SbF3fBHYeyFCHkp7Wjb5RWDIoovEJsV01LSth3MoV5gVLOzXV8Udhih1Wg6IR54y+BEkSev48tf2bOjzh37nyUMJa6N550ndkEw0V2AQDL7mCi40yWHq8YM5tUT9p7CGvcshwYKyxNnTdnnaI0Njfv4m0VDvUTP8/qlh+8U2JfBF8TO3jrez/UtFECMFLNuTHLfxbUsVn7GlvknWzEdRfnySXkwNtQu7GGKd/F+tCJNiBtjAIeEiPFjsHf1k38DVyTAkMLSE0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u3ILOtCcE65M/+t2HdomvIArdFCwRvSHHk7KFMhcS4=;
 b=t8Rt/0gKzi4yGnrpwLJcCwKRJqOSFtbDRIzI3Mil0fnt1vRQEHi8B0pThc6WXUvhLwzs/dmzyOq10jdP8yY9desLjFcIgAA844WgbU+fUDTFgxGzpAPVrNBg0XDh688Ve/Cp8u6ZxgSCjPc35I1aAhmlBn5xWx7CUghOGy3O9wtmS2P5nt3bMeqz9thGph7fePv8kO4Uz8erzATs0ghu98LY0Q1PAv8FTmHFhl8KqRepHo94MDHNnbkpFOgMV2bH5UuvlNgarx7jQyZaT6tHW8G2CrLAtNA34ApTN7RKXFFPSsx45pfMUR9MvcFf+iCz60bLo2fUGSvXAtjBt7w0DQ==
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 25 May
 2025 11:16:01 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::86) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 11:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:16:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:15:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:15:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:15:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5: HWS, remove incorrect comment
Date: Sun, 25 May 2025 14:15:10 +0300
Message-ID: <1748171710-1375837-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: c750357e-7c18-42c6-106b-08dd9b7d87d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M24HYhnlgYDcYBqBG6QrVNfsZ57IklNHiRdOOa7wPTzoCrGszKUjNR5tgNhG?=
 =?us-ascii?Q?GuQ55b25A43QuF6mkIlriqhylc2GG72kl3pNWDPs/3T/D3rWGM6OzPO91MHR?=
 =?us-ascii?Q?2cim4xM6AiWAyXUSbuIt4LzNzcQWZWJQ/ZRsjeCTj7M/VCzqBpwovCsGbM76?=
 =?us-ascii?Q?3KLrBcDzAtyJfQiI7PEbcvt0xaBGtBgcBp7rqFpLuarxO/Q9DjxvwedJxj4e?=
 =?us-ascii?Q?3MMakS5N5+klKmjELfKjTkerLivSuBWSEtQqLBKTj6lR/KH3L08rZF7M62/y?=
 =?us-ascii?Q?7V7Fbj3a0Ua/r+X6X/hhfJKcjDy/HaF4sim4i33LZcaHvWEIcUgp7D8Yh/oS?=
 =?us-ascii?Q?UPsjIkqZmLuwkoCyzRtsp2b1QekcxgsA8O0RvstYuwUFh1aNbtorSywgwDtw?=
 =?us-ascii?Q?71qnHz+PIxl/5g3DQELC5pM6kCY+Gp4Pj36v/bSZ0ONJY9hmzDQt4WOWhY8R?=
 =?us-ascii?Q?aluWyBt2x9pvYF/owivk8vFUB7+twKCs/xAjmxmg16Jt2EiF9pp1kYJK6mlw?=
 =?us-ascii?Q?qFssYAGcJ6RJQ2QFVHdm7Gw+Ei9qqpchOjfbf+Q5xAqX7KPKoidl81LaSuQh?=
 =?us-ascii?Q?mTOqcFDdNNFHFjbDDrMuWu5+2k3tWD0WyHaalD3J9XMfcZ8hxsLmpce0mcRN?=
 =?us-ascii?Q?2ZPlvTi17cyMtzRsIZTqraxo1vdvifyWrzV+s2z3OBLF3Whdgb71erUDWWMr?=
 =?us-ascii?Q?vKlc9m1sRp6GCoKVeEkqGirL+ebiYKlFtYoSZpDBezazuH5rGnVks9uAFwNL?=
 =?us-ascii?Q?goXk/TgCjC60h3GBGHdGlwnXkI3WUhkpaWk0Ah7aiEQSwKENuVU/i2Hsavyv?=
 =?us-ascii?Q?DCj7FYKKQP0m3/8mWPeFEjzI3C0Hm0p9gXx9O5f1lae7CuC8CWfA+z750SP5?=
 =?us-ascii?Q?CJvA50ic17g6JvPFQKWoq1DHR2eaLNHMPSawjaIGWIxQNpp1roRDq9D3IiAe?=
 =?us-ascii?Q?72qt0Bi4Gs8UbVT9yzjzQJAFxG9DR4FO8gj5HV0ep2nxi9lHPflS/WeLlrqs?=
 =?us-ascii?Q?iHTuhd9Ss+46YbJ3VVGxxefr8D0k2z5Sf2uKRw6rk0wN9Xr2wwdrW/KGUqug?=
 =?us-ascii?Q?32AMLyoE5IOvRWXvxwff7o6Mz4v+V8xuCKXcWuLs1pLQclFdh2P700KNBHcI?=
 =?us-ascii?Q?CuJiZmKdBAbRsZuwpS790fgGxtKGOQsoISECD/SyCO3TRol6yVDgdAqfRpeI?=
 =?us-ascii?Q?vAETfpX++ZZRqLBZrgWvZAOe9o5384Oa6j5oAw1g12ARdGRRJsdCpOy3EAn9?=
 =?us-ascii?Q?pUtI0HrDKAriJDcAoci1n7o0Ngf6DxNjY8ZVXL1IfLAfmWCgbc+ph3PDZnYp?=
 =?us-ascii?Q?NfK2lo48/hOf3aNJLci9GbXwxa11uuh1MpQ9nmpsUdlsk/bTrtciZ6+PYqel?=
 =?us-ascii?Q?PiZ8xDie7hcQTwpdh5cnXnSQnTSfaWUVLEJkdtCHuoi8PGny8JEsVPZO4N9l?=
 =?us-ascii?Q?Cg+17bZynNW9gdllrUs5AdBqmaPPy4WjHA6Po3E4JdR1X/l58nYw/2f+v2h8?=
 =?us-ascii?Q?jN3ctqCuXcjcFf1JqLfA181FXDwv3bG5eO9i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(30052699003)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:16:00.7249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c750357e-7c18-42c6-106b-08dd9b7d87d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Removing incorrect comment section that is probably some
copy-paste artifact.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 9e057f808ea5..665e6e285db5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -876,8 +876,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	/* At this point the rule wasn't added.
 	 * It could be because there was collision, or some other problem.
-	 * If we don't dive deeper than API, the only thing we know is that
-	 * the status of completion is RTE_FLOW_OP_ERROR.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
 
-- 
2.31.1


