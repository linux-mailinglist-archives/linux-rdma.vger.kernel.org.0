Return-Path: <linux-rdma+bounces-7813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66243A3A85D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 21:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C43F3A5AC4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C81B87EE;
	Tue, 18 Feb 2025 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmM117aI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C221B9D5;
	Tue, 18 Feb 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909126; cv=fail; b=Vw4FRZpOg1LnB9I/O8B89nq6H5Eo+1XJi9TZSRyy+ebtJb78oAmanY+yqrtsEVCl4sXnIiSzgoOa4dnibUmOPda0i9QrHqgE2hL3TSUUTLETf/WWUL3nw5acbQDHHFZudjhMYZL90EBYHtI+rWVVsLl7Ap7XM0D8Frsb7GBT3AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909126; c=relaxed/simple;
	bh=BYIZOMgqKHJlGkKb7ZnBaJrslssZQJyRe2sRaS2rq9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nSiBO8MbXGe2f4lnnPGzdxdtABh+DH1QRLZQddOkWlmy3zbYYKZJa544aHODQno7Pdh1SweDmV3FADJvXjSPH8ah0/Vtorc8k1swu7Pxh7wYhiCXbqK4d0URzSSJkhlCaasuavikIExonMx4K1u5bZrOSEtT+pozme7FIvSkCFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmM117aI; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+wvHCBrDkSCu1D+NyASUGSDcnLuCW3A3n4MpfzsfzuHuwx9vpYCAQ3oSmKVVMSKk3LaI2fiadHwRIT55UFhnkB0mWmNxl74bSEz/jwoETiKsaDeQwidX1P6tQNiohsUCgtR76C/8QXD+6+aqw9gWFhi9PyYVTtDQGZKGl3Q3Kbp3ETmKvmbuACSXHaUjUgWsWamVWBqFPMi6pMxqlH0Oz1UX2NTDcFgdAqNaU26gjGFMHbEIGwIiVsZ5j/dKR8pFvKeujSe4GmybbjS8FR1mAvPxklJAxXp55q9dFYBtfUeEMNzNBSGhsrc/nVBElJ2z4pzDE1AC+uMdiytmAX9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYIZOMgqKHJlGkKb7ZnBaJrslssZQJyRe2sRaS2rq9g=;
 b=krufDgwV6KmLVhKiQ4V8CMgO/16fTnIArAAYk4p7QNUfhliYIPm+g1rE8un2SLflOP/R+N2JE0odip42THjH9dK5c52L9S3VDgbHmYuHc4dMR7BMoozCgGtaKjfxszjQxpADi4X0tn9Cpv0AjeqeL59h9AxnzmPaDlHesl5J5BK2eYCp07qXh4BUo63ue3vf6yfTd89l1oa9+r7WWFP9A2CPsZTjp0/v4KU7QFX7kHh7lPSrtNJRT8FaMc0EUQUq5crB7BaWE8KsKWB9ditM9TZZ6DAPbIN860uglHMqVKuNa8LS3Jsr1+Tqk8tO45vLTfKIWnDepbG79AtNijTrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYIZOMgqKHJlGkKb7ZnBaJrslssZQJyRe2sRaS2rq9g=;
 b=CmM117aIK+yql2geZa9tW03WjYfwaKY9GdwxDe+BcRj8Fl1maGiYB+oq/Ae4f8QeVEa/GY4fCi78yoOfFeokYx7ZCAPRGOE4kamBeIWFcV47KtDSzyVRnI85fr+Fo2z2eeMaSAopAFb1gmggpM3Y0bxPZiAysy8OOD6PKoKTTJjzs8vtdRCbC4O7RSP26IpxxYqIj5MFVXWdWyw/RZ8o1PMeU3tlv4luUugm/ttlKNJDvRoT30dgF2F7IHHnJeZrDijUM422a+rKSnRwDqRngYUDcqw2A9wS3YA5E+w82AyB5WJ7Endbi1KeU1zDybRmMlbbzLyyJIVrFPcQTulgqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 20:05:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 20:05:21 +0000
Date: Tue, 18 Feb 2025 16:05:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250218200520.GI4183890@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: a08b7dc4-25fb-4090-0489-08dd50579319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/z+RJFp65LsFJn11DWdagua6K6f8G5sWkIxgWf3oHklOmkXaKeTdgGTFcP9?=
 =?us-ascii?Q?0cZfK4ixcHPn71rjyMpFkUaac8x/oCQYBB8gHfVY2gO1RYnSOuORDamMfZdB?=
 =?us-ascii?Q?qVhuGFD4VkUSLQTY5bjO0WTH+0aGwaRPpAM/pvW9Q0RUWWDGK8wLjUF/gUpR?=
 =?us-ascii?Q?sc+XlPhvODKpm8MuRQlGho1URRpwahBcZfXnmdFDitU50UX4IQ9dVkyQdFeI?=
 =?us-ascii?Q?YOOFGFeLUw847Q1Y4YFSE7qdERU/WR/ZYNowy8SElSJdUB9RwCrZIhMVq5el?=
 =?us-ascii?Q?4UPQ9yMnQEg+MvFQvEMKvmYEJF9749EYjf2JRDRT0xpzsO66VwRvpgQw8qcr?=
 =?us-ascii?Q?B+zZnuOI9xifj02dXlUsf7+n3/5NTX6m1ALlzyaHP7HaMCpr9qKfCNONuCNa?=
 =?us-ascii?Q?BHmT3kot0MCeu7rBIBHTN+f89hyHtuCNab0FTVc+1dbGMlzVyDCOl9NaJUy9?=
 =?us-ascii?Q?IMQMaTozCC3XLnRyNvQCCGFaRE1XT5y4XoYb/vojjqkzvbnFktunLkjD3kqW?=
 =?us-ascii?Q?g8oN7mIU86icoIdRooF5CMlF+GD4UzcEU/OHI25TnDSoq+V9+1LAzCy5S+3d?=
 =?us-ascii?Q?JZxgJtTFheKtwHByJmI5QJfqyF+XvdK7TfdL5WTfCmMvSoN6jqRK++Blvkct?=
 =?us-ascii?Q?KvobIOT2JImFlKbegLD2wB0MGAxLBUaLMNEi7QEcXjF1J1gvmji6rChQqn7y?=
 =?us-ascii?Q?6CbLe1OBuaCoAj4RjE5MC76ZmfdOp7854/DNglHknltjqwPtMsByk20/OLXo?=
 =?us-ascii?Q?bMSygqHtPpkzQKjJrF9Ist+NXXnoYbolPyeSTckrqCdEWkMJJwTdsGvuOKBe?=
 =?us-ascii?Q?uc9JMKtqOpqGVKz4onDZmiyCCdZyBhH88MIhHaMUB3TKkEgLqJRgvctnmMCg?=
 =?us-ascii?Q?DpViiDseePrxbF3eo0m57rvRhiiOsoYTe3UYtU3hZkyzrM3ptEOodO2FV9nQ?=
 =?us-ascii?Q?Uh03WvVF0bnPdNP6QoFiPM7XVz6sv7VQXgz1mdBmvagUOeRHQjae1QkWQTg6?=
 =?us-ascii?Q?Uh4nQrMMMc9waymgxW+Ge6RBn7gf9OWNP6hmytV2TwzkXL0h9k7tBYmWItxi?=
 =?us-ascii?Q?aWg3L+FEqCEJjsLIsZwI+yhb+/9CzyE8EsCoL3aMb+AN7SfMWYohCG4G08cj?=
 =?us-ascii?Q?O72FUx6F5a0xG32L5WK3G3iEyrpmya4xVfR4ld9Fhc8IVFMuLYJpdTzsh6bi?=
 =?us-ascii?Q?ZK+2K1XxMJiTazNTCMTvvPlzRVp7gL6q4JlgVQ+Mhe4v5FsGMjmGiF31NYAn?=
 =?us-ascii?Q?SUJ5xt24VXCXCjmUZ+O2rmmocKAg0EKd1kD1U0JdccHajNCDiqHO0B08mnsJ?=
 =?us-ascii?Q?TJJ/INbHHHWDs4gPCRz7pOghz3sgYW7XrxdqLm7Lj8Cg4f8OEFxTZ07b2cys?=
 =?us-ascii?Q?mlF2ic+CYvAwf50HsUwAI9PmoY1/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4aY5OztP3QtuyGAn0QlqTCiysNwmtZioakP84v6sHjLOquV2qdJij944qtL2?=
 =?us-ascii?Q?kefd20Eg6WgA4Bwse7eKcrPaLRCyip09svQ2TtF8sdzevhWYC8gyxtTeDmkL?=
 =?us-ascii?Q?Zw8HBdT2voG2tvNS2sXunsyG5HDlgWMlUxMqy3tylGo7Jj9tFZGFvvB6MDhH?=
 =?us-ascii?Q?hi8MnbvCdB7cRgsVQyxgTrktpJypp8z0qoIbNaRKPnJfsUZF5GwLR5ccipGT?=
 =?us-ascii?Q?7PXovVRM8yneJkmZR4e/piCIsjEouQLID/gUhKrrNn+XC1uAyK67hexXfdx0?=
 =?us-ascii?Q?M1VPcx1hKGkEAFF+arnHkqyoNZJoY/ohJjgxdAk5zDn+Ss1+1zLQkcP36CfN?=
 =?us-ascii?Q?A08tg2M81dMzdFbURPqnNotIIJvRiOeJA6Q7rBcHlJxi9eukhPWcCCKSZUrl?=
 =?us-ascii?Q?+15OPdoMOfnAC8/GWUxejhP+LGHaArS6CcGRb48doSNzha2nrYk6xFg9DZBV?=
 =?us-ascii?Q?tErezTm1v+Hn/32Cn7nM64tRRRzr1i1/HcvLEq2MO6hLjbDVX0K+WeYbtoQ2?=
 =?us-ascii?Q?unZYW0KS5aZqyh+wmircwXDqW9hocWFZvGp70TuYjdZWLxtSPsuBS8XyJCWD?=
 =?us-ascii?Q?PWNECnVgb6RzdP4uw+OBZKrNTGJLSL0wV+hfjYlyteaI5CWgs/2SHdDqT/RF?=
 =?us-ascii?Q?M6oYl8XOXxGRytkQfnBxpo8bpoqWzWY3I3hb5vtg044ff0IBfu5f7zMm3CX/?=
 =?us-ascii?Q?VllHx5GbrAETBdgXS5lVLMm4iHx45GkVfurJ+Emr61TQgtO4CLtXT7VALpFp?=
 =?us-ascii?Q?t/AfU8uxryddEbswjjDfA5w7o1bGLvcSB9EestKR5CW0Ymq/6SPpWWovq9NI?=
 =?us-ascii?Q?4v7vZO3j7IIvDXB9ibSWdPzkEbLbrd+2TV2em/+/GHNoRuhGJrYCfCN1vbVw?=
 =?us-ascii?Q?Yhr+PV5wEC1OwWr/+tDnjhPx0rI2HNZmTlmLXIi8+v5Hxl49tJTZO8X/uzOU?=
 =?us-ascii?Q?K+DXBRMaIlqkhCISjJYvBWhemStGX4clP2c90vN5szpt5iN/Ue79cpQHmuOj?=
 =?us-ascii?Q?r3XJntwDSB3yNavNS8LIed3yxRCpWMoh5tY0hjjxT445YgqNNk1m+F8lbBxC?=
 =?us-ascii?Q?nxsD14hz2ZCLM66SI2F5XKa2wlWAkwWiQ60BsiVUFcYYaqbA5p8p31r2LKdU?=
 =?us-ascii?Q?mVQjx0bu/3/Vp3oOhwARLs5GAhMG/AB9CMliy4AuzYMY9lyxuhJXYVD6l1da?=
 =?us-ascii?Q?UzZA62SV3ardklFmKSlGWvlYUbomR0YO+KQsos5wbIMJrdLhTZ0yPfLZqwa1?=
 =?us-ascii?Q?tB9mi+9P6BfkAk1wHvBWxYzij2FO2hDZYPP9oWfJcnD/ERbGUflC8Rvul5Yx?=
 =?us-ascii?Q?YS5JCqbFDd+aoDWqL36W2w7qAA4YMNGgWiddHOxDxheJMTDD9WD96P8dLPb9?=
 =?us-ascii?Q?3bu+F5Y4negmS0zN5fUDK5Tvn5jRV9kIKK4w4F3FxDiumMCKV9Vx+IoXnwNe?=
 =?us-ascii?Q?OAjrIG9Pno6S7JlyB9FbnS/H2lpKBaMtf6ZBUHo6IRCvMemaxBgmiGVW8KG7?=
 =?us-ascii?Q?3CvEWr5BgxJWaa1tyhl2c8RgSJnagdBfUS51pQH1Dds+A3IZjFbVThWAjBUg?=
 =?us-ascii?Q?YrSl+NvLAxxubgaK+Cn6ojVS7qiS7W485ByhFyqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08b7dc4-25fb-4090-0489-08dd50579319
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:05:21.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcFIQKOkgNQt0t3TtCh7I9L+OqxX5SeyhXVNFdFntpMnuJ4vvf0MVHgaymaQtLFb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

On Tue, Feb 11, 2025 at 09:24:35AM -0700, David Ahern wrote:

> "Any resources in use by the netdev stack can only be created and
> modified by established netdev tools."

That is already a restriction described in the doc, not just netdev,
but any kernel driver running with any kernel owned resource. You
can't reach in and change kernel owned objects.

Jason

