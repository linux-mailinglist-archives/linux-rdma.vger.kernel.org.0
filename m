Return-Path: <linux-rdma+bounces-3214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5290B697
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B2B2E067
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC913B7A3;
	Mon, 17 Jun 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYqeObro"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F213B588;
	Mon, 17 Jun 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636889; cv=fail; b=Da5fK/piYAjvcE8PCxxcSqo+9xPHzl9V1XugpaFVYJt+MfKlEJIY3fJfFDaKZRCQ44DkM08mtw8UxW47vYZoYYk9uYJl+6ASjwMMmXt9MrvEp/42MBBd8wQOVLQMm1IBzA+9auxqp8TyuVc7vx2/f4PeYBMe3p08PdruimlceJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636889; c=relaxed/simple;
	bh=HxYKGX4SgXfA7EFUbwvkGMr++DoSfkX1ASIXAl5Evgs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=WTOaw/KChb0h59aFiAducm6Al5SW1CQRyIA+yFcDAvuTa0PIwFxWmyciVPeuNOipRSeRRrHo49ieXBSHIHkjwS+KZdftOMXR4a4oX9aG2kdai9pu0rc1pbem8DpiLWgZkjy/eaKIsE1ZyStfkSjWBjdmboECpNzz2jvsy/iCsf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYqeObro; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR9AoDM/TU9AuNxk5Wgr4MEdpr6+g7LE1KwEQr9xt3mBmYrBnVpX98ExfxkQr/vZBranQ+M4uJvkQaGJy7fpjBaCUCMXYXrl1M1uw5c/yVAgvqUyLlS6mNPEWoQBU7EPjJfz5ThY6aQAFcH7/zKBV8aTBY0Vu90Y96DC1/GYyxUVKgfC9Hum1wn8h0WHqL/ronqKkvy8PcQZzgAWPJwIrDjhJgy43fu8SWlDey5H+xk1i9CVh9sYLXq74jk2URDczA1ufSTpx3apnZRB5c+Dz0VY+1YGiJb1sjQVKHwcZsCbr0tn1mqlzUj5rixR5I7EYQOho8xGfuMS5ebGdqB/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0NJSJopFpYY1sxBz7MOQBRS8BqBtGo3jUQa1q/1gmo=;
 b=FKjSuQAFDVYH6kTwjE5CERD4+kD9iN+mFZzvYliLYuAE/NEp9wQ9b6vcm/WwDnGvGufpHEg2u4PCeUELesjnzfeGSbnIAmFy1n36I7oUuODCS/iXsJXtr5qhYWTzsdWEyLyBkhDgP8oP6KDDVEesJV6cVh0Q5qfTn3osJD/PfYGmv6HpFoIR4uNLc7qXDOtRVPPoghW9P0jZiJ06ez2yZLqRIqBEm+MK1/bbmyjYAyVKS6+ewNDNZXk6ZY950YJhzA3rtQGlemr6Y5/zFjq3m+e2DiNLzmN4QV7zbfFlK2EY5zvhWq2FY3jNzMjj3PKE4gv0w5kaPzIACPyGYEt/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0NJSJopFpYY1sxBz7MOQBRS8BqBtGo3jUQa1q/1gmo=;
 b=uYqeObroVVvz2tsBHGgpSCkF21QmsKAe4aVVcscfxAI7h2FsH4L+KEcb7eFd7t7v/iSNsoI7zvLhcDzXizRG0dWbKT3PmBnHxHh+P6Oq2t6Gi8MrRnp94QfxbFVudwBvPmZocP7kT5sUabY6wkk6qODKX7OgwFdCEsk/nZYTdUQU5UwW/38wPmVHlwVxf0niGPfrwxDCng3bcVQPtCjW1tDRGnTEkfio6zffR20Rqi6kt1jB3jgfnJm2Xqi1aUNzA4rqeyZczE/PC+bkwskao7nFDr24S9dqUfjslwweAHhxSlVQOwGOfrnuvuBmxdvELN3aYGFy8nbAonwb9mnApA==
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 15:08:03 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::41) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:07:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:07:48 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:07:44 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH vhost 00/23] vdpa/mlx5: Pre-create HW VQs to reduce LM
 downtime
Date: Mon, 17 Jun 2024 18:07:34 +0300
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdRcGYC/x2MSwqAMAwFryJZG2jFH15FXFQbNRs/TSlC8e4Gl
 /OGNxmEApPAUGQIlFj4PBRsWcCyu2MjZK8Mlalq09oOJTodk78cphuvQEsgFwm71q+2sTN504O
 +1az8/OUR0n5KhOl9PxlLUg9wAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 75062541-7fd3-4e6a-728c-08dc8edf4908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkcwMWQyN3BwQ2RRQkVQTEZpTTgwTHpUN3ZpMjBSdTNINjNoN2JYa29jNWNP?=
 =?utf-8?B?TlV4Q01QOTZZVjVQcFMzUlhwLzhoQng1cGtDcitabWNoMld1Q09RWWhpQU95?=
 =?utf-8?B?MWxtVURzTGcrcFQ3Z1JESkJlN0prUDc2RFg1eGI4VTI1TWd6bCszRC9ZY0ph?=
 =?utf-8?B?alZ3L1FKWHR1R2RPUUhIWEwxazAwQXZlNWNWOGR0TXp1K2UyRnVwUzFCZmZs?=
 =?utf-8?B?WnBYbVArcHpGd1oxSjUvUGdTR2tLbTlBVCtPQ1Y2YXdrcTFWZWM5MU16N1Yy?=
 =?utf-8?B?NmJSb2FLL0YxZUoxL0ZnNks0dGRSaXcyRFc0blJNVVUraDc0T2Vmd3g4dmdi?=
 =?utf-8?B?anF3ZFNsQXlxQnNIREZ4RHNEZW1STjBtb2RlQkZRS0JuaHp5R1ZkeVNkVVcw?=
 =?utf-8?B?SzBDM1VvMEpJZ21BdVhoTEV5SElJR3RwUVJuNng3bHZNaFlabDFFTHhvSWpO?=
 =?utf-8?B?bTk1SDdhNHhnVjFMaFVTSGZqTHpTTDY1WmVvMGRheFpLWW05RGltL25BWUc0?=
 =?utf-8?B?SkpSeCtIZEZPc2s1RktpMmcvcWlIR1N0cURteCtiaUd1bzZKYVFWRXdvTzZx?=
 =?utf-8?B?UDJUNXo2Tjkxd2xqS1JJeWtCRC9SRUQvdEpKNDZIQUFJWS9jTG1vNSs3WkJJ?=
 =?utf-8?B?L1YvNzZkNkxZTGVjMTF3eDdXWXA0VVh3cm5FQUdydUdIbUcyZ3JjaElvMmhT?=
 =?utf-8?B?Zmw3MzJqVW41TTQvRmRUeVJPZEtJaEVEbGhQb0RoTHFMUmtwakJnUFpORlVC?=
 =?utf-8?B?QS9HaHRpZk8xV0hJdkFyOGFPTDFOMVpQL293dTBOeHFvb1JPQzZ3ZW9jZlFv?=
 =?utf-8?B?WVJkNElRM1JZbmZ1dEg3TldudnJ1RGorR0JKMWhPS0hrdkNaZlpxekhuR1FC?=
 =?utf-8?B?b3hSak9tNWJQWStLOE1JYTZvUzREZFRoTEljL0lta25KVnFTRVhUVCtROEZD?=
 =?utf-8?B?d1hwSmZCMno0azA2WFhrWm1aemVGU3pMSWhpQjN6ZmdQSkJ6S0pDbUtEQXFq?=
 =?utf-8?B?eis1Myt5c1lEQXB1UU5uOVU3dWhONjI1YUNmWkNjc29zVnNLSFV1WnczWVc5?=
 =?utf-8?B?enE1aDhhRDJjcExBTkF1WmxjZzlSMkdCK0d5Z3Q1MDdvT1hZVDkzdThPUmJN?=
 =?utf-8?B?WWJmckRFRTZHZEZtZ2lYWi93VEs0cVo1MC94eklzTEZZTld1QkU3ZWZUaEJE?=
 =?utf-8?B?ZVBqZVVrcDVCY0J6MW4rVjVHdCswMkJTbjdGTG9RTUpmZEpoSUtNbUMvNzM2?=
 =?utf-8?B?ZVUrWEMwM2J3a2lUQkg4SlhJUHRlN0h1TVpQM3IwMnNxTlFYYXM0Yi9qc1FQ?=
 =?utf-8?B?WkY3cUJRR2dFSE94WnJ3RDcxL3JXVEVEQldxY3RsRElndnVPb1RqSXhHOEtQ?=
 =?utf-8?B?aWpab291WG9IMDhHZEx5cTZaNUx6MmNRK0VrQ1gvUXZnejRQdDlicktZVXV5?=
 =?utf-8?B?dXpMeUxEL21DcXY5VENLTXNWYXhoSGtYTmNhN1RmMFYyTFpleC85cm44RVJ1?=
 =?utf-8?B?ZFJYaktKMTRKSHpiUnlVd1RHVWloNE4zWGtQaWxzZzlrNFNWa2dybDNpMWl5?=
 =?utf-8?B?c3o0V0dnWC91ZXlCb1RkVkd1ZCtuOHFpbHROQUZOQ2tWZTdnUnpxOGdsTkp0?=
 =?utf-8?B?bjRUaUFpRTZsZVNiR05PaHB0TzArenhYZ2RJUnpITmJMR1dUbWlhWE4vUXUx?=
 =?utf-8?B?R0t0akNrZFlFeTVFMFRuVG80T1o2VlUzVWEzTzVVRkhjVHQrWUdVY0dyekJU?=
 =?utf-8?B?V0hJcVdwdis2WkFDS3YvamZ3UzF0Y2F2ZHhYYkVCaGZEalMxWmNGY2tvV3Fn?=
 =?utf-8?B?RVpZUTZkOUpLd3V2M0pxbUtoS3pKKzVBYjR6TU9NLzhaSmV4cGE5TXkxWUZ1?=
 =?utf-8?B?SXhUZjhpSEdCL09xN1pRWkxjajR0TUZmZ0hSRWYyQTNCVUpDV1lVSVR2NThU?=
 =?utf-8?Q?kbRCjztwcxM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:03.2034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75062541-7fd3-4e6a-728c-08dc8edf4908
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330

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
Dragos Tatulea (23):
      vdpa/mlx5: Clarify meaning thorough function rename
      vdpa/mlx5: Make setup/teardown_vq_resources() symmetrical
      vdpa/mlx5: Drop redundant code
      vdpa/mlx5: Drop redundant check in teardown_virtqueues()
      vdpa/mlx5: Iterate over active VQs during suspend/resume
      vdpa/mlx5: Remove duplicate suspend code
      vdpa/mlx5: Initialize and reset device with one queue pair
      vdpa/mlx5: Clear and reinitialize software VQ data on reset
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

 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 422 +++++++++++++++++++++++++------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h  |   2 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |   2 +
 3 files changed, 291 insertions(+), 135 deletions(-)
---
base-commit: c8fae27d141a32a1624d0d0d5419d94252824498
change-id: 20240617-stage-vdpa-vq-precreate-76df151bed08

Best regards,
-- 
Dragos Tatulea <dtatulea@nvidia.com>


