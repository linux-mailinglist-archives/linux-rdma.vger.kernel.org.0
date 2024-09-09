Return-Path: <linux-rdma+bounces-4840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AA972184
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B070B28408B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82117C9E8;
	Mon,  9 Sep 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+pCbjDU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D42263A
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905142; cv=fail; b=HYtak5cygVThX16XlHbrpGcTRO5SLIcTbAXuz+iRqdyEBTYundRC60MqXry3bZt0uHL5V0gh2EB8t9vjA5jW6vhG+iWI0139XyxU5AlXSP3r6Z4pRxC/6bR+mFzm857wz4bfx1unIdaPBbCRN1FnhD2oLDIjRzLo5bVoHh2+tJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905142; c=relaxed/simple;
	bh=XKXoFo5RR6YAZgbTWZZq5Na2pyIcqZgN0rKIk0+W8JE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtJ9I5LAjd5a0TGmVQi5okk/meg1wiOqJL9YifHwoFvSVwjUdA30igdP2n5Dt0kVbZAlgw40O0v6+w+3+Yya5PupP5xqDpVBwgzUGeU3HE0bREYkPpTUcMwDfnD7zYO2RAHLl7QHJ0FUyzdmUwGxPJQ+7wxGTNyhp6QnSPe7TL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+pCbjDU; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awcoNkvqaHSFSa6cYrpXRqJVffN1OU3m01W8rvViBoYRtWI5PygpX7ScZOIId/RG7dE3ib3O0oEiEqK6IYdtMPQK+bOE1/+sV54wsr8MvcdM6XF8DthNFcUauIlctMskNC71FMxc2A06t+7wtQYIsfu6cr/OY6EKiv1AODCXk02tIJJvae7bTkR93WvM2qUsF4hW+QUY1H5bXvjOK6otIfX2ieECjkpS1AvXO6JzMNgOSZyHveWsU8C2G0FGPdUHDLcQ9FF+ZvNfobinR8+A3nxR+f3jnieeKWlamRei73wCb8DAnd2iD4ZAYP9tHeAipi6Ddzqu8szbcEblMAI+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKmPd26/VCHmQzdcjo5XfcUi5D2r0RzfShZ1fp3KDJk=;
 b=jTuNHPN0NjUAY2d9nHAfLJAqhS4zj5CFbzqv/r942RtN0OQymCtWnU27Dgf/d62Fl6ITFr1dSIg/LgOu+ZLeGSjGsHEEk9UC6I5rItE6mOAjUAtN6EWKQNFkSekrqKAUJkhO/hWjtnGNOYpBL4mayIw+hHcWSo3OfOvLIAsgQmXvkIJp5sc21USKS4trNhQpQt4lrlfqPTidoUaqPJLLke/Z225jUwgwgtjPbdz+6HivDXN652BKJKMhORb1R4vJDbiRSMz6gPbf2ebAER1fP/98/fiIQHp3dILMl7FkzwcY9vB/5L1WiNBOJUAO5Q1lJQYqCMGDjaX8oOHdEKddxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKmPd26/VCHmQzdcjo5XfcUi5D2r0RzfShZ1fp3KDJk=;
 b=c+pCbjDUJUUWKId8AVCeijd+8Y8+13QG0mIiE32qrn0clfsRdfMuswm/KYXraEQ3Il4HYjYxFIQpVajxIJZw0QkKQgTX0L6cAhk5ANTR2uvnsTpbtjtRcocJ+b744lDURKSeOv/GH2F7O4xH7KdMMdIhWDx9f0kqqb/ehuD1Y6OVct6azrmR8O2YSE5+zSMc58rMCboZcxtzDZj3xLw2U2qhZ5/Bn7PY69KO3ZPvT+mw6ouTLuxI3hU8zAqH7LPefbAKjng1r1LubLetMDig0m3bvnX3KW+8KlOMkULbdPoHl9aXzuONTA55wqijlmaRMydyVx1KzCfvdbmc9OuqJA==
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 18:05:33 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::4e) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 18:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 18:05:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 11:05:16 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 11:05:15 -0700
Date: Mon, 9 Sep 2024 21:05:06 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>
Subject: Re: [PATCH v3 rdma-next 6/7] RDMA/nldev: Add support for RDMA
 monitoring
Message-ID: <20240909180506.GW4026@unreal>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
 <20240909173025.30422-7-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909173025.30422-7-michaelgur@nvidia.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a1c210-558f-437d-7f41-08dcd0f9ff1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AiCb6sTOIyFyyzZy9mHOHCsYR6wQrO7PicM+79nhl6mspae35kpTOV3eDWOF?=
 =?us-ascii?Q?I1Wb5GX75tERvaB94l220XmEvcS48IZT84kTsLpKMUPyEfyh/8bLg3oqBaz8?=
 =?us-ascii?Q?OG6+7GMBA5zsWiNElBUHQajpx1njrQ/eicL8SjfwZfGWIkG+/x1lwqHBVsnS?=
 =?us-ascii?Q?Z3pf1yt9zjgBU3WbpljKm2NKCqAlH5UYF/QagpYSESOQwnDUG9Sgy5szNgh7?=
 =?us-ascii?Q?b6nfdJZ2LbgFXtdDaarwJ3tH8VZnbmPNz22TOAGWaf3rBO0chkJuHGr0nIgv?=
 =?us-ascii?Q?DqtpL5giCx7Hb5hn4+7kP+aSbrU5NBCngrGNBNRUztMXxxOVAm1eZK0RCovA?=
 =?us-ascii?Q?cRKFqZAWhg1VtWqfgwihOBCXOM+a6OcjBAJ4phmrRt+hyAet32FR0ukDB9F0?=
 =?us-ascii?Q?GVj9vWK1YTurh+JPMp7GkaGCntPAJrZTKV8GU3nXsNetFy2NwwOFC5byyTh+?=
 =?us-ascii?Q?KviozBqfOv7YyZqZ/CDznraQisF6W3VBv14Rx6vcdfuecAjnauClY1ztOpQA?=
 =?us-ascii?Q?4t3QEbVBmPoLzaVwTReEtzQ8i2sIUnbThOQcaswgncllHE4vKDZuaSU+SIsI?=
 =?us-ascii?Q?ph9/7bAc4chRZ2K4xpWHEpMvawwSKTNWuKHkh8S4m1AxEY3iEhktxkUTsQqq?=
 =?us-ascii?Q?CJXLEg6mJVZ4RRYA+NNCYvipVB+2YeyaFhzaLBS2T2UAorCnF05QicedF7Vg?=
 =?us-ascii?Q?ZHlZNqa2sV7cyJprFLXknnjI54YKBSl7atZjylQAtQvs2zyXJ0NSTLFr7vgB?=
 =?us-ascii?Q?iZ3/HPfP4Fgf3Kk30E543PlxyJLkL1Vf20ZTvXRBXXiM5R/yqVnOk441PI6q?=
 =?us-ascii?Q?dNSdO7RZyYJT5UfvkKcVcFzgf1xUgKlZyVzqb7ubl9wyhlVt1SCDH6HEzXIr?=
 =?us-ascii?Q?2vidrU//JOCTdlDOtaIHR10ZJZaVP7vB60kzZ+mFQlS1HKKHWA2Fp/YEQdfR?=
 =?us-ascii?Q?n8zkc4f+0WzzaMaSys15s5ncKWj+kdaTvqUR6RIVDewejCVfn8DJZy/AVSfk?=
 =?us-ascii?Q?t8yg2EE8AaX+NBl0W89GuhxvRH1Y8b/NbyzPR+2I4xkixxtqRSQFNWNqTzuC?=
 =?us-ascii?Q?KGQ8K6dhrc9XfLAFgg7JNt5UaCCi9cVituVaa5ol5KxlZIwaB3XyZYhiELNg?=
 =?us-ascii?Q?HPk9GTUyj+SH/1t3SubHNylDn4m09niG/POOVnPI/tPVsNp412GEe1evarYU?=
 =?us-ascii?Q?Gslsp4WBow3xN5q44GFk2rPfDNhflf5RKvYlkQzieNDTg7TlUFCPgMwAG4Kf?=
 =?us-ascii?Q?9oGN5LQleKd9Wa93weKzjUXl8Bnp2ZM+eG9s9kU0cB9eiiNOVMKkXrwD+lmV?=
 =?us-ascii?Q?h4K9Pdkddd7zQgj2kU6rEdO6OMyQr/LI3z1L0SU5XEYX8w7CThGn9EDuz7mF?=
 =?us-ascii?Q?EOKDsM0tOpvgivwFib+igdhTF3/3FbSpeDVlTIpQDFrdOmR6NqTMdY1Cqor9?=
 =?us-ascii?Q?TQemio2ZOeSN0rlz7QlMMBV5qxh8LJa5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 18:05:32.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a1c210-558f-437d-7f41-08dcd0f9ff1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

On Mon, Sep 09, 2024 at 08:30:24PM +0300, Michael Guralnik wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Introduce a new netlink command to allow rdma event monitoring.
> The rdma events supported now are IB device
> registration/unregistration and net device attachment/detachment.
> 
> Example output of rdma monitor and the commands which trigger
> the events:
> 
> $ rdma monitor
> $ rmmod mlx5_ib
> [UNREGISTER]	ibdev_idx 1 ibdev rocep8s0f1
> [UNREGISTER]	ibdev_idx 0 ibdev rocep8s0f0
> 
> $ modprobe mlx5_ib
> [REGISTER]	ibdev_idx 2 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 2 ibdev mlx5_0 port 1 netdev_idx 4 netdev eth2
> [REGISTER]	ibdev_idx 3 ibdev mlx5_1
> [NETDEV_ATTACH]	ibdev_idx 3 ibdev mlx5_1 port 1 netdev_idx 5 netdev eth3

No need to resend the series, I will fix when applying, but the right
format will be:
[NETDEV_ATTACH]       dev 3 mlx5_1 port 1 netdev 5 eth3

Thanks

