Return-Path: <linux-rdma+bounces-17123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAl4NBeRnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5E186A05
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DC431F01D6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E33803F8;
	Tue, 24 Feb 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwF1lWYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC7229B32;
	Tue, 24 Feb 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933667; cv=fail; b=XQXnElco9fwvROl1kgSwmST+clVA0qKRosqjbXST7IniZyyTqSg0fZME+MyHo3IJPBC5zG7auh11+j2ewfcs2Lb0D3LpJkKH19TLA305O3F8T6M6nSpZU1kFKBfUuHzEYpH1nYgQj7p/M306zSolqWX2XhkP6W4gGxcv1P8XW8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933667; c=relaxed/simple;
	bh=0E8yYmIbJ1hL0/KDNvYgCdKClm7FW4ojClN9hKm5xkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkzTJCcF93fXxkBZdKYcF/wWe8LsQl+taBoF4yPnPIcme5vbqVsBF/nuf/kT8ahlkTytAPUnMaUbPARf3WTnfLUJmzWUI4ZJfD+agObYOVBbOJaHLQENKzC6Kv0vYcIxFyb9JEKuomx6YEma/OLh7TmQMUwgu+rbg1ymSPlkQHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FwF1lWYJ; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVogVlatbVArmKudddJGPel7bubIyaIxhDfWEQClCfAuSl913KbVVKAXYYHwKLSaoeJLQV6md+7cituQxFNIbzacUENdRJtZ9LEKjnl2qmtCThO2vpUCpTs4QY1xYIpcJjhprmUEfNvUoQh7sREk1/B69j9o1ibQi11ySekPiYqKB9F27Y1jFevC7wP/bpa/EruHFkOqOZYBJNQg5CnMZ9mW7CIRiMXhtQDT3T1bnrcu2kXVzldTZ6fkLG5xpe/Wk1h3uidj9+NGFsz9QjO5+L1mZ053fjljgZGP/gdJAQ/hAAhMko/1WWErPI5K/vqmdOaphKidCZJlNPTo+40SRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdGYsUpL2MA7WoR/N4wlsTApMGnhwf/tIBHR9YwIGGU=;
 b=n53QFzSAJPvQVPrCCUY+MlF3Q4zIgkcNu2byo7KAifaEPGoc4vBz06VYQxH/Ngrb+KyAzN5zmUxRzkzJ8beCalC9PfC8OYGpWyvu0TITWF8rbde5HaQp6KnwLtnBDozwzth8Am9KWt2Ncw6U847BnyFfyoVPu0Xj0TVpV1PoUOfKU7JRrz+5FlWWfIElKSjGZt+axbsVflDFAw/+WSqxCcM44/4YUMBWxlZDQ8m14bMOTNaDZT7aLdZzo1zBkxShVdd9glmoxfM5Dk9v3CC77gNbR+DsTRJUuATM7gIReBQKn80627gUm/eEHLalgAprZRHB3kqOv0T4Fs6GLb3QSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdGYsUpL2MA7WoR/N4wlsTApMGnhwf/tIBHR9YwIGGU=;
 b=FwF1lWYJyjZp9W5hZTb8LNETU1TcfsGhVnjcGHJiJsINiS6o+AZubbpYcjYt9cwzN/CenamhEp5pUHZEhXe+npnGOsGwCtV56lP4cwJwzp4smFhfgjABw7zUlXXxKtipdD6HyzB0HeSGN2gUO8Xa02Hp2flGs8EMHj42JhKHq36jNH2FCoCKkNvkJsnek9sg0iX7Ejv27WHrPjCFMJPG5FV2ycfDdM8seEvrjzXx5YMaG9eh9Cq7/Nf0KUD/cMI0r9EdsKKW7zuvBNqTm18tbnMA3vPS6QIoR+M3urXqqif0clBoXprsBZ4u9RjTrQwla0yvSC5fLg6VH+dDJ6jT6g==
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 11:47:41 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::7a) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend
 Transport; Tue, 24 Feb 2026 11:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5: E-switch, Clear legacy flag when moving to switchdev
Date: Tue, 24 Feb 2026 13:46:50 +0200
Message-ID: <20260224114652.1787431-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224114652.1787431-1-tariqt@nvidia.com>
References: <20260224114652.1787431-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 004ec1be-8c9c-4966-f3d7-08de739a841b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7N/c/A7ickYsFyY81l9A13jYVnbTCo9cwvSmynvQqcIHL71Z7AXUl2HMwTK?=
 =?us-ascii?Q?w4P2/wug996XA3FxR3SPX4UUpijG9bDCwqxPv+SHhy32vGcV9TLgd2dyaDkc?=
 =?us-ascii?Q?kYU9wwnzOw0yto2WvD7NTemFakSAOKY/FfTyQncptK3JkJY3GG8jPcCBQcEU?=
 =?us-ascii?Q?aZJ18FJVqmYJWuKMT3w3ILbWhnRqIcWuQbbswZQAaCeGmn95exOl6H06rOls?=
 =?us-ascii?Q?IIGpjrTFBSSLoU9ywqco+hJv3yMhDy1K74rqFUDQ+r9VF4t1dTyCrXIgu39G?=
 =?us-ascii?Q?IzEKtTfMgvXYzCbKk6J/Vjm0Ba15DanCtbIQK9mBd3y+Cwg8mI9JfC+6Mk9M?=
 =?us-ascii?Q?FRLDaHvoREo7FeN0Qo5ri6TR9oEq/8XGwE/HWRqAmQfEykzJ6Hp1V+xUwitY?=
 =?us-ascii?Q?NPY/t7i4tqBXR8Kojc1PEOy9qujQIHR0hX8OObDakpKKR794AAFN3Gl88rWW?=
 =?us-ascii?Q?9jTDM4En3EFyLG77+1F5TxXA6e34KH7ZEkJa7pli4u/Ps8QfL0SNu86W48Cx?=
 =?us-ascii?Q?PpzA7CGtmVR86mtwjTRWYBpjbh1SNqBFXfvR4qPOtW0Q6+jDDuml/zuLaBP2?=
 =?us-ascii?Q?RHii9b7xIQ/Am+PPeDjcZg/ANstlxIjsOlnIsAiqxqgpe6QImj8+2Q/nyb9n?=
 =?us-ascii?Q?QFx4NJFvvNH6EmyL/yi/N+Ps6VdMHu8lc7LxN/N7pnTKrQ2rro15LPxi+JmC?=
 =?us-ascii?Q?466nmOwPDAKeJUPQGV2wrVp+gTT4e2IAoMeJtyC4g+ycWPUAPV8WiADvvtUY?=
 =?us-ascii?Q?2CV+aYJWau4iXSVnVNHn2QIwQ6gsqhjWw4cJFw/nMK+VDR0USjatv+0wGLsi?=
 =?us-ascii?Q?49Qx9cD/1fov4B2j/WUE1K02u81vP2ApwdopXPmAWDqDynmZKhJxR2T/Eajl?=
 =?us-ascii?Q?rIxgztuLJ65b5tTSMrJFB9h2Fbl8/q6cBEvo7+3C/TvqETyE4vjpWra4sMIR?=
 =?us-ascii?Q?rXVysoBBeAbmtxGQd+Taxehl8WJdCtrNY1JMvQk6Q7W2PIi2vKWeZ2ga5GqM?=
 =?us-ascii?Q?1fOdk/Fbv3jRYcMEsMn8y69vk3W7l7N34/U2phhikh0cpCShSf5VPEnkslRF?=
 =?us-ascii?Q?qGtT23Q7JxrauOKQtsQFkfAJXk0gOpjSHvAGo2sX++Q/WQ6+qo89q1R+6SGM?=
 =?us-ascii?Q?efkQhyYwUkNMss3DI+MyW9XazLUOe0VZCdE2t31w8ChjowV2fkV+rU9Wb/g6?=
 =?us-ascii?Q?xst4wgtHyuay+qZZILYGR8QB9kIUNvhh6Jb0ZH2ySrbMQ6PH4xopSY0M+a94?=
 =?us-ascii?Q?fiyvMRuGxMjlFdK4mf/Fki0HufhWIi4AsjFg+LjhWj0WFE8X0+Ipy+NblVJg?=
 =?us-ascii?Q?wXE+u77jpOFCgHHylGM1/hdCc6JBri8JHDBfdWeYvKUocK7Uo9BjuyhIFy2h?=
 =?us-ascii?Q?LhAYxXL7nlyTRFVtrDO0N80Gb9qDV6XjwjU5E5a/aTol8Ba00tZMli1rhbMC?=
 =?us-ascii?Q?szwsU4EoG3+cvefOkJfBBR1RtpkPDnd41eNf/uxLpHQi5Hz7/+s/SwUKUcnO?=
 =?us-ascii?Q?8j7UTmeTpvvqxcmNZZn0Q1bUiPsT9nGMQbpeLK8Mx7+uZBZAytBtMSuUj8mW?=
 =?us-ascii?Q?o/ZLZ6dKlW5mjH56Wqea3T3NypX/h9W+jsheK31JOMuviAHGaus4s8vZrILI?=
 =?us-ascii?Q?5xATJRCcykhfzTYXk/w6y0L/YVsSy1bOf0LnjQRJ2hOUOT+IkGtDV+7OLjUA?=
 =?us-ascii?Q?F3n/oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	olhUa4z02LC3QWatuMWqW8+FWDKepAu2z70wcK9GhG3k/rMmgeZjyBd5BQ9l88M+FOsKboFCqtSTfZPSZaXKfvoULC99zpWQ+0cC70frfPNEVX72b9qwEAqPeGcHCz9OJoVRg+AOQqaDxQtIuZRi6rNiaSjEvyRTyZS8OsEc1y4668kryEcPtJHtStuJ/W9+KXNTQdlIxDebVgD6TdroqkQPN3n+C112BgddizUAbm0ePWW0ROxiA2M3cXURVEQYTepZGqF8SGzMi4nQgbs/DYP2j95Cg7BDU4jwqiblJ5yzsJCGeV6q8XcN9ER96p+7kxKuys5ekqfC6012wVCw4ShRE+02Ck2J9iAcX8CqlcUppmO5YorqsmxjLAI6hQ/QrEhAIT796SiSMhU4IO7GipbTWFb8JptRmYLPb4VX4rKamhxYxKl2DRcfIKznL5db
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:41.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ec1be-8c9c-4966-f3d7-08de739a841b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17123-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3AD5E186A05
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

The cited commit introduced MLX5_PRIV_FLAGS_SWITCH_LEGACY to identify
when a transition to legacy mode is requested via devlink.  However, the
logic failed to clear this flag if the mode was subsequently changed
back to MLX5_ESWITCH_OFFLOADS (switchdev).  Consequently, if a user
toggled from legacy to switchdev, the flag remained set, leaving the
driver with wrong state indicating

Fix this by explicitly clearing the MLX5_PRIV_FLAGS_SWITCH_LEGACY bit
when the requested mode is MLX5_ESWITCH_OFFLOADS.

Fixes: 2a4f56fbcc47 ("net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1b439cef3719..9d51d030596c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4068,6 +4068,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 
 	if (mlx5_mode == MLX5_ESWITCH_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
+		esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
-- 
2.44.0


