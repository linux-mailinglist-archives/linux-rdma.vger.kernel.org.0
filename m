Return-Path: <linux-rdma+bounces-12686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED30B22A99
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCDD682E66
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D702F547F;
	Tue, 12 Aug 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+fadZfs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986F2ED171;
	Tue, 12 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008319; cv=fail; b=YMYzSWEM2k2/lypGT8dSmPIgvBB/vpSbQx7bd8mE5voei2v5aXJB38TPoWgg3VYXFl64CwXA+TaEdcR+P8bwx1dhjtL/RHzoqoGuPEGPQ4XWVsS1jddKumE/SEXrZeC6dHzVjn+O+C91TYIIDeqPBvjXMeGrWnUX4hN0923ysAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008319; c=relaxed/simple;
	bh=qrpxdhRxlpI/ljLKW7Mhi21pOIDPC4lSY+zbkZh3rZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0nX0M5cRrfLwa9kmin4BMOoh6xpY0rGX/yOtgLDOGsOUSw0hN+vH+V0W053lwrCVB9+WHfl/bP0eYfFAui/hsd6E0IM874AfYir89BMM2MQTerN/AEFrKh2zj22P5M7WgcRBn8TXnQxjMAHq/iGZOwSUg34/y+k5kG+i45yhaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+fadZfs; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3t6ZhyAC42INCKOk0Lpv20C2rGXocfVqYvwpnlw7SVmRX7fAFhNsRNDlWYXD8knaRB+0/pAA+3OpFErCVcVFVIQY38h+tqOijRE1qo6dIlvgsupKfhFD475e4t32987fTXK8JGHWImYChhihXrqbMbqwdik1qmxs3/hJIbrYwHjQX0tlJ3vCjRsnRSKuYANsBB9nPkN/C/IHqhfzFk/mLuga2n/rKDHXhKE4ozbXWwXJD4YmOFGpcrD976w1jE1RREZwvNSNAcHEukdiRbtlHkqO/++xOIuFl+KB+oxhTEoLZU4kcVPVpucIfbs9mX3/zqCmTFGHKR2B5J1+gnPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aBXMlRtfD0ER6BVvqbzlgdAK/ueYey8J+3LFjtDlVs=;
 b=CUPorHInysXKibNBglUYneir/XuN4/GCCdSAVaTQrtv4uvDkdTXd7pRngaOSKJVZzjfF6RUpoHh4rd3+L/y4us5w+dcTZpyf4pFkA8lzTNkL9kQKcYjvtm0cpzbIqKWtwCnziKDdYbayJS9wYq5KHGolel4xqIcFKA0MkghHehdQn+HhVC+jurfhsFE4L5lT68Ew6kioO910IG/K2PL2UYPFGkZaBGghWBaSBMi2r2DhK9dHDQ5Swi5zpehGS9ntdcbSBl/aMmZrIs2rGZ+2eGYw+QlXU4LG/Alz/4uMBufPpAy7Z0zyuq9sfJ4EpptWf9vzDQeT2+GxDwbq6pbGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aBXMlRtfD0ER6BVvqbzlgdAK/ueYey8J+3LFjtDlVs=;
 b=e+fadZfsGpPtN3e4LFkl2K7Ede3b/OvPxsf/OZKDohMz64IRGKK7ltpYrOzCGorvOzs8bgewrUW7ZB7nUHWQfFIjpnooJuWr+v2mXnHZXHEACyWne5lSj4afkmIsFGoG6b/1glZMLTovyV5W86scARpeEJ1RWvrF2Fa8HQ7jQgkMuiRaeBeKoIOk32qcvw1CMw2zGGGfbgPKccUa371CJTijT1yVMpQi/4ZvoCzRDcurYtoypWWkXkd7wpzH8lVd9JU7QdnDrZbkeGhYNAc8tvcVNTNskwo9iZAV9Qxwp4Z9ERbPtIW9pVn/MOWT0rvB+zEbKIyb8igvhe8H+oQhTA==
Received: from BYAPR11CA0093.namprd11.prod.outlook.com (2603:10b6:a03:f4::34)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 14:18:29 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:f4:cafe::fd) by BYAPR11CA0093.outlook.office365.com
 (2603:10b6:a03:f4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 14:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Tue, 12 Aug 2025 14:18:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 07:18:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 12 Aug 2025 07:18:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 12 Aug 2025 07:18:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Carolina Jubran
	<cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 3/3] net/mlx5: Support getcyclesx and getcrosscycles
Date: Tue, 12 Aug 2025 17:17:08 +0300
Message-ID: <1755008228-88881-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: f0652e7e-e2be-457d-32c7-08ddd9ab1c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWpCbXJwWmFNMEFDN0J5dExyajAxN3plS1NSdlZTU1l6UXJUY0d5b3krSzEv?=
 =?utf-8?B?cTU5THVHYTRFTFB0eURqQ1Z0THRVSkllMEdybUhMamU5aHIxRmJJTE5XbGVz?=
 =?utf-8?B?WG16Sm5ZWVNScDhGMkhBREhKaUVLNlRORjh5RzA0bktSQWluQjNLSFdITk1q?=
 =?utf-8?B?VTdjTzdtdTd4STdmbnZKS0JqSnFkOE11VEdWMGVqSExDek1KWEpuZTJkV0NR?=
 =?utf-8?B?SG9TOWlVTjlmcmpWdlNzTnZOU3NscGdRRk11Uks3eE5tcktnOHVMeXY2WTNC?=
 =?utf-8?B?WFNHODE5bERvdzhUNWM1dDM5VDJGbG54VldHNWdydHdnaDV4MnJta2s3VDky?=
 =?utf-8?B?a3JyeWZiMzQ0OW80NG5NUnd5OFowN3lZQ1ZuRkxTcjcxc1RkTW5nc1FMVjJC?=
 =?utf-8?B?MXNzU2M2TXZYTzdvRnlNVDAwSzhidDJkVUhXVWZ5bjZlQ3hUYmN5ckdGdDVR?=
 =?utf-8?B?N0RRV1NWRmxZRkY0Ri9SVDFMWDl0NlgzTXZ4OGJoUGswb2VlS01ZeHRGcXkz?=
 =?utf-8?B?NUZ6Q1FCK2JHdHpBUEM5VkpLNG92d1FXU1E3R0Q5ME8zekRVSXpZakZYSEYv?=
 =?utf-8?B?dURSdVBLOUZ6SzNVOThES1JBd1FDdk95UGR4Um1mR0RwVkV3VlB0V3lwdm51?=
 =?utf-8?B?TG01c2hYQmM2S1pqY3VLdUlVaU95R3ZGazEyR3k5Uks0MDBrUStZTkZqVU1x?=
 =?utf-8?B?ZktLTS9DQnJRMEhHZ2ZYTHBKVnRFYXFIbWlJT0dWUGt4UWxHMFZubnpjSzZs?=
 =?utf-8?B?OE9xZGhRdTNqMUVJZDAyTjQ0VDNlMy91OHN0blJpTzBZTkNKUUk3MnlLRWVl?=
 =?utf-8?B?VnJqVjlhSFNJVVdSM29jRzUwNmtlR0ZYeHVFNXdkT3hDUGVnUWd1R2hXeTI2?=
 =?utf-8?B?MWVRUVNkTDJETWpydmJpZWErd0hpVEpWUjVOaWEvaUExclJqaHUxMDlOVTV5?=
 =?utf-8?B?dWUzc2d6V3dkdzhIdjNneGw3ZUhLYytzV1Q2WXNDT1FNSm0rL29jdUZjOTRQ?=
 =?utf-8?B?aG41ZFRadHVudVNDL3VudzQ5NXlKYkc0SHVPN1htd2o0UjZMRDdIQWlQVDAr?=
 =?utf-8?B?b1NlbTVRUjBpTElKTkhBcmhvS1QzckFXQlVLYmt5VGNSTTBkek12L215N1Fz?=
 =?utf-8?B?eGRIYnh1cHZRejN4M0I2TXZxZ3hHQU5hSjl1UlQvMWlxT1J1aHlGT2tKNm1x?=
 =?utf-8?B?T0NhOUJ1MTRWMU1DNjNXM3EyV2Y1T2NxdDNoT0c4S1NybFVhdDBvajB3Ukto?=
 =?utf-8?B?TlJXWGFlUkt0ckZUdGxJMUFWbyttc2o4am82c0xQcjBiWm5hRDhxQkFRdlNK?=
 =?utf-8?B?T3JoWXpHb0lvelgyZk9RR1lDcEhHV0h0dkprZ2xOVEoraGloZjY5QkJJRlJ3?=
 =?utf-8?B?dm9OWEgxaEpXUFFjdjhDZWM2amxzSWxNYmtYNkVnS1BSWDM1SUVGMXpCRzFm?=
 =?utf-8?B?VjU3TVhIbkpkeXYyYjVIeFBXWGRuVnlzRTBPRXdiZk5kRVRaa3Z0SVlOenVJ?=
 =?utf-8?B?MVpRU2ZxbG5kM2NiUkhIZTlCNFBDODVQYmhpZlptVnlJbytyckVhbUUxcGI4?=
 =?utf-8?B?dExPUkk3Y3dkTVJycEtVWVowcGZlWWtndnNBQkV6VXQ0QWFDbThGWVJhQTVG?=
 =?utf-8?B?NklvMTQ1YmVpVzdYdGp5cU9LZEFrUjZ5UzFnTjh3L01XQ2YrSVJoc1ljaWRm?=
 =?utf-8?B?dm0xVWdQTjR2bHRPSC82Y2tUdEcycjZLRGE4cVEvNGRZSGxFQ09MZjZxeUhq?=
 =?utf-8?B?bkI5VGZUU3RJZTJJcWVxYWlRVzZ6Q1hmWm9SV3ZxZkY4NnVCZytYWTlUN3pK?=
 =?utf-8?B?RUpRTEM1TnQ5c2p1eWhvTFQ3TjY0L09hTU1GVWhRZ25pZVh2VHRTUU5mbXJV?=
 =?utf-8?B?NjZyUmI5RnJSaUJDNzFZTW9IT0szYjRSemtJVlpmbkREZFEydGY0UXluamxV?=
 =?utf-8?B?ZlZXMXFzeEZ6cWxxRVdoN25CRUZ4a3NiUXltSmJVbWlJTHJGZ3NSSzFrdldL?=
 =?utf-8?B?bmNYbHFISktTUW9SSjdIY09laUwwYjhvSnZuTHFKeGVSVnU1dE01amJwWmZi?=
 =?utf-8?Q?Qzxt2Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:18:29.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0652e7e-e2be-457d-32c7-08ddd9ab1c7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421

From: Carolina Jubran <cjubran@nvidia.com>

Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
expose the device’s raw free-running counter.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 9b49bdc339ad..7ad3baca99de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
 	return 0;
 }
 
+static int
+mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
+				struct system_counterval_t *sys_counterval,
+				void *ctx)
+{
+	struct mlx5_core_dev *mdev = ctx;
+	u64 device;
+	int err;
+
+	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
+	if (err)
+		return err;
+	*device_time = ns_to_ktime(device);
+
+	return 0;
+}
+
 static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 				   struct system_device_crosststamp *cts)
 {
@@ -330,6 +347,32 @@ static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 	mlx5_clock_unlock(clock);
 	return err;
 }
+
+static int mlx5_ptp_getcrosscycles(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *cts)
+{
+	struct mlx5_clock *clock =
+		container_of(ptp, struct mlx5_clock, ptp_info);
+	struct system_time_snapshot history_begin = {0};
+	struct mlx5_core_dev *mdev;
+	int err;
+
+	mlx5_clock_lock(clock);
+	mdev = mlx5_clock_mdev_get(clock);
+
+	if (!mlx5_is_ptm_source_time_available(mdev)) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	ktime_get_snapshot(&history_begin);
+
+	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicecyclestime,
+					    mdev, &history_begin, cts);
+unlock:
+	mlx5_clock_unlock(clock);
+	return err;
+}
 #endif /* CONFIG_X86 */
 
 static u64 mlx5_read_time(struct mlx5_core_dev *dev,
@@ -528,6 +571,24 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	return 0;
 }
 
+static int mlx5_ptp_getcyclesx(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts)
+{
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock,
+						ptp_info);
+	struct mlx5_core_dev *mdev;
+	u64 cycles;
+
+	mlx5_clock_lock(clock);
+	mdev = mlx5_clock_mdev_get(clock);
+
+	cycles = mlx5_read_time(mdev, sts, false);
+	*ts = ns_to_timespec64(cycles);
+	mlx5_clock_unlock(clock);
+	return 0;
+}
+
 static int mlx5_ptp_adjtime_real_time(struct mlx5_core_dev *mdev, s64 delta)
 {
 	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
@@ -1244,6 +1305,7 @@ static void mlx5_init_timer_max_freq_adjustment(struct mlx5_core_dev *mdev)
 static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = mdev->clock;
+	bool expose_cycles;
 
 	/* Configure the PHC */
 	clock->ptp_info = mlx5_ptp_clock_info;
@@ -1251,12 +1313,22 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 	if (MLX5_CAP_MCAM_REG(mdev, mtutc))
 		mlx5_init_timer_max_freq_adjustment(mdev);
 
+	expose_cycles = !MLX5_CAP_GEN(mdev, disciplined_fr_counter) ||
+			!mlx5_real_time_mode(mdev);
+
 #ifdef CONFIG_X86
 	if (MLX5_CAP_MCAM_REG3(mdev, mtptm) &&
-	    MLX5_CAP_MCAM_REG3(mdev, mtctr) && boot_cpu_has(X86_FEATURE_ART))
+	    MLX5_CAP_MCAM_REG3(mdev, mtctr) && boot_cpu_has(X86_FEATURE_ART)) {
 		clock->ptp_info.getcrosststamp = mlx5_ptp_getcrosststamp;
+		if (expose_cycles)
+			clock->ptp_info.getcrosscycles =
+				mlx5_ptp_getcrosscycles;
+	}
 #endif /* CONFIG_X86 */
 
+	if (expose_cycles)
+		clock->ptp_info.getcyclesx64 = mlx5_ptp_getcyclesx;
+
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
 	mlx5_init_overflow_period(mdev);
-- 
2.40.1


