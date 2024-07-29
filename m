Return-Path: <linux-rdma+bounces-4073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C355393F8E0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B81F2281B
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E78155CBF;
	Mon, 29 Jul 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciQqH2Fp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3B1E892;
	Mon, 29 Jul 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265142; cv=fail; b=GxRuYt2n8mV7RXSE5NM4do13kW0MDLhdLJR4xUGU9hzajlSLR3DcXbiEd2eG5+Fd9N3YQzrfoRTVBEesRsTsLFuM9iuAk1HH4qaS/u2yNsTT3Ks/K7+ZURu1AJaTts+2uG0GSOXhOfgl1k4WO+7oJ4cqxplFAODZ1BcHH0YmxqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265142; c=relaxed/simple;
	bh=ZKInK73lMMa+8CH3y58ZQ5BYAPnbL9RB5JzRdL129o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FkGO2RixoBwV3ktoq9VmT1h9LdIot9sqm5PdzyHSkTubadF3ApEIVC4LDI0d1p7ws7jesOyYG+eMZd3C8Srr0SSxUik+0frE7D0XEKdGGi+1iQvR1QF7QZhspQZIUvOGevPTO0ls+XpKsf3n2qeTngZB1aXUKyWIK0XctJ9z2oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciQqH2Fp; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3dKJxqUr4y8XKMQEzk8fIDDvdywmpKFmoQ9lcYaZvArDTieg6uiX2nJj8EAFEow/BG5ZmG7X4Pf41iBp+dGPl4B35j8pUutQEL7fhqOiKI/kUMwPg8w6sHQTYEOFMycbOoXT3PTlqoJ9KwsbQB4Z7Gy7IpAPbd+USV+xEj1bGokqCLudWNlmH7oA2WOedibpMkgqd9pMejeASIzm1dR5OnpWPee4eVpbfHS/j3pHTElCNUzy8UjnbKTkt1yGtBnuKv7w+84usLvgPveeHH5LMHiYqHTZIvIja6jj7WSlpW/j6oPgKVnYdEioZFJftS1btEvvHB7uCqrFEWPTJVxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SsD1i+yqBRkPAO/M8N+64Kp2cji7iII3sBKBMw15jA=;
 b=oSrCdzRQ2x+HyJTjOjNNjLCxNjAmTuHU+qa1lV5WcR10HS6XrZw/0WhDxUuIRncnHmdRvFx8sSK2/Hf5xt9uVYyz/UyFJelbXz439U+NxHDhxVFxlKKegQFE5hFDE5vt/G0W782RgzfRanxUgeyUJVAXAd7pHW8U3XCqBNXOzps0JcWiAkOOVJRkowEQUZnqETM9WyY72fOw/7aEuhakrfxe0ty0iaPKCNFPiqsx56lDH7BMkudFLUkGBi1plp0KwE14aKWuay4nfto7ZXlw6xyYVcvEVwig4Ja9umYdji2QxtsMKXrEjCu1IN70IXZrmKBJModTU0P28wGdOmbkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SsD1i+yqBRkPAO/M8N+64Kp2cji7iII3sBKBMw15jA=;
 b=ciQqH2Fpc4ajbFDfLfauzfGIVkLyna05W+YOnkUdRlCuO2bota7GZ+0U286UFSse1m50g5OmgtJe9t3kFDJATGioExDGCCNk4rZYG1Gqm6XqueweOnzZqWXybTDUjBB2CfvGserZvNPWMXQpQYW2Gp479Jn6n7aXDukIzgQ8zHzygsAh05cgSfeNDNrSVA+L3HVEosaMb2bFZI8CzMYVCrIx4BMQwpmr8XF8bk7D8KIZBHwjm49G/r/gLWWZQdYUmdrr9o+ZjoV7EGCyNAGcHu6ZLAkq1H5Rtt/yKoP6DYc5sQulVlH+KxF7vd+jqBGqk/PiW8zKcmvMek0fH3tupg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:58:51 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:58:51 +0000
Date: Mon, 29 Jul 2024 11:58:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	shiju.jose@huawei.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729145850.GD3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
 <20240729152943.000009af@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729152943.000009af@Huawei.com>
X-ClientProxiedBy: MN0P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 6665d8b8-7c2d-45c3-8665-08dcafdef574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mrcZCMtNVHIqhPEFxe1RIhafgig4TuW89aZ9QiNQT5tAiNiUsqqGWzN+v7r?=
 =?us-ascii?Q?2SkCIl/MfJyhg0NylRBg2WjIR28MG37Cx6eUa1jnWEHpdzaqRvLXBE88iAp+?=
 =?us-ascii?Q?J0Vskzr76PXL5KScDARJKarue1X4Z8+4KVjnCc44C/djCk8r5xGTrfskyugb?=
 =?us-ascii?Q?jjOsHfNRCJNMSsYZsW/91Q2/vxguo79lbhcTLlWLnBm5LWUHCKdzR5D9goy8?=
 =?us-ascii?Q?JKuu+cbRhGE9U/xJsgOiVDQsnt4jH3He3XvzhKLbykmM5GookfHTU2q4qE3T?=
 =?us-ascii?Q?LoU3gTTl7TREiM/Y0XUD56rHjUhnNgy9rOEP+Jh2c3WlWQVJkAjuovAaclZ2?=
 =?us-ascii?Q?CZXwcQaLeh6EvZk5uZMNIp+2H0n4lwm3mpLCy89BvqvqSShPdF2MLPH7gJKW?=
 =?us-ascii?Q?Po6VSmtmeY1gsot/KT+qROoK31HjfnxAdEfIqLnpTsfcAWCArxoP+Js1hoHY?=
 =?us-ascii?Q?IXyl6sXsDKjpPWA+AZRVbztrThWLHzdgsrxLAiZOcZpxsYQT2T9e4tmHv3Bl?=
 =?us-ascii?Q?yvPV8ShU/oPKJfWh61c4Z7uT4Pi8UxkD+yEurGtNrvJcBRl6Q5WcqkPMlf/L?=
 =?us-ascii?Q?brqqPgpwKzGhvcWJDUEboS6wOxNrzSOHPNmd1AVxiFtAlualh/g0rxPV6u7G?=
 =?us-ascii?Q?OwZ8eInVYgoGoSDXRev5pSExjRd935C3Kw4e3lOxTSiztHff0JIelPbBxiOI?=
 =?us-ascii?Q?0OkEEdF7FM0wpZ8v07ontvnr81tTAqOV4VLhV2qz391n+pBdFTFiF+84c52+?=
 =?us-ascii?Q?v/eYgTYoY598GAhiQiudVnWpEC2oc1DaK669pm40zdSw+kKP7f2iJ8ZtbVTD?=
 =?us-ascii?Q?2nujznirVTmjR6IjkPFaW4aqKWe3yw9yGoF3dkI/HGefK5bxaVLtJR2exdby?=
 =?us-ascii?Q?jK4IwVy89aNmWilQHSD10JtoempPQ74fK3H5+GH16biddCsSiJx8DSuAaDmm?=
 =?us-ascii?Q?woJi5wFXUi+jRYdj7dsQnLdxBnorQSsr2kO4OdZgjrMBCwOppG1mwS/fTLJq?=
 =?us-ascii?Q?Ny8Bv/+NyMjoIfyTYf/RWV+ZuM7lCxyjM5H2z6C4RTJ6uTvee2W7PTzVDDpF?=
 =?us-ascii?Q?hW1puWn7rJZM1prA4ay3mUVOxSoY2eBpAQErf02lgHdiDZwfbY+l+0cAkSLE?=
 =?us-ascii?Q?5Isix+U/1Q6w9c1E01MgoTWyaWqX7qDVlpnZKyfBR56ZZaX/6z1CDvJOIvAl?=
 =?us-ascii?Q?6jbxOopFxNz+di7h/jk+rANEzTqJdI7k5nGgw9Z4TUKFpOXUMhSBuAtV9B0L?=
 =?us-ascii?Q?WhIJTYLaIkVLL0AwZVKWba/nOvyOi/f6QgVlkN7j2y/XTRzmuAjwp338rc8i?=
 =?us-ascii?Q?SM4ROyhg7xZjXyxdXEM9u/a83mSrE3AxsPdCpFXn9fr/mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uu76CNHlTNkEUjI3BDYXShyGTrfFzwX41iRlCqs1ydC31orooETH7kLRBYFJ?=
 =?us-ascii?Q?ZwoEWVOqTyCp+3bwonH0U3EdijZ9hqtYgVtB9Ehv/OoIFiB/okR6Jj/utTMw?=
 =?us-ascii?Q?mJFX7EaJCKsXLxu0UvVQQEmGEuftzo6eok27UgnPXzX8pMku5iFQMcah6fPY?=
 =?us-ascii?Q?yPBdfAcsDsgWkyNTR38aiREcq9Fxut6WYztbv/7cSJ+6rDQblPU3o4dyusp0?=
 =?us-ascii?Q?Shwb3ixtQkql15RGqhprqHfqE2py6CPvtdFzOdUzgxHbqTR824aH7sVuyg+p?=
 =?us-ascii?Q?oAttjtvvSNQOrDz1bmC+jRqEVNhvYoJ+4j43mkoyWPHLV1AH9Ua+XGonax7+?=
 =?us-ascii?Q?tHGfPwV35tRJsfUaiiF0J71WywIh3GtMcqZVM4/5lxmCGThfOObzOfqRH5GK?=
 =?us-ascii?Q?PpyERRy91nXL057cfq/6TkQLqg70kYU/G4AX9hy7qQ1eavZ1YzcKvs+VX0pE?=
 =?us-ascii?Q?SiqMQXhLLXiq5RxhMr5VFE5JGArvAmgpqW8JCRfjqZdrMgF5RdT/tHH3GU51?=
 =?us-ascii?Q?dByIOTs7hF+uM0GI568p0TsiY6AZi2s1+Xd5To49lbxhAsgXbNBED51+PrYu?=
 =?us-ascii?Q?EAADhAbX7tiBJPEgpfF4gYzYqRUu8BbXwqQG994pBlmjysiGIqA5/ds3O+nP?=
 =?us-ascii?Q?Ur6ZZUdWULAec+MRLP8ru8lMKKfrI9GJvsvvaT/PLhh3EspyqLF9/Nxsd8Uy?=
 =?us-ascii?Q?p/d1WGZTKb5ysgPpQ3usVXeW3Q7iD6dy+doe1GFN69IeCVr8jO4CgHkxbk5r?=
 =?us-ascii?Q?CZokSEUEvX0nk5QiMrtz9WTBLDSKOJms9Xc1VJDld0ous0FOMliPg9xJ4iYd?=
 =?us-ascii?Q?w9y/Xl1ehlO5/Tl6TceWiGiyRVPYEQWWb43Hx3+SANgnGtWJ8Z1ALWlfSmY2?=
 =?us-ascii?Q?RMa3BWR/oZMVunEMvW0q9H0Z4yQ5aG6oFO2meljz9eqlZu/xZxDVgdof2zP8?=
 =?us-ascii?Q?YMP0g3R3RZ1c4GTSlJa0zDh8oX6TVhSHnPp4E/u0DQa5EOT9+c9p1fgnmzkE?=
 =?us-ascii?Q?far41lFnN1yGZP19JGkuGQQEk3AkgFlsrTE46cV+zuV/Pj74lFSYSU9psShI?=
 =?us-ascii?Q?AY88Bfmvh1NlKCToKCvaxxRL8XzkOCI8Dy3DiDcQwuSTW8Y2Fermm6JESoDW?=
 =?us-ascii?Q?FvZDwMjt92egXpjpaCjQNshyLifNMhfIaMe0uyvOoUjqGs+F0szEvI3sHo3W?=
 =?us-ascii?Q?BfCpW09K8EyslSRsegJ4ogRA7Pv61Yyf7biJ4aAN3F6x5EFIElmCDXddsfGx?=
 =?us-ascii?Q?rPG3/DZv1bi1ZhyyRD8CQXaNx8Bi2zboco3zpd4ltB964sD4LM6LkaDimsT8?=
 =?us-ascii?Q?Sx3Mhx5hSQBM4h7adKYngBMJ3QwBduZtIaWbQQtfWa8wsa/b7Wy0Mkxg+zCa?=
 =?us-ascii?Q?FugcowcwU8/jffgkiXf+cda7z41WRAKsiV3Kyra9FPZQdCLoXTOPEz5WlxbR?=
 =?us-ascii?Q?nPvVPV0YkXrEEflni2xEw5x8hIOr5SCspgxLrDgD2MloRdlKXodKUVuGFAMH?=
 =?us-ascii?Q?aTNR73lYRTuuDa2GIwv7VKx6E70FeIPcmef4CSW0Qz5XuAzIFuf5bwx6Qu+Y?=
 =?us-ascii?Q?9noU7XnE/y3PFvWpf5JUEgA3co+xhmuaWp5JUZb1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6665d8b8-7c2d-45c3-8665-08dcafdef574
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:58:51.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNvkJIR3CBWxrv9lKn/VjVelf+9koaBHDByqbHR8JLO1TMBD8vRoH+FUJxVyyu8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

On Mon, Jul 29, 2024 at 03:29:43PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Jul 2024 15:38:39 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Mon, Jul 29, 2024 at 01:45:12PM +0100, Jonathan Cameron wrote:
> > > One of the key bits of feedback we've had on that series is that it
> > > should be integrated with EDAC.  Part of the reason being need to get
> > > appropriate RAS expert review.  
> > 
> > If you mean me with that, my only question back then was: if you're going to
> > integrate it somewhere and instead of defining something completely new - you
> > can simply reuse what's there. That's why I suggested EDAC.
> 
> Ah fair enough. I'd taken stronger meaning from what you said than
> you intended. Thanks for the clarification.
> 
> > 
> > IOW, the question becomes, why should it be a completely new thing and not
> > part of EDAC?
> 
> So that particular feedback perhaps doesn't apply here.
> 
> I still have a concern with things ending up in fwctl that
> are later generalized and how that process can happen.

My intention with fwctl is that it should never technically inhibit
generalization. Someone should be able to come and implement a
concurrent kernel subsystem to operate the generalized thing. The
documentation attempts to explain this position.

I don't know anything about CXL here, but broadly you should very
thoughtfully put things into fwctl that are single-instance and become
"captured" by it, because this would impede a kernel mediated resource
sharing in future.

Like continuous memory scrubbing and EDAC is not really fwctl since it
is part of the main mission of a memory device. However evaluating the
memory to measure current ECC error rate for data collection and
debugging would be appropriate for fwctl.

If the HW can't share the units that are doing this ECC work then
ensuring fwctl is optional and secondary would be the best
option. Turn off in-kernel use of the scrubber unit then you can use
that unit for debugging. (as an example)

Jason

