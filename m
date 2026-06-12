Return-Path: <linux-rdma+bounces-22172-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6PetNc/xK2oSIQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22172-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:47:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F567913A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:47:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UAc97hnZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22172-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22172-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFFA83287205
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DB3EDAC7;
	Fri, 12 Jun 2026 11:41:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55623ED3AE;
	Fri, 12 Jun 2026 11:41:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264473; cv=fail; b=HkUpgBlmIykJTFW7+Tgzcm3Oms44uM9NtrJ/Q2W5w7NlDC2fz232cJSHfBWvA/06OsVBf/ERYfubQ/qK18ST0iriCszgoespXxoK8f7LTUKoF5EWm4b7qLXC2hgSIFDyaag0Dc8T3+REO4FnPBoIyFIq9j07Z8nJlwB13+ixLCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264473; c=relaxed/simple;
	bh=F4QrfLENmkrg+u8xJV7fgjie9kAa/KHa0Aqs8BsV7BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFRNrMpYrzu8p5ZgSKUs/gHzf+erzYuShWoiirTKPjQq6GojrWGFFyq+BGcvQpMmiBGbZ1lQraBhYV06PgSQBmHE6loofoQ2RJyk9WeBLMWkJ0UKeopC5Bsz7P35myQ8+llBn38yfDAPRXHE+4apE9smQh02iyxtm8t5xcMJu7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UAc97hnZ; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY1ueN7+uJXBr64N94OqiBdch4eIHSVRmZPFri7KLTlYKkhgMmYr/c4POJRamtXpm192MQzfoIgDjhF1J9ptS8ZKH6ZCdec7iTxfjYvomA2F7f5NbebEsVSiRvRJr40YUWuQ1bNXEVchQPIHnkSbAzxoXm4YrrvYJMKdphVLZtTwZPaysSqYSmy6+LjIX6Gf3vF3XTPp9qFlwaMS5VCF52faFA53NRQ1vNjtr7pewH4/m7IAYjKyBsSOYmugLufV1j1rQ9DNHuGMt6Vd5nnMxoa/1DfT4qjOgaFglJeGybbZBxsinmI4sY6EBjujx2O6Ei1TeL22kdpTt2bTCbdpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veiO7IyCxvjNGgGbzUrqbiXP0ugwCR5sZ/VEXYQZjmA=;
 b=EbYfWo50aFd9cP78YYahqdV8rG5DMYMDT4AxAjKGVOaTnlq+sXUF1v8bfjLf5sgS2QL/5M0w3qvLBMcv5P3ahMFv2BDD7abqaxi/dBTdvljj3f/f+jlnGaACO6UzxYHDoACsvaMjXn7D5AZ2IMG4EIPvmVlkR8YqvlRKEQcWOxVjnkdBt/WzfhFOQpsti6zZZmSIQtabkAJMSABeDQP+LiNJ1JvsxClEnUlENxnMRH7MB3vWLXYItMuaO7ORlhXlPLJrQvX7WBUXaTLNGI/UVFwKF5Exe10cc9pSC16kSyqb4dhTBYbJVocZub2NaOq9+EcbXatad6FGHV5JgZxOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veiO7IyCxvjNGgGbzUrqbiXP0ugwCR5sZ/VEXYQZjmA=;
 b=UAc97hnZumnnAW4SAsnwq4v4/pqXJTcvWo3dAWql+GjUKGRDrDSQQCzY1aU3zdieW8kAfVNZFTvI3XVzY5dmPwRm8LELEMUTDX32OJ5ODFyIte4geVvKmGjbKPFi23nhOAAEH4bkZuwPzl0Cqyae4BIhoPsBlcKtAARFLVjEy5xAp0k+JO+Jhayqq31ZtcsnzopjbSbARJPoaXGJ0A2FlSgZRdqT0PlUwkEHjVMfq+ZzzQ13lc9WKlqFavpBVJZSxfLlBW1GH7RN4EKkADmJ2UcCPeqWGfvkCvKU0onDhsV+DKv5m+YARcV0x3ijrguxveArnZKp3d0K7Z5bN4sqog==
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 12 Jun 2026
 11:41:05 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::33) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:41:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 13/15] net/mlx5: E-Switch, Tie rep load/unload to SD LAG state
Date: Fri, 12 Jun 2026 14:39:02 +0300
Message-ID: <20260612113904.537595-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6a44c7-be04-4522-208f-08dec8777cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2SLPSn7RkQqUhJ8Hs+PDO3pzqYIK/F/O//mHdLQfFdRVyogHVP3GJe5mkc30jLJRFnz4PzA17tV+on3xs1PoXm3ml66Bbiv4yoLBPJm/dA+tZULdKQk7QPolxuab9i9eRmlyLeZFJP3/VoFVe6Ra7HJGOSh7WmKNActs589U+bSSvc8H95NjXvNOA1dHmkDe9GeEYlEA6DpfpibD30zj6TESvLUBAKnCISNXHTwWIMp8phOKwRQeuKLxk+lRHY7zaUHlCJhApK/C9ugmo/cBnIF7674mafi2F5KY0OauLutpSQV+T2dVXy0uKS9Twz1YK9zprJs1yUOz0njiXc1daVMW0gckQyDQEhXTaIX4TH5hlrxAyXog9MydFtDt3lfwFK9q5SDYB6mrUnJLc1gkpTuIuN+e06I8TDzX/2Kj8WqRTPqx6/lwykKU35d1zeMvwU0d2cvM0PlAY9JbQyFjGLxd1FaxYQBUSA4WLQl5btxwbQjcRnCQM4xxJDLCB+8cnqkJKYKwDzc+a4dJoT1grguZzsJ8CCtROo/9vp/fXWQ2sILAMcagw+SMNL9Nl/xL3MrqHqE2YREyoOQ5LHzp1YEzkzYVGyc6bsUuYfZAelmp4oZNjWKFHSofApvIki7zHgPpCqDwtRbSJeVmZDz7M2h/R0pZp6mIjYaY0vPiUdoVO/Z2Xi6Oqt+5Q7DoX87BETJldE/qy+D73LhvCjt50ZDWofwStuX1BnD77MPjghA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EN3B6tgU7kTqLtRw9U5zm+FmV7dO6eu2GfseJdvL4MCYMzzG0hiZ/fM93h4hzdhDRCLcbpHHP3WmQKVqSF68SSQQedFQhAf4/mI93EzVjd0JgImkYs0kEaZuzOMxG6v9jNbU0Mnzgw3Wey4Yo5GKNF5NmFBOe2QnSEaBwokwJ79MsO3Rg6bxkggxoteiHP82u7vSBzkmsR1GVGX9m6RE5SlfDQt6ujVUPwkRcNgY2ol1MN5piU1EZnM/8pVY2WOdEG4X41GZmNbzVkxEIUlpZ9trdJ+ppl7SYaHDOOy7tfU5yXrqqHMw89cnNZ+1jRyIUrMn0Jw/4r2BRrvhc0t/Zf1Aes84H/+94i9uarL72e3oshOe5Jhha/GhcfLOqSBRxEkqmEhS8IauIZ5223JiuXnnyIe/rkGm9edztK0y96oYJw/jPX1xKVnlzICXUi/O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:41:05.2039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6a44c7-be04-4522-208f-08dec8777cca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22172-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D5F567913A

From: Shay Drory <shayd@nvidia.com>

On an SD device, vport representors are not functional until the SD
group is combined and shared FDB is active. Skip the initial load and
the reload paths in that window; reps are loaded as part of the SD LAG
activation flow once it becomes active.

In addition, explicitly unload representors when SD LAG is destroyed.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 26 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 26 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../mellanox/mlx5/core/lag/shared_fdb.c       |  1 +
 5 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a5f0774834fe..b2b3150f1f04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -959,6 +959,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
+void mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw);
 bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
 			  struct mlx5_eswitch *peer_esw);
 
@@ -1063,6 +1064,9 @@ mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 	return 0;
 }
 
+static inline void
+mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw) {}
+
 static inline bool
 mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a24719cfba34..4dc190a4e7b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2863,6 +2863,10 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	int rep_type;
 	int err;
 
+	if (vport_num != MLX5_VPORT_UPLINK &&
+	    mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
+		return 0;
+
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
 	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
 		err = __esw_offloads_load_rep(esw, rep, rep_type,
@@ -3779,6 +3783,21 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
+void mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw)
+{
+	struct mlx5_eswitch_rep *rep;
+	unsigned long i;
+
+	if (!esw || esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return;
+
+	mlx5_esw_for_each_rep(esw, i, rep) {
+		if (rep->vport == MLX5_VPORT_UPLINK)
+			continue;
+		mlx5_esw_offloads_rep_unload(esw, rep->vport);
+	}
+}
+
 int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	struct mlx5_eswitch_rep *rep;
@@ -3805,6 +3824,10 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 		if (!mlx5_sd_is_primary(esw->dev) &&
 		    rep->vport == MLX5_VPORT_UPLINK)
 			continue;
+		if (rep->vport != MLX5_VPORT_UPLINK &&
+		    mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
+			continue;
+
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
 			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
 	}
@@ -4764,6 +4787,9 @@ static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
 		return;
 	}
 
+	if (mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
+		return;
+
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		if (!vport)
 			continue;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 424478e649ef..28d16fdc3f06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1312,6 +1312,32 @@ int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
 	return mlx5_lag_reload_ib_reps(ldev, flags, filter, cont_on_fail);
 }
 
+static void mlx5_lag_unload_reps_unlocked(struct mlx5_lag *ldev, u32 filter)
+{
+	struct lag_func *pf;
+	int i;
+
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		struct mlx5_eswitch *esw;
+
+		pf = mlx5_lag_pf(ldev, i);
+		esw = pf->dev->priv.eswitch;
+		mlx5_esw_reps_block(esw);
+		mlx5_eswitch_unload_reps(esw);
+		mlx5_esw_reps_unblock(esw);
+	}
+}
+
+void mlx5_lag_unload_reps_from_locked(struct mlx5_lag *ldev, u32 filter)
+{
+	/* Same lock dance as mlx5_lag_reload_ib_reps: drop ldev->lock around
+	 * the per-eswitch reps_lock to keep the reps_lock -> ldev->lock order.
+	 */
+	mlx5_lag_drop_lock_for_reps(ldev, filter);
+	mlx5_lag_unload_reps_unlocked(ldev, filter);
+	mlx5_lag_retake_lock_after_reps(ldev);
+}
+
 void mlx5_disable_lag(struct mlx5_lag *ldev)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 8481ce55c10a..e9f0ef83ce1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -310,6 +310,7 @@ int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
 int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
 					u32 filter, bool cont_on_fail);
+void mlx5_lag_unload_reps_from_locked(struct mlx5_lag *ldev, u32 filter);
 int mlx5_ldev_add_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev,
 		       u32 group_id);
 void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index 8d4f2903a101..113866494d16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -296,6 +296,7 @@ void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
 			pf->sd_fdb_active = false;
 		}
 		mlx5_lag_destroy_single_fdb_filter(ldev, group_id);
+		mlx5_lag_unload_reps_from_locked(ldev, filter);
 	}
 
 	mlx5_lag_add_devices_filter(ldev, filter);
-- 
2.44.0


