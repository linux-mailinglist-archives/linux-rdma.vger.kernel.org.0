Return-Path: <linux-rdma+bounces-16469-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AR5ILofgmlIPgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16469-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:18:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5988DBC9A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885E1314198B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E23D1CC6;
	Tue,  3 Feb 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bQ52cq4V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB33D1CAF;
	Tue,  3 Feb 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135103; cv=fail; b=cMlXGbF+xsAHo1eEgBpKb3cTA1jHX5X3mvfTSXrkp9pnlOQXf0f13Br4spSKszKfr5TaAzLshPNEWcx5qxqMTAdCVQ7Sf8E/ZtKIdhM7OD69oSY6AgwyeUEBzAx0vR9tNqGEfCUG9GYp+avFxSQlpUwqIRVeQXTca6lotGoBxZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135103; c=relaxed/simple;
	bh=Qn+MQHpjv/c7Nw3o3EDZcJT6AGPdlIJfcgYVIEarwc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdbbyJdqPcP9N6U3X+VERYcXB4kxqelGS1D2vy/dnZOGKR/FcLgZANQqcQHwbHzBMtzgwOqxfk439Ye0dzpl5k82G/Q038AsgWKAYYxYnT8N7AUAN8sKK9ghKzmnmDUNfNH3XKNu3p8b2gRZurfDnwRRS5IlC0C7BjywqXA0LpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bQ52cq4V; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InpDlNd9t6lUSWbInuU/Dw/VK/gm7VBGMQCsvOM5rWYw/vpKK3F5FjNtDXuoFoDK9Wa2KuMcg6TM2SCJ8Tpq2qngM3vQWaDRyljW9lia6Rb9irmLK/75j6N7yDO+Y9fa/cniSRmQ7nWyzobwY2EvdWDjGvdj/D45S+mqSJq7tw8RSKrHGio7lgeWQOn/XthWwWTnscv62oGonLXSjLp9sli9mX+cb6KTUigZi4L3xfMQD5PUeSUjaLJ+tYRJrYUvPR6dTXppvsqjkcgNgSbhe7ClyYH4O8B0w9cy6FlMmrNxrXCHuWeaAwnLU2b4Gv4G2mmqBMKYTU32NzNDuf5TeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvCMrXuBAsH/QLwIlECMlegHsOWV38Ruj8ASScVvBo4=;
 b=U2lw9G0g5wJ7ujKiEluij1VAw3FbJtoZjhmqg556ZGD/9L2NjvMG14G3uFkVGyFpr2u/F6yuOrtXaVBOyg95LPqu6CTOFeipa2sEHIGXbIM9F372nzdBI7RgjKOX4V3ByrZsTIpTlxC5tJSFe6RTG7ofC/usp9qtMtt4xihZBIcfJ4tLxUVpgWqZAF5a60STQIl5rQKKD9Q/UBbTSm5zWaLef0t7RM4+XV3XB+7QPSstoHBEnhs1T1M38oCdzsHT/4J7Q37I8VpJj5uEtikoUms+QHcc8QDDoA+sJG9ms1tku42aWKbmI78CDqbzDBvGFzYjzCEUQCWzhawROVTlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvCMrXuBAsH/QLwIlECMlegHsOWV38Ruj8ASScVvBo4=;
 b=bQ52cq4VcgGsPxsoaGNpssK4bI+VIOKYF+hdTQYBlRTVlHr6f/ZT13rPj/8Ogifi8qqoBURn7GgkFOxq+nKOFsSpFH4B3kARCcgrmGK8fAV3ohTgtSK0TtQlGWrf/tnfzEal9UbfDGboLsq195+4fHnaaC6RUOuN5ZxjTEFICop5pj+NsOsm2QEBF/3ZO0CJoMYBJJlX+/OvPiJKqtCuo146Q90LRmWLCiiabVh66d6jISPpvfCnWvxsrszhB9SE6w9yakhJPQ7MQqlfrFk30o0ieAYbsNMwpyFC560Zq65Gp/9TaQS2MjtMDWfVBiLEpAYVBVxt019aKcOnSc3R/w==
Received: from DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) by DB9PR07MB10123.eurprd07.prod.outlook.com
 (2603:10a6:10:4cc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:11:35 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::a5) by DUZPR01CA0086.outlook.office365.com
 (2603:10a6:10:46a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 16:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 16:11:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 190FB236C0;
	Tue,  3 Feb 2026 18:11:33 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: tariqt@nvidia.com,
	linux-rdma@vger.kernel.org,
	shaojijie@huawei.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	mbloch@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	eperezma@redhat.com,
	brett.creeley@amd.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v3 net-next 2/3] net: hns3/mls5e: fix CWR handling in drivers to preserve ACE signal
Date: Tue,  3 Feb 2026 17:11:25 +0100
Message-Id: <20260203161126.2436-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|DB9PR07MB10123:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f9460b6-ca71-443e-ec77-08de633ee737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/6x8cQ3hmRvisq/CqWxZrmcLpnniqdyVC6IE86JFQElTogHHATInYKzUnPO?=
 =?us-ascii?Q?S3goXtdKqygC6fE88IwaQmJa6aNcXGX36pPhPfV8ZEH4K5nCkbOtwt604DIN?=
 =?us-ascii?Q?Lmh4hthw2sxKaIqvcINuhksT2ipuiKHh0fb05eXevv53LL3osKIuyORBQaXX?=
 =?us-ascii?Q?MbOLC862cdfi/Zvhaxx1B0UOxtp5XZAx5QnmbeTirv/wou6pN54DeWvVJXiX?=
 =?us-ascii?Q?iX5YPS5DIRcm9+GJHNuqXWX3+sDaRxGx9hMHTSDYr/+w5RNsByj4fCAsPc5K?=
 =?us-ascii?Q?BZ4tl+pKi14/D3TTwYNJ+4vFbp1ePKTz/YcAn3OXikas0WI9j1wAW6eMkvXC?=
 =?us-ascii?Q?IfHDS2aTZ0ISXvuYykp073xFY9G1LYieVLc3wba/poMtOguccf7gWcmQUeH6?=
 =?us-ascii?Q?M2Vq0mZtkugaf5FNosU62m0d2XjzV9uV8N586nMQNOkiahOLZjmGdbkljVGz?=
 =?us-ascii?Q?iZVFLfGqt8Llk28fbXmpeUDrR6rm6LI85YMWHbisxuS55BDoroxJGj49gdKf?=
 =?us-ascii?Q?tmcu/36XIBXePpGyyZE5aR6j5pkzn3iBsTe6RSR+V3lnSFJSjk9rGwVHJIbT?=
 =?us-ascii?Q?rkSw9J/UkC5+ra/G74KkPBEX56RRm8LVBj6UFM7sj2zUvtSvZPjor72xJBTr?=
 =?us-ascii?Q?m/VZL+pzKxdc3P60ns+pEJYBIDdKM/It0cARa4nNpxCiShoSw93+/hsvlPTM?=
 =?us-ascii?Q?QjfF3b4uDcx7tt4rVS/amJJuNKxE966ccgiWXkKIY2YVnTo7VnNs3MaRT/ar?=
 =?us-ascii?Q?q7vQ0czS3c8K4h23SPPvH0B8i9OanGNpzWibmOcsNtVTaTVqi5RzaY4Gtsde?=
 =?us-ascii?Q?Qq0Jx1QNhdq+niKLHbcCuBThVWJnQVc72uQKh64mulavWAO9F9EBFDNTeEKa?=
 =?us-ascii?Q?lt0udJcFG8trwZG0tFxEJyFNjR6RR/qFPJYDbiVIFjZ4jO82qcuun7WnZYje?=
 =?us-ascii?Q?YADcNwOPp9z6gVDa4irb81eKhcQJHddx2lYq/SgHiz94UflAMAQLQcOWuwmZ?=
 =?us-ascii?Q?OAvGYT7iSEHxkJ5ECa6Vq/f062AzwKl5kYE7hHzBOob7O7bU92Ongt0GHCgv?=
 =?us-ascii?Q?Afh9+178xGju075/xp4y2zG8HSy5YbeM/MYzBAm8aiqyOSmKilfAV8KlmQT3?=
 =?us-ascii?Q?I5kcryLsnIUUsxAcSss0t03xH8o2ynlImucdBrCJ71Q7sZPZedjototww5oP?=
 =?us-ascii?Q?5sybq10u7A6incx9w6Q0iO8U0X4Lq14oF9B0T9lohovqLcAmiAysG1+p65MK?=
 =?us-ascii?Q?HCwaDwPiSunETV0xwIYaC3AiUrPZo5YqK0dAXwEGRsHSoYy68BuocazX9kV1?=
 =?us-ascii?Q?1DoN/hPWPyw45pttV6nMqTD5wnLqPj2p85xKf2Q7+lGhsAVL9zPmonPzRGg8?=
 =?us-ascii?Q?V0kwFzWiDOmgEf8v+vFlaQCkl4NjN00UkTitjZqFmHUwTlwmYvjQdI0kTj5J?=
 =?us-ascii?Q?kLSkNufWi5Td8yNieetfNhCesC2A7WRAmn8Pv3Xi64t+Fl2AoynuXoEQbSm3?=
 =?us-ascii?Q?+meK4m5X0tDfC962s3pF5iT8V5pSBzBL6j/xov6iA+domJUI7zRn2rqf6qXQ?=
 =?us-ascii?Q?kOrJmg536eLrshcaS6LDI5SO6tIS15LIUTnI4OEpCPo0NLQrSxXbszCquv9e?=
 =?us-ascii?Q?GFe1s8GODyW9leOm6myRxLPpxaOE2EN7VVfj1Rz8j0rGNQUYSSp47RNjq2/q?=
 =?us-ascii?Q?YeARIlmCKAqCEYNmXCbiIm5E+7A=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/m0fwx/R+DKBdssG9MOaU3GmrTMWv3fqYbWsdyUmAcrjFwXt4H07rbj0wDwf+8YTzeLpGZ0XqOSLz6WNhbb5dMt81z1gs9d+4CKsI8KsiwxqhDb65eMRuxooVEVpK+qPPCqplgTyy/YnZgPfTb6ZRz+uMfZF+ezBerbabCCm+aXecOekpIV3vjGlEYv+FmoLsRmQ6+czvjaq/lSJuhA1GmdwnZ2OAsB9IqFk6kqxeXx7Iv3k9uPtYJZlV1DKONTDmHqOEGW/Js7IQg9lLCRhpH2xtLBB82ObCKUHOSv6NCfwVS/jQfpc/dYSSCUPEWd6J6lWNKsqZyLoU/TcDzlhv+nI7K2bUPvbg3FxEYrM6hi+wxf6qk/7ixvUMTbXe82uH7PpYHsLZ6/LxjV8WFlOg3pvummcYreunS3NODxp63f2zb5BmREZ10XUgU4ack4U
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:11:35.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9460b6-ca71-443e-ec77-08de633ee737
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16469-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5988DBC9A
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, hns3 and mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP
segment with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN
is only valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168
ECN offload to clear the CWR flag. As a result, incoming TCP segments
lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Rewrite the commit message for clarity
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a47464a22751..3a1cf4335477 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3897,7 +3897,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1fc3720d2201..d174f83478a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1311,7 +1311,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1332,7 +1332,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


