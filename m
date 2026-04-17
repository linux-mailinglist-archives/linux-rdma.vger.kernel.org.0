Return-Path: <linux-rdma+bounces-19416-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODUENNJS4mnx4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19416-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:33:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFB41CA6D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3102A30D2B40
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A233468C;
	Fri, 17 Apr 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nMzqSndH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9330DD1C;
	Fri, 17 Apr 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439618; cv=fail; b=BLnLJBJcgOF+vO9awN5VwFzVV0jSbg1TSpXci2oLCSAWMSQOSgXi3LoohrmAn2YAbY20gYyzLjBUvnMatCtwsBLiBf4xuil9/9bn2Pox6O3PWphoG5i5Ezxnfqoga5BtvZOmopEIqnIubTSpWO+GsdnDE0ebG5oWA3PolcTc8KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439618; c=relaxed/simple;
	bh=G1/lLhYPiAv7wq52r9/D5m5lQbFGPYeovYBKTWZixMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNkU/dRz+ZpH2f71qUBr2ctaHQ3hae+jnh/B47P1gfvKGUAoP3XbwEKtbsMIwsek2+/6I2WUYPbqTxn0VZNR3He/039N3y0GTQR39y+558+jaJPY53QPI02K00imBk0r11jJ+2R1iz67Ok29iw1LTVIXwv6dyq2cKXHFLQIYXKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nMzqSndH; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3tcX7xdiHou6dlak1v+0V8bsT2+R24iluBca1ueqdwMVsFQvBrfYmjwkIV/su4J5/3gcmz1qkkJcqvHwkpvHl00ab7KvkfB5TzAd60P2RCu5DYumWHKXkZLCRobYCteR6oKXFPDmRA8IDssnddM/F841ERUtzCrMP+9kEvAaT+FiM+2gDSEYFxb0XPioCeoip5D5KudlKeQlme7tO0B2IVTBXHwoETtoQF1qGiiq3VHVqEfJRodHYjYlyCxPslXmNoYEBfwu3XCXXB3KgZ8TeRL7Iyewh+iFr4ZXKzf1b2PpL51Go/Djp+ribxh8measEqyl9Uw4dDqGcBznCKs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYgXmEqRTPvqKDJbEA6o0acCJvwRCQe/Vsg90fycM+w=;
 b=WPU31ptcHQyZGqDRE0rV+Hb+K5CzhfDyNOQoqmy3Ft/M/QYdMwuU4TlpcP1vehvVgKQVIsPMgdK9kMO+T5q36ksg9O3+H9NIA/LyI24z/r8J607pPYJp1+kgCjtclyAaoxo5I6WTQ6JBNx9mn4gHvAxjqSPxfaCFKrHDQttwbFH5ybIWZBabFKQTJM0m4U45SiHEeC5AUPLMUiVZup8te7iwD3ZfCSCuOS21dmzaHz2+x//A0khhOGvtX984rXKvKqvDu1flO+3HtSK5xcA5P2fPDyzG7Dlh9NOWX/eHJEYaVjKhGfQa4Y3gEaH6M4j9KzCnHCyhqg7F+IsWcYNLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYgXmEqRTPvqKDJbEA6o0acCJvwRCQe/Vsg90fycM+w=;
 b=nMzqSndHQw8TIVZ1gigh96dBDutS9+Lg4g24ATAOsrAsEydVcwIwsVyxJPW58PtOQndRts+6EcNVOB+KdFE366rqI2TnzawKthFhxZ/ZP+Zqu1a4mBoyf/PPyiKgOgWC8DcPsoNhM4EMkHLqttCzzGzW5j3UnnTl/5UyLVKO+ddqdNO4P1/T58xMOGf9AqyjGi8Ic3oo8HIJQ2x3a4xyf6uKzZt3wlG1FpMMg9//8V2vwkBPbA1PH8+3OVu8V9NawVlPRI0GRZzdQow0NlyYLkzVxsd+6Y4DXivXeQc2/5UPVYSTx3OdmebbNDa6ICxt2gFXuDpswG9DiA483hbUUQ==
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by AM9PR07MB7698.eurprd07.prod.outlook.com (2603:10a6:20b:2c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 15:26:51 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::1d) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 15:26:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A4689200E9;
	Fri, 17 Apr 2026 18:26:49 +0300 (EEST)
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
Subject: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to preserve ACE signal
Date: Fri, 17 Apr 2026 17:26:41 +0200
Message-Id: <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|AM9PR07MB7698:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4cd634fc-8fff-4762-4c39-08de9c95bf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CB+5iIl2cFRYOEgXtt2i/QUAkuGZMGhfpsPjsBEI9b5ojmLLFjMnM3GuM7QzLnZsvjhB4Gv/iQyyftqNGevuQ7jSFlV5VnkmgvoHSZWxW3L/gZS3ftdO+06nz4EfAuMr5XYe/QUNkkxt75st+s91kqlzOPrd6SgE5UvOVktpdnvLeW1XFISldDinMfgewni2knecAtiR5anHoGyHgLQpi+tIid/fyAngfnAyLq9mIvZo7UlxPzLHh8oh/Ahw6eVshkTTljf4vo2x/t6fCj8hyHehHduNIc9sKTGqgTTyb1trLVGWaJbaN5DMKG6KA5bDBC5QYEm2UMlLU403eav8MKrBnPxmiECyx5wK/OYTqJt58GHk5uq3RfogAoMno9XxpKP76TsvqJbMquS9zILYml+aLt+sOibqqULvaKJRr8mZ7Fe5x0kUpmcdoEYb8hoTbmg4owdSN+wiagX28xttjIB5O/Al0pfB+4lPIE5jTU7qZdnBeNb+0dK/EeFSk6+sX2uQ7dqa8WGy6YApWh8GB4P+7teIQF5Lq3T/4IXq9fP/icOoJoq9AEXQMcfd6+GGB8h0UEoLJK0cwjEjPBOiZ70xTtBJiamBqbXIDl2HyeSH5u0hWzRxFA63SwRTsgCM3Stl3qc6gepT/0kzucqKX1Mv4zFDnBJqLObMe6gdqjOUgTMAiomByPKyQzrnaS6k+gDWgPufcEBMDR6+98TIJwewSyVG7DHwkrs3pKDLAu1KT9VEg1NqbiAiXpuEjZXQY4REUXDtX+FKCSg8i62ZgctKcgxnK4rUvooSwwvv//3Eoxnzq1Y0yZO0RoMmJYxi
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	deRA9hmENVgOoEGFT+I6MnG74lLnYp3wgg2hzE5NCeYqslVUeEL6LGOl+wqUIAB+oM39SIDLQEdaxCPIRiz5hLTdxgNAk/NhDC8Ul5bi4rrLIZj3P4ZdnTZRpzCHaMfRhcXQvo96P0BUgcz9p1tOt119Ki1j/8QL7vFclv+NHKHcTDl90pYyciqTD8JBFdnfRdP4QhVwaQHCA6KrQWUNsRY/AH1vMJ/4rkkwKRKZpo0gMaeocriFA123CxYgsMLVIj3emqBlLgcDiRVULX0ZlBiZg0Pcb4y8qFjZJl7UP2JhBKLnWOoo+lRYpctt0RHBKntuoz61ACnBVCNjw7fHBfAT8F46diiDsPu7QspDMbHkTpfQOjr4GtbrlVVRq00aUq8mW5CXnZWq9ErXepGkf1lDuKwqfrx+g4qsJ2KXDT/dnq5vtxua7ZbFueUg+WLR
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:26:51.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd634fc-8fff-4762-4c39-08de9c95bf98
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7698
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19416-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66DFB41CA6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, mlx5 Rx paths use the SKB_GSO_TCP_ECN flag when a TCP segment
with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
offload to clear the CWR flag. As a result, incoming TCP segments
may lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensures that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5b60aa47c75b..9b1c80079532 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1201,7 +1201,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


