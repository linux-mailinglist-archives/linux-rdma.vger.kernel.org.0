Return-Path: <linux-rdma+bounces-19415-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIs8ChtS4mnx4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19415-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:30:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85B41CA0B
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 456F5304C6FA
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03F33064A;
	Fri, 17 Apr 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WtloKMrZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310B32E13B;
	Fri, 17 Apr 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439618; cv=fail; b=aOPUTUa1KwCcaId6HBjw12dRVvHjajCu1mwHbmchG2D72WhogZ+FnuKFxO82UwHvaosHT0CRv4L+nQGExnQ10M2a/XA7tQieHJeafJVMAsLEyr1Y0T+/ky3wntuXbvamUTpY9Ip6l2ETs53Bvv6NAFuwYeeWcgpAk+jNEpFfhqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439618; c=relaxed/simple;
	bh=aSSsTPTM2qbanF7vCjej5MNto5Og6DvTTAhHysFMh/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+KxrJyC96jYTjLkIiBBQd0Aogzpv5M28kizYuWrVofSsY6mLsdr8jStaz5hNCoTUYFmYJvutMzvAnDZbEaRbnDgN585riIggnYIn4cuW0D7kMVQXeA9AQKQF6a8jXaTlSBINVJcouskEI2Ek51FUjSXRwtrpRQ7i4FCn/HW14g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WtloKMrZ; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaEz8/zi9PvVXsWaSecSwSDIAGp5qUBgrusgOLTXsx5xZ+QMK16sH05GLprBYKdMw8vruUqFEedtbPzPl0czL8UjlKQ/ApiqeP47VvJcJgXEOuPigEidyga+RB6CWQZhSx03ZgEM9+poDjsx0wPu9BJl8/8fXaPOiwnRXXPBBFj45I1cWMDOBbKKB3CP0ErthdvNCCpu+n3URYLErqv8m6EwNo8VQSRhq/8BPVEOBC6EMFRS3nofNPtMe/ni5wAVLX2/Rhe7qGU6Wo7ozCt7bxybs2BzuDILoVVpjKpfxZdremB1wnF3ADhFiqs+dGVQJaS28M47ncdcEi8wN9DLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQFzRqA7V56py2at4PFpbJuqIxjcGUXvFApHw0Aisk8=;
 b=jVBLdmc8zi/Ct1/XTxtTD+1A76HlsNt/lWy4UHTPdLagTJw139Xr5MbbKZqz4gDwTl12dEqmQ0bpcUqTCSD6qFjur73nFH4ojzr02x9l6RilYoAlYb/L73M3GJZc74KxXDw7VHuVm4nrJpKYYDE1whDKWDmSnVSJiO+U7QoPQccUrbqgAzI2VN6DKBNQTwskMs/5s2eJb/+3lE2U/C3TJSgdHjDHvIbzRVztI1TV2FErdY7gTktY+zbtRDON5u2jBM4mdIeiUDqFmpaBwhDcy2Xkho6dZH2IkiHaIJ4oeDeBuXh5ogEFuBlfN2oSOHNluX/BjFz+gHEs579pHQ+jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQFzRqA7V56py2at4PFpbJuqIxjcGUXvFApHw0Aisk8=;
 b=WtloKMrZllpUsAAYTEgqQzdV1CruQRzWUM52opH9bhDEbpU3jib6f1/3UDR264tWC1xE5gwf8YtpDFEm2Qp2l4TsaRjnbgZSzs8+aGXaNmsNcvvnZ0Yk2sqZwOCahn4kPAx+PLBlHhMOnQy+mgcsmS6dU1DwuydqGHuXN9GN6UJkxVdJPQ3RVXOLkGGd3V755Fu31yHk9awt1mTJ6AHY575itZngYh0NOgJn1ADUwLfiX7uBHe97++bpXZWlvrQQmUmHiS04xomxX1ZPN/YoPRUUNibMv8PtgOQScRGUsyI4RkVlBh4IO7PEtJtRyclOcr5+97blrpHIYc8DMckC+A==
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by MRWPR07MB11824.eurprd07.prod.outlook.com
 (2603:10a6:501:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:26:53 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::7b) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 15:26:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 68130201CF;
	Fri, 17 Apr 2026 18:26:51 +0300 (EEST)
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
Subject: [PATCH v4 net 3/3] net: hns3: fix CWR handling in drivers to preserve ACE signal
Date: Fri, 17 Apr 2026 17:26:42 +0200
Message-Id: <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|MRWPR07MB11824:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4d541f4-104c-494a-3707-08de9c95c0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hQCF9zHtfDdXc+hYF0QFSR66qTKniWp/CXhnfLHeeKLeKLeEzCloEjfhYRqKgk32xyZp5NtmAhZEVsXdxV+fTR7nQQlYJkUMHH1o18CC6EjHGFbuZbuW/Zi/p1KDsHqZu4oBpInypoQGpuwqUXmtyM5rdf1YOb6FxYJa2rSQfI+0DhCFhAA9szzP7ufl/0lCxwCzdgmSfvL+Hyrq64GCbkd5+SliTQ39UFlEpZ4sYuwsYvTJHatFBikby1aJnulViQiph66Dbl/dT3E6vjUHYd5Dnc6vSdOVsv11Jy004foOeEgqCwyGbg+YauxABA7ZmDIJ5Jp4rgw0iQ8wvA1VF1sOy/7ObZ8OeKg/U9bEcWo2pIfJskvO/Hik1/su5twpyeRbbajlzSNHg0t5iSp4Vk3xG3KHdlXlb5tk7GAppx2ct+T0FHyg4HiltJMVWrVowsFXuGfiAJoVBImvBxwWdCKrISMtfAyh4fT1m0DqdBNjhB2P8JOpqSY5Is7/cgJ/BOp+V6pff7IEfiQ9RM9izKJkCjg68wggImuSHT51igp08q7LqcnaTqrOBNp8c86KQAxtb1M8VRYcsC4CKj0eMRlxLs8i+5agDtK9H/uN75qYMLk19I8FR68ZWIssfTEdts9YIf4oIZQ7jyLBFmQJWrQ2N8qOAE0UYLA8NzmevEQDR0/WBfiIhKynkYKYdeoVy+0Fk07ePEjhigRXBPh0JZad96O38+pyGcZOTxY39aIn5JMG9oiK6yQPgzuASblRhK9J6TIgl2fscp0K6t66QyJY/5rLiPhPPcEuLoD5g7slTwEEaK2yaehqNEfoExBB
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2lq35C1tK1zT6uXRqMOBMUyC2M2LmPz2qHSxwn7NQU9FhHkpgRudy6jl11geT4K3amenmi5Pl/iP87s6FmYYkeA8e+E+Q69Lp60i2A3k63DMGX5ExcgTVdM2lzlBIW1qCHtYuQWDwYXMT6Aky97w2fOF5wU49P6OYrdW9e/6Oxqnkuy+W9nrQnR2HYAH+Gy+iGCP2vYMvAS5ZI540gSbkGy6xXUSB+2TbsKbE43PsRMkZGihw39p9Zj0ASlBDzl9FIjgfrg9EWmic2eF+85Dzg2gzaRDBHw3nuqTUoE5B6LBWDJRHsjuzHCHsMyHd9q+3LDdqawyIDLdBi1sv28wBBABP5UY9wHtNak6y4RxWZ3Cqtz/zbp4ruhmvkjN6kWaWC2WdJG/KkM11VZADR81h0vc6ZKi3wVhk9pa0xrZ56ushCyiKvNbtbtuvQCE/ZZK
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:26:52.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d541f4-104c-494a-3707-08de9c95c0ac
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB11824
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19415-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E85B41CA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, hns3 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
offload to clear the CWR flag. As a result, incoming TCP segments
lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a3206c97923e..e1b0dba56182 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3904,7 +3904,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
-- 
2.34.1


