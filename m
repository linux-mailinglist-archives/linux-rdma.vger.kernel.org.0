Return-Path: <linux-rdma+bounces-16470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M6kIfAfgmlIPgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:18:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614EDBCC7
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1D53154221
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52963C1998;
	Tue,  3 Feb 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="J79Z7PK6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641E3C197B;
	Tue,  3 Feb 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135110; cv=fail; b=WEOTAzWbgQJ12/SAEfvxR5n2QzebscgsfMhaT6gMrLiDvI7eJ7MowD5XppcLCi5qx0nY9GKXT3YpviosnWwgFDbxlIwoLFCwFEN67Yo5/HOXzmoO5t0x2Mv+pHMuqQWDL24AhD7v/r5nmLYnIs/VKT1wY2aWHU031d50GHxUkQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135110; c=relaxed/simple;
	bh=KbLmRj8WBRnYMBFoOO0QwCShhBSyHW/KLWjnDBUJ19g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caK6QpO/viO3G98OI48ZxIHJrSUKSHAnhCBjGA0WUZc6aHwNQnTcOAE/od3M7dIBiW06hMj8nTntX0TdgJU+hkgYcUKHpeC0bGWgAEsrIGPNBbgZjJlaN062LhlWu5Z63Kb/S++5zRxrpCsKxnda4qvQW1iloVlVwF4RUQ1gX/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=J79Z7PK6; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk80ktl43tzamrT4EhIsXGMcC8BMeOcw8wIwTxukxV3G2zMYOBWW7mx8BV1jSX+9/phnFzjm4fimdJvLuF185tt6wNRm4/a5AHgWZ7fdxFXN3C4qvdP9B1DkowaA4NuqoqkxMkggBykEMIPutCA2ETiZnH15dz9ojXGcXTqwRCyHbRU1wuqHiVSZiiH6XQWZ4Sfm5UyucI7HV9H0Jp+hfhtRw8bIIn0DxNrYacoyBLQIuzD1auAOmAZKf1lAhVm4wB4Fej3Ie6gKAiENjLLyu5+Ko5MwAMqmZqAXPE2HfaG9W2eNTNCRqZd5LutcZGTjpiZ5TdI50KTRg7dyfSHf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R0Q3StBUhc41gdU0/nTfkmVJWxdAHbh1PQ46Pw8OdE=;
 b=VPz7TQ5CXJAUBvdDpnw4dkkSzSX3v1/xXBeYBzTJHtYYUn1SQpC9wbpUGLqN4ZW8zZptroPscI0+LTXs2J3aYhIP4eZFoqzHIsZrq/v7CQF/P/5e5M4qmm7r6Yf37C4tCPVD2NbTb+m+uhCGMrjC0/nUd6yH9TljGGNMwEDR1PaEkJoHjBXrDK5E6dj6exuoAeJT27oxsaqX9b/Kv5VK07RsKf86HoJuTMVHt/WAbSFzem9NC+gVPrjLfZyLqZP0Z442UlELYKVAgsPsYH4JcXg5SuwiMEibQ1FdR3loAqhiGRNwyr3PeEKRi4cxyCRSMvdx2PptTxLAwF5u1wvqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R0Q3StBUhc41gdU0/nTfkmVJWxdAHbh1PQ46Pw8OdE=;
 b=J79Z7PK6tMA/nic3+/bC9ytuuumFkYgcUnP2WE04ADd+I8rUWvuYzb0juJZsFR7VdHO853afx6aITg/IGmZfSmDB1dbeqq/nfGlVpApZeeZQQyYDt5SijDjZY9xZujtMCRAIOa1jOcOlskcbVOBq3ueTeF9tGZ2EJ2edw51xkJMhM+/AaB1mexkcsM2vpCooIMCURqsizLfrUqHfrAJ4V8mHJw997+kF65A8gLSY1cq0JZ+ua/6kk0yQZ91MqX1DnQU8UEbMNzQmDcw2YIglwMBPO1eAYLN7YMOT92d0/3tqZhCuzaaXlJ+f3Hhw+DYdrRosScuR+8wcNicCCSNYog==
Received: from AS4P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::17)
 by GVXPR07MB9964.eurprd07.prod.outlook.com (2603:10a6:150:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:11:38 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::9e) by AS4P190CA0038.outlook.office365.com
 (2603:10a6:20b:5d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 16:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 16:11:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 42B9D236C0;
	Tue,  3 Feb 2026 18:11:36 +0200 (EET)
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
Subject: [PATCH v3 net-next 3/3] virtio_net: add AccECN feature negotiation and correct ECN flag handling
Date: Tue,  3 Feb 2026 17:11:26 +0100
Message-Id: <20260203161126.2436-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|GVXPR07MB9964:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88d13139-8df5-4522-9907-08de633ee90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNEoieVUW4m1+ha4J3CepvuNlgJilSMm9rPw+cKZ+ct4GPDPGvydEkbNBriz?=
 =?us-ascii?Q?NJuBRAHq/b176AyDANDTl3qo6U+pgrrdzuGnpNlXODVRt6YL2YRubO+ftecM?=
 =?us-ascii?Q?9c0nn8xGqBoDQqibGDdNvc++3+6IBcyuV/EkXHWLkK1cJuFKvW+guZxaOKEk?=
 =?us-ascii?Q?ZA+FBHjcDHPHSTpTx9PF/qvM0Pr+zPZ6iU6v4ZxY2UwcxkDJHPG3YRX8kWs2?=
 =?us-ascii?Q?oXv0jcDZEfdZ2P/30knk9KLdtMr4BdLYblV7URe1fVIXW+ZooUzHxpi5gWs9?=
 =?us-ascii?Q?OzTH3Hhrbdazs954rGcQiQYeXh1JG4cqbggsSY5A0WrWnVsHNT06/2lN4kUT?=
 =?us-ascii?Q?iBVTaTtA2MXtOUYR6mALfJra1wwvrADVtaK8wa2sprOMyKuiZk7N2JTWcmfZ?=
 =?us-ascii?Q?yYsMnwNXtacZw0B21BKPQj3mubP1r596SyFoNBgieMsuTte9YMtP8HJgnbZ0?=
 =?us-ascii?Q?zHxP4VuXF9KBB+L3IvRvJdYP+f3gNV/BEeOmZ2rK5JU+rBIQsuVmq4wQEJIk?=
 =?us-ascii?Q?CDZFuSlthIA+ZoMIkHxfuX72Q9pvKXQSwwZpWHFx3vMqXw9AC3dKBSDyn68L?=
 =?us-ascii?Q?BZJYupcZfF6LF+rTO9QI/tc7GhhCq4cVDfhZbHjitlpqeoA41Za8vUlGBc1Q?=
 =?us-ascii?Q?KsGLnwCBXnM+X/yMz7fKPiY41EfL2DXAOfQ5gm8X9ypRoO1+8Tm8lEZjxtUn?=
 =?us-ascii?Q?JzZnp5U/jkvHIxlIkiSFcSwoVu2YfeAyKUW+hwD8NeM3qbVj14U/lGgU8ze7?=
 =?us-ascii?Q?NtwaJuE6j7tJIgZI6LxuR2FZmXp95bg1T/7xWv34QArrGAuQGpldGjaC+f36?=
 =?us-ascii?Q?nDo5F9GpONlA3N7W7+Lb0nzi1Ihf7tvjLaka5Iqb16yvAQBebi1q5DkC5M1K?=
 =?us-ascii?Q?Hmkm3evosW0q5md5Na2BUrFESVTPdLRKyxA+oON9S7hjqNCng+3uW+SBNdGW?=
 =?us-ascii?Q?iS9TzPR12FzND0pQ9Aql82Sbim+2OxfhZhbv/MCOC35KKyef85kQzIVQ4DEe?=
 =?us-ascii?Q?I863vMhAi3MKX+5Ls+AJxefuMyuPkl/A6bUbhdiJgX6cy9g0X1bCycx9lOtR?=
 =?us-ascii?Q?FfY1i9GnAinu3Dums3SlMh8b+NxXZgV4+nLBJeGkjdZBfpcXCAFbSCEtjVhE?=
 =?us-ascii?Q?U6SfuH7Nw5UjRbsQoU0+bCqU0hcIzmXOP2Zd5zfxZMO5Uw36Jm2hHiX0qS5s?=
 =?us-ascii?Q?nBJC7iFszOAJ79kvuB0Nh8JBG4qPgLNWYAcj4nPMVcsd0DRqCmoFPYuBmcGl?=
 =?us-ascii?Q?xNvI1XnU0LkjxDZcOtN+IxlLxwet5DHPdUoYsa5wrX3rJpE0wqfFYb35ZaHv?=
 =?us-ascii?Q?ydF/DCuoiNHxJU73H+Dxk+Ch7Dn3Q3bDFETEfjvIIh/leHVUntNaVYibI4/3?=
 =?us-ascii?Q?apuZleCkR4VReOcySuYS40Q5GBiB7RN7S/eo7jt6zcDyB9EitIEaPHHqVUcp?=
 =?us-ascii?Q?LBOfDUk2v3mMLNLzp0UNwHe745nQGXiXvKTrzy6Bvx+6ranPS/M6KSxMzp47?=
 =?us-ascii?Q?UEdmDrL/cBLD00yHIp9fjQ1LKoII3zZX+HTzuLrUbDS7fuZ5sF0S3ZQXeb6K?=
 =?us-ascii?Q?M4HkYa0caSBKUl7C235XrrNy/HY3S5ypRYa3E/tTBARtO3Bj77lDUvSPDdy7?=
 =?us-ascii?Q?xagsBOKLvTevuP5/pc60FIMpI6SI89kBtr8ebwDwMdpRVJhUcD/YOKzQTGJT?=
 =?us-ascii?Q?+B8uZDRLtyep4ajz7V4qzOtlKaI=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fYpFQdEQacBE8nHLRRFVU8zhXoY/ZA/a/EadKX+LRnDArgiPwpQZ3CT8380CyCoB5EHRyqLu14NAqLafTmGXev6/Ijv5d8gGw2D6ihWcvZgc76RoLQmKvcLUJJJ2Ao6ytb3fm2ZiFkvDtYv4sAn5I70Zj1Q9qHjJZMBBrVDsBYfzl2q6rSi1zT+Vh52QAve02L+eVQaWhC/Fad7s0lM80ADk7djfE/+YNNbpKhIH27qoUBRs1YCSHbK0c7jyLOWVmtmgxGF3Hbbz1ExhYSVa6U76PqmA62OfgAHw5+MA1Hiw2XG9ymCPndqjYeHfwZo+L/Aeuh5ZV8dq8vgzl9bcIB9x1cCFxXsCHSBDUDTKhlbN2voL8Mmrn0M3zJ14EacK6I5FvltnKDn3JJ4DPHDYVQH4pisiRFL8p2F9zAtZz58RDGG1Zm/6z1Ir5+CClZ3O
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:11:38.1456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d13139-8df5-4522-9907-08de633ee90a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16470-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2614EDBCC7
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

virtio_net currently negotiates ECN-related capabilities through
VIRTIO_NET_F_HOST_ECN and VIRTIO_NET_F_GUEST_ECN. This is not sufficient
for flows using AccECN (RFC9768), because AccECN requires preserving the
ACE signal (CWR flag is part of it) across GSO operations. Without
explicit AccECN capability bits, the device and driver may treat AccECN
traffic using the RFC3168 ECN offload logic, causing the CWR flag to be
cleared. As a result, AccECN segments may lose their ACE signal integrity.

Fix this by adding new AccECN capability bits for negotiation between
host and guest: VIRTIO_NET_F_HOST_ACCECN and VIRTIO_NET_F_GUEST_ACCECN.
In addition, translate the AccECN GSO flag correctly between the virtio
header (VIRTIO_NET_HDR_GSO_ACCECN) and skb metadata (SKB_GSO_TCP_ACCECN)
to ensure correct ACE signal preservation bwtwen virtio_net and the
socket stacki.

This corresponds to discussions in virtio mailing list:
https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell-labs.com/
And it was suggested to clarify documents of SKB_GSO_TCP_ECN and
SKB_GSO_TCP_ACCECN first.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Update commit message and title for clarity

v2:
- Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
---
 drivers/net/virtio_net.c        | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c      |  6 ++++++
 include/linux/virtio_net.h      | 18 +++++++++++-------
 include/uapi/linux/virtio_net.h |  5 +++++
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..103fb87c690e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -75,6 +75,7 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
+	VIRTIO_NET_F_GUEST_ACCECN,
 	VIRTIO_NET_F_GUEST_UFO,
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
@@ -87,6 +88,7 @@ static const unsigned long guest_offloads[] = {
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
+			(1ULL << VIRTIO_NET_F_GUEST_ACCECN) | \
 			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
@@ -5976,6 +5978,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
@@ -6635,6 +6638,7 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
@@ -6749,6 +6753,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ACCECN))
+			dev->hw_features |= NETIF_F_GSO_ACCECN;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
 			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
@@ -7169,9 +7175,11 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
 	VIRTIO_NET_F_MAC, \
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
-	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
-	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
-	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
+	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_HOST_ACCECN, \
+	VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
+	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_ACCECN, \
+	VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_HOST_USO, \
+	VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index c328e694f6e7..90bd95db0245 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -78,6 +78,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_GUEST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_GUEST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_GUEST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_GUEST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_UFO");
 			break;
@@ -90,6 +93,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_HOST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_HOST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_HOST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_HOST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_UFO");
 			break;
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..0cf86b026828 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -11,7 +11,7 @@
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
-	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 		return protocol == cpu_to_be16(ETH_P_IP);
 	case VIRTIO_NET_HDR_GSO_TCPV6:
@@ -31,7 +31,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	if (skb->protocol)
 		return 0;
 
-	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 	case VIRTIO_NET_HDR_GSO_UDP:
 	case VIRTIO_NET_HDR_GSO_UDP_L4:
@@ -58,7 +58,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int ip_proto;
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 		case VIRTIO_NET_HDR_GSO_TCPV4:
 			gso_type = SKB_GSO_TCPV4;
 			ip_proto = IPPROTO_TCP;
@@ -84,7 +84,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 		}
 
-		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
+		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ACCECN)
+			gso_type |= SKB_GSO_TCP_ACCECN;
+		else if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
 			gso_type |= SKB_GSO_TCP_ECN;
 
 		if (hdr->gso_size == 0)
@@ -159,7 +161,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		switch (gso_type & ~(SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN)) {
 		case SKB_GSO_UDP:
 			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
@@ -231,7 +233,9 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
-		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+		if (sinfo->gso_type & SKB_GSO_TCP_ACCECN)
+			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ACCECN;
+		else if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
 		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
@@ -282,7 +286,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 		return -EINVAL;
 
 	/* The UDP tunnel must carry a GSO packet, but no UFO. */
-	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
+	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN_FLAGS |
 					   VIRTIO_NET_HDR_GSO_UDP_TUNNEL);
 	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
 		return -EINVAL;
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..af5bfe45aa1f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,8 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_HOST_ACCECN 25	/* Host can handle GSO of AccECN */
+#define VIRTIO_NET_F_GUEST_ACCECN 26	/* Guest can handle GSO of AccECN */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
@@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
 				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
+#define VIRTIO_NET_HDR_GSO_ACCECN	0x10	/* TCP AccECN segmentation */
+#define VIRTIO_NET_HDR_GSO_ECN_FLAGS	(VIRTIO_NET_HDR_GSO_ECN | \
+					 VIRTIO_NET_HDR_GSO_ACCECN)
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
 	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
-- 
2.34.1


