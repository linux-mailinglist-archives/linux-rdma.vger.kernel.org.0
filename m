Return-Path: <linux-rdma+bounces-22824-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZr5Ndj7TGoBtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22824-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A371BC1A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DxdaEiwD;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22824-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22824-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 671383096310
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F50417376;
	Tue,  7 Jul 2026 13:11:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5B414A33;
	Tue,  7 Jul 2026 13:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429872; cv=fail; b=fhomm9WGxGuI2S5Tes8hw7LLsXUZ5hFIXutatGkF1UJKGxwANUgISzQP5RGzlAvrO2IF+/nqOHHd5vEaJ3eb+gNbTOcpSYdwaBiqzdEBLjW7panNcWYs4zFWt3ZfVHG7m4TE4YcSyXqCRMVkdF8d6zF7LVArlCcjVY+p+8rtC5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429872; c=relaxed/simple;
	bh=NA2qTGpLBmJRkKv5qVM+UfRvDc1uEBcmqJknr/M0CCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGrnIbxyni3NkzzAarxSJ0EsiEeNdn3+NSbQFJn1tUczn0VOtuqsCYzJ2Dyg9z+2iBW+sEvTK4IQWs7I1iceazBNEj+PdzPLhMEdU7k1PlH+f4xVMsnt7pRkhGOEAZxhAjlO/Asq/IkOQZK9SeWzM7vHm6gGMzNQ2wCKTeyNWos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DxdaEiwD; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMAQrrTBIfUQ7kJ3+7yuNwP3SYwQfp8JQgQCgLpfs0B5Qn/s02QRW6gAIlt3I0if5G2qNkPqEwdeRiBKGd84Qo7N3zyJ412Sgbd78hvgqP70QxbnkTEuCbRDdsgWfhgoZdzEUMoPSIBTTB1FV3N1uoPYSmejIoAD/DzE+gMumIXRiwIcHFXFv0xMGHX1Rhs9rm1OtcbyGfFFuMPk+gcT/WDdWMq2lQE50wgS6BIf3OiEbBJG1h6rgQavvFpFnMAKroqkgA2fGGGNHq62MraidNa1OQvlXStuoE1UL0Ax+AngoLK83JO8QsHyBMfUDmfQNVguhkL75KpoBuVBQuQUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8PTpw1gyDV637/Pyi8nLsUq9JRvQOcwfOPsKRf3XUE=;
 b=OkJVxwqzzUQf107ZP6SGr+EZAsY/GJUb4nQW5uAoDSTGGdj+GwKemZh8l0yPVtIokB+zrZw7Ca2BfRLs2SBSFqrItsuV08eyjuP1pfOgSGYHnMpENQJanO+bcadeFv8pXIQy8/o1yjHMnpZCqniM1K10Hyd/MUnaSDvaWOlRuFyJKO+txErSXvN+8KaIRLMUQJGxYCfAwjxKTTSP8LhuuVgDTmVzFTToQPkXeCSqJvL6wLdHfd9CWqMLrp1vR+8IZyxXnvmzZuww6rVgt7RNkbdTHBDFxGEFs+zJHlywLXeN6EAK/8SYS5AI+hUuc5mDMkHjVlVM/+CJziUt6f6L1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8PTpw1gyDV637/Pyi8nLsUq9JRvQOcwfOPsKRf3XUE=;
 b=DxdaEiwDLr8Sn4Ra8gWUEw/YduRy3A2m8aKAvBxpFDMyvey39ur38iWmzl18Hd9S9zko77Njv9joTdkgohv9VNBxGDYtN8Av6bsvqfo4JH7LzuU7Ff9WHyGiR6ksqGmEnA8NUQ4faTXKX7APdqxOTMKIDLae4tkXJ4KiXNvEZvf6ydoXNy78OubNH7KiobupkiFzT4g7V6skuxiNsEUtcAQw7snM3rzWbbap3IVfEkPEkPdB7mQKQ1CnLxw7pQzJkfYgKd1X/3veAu9Rsgu/cJobdqeRuIk5KO0bADs0/hD1MYy9P1mMPtWMy669Xp0Avn5vKWltOPJWcuAHKuVi2w==
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:11:03 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 13:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 13:11:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 05/15] net/mlx5e: psp: Use helpers for steering object manipulation
Date: Tue, 7 Jul 2026 16:08:48 +0300
Message-ID: <20260707130858.969928-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4719f3-c658-4377-c8d7-08dedc29322d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MrYl/d2dHa3SAb3K0eE2oMIUc6tWeU+l0DOlBEs3b61dq9mglu7hEYbIRBAgOD7zZLnNAnRu8oUEuUP83TZOd4rberjP2YFOTE7ZqVLRTNo0AV2Snxm1YQL9V1NkZgiBcrbzVjE8TsnWUUbJo3nOaU7nlqnl1mPL+vbQiQRBq9J30GTMmaSyH6AQicz21OK3dnToqUw4HgjZQJxkB716mKB9bwEZ0PALT4u5vbGmajHDb7KIJYSZERCD6/mUcrO3RY+v8ao1TwNK7hbQ/SWTcuWeEiszZ1a3zBww89ffDqMAsu6/kh02yljwy/itP4U0E+1ppwYitjZ+kuyW7DJXQwGpVa+lOEzhgMi3aVvNUVqDFkopBZa9k8fL1Ol/ZObz7Y3h02I74JjG6O2n5ag0aJG6+8S/7nM6PJ1U/RHZ0e2eWK9/5DUv6cb0p3KKarfNhq+xSLDYHYwd2jeAwggUhmOgG4ot1aMQ0dy1nE5oBzMZ1Bx5IEhyM9x5seJjHI1cK3+eSCA6OB6UBmd32viEJrjie2g/xEqXkirUlVfDB5uhWWpanrDuSqYPxQdCed3AysQ7P0pplXTcYiv0OejJDIY9dpJZpsUEu3Jlk3lAFbwMND0yOgLqANJAuR4tRC3c16rQOjk8T52mJc8NguBXDE5Kfv4402xCzJQF0n3J6AIOjuuHLhlXucXSH4enuXD1k9Vj4oHgZe5V2Gb48VnCfg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VwbL2Dxm4PiAwvVTeasr0swglitj+5L4BeRPnRkrAAZKhUH/D+jPwZdDl1aU1xbV5kcRnFzMvwygwAygQIGZMv5+HJ/fHPoEIE3EU/7si89LKrOQrEy0HczbDYgekq929cvtpocgHcPCipu9d+BVbN7KweeErZwmGkJLKyuVkA9Gd9tSM24LAiL6uWu2OqnsP4kf91V+ycoijhMD97xnSw3BNO7LA9kWAIQKqkwZ2exr5aWJQ7TI2tEpVJ93N7ZIU0+t5EvqNxzB8Y4JFJka++wtEsvy5/Y0+h99Gm5OMYmfkFZ8MWNUaB9r1tCQQ2nokRzEVRpPcE8g0axWrsNdiAACN3Tq7pLgYK8Uy0VuHHWe+qZOUrXF1if5voHSttHEpukIj+IefAT7takKYgH4P/uQWXAhn/tpuX2sJ6yy4MTWdKhYw5zEfWK4AdfP0twa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:02.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4719f3-c658-4377-c8d7-08dedc29322d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22824-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 634A371BC1A

From: Cosmin Ratiu <cratiu@nvidia.com>

Add helper functions for creating and destroying PSP steering objects to
reduce code duplication.
This will become more relevant in future patches which add more steering
tables/groups/flows.

One nice side-effect of this is that the cleanup functions become
idempotent and can be used instead of long goto chains. This further
simplifies the code.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 304 +++++++++---------
 1 file changed, 149 insertions(+), 155 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 5c34c0be997a..a1c7ca4ae722 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -73,38 +73,103 @@ static enum mlx5_traffic_types fs_psp2tt(enum accel_fs_psp_type i)
 	return MLX5_TT_IPV6_UDP;
 }
 
-static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
-					   struct mlx5e_psp_rx_err *rx_err)
+static int accel_psp_fs_create_ft(struct mlx5e_psp_fs *fs,
+				  struct mlx5_flow_table_attr *ft_attr,
+				  struct mlx5_flow_table **ft)
 {
-	if (rx_err->bad_rule) {
-		mlx5_del_flow_rules(rx_err->bad_rule);
-		rx_err->bad_rule = NULL;
+	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
+	int err = 0;
+
+	*ft = mlx5_create_auto_grouped_flow_table(ns, ft_attr);
+	if (IS_ERR(*ft)) {
+		err = PTR_ERR(*ft);
+		*ft = NULL;
 	}
 
-	if (rx_err->err_rule) {
-		mlx5_del_flow_rules(rx_err->err_rule);
-		rx_err->err_rule = NULL;
+	return err;
+}
+
+static void accel_psp_fs_destroy_ft(struct mlx5_flow_table **table)
+{
+	if (*table) {
+		mlx5_destroy_flow_table(*table);
+		*table = NULL;
+	}
+}
+
+static void accel_psp_fs_del_flow_rule(struct mlx5_flow_handle **rule)
+{
+	if (*rule) {
+		mlx5_del_flow_rules(*rule);
+		*rule = NULL;
 	}
+}
+
+static int accel_psp_fs_create_miss_group(struct mlx5_flow_table *ft,
+					  struct mlx5_flow_group **group)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	u32 *in = kvzalloc(inlen, GFP_KERNEL);
+	int err = 0;
+
+	if (!in)
+		return -ENOMEM;
 
-	if (rx_err->auth_fail_rule) {
-		mlx5_del_flow_rules(rx_err->auth_fail_rule);
-		rx_err->auth_fail_rule = NULL;
+	MLX5_SET(create_flow_group_in, in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, in, end_flow_index, ft->max_fte - 1);
+	*group = mlx5_create_flow_group(ft, in);
+	if (IS_ERR(*group)) {
+		err = PTR_ERR(*group);
+		*group = NULL;
 	}
+	kvfree(in);
+
+	return err;
+}
 
-	if (rx_err->rule) {
-		mlx5_del_flow_rules(rx_err->rule);
-		rx_err->rule = NULL;
+static void accel_psp_fs_destroy_flow_group(struct mlx5_flow_group **group)
+{
+	if (*group) {
+		mlx5_destroy_flow_group(*group);
+		*group = NULL;
 	}
+}
 
+static int accel_psp_fs_create_counter(struct mlx5_core_dev *dev,
+				       struct mlx5_fc **counter)
+{
+	*counter = mlx5_fc_create(dev, false);
+	if (IS_ERR(*counter)) {
+		int err = PTR_ERR(*counter);
+
+		*counter = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+static void accel_psp_fs_destroy_counter(struct mlx5_core_dev *dev,
+					 struct mlx5_fc **counter)
+{
+	if (*counter) {
+		mlx5_fc_destroy(dev, *counter);
+		*counter = NULL;
+	}
+}
+
+static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
+					   struct mlx5e_psp_rx_err *rx_err)
+{
+	accel_psp_fs_del_flow_rule(&rx_err->bad_rule);
+	accel_psp_fs_del_flow_rule(&rx_err->err_rule);
+	accel_psp_fs_del_flow_rule(&rx_err->auth_fail_rule);
+	accel_psp_fs_del_flow_rule(&rx_err->rule);
 	if (rx_err->copy_modify_hdr) {
 		mlx5_modify_header_dealloc(fs->mdev, rx_err->copy_modify_hdr);
 		rx_err->copy_modify_hdr = NULL;
 	}
-
-	if (rx_err->ft) {
-		mlx5_destroy_flow_table(rx_err->ft);
-		rx_err->ft = NULL;
-	}
+	accel_psp_fs_destroy_ft(&rx_err->ft);
 }
 
 static void accel_psp_setup_syndrome_match(struct mlx5_flow_spec *spec,
@@ -124,7 +189,6 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 				  struct mlx5e_accel_fs_psp_prot *fs_prot,
 				  struct mlx5e_psp_rx_err *rx_err)
 {
-	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
@@ -133,7 +197,6 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_flow_handle *fte;
 	struct mlx5_flow_spec *spec;
-	struct mlx5_flow_table *ft;
 	int err = 0;
 
 	spec = kzalloc_obj(*spec);
@@ -144,14 +207,12 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	ft_attr.autogroup.max_num_groups = 2;
 	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL;
 	ft_attr.prio = MLX5E_NIC_PRIO;
-	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
+	err = accel_psp_fs_create_ft(fs, &ft_attr, &rx_err->ft);
+	if (err) {
 		mlx5_core_err(fs->mdev,
 			      "fail to create psp rx inline ft err=%d\n", err);
-		goto out_spec;
+		goto out_err;
 	}
-	rx_err->ft = ft;
 
 	/* Action to copy 7 bit psp_syndrome to regB[23:29] */
 	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
@@ -167,7 +228,7 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 		err = PTR_ERR(modify_hdr);
 		mlx5_core_err(mdev,
 			      "fail to alloc psp copy modify_header_id err=%d\n", err);
-		goto out_ft;
+		goto out_err;
 	}
 	rx_err->copy_modify_hdr = modify_hdr;
 
@@ -184,8 +245,9 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 2);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add psp rx err copy rule err=%d\n", err);
-		goto out_modhdr;
+		mlx5_core_err(mdev, "fail to add psp rx err rule err=%d\n",
+			      err);
+		goto out_err;
 	}
 	rx_err->rule = fte;
 
@@ -203,7 +265,7 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx auth fail drop rule err=%d\n",
 			      err);
-		goto out_drop_rule;
+		goto out_err;
 	}
 	rx_err->auth_fail_rule = fte;
 
@@ -221,7 +283,7 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx framing err drop rule err=%d\n",
 			      err);
-		goto out_drop_auth_fail_rule;
+		goto out_err;
 	}
 	rx_err->err_rule = fte;
 
@@ -238,27 +300,14 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx misc. err drop rule err=%d\n",
 			      err);
-		goto out_drop_error_rule;
+		goto out_err;
 	}
 	rx_err->bad_rule = fte;
 
 	goto out_spec;
 
-out_drop_error_rule:
-	mlx5_del_flow_rules(rx_err->err_rule);
-	rx_err->err_rule = NULL;
-out_drop_auth_fail_rule:
-	mlx5_del_flow_rules(rx_err->auth_fail_rule);
-	rx_err->auth_fail_rule = NULL;
-out_drop_rule:
-	mlx5_del_flow_rules(rx_err->rule);
-	rx_err->rule = NULL;
-out_modhdr:
-	mlx5_modify_header_dealloc(mdev, modify_hdr);
-	rx_err->copy_modify_hdr = NULL;
-out_ft:
-	mlx5_destroy_flow_table(rx_err->ft);
-	rx_err->ft = NULL;
+out_err:
+	accel_psp_fs_rx_err_destroy_ft(fs, rx_err);
 out_spec:
 	kfree(spec);
 	return err;
@@ -268,30 +317,14 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 static void accel_psp_fs_rx_fs_destroy(struct mlx5e_psp_fs *fs,
 				       struct mlx5e_accel_fs_psp_prot *fs_prot)
 {
-	if (fs_prot->def_rule) {
-		mlx5_del_flow_rules(fs_prot->def_rule);
-		fs_prot->def_rule = NULL;
-	}
-
+	accel_psp_fs_del_flow_rule(&fs_prot->def_rule);
 	if (fs_prot->rx_modify_hdr) {
 		mlx5_modify_header_dealloc(fs->mdev, fs_prot->rx_modify_hdr);
 		fs_prot->rx_modify_hdr = NULL;
 	}
-
-	if (fs_prot->miss_rule) {
-		mlx5_del_flow_rules(fs_prot->miss_rule);
-		fs_prot->miss_rule = NULL;
-	}
-
-	if (fs_prot->miss_group) {
-		mlx5_destroy_flow_group(fs_prot->miss_group);
-		fs_prot->miss_group = NULL;
-	}
-
-	if (fs_prot->ft) {
-		mlx5_destroy_flow_table(fs_prot->ft);
-		fs_prot->ft = NULL;
-	}
+	accel_psp_fs_del_flow_rule(&fs_prot->miss_rule);
+	accel_psp_fs_destroy_flow_group(&fs_prot->miss_group);
+	accel_psp_fs_destroy_ft(&fs_prot->ft);
 }
 
 static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
@@ -306,55 +339,42 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 				     struct mlx5e_accel_fs_psp_prot *fs_prot)
 {
-	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(fs->fs, false);
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
-	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_modify_hdr *modify_hdr = NULL;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
-	struct mlx5_flow_group *miss_group;
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
-	struct mlx5_flow_table *ft;
-	u32 *flow_group_in;
 	int err = 0;
 
-	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
 	spec = kvzalloc_obj(*spec);
-	if (!flow_group_in || !spec) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!spec)
+		return -ENOMEM;
 
 	/* Create FT */
 	ft_attr.max_fte = 2;
 	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_LEVEL;
-	ft_attr.prio = MLX5E_NIC_PRIO;
 	ft_attr.autogroup.num_reserved_entries = 1;
 	ft_attr.autogroup.max_num_groups = 1;
-	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	err = accel_psp_fs_create_ft(fs, &ft_attr, &fs_prot->ft);
+	if (err) {
 		mlx5_core_err(mdev, "fail to create psp rx ft err=%d\n", err);
 		goto out_err;
 	}
-	fs_prot->ft = ft;
 
 	/* Create miss_group */
-	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
-	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
-	miss_group = mlx5_create_flow_group(ft, flow_group_in);
-	if (IS_ERR(miss_group)) {
-		err = PTR_ERR(miss_group);
+	err = accel_psp_fs_create_miss_group(fs_prot->ft, &fs_prot->miss_group);
+	if (err) {
 		mlx5_core_err(mdev, "fail to create psp rx miss_group err=%d\n", err);
 		goto out_err;
 	}
-	fs_prot->miss_group = miss_group;
 
 	/* Create miss rule */
-	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &fs_prot->default_dest, 1);
+	rule = mlx5_add_flow_rules(fs_prot->ft, spec, &flow_act,
+				   &fs_prot->default_dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_err(mdev, "fail to create psp rx miss_rule err=%d\n", err);
@@ -399,12 +419,11 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 	}
 
 	fs_prot->def_rule = rule;
-	goto out;
+	goto out_spec;
 
 out_err:
 	accel_psp_fs_rx_fs_destroy(fs, fs_prot);
-out:
-	kvfree(flow_group_in);
+out_spec:
 	kvfree(spec);
 	return err;
 }
@@ -456,82 +475,61 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 	if (!accel_psp)
 		return;
 
-	mlx5_fc_destroy(fs->mdev, accel_psp->rx_bad_counter);
-	mlx5_fc_destroy(fs->mdev, accel_psp->rx_err_counter);
-	mlx5_fc_destroy(fs->mdev, accel_psp->rx_auth_fail_counter);
-	mlx5_fc_destroy(fs->mdev, accel_psp->rx_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_bad_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_err_counter);
+	accel_psp_fs_destroy_counter(fs->mdev,
+				     &accel_psp->rx_auth_fail_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_counter);
 	kfree(accel_psp);
 	fs->rx_fs = NULL;
 }
 
 static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_accel_fs_psp *accel_psp;
 	struct mlx5_core_dev *mdev = fs->mdev;
-	struct mlx5_fc *flow_counter;
 	int err;
 
-	accel_psp = kzalloc_obj(*accel_psp);
-	if (!accel_psp)
+	fs->rx_fs = kzalloc_obj(*fs->rx_fs);
+	if (!fs->rx_fs)
 		return -ENOMEM;
 
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_counter);
+	if (err) {
 		mlx5_core_warn(mdev,
-			       "fail to create psp rx flow counter err=%pe\n",
-			       flow_counter);
-		err = PTR_ERR(flow_counter);
+			       "fail to create psp rx flow counter err=%d\n",
+			       err);
 		goto out_err;
 	}
-	accel_psp->rx_counter = flow_counter;
 
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
+	err = accel_psp_fs_create_counter(mdev,
+					  &fs->rx_fs->rx_auth_fail_counter);
+	if (err) {
 		mlx5_core_warn(mdev,
-			       "fail to create psp rx auth fail flow counter err=%pe\n",
-			       flow_counter);
-		err = PTR_ERR(flow_counter);
-		goto out_counter_err;
+			       "fail to create psp rx auth fail flow counter err=%d\n",
+			       err);
+		goto out_err;
 	}
-	accel_psp->rx_auth_fail_counter = flow_counter;
 
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_err_counter);
+	if (err) {
 		mlx5_core_warn(mdev,
-			       "fail to create psp rx error flow counter err=%pe\n",
-			       flow_counter);
-		err = PTR_ERR(flow_counter);
-		goto out_auth_fail_counter_err;
+			       "fail to create psp rx error flow counter err=%d\n",
+			       err);
+		goto out_err;
 	}
-	accel_psp->rx_err_counter = flow_counter;
 
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
+	err = accel_psp_fs_create_counter(mdev, &fs->rx_fs->rx_bad_counter);
+	if (err) {
 		mlx5_core_warn(mdev,
-			       "fail to create psp rx bad flow counter err=%pe\n",
-			       flow_counter);
-		err = PTR_ERR(flow_counter);
-		goto out_err_counter_err;
+			       "fail to create psp rx bad flow counter err=%d\n",
+			       err);
+		goto out_err;
 	}
-	accel_psp->rx_bad_counter = flow_counter;
-
-	fs->rx_fs = accel_psp;
 
 	return 0;
 
-out_err_counter_err:
-	mlx5_fc_destroy(mdev, accel_psp->rx_err_counter);
-	accel_psp->rx_err_counter = NULL;
-out_auth_fail_counter_err:
-	mlx5_fc_destroy(mdev, accel_psp->rx_auth_fail_counter);
-	accel_psp->rx_auth_fail_counter = NULL;
-out_counter_err:
-	mlx5_fc_destroy(mdev, accel_psp->rx_counter);
-	accel_psp->rx_counter = NULL;
 out_err:
-	kfree(accel_psp);
-	fs->rx_fs = NULL;
-
+	accel_psp_fs_cleanup_rx(fs);
 	return err;
 }
 
@@ -675,12 +673,9 @@ static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
 
 static void accel_psp_fs_tx_destroy(struct mlx5e_psp_tx *tx_fs)
 {
-	if (!tx_fs->ft)
-		return;
-
-	mlx5_del_flow_rules(tx_fs->rule);
-	mlx5_destroy_flow_group(tx_fs->fg);
-	mlx5_destroy_flow_table(tx_fs->ft);
+	accel_psp_fs_del_flow_rule(&tx_fs->rule);
+	accel_psp_fs_destroy_flow_group(&tx_fs->fg);
+	accel_psp_fs_destroy_ft(&tx_fs->ft);
 }
 
 static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
@@ -690,7 +685,7 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 	if (!tx_fs)
 		return;
 
-	mlx5_fc_destroy(fs->mdev, tx_fs->tx_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &tx_fs->tx_counter);
 	kfree(tx_fs);
 	fs->tx_fs = NULL;
 }
@@ -699,8 +694,8 @@ static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_namespace *ns;
-	struct mlx5_fc *flow_counter;
 	struct mlx5e_psp_tx *tx_fs;
+	int err;
 
 	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
 	if (!ns)
@@ -710,15 +705,14 @@ static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 	if (!tx_fs)
 		return -ENOMEM;
 
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
+	err = accel_psp_fs_create_counter(mdev, &tx_fs->tx_counter);
+	if (err) {
 		mlx5_core_warn(mdev,
-			       "fail to create psp tx flow counter err=%pe\n",
-			       flow_counter);
+			       "fail to create psp tx flow counter err=%d\n",
+			       err);
 		kfree(tx_fs);
-		return PTR_ERR(flow_counter);
+		return err;
 	}
-	tx_fs->tx_counter = flow_counter;
 	tx_fs->ns = ns;
 	fs->tx_fs = tx_fs;
 	return 0;
-- 
2.44.0


