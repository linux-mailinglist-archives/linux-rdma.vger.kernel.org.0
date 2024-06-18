Return-Path: <linux-rdma+bounces-3245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C390C026
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC9F281D1A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AAA3D;
	Tue, 18 Jun 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qzlbC+GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037CA368
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669458; cv=fail; b=gg8fcTicspZA0riCzmEQy2aHPwl5fSUMVYzmeRvenMaWepd1GCW/IhQ0B2wXSNAxS/agY7htoRa3iQxgLyHwDDg6GBvFes+gvOmuDPmXNtJW0k/jTdVs7JSkzzDJmeXHD3vxESCZvF74NQTupTXEqwkm1SYxo6qtB0rThPWVQwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669458; c=relaxed/simple;
	bh=1omklRoL5Qy4LsCZV2bB0CW0V45v4qaSKZEbt2BMUkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZgRzIaEBLFxOR++gUC4589GQXqq2IMeoQfvy2ne+YeXvvWfdqj2DCBxb6+hKbB2XKGXLanUq+ES1xF8RChoOF/j9wlFvOfnj9ny5dZyc+aRyZphmc8v7yksyZXJiT+ViDOyZxbRik1k9JNYx2jcYsh5OCODgkNCZJ0zXmQztxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qzlbC+GA; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoCcQe4pYBL1QSyczz593osSzMKg33JxbZWsavyt0q3WpUP8oCISWjkqI4NBmjXsV6M5CsKPXDqE5FtROdeltNvbthU14j0Y7RBtMmdk2io/CtU2dllV6MSrDIUlOMG6ooliONVTcyix2axVYR6BQLnpNmsH4I3aBolWeeXZboEKpaXQkpdZy4c0HAL4UUYMxfWu8907HJSCgEtAsIuzELTkWp6INmlyOA614qAshrqKddp+qbEhStt15kPgLF2d44mRt7g6y4VVYLfp8ub/R5Yg0wXHt0Qu75KnZlLQxJyjR6K8ZM2UHZUa0wvIHtuhsqECO0DxpUgtG2PO5SwC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT1jtiCNj0jDBElJurGLufTeJKAosGncGhPCfxOUxXg=;
 b=CUK4nh1+WlOiVrwNpG+DE/BgPem0lELbzXQ6gFHzxCUlNoHG/gCvhW2bFDNopn7pPwhz3x+UZWeTaXnE1CmNCymu4ZlzKFxtQ3fpOTC325SFirL3c/m1xo5ttxGi96DI3JkAoAa3h6NTDREoxtkoRhf/SqVcw+7BXddeW0yl+4RaGyZ/oS+Wh6f2D/zfkmyh4VkA+ymA4A+IA4XTbwjX1xJUSp9CZh6sJmm0IEcF+6+eq7umEbQM1MIUaq58wmE6jxI4qFRnIs0EEPwHMQjyw37Vu80x+PFro9Vr+rXH1nzstyx7ULgqDMkjF1equIkGf1Aewf/boq75d7LlrnnjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT1jtiCNj0jDBElJurGLufTeJKAosGncGhPCfxOUxXg=;
 b=qzlbC+GAB7axx/0o+wpXsvsMvggCoqZ+KCHjRrQZbA7Rlvsr7O7x8SY96od7zQ3fQOJNQGoMA1XOX0kon3BcB8cONvd6uN5Z+V0NoAqjVKVe2RhWZU5DYmyjbeors8yoSsBTKW//cBB8vsQtWY2MNZCfD7cDDADzlUqjJ6cl+fgriyLyqIntTamh7hIR8KojtsIVgaoxA3YjLOAGvrMd0OIRrrVKtnCBW/W9+NHIfMs/82YQpynoneId1zApZU/R0/6D/cydjog3VWfaZrz26JUTSlUjkjroyM/hlSuiQaO05DMVmLKyU9lebUdw/AmYQ5cGS8fzPsJ3eKYjFbMDZw==
Received: from SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::27)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:10:54 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::4f) by SA9P221CA0022.outlook.office365.com
 (2603:10b6:806:25::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 00:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:10:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:38 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:35 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/6] Last WQE Reached event treatment
Date: Tue, 18 Jun 2024 03:10:28 +0300
Message-ID: <20240618001034.22681-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 868f9a52-08dc-414e-17fe-08dc8f2b1e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZAhOoiQ1R8AyvvQ9a8gaZfN5BDqG7IhA0TgFTzYRAbgIj2zBJ3ElxmJvDRC?=
 =?us-ascii?Q?onpREayiZu/JRh7+Gdpl6TpPIleybDo2J8vrgqdl5BV1sRHpx/kzlWXpyiPn?=
 =?us-ascii?Q?TJHa7hGJvFRIJYfPWqxeAaOVQoUOknk/z5jQgLXA2Dx78vSaqUYJtBQWDKLI?=
 =?us-ascii?Q?GtOHCoNqDk9OMhsCQ8417nW8oCJvyUEWr+Q2MLjgpsIYwpWmRToMjk9GmOAb?=
 =?us-ascii?Q?SoCgh7Lj0liThkmGZN5k3M0WaXGswfQzVANlUkLUfcV5A8sRt7nUoX6YfL9y?=
 =?us-ascii?Q?BF48eBOu1Md3Jb5Z9l9+ygBgRRsjtv7/s4G5qH+YJs3CAtSoT3kn0roNqOrP?=
 =?us-ascii?Q?90XNj4+sLjb66fq2lcUjdE7kTSKH/Vn3ks/6lzzO1yfzPomIjVziQFypSv+y?=
 =?us-ascii?Q?NF0F6VO23KFCxMyOVrhQEA7a/cJrVMUW+jAAGa+aoOg3GsvmO/0ilfnUjc7W?=
 =?us-ascii?Q?0N/zane68ACvNnUX56kIbVWCoizXF3i0pGKtUBFaZpb2YVtABG/f9uWn+7YM?=
 =?us-ascii?Q?MEqw2IYnhq3yQrU9dPwn91qy124+hLEkufPix8qQa1ddRaARCX2Mc2BAvXrX?=
 =?us-ascii?Q?7iBmAKZOHAZDV/2+U4bjD2/ZBcyZv4ufzyUKYsHmL0M2FcZXxO55Y8rxfzYs?=
 =?us-ascii?Q?uWvbqMW5TAd+PqIwh7tXkf6merI3ZHLNOGQYMjpQlm4+GYm8gT0GD2CC0lfL?=
 =?us-ascii?Q?/TE2weicoTEvoo9YX3PnXww+egNCThxfkLUE2lcumickwcQw1zTM8PVm51ef?=
 =?us-ascii?Q?KfXpAAtCGSe4SkpIPJMlkMdGk+eD7ZSHgX8nSuzbbh98RpO7uqSVMzTR26hg?=
 =?us-ascii?Q?mzZPAq2/eQ/4FiFU3WtDNVw9JOBsz0pRwMPqk8CbAxaOP4KeAv8uWHYpDkk/?=
 =?us-ascii?Q?Sdxeydle6YsR18xWQ47omupV8pXXmaugJGleEupZx69Z+ho42mQJv3aWwog2?=
 =?us-ascii?Q?WYaJiHCPekPbtaRUVxzxAIOK2qQBinqqwGmV+O9ixYzIPH9qv+pA4ggwJyZN?=
 =?us-ascii?Q?e9EdAYpE8ZdlNM4atX/4IMSbibLjHhmRJZ5y+CXXMhNgno5Sj9ijWRIt4D4K?=
 =?us-ascii?Q?tKENG8xkJVPtKcZ98vdcdsr0+0Fc/XnoVS4gDSZvXVsJtD+MRbXcMnHzJYaD?=
 =?us-ascii?Q?dZRY4UHZL42cHhMda7+yQzDE2t0aJeQMy2GxkRKOuHJogIW3D3oCPHG78ZXK?=
 =?us-ascii?Q?pKveHDp3UM7DjDAxDOKyy6ahcmviMFr8+z/C3b4yo36B4WssRDtnv1nqGzXO?=
 =?us-ascii?Q?zM69PTKSE+azJIbW2hi1xPKkWomkxSPRfYS7pQeSZIbsUMYibxkbMQtdZ7Oj?=
 =?us-ascii?Q?1VKFeQTEtSMez6FR/qq8oeK3Fl/5hJK0B010htPifUOajAWVRLFox4K4JdZv?=
 =?us-ascii?Q?jIZCkv7tjR8Q/6dz/6g61ER+NNJEVLCJQYERdbNuh9hzWhBK2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:10:53.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868f9a52-08dc-414e-17fe-08dc8f2b1e9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757

Hi Jason/Leon/Sagi,

This series adds a support for draining a QP that is associated with a
SRQ (Shared Receive Queue).
Leakage problem can occur if we won't treat Last WQE Reached event.

In the series, that is based on some old series I've send during 2018, I
used a different approach and handled the event in the RDMA core, as was
suggested in discussion in the mailing list.

I've updated RDMA ULPs. Most of them were trivial except IPoIB that was
handling the Last WQE reached in the ULP.

I've tested this series with NVMf/RDMA on RoCE.

Max Gurtovoy (6):
  IB/core: add support for draining Shared receive queues
  IB/isert: remove the handling of last WQE reached event
  RDMA/srpt: remove the handling of last WQE reached event
  nvmet-rdma: remove the handling of last WQE reached event
  svcrdma: remove the handling of last WQE reached event
  RDMA/IPoIB: remove the handling of last WQE reached event

 drivers/infiniband/core/verbs.c          | 83 +++++++++++++++++++++++-
 drivers/infiniband/ulp/ipoib/ipoib.h     | 33 +---------
 drivers/infiniband/ulp/ipoib/ipoib_cm.c  | 71 ++------------------
 drivers/infiniband/ulp/isert/ib_isert.c  |  3 -
 drivers/infiniband/ulp/srpt/ib_srpt.c    |  5 --
 drivers/nvme/target/rdma.c               |  4 --
 include/rdma/ib_verbs.h                  |  2 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 -
 8 files changed, 92 insertions(+), 110 deletions(-)

-- 
2.18.1


