Return-Path: <linux-rdma+bounces-3248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2090C029
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03DF1F22FD4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A24A3D;
	Tue, 18 Jun 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cxHAtv6R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF532211C
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669472; cv=fail; b=oyLRnxqIsHF3DX4mzxrDFB5xVP7Hi5P+AecmnyTo8u3yNJgbMAzFoMDg37dKY4t8r9kDBvraebqqInQ/ZUj/8hhTxUK36cLpMKKqBVFEtiJhl/ZmaThonuSLCM2XnD3WENUnlpitQYwpt93r0cHaHXccMTwlmc4LLULaX9M8PtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669472; c=relaxed/simple;
	bh=DSetob7ihncurvr2xmXZnFwcWzUk3F6+2QM/oCbX1cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh6wWaJtCdYnM+gyr8zMsqGsi4akn728/Yv/Y7RmfJ0OLcMmw8U0vbzwseRd6cjCPYqvVEjZo3PpRXqLEVMI6hTaQVeN8VtPHo0jD1I7JS2YsrgpiiLwWRE3REwTeVVOcp4CUigcfJZ8GPCky5FeSk8jkp3Jj+g8O0lw9271RfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cxHAtv6R; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2jXWcaXJR5yrkB79kyH3/t+ile52x3aDtaphfDL5ZEfpFyZXVS25jlRMfvvNSssHhshUPwEgqrumVnH6gCtkEspAVuqrn8djALTxKMeknFirrFD6tOtA0gD2/K/thICAB02XThBg8r6Hggng4UcAlnph7XGwvNw18DHwjrGKbS/UaTnpzgc2k/O2JDbwsdDnT/i1sBBh1QPFPfeI8fUZ/r20Wf5AoKlU+RMphPfhfRGacfRrRK69qN+uwZDccad4e/krPUDgu4Z1OyqTceuWtFF8KjlCa5jx9TryQ46CvnmnDhHTDaV+JnuzUk5OC2NvxAu3wKWpMVamoURGh7B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKou4U3jOBnwOi7EJmCG8lq8qDKWl++jyBmgrZRiph0=;
 b=MX0d5epyqJ1VXv9XAzQ2mRHCtC2kK2baipD+S4CX+vJ3p7Nqw+Qjyeqv2vLnVpoDluaRQNnT+qqATUmI/kFvTze3vY+okDsxGxvW6yxpkq1jxsqGNmLYpXU8gjsBc3fZfDhJR8gd9XdUFqkqzfIPNAA4xkB0pqFLqtdu4BphcvG3tod6VHXaRDwDZJSAkkrMtgo1b7XPRhEe0O1Jb6zzpHbP5WTNUrK+SD8VNHjVNVLiAk/jBCwenbDHlbkS3iftu2nOz+9hggNNP1XQ1IRpqB/y95sAsI2eMKkR8FBmouMVBQi8U8C96l0cVpXxQDs/DNq69qrN/FTiwZdGRhP4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKou4U3jOBnwOi7EJmCG8lq8qDKWl++jyBmgrZRiph0=;
 b=cxHAtv6RWPwiC1p70SB/47Eh7hg6ERZGMd1OpUg3k119zUAyGvYENnLjaXBQLpZ1bRsPc584iMC43mBDruP4eWHPFZzD2tEZ5i15o7mWITlDCWiZCoX6QUSwa0lddHuJCdFrNi+3mao394N29GXtFJwGBI26jcC4msDqe83/iqH4a2+BOg0f/qichhpnige+ZI+uSP+L6ap7mBxewem6JG1OGTgwiJT23c1IxXDFwj2QNQoRVKxNSKtKX6sLYyLRa6W+3ekgxtoDOHOTaWu9WSYdCR+6gQ7p6Fxn5jYqvmXcCJPiP+Vgq+SBbY20KF938qq+wCOunJKYygBpoZN3kA==
Received: from SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::24)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:11:05 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::46) by SA9P221CA0019.outlook.office365.com
 (2603:10b6:806:25::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 00:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:11:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:51 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:47 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/6] RDMA/srpt: remove the handling of last WQE reached event
Date: Tue, 18 Jun 2024 03:10:31 +0300
Message-ID: <20240618001034.22681-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b63f65-c3c1-4063-8d76-08dc8f2b2538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pg3JMNxTxmFco00lFAIND2VWjNBN12z/KHj/+cdnx2Gpfq73wdEKLHa/XPJn?=
 =?us-ascii?Q?IVWPZ3ap5edwzvIMVmHF21SzOF/tnUWeEewaQFZdoJuSovdmbK7rOz8qo4en?=
 =?us-ascii?Q?Np0Qo2A2JggqvSdk/z7Yt5Ak5K7B8K0/y1H0/idpFghLHLS0zXnPf2TD60F4?=
 =?us-ascii?Q?bqPPDePYRxKVwSEgKWTUJWrFpjUYz4nEs0QoQ4YJ/QVcalHK0bDYybcpu0w2?=
 =?us-ascii?Q?bKZt2khN9kB1sJzzsQWQUigM3PMaO0QXrsZ/zFBI189T+fjCUOOljkBAkhRb?=
 =?us-ascii?Q?tt9luyqYZ5ApGMYUZS55/VjUOh/WmsjtWn4+9rOpaaf+uRi71n+4ODTpI6ej?=
 =?us-ascii?Q?7nrdLyi14TLJFRGPF+600HqzCDqoXqs3WWBk/dItGS8yEHK1HEH4N7RxDRxQ?=
 =?us-ascii?Q?8zbUkcNUfTybJfdGcyTvaARZg91+odHD/NgMo0ObufU7rgiGFin7inWok7pr?=
 =?us-ascii?Q?wUDbu8TN1m9ZTCpQQgFZ9zvNo6bhZR1gcNFctY4O7ndbJdyNKpopHOXiDZw7?=
 =?us-ascii?Q?yUaRhX1cJdj3z2/lCOI6Tzpwzf08ZfsLbkU5JP2ChnJcROtJJc3l3moGFEQq?=
 =?us-ascii?Q?fRjzztBlOZVOP/fS6XMMpfrYdVLTMFpDiPc5e7EB5k4anNWAxI+KL89j5dMA?=
 =?us-ascii?Q?cH4h0ueaH3QBHifB0DrJY4OXhw9x4B0dD/rVo/6y8ehCNGYK05zedsoHrzi+?=
 =?us-ascii?Q?v9kPfPDZs936LOI1A5uHwTZIA2rqYARBY6rVl0gvjSyz+5XQj24D2oPjHBWO?=
 =?us-ascii?Q?rXg6VP2QXNa5CrlfG9Xl6tDwd3qEMBk/DogU7gskvHCp97qLnXveb2kVpFPo?=
 =?us-ascii?Q?8iiVYmM9Y+iL0zE5n8k0o1JjKrAtLR7L5FwJNY3P+cpquMOF7khCIyc2CaDT?=
 =?us-ascii?Q?ce9vZbr9/HXeu1yfwsrb2cvZUZsvAAMuwAXoX9dcvPrJQLcKDN+dF2NWPNlS?=
 =?us-ascii?Q?rq0qj1AEPDUEegQzsfIPYOhZNQ+roaZzVAJr7jtmMzStNBpf82qBq6I9VLVo?=
 =?us-ascii?Q?ZgIc/PLoylXzBiCK/5uX6YKfZX0NznEaeOw4ClewldjlZVyVs1ddknB8b2JS?=
 =?us-ascii?Q?TWYVaOQrFl9Ojpl6OjzxfwCR6mZ6bwRwVroXQSrA3Zka4DfMO2BG5IcuVxrZ?=
 =?us-ascii?Q?cdeARVMpw43L89ecDLwyqiTwFxW+6dqX9ghg+VpW0kDz3FrDTfNFs/d/Ur9q?=
 =?us-ascii?Q?rNPTwM5Yw1qhmKgtt7A77qNZZx2D3zHD94/n2rc8YshTldNZDKknpNdo7zrP?=
 =?us-ascii?Q?DrqHvtOeIKSN5HJHymXHVxTo8V3uEDFTqog0DuAfRp+EP+Eorum9MIM1L64p?=
 =?us-ascii?Q?l61m/3tqFw5ksROOpR/WrBRvevpr4ClYpty9SorhVmkbr9VFJihQ/nODR4sX?=
 =?us-ascii?Q?iqUFuq9IiULoJRQqt1nRvHNNJc/ORqtiXMLf3TSnec6jqdcjag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:11:04.8877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b63f65-c3c1-4063-8d76-08dc8f2b2538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

This event is handled by the RDMA core layer.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..8503f56b5202 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -231,11 +231,6 @@ static void srpt_qp_event(struct ib_event *event, void *ptr)
 		else
 			ib_cm_notify(ch->ib_cm.cm_id, event->event);
 		break;
-	case IB_EVENT_QP_LAST_WQE_REACHED:
-		pr_debug("%s-%d, state %s: received Last WQE event.\n",
-			 ch->sess_name, ch->qp->qp_num,
-			 get_ch_state_name(ch->state));
-		break;
 	default:
 		pr_err("received unrecognized IB QP event %d\n", event->event);
 		break;
-- 
2.18.1


