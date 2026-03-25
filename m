Return-Path: <linux-rdma+bounces-18645-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFMUEjcxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18645-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:02:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB732AF2A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C12AA3058356
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B635D5E2;
	Wed, 25 Mar 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfh+p4N4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B41D798E;
	Wed, 25 Mar 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465260; cv=fail; b=X7uNQ7KdMQEX9SvHtUpN6nZpwXlO5mSV+vPkzTyJAOYZFFS4uY7G6DYNetax0FsAL72Ti7RuyARqQR8xdj4zo7uGUsr4CVZ+ca4xYLFEPzot3pC6PuzgyvY1V6b9MCEj8JrMLhWFnHofsvHnDNDLE9oIqEe5sxzSOISFcWfVr9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465260; c=relaxed/simple;
	bh=3JxhANRcP4sd8c9nPuJAoTiym8lhufZjNAFgUwwWNtY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TzCgO/WQssFmW17TIhYC6IcYkfk/RpzhROlJS9XBU5LoSlUm+gQu1GcRkCAlBUxVrJZy7dA3rjL40DpAnIag/jrC310xLOvLNlUlfA+nwlQaj3CxGzl8BUEfF9iY/T8gvTZ4etKwa8E54HG0y0qkXrG34WcxwEOR2LwXH5cDPUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfh+p4N4; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq+BwScT98JQs+nyvIpP8gyVaF9mRiUGA2fUdY4y/3hKNbxCSTY2VGt34hzA75gcydunLgrSzRLOYA2561Ulmhw63ZU3QBKwF3+NUZX5G/Usj5ihw5Bm7cPo+sGDFq+jGgIHihAIZf9XuAozBSRsTdZ85GGR4p3gRcZBDsqNOuIP5fwoXVxRSPtvBSyVD5cH1wEiGujmO1uBR1sIqeXzD7hi73hWPhDv4ZGx/pLQWMYDJo+yViZ35OG3j6gCfVVWnlIgtoPRQpTraAf6X7wpEV31z30EwLDp/iUf8dGuDud+8cx/ZKUxpjbSBSfoggzFZMk1ppQio39K6IGDkFeeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnx95iwWuDgMQxLdC+a/7WD7AQ44N74xlj65GgvyWV0=;
 b=agJKYvxBw6dWQKIlY3C1XiDy998KZDyb/Ysmwn1XtZmKLlu6RmvKOGI5d9EbAPaPyVdAZptQRLadcexwQmbHP8TwLLgjKH3L9eXcZMwy/mHIWGEGOguVxfNeGUx86Rq11qHueER00bOqZnD/vcJr0fjV23tqfQb2/byE6mDGPDi3+euAbEQ9h1yumeXYFCNvLcCGqWD6w2LrQbAiHopbDbbma1+lNAcE7SvCK+RUHdOAALWDjkCBkVuOWoMRoLlXaB7zrPXkFia5vYyKzljA9NIbRjN7XeMHCkfFr/G0k4UZ7pLI3P9MpuI5Bo3a/SYhTXfXPxsD4KlJMc+QPOoKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnx95iwWuDgMQxLdC+a/7WD7AQ44N74xlj65GgvyWV0=;
 b=kfh+p4N4P5WZKQTlF+X4f+RfhbmyuJC8ukdSg1NbptXlCTKJyCiOBTipRiBNZiLDDtuChBnixbv7HtvhCNtOsQnX2WPYHQKEEKjq1y/n4oD82Ht5PTRhy6PQ1YhoBo3lWq/Hc5MXm3inNxDGSIbfBbelmkJL1wPcitZT1R9N5bvGkQaFQ44EwP5Jp0U+Wc0PZefOEEJ1u1BrK4Il3aehIdKvNYFL90WPHyGx7/gRHarNBNMWm0qlNX47QPCNCJpD0UOKFTshSYcwQxPP/ykuQ9hWml0BIuSRBPM38rLkORPcbFYgKeeeeyk84bhr9jGavdSeceK2cGAr19jIKPZJzA==
Received: from PH8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:2d0::13)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:00:46 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::6e) by PH8PR02CA0005.outlook.office365.com
 (2603:10b6:510:2d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:00:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:16 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:12 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 00/10] RDMA: Stability and race condition fixes
Date: Wed, 25 Mar 2026 21:00:00 +0200
Message-ID: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAwxGkC/x3LQQqDQAxG4atI1g1otIK9SulCnX9sFk5LomIR7
 +7Q5cfjHeQwhdOjOMiwqesnZVS3gsZ3nyawhmySUtqyljs7xtV0+fGwThx1h3MbA6JI6JpKKI9
 fwz/k70kW5p4T9oVe53kBnhyiqm8AAAA=
X-Change-ID: 20260325-security-bug-fixes-6fdef22d9412
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=2347;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=3JxhANRcP4sd8c9nPuJAoTiym8lhufZjNAFgUwwWNtY=;
 b=cguTdmNnHmxIybJM149zh1r7GpfBAMhvpWY/vmYqTeLPx+dlv7bY8lBA+MEuCpNdxFlEWxtGJ
 Wzy9+XvstPqAc/9Bw/Dg2xeQoSNCkjbTpvEJKOUh9442n3TTdDQBqkm
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: e10fae15-665f-4703-94b0-08de8aa0d22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7d9P4DxBDDB3rQjMq1/SMW6chyMf/9I1Coh8eS+AaRpYqa9Yr4dwpSdvshhziEm6m1KAbcZ+bvPTl0GBNUnP9szEtXQ+EdwRiWaTQTh9skgYs2AHusmtoJYXhNqCvL6hUVOMSob01paRSLprRdXdYhRp+Ik1EJfrzPKja0y95Jx5IaNTpdh9HjPZJ4espJmtAAz4v5kw9tcg5vuAuRXwehGtNHGMugn87rbCJ0cKVg2dvsvtq89EdhlI1i4XZFuYdDIhj2w++Nt7ndRbIPOWYdfjrQzUYoerXbhWxZL0I6+rncqwwgEnV3CoCwLptsoTyWcIUrzntOYt+14lyz3CWjmgk98p5wF1ikByCBCpT74vHcKkYZwkWTxUQxuu73d7UX/652unhhPSUCTC1OGdF35jkiRqSUyxOPM5LFtnyC8mWRAHv4KzjH05mhGH1zKkWD3AYWbGr3bm6p+9Mtpd2tjeouBWnGZHuKCYHbt9+mhLxkBtHgokK3+sROcD0PE97i03rMoFwfabOcsqtt2MOfUmVLkpIDo1AiNXF/u9brdRVM3Xmyb9kiYKJ7SHV4gIgMdF1rMjPF6nAnW90eXFTyA42KMAiGUV/8odAi5nI8lhNyVJHEiXbJv9h0cBiPQ4fx3nvJnja5TyYkKWjBcfvw+s2rr0YZHnGV2QtdJ6qgHjwYHwGP4FGdLa4fly/pW7QdNR8WEW88qewl0uHB7NBDyv2il1Tq4Y0Gef9m6pe5FP46dE1K8W72CPjr5wPdbgU/vc/uFCYbfEJjE+yJHbjUZTY779zU63l4+nsCBOSYNTeRzB5A/Pb5MQ2ktxr3LV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S6UKOnGkLlaBeSswEN9+oX7XnTeLvamjSnNy61HCJvb4PgafwgFb2OIlmTzTsoT3pGPO6A9IzlVwGtejxGdem/9nx02cA+l/obNaQ/XnMiBeDqCTgVSmbK+CIiacSaup3AeSKl99bqjuxzglouGcXhM7mEVrmH4+jocQoHNaVMFC1tFqgEnfeUayLDUPZMvhOhQeOGFZYvpQHgR2vbKE2TRxMH4pG8FlTaQZFgZH4F2g1Q2tNy2H/NzTVd6cgyf+hGCIYJ5emrbhHtwvLHjOsr+ro6lIB1vK8gghGiMVmPdGs7YR01dtrgRcgme87uVHd03wYGtqX8LUsXvJ0E1oOXQDasKYFz9Izh8bzvujVL4gbfnpk90rTWuChN9Sc6BKTfxeR3OajkD+ovmFZHN3wcic/+7NEGEnTQQk4/OCks11jIxHUZS3ytwyDQtdrlJ3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:00:45.7851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10fae15-665f-4703-94b0-08de8aa0d22f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18645-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EEDB732AF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses several stability issues in RDMA core and the
mlx5 driver, mainly around use-after-free conditions in resource
destruction paths and race windows in concurrent create/destroy flows.

Patches 1-5 fix a restrack race window affecting QP, CQ and SRQ
resources in destroy flows.
The core problem is that rdma_restrack_del() was being
called at the end of the destroy routines, leaving a window where the
resource could still be looked up via netlink after vendor-specific
resources were already freed. Two preparatory patches lay the groundwork
followed by three fixes.

Patches 6-7 fix xarray race conditions in the mlx5 SRQ and DCT destroy
paths where a concurrent create can reuse the same firmware object
number right after firmware releases it, causing the destroy path to
incorrectly erase the newly created entry.

The remaining patches are independent fixes.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Edward Srouji (2):
      RDMA/mlx5: Fix UAF in SRQ destroy due to race with create
      RDMA/mlx5: Fix UAF in DCT destroy due to race with create

Maher Sanalla (1):
      IB/core: Fix IPv6 netlink message size in ib_nl_ip_send_msg()

Michael Guralnik (2):
      RDMA/core: Fix rereg_mr use-after-free race
      RDMA/mlx5: Fix null-ptr-deref in Raw Packet QP creation

Patrisious Haddad (5):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/core: Preserve restrack resource ID on reinsertion
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()

 drivers/infiniband/core/addr.c        |  2 +-
 drivers/infiniband/core/restrack.c    | 20 ++++++++++++++++----
 drivers/infiniband/core/uverbs_cmd.c  |  9 +++++++--
 drivers/infiniband/core/verbs.c       | 21 ++++++++++++++++-----
 drivers/infiniband/hw/mlx5/qp.c       |  6 ++++++
 drivers/infiniband/hw/mlx5/qpc.c      |  9 ++++++++-
 drivers/infiniband/hw/mlx5/restrack.c |  3 ---
 drivers/infiniband/hw/mlx5/srq_cmd.c  |  9 ++++++++-
 8 files changed, 62 insertions(+), 17 deletions(-)
---
base-commit: 6edef31ef9004ed51624246a04f7f81112f485b0
change-id: 20260325-security-bug-fixes-6fdef22d9412

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


