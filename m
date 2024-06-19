Return-Path: <linux-rdma+bounces-3347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5990F4E2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC53F1F233C5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6C155738;
	Wed, 19 Jun 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukd1fb4V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5F1C3E
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817143; cv=fail; b=qqJxmn8QdZKgk2vGSAX6AAkY1eC5FJdnIYlGIOh/meOOb2TRN6+UxLGdwn/WcYWCBPJRhhIxVbe5ZhIc7dSQriMO31S916WdzfMKhdR19fDkRGK3lr48/eFH0BNXkvmZIU/MIGT9IPBw7o/JDhHqwE+h5u7zysO/mG87iDcn94E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817143; c=relaxed/simple;
	bh=p44BvhqK6SHx1SWCilwl6wGKSizMBZXk3oUoOVxCPbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXsxF5EFtkIiyAar1byFsXvinsRS85p2cgAKcPNJyELK9zbFXtRQJn5CCI6engQL3IzeqrF/i6g7/eocHnyiWsGoPbYkBDGWS1xdWq9ulwWG+X59rzdaR2ekbESYL1QMwL3pkPXB9VLhFfyBI7TzjOWzeRmY1TBScG9CJUTTFA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukd1fb4V; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI6d8NgIHOBIRAeigIEKW3FHeBJNozu1C0m+VBY72fCuEsN879/9632CrG+zT1IU91theG+FhXt44XRpsRr31V6WFkeQPD4H7iFqxRFpmXYKiJo3vBwGIYuokewflYskb4YKdD+OsabjZpL8SLnPWlnTSOeQFsy3Lrri6u8ZR3XRx//yBO+3monuMysgpCTLQ279UTFhF0iu6sIpPROFXd5yd3NeU702DsXJe/c5fiG9kx7pE293l8l8z6WA9bTyRIZUh2xEsSligwf7YTebO1ThFeGkvYN01cE4SFN5fzk0VwA+Jn5zrfhebU8ZRVH3k+0gv8i4domEVD+m2nTfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOGATrBX4LJwEB9xtRbU7nOchBPhQAwHaxVa32lp0dQ=;
 b=hFtJPOzdZq6fdcyUolSQqGZGff6BH0h7OwFCpOywaMkfdav0QnAWfijEVGkEuIrbYVCZNS7UpRnzwV+O4iOGEO6NoS1+JCYJ6Eau91nQ6xQVchu5mwyjucDBTXnUpn+qa4SmpzxQT8TR0rTEZzE/MnDFbJiOP5FCOt11P0aBw8KMqSANDlKVcgn+N9gXA13yCj5HNx7Qx2LAXJQ2vHZitYa6nGN2kZXOGyHuizHy2GIe7MAsxeIPJpmauC5/I3K8t+JnN2gGXHx27TDloIEFdwGP4cdopkzvsjKbusYz0H35VH85gBFfEsophNoO0gbjSdWLAHPQ3iMIN1xKPUkWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOGATrBX4LJwEB9xtRbU7nOchBPhQAwHaxVa32lp0dQ=;
 b=ukd1fb4VN0AibmwAmSYazPNZgP33ysCmE9GePQh6qrce7AG7ZVwUBbT3MzdHDaF7gynD1vcxot115Tjd9XBTXH2rbCCiPO9Giys2GcAShGnLaVB2SKjMB1yt8w9TSCJkieeN3rHmnrKsjfkv2/ljG0aovaV7y98KNtAmOE7l521i+PCM0PACVNg1WUNwS7iuqtRNH1h7xlmzvR5LDL9twCzkfIA7DigQCtSqtmLpE47WVKjsW9dxA+AmtpW4N5lMu972A4yBHAT+rsxPMmftogIZe79RzzQBwQd1JOJo7R7wX0NPyQediUKSK1jM0ehOpQ/J8zIHth0CSkXIAJ8mtA==
Received: from BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33) by
 IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 17:12:16 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::d7) by BYAPR01CA0020.outlook.office365.com
 (2603:10b6:a02:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 17:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 17:12:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:11:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:11:58 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 10:11:54 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>, <sagi@grimberg.me>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/2] Last WQE Reached event treatment
Date: Wed, 19 Jun 2024 20:11:51 +0300
Message-ID: <20240619171153.34631-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 99820f50-f424-4e59-9f01-08dc9082f785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bc18E/HzNMEn1vtG/AienDk48yPqd2PYDa+dvjoSTQTLuhhCHt9xXZ67EnV0?=
 =?us-ascii?Q?krX8mOgoH+W6dVjRQpf4ZlMZU0DlyKgrQDLx9d3jBFfa6eh3t8sgij0DfpVH?=
 =?us-ascii?Q?Krw748WVJz9/nDBByVlJu0073+bwjFNG1bNMgfUIHYgHFeQ3scct3YmQ+zlI?=
 =?us-ascii?Q?DxdMAs6gDu6Cj0IFelSy8nhIBSQCaA/fj7qKbWhjTFhT7nWL3yt9IlRcCIzQ?=
 =?us-ascii?Q?o3cNHt4uqnrmEZy4enfjoBHSBqnh7q/989UJIhnOqIRvSAPnt3wqvAkKLiSY?=
 =?us-ascii?Q?CnEbqLgX89OUTk1tDhohMuhtzcPTScgk7SVXAOOJdu/9E6J+9hm4KBClSNwu?=
 =?us-ascii?Q?ts9LFLBL4HhB3Cs52VxNjhB88U6ZmcwHR3m+0u4Munyw+or1L3oieHQq6jX6?=
 =?us-ascii?Q?NoxGNFol+E7FBTGqNtY5atXl0+XF2phhPCm2qzqLhcx3kWjRgVedpsgu1bpn?=
 =?us-ascii?Q?TvrHwJOze09O5Pa32ZIIpCANY1T0LdppgCHO6bZtY5NZctKNYbPLvbS0fyoK?=
 =?us-ascii?Q?8q+I/yotVaGZSYgQ2OpoFenQU+BaUF6d+PPzeHziZZ9+8zwdwAo/nLsPLOKY?=
 =?us-ascii?Q?MEBmA3zoebhcndKQNWthHMcRjew+MCGWzuuNy8rteO05bbcbKIb+YjJts5re?=
 =?us-ascii?Q?b2b/v/KZuSW4m37SmeOUk3jTWPvTme2TMAthD2jkLXx8upSzARejYdVU1B/L?=
 =?us-ascii?Q?iaRHdkc0/8kXDZ7tYrwrD7ZaSpiaJo4idQBir2vLaSWGaDf3BGh6nDzkfh05?=
 =?us-ascii?Q?mFTop0WLLX3kZYxbWziS+K5bB/JVubHFLl9JpSS6Fh+LTanJvNCMcujE2gCX?=
 =?us-ascii?Q?xSSpkKUtugPVE/AMiylK3dblTr488U9pLBcP+IGCUj9YjynKr64bmkwFcXsL?=
 =?us-ascii?Q?LoGUFeQQOEinjjwn4idILIPEpchi3yWPaYrr3+GkSCFuEnRrHJtw9W2qIcmd?=
 =?us-ascii?Q?EvtTs36eYU7D3fnOcI4btP9qZ3RyHUnPJhwJKTjTLgeBfNjfrkbBgUZ4/NEr?=
 =?us-ascii?Q?D/VXFhQmexxo+o/fQlRDDr5XjGc2L66xgN2qEPMVZZuGWclT/Oykon+IZhdt?=
 =?us-ascii?Q?H3YqOKcgtfc1Ae2JA1vV2EWu0QvbbEIdeQMX9UOTGI8pFXhqy/jNUS2US25M?=
 =?us-ascii?Q?A5mxduQmYhgT3/hyuS8er7FITiKFw1JakIu83EGqS7VKShpX6FRGEp7SIbWQ?=
 =?us-ascii?Q?MubVrkqua+JsP5qlDfQHY98URjPje+AwOFXAoNKeO1I1f20C0PLF/Zn7lziE?=
 =?us-ascii?Q?RQSFam2UGrpD60KmAhNpw+LJYHC61AGkui59DTIvmD+Y92Jr4KRnl66VlQiR?=
 =?us-ascii?Q?Fivd7k/H8qZTdVQe1Ytk7G4bV5vP4yhU8r21LDMwVmjxTolhWX2AzbUPNedW?=
 =?us-ascii?Q?6WOsSzGtT89xzjGzEorRfAgbvnwAgwG9V60bvs6Dnr2dPei1eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:12:15.1395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99820f50-f424-4e59-9f01-08dc9082f785
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

Hi Jason/Leon/Sagi,

This series adds a support for draining a QP that is associated with a
SRQ (Shared Receive Queue).
Leakage problem can occur if we won't treat Last WQE Reached event.

In the series, that is based on some old series I've send during 2018, I
used a different approach and handled the event in the RDMA core, as was
suggested in discussion in the mailing list.

In addition to the main patch 1/2 I've added another 2/2 to remove dead
code.

I've tested this series with NVMf/RDMA on RoCE.

Changes from v1:
 1. don't withhold the LAST_WQE_REACHED from the ULPs (Sagi)
 2. Remove ULP update as a result from #1
 3. Increase the wait_for_completion_timeout to 60 seconds

Max Gurtovoy (2):
  IB/core: add support for draining Shared receive queues
  IB/isert: remove the handling of last WQE reached event

 drivers/infiniband/core/verbs.c         | 82 ++++++++++++++++++++++++-
 drivers/infiniband/ulp/isert/ib_isert.c |  3 -
 include/rdma/ib_verbs.h                 |  2 +
 3 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.18.1


