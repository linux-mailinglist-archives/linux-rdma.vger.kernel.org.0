Return-Path: <linux-rdma+bounces-5938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257009C528C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A681C1F23392
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F220E332;
	Tue, 12 Nov 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uns811ZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F920E325;
	Tue, 12 Nov 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405521; cv=fail; b=lDPQOEp5zlRSrKOK2aWwXVZJyUB9CO0NgnGSy8Rq5P7yj9EM9JKpzhEDcxBmDpuVQuNYfMtA6aVE0V5t4MWf6p8MDj3jvwtMf0kRE2VkgpD/cmcEvYbAcb8jeH+dAoTPsTIU5fbVhgCair0gKSgnO9VcGrPK/PZrrlpe7ZXFeKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405521; c=relaxed/simple;
	bh=MSrwfcXFsVPrcUcJ2wMtscUT0qlGFwvbcGRqd6uAwc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUHI9EtjD4zp577ETPNrwg38u/deZBlsaVQBxLTHJ5Zo3Gy7ihe4AFLrRJvAgpEvnpS8OJeLLVptMh06k1/3G4ZFtCYPUR89DhVY4HAfMHj4/ihzSU9Dl5FI9X5GXwxwgUmHey4ejZKf7BBs4+ZG3pgVhzXGjddnKQrI89EcJYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uns811ZM; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNTWvTpWorEnJ3O5+s/kVarptbJWBojSqgCCaGS2TJ8FuT6QQAY5XqtpXU9Sac3Yk3UxcrLw4IcvO8EFOQ/NfYzvx06b4s3yELTfFhyqjFF+RN8T9qTY+nJU6Ufv6Bta9ScSRjbS6POgs6fyWDen8ixcsOMs3oOZ+C7CkdXS4JgSlwx7MnMnG1VtdQ6+98KkcgAV3TkM2N4swkSQgzCrbCNRxQwa3CSw6aDhGRP174l6eenQsla6+8ACrlwxaKT9EDbTYl2AtupuQgW/n6ComYQ/ug8tJRjtLS/se6rkpVXrPVfgst0G+jZDdDXnxcF69xZzatCxMTg8Xi2tNAfwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQc/opPpy/8cW9mN3euuHnAuCPhVMFAJAMJ/JxCJjXM=;
 b=hSXkdwMxUGpV2mQIOUAJIBxAnkae6W7iZlRvPPb7NfQF3ncYG8oGS2VTRWW/QJfbNwjHitstr6E5wgcQEgeV3LOXwrRZiAAdXO6WO8iGUm5y1XPW6avfWH2fl8lEMD5rzjL6zaElZd9F+uJE/Y0b7jMV97qmwr/y1r8NwnhHi9BoZxNzD1mtq00DRBB1vq5fPtftk/kv+uwU53lpCOfce9a/wwl1QurBnUqmmPwcbiqA9mXH3TxLTUR67ip+Gh+H4VJDTChf08UNKVcJe2hAaWi/ZAZqq1CLzw6ioit7BffHf9QISpkOxv75T5lu5GpwSR9wZFswN3iIqCBWbfJWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQc/opPpy/8cW9mN3euuHnAuCPhVMFAJAMJ/JxCJjXM=;
 b=Uns811ZMaavYZeZpCRKq3En1w7YtSDyYVO4zyhIAFXudVx1oktMFD3rHXth9A+rD5arTtK1klvBXJCBVukcatuxC6ddxhS4V8JGoALVUgk7Pb0cCNsdsDaEgUqkCP/8afV5mdIemVEPwbW3Kv3DggidkesmDRlSQC/a2uBPl4RJzjNL21gI1s64Yh/mPjOcwOtrG2PQxnvMBfOstm6mS+IxgNKU/PRT5bAxrr2MJTRaUMNCFgUviypWl6R/XnzqaaaMjYCiYF9AVcZtT3b4vB+cz5bjch8A5/EOg/ietvC4w2fCcWXsKuT8EePs2o2//QgiHTzR02tEJi2YqX5ofnA==
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Tue, 12 Nov 2024 09:58:28 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::f) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 09:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 09:58:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:21 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:20 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH v3 iproute2-next 0/5] Add RDMA monitor support
Date: Tue, 12 Nov 2024 11:57:57 +0200
Message-ID: <20241112095802.2355220-1-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5d9db3-c200-40df-a4d1-08dd03008ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIEkSl9kNjXRgfBCwZ7xQiPpicTz8o0S9vFZ91Hth193Nxka10CSEQr1E2Ih?=
 =?us-ascii?Q?89yA/3l95G2klf8Lq3hzn3FLoqNpZJOT5g2pw8ix+n6K7JzcCunPvkH43yET?=
 =?us-ascii?Q?6f73TgpT4JF1Yq4vkzYBIPvfaCqn8V7td+R5j8+93X+annrw1R/Nv3dXqtHu?=
 =?us-ascii?Q?/dvlopPk5pl0SzI4Gi3/1k+CwC1W33TohAoO3F66yp+7VngE2LuLGiKAHPdk?=
 =?us-ascii?Q?CrrL3opXwnM0mNbWzpmjCJmgB+H4F47mCuXHFpByUouF1JZUrHl1l0erTPzK?=
 =?us-ascii?Q?aMv9kXLfLcrc9gFUqxh2T8tc/7XciHC/RGFsab2dN0Q1fCwfTtBnyHN7qz7C?=
 =?us-ascii?Q?vl9is+s0QRHFAJQVds4VRH1rs6k1/pJsGutqF9YNoKNfiqV56/WT5aIEd7p3?=
 =?us-ascii?Q?0r4gH+htXheT/leJMz/R4NMKEjFVjLJvZOApTBboPpVIzzhlsumhajlAtyvf?=
 =?us-ascii?Q?dd0JlT2kbEKZ8MOHgnsfv/ToJ/zjq1b76ZVlXu8Sk6xx06R3bTM9guRxcgvR?=
 =?us-ascii?Q?G75Gm1xVPzm36l4AAfAZVDyNvVY1D9m1ScS/P46KmD9p4uHYqiCGZZjoUhoD?=
 =?us-ascii?Q?f0t/JDzvSGIrCEqNgo0ads5GPQEqscO6f3l/YIpdPj7Fvf9Xb2sRyq/ZjE97?=
 =?us-ascii?Q?Cep26L0LEcFMgEUgDYJe23QnipRMXfZg89DbmheIozC1O/qjCFC6L3w8AmkZ?=
 =?us-ascii?Q?fKVqcjFLFZTuk3z6JGw2o/EcMeigC+ZUdYEwt8pTzHGlld1vFTzb2GDVhDtJ?=
 =?us-ascii?Q?MYPHDtVHag/dplZMYIk8+xa2F7a395wQRNSYghW/RsgKESE3c6/mf35u2Hcd?=
 =?us-ascii?Q?A6pNgas89JQu5jyV+r6WsRndyAQvxK0f6Tzrv74acwOcmOr5LY3gyTaUoZyH?=
 =?us-ascii?Q?v7FMy4elmudjWD7H1JpsdMowyI7uYoQInXQ5R38QbJ/XVo6NJ/Hghq2FTX6Z?=
 =?us-ascii?Q?ltLFyGHYHVv9MpiC7seqUcvE3sO27nYtYXCaGbGkHW48s8tvPlHj9NTB92US?=
 =?us-ascii?Q?M43MJIwWOkIGLlGjTK8cY8Au8FvDJ26Yau+9u6KezL+NEreJjfzg0IvYGYvd?=
 =?us-ascii?Q?lIXrsa+WOhJIOFrcb3T6ZCnl7hlLMNlLPaH+/HJO7rJR49rKuJO7iXXTSO1W?=
 =?us-ascii?Q?xcvE47y7Hp62T9Svm5T+cORCAQDqykmrUpXkKVHnqKqpTiV7nsSEyiQWMbgm?=
 =?us-ascii?Q?67mkUrR3lRH7a7/ii4mPCSklHxtYNtC2JhFgTXvHKqsR1KldtX0iB5xxE8Pn?=
 =?us-ascii?Q?PTMjKlB1ROda8nsuw+bo31nOaBN4LcPiT0b5rBATTgJBRdvuFgNFwAHlxw5D?=
 =?us-ascii?Q?f4y/aTprwfAlx7sIwdT60GdS3hdlFCncCo8XSHb+ch58wtTd+FCpjgYfx0wr?=
 =?us-ascii?Q?E245S/2MfrPoPuEr8IBIYHsN9LGVDO4b+VBTdJ+BdOlLp1iMRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:58:28.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d9db3-c200-40df-a4d1-08dd03008ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

From: Chiara Meiohas <cmeiohas@nvidia.com>

This series adds support to a new command to monitor IB events
and expands the rdma-sys command to indicate whether this new
functionality is supported.
We've also included a fix for a typo in rdma-link man page.

Command usage and examples are in the commits and man pages.

These patches are complimentary to the kernel patches:
https://lore.kernel.org/linux-rdma/20240821051017.7730-1-michaelgur@nvidia.com/
https://lore.kernel.org/linux-rdma/093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org/

--
v1->v2
- Print hex value if an unknown event is received
- Add IB device and net device names in the output
- Add IB device and net device rename events
v2->v3
- Return an error if monitoring is not supported by the kernel
- Modify initialization of the event_types_str array for better clarity and
  remove static allocation
- Replace "extern int json;" with "#include "utils.h"
- Wrap line at 80 characters

Chiara Meiohas (5):
  rdma: Add support for rdma monitor
  rdma: Expose whether RDMA monitoring is supported
  rdma: Fix typo in rdma-link man page
  rdma: update uapi headers
  rdma: Add IB device and net device rename events

 include/mnl_utils.h                   |   1 +
 lib/mnl_utils.c                       |   5 +
 man/man8/rdma-link.8                  |   2 +-
 man/man8/rdma-monitor.8               |  51 +++++++
 man/man8/rdma-system.8                |   9 +-
 man/man8/rdma.8                       |   7 +-
 rdma/Makefile                         |   3 +-
 rdma/include/uapi/rdma/rdma_netlink.h |   2 +
 rdma/monitor.c                        | 209 ++++++++++++++++++++++++++
 rdma/rdma.c                           |   3 +-
 rdma/rdma.h                           |   1 +
 rdma/sys.c                            |   6 +
 rdma/utils.c                          |   2 +
 13 files changed, 293 insertions(+), 8 deletions(-)
 create mode 100644 man/man8/rdma-monitor.8
 create mode 100644 rdma/monitor.c

-- 
2.44.0


