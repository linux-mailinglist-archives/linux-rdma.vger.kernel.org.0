Return-Path: <linux-rdma+bounces-4677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A996741C
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 02:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1FA1F2202C
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD102B9BB;
	Sun,  1 Sep 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nn/4hnT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF829849C;
	Sun,  1 Sep 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152144; cv=fail; b=thtPB2bmkZCigm6cW8lMLcBc/kD0zNS4zVErM0gi14VfmjQcth+RRJL8WVq7YoU3T+ddwqF3dG9NWVUjkBXFGr56m/qOd3hGmCrfXpz+2WL7I+lbkcGAa73fhV/sI8VIvBKuBdTlZBOo78UuIKF3QsIV2gUpAIAN2CwZnSd5XMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152144; c=relaxed/simple;
	bh=TYhx+H8NOTNtJbEPjHWVQrY446CTlQH7xfy9K92p0Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFKUEqc5hRkSA6+9JQ4h3RSUDaSNOmUKtzvnepIZWHX+xDHQ1bnJtA9QVHTwrDUUTiM0buq+Xr/Kp8AxJj5rbgWor9UTsQkijeN281wZYHc87sVhOy0WIl0hs8x1zSLWlxJOY6XBsHjif4559xdUI3VzFm2POpoWbbUlRwpsWYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nn/4hnT4; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/2TuSzISTqu6skA6Oij2B2qIFc3ZHAUX8902SUc0Z9DPEYMwjKunjrF0qphKJpqJ+wDW2OCppTbZG1YtCp/Ft2vEYEUNDMYIiiSKegoWp0lLADMTc8dEM+S8iAIGOy40KZez4t+FdSWyMPBeF3p7rfB1Ix4cT6lbrVWxj98sP2BrKO+/Wv0qXPW+a29kGgQifT23wBgwfrTHgG+de0/3OscQuq2hctGCGdcdG+X5BldkOLv2/4o7+wcrBZguvhw/wxDNjfgXS9HE+gHl7YKip98OVQhL+7fvkVCYdIJOaDFttOGDrnrJHGbgsGsr90Z6yD6PxxcdTAvUhtFKnU30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxPtT3lnJmHk+BLsxqIPQdfnTzC39Ld4V+FKHnaPzc0=;
 b=arwaMv+qlxZwwI1aV0cSYTnhQmQNxKqDVTFQpfVzmlagQlGDdcWyGbav9yhNW7Y+Xs9poQq/cgi+UXCDimRFv+NkzVQK1YeOagcM6zM76wX1tQeV0CEiuSz+nYlzUuNNy6GdbrjNLJ88yNAqEoNBgG06FNmWbpVgK+dm2G97VYBIsZFNZnYRAu7oZ06xK5sROrtkuulhPXV6BZgDbjtFn4JoQ6mdzTnFssrjlYyv8TG3HinTyV9pHHXda4aIjtVESQW1wfpvVT8EsngH2yZLOpTf2/bU16F6WCBYcHmjNFsoRJc9oJYxUpJAdFAOw9YJ4g6hFjotKJ9FI3o/VeHZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxPtT3lnJmHk+BLsxqIPQdfnTzC39Ld4V+FKHnaPzc0=;
 b=nn/4hnT47RtlOQ2Um5WJFLXBy2mIK7zP5OOFjtWgME+8+MPTRxyqgqLLuaLGDQgQ9a6ZHIcwj9zDzOvz+3KUrfogRI813nm7lx8xILjWqXCTcC4LX+fimRQXmYTAYuTZ5swPnC4riJCcoMRJToxlfYU1l0hQ2ZGlJrxl82GI//1ya/TGhnDIKrRMU4Mi5nfqF/Fui7j36KMQvL5nvlFNVGMfH2c3x5GXFKlJNyTk2D2JLZdFYaryiQ2e+9L/CqtyIbfmlfWwhK+l+2EY0Qdx2pDxgUcpi4Lmo63JNmSNu4274TSY9SJSBGZ/YdMFyvjSiqHCGT8C0sx5lB6kVn+A1Q==
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 00:55:39 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::9a) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 00:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 00:55:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 31 Aug
 2024 17:55:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 31 Aug 2024 17:55:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 31 Aug 2024 17:55:30 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [RFC iproute2-next 4/4] rdma: Fix typo in rdma-link man page
Date: Sun, 1 Sep 2024 03:54:56 +0300
Message-ID: <20240901005456.25275-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240901005456.25275-1-michaelgur@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 11221a1d-49ac-48ed-e826-08dcca20cc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhunmlpfFbB7593z0czxWCEqkv1Klz5v03hd8A1Tyjsyf/Ex60gL4pAjuPax?=
 =?us-ascii?Q?+W1B/aEKGJIV630DFLnj4hgZlLNAr2Bx3oDZqA4XtqAJHr6D/GzRSFnEWSlS?=
 =?us-ascii?Q?FAa20qdMFY7zWhpnJQhF05Q9740ZogjApWaDyYifr55b8hpjEu9o1ZLIMghq?=
 =?us-ascii?Q?OEw1uqZFA7ADPnJqD+LeC8EN3oqAFki7tOh3WKPOYZPOz8rzLu/yjvVjT4YE?=
 =?us-ascii?Q?dPsKwMId+sNSbABuOdikjuq3dHdc4HYOFbLHGcRl8Gw2k1i2WCO7XOqRHLCC?=
 =?us-ascii?Q?D/3kNZDNDDSaRicmrMxHkhGlP8ifkpA37dzm4ZSY2S95/UXlA02tK9m/0wNV?=
 =?us-ascii?Q?oScN+7KeqjlBqPDc5XbKTtKsdWW6kVcZhs/57ieEtfJYPnWYc5Ke/+nM6wAJ?=
 =?us-ascii?Q?zMUq9hEAvF8WLVDtqySrf1jkzy3aJ93pjg3xRpGTZz/MeOq7gq3I/qlZzwEA?=
 =?us-ascii?Q?cUcg9mFNfY7EnJ3ZKhEUQXhNNaPFyRHZGIfeUmwY8ymeze4wlnLyaDYxoDy1?=
 =?us-ascii?Q?WRW4HaaObBYgMkRr+bVyJDNOetKM+F627EUezmApREGrDJM7KjJnF7PcBBnX?=
 =?us-ascii?Q?PpwkLwQQS219rkzEaL/kAR8FNbIlweQSQOsmq3lKxjwAg4kf3A65vGhgfAy5?=
 =?us-ascii?Q?TRPQOK/8DP2it3clnoGCP3UVPMaPTQ2HYM92UNdHJlwA6uRdngQgM9s/vP82?=
 =?us-ascii?Q?+sjmi/dz/XWOIOlHIsePsgGB8zNw+sBXHP5QledOMYrfxQ9Wc+lAYh8JI2qQ?=
 =?us-ascii?Q?XjycSDpSFvJvYNZnjYwW0dB+RGCDb0tcO+p1t3yjfe5OWe+xRGlBkzfMfqgv?=
 =?us-ascii?Q?crBunri3ivcRIGJGOMmpZutipFevzv3cfsCcgR20WYcy66eSjkKZWp7zKAjB?=
 =?us-ascii?Q?0jy0SFOiWQZFeEfFZag+DEzs0+MZOKt7fI4Q2JlU+Y42J8EWrxkloy2qUGEV?=
 =?us-ascii?Q?9sKHMzmAN5GYssdkw8k7BoD3qI+Ww2r/4Is33+NzSstFi4faZIxQGy+mNqm3?=
 =?us-ascii?Q?fc/FF0Mecldh3IQdqkDkcn9YGTzDjoQENtLssbYeaKjmbY3wPgZviHr5cE9S?=
 =?us-ascii?Q?RnAklbcwMXFnLWVmm0x62RfQ6CybXIU3bs6JU1Yap+At7aYvoPpqYCaCyON3?=
 =?us-ascii?Q?LLL7bJz/zuU7k51vA2K7/PeybnIxjM1qUeXNqT3kvRnXo7/D8FQPsBNdZWMP?=
 =?us-ascii?Q?71aTj7CLLQyyFMFjp7ynw3Hi11a33NdMDPE2MapgXnngvM3hcIXimNL0+QPo?=
 =?us-ascii?Q?zOGGAtHRbcW+rPgIFdC+M9qg0VLAskrz62sud2+LCYaJoNCN4QtvmaDPIsqZ?=
 =?us-ascii?Q?7OiOrKdSlCmZK72ws4ThbGsg3wA1d/PyXt28o8xQZmTmnvKPFRLUBrJd27zQ?=
 =?us-ascii?Q?iKbTbEkkZln8amSa2eoUbN5BE+9ajud6wRNVh/Rf95YGI/SpxvprmDB0siVa?=
 =?us-ascii?Q?62MfsBlSXwO+AMRKMPAHnc9zdnMHDcoE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 00:55:39.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11221a1d-49ac-48ed-e826-08dcca20cc5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479

From: Chiara Meiohas <cmeiohas@nvidia.com>

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
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
2.17.2


