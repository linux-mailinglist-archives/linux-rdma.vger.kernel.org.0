Return-Path: <linux-rdma+bounces-21077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGABJG60DmosBQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:29:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D15A0227
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52F903069076
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E739A04C;
	Thu, 21 May 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DiO5PDXT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57379399CE4;
	Thu, 21 May 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348339; cv=fail; b=bAdMzsQcZftfuKoAr5VRyPZeqWgm8VHrR153RA+AoLLCv0jRTXvBaLlD9kh8CHP0UrCbISKZRlpeq3r3ffy73eZ1M3mWoVJ/GlN5ZDIO8pPULiILVJFcUIKO+RJU99Txw0+vmGrNe3BJAcclVPlIVzyh0biuTQjjhUjp/4oueg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348339; c=relaxed/simple;
	bh=keHirgp+Mhkwp5DOoS/xr2Yug7K0dLZPqLPA0QDNFYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxDj/rFg/44SYHVCgxx/BmWOJqw9yRbp3x9gzGcn7GRWNlNd5amhigyowvEisdzVYEOzzIOc4kQJj7z14z7QQRYiIOwVthYKoioIaY8h1X5zI9/2UfWT4ZxSTHQaF5qMb1cjGOVvHWm/fzWeAYbvcgelfr7N6xfZ9FyuYfcTRik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DiO5PDXT; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okGy3g5dh/Bi998IFRjjEgkDtBs7fMu44EBxfxmUQojgJEESA376igjOa7VPLUbQVnSwXWTtzhD4bbw4YDS8pEHqDK1T6Ju7sX+vD1LfSgtmtHNIbKLYN1HLp+Tvqbv2qG2SQUiZK/Rx1rhdQygx3AUg6YUsLVjXBCak7jMk0kB/H5TLD74QbTufMh9EaCHAj2ha36jvt3goLYx5e6197M4NuoyyvPgY8P7WqbzWilLL2EI2WrBsiprzA+38/HN7wK2QwJ70JfX1WfC9qfUIw8uUYIl1u5TY6qpjFcYp04YFgzp2IiCqUTdpg+ecCG7tRxXzOvL6bWDfQW40+JKnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yBjdSEe1sTaubArdQp2aiVgXIWP3lK8yHmQPPa1Xb0=;
 b=K2S5ZCoZ+j5co8Tfpqpg+ReFmeTGc1hXqaMVnM6aN9HBuJ1MF0c8VXIsex7sZRFvVal6tEz3mJopbwPG1NnxiL9nyvc3vbhmdGT4uafZUHN/fof7Z2dlvg7vH9jyHhxrTTWxnKSVWf/Dl+plvHF2Uj2ikv/HRtp5YG5GtEQ2Z8gAeWcDBbSnJXVx8Px5dTBwOBQ20S9OshHK3TZ0mW6UzGBVJWYVJ3K+c6cWaRTKhLAw3Y2PLvcZGs2gDxZvJWpmUYE02bzF9Dvpx8phNK7K5ZbrLa3VE0Bs6gfBvlIeqgT8MVaYS8MvRsB5myU1GlcC8BfIRujHKkQ73MUe8HFjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yBjdSEe1sTaubArdQp2aiVgXIWP3lK8yHmQPPa1Xb0=;
 b=DiO5PDXTXnjBMZyEpkaWrTgF830CDi0aOYCpdzxj/Cyy2NUjA9BF2vMULSKWode/FrndJfWyzheFuCihrMtWdyJziiuLkMdEhnTV0Xi8HifQuzQa3LEGCnyzGFGhlzNVCN4R5hKJLNyYcp+zSN6i7XIwhTmDxtLET8gXnH5M01qFVnnj32WMe1tX1XkdgNtCO3sEc9wL/hPUBFwURtXn6o427SrYgGV8w/PCj5LqlrsvuesHoKPW82hrilSutCtqb+C4nxKq9UaNff/Suz02dVutC0V26OXL0MSjmC40CDyHNPZw7A4y//N8WZALNe7dtiOmxyIMGBETZGU3/JMmZg==
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Thu, 21 May
 2026 07:25:32 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::e8) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 07:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:25:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 00:25:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 00:25:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 00:25:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov
 (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr
 Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Tejun Heo" <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode during init
Date: Thu, 21 May 2026 10:24:34 +0300
Message-ID: <20260521072434.362624-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521072434.362624-1-tariqt@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: b37cb7f8-342b-465f-bb0a-08deb70a2483
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Dy7r6D2pgtg2RyrNA5tzLZWdH7wOx6FGrsIi/eyw43HlKqzJ2p9bcWuYwYsizon6Q9UQ9G2dAIVdONPNkYiQYEclo3adycw44oY1K5wFhWWDnI+8MeLid99Kij0aArSdUpra4rDUZVrAcB6sK3JPA7ris3fxfTvwW5Mn904AMPuT/iq4gA2AiHtPwGBP5f140asqetv0cbM+jw2MiUrqWMS6Wd8MQUA5H9e7lgdatlq0zJasdyQffPGX/Bj9XenFfT3xfzKXibxH6Zf+tKU7HXXJVXwgz8iZ4y/+riE7JCYNrti9jt8YaGY6pXe8nZbi3TBepBfyJdOUi4Gu7nQR78r0Bu2Y82P8JsVwTixc50oj97pAFLXSBatgTyjIgmx+3GPxI3ZvPvf7Z16V/jK2osBB5LVq7lbmr9qKehmZMA3flK1luV/bWtiXLmelqdrjXhguADjMU/zvdsScF5R1mXd6KKajhFPzNaxSZUhejsaj2wsXmWVv7pT2KvxGvXXm1hJXTQGTK1rsqy3/Mn8SEGfPZe2z15cj5zstA83YYtSUZp7+OkybUau18ZlZnU7D7k6VWLBvgyaYitRo46v/msNEjZTr5UgTI/Dd2vxy82jgHUObGhwAbRTcTyC3mC7gvqkrEqlTMBGassmPYxol6+R5bGMnIUn7mTAxf7rcwA75g7b5DfgXliVubgf+rztyF/pAQxMNrox/LwQYHI7IJ6BomHolZtoA3iIc0Yx8X5U=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HXmBGxuGdBRao+yXce6uDnVj+Fs39B0Y8Zhm6f9t7VtYVPBVKSxM+Vv9q0DXOKQBJAWu652+3Yvi4dUPcaEU0zX0VcxV481YEYhl4AlHgDMz9G6rRK/JKlThTyXqhgKz+nQazZu73R/nxheOwekEibuDoMU99gXLI+LNYnpfRBtynrrStZxPGcQjmFLmFheN/C+Kwpb+tkbMxzyVSdzVJW8xls7iG0n2dXj0Tcg3Wpn98NZNRPHAtrXV2Sl2d8rVxOl9ii3kbXyZ5JOJ1mHmEHc6i1k4//CuqlCZPdxdYpdaN3fQlkrfNckefPrWoaJtmdfRAAm0QieHp8uVMt/4Wgq5YGjxLxAptb4Nn40jdFpQHHTHhPI9lHTLf35a8wohuSDyHOUxbFKSxesnsQHmYL8A+jKJjUOkqYh9T2vvjpHcXCSJ23iyrSE0I2LeshbZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:25:32.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37cb7f8-342b-465f-bb0a-08deb70a2483
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21077-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 533D15A0227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

Apply devlink default eswitch mode for mlx5 devices after successful
device initialization while holding the devlink instance lock.

At this point the devlink instance is registered and the mlx5 devlink
operations are available, so the default eswitch mode can be applied to
the matching PCI devlink handle.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0c6e4efe38c8..4528097f3d84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 }
 
+static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+	int err;
+
+	if (!MLX5_ESWITCH_MANAGER(dev))
+		return;
+
+	devl_assert_locked(devlink);
+	err = devl_apply_default_esw_mode(devlink);
+	if (err)
+		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
+			       err);
+}
+
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	bool light_probe = mlx5_dev_is_lightweight(dev);
@@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
 
 	mutex_unlock(&dev->intf_state_mutex);
+	mlx5_devl_apply_default_esw_mode(dev);
 	return 0;
 
 err_register:
@@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
 		goto err_attach;
 
 	mutex_unlock(&dev->intf_state_mutex);
+	mlx5_devl_apply_default_esw_mode(dev);
 	return 0;
 
 err_attach:
-- 
2.44.0


