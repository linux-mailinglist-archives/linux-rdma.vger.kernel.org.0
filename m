Return-Path: <linux-rdma+bounces-16298-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE/DE3CIfmlkaQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16298-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC6C447A
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47D6B30071C8
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385038B9A5;
	Sat, 31 Jan 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Pn45Qj0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4A378D6C;
	Sat, 31 Jan 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900125; cv=fail; b=RWcx4mWz+BVOFl6WaOdSgKaX+viBB3iK3ZZn8NP1Qhb5oc28KnO7AWEi3g4oQESRwk5fZNLPDLp363eo3waRIXDw7TrxuDaBpo3yF+WhFSiJoDm22J/5QwErSqLZICWdA5bRFB0tP7COOuLhIqJvr0Q8MbhJDFfsgCfJRgabxS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900125; c=relaxed/simple;
	bh=zeXJWV5ac2bS3SiVLb1A3fmFd0LZ5rh73dkyO5y0TXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep/Yn0+5qTBH64znOy5574m2XHF75cVe3Vcn6/MSw/EFNvr3Q+uIPLWKOl8N4Uosavogzj4M06ZwljY2RCizdc7mWlbqBUPu1+eAVskENnIAdoz6WJRY0NDnQ02dExymnRJ39xgAxGFuYqDaPAUVaxIM3PElDPeNvLFuLWqR0VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Pn45Qj0J; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+dTCfS4g0ggbvEAU+fDVoR7PfazYb3/RjlFnFtZMZgRH2tbUy1ZUqb6Wn0NPVMv5+b3wBX6yOQScOt1K2jY7/0y8oYW4jzjsEfTevtWKv2PfxujJ+jPzwqr059zi3FXdZZFEizpwxgSdVwQ3yvWr6vSEC1YsBtjHzG9gena+KkWx/XsMlSh/lnb9rkHwQzLS33ICISOEcKyDcTVvkKy1F8H8I4aXRzxEbdqckPKFLhWGfKwEot1OAV+6JMZ6IO/CAPJ87CwZ/mkm+re8E8jFSSd8jIjmGHW2fzrTrh+AUccUfFr7bvRBO2AIXnANWRBx2U6B2b4M8WTeS5OYFE9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3raweNhp9S1cnVwn3QXn2trId+Mh2Gr9z0EhLGfa7oA=;
 b=i/vVhUGg3XjQ+R5Q7tB8bJrKNX5NX1UmeJ6DhuaELMW6P7MU0+c1lzi/pouTrKpbOCcw2IU2yB+90flWmTh++D8pYcPPOSRnBIUza0h4b9clM2nRRomY1NX6+u8iN4joh9qV+tGNxaKkVweNfKz4oLoQzbEhbGkwQpuY4gKdjD1qNypmXZQeQB/ch9/b9k8IFYKZrDxuN9cESNGNsW/a5zG1mMi30f+21Vdif34q0DW64buvDrfkqbBby0+i2cuEMLxsRtHm20aLl4Y8XuUnrLKiW1q1rWydSETGhMboklLkQIFQreishu63tIZlQEgpOZW+7Ba45hRDASuUKt2G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3raweNhp9S1cnVwn3QXn2trId+Mh2Gr9z0EhLGfa7oA=;
 b=Pn45Qj0JGovJDvnQjbP2rp58cFd8kHtMRPTXgxLQvoRC7FRXDUR1ImpyQ7AS6wvnMJoFP4/Ay1LvrayEQm40ExniEOHfkz7iLy1gSEqtOQLkmEqxMpwLrqtE/IPQDQQtfDi0Q5yuVIBoPVkF/VDHq2Q54NxfBdt+kNs7WvDzv8M5Vnt6PVcJImX6yYTxHP1lV7awKPejf4kfrgsy0egA78qhvmrrBTn4qfiVlaDTfoRnrGnAxN/Tnu7RyS8Guk40+GJ8Zk1MLgkAaQ1oiIdXz8MNdCAd1m6J0CSZ8xDBa2+a6JMqRHL1iLppfabVFxWa3TUd5ccWm1+2zLpUjJz9FQ==
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by DB5PR07MB12056.eurprd07.prod.outlook.com (2603:10a6:10:64e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:55:19 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::d3) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Sat,
 31 Jan 2026 22:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:55:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5D8041C0030;
	Sun,  1 Feb 2026 00:55:17 +0200 (EET)
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
Subject: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR flag when receiving GRO packet
Date: Sat, 31 Jan 2026 23:55:09 +0100
Message-Id: <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|DB5PR07MB12056:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f23a3835-feda-48d1-4e66-08de611bcecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIjcDmIr94vzGNbRdkSJqUSDY4BaaHYAR+K0zBVmyOiwSCha+VMSTYYgjf1E?=
 =?us-ascii?Q?W1SkurwYyQThl/dSkV33RQVGFkF2CKU3ysdEeTeEhMSmbtx66lR+RYeKszQE?=
 =?us-ascii?Q?7KknYc7N9hhEHfmbJHGzd9POFwoVOSLRhtnoN3IEjyh7zf/W2iS0Wjy/bSt/?=
 =?us-ascii?Q?VdqOQQcmrQxdrETpJ+fOLo103n4ztCj15zk+mphGFa1iv+ERsStoPaEHq6kn?=
 =?us-ascii?Q?WYFv19bXBDSeslk44vUOSXnlOOw/OEAjUAmEnyQzPrgoKggjtkc2Od1SDIPQ?=
 =?us-ascii?Q?vi+i3ymzcScnm5tRQVGDCtslHu8MfDGUiT2/9msQAh17DZas2eQUGjZnVJOz?=
 =?us-ascii?Q?kE1ej64tFRFfnC4YsV48jbtlYYttytBE4Ej78cYH+M93fNkzgwP3TXRMDBi3?=
 =?us-ascii?Q?eFW3sFyhOhW268giRyQOZ/BYlWmoQ2Vi60m4jxtY6StVZdQMqOBZ/5Y21VFM?=
 =?us-ascii?Q?yUR/gcibt2Dr20efsLM187NlmjCC3zyVwe0ezj/IP5DziqlbNV6dvvYfjypL?=
 =?us-ascii?Q?DvyHYkWCXww4PFyX2n4Op1v4KBdEJsfzNlt5YwiHRaODhQSK/jyG6WMtBeat?=
 =?us-ascii?Q?f6Ig9S7qio+WNtJ2u91AiqdyC0Vl/BkbXHSR1mjZ+Id5kwR2Kchea+aM7ZmI?=
 =?us-ascii?Q?mTGnA/7vR3tlF4eySeSkSmA2viBPBUAdxscTPNLX15yO0iI0eewiovbQ8juY?=
 =?us-ascii?Q?RBvopnFAQRXboE0uFr36SLq7yqZw2MjujrGLOR8LJpRm2LV0vm2e8u87OkgY?=
 =?us-ascii?Q?K3uamYVuDI+RXRmLSHEzlcm/NUe8Agqx/VXFzL6EB90iiJQvSZJR56qI4sub?=
 =?us-ascii?Q?/5gkcfvK0ke04+LWKFIbhX/Bytk/gdXqBKzhDR0TB8bxVj5GrIYU/3peWlmi?=
 =?us-ascii?Q?FoIR/tXUjeN849OQuBxI7CyIyAX3vMOR0pjgDkjlwvv+KVd4dv1jqPUTm4qV?=
 =?us-ascii?Q?bBSgg3wa+FXGmDnqxcu/zC7UK5Ob7uTNQU0Ihu0A/VZqJ8OkRhMdwHxbGb/1?=
 =?us-ascii?Q?S7S83bTklY25bBEYGZe8EoNKw6afXAIvj0FNbS/pINTiyTZWWzpdo1PRLXen?=
 =?us-ascii?Q?GbXrAEf5P/fzsTqdfK/NcdW7Gk4DNEgtgU5vUCCIFdAGh3lnendoebNwI3mk?=
 =?us-ascii?Q?R7GLf76v6GCigbBWU8y6dDF2u4FT9CNfwngZl3UdvXcSzjYQLV4tC/Y3gLEu?=
 =?us-ascii?Q?erM+ecCWYI/Pahg3ACvwsJH9l4sZlAU9BB+gMEqq+cRO4kKJtqWisV1mkCGC?=
 =?us-ascii?Q?JeTyBo9E+3M1q8VE8Fr19CVa052sFaYiEcv36p5ndLpcwU6gL93zKefUMqJU?=
 =?us-ascii?Q?oxp56KEYg0l/1HG8YKDGPrZGq8VACid1DYjKzj7abNFdfcyzGxfAgXczm5j5?=
 =?us-ascii?Q?p7cbjYb/+lvrLqX/wOOuizW001If3ihp+G8iUa6uagtDZ1XjtAA3IxnDknzA?=
 =?us-ascii?Q?RGnYPkdQomfNUzfEJ3w1e1yU1MzzAYMF8d6EFtuC7FJV3ASRNR6AEk2HKDWC?=
 =?us-ascii?Q?OAXw5hVAsDbC8vDkh75krYj1CQOBUCRyk5JAOYhjL1vth0LogLEFVecW68cz?=
 =?us-ascii?Q?0WCplwG06XPI9K8YQxowS64bEAKzu6vTJWNlzy2TjY6poUB1Za5Vg2Nag4i4?=
 =?us-ascii?Q?5Xgc2aQFCKrRXqIMf5oxrOkSciQWT7Ita2ypugS8ti2vQoIs49kSo3pbTb1t?=
 =?us-ascii?Q?ltvQYdEOnFTmlAXmBiT7/wxjc2g=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eGne2xfoyMmkwhXHXtQQdXnjcBcYMb1zufnDCUk9WbfWzrtLVcAb1OE2wxaRG+wnFG2DpfNvg/VkUcu8G71f1bumwfT54kvdQHJelZgf4ZUBUOTtnVMV7gJi4AKC0uXKJ0j4JmZaCEhd2x2Mn0T2g/8fqUZMo0PMQC7egWvOaLBjhFYleRTE2mcBG7wgaX7GHPUq9HwYH9Vm8ZqQ1BYHl+YK20HbAvQxqKciHffgDDwigGBQB1D9OgJqwl/+/c49bevIqv4MiIm2YiHS7KCE5mkLrmBUrTgi9g6ffwl9lQ13shjL4dOloAGoiII+5rFzrzjLXydseMu8KLg6/tROOKdUwDVUuBLHKjtL40rSld2WRV8OJJGobmfq2UTQQR5hr4dmW+HO9DNDGBfIdv1xDcv++7FX2ve9NBKEe5mOzz978eKnKyHlYZUxhkl7beRU
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:55:19.3922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a3835-feda-48d1-4e66-08de611bcecc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB12056
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16298-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7EC6C447A
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when new
CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not knowing
the ECN variant can result in header change that corrupts the ACE field.
The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or
NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR
flag somewhere.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
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


