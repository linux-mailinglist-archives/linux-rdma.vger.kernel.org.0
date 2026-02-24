Return-Path: <linux-rdma+bounces-17122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGjyOpGQnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:50:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44C186997
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C3D230A31B9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411D3806A3;
	Tue, 24 Feb 2026 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cX7+vRcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98453803E8;
	Tue, 24 Feb 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933662; cv=fail; b=frmMTTUdt3fwo3+XoZA+W59cSN2oc8e1OalZ1gBjXKj2ECH/FOt31i6BqAvtYHF//FBlGPdqMqgTfaz+aqe1pVYaqdrzNlQhE5O8SKYXWusvlh7hJhaExnbQeecqtcvSzFjpANL5DGsg5rdCbrz/HubNXveWVwWbT17Vo++zYQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933662; c=relaxed/simple;
	bh=9Tbef+IJ/tg/SwvMj+OldmMOeO4McJ63O39rEcyBOZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idSKN2BMG5Piy60LbR3NeDQWGMdek5uufp4NXmiWSd7M9AaWs2Ou/vf7KibY5YmEXqvgfu/oYigPYnZYmj/abi2DF19wH6fajPf64LTwe1q+iVJHrU5UWqiyMKtwE97VWo7PH1hr+oDXuccxhPYwvUqp+Y/J5hwdoGxxVCussfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cX7+vRcH; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8fmMlL/fLl5LC/DKdJjGVOl6xD+p8O+N7TcSjy6L7EwL5p7nytY5YA/nDi6elgoEWMZ1Oz25Hb6RKLBokaVYDt4za0xKgsQGFUFRlVhYnpzC75ItSU7LShh4MRR6Z6WyebqfY9HIbKuynbXZ13w8w8SQ26xcZ03WzEGvcNJFq34oSgilyTv2Z62JKU6Dlc5Cq9TzTErg2uiVP93+pTcZ9yviUd20Rd0t5Ua18SMfV9E6kqpsgNO69jAn/yDXuTSpqMkVZwcGpOu4tCsqPjKQ4Q1dSgcuacrBgwZRHoU+DJ9cQ1PMdIkQZB/eM5HH4MyFuDnBdo4L08w6I+EHPTHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phJAB2MEy4Fdf/2mj0OoaE9zNONJrsk5K9sIszh3sMo=;
 b=j+ZKBX7oUiExHHsUAOS+b82dIqzfsyYxSbbInVCq3bFjY3mr8NU6fdCJeAemfZvtGwanGxnhZZKdA8p+O2O2vNaJZ4NzaLpCUfLAQqFcSsnvtGsV++D97SWQ1WDHOQqdZlfjX018evoOIFWvIJJm7NccpBhZ2ws8Y8oLSazh4c6ZvC3FJbzwuaG0uKeuveevNwwYyC7xCKzwk/8OCD5wwpneBKVWFj6LpWwsRG4c2lHLq/31rp4kioA3ek20HO+xFjrHKgTMK9cAiL1MgZUp0MUxsBZ/MZVMQq/coW2nbi7faAUUw4afpO5RdMKJ6Uuz8VVy7hH7ACAhaz5B41I1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phJAB2MEy4Fdf/2mj0OoaE9zNONJrsk5K9sIszh3sMo=;
 b=cX7+vRcHlQKmUdLyn9V4FsnccRMDzeFcKTT1QXeVH2gq5z6mAYbzZ/cyDQ0i3CrSqMC03ehcbiPbp2bx7E9pN1RLlBwQ0E4t8h4OSMWUMTC91NRM1HfL6zgEGQvdd+bopdPWECwLb3hezhRzvNgm6rqJDeCwnGM5UaxqxT2wo9uu0J1g86kRFNEstVcoaMiA6RPM2uhbE9x1nrlFxLvWZnl7k1o4QBRSkUjv7nHM4nkX72+s5ygFl6ml+Eq2EbqKrY5TJL/7DJM27nUXFwEWOvVKtV/e0VAFSmiDGbo0UJT2FiG4kv6kQXuVIbvtzsB+J83jt3BcXPcZNfFSYOn0NQ==
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:47:37 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::22) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 11:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5: LAG, disable MPESW in lag_disable_change()
Date: Tue, 24 Feb 2026 13:46:49 +0200
Message-ID: <20260224114652.1787431-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224114652.1787431-1-tariqt@nvidia.com>
References: <20260224114652.1787431-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 251ef89d-8fd3-47dd-846e-08de739a819e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40hGQ/4ZA9aSJS57n+hRaiVIfzlNPDiVSzeJJpQM7/yAPXskjhue3evOBnG8?=
 =?us-ascii?Q?DECwLwGqVWZeCVR74kNe0HKKepNFo1reSIJzdM+8+066h6sXu9q14ACVCni4?=
 =?us-ascii?Q?S3Mmec1R9ygYUgcrhAREXU4Lx4uFAd59MxjoHNpLnfvg5duV8/lsv6Rsq3lD?=
 =?us-ascii?Q?Wy9u5DCqbEY9QyZ8c/daogv2vpoKzlmDM3DIBaA6rXx7QxRboBO9ZDk7o1GW?=
 =?us-ascii?Q?zfn/iY+0S6OJF1JIjaFYAusCUI4NO5RTCC4bAdF2eDe3Q2ixHUAXeXbaUWUZ?=
 =?us-ascii?Q?bONsFLTgrBpyxpZJ6SAkNwqwBYFuRS3iNjbKLQ9HXjcU58J5XB5ZRRASr35g?=
 =?us-ascii?Q?6+e1ouyddVQTTUtbZ4xhdGIA1Psenxp/j2KSQB8+E3TT8CQnOhEnL3MAeaTb?=
 =?us-ascii?Q?oQhXJJ7DxNuCfPURZMUiyxG6Q62z7Pp8sn0jgQzFF7SCGh6K7C2UG46eCPlq?=
 =?us-ascii?Q?sMtTmMcPg7Vvltiy6CCErrwY1/HINHlZr5pnlri6UIsWNg99uCDthtbdi9k3?=
 =?us-ascii?Q?gESL51c0S22bJdOaZt96lR2cytYWICZO0iqKJAZWuMLRU6XHnlYYbmXu77xh?=
 =?us-ascii?Q?7wRHZ0W0uMdkk/wnEawkTshbMMBndz/YfqQDKmXl/egBghi3MNdC3KN5U05d?=
 =?us-ascii?Q?lbjemsdXmbbiLO8Lav73pq1HN6p4TwrULMDo17dEbsGb4Ct8WTj7ul4kXGrn?=
 =?us-ascii?Q?Bdx6/RS53iZ5C6RcNzMaCkHRBcD4gKidJhNlAkLx6NUMmYz0E9/wI3Vt85h4?=
 =?us-ascii?Q?Atc8yO+/NtblThKlHp35Ao/nU29q6ZLzGqX03n+TyDuCbwX2l5Cf9jQmu8Hm?=
 =?us-ascii?Q?KyONwooI07ch4tXP6uF35U2I+0VwA07G9Bz212opExYloBQjnCgb398GaJ5u?=
 =?us-ascii?Q?aDlqb4RmSK1uI2Rlo6Vzd5pp/15U2o0HkeskgiyJVu4FYUSgCHJ33/+Nc19q?=
 =?us-ascii?Q?ksS88TzRtnCIZ7HlLEs0blvegE6zxfhDuSvfUeLHxHwJKHBAwHwmkjmSfaRj?=
 =?us-ascii?Q?GA05Y44hT2x9Ze0dEmuawRc6PnXus3+R3UmnU3zHVNEwqykvQ0043ZUl17Fl?=
 =?us-ascii?Q?Jqee85PMOVLcvNiTJLtMZV2Ufvq6qRCayKYEGOqkKj+4setjEXU/Q9Nwec3J?=
 =?us-ascii?Q?YD5OaNSRr9CC6F4yDNOE2EV5IPqIpfSWYuXKKCjO/9mgX8jIzNgIry1Uer/4?=
 =?us-ascii?Q?7Bhc11lpx8ZyjzXpe/46oNC8F1bk53YCtdyGSw02b665uLkPKQNea7gfP+YN?=
 =?us-ascii?Q?qTH13P9byT8+ao1v7+K5JalEeRUu176RT8hkWnCDtrlC+S0DrZb4Wn6QQ+nu?=
 =?us-ascii?Q?gQhzJ8vMxNryATFKm/652PCmO5S4TLhqoDg8T4yLRx0UclpAvXFUTC/q0J5h?=
 =?us-ascii?Q?p5iDuPPJ8vOWL8Yed2/WogSGdGDmDJBha341hBHgK8D7nEp5M7aCbxe8Sqoq?=
 =?us-ascii?Q?ILkh+7K5OWtRO2sZAUuBlkJcvkr0yN1i7Upspw/0098O0y7vrdOaQlQkjyAW?=
 =?us-ascii?Q?COL/uhpsZGltvMaZHLTy1ISi/+whaNaRjYa7/Rx6NTicBy+sfDrx2FtYJ0QF?=
 =?us-ascii?Q?smy5dtwAce1DIsYJM93UbGZ+kGHp8tid6oFoZ051Adnjft6a8JYJtSF6stBx?=
 =?us-ascii?Q?/ihvKhEVTr3RLBCqJ1VJxDIWEpIvEurioxKPDnMZSeFE9hqVTi1YyV4ePoj7?=
 =?us-ascii?Q?hB9r3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	goUapB0HooW7Gm0ZONMsC79QzNA5aRL8vtyDNqxLQedBJWSsAGP0oIWSWbDm52D0NdNNUD2NGd40JnTbbuvlwQ5svGvfvN7NC+yc487purIb7BhmOfQQFbiHToUdTX+8XqHiTvrnI1j4XFaZM5dfgFK8wP8PloSwjc+2ICRJPSkyOo6irDs7hU6EFPMUcWwP7UbPKlosuEy5SAluzoLiZGILXiIBA66XwuQgF0iHKOCaXfKN6ra80ZQEjXRJxMfEtwW+Ngi+onDHM406RDrSBFDWiCw04Se30BxbUGZLYkGF3FOBrxlrayB8/OdIK93x+dKoHpjH9PGWEX7IUlyieYOl9BWizqhsIkZiswD8bvjfW6trGXk29izGjHJmihw8NCF7WeoXU97Dktty+nnX4yvArIRbHRHtYk8K6ijDZNlIAh5w5kC9iekqXj34jCBu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:36.8070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ef89d-8fd3-47dd-846e-08de739a819e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17122-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC44C186997
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

mlx5_lag_disable_change() unconditionally called mlx5_disable_lag() when
LAG was active, which is incorrect for MLX5_LAG_MODE_MPESW.
Hnece, call mlx5_disable_mpesw() when running in MPESW mode.

Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c   | 8 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h | 5 +++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 9fe47c836ebd..859f042caf79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1869,8 +1869,12 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
-	if (__mlx5_lag_is_active(ldev))
-		mlx5_disable_lag(ldev);
+	if (__mlx5_lag_is_active(ldev)) {
+		if (ldev->mode == MLX5_LAG_MODE_MPESW)
+			mlx5_lag_disable_mpesw(ldev);
+		else
+			mlx5_disable_lag(ldev);
+	}
 
 	mutex_unlock(&ldev->lock);
 	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 04762562d7d9..a63d48d18878 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -65,7 +65,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
-static int enable_mpesw(struct mlx5_lag *ldev)
+static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev0;
 	int err;
@@ -126,7 +126,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	return err;
 }
 
-static void disable_mpesw(struct mlx5_lag *ldev)
+void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
 	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
 		mlx5_mpesw_metadata_cleanup(ldev);
@@ -152,9 +152,9 @@ static void mlx5_mpesw_work(struct work_struct *work)
 	}
 
 	if (mpesww->op == MLX5_MPESW_OP_ENABLE)
-		mpesww->result = enable_mpesw(ldev);
+		mpesww->result = mlx5_lag_enable_mpesw(ldev);
 	else if (mpesww->op == MLX5_MPESW_OP_DISABLE)
-		disable_mpesw(ldev);
+		mlx5_lag_disable_mpesw(ldev);
 unlock:
 	mutex_unlock(&ldev->lock);
 	mlx5_devcom_comp_unlock(devcom);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
index f5d9b5c97b0d..b767dbb4f457 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
@@ -31,6 +31,11 @@ int mlx5_lag_mpesw_do_mirred(struct mlx5_core_dev *mdev,
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
 void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);
 int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev);
+#else
+static inline void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev) {}
+#endif /* CONFIG_MLX5_ESWITCH */
 
 #ifdef CONFIG_MLX5_ESWITCH
 void mlx5_mpesw_speed_update_work(struct work_struct *work);
-- 
2.44.0


