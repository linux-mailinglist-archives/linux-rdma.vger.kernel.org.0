Return-Path: <linux-rdma+bounces-15506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6482D191EF
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3FA3012256
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0C38FEE8;
	Tue, 13 Jan 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1AoZrKA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54713803F8;
	Tue, 13 Jan 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311467; cv=fail; b=Iu/MS+GBXQlpfhI8zS2DW+S3qt4Sv68aMW7auS9aXRMso++sEvYrnAjab8XB0fdg+sbPjZzKVCrcfGMHiK/DMWUjCDFwTXSsJo4TQFC2T9tyRXdN688KQlCe8lrgX9UQ9WpBYEjgAS1LxSoHEitzFY/Wtm6+YGSR8QqUVHSVavU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311467; c=relaxed/simple;
	bh=FD8q/cjTY2+Usx0TZNl31mX/Cg7Wg62IvC7KqJhvpiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jNeZwhAJyLNp2okFq41wr806iCuuE6YPkfY2Li7WhO4b/SdWmFPZN+uAtxwpA22STasjGvyscvxdsKpmDDcVGPAFsuYcOf814i3W1I4wUc7y8WqZi7CXH6cSU/MScC2a9sSNysCJkUCPUFNT5aJnsUS+JrxAC9VI1XUjKsQUB48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1AoZrKA; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYMdLo7pYOQUqpbjJhJpfOHfZ2OELKkPqiYGPC30n877wXG20VY4MsBwJ1Z32p+YrcthnusPh1okQJN2sjXOwFo5/iCvegEEZ+M4Wo2CKKqs7FC5XXgfeLArxt9xUAbKrgQ0OtlHJ9Qq006rl0KHJoRrR1c4BJ4vh4zeKux+ZL3zssuh5+0cIryFQ3f8gE005qwC4tR3CRrEx1tfV4sRKqhaXH34DlBe3EKZJzfGzr3Sa1S3A3lnGUAM9cyeaUM+fjsusK0ftsonsunxrHDJVlqDtRJIy0TQAXDC7cTkb2MNiUbmjuvR9QMOsrbX2FDvz2tNow9QQ2FLBGdsCdPLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhIYHVZA54fmRjtkdDc/zYo6ot5+a6zFYdL5x/YD+CY=;
 b=jTNBl4O21xfxP0fyS+vos4rejwwwfmwJIxAPWCh3WXaXhi1okS5nzjqlxOeJ/mW/TrALiRNRi0Xt+hO3SWtUZ1XTJRlYBbaHZPvtzzwz9EHS8YcFzOnIAAWSuAU5PhgzkOYFE06z9odLisamA0j9OJE85X6ZpStyEUlPwNZQ7cEf9RMNnc8yBIiIYgBfV7IhGLuzEq9E3oyCuFJ+0K0Coac8c7v64YvwP8OEdIj7V2J/4Usb57AkJjaDK0zwKtNBdjicq/sicutN+pzcG8QSzXI1yG26XansO++aJZ5jYRWtgUZ3SxxCn/CjI1bdeeQ6oIed1ApJLIRO8llmJVuXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhIYHVZA54fmRjtkdDc/zYo6ot5+a6zFYdL5x/YD+CY=;
 b=H1AoZrKAfkTNK+1p77IhNTy7vGyDcqTENBiscHf7LrsHqWYXhTbXTRtKrjTrV1pt32zP3gqn6Qcm0aRNGHRJ0aVYC20tFl182lDZOSlmKkkOt93566WH+0kJv2AijONhxBIYrtRSt1qEIciCaPLDu3gfhheVMYlbmqmwk4Nid10/Spw7rHZsKkrynbNDB+KaYtfKvlFwkdN3yLBkbhpvT1htZ+hKNqHJD9184KZOZX1h+/i61EUmez0QKRCXdGPDxDLWpqR0pZrK+AaJv+bZofBVLLWUpTXLRABPr9zdKvHt5tJ+KQkJHRDQ21cTuvN3eEpqg+1WuBQ0oqnQih736g==
Received: from PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::15)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:37:39 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::cd) by PH5P220CA0005.outlook.office365.com
 (2603:10b6:510:34a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 13 Jan 2026 13:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 13:37:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 05:37:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 05:37:17 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 05:37:14 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Tue, 13 Jan 2026 15:37:10 +0200
Subject: [PATCH rdma-next] RDMA/mlx5: Fix UMR hang in LAG error state
 unload
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260113-umr-hand-lag-fix-v1-1-3dc476e00cd9@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAIVKZmkC/x2M0QqDMAxFf0XyvEDT6dD9yvChtFEDs45UhyD+u
 8HHcw/3HFBYhQu8qwOU/1JkyQb0qCBOIY+MkozBO/9yRE/cZkUTCb9hxEF2bByF2FKXfN2B3X7
 KNt/JD2iaA2beV+jP8wIc//w8bQAAAA==
X-Change-ID: 20260113-umr-hand-lag-fix-501ac819d249
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Edward Srouji <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768311434; l=7522;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=LKV2dxnqEpEuRLeR/2SdpT17NwbzLiJNVMddxe4sSj8=;
 b=nxlPNgU3vDt8rnTw2/gdIm+PHGg3susaJXzglLYS2OknKQERv8V6BOJNUtEf1pNKMZWeQc63q
 rwRfTbsSUdZDUpeud8kGpQ7+NcSDI9MLw+z2+j9AvDKOTcxD7qeP9Pl
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d99fc0-a6d4-4a6e-709b-08de52a8eb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEFnTVJ6YWltM25BbzJsZDB3bkpReDhsTXRhbHlyOGF4OXYrOUk0UllUZlhE?=
 =?utf-8?B?UDRnTXlRUFFhUzRyRW00eUlHKzRiTWJOK1FZYjlUcmp4NCtZWmwrQmJGTnlj?=
 =?utf-8?B?bDgzSm5EdTFXWCtPTksyY1hhbWxuLytQYUFsSzM0QTR0R3VGVWlHYUtuaVQ2?=
 =?utf-8?B?YWdyNUJXT3pubDZ1am9NSEZFYVdLV2k2RjZ6TWZsYVFXNCtwblhNc242Yldl?=
 =?utf-8?B?VXpKU0NIL3FRdUdxbTlwNEVYbjkvTjI0QXUyN05xZzI4UktvcUZsakhBOUFZ?=
 =?utf-8?B?UUlpVDVuY1czQkZoUHZIOVNmcTNNdGlvd0lzZEFIY0FoMWhvRzEzSFd6d1lU?=
 =?utf-8?B?dVF5Mm9ydmEyRWlkS1Y0N3JUTjkrTnRtQmhZd09YY1hvT29qa0UvTytvWURZ?=
 =?utf-8?B?b3FUWWh6U3hWL245WjB1aVlqTXpJaHp4bEYxV1hCckNydlh5aWFyY2RGb3hz?=
 =?utf-8?B?VlVuQ0RobHRvMjRWcHFPbFhmU0s5eDIwd2s0elJsTVV5OUlqeHJEVW5DVHVq?=
 =?utf-8?B?QzFuRjNoUDM3SFpYQ09pdnVkNTF2d1V4TU92UzNTMmF1aTNyTzdlYXUxYkxU?=
 =?utf-8?B?L0VlOVZHcTEvL3FQcnBpQi9peUROQStqUlhadzZVZVBmZUx3SWRKMnM5QVZY?=
 =?utf-8?B?Qmo3cWNZN1FJNTdFSHU5ZzR3ZHhHeHpwMWdKS0lLUCtmTHV4cEVVUlNpQnZ1?=
 =?utf-8?B?Z1RGY052cUlCOGdkR2hsZVp1Rnp4NFdOWDVwTERXT3gzaWxvRWxGbTh5S21R?=
 =?utf-8?B?Zm8xc0d0VVJNM3JPZG9VVU5SRjEvdTY5YkdNWTRJUnNEQTJFSXlXamtSMUZW?=
 =?utf-8?B?VG1xZUwzMlRxckRCWmZaT2hnTWpUWnRqQ1c0UWxibEx1cWZ2R0ZlLytUcUNH?=
 =?utf-8?B?UlNLcWdhYTR2bFducVVUM1RCOW15cGhJMXMrYndENG1TTmx3VUhTUklQWWpS?=
 =?utf-8?B?K1oyVGtNVnYySjVsQVRnMVlMeWNhMm42UXZGdWlGbGwvWDhwK294T0lscDc0?=
 =?utf-8?B?U2Nha0FQMW9DeTRFdFVsYWJXanIxaWxrcUM3aEhaMWozY2psay9pZXBIVjF6?=
 =?utf-8?B?MWJoaXdJcDJTeVZ1YU03c2xMS0NvZWVHZjdoUW92bEl1THBzMzc5VnVnWDdr?=
 =?utf-8?B?Y1NXQlhRM1hiOTBZa3lCVHJFK292UTd3NlVqMzZ5d2ZuLyt2WFcwOWV1ckRy?=
 =?utf-8?B?cXk0RTg5Wm1wR1JHbVFSc0FBT1o1dDl5NlZyZTl4M2d6L3UzTWE0M1kzVHkv?=
 =?utf-8?B?M2ZRRWVxWENKTzl4KzhkK3FCRkpLM1ZDd1ViRVFIWHNkWnJiOGptTDhKS2ZO?=
 =?utf-8?B?M2hZV1EzMVJ6bkFCcTZtWGZKYmJEcHhvMmNsVTB5T1prNWpEaUdRQVdHY0Jk?=
 =?utf-8?B?Zk5QeFdHRFNzbENhLzgwME1RQk5ndHN6N1FLeTR1UUUwbUs3ODdRUFBMS0VP?=
 =?utf-8?B?dzhYS0QwWjQwN1gxcGdqckkwa3BNTXdOOEJPY0FVeU1VKzJqVzhmN0xFWXhj?=
 =?utf-8?B?U01INUtRdjhXT0lnUERJZjllMGJiYW5KbmIzV0lqZFpRRDl2K1VmQUw4VURx?=
 =?utf-8?B?Zmpwb0owMUVjNlFIajNRUC9DNTJITXIrM2tPMkFqMFdvUUdIaDZsYnhxUXZy?=
 =?utf-8?B?SlVxZEs2K2F2N3V1NGJkTkJwVjEvVFlFaDZPNWhiOTNlUDF6S0NOb3hHODlY?=
 =?utf-8?B?SHRtT040NnFjemY5T0trd1RlaXowL21qWkU0bWI1WVVoT3pad0JRNUoraFJv?=
 =?utf-8?B?TU5xSW9HNjFZVXRPeEQ4TUQ1b2ZlRVFuYSt4empmdXIyZ3RjQlF3ZEJ1Tkho?=
 =?utf-8?B?cWFZME96Vjk0OFBUdXcvOFRCK1Y4dS9rcWIrRzBSc00venlNTGNLL3hycmpX?=
 =?utf-8?B?ekFKS3QzOVJzRWNpS2c3YTdQSVRVaHc1VFlKNW1kdFA1L2liTW1zRnI2NXlC?=
 =?utf-8?B?Nzcxb2N1Mm5XWmE2TWNSMksyeSszSnRoYk9iY2VlejY2ZW8vMTBPZGpRSXNv?=
 =?utf-8?B?NVR3Z2JVSmFUeGthcnk0S0RjSHFJa1BaYXZiaityam1mMFJwK3BYSDR5OGVI?=
 =?utf-8?B?M3hlSzdCYmJrd3hGaWMvdGJrWkUwb1UydS83UzMrTFk5cTduc25IUmlub0k5?=
 =?utf-8?Q?5CB4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:37:38.7087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d99fc0-a6d4-4a6e-709b-08de52a8eb47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

From: Chiara Meiohas <cmeiohas@nvidia.com>

During firmware reset in LAG mode, a race condition causes the driver
to hang indefinitely while waiting for UMR completion during device
unload. See [1].

In LAG mode the bond device is only registered on the master, so it
never sees sys_error events from the slave.
During firmware reset this causes UMR waits to hang forever on unload
as the slave is dead but the master hasn't entered error state yet, so
UMR posts succeed but completions never arrive.

Fix this by adding a sys_error notifier that gets registered before
MLX5_IB_STAGE_IB_REG and stays alive until after ib_unregister_device().
This ensures error events reach the bond device throughout teardown.

[1]
Call Trace:
 __schedule+0x2bd/0x760
 schedule+0x37/0xa0
 schedule_preempt_disabled+0xa/0x10
 __mutex_lock.isra.6+0x2b5/0x4a0
 __mlx5_ib_dereg_mr+0x606/0x870 [mlx5_ib]
 ? __xa_erase+0x4a/0xa0
 ? _cond_resched+0x15/0x30
 ? wait_for_completion+0x31/0x100
 ib_dereg_mr_user+0x48/0xc0 [ib_core]
 ? rdmacg_uncharge_hierarchy+0xa0/0x100
 destroy_hw_idr_uobject+0x20/0x50 [ib_uverbs]
 uverbs_destroy_uobject+0x37/0x150 [ib_uverbs]
 __uverbs_cleanup_ufile+0xda/0x140 [ib_uverbs]
 uverbs_destroy_ufile_hw+0x3a/0xf0 [ib_uverbs]
 ib_uverbs_remove_one+0xc3/0x140 [ib_uverbs]
 remove_client_context+0x8b/0xd0 [ib_core]
 disable_device+0x8c/0x130 [ib_core]
 __ib_unregister_device+0x10d/0x180 [ib_core]
 ib_unregister_device+0x21/0x30 [ib_core]
 __mlx5_ib_remove+0x1e4/0x1f0 [mlx5_ib]
 auxiliary_bus_remove+0x1e/0x30
 device_release_driver_internal+0x103/0x1f0
 bus_remove_device+0xf7/0x170
 device_del+0x181/0x410
 mlx5_rescan_drivers_locked.part.10+0xa9/0x1d0 [mlx5_core]
 mlx5_disable_lag+0x253/0x260 [mlx5_core]
 mlx5_lag_disable_change+0x89/0xc0 [mlx5_core]
 mlx5_eswitch_disable+0x67/0xa0 [mlx5_core]
 mlx5_unload+0x15/0xd0 [mlx5_core]
 mlx5_unload_one+0x71/0xc0 [mlx5_core]
 mlx5_sync_reset_reload_work+0x83/0x100 [mlx5_core]
 process_one_work+0x1a7/0x360
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x116/0x130
 ? kthread_flush_work_fn+0x10/0x10
 ret_from_fork+0x22/0x40

Fixes: ede132a5cf55 ("RDMA/mlx5: Move events notifier registration to be after device registration")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 75 +++++++++++++++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e81080622283..e83a5f12e6bc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3009,7 +3009,6 @@ static void mlx5_ib_handle_event(struct work_struct *_work)
 		container_of(_work, struct mlx5_ib_event_work, work);
 	struct mlx5_ib_dev *ibdev;
 	struct ib_event ibev;
-	bool fatal = false;
 
 	if (work->is_slave) {
 		ibdev = mlx5_ib_get_ibdev_from_mpi(work->mpi);
@@ -3020,12 +3019,6 @@ static void mlx5_ib_handle_event(struct work_struct *_work)
 	}
 
 	switch (work->event) {
-	case MLX5_DEV_EVENT_SYS_ERROR:
-		ibev.event = IB_EVENT_DEVICE_FATAL;
-		mlx5_ib_handle_internal_error(ibdev);
-		ibev.element.port_num  = (u8)(unsigned long)work->param;
-		fatal = true;
-		break;
 	case MLX5_EVENT_TYPE_PORT_CHANGE:
 		if (handle_port_change(ibdev, work->param, &ibev))
 			goto out;
@@ -3047,8 +3040,6 @@ static void mlx5_ib_handle_event(struct work_struct *_work)
 	if (ibdev->ib_active)
 		ib_dispatch_event(&ibev);
 
-	if (fatal)
-		ibdev->ib_active = false;
 out:
 	kfree(work);
 }
@@ -3092,6 +3083,66 @@ static int mlx5_ib_event_slave_port(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void mlx5_ib_handle_sys_error_event(struct work_struct *_work)
+{
+	struct mlx5_ib_event_work *work =
+		container_of(_work, struct mlx5_ib_event_work, work);
+	struct mlx5_ib_dev *ibdev = work->dev;
+	struct ib_event ibev;
+
+	ibev.event = IB_EVENT_DEVICE_FATAL;
+	mlx5_ib_handle_internal_error(ibdev);
+	ibev.element.port_num = (u8)(unsigned long)work->param;
+	ibev.device = &ibdev->ib_dev;
+
+	if (!rdma_is_port_valid(&ibdev->ib_dev, ibev.element.port_num)) {
+		mlx5_ib_warn(ibdev, "warning: event on port %d\n",  ibev.element.port_num);
+		goto out;
+	}
+
+	if (ibdev->ib_active)
+		ib_dispatch_event(&ibev);
+
+	ibdev->ib_active = false;
+out:
+	kfree(work);
+}
+
+static int mlx5_ib_sys_error_event(struct notifier_block *nb,
+				   unsigned long event, void *param)
+{
+	struct mlx5_ib_event_work *work;
+
+	if (event != MLX5_DEV_EVENT_SYS_ERROR)
+		return NOTIFY_DONE;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return NOTIFY_DONE;
+
+	INIT_WORK(&work->work, mlx5_ib_handle_sys_error_event);
+	work->dev = container_of(nb, struct mlx5_ib_dev, sys_error_events);
+	work->is_slave = false;
+	work->param = param;
+	work->event = event;
+
+	queue_work(mlx5_ib_event_wq, &work->work);
+
+	return NOTIFY_OK;
+}
+
+static int mlx5_ib_stage_sys_error_notifier_init(struct mlx5_ib_dev *dev)
+{
+	dev->sys_error_events.notifier_call = mlx5_ib_sys_error_event;
+	mlx5_notifier_register(dev->mdev, &dev->sys_error_events);
+	return 0;
+}
+
+static void mlx5_ib_stage_sys_error_notifier_cleanup(struct mlx5_ib_dev *dev)
+{
+	mlx5_notifier_unregister(dev->mdev, &dev->sys_error_events);
+}
+
 static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
 {
 	struct mlx5_hca_vport_context vport_ctx;
@@ -4943,6 +4994,9 @@ static const struct mlx5_ib_profile pf_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_WHITELIST_UID,
 		     mlx5_ib_devx_init,
 		     mlx5_ib_devx_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_SYS_ERROR_NOTIFIER,
+		     mlx5_ib_stage_sys_error_notifier_init,
+		     mlx5_ib_stage_sys_error_notifier_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
 		     mlx5_ib_stage_ib_reg_init,
 		     mlx5_ib_stage_ib_reg_cleanup),
@@ -5000,6 +5054,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_WHITELIST_UID,
 		     mlx5_ib_devx_init,
 		     mlx5_ib_devx_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_SYS_ERROR_NOTIFIER,
+		     mlx5_ib_stage_sys_error_notifier_init,
+		     mlx5_ib_stage_sys_error_notifier_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
 		     mlx5_ib_stage_ib_reg_init,
 		     mlx5_ib_stage_ib_reg_cleanup),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index cc6b3b6c713c..4f4114d95130 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1007,6 +1007,7 @@ enum mlx5_ib_stages {
 	MLX5_IB_STAGE_BFREG,
 	MLX5_IB_STAGE_PRE_IB_REG_UMR,
 	MLX5_IB_STAGE_WHITELIST_UID,
+	MLX5_IB_STAGE_SYS_ERROR_NOTIFIER,
 	MLX5_IB_STAGE_IB_REG,
 	MLX5_IB_STAGE_DEVICE_NOTIFIER,
 	MLX5_IB_STAGE_POST_IB_REG_UMR,
@@ -1165,6 +1166,7 @@ struct mlx5_ib_dev {
 	/* protect accessing data_direct_dev */
 	struct mutex			data_direct_lock;
 	struct notifier_block		mdev_events;
+	struct notifier_block		sys_error_events;
 	struct notifier_block           lag_events;
 	int				num_ports;
 	/* serialize update of capability mask

---
base-commit: 325e3b5431ddd27c5f93156b36838a351e3b2f72
change-id: 20260113-umr-hand-lag-fix-501ac819d249

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


