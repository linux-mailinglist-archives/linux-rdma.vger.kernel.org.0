Return-Path: <linux-rdma+bounces-14604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F61C6B529
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 20:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D2DA529EE0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E525F988;
	Tue, 18 Nov 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqevvFky"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65B2AF1D;
	Tue, 18 Nov 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492429; cv=fail; b=jS1dpQHMdEkSa3gMGkOg4+3Z0cwOU/SifcTSHPmMT4jvlMlWqgyLuUDQEIm8cTLkoNCPvj/cqCC6gPkyFz817yshIDuWesFmRDo6RO1M4B0Oh6OaIMd0QXD38vjdoLbvcjxO3ZJPDzuuby9gPSLQk+xqSf0L1DhKXDIapglkSt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492429; c=relaxed/simple;
	bh=DeovzYcLGftpyyJl1bGepui1P/k0+8nG6DLZuW/ZtSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhcMpgE1BAO3jMLzRa46vSeEoNwR/hLmx6oGaOPaj3IM17FrP1uwzX4LRYqcrBmbwacUmhnKg6ob/rEgSiqa7JvryE0EtPADtZqTk6t3L/dxnVfZklEv/8FR/xFvDc3sn+eaDD5OMq7H+gGiKRgYd7itjc4fXoAw0jatJrQssm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqevvFky; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POq6Vrh2KPjMdVs5rBjhgjL0JlAPEFThOxX0xVHxeMi/gqe11siql7mVC9YikfCeoxHEq/I1UsMeNFuQQHGaV3alvLzm4npjLIebK4mUSYatykXuEdRg/aXsW290axxayBT3h/LgTaIzZv4Rw0hIiVHnV4YxfyRpYTBqNTYyFsvNZhXjXROwvV8ptHjTwDJKehvvGKZ5MTb+wc/U1NJE5GWwtGupQseqqUZ6sYXYBiJkflxBobvtb9hC27RWwgNTgn4mUDCxPYEcMYEwAl0odLJHgUakOUN8I67zloglUwMGp16phEqPDof5ZivK+XtvowFQd1dJfrultqKvbZdgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y38Kx/4c9bkvwm0WejpyqOubmOq0+hMhacab/v9tVg0=;
 b=n+qpfLXsdqKJFC3KoPThZ6xePoNe0kuucD+eM+DXlOAGVwNKOtjv4/XF6KFHnY711e47vjnknaKc7OIkYfSBLT9VRQ35eYY9HG7SpEh4LdFByRkILjF8IbYrmnxQCS+BdQA8WSXiWfGQbwjWIwrU81w2XcFddfzAT999Q5icQddDrOHJeJW9U8nmq8v33jUBxWWKr/aPcyqdYefrTKuENA7xBFJwyet7YWmwCiDO9xZieLqVkP6LENNjCUnaKmqZHwmea3xvbIiYjnWA83Buwhg893grhZPbyqF5G2gdHPUChxONYUc3bPsEU6ESlITKWBxUcEMeGYwCpICrpMMeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y38Kx/4c9bkvwm0WejpyqOubmOq0+hMhacab/v9tVg0=;
 b=ZqevvFkylDmP+M4h+TvREKj8C0wY9e3sBShAj5SrrQ1yL7AMg1S3GdLn7uYsC7TQWsTsM9S2P1sEcBQJkmOZmmRn+CeAwP9y1q79yIDEjEaU+BMqCQ2IrWDCp/vdwSooTMrIPrvc85ybQBR3T8kY7RplVPvgKrjrYJuQT3UeR6j/Hsh3bF3QCXvj/ooenHafZ5uXHGPDjqA/tp39tZZKXHhC+dnoP5+VN8HNZBIzV1JlLlskutNACsJMoThAP8IonIc3lcBPECoq5bRMSibGfesdmo6jW3r+NwrfYtzpGavtY9D+ARyMaRbhe7SJKqRcwYc/Ouu1g8DxaKg4cFIGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 19:00:22 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:00:22 +0000
Date: Tue, 18 Nov 2025 15:00:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
Message-ID: <20251118190021.GR10864@nvidia.com>
References: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <26019e39-d36a-4290-ac80-c8b0b09104c8@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26019e39-d36a-4290-ac80-c8b0b09104c8@rock-chips.com>
X-ClientProxiedBy: BN9PR03CA0507.namprd03.prod.outlook.com
 (2603:10b6:408:130::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: e626f434-8325-4db9-aaa4-08de26d4b9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPNXafXnxOycWt2fOwGE39ac2mv5wTHhkhesbkE3LKots4TJI4/BgRFTP0y3?=
 =?us-ascii?Q?sk9bLCxyXk9bIHTU3mZ8f8aI7QBFYwDWUeyeTZWSnkZFoKtOnsN8I0ZU93MB?=
 =?us-ascii?Q?6Exkn6i3tdYaxdsgu+mBFMlsvpUDzi9fvkUxFAjlcUG1OrwBk3jit1mYqxVn?=
 =?us-ascii?Q?Xedqz3e/CUyG8JUYa/hCVDKQ/JrnDnUpgUN9tW9wEEl+ukDsiLiLwF8FGkJY?=
 =?us-ascii?Q?CLxr7WNAkh+4mtihCosvKeAnVMpmQ1gXSfAlvCYF+3T+C9nF0CKEu0fn2/3Y?=
 =?us-ascii?Q?t6UMSSJqDOaiPEJwZM1BJyGqe7tj1bKW73iwAh9qgKIAzKTbUOs7lnq910Pd?=
 =?us-ascii?Q?z3Mop/FJRe+nZC0qOXlzaJamHGd+CFdMWZ/sjoq9aozSn0cApHwPeCpZ3QRF?=
 =?us-ascii?Q?Y9E3fHFV29KOhH+8ZGtdVEO3Tnz4h8g5aljAMJfLYrA78vnyDRj5V+6Nobaz?=
 =?us-ascii?Q?bojuabzQtQvZer7APNwPPJjCMO+jd4iLRzIdM9Jg0qX8qv6TBT5bciGV8JEt?=
 =?us-ascii?Q?wSfzO1NPSbDSw5YvyKsh+qrsptvHOx61bwbZDQNq4QR/AhAiH+bRe8NBtUxm?=
 =?us-ascii?Q?7FkDOiJkvx+3R5y+ZI7gAYgOwnT8ddA+tUetbfF4Yc9/laSkZD/+W26w1Ozb?=
 =?us-ascii?Q?+vyLs0fuGVmIFxlEKVJ9RdK0xA2b5GItvLQKWLwYcqmk/2GjX9/WAOm2tuuJ?=
 =?us-ascii?Q?0XLWbsg7MMFvxfytzPEUlw4udrkh19TNmKBFbzknw4KcOsg26/NDGP8HRqKB?=
 =?us-ascii?Q?0OVHGDxQDdR83DhJ065Byqtiqupp9zgRea28N0SFu79IheUVkv5P+QSQfRhn?=
 =?us-ascii?Q?i05wd8MFfxWMbSg9q/gzuEWa321WGDcjP3QidYTyjVaEfMSnh2SzcxMZh3rX?=
 =?us-ascii?Q?4ghAStj198Z0M8MivHE+lhRL2jpgrG68LgXz19UHHEP3JlfdaKSX93Ev/muz?=
 =?us-ascii?Q?m/vcWv1H6k/KKSR5y854MEaqUoR7bMQowUBMXGXPOL6MWpWuMHEHCSLP7SYV?=
 =?us-ascii?Q?8qPqPsjBXlYLz+Wv5OMUOGlBKIQ63MJE4DdOtNEX4f0/GfPDCsaJNBrMidR8?=
 =?us-ascii?Q?CecwTlyaWnbyQZem+rd4354cuFl24hTDJMLkImxEd3WnEtAcio4q+LV8SRmR?=
 =?us-ascii?Q?B3Ws/W4anJ6vmvvOdCoAIDQt7Cc8y89nQIv7+wUXTgAGkRZiQgT0sTou0czl?=
 =?us-ascii?Q?YIbJUSMxjDlGdcXowGo8l369sqXTy05IausjUsOcVgbFj+8bQ8dgwr1vRadD?=
 =?us-ascii?Q?Yv9zgCC90wA6/l2w9IsEzHhNxPG4z0i8C5gUKVeTQy6drU7FwltTUHIzn5lr?=
 =?us-ascii?Q?5JeXCNGBcmLHFjpqgTCPDTJJORejKn25kweGoxg/hszK+7GumunrgfOqEW/1?=
 =?us-ascii?Q?QNP39rpmXTRlLRRbbPsvTSo1PcXJoWHdRQ9+9I9en8BoI7KBiBwvUkp0ZHK0?=
 =?us-ascii?Q?Fw6SMy0YFJn1lZbnU3IaUE4mF3swxURn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xt2K3vIm5b+ej/41LnIf5XLRH6WVvgjyYg9Bvu6oEJWWVCgSE6bWgEI9Die4?=
 =?us-ascii?Q?1Ugy9LvPaqji6fD+LM3cSNxq/C0Wy7sDCesL2BDFDLN69ap8Md6THWOx1i+C?=
 =?us-ascii?Q?BqjpMfiqXvmw9tG9rYtdC7X0eM3JhtiuDYqICvz7ZQEKdzRpcDsFkDLSq6qQ?=
 =?us-ascii?Q?vreM/MA09nx9Ptbhf/tvrtnpKSx0Fm6YjBRlABglqdsCnmua+kjjc/gLiOLZ?=
 =?us-ascii?Q?dtLPfj6NCyBOsHn7QM6hDl6QktV5oO451rk9DYgsLT79w4IpSNsi09Kc70K7?=
 =?us-ascii?Q?N/NqfekVEl9UFqKGGZIelq9c2jOJ0bWW8PoKEEwVZUh2bb6yl6mvJIMqQBIG?=
 =?us-ascii?Q?+1cLF6gTswy8m4Mlqjww/uEqBER4w5euZnTQZIYiiS3r9UXkU4/cNlSEoT/9?=
 =?us-ascii?Q?qZhhvj7H5PPhEd3gO6Uwzk5O+xCsM99zPOVfwcdwEA9QnxfmTxydLuRP5PVQ?=
 =?us-ascii?Q?wjAbO4IXcR9xdaQ83XYFYroSom9XB4CsmX3WxfhBCIhVeA0x7S1ZLRJ9E6rk?=
 =?us-ascii?Q?1u6byY6yjEnRaDL4zbhK+jzfXuKfnVJRfhba+hBSaDCAb1+AMPP9apDplTXF?=
 =?us-ascii?Q?GOBHMlohkaTd791r/n25niQ/llviOxHsDkA9kbjyKIEnaXGhmhIGa6Ui0xte?=
 =?us-ascii?Q?hcwZDZIcfmwb9iJCSjx0oqLfFlQrwNyHqhsK/I86ioeGi/LqIM8iIko3Tjzh?=
 =?us-ascii?Q?McZMREs4YFvzgt/9VWaEHPg4Asn5bwdvTSWKyNYe6HqmVDRAmdJmdW+gDPFS?=
 =?us-ascii?Q?zRdZXrfn+gTXoy/JtCJTluWxN30bsf8tUp38ysgdXYUsN2OOxVQO49HrHw1c?=
 =?us-ascii?Q?Ott1m4XZR0ZrHbCgbxx+nR4FsnCKX7W9v0O+uLSUYsSMUs4E8LGYCIFHwJjY?=
 =?us-ascii?Q?imk7CrUkmgTyIAVsxfYDzE9w7MNo9fB03ZFJ98jHmSVh92HkvRn0CToiyAna?=
 =?us-ascii?Q?16P90kEdlLFFkgPX/KVlMAmKebFwz1h3o51MwMQoIo24cS66Ue7mKUeStp3K?=
 =?us-ascii?Q?ZcXVaZH8TupRh6tGgDF+mD8eZsVn3EkCZPEpufir9jFd4K3cBkQCZ3zcguta?=
 =?us-ascii?Q?16rW5Np9PLoP0ngpO3hq0cpdMpiX9WcXiJv4EJZTgdkIbYuylp3o3dmyVno/?=
 =?us-ascii?Q?te7CyImzQbhysuRCOdzoQZ/g1Qf136/eb1XmbdjENQq4YXe7tb+/HIujUqVO?=
 =?us-ascii?Q?7VcebUWj+KJaWxQ8VmPRFgFABMsh3zNJJ91o2QMzDmlw3yMGm4RiScswx16e?=
 =?us-ascii?Q?iMHyQy6K9PpvM6KvutXJNGm/p46s66aXd5LLEiq7I+/ATzXCTalW7yPkBodQ?=
 =?us-ascii?Q?KJ+7vxHwNNyf6SoopPlmrHL+/GNeYBqX2cjVtXZpxkTrk9bBu2iTrmILfH0g?=
 =?us-ascii?Q?6svnc6vUeM+ybs1Mt46OQU3eUCo9f0LfLJzE03EeAxE5CfdJ7SNyJ5GbxH/t?=
 =?us-ascii?Q?lGX2HrT+oJY4d7CZDYZbQEeIgd7wiz70i7/gdE1Hiw4JGjS8tRSdwoGCWQS2?=
 =?us-ascii?Q?/+hBdpx5Wi0iiw/9q3wqhldITjIp+jL5tfPZhs0RhuW7Ffb6Wtg6ExVUI3jp?=
 =?us-ascii?Q?TZXgoWZi/72uT1BB83o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e626f434-8325-4db9-aaa4-08de26d4b9b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:00:22.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYI9gmyWO5ZNT7LGD6dr0YYufiiocS9D78SQn/hc+zcrATSki79hfYMpIJayhe4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

On Tue, Nov 18, 2025 at 09:30:29AM +0800, Chaoyi Chen wrote:
> Hello Jason,
> 
> On 11/7/2025 4:34 AM, Jason Gunthorpe wrote:
> > report_iommu_fault() is an older API that has been superseded by
> > iommu_report_device_fault() which is capable to support PRI.
> > 
> > Only two external drivers consume this, drivers/remoteproc and
> > drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> > now protect against accidentally mix and matching the wrong components.
> > 
> > The iommu drivers support either the old iommu_set_fault_handler() via the
> > driver calling report_iommu_fault(), or they are newer server focused
> > drivers that call iommu_report_device_fault().
> > 
> > Include a flag in the iommu_ops if the driver calls report_iommu_fault()
> > and block iommu_set_fault_handler() for domain's of iommu drivers that
> > can't support it.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> Sorry for the noise. Sometimes non-IOMMU drivers, such as DRM
> devices, also want to handle IOMMU fault events, so they might use
> iommu_set_fault_handler() before. What API should they use as an
> alternative now?

The new flow is through iommu_report_device_fault() which an end user
can access by setting domain->iopf_handler currently.

Jason

