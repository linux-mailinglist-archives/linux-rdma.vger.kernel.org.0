Return-Path: <linux-rdma+bounces-5280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6759934D4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 19:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9AB225E8
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248401DD872;
	Mon,  7 Oct 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gxx+Pjz+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59F1DD558;
	Mon,  7 Oct 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321778; cv=fail; b=bIedbC+gnL/w/xG0UoMLaFhtfM+fjPbV9QO+gb4xDbNRRdjQaU450h/y2BF683nKJmoUOwqiNC8uqXSwDJAxlxz37CVrlG9EWWilTwVfPG/PAkup8J+u9fZd5ee5WiFuCVlbGRsKRW9BxVe8DcY6PPSUXJ0DBQDEithvsnDv8M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321778; c=relaxed/simple;
	bh=yZzYwig+1mKOKHMiN16PsU+sA/aC4y5ao90DMDbzEAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVmY7HB7y0d7zYjp2xxSVfFdB5d09Rbjq2WNC1++R2obAyWgKWghm61O8LXcW2oLjZq33Q8GTXoVcwkaw2UVbo7yzqxG+8b3WCC1BLqg07IZAazmegIp9wr++3QqDwlPYMFoPZ1oysd5KcTsqdsrar8iRRY7i1YwhTtnFCCIS3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gxx+Pjz+; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omCdqxxTMJvjWP7U+/AAuCCdr5ByTvCdPXyuCMVC4P3iAe3iXx5JKMwQspNJLL3zzbUwu7HbON8jV7n6hNVnX5puugc6oJCAMvZadypw+6KYjCULOM405HLfObPVy2Z/Dka1n/GrGAkAUrd0svgvJjOhdKu0KzRgurZgAvd5InhaTo6wtdnpSgDDi+QIZ3P0Cejg4AirbZblohUu1GYyiBkvbiBqbf+Qatk5efA9gBVuKIDqb5XS6foePEzovgxusJN8vq6oTrvb+BhmeLpldHkJmqFVxPPFMXcrXyeaQjk1IcQe9hboqsW2TkOzk2ahrcHjOvR0IccUSRDmMVRUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0VfYzzdE1S1evYyZIDGihaoKHCG6qUA0b/f3gmb+8=;
 b=aLBDs0lGP0ibexR9ZOin6fHwk/VKhuXaPEXQ6GbZFiM8MA31kmWo3ni4B5xiG9yNsLBTr2e2kLeU/9RJImyf10SWhGV6s3zQ7cJC9HqVyXvhDIkpvacO7LYjNLfyybj6qEq5kxvgJeXip95TlvSYzE95tT85Y0UQ7E68r3TPk2FsslI0C5S+ht8rdrK4bbEiRCaONppOGOVbP8deKo8fv8b519UTk1jm3hlcvjriH4aI2u4bTRNsSa4Yn4qbdNQrN43U29Ko+Tjsr8cpI3VinGVh+tyKjIgYtmp7F0i9NwFsC6BvhJknCq/xt0mPGXyYPfdp6GAbwMnj16mtThlU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0VfYzzdE1S1evYyZIDGihaoKHCG6qUA0b/f3gmb+8=;
 b=gxx+Pjz+iM/NT+H0/V7Oryh8UDeV7ejal4jThJuL9ChwqFf0UQi5B7RPyYXLyomQ0n7Y4myLNm6fV6G7ZKsBWS1AmOVJyCjaXIe3sEw/nTvzLzsDNBNf/eCiAbUE04dHTmHTcXMC9qoseInKKc8dXWW2+c9X5F7pMBRNboMV6s/tOzd/WLe/hsMAko8Gpi9myRWYUR3EDbBd7WvkxzFF4PbhVqyX18lysjdCIyO4ON18UCR2MZYO0Bj59EN2tw5X4edL1S1lWjBoAN3UhIs2oitPTIPGG4AJft7Kse/5MuQoWfDqavJ+aYxJlHLZ8U+2BsWbVcrBydtdUPnO6oQdFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 17:22:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:22:54 +0000
Date: Mon, 7 Oct 2024 14:22:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
Message-ID: <20241007172253.GB1365916@nvidia.com>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
 <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: b6950e6d-c098-4593-355c-08dce6f4ada3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2gyJns5jb298/ChgCEsb4uVzvoLQuPjCWijI0+5SIa8H/RXlbkTsBJAEcTYI?=
 =?us-ascii?Q?GxIT9va7vMIbyc6oQxZrJqI2zLVCp8naVcsPNM4BVVEY0+wD8bs8yPjBN5NA?=
 =?us-ascii?Q?td/aJ4fOc2LtJqyTuWX0gTcKgcZ5B9D9GsRLAXXnAEfWup/gxSqHgYHjrRrj?=
 =?us-ascii?Q?z9u45nl8Krh0GPrMYtZ/SWh91sFvhnN1xBC/r0F4pv1Jj9DmhJJy74FA4Hd4?=
 =?us-ascii?Q?ZLCpjQcsm0QZt0g5OB8za347jiEv0Zxq2VVxspfozkSnQA2Q0ymZ8EZ8ZNfj?=
 =?us-ascii?Q?V5WxKUz7zjgyVfGePv2Wn97uYEwSs2p9XhW+ad7nwg+HvkXzvjuOKVKot/U1?=
 =?us-ascii?Q?4mFmEdhXnWoIoTREdiEgzMpBL7JqrA2sw8zQRmiJJDZjx8MfSFRQ9QLCAgul?=
 =?us-ascii?Q?8Fi7pa2R3L8Gazy3sofscgy4el+m9Y/lOT/mDQXRs3/VfvKs7KORx7NtBU3l?=
 =?us-ascii?Q?jXN3X0uz4nnfbT6flLnzzjGXygkQaBKEhfXqIKBJm+WP9Jygql+QLiZ5n9kc?=
 =?us-ascii?Q?HVgtM1CNwMS5GMtPQhIs93QcanuoQa0CnDesLizfdu+1kheRgvJ/YrXtY4mT?=
 =?us-ascii?Q?sdQTFvIZMbflc5McD1mZ6mb05yusO/5DvmDnGDzeNEufqJ/myhhs0f6dBnL5?=
 =?us-ascii?Q?d1s6GrD3Ykt51nVLRRJkascg+KD+00CrJHjUft/IcfI+VPlR2rNWfUASWth5?=
 =?us-ascii?Q?aenLIFGlUaXnYOZYvY14/YrMu8Zl21roloZ+Zl5F+5S46mMBmfPCutQDYh7H?=
 =?us-ascii?Q?6Xa/2DfmVvCkylPWpLfgd1LGWXvXD3HxSnpyt0QR30geFchpQDFAdkX24kGH?=
 =?us-ascii?Q?mDePBaqEV9nuN+pr/fkZ3WXdQWKgZ5dMiIKa1l1xJM7nM5OvSvtg8JWvn0bu?=
 =?us-ascii?Q?LGNaPmMK43A+Wd6WM1EAcpPJTu0gUkt8BWkprDbCPzjKAkwAa6B+2pE6Hf+B?=
 =?us-ascii?Q?lrlVNCVG2cD+Am5sEs7QXpUS4662ntSZJXboOSXUTRlhWdLwgiErXqdBI8Jw?=
 =?us-ascii?Q?gsp0DaQhn10FPt0v4wm9NFPq0cBzIL68XR5R0AyfpbdX1SNjvMzrhyh0w/yq?=
 =?us-ascii?Q?zsPgM5eV4HSIPpU4JS/6Nmj7Y16z/vzAHLzsHRRwSaTa4tTIFGtMJkddTy0h?=
 =?us-ascii?Q?YRuHQNyd7aKTg9cSYePHGNJ31BPZmkx721bFWROcu695e7pwDJOyJXh18BlL?=
 =?us-ascii?Q?EO4CdxPaQTxUGJegIF5wprr+ba/QJMs/i+pcQsNudUzLCIEBOrqIsZXUK4MO?=
 =?us-ascii?Q?7vE+PYMLnNaRqwz+vsUysqXRPmHoazNJdJeFGkQG1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sT0ZkkysWb1TbCVQ4/BtS67HS5n7CCLGdbvdlSCdVTW06BBQukvZmL9i7SLO?=
 =?us-ascii?Q?QOVhIpBctGjB/Y9Wnqf6fQvACBNJRScsZKvdhp8j3tVfKujwb6taJzbk+VPo?=
 =?us-ascii?Q?Y530thEyImyxSGio/IbeIf8NH2TLy1wM4g6nviUGber5qpNIsBDCmTMCdHpH?=
 =?us-ascii?Q?ZpzRo7EcWFUE8b0WT2OdHM8ru9v3pbMBydEB6nFnLjoO75HAYorMXwBLXfat?=
 =?us-ascii?Q?YXZvOKWQlNLGbRkDVcNAQV2W5U/bYspf/a7ItU7jLRQCbi78qlw9vF6itMt0?=
 =?us-ascii?Q?pSp+x6xbFOvRKUdr/oXMHP03Hf2gNfVJycd0LDSUyZk1hTZ7KJ6aq5EAYX+G?=
 =?us-ascii?Q?i0Zl3TNgBpqzje4g7O8mI8X2kNa12r853eE0Y6f0jUpMHR+JE1II4/6LBQKA?=
 =?us-ascii?Q?7bbZCAmWlFYfWu/+UWd8ZEtXbklsx9qKeXKaeuwmQR96sFL0q+J+5+5j53Ob?=
 =?us-ascii?Q?8ToNRRNXYn1MBOxrYPBTdz8DeGiLtlc9GY6ewFc1CDf4TqHtRKMCdi5oScfI?=
 =?us-ascii?Q?92ycO3SByPTQ6Nd/7r8XDQcoz720ToU0lu/5SvCUa8ynJH0uPnpu7Bc1Ca9k?=
 =?us-ascii?Q?Gc9atUonH+vmb86D1Dt/SZgTUT5eQWnGQNLQqSRKwMbTOACUZXuXzUT+IH+w?=
 =?us-ascii?Q?apeT45rc2Xw1WZhkoIs7XZKqeY3+e0U/ePBBOg9aAqUTpzRu06pggYmi+n3c?=
 =?us-ascii?Q?X9Fm0bQ5g6rYB5qeR51HMJjg59+yeDAO1fgh95s714W+bDL5fyIWmjpzrwsN?=
 =?us-ascii?Q?/Nkfvp0ErChtSElszUucQvyDXgl1Uz93a0uQQxirlQnJGWsG6Wmo8XmiNwr+?=
 =?us-ascii?Q?PE9vaxG1l09d64CdGI+bgGLDomJBYa7RbxScLWz1ed1eXuSNE3XEip1aHCe6?=
 =?us-ascii?Q?bEQedj9FpttXvrg6oMn1HvbKEZne7v6oyScHb1rBAIahe8PeDP7wNop5vs+l?=
 =?us-ascii?Q?iFmgbURelRZlPPftWMVOxMTVu9sCz8T4l6No2341cOPJqavARg6S7k8NDlGD?=
 =?us-ascii?Q?1f1DQE4YjKR0DupunHv+jOplctTR2wVTBw8eKqJ2im63fvz1wBfBToFGSqKZ?=
 =?us-ascii?Q?MSVYeCpxXNGDv2Bee5ZNBiF3iXgDijQL7v64gVMjiw7gDJyi9ttdovpgYiPT?=
 =?us-ascii?Q?/piHbgwVyUhtSfSDUSFKP0yHrKnrB2iJ1V+0d+JvnXSEmzMkIBfO7R8afwdr?=
 =?us-ascii?Q?KaMwdMmQPViejxITNxiunZu0YPwiznIAtylWJ8T9mkY1pcF+XRWW7HLo5xZA?=
 =?us-ascii?Q?N1NJp9+9Hvt60Ha9vuW+WnrrFU89bw+FlBC/ZZqou+PtjRA4kbTRUdR1prbT?=
 =?us-ascii?Q?bqhwtLqH/fbk3bKO10R+Z5WRdtU0d8qJck9k4ZsKujCdOxD68gqXwhHOfiz4?=
 =?us-ascii?Q?HhL1Doylsu0txQGtmP4IwkI6wFt8QK+uIGQLNGRRm1VNQqjqhv7+K65oqwvM?=
 =?us-ascii?Q?RcSwCs+BVnN+8WfURhkMzqYyiDOsramCpnP+vFq/g9CrLb3dKBkrkZvvpmyz?=
 =?us-ascii?Q?s/UtoY+uCD8X0MrtPP0x96MG+AEcHjYcMgzIs9uMRI/uBVsQkcbDmEx0nmSM?=
 =?us-ascii?Q?Okq+D0gvTB+9JmKC5iE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6950e6d-c098-4593-355c-08dce6f4ada3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:22:54.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3X/rCJ0hC7hoF+IMoSODJH1xEgmn04F2u2Na7jHIPpT6XYzipaHuOYMZeyOrZPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

On Mon, Oct 07, 2024 at 11:20:56AM -0600, Jens Axboe wrote:

> stand by my comment that using ida for this is overengineering. And that
> yes there are 3 slab caches, but having 3 per whatever instance is silly
> and you should share those 3 across instances. 

Store the slab cache in an xarray indexed by the variable size and
name them according to their size?

Jason

