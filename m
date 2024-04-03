Return-Path: <linux-rdma+bounces-1769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1989785F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D783B3BC36
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D3155A35;
	Wed,  3 Apr 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFaZalYv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987F152DFE;
	Wed,  3 Apr 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166132; cv=fail; b=Xx2ih7/98SIpFvquWB9HdZdUd/6xHi92MvNi6jZvXBFgDfGZ+VWR0cIUvZxm4UvLjneGTVMjZ72DqXn9d4oTi+B4PRAbqVYtkwMuYa91qvHI+wHhs+7ky76NbPrETny84xDAl0vu4/oWS7t0wyda/QbpLRHWNZAK57ipALaTQ1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166132; c=relaxed/simple;
	bh=jlXnKduzxaOwfaAhfgHFKV2sW/WHlIeHS2BVi7ivpM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1+NxYgPcnwZAOKxMUUg24DkFG+FQJE4aCLlNGR2mmZ9oMu3cpz/BstYBozGvaUerIGMde+6Uq0yNbSr+0dGZXyWrENLMj6YXrsaUn/AY1jro/YFFzs6vm1xLk8QiPVOgIgTQVJZGaLxePMet9zRRa6TFB0pfWRZNOSDoxj1MtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFaZalYv; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMBN4VUumANqeboh8HghqaFhlV66BqchbNR8+km4iHJ4idNhCumYlm51uqJB6KrR8OT++UVpWb2nKrJeCx5UcyLJU15REQrmruyPM615zjY46lL60BSp73fKAaDX5+v1Ho8d435GfHrD0k9xlP7rNV5XL1UiaRxe3hSDW+P1YAGegI8DA0ohyLV9+AmwS1CyI9XM8GNWyzif2fIwzVShMGHqtMNpxZtxjimwAIuarhnMRcIXuMQi31w2Ms0JfLUfRxBdpq4fCcouBOmTk8g4fcEdtkjq2lp5QOD95xPu0QtmLjUJ0ECdgJ+mPoufJJBT92D7OpcAa37k4X/qJNnvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwuzmTafwFAoJ0FO0IlmTe6yLzn2I5ns5SoiqZwlZlE=;
 b=DkaXeE3I82bfhV3aOjHo3zBTvjc4N76SG1U4PWYmyZlRnZRZ9bqHR4MJ0Xtv3QUOPRNzFwQdgwTHCXVqQFhVRsBjRtgJuC+a6ZEwa327ROLgDr015zibso+Xub9QZymjZYlQ8avLn/8qpJNxci7T5f7SXsdCUQprsm+TjR1F5vHAqNGJKGvcukgCWR0WaLJ13i5VcKpenSqxeBVq/ByTmmxjbt7Qun7TuD2fBA+AmQDSQbBr89rJyEn+d4U+lpRJKZEM30j6umRHzq6+cmE9JjmSPGvarc6jP9aK+RLeNbXBLebkgD0GyoLNSclQPepC06l/ELsyogemNYQl2zTr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwuzmTafwFAoJ0FO0IlmTe6yLzn2I5ns5SoiqZwlZlE=;
 b=UFaZalYvdJi6AP3L8UZvTL7EeELTY0JK8T05twCn/nZvYCTIHHRVCJTaJlyjMTAoRKRx0+YIqLkSCZnI+rgYuwXjH8+KOiwbakbhtDTJ8WRUzHuoNOHM6SI9t7rAHr4xuzwjziYVI04c7bNgqom8vjfldJ7Z+95UizAw9vRxjy50mK8I47Wd8Dy6kNfDxWu8MWXsyPovF5XakIgOjajak4l0mVPO4eQLfNEA7AILHLU7msccoBewlVC65POp9mHcq8+YJC8quJ7fdcLXh1rryXITmfbg6KE6lhhmkDqvrBxw3obw8Cw3/B3JsXrlhvuooppi0K4ObnoXiJt5WPqHlA==
Received: from MN2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:208:15e::35)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:42:07 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::52) by MN2PR17CA0022.outlook.office365.com
 (2603:10b6:208:15e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 17:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 17:42:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 10:41:49 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 3 Apr 2024 10:41:48 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [net-next v3 0/2] devlink: Add port function attribute for IO EQs
Date: Wed, 3 Apr 2024 20:41:31 +0300
Message-ID: <20240403174133.37587-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: db6ceca7-9b20-4916-bd29-08dc54056236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dRpS9RN8nKku/13ECosGIa9yf7Jh4R2dIlbu55HGPuWuY6Hna2ymCSjLcY/6IsuJYyb/BmiwMEwThBtqf3IIkuMQlDwBBgL6Hm6dhQSTQBUlgKrvqAEy26SE4EwuuTkkB1cof6EoyiJ2Ny3CbHmGHsFkQYwk0BWBOsCUBnX/WukZFTMsNQFtO4y4DON1s6DoV00sSpeAd2VKKNV8vgu/ihQhuZOpVkG63fZsOFTFy0+qY5xc6CNPIdYSRr9WhYU1XGCaNwRKrAIBbliEPKi28SjJfmrWeFlpJippm/K0b3XX66rfUjRYQJX6YVYp8M4HwY/qVtIlmoEEcqacBJA+A5mEoMno5+2BEb2yWeoDbxZTErgKiy7wg5vgHydQOCw23sHqs75B64pAhHFFO4QUM69qWS+jyo28CA4eD6msTEcC6OgPcW70SUZeI6gaL3KbnyS+eskCGU2X5eMLXLrAmuJ01Dp0rEVfZQNa2dTrGvDx+V7kBl53DjtO3Nue3h09Ph/0Yy+ZQc53q3Y7cRWjgAAmZ89sF2qNb34vknV5MZm6Sv4KgdoVrbi1Q+9ERVuOVMJ2+fHQ/0C50+Z8Eu56JSyz7x+UPy2BXbcdWKwtwancbtOpKRR4ZDJ6ZAU2m9qRopmjxQWRbqfwtIAZIB7VkFNIAbBIeqJFI6ynd3mypFlvPbiOszYYQ1c/nRPMs5ZrX6xqbPzHx+6ZT7N8dAtsgcpQWpUc97OWF9rw1DC7A8Pfw5T3IMtSuYTlEKVcG8lX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:42:07.7060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ceca7-9b20-4916-bd29-08dc54056236
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

Currently, PCI SFs and VFs use IO event queues to deliver netdev per
channel events. The number of netdev channels is a function of IO
event queues. In the second scenario of an RDMA device, the
completion vectors are also a function of IO event queues. Currently, an
administrator on the hypervisor has no means to provision the number
of IO event queues for the SF device or the VF device. Device/firmware
determines some arbitrary value for these IO event queues. Due to this,
the SF netdev channels are unpredictable, and consequently, the
performance is too.

This short series introduces a new port function attribute: max_io_eqs.
The goal is to provide administrators at the hypervisor level with the
ability to provision the maximum number of IO event queues for a
function. This gives the control to the administrator to provision
right number of IO event queues and have predictable performance.

Examples of when an administrator provisions (set) maximum number of
IO event queues when using switchdev mode:

  $ devlink port show pci/0000:06:00.0/1
      pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
          function:
          hw_addr 00:00:00:00:00:00 roce enable max_io_eqs 10

  $ devlink port function set pci/0000:06:00.0/1 max_io_eqs 20

  $ devlink port show pci/0000:06:00.0/1
      pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
          function:
          hw_addr 00:00:00:00:00:00 roce enable max_io_eqs 20

This sets the corresponding maximum IO event queues of the function
before it is enumerated. Thus, when the VF/SF driver reads the
capability from the device, it sees the value provisioned by the
hypervisor. The driver is then able to configure the number of channels
for the net device, as well as the number of completion vectors
for the RDMA device. The device/firmware also honors the provisioned
value, hence any VF/SF driver attempting to create IO EQs
beyond provisioned value results in an error.

With above setting now, the administrator is able to achieve the 2x
performance on SFs with 20 channels. In second example when SF was
provisioned for a container with 2 cpus, the administrator provisioned only
2 IO event queues, thereby saving device resources.

With the above settings now in place, the administrator achieved 2x
performance with the SF device with 20 channels. In the second example,
when the SF was provisioned for a container with 2 CPUs, the administrator
provisioned only 2 IO event queues, thereby saving device resources.

changelog:
v2->v3:
- limited to 80 chars per line in devlink
- fixed comments from Jakub in mlx5 driver to fix missing mutex unlock
  on error path
v1->v2:
- limited comment to 80 chars per line in header file
- fixed set function variables for reverse christmas tree
- fixed comments from Kalesh
- fixed missing kfree in get call
- returning error code for get cmd failure
- fixed error msg copy paste error in set on cmd failure

Parav Pandit (2):
  devlink: Support setting max_io_eqs
  mlx5/core: Support max_io_eqs for a function

 .../networking/devlink/devlink-port.rst       | 25 +++++
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
 include/net/devlink.h                         | 14 +++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 53 ++++++++++
 7 files changed, 201 insertions(+)

-- 
2.26.2


