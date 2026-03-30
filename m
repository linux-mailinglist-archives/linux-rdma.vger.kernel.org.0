Return-Path: <linux-rdma+bounces-18808-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IOjBDjSymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18808-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBD360932
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1F2F30263E5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02F39B489;
	Mon, 30 Mar 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBu+2rHu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350C37EFE3;
	Mon, 30 Mar 2026 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899696; cv=fail; b=lzCy6NJfS6G6S5XUVPT8cMGXbVgzRQwzBgHsErIFBjfpWgKZRzXpgQGdlCfu5wUgjERSxZKdOpEnzfbkCBI3ue/C5OdNZmjS5CtORWnpalErObkXllZi2JC17wAtUwwH/Gw48IqIlrIN0/QRi2VlpgQ5ufPsczx2c0jnTG4CHWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899696; c=relaxed/simple;
	bh=3j5urw42CRoeEtlbD61/hWs4pabkf8qkXj9/CW69vbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hejyFlaZESGCiQO6ckWje0Ql53XMqpnHk0nWktjJgyAkEmn8ePCuTq+ZRnVX1o3DSYzqgcZomKHxPWmyRlyc4dxKJzyq+Nx3NtLgUu3FB6ZT42IpHJLcYs3vDapE/wg+/8PWa4alGpH4IXT5uoTdYF2SMZDWM2drdUT9+dxeb+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MBu+2rHu; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytuGmFPgi5SYSfUXrSgU3oLISq9KVQUyY9jDmEUkWwfx6ucq9eNPoQ2UnuGgfJcUF3Gl74+Ysrs/Ac+IElK9SJgy0K8McO2jbxfn2OYsR8keU4a9dZG9EUnMT1hWuc+btktkNOZGQcmaIdufnMCmLFVDu3wt7fgq6ouqljVBlLdvJr7ZZsGTfFgSspJZhNRBClxgicX4qP49JFbfTWJWf4xxgY2ZGC1qsl045y+aM8+Y0ptmL3WG2ctr75750DrizfLyEHIYepwcDTPOKV1eDm01PnDiPpDMVhbaV486B7/UKuGJxFEtc1sUSqc1uP/MfCvHdaddMaU2spr+7Y2/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOcbX8a5sv5GA3VBH6eGINd9LtJF7xmVHwWs1+y4Hd8=;
 b=C1I8aaeSWjOzbiuQX0NqU7OI5xNGVLd6nNyRuuMF9kRG2LLdkSSMwDm+m4bUiGNRUv/lirlln2l9MgVxgUEhPzm4mqZ4Zy46mVDxAJArK8nSZu9wgk/AjE//SFZs54h4IHRXieHQIj6nLdlAKM56IrR6lsuksulEwIWHHkFyMQzy4M+JTCrrW1pR+NlUmHuPrNPotU8xcE/+/9CM4piadLsHxZzTv9dTCMYXAkpBWy6If1AVVmsXL/jc2CXyjPZPZti6lWRZGfKOGM2346X0bv3POfFx9CwVSI8JxNci6FDmyW9rdAPG4Kae8IUmPlp1weUXnBC1ELiZruaNqClffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOcbX8a5sv5GA3VBH6eGINd9LtJF7xmVHwWs1+y4Hd8=;
 b=MBu+2rHu1KH1RhQA6Li9wer3fqR0bqURdOorwiHIrV+Exd0Uxsj1hKA4hb8bGMsNYLO9dtDDcRwUaW4NpIzX2W6SfAJWle28wA2CpWEw/SGCoFW3srMQy49U3qO2imr6H7KFHUj1vRFXcLFZ56eNRxjtac3LwS5SDYijI8cXBO+rfpP2uPPl+X0ye/veGLh3OyQPMa0rUfIIAFgHU/tS0VScL2AzMvpILIw3IC8/WFCZeFpIOPYtT2Vb6yLmksgqyhx1rOMaRAAYtLVDmInKI1/fV5dtbI5AaknHi6SaNLGj81fGEeP/b62ARrwqA+lAbj4q/k384hgV/tgmQiXZ1A==
Received: from BY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:a03:1a0::37)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:41:27 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::f4) by BY5PR16CA0024.outlook.office365.com
 (2603:10b6:a03:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:41:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:41:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 12:41:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 12:41:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Shay Agroskin <shayag@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5: Avoid "No data available" when FW version queries fail
Date: Mon, 30 Mar 2026 22:40:14 +0300
Message-ID: <20260330194015.53585-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330194015.53585-1-tariqt@nvidia.com>
References: <20260330194015.53585-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 68402263-de21-4ff5-fd30-08de8e94555d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iwwsK+WMdHbvk1QMibBnwdvlnEl5NAdF36J3oFi2ZbqCpPNSJGaZEGt6vxKMQlX/EmO7BpVQY+W6IJsGay9K9EdDANgsdZKja3ntWmLiAUPEk14f3Eh+l4U0Yk4XyO30VoWsTX7bVFtAlkJi5FurkNpV1DeG7qmbDxYG/HRFZlZLZ+pw4SIBwgShaaPyCZ5xccz424mK8cRMMOjD3Fi+7OZQnJt6W/8PlA70WiMlZ9TkNe/qNhCIU70sheULL4/3r4C2Unt/mpjO7M01r6gGhSCpy/tTnj27vHq6ZOOIxcbMFPKwKXrfU70zKG0jIt2Ntbufkj136TfX6xCUVK3VLUCuCmG1sSGC8angyKKMceV9xbi83YjYr7ZjD9Uvkn0HYEVQCGoNT9Hl5BAp2bZfNHLyZaZZbQIuSa7HdvoenpHuhCLCtz+i3uzjNyZyiST/b1WN/5T8zPBhlpF3tvoEOr4vAU2bAu7o8AK82deo+cxBgqgzF5az9UACJRI1qaGj23YgTH9CKMx+Jkiu0wYCYeaVbg3adQqCkN0aVaOdheQ7RfME3uGxQ9F7XBWZD5uqHRC3JLs6bYA4BYDrgnpj+UG2AmridjSCnT0In70glnZBxxS9MxpEPYmkx6q8O5Mj5j5c69sz29q0Axn/ljEIEHcr5JHqCgXyTOglwhLB1nY/ssm8KCDid06No90SzrCmOE+U2/rRY7wM3mrmYKCWKuVz/G9+V15h5XGCfAq/O5cvj3pv5yPcqwIUwXYvW36q7SmmgzZETLM/HDutKc6WvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z57QEyjPNjhHey5+S9xKliFpjtn8QI96Q2yupBbRfAaBJekHG1vuxzI6+IOKBRENsx6TcHAEu1i79JY8pot8c+ijxOA6WRaqaV9C7sjK5eqZsx3jIUE+JKDND3uMw/DCJg4x4C7bewyOvj9Cj0VxXXepHn0WhieMv8RgBzKe2/aPhbzzqu2JprlvAW3MTLmas7QU9DYaPTFB0PEstaJf8qWtINe5sM0gh1S6kR8ksu6q5RwtnTigkbzESP1UrAqltO3+4J5p8zFmGBQB1YZ59EFJklUvB2kAzm6QRQIEVN1zS7fJBBjpSqPJ86qtwEJ7Es0bkKzbethjcCgleJqlIvtNnRNqD/92fOoF/1DvzV/dvobRTM1/eoUHXKARQQJAAiz257DiuTiNDaENFOp1C9+Pa+TInlckb8oEYYWr+93k5M8kSS5EIRt4qr3+zzom
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:41:27.1551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68402263-de21-4ff5-fd30-08de8e94555d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18808-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7BFBD360932
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saeed Mahameed <saeedm@nvidia.com>

Avoid printing the misleading "kernel answers: No data available" devlink
output when querying firmware or pending firmware version fails
(e.g. MLX5 fw state errors / flash failures).

FW can fail on loading the pending flash image and get its version due
to various reasons, examples:

mlxfw: Firmware flash failed: key not applicable, err (7)
mlx5_fw_image_pending: can't read pending fw version while fw state is 1

and the resulting:
$ devlink dev info
kernel answers: No data available

Instead, just report 0 or 0xfff.. versions in case of failure to indicate
a problem, and let other information be shown.

after the fix:
$ devlink dev info
pci/0000:00:06.0:
  driver mlx5_core
  serial_number xxx...
  board.serial_number MT2225300179
  versions:
      fixed:
        fw.psid MT_0000000436
      running:
        fw.version 22.41.0188
        fw 22.41.0188
      stored:
        fw.version 255.255.65535
        fw 255.255.65535

Fixes: 9c86b07e3069 ("net/mlx5: Added fw version query command")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 53 ++++++++++++-------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 6698ac55a4bf..73cf0321bb86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -107,9 +107,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
-	err = mlx5_fw_version_query(dev, &running_fw, &stored_fw);
-	if (err)
-		return err;
+	mlx5_fw_version_query(dev, &running_fw, &stored_fw);
 
 	snprintf(version_str, sizeof(version_str), "%d.%d.%04d",
 		 mlx5_fw_ver_major(running_fw), mlx5_fw_ver_minor(running_fw),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index eeb4437975f2..c1f220e5fe18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -822,48 +822,63 @@ mlx5_fw_image_pending(struct mlx5_core_dev *dev,
 	return 0;
 }
 
-int mlx5_fw_version_query(struct mlx5_core_dev *dev,
-			  u32 *running_ver, u32 *pending_ver)
+void mlx5_fw_version_query(struct mlx5_core_dev *dev,
+			   u32 *running_ver, u32 *pending_ver)
 {
 	u32 reg_mcqi_version[MLX5_ST_SZ_DW(mcqi_version)] = {};
 	bool pending_version_exists;
 	int component_index;
 	int err;
 
+	*running_ver = 0;
+	*pending_ver = 0;
+
 	if (!MLX5_CAP_GEN(dev, mcam_reg) || !MLX5_CAP_MCAM_REG(dev, mcqi) ||
 	    !MLX5_CAP_MCAM_REG(dev, mcqs)) {
 		mlx5_core_warn(dev, "fw query isn't supported by the FW\n");
-		return -EOPNOTSUPP;
+		return;
 	}
 
 	component_index = mlx5_get_boot_img_component_index(dev);
-	if (component_index < 0)
-		return component_index;
+	if (component_index < 0) {
+		mlx5_core_warn(dev, "fw query failed to find boot img component index, err %d\n",
+			       component_index);
+		return;
+	}
 
+	*running_ver = U32_MAX; /* indicate failure */
 	err = mlx5_reg_mcqi_version_query(dev, component_index,
 					  MCQI_FW_RUNNING_VERSION,
 					  reg_mcqi_version);
-	if (err)
-		return err;
-
-	*running_ver = MLX5_GET(mcqi_version, reg_mcqi_version, version);
-
+	if (!err)
+		*running_ver = MLX5_GET(mcqi_version, reg_mcqi_version,
+					version);
+	else
+		mlx5_core_warn(dev, "failed to query running version, err %d\n",
+			       err);
+
+	*pending_ver = U32_MAX; /* indicate failure */
 	err = mlx5_fw_image_pending(dev, component_index, &pending_version_exists);
-	if (err)
-		return err;
+	if (err) {
+		mlx5_core_warn(dev, "failed to query pending image, err %d\n",
+			       err);
+		return;
+	}
 
 	if (!pending_version_exists) {
 		*pending_ver = 0;
-		return 0;
+		return;
 	}
 
 	err = mlx5_reg_mcqi_version_query(dev, component_index,
 					  MCQI_FW_STORED_VERSION,
 					  reg_mcqi_version);
-	if (err)
-		return err;
-
-	*pending_ver = MLX5_GET(mcqi_version, reg_mcqi_version, version);
-
-	return 0;
+	if (!err)
+		*pending_ver = MLX5_GET(mcqi_version, reg_mcqi_version,
+					version);
+	else
+		mlx5_core_warn(dev, "failed to query pending version, err %d\n",
+			       err);
+
+	return;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b635b423d972..1507e881d962 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -393,8 +393,8 @@ int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
 
 int mlx5_firmware_flash(struct mlx5_core_dev *dev, const struct firmware *fw,
 			struct netlink_ext_ack *extack);
-int mlx5_fw_version_query(struct mlx5_core_dev *dev,
-			  u32 *running_ver, u32 *stored_ver);
+void mlx5_fw_version_query(struct mlx5_core_dev *dev, u32 *running_ver,
+			   u32 *stored_ver);
 
 #ifdef CONFIG_MLX5_CORE_EN
 int mlx5e_init(void);
-- 
2.44.0


