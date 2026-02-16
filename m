Return-Path: <linux-rdma+bounces-16909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMvABf3akmn3zAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5A141B3D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC19F302EE85
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8B278753;
	Mon, 16 Feb 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O0e6vRSg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DB27CB0A;
	Mon, 16 Feb 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231937; cv=fail; b=KLf+pqniTr3EqvQJ9PQ6kvRSDYP6/F0TodDOVCBrGbCtbgYyM+G2SrUjTwCxyeTXn9mj8rqgRiMdwFbWhUPU/5L0AyFUbbu381E7zExaHs5SX/D55xCnrWxasl/U+qxjurDml18BnOsjAEQWanbSWvOaKrM6J5J3hJM/Ph1y5E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231937; c=relaxed/simple;
	bh=z/AbbvSffwr8wjcXi+Wc5g7Uf0eotFgGQ1IXbKt7OOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTQ6KIi7OlyUbtGCZeGjhPKBkp/x/fpDB5XMgVMIJ3ADunHpEgCtYpTjtvBzTN0wO5j563H7IKE2k/WYcDQSgSioAjCCj1FvyWk7ovk6q4a/J7cYfR9n/4VQ9MkGfUD8dfeCXLpOWFjQtmZZyKtNZMV9NNKwzu8I/34NlaUHW3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O0e6vRSg; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq7i7Tx2i+7h6XGoWtaEg3sxhhYSKARDQ4D7rD4mDz6jfHr/2q5PFxBSBH9d8OpFxDjY9hxgVsVi113l4VCnBA9gxUUcKvemKDX6/D0kdfwEsFqib/7pGPkhf1IvVHjgXl7u/7OX5hdKcn+ZNtYll6ouuBAB8vtmnZuRERVgctfzHbxUKZKGzwj9yD6ALksQ+pvL6dgGPbNyGKWCgWzRf2rqeg7bFybq6h7mcfN/kJflEv0IGDDyTdcTNHYOYo3NVAFhqge/q04AS1MT50GF3OPJu/jbd+F2Bx2R7t9P5Ez8jqe5/qKjs7PlpklYNbIqbzPHGXxcQqoWehW5sZ19AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DzYYOheRq+vseiEpeB7D1gJ5ZqfYCTJxUEKuq7wKmU=;
 b=a1Tti+kvvyAjBISbt0K2G0ODiRbyRh7HdYjp3hC0I963E+T8POzcfIxoU0r6ghpqMmLhvobbP4IrqX1UnDsjbvfqb0g6KYXF5aKHbY1t0BoNUTBsMo+IYoUaJhll/hddlED4w5aHM/a2nIHBQPV4pNUEA0IhWTqD85DD2cdDv3m9UCod+GsDS/hhqpEvji2Dxzvt2Ar20CZI4vmbKbgAfj1ZmNSTYpuSc+jsvVn8tlGzFbUoMcSpDsTaSHOrrfbCpgVwCKRwDnpNg3YcujgWNrbvH7VRgC2VMvR4oyE4KmRuxwZrQIi0lMPnfVi190q/q3yxxgtOYpEQ/C7x0LSjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DzYYOheRq+vseiEpeB7D1gJ5ZqfYCTJxUEKuq7wKmU=;
 b=O0e6vRSgdrMriMGm4spTgB/bHDhX0jEwS1XT4zHKVvF677GpWvtBiQ63ATnO5Kjh1cjJ3pS02W4GDNKYXUmmmnyPS32gs1Ed397PE4XcUKtAjRWlfZW2mrRBCnJ7yDC/0o9a0YO6bUel2dlGTXPUKL4+xmzr6auBrdD2kAZBWQEfex/3pHRdUnxSOof1yjGybrYcEVe/k3WR64XCBhZTmwa9u4vt3SMcPoQRz5Hu90noXgPcL2s5t6u4z/bIrHUAF8ONrtEUwRemG0adXo8ERe8udK6oTWHERHt2NNQxpC7AMsLRGHeHaNam8BPDZlboqDFe0RdAh6JXe5Uq0RFevw==
Received: from DU2P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::17)
 by AS8PR07MB9234.eurprd07.prod.outlook.com (2603:10a6:20b:5ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:52:12 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::8f) by DU2P250CA0012.outlook.office365.com
 (2603:10a6:10:231::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 16 Feb 2026 08:52:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D199F1C002B;
	Mon, 16 Feb 2026 10:52:10 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net 2/3] net: mlx5e: fix CWR handling in drivers to preserve ACE signal
Date: Mon, 16 Feb 2026 09:51:42 +0100
Message-Id: <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AS8PR07MB9234:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf782de8-1228-4e9a-ac6f-08de6d38ad26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qK7uK27bKKppiMhsyb+6g6FYZCtpR51D6HTXJ+1qT9ZY45/UZIDnEkCGByE2?=
 =?us-ascii?Q?U1+1GSCsCqbEm1wrVn8sSc0D/a6khLySwHqn6Xk7RCXAl46GT88yD0pHfc9X?=
 =?us-ascii?Q?+FN+vOflovtUrt0U3G6pVd04ARKo4jI1y4rMJuYNpXh5Us7nogNCuIdnfAlT?=
 =?us-ascii?Q?bRY4gWoBQ5flhRUr8huhxWw2W3C8E6X4Tm2/Nc9CSQAoC+1r8dNvtJowkaMi?=
 =?us-ascii?Q?gZ3KS6wXQvn3Wdw0nWgoZz9H97six2lvUq+D5w5CeJViqemLoEohB8CsGy/H?=
 =?us-ascii?Q?NJGWBxCtHmR6m/DExNumn/lJEH6ItT5Q74b1qiaXBeJuh15WISdMMR+8TzsE?=
 =?us-ascii?Q?FNfweUbgVSc/KqEef8zpoD2YP+BZEoNWEXO2Zcj6pbGadTQD5kNBbBSoWxmn?=
 =?us-ascii?Q?/44uqvqSBPZYySFJloN5DSZOyAh7dwQURB+JFAA4ewT1IRqTc76ET/oMB8z2?=
 =?us-ascii?Q?jA51IAMMdY0C9jQZKezxX2KCepY4GRSH0ryX5tSwmybWHQlrx2fWILW54gaa?=
 =?us-ascii?Q?fv8DHSBZIO4G4ip+ey5+JFUxFcyi/qh/Rx+lthy5V0frjvme05KHpRLv428n?=
 =?us-ascii?Q?NZC7CK8vRcaX1UjC0P9vkTdZKzqNhuX9XAlObHCp1pjX/ajSg6Y8/wPkTZgg?=
 =?us-ascii?Q?OzhY3vTT55J2jUcbptwHkBTcA135OXes5cmiBy42hoM6WYKur7TArBJQuTub?=
 =?us-ascii?Q?MxZBMt2VelMNKJHGHOBMuYRFXhao9OMf1y1YGAsWKHiht45Wn3t5unOp9Ll7?=
 =?us-ascii?Q?olAgATcG2wvZz7ewSasktLqE1VYxJAUYTqAdAILMbepjQ6oueC9SoJz2uP3F?=
 =?us-ascii?Q?GZeeNUTZOLb0yCgAm3KGHRaax1t7eTTmElaxtTyCDPW2652q9x87+VGPVlV1?=
 =?us-ascii?Q?UPhL5TiqRjy2Dzmm01hzwDFO5Zy9SkXn+twRlB/8NOp/BaQeRV5UxQAtQrTm?=
 =?us-ascii?Q?kJOH2zL0ahwoev7V7uoz3aRByCkJRPLsfgaPslabxTIG4ZFwjr8E3ogac2PI?=
 =?us-ascii?Q?s1DGOIjNiwfCzMnkUVzPRaTvm+5IZEl5k9IPRdUQKV4ewJMT0ymKDsJmiN9h?=
 =?us-ascii?Q?JiuXwRJC9WG1YQLJ+u8pK40ZQt2J0bs/JC3hts+ldNOTDQJBfkTrexQlfbie?=
 =?us-ascii?Q?j7tvzoYL6XU6CHL1FsS2qgR5LLYU7YwLczRAD2WcxMZxhdrOem/pQVGqoqoC?=
 =?us-ascii?Q?fiUC32v4TTHUxYCNZSHzOTrNgY90UeBKAeZAzFjjDwloF7T9o9HocQpbc/G/?=
 =?us-ascii?Q?p/6xHK9NYbtj0RJ3b0WzfMUKMp+3WD58cu3vxyYMwDB69dDnwMrUnF2HVP2s?=
 =?us-ascii?Q?cHirzcl6YiNj9pvGzrdmOXIj/o+qkAXEA7fuO9pLt8ZgF7ClfmJvTpXa39ET?=
 =?us-ascii?Q?ZJEP4a/h/sTGUA2ufhhbyRUIUP0im0RZsOXFb5yQlk1aXA/7na0Dxn5sqwMq?=
 =?us-ascii?Q?rcCd45q3x/RW/vHPQGInTUm3GEOrvM1zuxhuGZavP0OPsP+j60oJvf7WOG40?=
 =?us-ascii?Q?AcHon/B3Q8h8dZpAEwUcgDhRro5+rXwMIxUaqtSRotUXbzIM2JXGbcoy+LmA?=
 =?us-ascii?Q?XlqXXbKFQ2aJWOUCE9FtCBCNEMkTcSs8pN7FT5ocmP+/1CKoE30SKGwusMKo?=
 =?us-ascii?Q?wKW+kxr68KdrQT0oL/fXbq7zaZETs3TUXwH8mquD4vexsnovxXCPZfHZIAYi?=
 =?us-ascii?Q?9QxtMMcNZ9nAVEC4ttLjL/2de+4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gi3DIsGpe0hVqUjk1d+7cZIpwwYm3Oq2CmMxOEMFwc7C8XzP1wJzmJ4/cnBvE41HNsszpukcPcKnv/Ay0kdu7GnpxcpLKXxP6Gjg1H24AwmzoZzmY3LZmKX7YJ25osbynUtJ8MYkk6wX3qMmwAFwbNJ+MvfI3jAl0dAC/iw8Es44f0FapDacwwmUmLll5sxcXT58M8pAoFURF8l0wpu1Wa8LyH/cW3gSrwlHw1JyfNK6rWiT6UL9bH/qNsUUDnjY9MQO0gKzF0aWvyJupZ4lo50d7LHr1HjqIvJIK1GntO5G1ghzCYC02ibch2ggncMw9L+rtc3bcR59JokaYImXoTj/QtYxW6xShWT3dJxK3kKfy34ecnI6vzgpO2137aDLW1rwThHR5wii2x2VOAlN4frY2sb3RjVsS+sTGdizZ4LWZOoZv+126zwtlbbYUweF
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:52:12.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf782de8-1228-4e9a-ac6f-08de6d38ad26
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9234
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16909-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:mid,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 80F5A141B3D
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
offload to clear the CWR flag. As a result, incoming TCP segments
may lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index efcfcddab376..64fb829e1f0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1137,7 +1137,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1158,7 +1158,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


