Return-Path: <linux-rdma+bounces-2969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A38FF8B4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 02:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D41F2502B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACF8F6F;
	Fri,  7 Jun 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsKleEFJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8623AD;
	Fri,  7 Jun 2024 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720881; cv=fail; b=HaAL0O43Cd4bhXYGvXXyMv9qbnCd2fuXqa1wXxlvpr5bbNk1xfWibG4K7hdW/ndLUvfM+HK3xLb3IeoWulTxpg3oheaESIe8ywStKJF7qoSssQ5URVrJdcKJlhpywiUNW8QHcddQYXyFxTB/viNHECW5CcrzFNIXKWbyaAUTBFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720881; c=relaxed/simple;
	bh=9ynxF6BRluCsl2lFYvykTEHbrwP6CFRJWxjUPWkOMow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zi62cUVGmSpUN7sGrSkzUkW2ZFBqm7WUgezlSouiKxVkKa1r4fE5eLFJESE9T0cIfukZmh46+Vi9VvKLtHzJVNe9hiwie2qppbFt0dL9jRK/VdpREFaIiEE+iriRQuiHvNB68/OiOXp9uuO0wOtIG8tOrtc43wvjUflbHukMvQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsKleEFJ; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEvfnPCz6YI3TvwUy793RK7vrHb96tf1uu8coO9fTTztDyHfs96n2zPU7Js8iJPoAghWA1foA+ZYQDN0xBoXjJBApidcYPr2m7S8cOE5lrtCtCxAll6CIqn5BdZ9kJxCfdQCtjqCkH9Z74o7C4SI5YfaQvN2CpSHACTBT42SJ6pVvjNLGBUllVRIvG5eCD4w9RfQ5BL4biWBe0BW0toL2UZoThc9UB22ielOYO3CTFiakctL3WikWcuMCoSvp94mMccNk3BoVnT4YCgP6kvWT5qt/OeA/y0kLxqx4Cu+RUvty++pdgjXzl6WE/D5Qmh+rPm7AfaGkeewGlVYKwW0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiiD9fsEIHYvREju3gNguDrkPsWHYSkQXegy5Zsh8QA=;
 b=gDhZkiP9xOLUyFZvxBnzDzVcPwrDkHZMlQ1xrLx3A/qiqFxDlRSD1LpyxG3pjtT0e3vIP2WqiqOHc3yfvnth0KhlZ7x5styMOWoNJsWWFMOTZoxxR7SMcvuTYyYRGmoqW62MdhtZV+F96xeFu0n4UvBNecm+Ph//5ARY8VdoL+/hLZMOCJkV2/an+DAPyW95DFaHzF0evXipL7/mvbpWbU2Kl1WwsAuE9+SVC4PnhpVuk4PrX+f1eZCvSXLy17Bl14xt+lXX6rqOgigLeA9Ruce+vJSCO9D+gGCIDWInQ0qZbrx1QFFzWYJA3KdtjzI09ZlJndJQZ0D3lvHrLU16JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiiD9fsEIHYvREju3gNguDrkPsWHYSkQXegy5Zsh8QA=;
 b=QsKleEFJzl5vzu/auOUnGDhKtsshwO46zbogRszQAkN8QxGuXbXTMQMZTsc/8j+7Oadxd1VChImrmvUL3Qy1pAcPJjohXR7C829GvysKcSXmfAUdcDDroB1MHtxBy7Cndo5ZIpRpK3CGgxF20Dbn89oG9P6l/Ziq7P0LQiuNSgqBIsktFSG9lXCOwNvxjSjlsijAVSszTjMAWx/9cXaaFmaahpcq91UXJ8ckqylSUdRz+oeAlG8I/zUwclYKZBBVOe77vEotm1Jv4DRhj7nIspjzSwx9qmxaJI/dav7akJS9a/O1r+Fl2sUpyJVbAvVL1Y7B2Vd4whUCziYAwijtcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 00:41:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:41:11 +0000
Date: Thu, 6 Jun 2024 21:25:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607002536.GI19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606144102.GB19897@nvidia.com>
 <6661f0dead72_2d412294ec@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6661f0dead72_2d412294ec@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d93906-78fb-4939-969b-08dc868a8748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xtmFRvXg/HbK0UHjYGXrKmSZPSv12FaM8bc2znEUqtVvn6Q4uvXsqMge1V14?=
 =?us-ascii?Q?gl5v0BLpU5KoapBFarD3uu/fGAN+SpmWura78P5eAjDrS7t5NeYzBx5AVnqF?=
 =?us-ascii?Q?2Hme30jw/cLc7BK3BfLPpljUCGUX+BWoykw1VVXyUhvsB7vStsQZnngNrycj?=
 =?us-ascii?Q?pGVJa7QnYpx6cP5///bzUXfopBW2Xbs2CUSaOMiZv0E3ve6DhN4qREqvcEwu?=
 =?us-ascii?Q?x89B/k16CYEbwQO7hHOavXQH/BaStGxiN6Kmi0OsEaN28nerXqOEdMe4/Ot6?=
 =?us-ascii?Q?Xvemh98J88UbyTnaeYW84jUSCbumkPctMYzYwz5/u++rvT1miYGksjfjt7xs?=
 =?us-ascii?Q?CEEux1O3bWr0g6CloDo+8QsIUU+yU2PKWBl7wT7os5nWW3uVKRwcw7BwCUs0?=
 =?us-ascii?Q?MKFjK3sPOaX0UAY9g+CBm0ZXafuladvNF1dbKNVEDuHnVECtRJroDPoWImf0?=
 =?us-ascii?Q?jdvHID0O21TnNRURJlFvOc9l1NIceECL39s1xSM4FyBjutHEf+2MkayvtkXX?=
 =?us-ascii?Q?97X8qHpfBO6ce7uRGLEYlQHQRxTr8XJY2/NaX1P6It4lO5wC8oUrHZEZA0fl?=
 =?us-ascii?Q?DJFY5e2bL3sbEgZiagy7S0ihPtdnQOnO+egKuO/2akgE+mj16U3FS9ku2KYy?=
 =?us-ascii?Q?XWlDA4WUblCvnf6TMJ7ivQUgi3z6JVmBtO/V7PRtk/yca+fpBIqnJVUJQ3Rr?=
 =?us-ascii?Q?R4zY5ZNRgM28Jmo2VxH4XNWyG9MhS67iuashPuhm/z/QN58W4dbRZKDVcuXg?=
 =?us-ascii?Q?Kj4viswIz2WqYF4rDUV//OX1uQ4n1RSLYQwWxavmDnpm+uIcQzLkx7k9vuZr?=
 =?us-ascii?Q?FY5r07G61JMb/qxcjTrJQP2rXohlPoOKMIZYf5rxHb4D5SUJMbka8wBcJsVp?=
 =?us-ascii?Q?PDVias5pCrNbKx+fvnEZTA0mE0mg8i9mLFw8AUdeQl00HrxBb1c5W0fw5BaH?=
 =?us-ascii?Q?Sj7Ten0v6UheRqSjLHV7MgQh9fQrEUD5/EYejNLBJADXHf4Ub5vjpxxDiyCx?=
 =?us-ascii?Q?N5ePbSoGd0Exk4hoccbDtf+FQTjhOc/C+SHsRJKJckmIQlfJ/sq6VIH5aaV0?=
 =?us-ascii?Q?TmitfPTcEYjoOyYvLpO9VjJnCitCNAitZ27z5kmZquj4pj/H1IdbInfUsjjp?=
 =?us-ascii?Q?ga39NJQF6Cl4K4RiKu334AMb4IwogK80hcrNPazDGSMbiS14f/gH1zJCoYbb?=
 =?us-ascii?Q?pB2z17iUc8DfAfNls7NJe4+p+FEr5bIiYSmQjoP3IzJC0SkpAleYQ689/PBT?=
 =?us-ascii?Q?wjefualEti5nFOCWB8eRPxpqD9smg+kfPBp0npi9h3Y0PnYDKlEqXOaxB17+?=
 =?us-ascii?Q?bEr+rPk8nl6Potjblyi6eMmr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xA5Ss3Hi6fDuUUi3eDOKAuVtKcvPXDKfadbZflj2cGBfQy6KLlvUHDw5vXA0?=
 =?us-ascii?Q?HSdGLvc9yzfjZz5JWq6TUnIZQZL/x7NRf2q7DumYFi4NizROLov2DLRUJXFi?=
 =?us-ascii?Q?GzSDGQlpK0MWZm07ryvux6JSdePO+WmdVvUEBSSsdTpAFSefneZOGdP7ZzAJ?=
 =?us-ascii?Q?vXJa5tjeUKlRaGeLF49Y8uZ0PHcb+dipr/23UYUCegdnkFtifm9N7HU9EJZS?=
 =?us-ascii?Q?9fW4KrDWPHykCtTS2BcusZ1mC88qGiJEyKd8YGVtskNZ5AzDm5n/++HNu8w6?=
 =?us-ascii?Q?j5qzUesKeW9xxxbI6jtpnQvGy1iXl5l2lh9dghd9O5DERlDHMwsydaacAoBS?=
 =?us-ascii?Q?L+J+O//NLFxYOTGysg/1PLbNlV9e0wBrIbk09Wqa20QMeCz41FuXehI/Em6G?=
 =?us-ascii?Q?Cnj0/2UNSNzXnct9BuBZ8qb9gCFGQD6/Hls1p5OM/EDedFkZiL1NrfWsWhlE?=
 =?us-ascii?Q?blBbR4eCi1Sk2mzcnkUMD4kaAQkeAYs3qDTEaNzLZPmza8WXD4XtqVEJKxnh?=
 =?us-ascii?Q?ek+pFjQZMkCMQji8p2ddAfDBeWjLCDdJeYjfzYesQ3Cq6tVVYoCZ03YKLtok?=
 =?us-ascii?Q?QXWTRVd3w9Kq5XLWnEwk1ZpU54TaIEf6+YQtwxcfpOVdg8T2T97eWgMVYvHS?=
 =?us-ascii?Q?YjkOK6k8yjvl0i+U3QJSqDpCSvCD0ZrBa8OV3A2FdGU8l0CzpkytGDakLoID?=
 =?us-ascii?Q?9qD4r2ot40rACHw20CudsriNzNfGK1hNgxfzItChg69YGZ5FUnCdHwLKU6VR?=
 =?us-ascii?Q?qB9aIoop/rWKb+fkZXDJzqkLnWy1iJWdKrjtG9GfIf3adxMbH+dgpbeeAgcG?=
 =?us-ascii?Q?gHBuukjLSyrZguUcz45yKbbJZivhaz5Pak9eQI9kmUPCN5nW4iDJ8TS1z2Na?=
 =?us-ascii?Q?LhJbGc55jS9n37ATievejwLG6iFKD29Ng5uXR7HyB3AG1QV8UvEWBTaXFZrV?=
 =?us-ascii?Q?7+QMe1EtNxUSkLVZiTPG892tRDAarCLYm3kZWD9ZFp3HtsfRLMoR0vzLb+9V?=
 =?us-ascii?Q?uBZQcn2+73PrMyXwdrTwZc+7baDm2ttNuN7Sc9ujsqAwQ3fCzZq9/pmXhuzR?=
 =?us-ascii?Q?NLysH++4vWX6L1w/8VmN6QOmoHZiTISfdh+o5hc7w6jKdNwG7H/3E69IVBcx?=
 =?us-ascii?Q?17k8LIfOKI9vUhyv87jDzinq+LBtRCJZ2sANH2AMhEiYhcXa0fTqChDWzxqo?=
 =?us-ascii?Q?swKaKn2bwbAMMPo1mmsN+nqCt55G2GBuf6acoHnu8iqu2Tx280PRt10EbqCH?=
 =?us-ascii?Q?nGV7avKRH4QtBeyy288ea5Giqu/cTajjBwEefcr39FNjS4ymAyuDkN56r1w3?=
 =?us-ascii?Q?N947vS1eL0duhlMxEm0rt31HTXdGpv/jgeqIsBqfTKeqRgugorCnY0/zKA30?=
 =?us-ascii?Q?3sjG7tolLy8lKIvmZRRanlmyslBuvIbPzNQJKRVjgwxG2EZ5Z7WC+zlRW14p?=
 =?us-ascii?Q?BAXxHPwwq8bYDE92iDWO96bI6EP/6uy2SYG4YeBNPQsuzHY6nWY/A0h3IiAx?=
 =?us-ascii?Q?38y0cgvU6grjLeZ6oo7XY2Sjzv9UQXCZsUKCegKKBaY8F1qXH8tovI9mz7ZE?=
 =?us-ascii?Q?EkWlV+OVGnYjrblFoi2mcpIFshmENxPaNUjEz959?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d93906-78fb-4939-969b-08dc868a8748
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:41:11.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm5LnAJxYL8izVm9I286cL1FLlLzwR1BfSc4mQAZ8Vt/3iDkD0Ygr99ZyF3/59M7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

On Thu, Jun 06, 2024 at 10:24:46AM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..]
> > > I am warming to your assertion that there is a wide array of
> > > vendor-specific configuration and debug that are not an efficient use of
> > > upstream's time to wrap in a shared Linux ABI. I want to explore fwctl
> > > for CXL for that use case, I personally don't want to marshal a Linux
> > > command to each vendor's slightly different backend CXL toggles.
> > 
> > Personally I think this idea to marshal/unmarshal everything in the
> > kernel is often misguided. If it is truely obvious and actually shared
> > multi-vendor capability then by all means go and do it.
> > 
> > But if you are spending weeks/months fighting about uAPI because all
> > the vendors are so different, it isn't obvious what is "generic" then
> > you've probably already lost. The very worst outcome is a per-device
> > uAPI masquerading as an obfuscated "generic" uAPI that wasted ages of
> > peoples time to argue out.
> 
> Certainly once you have gotten to the "months of arguing" point it begs the
> question "was there really any generic benefit to reap in the first
> place?"

Indeed, but I've seen, and participated, in these things many times :)

> That said, *some* grappling, especially when muliple vendors hit the
> list with the similar feature at the same time, has yielded
> collaboration in the past. 

Absolutely! But we have also frequently done that retroactively, like
see three examples and then consolidate the common APIs. The challenge
is uAPI. Since we can't change uAPI people like to rush to make it
future proof without examples. Broadly I lean towards waiting until we
have several examples to build a standard uAPI and let the examples
evolve on their own.

If there is value in the commonality then people will change over.

> This gets back to the unspoken conceit of the kernel restriction that I
> mentioned earlier. At some point the kernel restriction begets a cynical
> in-tree workaround or an out-of-tree workaround which either way means
> upstream Linux loses.

Right.. The kernel just don't have the power to say no to the
industry. Things will just go OOT and it is really our community that
suffers in the long run. As I said, you can't lead with NO.

IHMO there has to be a really high quality reason to keep support for
HW that people have built out of the kernel. Especially start ups and
other more vulnerable companies. I don't think Linux maintainers
should be choosing industry winners and losers. I sometimes feel I
have a minority opinion here though :(

> > > So, document what each subsystem's stance towards fwctl is,
> > > like maybe a distro only wants fwctl to front publicly documented vendor
> > > commands, or maybe private vendor commands ok, but only with a
> > > constrained set of Command Effects (I potentially see CXL here). 
> > 
> > I wouldn't say subsystem here, but techonology. I think it is
> > reasonable that a CXL fwctl driver have some kconfig tunables like you
> > already have. This idea works alot better if the underlying thing is
> > already standards based.
> 
> True, I worry about these technologies that cross upstream maintainer
> boundaries. When you have a composable switch that enables net, block,
> and/or mem use cases, which upstream maintainer policy applies to the
> fwctl posture of that thing?

fwctl is intended to sit on its own. I think it is even a bad
architecture direction that Linux has N different ways to flash FW on
devices, N different ways to read diagnostics, etc all because each
subsystem went on its own. With fwctl I'd like to see a greater
consolidation of not re-inventing the low level of fw interaction
differently in each and every subsystem.

Like you mentioned CXL has its own way to program flash. How many ways
does Linux have to update device flash now? :(

So, if you have a real multi-function device fwctl should be the
central place to operate the shared PCI function and the FW
interface. There may be some duplication in subsystems, but that is a
side effect of our sub-system siloed development model (software
architecture tends to follow org chart, after all)

Jason

