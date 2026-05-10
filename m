Return-Path: <linux-rdma+bounces-20316-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE0zKa7UAGp8NAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20316-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:55:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A0505D16
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDF9F300C320
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C56325485;
	Sun, 10 May 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGhNkXO4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E731E859;
	Sun, 10 May 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439313; cv=fail; b=QNHnNNq//y5NE9KZdlqdzB5Gfshta+ymMExKT5dzXFtEhd5ASoXqgsNWhKCk6fCOZo1hrRF3CHlT27Tzb7LnKYapucH6GkTi4ABPwt1gBDiY2mZwGHT8qxSPsQa3CbwI0shfo6edCtcTY6O9Zutm0bHl6WSNuSaf7S1C/JyIh4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439313; c=relaxed/simple;
	bh=D+WsKsyk8XmOltLR5OHwCZRe+S89PiZfPtheDxjwfGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIE0SaMIItq3rEixdjlINYbxZqxUmr+GOi+7wEp/DK4NmuD1GutbLxKA0WvKV5ckIy1K07ZeaX2Qv4LnsaNfbNNxdPqFRTCIMUS2S9b1XZLS3hp1662IEFNOFfcygB9tIpkPrrqezeVuiC0Gb49A0qkpSsGBl4ybj/Ocd2c/Rvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGhNkXO4; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLaPqGUrMl7W6lOw2r5jmJ77GI0fGs5/siYbfIrBv4JRkv+KgHzGdVyDGEpkSv6GRbN0ScA88W70v4KuX/GNNB6Eqhw+1g3aW0CApjfoa/GBUoGWTZfmE1X7mqbZjxwbTxepDVn88kLDE05NGjtiMj11SMZTnYNG9xprzmxg1ZLh7ikJIH7KKcOEkUxs0LaZbrpxye5Lrmm87J1aaVTOwrLVBxZDiKAyU4/9wEAky0lnj2x+wvcib63fQAApj6xOm86vnCf4pAAuPS2IGDVQrUiJWyIaftLJqImuRxFw6bXFoSvzGs8U9lGrw3GcQIp9uX3RQi5Ncf8//bdRhuqjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRTuKq/vTCnpn44AxnKOSdtAFiazSZwS925PTmR/WBc=;
 b=PPvK9F1k4bFNaD6guHK/t4KdvN5HQwqGVFupLkesXYRDpjv09JGqBfRO4Jbkxb40yHhHI5bugOT//M+EbctHS7MPWj1nGpFwS26Ulc/EE1h90RtB6KuWQeb305/nWRUyenon21Yim2BqgVX5AsvYReCpmseMfQHYpFPIOk0FtoGp8ZIBTDDjlflDnA3hAnKirK7qsn67G5PobV4jUvCmLRTrjCn2qTGe8IXjjO05ZaumPtmLpgV7hGdZhK7Dw6JVKFnLzjBuoMYsTYGZKyOX5vVkeUZc+zZg2nRxNLEiyf0CSvsPiCL59c49XkFbwc9TLYCi1QY33xQSQjdsHh3U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRTuKq/vTCnpn44AxnKOSdtAFiazSZwS925PTmR/WBc=;
 b=DGhNkXO4AxSyD8YypfELYmKeHjQ4Q+4H+CzZ5pKgmbXBmFV56wFyxNVrXfD+GK5TIK/9cjdkh3ct5oNxvkywyA9U/bFn9IR5Ut3HOmN38zQ50uFm4w6vH4AjhN4dc9+58i7GCaehc4wiJwJOFWzx2yc/0ntABAWIwOT5Uv4j/mTalvDnmDwqlwzWbTgvTuvTaDBEo4Dx30LUN9rR2o8wk8FyUZggUJ3PNrDEg6qWfKBX1UTwq0w4X+XR8gYjKmpBko18q9d6yHFtxz6+BNcdMl0GpSxNNd0Ea9tdeH1X2gMDcEXQBLK58Sm8YFJtitljk0mHapT0wHpMS+7xsdWHGA==
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 18:55:06 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::3b) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 18:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 18:55:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 10
 May 2026 11:54:43 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, "Petr
 Mladek" <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, "Marco
 Elver" <elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC V2 net-next 2/2] net/mlx5: Apply devlink boot defaults during init
Date: Sun, 10 May 2026 21:54:24 +0300
Message-ID: <20260510185424.2041415-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510185424.2041415-1-mbloch@nvidia.com>
References: <20260510185424.2041415-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: d243ee91-aca7-4046-cfb5-08deaec5a6d3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PQLc/7v28yEOTJSNhmqMnLFW2odbYTBkgAyGuakDoOUXFwekx/UQZ28NfgHMzhxixUDQsDwGZmmrV238oThDI1HwwaDth9UUVpj+VgruHtaCi9M+GZu4kBlI+CiE6Br6HHmjq/rRSR6PBgPK9ivJGGLPdY0+jKuB78DcLhuUBa+R6xE4mppz0iZYr1yC5+47g/axnFQg04EXN+xIPjB/5toMeWJW+ojUxjpzB04pGJkJ7wCYMEK1ncc7nR+ebSe8kRn8FPho//5hYjZ7G/q6AhR9pGE6PbNIPdnmfY0XiAib0NfARd16eWnwCuY/neCdiC320Os9R2EPJYDJfSYumB93esHLWAWVcE1FRLx5MrY3PvVkfd18S4+P2wKPcPu9Fwi1sYd8/kD4106mtSmN9m4rANfJ+u9sVNbOvfjmXLobrkd8E2dsPYANZa0QVClK1jrjwPcpmEnScUiBLPYrZ/IoyTYvhubBjRLg9/eIkWta5wpSTVt45qUzRK0iSnts0Exu+HuD6j4JgbhHBhf7FdU2Ms3+3jSna/GFKo1tlh6HNDj1HemrO7btXEEVBqI2yGQcNAGAXe05pJVt/9t0a8eVMUmoxQlIwbs6nzj1iKwOvJjqzIrL6Hg6ahxcSVcQDXSI7kDHX4e4VhOoXLXyvTtQvStSyDvAmlL5MsTAf3yAM/Wp05ERY9GVL8e6Qj717lopT1aBhzwL119XNUBkoDTZpDhWg8Q81ANsxxUw7v0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F9R9HWEm69IXvPeah1Zn/DzqcPpZ5RvssNNRP4B508nAWXyEy/orgl/CCSDcQAk+bVH07GzzcbEYlzDwzw+HpkHgrBpOk80bZJKNeVOV8kYB13uAeKhJeNgMTuHswYssanCva3DR22hCfQ0Ct8MPC+9oF2jpd0QDMvyhEq+OCZE92NSZG9RvkKuG6OWqFW2I+kOQ1bbVyuWm9NiiMuScoVUdigxt8rvCDHYFN11dZrmPKHnqipNOxVA9caoiaR7Yt9uQi+RzacmpUnZBT8wgmySwBF4NSX9HiYO276t4B1VNxJj0A20F04Uumn8I3Tejk5grvahFCENl7vWUaIhw32MMU+LuOxdus8CgQaqdK4VFwasS/Ybl4zwVdZYxI/rNZmmf21yj17biK4P9ft/lccs3bBrgrEfo0octbfRBnt0EN9HJTE8t+RuXJIhNjF8P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 18:55:06.1904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d243ee91-aca7-4046-cfb5-08deaec5a6d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Rspamd-Queue-Id: 843A0505D16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20316-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Apply devlink boot defaults for mlx5 devices after successful device
initialization while holding the devlink instance lock.

At this point the devlink instance is registered and the mlx5 devlink
operations are available, so eswitch mode defaults can be applied to
the matching PCI devlink handle.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 296c5223cf61..deea7150084f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1470,6 +1470,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+	else
+		devl_apply_defaults(devlink);
 unlock:
 	devl_unlock(devlink);
 	return err;
-- 
2.34.1


