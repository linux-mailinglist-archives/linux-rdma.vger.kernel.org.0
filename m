Return-Path: <linux-rdma+bounces-14022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3117C01CAA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B451F3B2F81
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD932B9B8;
	Thu, 23 Oct 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LaErF0yY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F832D42E;
	Thu, 23 Oct 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229628; cv=fail; b=ZAWQxp7FQH1daVBNuGBEPDmESIlrrOUR8Z7UnIEqKkFG6dUHcT2WviohGfbGz7OGl/UAMcZzMOKr3WcIz69NpxK/BzTjzy/P2cmcIDRvc9OX8yFZ3KMHmmGkmJiqozYmEXv0whejOxP1JbXHt2PtdhChwHXFRfikRJ6MtndoMr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229628; c=relaxed/simple;
	bh=qN5JwCu7cUjAOU4gG+BuRiRb87l1Dw5qDqF7FgxPIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pv7AmpCnUlb6gSRgQ36Rf1MXDgc0N4WPHbwkELdFtFuqr08+s1exZEjUCxo5t6uVTHanbNfhWuvYCqfyKIMntn98h10ZeEozDGFYA6XwLMrbCLNsDELI7he7Z3TyksXqxip54kzxwK29m+vdiDxr9plsT24jRDhuzuvaTNMfv7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LaErF0yY; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp8r2qlkb8MJUBtASLgWR8tbYPt4j0hjPFfjBf0U1gLqvP/APV339QBhHinJObhJeRWznN4ZGLeQKOazmh+0rNWHD7DL4xI0Xim3suiTTX3IRajV4qSITkxYnBo4H+ffci9RPsikFKJFWJGUVqNxxCDshqPFJnpaE/T4LiRiEKdKd7UmmsoiPw6RbcMqVBXtqWGPssdaRHAU/bG5T3COUj060MCzFz9/+Ra/bb4S6IFe1kOa+yZjQlo3ev+6h9idTOE6nWtoGKJZKMRoGIGAVNJBz5stzOU40P6tkX3Tv26l5jyVzPqH3bG+A7qYhhY1OVHQIkcrgRuHhrQgTUVNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L70ISb5udTSOblj/fwUOMONa2wOnc7GX6XtX6syjQ/A=;
 b=VVjSeLxDXb5u2xQmfLsIG4UB8Ao2SunI7hC2BlrivRlhLVBqxxZ8tdVIINqQjllMKbc8rUcK3CYUl/210j819t+VW/Pix6RPqH/IegBqV8kO978M3hvcjRmE7uK546Xk3MiwEkm8I+5DHo6yInBBs/YoXaET4kxo0NeHbIvkUCaTq9e+eeXV7xqShDlS9rnv6XRl0U7+dlRHAgqpHzVbrkljLf/Dq5Us2pvxINvcBdm+aW7PyY1mvZinGByeYN10gMYo5PcskiuBP26FIF2kgFabuVaZSwnT+O9+rqHwDahBVlWzP+8iPbIOdxKAn/2qTciSaZodjVDpYaZqsE6JVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L70ISb5udTSOblj/fwUOMONa2wOnc7GX6XtX6syjQ/A=;
 b=LaErF0yY2OGFTRdwOOBIuM8AQuBmFbwSZxykaJNzCpKBNMdOLZOh/GpR8OBxMw8RvXzg4sAMQUVTqml+kPykHZ1J9kuBTHwNqCDbE47enKwHswgeDWB9dht48haicoE8Dhz4r2WSEKAMR55TKgbhqaas6knd7I7RGxnf6X0e981MRhoSmV78FQm0g5DrSQxJ+05zn2sQ2EzZP5sSTm1ObnE0e3biWJ8RdayKBDGVXqVXfS+t79lnqKfl1FlMYQ+ELOiJeDN4Qmkx2BSyGVeg0BB5pnmVasd1hOTB+ixTj6cC32/p+ev3eoBBQ2P58zQlGYQKqzB3RFMOmlZdHFIAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:26:58 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:26:58 +0000
Date: Thu, 23 Oct 2025 11:26:57 -0300
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
Subject: Re: [PATCH 2/3] iommu/amd: Don't call report_iommu_fault()
Message-ID: <20251023142657.GH262900@nvidia.com>
References: <2-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
 <579bdc4e-ab71-4120-8991-34400d4bbf8d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579bdc4e-ab71-4120-8991-34400d4bbf8d@arm.com>
X-ClientProxiedBy: MN0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:52d::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: c37b7ba0-f2e7-4046-2c9e-08de124038ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?REoMElNXr7jlpZpQ0trkmXGqAvhAtCOVDrUD7ZC3d6Bo4zbmrhp/QmyjCcJc?=
 =?us-ascii?Q?ACL5mlwUlHjKr5xscknjKDRZk+7eRPIOiAlLDFTYm8aUHRmqdE2cwPs20rxa?=
 =?us-ascii?Q?MY0ZHiJEqAesUxza8xzvLWghFAELg9Eo7l6b0awNlZJESRnIbsHPlmtRAggR?=
 =?us-ascii?Q?ljzXKI24GVzeJvL2k0qX1MspcvWSw0sMXN3Z5tuQnVDMFvFg5RjqOyt+zQCe?=
 =?us-ascii?Q?814mNcCJhybLJs99SgY7SKGoF0mrgEhOBzritDkgyW4GrPDwdbDGnFm9aHmO?=
 =?us-ascii?Q?iwC8dhfzNLjULsRuS8qXMMtvWfNI5ykGLrjClsB7Ox0c0JVcpSA8CvagL+XZ?=
 =?us-ascii?Q?6NjagHdoLPGLn80OLhsVbpITZpFWSjCw4HQZQsibZL2fDmKhmL0uztNk/6eQ?=
 =?us-ascii?Q?vaHpNR2aAQaI2zLDjnCuKGPN9jTuu/6ViE26DhxjrOr7ugrTs+zR9NYuXlq2?=
 =?us-ascii?Q?50Z8DxxW4gKE5mwkiAAStNXnIs/in8BUtokFx4ZbwgAF+PNAhvCGyIzVJJe9?=
 =?us-ascii?Q?GG5g/QytWP89MJHgSXrqN9c9Luue8CAI2tuezwuaCHqTIf5d8UQVRsCl9B5m?=
 =?us-ascii?Q?zC0GlqprdBHsUn/C9pA4mpn060x+g9y3M8GBU7IWQfNbEdXITbO9wzoMdays?=
 =?us-ascii?Q?0mlvA0FmKr2swbq3fwKmyqCp1uM+f8IbkQssBW0DomVPe6P2Es+oTWx3LWlV?=
 =?us-ascii?Q?D4u5toI0Kfs+jE6apiAIYExNIszAfQC6EDxOIpX0HIUCRN70Cuue2cjfBKzR?=
 =?us-ascii?Q?HExZ1Dr3IMLfMgg1Flxmt/BKSbISgLgGdUrFD+9uLZYfSWuD+q5F7OzzspuI?=
 =?us-ascii?Q?RRwUGTiVNfEFTo1bzbF4LSNiPKNkhxd8hC3mG1bjD9A0pn+fsFMwh9j9f/e3?=
 =?us-ascii?Q?EIhfvJ2BLEYjDaMKM/Me6fXYPlukazqAvZ84qS2eX+8YYpWnwGn61xtxH9Bc?=
 =?us-ascii?Q?Ye+PGqV8hbz4lWHEETkWxZiYCvo+mGGHt/e+HqQymnvIpFq/afYcPUsu0a7b?=
 =?us-ascii?Q?7mAyEYXU8jrX0vuw2tWsiaBAwGCWNCuiYskjiG0uHtQ9t4d+bH6Uwz7Jgw89?=
 =?us-ascii?Q?pgrQZTLrR00rEKcD1CChL9DCexTkFNxOC7kJY9OR+yJbK9D18lGNWjH5ZeyB?=
 =?us-ascii?Q?97hXrX5UV406hAQWiGS4N9cba23nhNrK19axK1xo5v0e1U1kuN+rt3oAWMxW?=
 =?us-ascii?Q?16DTnVfL83hdrpglC8745dqVY/+lRa8Gd6UvedoGrgRFLhnXIQapYPNadtMs?=
 =?us-ascii?Q?9sH0WzZa1DWiB9tFhdkFlkoxKcc3IN91VedhQXnbyDYOMznTFTgPF3GcNu1C?=
 =?us-ascii?Q?EQ7E/wN9C83ynD5T2y2TA0r838DqAp0TcpJap2exz3fdpBaCiwdEGT9wBmR4?=
 =?us-ascii?Q?RAHrm5diAHmMrDDFdCDRM6M79GuEnOfATKfEjRtgkVIjikqYM51/WOy0Wzsa?=
 =?us-ascii?Q?oZFpnoY6pPZS3RLudwq5v+uOZckB7DyX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIvtdRJKmggPKpS4XzTl+AxK0XCRneZRLugGHDAH/DQ7vn4nCwiEGLjRg6C+?=
 =?us-ascii?Q?QEfBX6hxqBrbcRK4pJmnlWYwqWCEWEeNFNII9yypl8o0TWzCYYf8lKUdXocC?=
 =?us-ascii?Q?LUS06atd4NNaCFXWqojzv6RS5h/tl1E90l4RO/VE+MCuH51NvA7ctriotzZx?=
 =?us-ascii?Q?vkqXhWMbm4KwFRWAqwN5+ZjQf6KS/mmUV4irI7WNMtyKBm7IvXfasOTP01xg?=
 =?us-ascii?Q?VdFcMlubBNvukVIliV465/3/ZA58Yc2WYRiqKLfrbuxd5Eo4hzEOganLakUE?=
 =?us-ascii?Q?IwgdB+MiFP/uFbzdEASsqjRngcfTCpkp0t9I6UzlGrLlP29YGMUY8lr6UwGT?=
 =?us-ascii?Q?/zZ2mJyOavbK6+WfZqrX386oIEaezFx6H5tD8OXyrIJajATDsN4zN1a2t29u?=
 =?us-ascii?Q?EzIcDIbPRjdmtLJCDpcalfXnCd9upBVLa8OY2dFb+EHlBirEz/zDzhbOI+1h?=
 =?us-ascii?Q?PVdpHrVJxT0LFsWNRu6krdjTrrypbK0DIxL9j2qJNW4kEFH84C+Vp0NB2Z3/?=
 =?us-ascii?Q?hqmY+9jLSDZgqJHegfPpMYfxgYx73GxwwfCKZHVdw1+0acLDa9nOuJtRY9Ar?=
 =?us-ascii?Q?geRzeQiCD8j7WRI4eItZK+PCpn7dR5iG9M45J491cCjr+9oWH3hrbmfS/3b1?=
 =?us-ascii?Q?g3YSJYMn41rAQuS5EXDatyNciURZneDVod2B6OuA3azESLWjNxVe4f1kufh0?=
 =?us-ascii?Q?ks56027rwjP4vyQ1KMErvo+d6FJawGcFdyvx/iraWKaqyHefGiTKvltBxjG6?=
 =?us-ascii?Q?34A4W0yXNUJ2SEJ4UeTd5t7C5CKzkNWwBGXPfzyaoz7wxoc/LUJhmfJmICG2?=
 =?us-ascii?Q?dtzbjyQ16CnaCcb89rvyAKTUsiR783EmFDIuxSHjJGektForohww2yqlR89k?=
 =?us-ascii?Q?2HgplBidOcSg8MKC06wJg3VCAjxm4l0FrpaIE/KJpQGJr+ogM12Lcf9Vvemi?=
 =?us-ascii?Q?Ez0V8Sf5Nv2v1qxgyI6v/JVG0PfYZlUUyFk1V1I7FEFwfKeKIduCCVR52Whu?=
 =?us-ascii?Q?uX6lDhTHmvWPHqs+iPUnWiOpBEVtzTrssk9mDT01NTPXBt5/WSVn2BUYggbI?=
 =?us-ascii?Q?WU1M38C9U+ux9BMfIf9V/dkD8rwllMuY/C8bvjXAE8vnbnE0f6ybFmOVfEc+?=
 =?us-ascii?Q?honl7t0F32n+wZ6zTE0V/U5BhB8qREwbX2su4WamTfvcqt4ilrXQ9LqI6orC?=
 =?us-ascii?Q?mKCN6mrQLPPH9mbF/jd/RTmFnYF1a0Lr8gE1cFyOh/lIWg5vxWguSgeqzaaK?=
 =?us-ascii?Q?H/5XhCbS0MGLpHN2rex8ZkpGLyrjjhBGvdEp9fhUcVbfBW+izJqeWimTdNTM?=
 =?us-ascii?Q?PDGi9Uc4uBB6NgDdE5cOauDHJaiG6JtHMWv4J8z19mD0t/RLAZOFfBW7uNlp?=
 =?us-ascii?Q?LcrsBSLLls6bTPsUjDJ1uNR3rW93OBcXS+rhKDsGj/Q1BTngox7fz+zsNc2O?=
 =?us-ascii?Q?SHZhQo8YJBS3N/cXO0ieny09s0W0RyNU7OwJ6du/Mt8GcN/eQyaqn4hTuuvb?=
 =?us-ascii?Q?HB1nUk2T4JuDwcLrzVnYm2A9BB1KJPpNJUKnt4PjUQaGyUaMW3lb+fv3/Ed5?=
 =?us-ascii?Q?esGHrKw1Jl0c0NwTdvg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37b7ba0-f2e7-4046-2c9e-08de124038ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:26:58.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpr+5VVnFFAJZN8NC2yB3UKQMBqLMY8fLwl3qLZbc2arRFa2jX5ypiTBtyzmw3Ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743

On Thu, Oct 23, 2025 at 01:34:21PM +0100, Robin Murphy wrote:
> On 2025-10-22 6:12 pm, Jason Gunthorpe wrote:
> > This old style API is only used by drivers/gpu/drm/msm and
> > drivers/remoteproc, neither are used on x86 HW. Remove the dead code to
> > discourage new users.
> 
> I'd be almost certain there's somebody somewhere using remoteproc on x86
> with some FPGA/bespoke PCI device/on-board MCU/etc. - whether they're doing
> it on AMD *and* care about its fault reporting mechanism is really the
> question.

Hmm!

Looking more closely

static int rproc_enable_iommu(struct rproc *rproc)
{
        struct iommu_domain *domain;
        struct device *dev = rproc->dev.parent;
        int ret;

        if (!rproc->has_iommu) {
                 ^^^^^^^^^^^^^
                dev_dbg(dev, "iommu not present\n");
                return 0;
        }

        iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);

And then:

drivers/remoteproc/omap_remoteproc.c:   rproc->has_iommu = true;
drivers/remoteproc/qcom_q6v5_adsp.c:    .has_iommu = true,

config OMAP_REMOTEPROC
        tristate "OMAP remoteproc support"
        depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
        depends on OMAP_IOMMU

config QCOM_Q6V5_ADSP
        tristate "Qualcomm Technology Inc ADSP Peripheral Image Loader"
        depends on OF && ARCH_QCOM
        depends on QCOM_SMEM

So, I think it is safe. I will revise the commit message.

Seems like these drivers are definately used:

 drivers/iommu/arm/arm-smmu/arm-smmu.c    |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c  |  1 +
 drivers/iommu/omap-iommu.c               |  1 +

But I wonder if these are all dead code too? Any thoughts?

 drivers/iommu/ipmmu-vmsa.c               |  1 +
 drivers/iommu/mtk_iommu.c                |  1 +
 drivers/iommu/mtk_iommu_v1.c             |  1 +
 drivers/iommu/rockchip-iommu.c           |  1 +
 drivers/iommu/sun50i-iommu.c             |  1 +

> >   	if (dev_data) {
> > -		/*
> > -		 * If this is a DMA fault (for which the I(nterrupt)
> > -		 * bit will be unset), allow report_iommu_fault() to
> > -		 * prevent logging it.
> > -		 */
> > -		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
> > -			/* Device not attached to domain properly */
> > -			if (dev_data->domain == NULL) {
> > -				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
> > -				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
> > -						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> > -						   PCI_FUNC(devid), domain_id);
> > -				goto out;
> > -			}
> This part is unrelated to the report_iommu_fault() call - in fact it was
> specifically added even more recently.

Yeah, I'll fix it

Thanks,
Jason

