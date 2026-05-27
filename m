Return-Path: <linux-rdma+bounces-21365-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGsFCC/tFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21365-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:10:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F33F5E4AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BA5E30860C5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB46408029;
	Wed, 27 May 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhX440dz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2921E091;
	Wed, 27 May 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886612; cv=fail; b=OzSwUR8Uc6SBgpEe5dhQeo93rMMLKqIJHCSasfJZrkldpLYA4xvlnHmtPHm1LghfRB+NcKhp0pLaGbVr15eSh0LwwLSnyTVKChtFbV6awzD0nggvc/xEn1oT0BG4cYIbMG6c5eAs9OOkWFABkV+/cNhHDkC6adP37cV1n/4qSpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886612; c=relaxed/simple;
	bh=sQnAtlXhG2K63oWZXFT8sP4DXuosorjINpoJdmM0QKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7DBJBWaSkRjkjKp/4CVwLoEYEnaXar3kowS/vCKGDNEWkZl0v/dxlUVXQKzsskRIKDYDwEJMUTKdT+c2QQMm+ADqPX9Vkbn9sfRIyJeE+QsINNmGQf/VZoBdQgxH/v8uouAfeAEb/QMIHsjOV8IiMpgXytbyIMfPf4ZM2Csgws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nhX440dz; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLjAFVvbZaeSrjY4H88z/AEuvsvqjhwg+8URkKnJPt1wOr+6oChm/7xZ4fTgX7i3DWvo5RuSrq3u5752GfLSQQ1xw0oJHbcxQdsJz5l/VEUQnELIm3T63dcmd3F5Qmkgb/58WPRvyDFQ5kut+aUOOQ5RvhXqGRiVtoIIhwG9yDB5CZQHZiYaPvs9jp3p/Q2iRpifmShCwiabQCGqOXTaqVJDwnVy3du/A3t9Xs3Kaf59JPVsChs+nndMSKCSrxiNVGZDXanToAjKKiOH7rIyArRcNU1T9cJOlv9YHsutt2HgOCC1r56jpffWwJcgeurEnx7AZ1hVrP+05QH4adljOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBc5T5e3GYCM4CIelkXZlhrl5shwcWKAKGIY5D40HZA=;
 b=kh+M9fG+3e0MV3lHwB10V35C7wXKJe8tZU97JNUnlD7FEFCtesWRwDz1Z/ZtUZjr/NYYVPl/jkcmFywLiWdHe8ua2vn35fXfcqG2rH2wpE8KAIolSPsNCJQ6bURIublVs4jGXpgj6bF1VU9aJNTNdN2v9J+7D1L/y9cF6YnFDH/r3UL+OjLkFe105kMfSgnK3QD4gFuopxtjF0Sjza+55csMc9Qjd3g2we5tDzB2Dn8+SCg/OUxYYWa+pWb49bShA2BSLEaVJ5Tt95J3iqlzvrrChMooTpoquoLqFanCakW4Fr8fVDtp7hd4NXUto5uw8z8X47ixkh/j0ChEWEBcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBc5T5e3GYCM4CIelkXZlhrl5shwcWKAKGIY5D40HZA=;
 b=nhX440dzMldHiHuRp4/7JkwlVL84n3ApGTlupabnj7vD4okui7AzF0tczP3KwrgvPdha7xaceiXuAR1Z+wrZ+bTlOdx5OSiujDBHDUZIq85M6YmpV97cHm9BsM/e+j/Vh0Zfjity5x4SOktpw2iWzWZWC0QqUksPnD1ijW2MEHaz4LU08b0Ym3r1ZhoQlT6wkujaBe9soLuxB/KzDpN8hYDFNEULcIoGEIrmsPCeQ7tl4Uoo0AnlUxWBmlGvkRCPINJexC531leXqQAmLoW6D4ZTqOuoXytjE2WVD9kRFDoEMEL9kpp9xfkFGIFB5TpK0iNQqu8Tl4bYpKYCeQhppg==
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 12:56:46 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::57) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 12:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:56:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:56:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:56:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 13/13] net/mlx5e: Verify unique vhca_id count instead of range
Date: Wed, 27 May 2026 15:54:27 +0300
Message-ID: <20260527125427.385976-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ec7503-2d74-4d09-d31b-08debbef68bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AiwUFlWLW+CSTd6Jh3gGNvLIMK1V1yDdktlRIWitkn8RklPRMSHfAwdSb3Hxub37gwPFBFL0NtsLJa9bMQHcc1lRvKIRkrz+yAE+QMsgYiiWZGN11IB63H7WdGMl/iWJfOD6SBfHPv1kQ8eBtbrp5qZqVq0C+pQzdrORaHSeWyAcNCNaEDRJbs0UN4Rsqom85xxHH9zpax8KANp94s74JeU8Za1yjXUMgIY0r9upS5GGO+aVMcEEJUiERsF6jPQiHWubYoAmCLitthGCTgzR/koPJB0Znqv93Si1U8vooAVsUtGnB7+t40vVai+MOfiur+qxT/Gmn2Djq5Nl0Lh40nTOY2SbtgNZCg9lr3t74f9xsq+J9wxXn5SXM2adjqvy/T+IzEd2utF0LAErDy39y8gRY8cjpaHX4i9lQWvQgOsVsLabPmeem+fM3Ff4HWxXbMeUlSejSTULxERbhTNIieHo1VpwLx1U8hPqV65thMhlhMeEP2PY3vf9A64mghAE8XJYJQ+3ZXqaSg565IpMXogUhp/tTrKKJRFhIZrmFTxHf8w/TLD2yvNWF5NAueviP+EwCEAB0sc86tEG+g4js1ja9+gfpnINiHk9JgrUOMJQnW4LFyzsOQVSpH59SZ8Ef9FP7Oh+sqsNy572Jskxh8fmmNu9pZgT4o3shgHzmGm551/DxD2Va9mkVIj46rlDmvSGgyI9KNbBypGdLkj555XJtGLX+ADMmXv8MJWtI/o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A/LF/cKVlNb8FB9s4FuBk4AxBt08JKyoIlymmXSdge+qRU5R7Lw1mAGjrInXZWfQqiEWcoQk02HuOQZ5VOFkYXFSwoFIDcy3YpNWfyFH+++fISa+OXXhqduaWOjhV4XZndFiO6M/ITqpwtxXbCPIvQPrQYGJ8vSxVxvLeDFdke7s7z2tiDdgeDy/tsHrBLCdLJtoXSIYX7dnGVti1O0f5YaKjC7ufbNM9m1ZvvlTulmpMHOzOn3wPgRgmS3+G1UhbI1qtJL2js0w0QTFcoqY+eVXTavT7KNc5zhCdgDuS5rpwkoRIm4pfCId0o9dnmusSMOwx/b6nigRQYAOEpbdFW7EbH7X0TPZhzxOE/PSDoPQHF2PSnGlg5J8U+eTi8RNMaOByHGjpvZoF4mkAUUoPGIb5ula5sT/gRJfvkdsGpnY6u3xndnRsfzjeaROg9+p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:46.0920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ec7503-2d74-4d09-d31b-08debbef68bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21365-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1F33F5E4AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Change verify_num_vhca_ids() to count the number of unique vhca_ids
and verify this count doesn't exceed max_num_vhca_id, rather than
validating individual vhca_id values are within a specific range.

The previous implementation checked if each vhca_id was in the range
[0, max_num_vhca_id - 1], which is overly restrictive. The hardware
capability max_rqt_vhca_id represents the maximum number of unique
vhca_ids that can be used, not a range constraint on individual IDs.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index a3382f6a6b74..8511363f7bec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -8,13 +8,28 @@ static bool verify_num_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
 				unsigned int size)
 {
 	unsigned int max_num_vhca_id = MLX5_CAP_GEN_2(mdev, max_rqt_vhca_id);
-	int i;
+	unsigned int unique_count = 0;
+	int i, j;
+
+	/* Count unique vhca_ids */
+	for (i = 0; i < size; i++) {
+		bool is_unique = true;
+
+		/* Check if vhca_ids[i] was already seen */
+		for (j = 0; j < i; j++) {
+			if (vhca_ids[j] == vhca_ids[i]) {
+				is_unique = false;
+				break;
+			}
+		}
+		if (is_unique)
+			unique_count++;
+	}
 
-	/* Verify that all vhca_ids are in range [0, max_num_vhca_ids - 1] */
-	for (i = 0; i < size; i++)
-		if (vhca_ids[i] >= max_num_vhca_id)
-			return false;
-	return true;
+	/* Verify that number of unique vhca_ids doesn't exceed
+	 * max_num_vhca_id
+	 */
+	return unique_count <= max_num_vhca_id;
 }
 
 static bool rqt_verify_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
-- 
2.44.0


