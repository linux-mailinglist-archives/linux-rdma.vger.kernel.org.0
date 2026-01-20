Return-Path: <linux-rdma+bounces-15755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C3D3C23A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C84B84A3B2D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAA3D523A;
	Tue, 20 Jan 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubdcEJST"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E763D5242;
	Tue, 20 Jan 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897074; cv=fail; b=kwGFjxNU7joe3NlTpmhBRqdWb1aKY3ifW69F0FdY2DNqS79WIrbp8esN6R8FxSIVO0MiEC3EeLnAI4kCeTdekY3y5Tn+DB6AmmdQZUfduuV5nFPEAOdirISSnY7f5jdIahN4mHXhcdfwxoDzEG47dKL7raQlEkQJj9b58cNF2uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897074; c=relaxed/simple;
	bh=gCuCluAw7KVDulLd8cJk8/KFKgF/8W8UUArKtAh9VAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVCoiOxWajBe323pP9qf4X4IPuk33wSmlMAceCDuNW+8iNH4sn9m0Op1gR+gD62Yls3JWVM7fZAFeaoAafa8Bwj48u0aFmvaw3Q8dk2rSiMt8B4dmfDZNl40AGAqKOmcNfetZVq38gtt6eDBUrnJT039qouUwoD5CwAuVNEGPSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubdcEJST; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyIC08LJ007qUXc5y7ghQpVs4r9hDa+Zh70y1dBHahYPTlptmGrPtOr3G7zr0B8VxfKwVPvS5fE9op07U8iZCg6/mCR8lDas4naj5nJilbItGRS7P8OQl88mavQcZYt2wj+rc4GmQzEMFDEelREWPmrjTVwV7pEKB/X2MdSFjY/nts0MrSKemhgPtgrT2WymKVDwxjWt1ic/6mR7bD+Cg73NGrONCX3pD/oWW0Mmi7w9s7FcwEUi2NCL36IKZbeglNHVkVZ19WvQh3NK6WTNTswa1y07F4vuNEjEqPWTi+IQRa9hUxBHeIN27bmz+x6dA7W2wJ34EsYxK/31xtoSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFInkE6zwS9fg7shvCN100N5e80vF1vR5+8+7zhN/iY=;
 b=cECx/9UqVET2lISKQ1G0S/0VmN6eRCjL7XBBqY+BSx9GSTWS3bJ4BgScZaVvbGxv2vKjwmNWZoa2c3C0Aoy1HM8z1O4IW1RsD4GxYFIGdQsyRxKDrTrAeV/mGDEE/cLzWHSDhm8ljv4+Jyi+umZhiMDBYXtxA48vAQTkellUo0wxc4hgflQ4u5BTsFFvW2aeeDE9tV9tb/XsZkVKW91z99fELTRrXhUbSFPulyXFIk9T57SkVNHkzoGDXbdE0OKON6ut3DfCXO1fcuklswAhVAxgR46eI7RghlASU7k1k8bct2R69Nsb/V1KmHRrZMwlTelkiWZ1a0T3cBjgGfJtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFInkE6zwS9fg7shvCN100N5e80vF1vR5+8+7zhN/iY=;
 b=ubdcEJSTPy/0cOKoHUTrdfzko7iqBIlyMCjZkHGbUDruYX1AWHXMI7ICVa/eke0TgyuKOWeo+EkQKWnxW3bsIOqdqSctefxO1OqpN7+z+p2hy1ki9MQv0n/FoZX7YY8Sul5C4gbr4jn76mTxD0wEA86bJ2UensmEhm13mtlVHOIXaMu5s9qVciloGyTds+1TyQG0DB6f+cfvi8yYg/Tbjq/xhcze2wpkia65ICsGSIIIKVzfIJnQnrKw917I38pN2+sGqhEfl4244wtXULpkWb8zHTTaPJbP1tqcDk65iACwi8G84Tbdk7Ia+9A6ctA6XrUDw5MKuTKDbxoNOrDI6Q==
Received: from PH7PR13CA0015.namprd13.prod.outlook.com (2603:10b6:510:174::21)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:17:49 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::15) by PH7PR13CA0015.outlook.office365.com
 (2603:10b6:510:174::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 08:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:17:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 20
 Jan 2026 00:17:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
Subject: [PATCH net 4/4] net/mlx5e: Skip ESN replay window setup for IPsec crypto offload
Date: Tue, 20 Jan 2026 10:16:54 +0200
Message-ID: <20260120081654.1639138-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260120081654.1639138-1-tariqt@nvidia.com>
References: <20260120081654.1639138-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 36da7d3c-0fbd-4fdc-81e2-08de57fc65fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h65U4wOu5QNlDA1EWgUz8wkf2/mAAuGqR45fU2iaYVqRbgJKEB3byedrNxHK?=
 =?us-ascii?Q?ioMeeR6Sj1eC55aOaBeep2DJOTy0SJeebAFQ5H0tTPK0/ngjumOMJJYwa4fk?=
 =?us-ascii?Q?a2JJM6RPK0bnvSpFqGxaOGhQFN3lVoqhgMyL6lDSXuYs5hpKzZBiFDz2zaXW?=
 =?us-ascii?Q?XD2SnrnRdKfD6OnaE506NkGTuD+ysFTRy4cVEK4oPfEaua1w7iWiManRL1hW?=
 =?us-ascii?Q?u0Ir21QDO+r20Emt0qyEv69wCypbTeWEoaZSmO0sA0tB/g2ljjiZaeaDo45u?=
 =?us-ascii?Q?CqH/Kc2Ae3K2OdkYnE9l+uFTA51lv61Q4ZzpaZJW/1esyj+9flHX7coER1aO?=
 =?us-ascii?Q?/2YdpRzyLW9erJTzOACPeTP/shScj++yR/mHuO3KfumUFHbRtzCOOKSw44m7?=
 =?us-ascii?Q?uFin57YqGtEH90dUlHUdkHXgF36wMAjsv+u5/1fmxcx6VbRDfszcHGw0ek9v?=
 =?us-ascii?Q?D8AbIpweUxRBqvAT9Q4SILM5dGQb/5RuEhzWX2IHn/zUrEPutd5Em2mAQhrd?=
 =?us-ascii?Q?h47RR+A9EqpYCEdKaX2go8Hpc41hRUHWM5URf3dUplNIzbbH7TbevDWWOq99?=
 =?us-ascii?Q?OOZ9PxcSlkQtZyqgi6QEb/LTv8q2vtC6/HW0IZfnOzK5WHJymCpIDQdjbT3n?=
 =?us-ascii?Q?/YlFhtDPoMcOpgGuGf95yXQkvQ6tcKKktooPS0BZbpYalV9/5h9Qughx19Ri?=
 =?us-ascii?Q?ODIpjqRExT+lqfeO3v+PGpgTn3ZnPCVh3wf/Yb/Xef1XyGxCpLRVOVIBpXt9?=
 =?us-ascii?Q?JzJdFQls1i6fXYgbcJH5rEbFBdY88alFxv8VVlRSO2SuY0x98O0oDwX9nRBj?=
 =?us-ascii?Q?uOsxcHBCd1i1A3m4aFNR9UdPijfm2S7qbIgS8PhZdd3iEt8v0Lohrk9qs6Gf?=
 =?us-ascii?Q?9mhbHg9fxz6pXTHK4dDzmRSRExV+m10Kd0W88yizQEI5nrpOIum4WMEvmZG3?=
 =?us-ascii?Q?Wmf4UjdUJ/SuOE4NSZolLHcQO/hRaU7+lhcz0N34GZctGmD3a6xMB1gUaT4M?=
 =?us-ascii?Q?lmL9emQ8RyQChxHnW+zQu82JOOAruv8CzxFGKJbsz5QX38XIYskuZ9t2/tZ6?=
 =?us-ascii?Q?tK0gu+ySeCN7HFognCRh5njuoc6JoLQRriSDCJS7AtymkpqlzkBBn6AMuxKs?=
 =?us-ascii?Q?gShS6QZ1nLGRzKFVcNi+QyjQxOWe68K6iOUlxx8ttjO8Cv7D6yhdPmdDKKtJ?=
 =?us-ascii?Q?dgvr1Z2Qm33CgeKNluBQQJRUBLm72cIzazt3QU+cL6IHTnkiP98QVmRwiXpD?=
 =?us-ascii?Q?mbRpEt9O8qWmi6QQh/9+l5ZHUVXWXELBV52ifTpF6GNm7xhWxl6GCDAFJZzZ?=
 =?us-ascii?Q?nppLdX+tiX9qNR0xQHZ/i/9oQ2JqN0HGSpN9QDKKcgTGQodTPDLOoqt9hEgF?=
 =?us-ascii?Q?UfC8zLGHSjCQYC3hD89vKtK3VET6e8NshSJAeEPD47427OHRrzcwhPS1Vp0T?=
 =?us-ascii?Q?LSX+3Pg61fH3obq6UxvrnIBFuhFfq80ClNF8qRRcyZqOIY9mGR3TACn57+Kd?=
 =?us-ascii?Q?gcwDCnj1ugo0P0yaVtwvlm2gV+eYnmIuB1CbCGngLEJ7K6YOAQ8Rvir8wiGE?=
 =?us-ascii?Q?TFs4unJuQk4Dhl8mkPH3NMG0OTUfhWbv0lTi9LthFzR8ak76hwQkK32TR1LF?=
 =?us-ascii?Q?PB9hi67/nwGdkHp9R3xNczie5ZL63p+w2CqvLxdPXWJCDIyaPz3pejvLnsu3?=
 =?us-ascii?Q?0f5sZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:17:48.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36da7d3c-0fbd-4fdc-81e2-08de57fc65fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

From: Jianbo Liu <jianbol@nvidia.com>

Commit a5e400a985df ("net/mlx5e: Honor user choice of IPsec replay
window size") introduced logic to setup the ESN replay window size.
This logic is only valid for packet offload.

However, the check to skip this block only covered outbound offloads.
It was not skipped for crypto offload, causing it to fall through to
the new switch statement and trigger its WARN_ON default case (for
instance, if a window larger than 256 bits was configured).

Fix this by amending the condition to also skip the replay window
setup if the offload type is not XFRM_DEV_OFFLOAD_PACKET.

Fixes: a5e400a985df ("net/mlx5e: Honor user choice of IPsec replay window size")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index a8fb4bec369c..63aa23f5c49e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -430,7 +430,8 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		attrs->replay_esn.esn = sa_entry->esn_state.esn;
 		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
 		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
-		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT ||
+		    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 			goto skip_replay_window;
 
 		switch (x->replay_esn->replay_window) {
-- 
2.44.0


