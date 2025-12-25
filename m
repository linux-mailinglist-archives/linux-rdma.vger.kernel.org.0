Return-Path: <linux-rdma+bounces-15217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E5CDDD10
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723383028F50
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BF2F363C;
	Thu, 25 Dec 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="laVc0HrI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA731A7F4;
	Thu, 25 Dec 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669260; cv=fail; b=HllMv6gXydgld1qKb2ID+bxkbQFmTpQIJxBEPfBwc8pxWm6WuhA89d2heudiZ9CXl3Gu+r3a7cbl55vsmz7YsNI1v0wA4cwqk6AzhjrFw/lvI+DVTsYW4uQpNXHNtoFaZ+OlBckIXKJEOmNx9JxsNVzximBigrXN0MjN1Dl4hog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669260; c=relaxed/simple;
	bh=FOVP8DFucsCcXOSzyAu+Wu/Q9SqEcHLxqfaKdJF9hzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGxqU2VxLOqRYS/QZjt4DodrnTCSdi2UuC0LJ02sjHJgkYFXOt9jX2kW+Qp+6xs8Y5nPvPjRdDh0eqtrZbp08pTKEdwwnD6r3QsKrop2s25Xt/3paUiB98LNFWfappGoXPWvIoSGrTsaOPjftcqRYuu2ziOtVtdBZ9dTsEC0xDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=laVc0HrI; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbA2oJOuoNrkgoa7/HlEVvrppnvMcA3+RMRF7GCLT9NuJE3Ew+F1jmEFEtUJAK9ZBB4qgG8FemwT9LlVUiSKuykqXbu3nHw9xKs+we4Sn5QaDHP8DfXjZdwGq2ujBUJsnNgmjbgAGSS+45OHQ+h9U/XK1YNBUNXvDQnHdlYJHQgfgof/QAIzFBob1zehzhz/IePLEwCYDhhh712CiCGkbGF4hTv+Y9qfjsRtN91JgADfZZWTLxnemf7IqpUc0ZK6TrSUMhUfFr5QgPCAG8Vsdt6nFnyh6PZFS7IuvTnz0sfMi6KQkS/Q/RkYm88axLOlGlai1tlDJHI66OvHxI97fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=490ND+BKE3mkvzj8n11geCmruwEyx5eF1skcBzia23A=;
 b=F5Q0z2Cfp0/wCNkWeVFucZGpIwuzFIGTOIrpQ6XvDKs/5nhu/Oxp5KdDYZ4nNyzEyuaTw7GrNxF3tO19NnIhNX9bDzBFPTikqv9x8MhtvIMSD2aX9bnPg8MAlIiTWxvmdeHgKywXlYv6xNkcv8yVQ0l3DIuzxCpFnbWDlPp1UqfHxyteJOqQQs6dlHe5pCNq85DKwcvn4SO+C/kj9U7OyoZ9ku85J03TEuoV/7KcE64CeYV6GXdYmkIXi9kxfdprDPQUvS0keqjuc6K60fhhNLHFGs89TmESn/mr3FewwBL2F/xS5o/iPCQCKrpeVPd8GF1CSJhF1AoDtXpQzjyJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=490ND+BKE3mkvzj8n11geCmruwEyx5eF1skcBzia23A=;
 b=laVc0HrI/yHsLZ+90DtnphJTCZxnvpTsOY+iE9deBg9z214yuFwZqv583TjJu4huRvOJ9yKZ2zjP+xqMl6B4lkdWxcTl711vsspoORaz0eWnPGzVQJHgrAkQF73IJLcEnolTATzavIYAmubhWwFI9/k14PG5skkVkm1TbXDn+pgD4ZFhVoRYk9Ie7YK/N7teaBJjg4TlCjECo0xRAO9+tcOAJeGNB17a7PX7SQ+YQa4xTSdHxi+lLXOXfzytOes1gmwhWGt0A6dTvgf4oqqWzz4ga8nxBnGCSdVk1RbXU/q0q37EXbr3LIkL/yULNsOgN0qeQbUupgYL8SrvsdICJg==
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Thu, 25 Dec
 2025 13:27:34 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::6c) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Thu,
 25 Dec 2025 13:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.0 via Frontend Transport; Thu, 25 Dec 2025 13:27:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:31 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:27 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5: Lag, multipath, give priority for routes with smaller network prefix
Date: Thu, 25 Dec 2025 15:27:13 +0200
Message-ID: <20251225132717.358820-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
References: <20251225132717.358820-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a18aa3-2a5a-43c4-9f45-08de43b95bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kz2PBpaF7Xs110BRNW9CsGXyXIlFF5ksDw0CV3gj0Iexz1ftLLvJQkHjjNde?=
 =?us-ascii?Q?HKJIUJPjho7CQrcdh/IlDgMsITuktwSgicA4v/0DBcjbb+HNgpR4igoqEDsd?=
 =?us-ascii?Q?PcfVitbQIirr0e7oMFtZDN+ZzgduLGgzSe2e8usr3va+5eHCBd8XRr9cAJWl?=
 =?us-ascii?Q?GBwgUrklh/cp+xWERkkcSdJUOnKFOh+y9ZZceANBPn5FlC44Jr/G3gzeYmGM?=
 =?us-ascii?Q?h/kme6/CbXA8bMVafuH9jFTR9JwSXTB/MT6z2YJkciUCWw1+jnPRSgOoVqfy?=
 =?us-ascii?Q?75hiPbArxFbBsYHC8tFGb2Qq5RT+6og28sJzvQsXVFGbT6eUR2SX2tycFCAT?=
 =?us-ascii?Q?0WRRHf/nqQqFcYOxDnS3h55HF+tCkXjgdbIImxSsyBPAD5ECK2awle1XJGgz?=
 =?us-ascii?Q?x2KkInHwPyOjD32sGUj6zge3qgtmCXy7PUTSVAYuyQHBbUEtDPhCgg6Qnfs2?=
 =?us-ascii?Q?h25fE5xo7/zcZcwGMILXswSC12poQw6YcMx6Y0o8YDODka+1OVTrrtx/lXJ1?=
 =?us-ascii?Q?8F/+jGwpDl29JuttWEycJDrGYK3T2WNwKQdLTI/knh6gdNuIVm1qkrK3M0n5?=
 =?us-ascii?Q?Ti7z9xhh+LMVNoQ8B0sJAStkb+AGlgynqGMKn/LX50lbX/8ANlDficSHMfEZ?=
 =?us-ascii?Q?08RlK1su0aBK3HRfnmKhLt93MogTFSSq7KgNyYgJbhSodKBt/Iu++aNk3ds8?=
 =?us-ascii?Q?ew1bWeJhnvFg/8y5N7utCIP9WNTk2TA62mjGUTZCJIOVvj1YnD6tOptYAlok?=
 =?us-ascii?Q?jEHb9wA6PRqYFUlr2yIVOqjwwCL2+Ipg6TdTgn0MljGJO6ApqfLc++y9ZFbR?=
 =?us-ascii?Q?fh6+sTQdEnxN2i/We0ES0rvvptJ8u2q3Y1fzBgP3Qi01R4o8doOs8pOZ5uvk?=
 =?us-ascii?Q?4ZsiuqvR7um/ER5IWmmbDP96bDtv7LqETuEuooitJtK4VqO7hVpHEkJSn8ou?=
 =?us-ascii?Q?lLqs1xzkmV4qbhHfQO4hT5dTdOEh32pN8dP/Jg381aTrEe52dyBbPHH4hzjK?=
 =?us-ascii?Q?m5k2h0K867DR0udALa6I/Ac98RI5clXbvUGFxhLn+dkhrBs6d2/pxDDIQ31h?=
 =?us-ascii?Q?JWWMbQReUm2fs1YLkaB1iZpME6WAuKJ9BYQCj7HA8E4MXyKzJz+nV8n/WVf/?=
 =?us-ascii?Q?wxQ2eGA78NsBOj8xQL/x6ERWBslQEiD83YCyHHMcBNy8wFW60C3OGDDpyJ9I?=
 =?us-ascii?Q?Ho4rbGPQyExWgl51BF0sYi0ysl8zhlkPluL9V/pR1bLmRyjtJtre/sMoyF+O?=
 =?us-ascii?Q?U/k4lQotd0Rv9NS1T9B2FOqx9tEq7EmN5Ey5Fjs4O63DbniUguG6y8KJKQKt?=
 =?us-ascii?Q?z3JMVebRpCtqimZX1SJeMe+QGiLicXkqkaANa5IYzxH2/zSdhvnaqHC3yJU2?=
 =?us-ascii?Q?GLpf3vDuTLQ2V7ALIPz7maxo08S2dxVq01lO1auP9mW/UgK8vOZl6DMQGXKF?=
 =?us-ascii?Q?2INLQl+eicxrtlPbhpXHxGP4A62Cjh2/KUcazJn43R5dbYOPyBTGiso5qGt+?=
 =?us-ascii?Q?0iyfkz9mwkE6S2N9CEz3mG09tszvbwfAhm3rrBqVtMKi9kvOEDw6EjqYyrew?=
 =?us-ascii?Q?IBJrY0Zkbuukqfhr6Rw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:32.2140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a18aa3-2a5a-43c4-9f45-08de43b95bf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

From: Patrisious Haddad <phaddad@nvidia.com>

Today multipath offload is controlled by a single route and the route
controlling is selected if it meets one of the following criteria:
        1. No controlling route is set.
        2. New route destination is the same as old one.
        3. New route metric is lower than old route metric.

This can cause unwanted behaviour in case a new route is added
with a smaller network prefix which should get the priority.

Fix this by adding a new criteria to give priority to new route with
a smaller network prefix.

Fixes: ad11c4f1d8fd ("net/mlx5e: Lag, Only handle events from highest priority multipath entry")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index aee17fcf3b36..cdc99fe5c956 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -173,10 +173,15 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 	}
 
 	/* Handle multipath entry with lower priority value */
-	if (mp->fib.mfi && mp->fib.mfi != fi &&
+	if (mp->fib.mfi &&
 	    (mp->fib.dst != fen_info->dst || mp->fib.dst_len != fen_info->dst_len) &&
-	    fi->fib_priority >= mp->fib.priority)
+	    mp->fib.dst_len <= fen_info->dst_len &&
+	    !(mp->fib.dst_len == fen_info->dst_len &&
+	      fi->fib_priority < mp->fib.priority)) {
+		mlx5_core_dbg(ldev->pf[idx].dev,
+			      "Multipath entry with lower priority was rejected\n");
 		return;
+	}
 
 	nh_dev0 = mlx5_lag_get_next_fib_dev(ldev, fi, NULL);
 	nh_dev1 = mlx5_lag_get_next_fib_dev(ldev, fi, nh_dev0);
-- 
2.34.1


