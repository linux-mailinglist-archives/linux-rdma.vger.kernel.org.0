Return-Path: <linux-rdma+bounces-14463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0161C57414
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 12:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 470AA34D720
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53253337BB5;
	Thu, 13 Nov 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJVbjZ/o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B242A96;
	Thu, 13 Nov 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034256; cv=fail; b=K2NWfVxhXzQPPkiMvZ812/lNSuc0uxRPT6tT1uLZpMq64L1Y4Ecwb87lDuU2lcO6aXu+4Qd9Lz6QlijvnlazcPLaR2qFYI/EP8MKHI/fXz9S66TZvHwt1rzPc3GZyrKYAHCpenXXIMctr5APXebyqWELysQ3bjfM8HDOM092RNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034256; c=relaxed/simple;
	bh=OiUFxYmqGoq67NzkPkTDF1RF92tfxM4AXcjTkblZO6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tugvsY8G7RzOD8QfbZu4jAUVMTxgb5rp+IRGmQYEmnJxTpCQzLiHOyMDkP6q2cZh6f6SrVSg8cn1fE+g7kNl0UQF6p5DeHHRBww5osndJaixHdiC+Hp2W7doNElBVcoLQLtISk/ZSXK65VCzWpvEvOZBt1KOkOF5yXGQqpr8dY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJVbjZ/o; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdizPXdwopsIcNGh9Vph+ZnYijpQqG3aAfE2Hwp4r4fARGF3SCTOYOKYN0Yg9PanKpjat2f+mZQmEn40N2eGpOItHnLlrsygL7ou83N/v8hMvJiJiE1+uXKtPMi9VMR8vM6rcaAXMttFwmmkIKkyMDMbOUAAqpRt5Oa27OPILFTAJwQcs2ooWUWGJFjaaXlC593JWuWXhcjQ9DvMQLLiZfhZ9FKaa2weuyuchaU4OMGJGX/d2eW5ovTLuErgiD+0Er3Im+ctZm4yKAmMTX4rOnfh+Vh542YEusIdc3fiKSywNm9ZlhpRknQUArfmHqHHw8yA7+dzbNpqBW4x/M83cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVn19GIUGNtQ+tKX4RTyoT/XnXyh0sDLW3Fex7/T9cc=;
 b=mo8tQ3zGEAHIfyTzkh10UX5w8ZaR4HfjLn6jAs+Ce6Qjaa+IoZLw6fHFGnGfi08dCYD/jCnP8qLBGzguIEzY3KKzHTM7QP8ZT/pjNp/XtX0ejqiNb0cN1pFU4+rPdxpopUXMPBRMcylIOE1ceXVwhY2GeT2g4oYD4d5QbOW/1unX5SGdgr6RTmTzeeNS934sT/DZCGx1xkv00oiv5Oc2yFpTGfrBg54d+GiMcuzCusuljkaJHz6I2l0+sj+HL7ho/jSg/98sxSL/1xOfNHnaAG2JwFKn7SQ18ndF3o7oMwLjf3FMFBg/XET66xYdRA0tGl/RoqhZi+WznIzYYu2U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVn19GIUGNtQ+tKX4RTyoT/XnXyh0sDLW3Fex7/T9cc=;
 b=gJVbjZ/oVcaWcoSu5nfTPb4ROaVFIWeq0ubEj8Z56Fxo8mmlKgN+rCT/K2n/B+hKRPD3SK5xuFNBBRPGJJu1M5hvpDlx4i09vr6Wq8WiA/LzFokvZmjiDpCLMx38zYm5+D7hOAxka3rVnXlckBdPkW8sTg6W8E7XfHO0E/fI1jfeLN0c7BZDtz9owxoJxbiKZMoRrJSXn7VZVn/Lc9/tTD4etdB1MgJJFPlG1G+W96cYUxxM2bo9lyoSsbFcZjDat1UrgN/WCReUqz2GCw4ON6b8yX6fRNx16bKFSviIUPf3qb+NwWu+qnWF1TrO41sD9yf6uxJwGsRxaw3Z8aMMsQ==
Received: from BY3PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:39a::12)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 11:44:10 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ef) by BY3PR03CA0007.outlook.office365.com
 (2603:10b6:a03:39a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 11:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 11:44:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:43:54 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:43:53 -0800
Date: Thu, 13 Nov 2025 13:43:48 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vikas.gupta@broadcom.com>, <selvin.xavier@broadcom.com>,
	<anand.subramanian@broadcom.com>, <usman.ansari@broadcom.com>
Subject: Re: [PATCH v2 0/8] Introducing Broadcom BNG_RE RoCE Driver
Message-ID: <20251113114348.GC10544@unreal>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a08aad-f9a9-4000-63ab-08de22a9f54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AqnXUKNn4Uv7ABhSxsXq3DVHsNvGcLa3IE9+uAUnGCy74CthRHjak+D74oh?=
 =?us-ascii?Q?ZG3e2Ogd5tkkWFIRXTlKTiFViYQa4wN7U71Rsq6bzv2WUkS/3qWzTfFpFK6g?=
 =?us-ascii?Q?dMigZyt4P+tcUS5wNbfFW1iXlwjAm0v8bOdys2tUxmjERJimd/gzfL/6Sdjm?=
 =?us-ascii?Q?2r31BYbi9tmOd3PutmwmS2xph6JLZwYfr6gOjBf7i52DSCA9dR2dkGRFMEFw?=
 =?us-ascii?Q?KgmdMuBxl0o6LpLGXtVr3PXw7OaKXuJ9FesPSggm5Pk9F/LFprHXWR1oE1ZG?=
 =?us-ascii?Q?Ys0BO8MJc3a3TvteHAtJknujsGQpIU0qNZKmJN2yg9zqLu03cABKF4L/xzUD?=
 =?us-ascii?Q?0AZkQV0z9lwWycGKbzsC2NpDVSuXUgmtJ+8n8XNK5RFO/tgl4o8YxSFICVu5?=
 =?us-ascii?Q?MaZCtxWmlibpwzHaOJt9IN+Re0mnWNKwoKHns2kcVVuUIDzdDNU2Fazch7oN?=
 =?us-ascii?Q?W+UO8ImI7jdpFmXsdJleAp/c3sQePf7JbQn+NU9txvWCN1HqwmyqZGLPhX2A?=
 =?us-ascii?Q?txc6r0zy+T6ICn70qmEMbfIIa2x22m3QzWD+trgSYpxnqxrV3Y2SYlLw7ysz?=
 =?us-ascii?Q?gm2P4qlV0IpIa4HhHOaGU/KgGGjuXKciOXtrJt8clQHC78m/fNeF0KdEg5E3?=
 =?us-ascii?Q?r7LEjWBK3On9CXvdUEmXQn/IQIsFk1RKEiGi5L2IU/wfZ65x8i7oRupvukww?=
 =?us-ascii?Q?MbgHGkH5LigksZDSTRuy5xaO3eVJhzT3lw7156ij2rQisRbSd+3+CNbmrbRT?=
 =?us-ascii?Q?m1G/UARlv3xgZbDcxG6b1g6p7C2nUlO3CfA+CULCV7QZveKwVMYdGjxK1cnX?=
 =?us-ascii?Q?+MAWKC9fVL/PUB02qY8gMFTPVj4VVWOrRLnQ7tZIoaw4Ov3P4mCsoiBSWCYo?=
 =?us-ascii?Q?TNm2W9MMquUUfanvu/DhFyFpVxavq4D8tC8ivdk+NIfmVuH39YSmFhXjUV1c?=
 =?us-ascii?Q?YHWAqpmFNiPIY3ez1BuJ2I1i4BNaK7zzGurrrbjI+Y9eV3SNTm0Ow3IsI2Ui?=
 =?us-ascii?Q?wwF928Gr6ef994Z8IuqkUR8AG+kyEX3Nvg70DM6DMThJDUX6r6QgsAt+caJr?=
 =?us-ascii?Q?2DKV2EVri4LTMYMRiXMFV5oikYUz0jc0LxpcBuC3ovgHp0KhazC3ITXaOj6f?=
 =?us-ascii?Q?AIiBaZVt1NAoKzFilNs/4TUSq4gNZ+BJW9QIsUuX8FJ2IwWpb7QP96XIkfsf?=
 =?us-ascii?Q?BgnflsqSlilDjz1cjEqmD/v7ZBG5BPyDiny1k1ACJDLy8yzN/ekroo2Y2NU3?=
 =?us-ascii?Q?zwq0zLpyqy+p/jw5j+hxpTvTWvp9b6QoesPXi/jLVzW7p8QOXnvpVYhjbnqI?=
 =?us-ascii?Q?R2jHruwcvb6CZ+H2M4+/U7CXVNcsJ9wT4lodReNxu98qdhnspUNmlZDEi2K/?=
 =?us-ascii?Q?0z4m3ewLl+yV+MBrYIFGpoRB0d2zwcp0AsKWCxnPdy8rFLf6QCCA+B1WJFw/?=
 =?us-ascii?Q?17BRQLEYGQw+67mgNnCF/PaIj5HwQr4AG58XKwHbN/dIwc4geKhOJe3AbHmG?=
 =?us-ascii?Q?t3qDEPTe4HijYrc46jxitp9LrXqpemOQDYfxa9BGCQfhoYAVDwAatt4wi7GT?=
 =?us-ascii?Q?XVcGe04ApSKowTTGD1I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:44:09.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a08aad-f9a9-4000-63ab-08de22a9f54b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69

On Mon, Sep 22, 2025 at 03:42:55PM +0000, Siva Reddy Kallam wrote:
> Hi,

<...>

> Siva Reddy Kallam (7):
>   RDMA/bng_re: Add Auxiliary interface
>   RDMA/bng_re: Register and get the resources from bnge driver
>   RDMA/bng_re: Allocate required memory resources for Firmware channel
>   RDMA/bng_re: Add infrastructure for enabling Firmware channel
>   RDMA/bng_re: Enable Firmware channel and query device attributes
>   RDMA/bng_re: Add basic debugfs infrastructure
>   RDMA/bng_re: Initialize the Firmware and Hardware
> 
> Vikas Gupta (1):
>   bng_en: Add RoCE aux device support

There are some nitpicks which I wanted to fix while applying,
but it doesn't apply to rdma-next.

...
Applying: bng_en: Add RoCE aux device support
Patch failed at 0001 bng_en: Add RoCE aux device support
error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_core.c:296
error: drivers/net/ethernet/broadcom/bnge/bnge_core.c: patch does not apply
error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_resc.h:72
error: drivers/net/ethernet/broadcom/bnge/bnge_resc.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Press any key to continue...

Thanks


> 
>  MAINTAINERS                                   |   7 +
>  drivers/infiniband/Kconfig                    |   1 +
>  drivers/infiniband/hw/Makefile                |   1 +
>  drivers/infiniband/hw/bng_re/Kconfig          |  10 +
>  drivers/infiniband/hw/bng_re/Makefile         |   8 +
>  drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
>  drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
>  drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
>  drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
>  drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
>  drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
>  drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
>  drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
>  drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
>  drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
>  drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
>  drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
>  drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
>  .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
>  .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
>  .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
>  .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
>  .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
>  .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
>  .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
>  25 files changed, 2907 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
>  create mode 100644 drivers/infiniband/hw/bng_re/Makefile
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
>  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
>  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
> 
> -- 
> 2.34.1
> 
> 

