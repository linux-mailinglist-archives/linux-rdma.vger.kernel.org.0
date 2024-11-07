Return-Path: <linux-rdma+bounces-5829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869E9BFF97
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5A1282E40
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98719AA5A;
	Thu,  7 Nov 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imkZLbSa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2A158218;
	Thu,  7 Nov 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966666; cv=fail; b=Aw9soYsFymJxEPlkRgqhW1vkYNmABpKtcIlYsrkErZdaDpvgju118oGXV6FFaVbOo6AHy1ciM+uQMLdWFQBl/GmLsJRuDHUrwuXVkglaZw0LhQHz5sJmpLZKpfHo98JdprQUKLoaq8pJqo/G4qb1yoFxFL7rh7mfgfFrQcJ7OmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966666; c=relaxed/simple;
	bh=ncle9SeKtepsEI3IDufpeHD4ZWhqjBnrNRh212vFwYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5PHCaQnqyc/ffFQb5a1VdkGnfuf7Oei31Rpx20AACVhQ0a4GL2h/Y6ATqKFukaThmxtJP1u6SnQNLcVZmnhv+uPPcm67L7oXKeYo9y3972V3m9QNVKPGr8eBZLpRW4mKWZ3sfwzfs1UIFqi7gWOWh11TKqZBlUdwSfgLph86Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imkZLbSa; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyGLBjGP1fN95jucpT6qH8b5aU0edJ+enHLrIVhMlbOMsD8o2Y4D1YqvbqboW8jXZ6fdHXzuAWdCu+/eCT2oNK6OlxpauPAGIlV5M8uDqAjFp7ffFGPokoN20uHMb34Urg5+qJ1eSJphLzE69y4dDdphySL7cZWQBayoqRvuGLSmuJsg7InRc+liWFvFCv0S+6EhFCjfx+YJFz2SvD7II/6P4h48JXPYA5ZGFJB2lgXOAkBnh/nAS1eMSg/UrgUFyNLQwYjGvUjHOvm5xh0f+aNoyYz1eX44jYXJW/grZ6H6WlPU8j+IZo4kShtOikFbETidil710/iU1oQPCI/z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WszNR1Ann5KlTSPBb8SuFfcM5mgaLX/yJ0umeESdJoU=;
 b=rArOVThPMJR0NzNhf5vGI/WtD2T0Ko9s26gAQq1Cz0lzBk9nVNQybQAPJEYS5gOeOGNeWFf1g8ihTjlr4NKE9rsMj5CzWJgVXKUgxygBhludA10xjs9O47HOQNVCgag2hemEurciG2/ZYnHLaplKu1kkr+ID3rzSDgMVbXhz/aerDbLhLCXbktiA6Vhp1CA4bVAxiR6XXGZ5Oz3eXx3AB4F+TO4Wr4HtdeMxWue2EpCd8Ag484vSE80AGuGfiJcAJRX3bq8XBtxw9EPfVVlKx9oBqlgIKYItYNCU7FAzM4XMY5zGoxehOGNYUqJwEt5QYQG62vmcvwF+2fxNkIYYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WszNR1Ann5KlTSPBb8SuFfcM5mgaLX/yJ0umeESdJoU=;
 b=imkZLbSaJaIPhLLqQuCHNB4oW16EXJrKs9LRNThF2M1hNOtwzqHmTybCuZoWEyxRp/uPhT+a/aRORBndskcB2pVaHEPolx6RXlnxapuxwl7PtjcXCKR2UxJKCXcamUrXpGI3qnTbBiOSL6p4P74NbxPttsNMCr+1MV59nQeDlD+Ptoh5ZhX/AwEcB3RgJt42V0q9Uct+oXwSHzp78L85sNor9oynZO8kBzz0w/bjud0ogBSqd0ZacBoidz30Qjl5lE6ajV5J1nCeBGEXs/rKhns2Nictt9eguLtnxjyGCuEu3/gsPmT7MEpfedsk65t+iLY/K3bUQFhxLRyWEn8InA==
Received: from BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35) by
 DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.33; Thu, 7 Nov 2024 08:04:22 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::ae) by BYAPR01CA0058.outlook.office365.com
 (2603:10b6:a03:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 7 Nov 2024 08:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:04:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:04:13 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:04:12 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:04:10 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v2 iproute2-next 3/5] rdma: Fix typo in rdma-link man page
Date: Thu, 7 Nov 2024 10:02:46 +0200
Message-ID: <20241107080248.2028680-4-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107080248.2028680-1-cmeioahs@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 184698c9-c565-4b0b-6f27-08dcff02c9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/R+pazt3tS0D25wvjwe5pEJVUibpowewLVh3DIoaTTLgRAsTtE7JWqwbXsp?=
 =?us-ascii?Q?/X6qitsWeNbQT5uj/b6QkGz1NYYmTo8nGzz+bzNwfoYZXGzYF4dW8JROYTQq?=
 =?us-ascii?Q?htRY3tf3fErf+wpkVvU2fO8BvCXehTifIZh5fRt2zy/3/XCjYh4t55qiecaU?=
 =?us-ascii?Q?vO4ch+ccTnlxK6bu5wj6jgDAiRxd5mJK4VNcZB1EZP8Tz0nsh88h2Yw4n01k?=
 =?us-ascii?Q?Tnf1LCJftKXigttNOeM2OgHFHbf61IoA1DBk6XqpDKV5N/gQMI0Kr1XKAHQq?=
 =?us-ascii?Q?p7/W5GpvvCmKHgWV9yjE04SMGeIVhLqDq7aQ9kjO8rHdouAWtTO/npZRqZYQ?=
 =?us-ascii?Q?aShoFlRDYfI9F4PrberLj1KnJkLcf4IQeaBibc/ku+/7y/GgCdtnLiZ7VwiH?=
 =?us-ascii?Q?bxzsJhyOEeKHaK1dD/2oAGyehKyhsuE5qGbc2W8EWnnVNU2K1IrqPDVcB5HU?=
 =?us-ascii?Q?LmgdsCv2gFS73uRIWDgyFmBTxhZpBMojyIcV3NcKAQGxF24iULDL2jfa1+Mi?=
 =?us-ascii?Q?YHY2V8P5J6OJR4TiR5awJAPeC2MsEbA1nXRUEBSJQd9DHN20Cl60Mr21p09I?=
 =?us-ascii?Q?Xyp2x0vbkvmWXQa8LpMGu2KYpNOycBQ76iimHlQfpeZmRC+9oDdTqTbqUhVe?=
 =?us-ascii?Q?P4z/VNGPiSAk/FsJeucFhaOONQpi7dh2wcu3dqiFL44MiDG/3XvV9TDzPVKq?=
 =?us-ascii?Q?D+v1AdXH+tvHnO1nEEcAjpPZeg3srLha624oteSwLSmkXlowmCMnQ+XwjjCw?=
 =?us-ascii?Q?Dxp6Z3/sz1U4PxUkftpJJv9F3iW7cy31rxdHB1TNntbQ86P463H5BVFtIiGk?=
 =?us-ascii?Q?DQC+BJs4YQqd2tRzROzyFm10Ijpktnu43/IXQivlg7x4Ng0/AZ0xU+nZiH1h?=
 =?us-ascii?Q?014sJTOpOfShJjUn+SOofK33iROdqYRkPDCv5qBy0QPQDUbyHNr3pFJwa1sA?=
 =?us-ascii?Q?7Zz4BhZAjIMcNogApiAiKB7L7zw37NDJ1YdX2FudiKmFy9r1kc7+tGUH9KSL?=
 =?us-ascii?Q?oa/3jrR7jS8QRTr7X09fRsTejEFs/VAbIMYWHWrO+BIPt8p62lb9Nk5sPE90?=
 =?us-ascii?Q?2HpbXU0NQzs/6NVAc3B9dMm6Trk8MOWFPZEQsl8XQLRg/0+Lda9mr4ZjCVTw?=
 =?us-ascii?Q?MFcbz9eZtzBcoL4nRzWGzQwbZRqEh54nZvHxxwLkKGDQi2+z1sYOI6D0P2pQ?=
 =?us-ascii?Q?MG6+C0Eq62AiIP4xx3gGF4wnO0TUdwM/XSkOZ92KFFCCk7Lc5VbxB2EV543k?=
 =?us-ascii?Q?AqWX0PBK03GFDQmssqT+VLUrmcbcwd1UjgD+qYoJt8OqAoi7QrqAdx+LBREj?=
 =?us-ascii?Q?NMIIkdkx0VbOVZamiuqtJMp13LsnVujgogRU19wsUMdhyYRve98fMeyubDfP?=
 =?us-ascii?Q?2tKViXWejN1QMzQg44SGqDbFrGFbrRZ+G7cwkndDpMfa3sY9tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:04:22.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184698c9-c565-4b0b-6f27-08dcff02c9e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

From: Chiara Meiohas <cmeiohas@nvidia.com>

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 man/man8/rdma-link.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/rdma-link.8 b/man/man8/rdma-link.8
index 32f80228..5e4a5307 100644
--- a/man/man8/rdma-link.8
+++ b/man/man8/rdma-link.8
@@ -6,7 +6,7 @@ rdma-link \- rdma link configuration
 .ad l
 .in +8
 .ti -8
-.B devlink
+.B rdma
 .RI "[ " OPTIONS " ]"
 .B link
 .RI  " { " COMMAND " | "
-- 
2.44.0


