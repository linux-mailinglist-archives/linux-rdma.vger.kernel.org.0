Return-Path: <linux-rdma+bounces-14661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3FC7537B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 17:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 32F0331C1E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BF34F257;
	Thu, 20 Nov 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sG2hRfoh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4028505E;
	Thu, 20 Nov 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654602; cv=fail; b=fkg1scQg050QDaG40C2hZv59H0pOqpvAtSwXzzKGQ4f1S2BFPcvTmNh6xMyXPKg48TlsNdmPCFpr/iQRRhKCo0SLB5zg3cJ7+b//JooLJ0800gj9/Uo3K2kr1CyyeFJZ3Z0ITEkPNUxefo/zCLDXbpWeRyS6Rri+6kEb3u7gGMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654602; c=relaxed/simple;
	bh=k0XzU/rtn1kdBxKqrBlufPnMVFw0gH0E+79+vk5NQ7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmobuFGIZNYkwT3Fi6BRB0WmAlRxufzXvn3JIIVVqRJGELDw/tLKJbs2pq8Ah8PwpKX+ZGBmrWyFUHwVvFY5mCmsesu+X2nFSwQR0wwWn8UkgqBKKM2ns+Aq10JbrnZsu+0BVBKXZLJFFc81fmZquvNYmrV5EkcdGABOuYLc0+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sG2hRfoh; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcPohslQZlEAkMB4DZx0/xWNHUp8N5aXwETUwe/RgOd/56MZ0BX/HfekVduSP+qcgxcPW75v2QlzSdWlKGQOUlCgcHTMI4LN+qm492pSkHOsaZxxGplAUucXO9ZUeK0tdCDvSobi1Zl95witJ/Us7OoIUovKzWSlkJp7QAjOebeuEAPiMlr3MOxVUV+7Pd4DJDkHe6ZRYnLNkkwI4dBPk/VbBDxHFQw8t1s2+CfBJGnW905qtGA2vQ4yghR/RuHl8f8Kb6boX1Zcw3LZflfhf36OybxkKvuC23XJa66jZJ1NdH6dLffUtWUlNn9yssPGjFjcmYf8/JNNWsi+z4Qq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDKO4HcftS1KnX6UPUcHcaNSiChx4TPi7N5clvHdyLc=;
 b=EG2pa2oHBkU6vZAbqo9a21EUtu70f2hyEPPjVR+QXP1XvwJ4AnthOEj7FOpPhGXAN7Odaq2w/Cguy80MabLaAiPefLNlweIVl4tDzohxKrtcWaUo+WTzS001qWnPUl+NcDP5USFnhgknHVOh5BaagESRdApk61MUHNU1sTo1gx0LArV7nwJ/+3DD+Bpzd8VjHtVavQ43UnoespcnXFr0wJY/HtPFfFhPq3wITHviM5cjtqiIn8RnpCRZlQQC8tLdiVu+E/GtfQtVq/eWFD1xNPs/kKkVS0qTHeMYk7DLrr+pjUQYzYKuu7W+afyeiyJRzgY+uHJ8lPcl9HTJIdLfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDKO4HcftS1KnX6UPUcHcaNSiChx4TPi7N5clvHdyLc=;
 b=sG2hRfohIetMELr35BYKHl4ZakxjW3ThBAVtmXg3cVR2RjU0qYyMWfT+GQUisUfIqyMXdHil4aF3b/4EWUEguzoOuabDyll/hhEIQo9octeKzz4KLP9Z6082xWG+5PQXT7il9GDIRbfdJz/+f2xCce1fMOPwWEf/uipnz97RDdDyhc0B8Lxhj9vCTOroqk5MSxUN4F79pLiJFTm4SoZB4U9Ed192sAs72B0TBF9BCRwRFf3/VP5tU5URJmuhvRweWQxFf4Fw4HyRLwO1os5HgLatcHGzrmemi5qlc5CBl2CUa694Z7evQ+xo2nUReMFkL+n1YcX/YQdu1NwnxBJTUw==
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 16:03:17 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::33) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Thu,
 20 Nov 2025 16:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 16:03:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 08:02:49 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 08:02:48 -0800
Date: Thu, 20 Nov 2025 18:02:44 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vikas.gupta@broadcom.com>, <selvin.xavier@broadcom.com>,
	<anand.subramanian@broadcom.com>, <usman.ansari@broadcom.com>
Subject: Re: [PATCH v3 5/8] RDMA/bng_re: Add infrastructure for enabling
 Firmware channel
Message-ID: <20251120160244.GW18335@unreal>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
 <20251117171136.128193-6-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251117171136.128193-6-siva.kallam@broadcom.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: c73bc4ce-94d4-4b10-3804-08de284e5160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghK25bjMIhkM7LNJN4z98LdFD3t3a19kHH5ag+hPRhjtE7cxbyKtWvFu6sLL?=
 =?us-ascii?Q?KTpVHgXDyGzNedE5xfUid/bFwcFsm4/CLBKGz1oQXpFGTEpXE//+LG9FsqgH?=
 =?us-ascii?Q?Yd+5/QkHlgRJ2ydUyH3Z4VXLNjLYHCCnX+YSNpzAViL/LX0/JgFW4wc4HTcZ?=
 =?us-ascii?Q?RUUnwY07yVY0kchoFnZHeEFnsqDmcUjACwLbw3HjKpPm7wB+Q1lLyojL9zv0?=
 =?us-ascii?Q?UM0edxeZWnuUQgjpjFhh8IQe9I/XBEhFGSQIPtuIloegOamiKYaZz3g8ppo1?=
 =?us-ascii?Q?T5F20PtKExrZ9jj4f4BiMOzxpGytHopH8rZ7AVnA7/trr+83EkOmCgVhG96m?=
 =?us-ascii?Q?wPN2G79cMpNnFvMYatlfe7+kWauwseu1AmGms6rssAEhBADu7+mQKg4mkC/t?=
 =?us-ascii?Q?xm2KDqodBs7eApLpVukbDdjVXY0ry0LRI5e3vmJ/oC3PJKk2xMqcuj9SVKP/?=
 =?us-ascii?Q?xICxyEVDerXauG6lipzxOLRPaXtKGYy3DSIrUkHk3Pwilgs0mLW3HA99OLgA?=
 =?us-ascii?Q?yQGSe9bstYjsp01YMSHiKGy5OOSGMQyJzUrS4uemfYRyfVi7JSO82YEIZ/PI?=
 =?us-ascii?Q?x0G1XpAn6vOvvLamjNA96AYQoFyjiRCxlq+83jMro1Z6Its2MiXorJNyz4vx?=
 =?us-ascii?Q?4QLkx/BLUWHiDtrUWBmVakvcdGgVzTQLG3qlwXMEq5EPf7g2V8CQh4WnHlDW?=
 =?us-ascii?Q?O3j4X9um/LjiJkzj+3bqGpJW1lcj80VOMK2WaI/0ce+vvRNjgyIOxzf85zzF?=
 =?us-ascii?Q?XwLuchmlOBQdkbdeJerTXz3akeM1H+TR3Ejz/CtgmqD98MI5gp5J/zBhKDzh?=
 =?us-ascii?Q?XxjbTqvUteeeZRmA/TDDq6Jz1+iJLUzfR+9eeGtrBowOLeDCW0N1RzNddlrG?=
 =?us-ascii?Q?rYizIqVtJ4YLFavS+4hF6tHCe2CvY/+RDo5YmOGvzGIufvQpktbj7eLsUAPH?=
 =?us-ascii?Q?3e5dBRy8TcceinQ9tRhSRZOXzH1nQK+Q484gupEZjgIHNVz4OLhtCtYBFPSB?=
 =?us-ascii?Q?0vFNPJfJv9cA886SujxBFdykn2Kq3ZpMR9yWptWjVJrq/uGF5RJs2o873nrj?=
 =?us-ascii?Q?U/JPIJB+FEh+6sj1rd1rKm2CcWdTfDBoMqav6jTBjtibT05tqLj+AGYirxu/?=
 =?us-ascii?Q?zzLEkwWMqTCur1elp9e4mOik7DrhAGJ1uhhxmGe5yINoUygD/NNurvJpeacM?=
 =?us-ascii?Q?NWwQe5Sv67zaqVy3AARtNsoTS2AhQAvaxrqiAogWauKuyRV1L1sOoDu3vwi9?=
 =?us-ascii?Q?B6DrPuteCjZWJW+VDmQjhrSX3wJW/0TctaRbfNn7I8ZR2fQatMvR8QU8tj68?=
 =?us-ascii?Q?Xistm+zOKCkgWU/Z3yHO6NNnbwnV1TmMDfOi007GcsHKsaVQqDHBuxweAUsT?=
 =?us-ascii?Q?3ubRvJhpEUWe2X67oVjdKF+qz/u96MaVusvaOAm6PIkTU9nR6+c8soamhZYX?=
 =?us-ascii?Q?KG8Tz/y1TTssB6gX/oOt+FGQIKr1rEUA2FJU+4xR4ea29053bliXFGxbH8eK?=
 =?us-ascii?Q?Nge8hT7OR/XP4Ll6MrzJiatwkwKCa6ohWHis7MVCuriU62MBzv5tgZcNjWzB?=
 =?us-ascii?Q?r5iBue9hnL6Zg5iQsbk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 16:03:17.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73bc4ce-94d4-4b10-3804-08de284e5160
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

On Mon, Nov 17, 2025 at 05:11:23PM +0000, Siva Reddy Kallam wrote:
> Add infrastructure for enabling Firmware channel.
> 
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 120 +++++++-
>  drivers/infiniband/hw/bng_re/bng_fw.c  | 361 ++++++++++++++++++++++++-
>  drivers/infiniband/hw/bng_re/bng_fw.h  | 133 ++++++++-
>  drivers/infiniband/hw/bng_re/bng_re.h  |  45 +++
>  drivers/infiniband/hw/bng_re/bng_res.c |   2 +
>  drivers/infiniband/hw/bng_re/bng_res.h | 102 +++++++
>  drivers/infiniband/hw/bng_re/bng_tlv.h | 128 +++++++++
>  7 files changed, 885 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h

<...>

> +int bng_re_rcfw_start_irq(struct bng_re_rcfw *rcfw, int msix_vector,
> +			  bool need_init)
> +{
> +	struct bng_re_creq_ctx *creq;
> +	struct bng_re_res *res;
> +	int rc;
> +
> +	creq = &rcfw->creq;
> +	res = rcfw->res;
> +
> +	if (creq->irq_handler_avail)
> +		return -EFAULT;
> +
> +	creq->msix_vec = msix_vector;
> +	if (need_init)
> +		tasklet_setup(&creq->creq_tasklet, bng_re_service_creq);
> +	else
> +		tasklet_enable(&creq->creq_tasklet);

I wonder if new drivers need to use workqueues instead.
https://lwn.net/Articles/966894/

Thanks

