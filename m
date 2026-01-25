Return-Path: <linux-rdma+bounces-15981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP5XOesJdmnYKwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF6807D3
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17AF30086E5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A4319615;
	Sun, 25 Jan 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/g4gqw+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7F2DBF45;
	Sun, 25 Jan 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343448; cv=fail; b=g6RkD0ZefW9HLpfogBb1zv8cYZt7jC2h/wP76GQmyEN2oNn0OwcQeW6Jfmx/Wey5R05ui4QUs+GJohR2yl4tnU7mdLCas25DkixJliVm8fGTXVjLtWbLxZOqEd2/6hFBsrxgBwAs6JW9HTm3Tle+RDldYlF1n7L9dAmtMIRYWtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343448; c=relaxed/simple;
	bh=5UI9yX1VmOy7U2RKffBzmyp1MkXbgvVGOrWNOIW/T54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA1GXRhEMQ23vT/jfvkC6fJGQvhJ5JhDpFxWlw/enN37MDUWMgZyOA+lXC9SU7GG4KBoqNllMsCkhSBIKhDVxZFM51mOik8cSv7OEfxHVrI46huNFnJQBlLtWwyLwvPvkjFPFGHMhzij85WTIXwcEW3/tDy0vlJRiHeJtUapowY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/g4gqw+; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXFoTbSogXc6hg4O70mGgsvcuAtG5XrBWFhfaLEo5G2HcRZpal9Z30NOB5/jv3IZixIijUqipJSSOITdNvlpNRP+0T04WYpdU/UYrDlLb0QXK268z9Mp6TOgG+Xe5pYksAe/ZQfXKU+n8fgRUY/rLsKj9Ib9Ie7woKYBwWSx55hx2+FVi9EHRM8AH187VXABttkN6EGZbhIzJsMsqgi6U0b7QiLCu4s3Otr+5ywyzHL0nSD52J4ZJ1QeM0jQ2Q/qL4TWos8QwXKPb2H7pNa7ef/ZLqQ448FxV0BT7n+0OdQqlKqP5VpCT6MChWfYGiSqDYecrS+RWnfkspFsyXxN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8jwJMtGU16L5bMb6XsG/Xx+K3V0XkZuITIeAUTfo7s=;
 b=Lz5KDn4h34wypIj9hhd2TWh3H/N+DwCda1hOiSUh+IplUlPu3ses1aXBZeOSFsbx4ZmE7s1nDKxret0sVODkHmke9qi4Fd0o8TsGc1f/83XIvBLmy8eh7TVvzY9ZqgU9OjrmStHjrkY9DGUW0u1xkWRY19IQJckUSnyDlV8uNoC9eQRJqkcuZAxL0cKbKfboFWcyKdKP+jCMB1/Ts59R2NsONT//16Ge834WPvm5jl5srZlZNrUJ6+8ppBJ7YmKEoYdDZpV1xaauXPtPa1xW2AS/cwlx0HiIAwQNmIZOl0sXxl8Amks6xmGGQ6uPxRZrKbxKmw7GkMz+33PDwqdMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8jwJMtGU16L5bMb6XsG/Xx+K3V0XkZuITIeAUTfo7s=;
 b=a/g4gqw+qQjfhmrw3Zip00cRSvgWopgFjvBjzWmj4OglkFsLdnP2BHhr+ewe2+bQ5aJoOYXFR+xSVu1R/9gIfFv22PFHF5teaWNh/9GnuYPTX+Tb6M06jPvuBMzsQ4YVScWToXaShLALIe00eF39UtMbneypuR+VXbwlZi7gLPFzRsmdu3WhOhQIW8fpgAt5UD3fQH2WN9nQQiV/tn0EZux9l1aXxrf30xv0uIKEOsho5SJnOaj93LmA7JQDdZYDitEWGl5Wz2lRu7fOsKxd5Tfrpb7AldZMn4GfNmKpoLsitzPBR4Z5wgt7NwaQzyzoKnTt0n4I5dwW55u+SzBT8g==
Received: from BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) by
 BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Sun, 25 Jan 2026 12:17:18 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::4a) by BL0PR01CA0031.outlook.office365.com
 (2603:10b6:208:71::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 12:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 12:17:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:05 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 04:17:00 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP header for GSO_PARTIAL
Date: Sun, 25 Jan 2026 14:16:47 +0200
Message-ID: <20260125121649.778086-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260125121649.778086-1-gal@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 79dab8de-7357-43d7-7762-08de5c0baee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvFCSGJae+74OGCRCxXYyB6jF5p7crypLR4+E93ULipBs9OwZ42L5rHgqNN/?=
 =?us-ascii?Q?SALGj2Xcok7XHvccVVZ7CSAEIzPvFtD7vZIs0wnFf8TrxfN9UQ9tRzAbDsSM?=
 =?us-ascii?Q?x07wpwfCWcG8UHP0/7Fc29FQgDe9zTDUU5J+jgRqIcgULBQPkK5MDdbvrsOR?=
 =?us-ascii?Q?XzJjn7/s3zTLDjLD17Ivb/93c8Hv7kRpdp+Y3O5oy2w7YRKc+2v5o38ff+8K?=
 =?us-ascii?Q?tA+TD8LPexPwuZzhHqlwJkmTJXMCed09bXpdNwq0mlUA85b9anukuQyPQ9Pt?=
 =?us-ascii?Q?Mp1WkQWDD6XPN5bD//W70ZpgS+c2bj6hbe5TytHjLTK8WN6/Zwo6RuA9EL1w?=
 =?us-ascii?Q?RMybaZRfswUuALAf2CNQnVsEmChYAIBEXleJzdjF0ETp2HUx7r0riMFkhWes?=
 =?us-ascii?Q?3mjzwNR126l5857DdEbra6zM6HxJ/WxuRICvgBDl93vb3ySH4NURDSKMBt/m?=
 =?us-ascii?Q?tvgoviH984X3ylIk4NbTPl+jvfiobRsKHJ17Tg4PqSo3pFY01baCdTqcj869?=
 =?us-ascii?Q?mc+tngVAp06ZocjCII194zz+RwP93Csn4MTvW9QDRZwMBLNBcdEKfO3HTpDT?=
 =?us-ascii?Q?TwM115eoscC6VHmZmkRqhhiHQkQlNXsq8mtnHZOqzIxVfjYJEew00Xf+mtdb?=
 =?us-ascii?Q?ZGTRW1HmogvqCn7f71tMroxuevopo/ugia0VpVyBDNFqMd7ONjqnPOvqv+Ww?=
 =?us-ascii?Q?VBrtb9+/owRyvi14e9pcE1zCjFr+XL2STeJsgia6aLIyp86HUSPd6KDOo9B3?=
 =?us-ascii?Q?gf3dPDeYdC1HNj3e48Krw+FdkVhDcRj5c8M2dndJUGDycV5sxlh51vwbbPJ6?=
 =?us-ascii?Q?YGjwS3qseWnPWpvRCR9NC7YPAqOzAactfzrDYRLgXxnwZLU5T2x42RZgLCX0?=
 =?us-ascii?Q?fY0AF4jnjuRAGft/Iqeamr3pHEFKHv8NBPavEI6zMQfNu8BkgbY9FlUzQAl+?=
 =?us-ascii?Q?3FrSQ2486KdZKlIXCrH4a40+/tH+ltSppeUu0QTPjhGGg+DPb7f4523M/cHa?=
 =?us-ascii?Q?pSPTV9xUyxDqfqukm2V1BnGAB4uy3x5moE37Hy3Ja5f9OATGIgipWCbBu6yr?=
 =?us-ascii?Q?esqJGbNSY0yVH2C2s26+JlBXVHXO8e3Y3Xe6JvDz1F6hhQ4x4DLp8//6p+Yy?=
 =?us-ascii?Q?A2OylzJNVaBKa1s29svjwa1KlmBao6YNhUJMgW+iJo1fEbiL0JZwcffqDf5k?=
 =?us-ascii?Q?rLXe/A9p4JdRuTs+H6S7Lwl5ryYig4J2eGr0g4MPKM+rOfmlx91Qr0vk11IZ?=
 =?us-ascii?Q?EJiH5T7tkFKmF3bChNZ7GWMi2Zd1boa77knTaS8A2AF7/GvdvqqPY5oAkzAe?=
 =?us-ascii?Q?K4pZOb9+QI43FhJhU+DqU1FMjJ9wwvLIn1COBR2XM2coj6eexZdjJ7GFSu6c?=
 =?us-ascii?Q?BBi8TD3QxYM488Wk+F0dpiNXdDye+xMGyK8YyXqY97TrDYK77OeNX57oZtaD?=
 =?us-ascii?Q?j/35Fp5Pex3N5I4eIYl+IWs1JG9tTbuHGeudUK+sSIUbdFBMa/2m/kWiFQ2l?=
 =?us-ascii?Q?uEt1soEvpxNxlBZHFF/C2/01up2mz4h39TEiGjtiXjhdfMjbUUemySEgNYcC?=
 =?us-ascii?Q?a5LeC+YWZp8lubl6DuX0+swcbVcdrrT+S6Qb2+KRrH3x8pfVwVVkNNBQWdN1?=
 =?us-ascii?Q?CK/vCXnm7v/FNB1NNomOuryCWP7MNrKLXTLkOMdiLR/99HbCzGfcdG6UiYSi?=
 =?us-ascii?Q?xL7ntQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:17:18.0285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dab8de-7357-43d7-7762-08de5c0baee8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15981-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4DAF6807D3
X-Rspamd-Action: no action

In GSO_PARTIAL segmentation, set the UDP length field to the single
segment size (gso_size + UDP header) instead of the large MSS size.
This provides hardware with a template length value for final
segmentation, similar to how tunnel GSO_PARTIAL handles outer headers
in UDP tunnels.

This will remove the need to manually adjust the UDP header length in
the drivers, as can be seen in subsequent patches.

This was suggested by Alex in 2018:
https://lore.kernel.org/netdev/CAKgT0UcdnUWgr3KQ=RnLKigokkiUuYefmL-ePpDvJOBNpKScFA@mail.gmail.com/

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/udp_offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 19d0b5b09ffa..89e0b48b60ae 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	struct sock *sk = gso_skb->sk;
 	unsigned int sum_truesize = 0;
 	struct sk_buff *segs, *seg;
+	__be16 newlen, msslen;
 	struct udphdr *uh;
 	unsigned int mss;
 	bool copy_dtor;
 	__sum16 check;
-	__be16 newlen;
 	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
@@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return segs;
 	}
 
+	msslen = htons(sizeof(*uh) + mss);
+
 	/* GSO partial and frag_list segmentation only requires splitting
 	 * the frame into an MSS multiple and possibly a remainder, both
 	 * cases return a GSO skb. So update the mss now.
@@ -584,7 +586,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (!seg->next)
 			break;
 
-		uh->len = newlen;
+		uh->len = msslen;
 		uh->check = check;
 
 		if (seg->ip_summed == CHECKSUM_PARTIAL)
-- 
2.40.1


