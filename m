Return-Path: <linux-rdma+bounces-12174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A4B050C0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2744A74F3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 05:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9192D4B7C;
	Tue, 15 Jul 2025 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEby7V0E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523672D46DD;
	Tue, 15 Jul 2025 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556618; cv=fail; b=b2BXHBX0W2p+e3F9jqSLQea72tImSQSSnAFE5EHTC4hEAy7ByF9OuUmk6CI6orNpplCHb96CH1TvqZaMspVcrSESnc3iEFtFtj6tqNWY634ZyHI9vJG7GcYaEuyVoBLZatrOtrWXkui+FyKBuekcKhDf9pNr7O/fH1yFBZchIgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556618; c=relaxed/simple;
	bh=Byc7mxjKK4n+Uv3YR1HTZQU6oRzqnn3crajc8mkNeeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTDNqQg7sQD6uHU5hUX5Cb4yIgeHWRhO8qbZpuH07LyFEuG+uykty8GWvhpd3zzjWZaB+ZPnfepTVD8fDk/xaEYdebUkPMEbYWQLaM0oO4+GN7YSzTXfDTx9z66sB+dDp9VYUibnMSBGtTBwKdVAp7XcONI1YzDIJ/x3gsDfyeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEby7V0E; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHeuPLVqK0Co4nNLlx65gQdwuym+O9ZzUcdNFK4oKZM8ZzraN0Nhb+f8M4XEoR2d2NKxJwuiLeLgDtXezOFT0wHaWjgNQxfjy0BZzoqR7vpyla1gOdPnEvFvexXOVMfEy5sU1GHsKdHA3Q4oJWP+0j7qJVviFH5sjoQWqqHptYovhpnJHmw+QB2fLvZ7rifOmJcOT+83OsLpS/WPW//ZPjtDGY0LF7HgbLW0jp5wVXwEE+bLd59hfmNI9hyzBfPLWLVg0davtXppr1ZvpyO/VNPQvFc3opBEyMrpslPF34YIWjRQyKun+kXlA/IlyRB90E2CMMxMTOxv41NThAFvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJg9BA6ED2ApamlcG/+c09jf61kbBpvU6Hakao2bL38=;
 b=GiP9919ySX9e5b036N2BubmLEnhLXbqtIhVKOU5za8DcGIB0/u5ctBMLuXIvzq1ddYajZ2JvSi2X7wHufiAfr1ZtgD73YIHdYdeDypiWQe6YUAHgo/mh9owxbweQHJBnvSojWcG/e85XiqFqpAobHdUhqIYJVC0KZXQdnyV04iJzDKdD1/WJHqwqxhpjaZHKsR+IOYMuon2qIpTef080kSf5Lxowgz7pdoxH5CcLUXRx5450bwFrm67iKoNdErN1fCX56GG1+NdmcOb7CLcw+OvWoeAO8If8kct++VHIKKx7mub+msYccdXKUSraLqvEJ6WJqPng4htMyUXJahzrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJg9BA6ED2ApamlcG/+c09jf61kbBpvU6Hakao2bL38=;
 b=nEby7V0E2MM7mWE83L4mGjMMlW4hpyE8iROvl4oeL36cT96Vw/GBq2h7za5BkTTomm21lZ8vm3I0vRAYOmHc6jbDCrOfdRiAnqLedfSkKyQm7BvcrjZiSAOGpc08TGiMoKWK+czuHloTZHNKwIhy1o3Uc925dDV5qarpv44cIH6gl0diF+wKPyIdxlhnr0RaNM3WMpF85cviZ2fC4EjOx3SwBMx3bATgs8jfg963/ofIWj3aYzVXBoCUdC7qQ8h2eS978L0KFcWGNTZd3IELTXERlMQRwam3T7rPviiKdsjs8Py/z1vgUE1H41Dr67QEdJTUPzHfe7GoQfQ5Xhin1g==
Received: from YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:8c::8)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 05:16:53 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:c01:8c:cafe::da) by YQZPR01CA0155.outlook.office365.com
 (2603:10b6:c01:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 05:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 05:16:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 22:16:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 22:16:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 14
 Jul 2025 22:16:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: Extract MTCTR register read logic into helper function
Date: Tue, 15 Jul 2025 08:15:32 +0300
Message-ID: <1752556533-39218-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: dabf11e1-bd8a-4015-3728-08ddc35ecf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYaYwgmpXpVZB8pu0xRyT+U/FQR2tccHkfCYfBu2hlTEL4vRyGA4tibnd70x?=
 =?us-ascii?Q?43nxhkYo3Hodz/9/LEtt8tbm0JAK5LAoub1pMQMbgt7zw5JKm2jgbLqFAfv4?=
 =?us-ascii?Q?qLIhJVyBJGxZzmVuMs1jB5oMkjnNKVYUH6FbaItyvdlIA4KrrMDcTASjrY7C?=
 =?us-ascii?Q?Ym17QkMFMjabYgwLQmQScRXLPzAxieYKXOWvNJcgkr3Dr0QDPuwQGN6b+hu6?=
 =?us-ascii?Q?CKSZE7LrNiFLGlP7z2jLbl5fMHXK+9qaFvbryWjDpeTRoq0ah37NOCWyDnN5?=
 =?us-ascii?Q?h1spyYP13RU2IKCfRn7egVMyAcvSkfA1Suwh1URIFmZIznAHxKfG1zJEQltH?=
 =?us-ascii?Q?bIsxth0+uIjDZhLtzJ+4RbY3zgaCq620Gk1orUKOaWstWvoygm165AN32SI9?=
 =?us-ascii?Q?4Q7o2IFo2AE212tPZWvutCUoeazIMy2jx/h0PqDyxSALYWsnENu5lfmFGWR7?=
 =?us-ascii?Q?qXtwEvZqowbURfe1X/xq4GEZfeNgEt4kVSGaCurqOjWW4qVme0Kz5qzL5gix?=
 =?us-ascii?Q?wlzI47sn4mCVMTe8uQmxyzcuK/kQD1aHbQVkiUyhg1CRmqzQQ2aS0YJubNKC?=
 =?us-ascii?Q?WAcJpWyfj3HFbSIBNLVprQVaBkAowSQcEK8gOdvY8y0OEQjXjSXKtH/u3pvi?=
 =?us-ascii?Q?+JjVHeTrjkCyQo7sYe4ipn/mURtBOWbI3RJ0ynTsu56Ne7tVVLSoKTXvx96t?=
 =?us-ascii?Q?SR67B7CUFlMmMDEnd97vdpKSfGUY2R6yes949lb3y4DnC9sfzjYXC5FWVVbL?=
 =?us-ascii?Q?T2A6SXWhJliqzfvdtPmU3nf0tXAECWunQg9s9ZfT6SdWR/BJAnLdW0AyMc0J?=
 =?us-ascii?Q?+Q7bu60/Skvt2oWHppsbbkpbLDMhSG0rkP2DjNuJQ84OyZ0gTe1PxlO3/nzs?=
 =?us-ascii?Q?sBOl8nhF7pFkYufXhMGQOQQwuSLTcnYzfeXH/vXGd4vWyR3HrFUqLm0Xb2T6?=
 =?us-ascii?Q?jEBJikhkZppz2cHoxwymx+a0kpCLsyuRb27zrV5eaW8FNSBQusm7qGirKI24?=
 =?us-ascii?Q?JI4WOaklGgXP9H/GGm4Ab6wzubWZ81D5UFfNJjRAp4GpPWd6QzJ7VXOkUfFY?=
 =?us-ascii?Q?83enUfjNK40n7kY+hNQmpXVjsSgdQnTXAUmY8+BBtKvCc78XD2n+cDohsW5v?=
 =?us-ascii?Q?Y7Wg3p/gSvlOisUSRtRhANOnOvGCODfW0yvtJZL5buGmPWjccP6xSLzTFUzd?=
 =?us-ascii?Q?dKMbESTFCU3ig3R+9X4kyK53pRwg6iu8eGq0OFD0AeJNRxk7CRNtVyDYHD7D?=
 =?us-ascii?Q?cHDXtUdydUFZIhWQpW6MnJY/Yr6epQb8mCFD1KRuMl5Gz2O9wkWOfckmFGRg?=
 =?us-ascii?Q?jbZtMkfe/L+ErHsLWlimhvpeeDLMcmqrbfFqpZa/kMtr1h0PeYXXNGseojM9?=
 =?us-ascii?Q?o02eNjmSMPS3QNER/BfMj6r5+4y7AAxDTLHHLCP3Bv97f5nRgl0eYC9JISFe?=
 =?us-ascii?Q?+9rP62NCAkgOhMHqGuSNH5k/T8nrW5MyNt/U2tF0EbdosYjorwSHotUb4Usu?=
 =?us-ascii?Q?C8fq0nGRX6v6AOYNQAkMoE4NQJ+8NTvVcxtV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:16:52.5754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabf11e1-bd8a-4015-3728-08ddc35ecf36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

From: Carolina Jubran <cjubran@nvidia.com>

Refactor the MTCTR register reading logic into a dedicated helper to
lay the groundwork for the next patch.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index cec18efadc73..b1e2deeefc0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -247,27 +247,24 @@ static bool mlx5_is_ptm_source_time_available(struct mlx5_core_dev *dev)
 	return !!MLX5_GET(mtptm_reg, out, psta);
 }
 
-static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
-				     struct system_counterval_t *sys_counterval,
-				     void *ctx)
+static int mlx5_mtctr_read(struct mlx5_core_dev *mdev,
+			   bool real_time_mode,
+			   struct system_counterval_t *sys_counterval,
+			   u64 *device)
 {
 	u32 out[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
 	u32 in[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
-	struct mlx5_core_dev *mdev = ctx;
-	bool real_time_mode;
-	u64 host, device;
+	u64 host;
 	int err;
 
-	real_time_mode = mlx5_real_time_mode(mdev);
-
 	MLX5_SET(mtctr_reg, in, first_clock_timestamp_request,
 		 MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK);
 	MLX5_SET(mtctr_reg, in, second_clock_timestamp_request,
 		 real_time_mode ? MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK :
-		 MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
+				  MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
 
-	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTCTR,
-				   0, 0);
+	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out),
+				   MLX5_REG_MTCTR, 0, 0);
 	if (err)
 		return err;
 
@@ -281,8 +278,26 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
 			.cs_id = CSID_X86_ART,
 			.use_nsecs = true,
 	};
+	*device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
+
+	return 0;
+}
+
+static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
+				     struct system_counterval_t *sys_counterval,
+				     void *ctx)
+{
+	struct mlx5_core_dev *mdev = ctx;
+	bool real_time_mode;
+	u64 device;
+	int err;
+
+	real_time_mode = mlx5_real_time_mode(mdev);
+
+	err = mlx5_mtctr_read(mdev, real_time_mode, sys_counterval, &device);
+	if (err)
+		return err;
 
-	device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
 	if (real_time_mode)
 		*device_time = ns_to_ktime(REAL_TIME_TO_NS(device >> 32, device & U32_MAX));
 	else
-- 
2.31.1


