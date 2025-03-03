Return-Path: <linux-rdma+bounces-8260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A353A4C9EF
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714047ACF88
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A024DFF4;
	Mon,  3 Mar 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+pTdUBl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE020F07D;
	Mon,  3 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023003; cv=fail; b=B/LS6MkSganSu4CoS0lPQE7/6TSqu3abMeWXgKwU5J29vLS3UWEBLZJj+9pXtb+Vs0EjVi60tBG+MBc+pITAUKkEQpROSw5aJydiu0JiZAJkYutyVjDOlOb+JU3ZyBL95xhZjPn9kEQmJZyAwyjACWkKLSICDoF+lJbqLkM4xuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023003; c=relaxed/simple;
	bh=agGuzpxL35QNlR6JitQI3q/Fx4srL7G+r7ITqXEfdrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4LOJ+DpBTLZ7P7/pOLo7tsh6MwQG70dCVeAmSId+gWBAtzLE7fB/VLeiY1o6AJwMAWCXN4V6fLhqBL2cfoxj8mfNQ0b7LuSuyFXnxxw8JTbTkgwKlD9DzNxNsYNH0Dt+SkoEcAdDzarLjUpINqUXuQYgkV0D1IzhLjjjtRSHiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+pTdUBl; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD4Mo7/Ih12u0VSLpNddlu+UtjPAklJUu1SbasPQVjTyRFEgsWxJKTTWU04uAvekNX+iz/hOgZyJ5CBWKVPg30NC2eR8bVIdSNMzGO42dkcF0JeEm8ASMMNIitn5ncAp1sa3ruvW8DU1nXmccM4FiKoV9cv/VS2408z/m9RW3VygUAKNlGYwzUzJK8RiHKy3sQws3TZ5libBv9BcjdbF0EOClZRMmaijxLBcmr+FS0SaX1l4Iblmw5reD/Y8pcsJm6o5E7I0V9IkZ8s4dvyi4qJhrxrFGYAWzbnXOYUmTThI4i/DC+8il4O7UYe8B0poJI60lHM63f1GOsVDaIIqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G5zF2zUF0K+wjWyNjZEmUd3rDrw+03T5u29eO8WShI=;
 b=H/dY135+UHc/pL4IQI5rNI4S3GKwsjCwbPCo5i+uSUwQh/C3LZLBI9C8wKIM1VQGDbjOfZY/XPkieIHqstq+EAjWKpYo/L+puOlXH3lJned+/lIcQrNMLnafftQ6sG7Sa5yFV1s0vpzaYJMqjpRht2gPuFgiPBlD2g9OV/Hhr/DiFbL3jHKX/xmTMyat52KGRJIPcZXpAjG21fvBNojf4G11QbLn7QWPOjZxrlu+DhxlOhRULmsaEsj0diVJYgmRuV72OnGd/biDVT3XuiE6ZDqKnbPW9i4iLHj/1fwmNdbDUH2OMPI2vyjPMpLh4E+CfX0ZnOJ96ErPDYlprDqe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G5zF2zUF0K+wjWyNjZEmUd3rDrw+03T5u29eO8WShI=;
 b=a+pTdUBlsrgivMChtypQO9HXAY+n/jQB2QvUS+/szsy1qNTl6kxLzs9spzLCPk4xF5zu/65HaKthKZdQeLUIo3+1O1hoDFX9c6EHzSAEHicilgeDD0t2oWhFxpmtl7s+nmAtKGnU+4YXVTJL2jz3lZlUlOsFC9U7PnNGAoQbM/+rJvsHsoABeHxH23xzXJ015QVHRBvZLYDwHsJSKYxF0oePwL8LCwBWmSyFT5ZgyFayegNcsygo37TBvp4srPRL7aP0PiO5TJWlLSjS5vGp+8Vh3hmY34TDSK09pselCEWpAd5BqNq3pzDWaoH9mAryGVzXyDBRGNN09VKAP7ThWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:29:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:29:55 +0000
Date: Mon, 3 Mar 2025 13:29:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
Message-ID: <20250303172953.GC133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
X-ClientProxiedBy: MN0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:52f::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c201d8-bffd-424d-181a-08dd5a79032b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ib8JtarluyG6BdfGnLDPPKefhG9WqJSkf8K+n3eJ0l0nxgjYZS3Ez+AfJMlr?=
 =?us-ascii?Q?dEdG+JW3rHs/JG7nnIfEybPQoI+v/bGiWBc3x/5h+Mq9Gj/6qrLtPRdErpEA?=
 =?us-ascii?Q?bXoPgKwO8JlvA7Cqaq9wlijtV4KglFJ3hZL8hl+WBjwWRxMX0u6iej8342Tm?=
 =?us-ascii?Q?8ueu/qwmNYqsSkNF2fPO0QVLJHTYEHRc3SLq0qTB+4d1LO+53XN+KxnuKwd9?=
 =?us-ascii?Q?M4tch4AgkIOmRzxvSBvLxcyUzPSTujn1DODHlKIshsdfNlKXy/W+K+w6qkX7?=
 =?us-ascii?Q?rCDPXlP1+42YU2GCqI5N+ioq9X19ESfqcoctoOiP1eRyZBMmjcXmYeCtMFFm?=
 =?us-ascii?Q?8WZ/BO3EEsd+MbPek59lI+sufKqGjxGI7+cTVY/T/sr8PjlNR6wTBbIECoxB?=
 =?us-ascii?Q?tJ3Kb//PLzK4tIMJEraebIwVVBf8bt8ugYSV/yjvprXEfrSPEWBCNSAySQN3?=
 =?us-ascii?Q?sGbrjt12NVbeTefssF4+L4owgB584KZty3gxhaIfapwL3R7pJEcsArF+d4xQ?=
 =?us-ascii?Q?zkDu8rDFkbnLL4GF/j0p6rTPfwLowaUAiJr2VYCvTUMcjOI8pX6WS1KR3k+r?=
 =?us-ascii?Q?69sD+Yz31oEJMlxUtA+ezgo3rRE/Uv/D2rYpcJa+fj5v2SleMCPLqHfDdsXH?=
 =?us-ascii?Q?YMZKAEmoMLyYIcPt3ckswuPwW/2aSy8WrhtHVVIw9PgXERXdjKy+pwCGJRey?=
 =?us-ascii?Q?CxdD2bAOROmrZTeEmyFGLiGPeYcrllniiHayiandiFNFoLfudKXWAmHzAuKn?=
 =?us-ascii?Q?YkWJWqbGb1yq+ht6Kh0c8Oj3BFYoCTw0rM5vLKzqH6GPqAgxsqN/Vhqzn4+A?=
 =?us-ascii?Q?dr0qb3Ba31O8X/pgLnnexsXcixHvOGHCzx8al1RczEoHF+kv9FyDhx/v1Ye0?=
 =?us-ascii?Q?bshbtmKY0dEhLWoecumTs+RPjHi0Ikcg6PZNrUB3NiC3UD94YAI83yuwdheY?=
 =?us-ascii?Q?ns/VuH01ALjublP6TmZgTRe8YRa9ijWZ0KCUDshIxvPFouSATg0Vmj86qQhc?=
 =?us-ascii?Q?jV9qEL0ghuObLtWb4sRg3cirbOByL0r7aNR3iSR3qw35VJ+S4NIuDfHiwlyz?=
 =?us-ascii?Q?llVc22Pl60hPotsLkgNeC15zz7YXwFnFuD1uWcLp4+brOVTjILLjCcPTcv9u?=
 =?us-ascii?Q?krpl8AzCAGuXJy1Eu/9UKpfLwdgq1nrwg4oAo3luHJSNXtNIRE6rK/mhdlWA?=
 =?us-ascii?Q?+B4UZm+3Gwed6/sZuhOQxZv+YE5AkBkwnHyw7hG8vrSICGGgGLOAms6AVQ5c?=
 =?us-ascii?Q?+J4EOsFQSlvr4EjwIPNuQCSbXG6LwSka7Y+U4IOx94bqbsm87YVX/aa9RKMz?=
 =?us-ascii?Q?ihAICrYdpyucix2GpWSAcgTpSSAC+1temrmmLlA9q4G93ZCJUba4zX1fUmNN?=
 =?us-ascii?Q?oHLX+YyPoB2Rcjm46a3RBUO8xemd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4X58WZISkqUp5p9o7TLxhLIOdiLKZ9+cDHilJB8TC8dsVUTEMHDjzf8ct5p?=
 =?us-ascii?Q?IQ8lt8yYf1377TLpIHhsRKEQMDIQSyNDrikde7Vxl5mxEzD+5/RZEoUvzTQN?=
 =?us-ascii?Q?jsEsFN9uS0VJw5E6QTIVP0Pdu2Eq4O2p0kTQJr4TUrD2B2mY1y+kO9e1Xdph?=
 =?us-ascii?Q?t/B3G5Z/sCpnO/XDvWWvOiOlGDlb8TvxGZ4Rkwx0gryxicAB1yuLAQqBfFbE?=
 =?us-ascii?Q?liOVI/u8kFYpbG0Hw2vgwqcKZZ+3FxA/PmBGGqdaQAf0qEjNbbfAqmCJZ+V6?=
 =?us-ascii?Q?51krsEldACcfI0fxQHPNDWfOxvAsMfmuXW+yA4U/41nNGfqdS6EV7EYyKu7z?=
 =?us-ascii?Q?nGIPbt4fdWZ7/Ve6Vz3PEuisgL4C2BZgT/cXNVz93UMHlvdc21iJluk/8IQ3?=
 =?us-ascii?Q?xV9/wRRHlZWFc6a1+sv2x2VsQprT7gbhNKGKPPxJ41hVmxPtXoGhgOyWFyO8?=
 =?us-ascii?Q?3aDFZxolJBYci31Ty+x91AvxcVZsftiTH7HtsTpIJvKG3ib5qbqSHQBZtioX?=
 =?us-ascii?Q?LYgaUHGFTjAY2Kel4lQxWmMB8Pw/8uFLWuRbMx5Dv10DTi7uhZI1gLjfwZCy?=
 =?us-ascii?Q?uaKfGizmFoEi81cj+69wmJb7s9oYiJ/eJSm1cBAstE+zZRl5aR6CoitEoB/Q?=
 =?us-ascii?Q?J+lm69JKQSt/DS6r48teyu2IKl3r8qFXmzcA1wCqodV0qDpQhMIruFM4V1En?=
 =?us-ascii?Q?uRFsOEtS1mlihblxMPi7r0BC2yDkVbtpCVDo2MDyH8CiW/oX9ygr5CLfoQgJ?=
 =?us-ascii?Q?shZ9s48h5cFiXQeW5tviuXGyQ5o5ODZ89Omg48svoMwhQB2rqNkrZUkriIS/?=
 =?us-ascii?Q?zIJDN8eK4UDLBnl7LG4s/Q7AjTgARm2dBrySet2K+rOFpP9KDQr1FIucDz1K?=
 =?us-ascii?Q?flTs2waMvILAmTTvDaw3qGJ5j1fMrY+sENUVV1v7qqSfGLfvPrhj9qkFMtqD?=
 =?us-ascii?Q?g2eyWWe7NoVdNoWevmaP2dgDT48Llj8OUVena42Ih8GkVgvy/d3I5xHRdryK?=
 =?us-ascii?Q?PG6GCeNvZsuz52lUE8UE5z8J6Ilat2zueAu1bE5zXuC/ndEcgI/VHlfS8ipG?=
 =?us-ascii?Q?2G3kFIeIru+xl/nXjZRr9Pynl1r12Yz7EDbLF2iy2VFXsOh4eM+4vRgKnA6J?=
 =?us-ascii?Q?GuDCpmeFgaZAktJGF3YfFSTT5DJJQEZFMoYbHMnXoqFxYejY/4ENRIuT1MZc?=
 =?us-ascii?Q?E5DXjpj71iYw21h2DxPNKtp7D2IArlEcgrnaPYtFa9wDyAUMahpRvqUg+zAe?=
 =?us-ascii?Q?X2NbjGlNGVovfDkHXK0mADYDdh8Aq78uE+CV7blLNrpX2baOAYZw819U9GvQ?=
 =?us-ascii?Q?Fe30Xha6FYjQoGem0EqxggLVEGK8fCipYAuh0LHDjc5ijO8jW3OfUP+HqRjF?=
 =?us-ascii?Q?G3MNuIYrQkcRIZRfNV5Y4lKbzB64tX+bAMn4r0PWujmSFAIJ+Oj8QIoxvNT0?=
 =?us-ascii?Q?I00y2xAL1uXyGCuLRKX6rANaBpq83OzmyPwDoPVT5R/Ecfbm0nz/Wq3p67Hk?=
 =?us-ascii?Q?ayLMj4GjPkubK/efHslwQsytuW/jEwKjLCdBGUtypkndvTunDztOgs0j2fld?=
 =?us-ascii?Q?jEiUHiFSX+ycpAAhEOx3+IQ8sj/epRNyLjvjgupv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c201d8-bffd-424d-181a-08dd5a79032b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:29:54.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmQrIZGq14VZJ8BJlYEWUWC0bMXJVLZBgQWAlT2ezG/iji0UrG3BlGgrWR6IGRdM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

On Mon, Mar 03, 2025 at 09:45:52AM -0700, Dave Jiang wrote:
> > +static int pdsfc_probe(struct auxiliary_device *adev,
> > +		       const struct auxiliary_device_id *id)
> > +{
> > +	struct pds_auxiliary_dev *padev =
> > +			container_of(adev, struct pds_auxiliary_dev, aux_dev);
> > +	struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
> > +			fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> > +					   struct pdsfc_dev, fwctl);
> > +	struct device *dev = &adev->dev;
> > +	int err;
> > +
> 
> It's ok to move the pdsfc declaration inline right before this check
> below. That would help prevent any accidental usages of pdsfc before
> the check. This is an exception to the coding style guidelines with
> the introduction of cleanup mechanisms.

Yeah.. I'm starting to feel negative about cleanup.h - there are too
many special style notes that seem to only be known by hearsay :\

> > +static void pdsfc_remove(struct auxiliary_device *adev)
> > +{
> > +	struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
> > +
> > +	fwctl_unregister(&pdsfc->fwctl);
> 
> Missing fwctl_put(). See fwctl_unregister() header comments. Caller
> must still call fwctl_put() to free the fwctl after calling
> fwctl_unregister().

The code is correct, the put is hidden in the __free

However I think we decided not to use __free in this context and open
code the put as a style choice

Thanks,
Jason

