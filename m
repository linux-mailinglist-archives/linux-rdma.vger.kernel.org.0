Return-Path: <linux-rdma+bounces-16546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLAQJtafg2kLqQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:36:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B7EC1DE
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B629306640A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4D42849D;
	Wed,  4 Feb 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pe2LaFPi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7251427A04;
	Wed,  4 Feb 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233663; cv=fail; b=WvleaV0GIbQhie/cyp3L6xloY/8e2uYtdrisJ08t60nSukaJvCXpRjoF5YXxsCmKFPz6+Cgw9alqReamQ9aOE14FumYRNxY2mzI3znkmiKZRYn8gg6/f/unnR0B8Apu2MmAOCr4Wy87Gq3T9AxTLSM+Ait4+Q6mqLDfjvcjmgBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233663; c=relaxed/simple;
	bh=fZwNMFah0hNJwwS20cdUZVxdQBxC5eUKVkmCRIO1/QE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpuyYvu7lCZy3rHUbXC2XN58P2rwCkmF7qSAUK4Bqc7jFow4C+mB13lE5XxMSY/5GfSIlrIzAxIOsP006co+uHQtwlOngf6tt7jiIzK+2rve0kutT9IzoHEVBCj1WR1blXZYcCnc2yD+qAYoYbC9oW2QfKczZjBMqB3MHx5C9fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pe2LaFPi; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzMnOhuTt/joH+zAz6kitzKdXOdegVPv8fgSYs9FGv164uE0xt0pS/vrbr94DrwU/3m240j3HIzjX9PMBSTqYdbKqN7LhEV3DcXmSJT5SCdip7AoDoRLSS1vh7wmdC4Fa+SX6TqMbdlsDSLwCoSGVtjuoewzouFyudYsPeUFi+9OX+m3mLgEVVIHgHLzyPN5rNBwpWvggYC6D2s1lLMwQem4YOxkR0/IxFiVvC2DIph+foW2zDs1rQLUAr4czlHW2EDBYd0WukZeWoI0yXKl+I2ygH4RDBzm5njF5JkIDjyQ5DBI/92dn3I8fet7ffrySSGAKs5p+rk4eo01KY1B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to2f52hgAyOOLLNBgDux2bl041JUM4hBsW6GfW8IjHI=;
 b=I9B4adw+x/g5lFrtpFJ4ipPayPdrrlXtiO4DAMi/xgmSxNwGwd/9jDF8n8Vrjl2KPhHuPbKRe5H8ZlqIczsmGNC2mun8P6uUmeQoAPfgYBTF2OiPj9IBSVfnpemK2KLmhlCxcsh2FDCK6VkxE8cGuKfmtUt5wr/P38dhM2ErZC8CW3joLjXsaHVg14pL38c4w4PiEoDT0rnHkl17UIe3mnx5eDqkbrRDqjZZR3usSTws+MgH7kTbHRFmPM8tA62W1OgeZcS1GWKfE3mfI41jOxIO/tPToaFImpX6yiiT56e9b9XHBG+C/UGX2hNJTxp8ySohTxHnu+hNQYvzbtjp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to2f52hgAyOOLLNBgDux2bl041JUM4hBsW6GfW8IjHI=;
 b=pe2LaFPiwWfbykygjXWsRQkDksXnSZsHcutdni5yLRoI+20cqoFrWrpRDxrsHMzKXJTGZrUVPF/2IVfu1L+UbI7WXrLwm1bszL+UdHTJHQsfGMvcGgbrzDPl3ZG/mmV45RINnm/wH0xI6oIBWn9n9KvJCrtrF3SdwsSK55vf5jrWlftosaF5C8OZqy4LfNej68biciTMWe2pc4UYb1cuLcEmAVqqlXdiqUgyognN2UcQ+Nte0/aYaZ5fIhrESH3cW3yhBHnuQixQcXA176qzMVMOdw9x4ym4wi5TYuBaf0bv2F2qfMLBh+foaeEdXR+PrlmGpSlezDzSmY1thpqmhA==
Received: from BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) by
 CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Wed, 4 Feb 2026 19:34:19 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::8c) by BL0PR0102CA0003.outlook.office365.com
 (2603:10b6:207:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 19:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:47 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5e: Report TX csum netdev stats
Date: Wed, 4 Feb 2026 21:33:13 +0200
Message-ID: <20260204193315.1722983-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2940b6-9ad7-47b1-286d-08de642463c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcG/ywE7B9riGaeVyui+iqKvJLdfDQM+AW2nFqhIrYkw7cSJXcILbdi41kyc?=
 =?us-ascii?Q?VM0rXF8XxJ0/oX/JF8D4wTIdf0AnMvijp0kN2aWGQIpToHSjMIsDYyfN2w4G?=
 =?us-ascii?Q?ZnqIEfZYubjn7r9R8tqMa0Rtcs0+eMR0EZ3B0bQiFAkwk2CAJJ0asWI4NYg5?=
 =?us-ascii?Q?7oQNZPALznDk7jHIb4+vURZecU65VmxytoPTfn43px0ofehioeQ1JbeTqvv5?=
 =?us-ascii?Q?I3XVdvXycxSrqWlUT8qIL+chPCsWZQfq25pfYpCE/Wv2GXCBwaKcCw4m7YAm?=
 =?us-ascii?Q?mNnMeIxrfS4ShsT4/7MOM7Z8OKL89cN4kUeadNVxcrY04FNwDM08J0nBuquf?=
 =?us-ascii?Q?ewf200Rayb1c6ptO/q4l0+2fTTJI6Ovab9ceSh421oIXAyK9/N6NGEj+rton?=
 =?us-ascii?Q?mn6d+6v0ekDQLKNbJij2LKnWy6YBuwXR/hYLPKCVxkHzyc4XPwk/gVYGY/W7?=
 =?us-ascii?Q?bkyTaXoWV8E5DVnrDWX5zCWRicUmixOEdZASKlioZZ1uip3kjNmnPM5HpRs4?=
 =?us-ascii?Q?i0PQDb3YAIcNn21XaIFwNM/u+L7k0FdxFcrgWIswjx4rGffwG926UNxLVpAC?=
 =?us-ascii?Q?ayIgHPGPLaL+1vAC/GzwK+a15ERDU8/CjEhiqhMi6Hc2pnVYkw/RklewwLEc?=
 =?us-ascii?Q?h9l49JmCJDxOQS8xW6HJn6r80z4s8lHynPfmSykPC9MtvcDj/1knh5eMB5Js?=
 =?us-ascii?Q?X03M+u6YmS2w1Gkl5FYYB5hP0zIKjKJBKpy4Xnfv9F69Fkp6x2CSQscrs0Sk?=
 =?us-ascii?Q?rPiF+1Cv/g4awjduiz8nSKImM5h94niFKQIXYMZSO6E80WMUehMJMXp96nFI?=
 =?us-ascii?Q?QSsrT3ZtnrVizGlpHBOhx0I5ICcN+Igi2s9CmlkAWyhmiNxPxPhhsnTfbaqV?=
 =?us-ascii?Q?JXarEhQKcJANAryYjUlmc1aP0NXJLhJVEeyWcqcWMGA935OLYJ42n/2BiBK9?=
 =?us-ascii?Q?v9J9rmzLY2MWnBCX3szt18C2hXtmDHld9wmt02+evThHtMMuQ9wGvXP4CdnV?=
 =?us-ascii?Q?ny/6iIKd4D3FggQwr0YFpEGfqRmkNdIpxky4XDzaneMT5cSfiSefCprFItM/?=
 =?us-ascii?Q?7Ge8laGHfMDv1tyN5FKHbQrTf4mfamQ6U+7GZE4cSB6+SoRuGz2+8/R5u1BM?=
 =?us-ascii?Q?00m/AehQl9Vknrv+5pbFacVuIVu00tMN6jmd6BwH5LGJD5Ir6JTk1DPEPXy7?=
 =?us-ascii?Q?z/4F659cXFp24HCklDP30FkHOzxdR2E+uRd0GKQEGZulVuL8EGhxMlts9Pff?=
 =?us-ascii?Q?fR5uMTQx08GHB7xBcM8VPzvqvwo2i8EUV2/1kOsjjWGPytwUgileObSHH8VM?=
 =?us-ascii?Q?tSAje3xYGlPduVDav5Ldj3JAFtby7lOuLXqhFq6gHY4tABk3PeRY19NjDvcD?=
 =?us-ascii?Q?aqlz8bOsQlNdH8FwhK1PCun4Jj84rP/Uj/b4JrLosDwRXUNVcI2SUSCgpGWw?=
 =?us-ascii?Q?GO8q04bVwnYCDhYQMNKz60aOhjZuSCSiSlKib9xK4W6am9vZCHvhlEEwYSs2?=
 =?us-ascii?Q?eczcf/1DzmOLm+XDs4KYBthyW8C1kVEGuAbgJ+HN3/3MWxabEJNo5vpZ0bwu?=
 =?us-ascii?Q?WsKqAoKrUGrUunSrDwXpZzByG7xN6UHWE/KE0w0DsOYfeoDmvqKbOSEG+Ewg?=
 =?us-ascii?Q?/c9J8cMV4K6aEcoNu6wZ2PL3MVSXjuPNE9RhYqhockzQJW7nmtpDYDOc7CZ+?=
 =?us-ascii?Q?5kzboQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8mBaBp9Jv/PDOMPNZxe8I40VVOjIwBrj8EyKaLDzFWIpfGnHoCh9oXz0iArkBPq/16+onhWJulk3+qEpYnEeRD4OMOSfelOaSVlHRcLcEkW0U60FGKhrTNKJLyAqLmWicIdnclSw7ci9t3NWSu5TCTtBIQk2Fkx+MM82Gw/Itxh53Ag/8v54v1SZv2FQdFemF0PK6pELH+iFk8n51xetZPbQqhpaOWXtzFZi7G5vWvETAXKYyhIoRGDwVIG3fNsrmi8g4qcL1ASF1/0HuX37FLQCBq1wpbfIVjEP1BKzZRI0cSlgBPnjMiKoTpuyIhr5wTB6WdZtn3JRGG/xsFX6QcmnPyaxm1Rn0Xod/u8IJF+JmiyYpbhG+4u3h6Bb18gPgSXsyFaRvDh2c/FBkn9oOjbQSTfKYV0t1aFyYQf7+j8k0Sxi1FUVrdcQIdtq481t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:18.6637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2940b6-9ad7-47b1-286d-08de642463c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
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
	TAGGED_FROM(0.00)[bounces-16546-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2C3B7EC1DE
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report TX checksum statistics via the netdev queue stats API by mapping
the existing csum_none and csum_partial counters to the csum_none and
needs_csum fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 774a2e32d5f9..8c4ab3f81bbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5558,6 +5558,10 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->hw_gso_packets =
 		sq_stats->tso_packets + sq_stats->tso_inner_packets;
 	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
+
+	stats->csum_none = sq_stats->csum_none;
+	stats->needs_csum =
+		sq_stats->csum_partial + sq_stats->csum_partial_inner;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5605,6 +5609,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->bytes = 0;
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_bytes = 0;
+	tx->csum_none = 0;
+	tx->needs_csum = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5635,6 +5641,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
+			tx->needs_csum += sq_stats->csum_partial +
+					  sq_stats->csum_partial_inner;
 		}
 	}
 
@@ -5657,6 +5666,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
+			tx->needs_csum += sq_stats->csum_partial +
+					  sq_stats->csum_partial_inner;
 		}
 	}
 }
-- 
2.44.0


