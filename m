Return-Path: <linux-rdma+bounces-16545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IChpNVOfg2kLqQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E74EC176
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BA4D30166C0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB53F23B1;
	Wed,  4 Feb 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LzGz9qjA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D48295511;
	Wed,  4 Feb 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233662; cv=fail; b=AQVIsUIxZxnKDPSdymAU+34VcTwe5Kv9enabXNKe2GBnKzzq9roqTAdm64KQx6KIGhOLKIue1jftUxF4490CE/VHHaI3ktBRuSiaCJWp1Z/cz3YXvO1GL+0zlRCusvVUab6ZRvXUV0h4Vbe0LSaktk0ilRH7aSIPTTbdg119MNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233662; c=relaxed/simple;
	bh=7czKWxHRQZUdIXwrGcIEQhmYEqL1sYc6VkPK/djBt1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C25QC9dDHlTFV739l66ow3FGg+rF2VnFWKzmSJ6sc5G1h9gt4/4Jhdu2I6OuqslFw1vRy329zOF5x0Eu/4wboGXEkephmPnN1tG+xUKcAmF7NCxJhaVDBnGWt3Iwv822RcOE61LTx57+aSl3J5rng6AkL34uCRU5Yki3Kt8x3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LzGz9qjA; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcTIIZveFUWzEbTvzilgiOa4+QTmFm7CLQXG+ZZsi4Qe5NC82Ef6zKabzUNhDDkvQvW6Cw1XP+Q4Xv5mOvTXlmVdrZvKjZ9UKUvVnbtRH9VzL0kkvvHivftkXEaJyWB15YqnPKea0FVDbmikEcYk3GWUKVhLVWpknytGH4NmUbaLulVmbkALuvl3QZgEBnfJKM93uQ+mdGgb/eT1uOoPyA3c5onLo8up/fHXUgA3EPFl1is9Km60UHedwgk0ORAWdMo0Ea1QHbxmZlasgULgCFVrmAs1SdqU96zGkg9BCGEVDWZoJPPnAe+9oYbUVvp6tJDeZM9pVBFEnUWPab63WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSWs+V9sTMqjyyrpkXrBXDZYTe2TWBakteDHy0TjoQ0=;
 b=vnEF2SR0DEv+8eyUKLIfQo4wgKJtIoPFhO/hs//bibTXW5EOrIdsXRa7HYyr/HUC0S0kOD4ORv+dGHzrploEA7pwDscT13h1RUIBVA6CqUWcvmhPobj82TInYWjtlccI1xfQa8naua22c2qrva1qKPJ10qQEYUkXGi1U/TK1vvpMKXOJydW+8Uui9TtkzrTMs+/l3LbMInQL5vu7Vc60xyXrchlHqb+3CSHo+A4wi1tctmcnCyARQGWKc1EMyvpLMy7CqOb4fJIVru5SLS0w10wBy50TfhOeX8UPa0Lz/FR5ArbH3JyGrRpQPuwGBUsjcbYapYj1zU5suJ4S+Jh6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSWs+V9sTMqjyyrpkXrBXDZYTe2TWBakteDHy0TjoQ0=;
 b=LzGz9qjAqazjolJrkF3z69lm0N9xCKbb/PfwFD67967jBSfceSFfxShfH38GLPM7c+YsQnFcmx0fOuGy3oUut7XlQ8X0j3LT5fGpyRFKEEUxzoBbRc2zSz67vD23IxZWJY8cPcL4Sj/VMp9H/p41MbR9d3XUE3GlujLg/XbU+xfBxx5v7e0PZsMGTmKbRG1sEnw/M6zowdMSt1kwPvU/fHINxMuBU7sdQ6vSEu1cd3+uPM+fCLYS7m+9mUzkzF9PBCJfcUfbQ03yfEghg0tdomTuhJlccO8yoH0sKGa1inhkHrDn/C0Lizmr6SCji1lHoc//PowIKQczjTEvWYZMjw==
Received: from PH7P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::20)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:34:17 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::7a) by PH7P220CA0057.outlook.office365.com
 (2603:10b6:510:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Report RX csum netdev stats
Date: Wed, 4 Feb 2026 21:33:14 +0200
Message-ID: <20260204193315.1722983-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 069bb041-0f3f-48cb-b87e-08de64246311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzPG2hxSyWMC+JcJNSNyOay8PJIG/B8OIxB17HNfH/AjcUYjmZYXHFlsfJvq?=
 =?us-ascii?Q?hhhU7fpehCV1/wn8R3ny1QG0vLRfhP6NnR8obEmZzKzJwV3I7Wgf3hqjs92x?=
 =?us-ascii?Q?phL3o73I4sqerRwA/XVKzYK2IbTksrgIAvAJSfXd+L0Vsbb9/EKjW3ssWbai?=
 =?us-ascii?Q?pYVzwWZxGngRKENTb1b5S2Ucy5EutuVtCVnfR+HnsAyNsUPwoFAWfZQng4/8?=
 =?us-ascii?Q?5+4LiskYM8mu+nGyfIvqmh4DjGfV2QjGCIDdYudDDOTc8xP8NtSAstzdEnkA?=
 =?us-ascii?Q?EVi0RK7t5pElgus2ZcoMtFQt678sgXeheOVncwBOmb4xlchu8KHx8tA/rn0+?=
 =?us-ascii?Q?Ka1JczWZRZZAfz1q6C/O2nf1wEhrfevr+ldmbRtbm9ZmAqfzeoS0ntZvd6QU?=
 =?us-ascii?Q?XdilrYEFopAb9mZBEpvcSO5JlLUVY8PrbmyQDNrKxJRaBhW77l2xjHcDx7Zc?=
 =?us-ascii?Q?W/7s8vEh0clr9iaKDD+OAfGYQcp/ZTO8YuC4bv3c4WAM14iWaGbxtMq+/C1Y?=
 =?us-ascii?Q?H82AnEznn6e+WQmF34c5i4oJDO+9dhHGEht/J/BXEPKQplQsn8rC8f90UZHe?=
 =?us-ascii?Q?2hkvapYPI5nekUnv3iPfpsQqdm5w77X7bFnKy4fP2Sfu/8DdX7ZSXK7MUIfG?=
 =?us-ascii?Q?SqnnCk9+tJZWd5mESeILSbQJpjAW6SeTZpTscrKOZlcXJZxzlnlIhYtZ8rwd?=
 =?us-ascii?Q?3f5NjauqSNwYJwcNW3Z4eFGZdWqOJg1wnCZ+RDc+gwvoUaZbTxxAHm6alIAy?=
 =?us-ascii?Q?PlVNRTZqNyjYnn+ASt6tLZx0SQ5F55qj7C2MaiOxp/G8q2x043beiSSdeTWm?=
 =?us-ascii?Q?SafdnyX1nWeKvOB5oAjMbIbTJPestJAhjm9XucYoXEuuQODtFtEcAulUmML9?=
 =?us-ascii?Q?/HnvQrRKaWuefOxEOlnTa9fw53dmFEqNNz0elbBYwToGWYzvrHYmSimpzay/?=
 =?us-ascii?Q?sEcKnwHZz1V4uVR7PH6UkVivGnH7wv0wPnxkolwe1pxFchsrNtkPGkZtY3G6?=
 =?us-ascii?Q?YY+AGrBh4jDDlCTU560iOkmukuF+L+qWzKamGJ6/jco3ZtnUUPMXzKD3o5Nb?=
 =?us-ascii?Q?avbEiYHOPKfkJ5oGw515+apgm+RDZBm2LyvPLjLzB/yQ8TQbv4CKHHy1tzhE?=
 =?us-ascii?Q?jvOZ+cCElV4nWzI5aMfZ6pSG2AhaI7Jr+UN6H/C9x8em9FQODEzWwUAB2MtN?=
 =?us-ascii?Q?ay5l/BgtXGg0kd7p9BDrl2aYYzuwxvC7GYm52LG7BYLVIltEGa13/yBT3tdp?=
 =?us-ascii?Q?o3kS3RjNPNEEcqZQPcVhEpgVTDCmP4vYB3UkeZUPzoOAcfXhWEiBcLL1RPa7?=
 =?us-ascii?Q?pFQl6AJJVWxwkLGPalYQs5ei0qXJSQejKaWz06ZI4N+fw2c2YKHetI82CJHP?=
 =?us-ascii?Q?nRB4I3Rd1bsb7j8OO43mqiYLtXcp/VN4g6cAuggLgaMN2pqmNvRM44xCbAKC?=
 =?us-ascii?Q?pd6QNxuSTXhg49D8e88KC7BPci4XXc+AolJQtIOTEwbtOkpOtKOxsRlmSg2u?=
 =?us-ascii?Q?1FMdqSNsvjlgXP0hPCJjsU6kUP/CFtiDIcUMzbXThRYJpz3vv/LS3wZK2To7?=
 =?us-ascii?Q?ayILje6k69qGQkm62ggFgWF+/WQ0EvHLS01k4mlazHbB+6vnmfdtvMKG2wdV?=
 =?us-ascii?Q?M68SHq98r2DUCqnBvXkPvUI4EQf525cMWi0HN0tY9V2jMburz8YNrYgHNBVQ?=
 =?us-ascii?Q?m+9nqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CHrxQa8SbUkMOvhQvaK7cC+aOHyFF+UiT/xZ4qVYo8Fv7prKpsX4ES1/XGxmHAaa1xmjItDkzQdt54YJtts4zUuEjPv6jph4vPw39l45kSRHXVOMWQ4+W4BzEBy8jQJuh6BnD0aK21oBKSHQHHiS07wE9sQZpmYF//FJAUbfSEcBO+j3UuPc5jTy8C9oZWHrTBd/0WM95o+eXw/wUoRtrm9ZAdVFxnGnISwyaY3CdSe8PTUDhOh7CqV1hHsFthT6BjsRzBbtLjXuyJ1eJRXO89iv+zxewQbrNmlXXGtXw4VBirEqYAkeIkcKl6UK6PflePZuoZbRzorSnuujNHXXEzwScNgk1vXtCX7/dzWlNsPOfvAkGlPs5WMtJ8CTOFft23BEsSFNR44inWfhscmk2WoixGpfOl5H1NHjknM71z3ox6W1zAfoFKSjuOF/l/4u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:17.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069bb041-0f3f-48cb-b87e-08de64246311
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16545-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 51E74EC176
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report RX checksum statistics via the netdev queue stats API by mapping
the existing csum_complete, csum_unnecessary, csum_unnecessary_inner,
and csum_none counters to the csum_complete, csum_unnecessary and
csum_none fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8c4ab3f81bbc..036587123a6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5536,6 +5536,14 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->hw_gro_packets =
 		rq_stats->gro_packets + xskrq_stats->gro_packets;
 	stats->hw_gro_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;
+
+	stats->csum_complete =
+		rq_stats->csum_complete + xskrq_stats->csum_complete;
+	stats->csum_unnecessary = rq_stats->csum_unnecessary +
+				  xskrq_stats->csum_unnecessary +
+				  rq_stats->csum_unnecessary_inner +
+				  xskrq_stats->csum_unnecessary_inner;
+	stats->csum_none = rq_stats->csum_none + xskrq_stats->csum_none;
 }
 
 static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
@@ -5578,6 +5586,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->alloc_fail = 0;
 		rx->hw_gro_packets = 0;
 		rx->hw_gro_bytes = 0;
+		rx->csum_complete = 0;
+		rx->csum_unnecessary = 0;
+		rx->csum_none = 0;
 
 		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
@@ -5589,6 +5600,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->alloc_fail += rx_i.alloc_fail;
 			rx->hw_gro_packets += rx_i.hw_gro_packets;
 			rx->hw_gro_bytes += rx_i.hw_gro_bytes;
+			rx->csum_complete += rx_i.csum_complete;
+			rx->csum_unnecessary += rx_i.csum_unnecessary;
+			rx->csum_none += rx_i.csum_none;
 		}
 
 		/* always report PTP RX stats from base as there is no
@@ -5602,6 +5616,11 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->bytes += rq_stats->bytes;
 			rx->hw_gro_packets += rq_stats->gro_packets;
 			rx->hw_gro_bytes += rq_stats->gro_bytes;
+			rx->csum_complete += rq_stats->csum_complete;
+			rx->csum_unnecessary +=
+				rq_stats->csum_unnecessary +
+				rq_stats->csum_unnecessary_inner;
+			rx->csum_none += rq_stats->csum_none;
 		}
 	}
 
-- 
2.44.0


