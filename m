Return-Path: <linux-rdma+bounces-2196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDEE8B8994
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D71C2188F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE183CC2;
	Wed,  1 May 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZAZF0PbY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460774437;
	Wed,  1 May 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565440; cv=fail; b=d31Zme5lupzFu3Yw/8R5XqYv7uPNQkRrauyXAtxOw5V6QVLF98l2/NnXH2bZDZCmlTumkL0cpgRdprWTX6g7/wOSZHA5TH7Upsi7ns/leGm6uw2GOcSC++qZ5VjJb/vUH03+1FDAcLyvcWlv6IrzxOpmhjmp3mRChvwdIRZhAbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565440; c=relaxed/simple;
	bh=6jBngJ+iy2VGj/xWmxGjLQ5lnLrx4MpBoH6W9fT9QnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gtEIaVfkZJqvVgyu+tN4ihw1NXVtibaUx9BVPXxNQ0w8wbH5gqWnf6GZYOsahHrlNM445RYZjAGlXfj5fRm3A/JMo02oOSE7hWRQTW7MOY9Ywt2ezBZeQLc416KwL7gZBWPJP8t7SCY47E4wxnOeLJmZ7af4WnZ5Cwp9ZJ+CfAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZAZF0PbY; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns2qT7Yx3IClk6eq+mWQfjg/lQvVxQF/Hevhy02QZcZw6Uosb+lJjy8H6ARl7k+WZoMJT4n/gt71fdQVz9JgTN/dYjZdjxEsIHZKdihSlhvic7/9PCHHPAmGEdqj2R74EzMvDzDX7kCnhM3bhTPnmhgY02SxAG+F8B7DQPaEz3tUGDYqBQcK6fPrCNUDiP48nXD8Nn9aDFKWerOEBC4fJ7j0vHB9Sf0TXeyf0f+ej6QGnOY/GpmTCi5lfii+JmFVgXG5VA+yKEqJrQZ/sQb2bR9x0+70muxD6yBibZkmIANftnI7KCfA3FucV1InX2WJv0GRLAIa8gU+BgulO558Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnJkJO7orUqyoqrS/FjEYW9dopHDcxHV/lfxRSrGFSs=;
 b=LndbW8qIkZhXBXrAIp/kJ3xBVkfLEbuKV3gVyG1AZIhsx7IgELjsK5ehIjkaJxoITsqPjQ2e9UKHkv2Gor61mApFKKSL616jjZk3VqmFjUKh+UsXUGdzesUsxCQh/jqkI7M763+JXV/JJzhjN+skNFR49tD48UT5jJ+JIGsTGULfzUYEMINKi74wcz7P2YE4lCNpOJbB1K/V1YX3k+CewSgGBapoB7Qk8UIhTAEsm40s28ZwnPosqS59HTAWocnuYMKhMSexuGuxCGRoEHGGb0wBR0jck6mw4+qJyOfKD54l7BhlIiEE9Xu0BnzVoZPIR6Sb3TcSDvV6Mk8O7fhFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnJkJO7orUqyoqrS/FjEYW9dopHDcxHV/lfxRSrGFSs=;
 b=ZAZF0PbYpAukV01czbfEiKIvGruRHvOrrO3Lx4u8/akmNIfMbKZtGWtEC5NR+iB+8NuiJV316fIFsMnonRAs0iMlwwjY+Nhmgv9BZ9F0rf3e8l2tpX1UmNWxcvXuINZvfco7i1PrvA1wKgMawcMH/OOBgCMn1GDwGk6Ikq3TuGguBkynAtqiIdNZ3JdUc/h5FzsDI/2tMhUm5EqEV4Ue0eiMe5bEF9hBTG7OSBTSE3AovlOh6tPrceWOBfmyXCtkb++vRsc9j+HoZNoL7o+kN852Cz/ChSYsfwff2UAZLp1MXVH7ofMKaCZvqagBnQaszfhcYWwY5LGrC3FB5LjX0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 12:10:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 12:10:34 +0000
Date: Wed, 1 May 2024 09:10:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pak Markthub <pmarkthub@nvidia.com>
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Message-ID: <20240501121032.GA941030@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHO04Rb75TIlmkA@infradead.org>
X-ClientProxiedBy: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: ad664f03-e733-4e47-5f08-08dc69d7b41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtAEUFuSCuTQwbFH3joNXrkHVodfkMxG796g80mnGMT+bGnSyeCYb1sQZpX+?=
 =?us-ascii?Q?ch5xNtgdwjLxocicSl2zJzXbiIXqqI3bI0O7FV3jDo792onPjbiq3lFWmIE0?=
 =?us-ascii?Q?D25dJ9yoj3sLUCFE1hJ5F0MLTXQEXDnEUHfrFEy+V+qQ8QGF5SYQWHmy2qZz?=
 =?us-ascii?Q?YmP+HRS+Qxcfdqa1iGF7uFz+8OEaRpHGHJgqZ4e/EN4Z9qQxVU013qacHj8e?=
 =?us-ascii?Q?8SJV1jv25sqOHf8ng9WgdiKWMHHp8MIdhBxkcbZF5Sl+nUOVyEKDbCDtMcla?=
 =?us-ascii?Q?j/RDcgUE9A+VrnEnS9tFYysosiphmLKYPX6cNDe+014JLmEvqP5DyyXMH/ZL?=
 =?us-ascii?Q?gqvo2L4sHHHRxj/ltYGxrvwHolv8sQ3dgJYwsGeSK5a8qu7717sM6Xn6zvWh?=
 =?us-ascii?Q?q4350MAr/avYTxWExeL3jAWgktEQCEP+O4EyOJK0KYsXbcGwBT2Lc0LhHaK1?=
 =?us-ascii?Q?XOIyl8HFoDesW6FXthGbnls2fdzG+Hqil5kNjeA5v51XssDMUczA3lcvHd7r?=
 =?us-ascii?Q?UkUegogw+ebV8FAXU2OggKCmgoQ6WL9g+80WD0MRDIMpX/d+Nr1S/xGMK79o?=
 =?us-ascii?Q?VmZsP5a0P8KC56fKP1ooj9rFmneaJH2gTNKSoghrDNjIiMYk7i/lUbTNRqtm?=
 =?us-ascii?Q?9HQdttCVdGlDmP7mh8HeYvMyTR36Qubk3a616xD2SOgUlc/+bRY7h7gayPIi?=
 =?us-ascii?Q?Deq/iTPc1P7CC+q1U5xtQgygAOZcQW3pMNjarAo0OISuJ0ly2rkHQrBRLrFB?=
 =?us-ascii?Q?0wYZ4JqyspGsCeg0kDggf1bfngsO6fenD/lGYcaEzBTQKMvfS7ddR1F01xZN?=
 =?us-ascii?Q?BP546fDvaYbyC8hAQdi8IbvfNtMEyuLV4+FEzc7mQp7cEpmxJn3TguMoDfkk?=
 =?us-ascii?Q?F+khkqxqB+6jLz4TpjtL1ZomBbZxctmcOaLLvK2dFrjhejCSYh7tMVwBj6eM?=
 =?us-ascii?Q?Rr4pcrk40drJYlUMHY+nSCQQPb5QFfgBVzVnDNREpPallzgNnPBcqrmI9BtW?=
 =?us-ascii?Q?+c/ipxB2xTPkSvO6Fm+G6hpF+Sw7hpV+SayvcljWDQ3dYZ1NNj2GGGhltMiP?=
 =?us-ascii?Q?M7vscSu5DQYkOrSJXuZ1nsHjvtOesFs7A6Lh9VF+A8c5nkjIGrcgc0Kz2KkE?=
 =?us-ascii?Q?72Kovc0ZpKTOjPYE9UTCy8Tn8GcefIWdZgjiJoEGhIXoAMXbyQwbH8Ex7zXF?=
 =?us-ascii?Q?U34bYqdNo8/x21J9tlCXTkGDk7IyA605dGY2hwI/iBOqOwNJ0wPmqgOaRwRY?=
 =?us-ascii?Q?W7sjTD/lCn7J8gjF+c/akSOF8q3UWHwuRzEGcpQoMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mDcEyuKOVjIAERu9Qxo8GmTEsJYBGtc/cDf06KkCC9JpTmGG7XgM97VH6zbs?=
 =?us-ascii?Q?Mwk39pjsAL5kZXOXp0KHliu4HEyP+EoO2iAvmedD4ezpp9w5Dk4Rn62MxvBE?=
 =?us-ascii?Q?l91uICDVp0gQpHPgFnC7/+LYUzRGG7PBEQAQINqPADSruQ3DkMLSABrNsWCF?=
 =?us-ascii?Q?xwVsF8ERED593Q0u4qyTauh0ufA/juSMFLr6kqkFAjUSdXNoeu9Jhaqsm3Lr?=
 =?us-ascii?Q?75ZGVmDH5hCG6IFp3xQDwHqMRL9m+DIOUSbs17ETfI+jpP5c27lXXFnjyolQ?=
 =?us-ascii?Q?YsxLHeR2iWddh/8nlNJ3DNBPbPv+7BDuc/t70fHkJXXs0pNlF+9G4VfWnfoL?=
 =?us-ascii?Q?TpD1ILLXE26OyyG7SSoXxIm4NgsdtdqYGnUkhj68WYQ55EviivG6ZOcee79H?=
 =?us-ascii?Q?ktDxippODFe+kx2ItaWX6qIjLOQkRG/FIEnNhulwu24kH7wWMc8MgvK60Xdf?=
 =?us-ascii?Q?QjFqdMYB/dwsV4eDw4SVJz3I7vZLZoEBVl8elJg04BEcFXAO+/g89EtlPgEM?=
 =?us-ascii?Q?beFzmw9vvwXstXyVCcDN3gBiZ9iS9GlJ7CPO15d+6MAWguhhvu+9bVf+Ck5j?=
 =?us-ascii?Q?y1N1P5GesSE8VBhCVb7cAqWzwJCleMO/SxpkakI+ehdTiwVb8rAykPF4/ARz?=
 =?us-ascii?Q?vMbVeVhAX6Beg44/WsMKUJZQbxHy7aWf6OoioYeSe/hwNx64ATlbIUwAzelt?=
 =?us-ascii?Q?XnRAuWQset5nHkwAlqxg30W9K4E0WdvDKZTo7DdQAiJYfulYBbP9nLsKYRXf?=
 =?us-ascii?Q?GwY8lY664YB9xthz8022WXrslvU1LxmbT5PBBCcG6BgU+qSIyhJqXNkrOROS?=
 =?us-ascii?Q?ZY5NwY3mSIVaDAUgecf7ABRZVyzjjiHKDAGhAjW9P9IGYqrX7hv/olIRlk1B?=
 =?us-ascii?Q?bgMvaxUPeFl9Luhf5yegVzCflux+VXhjW0o3rMXTMN6/WKB8ESUQZCgstRGR?=
 =?us-ascii?Q?nIsu768KS4msd++EAxON4G1ApWB/SC0GPtqn9hcS/JCfCWIKvf3PkwmgGtQO?=
 =?us-ascii?Q?h8gnpQ90b4hQpW2v4STeCF7483yA284rB6qJ+BSGJnspUgq+NtSl4bCBbJp5?=
 =?us-ascii?Q?uqpTfmOgD+Hbgd2C9L4RJ7kimUyOd+r7R43b6/4GWbno3aGVZzO4aVgrjGxj?=
 =?us-ascii?Q?sZCaBvgjnq2D3q0kmOxFROfL/3bOx1lBDt5XOKgXkeCp4u176crnGQOSpZmW?=
 =?us-ascii?Q?LaGcUcWxkxeEGDr29nLG1hLP6YDgcYVu+kxz0KbCJkZyFBfYtSx3uFHhaYzB?=
 =?us-ascii?Q?1iMLHEh/rMTYLMsInXT96zhKpKSj7qCiC8PVh0K2qq/ZE2ce/73GPocnwerM?=
 =?us-ascii?Q?KcFB7uQlIzPwO6WWk5msr0gRcs+qr3N4ZdZ+cuDJb7bdcVVMdJiEed3cY+hY?=
 =?us-ascii?Q?H3V9bYWYI5rHW9wthAtkrdNhB5EZ0ZMNAEn2isx4oVWB/5qqojrZJfVd/tOm?=
 =?us-ascii?Q?VjeihMQxjGRCZHV7MnTqxzyYqyMLwDXlDZE6FtrsUcxIu2ssfixSMUg0rC1U?=
 =?us-ascii?Q?OEkhnmLem71wigsApUvya33kFIlUyvs84c/PZt51Zn0PPQVov2GTzdE0div1?=
 =?us-ascii?Q?TTJqaYE65A5AzQGEnEIclox+czBaXFQEKI9aMeR+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad664f03-e733-4e47-5f08-08dc69d7b41a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:10:34.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+r7PVpf1xn4kawtTN5uNQ+nybR9mNnPhUukwuhUcVqjbZxhSU+Ipm0bS4SPBbon
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

On Tue, Apr 30, 2024 at 10:10:43PM -0700, Christoph Hellwig wrote:
> > +		pinned = -ENOMEM;
> > +		int attempts = 0;
> > +		/*
> > +		 * pin_user_pages_fast() can return -EAGAIN, due to falling back
> > +		 * to gup-slow and then failing to migrate pages out of
> > +		 * ZONE_MOVABLE due to a transient elevated page refcount.
> > +		 *
> > +		 * One retry is enough to avoid this problem, so far, but let's
> > +		 * use a slightly higher retry count just in case even larger
> > +		 * systems have a longer-lasting transient refcount problem.
> > +		 *
> > +		 */
> > +		static const int MAX_ATTEMPTS = 3;
> > +
> > +		while (pinned == -EAGAIN && attempts < MAX_ATTEMPTS) {
> > +			pinned = pin_user_pages_fast(cur_base,
> > +						     min_t(unsigned long,
> > +							npages, PAGE_SIZE /
> > +							sizeof(struct page *)),
> > +						     gup_flags, page_list);
> >  			ret = pinned;
> > -			goto umem_release;
> > +			attempts++;
> > +
> > +			if (pinned == -EAGAIN)
> > +				continue;
> >  		}
> > +		if (pinned < 0)
> > +			goto umem_release;
> 
> This doesn't make sense.  IFF a blind retry is all that is needed it
> should be done in the core functionality.  I fear it's not that easy,
> though.

+1

This migration retry weirdness is a GUP issue, it needs to be solved
in the mm not exposed to every pin_user_pages caller.

If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
then it is pretty broken..

Jason

