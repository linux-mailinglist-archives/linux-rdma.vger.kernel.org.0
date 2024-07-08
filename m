Return-Path: <linux-rdma+bounces-3721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68692A1CD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E1D287312
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74780034;
	Mon,  8 Jul 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSg2iuLL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39E6EB56;
	Mon,  8 Jul 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440091; cv=fail; b=m6mBX2U4pXFVPe8zEvWavHPxjw9EBAUzbN0lkocJ7YKmhF9GmKFtQXMXQuFH6CvVs6U/JwkXAUHIImnemui9bxsIgFB2+mmBDI0gMwbTVW3Ehkh7rj6+onsjL8+jgZxVTxwG7IgrUlseuSQCOfIcp8N/nb+WZ9EpI8fQ7rG7Cng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440091; c=relaxed/simple;
	bh=xoJzVJRLm4ZQAyLzvLfzHxWI9NEFTELEiduoK/kyeBs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NXnwVeZmpDv/KxxNDBDqMFf4CMqC/LoXvY/mnl8R/KMKHIhFrz0Toy/tVATNmQfZrmklgCfwpRJZ4SiNgvAx9FefytDENv3haCmOshtCbuviGHtnSSAS5xy8o5w9WVVTZ4K9nZYRCkw28RJEJjAT4PIvUoUx3utZevjdgwU/YaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSg2iuLL; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQQI2L7i0Go71JZEOrJeuNnNEsNQGzxPtsbOmhu7UXweMZGqeWXhasuVIM8o5iPI7vE6ysZoL4FCgBaeBXj+HcqVVjmLPrPiMtaWdru2OLFUChicHacileNDDgbCDIOatKcD/nboDN8S5wHMlAM2Ku/eHv5P/3+lqy9ha5QTSEwknK46Gi+xIj3e/Pnq4jgYPAuFJBNWsx2glD1fRyFZnJ2Sf8nGL3fbprELjJXnln+xqoJ+zel0cmzmlP35xUcCwfBNhDsymRdhIcvcDebD7VJ5jXH6Ab6X+ysUIA37Dm56Iy7tYlNkElR16MOtslm4mtPl9DJAS6ddHxrI/z2M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx0qgrCmDsJVT9LQnjov7aKz+XPb1VDy2Z8dcZ1wWXA=;
 b=hqj+qqr9DrUQpqVXo49FXMFYPEyuHflPYzhlsDtkzpSfvGg/GP7h+wqUr/wl+ZClScQzKTvjLl2BbmVCpO01JI2rWd+S3cmB70mbk18kpCzat4LSR/Y1TUwrvbf/8zqmAnvCL47DgaacDvPeA23tuyVYMaGXBqghGGM5KDpbbshmykTAfbc5/MeZLy+sccqFPYVEwMjQzpHizkLViC+LPemkm1z44mnTnwd46UijGGB1FJwgSJFGbtoM92Cn5kmmXa0L6gVgk+gG5OZaFSslkxXRdLHKfjXkk8eussux/kBmFxAsq7vi9coSKvSNXXS1PUqvwGcXpNrzNNJPRUqVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx0qgrCmDsJVT9LQnjov7aKz+XPb1VDy2Z8dcZ1wWXA=;
 b=gSg2iuLLprQw60fjLfCf5UNmZuTECnsn0O1eVrM3CqMon4pGBVd0d2BSHdWjiQBz/TlwjlY7H0pLoM+Zgfumdp3QUAx7q73uD+63L0m4rMVJC4y5UobwFkp8htvErreidopEWS7X+hPQf8762QmS05knMIvat1mtelnMlMoPVJ6/JQFDIYZVWsYdX7mnKYqnx5K6yClyQsO8RQyJQFJmeBrMYGUbMfo8z5qDRx7WNgOpYRrY64g62oXkoaTpBPhM03M6c4fogtbRpc51uNbJV9nIEgPOo1icM9svHq8TIKrwFAHovDQ3oVdqXMGjWQoGGfLDXsSjsTHoQ5NjVpHfmw==
Received: from MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29) by
 DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Mon, 8 Jul 2024 12:01:26 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::9f) by MN2PR01CA0016.outlook.office365.com
 (2603:10b6:208:10c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:00:59 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:00:56 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH vhost v3 00/24] vdpa/mlx5: Pre-create HW VQs to reduce LM
 downtime
Date: Mon, 8 Jul 2024 15:00:24 +0300
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjUi2YC/4XNTQ7CIBAF4Ks0sxYz0JaiK+9hXCA/dha2FQjRN
 L27hJUujMv3XuabFaIL5CIcmxWCyxRpnkpodw2YUU83x8iWDAJFh5IPLCZdymwXzfKDLcGZ4HR
 ybJDW855fnUUF5bosnp5VPkMe55jgUuqRYprDq/7LvI5/6cwZMmWwU61Ho4U+TZks6b2Z7xXN4
 gMS8jckCtRLNN2B46Cs/4K2bXsDPtybow8BAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Zhu Yanjun
	<yanjun.zhu@linux.dev>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5c10dd-fd1a-4743-1cd4-08dc9f45b1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2Jnbi9laGRyU3hsZ1V4eTBYbE9nb3ErTzVMTWo5TUtUVjVWRUQ0dWdQMUtT?=
 =?utf-8?B?ZVZ5MUpCa3lDTHR5VkcvQUhoTDl5Ym9KZkVMZnVMNkRDK1VtbzFuZ3ZrYzY3?=
 =?utf-8?B?TmVML0RGKzVxNUJSSzBETUhWR0RQdTZwMmlNdXB1Qm9nbFdEdVNoZmpIbVht?=
 =?utf-8?B?TUFTZWhzR24wbzU3T0NOMGlPeHRtb010Z21HQ3lnSGg3VDJIUWVuMzBJbDhS?=
 =?utf-8?B?aUpabkRPc2hvM1o5dlhWMk92OWNKdnYxQXh4NmpGSTlwR1Nzc1U0dy8zdjVC?=
 =?utf-8?B?VlduWlJjaWRMWkc4VDNVNHVpZlcwRmVISzNQaWwzZE50c2ZqdWJiWFVTY0JR?=
 =?utf-8?B?emJMOUNtVWx6RUdCVHVKck9CNUorcUNyblBLN0w2SmFxV1NoZ3lPN3NCc0FI?=
 =?utf-8?B?QWh4K1NCRUJTbkN0YmtYOGYxb2QyT2owcXdaVllsVFR3Z3ZxZjd3Ujd0L2tW?=
 =?utf-8?B?QzRvekVUb1FtSk5GNElUNnJuYmZtZGE1Nlc2RDA4dWxPbnVJTkVZRnUvS0dR?=
 =?utf-8?B?ZjlJOW5EQnFHcjB2ZVpVL0FqdmNpUWN5V2VUQXpvQVF3Zzl6QVhrZGNJSVNZ?=
 =?utf-8?B?Rk5lRFNHUzRma2MxL040dzNYdEJ2dDZ2bmZ4aFFSaU9KQWJEa3cyTUEwWmln?=
 =?utf-8?B?VTdOMGRKUjJYTW8zSGsyWER5YzhUVDZVSFhvZlZ0azJkcmhWR2ljejE2N09j?=
 =?utf-8?B?aUlydC9XTXYwbGNaVmVMY3c5WU0xeU1kQ1VhOFI2YzZxSk5ZZlZXaUgxaFFS?=
 =?utf-8?B?M243b3V0STJIdHJPM04vMDdIbVVJKzdBajZabW0vYzN6bmhMOTZGR0pudzlC?=
 =?utf-8?B?MEYyL1B0NjhJZ3V2V21xWWsvNmg1NkFWdlJIZk5MVkVmcnZsdTlXNkM3YXNy?=
 =?utf-8?B?RStJMHBVS2Q0ZkZlWUZOQlRuWTJNZ0JYa2VSdFQyZHZPck1OZFIyaDlrWmVw?=
 =?utf-8?B?b2kxdi9JQUhpaHVreUlNN2g2UGlrY0JjZHlHSndFcXdPSHlyVGRWdUxwL3U4?=
 =?utf-8?B?VXRZc0hiNVZSTGdsUGpuaEpGOWZ4N3NkaWxDTk9lc08wMnpvNEtlV0NXK1Za?=
 =?utf-8?B?UGEyYlBMQUpnbGU5ZXJkbDl6NUVqTFdqQzU4djhrdnh2TXVUUk8rUTAxbWFL?=
 =?utf-8?B?Mmp1MkJ0b0YzZXBYN3NaYkYrUDhpbGl6SndzOWN6cExpNERHSElZQUw4d1Bp?=
 =?utf-8?B?dUhKeE4vNUdYcTdJOWxxUUZ4dlA5UDlwc1o2Q3lIaTFDanJJYlAyTXVPb1FI?=
 =?utf-8?B?WnhkaGpoMjlDY2pxcmw4aUlHN3g2M3IxNjlSZk4vbEhudDNLMDVETkxzYUR3?=
 =?utf-8?B?TzBxRmpQZUo4SmF3a0h1NWZOblBkNGpERmhreWU2YUZjZkpzUUFqQnd6anBY?=
 =?utf-8?B?blpWOFBPejNWWDlXNGJwTWlrS2xydWlYS3pVc0RuRi9wQWZiOWZPM0JhTllU?=
 =?utf-8?B?WEphM2UzNGkyeG5MUHRvMU92a3BVRHF6NHVka2V0WWt4L2lrVUVDWFVkd3E1?=
 =?utf-8?B?YmxhN1dnZ3FyRVpDNUx4b3JiME9hNzM1VndUV0xXT052aFI3bHBaSlhuSHVn?=
 =?utf-8?B?cFNYQ01GUWlQWHVMRkl5Ui9sMG5UQStQMkJYSTA0SzltRkRXc0RmTko3djNC?=
 =?utf-8?B?QkpQZnFuNVVuNTlpUzJsQ0c2V2NpM0kyVm1hVDNFb3k3RkIrZTg5alM3VDVy?=
 =?utf-8?B?SlZoMk9aNHdYcXZmYWkzTDlEditxS3crM2k1WndTWW1DOTdJc1hkbUMzRFNj?=
 =?utf-8?B?aDlJdXRIWGRRRGxHb0Z6UWZENURrV2FuejFPMys1SXJkMFVTTXU1WVJXRFkv?=
 =?utf-8?B?WUR5TFUyd2hxSXo5Wmd1dit1a2lDcHd1NUFUV2dQSjhjWjVvY0RWKzhOL056?=
 =?utf-8?B?ZXhDdUJiM09UaTROaFpoSnpvZDFQNVlWL2tSRU5SaEpISXBHVEFaZEF4VXJt?=
 =?utf-8?B?YXNrb1ZoWnlSamk4NnNkbGkzdEdzd2VwU0JCSW4yZkxjOStCSVR3MTQzbkxa?=
 =?utf-8?B?alc0K09aYTlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:26.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5c10dd-fd1a-4743-1cd4-08dc9f45b1c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

According to the measurements for vDPA Live Migration downtime [0], one
large source of downtime is the creation of hardware VQs and their
associated resources on the devices on the destination VM.

Previous series ([1], [2]) addressed the source part of the Live
Migration downtime. This series addresses the destination part: instead
of creating hardware VQs and their dependent resources when the device
goes into the DRIVER_OK state (which is during downtime), create "blank"
VQs at device creation time and only modify them to the received
configuration before starting the VQs (DRIVER_OK state).

The caveat here is that mlx5_vdpa VQs don't support modifying the VQ
size. VQs will be created with a convenient default size and when this
size is changed, they will be recreated.

The beginning of the series consists of refactorings and preparation.

After that, some preparations are made:
- Allow creation of "blank" VQs by not configuring them during
  create_virtqueue() if there are no modified fields.
- The VQ Init to Ready state transition is consolidated into the
  resume_vq().
- Add error handling to suspend/resume code paths.

Then VQs are created at device creation time.

Finally, the special cases that need full VQ resource recreation are
handled.

On a 64 CPU, 256 GB VM with 1 vDPA device of 16 VQps, the full VQ
resource creation + resume time was ~370ms. Now it's down to 60 ms
(only VQ config and resume). The measurements were done on a ConnectX6DX
based vDPA device.

[0] https://lore.kernel.org/qemu-devel/1701970793-6865-1-git-send-email-si-wei.liu@oracle.com/
[1] https://lore.kernel.org/lkml/20231018171456.1624030-2-dtatulea@nvidia.com
[2] https://lore.kernel.org/lkml/20231219180858.120898-1-dtatulea@nvidia.com

---
Changes in v3:
- Updated commit message and comment about virtio_vdpa and VQ
  pre-creation:
  https://lore.kernel.org/virtualization/20240708072443-mutt-send-email-mst@kernel.org/T/#u
- Link to v2: https://lore.kernel.org/r/20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com

Changes in v2:
- Renamed a function based on v1 review.
- Addressed small nits from v1 review.
- Added improvement numbers in commit message instead of only cover
  letter.
- Link to v1: https://lore.kernel.org/r/20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com

---
Dragos Tatulea (24):
      vdpa/mlx5: Clarify meaning thorough function rename
      vdpa/mlx5: Make setup/teardown_vq_resources() symmetrical
      vdpa/mlx5: Drop redundant code
      vdpa/mlx5: Drop redundant check in teardown_virtqueues()
      vdpa/mlx5: Iterate over active VQs during suspend/resume
      vdpa/mlx5: Remove duplicate suspend code
      vdpa/mlx5: Initialize and reset device with one queue pair
      vdpa/mlx5: Clear and reinitialize software VQ data on reset
      vdpa/mlx5: Rename init_mvqs
      vdpa/mlx5: Add support for modifying the virtio_version VQ field
      vdpa/mlx5: Add support for modifying the VQ features field
      vdpa/mlx5: Set an initial size on the VQ
      vdpa/mlx5: Start off rqt_size with max VQPs
      vdpa/mlx5: Set mkey modified flags on all VQs
      vdpa/mlx5: Allow creation of blank VQs
      vdpa/mlx5: Accept Init -> Ready VQ transition in resume_vq()
      vdpa/mlx5: Add error code for suspend/resume VQ
      vdpa/mlx5: Consolidate all VQ modify to Ready to use resume_vq()
      vdpa/mlx5: Forward error in suspend/resume device
      vdpa/mlx5: Use suspend/resume during VQP change
      vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add time
      vdpa/mlx5: Re-create HW VQs under certain conditions
      vdpa/mlx5: Don't reset VQs more than necessary
      vdpa/mlx5: Don't enable non-active VQs in .set_vq_ready()

 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 431 +++++++++++++++++++++++++------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h  |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |   2 +
 3 files changed, 295 insertions(+), 139 deletions(-)
---
base-commit: c8fae27d141a32a1624d0d0d5419d94252824498
change-id: 20240617-stage-vdpa-vq-precreate-76df151bed08

Best regards,
-- 
Dragos Tatulea <dtatulea@nvidia.com>


