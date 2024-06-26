Return-Path: <linux-rdma+bounces-3497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3D917DC6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1739288F23
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D1178CEA;
	Wed, 26 Jun 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXvgXEWV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81116089A;
	Wed, 26 Jun 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397626; cv=fail; b=rWVeGZKk9K5N+9FjE7qsYDuiCoBoDAhjwHjvyHdq458LnxrysuN43TqgZ4EfbQwMs5PQs5jb1sJE9MNhQ3veC5F9n0crRuLV02t28aRRKNVaEHcJrZyctbykbRlIQzHChZWC28unBeIfYiRN4IbAIl6DwzTy7Z4584PpDgtE4HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397626; c=relaxed/simple;
	bh=0aAoj28BtZ4IW5jsHbQB0qNP0ucM6tR8jcjCtQOLpIE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bDuTA0iQQpy03WL7+SNbc6mYDIJgnFvOVSZlZ7v/pnn/168IrJM2M+Aa2+g7Nxc6/QgkbL8CY+KWTUqZAaYfguv5FJrJR48zkybcKxAYM4X4hw5CS7BOC+Zvo1hKihXegTtTZrhVSyTm8kS9EfHjktxclIe0mPvNlyRUoBgxP98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXvgXEWV; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLAEUdjkqu/kzUyiRPcmVlAGPp+Qg/b4BT7ka6uWXEzU4FQw26xWA6Gl+USD2vEfPXBIiE1aq1XRumKOOaOGIHwx9i3TeSENpqDr0DqL02kMGrrXQ6or9bBMCDcco8rOqe8fmqZDqiG8uNmwd3SysutxauUbO/hMh77zaSFncZ3INR9iNF2kwdeCd7UNzGHLnEA98eY7FkIJHYrzzLeugwoQJYWr5PmJGNRNdBoVEfeLimwb7NjX2z3NgJav1AdAmXQY9U00+VVqzur73WlzBGHtt3ThU5sg5iJs+lH3hkE6xqMFjF4OQxO8reJPo7DvPhYtLK1rh8bfPY9lwUBkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeSRcQz++9NrVy0jjK6A4BzJp/ctZweA7pwBZRIjUo0=;
 b=PAtEBfExwO/dRzdalXWTzzOmmxYjNZSAkYJdvwim6dbN7Mhnd1+4YUK/nwgsojHggaFYCUo8IhLJ3IkbIGxDsgnQw/FcPe8W2CFX1MpjHnxfm0FH+poXwDzb6lu0sIe+QRh9mqbemgEBmuwnLv5irjrQfloaJUxH8SeN8odnrXDL/OCKNTqmKeV+l0x+nsum+2/QaSQ3ZPEqGbZoHXTXzxDBSc3dcNsdenBTJ6giMJ26PS61+78U7PBUMK+9sSSXiTMZ478J2kopCtD+dYg/4E7W4ME+Rf5/7b9Dhzk433J1BWDaloGg67PjT5arT1q9Tcc9ghsIV0Du5BjN+U4OzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeSRcQz++9NrVy0jjK6A4BzJp/ctZweA7pwBZRIjUo0=;
 b=FXvgXEWVTXgFNMV0fAvVt7YR772xQfbx+QoasqcizT+KaSXtpkdjlSJRY0738uo43vfonNQLwXtstwpvm9GH4RytFNOUFs0svQE6GwH1cSmmm7K3yjA6AIeeuXltkSAmOJ6sGtkP++Y6s+SllBVRYJleQMjAdUVb3H9x+M0CXT9sDfuNF2kVMHUZiXPfGk0XqBYD7/qaTT8H3ms/PIf+Ly3l5Efa9miNS5JBOg1aWmigdSziJgc6zg9UhxyAlnnbU13sbqCkpwbAm/KW1mHhwBpcK3u5W6Og/GKmMN/AKlOGLmCOMoEJda4DDQNppSKf9p/oWe3NEJOj+paQFDjygA==
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:01 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::24) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:46 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:26:43 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH vhost v2 00/24] vdpa/mlx5: Pre-create HW VQs to reduce LM
 downtime
Date: Wed, 26 Jun 2024 13:26:36 +0300
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzse2YC/4WNQQ7CMAwEv1L5jFESSltx4h+oB5O41AcaSCILV
 PXvRP0Ax9nVzq6QOQlnuDQrJFbJEpcK7tCAn2l5MEqoDM641nS2x1yohhpehPrGV2KfmApj34X
 Jnu2dgxmgrmszyWc330DnmAuMNZ4ll5i++5/avfyrVosGB2/a4TQZT46ui0oQOvr4hHHbth+xI
 fm3xgAAAA==
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c7d58c-b7fc-4322-f2eb-08dc95ca8444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjhYM1VaYWRUOTlMRHVQbXFRczFaK1pvcEMrbmtPR1J6UkRtckNiSWtKL0Mz?=
 =?utf-8?B?WlRkRTJlT3laUngxTUZQSExiamYxc3Z2b0IrczdwQ2NHT25KNzhOcFg1ZUY3?=
 =?utf-8?B?NkdIcCtJM0F5eU03NkJaUUFJVDhzeDJNa01KdEhzMUpxRFhySUw2NDBVeVZv?=
 =?utf-8?B?ODdlRUpSSFRsWno5RW9hVm14YU9xbnhyOCtvcHllbkdYdnlvWTR2cEx5V3dv?=
 =?utf-8?B?aUd0L1pZVm1pTlVCRjJyZ0xSYU5KN0QrZHV6WHZiQkxScmo5UEhIQnIyYUVs?=
 =?utf-8?B?Njk2U0hJV3d2d1FwcDRqTTlSdlJhbE9WZGFaSUNjVUN2QkVnc1gvaEhPNVNy?=
 =?utf-8?B?dWQ1QTNtQTA4K3M2aWRjeDdCVUNxRFl1bE9FcXB3S2FoeFlwNDY3NGZaK2U5?=
 =?utf-8?B?Y3RuVkFDeUl3UUdwUmFaTnJOT3pHdXcwMStKMjlkNW12bEZKb1R2VWlZRTRm?=
 =?utf-8?B?Tk9jR3BwazNhdEN6L1NNRHFQSVU5Z2lSdC9DVEFCWlJXVmpzeWwxaUR3VXpH?=
 =?utf-8?B?ZFRRM2lPZ2ZGQjd5aFpyTnpwbGpyb2h5K3JPclBuZTRzUUFzeTliQmlYMGxy?=
 =?utf-8?B?eXNQcnZKTnVYRUszcW9ZWkxDRDhDbGRBZCtzNmY1YTZxS2xxZzViNEJGMUZV?=
 =?utf-8?B?Rk9aM0cxNXZsclJSQVhtSy8zM0lJOXd1L2RWN3ExRllpMU9vN1JoenpGcFFl?=
 =?utf-8?B?S1J1QmR6eFBGeTAwRWtpVUZZTXNsb2M4bE1BT1F0VC9mVkNTb3BNNVVncitR?=
 =?utf-8?B?R0xnWTBtdWZaWmVtN29jRTNsNER4eDNDR0R3ajBpWFZrV3BHOUVJUTZ1eWxF?=
 =?utf-8?B?QW8yUmF3RkdLaDhwcHRmek5uUnhGcWdFZmdLMDhMRmpLSFVjbFJjTXFxRUZT?=
 =?utf-8?B?WElTVkpxOUJGbWI4V0J5c3lOdzhPWmVMcXdZME9ZaVVpMlZIT2I1WURsUENu?=
 =?utf-8?B?cUl4UVh1S3c5bGloaHdnc3JGWVdTZUt1NHM5akw4QjRaQ0tmSHZhMTFlREdZ?=
 =?utf-8?B?TXorRU1pVVRmclNuZjVJM0dBMVBkOTU1OE1LczM0dlRJSGxjci9YTVNmOWV2?=
 =?utf-8?B?L3RhOWpzTGxIejl4TzNhSVVHNXRzSGlZNHlXTFB6R1l4TUd3dytmQ0RlNmk4?=
 =?utf-8?B?bmNtc09Sd0N4VWhiWDQwc1VPS1poc2IvY1V6QnZHOXBMak83ckcyWlpIY1Jh?=
 =?utf-8?B?Y0xDR0RTcXdrR3hoRi9GVnZrcmV6eEJ4Mnp5akM0WWcrcWt6eXg2WjdvMlY1?=
 =?utf-8?B?Nlh5YWhIdlVIeE4zTnlIQkU0K3owZURPK3NhdnNNOGRtVHJqU1Ztb2dBTndG?=
 =?utf-8?B?dTB3dGdNc3VRNWxMN0JmblZ5cENLYUFBemlqQ2FoK1FHeHBOUmsrekZRbXI4?=
 =?utf-8?B?QkhMOVdRamQ3N21tdXVDS1o1WHh6K3U5TEt6Z3dhSm1PZW5FUFNmYng1c0hh?=
 =?utf-8?B?elRUemNmSndKMEJYNTBNZXBVRlVZdHI1WjRCMUs4Z01jbElHcVYxSk11aU9C?=
 =?utf-8?B?elJvMVlMRUVJQ1lUemJZeTgrdVJLMGxKdU1BWDZRVGlIekJLVURvRnJ2T0hP?=
 =?utf-8?B?ZW5DKzZJMTM2bUxYSFkxa0NXQ05LOXhVUjBRVUFUKzNJeWZCVWlMQUlFUzdS?=
 =?utf-8?B?YUsvWUZqSUEwdElLdDlPeklXVlNHa21hOGQzSEM3U3pMR2RpQ2FQd29CeGs4?=
 =?utf-8?B?MEJWa1ZvbFFiZ1ZYeUtSVEpnS0I1ODJXZXFzVk5kbjJtODcwMlRvS2E4WlBX?=
 =?utf-8?B?NE55VUVuckdOUmV0WDJLcnNhT0dmeUFJYzhscnJ4OXljOUhWc1p6aEs2aTlW?=
 =?utf-8?B?Vkt3anJkMWE1N096c1RmM01iZ25BWjBpa0hRL1hxUmhTZlZOVmlLZzBoVGNE?=
 =?utf-8?B?Rk1JdVdMS1E5cTBvV1RZTjJxcmFsLzFOZEpZUHhxWWZzVGpIREtSckdaRm0y?=
 =?utf-8?B?bXBpMm0vM3VUT1JhS3hHQTdUaVZ1eHhzWWhLU1lZTzN4OXdWdVJOY28vVUR4?=
 =?utf-8?B?UStWZDB0TTVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:01.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c7d58c-b7fc-4322-f2eb-08dc95ca8444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

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

 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 429 +++++++++++++++++++++++++------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h  |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |   2 +
 3 files changed, 293 insertions(+), 139 deletions(-)
---
base-commit: c8fae27d141a32a1624d0d0d5419d94252824498
change-id: 20240617-stage-vdpa-vq-precreate-76df151bed08

Best regards,
-- 
Dragos Tatulea <dtatulea@nvidia.com>


