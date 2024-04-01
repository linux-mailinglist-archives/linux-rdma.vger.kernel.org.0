Return-Path: <linux-rdma+bounces-1694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BD89393C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369A01C2121C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CBFC1A;
	Mon,  1 Apr 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sO5llBTk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A6FC08;
	Mon,  1 Apr 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962368; cv=fail; b=HjwaqLst8Se+dqOK6O6w0I/APkYfMrCWwE95DHK6yI5cJAVDDlsuDjbIg/uw6mH+ZGGs1kM8PSHFA1MnrJIRIY8ph5cFJJJtpPx3EFJZbBl5EmqhBz2po6kvwxYB/mJypJXd2Qt4c0zNbmXvQPNxxn0M2nkwCALotUcijg9gkYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962368; c=relaxed/simple;
	bh=3RQhNvI/a+/G/CNiwQT9BUomL9k1rJaJNPucEigaXKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewfoB2nRVVMTawHjyG7s9txowPSJN/B8BYp1wYUxI+Mx/gCq77K9+msOKzhQVcj046b8KrwDPofnjycXAYBRp3n55GVcdDgFStn+DQJLbW0s50cV2LpbojFSO2/p5r6CL5TKVfGGdkdVT7yg44i/8Kuh9aNp6DI3o0uc2oromKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sO5llBTk; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gye/UyrHBLGuWAm8dlLaXzs3TnDU50g9W2dYCrRmG37ytBX6m6SEL8gXDz7UHHCsVplylwe/w3GWBElcIk8vmiwUOL4t3z8MkIJp4E0WiaPm1iKLospljMrdIj4dA1UTVIwF2m9NRZ8yzAkoY67NP2zf4bv5vjzXKyWUIATtBXE7e02HGR66q1TwrpTuDIt2dyHYbfwhmM/Tg6WUjreDecpxxfamX6niePpNzQ74ejKZuPvzvgceH8+0dntLIhblVF8XLiI+rFxvqGjX0h6K8Z3VPRk8ZdhjaAdhbV78504Upmbuy1x7+5PM258efoq6i1USN+cl6km+TGInEidlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjwbf5IO4kJkSBaQDg53aNMfV/fKVVhUlHFeOxuF4AQ=;
 b=lQKrXOGbq/lDYvVsDrCQz+Mm4Uz3ElRhSfKB2HWGRDCDob+QgLNMgqvbFVTWl/KTzF5oFRTHiGHCKeodICpDxSB3644ef4HLaFoC8UfHvC/Jfuoq74dRhKanAA1wVThiwpNO9O/VQqbTxiLD4iG1z8ypguxphI9OTZ6181bopF8HQ93YXV5RrbaXtPBFMgVigFe8n6YNcbdccgpqur2OdLBsVXDZbWhbepBVbHVaJ2Z8XVEb4xciN5Zsk3hdjGlLBZzDEs12vxU4PHnEQ+DLV9AX4D4GsHKipAGzMFtt9Lg+KiKFhwfX04fIGqPSYDC0HTssadUs2Jqrx88YZn6eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjwbf5IO4kJkSBaQDg53aNMfV/fKVVhUlHFeOxuF4AQ=;
 b=sO5llBTkQ+uzMDIA045xcDrSstEDnfv0VBLtpgiSJLClKOmuLJnz+NY3ZfLl94bvLIvzXyxbtIdz/UgJrWPeqHuH/4dcIIiIqVyTHZczuqiTujB9BWuRiqje/qOUg8l/sIuwLV7ix3qeLY3l4/fSBm+TLr+RuqsirKIjfXI33t+V3jZPt83q8MA6NIsMwKaTou/0OFvVmO2hz3rMOsK/dYpiH/4pWIsiUFkYAf8aaHBE6f/Yk9YCbKMi9JKiSj886YHHFsqU89yu7vc+W6YnmBky4+c4WjNqjaIQd0KIaulQwIDGZK9/MHqvs8RJC/HVfY8DFa16vG6hFp6ifmTXCA==
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 09:06:03 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43 via Frontend
 Transport; Mon, 1 Apr 2024 09:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 09:06:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 02:05:50 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 1 Apr 2024 02:05:48 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [net-next 0/2] devlink: Add port function attribute for IO EQs
Date: Mon, 1 Apr 2024 12:05:29 +0300
Message-ID: <20240401090531.574575-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: d675bd8a-b0f6-4350-0455-08dc522af4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UeEj6/IwRd0Z1xjNR0UzVUSaTHOL7hInLFwUHYTQ+oJJiM/gfYye/LoRAd5/UE2nPQYHNB+J35cP2jevOti8qqgVgG7NyeILhKbHlvHwkerqLaiBOMGzI5RjJ37TLZahZd6E5M2/TBN6iBcVsb6l6kpaCeM5PlI05yaCRt9Z9ny7GiccgGRfV/ca34Y0Wy9AjBlL3UzyvWetOkTwSPaYxGfFKgV1o7OMHvXQHsBWiU1G4opeB9G2ujgA1GSbBcqwOn0UCQe/ltoEyTdVtJdPZi0ux4kQ+DzBj7WFl4ECUvskBoPOB9lRhQMwfTfrY8ooZ9V8Df69AaH25owtY001DdpnSWxeSs2f2nAx18L/DN4WXBpRgj0j5e1oZApsmdgiFwveoj92/tUoOVfNeETEtk3O6p+89Y8HnAI0hOSr/T5Hivx+RRsdBCIDBRzyi3XhKbUwgqu3ER/Dp7IG0M1BAzP7US+p1jcRBiis/mP1P9vjwbOQBl/P8vg9xn0Braq52jI/3eY+mTD+RkpNd8v0T4HX1w63KJRb8cUwg8cNSEc7O81J7cSncfUQNL2qYMPs2atr5sGRrAhEYLieTtyaLrTSyN4q9ZSqMQecMrh0NFd2B9HTgs/PM3qattlC7bnoYkm7+b88dxZP45L2VE6wnxLXWEWJxHCc8yTyeYmPBYs2Lt3ZZym3zBB6JcpT2H2Mto/hOgsSgLfAUHsrP5z5SwKNSK2FWYs4Xexgfn/YWdpg/g2IVfw9VFzFvzD4K2EQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 09:06:03.0557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d675bd8a-b0f6-4350-0455-08dc522af4fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

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

Parav Pandit (2):
  devlink: Support setting max_io_eqs
  mlx5/core: Support max_io_eqs for a function

 .../networking/devlink/devlink-port.rst       | 25 +++++
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 94 +++++++++++++++++++
 include/net/devlink.h                         | 14 +++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 52 ++++++++++
 7 files changed, 195 insertions(+)

-- 
2.26.2


