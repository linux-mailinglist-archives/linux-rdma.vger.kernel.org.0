Return-Path: <linux-rdma+bounces-7518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A95A2C522
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175871604CE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24923E24F;
	Fri,  7 Feb 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWundFOA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32254723;
	Fri,  7 Feb 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938221; cv=fail; b=A25zSpFFWWdtXHeFyNVwvm5RzFagwTCY3FYGWC+AyPWKHRqZ3uzIMMEQfmriC9RxRCpTi3j8ZcwB7hljgLO/h1fZcQH1klr1GpUxUpqa2u2DjZw7h3vRf4NLksqnBiPFDYWF6VZbKb+Ets6JNFIvPzJSa8mIhSxAeANybwexijA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938221; c=relaxed/simple;
	bh=Q7yFlqYV+s+k27nYVAt9c/UpiKZISRyy8ZsTk3pUhfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpXEj41jTM7f4Tn8J7I8UAIrvIrNOn6i/AHsHgwL5d8ldCU/POXHHu0OrVPRA5c6M8gsMVhT1vQ09oJKsaVlNQoIlkcUtRLDXogoeMidR6scsvNIlE7ZtDKt6mfhnfsd8c0AVBN7phEgRb//ddGMluhSOLg9p17IWZ7EIwIJUKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWundFOA; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGRWShXuQBYJvJ151P8OS52E1s4keEnmCdnB7RxkOi1YmbDA6Lg+eYMiVzKeH973Dm/XmTutu3T1sPo7glNoRRINt+BfQylsDs9J0jIsppL+4fDuND8c/w0QVHUEEzZOVpAjOLt2lKk9HazLIW2+7WeGIuCPoSBXKIHNhuSU+7tfqo2P5UTrwFARzRjbOnoYFsIME7C3O9u2pGu4Ty6xVmhQNQL1ZmMEa8oSMbTe76PUe3LJN6qaKegMeRYYpwZYyxxR4uM+dft4M5i0Kb8A/C2amUMp/WzD2VbZes+0FOczTAiJZ3jxAEztvvsrol6xQ/g1Vhk3fZBvuVKFIkW0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8fG7pHqKeif+ekusiS4XelCQt5ugX9T/cp1zcBzsJM=;
 b=wLZlEfWomLlMLNF6bn9GPaSnFA26tVb1ut62mtzp5PowICgZOWEvPUWoZWS6L10VyLG8fc/GgWtQw+8H7CsYxB0b6MVpZQYWwaGm5SGqgDlhHUMilcwl9dsPHJkwyY+Kc1ugZKES6Uz14eD1VewWtRLymIUSI/20hkUlSN6YZ+nz1yaBbJEFa3HasUjNLpxYH3xGpUWd8ua9NvjhbYroH0i8JcWmWvXqjRyxVQs54DU6F5Ougr1Wyy1XLXGitFLccZ2LaN1IeWQryWduahSZOaIo4qCW10YorSMoXkiqsplE2DFD9k8FBm1LRBJRkHJSF9WpvkcAwV20H/fKt40XmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8fG7pHqKeif+ekusiS4XelCQt5ugX9T/cp1zcBzsJM=;
 b=KWundFOAsLySHZauUVcYd7lTKHMlH4HRlFiwvkxPEdlWdEXbWbujYFFi7ZF3aQWlCvM1tAg9+ATX46GiMNGQ2BeUqhbFE5bjY8y+8pwYjA7aB6gRTE6ltLRvvoLB0mtFAMOoKT6yHfx9WAYlB3+TUDM03OHZ1miu8sRL+XX0slBRmEajqDOj24Vq/riXrGRnEl6A1TAVEocxozI+Zbe/vyN/dLWp3Vksviihnl3qN61yYpAJJ63tKY2BqIkGuwZ1L3u2pYeLYdWnNIkH9jxBMvuizaRQZ9iVO/IFgYSp1OixZ45Hxiw5R2gF4UQISxdNTHcFEeNFuN9tw0HwEYzfmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 14:23:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 14:23:37 +0000
Date: Fri, 7 Feb 2025 10:23:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20250207142336.GA3650433@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250207130641.00005cb9@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207130641.00005cb9@huawei.com>
X-ClientProxiedBy: BN8PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:408:4c::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 49349240-5e3e-4f5b-3357-08dd478302fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krhLg8A8AwsdqSaraaE6psn4goerV4fwlwK1VBkXaErr9jxtBzCqtw+OR/9e?=
 =?us-ascii?Q?lJLYsbL2VBZ25hyiBUzn+ilirUc/fOU83oV09SRyZCKyACGlsyHOBLeqgMmm?=
 =?us-ascii?Q?5aDlu4bxpW7nZp5t2t2eXh9W1mmDyGWlpV17AgSWOrIGRMfT31w2eUNy0luM?=
 =?us-ascii?Q?pQPixMcV+BQn4DMGcvfeHbcGtWWLFTDhFRHgL47EljljhXCQiGIP3ymeLMxv?=
 =?us-ascii?Q?rCI3ABVRGp6USypixF3xXcCANbX3M4wFXAWUPXVOgwDUWf02LvQs93z2si+Y?=
 =?us-ascii?Q?oGmN7/rrsJUNC2K7pddC8gc3XyhCzEymmQ1piuFcU67O3knoKfgpGNAL1kYd?=
 =?us-ascii?Q?mO3eXUs0RQ+RoQbxUi+D8G0Ku5vtgAXoNducFPQ1S07jCCPAxHfWQ93R70dt?=
 =?us-ascii?Q?TCcTkLK1FJlBxPwDdC0gctzJSWgRtRAftAwY/Eo5vdOB4AiG5HGVkKR6BfLs?=
 =?us-ascii?Q?WoxyV/GxDF+19Vo0++aSeYwt1gaSTg22b1Ffxf6GZPptfWXHRY2d0w8Q7eII?=
 =?us-ascii?Q?fimitf/CyHTaWphzugsrM0rLbA9EDiJbhd6GUzEAnVtDaV5LznnpUTuqy3pE?=
 =?us-ascii?Q?2u0TN65r6g5cix3DdP9sVrQgE+wpfH/UwNqFQdK8c1FmLhr1MRe1PM/OsneJ?=
 =?us-ascii?Q?cqLnG58/fk/D3l3Zcyd0taYEb4RC16baoSiQplxbmADg8aHWM6s1UpDjzIQ0?=
 =?us-ascii?Q?BtMo9mpZq+hJ9jWHGxWrTk50ozTYkKVQy6yUslv3iqAntc70FpE6bfuSgVte?=
 =?us-ascii?Q?bz6r4jDTt9tavghRRP1p+NtVA91Wdr25Qw7OYv7/xjH4FMeadOTG/irkBDDE?=
 =?us-ascii?Q?P3mWax3+KaY5uLKK0Us6zRBalcGrcds5REL7zlJSXLHCzHIuqlQTV/eXa2NI?=
 =?us-ascii?Q?WBruHshGqlh6qfGxgWDI/c0nJGnD2qc+Xq3ZlkoX8ulvgyKAJLXe62x0XT2g?=
 =?us-ascii?Q?MZOSzo7wgh0qVylDTvPEJ9acmsrICIUmIpEDfM4J8Rhtn9mFhalj5NxEs8BK?=
 =?us-ascii?Q?77HtnXo11O9Bdp9G11du4NbqWcVYDcxAE0ACT+THix8UkY32AYm+EcDiu7HB?=
 =?us-ascii?Q?1WllhPVs23aq8KNUunxLML1jX/MV+ovW8acmij6+wX+jP4+o2bn3sMz+CBY9?=
 =?us-ascii?Q?fL1Fanvg9t5Z/l89cmj+8kpL63FCOBFJ3D0mEp+/lv8T1lYgWrc+NBYLDD/X?=
 =?us-ascii?Q?GHtM/wkV4Dv7jj3FF+vphQecyb1eMTXOUYJ8D8MpqD3m6rnJVADLqcj6LrRh?=
 =?us-ascii?Q?14T29yzKREjfMJ8bjbqeCFpkuyW0ugKpfH5IZkXgnekku4JCRH02T/8FCnNU?=
 =?us-ascii?Q?QyUaIGmXE57vNKRqCDQGPb1qnp+4dgeHvub0g+Q5fd4snNq4QlhSoZeZfSlr?=
 =?us-ascii?Q?GygdcL+gxJUoVOod+H6Unr7k/PAR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8y/sgbYGu8NcLs2Vb/vybAx2PoOdL+XdAc9OJCtqi9N9oeC9WFbna+7G+KY?=
 =?us-ascii?Q?lyfOsvv7Xxl70ZLOgWKoBN7xKnWTmfD0ZlY51yzjIBJCxHmZGuH+GYyDy8uP?=
 =?us-ascii?Q?V7RenrSstRDw6PNDrnao+ASTz2YibXM+aWx5XzPlddFSFmoRDreRDrRB0+Ap?=
 =?us-ascii?Q?LrHny2fEvvQnU/NArEHQeUKdDyVXtuZBIIY2S1/gZ3anjv+MeKmQY7Lf8GEa?=
 =?us-ascii?Q?tcZrA9XKEkj/5OD+uXQGYj98ZklOECsgXO3G1XPWeibNtNitvOP56iL++ScD?=
 =?us-ascii?Q?DhDHOOPoVucnDHeqB/bdohKHyjT71uPqf31NwxyXfhvFnoBzuJ4H/YnFjVto?=
 =?us-ascii?Q?JSGu1uLSLVJGEK1DHqXQ2IXrSSA7+e5SgoVv8hjMiBtIH3fZGkniXnCgKtMf?=
 =?us-ascii?Q?KBAfPnRbqUoHAwbHtzabQZPwpmt/TjB3Woo+MM+SU2nBbm2kFJ1KCOnUa/Gz?=
 =?us-ascii?Q?GNuceFAi4Gbtu3DCaHpnIw2lsFypanlfAVKphYtH8AOxe5wJHqjdWo97A5KW?=
 =?us-ascii?Q?b0Af5yTnYPlwR0DgX7AMT05i4v6BNYDGLSprW0hkuy41G5k9q7A0Gj03cOKu?=
 =?us-ascii?Q?eumeixLm+1J6NsIVoeAWkMCpf8OTK9BLoG8I8W8X3zX/lUVrRupK7iuhsAeG?=
 =?us-ascii?Q?Hwuzgwja/8srtTLmqGh0mwsaD02HIrbVO/jlS/ISC0tIaUhB72GW4uDe4uRt?=
 =?us-ascii?Q?+rfVCU5mvfT2nNwfL4v2ojxasrG23MleJ3SVue7GIIMYJ1y7kgVgkG5GNN0J?=
 =?us-ascii?Q?yMw3rWUfSSbQ2uM939gMD0d7CQuiPfn7CqEogSzeHG9UDMEClSp0oyUn56z6?=
 =?us-ascii?Q?//h/jJ1eIHojuFC4nCfVCQZx5BZk0QIGZGe5tR7MKF1u4agCobc/bjQhduUx?=
 =?us-ascii?Q?NgC+r5UxzCw3Buz5RY9ZYR5YN9W89/QRAdOBi0vfDBS03QyGuzVkkZB3pP+G?=
 =?us-ascii?Q?NvZdTBxnggJ96zt1yqYavs4BditwyefumjgyL0kOB6PWwTw+wu0xgrplbYb4?=
 =?us-ascii?Q?4F3oL95u7KPE2GwMGLdxrLdZEW16jaueX6uD/C7yIw70fDqVO5Xt5Ru6TXrs?=
 =?us-ascii?Q?chPZsuK1bVSPzSz4AOFOYuikAGIitAO+ogCpp7zdnDIl3VOKLJz/vB1YGzux?=
 =?us-ascii?Q?qoKibJ9lniKEjqOUP/z+ngSz15mZZlkEMueEtqbZMX/V2MpqEx3PZnz7JMcC?=
 =?us-ascii?Q?uIua76RvPykOsHojipK5HQpgQl3EXI47V9ZnnRQ6NS8poQ5ORybVOXy/xzsT?=
 =?us-ascii?Q?iCJPWAx7S1XA4kwtJU28Y/H5mn5YJkI0n4PUYptbt6e8MMsoVLsQU9+CMBOn?=
 =?us-ascii?Q?6aG10T+UU9C/c06ZIiw2pVHOdE+/FZ3uwkndwREEYEj3JOmXEj5iNwRlCr/z?=
 =?us-ascii?Q?KbcYooocabo8BNxcTBsT5Liln7amALD5CRjVqrPXoH49vg8VzFkNWktH8C1k?=
 =?us-ascii?Q?DFwasyCY1AxgNG49qgQFsNM5QG2n3HU7//5koa2rhodhq8NG1jCUMyfI6XK9?=
 =?us-ascii?Q?nMXn8SHuHx+Nhs/VXVOqPV3L/GEU09SwjBT6/yo70GKbG63ZjaUQU9qXqpsv?=
 =?us-ascii?Q?t7gL7lelz4p9ywLgk4AoW5kG60T6ojehSXxOHkBL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49349240-5e3e-4f5b-3357-08dd478302fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:23:37.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLUxDQ4OJCPKAroTiCT+1uG3V7UulP8JAfZosry4qYHj/Ij68hJ6IzqzNoX0Dqgk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

On Fri, Feb 07, 2025 at 01:06:41PM +0000, Jonathan Cameron wrote:
> >  enum {
> >  	FWCTL_CMD_BASE = 0,
> > +	FWCTL_CMD_INFO = 0,
> > +	FWCTL_CMD_RPC = 1,
> 
> Trivial but in theory should perhaps leave RPC for patch 5?

Yeah, I think it is a rebasing error

Thanks,
Jason

