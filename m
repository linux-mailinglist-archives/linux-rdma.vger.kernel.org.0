Return-Path: <linux-rdma+bounces-21781-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3h8JWaEIWpiHwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21781-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 15:57:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8364098A
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 15:57:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=c+Ky7cjZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21781-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21781-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E3230F0AF7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC247D959;
	Thu,  4 Jun 2026 13:52:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107747ECCD;
	Thu,  4 Jun 2026 13:52:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581134; cv=fail; b=FSqXb8albyAm2T6cisUFZIVpoiIU+2og8X7ZEkIJnOPOP/NJWeIHGDeKC5UdVNdafVYyD5fTDFgEqrh61BwyDLjEqdkujxWyuGaH9Rne2ahBQrHeP7RIDLO0N91Ls/MurE9CPaxTDm9zGQ81MH+9CV0DG/0IYtse99A2UNsbUOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581134; c=relaxed/simple;
	bh=SKP70qoqi/sMXup6G/5jw9ua3wPAdCRRiwfyo+qzqpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M69m9mbWTbNW12+KJsciDM/SA6HQFZp69jAtDhGZnAHfJomTfLJ28kAKfzIqHpkcgmZLCazR83yrvmFSfXr0aqmyyE+HpFOhEZWMZotpSE547vz9sSueb1rcMniJxzzqSb4N+H8bI6o+cxd7GSCoyOicMvJgtM49aiOwOBRgkCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+Ky7cjZ; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybGqwUCTaWEpLPlNz4vh4E6KGT9fDbcsiC/QRP+x81I5XGEBBlnbuf3WY7xCMt2NaBez7diI0znHFtsYAPPtMK44mhTQ2UzHM28xK/HvG2WHPpPmIQ03pGEK82DAeKzk/qQUmaEriDY+wP8+SAilDFZZPQysbMxSKWHFLh2G/CiaAAHoaAvBOqj9NNFB+W8yqbY8fcqYgDDDujEJRdIMtEaXXKmtVine18Xx73Y25ZcPCdQrczZPFdXQYUjsyfuVMTUCDyfuo4HfEnSOl+XoM9FOMHTUheyl/pR9byh7cb66TO3MdlJUzf630CcgVo1xeNp/zpZv7obdWnhIMmbHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNKrBYStiWSZP+zyG2In9c8w+YSrOQLbIhHJrRpTkyY=;
 b=aT4utAlorqZPz/tZdff7/FY2aA+xYqmM35VTUKu93JGFCgka2NgOCa9Mgg3wZyY3c7K8gO6SFcByy6yns1q06UdyCQHNAe5IqFZ3dKGBmZfOYYBdSPNagDlky2x0Kla3P3yp++8XiiPfLsjadeq8JE2OTLRtcKIj6ygwJiISJDF8CqaCf0RmusF84E6d1K8SbWipf+nucFRTBLwqEYkhjYasX+piCYrucT66O95lPgaJow8rWY8FH4c/0uvLWsWOGToLQ98HsR6tH0prGBl+KIkEbF8CR5p1MqHeHPlkT29RcxYgsMRc/tQEOR4S2KvlaktPAcPK5dOtnybnGPhIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNKrBYStiWSZP+zyG2In9c8w+YSrOQLbIhHJrRpTkyY=;
 b=c+Ky7cjZgNQTkrcf8xYxSrsMMr1atCbRcWLQhw6vB07k6MB6+XtgfUxxcYLXBd9VHBNHcgbTqaLidJRNPuaca12hfdhnCsoNEkbt1VwO7cmhh1XhTMfyUzPLyPzGq9/7fTOsF5kpKXslSUd7Sm7kX+RSwZcgwyk1WwsQQuZDzJvGwOxFwth1d+ozBeC6JPcg5evzvljxMC/1UgUO63Q8CtjkF3gceUBBWX+qsUWMfpW5DMbqkPp+OnHURKW21a9goeCk7CgVjYm3gVBcfQemgEPYoJyWeBKKVrHHioZH4buyIsyuGXBLbUr7lQcESkkZE6p/KvYOPz0ch8IITKRXKQ==
Received: from PH0PR07CA0072.namprd07.prod.outlook.com (2603:10b6:510:f::17)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:52:04 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::35) by PH0PR07CA0072.outlook.office365.com
 (2603:10b6:510:f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:52:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:51:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 4 Jun
 2026 06:51:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Eran Ben
 Elisha" <eranbe@nvidia.com>, Feng Liu <feliu@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Simon Horman
	<horms@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Eran Ben Elisha
	<eranbe@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Joe Damato <joe@dama.to>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/4] net/mlx5e: Bounds-check stats_nch in mlx5e_get_queue_stats_rx()
Date: Thu, 4 Jun 2026 16:50:40 +0300
Message-ID: <20260604135041.455754-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604135041.455754-1-tariqt@nvidia.com>
References: <20260604135041.455754-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4800d244-2661-4c05-0b42-08dec24075e7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RzErhIUNOdv9AQ8vUJ3BDBOWaaAdhMw5WrVsgs8k5KmGWUc6UPGAUGUzwFa/VV00pkBzbVAVL2Bx8t9ZbldzxY4i+UpxWdwmg24gs74mc9l3znyPnGd1GqhDAPjfL5gCJt1y7udqynM/G3q0wAF4jjdSnZnCQQA538dCOEWdcZWw/0WWplEVm1KM0BBt8wXG8sv2Nj7fiJSmvq+56paUuziyE717btHhTFGT3GVj/BVZG7cqv9iA34pA1O4yRualywp1XowOD+12EqDJYgGElVyByHuz5c6iXrNoom3oZ14oSpj8vdjVS/qFpXvc35ELvhd42pdb5kShhqS9TZJNVL+uRSGO/Sv8KkLzKv0SzYyv1p2cY32c6Xfo2R1P1UkHR1QBOdl5YTdPSDXxqS3AtstMzKZnh9c3RwIGazzQzqzJMu3pA0lxEbfaEk58rdHDvr1EHKVLGSprtt0iccgez9NnqrtvggzVbHexi7HIcdA804GaKagmcx/ALkTaZ+gBiXcXtGdeo8mxB8J2sT5KRYahyTJqJQY3qrnJQFWEXuodcaiYpkGu2VXbl0xwgLuo85tNvCBhlj5XeHN1vJqDjr9nlzLR/N+pfBLJwp+eZcLFVoXON98+Uvu7JeJE9Bo5bC4Jfv9000D5thcJdIPme1oZJyZ3WS/pIvca29jDSm7lIrCv4B/wtVBC+ruNK5ByHnFqDieYm9ZHIMwJ8zrRtrKUa05Q6sONfraW/7QweTQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BT7rn1gwGW0ohB9gtrQxUZO4j1cibHCVXnrf6GvbPuvTzY4v5uYEYXC4SURia8MYW/84s+klxVgMahaD8T91g2CpCnMZh043CLsmr247vP8wxVABgmgUn/gywLej11iYFaVy5z93bjacDUskFx/yqjnVDkEFwF6/DQ+1PlX5QvphDVAjPXQumdE3YabzbeEqDgnIA9N49FGYgTxNvuDejmt9HZucnsIN4imST0IrA9geqyZIQCs+AtBnzzvzMopp2A3xhTj5/nOuI0F/CtKKBbnPtkvSMRAQA1yol8q46fqeKUXA7K4rtsMfyMJVOh+v2byUwSIjKqpCqQ4k9Hd7HJTaBpyrKBDEwMYFiTnEpSPjpnCkShW+GLBUeBBRIWRAlvBfUgC4WJP0Xk9V0L4hrgKakIe1D1juUGfs+imDPdEFPJemlWOUmFxn7kWzmmJO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:52:04.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4800d244-2661-4c05-0b42-08dec24075e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21781-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45C8364098A

From: Feng Liu <feliu@nvidia.com>

mlx5e_get_queue_stats_rx() is invoked by the netdev stats core with
an RX queue index 'i' from real_num_rx_queues. Today it only guards
against priv->stats_nch == 0 and then dereferences
priv->channel_stats[i] unconditionally.

During interface bring-up channel_stats[] is populated incrementally
by mlx5e_channel_stats_alloc(), so a concurrent QSTATS netlink dump
can call into the helper with i >= stats_nch. The non-zero check
passes, channel_stats[i] is NULL, and the dereference panics.

Replace the non-zero check with an upper-bound check against
stats_nch, which subsumes the zero check and prevents the
out-of-bounds dereference.

Fixes: 7b66ae536a78 ("net/mlx5e: Add per queue netdev-genl stats")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8f2b3abe0092..42a658402592 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5489,7 +5489,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
+	if (mlx5e_is_uplink_rep(priv) || i >= priv->stats_nch)
 		return;
 
 	channel_stats = priv->channel_stats[i];
-- 
2.44.0


