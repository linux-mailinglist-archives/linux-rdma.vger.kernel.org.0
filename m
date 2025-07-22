Return-Path: <linux-rdma+bounces-12394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF59B0DE95
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2033188CD4B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310122094;
	Tue, 22 Jul 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t971UOnp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605C2C9A;
	Tue, 22 Jul 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194273; cv=fail; b=Td9159tPtHevKbC0+S51bwiEdBzceIOsLn/ADkQbDDtV3GoH0z/dg4Alxm7j14DJgS01kRAZ2GJ/TZItEsVXO7djl2NGVC+YQEvCNlIhe7kyyZ6nkoj7jc3fdqKOxSf9UvgMhbYE+v/ND0bPNxr+Kp8FeHTkM3Sb3fqo41daVmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194273; c=relaxed/simple;
	bh=aPLEy6o+ZvFVLK1tYd78jRU1+kRfI+jFkhfz/YSMMk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f59yEpyyNDhjv0haa25CSq7NrWPQIpOqsGixMslyinwd1zhow7CpmfA7BB3mbaYXVBj3fzHCFwAlqIeb0j4uA8jPDHGBnYYQhGzQ/I/A90Z/VnpIXg+G8oiMM6Bl839LQ3OMhsr0zgfuuB5jLh2z9LfyFpAfkqNykDXM+Vmweu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t971UOnp; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4W9sdG+2+wXh4cafZPMUC5ZSa0d8nSMoOfKL2k24E1x10Uy4qETJett0mem0Dvlu6lYVyQoVOYZoXyEmM8qZaC1wamU097o3kZY1r+mJHHXs+hnsTUfTQp8zOf+0sjNS82RjzIORZa9iHj4cyJ0RHQJPBYpDOHK7BflwgG5sNoPee981vW97xSgt7OW7pd3MV+ELx6/2l/qVVSKiJtvAANIfRwYdVJ/NcpYCwP30MDzgwF30hrIOhTZhn2SyvLt7JILZKPANgemORB+jXr3xjv+GGA4rTl9lbIMXNLKlTXkdHNf1L4to/794elY1ZmPI+9L1tLRGkQqTRHMcPw5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZOyl4O8gQdrqZAL+TZeqjdHP/8irEd82LiIvk41xDM=;
 b=cocbrL7DY8h5CUjR/yowuZdXwiuyztRLgbw7LqUTCKJlbCA0Qr25A4TitupcMSpk3u2KtosjLkck13YFDLbTw+s+oanK0tojgv4/FhYHOmcTLnM/RE62yFFO5jRhl+ULNpNHF5IRnDWw6192R8K4Pez/pfe3OoGzg5vRHsTxOdVvu0XVrA8zbw0Wqc/8eZut28s3BgOInMSC3wvQvxRn+9QIDcmVQ3X4Yhn88HBJRZX2ZbD5vc1TMyH7jA9/SyNpQS6Axxr3uCdlhVSNJkGaIsho0YjZZ82bm5WH449CODXQKmyoz+rR7fzd3CoMrXMUI+RN/H4KSCBte4gbCrkLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZOyl4O8gQdrqZAL+TZeqjdHP/8irEd82LiIvk41xDM=;
 b=t971UOnp2ur55YwdkSrwWxuD/db2JrjH1UlaAycr0hVBkDOxfp2MerEXrITzCG44xTQ1oj5qy63foZO2k+UfNTpf+kcYK3gu2mOsleYK/UUw1doK8CJYfVW9ZRUImjOYr7D04Fnhdd86DQpxr4lAGrMgkUFr4TJ6K5ITYcKRUNTInt574Ut6W+KoBHpL07Y/9OMn6Nn6TqFANtx9JX+WBVq8IlRFfAMlPzT8+aKuKh1UaOn8I9nXoc6qkJ2RJymJ0NVnfcw2Ld9lQPGk3J4+haKF9SOzxt8dnWqExjaVTqiuquu0NmzHbc2jW6Jy/LU4iI3yB+OPtw6GGROMuOXVZg==
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 14:24:27 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::23) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 14:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 14:24:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 07:24:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 07:24:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 07:24:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 0/2] net/mlx5e: misc changes 2025-07-22
Date: Tue, 22 Jul 2025 17:23:46 +0300
Message-ID: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa0f882-b4f9-4c67-73ac-08ddc92b76e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRblIouL9PwA5/vBCQXJaZ7SKxnL8rwDIHfs07K/B7i/XKfepkNNG9X7duRZ?=
 =?us-ascii?Q?i3T5FcD9eR62dG+oDZ1Y5T8wRhtLa7iFdbUOyCN+UNMhoZWT5IZN1OMx81bh?=
 =?us-ascii?Q?nIDtzAHip2la8a8/vpDngJv4UlMXGS7EHtn0rchs/Tx+RelENpfretEqbMyQ?=
 =?us-ascii?Q?a0dDt7METw4ofA6Kjx/udaQvFqFAxmEJ3PUY2zuXnAXn8zNS0DG7sGvFteUi?=
 =?us-ascii?Q?oTxZKCQ7L/Eq7UWIMPCtTvmbXzY01jfri0n/u08zzv6cC61Cmf6RLD8Myu1U?=
 =?us-ascii?Q?PldqbP6wzjM2xoqkFO3KCqWNZq4sD6DHryoxc2yLiG9DfX9lhIJwQj8dii5x?=
 =?us-ascii?Q?7tHskITP/WnHEjApHrcdq2tglmth1UQArUMiIKmEhcAiAGrV5y7zQQDZDMIu?=
 =?us-ascii?Q?vzdUyKeApOoidkGH8zelYMF7kia44fJB7ZMG+DiatJlog0kFlJ7WgqR40TVv?=
 =?us-ascii?Q?1NX59b/m26MYk+C7Z76E9yAAg1O0MeddHJTThUMewBIXtqxdzfJZFc6VOwv/?=
 =?us-ascii?Q?3dP+y0sZhdsFPAm9talxiZQ8mbvRLjMg4MMuWfOrntMeMtj2rppdJZgWOAjd?=
 =?us-ascii?Q?VRtruzUM9oqiMVQ7+1xEk90K7PfK8wNzNgOkcHPFBVHTPeGHceVL/1C/u/kZ?=
 =?us-ascii?Q?UpddszGJGKMMhL14hFZ/B+asSoasvyXDTX+ZmdU8MkOXSjXXCMCr4/2e4euF?=
 =?us-ascii?Q?L2W4mqeWaT3LeyXUaVoXtcCVDRAvDdOHB3KwL0rrQsvrz9GzNYAoz2W3gOaK?=
 =?us-ascii?Q?m62lgoE3g1Z59VsPwBxCNHiX7dN7Jr0j5qCsBt16MqfvlSceDPVNrJuV2Sjq?=
 =?us-ascii?Q?MXY900sg8a0P8GlkWpFjUVqplz/yHJ4BW6FGLTtjWNDvzOI7w1y4AQOszPJN?=
 =?us-ascii?Q?FSHP5dy/1GYLaZzlFLbxISXyN27a9slUo8Ggho2zTdwPrIAvgb/ABxao5G7l?=
 =?us-ascii?Q?Q7Q4V60ox+O4HNaLPcUOd5qrz7xcUkgLr0u5EWXwDBJBJyRO8O4lYCUuzSY6?=
 =?us-ascii?Q?qT14I+9gxt/4oRsuIOFjjz+hxrVGLK7/gN3Nf4GVpqnG63qN7gRj0j4TQf88?=
 =?us-ascii?Q?4ysA6+hAxRrLQAP/Qu1CFPShTNnDEvuBEcpEA/RJJzJfQz+/fk3Y/NFjZp+t?=
 =?us-ascii?Q?keMhfLorLPmOOguP/9KuLN4+0trlMhb/MMUuTJYhOPsUW+d8N9MAXRfuuXXD?=
 =?us-ascii?Q?oqBRkvjrh7sA77SIf2EBWDh7jsXWdTaKbbPntZg0PV0dYIbUp9EJ5k7BI+Tu?=
 =?us-ascii?Q?/XFXMGuDCaNWO5Sq/ISJ4fNkYsaR2l8jZ2A9oBapYqAhtE08S8XledVthMIW?=
 =?us-ascii?Q?2/1BYehEBJBqqa/4+1RHfIad4Gkp7TVP9hv1iTKd6GLE557E35YwsRXMJS8l?=
 =?us-ascii?Q?CzVjA9//nJ/57jdL9LrlVrFDETbTDsOGev0P/dj5zg8X0hgbUWnnHTo84GUU?=
 =?us-ascii?Q?ZYfBo/ngRRcSrr2L/R3UsOD9eTXcZOa4L2LMVDdbzTj7YWe1ZhKVd3qYO1t5?=
 =?us-ascii?Q?nrQ47PpJ2j1NWbnYYcervf8GMb3kl+upabn8fnsnVGrVMS3hposFzlVJjA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:24:27.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa0f882-b4f9-4c67-73ac-08ddc92b76e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

Hi,

This series contains misc enhancements to the mlx5e driver.
This is V2. Previous one was deferred, find it here:
https://lore.kernel.org/all/1752771792-265762-1-git-send-email-tariqt@nvidia.com/

Regards,
Tariq

V2:
- Fixed RCT issue in patch #1.
- Dropped patch #2, the same as
https://patchwork.kernel.org/project/linux-rdma/patch/20250711030359.4419-1-yanjun.zhu@linux.dev/

Alexandre Cassen (1):
  net/mlx5e: Support routed networks during IPsec MACs initialization

Feng Liu (1):
  net/mlx5e: Expose TIS via devlink tx reporter diagnose

 .../mellanox/mlx5/core/en/reporter_tx.c       | 25 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 82 ++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)


base-commit: 3fc894728fb3a0d9282e81247b68c07468fe2985
-- 
2.31.1


