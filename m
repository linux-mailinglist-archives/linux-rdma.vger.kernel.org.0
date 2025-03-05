Return-Path: <linux-rdma+bounces-8389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15315A53E5C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 00:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816DA7A3680
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 23:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070420550F;
	Wed,  5 Mar 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D3xt25un"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D81202C55;
	Wed,  5 Mar 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216922; cv=fail; b=kI5kqZ2CVrycWVUtGX6jLIYhvnVgDtZiwjSYXmrPaD3KklM3+F3YJ/XROrcYaZXpX+s1spnGy43SMLiSPh/L/zxWbFERuP8IPxkU7wAqQP3LCaRdnegeB1busXeEvVVAm27arVJttrpOmSipEyFd6hle8c9hYGJOiXvLwbMe+pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216922; c=relaxed/simple;
	bh=JohjprtWKbqPhrOzLJ2HhP4Z5focF1UFP8AAnkcVry4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LiTx6dB+J3/10mqp0caOmQhbmt9ASnoIWtcwDNEl/+wrN+naULzs4ITOtM4fpoB7W2MTTOUfMn/oE5J9C1gip4c5SYxqNHr9PQWdgCBsHD4XDGz4MBfYKvskDNd7QQ6abrUBSpxzBAe5uJjAAnZwezU8Wrcog2+yqQ2aShgswG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D3xt25un; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F18oCs0Kfrmh7oPfuQRNJ6UR8SshI1rY9hpJJLSCJibuQ4TVKcZINDutV5i7+VO6eOAYHkx2Offk76T3S70GTThfTWFNPKZYGhX05Pnf7meMrIoDsTWgGakCQujiC11TrZVWyJvEYldUN910jD8inQQSnQIxZr4nDNDhGqyGxNVNt4AmOKsnNzDUCf/50SpxfF1T1THxPe9Ab+FMHsf/1vZcr5M6I9PHZcYd4xC5p2sBIGmX83unT3491i4lPcAeKvHJdbeUDdEgrbsK4V0zHe+M8/9FvTqdm0WYnpKIh5flFinZOgWZwexyVGmSTYEydnDo+ezg8MSEnY0fGfPJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JohjprtWKbqPhrOzLJ2HhP4Z5focF1UFP8AAnkcVry4=;
 b=pVgjbAFDI01kcGzCpdf5hXVpwzsykB1VDubqgYlvhiM4Vi/x9Y558TIRNl7TfW5fWVIFzk8OEEYe0PakBLVj+0Pt7wdwB9M8l0ZE8MtdJHOjc5WajJt+XYfWMt5fcj0JB/BILnfPWH7O+r9UBhKtGuI52g6/BY1IscwguhOKy/Zx2kFhxnywQbTBd+VW5hCDxot6wXk+U1f9wBVkoYtvFW1FsXff6rvEJnk/aAoeZmcglEFCoS03KpYj5qP8ujARDwltd/nwDxc8lRSW4CzEcUWEZ9Dgp/BPfHP9w1QH0VWp9+B0aOu2nC9weKvfeF57A/rTE7Nd+19+FJFn0Uvjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JohjprtWKbqPhrOzLJ2HhP4Z5focF1UFP8AAnkcVry4=;
 b=D3xt25unhqauGHzNUkRp7aS3L9IKeyNaKTyCIF7lmeUAFQV+sp4260qtJEv8dd1dlU+zyuo5206ODQKuxKgrXSGSHaafSmUCsiXMuBF1021uGU69V3+Ak7YiWA4n6g3bYgZdEeUmDefg7B6V44xmQKMDaFOjIDJcQGiikgbCOUs+Xaq4lAGGI7XJLce95f7Eh97deXek3IRCkx+KBi6qqxARYMSWoSEoGKa11eURakIh6BgPwLZv+B0l6HfZdXWGqJ8iJPWLwegWHgs+JASIeKkQf2Zq5QguZCjjQtGYJljW+7C2VgXttPPPfKf6aadw70TvhIhyuh8f4aOCLlvETQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 23:21:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 23:21:56 +0000
Date: Wed, 5 Mar 2025 19:21:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250305232154.GB354511@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8i2_9G86z14KbpB@x130>
X-ClientProxiedBy: BN9PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:408:112::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: c71d493e-e3fe-4ab7-75c1-08dd5c3c8539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FjkJeceh/Lcv4Vrybxo/rTeraxsNZ7p6Nrf0nUmzms2p9L1ON/xVrmACFF3q?=
 =?us-ascii?Q?I0OYWWS6ZnBpNuiKHLMZ5B/cTvcYMij0Vcp8UZ1Zj9r6Ob263sn77HUP1phl?=
 =?us-ascii?Q?vsUFeGVGUgvREacVpUYx8qhPlj1eozZsNryNhrIETYEdVDPwr1ZT8EwEBlpR?=
 =?us-ascii?Q?2vOzPj/PTbX0zBMeKedlt3ubttTIXF8d6nAAw0TMI1+NHP2itxRH9ZB2DrUc?=
 =?us-ascii?Q?lQYW0dtdhxz4YfcXwC2uvpUjDvvqFSUo931sEqNVp2fhYri29D2KsMoI1mwu?=
 =?us-ascii?Q?Tpg2fI+tebrPyeqxcWVJhIMYxE59hS8BH8H2yIGFh4SvAA2uB9ZpG6+H6a6s?=
 =?us-ascii?Q?rTI1HbrToRNRqC26AF0QaMQyCJlXnucopkpnd0Lu2MFhfJqJJi99p32FibjK?=
 =?us-ascii?Q?wUbQNG/qSsrKZhBHtMDnET0zy9xYgrhMXjLdbLCGODy6UoGS57oNinrS3qG1?=
 =?us-ascii?Q?rLzNJI2g2dOVC6RAvV+QY4r5W1OFetG88SMggY+MUEJZzOTheTdpcTldFITm?=
 =?us-ascii?Q?bmLpDJAaVynVmfX7it3UFDBLvZOgrb70W2Owwd8pzUfxjNL+jLW3rxFb3pFi?=
 =?us-ascii?Q?ZITWvR+LT232kHFGJW6KJNnhVwLqsqtx4ehrxO8yMdza1X+8iF92Rv313iIR?=
 =?us-ascii?Q?jqKUlQ7sMNCyP+wG826YuD5tnX/IT0HtI7x5RSVra92/bO9ZyUJV103oeR33?=
 =?us-ascii?Q?VydScnfVLNkvcA6GYuQDpel0w0DdaSljv+1rMJWd9mwKRax34nexRI8QUbR4?=
 =?us-ascii?Q?uSd/aKe3IAtWhjw19R6X8WBNNWwO1zkIuq3xRfp44knyAL/vS8wPYollKXY5?=
 =?us-ascii?Q?EBPhHCYp/a+HLHyxXvrkEDTH9hG0ml+XTuePztXsAOzvBpLs230Mvih4G780?=
 =?us-ascii?Q?b8M+X4Rrfu1a1LFMRLUO6teOoFUbWOzv7AlgPAkxZXSodmo505W98HhE1SRH?=
 =?us-ascii?Q?GW9v9W2kafo7L9/gsq9gCwZydsum/dx5TcwUT5YszhDoBfwTFb6FCSMKqlm2?=
 =?us-ascii?Q?GKKy3FmyrjaFdlAul/m1cxk/IgYTzhq1lArBnCNpMqbhUHGSpiL/5v/ysIP9?=
 =?us-ascii?Q?c7WP1BQcEBXc8Fc5MUDfHKraQ76XYkmpXpkgcacTHgreP5ch5SErxWdF6f9a?=
 =?us-ascii?Q?K6hPn/Lh38JR478ZEdDGnRyjdVsBFzAkjXIgfpBPUZc3l+uaRyqJaZh9/+DZ?=
 =?us-ascii?Q?BsMqz0bnIoDo4RuPDumJwwARm6tzBQTGAWA2YwUjw+EXbrs4IHUqkDFbkAg/?=
 =?us-ascii?Q?FMrz6/djjhtKxYEygOA9l70Trcd20jQGsuz8oBeLOlz/opcXogir+ZEl9fpM?=
 =?us-ascii?Q?jX3SY0zPnKZi9XJsiyBz5+iTULWovykw6aFn5XD4yL9/Ldaor6ywklaoTQ2B?=
 =?us-ascii?Q?I2ZvE7hTbIwB0DmwUpMuOPhvSbt8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSjE06GlIMmSLdwwyKE9q/vqaqi3YAFUBr8/zawSWJmzZj4jBFpYDcaoG4wD?=
 =?us-ascii?Q?MNxKGKypsS7dEyFW4I8Opag35liAgdxA7rcjJ5mBIjWuEWja+NikfmwrQj9w?=
 =?us-ascii?Q?46FMQnbydZPZhboI2v8XrRBQMh6JZF9ZTIWX/9u0Zy2wLNes6H8foENnANHW?=
 =?us-ascii?Q?e57HUUFXqzT7Xu92Vm7iQwEIciWOtwnKtVZ7iABk2fwNLwnnAhc0UKORfw3o?=
 =?us-ascii?Q?G5UAaJr4L4uTxvr2bA4ohLhRITH70yyNRBvHx48DsCUHU2ImSEJbs544QZTp?=
 =?us-ascii?Q?NQgMUt4YQ7HaKcfKdPLgDZZ+ln+SKWqDBAgPTmXsWeArvoP3tMjeadwnEsMw?=
 =?us-ascii?Q?xxvqZ1s54bzDBbAd+40bHq/xrkahvhCZPplCZwZ5E7CsCEWRNcUaUR+3vbmI?=
 =?us-ascii?Q?Akd0uI9DDAyXQH4hvCFKGGzgSRy/UIXWGHPW3zridoVMxi9ypsd1juoEr9SR?=
 =?us-ascii?Q?6fKKepZ5w+ATs+ADOAIFafsgcEybOuLt7soA1y8kFSW8LZkB3PBZ7PRsJANf?=
 =?us-ascii?Q?mbMyRHjI9KLHuU2ykv18+yZPm36OfNru3W6LYo50Gd8SECLy8l6uYfVtPZqx?=
 =?us-ascii?Q?QX3rANu+zC00sXL4UEfhKWCYYhj7JFz3OOZs20x523lvV2HCJ3ml4LJmUuiQ?=
 =?us-ascii?Q?uSaZ59Xt3PY0w/n/z4Wa57up9Egblilf1U472Es2jgDqRRgTZBr76uP2KvSn?=
 =?us-ascii?Q?rj67/8eFdOLMAWXyvU8ORuGlQkPcj99kfM3h0F5B2o9Y88whhNiV/h9mUuMN?=
 =?us-ascii?Q?RjmA5Rj9htW+MsKh8HBi0+2/jxEoNSyhfJRmxiaNlv9jCKxp1oT+t3iFd0g9?=
 =?us-ascii?Q?LLEEZehcuJwmTERQqQT5Vm7zOkJNmdFfw7/lQBym9Xzn+HGDChYeBMvuAK4+?=
 =?us-ascii?Q?/O/sTuiop6qnI7VNs/tsZErDicXRLtGiHcY8wnx992VQbHIt3RCNd42imGBC?=
 =?us-ascii?Q?C9sKb6eIFGyTrFqrsRpnFrfQDC4K3ypI3n1AE5PKTcUn+uue1xEdSx3At/WE?=
 =?us-ascii?Q?QW5TrDw/q9SKc0pZ1fQmG/ViTcq0dCPktSpauE12NClyAtnvIgVO+NiAWFy0?=
 =?us-ascii?Q?GzFE68JFQYoClQn+lmJtlftLs4WBBlVSvHy3drIvOViVhI+V+gSr9J+b81j0?=
 =?us-ascii?Q?a+sevbbzfPpcjv21u0j8Zf1XjOrzAo+PexWKSLXIEw9BqaYm0S+ijTEG3M+d?=
 =?us-ascii?Q?IDwfgDMUI7DHmqCqYdi0S25S4KWRNQX7UqpgqnWJmG8FFR+lE3uDJJJhrWyr?=
 =?us-ascii?Q?4gpSvxMGIpj/QyRNFN5sPdHdhV4yaE7LeCSHyWL0Kj5vJEVqjeL2BQjJfYPY?=
 =?us-ascii?Q?d68rRPC4n2judmJg1p3SkMczzUDatZWlDznLtTp8Ws9VmD9vIwlGwXgAkwps?=
 =?us-ascii?Q?hrZrjSCjaGFFskBrgyh8wl9gadOdzWy4CJptzLNtSgM0k3B5CF8iwDvgrq/y?=
 =?us-ascii?Q?CZebrj46xm02F1MbbI4ihDgeB/XF0mgKIlu4MBlYL8Hw/3C4RHzovEqtJNNY?=
 =?us-ascii?Q?WoxgR9w9r8Dwpp4o0Ui27bMHGrP9tSUeztNK05e7lHM4LXKkxFMm2l9XvVx8?=
 =?us-ascii?Q?t9Ty1BKc5JhE/T6bXLM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d493e-e3fe-4ab7-75c1-08dd5c3c8539
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:21:56.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtDOsBYjokjnZQnaCwL/z7tXAkLL5plcxnVi5pnuLjNBgZt1eLymbFPZxCY/3MnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:

> How do you imagine this driver/core structure should look like? Who
> will be the top dir maintainer?

I would set something like this up more like DRM. Every driver
maintainer gets commit rights, some rules about no uAPIs, or at least
other acks before merging uAPI. Use the tree for staging shared
branches.

Driver maintainers with the most commits per cycle does the PR or
something like that.

There is no subsystem or cross-driver entanglement so there is no real
need for gatekeeping.

It would be a good opportunity to help more people engage with the
kernel process and learn the full maintainer flow.

> It should be something that is tightly coupled with aux, currently
> aux is under drivers/base/auxiliary.c I think it should move to
> drivers/aux/auxiliary.c and device drivers should implement their
> own aux buses, WH access APIs and probing/init logic under that
> directory e.g: drivers/aux/mlx5/..

That makes sense to me. I would expect everything in this collection
to be PCI drivers spawing aux devices.

drivers/aux_core/ or something like that, perhaps?

Jason

