Return-Path: <linux-rdma+bounces-12172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA17B050B8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196421AA77B1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD452D3235;
	Tue, 15 Jul 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phgzQGrc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D947260578;
	Tue, 15 Jul 2025 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556614; cv=fail; b=YHxYC76e9g8Vcs4CYV+Q1wfK+qjzoXsaAQRWpi6SoTsunwlPMksOaIO4WgGpJU2wJ57bRN/FqOQPSBi1MU5dFXzdxSxrv/8d/HeJjiPxyZgGzjqyDPBkakRb9FyjT+RuMZJZF8Yt7wtOxzefzR/Yb9WYCnLQGJZWf3Lt7DzLr4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556614; c=relaxed/simple;
	bh=V/Nd6uDnrRhaEIuADsV1F54vmuyb+eGp5+uTIRz/vFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGK5m3SX4R/4ZweSMwb4iCfLIsdcPvvHLnZKazMUptyWLSD9tYa8rKDQQHOfkHzVlwfWz8am1pDi5Ef3iP3nog/ScouKIsy7vrWdjiVNqOViIg1hHLJQyjMG7/kw/lMbqymm8UzSfYiHRJ04ew/oYS+arbciRhII5DzEap75TGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phgzQGrc; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv+8kiAlivJh06P4RwoQfx7cBs7IUkJgXVD6e9565hCbXiOhYbOvY/9J3SDa2iR6QYbr3W/xhOWm8l8tFcG76STk0rh1Upq6DWdVbFQa6735Q7C1NCxBbSKBiAzAyHHpzYXqL8HJJJ0okxufmPu3lOc0s17+uYQO/pqk494ePQ/LCiEGNcrEnmowcMctn1+T3671JL+u6Iund9l36UdWFszruR9oNY/GS1oTjxIn68jBSyCss6MFKQHrhDU0aCWjZ4t5ehjMMFx3PztwVdiu22jKx2j9JUyJV9YGp2pjR08S8fFI6pq3aJYvkVr2o7Wa9GILun8tSvchgiaYyFMpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxBG2mBMWqJIL+qQP+PCniMHpLiTvjk0mjeDNZxznnc=;
 b=Oj92RDI611wQYi1s0zQ6Ek1MfQthFEyT5533MPpdx9EvbRpEB/HqdAbRA0JdHW3vKHkTCdA0nbpGekoHe5dox5lRKS3SUpTS/ZyYRqH7lXvRtUVI1QPLeOkett8P6rpWXC2I9EGJztXKoqrQA3W9jnIt7UO0SpXdcaNSDtl9miwzkz3Otr1dfRgrEUvvEX6BkzlspXDGgYzhBve4ZEFctLGXHRpnBfmi4Gfh7WZsDErmpp1GN7vlWG5q7XF+u5smqSOVgAxCjj2tdSzh9ZbK3S9GuCnS9utFF2sRrEMjCxYUY6Y+1ScbyZWbcGS3Up/dJpw3KFsjCKcXFDk7YXBdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxBG2mBMWqJIL+qQP+PCniMHpLiTvjk0mjeDNZxznnc=;
 b=phgzQGrczbzJ7yrjuaX/2YnMtfHbyqZCsbwHohklUUFLCgEVUiQHttML+LH9xrfo4tQF/nRAJAwA0ZMhg50RlzHl72mkqJTuoUH4IdZplcHEXWmlIZky/XVvq34vMxYWuF5ZOuZDj93wXVxKfHYjneZXpICaWUwPSLzl9JMhx2M4iR1QAIpcZ/fH/fB3oxpeWdK1ngxKy6E0pd8kKm/RFNePIXeCKcenV2kBz/0+t90ds9z+iNNUfLF86Nv6Lp0Djq2Y/VHBajYkmMvokEohLM0/q9gMhzCSL6t1j6M+22Btxkk0wBjAdzixCJRXx/6oiA+tFp+PiEoEqjbKbQSziw==
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 15 Jul
 2025 05:16:46 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::8b) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 05:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 05:16:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 22:16:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 22:16:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 14
 Jul 2025 22:16:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP and mlx5
Date: Tue, 15 Jul 2025 08:15:30 +0300
Message-ID: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e6a229-28ee-47fd-43a9-08ddc35ecb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1NLdHhrem5iRnhiWUtMRmVRSlc1MFNYRUVyVkNhRGt1ZUwxQTBKeUdhbGlJ?=
 =?utf-8?B?dFA2Vm8zTGova2VaSHlSenZWQ081dFQ4dXFKb2tPNmU5SGROR1dBc3ZNN29W?=
 =?utf-8?B?NTYrdDBUNFAvckZnaVZVbVQyL3kvMzlXRnRheXVST09nWHBNUVFOZWNwVnY4?=
 =?utf-8?B?VjFTbDZVNnF3R2N3QzNqQ2xOQTZiNm16elA0RHNuQ24yN2lvVUs0NEJVekh4?=
 =?utf-8?B?RTFnSVpPR1JNK2F2TUFuYytmL2ZueTc2dUhVWWNqK0tGSlozc1libmxiNjRN?=
 =?utf-8?B?TnhYaGEyM3M2d3cxMGRrWTQ4ZEUrdmJId0M3Nm5iNWUyZFl1K3ZQWmU5U1hk?=
 =?utf-8?B?VExRblZkQlpCdVVRWnh2UWorVkxwc0x4OUxuVmFHOHliL1pGRUhUbEV2V2ll?=
 =?utf-8?B?dW5zNGJpNlRaUVNyMnpFVDRLcVpDNmZuRFhhSGFINzRhVGtuY1hRODQ5WnND?=
 =?utf-8?B?THRRSFdtRUl4ZUFCUDhJNEREQkNvSzZSc2t1MDF6REtXT0ltT3pucDdEZHZi?=
 =?utf-8?B?YTZUZnN6NFQxYmI4ekpuSXpaLzc3YTlXUlNLUFFFYlFTcXd0NWZ6UnQ2bCtF?=
 =?utf-8?B?ckNscFdJNGtOdytlK3NtRkNocktNSHI0SGhZL1hlZ1ExZ1QrdW8xV2lzNTdl?=
 =?utf-8?B?YUYrdTIwNmdlZHYzZy9STDNsY3pzN200bFFKcmdSeW5NelBWS1YrSjd3QWwx?=
 =?utf-8?B?YUU0SzVHZFF5ZnpsUUNUbWErR01yek1wemJNTDFxMXF2SVFkUlVIdSt5NVQv?=
 =?utf-8?B?bjdnLzlMZEpPNm5MRVZRc0dWd3daT1RTbDJTL1hkUW0rWElndXo5WitvVlE2?=
 =?utf-8?B?R1pFdnNybG9YT3BHa0tpSXhJbENhWXhHOFd3RGVGTDdQMi9mUHdDaks5WFFS?=
 =?utf-8?B?YjhURmkzbXh4QkVuWjNqYnNhMlBBTjl3TGkzWjdRRVQ5SU94bjNDSHNQbGtN?=
 =?utf-8?B?MWRNclNzQ3V5WHhQQmtiNDFEaWszUlRqQWRpRklPN0lHVERVWUQvbUU0YXpB?=
 =?utf-8?B?TDhXZDdpT3NDOURuY29YWXovTnZ4Q2RNTGRiTEZrM0dRUjNZNFdYV2JiOUdr?=
 =?utf-8?B?UWVxM1V3SysvcVJ4Y0F2V2hEK1h3WmY5TGdDK2FYbGVOelhhZGpwS1hxaXMy?=
 =?utf-8?B?RDVZd0o5TzlCUVoyVFlsN3hPRGlQUGxmQ0xWaTF6RHNvT0hhaWJINjBVelZn?=
 =?utf-8?B?NEFPNXFDd1Fyb1EvVEVHNUlVMkVKUTdTeWdyM2p0S3MveElVZFc2OHNZRmZF?=
 =?utf-8?B?aGtSdVI3T2U2SzQwNXJyaUxJaU0wNloxbmNIMGYxZG15Z2RSeTB0ZVVqS1gy?=
 =?utf-8?B?Y1h5SUhTU0cwQ2k1RWtIbjZDdlloUXhKVHE1ZWFoWVlzQTlZeEN3YVlnVFhT?=
 =?utf-8?B?Um5id1VRNHpCa0hzUDc5Y284ODNzSGdPQnlHa0tLeUJZREtPU1RzRnltQzZl?=
 =?utf-8?B?ZlJSSld5MjdZaFdvM09aVHZ4Rm5OTk0yS1Q5a1E4ZHRqMEduMGljdVNzd0Nl?=
 =?utf-8?B?WmZXSmRIWEtqbk04U1BRWjcrNmVLcThxTkllRGtTK3Zydk9DU2ZSWFFid0tJ?=
 =?utf-8?B?MzZ6YUxTaEFKU2wvOTFlQnV4MEFqWGlOM1RlZFIyZHVzV1JZa2d4WnJHL2VE?=
 =?utf-8?B?ZVpSL0dYM3h2K3VyZEE3UzliaWwzZVF2ZGFqSHhxYlNmeURZR1JIZy9HdXFo?=
 =?utf-8?B?REp5WElxWE1rZWs3TnhOcWNra0dYdDBrU3Y2eGlzTXQzeTVOdDdoNDFoZ2tQ?=
 =?utf-8?B?eXBBVk95Q2ZrcGdCZkx5K2tXRGcwVnE5MGxEMlFETUF0Y0lScXRNRWF6eHly?=
 =?utf-8?B?eU03SlUrUVhxMjQ3UFY5M014c1RQRzdUVUhXV2tKOFZKZUU2aE1ocDV4Z3dQ?=
 =?utf-8?B?b3JYZmVNU0VUNENPeGkydUk1dmRwTXVCOTZ4a3pPZ2lvcHRyOUYxNHo4K3l4?=
 =?utf-8?B?Yy9xRHZLV21URklCQUlnNTlhUTN5WjdJbVhqT1VHYk5NWXJSSG1wdURJbllh?=
 =?utf-8?B?WkhpSDlyQ0dRTEd1K0ExWW40OHFCZUtxL1ZXb3p5a0FaUGFOc2pySlkzYlpW?=
 =?utf-8?Q?ld0Sdb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:16:45.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e6a229-28ee-47fd-43a9-08ddc35ecb2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

Hi,

This series by Carolina adds support in ptp and usage in mlx5 for
exposing the raw free-running cycle counter of PTP hardware clocks.

Find detailed description by Carolina below [1].

Regards,
Tariq


[1]
This patch series introduces support for exposing the raw free-running
cycle counter of PTP hardware clocks. Some telemetry and low-level
logging use cycle counter timestamps rather than nanoseconds.
Currently, there is no generic interface to correlate these raw values
with system time.

To address this, the series introduces two new ioctl commands that
allow userspace to query the device's raw cycle counter together with
host time:

 - PTP_SYS_OFFSET_PRECISE_CYCLES

 - PTP_SYS_OFFSET_EXTENDED_CYCLES

These commands work like their existing counterparts but return the
device timestamp in cycle units instead of real-time nanoseconds.

This can also be useful in the XDP fast path: if a driver inserts the
raw cycle value into metadata instead of a real-time timestamp, it can
avoid the overhead of converting cycles to time in the kernel. Then
userspace can resolve the cycle-to-time mapping using this ioctl when
needed.

Adds the new PTP ioctls and integrates support in ptp_ioctl():
- ptp: Add ioctl commands to expose raw cycle counter values

Support for exposing raw cycles in mlx5:
- net/mlx5: Extract MTCTR register read logic into helper function
- net/mlx5: Support getcyclesx and getcrosscycles


Carolina Jubran (3):
  ptp: Add ioctl commands to expose raw cycle counter values
  net/mlx5: Extract MTCTR register read logic into helper function
  net/mlx5: Support getcyclesx and getcrosscycles

 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 113 ++++++++++++++++--
 drivers/ptp/ptp_chardev.c                     |  34 ++++--
 include/uapi/linux/ptp_clock.h                |   4 +
 3 files changed, 130 insertions(+), 21 deletions(-)


base-commit: 06baf9bfa6ca8db7d5f32e12e27d1dc1b7cb3a8a
-- 
2.31.1


