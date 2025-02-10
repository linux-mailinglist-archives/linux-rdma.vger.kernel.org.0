Return-Path: <linux-rdma+bounces-7644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA55A2F175
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8936A18863C0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DB23A572;
	Mon, 10 Feb 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r515A5h+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEF1F91D6;
	Mon, 10 Feb 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201054; cv=fail; b=ecd5TCszctSVw30aGK/u8nbZfIm5cJZvjh13h/3Cgvnyk0xD02OSmEmz6CT8sM2nDj6SN9RKxnC5qP8w1/Hhw0qjhsOn4xCtRAkDlZNe1EYrukWtsLxVXh7lVRa8RdLqRhowFCySeQypjcL+s+Mv6vtBcl/KF7EiXKFAsJ735Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201054; c=relaxed/simple;
	bh=HNMorugA/wvnBnTgjVMDIbzBMLZNzEpNY4VEkiBGQiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BU4q8MDflCBYoctqr1moISfRLai2lgvIj7hN2Z8aqBGiGzyjtpI1OkddKO4azGB/kzfuM/aWve7qZUyUDAvCJsUNAhznGRcLN5VI+ZRzc0yy0S+ZmoB8SxFrlYhQclGTdYOpUQwctL/RdkS0lqgMIBqAWJYJPrA//cUXgWhBes8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r515A5h+; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c87D6xs3PJqyZFxpCMTbvqYY4ApOLDEATrDPx7VUeMH9+Tf78QdSSwH8igDns4DnCQdMXg0wZx0QB2ZIjPasCg8iGwZNeKNlHSTszP//GPsgrP4YHfn0kz/UuHi34SWEfR8XpmNpyZChYFfpO9LGxbVRvgQv8xZmjJM0YfaSWZcTeEPNUTagFn4MYhBEQ5WkfOojr8y1Fq7p+2lzCXHIap4Vah3Pyj4J6D4PBqOUPeWROabhb7ySYLPTjeG464DOpiujw1fbUN/q7b7vM9bj9FFgLJLzvCupTxjtz1RYAdRtnp9kwMiBGTkhcvy48xtz962yaKdgD0aqLudu1/M/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0tp00tgf60r6IJquIOu+77YLqWDh7xq51TpqCB1r68=;
 b=wtDBCOPysMZb7X2k+XPkP+ffpHkI6D61qNE/SLrPhsC0Xryt18CJ6/5HaGCNcMeJzfhZqhZj5UoKt4rcua8GBOlm+1T9HgqBj7Mb3S0XYXUdPXZscMnvGKCcE0y53t8p/gHLWQPDsKAzvlYHMWec2OVpvXQ8z0j/BtyU/y+qty0UFpO2oEp5wlXmE3/M6RBVD8noMoAISIsFKH7MRYdv7T8W1uGtoha8mx+nuv3kLqgIDcK56CVp5LbJ1tjbLiRxRfL59rEtRddVbFMSjZ0GSLZaSHq79/lyB8UFyk5H1w2x8e6vzpdQQ/qUE4NhprmBbJpeWspfGHTZUuQvyiYojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0tp00tgf60r6IJquIOu+77YLqWDh7xq51TpqCB1r68=;
 b=r515A5h+9t/5UYB+morBPb2jRlHGrSsE5WOosCVsvWOkoNlPYCmzYcdNMEF5YjrNGdmK08ygeLIERKrHWSvewwFGd1OkuuZ5MWRGzZdbWB9d7CTWgBIAbB1X2dvxrnwj2UgP/9vJgbtJp2lT4Xy53qPvpbWZkHYWXEXJ+pI83qOgq2QhrjS9uwetb1z3RMJpB5renX82+JMteHSPIojJDiaZ6lOGaEhQ9JYNpy7ghkZl5SBpzBCpnVEEFAeTfJQ6ysNDbGNNGWwP70ezJGKX9O9aYVGzMjsCStvW8x9bxCaeke/Mv0l4YnlNE0ttl0qjP9ve2NhX3Sr12W0QxwdkSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 10 Feb
 2025 15:24:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:24:04 +0000
Date: Mon, 10 Feb 2025 11:24:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20250210152402.GB3755183@nvidia.com>
References: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <4c636d2a-939b-47a9-8e60-e9e78d757fe3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c636d2a-939b-47a9-8e60-e9e78d757fe3@intel.com>
X-ClientProxiedBy: MN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:52f::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 214c0439-3c67-4e8a-01c5-08dd49e6f423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ImAvEpTYYYCGMYSani35Uflqn4cZhOCxV3j2vtRGuJx50UyHz817xPp4JhX?=
 =?us-ascii?Q?lVxbK9eUOrErO/lxOlR012LCXAKtzCkY41btvUGLMV40bWhx0ABd8siI1QpR?=
 =?us-ascii?Q?B/oT6RNpF7MzOsrQ0G3Kx93IdOXXtFjPw+7mru8OHCnbobL/BwdrjvU20gB/?=
 =?us-ascii?Q?udm3gAfOp20ci+Cq4TRoGjAYtN4sA59XgIdH9Sywvl/QULgVZp2rXRIpGGT1?=
 =?us-ascii?Q?M9XwuWTg+NDHBunth2oi/Xk0qrRd/NrvJqgtQF7f1nLNQcGbQNXskSbxUxBI?=
 =?us-ascii?Q?ENDn+UpySW2hWcmQo6rXQwEzTEL/y14szy6sAz6DpFGrhF5BI2Jf9xjwgBie?=
 =?us-ascii?Q?/BrA+b5ZK01Yy+v0qlXARQhW2Z9PWb2w1Jo/0iZOIpA9j3nEA3wlTuY41/Tj?=
 =?us-ascii?Q?5IbD5rv4BYd6IrydShriA5KMgmWtYUx/yjIS6+QQ5qGlIAdc0Yn0x5jnY4yg?=
 =?us-ascii?Q?vJ6e7UvakfVeUbwKSEe2kzRWh8QLlPWAc9UbnAbpXgOspkE/FBmlIidC42fr?=
 =?us-ascii?Q?7UgvB9GDsAj1RMQGPyZguoq7nvPF/qNaECwjLrDgJ18RejGLd0uEZShaJqNZ?=
 =?us-ascii?Q?UKHD3QFz9M0oJKCwwjTDD1bBtNk9/C9jzJ1lpsG3zi87BMuZzEDcmWySXzHe?=
 =?us-ascii?Q?1NUkcOJFqFVvIn1kM6/m51TohjuDr0b+I9H6kCvr5TE3Athde9DhWt+3VD27?=
 =?us-ascii?Q?CKEPkT5lalhy3Uaoh9hsvgzSkRI3D9uVMwAjfLeVwONpyLdcBVHOSFeAMTcx?=
 =?us-ascii?Q?XuAaedhXa7i9B6X4S+wyj9Yy+YIt+052TR78KLlLMpt2jdyeGNUWrQYEO55b?=
 =?us-ascii?Q?5OTNLbpoJz30Fjid1Aj5zOUzPpg5TVCqvtGC0jhHowmoaP4c8j1spQ8glQ7n?=
 =?us-ascii?Q?kfyeQS31xk9H+tBiKxzGf79z0ddYvPBiT2IuQi+oN8uUx+oNuQ9H06KfGdz+?=
 =?us-ascii?Q?KaqvNrcRNP4aDwYuArOyNSEuhCvYlzVRM5UsHpbupe4eunZK12ukwW1wHfuA?=
 =?us-ascii?Q?8NXTGu5wiMTfAved4obKw3SbdFEkrHTQUz7HLnQEu//wq8A/u2I4dGHPq9M+?=
 =?us-ascii?Q?46QFmfTIgCzFrK7cBjmsKeWV7sMvdxeSZtnzeL6DI/lDeCats/tsckLFcT2U?=
 =?us-ascii?Q?gnGf7CvHjZmPpWXJopEKsx2kN9mtvlrURdWYMuqyy13Fr09n08rN4y+3mdY/?=
 =?us-ascii?Q?WIOdJ+DoJNGXR2QMg4K6z+XSeusRQyXADtKASaMdoeNcWDt0gNDfKDPiVora?=
 =?us-ascii?Q?C//zXTRfTdPyMsyleYLmnme4SoY2v5XrcKeHLDCOs6FcFCh+hUQ/JGyMU/XY?=
 =?us-ascii?Q?+gFlc7vkCtOABwjNSW2LsgPgepxQCT2fT1uIocUVf4soK3V9Yw1hujG0hXY1?=
 =?us-ascii?Q?7DUHMc63Fcsnbth2GvSW2SRK3vFX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qozj0s663bWB8A24gwL4tzip4z2HrWn6ABJeKZLMtqGx27r76BaR6wumpBPq?=
 =?us-ascii?Q?eBKW3xzhy3U/nNLVU1ah7qp9C4g3RIxGenNACba7+HaJcfNsQVLXnBlKQ6N1?=
 =?us-ascii?Q?DO6RtsBQoe3IuddbmIYWyUpBgP7HSizkZ/8GlSITHqtmi2aRCke9yZwG/3rN?=
 =?us-ascii?Q?xv0bePYxLO634uaWCDaHzsC1Re7wlfpcbJ3VqqAGQscbhH+PLBOYn9K8sWb3?=
 =?us-ascii?Q?vfQlOXVVD38eK5F6p+aw7B4HpP2C99tBi6tstFqVFva/6m0Eg3miN72M3a4i?=
 =?us-ascii?Q?vRO+p/e+eSXufGIkuDfAoYrXY1VNIKInbq6Bu4I0IU+AVZLUduhMTFTx1Bi8?=
 =?us-ascii?Q?Zgw/vl9C2dIq/DlAFxzYrG4OyVEwWIEIQgRMhqYy6aoY8yX3+0nmjds4Qd0+?=
 =?us-ascii?Q?1uh/eQZ5bRuVTlR0EePLHuAJF2xV1BTmZvEzxmDgXDMKx+CE8xedHrrxlKmq?=
 =?us-ascii?Q?fJ8kQQpzW9GxnJZOzngzADugtgwQulvPzWy9z48Cg4vH4LdThXc8zge5nXJ+?=
 =?us-ascii?Q?pL/Q5Z1s/ywhJ8y2GF8lGffu9ofttjryimacYJTgpNb0ZLboWiWorlN9DWHj?=
 =?us-ascii?Q?TUtzM3PuhWeTwEJ9UOf2RfNI7sN2rv/yyK4Z28lld2oEoqZUbYAKh28aLxcD?=
 =?us-ascii?Q?rPkNEsRZR24nQukpivxnv3NS9VXFC+HoK8v6aVAG5ScGTYff6taby+EI+kgm?=
 =?us-ascii?Q?MdOwNiXf/ov0l1loZ8XbdBJVlKz4ge6SNCCdBabRVVZjxMhC1GBuviPcMJIM?=
 =?us-ascii?Q?bDF2WxXB+QvS2ctd7Sk4UHscApTCx7luVO3ET4ILCnwKHBCrOgqU8BN6LPw7?=
 =?us-ascii?Q?KZ0ISYa1ByzjxcgejqHadzrbIwHWhFt1IwaNbv3s1aq5Jye8cvvJmDA1XJUO?=
 =?us-ascii?Q?2sfVOYLw6Mzp8mVpr7B9pYoMJNc1cJ2eGiqSpslbxBSxhcRJdv5wHV3x+kFe?=
 =?us-ascii?Q?EH7g4BZrQB0jeAP65cby6vCgOWb6wx3Wq7BaT6KMUv/jR56HDR+ZBFep8G2W?=
 =?us-ascii?Q?oJ9wh+S2XfMjM1w04BWMzNDQsIGD2K5o2ayAETzv93Xfa3IvOeHCdBF5G2K1?=
 =?us-ascii?Q?TDSSjHAgATIgNg9g8Du2t2/9iRRd0ll8XiISHTUpDloQobvCySewdCD8PDdM?=
 =?us-ascii?Q?tlfjD7/psEI0/lQEBwwXgdP19Q5aZMeRUSRlHhwX/T5bGyD7MqQhwT7SBs7c?=
 =?us-ascii?Q?fCNfgEM88+pXqA1KdCiOaVA87IInrmQLa9/UADWwatjop0bpTybYvvuec3Uq?=
 =?us-ascii?Q?01RHlUHIM/6516ADZrxGonbzRB//kFIa7xt+ab3WcYQ2v/0MOQHQD4RjjGpp?=
 =?us-ascii?Q?rKkFaiZ+tbsH1tCw2kN8OCARm+K+gj+Y9So0ZZw4HM6Mjr1iAR308Wt4lfka?=
 =?us-ascii?Q?+0ZIhxRalQ7Sc3gYJBeuRmZCpdCYLRdoXtdBYh4CXTmyFCCQw1bLi7rTrLHG?=
 =?us-ascii?Q?4/UnOsW9yodRz3Z5Z7XbqVs0W9sFTRnGNfixauvRlis3zhkHPPkvof2KbXIB?=
 =?us-ascii?Q?/0DqcnSmfFXbBMcSpHxKEJ/htQ7i3zbFiwc/TzsCg4hFid+5nZWuVKL6AM1K?=
 =?us-ascii?Q?t28xUM9P+sGR9hHH1qOFyJEsnIRkrr55G0hpR+9s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214c0439-3c67-4e8a-01c5-08dd49e6f423
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:24:04.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5BhpahX2keMxAJCheWEqpxsJghGuIWUijxh9aDZSBoYcT9BwcmngS9LpOyTRihE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

On Fri, Feb 07, 2025 at 05:16:12PM -0700, Dave Jiang wrote:
> > This approach has proven to work quite well in the iommufd and rdma
> > subsystems.
> > 
> > Allocate an ioctl number space for the subsystem.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Got all the changes, thanks

Jason

