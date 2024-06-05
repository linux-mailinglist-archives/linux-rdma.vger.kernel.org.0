Return-Path: <linux-rdma+bounces-2909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F428FD5B3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46E11C21A73
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9182E634;
	Wed,  5 Jun 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rhWnsIQ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01615E90;
	Wed,  5 Jun 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612053; cv=fail; b=DAeKJAMJULs18+2fuSjcqN0LTi2L3HRDFPXwv8QQMF3FObgY3BWFcsSHUikz+1KJa5A3iyM8GXHSsNxvznG0uxCw7AJY8pdAHW6AdLK6JI+l0oBouatIDdJ4bAZ7+CsZiQphPVJlXM58f8bPx6iKLa8xofzquGlmMS/jhSqw8mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612053; c=relaxed/simple;
	bh=/S9oHSxhfANSP/NtRyI+Am0H/iy9fNcYPUtHhdMrVUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z3qdevEd2tekNLIFFP90rsS8CV/bLBrCeDc9prq4x5f8OjhbRbIC1idyKAjBOASFJsV/5CCuRk2YDDJ0wmI0kkEF2XCvL0b6tXoeflrOL1qFTMf8LROqvBv+vBC833g0tc/zjzxqueSJJHqWYV5zG/l6Pw9bHXZfKpYmUXHUFA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rhWnsIQ0; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0C7ix+E3KrjWJzoJewRCjJhh71iEtYY+Nu+i9Y/hMndTksTgwvESgnfQ5ZmN2sDbiaRPYPmtg6SvJNoRh3kbcMvlv955dbatnHKgEn5VLPpEooNnGRoU7ajKCngVg/HOzJmx0H6ZW+BrmXPThsb3kjgrKF82yn9wo9RrWGuEufU48UDRDKoFIWeGUwVgWOVKaXaMMTjbmPZ3lQbJbU+rDTgKNZMhhyFJiDorCHP9sZKz9Fop4bYK+OhR+I8P1eUkeRf7rHN7Qd6NOo6yoeae1NouD1D3BOh79HpeJfdIalpUMe86Sa+452FxgB/1RcShIOK+uT9TSNs9+6CKKqD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NxpiiXF35m1H7lfPCTWPeAGjehdO/naaK4NX7an3Ik=;
 b=cnUBAq9BGPpZGRSk86B6zKmG338u5gvoX1MMnByYFdAbOd/c8aE4G/42w9KmQr0m+M4Z4/uzB+U+CGuncfiUtsLki1uWVw8XonJqr7aJj88C7QeW/Em2Uvf/gHMrAPNkRAXff9KrJ1FE8jE9At0UX/C4eKAw5LC34szr6HZz91IEa5RZNShCptMTbv29wZ+HmsCexKlmDcJ7H7lRDYekdjrmSIeRlP7BW5XuhgH2GyjA9566BsJtq4eb7gV0Grbz2H6eh64m7/7Ur6Jr5mG2UH42JTDJCARtIuNDB4NpOPpeKj9HjZ7flD1lifiMDlINKi364SXYFANK+yi/TcbJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NxpiiXF35m1H7lfPCTWPeAGjehdO/naaK4NX7an3Ik=;
 b=rhWnsIQ0xTdFbia4hqm9WX1cf+Ry3Gqn1tEcmwTqWVdOZRYEAVTl92v6LL3Jj5wqz/q+PyGkBHiApGippySY88+gHhzIR+Kcvu/fjhoqKWG424Qkuzjz6VUzRjYT0ODhCq/X39yJKYTtwJlcPgXBzJ70FVVXxdbm/C+hnewkwrA6tCbKcgzQmBOsjhEhSuBWBhLuFXsfO1UpzYvBR1wUUfIDRPcl/calE4f0ARZ1sF7nCfZ5kiBPKZdMX+4kJjk9SQwBROGq4CaFiuhkC88hlQ6bc1yZ1zDQAGpkIO9E4nYO3vrdPK53qKdFvTWUYt2HXvhZCNOiJSsyJg8gqiksmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 18:27:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 18:27:28 +0000
Date: Wed, 5 Jun 2024 15:27:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
Message-ID: <20240605182726.GX19897@nvidia.com>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
 <20240604122221.GR3884@unreal>
 <20240604175023.000004e2@Huawei.com>
 <20240604165844.GM19897@nvidia.com>
 <20240605120737.00007472@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605120737.00007472@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 504d825d-11c5-4f66-e4d7-08dc858d2767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzN5rD6eJKSysi9Fyfv+4UTN3QemU/0o3LzakDr/HuMAnzWcf89gPttHz2wM?=
 =?us-ascii?Q?VktMEjK+Y3fAPhw1wJuw2IEl0FThSvsIrQ4mDvQdrTvqsNLJAkzOY6NF1F4G?=
 =?us-ascii?Q?kzuTz0UhRKeziPMkVxZcgXlafhkFBUh3Q6BjciF5tOSqi4M6tuRI4a9ozPhI?=
 =?us-ascii?Q?8Ijt+KxxAgkazOOme05eDjrrFhYcVgH5VccY265KnQvO8kmcX8YpPl84HAkc?=
 =?us-ascii?Q?jfzAJt/ADApxLeaaMbiZG11vnelAP+oh5HBZY17wmT2HLXRy0vAS95ymg6BB?=
 =?us-ascii?Q?3jocG7CNvZmc10E1qIpTGMnic2GnIOxmccB8YL4thMLr/J9Eo8Xbbcmz+rvE?=
 =?us-ascii?Q?zEGGxcRfClZ3bYqw7JKPO6CTt//2qajpeLSml522DlwYt89b/2sw+u/F6taI?=
 =?us-ascii?Q?FC/hPfkklQihFXv6OIqcK8RZR2R7gEGuGzy8eQFqRcqJlyRdDilcv1g3gThq?=
 =?us-ascii?Q?s7DSMiE5T9xUsAp5yTE32Ds+AMh7glIgp8NRkXrPvQgbMUx9vKHSXHraQj1E?=
 =?us-ascii?Q?i1AHV/7LMZS5QqW5QlbqmATZbcf0cE0Il/rF3TJfxr+P5HLszintDA8IYMm7?=
 =?us-ascii?Q?3zuysAK1C8tl1NG9BBr2B19oAldY/qoWkloV2bWY3ue5jIw8UqFKrPGtglJo?=
 =?us-ascii?Q?HQDWKmVF8Lqj0CvJEIlsoa916cHszyIOzvbkj1mQGgg2E8kKvSSqg/gO9fqd?=
 =?us-ascii?Q?qNVFauhDEejS6afJP2J8KVgEr/7rRrkSpOCA7WGcnYM40x2dRFU+lik7l+YL?=
 =?us-ascii?Q?mcowzqYxqsvP4FYmsFcVMxjKuUimcqb4sGyMnBToDmf0Zpsz643tTMCM15Ai?=
 =?us-ascii?Q?QI2LnOc9dTfNqxsJtrNq4YQLB1mAbierVobsdj2OOH9iSu2C3fsQ5ilTiqAX?=
 =?us-ascii?Q?I+BRlSJgUBKJnc1jzDq4EbDqQlSPphQpzjpjn9BMgmLmAfxMhWzzY5hlbN+2?=
 =?us-ascii?Q?puiKgeBXIT0kKgy3gQ1sxGxCbtoCAXr6sSXainpNE+WkX8SqiD3GeKJB2BV8?=
 =?us-ascii?Q?1IoPUlIdec6bdmyho3I2ZfdIrwAMYyeFAJpjWXYX8wV4yz59d+iATfqHY5eX?=
 =?us-ascii?Q?utKOEBV2zu7GYcfmDbw6Wtfpu7Ee34D4+7H9MCs30nSvpalFniIuA5Ob3KKV?=
 =?us-ascii?Q?XVRklvkCwRk0hFEY+lCzmZ2M5NFvbnLnvpOYJMR/ji8Jb5aM031HmmYEjheh?=
 =?us-ascii?Q?HZi4eUFvphrg9F4PP8PnL1UxIpxRA5P3kwbDZ9KT56WwEAzVZXhebGY6fcSj?=
 =?us-ascii?Q?C2Rqp+dDmjEzRnGRWnojnPOLVjDGCSDydeOY2qOhqM9KBEAnrcC/FGv/KvON?=
 =?us-ascii?Q?12W+0q8INfUVWqAuJmh9pE2G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJFH7jDvG1Vxx6AjrQV7YMcdGSm1E5D5n5FVQbJH6KQAcMXuoC8vMOop8ny/?=
 =?us-ascii?Q?Izm6GW6Oux6QrkCbiTwLvnyPH/doWZe3tfECkfdxuQq/5rPFuLlehbmaJC1q?=
 =?us-ascii?Q?Cke5Rxfp3OfHGM/jjWweGV6gIKV5MOtXEHE3pkYEX+E8OH0sxCiGo2mU4CoL?=
 =?us-ascii?Q?H1RyltCHu31GWKJFECuYB735KCIRd4/WayN49+3r/TcGoPDfbWIQXOUfSCUU?=
 =?us-ascii?Q?GIRBtIU9u0xl51B41skgA5SxEceDd3z77HNnrdBY/BR2ocKqMDwkFRMs2LXl?=
 =?us-ascii?Q?/6DGApeKspTdzBRnDSr7aB+l78xOI1ZU97QOAD2O1dtk8kpSxBbVDmk7uhYJ?=
 =?us-ascii?Q?vndLA9wf7Zob+KYVknjP3bUEsFCGhrfpLrQetupPjScr7oXfAlgo9s2oNEEE?=
 =?us-ascii?Q?PUGly/1WQ81zViKvslTUAPGbUL3LKLzTvfdnr52+xdAT8SRqrYyfpKGaHkoT?=
 =?us-ascii?Q?n8LvJqf5ru2iGrufq1b7QcV06bHJkdq92eOmKjuxXkunhVE2p4AjoxTFIEbt?=
 =?us-ascii?Q?3el39fo8f/0kG18v6yJeGRSfY0LtEKufuia5f6xT5Otv/pz2zJzqUOAJnhqN?=
 =?us-ascii?Q?jE99Wf2mbT4Zi8tdvUL/YLLp9drr0RSTYf0l2GKVNGzC1V5VaYwhDESBRdj5?=
 =?us-ascii?Q?00/BnIvpfESJcG5YjuMWYPUTMRfgJXwk3LoQoP/70MddAy4yizmkThqXcC/t?=
 =?us-ascii?Q?mOl38difPXOHdu6b4YZwGsknvajLzFkQSTGu45nrPZD4km7L3+x5X+ustMku?=
 =?us-ascii?Q?twoig1zSrd84RLlWfDx+Xy6TaYSZPcFbO2hUa8nfbtyh9HtesgoX4sDIAQTm?=
 =?us-ascii?Q?2MT04MmEMCcfeO/OpF80G3kUPlq5GY3ZJpQOF+yqlYrjjTu4x9Iqlq6cDs6Z?=
 =?us-ascii?Q?BV5DB5n9xEti2MM+ZmIz3AP1/vUOiCTEN7XgU0Jiua52TYxTFMM4epIC1bDi?=
 =?us-ascii?Q?wBklcE2HM8v9a7Z9qUKtmD6N1flnAwxbKCklog98t9RDldL2QKVTwvFPLtww?=
 =?us-ascii?Q?2ndx7c/W9j2PWuuPDEzGy6e1M6SaS+tJ9tjSmXqds1gECwA9d95PuHjcmY5I?=
 =?us-ascii?Q?YZ573nnwHF+UZXofLgVdooVSR5IxgAAgPI9CK4WZgrVazi4PxBO1LyNz+Dbc?=
 =?us-ascii?Q?g76AMNWM0g2AxOSxFZAb53vhLyoDamnNq5RkF/AbNk7b5uzqUe58fP9Ynr1L?=
 =?us-ascii?Q?dbB/Dl/y9rwdu/+Zl6eT0bGRhKDvo12Sd4eAfeHHv1W4rVZZI3XqQ5p3686M?=
 =?us-ascii?Q?f1tPbblqFKcty50Kr+uaK6MJH/HqqnAqaOuQEoadCAPyO0E3aCSRbudcg+fi?=
 =?us-ascii?Q?vbY5RSfBrqi3zSDrMtMEJ67SgOyZwPlr6tOCSbW+RNCZ7xWzjOQcYwZRWCQv?=
 =?us-ascii?Q?tZToyRfts4Qm70eaiTbCBTs1NjTICWdaFCvRpSUS2a2AEv8HkiyiBcMcrEYJ?=
 =?us-ascii?Q?rLwkw9eVYghp4L0KJcP9DI8+u0wxB4Z6mVGdrnCB3FP/Ge+DN/mMpDfFsHsP?=
 =?us-ascii?Q?UvWw3+YNuwEKUzemEc/cBy/4rHnUBJHCD8EVsil+rRSC+Q5api01cFcBOuFQ?=
 =?us-ascii?Q?YU6jaIboBYaZssUMyFM/uXseuuv5g13HB7morSp3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d825d-11c5-4f66-e4d7-08dc858d2767
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 18:27:27.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH4HOEFYUDAw9/PVt9i3MpkwlyImXwKxeAyzr5ZtU9NSOjBU7QhOm80ZXmp7dfuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

On Wed, Jun 05, 2024 at 12:07:37PM +0100, Jonathan Cameron wrote:

> > I don't recall that dramatic conclusion in the discussion, but it does
> > make alot of sense to me.
> 
> I'll be less lazy (and today found the search foo to track it down).
> 
> https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/

Oh that is a bit different discussion than I was thinking of.. I fixed
all the cases to follow this advise and checked that all the free
functions are proper pairs of whatever is being allocated.

Thanks,
Jason

