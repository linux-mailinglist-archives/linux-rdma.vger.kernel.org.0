Return-Path: <linux-rdma+bounces-21918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWDXFiFSJWrEGwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:12:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E59076505AE
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:12:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ATc2gEZ2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21918-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21918-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61E0C3003814
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FE38BF7F;
	Sun,  7 Jun 2026 11:12:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837936EAB0;
	Sun,  7 Jun 2026 11:12:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830750; cv=fail; b=gjzEJ8xNidInVYk3ugh/B5MRhP3K24/Qp5t7hcVLm4lURhVnPrlghoQEfibgrj8iJz2546rZJFbq+tPi3yxbK8fAjgvVGCTKYocRlmpi3uV4B2edzL2sk6KdKfIE2Lmj0cLDz9mHZa3ffWcLS84cqzzUT/8EhxjTi/ik6ej+mBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830750; c=relaxed/simple;
	bh=70BQyJi5fTPTOKyOxyVrTWxNO47y7qAK96mOGNmVU34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atjImiKHHIJsDfgwuTRwXXIZDY+87z54+Sy9xkFLPVPzKLr5UJYQ1GLWhEeg/k4NWOr2piTaXr0B6idsGEbbzyR4vN7UXVWMcRGzabrnGophA1MpkgyazkJEFhBETDwiyCyKcPFc7D03zfi5GZMlX1SebCUGOjfHyWVBW8vNPnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATc2gEZ2; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2rVCouiAcpKMrAg2fZDJbQgwIA9WnW8qxFGos6DYl1CBkC3k7BRGXwEQS9vNNRRB0+9HT98npmIYUFVL+Lt2EzBoB5NZ7CSfLfT2OTwSt43FhKvXer/uxHYO8fLqiQUGbrijcwqk1Gkfukon5tZ13TThYocstiylxjqA7Oo0b0R6CjYSWUluchLDhN9GwFvy5+xitcw2/hHmKNS4eJtt77bSM1+3zUYfr/6SZlbETMPerV5J47Z66CIQ/Qu39Sj5wbNTktkIRh6GfswNtZG+ijAEt3CT8VuHhaRJsvwo77kw1putA8Za9WND03cazbP0PSuxr+Bwr86hZwY0w/Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/ZtBkKYInrET2Y1mayIVQ6B8n2IL+5+lWZ3aIwF7EA=;
 b=sPepv4Zl2g1v8XhhcVCCMSHZCHAXMAFY8IOnNGRgQ9DnP2W0UvHanS8uAssGLW1zP/4m+63hYtWQEO9BbjCUPJosiaepCrHf7GCuTtpi3Fz2H4FBcpjMun5Ir/FKbiBBpAc+85BUgUBBAyrtDr2NLzJuGl0o/P1rB3FyX4JBnjOPEGzseg4IsztiitaEL32bB2xrV26c5AwydNeyVb1ngRP6n4qM1+pMlFPkk+1wXDXmjSkYR6eAntGtvdeIPznjig28vJG+TAjhup3zih4tPOezNCQP+tdpmWZjkHidju19vGxVVIEeUziIRezkgS7cZjbTOlSqO8mhuBurVObqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/ZtBkKYInrET2Y1mayIVQ6B8n2IL+5+lWZ3aIwF7EA=;
 b=ATc2gEZ2j15mLWxLN/IB/7fKw06xdTeKHx+ZL91YosnwFnpDp1g4mSet/UdnszmrfrhvvCyj/FYoeTTKMz+YKXq1AgnpoJ6H+fSO4ZHueBNGfqjmDCHQWlCzx6StiNNDPPsDIaq1naXmhoYj2AMp4kpA8Qw/yDWI063fHci59LziCQDz8sKg9IDzL/kUFgdxYP1s9UkuRW3f2Lr5aofhxB1QbJdj9oWoBmAVZpsND996tt6gQEhkcZInhU0HSmWRW31xon4q5jGGesQuh07XaQ1zDq9RKSBqV2iKRVSumu+kDrAf+JnSV0GXiVC5GOniaN5XUauqBZeCli1H/DY9dw==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 11:12:24 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::43) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 11:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 11:12:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:12:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:12:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 04:12:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [pull-request] mlx5-next updates 2026-06-07
Date: Sun, 7 Jun 2026 14:11:57 +0300
Message-ID: <20260607111157.470978-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0a3127-e731-4539-664b-08dec485a6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	lsLfCsp0I/zi/SBEWxVrJ1UKJgIg8aZZ0vP30tDC+Nee2dvlAILcZGG4z52TpDlk8adLyHGekNJU/jLguPt6TZEsYJFVRTW6e6D0Rk68EiFgbkmoAolFEtgRCSVpQ61ab5NsQqgnmKvst6B9jsM/A0oF5SEDtqE/B3lj6XzXqjAdwdfH6xbixOmWGvFWbvN4OcZO+I/h9gmv+simEj2lHKbhJaElduNHWgUC5cUYSWVzCO2fd17j9D+or6apBRpN2mTUo//0plHtH8LHKByNLkCG9KVst88MjXKKlLEJ3M7/B1UgPeia/KYMIFAB+ebbRBdiWYWa4VeXMxAHJW8zrmBcGk/ptG4Rvpul+TftRtVnELb7323j0I9Zt1g1b9rNBCX7nawVVboS+q9BR0E8X3wbNgDwR5HloBbqDvEVjn/0/NPiDKnVD8DPsl91i6F/BT9Y9dFUVWKaX6MUWUqOrRmdoQwPS6Hwi8OU6SWbm1me736gkVI+SqCh2VfpkttwBt79maR7XQkgmQhpXVcrxdjYz148/SJtVkPxuNSRjpURPu1yVN4gXQhddLNsq0xraN/kBbulhYfo8wzKPMTgkHJCiuuuPOMqI0HoWD0qGk6a69Z4169VTGt+TOj9+963rQ5n6D9JfXr8LZu72t3oNqbW7OTpdBvrQlpwfQJBwXdo5bL3u3iZjuUq+ki3fgcgwPEeLXwgK4Tz83B5MQyRvii/mLe4VPzvkU3od3FxONw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ETcVqSu9VSSVrWZqfsA7V0FmvD6CMGmPXMiHD83gB8L851EsHKIl5d5vqd98uiSNXuywqhqa1KYdOlFbEQ38DpSMno8ccgd1vLvcVgh6/3VksOClcYIBpA9sVPdcoQiAdLpbakYTYiJfErIAnWTRQ058xWHYc2OkSzpLy4mXJQzrUuHf3kxW5bQBG2DJsgX5UM87O2EVTjNvR/egXTk48JjcRTMl7vQP1FlDczFDAS7hurY/YGiAoPUpyFt70qVKJFNDsD8BFbxhNfm2F9lR/JY3DrJs8WUw9oxfHohzDokRsj4WD/RFhMU+hA4Ac6Zbu1IgQ0p9MbcgRS7uGL4EmJ3NoRX+o0BUFWBZBQDzMa3x4lcWFvNE4xbZHg7GgC0J9LG1162BH1+NXXPm+50iEFDbMwWjC6gGEM+RWhRudf6bI59q2eTCYZxtfcLFiX8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:12:24.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0a3127-e731-4539-664b-08dec485a6e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21918-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E59076505AE

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit 02c54621e81ccdc1907e2d735bcda751f2caade1:

  net/mlx5: Extend query_esw_functions output for multi-function support (2026-04-29 16:28:30 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to ddbddbf8aee54bee038149187270c93a45478473:

  net/mlx5: Add sd_group_size bits for SD management (2026-06-07 06:10:07 -0400)

----------------------------------------------------------------
Dragos Tatulea (1):
      net/mlx5: Update IFC allowed_list_size field bits

Shay Drory (1):
      net/mlx5: Add sd_group_size bits for SD management

 include/linux/mlx5/mlx5_ifc.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

