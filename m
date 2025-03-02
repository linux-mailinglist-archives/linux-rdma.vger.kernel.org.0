Return-Path: <linux-rdma+bounces-8233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5942A4B168
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4F27A3A4C
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D861E1A17;
	Sun,  2 Mar 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBIxSkjc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3F1C5D4B;
	Sun,  2 Mar 2025 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917366; cv=fail; b=okj5NIGPzqxW90LTHprtA5l+D58rnZ4KAulMDchrPu2pKmejQjkG//4+u/d+TJiyKfkBQkqRvgYGZcbTb8dj/hLZcuAej2tztoVS9/mlNwmFTuSUatMQTADiKmD0iKdjdrQ8AhQmprF9ccfM4MmpJo6Xgkw7P9kBnrifNlz+i6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917366; c=relaxed/simple;
	bh=AqbWMNTuIgm8nnQN4zKy8r00SnyKYrzJYIHLmGJ9Ydg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUrp9Rv+mQ8rkRcUFb8CJhFnKgTyPRMHoGYTTt9ZBHnnVSfkn7RbN9kRQR4oGQmHIjgyJxTrDJ3wPK2RDeAji1+peGKtYmrxOH+9ab2ih/bkX77usnBaGvOY6YYNJCmHegjYhBOfI/PBJDuskXTVd7PYN8I9xPWDqUYEYlvsi3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBIxSkjc; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmjb/z3YRKv2KQm7kA7niXpHKHdThQn2xiC0HjOc8n33IeXYh8Tng+/UnWI9vHhc3bSjed4bZWCZf+1kdMtudNFDvdzgzGpZ/UYiaB6pKnShU2wqwWvcGN44I8wuPBORW3S/x+VOepdDk++a79VJhRBtG8lfDtm0As2jUvIooaiqEsxOk8Ud+AU6o/WL9R6AjDMY7YrtnUo4Uiv60SmRDGfN+tCsp4gBVZPeksJjp+Q81ZX+03dWPWxm61u8uB4+hbeZ1V8/Xu+QiNyvY+mEPgf8MHHegHcnImOkioJMCOiqvi/e3dSIo+KVTim5uJ3AsFzhXmqTGjrMWSd5F8a/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt7pmrG/MXY4SlAdX1nBXiCp4i/xvLjxyUkkgnzXDwk=;
 b=JotbM1LkeVC4vnYMbrW1PkPT8YxuhAb7RmwNnpRpy31IuuP1qaPIxJ3yHYmAhxOsTa0bm6sfSenfsqkjOflLPC00TcirmTxdFsnuu1pKN9YcjfaShsvNMRXtZULMRqcbCm3K40eh/9+enzw2lCzzWV0HYjlCQWhkSA1of1GDI0FmyX3KK4Txs2Qv4f1ZyRvKo4JQCXzOAeUNJooYlrbkZJV60HPUDFrCbRooM6XnZULAM4vGJgjrdfFvJacGqLQskAUmM+7TYX9//6TExhChuEPMQyC4FIljvwXZUch1fCp5Qb8mgYWy3ekFD6G8iEQ9oenn7MShexCTAOaaXLqj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt7pmrG/MXY4SlAdX1nBXiCp4i/xvLjxyUkkgnzXDwk=;
 b=BBIxSkjcTCqPDvxOPUTOLSUWLHK2VF/kQwXw1qL699BicM4G2s+KVXpZ9DV9xF0XbPYgJopy0kQ5aT1lVGDRAmDThXM8FwozNUyZSYsRIVMWlyaB1WMJsaIJsBIJPYgtQ9En9gYmoQVxcbp92Zrx93YDWfXLxkCv9/VmtuKGchqRzu50HTfcBR8BVUwQ+cDFOFs9A2LyZAkjyboAwoYh8o1Ka30vVmHpacdEUmAtBEuGZJncqUTw2w3gCDuXqPzdDuIWYtu/dazQznpGBxkcjKzoXDBhzofBIfgYcwLi9QIjFSgwnz2XLt0BOwuJU4p7sDFw3bR3JbcPgUTgWvPmKA==
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Sun, 2 Mar
 2025 12:09:19 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e5) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Sun,
 2 Mar 2025 12:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Sun, 2 Mar 2025 12:09:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Mar 2025
 04:09:11 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 2 Mar
 2025 04:09:10 -0800
Date: Sun, 2 Mar 2025 14:09:05 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 8/8] mlx5: Create an auxiliary device for fwctl_mlx5
Message-ID: <20250302120905.GA1539246@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <8-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd3ab66-968f-4668-6a25-08dd59830fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OXT1p2qmJ90bLfrGkqiYweKWagGPHVV+ps2Y9ymIG1VOirH9KB+PAkldy6pb?=
 =?us-ascii?Q?OpBOSiDsnj+Q32rORW0kXUzAzOyCI5wDXAXYdNei+kDa7CbGnrbRv2Sok+tY?=
 =?us-ascii?Q?vj0ggKE1fyispyFZhsUjWTYaDQtKAyjPI7XHa/8pfhgk0T3vRfXexb7yjjx9?=
 =?us-ascii?Q?OI6fzTS0dPB40fA9E8WNZvcIZjexVR9/HxIG/GnhZie75jTDtowpYQu4bYOC?=
 =?us-ascii?Q?GNq1cwv/aZNXcH0ILr8IHQLQAHcAY5uchFOLNhfhaxQ4fQqvIzawRk4n705S?=
 =?us-ascii?Q?UoENExWvRTaKTcyb2QBmidOXV4/c/EViHE+tK7kE3/LrYY5WrzDsyVtjLSgs?=
 =?us-ascii?Q?36G6XcwE8kpj6hRooqANFs9bgLy8FPPl58WeDvnuZUFkDJUru8MP2okLTVkq?=
 =?us-ascii?Q?xl3RA4hfYmG++YySWabmPbzjO6Cc0yyzCOPTBVd8/cK6GCaxNPd0PkDMNiin?=
 =?us-ascii?Q?jsftZ4UsJFpyYra7m+t6PBYwKm50GEWe74ySvoa6u5+rOpLoyhnvFyDuPm1x?=
 =?us-ascii?Q?kaGfhr8nGlqLmaTjfHCPasw+ywNce2MkdzIBdypRH6L1Wt9sGsZ5bAPzHDuv?=
 =?us-ascii?Q?c6oPeyIT2xeRhTUrQ6ywYtiETOtx28BTKrCT7/EwQjd1oVwNiJFvxrXaWi/F?=
 =?us-ascii?Q?oNHM0qDAcl/qIqKRoTwrjDFcs0izeegE9fPLPXycDyD7vhh4kbKtsf2Z7N++?=
 =?us-ascii?Q?eDiboSOOXeBKhtbP1eKlMzCjV1wyXsAVCg7yFV6lAN4qHpSuEbZMHOyTJJ1z?=
 =?us-ascii?Q?n8CUQE3jTbUSQtRNUw6SpUBR7u4IbW1yWVJiS93vAuUCSNfDwAKiU7VIJuOM?=
 =?us-ascii?Q?LAPBbvgY1o39AjrS6OMQyQzxfyAEfYSnWxBDLauuZ5hU6Efl5bqy+ZRDrXUL?=
 =?us-ascii?Q?jYSnQ2Et1dJ1+XYf4GLcw0gHXr3fESK8j2RVcSVbFc2/JL+3IwBxKn/XGCcj?=
 =?us-ascii?Q?iXgu9oX+Bzj+WgPY8idO0RNf40/lhrRD872wzf9icU4SgCFwC1zEEm89ZkDp?=
 =?us-ascii?Q?X4ItW79123OdmBoZxGK/9jCHFSr9QIIx++LWWtyoWoAUUvgSrZcNSA5YYM/t?=
 =?us-ascii?Q?+hWk6EGqKiasX0r5qIdNbSf8uReA3rUaYKwoq7pcBaYIyM2CBev2ctjk5S6f?=
 =?us-ascii?Q?h86ymQvjS9Wvfy8zrzGuLtASbZYCGofqLxcKzI0eZRo1mcik8hqec7KKv+tt?=
 =?us-ascii?Q?m15in7EtzbN5a57Oz4yaYsLk9C46GR2DHREeK2w0xpUMFz/v2ylb0usonrAS?=
 =?us-ascii?Q?ady6FRlvyuU2SuV+6On2yu11dUX3X8lqGryz6H9/hZBhBcs2p4AL4kUoIC9D?=
 =?us-ascii?Q?s/Az8yb0Lqf/z/2LcnUNDUgNZqecXbsiwPAsNO4E7ynGoFVX6+pagcOS5E49?=
 =?us-ascii?Q?UvQthSOI+BYuqDL2Z40OxbMxVwIUN04Z0gZyKvnwLUaLcm9MaMKXclWIa3dz?=
 =?us-ascii?Q?TZBSzF525ufxKLTbNQDSF4deXCpnwDW6W2OUeBifRYvWN05aqEJ3og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:09:19.4600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd3ab66-968f-4668-6a25-08dd59830fbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

On Thu, Feb 27, 2025 at 08:26:36PM -0400, Jason Gunthorpe wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> If the device supports User Context then it can support fwctl. Create an
> auxiliary device to allow fwctl to bind to it.
> 
> Create a sysfs like:
> 
> $ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
> lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>

