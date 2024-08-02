Return-Path: <linux-rdma+bounces-4182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DA945896
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E3B1C23731
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63861BF320;
	Fri,  2 Aug 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qhcgg8Nb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238D28371;
	Fri,  2 Aug 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583480; cv=fail; b=Ua7+mcPqFKl1SyfCOzmG+zDrhpW9OBDAeyM9c/DrpMtnM1k8rspGLjhaQ3GEtZc+7DV9ozFnRsWLXlWMMDR/Cp3drRDkYV07L/qDWd2iqFhr9BAT5KbfRBYuCtXNSDXwVSOeauNUJQCH6W+TcuUJsVLsFnIQO93tVjG4A3wa+Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583480; c=relaxed/simple;
	bh=GLCS6hvQfb99PSxoIkGCb8lodadOQydvFKSoKAMVXeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eYg2U3Dd5XSgYU4oNHBSEdSNtVcMgU3ouJ0K2vPpmHOF7QP9SRJ5nTsJgeI3AkPTYprbabXtEPxUe+Stj4IwkaYebm04mVx8wt3Ddn4rg2ie++iazJfrKQkDqTLLmCVswUqNYhcBn//h5BdhbVDxJIETeO4mdUX6hL9HScxSYxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qhcgg8Nb; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyBPtHxdsT3i1qNRp0RQozSXnTEori9bdWLmPfwNytTidowm+JKfrU3nJ3CkWa48IqAeftqSW0Xy+LmJvw8NISDlNWEKSI4LPU8zfs0+VMyC2QT6Rk5ih8Egw0C2Bx+7v5Yaq6HfFCh3AecFRdeBpy0sU0v4op1TvDROpNrM5IwnQYKSwSZWqg0hXIBgXUyhgcdQXSu6NfRd+HT4eEDiGq5rm6UMNy14XKpTlMIc5NlSMfnoenDlqLRjYGx6FS0QSNPG6raKmSLxbTdaSsAjQceLg4bjSh3B5s1j0ZpTF74slaaMWMU4TK7jcLyc8m/YkT51ATB0p6QLoS1AoQI8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgkMulJx5Xx4+gKPEyhnBEzB/VQOh2xe0BmJ0IpYjZA=;
 b=FVJYEDWVCIhEukqorT6enVjXW33OVIm7Uv56KplkU4mgKrFf8GpsbdYMY9KWy6ekyS8Fj0v/ppCLZZ6defIVQOGugmjyE5WSF4mJr5p51OkTr6Ot+nBuE8StRdi5vbGLA5U47poDGI3lB7St83tU4Wj/zCxVc+CoXndls21UBCzdsUOnN8tddFQP8tAWz6aw3xFNeNBs2vjppGJigOrldZkaw0/pW3SSUAasmjo4eN9TwE/uXQ9E8K84q/ZR8dndxpSZR1n5f1mIyhWK1/04on1kgxkelBqLsHLPFevKRpL4m09y6h40o1O0+8kpYbZBnq7OqhA1spTDukpguHqdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgkMulJx5Xx4+gKPEyhnBEzB/VQOh2xe0BmJ0IpYjZA=;
 b=Qhcgg8Nbpi71K+4PhpT0AwQtQAI8z1bf0OY3e1X8omBTE/terNUn5NZMVHkXMOrVMD8VVGQED+axmkgr0T/J5r+oK8DooR6skfQn5Ru1AeWuwtJVk+PUR+kl9vn8NIBlgKXegoWLy45vpPmR0cM/6NJAxZZDeTgMwx/UxMqWEmnQD7nj33jliGmVYFF8VTN7kc7VvxCbkfK0e0SgVLwHuqDGtoLRDfagKIYLi8DpXvf3L6NzBQyUVuqnQ5clWrwaXY7irHxyS1McxSA1uakVj2HGwtgH53PUspo31/pWsjulZvD5Xp8cWoySV6c6ni/Bb8AQzwPDKgihMfcf8Zb4Kw==
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 07:24:34 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ea) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Fri, 2 Aug 2024 07:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 07:24:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 00:24:19 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 00:24:14 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Si-Wei Liu <si-wei.liu@oracle.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>
Subject: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
Date: Fri, 2 Aug 2024 10:20:17 +0300
Message-ID: <20240802072039.267446-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: afe02788-d827-4f09-d864-08dcb2c42842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sKIsCWi4GoHG/W9ZbvBw/PPBa7jSp6OOwaPDchkY70H3we/nU/fX/whzRdF?=
 =?us-ascii?Q?pnZKWMocCQOuMSkEHXuJOqQX2n/vaHqtCprWe0W13uHFqs4xVSy6KuaZpSbG?=
 =?us-ascii?Q?MJQxVmV3OV0BVqIWCyttu8p7X9K6eSHoYWteC1SgNG4UnB6KnrjBaBHEZDu8?=
 =?us-ascii?Q?S0kEBXsugPwaeSLc6r27NCTSYA/chB5BWISMwvuSR+J7wsPZdMCOB8YLclfW?=
 =?us-ascii?Q?TXZTv4+FdG48KKUZkVE7mMZf/pyheS3jxcQjNAuYTu/rFTEaicbdFEQjjrjQ?=
 =?us-ascii?Q?UgZyfUQyNUh4fImoa7DXefVPRvjkwtha7Q5msY5up7VNeMwxgVH7Hbh6ZcI2?=
 =?us-ascii?Q?iIAYncNB38GwQSb9+b3AZ9ZbyFaBMKNE1v+0HYJroMAJdLlakrs78cBa+mES?=
 =?us-ascii?Q?0vT01HffvkMT71jzaQpY0W2EzzWdYpyYk/vAYFDQd4NRVIXiTzd+d1kOb0ID?=
 =?us-ascii?Q?t2cCHzj1N7Idv1jxP6SN52/ALEnSFs/Ko+5a0tvnmZvvN2bbzugP5/Dbe4rS?=
 =?us-ascii?Q?K8zEdYqlMAcMIRypkhltWCnY+Hc6aFlXeghaK7KCr0xaBL6I5QPyAbp4FmX9?=
 =?us-ascii?Q?0qxxaO8X0ENPc/ptN8aUHTEPgtaJFmhg5TXJnxjRuBkJM6+e/PpOrc4hhJeF?=
 =?us-ascii?Q?MSt5tqqmv33PPC67U6szD7fxWIVT3zH2EfgmCTS9ZlqXSKrvzOgWyt7D2uqb?=
 =?us-ascii?Q?SQikTibukXF8WjHStdoHnvq4J4qHmTs9Jvk48uewxtx97W37SwxI8flWaU3X?=
 =?us-ascii?Q?T9HeaiQoNhzMRnG7fei5Ikhu51i2ZLWgoBIKib1C2+PdEYVLJ+Z7RhcaQ59V?=
 =?us-ascii?Q?2IOVtImxjF+axrNlm+/TRtcnUwiZjVFVIOjSqCqOmbNmv1JLxA9K6qdD3MXV?=
 =?us-ascii?Q?qABIk2aBFQzn2TfVe/qjvzNrGHoiZR5Lk0AkXHHxroPaRi9q491PwZ5iMo9+?=
 =?us-ascii?Q?++2vodv+w1G2GmxQ+gtye7qxAH8roFBicQ1WN8WI6DCq8MKrBt/RlW8Ebqrj?=
 =?us-ascii?Q?ynDEuYh1OnUVLi8gC+5SVfVi9svwoAFE3j7136rEMJ4BWR9UeOpgKPRcGsMF?=
 =?us-ascii?Q?kJ87XkMIp2AK3kiFKG8IeSkruJTKv1CBBvb0qDKCWyWWZbiuZ+HFpK52ZsK1?=
 =?us-ascii?Q?AwU/M/pn6cS7Rjt7uI9QRZGxSqkwFteQdZpsv62MJ2AA88igVi+mra5c+PH9?=
 =?us-ascii?Q?Wv0c01mr8jk2YWZl6pJPx9xm09jSK0vkNkE5fS7yYK6Ju6Vk2GfZFHUmT5Ut?=
 =?us-ascii?Q?d7P/mWv0TRdZ6JyNkiAHwpPctY1yAniqEeIXBQcFbwIkFP9tH6a7WyczTern?=
 =?us-ascii?Q?8XHHSYzv92+PmU2hovmDFpyU2oQFOodFff9h7UJ9WxjVAmt4Xft8PhKtoCVl?=
 =?us-ascii?Q?y16g+GczSAf8Hc9z0rxG0qsISp3b7GDsufu3O+TCdXZ2ERcAqCHyobWR+zq+?=
 =?us-ascii?Q?0TlvEiJw8HmialALm4DemnKeJkNWUe+AEIzhirJdVIFs4TCOQ31pXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:24:33.6540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe02788-d827-4f09-d864-08dcb2c42842
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

This series parallelizes the mlx5_vdpa device suspend and resume
operations through the firmware async API. The purpose is to reduce live
migration downtime.

The series starts with changing the VQ suspend and resume commands
to the async API. After that, the switch is made to issue multiple
commands of the same type in parallel.

Finally, a bonus improvement is thrown in: keep the notifierd enabled
during suspend but make it a NOP. Upon resume make sure that the link
state is forwarded. This shaves around 30ms per device constant time.

For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
x 2 threads per core), the improvements are:

+-------------------+--------+--------+-----------+
| operation         | Before | After  | Reduction |
|-------------------+--------+--------+-----------|
| mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
| mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
+-------------------+--------+--------+-----------+

Note for the maintainers:
The first patch contains changes for mlx5_core. This must be applied
into the mlx5-vhost tree [0] first. Once this patch is applied on
mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
tree and only then the remaining patches can be applied.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost

Dragos Tatulea (7):
  net/mlx5: Support throttled commands from async API
  vdpa/mlx5: Introduce error logging function
  vdpa/mlx5: Use async API for vq query command
  vdpa/mlx5: Use async API for vq modify commands
  vdpa/mlx5: Parallelize device suspend
  vdpa/mlx5: Parallelize device resume
  vdpa/mlx5: Keep notifiers during suspend but ignore

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
 3 files changed, 333 insertions(+), 130 deletions(-)

-- 
2.45.2


