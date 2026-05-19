Return-Path: <linux-rdma+bounces-20994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOPoELjCDGqJlgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:06:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FED584784
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39D543058D5B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EE3B47F4;
	Tue, 19 May 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AeRkbdlu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4263B9930;
	Tue, 19 May 2026 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221158; cv=fail; b=sOjWTOAD40OidH9RvDmqXAv1HwidMqsCFHeiiwSsLkxT1QhgLwwPyOxRryWq3SCNIPzjJNhgAxbV0cw25yB+ZXWGRm15mlA7I03miLVtoYjdjFI1zWsydeTmWXVSei38ZMpIVAphLfkYwsWq2/0MBNy2B+IWTmMTm/lIcKsYR28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221158; c=relaxed/simple;
	bh=s+HZD03Ink+zh/DPIqgpvTbWxivhW+LK8etUILsWPdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCKVnOolXbd11DC3XLlPT8p0HE/ggYdQb9XwAVJSg2De92xQK9WJqEYcT//6+mM/BH8RTbDnVzCJtPLlJ2fleUfTpXqUjxZIBOtI2UpBUh2vlX8dLLxsCKNiwGK/aTdskIi8Ko5w3L4dmNHAlpHi5ndcBWqBn/uAHZm7fIKuTxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AeRkbdlu; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILL5ZZLBNs1Q48Cr4LD02fVo53aUyiolphEU0s6nbq99eymzErzvrHcqS/R9in8oYgteuCDSzN8kqZyDTu1u9n2gmLtz2qOIukWPurSxLyqQC948VlDuP2ViLHd+SXuJbGIJpR3DMpQtNaW8ndBWtdy83YeypW+Q0hYSkY8LwITV3W64W4nmVjpkHIAjZoytAO3G3fzYdi9FZ0fBxA4bicTAXSmY8qC23uJthKDLbSIsQV2UWZLv8RB1ju3Rg59KiSuFogMoWCMAOw416yZlGg9kUF7evbxu86WyPwMacEF0REFS8IUFx36Gt3YtPodbHfLdnRTF35ifO5XUraxMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVyUogci/smQCsxJ3OUUcEelCEjHwAjhp8rTIfjyGQk=;
 b=PNSnUcmCkjC2miLT5IhIhKKCBqiLdCDU6ShkvljENo7EF3+PVzwFciGY1SetnZMe8Hs60rycqlAthtIprOIQ4/RQCS2T6gYjeW+xV46jikJ456luiutW311qg7dhN6c7gvnCSWnbHWaIXYuq+P8tn8bWwy9aUhlEwleHcSP2C80J77uBOuDA71IzSYpL3/7LOKvgMpZzZavpMFQ0UBFcIbNRSSNfKrjuCWHPOBkQd2lJpdLiobT/2dFN76yCDdLaG4LSDUQJmizpTrNUUSjejfI5C+y0dWvvqN9pYEI82Pv5SjyskPobVpABQOoMw7pdEefuobWYO2JEA1BqP8MIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVyUogci/smQCsxJ3OUUcEelCEjHwAjhp8rTIfjyGQk=;
 b=AeRkbdluqb/FBLVa2snWN9tCLtWfVI144chaYB3XsMLTja40lbxo2szRYPD2KRWO9MpE4J4CoP7oNz3l0QS9N+ZJPnKwAn2rTn6kdh+TF84CUH618kP/12HgMS4PmCy7QTiCPx5o3nF+MmNCAMA759XCFEp+VXL6XNP9F7qAV8ftvSu3EtrRSWwQYLL9tF+4gYtQjQwSAu6weoaAhzqBdL4LY9Z7HsrhS1aoDYcBdJJakkj+nMr2qplOfX0JoYJW/yx9BFDK+IFMDHla2MuUST9sw6/AmD6gyc5mlB//hQTMNXX4Qke1iIaeLf7ojaT46BW1AfdHZRPL1Qb53PmYkg==
Received: from DS1P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::9) by
 DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Tue, 19 May 2026 20:05:41 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:451:cafe::1c) by DS1P221CA0005.outlook.office365.com
 (2603:10b6:8:451::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 20:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 20:05:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 19
 May 2026 13:05:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	"David Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net-next V2 2/2] net/mlx5: implement max_sfs parameter
Date: Tue, 19 May 2026 23:04:36 +0300
Message-ID: <20260519200436.353249-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260519200436.353249-1-tariqt@nvidia.com>
References: <20260519200436.353249-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e570dc-5d86-4732-ef2e-08deb5e200ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|18002099003|22082099003|11063799006|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LFDvAQE950SA2HhmKQo1KelWbEQshpV1H+oLTcAdYph0QjF/0WbndmHwY2jz3LGE3njr0gOhl6JwZiIsoO3PGo7F/tR/CT44fxIEiGUYsTXF+rw/kTE5IbJcBWiMZrkvzWtPgCmG7dWKj1fB9uIzSZRmghrwnyBN04V1fIRqV/Xs88PyEe5oBCHaB+QEXzBY85/cnaBgmjV+mZ7pbR6ctk2rVGGDK5G9cHAmrqPFRS6uZps3FR5qzqavfmkpXtQ33uKKvixNjMXfElyFbrfDra20OP1qvM1Sujz4kvRp1OLbFqaKM9h9kTfR0Ekcmyk6cupbqCN6Jur4UGKAPXWhV4NWQKac5w9Ocr+rHbGaS8oV+UxL5TWHQJRHEpzYUSDpnUEupCNqY3E/Uido17m8w5PCIsnqcDsZftMFYr1Xpqlf75CCtiF3nsYt1y8uFzS2A2iwSC7zrvDUk+zy+PVdoTJYwUpFepn73UdKNwC+x0TEyEA++UhD9S/Wb+Db/nj2kBd1Tn4ZUnuF834qdPFqD+n5gpWZpsKiUo4PtU0M/oSabMwXZyejXlkeL1ZZkb1wQez+cjbr0W3Ius4WKrv/Q5yOIyduxSqTL+5B/h7vxAm4SxqSN+qnJKLixkN3+++cD0Cr8NS9HLU5rBrN3mkfbbN/KboRErLtr4ojb15wOcqDQkiz+/KUY9xA6wq2BnB6PshPgsGetwZyXc23DfObGaKd5nk/nBsmBAjN/1V5xlk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(56012099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ChF+/UYJMDqicW7fRcNsz2q/ons1wcV115OPy03L+/NJL4+bvmVWA16ULujLZv/dID0Hz8ROGue8tyk/XT2kHtj749j0xSvKn8224Bu+sJRPeZSbwB75FgMjpLF0RZIkTGrF+j1YhtJkxlGxD02C1jIRiaByuwJqiyXzMbJ+p+u0hhokcSMB+o8H45mqAeDJftJA7+gdVZQHLR4vpXREXoNFW66uIxPOTNpZA1Gp/f+Nog0Xr/cPLPbCNRMt/PDR/X0dGg/lDX58gmtAemSXRIfpjpca3SSWq7hh4liKwcY187wnOZaLWlqjzbiofGdkbXWoMQSX/2kg/eupwhQtIAu3rRoMVEIWsfX5tK8OGmwlc+3ZtcObNM1BJ1cSVCdNSHgxILA5ayDBgG0I/G44WBxik1dBXRrHzmqRAs9wWZvRxRamiSEjKTnOWovUAIPr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:05:41.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e570dc-5d86-4732-ef2e-08deb5e200ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20994-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 07FED584784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Implement max_sfs generic parameter to allow users to control the total
light-weight NIC subfunctions that can be created using devlink instead
of external vendor tools. A value of 0 will effectively disable creation
of new subfunction devices. A warning is sent to user-space via extack
(returning extack without error code is interpreted as a warning by
user-space tools).

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 83 ++++++++++++++++++-
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..f5e2dccafa5a 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -45,8 +45,13 @@ Parameters
      - The range is between 1 and a device-specific max.
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``max_sfs``
+     - permanent
+     - The range is between 0 and a device-specific max.
+     - Applies to each physical function (PF) independently.
 
-Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
+Note: permanent parameters such as ``enable_sriov``, ``total_vfs`` and ``max_sfs``
+      require FW reset to take effect
 
 .. code-block:: bash
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 19bb620b7436..eff3a67e4ca0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -68,7 +68,9 @@ struct mlx5_ifc_mnvda_reg_bits {
 
 struct mlx5_ifc_nv_global_pci_conf_bits {
 	u8         sriov_valid[0x1];
-	u8         reserved_at_1[0x10];
+	u8         reserved_at_1[0xa];
+	u8         per_pf_num_sf[0x1];
+	u8         reserved_at_c[0x5];
 	u8         per_pf_total_vf[0x1];
 	u8         reserved_at_12[0xe];
 
@@ -93,9 +95,11 @@ struct mlx5_ifc_nv_global_pci_cap_bits {
 };
 
 struct mlx5_ifc_nv_pf_pci_conf_bits {
-	u8         reserved_at_0[0x9];
+	u8         log_sf_bar_size[0x8];
+	u8         pf_total_sf_en[0x1];
 	u8         pf_total_vf_en[0x1];
-	u8         reserved_at_a[0x16];
+	u8         reserved_at_a[0x6];
+	u8         total_sf[0x10];
 
 	u8         reserved_at_20[0x20];
 
@@ -755,6 +759,76 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int mlx5_devlink_max_sfs_get(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_sf);
+
+	return 0;
+}
+
+static int mlx5_devlink_max_sfs_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change per_pf_num_sf global PCI configuration");
+		return err;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_pf_pci_conf, data, log_sf_bar_size, ctx->val.vu32 ? 12 : 0);
+	MLX5_SET(nv_pf_pci_conf, data, pf_total_sf_en, !!ctx->val.vu32);
+	MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change PF PCI configuration");
+		return err;
+	}
+	NL_SET_ERR_MSG(extack, "Modifying max_sfs requires a reboot");
+
+	return 0;
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      mlx5_devlink_enable_sriov_get,
@@ -763,6 +837,9 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			      mlx5_devlink_total_vfs_get,
 			      mlx5_devlink_total_vfs_set,
 			      mlx5_devlink_total_vfs_validate),
+	DEVLINK_PARAM_GENERIC(MAX_SFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_devlink_max_sfs_get,
+			      mlx5_devlink_max_sfs_set, NULL),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.44.0


