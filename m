Return-Path: <linux-rdma+bounces-14025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1FC01E96
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DBE1A63B05
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57214C85;
	Thu, 23 Oct 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5jfA7oW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FE330B2F;
	Thu, 23 Oct 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231281; cv=fail; b=Z4K68hNsnYv45Paw6O+TX4wgVuyBLxsylJXyAYguDtRm3qrsv6ptOzHpB4zJNnojDrlOJrrPxNGMhmxtmb7j5Or4vAuC0hNu0fJUFFEdYMALyILWPQxrw8OM/69H1aNgzJ3TzdnRTinUEnyrVQbh9OLn8V5xB4FJE+opTmgsvG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231281; c=relaxed/simple;
	bh=IiPvYAvcpBGZ2u81AWUq/U54GlzHSWxPP82TE8a9w0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRzd065WpYZt5qKpjCZ+/i2Tdsb7eml/pCLvOSb8MQkeIjPzW77BHdVPYC1Qn/w7v0t1WJktBX6U+bhS3bawUdc5S1yCuNUHtfOMurlWg0uocuaZwranKHMJGPPqFqqE32qW+T9KIDvorzUeP4WtAOx3Sqw4vv82Gy4cghzTVCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s5jfA7oW; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxx6M8fwVAJviMfHmvkgHPF/9iHxr50K98BXYyLmobMpZs/gTeZUHbrAXDY0UeOojM2RVc+lNtZPdghLBNSzG64tBf9g/80l0xSzKma+WLicQwKRAEDnYrZUo3LobU4K4l/PsVMc6zPFC+iRCeY9OKpYJ4w3dTlx5u7d6dXgPF1ChAik95jrWDZ9wFVbK83/FeyR3ueFyMeMmDDT+gbKAw5EuBHhPmnMc0ifmLs46i42C+xXtu61hkDP3vl83lC47PwcoW72mtvyiZ9Gnpl+OHmiTBK4qrsel6qgj8wXKJJdKpjXi9VgPK3syYwWtwjtysds1xVhf5uG6qqT7q9REA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqU7mjwQ9Tuv6viIvC+OdjC5AD/nKvbUFs66cknXclY=;
 b=BDWxwD2S8RJv2lyec+MaXrtoNDwkSD04juaRSgPrc6HKFqsirCozlMBmrPxeaHuvBi3vVKpuZTBf9yNT/Wqk/kWw47TWuaAwM9bleCH4TD//TgKHUF95Uq26xOWdMsb/gjxLRNraw92sNP7oCovkbHzIhWnjeTDvWmGG8UZSsk1w4FJ9o/i7FXZrMLhzokY0iKiGDqv67OUIKRQdyG8XY/0HfEX8/JIvJgDZr+AikpMyBvsdNkzXH7o3W3XjI1l8L1cJVXSdD736HJ8m+9CFL9EiQ1sq82za7j5h/VtYnlodRLKjdOJE6YZpfa5A8vSydxZRzimIrve6teGlw+1bQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqU7mjwQ9Tuv6viIvC+OdjC5AD/nKvbUFs66cknXclY=;
 b=s5jfA7oW5xFSTQB2NljI80gVY11IYv/PdmkCxRCP3tU1GnxsCwntK2Kea0y1g5vqiwGE/Vi6RJ279T7aI42wXEEKI+X8pvoMmbHIaVzX7VLavxeNHnjwq9yqV7Cf9netElLKhHqJBqfQP3IM3CgdXgMlWUkK315DDCJBa7J+/SeUVEOK/24SrVpbA4M2J9Zpy8yXxe44unoIVP5wzSgA7XKnmEvtYtXK/IG9ep+m5sjMUJCZd3on1R0BnrTNQByHx5q/NJGVhM5DBiCfeX0GlyX6MGBKP3EP1wGSUIZjqQ2O0t/NHXcHzAPl/kM473igopZej1VIn++eiJImT30lZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 14:54:36 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:54:35 +0000
Date: Thu, 23 Oct 2025 11:54:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
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
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
Message-ID: <20251023145434.GJ262900@nvidia.com>
References: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
 <d594cdf2-5aab-4539-8d44-f7e57770df72@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d594cdf2-5aab-4539-8d44-f7e57770df72@arm.com>
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf5b08e-c5d5-409c-0366-08de12441541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94oQD/d7+HvV+q5LlVCKVCK4C5oFl/NbIU6GgBaBG8yDL3kfL/bk1oEgKE1g?=
 =?us-ascii?Q?98mZugHJDgQ7u8QWULMbWZWmH+O/NtamGcuBAPkhkcrzfm0WsgdcS009f0CR?=
 =?us-ascii?Q?2J9InKx39yy3pH0vETHHW84s6eUSpcnIgXj2hrVrlOuFXnnsxqWWtbNJK+Ty?=
 =?us-ascii?Q?YI4MMsSTQq4QtX8JsicfS5kA5dy0NujHaVO2+PimhHJCUf7pTv5iJtDRzKew?=
 =?us-ascii?Q?HEmCjbC7k33W4UUD1ZBn3UI8XddIp0A0sG+khpPGr/tUA6aaAHjTaJSxBOj0?=
 =?us-ascii?Q?BYTZygHCcbm+VvhsQxDBqfCJxqlTNBYsi8Y+ICjFtgvPHcJxueN2iOv73osX?=
 =?us-ascii?Q?csS6jvuomuNfYFrVyjbsRMOXBs+yg4XQ856KEP7VJ1hVLRvWtWmckzFPbkcQ?=
 =?us-ascii?Q?7Zijv/+XmeRW6zjZNoL0UZk0rrrwhijopJZaiatiOwXhcoLdJ8FFODLFKoW8?=
 =?us-ascii?Q?wVsbrSt9J4GUr81KT4pdv5c0ZFJP3KM/SYf/oECpDYMIonQAGBA3IO8MDg7c?=
 =?us-ascii?Q?VIbFJ1z5NFbwo4SHs1WNSiEtYGH280DiifhqEXUBImnPUw6SFBedfZgdurVt?=
 =?us-ascii?Q?TTyzUFSWMv+yVci8B3qwvLHIR57ESytfO06h6SGb2Ku5OtF64ddIs3dERugO?=
 =?us-ascii?Q?1YUkcpq2gqEQqMnUaXYx9mezGiJrYgNp3ESQuMFCZjmRfWBwBlTOpr3pvHGA?=
 =?us-ascii?Q?jDvW6y4GSzhDkw8h+BJ+qLApie1Wj7ZtiDRvEsL4ZqnBI8MTxwyosl4bB0YN?=
 =?us-ascii?Q?0hLrTHGJYR8ZfGYs1e3bpJEzpg6dVOK/WKjkxmblm6QKpHcFa2mkB7OULqNd?=
 =?us-ascii?Q?40KQjy2M5oh+mezwDD3PWw9L+WuFaLEXwxVua0UexQ6SHchDbjD2kK8VCB2v?=
 =?us-ascii?Q?M+BA4kRcBjQo+0+KpbDj+azXxBpSQTh1MdWhGQnYZ7pQlyDrTRTBmiu+0htz?=
 =?us-ascii?Q?CalZN3NBoPAiYApLwr88vkWFIXsRnaX3Voh7C09fw8JyF8aHNj4juQClx5Uf?=
 =?us-ascii?Q?Mt95ZQVbkAHpxDKgbvKENTiLjCOYCCoe+wcFBKU/J80jMER2FK73z+GJqG8D?=
 =?us-ascii?Q?Naxgq3/wTtROJumKfFvKuP53tPdtvHwk5FIaC7ymsYG07Fdqn+ugLmp+r6PS?=
 =?us-ascii?Q?0cemeRykbCUd74QD1RbX5DaNNp7DfnVuHrXz+xiP22XyuOvnfUoL+F97AngM?=
 =?us-ascii?Q?Qu0mw8iTKr3s/nYktOjZ4qsxz1mUBOhm9/km8lg8r3ZoJ6YgDuYOuh3glVBQ?=
 =?us-ascii?Q?bR2LLnNpTyDw3VeCUbHQckBJHPOu1/mrSYr+4Le74Bc0pMjrBejbdqE1tH7f?=
 =?us-ascii?Q?Xz3AFUDwC5X8Jgx8jHYGi1bI+aC9vVK5GLisblswNBzyj/2aExCVMwhOGZch?=
 =?us-ascii?Q?Y0I65XS4lHKceAnLDFwLfWfBqO+gJS7KuxzoQZX2GROLzQfBV/nIhX/rCBrA?=
 =?us-ascii?Q?xnwjdB90otNj7wnXmOq9QCmffUudpHZN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d3v36TDUSHZkWQqPEs+llBOCuhT8akovkIXjF/xPDJXhgFijAIULyDp4sTl8?=
 =?us-ascii?Q?5MaDs8j5j/cNetsZty69l4erkvxDbZKJP2Rh4TXRbxj4KVOsJPHCn/DPd0FP?=
 =?us-ascii?Q?PqaedyTmx6G9XCECpDvUI2OezIgyxgFEHExpyPfpugFiZn9w/Nu8WRVa5juY?=
 =?us-ascii?Q?VbO+CPPuq5j0USP5wNE8rE5x1dCfGihzh/sStC244XM/OWdTV51ljgCnxwyk?=
 =?us-ascii?Q?0MJKG8TqiOtFgUH0wTqKWiv2E+ahXtA8Y5fRTaLL0UHMAFZUT4O6Y24lK7nC?=
 =?us-ascii?Q?PgbktrC+H2S4bkfZaDinakk0mQhYp5PbA2ghQHjhTx26OAEFyWIlh0V2uHcv?=
 =?us-ascii?Q?Bt65XWnaxOUsJT1ITt5X7Ro5CZEkHQAVaXQ1oGMcHL8zODaSOf4EwuvLiM7Y?=
 =?us-ascii?Q?AcN12CYPvObdN2qiFyaMFH1OwfIqRLaJpxFO53Awe1Gib64VnMajGmqDMB89?=
 =?us-ascii?Q?LCDIQoL7PBdkkdnp0RpikLfQE5eK9dI47oy7euXcEvQ2VVtZmoe8F5JetYsA?=
 =?us-ascii?Q?3TinnwDIqcBR71yShmE7RMAFrW7CgRzc9tl4b6Z/U0d7SIk/8vBLqE3KPtoj?=
 =?us-ascii?Q?j1PYujQqE+R8CVRQflwOawYlPvkA4JBANEIsjH9WsSJ8Dxs93yBGy6s3RQ9X?=
 =?us-ascii?Q?+pAbNkS4H3qjr9iCzc/8A8vo+W+wz/gL5xmH3GIwkuzmAKUXamm60L/kEAZE?=
 =?us-ascii?Q?yTd+it8ElQnZHMCZdEdaWbIvhByqt1iJSbwRD9N/8yy36ay6q1nqByWu4PRO?=
 =?us-ascii?Q?FzqQ6h9TecdqcomXkZuNKMq1/0+ULPjxdOwo+mVYmSmkj7deKYTQpCGunvUU?=
 =?us-ascii?Q?0A24hIPJf4DLdldVyemWbouRRBDaOrmPokUKaRsxwbdBNLFAPvfZfbrVokEX?=
 =?us-ascii?Q?qFg83Sz53MSEJDJenyIiZaE3M0DSmL6SrisaxvUfPBz2l2BqnY0ejlkh4LAa?=
 =?us-ascii?Q?YhX6Ac4VbHROmoGJDnsr4OuHEe+MzwKI6xrOWfDzDbuHW9NfSr4XWyQ11Dbl?=
 =?us-ascii?Q?Qf9SUmbcfwD7ECECBFBBacqOTiykCrTkI8Gqkh4kt9HhOMUca1iP/2C6LUHh?=
 =?us-ascii?Q?tACCibY5xgMyTRghIWJqAT2EVkZTgYfAxtReSvp8wOcreoi5lJA86or/Ubbi?=
 =?us-ascii?Q?N4vWqMz1y3NSkxh48ViJgbj8pHg2d0N40rMdibaUmIMDZkXci7qyPNEJZXqU?=
 =?us-ascii?Q?f5j2NByEeO2aXWzKxD8IMAemZF9ok3E80xFzS9pys8I3OvfqL76ta95dVVvv?=
 =?us-ascii?Q?gUT9NJArsnD5IwoutruN//klfeJk9/BvA8PlcOdiqY8TaZpkvIvyPZixT+Lh?=
 =?us-ascii?Q?W3ekyEInWo2qFzjkOhDLrMsht7J02MQWVN3LAgSBqKYtnQuyiVLCmFhgYbu1?=
 =?us-ascii?Q?dRWg5HdWi2K36TsoBzz4FKwNkPSJEcPGOQTtgkOayDWzygANnbYri8iPi19L?=
 =?us-ascii?Q?MzmOhOdX9PV+nfxSc2ZKNTbIOpGoZ3fWUrcn9PSi/l6GWIf3jfis/o1BXXLh?=
 =?us-ascii?Q?ZeVNnAk02xqKH9/NYRbyBPygpJ4j0BkWpG0O7NSBd0oNtnwP353sDf5isrpU?=
 =?us-ascii?Q?/5d7V11C+4cIwh9libGNj4XN5Wxfqoxn7W7zov6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf5b08e-c5d5-409c-0366-08de12441541
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:54:35.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+m8tgumpImimoCaMVbCCvLsQ+MFEpFp02TkvyZ+vorOd6Iv+Hz7n7QenP1vxL5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

On Thu, Oct 23, 2025 at 12:24:01PM +0100, Robin Murphy wrote:
> On 2025-10-22 6:12 pm, Jason Gunthorpe wrote:
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
> > Include a flag in the domain_ops if it calls report_iommu_fault() and
> > block iommu_set_fault_handler() on iommu's that can't support it.
> 
> This isn't a domain operation though; depending on how you look at it,
> supporting a legacy fault_handler is either a capability of the IOMMU driver
> (that would be reachable via domain->owner->capable) or a property of the
> iommu_domain itself that the drivers can set at allocation time (basically
> this same patch just with the lines in slightly different places).

That's right, the issue is:

void iommu_set_fault_handler(struct iommu_domain *domain,
					iommu_fault_handler_t handler,
					void *token)

We can't get to the iommu instance starting from a domain pointer

Do you think we should change the above signature to include a
struct device *?

Jason

