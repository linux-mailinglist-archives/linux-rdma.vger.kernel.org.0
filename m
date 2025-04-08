Return-Path: <linux-rdma+bounces-9244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AD4A808DC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4993E1BA225E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B126FDA5;
	Tue,  8 Apr 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tiUNfcgK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2A26A1A7;
	Tue,  8 Apr 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115901; cv=fail; b=ZllUxWIzYzw8HDNIgVsaJxZnU71GIsUb/ZbjdkvCFGEdKUyETsxAnrv8OYppM/0PJplLWzTl4e8gsZcXyEew4QaTJp1s9PAG0++e9rIZJbBtp1Qs0U08fFN5P0YVaNf0FEovO7HgKxFES2i+xR+d0pXmtVERp9sLQGyuLYb/Dv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115901; c=relaxed/simple;
	bh=MbHDHHAHAOHN6BcWcr9y1Hb3sE0KNFyEbF/GK6wtkD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxCuq6nK1r/MqFiZ8/tWZOSXpa9wWAa6nlFsop8u+3S0LQpAZV5RGgAvQStQfa+7AM5zzJbEn6qkBXGSLpMIO+y66zIWQIcanVYg/rwXx68cuxxfxLd094gPJ9ueCrBii97f3nvE3dfuyhC9uEbW/vRUxiEXrAaHTG/nunttxt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiUNfcgK; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOwmV2hCmoNpW5i555kHDBi/1fclRiqNnpDI85fSMA4wP1rhAr7FIHqW/pLrOb0A7TFKZpud//yU2EaSJeGbIqMyiyNIC0VkR4tAHaRLvesDlNQGjk+5VKuqlLiPyCqQ6fjYGU0LMuCHx16PDEzhTYiVwxsSW2AIAzPTDgrO+Y9Km3BwYTu3ztwNgp4/RP8Ky+OAuWkofH/DJN7AM4tNcJKYXJ5pV4bzHXux6cIs2NKhuoQA5kfibMSmmnz0YJ7JS6E7R1kHQejma0SxohN2K/pcMC9OYoHZ7x3IK3VfkcOHKFlsBD6iHMClo+ysv869xsbmGWHb0JirJWnnYYd2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbsQjeZYm61MJvs4h5Ly+vgn2VvI9rfPzTJYESaFcJI=;
 b=VXikjXMqoeQl/PtdPI2B/YQhe1WjF1YCM6jHqQiNqeH4DTWlYieKqs0gtKuDfcpDghpBDhG2pM8fSGWliW0Owdwst3ez5B6TU+jBvolbKOvH2sJ++X/4r8lmjUGUAdsJVwFxBfYMFOO+tyRiUyXRTvRqjx/wyJqlPLTH51KrofV4IOR9ofzG6hz3vcVUd51abm3qP9UvKA5cDvSINn8kPFlbtfypDNCJ8/l3SkuetuGv/0VnWyPGEA9haTDlKVzcwBxaL0fq3LxhJUbwtIiSbjHZiMEYobeOWGmZ5YP6723uInsSIe+Lm0M+hucSj3UaNjjpRpdUIZDt22VCzw39xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbsQjeZYm61MJvs4h5Ly+vgn2VvI9rfPzTJYESaFcJI=;
 b=tiUNfcgKnZQEfm571GsTPFykEosQdcQ0F1UCHL8Qo7x4jWwBiEblQQvZrcHOSPaEBS+q7oy7qCgAOlmV5sBjYb0xoiYWm5lswUa/x99uvEkKZgUsGDWAdY2glPQNcpygGOZ9p1UCZV1LVE57GDMOH3pvFYpsDkptL2IoQB2YZfYvaY+I5rttDfPm/Vc9pQ1kC6ss5nGRigoAAVwoPDiQ9b3C0C6IWZVU7X4XJEmw1KghgLPYrAA5X9cuNR4IP2qaSu/tZts0NfjeAs57Uq1kS2GzAqXJt/ByZxqDY9ioULLj17hQbHRdTiG83AQcJSLsD1rAg+U33nSQxhbSKfU5vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 8 Apr
 2025 12:38:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Tue, 8 Apr 2025
 12:38:15 +0000
Date: Tue, 8 Apr 2025 09:38:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Message-ID: <20250408123814.GC1778492@nvidia.com>
References: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
 <20250408122338.GA1778492@nvidia.com>
 <20250408123413.GA199604@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408123413.GA199604@unreal>
X-ClientProxiedBy: MN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:52f::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 6917ab00-cb04-4d10-a680-08dd769a3bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VF/NZLucAbfGr4BJg+/0FFkU4WmC0UZ6E5S/B3aQ5v0SM2bqmZ7eLEeY8Sy+?=
 =?us-ascii?Q?rooEu24LeoxDhGaZZjahSqKj47Yi1Ak9svRVjwTqRGpzG8kKCwXRDQxxM37M?=
 =?us-ascii?Q?j523ui5kLRCKcbChlrClfWplcTIH5tlUg2uP78GAJJRC9Eua28BaDaj9KvoC?=
 =?us-ascii?Q?zxneIfyf2uZBzcsKmb2IP0CiFRM2GzB4hNQik7gHQ/DwQUKyQDl+hM8nbspS?=
 =?us-ascii?Q?A9iqiAFWmZj7Afteq86aJtQwsfjVC5h6rQtlwETpb1L2P/LN3A/yImfwTKaa?=
 =?us-ascii?Q?mRjGF2Ei2UUZdq4afCVNdalHOSjuyo26afieF2iXjV9amhw2NqJnq3OgBnhj?=
 =?us-ascii?Q?08y7eQMTSuyIZolqE/pIt0zzS/joMw6n6ZOVw6Qs8x0rtkqMU6iXknFKxdRV?=
 =?us-ascii?Q?opTIXkLDsMCaQhbhMABnwaL8zyfYVjbyf3wtkoN7i45qMVMPO5JJUK9HtNnS?=
 =?us-ascii?Q?sJM+pP4fhK7vVXLuAa8+TexaMpWmWU66Jytom+651z9XqFkDKl8Rcm1n77vi?=
 =?us-ascii?Q?BIqlH2LvFOD0t76ASekHopPzviPi4t3Q6LFhO0U9yKWao2bybFHZRKzarWqL?=
 =?us-ascii?Q?wAMh/U5RA4ilaCvuyte4SpRdetzgrJo90G9IPuC/CsB+Pz6+PENUDghnJDvU?=
 =?us-ascii?Q?+TezdtzS3h1jVUUoxnYrRAHAkZN3eseRBRYWv6JqHeGiiLejfg7g9O8apP9i?=
 =?us-ascii?Q?XX4tNUIrHNWlF8FfikQYqvxbByOvycDxXAkXzYt533IdfyaWbIkPDbAP05mc?=
 =?us-ascii?Q?vs4yjlMVz+LJfUxZ8IgdHhrucAewT+XtfI3x0tMSRkmr6LbZQeHelfN7YjBp?=
 =?us-ascii?Q?rzgK9v1H4wsrYWf1R0YEBsOF74F/OJvguvEoDq7ZXxyoOGkCQKhFL5NkkEC2?=
 =?us-ascii?Q?L8UPEYWpKAbNe5iT/cLGdBOv7EbRHgIA9ACOl7lQdXjpBtaaEMO84c/Uykzp?=
 =?us-ascii?Q?GrUvpcI2isxb3juYpUtmGcj2AvH/0iAxE0i3KqoEK5EbScSnQarTCQyoFQ4n?=
 =?us-ascii?Q?WxX00gv+TZcUOVUfE+31K3RMRJSQXx56rInPbq9MMw1LaNECvI4G/UB9wBn5?=
 =?us-ascii?Q?Ej4ls0o/sdBcEN724bVuY8hlXUlE25QSyGk0zmnHH4f8S0aRyBDAJtYcgNzR?=
 =?us-ascii?Q?1dvk2u2ZKND8++JbD9iksn9kEXkfow+R7joKQ+jCj4sBc1Witb6icUKr9v4I?=
 =?us-ascii?Q?9ChFeX4OzfQsweWGq4gE73Q204ZWV47DTV4AGsPS4bMmPjzayDRpjTIzkOw1?=
 =?us-ascii?Q?HZX7kbl0PGP080SM/4XSJpZ0zsFJ8/uiL3AIAX/lPGM6tQJM0k3GpLiJAaSx?=
 =?us-ascii?Q?oxYKbNczCH3rpALNrMVxbw/JNGOP0j5Mx3LbVtxzQikWRIn5PjMj2O2w/h8K?=
 =?us-ascii?Q?nlC4tl2VIIMvSz7OE6DyAV2Ou94nUiFwJYRscb6OTlJvUfCBPn2DUwS0G9Y2?=
 =?us-ascii?Q?mDUpkhNBmJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAlyaFRI+gg08ehVixUz5RNQfTBNqkrN0zIY26ufe2ofp59X2gfVDjiM1gx2?=
 =?us-ascii?Q?e7vffMZjFwgOau1TgkVc5R3wT2PWZ6Oa4T4jD5f7SIZtXJxrkNhEJTn0q7Oz?=
 =?us-ascii?Q?AKXfqFd8HcOJDBX4cq3I2drRRAWKLXfGlgxX7tDQjm+2t+Dnx6Sf3TKks995?=
 =?us-ascii?Q?VLR9T+RwryDicdeyx0X4CNQJ0e/KwF/HLLYHd9PsC7X0LKwMt8ZpBc+Stq9j?=
 =?us-ascii?Q?V6AoDGbpXExaY5441wLQTFWxAzbhds11YzPxdbQ4q4CpCq6pMA0MMJ8mh2wq?=
 =?us-ascii?Q?nsR+tVwwWsw5V7vMa7G/ps4Z261s2AhVNuuYnz+IRIYyIdsswosR7FeoDYZu?=
 =?us-ascii?Q?nlmwiUhvceBNUyGt+pq2qA00GORxssV+tqIK2LrEllaFxI66sXMyh3bqOnUj?=
 =?us-ascii?Q?sryV1ZTKAxZ1KASwEEb0RSQAANI43L/ss2ea8KfHLJwBAjv+zr2yC3F0b6dk?=
 =?us-ascii?Q?0PYDIfQpint5Zy9Up6/v1df9Z+q6CMh2fQZNdQMBkeWueYOX/tmsBsnjaaqy?=
 =?us-ascii?Q?HQHPf/4UAMxFGLHIG/z7fXX6gXKgtNY7btwk89jAvwzmXA7dBORnAFK5sNcl?=
 =?us-ascii?Q?3KH35tQ1w9+MMW+OpGVQsmPmM45lHCozuiu2s39DMbr/NOSv9NP6lFHIz4lD?=
 =?us-ascii?Q?rOAtJ8utyEWOqr4wi0QYyZVDBq5al1IZBtpPu0yeQ/wvW708lHAdO0AcPmsk?=
 =?us-ascii?Q?3ax4lXgh5V04WPtNP9PWfgYFeJ72LnL4p18B4vZBfLB+O+anVDMh7HYzyeEt?=
 =?us-ascii?Q?I7mFzybwnmQFMglSr31p6TlDXc0o/zIWV8inI9pSUhL+HEzAFFcu9HKC8b5P?=
 =?us-ascii?Q?uQc1MvuZO2LuDvJ64Il4q7fl+egMzpYllbvztwo2QqWFeOcVTVgNUuH9qj9d?=
 =?us-ascii?Q?eQkU/w+wVUu+JKMS/9QhOFmOk/v6KeSUCJMu01SYgIHK1dGJi9LYF0EaYipR?=
 =?us-ascii?Q?WvJbo+u8CkbAMFoevvHCRat40gCh4L9SIm9Z5zW+LwG0eHX84/ooTwJrfMI0?=
 =?us-ascii?Q?kX6LW87TzNeNXvxE0D0/8e3CQmEDLa22Q5E3vCmdNPPY4b5/ziTUUkJAXKCm?=
 =?us-ascii?Q?znCpt36u+HCYZD76EIc2gdqX0RBX3jKeKrvUp2EDKDWwaGRYu+4M93R0sHuX?=
 =?us-ascii?Q?R2FIw4RPRzqxyfmQFf8nz0d881fl+S8wm7oy1fWh4NMv7LC0qTusHnbBp/d5?=
 =?us-ascii?Q?q8xeGAZQZnnp1lAI6F85Jk9b3yQgbPXR7XYw+zqR5FMqocIqFLMTuB2LOgLX?=
 =?us-ascii?Q?yLBq1JypacccU1xJUmrRcrh5pGS+l6ckBaZ6FWhQp6Wxe3xOJdiDv50V7BR2?=
 =?us-ascii?Q?fwjr5hoXUjo95PP5GmQJFBsp+lVqRlrqH3YxnmBXV3PxdkQh6MwRKfLxByvG?=
 =?us-ascii?Q?VscH2h+Lb6JhwyVcYTA4u8p9HDluQco0nn32tzlp49bwOhbeJlFXdhOGH9PZ?=
 =?us-ascii?Q?/tHHtJoAnjhbPRh+sQNUB//zgzScd6ynsnMg02+TzscLaBoYJ9M+1g5+rGvZ?=
 =?us-ascii?Q?fDgo5nP0eX1vvBJaKKwUdUQMR7iendU89bKdJmXtIYXhzHRmZVaAgReGgvnA?=
 =?us-ascii?Q?jiS8CP1czl3L6evD+2t2yp4sSEWSWeeK0C4M4CNm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6917ab00-cb04-4d10-a680-08dd769a3bcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:38:15.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSbbAuC1Kqj/sw2XqXyOu3wszA4ga2AqD+XJzUbLDx6fEDz58Uq7U3k9vY76e4AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

On Tue, Apr 08, 2025 at 03:34:13PM +0300, Leon Romanovsky wrote:
> On Tue, Apr 08, 2025 at 09:23:38AM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 08, 2025 at 02:04:55PM +0300, Leon Romanovsky wrote:
> > > diff --git a/net/rds/ib.c b/net/rds/ib.c
> > > index 9826fe7f9d00..c62aa2ff4963 100644
> > > --- a/net/rds/ib.c
> > > +++ b/net/rds/ib.c
> > > @@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
> > >  	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
> > >  	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
> > >  
> > > -	rds_ibdev->odp_capable =
> > > -		!!(device->attrs.kernel_cap_flags &
> > > -		   IBK_ON_DEMAND_PAGING) &&
> > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > -		   IB_ODP_SUPPORT_WRITE) &&
> > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > -		   IB_ODP_SUPPORT_READ);
> > 
> > This patch seems to drop the check for WRITE and READ support on the
> > ODP.
> 
> Right, and they are part of IBK_ON_DEMAND_PAGING support. All ODP
> providers support both IB_ODP_SUPPORT_WRITE and IB_ODP_SUPPORT_READ.

Where? mlx5 reads this from FW and I don't see anything blocking
IBK_ON_DEMAND_PAGING if the FW is weird.

Jason

