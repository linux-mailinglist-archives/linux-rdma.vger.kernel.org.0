Return-Path: <linux-rdma+bounces-3268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D690D15F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920241F25B84
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C81A00EF;
	Tue, 18 Jun 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEeu83LG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5213C683
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716141; cv=fail; b=EmH4N3lpJGBtkb7tSLgbBau1kuwlQLmjoUyiMsFxjyjWW33c+IEmGqJ4unddstjoWnjyFyUlDB6RTW0l7I+2nGqdW3Ul8r5jWKbrt77FU4qg2YbUmk8cqpEhbpUv2Q1v0HHTlmhXWOXREKU7gPJquUgoJQJPcCSmyG5r0Px4M7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716141; c=relaxed/simple;
	bh=HMgpyqWJS8uW99U1o3dWVMUCPZfsIXD5BCBXxilMsRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dgwmh1dT/hFRSY6CRBbgkuxnvSu5769xBi1r2xqcJSj22WpG+10/ntUaczdB/qFQr8pw3TM31QDfXFQllYRB6ExU5F84Y/rrPa0xF02FYdkx5/HSFoqqTiJZsrWu0RcfCKND7V62/YEsyB/J4ndR855I6jRMpi2L8T1frHRrRcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEeu83LG; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0dyhzaE4UFQZUD3JJ6eF1YkJKAnSR+6OaEPrWTKfZnLl4iJACdbZoG9xNUT6DDEG6NVR6vIlvzs3B8Rk6oUkxVz6gldV2IQvzY93xlhigLvQsgi4GmSYnAOIUX7UKKsf7e5TGT2/08Kv0pP6B+MkmQRQID0OSaVVU25R19Clrx8tQOQroaPHZltnMbnR74Fp1aL0m4gdA76Bw6FyVjPBPzdDDCU21fIupY+0bSU/4xSdcX0ql8AoO7yJowdvJOdnV8p3FT/PEOM0JCwUqlsYyr1tZ2ADpCrxDvtuUJnJbMYGjB3aBi9AFNkPPb+t1Rj5UaJaiPQWy0nHYWE5NFLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXEUtwuavwEwZQb4cUuXGnGKhnRp+8m81ozEJtmi1BA=;
 b=JNms/QKPvivw+gyEfu2vJEUuqaOw6k8UZvidAmIzcVyiw0p+DOgRJosI3QC5Gh0zkclUGgfKOjvRmfNYXceV8KcZnkajgQBBFjLrEy87+R8YQnWxVH40/RxNIbMIXtU1oFF/9+ocQ0bY4vonXkeWJQqfVP+/BswLw6esbr0pqtW4sOV6hZUvllxWlhoQR0VHUW+DJriZVnPkW2O+BsETLUsbwPQ0WIslmOdaSFl82NzAqdIm6H2SV5xHxoWVXhHDAgtRSk3e8zF7YHRYamI12V9XuvUQeqJkWeEdz04Z/ZsHyfmyW2cY40ravs51PgW+6K01U71iEc+Epy1I2qzPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXEUtwuavwEwZQb4cUuXGnGKhnRp+8m81ozEJtmi1BA=;
 b=YEeu83LGvHRX6D+jMkXSHLGM3h4cls4hYVd8NuRb+b07wb6uDMoA+10uA4jAn6iNFZQl4VjsKdNAicUaJy0+Dfw1FRhGtDyFhpMw3i6DpDnoyPHrn0rPhNCWqigRK2F+Po7rx5vW4b9+rkLdbwo6dWVZr9rIjJAzeCOwzjFocLvJIhveQ1WoWI+IkUpoBY/rID0vusGPHrbKrK5Kj/OlRjHPLzGuGiE4sFi0b+BPTliAyuQTFmaorKjxVUkiF2FmAEuPVYHYdDORcl/23VvogO8dtzDNMGtMzMkFHnz66pBc7LqqLp7p3c2qWSM8Nw7cFzKaIr3NtbkcHRO8iXb2nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:08:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:08:56 +0000
Date: Tue, 18 Jun 2024 10:08:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240618130854.GB2494510@nvidia.com>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
 <20240617201003.GM19897@nvidia.com>
 <20240618050557.GC4025@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618050557.GC4025@unreal>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da2ec42-690d-4e5f-b14f-08dc8f97cf8c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hs3EOdQNoVZc7YCflvWF3yBnI8Tz3TXFSa+WH7DhJjcbq+ttuUsoW/ms6YhA?=
 =?us-ascii?Q?PiutRxgIa+ZKiX0pw9DfppRxfz3dHiy7MDPYD3FABBXvk8GZFMUn1XyVBmAU?=
 =?us-ascii?Q?jU7oD03dqsUzgJBdegaPnQTlGHyZbGCzTXytJa2rxfgG79xlMbOKEI+jmtOf?=
 =?us-ascii?Q?rBqUGXZObntuy7nrLKD8LcuO6t1mhSD3pcdgaCQNQScaIbkEaxbspekOONof?=
 =?us-ascii?Q?6c+qrRQHO6fu6DOTyvQKRso0avJss8CFbrjoXHYCc7H4bGWKgkajf3rgcjzP?=
 =?us-ascii?Q?pCgc9PcsF4JUAUuf28bBc6GJk0Op25m9Xr8wIKOSTmUf/rHrdYPyo3aa3rG+?=
 =?us-ascii?Q?jVdsTw1bdR7H+kaAifBW5YbLIcZc6L+Qnt3xLWLkln1lZk7tdu/U7vi/1Sfp?=
 =?us-ascii?Q?o+gDmfVQ7vGTFe+K58/Owdf/ZrG3JI3c/QDfgj1KiJsQfbZ4l8tq63UjizAx?=
 =?us-ascii?Q?584aEz2QUPKp0fo/K+l63apIMXgvzPKhhBc86cnnZU/kfucGyen9WSaPxmck?=
 =?us-ascii?Q?thytx+FGH/AHVpHXbxs50mndQlUzVaJlIlJYsuU2fX/v/fqI/uvAyYq16Zll?=
 =?us-ascii?Q?Vlrq6QPp9h190BEUNUBiE92bskKPIVocTgoJDrTnIfFuRoDHsJX92R8vU+pH?=
 =?us-ascii?Q?00TKcAyC586hV2GFUuG+JeZO/4CVy+NiJ9k6A6FJOalPk0bP261ZlHZWLAP6?=
 =?us-ascii?Q?hrtNt2XMDPQpuxAqqny+JwNI0LTGVQA1s6ZR+FEiFanc9H1Qu5H55Y3zR5xf?=
 =?us-ascii?Q?DQICt0ntV7o8oh3ECyfLwhBGSobTNv6SdH3GrfKbxOijtq8tVDlbsUZVPU57?=
 =?us-ascii?Q?/LExHQZf1VWNjf1Vm/og4opJQMMXljdaxXUdd+IXjdVyXC52TWjpDSwmIZK5?=
 =?us-ascii?Q?r/Jqm0jrOtIHw1oz9ww88+sxS3u+gNuESiJAEVlS2w8EQWjropb4bfvsWkLw?=
 =?us-ascii?Q?E+V1Kg0Ruo2SooblR3bK+Pe3y4a+eVvYLKYmVklh5ZkuJV0GxlSCUVHFsR1g?=
 =?us-ascii?Q?GiDss6wAUw8h+s77xxpxJ+Echj4cTJasqUPSY+EjSrSmLBGo7NcDGzdeXB2I?=
 =?us-ascii?Q?tNb1QBxBEcYQUcYAuMa+ugx8qhCxbDbBaGaO9q+X1W8/9anxaDBNCib9J3S7?=
 =?us-ascii?Q?4rCfK6GNM7F614Q3RRiMa04sKNQq41aUiKly9Ss7BkbHiTtFsavlVLhiSYjC?=
 =?us-ascii?Q?xvp+G3byq5a4tW6YSudLYFWKHZ2Flj3TQdER8k7StLT2jZsui+/Ru+e7u6Hu?=
 =?us-ascii?Q?HG6gswOo7ZTF6rgdXGhecMkBOwyk3b5fvWiKwvEqT8F59BD2HSoWCtngq0Hm?=
 =?us-ascii?Q?6KPu6XyYvTNTaXaXv+Spw0N1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAw1geyv/4VWAadPI7aP52P7CHSelNzraNzQloNmwb186tlqYMU5E3pSQinN?=
 =?us-ascii?Q?xzHwg9CREmmTcLxFAEGuOTPQ/loToQVJzUgXiDX5ofOzjz6gU9t0ZFI96JaD?=
 =?us-ascii?Q?pfTKV4qKjANzFLQOrskCxxy5wkw43kPSEvmKvcBlSTQDiQAX/wUbEpo5ejHx?=
 =?us-ascii?Q?Ggp2PaviVPjvY1TvYZlpPi1oXMm+/wOUdIiML/mBixl7psKCHALeLEQZSR0j?=
 =?us-ascii?Q?OQcupcvvjxLbV5q+yA5zI4AXtu45LxYdO+he6fOvM06kvX2mB/73qAJFEhsg?=
 =?us-ascii?Q?TgxaurKHREEalZ/XS+3V/5PkvasSV4duKSDMVUbjkR166nc4a1N+tBkqZLsE?=
 =?us-ascii?Q?XeRREu61jgoahIRDK1A0ft9itBlViDptft/PuSFfkafgx+JSIquF19jWjagz?=
 =?us-ascii?Q?viRoK5KqlbX3AmyPcpLDr4olIhz95rcgzI1rtvJD2JoNnHjuDLVgzBknobaM?=
 =?us-ascii?Q?otyH87JToyv4eSGiWfTj2ER4Sx8MzRe/OIY3UpL9UsEu8R6+/mMdvy/c7Pqi?=
 =?us-ascii?Q?Uer1ef4ocVO9oHyTDn1fgVNH4KVht+sl8M82q9mUZHxlmLZ+Q5IbNs9yrdIz?=
 =?us-ascii?Q?w4A6RdI8GjCqu071lHe94V5JX7AbC+85kDZqXvVFaBgHwOTUJ2PmSwYRdDT2?=
 =?us-ascii?Q?ldjg1vBQwisoUGptKyIaVN+uM07umWBO/77QGz/yhqvLN4mhMCFG3COHr8S5?=
 =?us-ascii?Q?ZtvzJtFF6fbfxVS/9h/SeWlevqZDHK1eaYs9MiC3Q/z2bcmAeGXQCk7kTuIs?=
 =?us-ascii?Q?po1umegpRyF90UExqxxTbEPaB0zSfsXtS9DaekPxvBuiXIym6+84xTRWakuU?=
 =?us-ascii?Q?0ugKbBKf7Lv5Yv+Ijb6GOi7UiaEOneBSF2OoEd+Fx6dxlKFc6rOI9cBNvIxO?=
 =?us-ascii?Q?PdBS9ImlCCkS7UZUjrDRtc3q00CYyMBYXl8DqZloahYQrPrbhq4ZzG6ndf2B?=
 =?us-ascii?Q?3US94E33d+ZtA1+QhMT+FSj4Eh3M9CmJOE3/+LDo7cQjFdihA7rvtEoUelxs?=
 =?us-ascii?Q?rs3nwPPrkmpd/By4UJkMXR3FeAfK+M7yuWR6nu+7MvKlmTzFt0skcrIljntY?=
 =?us-ascii?Q?UH48oXMRjSuyIgFuOB+k7I628x5qnhgmeOg0bozcNQyXcIvw22A2gSaXlBJf?=
 =?us-ascii?Q?H9viK/8dpoQhHqqdHXCdeSL9nbBGUbESQ7EcyiHGkoZ8040Acewgr07sbyZN?=
 =?us-ascii?Q?Zy8SrZXzJvvdhhgo303ZbvXzhRgH9slVyd6pKOGfmQ7MbUXkd1j+UJx41dRb?=
 =?us-ascii?Q?6Evik6kdX3zA2dKbQ8o3sWGEZMHLo2WE8r3NBk4VdoYUKtAxuLaoE18GhwoJ?=
 =?us-ascii?Q?+nhZk4T0jebIm4PnvH0FvoQaF9ZAJDlA/zplgmf7QyhiyO+MDcBbrksY5lAr?=
 =?us-ascii?Q?A59Qw9ppGADQwgWCMg9UZ9oatvZktRFOLbm7t4vwUAYyLO5U+fiYOQtU2Dh+?=
 =?us-ascii?Q?k72FMpOCQW3/tBVAeDin+yh2oWiv1cooJu6b8HodlQHOJpq7RqVtOtc/uOpm?=
 =?us-ascii?Q?9DrNCJmzM/9ueMYF10uATPBiy+5B2xSDk3Yy76r4V2UcOtxdzKCwgm3afFvo?=
 =?us-ascii?Q?H24WXL9EK+6jykdA/QsHz9a9htA7gjVQH4QukV6e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da2ec42-690d-4e5f-b14f-08dc8f97cf8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:08:56.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /znkiqPx8856U75ogV3TEoQBousJ0GDuWJnON6xKChXZSh7T8iuq7+jgSFnhKO2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

On Tue, Jun 18, 2024 at 08:05:57AM +0300, Leon Romanovsky wrote:
> On Mon, Jun 17, 2024 at 05:10:03PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> > > On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > > > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > > > 
> > > > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > > > >  enum {
> > > > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > > > >  	UVERBS_ATTR_UHW_OUT,
> > > > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > > > 
> > > > The start of the driver's attributes is not a "UHW", the UHW is only
> > > > the old structs.
> > > 
> > > I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> > > to emphasize the namespace and the position of this attribute as
> > > relevant for existing UHW calls.
> > 
> > Well, calling it DRIVER_DATA and UHW is very confusing when it is
> > really the start of the indexing for drivers that use UHW.
> > 
> > A better name is needed
> 
> UVERBS_ATTR_UHW_PRIVATE ????

I think it need to have the word "start" in it, because it is the
start of numbers, not an actual number itself.

It is also not PRIVATE at all, this is just in the device specific
space number space, not the core space.

Jason

