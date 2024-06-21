Return-Path: <linux-rdma+bounces-3399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4062391268F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49441F228BA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D29155723;
	Fri, 21 Jun 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2SOi7jX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FE1EB45
	for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976115; cv=fail; b=Lib3OQlM6KCO17bopLIchhrCfr49g1jUDUJjHGfYeUgzNpEBz3Fc3KVpvweHOisA9cpfX4i+FGZEv3cWa8TF+1PQBQUNWwQ/2mWXQMYKeFY90ZNlQhYJ62MXD45scMY6TJ+w871mAl1TpMs7eDp3ectOn/2iL+MIyFWIxEFB9Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976115; c=relaxed/simple;
	bh=TIqeUcMdla2jbHtE1uFPbdxCj4HXEuR2RVWwzZYw1+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TMsn+00LSBdu9DeHB1wTGB63Kt3/E8KJ50RclHtQAioIT3Yy3C7Yf3xohmC5emBJRcSAaLjyQkLoqJ1JEPSPUZUFTe6UT7P1fECu/tZllVH7glWScHz5RSbGKUr+km35vs7H7XCSJ1DhERfOeRqX1L62I7grnDeGN42WzdEgu88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2SOi7jX; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyJ+FCB3XgY3CjMfgp12aXDy8IFwZgyqj04qPdhBICi1yxmlANrKnpbGuQPD7yBelWQcSNEoCj4rqMGsiENv7/qOqPfjJypU+GMU0DLxibpKkM19HD/1ybvXk+yvgzTx3RqzT4QdG6bEAdCgKvL+8ewOkFtwzpYGUFMY5/fty0zIewBb9KKzFnak0nHDEdqU/Q9HM0s8WccaduIvJYvvfPSkI8lZhkSz7R/1LuOO3abb3a1iDaSa3fmkUH5vmBq/qrE2p9zyFe5o7LLfZOAXemOp8WUCEdjsfCIlpGOAx8N6NTkvqmCtbagjPYPlBKnlL6m96+toTBifCFqqrH9pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH9o6Ska4/Cqy45nWWAk7so5MS39fg5KqZdqadFLvGI=;
 b=H1MrloopghoWqcpqf2gPcs380foKVYwE5d3yYrvzQl1nbOlgou9hOSVNN81LT8yh7fBA0WEg5glkSQWwuTEKiE2wu0/jsS9kK7eOOsohk9227/hab8porPjuP/5x1pG38T+NX4ScKADoCUCfg8GoQGt4yOYg5eqND7Vz/FpqhZ4IMoscrqbwLlxBwYps9FVJzkDtXoCRnCpBAi8X9uZOM485ZXF5OlFc+CFfYW52aGskswi+Y3E7IxNZTa/o3HQB4I2c8YxZ8GNbl02I3Q9mQMWlwz3aFBJN+0ypAwgHvKrhjdJhuzSKjypqOQ9gTlQzyvpRKAEljO/4g7gjwBAWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH9o6Ska4/Cqy45nWWAk7so5MS39fg5KqZdqadFLvGI=;
 b=g2SOi7jXhDpHxWHM7eDYiOyXsaesYNdH+U9FsbRPqOobGbzS96czsz+sEBMKxFva1QnP4++K/mzUdrJuiJfDU7LNmfAomm2OPYlJ4MkuE7j2+/3EUOGYOMRLbaMnftBGZkuo10/py/N9iuSU+Jq8l5boWgV1dKAcWYyqMwk5HLmOJWJL/W7GxtYGUZPemH8To7hBA7a7Q+dpqpuDAb4WCzvhg/FEHmkuBlxr1kD7rebWxs1GNZr195gY23SFoHHrirJU6EvX0jAJe2mtKOvdb8WPf1QFFMeUEIzmXtDTFf7LNIfRbp2rCX4xZpTHSdW87MB0wut9C84n7htJuXBjCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 13:21:44 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 13:21:40 +0000
Date: Fri, 21 Jun 2024 10:21:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak
 is detected
Message-ID: <20240621132139.GA4179191@nvidia.com>
References: <cover.1716900410.git.leon@kernel.org>
 <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0053.prod.exchangelabs.com
 (2603:10b6:208:25::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b3b591-879a-4ba2-e6aa-08dc91f51647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RR4M/xlOQn2nM0nVkMN3Gad8s1+tbwhTvJAdHDv4JtCCsXXpDPYvcl8Sff7k?=
 =?us-ascii?Q?1vdAcei61XKj0fGTni6P2WAj5JEqe1XgsoROwXGArSM45T+MVbmuUbFhJ5Wc?=
 =?us-ascii?Q?fj9Ab2GBjirO4Jp0mdPY2j8vx4mNq6UL5QAjEIXgSoJx+Hzt9EC+29VDdQoP?=
 =?us-ascii?Q?hS15VY2CY6JVpqNgUR9i1Lt9zGM/zK5VY/R68DwWQK4aTcFfLYPL+YCBwqMZ?=
 =?us-ascii?Q?s2JQmhUVMXw054e/UiAuXLYoqjrpNYWkSGedY2JLiDNWWADUbUTBNQwlscIe?=
 =?us-ascii?Q?eg5CGzAq/COjl3PAivr/NOAwBvDLKW+XRzywppQ6y8qHc90jReyIaVphtWJJ?=
 =?us-ascii?Q?V2h+PrNKbXn8Jg8YtjHzubimc2GC8SfqouDK1J4ZIv7mzWv409y24yO1AG//?=
 =?us-ascii?Q?Q6TFF8rw7hsXzPgOWLgHlblcl+/U3rvDohwZxKXZ/r3feIIo2B7Fp3BrD0yF?=
 =?us-ascii?Q?uvGG7oeOIN+B9AUejdhnpNb4EDIUpriRg5R3NG35CEx6kYKJjAmEL5xqiots?=
 =?us-ascii?Q?0tQ9/uuWz0MP7XzEKcyyAFekVgppY6z5Uy+P0zGGbiP9AHehzg8Jxkj8QVBK?=
 =?us-ascii?Q?kBdjHFkIM4kcO3YWgCg3fnlLgaCNZfg5P8HFaJ0TwELI+k5sHYxzBprHWLV6?=
 =?us-ascii?Q?furrqukGSGTmcH/sycWUQ3kSSGThFX/HvNNk3Fxao41x2gptpM6WQhmNfEC8?=
 =?us-ascii?Q?23SewoKOPhe/VzJ33DhUDIAtlXSMaM4g5QYIzhc5Pa7VAqXI/wWg/diQdvEW?=
 =?us-ascii?Q?0G8FyyS3ZztxC2vQezoXVcUkF0k98uuU7NpLjZSHbtOOs+Qzses36u33faLA?=
 =?us-ascii?Q?Iqe8oqAJUiwuZb3RbAXK99RV9RAr5BbfmZeTM6aJYqlquCGXYTt8jrcTI7FT?=
 =?us-ascii?Q?k0ZoW0Nl7L9lWtc8ri4YRDKWTplAC+QuvGorrpiKTqFMgTc0Q863Oi40SzGo?=
 =?us-ascii?Q?7S3ADm4/xZpS/mlwvThcX7bir1UDEb9aIQJHvSgOICJaTtGFMZZfWPMRDuLS?=
 =?us-ascii?Q?0KgGLkSJ/3pYSVhuJf6FPA1bYh3abyuTBEJfhHhYTQ4HNSPcfZPhLVoUkHLR?=
 =?us-ascii?Q?hb+Rf+1CgIdsfi173btbiCB2gk5ODY++xAit/GMFWMPLZzMS/mZrZhjSCKwc?=
 =?us-ascii?Q?pYZurj2Fm7yKFZw54Au8yALeELJgUTjpfLDwCTIZhYb47IcqUjyGWLafA0BR?=
 =?us-ascii?Q?/7LSN55IL9UJ15yVK3khSmy51AG68ykX7xUMWYSoXhYCAOls0u4p73lPmNPl?=
 =?us-ascii?Q?7TQkf0fS7RxIBEBzoCwZtb9gjBtivXplF3pfwbyTif7Sv9Rh052rWVFvSUIe?=
 =?us-ascii?Q?Mpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/Tx7CkviEXtBf3b16LsQP4/iB+AAxFY3/26pFLN4qEJxizAzDx0v+WPYAck?=
 =?us-ascii?Q?Wzahy0XfcFQVoOXmT44EETxJSN2SWG1RTYD1E0OphHUbDoPNf+KUg9WdNQ+7?=
 =?us-ascii?Q?Rw8C1iJe1qf4glrm+/ZIcv8bhWGyWJL7CQzCJhF1t1gqFuxWSL8vS9aBVssO?=
 =?us-ascii?Q?uLYrxloZDpOfneXrTXgs3PAsuZt+UnNMX6m+/nhjy76U/pve5XK42TOj+54w?=
 =?us-ascii?Q?rDskvXj0nzWK3Y2Vxh/HSAdaE58Hq58ASixEnF84K+NRuygXtRhtq1Xdm/2G?=
 =?us-ascii?Q?U6viK7DYjDg65mqo1/qCp4INDQK3Q8YNq5xprk6DdXlGiI5Zjfi/H4J8WGVJ?=
 =?us-ascii?Q?Gc5VDQ5fFzQ1lXgJAELKLhrdIMhhWA/rC7v25znWoqwNcJlrRp/0VMoyzdTQ?=
 =?us-ascii?Q?YadyfGQ+jU+jymk+y42aqdF4xCYZLMB7SH70HoMCh1Pz1IQ3Y6R5uXLvlucE?=
 =?us-ascii?Q?TIZf90KDpmQGUdnOLcGnpXNKTyVz3olcMhaTf/z1/hp7O6C6OE4t6oBQyyAK?=
 =?us-ascii?Q?6u+x+ot+qQsbTo8c3/u5jGKbBHRxRU9LLGcZe2yTauNFutz7k2lwL1wYTeFW?=
 =?us-ascii?Q?HopSXfSRqeRHjYbV0XYga59EEA3S7FQV1+5VlJbIeCPSxzSYHnzIlC4unWnj?=
 =?us-ascii?Q?rWM90QrQ5/tgtw+w6THGOeg+23JEOqC3FaF1X6xIxf5BP+SlAYNToTHiXG24?=
 =?us-ascii?Q?42WL3y7dW2a9ayzu07DjHKk4ucZ46YPZHotuALYhNPA9BMKIEhetpRAgsl1l?=
 =?us-ascii?Q?EJG7+3LcbsIqrDGZHmTTfIt+j8ytvIMGx7DqPZkoIqCFVhMvM1nCbtGmbYEV?=
 =?us-ascii?Q?L2IW9hySNI8vvLkaNUB+pwARM1ZrrzCULBmWlYtJApowxrQAzaAzcJ7uJ50z?=
 =?us-ascii?Q?Odjgd2H52FMyGcHPW+CSJBbvwLbHkKfebGgzeBH3QhaTfF8sfqAQXV36tAkJ?=
 =?us-ascii?Q?Rao8QF9SLtsWGFZVd7Pyr7JbgotAq4q5g8Kf7+MEcHZGLtT8zK3+WExBVrA6?=
 =?us-ascii?Q?NmdGgKBEWvusfj2Jb4hEBioz9Lg1Ozkm6ZVo11gt/PXu0y8XnhECJD98okrt?=
 =?us-ascii?Q?4ubP2BulDJpl9jyc0/ZnwwxJHAI1daRTPEaYb8HvqLyzbOj08QYktseB+MzX?=
 =?us-ascii?Q?XIHR/bC6G+prScSnFkuOnvENtM6OuObpXKAaXRML3CCr5lDhoitcRp6oV9EN?=
 =?us-ascii?Q?cH+fAl2s2b0P5AMWZ7FTEtxAakElotdSThA0c5SWRdA6wATLo+PqSPANF4Nw?=
 =?us-ascii?Q?IsExfVrgTW3RWz+z0nQj5UQqI0gXBmI4fWKZAHO+Rex60/33Wz8lOmB//azP?=
 =?us-ascii?Q?0K5kzU+NqEGwG4NtD6NHjO0NXbAjy9+S47g6D3hky/S5e4bUz+ps5nOY7Azs?=
 =?us-ascii?Q?FZhElMv5yO8f7GFDCEEyIiX1deqN2llJKFF9COhGng2PUhr89+mo36ZKPlQg?=
 =?us-ascii?Q?vnJiE+xCDso/DZn5osfqZCLxeuOIL4MRoAru7XhVyZM5SBgdXJ21U0fEM8VY?=
 =?us-ascii?Q?mHcbQd6J7bU8xa9aiZkNpvRNCo4mYaUfIFoQdMLW/Ymqwd95SgcPpBMd6jMx?=
 =?us-ascii?Q?jQY0otQJI9fMrCYaN5paoI9yRehCD9/BYWfG8gI4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b3b591-879a-4ba2-e6aa-08dc91f51647
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:21:40.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7GynPd5mu4+Nqap9pSijLx52KxxEEgkm1JnxEnCxO28Ah75OO81hThqHkUIvj3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

On Tue, May 28, 2024 at 03:52:51PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> When the table is released, we nullify pointer to GID table, it means
> that in case GID entry leak is detected, we will leak table too.
> 
> Delete code that prevents table destruction.
> 
> Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cache.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Since this is causing syzkaller failures and it really doesn't seem
like stable material I'm dropping it from the rc branch and putting it
in for-next. Lets see if we can fix the failures before the merge window.

Jason

