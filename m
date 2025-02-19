Return-Path: <linux-rdma+bounces-7860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F147AA3C6C9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8117A660E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834262144CE;
	Wed, 19 Feb 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ns1t10Pu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE91F61C
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987622; cv=fail; b=TCVfZoQYUW1MgminnLJJFap/we52pRhf4xYMGWwGEimG2Hxil0llUgdQ0D14Qn8ATIYVt/H7LiOe50uFCoSxuv+cKWAcm66LTlMnanRlO29e6oOBma0dOvGW7r9lCEncCkCA7WEmhSh7m2LTZ3/orDr0je3i6w2Lvmq9blxXAxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987622; c=relaxed/simple;
	bh=WxNX3059D6e2KetG9uc4i2g6HUOBVGJbA05VBJK4/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W4irBDw+67JGsiARUx+ruTuOnKdh5sZv0I2+Z9jYVIAUoL864xfTnOS//1PTgY+NLYkXb8thb7/gwFd47SoMqznwcM2dxtELZzhRXPvk+nK+GPZddAfLxStmgX87uc4ZjGAlfQBq+UGxvmTHm6lF4l1TocuIsk0AySk9irwsr1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ns1t10Pu; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7uRpqNmVSF+mQ2Xgpy92NzQ2iKWG2krTj7iHbyOrzz3Uu2qt8EaySFmNwReqKoIecAYXOqWDo3C5R5NdC97aHRk5yaPDTcqWBfDWbJMIKdNP3smmldu8Yg6TAo33makAERfn1xKQFHZaPGcci3eJwCjFbgP8zw7j4dVBnzpf2KgqtFczjah/r0MG0e6Ph5rIdYrov/KyX4IR59/8RMvXPLPNfNsY8g4RPktGtp94WlrP9iBpv2wXU/6R2epQvpAtvVXMZP3wNcV41yQsy6zsqnLrn79P0uJ1XnRUeG978ki95bBnmTJOqwmp2ahScH/+Y0pcCFOb/gNnU8MDIAmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez3gZPGNkUdKFZYkx5RYQGupIqVHbebk8y5VedHkcsQ=;
 b=ChT1pcFJdmagAr2mbkw7rkdviI+f5kdkP5DGzpnyIdKxlAFMr5htptl9l+SN9PsmgEI39qKjJVNkcFiNgtOTAMDnIXtqrDatoE7QeH1McCH9GRSETXAych+25xyiqxtDiAkVHC1HcCOFAcuvsHsQi/S/mUxzn69yDEheKxxVfqh2O/eAsNI+0tARZl5SzujPDPeOGMwd7OyuaJ75JpabzXAKGibdocEUWNpQSiHU2VAOUwSRIPdD6XvpvrjByQMpqW4pLiYRo/h62u+x1O6nGuN/7Lpji6CSGjz9GFwwY3afFjQbydVpWhjUNd/I8W1iGsYyfMiga/hQBx9jyBvb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez3gZPGNkUdKFZYkx5RYQGupIqVHbebk8y5VedHkcsQ=;
 b=ns1t10Puk95iSKfZF3Rs2YurbDJF8FwkkeX1ZXnDxPtu/zBrhUmgFs6oPnnjum718B3B8Pf5RtUidvPHoLNX8El23h9tmQFeS2sLWYxDadbMV5LSC42+eELNOgOs5k9gmhK64rfjfjGWPLnO65gJtnMUWqgh0NIP32aJGUTcDwVAd+gvp3j/XDYuORAUomVU/tZXTon0Bb2j64qDbatsM4+4Ju6bksptRIsOXfAN6ahvsJ1zvoBiY/rpsQIlQWodA9BWGbAy9ffSEzB6zRFy5uXi6l+WrVVgPWLXES79w2Z7qpun9XBwxEZuH/DtfceduirdBXMt2W4pHUVlHzs+kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 17:53:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 17:53:36 +0000
Date: Wed, 19 Feb 2025 13:53:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250219175335.GA28076@nvidia.com>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
 <20250219155647.GI53094@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219155647.GI53094@unreal>
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ce6791-4e63-423c-bb15-08dd510e5584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kV+FhUyhWNesa3LoU3mYs2BxIJ3Cwqiro+WzU6EUDBJlw09nzh0CdZL5gx8b?=
 =?us-ascii?Q?kU1jWWSvwbXHljOfk4MNemo8Y/AJjwl/X2DKezdWZdYHPsokHZgPM66zWcpV?=
 =?us-ascii?Q?EgymWbo70n/MHFY2Hrxa1itA+z6cyTKL74UMkfSlrsc5blHlhWnUiayAylLB?=
 =?us-ascii?Q?s1VZS6rgBCG7Bq1YOOzFUyUfqAZDKZHQZrLupH5odGpl0EcSp+5c+cT8Wysi?=
 =?us-ascii?Q?L/zMwzc9VGSEpxR6xBzNsRTij+Q2TPd3YB6ht1VK2s9heF9gt8DM9VR0VhCI?=
 =?us-ascii?Q?7FUKP7lMUGQITTT7YoDHYw8iL4fo/EOMgxBb/TDevCIX5KuGaOZ293oaeAIL?=
 =?us-ascii?Q?CMGyIXzcGspL4pBx+lmIa3oOqnoY7TI6c+c/EZ0hAYXXcmEjJ9e/9LOFithf?=
 =?us-ascii?Q?JlNx8bu6NKQHSZEifjh5exkFXLIDGqtvP1GKI76nRo1ti8dnPLny7IFqIPa0?=
 =?us-ascii?Q?DKPKAB968Dd1ZUIpbJ0mIab/u8Y58lwjmUBhI6Cd4hR7R/41zzvj3jcTdBfu?=
 =?us-ascii?Q?zDrlDuQFUkMuvG7EZIMfdJy5s8csR7fqvib0pPYtrnc7y81k8XhuZe+Juz2R?=
 =?us-ascii?Q?Qh398LwaD+DJv+4sAfyXf4i0pq8+y0vvVH2L+ZLxy5HF84SizVvAeSa2xgrs?=
 =?us-ascii?Q?kKgSuSPtn0vn8pExnfTIHdgLrRNuHG1KV3rLTQL9utbTVDaQgjHT6mxSoBqr?=
 =?us-ascii?Q?oQxkMcaPvmj1WT8q2o7KvRH+fFrEr/IlXozpftRYVQD/cCIDWrWgfyj7A4im?=
 =?us-ascii?Q?+5odjxnBIJ4cAz77ZUqYx9UBBFaEh5UIrZ86OlP2sxbM7oNZ8iohzMMDlR2D?=
 =?us-ascii?Q?Dwp29yxlx3Je9oTcnhwKhShJbKpJ3+ZQjWcBZ0LYgYGEL284+0CpMXCSoZxW?=
 =?us-ascii?Q?EpDXbMu10Zru7habHYGeZk5yMtz7Z6cgjcqVsbgn7S+dGGAlrb5AXkLiW9nN?=
 =?us-ascii?Q?b+fnQ2yTWqoGwqccyO4WYgeg3o6e3YRn4N64z25TSBhXyKnq3lHMy4bi+S5W?=
 =?us-ascii?Q?ezGnVP95YltMmg4NL5FqcINBq6ZpkII91W77WAMMMWQKxmsAkDWzW85hT8bQ?=
 =?us-ascii?Q?Kdqz+OQtNzZ/Udnf1nRijdpAT4wRkvknDQfog6Gahr+Nqndkv6uocR4b6653?=
 =?us-ascii?Q?rbnnzf7mrs6vVo6e3HjyxuUdIXMIOtJ8yj9grtutlXAmEAxpMXDkYgJYs94f?=
 =?us-ascii?Q?GmqZ4Dm8TeMD8bMVvwwEyPunxFbAtPNDwAH1z5hArHwbr21aDqq8OzBAs7PA?=
 =?us-ascii?Q?InpPKGeVv8jfRW91bsoZhog3wYHpLAPY5JGs2W3DhFZJiMowmrk1EtfhNUPm?=
 =?us-ascii?Q?9EeX5C14YiVQHYUZfeqTjuDPhYr2IBV8tJmNv8R4/vWDU9aSDZ79Zst7XB0A?=
 =?us-ascii?Q?yAZ847PXA88TPayABSqapGhnoA5f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfaxIc5FTyAsk9RBlVQ5obV+wzmzkr2b/jHMdjerjwt57vhx29wol1IOj+9o?=
 =?us-ascii?Q?NRHw5sl3v2NU9pDDqIudcaJdadFs6kUVi1BwLFSNeHvHO9YinOqN8Bxk9cxH?=
 =?us-ascii?Q?5BOTQSCDz9QYzATzPLewlsHhLaGn0yITbk2vG1w/gk2ARggMS3aO5h00gAlO?=
 =?us-ascii?Q?9BnFZwu7UT6///Jl8i++vLFPkudWvE9091UXg9qwijjKpUzQ8yUi42gZrtlU?=
 =?us-ascii?Q?c1gGhgAwXKmWDyAmN1Yr9XwJj2LeBBkwEijeawgAWWOsxKguUfOWUPIb59/A?=
 =?us-ascii?Q?ov2YvUDgY6JE/5VD8Q3JsR+vM+OFvpYZ2dxIkieJ55xwkOIeLErMIhcn8agA?=
 =?us-ascii?Q?Bkfh4n7c/VNSNOoE314XacPgavsB9R75AYgPgBcY04Fwh2sXSfYJH+ohsJZ2?=
 =?us-ascii?Q?Nj1gw6pElJOeZ9l+m5AtaRjzC/r2w/srAkaGRpK5S0AYP5e7zbMlAvqh7IV0?=
 =?us-ascii?Q?vFYqsKjolVRt9Ny35tgspurU/C6C7mynt6SKGBIbRH/gZMiTvKuPm6aqA61p?=
 =?us-ascii?Q?TCYfMr1eWPkYxAlrUfERmVeegkjl3BeZNlyr0VKzov3nlP203jOF9BhKWDE3?=
 =?us-ascii?Q?VyUi72b2kMmskLd0OeXqIajsdPxNLxhsLcbzlvLiWvj9y2mG9Fh2dtrbIRqM?=
 =?us-ascii?Q?LPgQKlhdh/0Ua04xLeGg7gppQ02qyrGn+AvYQukrdlUgMa2j2WuzoWebWcY/?=
 =?us-ascii?Q?2CY1Asy0LERuJHf0PBUlOjuKcRTsCP+cUI0BOFHGzyZ5I+Eq1jfouefQeQ23?=
 =?us-ascii?Q?z095mFSKN4Yvxis3sZifcYH/QEquOw0IcekqRoiQJ/wjgsaTTisFiVJwU0Xx?=
 =?us-ascii?Q?J12ZTejyzNbgTfDCzbMX6fu+fSv8rXFGHENFO7IGjg8alsV+ixGS4lrQv2Fq?=
 =?us-ascii?Q?Gvq+9e/u/K+qQ/5/jj5eWKpet3Zs+0hxHSP5yIlZpohy7wJ6MCKhvTM2MJiz?=
 =?us-ascii?Q?grjPfWzbRiBIjEEsu9F1i3V38b0g0fUK4yl/poi13pf5rbCnhKOq8Zp32imz?=
 =?us-ascii?Q?eRlUKP3SPbcJ5N0smBecKqFnDtMaVFzmMo8AOL+MAU86xHinjxGUGas4K0cZ?=
 =?us-ascii?Q?UeKHvnYfZoicNslKDyOnRE2j5GoxAVSGu+WBHRjJeCrOAHS6YVqqTRLBM7NO?=
 =?us-ascii?Q?uFUy90BgxTGU9F4xRqnqf+Swljggr1kHyT5l+KzrKydbA8Si9/7n/Et/DRVR?=
 =?us-ascii?Q?M6/HGQnubDNXxpj1pFjSfqflqi8zflxIMJ5cm81HC8uvV7vmV8bYckFNW/6M?=
 =?us-ascii?Q?cYLNIuZ0r3eoojqvteWRcImugonUnqwlbGdZtMJer3CsnBAIQUhxrwgRJXf2?=
 =?us-ascii?Q?jE5d5ySRKbx+00xy+Gkg8hzVhR6ybSw4HoCBZC19RPfexVOcgGu86/JWfS1A?=
 =?us-ascii?Q?tQUwOOdE1d9lNjbMJZgFwREFoliVzxJVapXf4Aoc3+16GvK9KSWbillJtgj4?=
 =?us-ascii?Q?PqD3UjzqMgoLYY1CiHTV7Y6ztcdrNpWVuvVajvsOa9ImnE/khyFuwQj0iqev?=
 =?us-ascii?Q?YJPA6o2yeXquVUgx04TzpZZN0oILGdHowMStKkS1yf0pc7kFVVhNe2/WRA7u?=
 =?us-ascii?Q?wY8WTVoenSNOPus8GUw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ce6791-4e63-423c-bb15-08dd510e5584
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:53:36.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enDaAsnnvHumlUqIymqQ4RvYCcpWA0CFKvpy6+3lXb06KO/Z7xWF/7g+8RFJxlTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

On Wed, Feb 19, 2025 at 05:56:47PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 19, 2025 at 10:46:16AM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2025 at 03:52:05PM +0200, Leon Romanovsky wrote:
> > > From: Maher Sanalla <msanalla@nvidia.com>
> > > 
> > > Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> > > uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> > > In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> > > error code from rdma_lookup_get_uobject(). The IB uverbs API then
> > > translates this NULL to -EINVAL, masking the actual error and
> > > complicating debugging.
> > 
> > This may have been deliberate as this old stuff is not supposed to be
> > returning weird error codes.
> 
> I assumed that this was the reason for such overwrite in the past, but
> is this continue to be true in 2025?

Maybe, it is ABI that leaks out libiverbs

But also, maybe nobody cares. There is a small chance places are
relying on detecting certain errnos.

> > What error code are you missing here?
> 
> Error returned from modify QP was masked by setting real error to be -EINVAL.

What errno was it though? What other errors are there that are now no
longer supressed?

I think the commit message needs a deeper analysis to be convincing
the ABI break is low risk

Jason

