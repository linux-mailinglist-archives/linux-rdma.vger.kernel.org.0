Return-Path: <linux-rdma+bounces-6312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BE9E618A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CA3283DC8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B01D5162;
	Thu,  5 Dec 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1oyBAQi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43911CBE94;
	Thu,  5 Dec 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443103; cv=fail; b=PHbe5PCkTUop4gaUEFu2mIV5CtgQikmiCbVIdhwFwUINEqP8z01gtenENEWNPq4A1sVLW7G2qcjUeeuBTllAUq7nwFo7Ek5QXLOwV0OwAop/1yrnNdDA4Xd8NOJQku16vtF8ldyp3YdeREUvtQL1qNyKo0vbnPnx9y59yzEbZKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443103; c=relaxed/simple;
	bh=r7jklOeLjnNyaZIltwwXSiVAWrAaasyW0qd9zxi6zSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gv15FKV8+Iw9mgGTb/zhBiWvKP3wI3ypL6sjKP6TBrmKlRklxqrecEcEd52gLAsmuqJu9CyvlTdKIRkcjSfdoqOi5GLMDvl5NHTVG8MVIplagIh7VOYhHY3fCA5WX1ykxlmEs6/qh9NX3m/M/aUM2ibo/hyVjlgBvp+m2LJASSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1oyBAQi; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sewVkErSypzM6DAnbOvqwyoCR66IKrTk/cMqGxUqxBdAM80C/OJ6qjjmreQA3rt7JXkc4SovVgOoLQRqUz3NO1fOhxGXy2bidZEJ9RGfWHL5/KktBEPXD0Mn6NibKTBLwKN+ZYHuRDFBvNaPM2Ldxg5WVNVE3JrdlQPIpmLIqu67sLHbZX33zbwIRJouv8xgl4Wd0Y6UxSlYUrtCgD0s0YIsdhCFO6LBZSttDZEdbtuKRA8uO2hTd3kZNQ4DKZjbWdOrzs33adO0nSv30NWl7+7riUVeV72JO4H9urQ67OoBsOcu7N17cGocH/KVxLU9CKkrhbWi0p6vOi10ZYw03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HEnGL27Zs+Wt9kSaeB+P9NPC1vs8UPexDN+dk6hOrI=;
 b=nYNItyNpk0dIT8ttVnjeHmykriKp3Jep7ZFOlZzOFj8SuQ/62SwApGXdKKguVn4kKI1cfzEKrO9NHRqmyn/5blcvfd5TrL3wGW/lQ8Ro6vIwtgznB/F72K4DGRGOLghIwAtZU4BCbZFFqAu21bVv28tXuUDVGb9xrxj+ODpKvcAFaGJHVoYyrOq/Gh+g347SI1C+UI0zDw2q1auzhPb3WAe+wXPrOHsKwu+JFuafQ9ATwX2bLmtDCIe1a8EwLNVAJq2IyddY/urfCi6NWDcJs9jXeJyRF/j8QddH8N48Yi2RwhyMnN6/KytVyaIGcomN5mtb/xIy30kn16rr1DYD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HEnGL27Zs+Wt9kSaeB+P9NPC1vs8UPexDN+dk6hOrI=;
 b=m1oyBAQi2To8OdoEFoanp34mTm6G6wXUwgKxw4zxfONUAY5s+a82XHUBukTmapeHd09Bv80Tx41q235AkoCMXGAIhc8AaxZU7bKxoDDmYk9u3V3qBrvnQetfuzQFvhPob6lH5GW4bJZQx5iIVORNsUb5Bg6RwS0dALNk0cuq2OA2lAsJZdqkjdLH7YlAQG9x/rBeWp0pksbP4Asr32wnrsL46YsmEb4NGtT72ie5MVO4GNYGi5WxtHOlyvPP9eHGUQnDncTFNdrDU1pgd2tuCFbuQNOg3LX6CSBAj+pwSfnn3fCV5tUETgNvSL4D55gkhbUmYkvGAdkjcDlQB+Jk0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Thu, 5 Dec
 2024 23:58:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 23:58:14 +0000
Date: Thu, 5 Dec 2024 19:58:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, kuba@kernel.org, lbloch@nvidia.com,
	leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, saeedm@nvidia.com
Subject: Re: [PATCH v3 00/10] Introduce fwctl subystem
Message-ID: <20241205235812.GP1253388@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20241205222818.44439-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222818.44439-1-shannon.nelson@amd.com>
X-ClientProxiedBy: BN9PR03CA0964.namprd03.prod.outlook.com
 (2603:10b6:408:109::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb10b1d-dccc-496f-8d62-08dd1588ae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pwSakhJ8OjFdm84xUQXkDj7G54DBs7M33yrl0B0SmBWTdFv6FS4bPZyhXZE?=
 =?us-ascii?Q?uyglfwnXN/yHUknPOal2a9jG5DVT4THygHkXJSSS4GDKu/rf+Q5OF6trzaXj?=
 =?us-ascii?Q?FMBS96W51v+guy194UKoMZNddRhJLHTjuZ1AaWX8lhSk72bidA1ovuwVEEiu?=
 =?us-ascii?Q?c81DHYeODe3Mh/p7lTxf1GrSfe0amcJqyMQuPoJQ+BU2e/927pf+ugFDRAio?=
 =?us-ascii?Q?Si6S2s1+hoVoTZ66kU8C33l8jYdKOX9AtdmEW/YZN6CC0lkOJwYyyNt2QcBA?=
 =?us-ascii?Q?WhDvCo4+X3rNa4ipc2Ul50W0sjfJJ681FlSGlNH2k0/9CttOo+8qkYd6m+er?=
 =?us-ascii?Q?oDODgtpwL70NelN67CSkrw1hsvvaZOELBUb5i3jqBsdnvA+xiy11Rm+OYqsO?=
 =?us-ascii?Q?v344NYbRAGgY2VhaSGceafjHLkELDkhgc31JMnBGqcsJtJrXJST8kkfP/85L?=
 =?us-ascii?Q?fPKXNGAJd6Llle1XmrfWv2PWY2xIDWsveRT7A1bZp04vKh0Gg91qdX2PLwXm?=
 =?us-ascii?Q?H5q/dBj/EiLEboaODvbBza0rqq/jZyXK1vQVVlh5sM58130sldMhciWMr3os?=
 =?us-ascii?Q?HQd9C9st9OdcFHZ2iE0/JtRPTh7r1/0X3HqOxTGvj130dh4uuALK1JIGpQay?=
 =?us-ascii?Q?W3N3SOsS89iNJTLOHfB9o4vTRmJGrvku9arMQqnBXlxNtQzfyiovip4Joy4v?=
 =?us-ascii?Q?yLnmJj3bpjYTEjciyIW1jiETYykccZ/Q73xA6lJqxbMRYeR+RPumyCVSFiWK?=
 =?us-ascii?Q?o2AkI2sFfD8jjm86Bs6yNRVltIikDX2AYMo2mzGim9cH2/P5nSY00fE/hoPv?=
 =?us-ascii?Q?a4XkkfMea/9X3ihQ9elVqJAwJybSlMsynzJdtOOaOxSgZea+C4SvxGagAnRk?=
 =?us-ascii?Q?sMYXwU9JwtKfFJHpXhoYorb2SOqS+AYlZUrRBGDFtSzn5/u8wp/t2nsOqzZL?=
 =?us-ascii?Q?mSrsPCEf7hVMW+bxMEs1PVDvu83EHR+Vbkk5JNqC8LOQc4BG3QAv9kKeSmqd?=
 =?us-ascii?Q?POXEF8Cru/lzQ4ZAFT2OMWWVvwilEi1aPeGxNHJTA1EfeadSJS9G6GvELN/f?=
 =?us-ascii?Q?iMyGzURFbJo9HFg5OJqs9/1Df//9zxqvf5n7v6JSB57puspXCX1RNJQ5fz86?=
 =?us-ascii?Q?y7t138yzPB6JLlyOT5VOCgkMfHzsZKyuyKreYMAvZct/vkNUMwruxqxA9d+q?=
 =?us-ascii?Q?ia4/OitI6JbbICqRxEMi5+XATSAxOxbwmocOD29oa5TT6N4wuiK4vLqaCzqj?=
 =?us-ascii?Q?e9DwZUoRjZzCvOcZvJJNI6W6JjnYNRS+UF0pGF+USdfjPsHDuBGHjp7HWsaK?=
 =?us-ascii?Q?sq1Jzke8oGBEFwQkk5M57o3TYu7qCtaydpGhZFaFBdVAcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ri9G/srDmXsfnFq55zV9jjD6K1bcX2ficfpQNK/Uw1J9yGfUE2tQY/Q8XYz6?=
 =?us-ascii?Q?apRdZNdTk2Snt7/H4QzXuDSgihMbV1LTPbJeyqMg/S4yXLKDEZxHYzPnNFCh?=
 =?us-ascii?Q?3zGrDez5FFozBdEd3WPvLrTERoDxR13QnmO5OD1C/md+9KXJcdgNP7SWTTgP?=
 =?us-ascii?Q?OOrS8E/q72e0v61veWBW5RDn2exDpwbYH8yMQgBU6sPXdich/fbeaRenyxQD?=
 =?us-ascii?Q?t4yTlklEFmVc/6hZW+P2Kkx7RfxRYQUxiSxNhI0VPTrPO7pwkuTx0hZlShAL?=
 =?us-ascii?Q?8GPVct8t4I2zCrQiZJPb/K4UFFGluiMbBGf3pyL3zfGznjyISt11X/vH+HWp?=
 =?us-ascii?Q?Y3+yRq6uNPAkGIU7yfcGYFSrbgXySlzVB0jyHQaWUpFrURzl6zwxnGq7p0Bj?=
 =?us-ascii?Q?5NQh0W+3tBvZVwnSWkO1clDJ/LQBkA6FG3bPCz9egWCNSTFExQJPpIl/YU5i?=
 =?us-ascii?Q?VZkK7HD9QkkbkHZQ3NgYLuuAPs7j+XwKxWBRl7oe2SgsszyPrPpTqysw9ZVD?=
 =?us-ascii?Q?Hyib2K71I5MJQg9tCg7e7ik8WsdYU8LBnFQo3q0Wu5E7IZvcNNfzLOUgYd2K?=
 =?us-ascii?Q?6gk/toaR0aywqCFR3Ba5m7cZmHOekd1H088t0GK6K8SXNinpsi7V1i5VCXg6?=
 =?us-ascii?Q?0IlGTag2qzTyratgO9HP1FP3+6IdDuseJzmXMBs0KO3dsgfLqaA3JacWA1FX?=
 =?us-ascii?Q?P3pyeIuzCSP6QjkO9fFw3BpmASOiQeeZgkk/EOCEmaUufUPbbIanm5eO33fh?=
 =?us-ascii?Q?zOfo7rsl6rwfQjXvcDi1b012EW0KRHRxRUguuPJGKMWk+DZerg7lnNzR1P9k?=
 =?us-ascii?Q?ZzeiRehLHrodlvQbL37ilRdF/OEHFbj16Fhy+LWXmkZ24LC6IAVfPtUdGUic?=
 =?us-ascii?Q?WkRKz+5T5+gRJ5BcReuqE2UDYuNUfeYxQtKyTxBK4hqqV1qjdOaJbqCQi2B1?=
 =?us-ascii?Q?A4/K5iyHJHPDoOrs5Za7CpmL+IwkKB2PsCqo90RpkOQ2/VLpQrVKSVDFLxcf?=
 =?us-ascii?Q?moFLQ4BSxthW68AAHRrex3MgWqvHVQpzFKTf0fK8/kZzdIMTtSg2t9YtVNiO?=
 =?us-ascii?Q?+3yvBwYDKwMr2NN1o85yt1cRtAtl066VzEN27nRj46HrTnl4pLbL7pBK8J+k?=
 =?us-ascii?Q?GxRLZLOlYKSi/IM51bgl7OM9H5jLVX8yBXhF8RSjIx+l5odonK0ONjWrYI8C?=
 =?us-ascii?Q?I+0fS/ZeixCy4odoIY0MhSGNuifeLXnxualtSfuwA9yE/sQ2B+46oh6FGUBs?=
 =?us-ascii?Q?FOgiAvSir7yLFbbpGDhakdk/IuT5Ro+iz11SptZUo1ZIc/Ju+q17i3JbtNSR?=
 =?us-ascii?Q?8IdSlEXnHsXQELrqIW8oHUqpvuiIsDR8q5JVGSbhSv2Hh1Yp1p5ccpP7ba4z?=
 =?us-ascii?Q?fV+Z+3uxQtfrfddJpI5dj1jpUrLA2PZan+eFUx8cqHYA7NGZDMxlQ1fFPu1k?=
 =?us-ascii?Q?mL0GhPtjZsNtvqYukhkQXnzgFQ9vcN5r2LV9L/z0iwcTsFlKVKXsGNsnZhPt?=
 =?us-ascii?Q?BI7yRVAyoX1+4HW6GmMi8s3r+t8Ojy97d0C3/goAMMEFPkMPaB6c9Rj8QWEu?=
 =?us-ascii?Q?2v0ct0UzBwWa+IRCo0bChan+n81s7mwLJUreCr6g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb10b1d-dccc-496f-8d62-08dd1588ae29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 23:58:14.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJUPif3fPjEj3HXpNz/g0k9ewmzICzz1Ghwr5eAnhzDYm6BRfjW1lU41v5T75FfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

On Thu, Dec 05, 2024 at 02:28:18PM -0800, Shannon Nelson wrote:

> To add to the support, I can say that we're building an fwctl driver
> for our Pensando DSC device and likely will be able to post our first
> RFC after the winter holidays.  This will include a couple of updates
> in pds_core for support of a new auxiliary device, and a new pds_fwctl
> driver to link that to fwctl subsystem.

That's great Shannon, I look forward to seeing it in the new year. I
think the CXL driver is getting to be in good shape so I imagine
a possiblity to start to move this stuff into linux-next around
Feburary.

Thanks,
Jason

