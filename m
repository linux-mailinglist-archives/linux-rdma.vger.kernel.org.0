Return-Path: <linux-rdma+bounces-19552-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g0rxM0TQ7Wn2nwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19552-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:43:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D1546921A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7200A301E96B
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C253446AB;
	Sun, 26 Apr 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IaugDa5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9D342C98;
	Sun, 26 Apr 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192741; cv=fail; b=bEPRYSIyiPIg60lCE9MOToENDmlzze+5wDiHKlz+dja2qPRmsXktu1GIH/6PoXNSZiYIFA7dn/Cmt8kE+3SF/SUOo5Sy1CPsgjyy2k4X+n8aMzzI7ZMf0ELBP4634fxsnV2NoKPIzzwmX3pEpCegsYGMIJavkciUzFdbRRBlmR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192741; c=relaxed/simple;
	bh=RLgAWE+OZvKH+iY+OVjxd7PTEIFPGabSTvSkSKdYvA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bVWqNA60Y3o1Szvxydte6sgQrDfb1U+0dWhUlDRHXTCtneEjTpi82CC8ROqTm3f4udoFdH2GaOJDpDpF3sAKiyiK9nASF698IxBbUz4qmiBj5+URjc7PzdJpcD5HgDRHGe+5CVcxX7RqWz902fHQfUoSfPXtcOU4spmsbB4uQMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IaugDa5o; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEoO5TQ1ZbghCv0sXGxp53o5aFKNW6gPJVLeSNJ/y2cPNSCIPr53OyCgGbBiylTYMdnQKSIR8+sH80+bJVnAJTPZdfmIJyshq1SZgNdjGRmt9/GcH+eofIaCU4QoucJQ8rDgO1RPPc8pLGtmiKr05xCrZwwg7tQBizvX+t41fzX/Cos5wzgPM/u8aaVy9mvqfqfwGJ23Yu+KpgcoxF9qqjDOQ0lGjTgcl9uLyRiSOVJDfz7WxLx5tvBxR086EyouJYWI3kr4sbToN8bkK2pWrvXY8/vBYmUjTo7YR2fIF1boTLm7lk1Ha5vpi+jn0JC2hSlZlZvWgfhx+3aZ6VDwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASD5TSYm9Y9PwjbLUR7uHEmVZZH8chZyiEtv+0ypBfA=;
 b=nrvsxejzfkFJk8VKnPQTqLyX9oQIjTLR/RrzIJcSHRShp1LaFmEmzverd35ckUVFKycGeVX2saXKhfCUDbjO9PfMjGWOAVsLys7YhBLtJvrv3K1YBl9vQe5k3NE3Tkld+ZBpAq4dHJA5a5aOTbl8Z4b7X/Hob7EAoM5mKoS9PhEoehrzRYTPVWKMLrlMc2EjfYmltt2AdrPOkmLNC+kNjSnppaES8VPoEBt5AjH5uy9V5PUYM1qoDd5pRlKM4PYjuDZz9xPmbkrtc8i7Yvi503T0wXbh738dMjd3EhSIAvgk5VVIUcj0rDCar2O9pPiGFkehu7sSo11CEkTDcNkkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASD5TSYm9Y9PwjbLUR7uHEmVZZH8chZyiEtv+0ypBfA=;
 b=IaugDa5oNg+oWhvEI+BMYzyTooHTfZrJD4GqcEBaLN0aUCNPlR9BfVH9mythtnwJ8Dv4y2ZOnVVmLUcNcUFE7ii9YzKAYaupGAve4b5/be53eYpND3UEQ6W34MaOC01z+RxQ5N9ndGNNCuAxTcv1RKU3L0XrF1d2YsvX1JSCRs8AngftUyltKmHK5U5KLJx0bwnexo3Hj+a709aIgI+pBfAT6vjzMB8+LDgl8R7EUuKDa4JTXwukJzlf3LHEksNAFZLPGJVRJhyH1f29Le0qqR8zu8mY3KT57lw/UihL6+fiD460/gJC2oKO8Ii3aRTzyS7naHB3/JXHlt1C3ycAKA==
Received: from BYAPR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:40::31)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.14; Sun, 26 Apr
 2026 08:38:56 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::85) by BYAPR04CA0018.outlook.office365.com
 (2603:10b6:a03:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 08:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 08:38:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:38:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Apr 2026 01:38:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net V2 0/2] net/mlx5e: PSP fixes
Date: Sun, 26 Apr 2026 11:38:17 +0300
Message-ID: <20260426083819.208937-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5d044-4be3-4621-0817-08dea36f410b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kdt1EF+w9stAwDDgdwbnBQKvQcIY/qs1G+9e0VWeJN6gNriuHSwKS2VcWcF9SuAN2lUY4x3E31WtVGq2QAYI6rSrGlRgwWr0/WSM0P539a5xd9nQ0NUxRv548IxpXL80JOzqGVoykaHyPqTk9LU2hDrKry6asyw8gL4TjjnwqsITrF7H8dU+PT/twFEr8fCMrRqpWH4BNNWBeWaxihtTOtdQ+OoSIAg3VNEJX9ojUWHSo4Ia26OxlZun9Y1m48XiFhZE9KT65g6nt7mFwy8h4jpER34vEeNYpgZtNG7jQiQ/zIDnOBx62xajEpg1G/niLIpciUCsPNErjsq+wp25+aPYjakpbr7DRcZrDKdx4ibBovvx3zcXKPtYN1nnZGD0aCOK9QxcYkyiWhoq/MBM/4/sFN4ZEG37LHxDDhXfk8SyB19LQaXb9Q7vpQ8adW/c3IkxCZQ9xbHfhdoAeIxqRoKqyPQYUXMY1ER4QsGkElVQUqC1h/HafDW9eQWxAQ2c1NnJ+6Gfjurn8ggIiaWPpxfCZo/X92LA3PoREwds7Tk8Fqh35Je5csmFnyJv6ko0QnBA/ztklMlpgnrMnkxKFQqKEivOlQQ4pPsuUHq/pPLbdyx9NKllNS4+4nZZVdualQaBCtB6S5ea76ogJVM8jYAFubbGoRPobhwA9tiffM39XPuZIyRhCMhRvMtdXyzW2GvGnegezcA1ziUyeeyJ0+sg3R3TwYlzACSLRW3gL9/H7h8PS6ghHtBeAIjE2F7TWh14Cg8+mvPBfMvMDQrotg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1dknxCvu17rYonwe9iqxJEuqc17pDhg3+RjNFR2P7WyHFv/GVWK+umOmhpJ5/oS8HReKmKqhvj6H3oeWmFe6XzxJ95Egpvcdo6e3rExtLx+l5fR8aSok9/DSUhzE395xIpQgbeQ4bd6i3TSMvvr8qhTpf8hMmvh1+GS1uwYEvqDaG9yp4wmKHFo3gVQxfELNoYNp94r4C4r3or5SwqSvBXJ6IZtZP9VkObrjEimuJWBDvah78ucC5g/CSix1xmU10C1sGS/g3nzIr0uBUZonPmMwIDUzTnH0ly7NwN6VP4pacBKa5E2s6OiXHiAKFiezkkrMynLJcgFTBHSjalT9ruAmHEtwvyPyJQ91KiHjrhoLGNRJhIphkcVyBFtY5NwghLEZ5RzF0MOY1vY1C0TDp7UQx2GJS5nKACacLzNxFVblMbdHtFoI+Ryzwn1p1ZB0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 08:38:56.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5d044-4be3-4621-0817-08dea36f410b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Rspamd-Queue-Id: 25D1546921A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19552-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

This patchset provides bug fixes from Cosmin to the mlx5e PSP feature.

Thanks,
Tariq.

V2:
- Link to V1:
  https://lore.kernel.org/all/20260417050201.192070-1-tariqt@nvidia.com/
- Expand commit message in patch #1.

Cosmin Ratiu (2):
  net/mlx5e: psp: Fix invalid access on PSP dev registration fail
  net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable

 .../mellanox/mlx5/core/en_accel/psp.c         | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 2 files changed, 22 insertions(+), 18 deletions(-)


base-commit: d40831b016b4986e70d20d0ad14e6a0c62318986
-- 
2.44.0


