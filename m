Return-Path: <linux-rdma+bounces-12175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A168B050C1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BFE1AA7731
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760602D5C73;
	Tue, 15 Jul 2025 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMrSerXC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE312D542B;
	Tue, 15 Jul 2025 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556622; cv=fail; b=sp7Jptj4PI8tCje79X+ToOstMdaHTBlQRZ9DRvkJHjL/m40VtGKD+FzSoBzzjTQWo0xhPF3HCkgLvMX70DojEN5F66IbaXFX4bpHiIWjbYRXWsxY2DghZMIoR925K80k6gW8FDmAm7dGKSYXx7jKWXdCqQZEMC/y//lMjKpsC2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556622; c=relaxed/simple;
	bh=fNoYcLhI598BJT/w67WOWw9ZnyjJNfIA1kjwj6uPTx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3yeMKvsMWweFS3maoX/Y2VsgjNtaZYnO5YLczEW8kyhE7MRkXC+zizOid+1qhc1VZzQpeyObAXh4j3wst7BkMGlXzBd1z3TWt/s9lsoyCBV/goZwVNLaNMOHshfRx9l9jjHMuMmPVSme1qsKm64dC0Xoy5N9aQFywcO3SdZMt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMrSerXC; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+TnML493L/RgpLkcyswMvbsvEBWuqLDCQouGEf9hWYN/XnU0frW1gFTdFpEtr/KceuQtd32ZBQaCOXeCDxhGWmyUYRh9Ibas+1QuebSntJd6UfVGQKQKAOJxvRRZhZpfaAzlbIrumZGP7wokw2rT8/8dP5/fPessyUiL/Qg8Tnr/5jXJlM6nQSwVkGleo7TruGPxR+hoAqLeE4vulUQtu3qQG6eAzBgpbP6RZVoPrU/Am2+7Xr6ean1dOMkOiEdeITBlbfCYjLudI1Ci5jKkg02wrPlu9R9oGZUZd2WZIh6B1eGXbtV2bDdpDxyZoOjX/MT3SkkUPwuYEoIn6i9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtsXpUfV9qNY4llJosIKW7EIio25qobdzwxpsyv89FY=;
 b=viLeKGOIoDp0E81pXFnqvSzUrFMZQ1WDtHBtj6AG+NyZ8KtrXZWI+RELaehoV+lZXZxJlHyxk6UXLwVVoki76LthlvZZCska2KJ6VB1ORlrhLHNKVHzZ98bUrwBvEmKRDmyuh+MUnPkefDi2gPdWYXTKbVUfFJmUGvpLzfC9oNbcbhuh3DRadw15rpqx4+JdFG8mRhDe7JZiPQbS0eX9wKBJs2YEIkmUmV8QlJ23ni/A43z+yIYAAml/XOBJ3iD2TLW3ihFVC0u1Ft0X/VPs14nwKUggEJbf/jIRYlJYjvJbqxaPd7vwjJ/GLR0hkSLXkOZl7P1QTSiurx1k3vnZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtsXpUfV9qNY4llJosIKW7EIio25qobdzwxpsyv89FY=;
 b=VMrSerXCTBHF2QJyoPTmJyYKBekSbaRi8d94BG8iWEuVXmhJqo0dU8PZUA+HTQuRyPZBi//W311Ky5JdroX7ZStMnko+m96qkT89KgnoyhrfmOhzeMlNK/a8uxUDsfhG3+rjKJZXSBWcxTbhLrNOfc/pUj8de3MwKc4Rtwq60s86J1kXDJeXH9lgzfyqLPa/5n5XHvPZ2XPTJqo4UKRX15cGu7PcyLCAf0eCB/8WSF47gF9wcN8T2+7DhJURK5FpmqAUPYT4iWBtfc1fL23/BKNZP+fTqtJ0A1oTDlrP6rRmRNcvV/AAGuW+Fqf7EGSmhgCBMeCuSe9mIhi73D753w==
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 05:16:56 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::80) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 05:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 05:16:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 22:16:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 22:16:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 14
 Jul 2025 22:16:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and getcrosscycles
Date: Tue, 15 Jul 2025 08:15:33 +0300
Message-ID: <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: a2230ed4-b422-44c9-ea5f-08ddc35ed137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SENVVW0xd0VNOXVpRGRkalFkUnVXU3hteUpXZXA4dG9lTEVmYjZYc0JiQWhn?=
 =?utf-8?B?K3M3NFlBWGN1cTFLcktoWGFmSlFkMlZGRE5XU3R3S1o1MTBXaG9yMUlGYWh4?=
 =?utf-8?B?b0gxa0xIN0NNYjF1aU5yQU9XSVRsS0pQOFlwTDRQWThqMVhvRVVKVFFXT0hK?=
 =?utf-8?B?WFFNWmY0c25PTWJSVXBiWEZLamQ3eTdPZER3K3k1YWNjWUdoZnBVTkdMZFFD?=
 =?utf-8?B?YVI5SVdDSHZNbXdUckJOWHNSTzhKenN6SmFnVm00dTNzbUtLTGZpdlovVU1C?=
 =?utf-8?B?TmlsanMxN2hzVWtCMFgvZ0xGVXp1ZkNwNThGN2RQUlBpaHVOSlBJVVpHTCtW?=
 =?utf-8?B?Zm1NejlQNUtmcDI0VTU2RXp3UHNSb2lwVTUxbFVFMCtCM2dJWGEvcGRoZXU2?=
 =?utf-8?B?eUpPVjBLeHEvYW1nS3FGb21qREJoQXQySTZmckg0eDUxRnJaSkxwai8vZHRq?=
 =?utf-8?B?SDNrVUFDL0ZpYVJDSE9oMDZVYXMzUFEvQVE2dEZJaDFnU1dmOU9ubUZsSjFS?=
 =?utf-8?B?NzRZMVFwODlNZERFdFQybFVlb3psMVFSaXAzTmU1K3hyUkVWa0JGUTZoYzJE?=
 =?utf-8?B?VmJoWU9ZNWptUVFIMW0xckhsanpTdmZqNFFsVnQ5R3NMZ0oxanlyMkpnUHZn?=
 =?utf-8?B?QnluNC9iN2NHSHV2cDNWQWtEK2QzNStRdmRhYTZqMmg1bXdYeUZyVjdGdStm?=
 =?utf-8?B?bHFCZHlPNDRQQjU5dXZWN25GTG8rTSswTlFqTWNZRUlRZ0dodTVZQ0dlK2RJ?=
 =?utf-8?B?b3JoZ3NDeFNDaW1NVy9tWUx4c0IyN1QxeS9JaXNKcDhGV2Z2TlBzeUxaZjg1?=
 =?utf-8?B?alg1MytVcEZzYWtXcUVhVGdwZmRuZWVFOTFiSndVNS84aEh3OU91QkRpOFFt?=
 =?utf-8?B?NjNHc3RqdnBYZGpqellGZk9XVVIrbGptMGVWekpJbzFnUnVneHIrOGRrMjdN?=
 =?utf-8?B?YXhVU3VGSzJVZURMM3dzVWY4aVB6dE9LNklTV09lR3NHZnJzQU5nQUlSYXhW?=
 =?utf-8?B?WFZobzRSSVA0N1BMTU1XeCsvTXNBRFdjQjFSSFZIeDI5QVhLenYwU29MVWJj?=
 =?utf-8?B?V3htWmxnRGRUY0xITlhLTnY5N2JVWlRJSGJieTJaeDRIVUVQOHd4RjZtdk81?=
 =?utf-8?B?aVRnbWFSZ0ZXcFg4L0dGMU9FTWdhbUFOSkppSHJZSmdybkxSajRlNS85T2dl?=
 =?utf-8?B?UU00TURYdSsyUVVBb2IxbmZOMW12dnE3VjFUejhZZFdPYXprUDNsb2NsVnJu?=
 =?utf-8?B?b1pvTDdDU1MxWHNuVzAxZGpYRG5XWlJFRUxVek1IOFhjTUZaa0VNZDZtck5m?=
 =?utf-8?B?aHJwbG9YdHBHTXM3Wjg0Nzc2ay9uOXBYbkxxMklZbnA4RnZ3UHB1b3ZWYThn?=
 =?utf-8?B?cFNsdC9ZRWxLb3VDK2JEd3lVTnY2b2xtY1pTUXpoS1VTY0sybDZaM1E0MU11?=
 =?utf-8?B?MFlWZUwyZWRVdHhaQlJLSGJ5T1JmbkVFeHR5WlRzZG5iWUlwWlBWYUpmVk9o?=
 =?utf-8?B?dEZtTVdPZHdkTG9WYmpFZ2lac2RTUDJlTGZWcmlTV3JNQWg0UytSbERDNGJK?=
 =?utf-8?B?S3RiS2RrODBYenRPNVFkMmk4WXpwZzkwOVkvd2VXWnNjMSt2ZWRpTFJWYWR6?=
 =?utf-8?B?RmJJQU14OWRyOVZqbURxZXd2MThLaGs0YnJ0dGtNbXgxaWQvaWk3aTBiOVZo?=
 =?utf-8?B?ZVlFOURiZ1puRTNyZU81VmJKSzQ4MXI2djZXQVhCQk1wSGNoY2FHeldSdWtY?=
 =?utf-8?B?eUNIMjlyc1JucnJnOFBKa2N4WGt5cC90ZGhMaWduQTFtUGRyYldjN2dKUWR2?=
 =?utf-8?B?TXA2QmlNUDFMWnFpQjlLNWlZdmpEbEpuK3pEYTNTYy84cFhBT2JUK0F2Z1pn?=
 =?utf-8?B?ejlHSjJqVE5hTkRaYk9zNXl2b3dTTUUyTXUyMTA3dmVnbjRmbVpyMmd4VURj?=
 =?utf-8?B?UG92Tk44WVVZcnhMWUpSL2RjOHVYd3NhdWhxV3ZIT0Y5b0pKaGpqTm1LWjlw?=
 =?utf-8?B?eFZRSjN5dVFFYVNpcUJlMmt6YXhGL28yMkd2b0Y4eGFOME9XRTEwU1V4aXFL?=
 =?utf-8?Q?DfFxTi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:16:55.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2230ed4-b422-44c9-ea5f-08ddc35ed137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

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
index b1e2deeefc0c..2f75726674a9 100644
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
2.31.1


