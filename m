Return-Path: <linux-rdma+bounces-22300-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R5rXM9E/MmrtxQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22300-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:33:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A6696DE8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=osjpUVqp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22300-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22300-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF40730D6046
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AB3AFD0B;
	Wed, 17 Jun 2026 06:32:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094C2EA498;
	Wed, 17 Jun 2026 06:32:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677966; cv=fail; b=p7E+TjqWshAMGdc/hcw+XPj10g52TmN2U45Fm9i9lDt++7FzbdjU8+JjkTDwvDtQNT8c4ca+tl3TfRtgtL1ROiS00g2Oub69NK6QovLavBQtxGE3Kt28VdE7b4z5dxWXTZxgEjwERi99zkDutRDa2f5rWbckSES/NtI54rZjzR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677966; c=relaxed/simple;
	bh=Pz79Hf9U41LAE0tnImJ8l3T+el8rLePydOB8C6RV/dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txZqZbJVNO3XHmtRJJpGX22pqCzMggQEMerNzsdJZL/tNydUxwPNFVYJ+/d/Gf56OLXY6pnAgXaf4WvKdBHNpBBTU+taTw7awDk65MdQP/6MoZACOn9foIEGI8ygw7idgcoJWCWBMJN0zZKKT/vvcil6ODcgj8XzJy9i5CeVeUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=osjpUVqp; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulcNva1LRoLGT7XIrXNZEE5Qdpa7Ipkjl5cj+iv2MzCxEiQe476Yerz7QHeeuZhpLX06CXxc5Rs/N4IMiisy5WFzaqcVyEzX/2/d04yILv1k1GzOdWqawIFGklCxW05NjT4AHVYYKBbRqNkV+JE9YXAZtcm+kGYmleC+Mg8sRWzWNrHVSuh6tYpQoWgqJWtBPuCDin154QDOFZpN7/xZ+le7gQIOoVsmXURNrrQETT2Eh1AJTPYQFCZ9NpU16Ot3OKsgy8hpzN1CrSOY3+u0V+mYogBNwS8LjL+tzgN/U3GZn2GFdo+fmtfNoRTBaakXRVsbno7td7YTCocMUortHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+82qv5kPNxVMOp6KDvPuyyMzb5rsTLKWFeRi0jUlZw=;
 b=zS9OsaLR5ouypuhDZc5BducamXBALFH1e1AG50c5CcMdWQ66iZgVazXhCZszayHWYMhk3ILiJh6Flzx0JBnPiFUexskwjZx8FVYUjXIeZn41aN/oG6dWIg74dmWkmTn6xSclxfw+hnUtuqM0urhId9KqK/C8P9nqdY/59Nst02qmtNsYtpLfjuhN5anW69mIPCj9qVdCfabpxk0w89BZsJnfMkfr6RI2J3oBH5Y8UjfFn2PmOXFOdQcndO7rvt5YkfobifobR+x3c+jbmOomkd02G0w23aofl8GaLsKgT+eQJcGjtBazDFJucTB12PebtD4t8iPUYlMGedbFPJ/Fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+82qv5kPNxVMOp6KDvPuyyMzb5rsTLKWFeRi0jUlZw=;
 b=osjpUVqpB8KVhZ9W5uUzLDLJJ46OSSnysBdYKL7PSIVJHl348efdS1e/UBfL/0Fspr5gQgN6P07CJ4eJ5jcXmyu7bzqiRvLoqpBO2Ud8Oji1Fz5CY7vCfAF7kItWvnlxvy3Z8Vv+hpUGSuU7tsISnRfhwFAlmGXUjag3huXUuTW3A3tuqifOvMcTeQtUeUEEtGZcGMNzJEhT/SR4YjqY2jNw4IasTMl+aMsjRZ+EAxAWcVAZgig/dUO5h8ce8PhBo7GTWJRwQC96qBjGXRIUUSps01sgdE64c7M3hqh6XqNxfd+ZhaTp9Fw7tTQhqcNFNf2ciu+LJ/0qU1iZMShTbQ==
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 06:32:38 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::88) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 06:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 06:32:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 16
 Jun 2026 23:32:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Rongwei Liu
	<rongweil@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: LAG, Fix off-by-one in single-FDB error rollback
Date: Wed, 17 Jun 2026 09:32:02 +0300
Message-ID: <20260617063204.547427-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617063204.547427-1-tariqt@nvidia.com>
References: <20260617063204.547427-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dc8ccc-1508-447e-047d-08decc3a39df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	n6qesgHx3kwI2dsnums4+dOYRzECmlNSdp4ECJSWig64fFKk5qe9qciX9L6U52bgurbFuEbW45nOgEMYieh0NHYZoSaJ+GZiWcgBVDyrhvx8Th6nek65KT8BDltA4WCnBh/E2CZYytU1KRRO2FFEnXUJP53MOeQMWQ4uRGzIBShe7mEA+g+B1LQJvn7ajuQiEHgzoOloggp3OHulfEoBYXRiMc3zyS6t62+gdTuxAblAXgy/HcQoKBRrG4n+BFsrlnvOWfy7DRQYsX3yVboVcEuFhXyqeYXnsKo2yxLprpxbeGJQ9yW8Ibf6Z60xNH/ret03mdOddgjnA8hXpgYEQim3qKFqeRWq8oBwswXtLZt6izobiP7bVLaDeyfo4nEJOMRMqh06MprS9chXIfY8NiSVTgmA7jSIWwBmKgMjuLXqgW266in3EeCY/BtS6yo5DauR/pB1hGFwt1AydHq/EXglISHyiwBpfZ0vRlWCihbCiFwRSGKK6jLX6+/wVtS78zlPLp+VJQetLHYLfBRFaAn+u6O2H4r5qzKchKeGPljHyjeNHCi7SIU72reC7XrCQqJq8RHxlzyKJhIMSdcE/El8PPbwEl4dqh4tVqH0X+axf24gO6pvA9N3gjQTJ1jVKmPLFw8BCcJo9WDd0IRhdI+g9KF0c3K6GN5n4N70F982mkjotmSzwln1ip+Dh64CdUWNzMb7HZuL5EBoKt7vff4WUroyqFZ2LGb0Gs0EBUM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/KmecKnysLS81ABSRX1qhuJdjWHCOEsFNWt5qMIkqwEOny5SJftBCV0eNOfrDT3CSnHzxV/w9qF+Bdo650srG6XNXEulSZn/NwKSEqRvjwqFuHDEcspqopVjvCjgPevtFhoug/g3/UO9YBvOcx54ZoVatmfghkPgR/Q74GF/1utLneZ3O0q5q2j2cn3vc9PzlXGe5taKA2Oi4ztfLBYHR7s1QQle/8OslzEYnrZ6U9Tr76DZ0CRxrWC/HGpWlao3lV18lduJE6vH8tu5YlEE0zhiTj/lRWWXkGkZOF1dEbEGfackPlivVDhDExqDzXimbKGx+1mZ8GflpkAZis8XfaBwzU33urMemXXlOydMA0vcxhrzxyKAjJ7KiyfIFPFrFQdq0PSTFJD82b+YBdIRCixo8it3YcK5Qyp+CJv0SAsFwp2K2oLf5rrfm+g/Kriy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:32:38.3654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dc8ccc-1508-447e-047d-08decc3a39df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22300-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 782A6696DE8

From: Shay Drory <shayd@nvidia.com>

On failure at index i, the reverse cleanup loop in
mlx5_lag_create_single_fdb() starts from i, so the failed index
itself is rolled back. That can operate on uninitialized state or
double-tear-down a rule the add_one path already self-rolled-back.

Start the rollback from i - 1 so only successfully-installed entries
are undone.

Fixes: ddbb5ddc43ad ("net/mlx5: LAG, Refactor lag logic")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f8e70ac5a85b..6ae1a7781c8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -845,7 +845,7 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	}
 	return 0;
 err:
-	mlx5_ldev_for_each_reverse(j, i, 0, ldev) {
+	mlx5_ldev_for_each_reverse(j, i - 1, 0, ldev) {
 		if (j == master_idx)
 			continue;
 		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
-- 
2.44.0


