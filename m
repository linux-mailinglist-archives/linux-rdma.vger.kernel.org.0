Return-Path: <linux-rdma+bounces-17228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF5UIC5ToGnriAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:05:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE521A733B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C9631550ED
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8A3D3317;
	Thu, 26 Feb 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vt3ONPKx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600963D2FE6;
	Thu, 26 Feb 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114004; cv=fail; b=Rc7xUdpEWyrm4gD83ZtmY1arzElSGfmoniLpj4JvID35fojWAPWWf3DDbKKIO6iDMi+2B4d9hVTjukOuflwzP9guIdQvKRmI1zXuOGlsT/CciykyjG2ytq3suQdADrDEYOWbeqVbBQKPnkFLvocEJAPsfGpMpgGpbPMDWrP4KVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114004; c=relaxed/simple;
	bh=hm5WJqP9+doO17dhRb/fXcCKN9aAwnDSj3fQaRsvTeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gZeD72obGS79m8350d/0BFKqMguNmAijKQ5ZRtE9guIawfU2o91OQl3uuhQ46KQfBBjrXXGKaGYTVdA96YBV/UbP4agBjTIT941ctA04RtjdFdmgslnLhwzrW/9GR18UPM4RspSNtB2gKZ5eRsTpF/WSxO5jwN2MKSvBSw3C58c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vt3ONPKx; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyc1rD73UsB7dUUgfzWhj3cRAROoMUM2eE5IrvPIg3kT5dM/0wVRmIm4knUHRyNuILm8WBVnxplt21ZGrfpyqQoahIqW+FEOCGPI4IM3HSuflmVI0Oq3/0y2zfn4WAILjHm82pqdf46knJcFlxoNrX5RPsM6+YIB8Afg/29/i9yhOGDYMPHLmthIoXKOz2JHC+3P2oFVwlbMTIZEqDDZE7ttRd1EHUa+re1YCm7sBv8ZpFD6kPdMNh42sSwoqqeYZnXKsCEUNp5cGRXcHYQIlg+qxzUrhoZvHKY2N5Opgr147il+UiHCrHkvVTWWRXgG7thDSzi1VjBzV9wr2SoyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qk3b+wK2yK6KTq1uzHJRp73P9EaukUk5RQXT8jQaiI=;
 b=jf9zIkoUN8Otmxj8YiwUU+3MV1xtKGYnUu/kLxnkXb/jJIEoPLieTkK2rqJnfY5GErbkqtOEu+h6BatXixp1jbxKR/sHjnW8FQVrMHya4LJ5HF3YgTWoFxjL4zw5HF7IITlC9Mg63l6bbTurKsWZPmFz8/gttIpXGMBP0WMSAK77SA+FD5zfao4SwAvezdnzaccxR/otFK44nD7lfb1YTnt37OMTWZUR5IJRn6kKDicdpcSW1U26cHlaedF2hcdPv5RukEFuZzMtlWsZqeMko66PrwIGhKX3PeXA/7cvsTuG4ADUqByirKndqCDHQWy4kOnyjavb4jNOI4oyBL/ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qk3b+wK2yK6KTq1uzHJRp73P9EaukUk5RQXT8jQaiI=;
 b=Vt3ONPKxVitiqY+XNPjMHjZikvWmKPbw6QP5ni6IPdFwq2kdOyy6j3sxsd1OJjPyXy0kdofHRs430Pyiv7u3nzjOIXR9zKg3Vz9v/7mFcM0LloFvNhi6yB6Bk5lMVArK34zViNlc6gM8ekeMFROwuCPpncb273wnfgvzgKzLzeBUdxtBspxRUQR/NVsuwADnBVHnm9jDonF120Mn1gXc3gvVuSFS1Kx+lH7IFEo0b0fhla7cXduDNO4M95r8ekYhoEjR8oNKP6w6CLDYXVpweqEhrsU15ZfIXscAjSKz4kjSEHNIBCjyX5D7K+YLQ74/QNFRwyU0PCQal6840OagdA==
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:53:16 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::a7) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 13:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:53:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:53:02 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:59 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:15 +0200
Subject: [PATCH rdma-next v4 10/11] RDMA/nldev: Add command to set pinned
 FRMR handles
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-10-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=5534;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=x/6xGugVmBAXHQNG7mM0BRo08gYmKnmDcTQ+SXaZQq4=;
 b=WE4DmYVWKnewjRtRI0mA/TCVpXQERuObmvh0PLL34VY757bynzfp6tRK9pAg/wsa4VbuCTEbR
 4epq4luTqLxA/8Gnup0sYKhTjLcL3mnhYiXra4YxtEzyS09JFu6Nhrv
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d542884-3d53-4ea0-d8f0-08de753e6406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	Pyc6/yLEg7uGWS00J/qfrT+Ft3H7t3dYY/rQg+KZYC6oXlhTmLuayg5Thktz79xFlXIzFejf5JxOv2MXgCdhWzlXXuWkbPfU+b3UjctolIok5y64+nUbOmWi/TsZadu+zC0UP7VnPqP6Ma/3u8txqM4iUxa2bBcHMoBRq+z95WmxgbnMeqPiw5AGheYP0cdko3n6HNio/7JW5IQTU2R2AeRJHfM+5UviLGSa5CIrNQMc+9C9JY8VWWgbQD07oHdlBUU002CMr46BXTCjZKziAmBYBnHrlNG4VcOVym37nDmfoV6rXTuiMcUrdT9deowe0xN3X3Vu/o2I+xX6vQLDhOSETS+bYAl8YdySjX/D1Tav4hCxOSJCFAqbfnb1bX3naHUiL4QuX2O98ntffybq1Mcc83WUhVD8OWzMXwOczZrSv9kQXWOude4xZG3bYu5ebnehncojlitpT3O8ta4XnBEKUMztFdrTYoaCPWSJmE3k3XaAIq8I7B0iws6J9ahq6aQeYeOZHMuFMPnRNs3syVYN5VV7z5i8X4RKPfkRHV09gJ0DdwctBPLOXIgNAi/FiggKf160qiWHDMs0rgkmVLmmcbZTsvKneQ7jHOmT4AOJtx26MYeZdzV/0GYZG+R8QMiYu5CKJQVzyMimhYeeE7XPyBXVEix2FuM2Kms5cWVPxmdVWIk3owmtOG3MX8fz4hc6UN1E9XIRDIop8TC9Dqxi3t5alQZ0qOc4nfnwh+MQzCi0H1EaKXoJUgkImUlbVc5VCfdkkuBRqgl2u/hUcHExNE3D1EqiORP/7iFFDoN0T5x62R3RAgiGHTETeGCZCX2lOoVUEOGF3gPF//e7Er3gh63Db3OEfWjNmZBWWQs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7sx2r/Ew6E6/Pl2s3LyJg0erigD98iehSHo73Kv7RRD20gMWkQMyRmAuGDpF1bqfqcMmwhGVmCHW6SvXatEGBNtFnd4Y42dwtH0QPGVYFIE72flO/jj0nocKX2GbasNekTEJ4rOOguRT49fKFOcfxfiX9ZFWrgf7NQ86mcxcBgX8Ad/i1SV1dlsSKWb2ihh+MGyxtzrkvm3IYtuiX5Al4XD20RRFV5WgX5qSKPazUlXTpCpfZW+InvlQit68BIJTkKJzpZn4c4vKks79rA39hnl7Oh3GzcVMn6eTeu5oK9MV49hcFFJrpwS7JPocNASEuD4zVRz0otPOLp7owEr3BkECHNYhPAxvG0N/k2xb/CY326caaxNFUMyRfx5Wd9qhVBYLD3Iqe/Ggw6cXqztCktmtOFQ1x4tkMmrVHBxMhu7NsN1HoMRPCf+ANp2gGs7Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:15.8825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d542884-3d53-4ea0-d8f0-08de753e6406
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17228-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFE521A733B
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set through netlink, for a specific FRMR pool, the amount
of handles that are not aged, and fill the pool to this amount.

This allows users to warm-up the FRMR pools to an expected amount of
handles with specific attributes that fits their expected usage.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 88 +++++++++++++++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8d004b7568b7b48e7103abbf0b7c3fb7acacba4f..0b0f689eadd7643fbe77a5364b8fefe3d3a60de9 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -185,6 +185,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2692,6 +2693,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
 			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
 		goto err_unlock;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
+			pool->pinned_handles))
+		goto err_unlock;
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -2701,6 +2705,54 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
+static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				       struct ib_frmr_key *key,
+				       struct netlink_ext_ack *extack)
+{
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
+		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
+		key->access_flags = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
+		key->vendor_key = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+		key->num_dma_blocks = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+}
+
+static int nldev_frmr_pools_set_pinned(struct ib_device *device,
+				       struct nlattr *tb[],
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_key key = { 0 };
+	u32 pinned_handles = 0;
+	int err = 0;
+
+	pinned_handles =
+		nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY])
+		return -EINVAL;
+
+	err = nla_parse_nested(key_tb, RDMA_NLDEV_ATTR_MAX - 1,
+			       tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY], nldev_policy,
+			       extack);
+	if (err)
+		return err;
+
+	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+
+	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
+
+	return err;
+}
+
 static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb)
 {
@@ -2803,32 +2855,46 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	struct ib_device *device;
+	struct nlattr **tb;
 	u32 aging_period;
 	int err;
 
+	tb = kcalloc(RDMA_NLDEV_ATTR_MAX, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
 	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
 			  extack);
 	if (err)
-		return err;
-
-	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
-		return -EINVAL;
+		goto free_tb;
 
-	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
-		return -EINVAL;
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
 	device = ib_device_get_by_index(
 		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
-	if (!device)
-		return -EINVAL;
+	if (!device) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
-	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]) {
+		aging_period = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+		err = ib_frmr_pools_set_aging_period(device, aging_period);
+		goto done;
+	}
 
-	err = ib_frmr_pools_set_aging_period(device, aging_period);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
+		err = nldev_frmr_pools_set_pinned(device, tb, extack);
 
+done:
 	ib_device_put(device);
+free_tb:
+	kfree(tb);
 	return err;
 }
 
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f9c295caf2b1625e3636d4279a539d481fdeb4ac..39178df104f01d19a8135554adece66be881fd15 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -601,6 +601,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.49.0


