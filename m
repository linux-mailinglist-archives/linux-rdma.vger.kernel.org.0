Return-Path: <linux-rdma+bounces-21207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ60MwscE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:40:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737305C2F10
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B10143015842
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E803A2574;
	Sun, 24 May 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RrL6wmmw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13F3A2549;
	Sun, 24 May 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637155; cv=fail; b=ohxM1zCCnHgTNM7ANtwP5Kgq6Soz3anE6ReSS6OPistPtoebIVRHptcH2u4qCflQgkLanB42YzeGbe34SXSbcEedtz4UFOCSpmczy5xrN31dN6+fvqJr0an/FgRUVMZX1Tgjxh+MWbL8KVnNDAjSHPNlImk1GaC3GUGf32CoIdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637155; c=relaxed/simple;
	bh=cRkxCbTvRjpFKnaOwA9OtNANOBf3kvv6zILhkWG9fm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iVr0nqQY8jYg/bzyk1m7krU5Xqnsu5m7KYnWtvYifPAwOo43YLcYopuoCBcKOdqdyKq5yeDZRVPmXeZNIiJrhhrA4WQf+eapI5uQPjn+9/f9WjC1EXSkKkVwv7/sp23Fk1xzPuFrpVoUIl7e+Na2f0PSK42iayziZ1JUQXtAKRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RrL6wmmw; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaqmCTpcI8VaLgqJ3Xpwz17fHs3qYt3PgS42esXJXwV0TnhtbbkelBkZXwk/MSBGnNw3IhI9Bydus617Vmzf3NANMvBngtzdAoOQBrP/5hM89yQ30l6j3ABUVBtfhfmmu3ddZvnccYVYetu52LCVNpwmIH8KLZJfZ7FwBZpBkfvFprOzpMKkvC40yvabtmnurqF5pkJd264szfAofFlc9vgMm//j1bYZyV6OmF8tpWq91dOVtaGwGF0OJI3Wo4rZMx2c2BZCIEuQXK4yYDv6az8GoydUDpDoxK8rRqvVd9LmcJ4P/jygJ/iToB2U1JieuC+P/6U8ux+X4sN/dVEoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQO8KmxPsOgB0XC/SS/0qI+hfPGZnUQPqnqRZ0n1c6M=;
 b=WrmlLQPl8aCnCqM6uSYjUtv17sRsv+xsvwo89JJUXMlnVp/U1hJcmphHbBJ0Mlz/fkQtMOS9Ve9pn+f8iAnTieiXs4A/dEDtTHShVtq3hW7/shgQ0RG/LfPilQZmAcsiTimbB1YV6+tH5Sa2PGPj5mpje7O8VvB+8D6n59GQHJIUedXWqlybJZBZmpOCirHEPcdExqNHxbJiA37NOCHnIxt6A5wKaWqx2WhxoavBJBA8w3Nkbfx/puiWNMitr3f6TRvd+OIEBRJn7Sat0R2qmuEm8zkWc67Kt3Cd1nEw58MO9OgbhEfjOcYt4/AT/gKAIuJRbSaw/0Ik5YOYCYzVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQO8KmxPsOgB0XC/SS/0qI+hfPGZnUQPqnqRZ0n1c6M=;
 b=RrL6wmmwWjGfwT0AlWMIrk3sxejhVU5thvSDUZpJ05G6AMk7E4GsE/GULyggI2pMmhlLiszEBQTDkT5AptFjqbIMolqfop64tk1/1YUbt3SQvrA9S9pnHOV3fx7RbYoeMIuUrDZPSupB4DToL/33IFgMHHbVo7a5GC/dgQvB9Sve+zu0CR7scPmx01T4vWbNxhYeqmoaKh438+Dhjjy6DF6KkbyiTLtVBsu72shKMRrwlhL7JAfHL17+/DppCES8p6fu1OxANrilcoOxb6kMQObaShS8PXQamvmMb0bCvIe9slTuJ1nMqkh2LuuOnl1QV2rIS8n8KUvyuCHKz8bcqw==
Received: from CY5PR15CA0200.namprd15.prod.outlook.com (2603:10b6:930:82::22)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:39:07 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::33) by CY5PR15CA0200.outlook.office365.com
 (2603:10b6:930:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:39:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:56 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:52 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:06 +0300
Subject: [PATCH rdma-next 5/8] RDMA/mlx5: Report packet pacing capabilities
 when querying device
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-5-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2431;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=aHKU0s9Lx5P7SBAnRFR+71tuNIyqpm30Z5dgLTlRjHE=;
 b=23xp3+2cL7De6/CKL1OyCdL4H8vtVQJD7tRmwZEipBaEh4ma8WhlucnWVAUXGzpCDSj5wbfvK
 o1xJaZZ3S02BG+dPqySbq/9vfnTNDjtC8mON4DqMDaq07O/UyriHYSg
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8099dc42-a454-4d00-4f48-08deb9aa97b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CaKvxzmguVsjiV5aajwTpLh51m9ErIYkrqF2soMVTT9vFswxTtWmBB0XqNTuTaE1RlP6GOlszYi6XozEZ5v17MWsWKZH+KfZP/3NMCHoTRWW52hlxI2t6DToHh4qjnZ3lEOX9AM5NybrfaXdjEdjO+1XH5YBAsmqMFaAOYhHpstd7ANsFJtS0mX6Pa99cd7D1KPl6IGsq1IWXITe2F2u90vSIXK5t6qTWTdWniRoei8uOWcNyHWfsbZoXUQTc6kotWPaXkgcAC8/Vzx8PTfFszxpF9gh6LLeL+uy4CJx59/yafzOWEJbHqEF9KNLeLaKKbZCc1tZo5Qr9ZVozEhKAh6eI4bFFkd/HdTqSuCI88zuM+VHDmZ1Lo170FbigIj1lDtNtHBzvz1wUpXcQYG3jrck5T5SjqVuA2fBAQVzDRwMCLG7+GipCBLRHOxWOIMwA4IXRxZlUOuEKP265/tmyhEL4CMnfoDdML8UeIcBZgyX02+wSxzoEoDZ5i872FbxT0qUVk4JSZVIzPHVNeSSgSnqU38GOui41V6cD9gwcz8hLUYvi+Il3ns11xN4LzRoc/QSa7Xnw+8VhenzyoU85tjNUon/9lLdfKRz+gZYW4fCccJDdbmrUWTy29EOMGTC6BxsFit8K4dPsg3DtHMd1qfUCis8sIBhkxRdSA7qhziofuO/PmZM2BTKTRinjemga4sSmQgM8DNi4Y6Tdepj1XfrU5ZDXmcJutxiex3QpXs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FnincmKYLY/CaAaPKzsN7Gs4ge9MJfev110dC7FT0SsmvLo6lCOE3xP0314lgI2oqPAsxu5nNSjWFia48PrLwQd1wnaCDcA1K/mqEP2KTbUhEXWiVSXfJ0lDeHy+dc0qOj1f7RZzx7f9Hciy+bpEh8sg0vY6kT8Un/XIwyCU7wsXQ63/9lfGrVqQC6VTq4WzNTC2KMmOrDKC6crGx7Y8/EWu5LGUqwB/Xjjjo6LTXLJx0fYwKxYtsZKqdwnRmnTmATZwZvK73otdZ+EZtwhkggFFBZjstQgFvEaJJK5/7k8wH8crbEk1v+nPCZn9inj7yVzILhJOEHXMr20PLz5vphPjJ36UxnIERSaFLlirlsT4Vu1Zs1PziUhRGjncQ3akmY/8OR5fxL6nUT8PVPOj7e117h2+rlCun59Myl0qYxd9X+XOm/SFTxdv/F5/3BSU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:39:07.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8099dc42-a454-4d00-4f48-08deb9aa97b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21207-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 737305C2F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

When querying device, report packet pacing capabilities for UD and
UC QPs when device supports it.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 428811fa805b68bf6a011685e027b8407a3e1719..fee5329cf398092c5096ca67aa23880b6e829177 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1214,20 +1214,29 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}
 
-	if (offsetofend(typeof(resp), packet_pacing_caps) <= uhw_outlen &&
-	    raw_support) {
-		if (MLX5_CAP_QOS(mdev, packet_pacing) &&
-		    MLX5_CAP_GEN(mdev, qos)) {
-			resp.packet_pacing_caps.qp_rate_limit_max =
-				MLX5_CAP_QOS(mdev, packet_pacing_max_rate);
-			resp.packet_pacing_caps.qp_rate_limit_min =
-				MLX5_CAP_QOS(mdev, packet_pacing_min_rate);
-			resp.packet_pacing_caps.supported_qpts |=
-				1 << IB_QPT_RAW_PACKET;
-			if (MLX5_CAP_QOS(mdev, packet_pacing_burst_bound) &&
-			    MLX5_CAP_QOS(mdev, packet_pacing_typical_size))
-				resp.packet_pacing_caps.cap_flags |=
-					MLX5_IB_PP_SUPPORT_BURST;
+	if (offsetofend(typeof(resp), packet_pacing_caps) <= uhw_outlen) {
+		if (MLX5_CAP_GEN(mdev, qos)) {
+			if (MLX5_CAP_QOS(mdev, packet_pacing) && raw_support)
+				resp.packet_pacing_caps.supported_qpts |=
+					BIT(IB_QPT_RAW_PACKET);
+			if (MLX5_CAP_QOS(mdev, packet_pacing_req_ud))
+				resp.packet_pacing_caps.supported_qpts |=
+					BIT(IB_QPT_UD);
+			if (MLX5_CAP_QOS(mdev, packet_pacing_req_uc))
+				resp.packet_pacing_caps.supported_qpts |=
+					BIT(IB_QPT_UC);
+
+			if (resp.packet_pacing_caps.supported_qpts) {
+				resp.packet_pacing_caps.qp_rate_limit_max =
+					MLX5_CAP_QOS(mdev, packet_pacing_max_rate);
+				resp.packet_pacing_caps.qp_rate_limit_min =
+					MLX5_CAP_QOS(mdev, packet_pacing_min_rate);
+
+				if (MLX5_CAP_QOS(mdev, packet_pacing_burst_bound) &&
+				    MLX5_CAP_QOS(mdev, packet_pacing_typical_size))
+					resp.packet_pacing_caps.cap_flags |=
+						MLX5_IB_PP_SUPPORT_BURST;
+			}
 		}
 		resp.response_length += sizeof(resp.packet_pacing_caps);
 	}

-- 
2.49.0


