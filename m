Return-Path: <linux-rdma+bounces-13373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708CB57B56
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2993B645B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1730C353;
	Mon, 15 Sep 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NB/MCL+Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33530B53D;
	Mon, 15 Sep 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940135; cv=fail; b=MsR4a+urce+bjWaa6jomgS1Dz4IW+Q6mCiul42zj9BZTnYC71cdhs5lGTl88XrgHml1U5nZYiyPB6dvlG2VGcXaokSTK3f3mtV94PVNxzKGhUyVe03bBS0F9TLY+TnT9ltn839LO9MzsHeo5kK7uKe5xV0NZaV5C7fUljIPKgkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940135; c=relaxed/simple;
	bh=bRJn6qfNu2aiwNfAhjZboKREnVwjnwf+4EOpq2STXGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFfN5dx+KjCypP/PUgeCb16pWpg2KWnVqtFvXoADCT2CQtAIlPR4i70/yeZWO759FOH3sbLYXYWwAxSoVoNGVyc1gmAvt/m0RHfiyut37DL1xGNb8Tna9Goji5ILK3/KcX6PiMMy2ZJgOwiQdgslVMppHE/VOdLTdmGLW1yFw+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NB/MCL+Z; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7nEU6AiT7lys0tJnqrJ2tKWTKyxNzBB+EltVvqU9chr47Um9TWD7E6hVn0i6H2VPLSDjetxqsPd2ytLug2vTVX1TyBynHcCDEzXleZP6AV44L0DBY+nXP2zq5EtVqHDMAa9yhSVaT4QZM6+21eQgTWsYQBxr4wCbqhetfZ9ASxYQeRGTjZWXrHVUoPTt3WfeR2ha2qdr87FDhtRdfFOqrBY1T1SeHwHmJwR21lrvw3IjrRNzcQ6gH4kxaNyg5b5JmiFrVGDmf4t8hl2vLlh1Du0yvkueMt5LUjYXdlZvmm5baTawS5wdgnyhkCmYvIo8Dk1itPMaKi4Xx+PcWkmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv8G56s1LtCWbpL+eW1eqRI0uNy7NBAKTE9dtVRTPCA=;
 b=aJwM2HKi9XUp7t1PZ2NojifGsu0QC5cg6mTI5t6qfGvFeIA7LdCIR1afxRCIPWX8+OzMHMhaRJOSEzc8C9ELwdjdMXktkxhfrT5Hs4+981yV86fklFDmWxLVGXjqo3m6GphHY8n/B4CC2s48bbvgpgAUlzfw4CtKtCVYNJ3W7sDGiZ6ZlnWvI6Wevn23Zsd0BSUBq+z2i0EeMLLv+3WyOeYkvdD76WnTml02lwBlnXLBgl7uLgJmq1gqvkl4K3Yje1FIITbY2HiFgmVutA8Boc20GTh0nqnDfs7FHStOzpuWsctubYiFvt8N6VUnWnMFIq3VwVn8xklIquD0m7KHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv8G56s1LtCWbpL+eW1eqRI0uNy7NBAKTE9dtVRTPCA=;
 b=NB/MCL+ZBDP8gJdKHAXIEU6bu9p4LDL67mU2rQ0EPDuwws/giFdgU4bFvvHHaLwA7d8YOL9ppumL+QwBzwM/ZZ2BlP3GoH4ukkxNOhmrUAgx7+j2J4rdOmfKuKs5wmIYEaE1dQRogJX2sKaiUxdhIda+ZF5iP1bMM8C6iqIzDnoUDD8bgDACFBNVBePxT4ERW0mtjlj3kSVSkwkW1LiLOCQL7usZwT/EC1tamM+q8sUXVl3WslBJ11ilrd04/29if2Ykg3jslaH8iI0QU2fGOlrn1nnMq2fH0eLC1Ccg3AaKV6ztcEokqh0tXlgnwPYKoOp3R1lleXngdxiOhBTmNQ==
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 12:42:09 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::54) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 12:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:42:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:41:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 05:41:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 05:41:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next V2 0/4] net/mlx5: Refactor devcom and add net namespace support
Date: Mon, 15 Sep 2025 15:41:06 +0300
Message-ID: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bba022e-85cd-49bc-8467-08ddf4554905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDQxclBLUEdoQzBkMStJbVJCc3UyWjFVbEtsTmVpc05qZFVSM3dnNGUrTDBR?=
 =?utf-8?B?MTlJeTZMQzVtQnJhN3JGeXdlMWZ4eFFHZFJrVVNFRjRBb1o2YzN1WUUxM3VV?=
 =?utf-8?B?eVh1MHZmZmhpSDVpWWI2Q2tMN2NIcm9PR2FZMFI4ak04YjhORFovV3NqWkZP?=
 =?utf-8?B?YXJUaFdPNHk2RWFCcHBiL0x2ak0wcVVkam9IVXRxYmJxUWkxRXhJa29RWlJu?=
 =?utf-8?B?ZHVzTGNLN2wzanYzNmI2MFhNT001eVI0eVVwZWhqaUFWYjlSeXdLdzlmaU5Z?=
 =?utf-8?B?ZTlYemMrNXZjQURMczVPUlRSdkc4dXUwYVkzWmJMTzdFUUZWTkdlMVR5QVU4?=
 =?utf-8?B?TGdTNTZuV3RTZXl1OUkrN0pnYjU4dklWNjd1Z2dmd0RzZitlVFFTai9TR0Vq?=
 =?utf-8?B?SC9GallyVGl2TWxyKzYrdVN0Z0ZZRDJLOG1Jekk4SmFLK1JkK1JKK0lTcjVI?=
 =?utf-8?B?eEtMOEp0anhQM1RmZUhxOE9iSmorNXRSZlFOYm96Y2J6TU5UeVpCa2xWSTJi?=
 =?utf-8?B?SnY4QkFMRzZHRzZuVU03OWZLWU4ycmJ4QjI5OWd0QUhaQVhZNWM2Ly9WWHZW?=
 =?utf-8?B?MVlqOWdaY1RNM3RnUzhBTnlFTmthSFIwb0VBODM4S0Q1R0tRZEpvYTluQ2Jq?=
 =?utf-8?B?Z2szTFdRTkVINEZ5Y05wUG5TYkNuRjA0a1hDbjMwWjN4V3ZYbW8zYVhNQy9n?=
 =?utf-8?B?a3YzdHFUdFNBY2RkNHJjcm56NGRuUTdwQlUwMXIxQUFxWC9wL3VsMndLd2hT?=
 =?utf-8?B?L2dpdStWUFNjc3JVZUxTTHlxazFzSXVORFZ5M0puRkpGWGVlZU1DUVRqMmdM?=
 =?utf-8?B?MlJrRXZ4L3BYb0pWaHVvR09XZ2V0K2xjTG04VVVEU3NrL1lkWjE3TExSS3Zp?=
 =?utf-8?B?R2Rkd2trSWNVRVlaL0VjUWM3VGd0ZGlxQmNPaWxSSVpEdEtDbXAzUzZrYldF?=
 =?utf-8?B?NmJlS2VETDI2bjJMZkpuQmdoUFIraFE0U3NseW0vU2xXc25vVTVyNTEweURk?=
 =?utf-8?B?Q1pkdElEQ0hrSGpkODVTKzRmb29WeFhLQUprUjF2MDVCbXpiS1l0L0cyMTNt?=
 =?utf-8?B?RzlhTEsyeUJXUjlEVGt5TVN5V3FvMjNsWktpVEY2ZWlIUnZtSHh3TEh1TG53?=
 =?utf-8?B?aTFqUlRyN0orcDNsOHBvRDlLOW1BbnVOOWZyTXA5WndBUml4M1lSTFUyWXZF?=
 =?utf-8?B?T0pKMlpjWDFuRzZwMmI2S2h6blpYelozMzdRYUh1ZUlMUy8wWmpBNzlyZHJD?=
 =?utf-8?B?TUVmT1creXMxdkZFM2hNWmZGYlkvR0NnV05NcEpGMnpTdFlIM3ZLVUFoUjlL?=
 =?utf-8?B?RlFlSjhUQzk0TU9TU0U2dVV6U2ZWQ3c5UDBBa1NNRUR4QW93QnI3VFY5NkZO?=
 =?utf-8?B?VEZNT2dPOS9HNXhaOEVYODBUTFhVN3o4aGl3ZUlsdlVqVGRkejVyOTQzclZk?=
 =?utf-8?B?SkNZZ2w0eldaanc2QkkyZEkyZ1VWaVE5V2xkeWdHOWxJcGpzWVVhNXBhRmNS?=
 =?utf-8?B?bnoxZnJLci9KKzZ0cEFBa3Vaa0JkVTgrZ1dMR0RsWUt2UTgvaHBBb1RIWG5N?=
 =?utf-8?B?N0VaVGJ2a044OEk4WWJCc09HMzZ4SXRvNER5bjBBNjNjQnh0M1VOOVpIWHMv?=
 =?utf-8?B?VHkxVnk0OExrM2FjQmd2UzJ5ZG50WkRxdU15V25QM2dwNGNLQ3JNM282U3Ji?=
 =?utf-8?B?R0JRQ2ZRaUhxejc2YklyREU0aHNBL1hTZldWOXEvbEp3OWxvTU5ubHN4WlVt?=
 =?utf-8?B?Z0FFQSs1bE9XSTYzdkhDZzNGS1U1anNUUlEvOUpXZ0t5aG9aMWxiVUtuazh3?=
 =?utf-8?B?RU9Xb1dxVzN5UjVrcE1LaW5IY0ZKcnVDMmxHNGhqb1U5N08xQnFIa1RvYS9X?=
 =?utf-8?B?bXNMNHBTOE9aUGdKdDhDZzFqc3czNjZhaWZpSHN6YnI1LzJxUy9xY082bmZp?=
 =?utf-8?B?Y1RqWVdIUjlJeElzRTNyL2NtWDlQa3diT2J6dk1NNDdtL1JPVjRoME95TjFi?=
 =?utf-8?B?ZmMwakQ4K2FXOEt3OURqVEdGSHk0enRGSDJKQ1pmRHhHSFFiaFBtcU1wRWtj?=
 =?utf-8?B?eGlSaStRS09RWkVXcjhGcWN2TjlXUjlQa3p4UT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:42:08.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bba022e-85cd-49bc-8467-08ddf4554905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

Hi,

This series by Shay improves the mlx5 devcom infrastructure by
introducing a structured matching attribute interface, relocating
certain devcom registration flows to more appropriate locations, and
adding net namespace awareness to the devcom framework and its users.

Patch 1: Refactors the devcom interface to accept a match attribute
structure instead of raw keys, enabling future extensibility such as
namespace-based matching.

Patch 2: Moves the devcom registration for HCA components from the core
code to the LAG layer to better reflect their logical ownership and
lifecycle.

Patch 3: Adds net namespace support to the devcom framework, enabling
components to operate in isolated namespaces.

Patch 4: Updates the LAG layer to make use of the new namespace-aware
devcom interface and improves reload behavior in LAG mode.

Regards,
Tariq


V1:
https://lore.kernel.org/all/1757572267-601785-1-git-send-email-tariqt@nvidia.com/

Changes:
V1->V2:
- Added Simon's reviewed by tag to patches 1,2 and 3.
- Extended the commit message of patch 4 to address
  Simon's comments on it.

Shay Drory (4):
  net/mlx5: Refactor devcom to use match attributes
  net/mlx5: Lag, move devcom registration to LAG layer
  net/mlx5: Add net namespace support to devcom
  net/mlx5: Lag, add net namespace support

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  5 ---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 10 +++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 45 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 14 ++++--
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 44 +++++++++++++-----
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  | 16 ++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  6 ++-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 24 ----------
 12 files changed, 126 insertions(+), 57 deletions(-)


base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
-- 
2.31.1


