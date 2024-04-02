Return-Path: <linux-rdma+bounces-1731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C98951C7
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 13:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC32B221D9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006F633E5;
	Tue,  2 Apr 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gegukPFB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5A4CB4A;
	Tue,  2 Apr 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057176; cv=fail; b=GA+e5TZn80lvRGxREmNil3Z4Rd0Jezm7tO2svdMhNtAhFlggHf246lITtBJEvb8p0hjWCLcAgA8g2NPAfjwhFxlZYU7C09H0zI+RRumZk+hk8+78Nyf/947L/SbjDWulYIV5gCL0QDbx9TLw1lf7Gs1D1m2JT7+/UdLQN/Mmpxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057176; c=relaxed/simple;
	bh=mgFgt3xqiPHuB3YkarFgLEcQ7hv5ZGPUBXZGAGZdmsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlWC1yUmXjeHJMgwbQ6i5zGGWC+h9C/g8gmIBzHmkacwhrxROpvzyP89izBaf1Qs/VXIh+7JnXtPV0YWIVQUfQ5g9WdBxNxwqorIUAIqnZQ53dwUzcFb1/wLdjkpZvyYuDfqKArXCT9JhfBU9sprUpd/TDfPn5z5LyFDpHWuCy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gegukPFB; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSSyCwjiv9qjWnEWZ9Byt6J694CjZbo3GSyGxOoX3p8YEJxEBUIgSY+uXTsku5S9u08Bi2q1NUPe1tK1WXMTAQPEVx2IgQTEuOzNSHBgqEIc+qGEguvdWo+UISNGCE0sdzJHGWfX4ZQHRQUXc1FqY7tFf33DGSULP+pfOtKINvAjq0EgIjsLJGr3YlIYFTQ3mlq58Mp2Mt0GiPZo3t39EoiCwUB2+7mXEGpjdmFlSkrUiVY4rPiZP22tm8TrReXCaWDka2ei+tV+Cw9NuW3cYVi5EFc2B0mHUvAaVDTmtG2vTRCxd4EYHBvAlNgBumaRpDjvxfyYQSbUT6QHnNZ5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDSzgsB4vd4TdrVm7EJMzdd5C6dQoCvQegHRIxw4o3Q=;
 b=iiAe74O/Y6PdhI3aXfiPP5saxdQeB6Bv+pz+ua7/q2N/NkRTTYqfPxi+t1TWGywjLOb7kscn0wgBBKW6Uk1ru3owIrNbJcDxMa79+HrG5tCkoLS09yqrxo+Ly3wyY9VHhsoCtbBEWcjIQUXbfCshXTPGIi8/LUHkEf+0Vdco1F6osRCK4BFKWhZrxjghM7kvjV5IJW4vEg89P2+VQb3PMT4NgkQcpmAX8pauPyAWpVRk2Gji2MntmXR53e8HYkmBvEywIGx24aD0EdSaVKhYyYM9Nlajp4+l5GzQQ+rvfR+6sHsgwHaFwVnI1CWMildIFmFiS72o5nS/gqJ7p/0teg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDSzgsB4vd4TdrVm7EJMzdd5C6dQoCvQegHRIxw4o3Q=;
 b=gegukPFBvoBJTOyUEwdTXzsjV+Xd1kS+m5j7XKlYRHNIRTO4TBE/4aKdq6d3rKIyy5B6FpSlM43ue893F5eqIHvRR06Rrj2uZUB/NIzVYM4s3+mmrVufQjkUIrmCkw9E6/+TRcnAQt7ZWs4DgHYciOv6+LK8/fi180j+krJoBZSeWGPhhtZr4ysasWgTRgk381mexSb7rYSmQw/VN4Vnr8BQNGlG25BE2eAMzJGm8dYhxYiQDX8c1zOuJ39luD0JE1RMgRMilg0qDzA0JfQRSIrL1nYURTI60urynvotnJ9ye60tQJjWPvN63K+b0hMq3CZBqTdb/j49VYXU5HmooQ==
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:26:12 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 11:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 11:26:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 04:26:03 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 04:26:01 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [net-next v2 0/2] devlink: Add port function attribute for IO EQs
Date: Tue, 2 Apr 2024 14:25:47 +0300
Message-ID: <20240402112549.598596-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: a8166c03-83c0-4194-c2a8-08dc5307b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hr2xi6cwjPrfZi2I8i6QpEJZzJ6oFoI4bHKqjK4dOCoDGrbZgYtw8QrZG2jpeAQFDirn3Fx+BjNABkAav5XEztnSN08IsTd5e9HBquBzjUrJOwoiydkNqc6O62jfTy8kuyKzkybGx07QgjGWcUD4dtryJmWlbuahhRcCEet0MEdsYuA14VnzGppk7fmCH0JSCCyLKjHJRQQymMz54NPM8Wr7dtn/jqanxrow+2e2S4X0TIO5pNvzdFLQ8ieKzppIXNxbNUJM+QIBRhpgCxKd/TgRIl1ivwWlFgLJPooARKr7kFkfSahcJuSTfoecExZaKJId8SLrXHo/Tb2TDmOhEzhjuf+dxMB5As2gW4c773e6o1ycRIvveNAXzNxnDNa2FleBXhXzPER7ts+v0bZfmTP/XS2qyLGd07NeLUpzzYipmmL9+Eq9KVK91UZjTMYXZLB+9DPn/73APG/wKOnPKrtKbV8P0Ar9jdkPfRO6kFtVF7m3QQhnoP/jFISp5O1WUSeaL6yYJFh2Jme62Vpvm6uyIP5bqt4pzHQTxhvj7buwo4jekR0oIQA+EhKUzLHTTJpxJ00UDUOpRvV2p94CKHuT+yfnXlqvvKNmq8TgihehyqamvlrsLT40dl5efa+6XjqEZX6mk6htnuJ2lSQs06ioWRj4MxNbzaF5UIvjZtbedHI2P4bVR9oxPMgzh2Cr9WNdLOlvC8d0rV1Wls4SMMUK1CBOXYc9B6y6Vc88pSaWmAoVzH0+83QxHeOUkHuj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:26:11.6082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8166c03-83c0-4194-c2a8-08dc5307b339
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

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
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
 include/net/devlink.h                         | 14 +++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 52 ++++++++++
 7 files changed, 198 insertions(+)

-- 
2.26.2


