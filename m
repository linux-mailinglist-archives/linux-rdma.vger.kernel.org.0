Return-Path: <linux-rdma+bounces-7729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D429CA34357
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682D93A2A63
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6BD28137F;
	Thu, 13 Feb 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNSHZtB1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADA281349
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457745; cv=fail; b=aWLFP0qaYBNdLFdGmQE5XRxYzFSGg1b4HnzGwBJgxuC4i4PI1lVh9KwhJIwxxJs7D/1H8+DcZChkXljDeF3yx29cVxbGrgVEsQ8nE8rnnujak5VNbLkxRvFXi/DTkNOZZlwCeCaT5OhXHtivv7OOIvVLHBOJN2kszTKcJxKr8nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457745; c=relaxed/simple;
	bh=iD51tDdd2SXF4BPbuDd54OZjGAXs4gxXKEqJo1PFdM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrGrRoI7KCV1hxL+SP6l5Q9MKE5So8Z9OKgNtciOfcP6mo+kavH+3XOScxBT5oaqtiU9TPSYKs2ljNJUp+Qo97SYc3TXouNeIOGm6b0bprtzhjDUy5BYo+4bRXDO+AmEYF/+/8DICkvGk6o73iQB2qViZ+/BZEGK9zSzhL+yW9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kNSHZtB1; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktKesA0Nt0xLfKMlHmE6A/uY7dQyBcJUnuD6LQTLzSZa+C5fH8moe+G0zJDOzIZDxEGDuOo3lrrStPi8EJ4UyOnc1BXo5kIWvHcVe51gf1uVIYD/LpeD4F4qfxbSxYU8LZs+5Z4MyJ1LIv+/pRAeXSda5mrlssYfaj/jXEOCOR/DP3OS3tMCsCf+cJ532xPdDM2RQDWzIAaqNMtddr0a/lV0kweKmoQmlEzNKKaH+2wWhPEOVvu7ZiPSJmWy6p8JlAOAmxxaMgp1meNNwJLDI6OD+0NGfVlGfPzatFshXgXP/v1Bb7tkwrMTaynlxZVAh89hF39k7FxX+zD1Z/1U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7ipGcX+7gp5gbU/PIlrM61Yxk/I83lQ97NqutoBVJI=;
 b=KI9pxyol2SXm9iYsCfPH1RSbYXzV/7CDM28+q7NzfQ2WM+z986ya/1lBPl5NHH+gBMzufrssmZ56zEPxU/M9hUzgGwjcctkrC+/jKR7x2qOSzsFU0sv3/bJcZoGV9DpdGtAXANWe+f4P51pFZXzqdvhEXskcxZc2Mcyu1vNfk8KJ00ZCVgq7JXCwsuiVu1KLTRRR3afNWRFpJfftNyyLtSMHnPGodB13I4TH79eJa/QI0s35nvTzHAY2baxbGSxB3TWKT6h92y/ItVc9Fn70FCE7ReUYt6aWB418+Rsf/KlX++YPTYe2Ywl40xhOB15gUuk+VYH4aTFIytziEvwYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7ipGcX+7gp5gbU/PIlrM61Yxk/I83lQ97NqutoBVJI=;
 b=kNSHZtB1rE2aktwSvSwJjz5+MKRzrTTctqvnF2i8QAKRPXH+Qqi8B1SL+y3FR3dwTCGUL4w0CnRnol2qCAD87zVzdW1wq1h/rel43aDmnRo5zNuM44hFIpBA/uXxC8+rCHDehlT0D/ddNFj8RCKVfbJuL2FtY2fLa9cQJvafmCCcBQpjTHYpNQQoUGUlMoGWi5cD7eSg7HUh8jtLif0j+FEewqTZCM7VRxUBV/k0MJnX2RtSiPg8Te8Nn/OdnyyUvBbMli00z52mjceg8k5ITVfXHUILD7d5aDBs0jVB7TAVefwNlwXBZ4++6WSp1W0xS7PUoOWKgkhMQVJ3kZ4ETQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:42:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 14:42:20 +0000
Date: Thu, 13 Feb 2025 10:42:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213144219.GB3754072@nvidia.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
X-ClientProxiedBy: MN2PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:208:15e::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: a97f8264-7d2b-43d8-7256-08dd4c3c9ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ev9WSbG0H4OKfowtTjJTzhWBwJvdE7o6qHPaxAHXP2h6b9CrKuXhl0MDTgxC?=
 =?us-ascii?Q?Rm5mZMY+cecj1MhFVy/tWmoS25F84cj3Xu3b3u2DkW7lkdQqFGSu0LuXAuLj?=
 =?us-ascii?Q?zjX962gvyGWBIJgMdjC6Ah7FD7xrNb4T+MJVJoHb8nLoiEwQurZSN5Svu6dp?=
 =?us-ascii?Q?k83oZCcVqMHrBUjaszHtUoFNnPtwwR8hFSbMJ0PDOAPniCtISVyxTjDgYKfk?=
 =?us-ascii?Q?CPB5nYGiyTJ0aJ6XiRjJvnGFyaZ9+dHkds23mJ/4Ql3hUCeR4wTs5s04YZjj?=
 =?us-ascii?Q?4zNgXQEaPn/sED85GKc2K2WN1pusa36f68IC7xDJ84tQ3G0qq6ZY8OSWOqAk?=
 =?us-ascii?Q?E4vgCKfFz93w1tGff8MBioBZxCEF31toA2V1DhZ5CFnA+j2SNeBus7/wx5Zo?=
 =?us-ascii?Q?i9QZUDbCm0ZyagP6/Yr+4iVtR8pZCNsLH4VZzEElkJPdOX07RWcNgLR+R9uZ?=
 =?us-ascii?Q?dq0uVQlS2COQ3NClPX7YZ4MJ71Ccjb7g0t1ohOzEYm2wzzPv+It5fPuKPKQp?=
 =?us-ascii?Q?GU+0cBXTiwAlsH/saEyVhEVfAJoPdi4h9kPrtEEAQ4sFT7tgODTQRqKHaRFl?=
 =?us-ascii?Q?HeqAw1oSWpdRzSxO8pnV8qcxFXOgxViLpHNx+E2BL93TsyFIukp4155F7zsX?=
 =?us-ascii?Q?QZw2bVg90X0St3M3WUVjVxVBIf5COV4z7SvWO1XQM2MNhdw8rfMlR/K1U1q5?=
 =?us-ascii?Q?CvPr1tvgQl9YgkJ/edQfHJK3gHhLM0jm5PJ2hcaH3E6M4qghwclA1x8KAE7f?=
 =?us-ascii?Q?T1V+ci8iV8/D8ighFW0GnliJbYJwbbr8G3KvHZbOv/uLifNM/COviHCSaAM3?=
 =?us-ascii?Q?dnDP0PMqPJonTeux3ly6BfdHJ1U/vhEc2qYlppqKkgWIj5ZYJP0YUCJqr1qX?=
 =?us-ascii?Q?Tuv3wfQBzqwA9Tt5c6L8qQ21i4CMn7pdtM7ceq+J9KQdTnXuWU1O0ISsi5Uc?=
 =?us-ascii?Q?rK/FnyFwjF4OiMzwqJYYbgniTpGIsrMX1BOnOKiVnENsnAFTDbAJb2oGdbFE?=
 =?us-ascii?Q?IBYl/1zq4n/pCeViok8OA5b7RGTeYqwpRI+8/cocq3Js2VYoKXl3/TfSitXf?=
 =?us-ascii?Q?RfeHkMndGlHacYaDXDQ3/W75LgINqRgWEkg/ZYh0obMOnjImCmgaLs1N0Bj6?=
 =?us-ascii?Q?sYKPlcsWmmcdACy2cRFRXcQX3ENKGGgGHc3BrbftzuJRHGxIjrFzcEEdtr0t?=
 =?us-ascii?Q?nqF/mP0W5wQWDbUGr8CVXgCD6rHhSdn1wIXFwoB5hU1g9zMiJ0Hep1LKMuiZ?=
 =?us-ascii?Q?siZjjPy0M/10k9TMW++kh9fyJaJNrJ2JaPyvLcnYBPLgjzKWxuoe+A3cR4aQ?=
 =?us-ascii?Q?EHCFHMfce1/IkK+peO108PPM/HTbWgG6ShRO9Ijc91+bqkQu4ZiVZsrg6guK?=
 =?us-ascii?Q?TBNJkU7TzBedSP3oF7JjSXC78dkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loVqxNvte0wkyQ91/HXvFoU/Zu6NDnHCQ5JA6GlUPWy3PTwxTGKIiEvjcyCr?=
 =?us-ascii?Q?ofYZBR+f7OStdaRPNthLDdOU1nl3VXoXF2VChChnVqv+LhKhCZwm5hGIGv4B?=
 =?us-ascii?Q?+tKa5cBWSQNgePzDiz8OCvIEQOOytsV64GzoZOwcIvsXhovJsDtUXbqcHQqL?=
 =?us-ascii?Q?0B5il0CJ/lUHeFD7/A+dH2SDna9FFHGYmI/m4pEycr+bCko5kIUOUxqr8qZA?=
 =?us-ascii?Q?IBrSY6TpZPCczdU9TETRD2iI/NaqxnaDmvRNR+OcUTJ3H5Ey+Op5vK9nKu2v?=
 =?us-ascii?Q?mXs+rwxC8AQjCCZrZkH6LORjWX4dTGFlUBIbThptgHqIWAD86jADU4An6fnq?=
 =?us-ascii?Q?ClRqxeMTnadKjNCMqrzip41P5gFRmSZLa5HUW7f+5QR0olxtmE1VwsnNj4fg?=
 =?us-ascii?Q?4TD3oEiV6ei6oYbSWr49JwXRRBLpYYXEKeP9rNyyKluTmCxMD3htdkJ3q3iU?=
 =?us-ascii?Q?S64/DYq6j1rZd9HfLhb9UufB2WfkHPeimKpyhdZltF6TuQQs7gcX5JJUa1d+?=
 =?us-ascii?Q?P+MGQTwvx/1CgoT4sI8o+tMwak+WsACo6YOtUSCXuzDkvVG1FHVOilghxFXI?=
 =?us-ascii?Q?TEaskydwxE8Rb/xBjbs4ocsc3HAgbBBG4us2CZFrN9ri+IL079oKHHlKwtR3?=
 =?us-ascii?Q?6s8R++5i0a8+NXj18Erxbxg9JaUOswNjwSpz1E86YYghAJ2x7W5qN68W+bW5?=
 =?us-ascii?Q?BXJC2XVJe02UX7629zEF+TGCxTnEieURnPLa883ir9ZzJsLhNSo734lYOxBF?=
 =?us-ascii?Q?ZRKpYxY22jygyZY53V9XUOtBduysMVBONsdhnHKM6C7GwPN3XGu1OrzhfL3c?=
 =?us-ascii?Q?5WB3TN7BLaoufFNHpop8pNl16RTADPta2t5hGbqyDDvLuzq3PKl4DfUzsx36?=
 =?us-ascii?Q?LNThUnpfY+slshPkOo1Tz4IiwsZqazXZG4p6m3NLkrPwYkP4rEyXp6Keij9t?=
 =?us-ascii?Q?KSBSxj6/+BLxJCLBgw95kVI3NGaNAW+7HC/b8mLVQu7LtC5mEIZWC0nKGET0?=
 =?us-ascii?Q?/qcYhaCfCeig3bUCjcpyhL7saf19uvSoBOL0aD9wZ4FSa58FISQzvPrEdTwq?=
 =?us-ascii?Q?NBZHfrrYgoiL8WiL24vD51LblGxSd0f9zCXj5yg/bSoiBlNOBMOCZsk3MNX9?=
 =?us-ascii?Q?WjB/kNvRou8dswh4W0ueZyKggjFzdesBDj3bLW9gL+/aJyUuU8AECo+IfeUd?=
 =?us-ascii?Q?skY5dwUniXjPouoLMvJIsg0JybTzpmDfog7YvyTJifqE8K80URfjfumLQRAw?=
 =?us-ascii?Q?rVz9CpVAjpQwuLTvFOMaQtM2CrkRyqrmQH4lCJ1UUSUTUd0LcR6xUkQs0KMT?=
 =?us-ascii?Q?hpH9ANLninGGJ5nWiszK7CzuE8SWD3/ejLUGG0iEVn4UW2opRSw1CXpGcdq1?=
 =?us-ascii?Q?BMnIatkxiV0SAQ8OuWIwycpoxbY4qMH2jNLEv9ocy0J/tQ8mn0x1JeaA9UzN?=
 =?us-ascii?Q?bbSA7t9Eb1cjuPf3HT3TSfRDeiJMEv1Zl9LmnMhjO5BCofo+rNqE72z2aYUL?=
 =?us-ascii?Q?j3Zkk95n0TSo34dF/zamx0I4gAkPk1strYcaIZtUPulziPzYSlZzlo0krV7Q?=
 =?us-ascii?Q?c1uxXnVmKCMXMApI0s6Uu/ZAoDS8LsGzbZ5/d6Hk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97f8264-7d2b-43d8-7256-08dd4c3c9ee2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:42:20.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxv0zZCvEgyqNaIwWitTluIypWrwboSAzHt2CuEY/vKNU+dpvLDqkC+3ouA3+kk2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

On Thu, Feb 13, 2025 at 04:30:11PM +0200, Margolin, Michael wrote:
> 
> On 2/13/2025 4:04 PM, Jason Gunthorpe wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Thu, Feb 13, 2025 at 02:51:26PM +0200, Leon Romanovsky wrote:
> > > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > > index e7e428369159..63a92d6cfbc2 100644
> > > --- a/drivers/infiniband/core/umem.c
> > > +++ b/drivers/infiniband/core/umem.c
> > > @@ -112,8 +112,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
> > >                  /* If the current entry is physically contiguous with the previous
> > >                   * one, no need to take its start addresses into consideration.
> > >                   */
> > > -               if (curr_base + curr_len != sg_dma_address(sg)) {
> > > -
> > > +               if (curr_base != sg_dma_address(sg) - curr_len) {
> > >                          curr_base = sg_dma_address(sg);
> > >                          curr_len = 0;
> > I'm not sure about this, what ensures sg_dma_address() > curr_len?
> > 
> > curr_base + curr_len could also overflow, we've seen that AMD IOMMU
> > sometimes uses the very high addresess already
> 
> I think the only case we care about where curr_base + curr_len can overflow
> is when next sg_dma_address() == 0.
> 
> But maybe we should just add an explicit check:
> 
> -               if (curr_base + curr_len != sg_dma_address(sg)) {
> +               if (curr_base + curr_len < curr_base ||
> +                   curr_base + curr_len != sg_dma_address(sg)) {
>                         curr_base = sg_dma_address(sg);
>                         curr_len = 0;

Ugh

I wonder if we should try to make a overflow.h helper for these kinds
of problems.

/* Check if a + n == b, failing if a+n overflows */
check_consecutive(a, n, b)

?

It is a fairly common problem

I suggest to take the patch as it originally was and try to propose
the above helper?

Jason

