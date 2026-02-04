Return-Path: <linux-rdma+bounces-16547-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIqcCRKgg2kDqgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16547-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:37:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA94EC20A
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B7D307B7FF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE441C303;
	Wed,  4 Feb 2026 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCVFBSl7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BA3A900B;
	Wed,  4 Feb 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233670; cv=fail; b=MCiiLIWHQzw6kol6bXnCi+yZ1zsrkRd9RoGpQPy2qXMjFNSpz9CmEVrR1uCyESvMRmuvdCtci5GWy42yIn1AnODsz8C+nj9N4RgJqDYnCoH9Ktm9X6KbtJIE4a0FZy7U/rR9jkiF2Ov/NaR7KOI0arzJ/qHqDSYYJPhA4wOgLgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233670; c=relaxed/simple;
	bh=MWiYf9IIbpu4cQbiRZXMls+mHoHyrJb83ywWeuvfoJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANT3DoOn2rRhfwWydHJZSz3kvM97/2mfy6Vd5VbnDaBVyQW0GTeMv2siFgmX+y/v0z0MrL5Uw7PCvy9pwnNK9xzCUcP9eHmidWsht3qKd1d70TFtY0b2w+q/TUBehMFTxyHeyvmEVJk23SKlbySNG9fR02YCZ5HxChFFWqJWLNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kCVFBSl7; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joTDgjeYiJ/x+Amjg4xjqSirL+c5xyVpTO88N7UYci3Xt+XbF2w4b6HyiX619EY+6uGNezRkB+V6HH04QWJlpXqRbJoKjI8HPmrpwJMhqhCJW+iBz5bFlmUmQMDnVRdKMN1Mzl/J7SHC9hIYthhQ9uWUUciYZim0tZVcv+4HENcYiSsQ/0NGKHplMCRKzx8vSNl3kJToZp2zKwVHdBdEI+4JR/gK9M/QxP0+TAbXs4R55hNMUcaQUsqlQSasDiVVHBdHq4dqPwML2yM5W6lSnoS4/jCyXrIblLCj1jpgaNZj5dNUyyxfK/FYb2se9ikOrXlHdoAFkD6qR+Fzyyb/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1R40vLBuMU/jcBKdTuukHEclQRzSBHjpNxinHLF/hs=;
 b=aBc/3EoTg/auOS4ZcYf/Rnhm8o/qJ9pGe1TbxJutg4G2khCVrBfr7vUfW707iDP67GY0b0KrAoa52/KmlfcxCS5ad9kYMKBpTcEJUSwjtGLPKL+gAzNAmleGChV3PPFeBXNl70OUYUiQ1juU2OwVlCY8yaecGR6lhbfacPjlCkPqcC10Zw3u89Wgt2s6opGEDwawHxYtaXF++/6WrUh+A+8Q7fovCAU94FhWzjtP3YaRW91uU8vCtGO0U+DSWKadX9SEH9AcpE0O2NGB5G1Xz/D1yt57sJCNw3LIKPytE4tbpUxwmyHkkwKRDSLPoOfCuTwmH1+0FHs1yWyPpTUwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1R40vLBuMU/jcBKdTuukHEclQRzSBHjpNxinHLF/hs=;
 b=kCVFBSl7aoGoKfBlgMidRrqBqf7h1xOHIXePxQekmm4j7P6ZCI0lQHCzH0jJoIugIqhtnL5McsC8g9ncBdpMFNyJimp6PPTnOEIoVlko902Ib+2jrWCjNHqeIAn/6C3FJQYupFQapghjDZRXYyH0xiKIfVkQK5Sio2kWUfxq+3u02m+wAJZCRC3hrVDQEwv23OwFunYIfu4UcnYki85Z2/edjKH1tzGJhfhISdTockid5Zb+p+iWAThvUruY8M033LoM+sgKLjGPtwGGGyayT+i1T8AVbbllvrssgV2mtERjSRciLX738q6urE6TvJ7iWRGp28svP9FrEY6xzobzzQ==
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 4 Feb
 2026 19:34:24 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::7f) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:34:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Report stop and wake TX queue stats
Date: Wed, 4 Feb 2026 21:33:15 +0200
Message-ID: <20260204193315.1722983-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260204193315.1722983-1-tariqt@nvidia.com>
References: <20260204193315.1722983-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a35c564-6f19-47d1-28f2-08de6424672f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FI1Ge6rrcso0NlHwqohAcP7RDp+AavMCEDh1xLNMTs/H8F+pcU2+vmwxFv6l?=
 =?us-ascii?Q?zkCmEops4oYbQy8B6JTCr1BNcqHNTbu2mVzsZhjwpYBzvh9MslOcZ8FY9Fpy?=
 =?us-ascii?Q?cv1OVfxBuUfQu/UDSfvMXu4F9vnUORh+NJLl8UphzUzKN7J/14TMUmM61Q45?=
 =?us-ascii?Q?ycc69kyQPClO3/hC5Ydm4aZO8hlw/HUKCDbd+N2yuKRfrqWsEr03pUF4d/bQ?=
 =?us-ascii?Q?4XdwwL3aL/UeB62S/kJL7q+WZvtT99ErW8yvDX8M1jL9le/srrXX0SES7HD/?=
 =?us-ascii?Q?lq2FB9jauyd3iueWV8VRgwGvCBrC5j2D34ILOSef8ZcZ9WfuFwsl92HolRxz?=
 =?us-ascii?Q?D01oFb3FauKXkt1EY6zGYUEDquuUmPCyea6kHc0QK2mQ4MOQRNn6px+q9eEl?=
 =?us-ascii?Q?n4UIpl68Xh0Fqb99+H0NW2u4ww+UP/voYtXivIv38edYLdqTulYnUNmuVev8?=
 =?us-ascii?Q?HC8PRb4pzicfJzA8PMYvbzupI4OG5dFV+LOFrmMlK0uF+O/Z2Y2oinvpVn/+?=
 =?us-ascii?Q?kv75N5Ur7mEiVXmxRgU0noNye7fIsj+zwqLW/JiOpR4+FWoKFtQ05ltURpSW?=
 =?us-ascii?Q?0mYytAkZU8tZYZ1uGiw5L4Ji2IMsTR361/ossdYeQbL2cJUkcmV/oKGqyoPL?=
 =?us-ascii?Q?8ngEQhRRjwZR9QlF3MEvJWOEZ3AEFYkJR23XM54E/EtJgiAwWUGwqy5qX6CB?=
 =?us-ascii?Q?M8UQFi7v/NBGm97YCdMInOeVBp9ng7I9iWT1E9JopT+OI7zmrO614WTOczVD?=
 =?us-ascii?Q?zQ0awFzsYk9Bz6PfwBxv7DBjnhT29dO7BYfAaObbyhKggPgs6fY6N96HxFkz?=
 =?us-ascii?Q?6v4JSWEImLaHOqV72aMPJIpsVFvh/VfpDizPIlE5ohzhZXg5+AUIctYGTiJm?=
 =?us-ascii?Q?82KdnFK4XihD1/ZOpfNS3k+I7Zu8ZHPcEG0QmeTTlz3GRi7bdr/Baq1ikYge?=
 =?us-ascii?Q?aP1Ukb4krTc1CO2BbL48ak5YzNebEFZ0C22uKtiDHRxLlDcslGvsQKN73WOV?=
 =?us-ascii?Q?iDtPFAfF6EF7B7jOoq85bmxl9SjJaeoAh0/1KV3d21aZDcaKePBxyV4lIGEO?=
 =?us-ascii?Q?OpOWu8JcTQ837tBaJ8pMG/S4BWmtTq3Qzf+VRjHpgD5Zh0jtHv11LD/U57wD?=
 =?us-ascii?Q?saCzwAVDElirI/6olrH6CK2nbIj2coROlUwBRHhLUZ/xR2jD/uCjhf3X0LtC?=
 =?us-ascii?Q?G/QSHi1LJlsNI1Gi3cVE+3bU5cMwTIPJKvbfDOpHjtTYRLrpE+AB5yupwBB0?=
 =?us-ascii?Q?t82DQ9TWCQZUDVRfcwEG4QbFfRMbvJ7heRQK/Zk39nGzarCNY8gbt4IbW3cG?=
 =?us-ascii?Q?IVGQEOXYr+UyNV/osBQvdBHGvaLiTR2y/+j2Wf/QATsut3C6OWjrrpcQEdrD?=
 =?us-ascii?Q?Zf35mSrtawa5ueKO+yAfO9DHMdIN18PA9SLSp2J0fi3Sxd0fF8OIcXu636i1?=
 =?us-ascii?Q?oGtEfbxIaWFwvWbrKBRwSTP6s9smo35ihpm2NNFsWXcoJo6Gl6YL30LxE39D?=
 =?us-ascii?Q?HVjHWxtNgmQKVFDTV/PfK6qYUXGybnpaQfmZByyr7AyBwgWKEkkMDBQuFV15?=
 =?us-ascii?Q?441yMn8fikm/M+G4KSE+bqmZT2a1HaXzFta005cnljmOHKweAxN2hkwueDX2?=
 =?us-ascii?Q?EyWKqJVBu2VlU+xy0qNMLNBmHT2vt3fGGezy6QxUITYDJ8ytjE1yIhjLrXwJ?=
 =?us-ascii?Q?Y6ACQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RxuWMWbfhQrmafj6H7Z0qVnGWp32+EOdEEk9L9KQ44jiTaCUIje8elLqnBSAMD+RNM+sI3j68g3Xqa9/z5h+ODrDy1CFrIhfN0UY9PV512X247tq7awP2AGURL3tiYiu7U6gDRCKVPBhnZPzeFB+qIdV0Z5VE7m4mLsNhEY+Yt92SqQ7735kRUmCRl/uLnQwYaI9uWQj3YAtSXMSZTI8ffD0/P7ES9XG9ib2b3SEN6gkPF2F/gidKTpPZEMwDYAADFMET3sC5gyH+AjsQZDSihALoSnzx0zn9By9Cfhos53mBTlU7YRBh/cXQFp3wsomz/b0QxoUvwfh9yQ6f6P/L5076r9Mhi8+T/SCEFAEIlkMNywLaQ5lMaOOkGizMUSMqq5NBDRNDvySUDXbTWjJnrI7YrvMUtJVUNZ8jU8VdA9DRha3umNxvtXJmPBZmNIK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:24.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a35c564-6f19-47d1-28f2-08de6424672f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16547-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BAA94EC20A
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report TX queue stop and wake statistics via the netdev queue stats API
by mapping the existing stopped and wake counters to the stop and wake
fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 036587123a6a..4ed0449a27bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5570,6 +5570,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->csum_none = sq_stats->csum_none;
 	stats->needs_csum =
 		sq_stats->csum_partial + sq_stats->csum_partial_inner;
+
+	stats->stop = sq_stats->stopped;
+	stats->wake = sq_stats->wake;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5630,6 +5633,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->hw_gso_bytes = 0;
 	tx->csum_none = 0;
 	tx->needs_csum = 0;
+	tx->stop = 0;
+	tx->wake = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5663,6 +5668,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->csum_none += sq_stats->csum_none;
 			tx->needs_csum += sq_stats->csum_partial +
 					  sq_stats->csum_partial_inner;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 
@@ -5688,6 +5695,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			tx->csum_none += sq_stats->csum_none;
 			tx->needs_csum += sq_stats->csum_partial +
 					  sq_stats->csum_partial_inner;
+			tx->stop += sq_stats->stopped;
+			tx->wake += sq_stats->wake;
 		}
 	}
 }
-- 
2.44.0


