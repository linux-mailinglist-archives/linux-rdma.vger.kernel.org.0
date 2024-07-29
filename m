Return-Path: <linux-rdma+bounces-4085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC293FC73
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA211F2272F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E116C874;
	Mon, 29 Jul 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="up+bEe9P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072180BFC;
	Mon, 29 Jul 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274244; cv=fail; b=bC0bbVOTjBAXnMcIXu/sjXrWbIh5OzbrTW7QoMvP/Wczz3zsymgiVW22R+qFakWA9X+NCVctqi1WllYx3PWhXJBT5QfVpl1U/FE1SNg4w8P63nsbzUS4uR3AGwFJOsAD9s5bDVdPsccvdSB+UzgIkDw0YSBD0OgIbVPiM0UPnKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274244; c=relaxed/simple;
	bh=W1bi6Ve0Pha/ER3j6//arr3PCNhlgKXh6T7tP0/tM7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjPNBEmgKML1Fc5Qwabra//U5INgbV59sYmAyw3YeLQKgPGbC337xftPht6Kgwy6mhIVxuJ62bdpx1WSJYeax6jp01FnVqf2JePfy3JaD751wmFFhsMZjSxP2n8BYXJ9SCqdmfWpgw/zgaiALe5Rvis5SUkyPGQWLXRO5kfdqwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=up+bEe9P; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJCTYp2CnwKYVwtgvqQ9WGQ480wvfvq7rDVg18Bjln7DV0LN3PpCVbHl7LSM70xeHi271dhporIiCJXvDBWLr2+xfnuSJuT74vWkL0yR7oFuXG5scT/La+zhI4GApcCBbzZQ1wbnXnMTDOsaeNxLEuWVCvjKduUjzc8b4BImXoIcqE+LwGUe+xike6lUMUdZeAJ7rbV/pwT+Yoqb4c88WP6Kr01OYgr5X6mbLyZI1H8DxA6BQxTQqZrB62zwotHQ8cEOViUqu+EM0ut3I5qf+ptf+bsCsHd14o88yb+28T7dSCYUCMN/qt1flTDVKgPuEqC8puIqvo89pIxpup47YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPEQSjUgbWAFUm9Uet6WXXYCVydzE8f7TX7UvNCTBsY=;
 b=v+m9IVWploe5j5OD1QzdUXkxwnlIAESyDJKAw0xANfv77x0TwYi/0qkmt+dUP5teHSIypZPoqvhgR50Vpsaw4AEnFepW9ydx0bKkyv/F3BWOF7QozUqXLnGNtuSfCQzLYdudCJ6QqUI3eKbNUgRIZYswvQucMLV9hXNu4GoZw5Z8WsUoqcjHcFj1sajTn4XiDq5ItEiMrZmeG9mAdfUSZXOe5iWiv6ktdCHwauLM3SdsRJqSZcFFAC1JJMgkkN34VVldXa+xGh6AFd/C+Lz1J+1dH3SoxEiuv2nvZjXQ/OpuXWfnXEuywTkEu2dnf8wTtKrGnBQ7qc9lnf37czFhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPEQSjUgbWAFUm9Uet6WXXYCVydzE8f7TX7UvNCTBsY=;
 b=up+bEe9P5WlCn64nbxpK4z+f8vHVNHFwwxh9lztZsEiHHQwiSKmw+CKq+bbnNfWnL9iz7fZ8stVE0pEL3cZ10Q/mczeSOHMG38i87rHkVghOUbKvmSTFrqPCxqv7+m1V0delK788rnacI6T6hetr7YV4Cl2c24H4ULOgdWDN2UJyo0JJmIYfiQR2jY9eJBG68QGFHCKITNazhdpieWbBlMupOPsQlJPtMfNJlKDcvcIQBgPk8qLzt2ou4V+SdkDuX07QeSgTmSNt/PUJLbx9GNx+KxzisCza+hLARuhgNl7UsIiaWCs3HUZt0d5DuoUohIsV+vnoKHpCqotVQCS55Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:30:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:30:39 +0000
Date: Mon, 29 Jul 2024 14:30:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240729173038.GF3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726153042.00002749@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726153042.00002749@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: a7551b03-160d-4916-ab5a-08dcaff429f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgNeihnJ1eAhfXy53vyiTUAf+k3OgruF6oSK64uPmNvr1PCQdTfJ/INitrRn?=
 =?us-ascii?Q?LqEcVOioZVTrPdJusv7tme4JRMOCSjjC+Q1BKSHL0mYtGl7aOQbd6sp82qyl?=
 =?us-ascii?Q?Wq/U79pChHjgxnfKykd8S+vvLwRj6ZpftJmSh8qua+T4jD6bVoREyv4KF2Wn?=
 =?us-ascii?Q?riBeDW6fu1wlBJWOee+WfXHLMyqATenKtkCqafcBDmH/bpagDECDhT41Hnn7?=
 =?us-ascii?Q?gNn5Ul8MhO40BIWHXutPEjIXf+yVbJWbbaTI1bUUTqvbQPzYsWXrB+XXZn/q?=
 =?us-ascii?Q?exO7YtZoRtpuE0SNoOJelQRl4KOBxd/jB6mzpUqMgS3O0P4mvhAncM7OVc0a?=
 =?us-ascii?Q?L4M1VcleGWWopdz8Bo9DDp+moAh1cp5o+KBYbl9GkK2+c1V8QP16PCAc1UAJ?=
 =?us-ascii?Q?JYx9nqOgJChuKBzt2YA1ynWf2cZmPoJJXNjFia9ywb7VF435OtKdzUx0fW/k?=
 =?us-ascii?Q?nX1tGXPqteeYewbJ/RAAOk9CnKgGzFoAOjWuFk3skL/q2gxNq5yqtMKKIUov?=
 =?us-ascii?Q?SEwL5axofmjs3oeP2OdytN2lOeQ8UFgt8GPNWzZqATTb7W5UoXtsJSoCdLGX?=
 =?us-ascii?Q?/cpxGocd3ziXgJ4PgLAYPCNJMGH2Lq/MoeFIzudEFJFvl+/P4wECJFbK/Kx3?=
 =?us-ascii?Q?P6Uw2vGuy/Vleb7zkGGMPXiQPzp6tJ31BGWuxwYuEbInmZi1cR8ynm+lzhdJ?=
 =?us-ascii?Q?KR53sldR4X/4JZtXwQ5TLt2IOsMzJBnpKdWkd+5837IKokYfwl+Y0BJ2yNi8?=
 =?us-ascii?Q?ysvrbENFz2xQ02apZ/k8P4i+gwG1Ob+HDfEc8wHoRig6F8v/VIVCG8HQDbim?=
 =?us-ascii?Q?pSDGKhqPSr4edZMgRZuh499DQiHrh/tYA8DzDqQ7kyFDichTatYLDmyHLlDM?=
 =?us-ascii?Q?H3aNzhEAd0w9Gk8H4OXxxfcT+U6vBfXPAGyj+1tXf9CKd+rrfBlUXK2xxIEy?=
 =?us-ascii?Q?xLj/TwsMwCCgSvrqEoylPfzddRwYsc7xBm+fLqgl3QE1g2XsrrzfFCp/szSa?=
 =?us-ascii?Q?qsIZmIu219DQ/Uyfc1YlgW6dRpmHZ1sCBavR6YnXoB0X7UNiYB7g5FO4Hu4n?=
 =?us-ascii?Q?eFkd46HxkoaL+YUkxHAsSaFwItVXInHar+2t2aK/ItzWZDQYVe9BfDDP41TX?=
 =?us-ascii?Q?d94CImLOU08rLPBXB6ydVXZoFxXypKWArLjlmU3i8U/wfJSwolCaZxQ3ozVr?=
 =?us-ascii?Q?AumXcPp7E8NB6CijABXElSboOvaiR/srozPoLDVymjkNsyMTLd3a7gemHK0P?=
 =?us-ascii?Q?u06thg06UcON6EBflMGv8Vl19M4LQ0+xzguChhnlohmFW7/tsAkrTd1ZRdHi?=
 =?us-ascii?Q?o3x3a79bNncjCFXpgwUEbTL/TO+SW46fd6Rj4o1TpVeF9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvgCljCzizhd1fVC2ExHqjWZzp3PrxBq4idVXHqzojMw63XL1AIkNjYqVxTo?=
 =?us-ascii?Q?7G22MiR8EyjyFzGW8hjL0GI2COUNWx6UzOYC+XmK7T78yiDJHmAAZcF6oWqC?=
 =?us-ascii?Q?IklY5HhbJblkr67rmwLLCw9z12ynz43BFlXBJeln0S2zXg+whF5EF+Q3dk13?=
 =?us-ascii?Q?ZvcfpuprhM1hnrndLpCx7JlUYxVff0vuiYsBldYPK9a1LLCq0rbGcONfSm1T?=
 =?us-ascii?Q?yIafc3mTCwEFW7ydMcKu+AD+da9TVHyCHMr7VzXmtLHdUQnziO6Kp2aBba5L?=
 =?us-ascii?Q?VHf4C0ZOYSUjUqo/1bLUnElqsNLXq0ETOYXBxLhAtuaVlzESKEvsVGpZUZkU?=
 =?us-ascii?Q?1hO6faTMxNQHR3IwaIWC2a2IfLZ5oxLeNdwEPqg+oygd8puF/N2eN2Z5HgZE?=
 =?us-ascii?Q?o+g207t5vFpryMz2OKCG05ANv6yebOawXbrNQ5UUjchKdncUELKRGRe+gMxl?=
 =?us-ascii?Q?WrqVB9mznc5dIrs9s2JSjx5eOg52Bduw7FbP7ewmDAuVaGdc500lfYkp+hFn?=
 =?us-ascii?Q?P4pSn9+my0LlpVEOHDoPWoff1OlyN/yQRhp8T1zs6ZMF9rlAgK9F6m00QPX2?=
 =?us-ascii?Q?LOk6XqmNb8s0T3XBfCbFeWoBX62wuI5CGogtSvWy7E0dT4ZF1un44D2Ofrx4?=
 =?us-ascii?Q?wl6G9t79fAeFEWymX02w1XWZX973z3sTiWeHiL1K27ESvl6jdtc5z8hZe3dl?=
 =?us-ascii?Q?97Rlbj/bltQt8IYCW0RaDmWlKXZUiCVl6OJRvw9DIKivzYIvZPcIUzshKmWW?=
 =?us-ascii?Q?dt0eykmk+83K5Ld6IYPMcjEnXXsv3ajvWY1VJNJ0PURFxEPnn6pHbAp/a46z?=
 =?us-ascii?Q?/tSihln1iZgozmiE568GtaaRN8PFEM9+Zgsemj9H+Yo7VKEI4NzW4Cnf8PDM?=
 =?us-ascii?Q?MnVeiDNeRAkcHtu1rJu4ty1HZ2Jd3Sfz569rJJ1KVSw9c20wiTTIVNfclAnm?=
 =?us-ascii?Q?otgFAZvb8BrZVdx4YN4xIlfssSQifhQ5h64HazH5KST2A2/X0J8hXvPFCWHs?=
 =?us-ascii?Q?XVxxiKRBdaTBHBaYOmroTXn4w1bnOsy6ICYp5alle7IfE/6ksk1mG0NJIM5K?=
 =?us-ascii?Q?3mjDIc4ouPjmNNd1W0vLa4lPTgtex61aKl2PtPmho+LkOI0/6rvuM73gGrKn?=
 =?us-ascii?Q?FFMZj/AluhI33zlMM+mn8J2TRs5FCvXgVUIBrcpclr6A9DFwG6QoxPbfo1hw?=
 =?us-ascii?Q?F2M5hMHcDSkK4lv8dixXusomps1sVAJzYcEM3W8caUjBRG7AbWe0MNMEk6Ol?=
 =?us-ascii?Q?2yNPlizFx1m5VzbWU+ADua9+ioefU5LPlFl+huk6B9OWqyUG377PBkF22C6C?=
 =?us-ascii?Q?0Yli4oxAcFgb8fy/P8pj/nkCWDXZWq5HZlTA+VD08e/wNsvBb69yzOUFqjvu?=
 =?us-ascii?Q?uRg88NXrTO3A1TrZgEtwOy+OS1FQXevlbQ0qm/Fvg8vDyyrtDH4GTQGzPv6q?=
 =?us-ascii?Q?s/ldzIP8f13osCzXM7drRMFmfVb73JIBBPlYVeVn4jQV8tIQqq3X9foK2uj2?=
 =?us-ascii?Q?mQ3eSSTWnTmSAYldpGb4zqfO5c/xFCAd9EjyOkTTHN/EHHlc3XUICJIRupzK?=
 =?us-ascii?Q?rBjSestad217KaftzCDIzTmMUP/gCAy274FY8l/P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7551b03-160d-4916-ab5a-08dcaff429f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:30:39.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBw/fk6AMDjyaY4DjmoZeBCxYjsvUuXqmXYQXIylxscXPeZDZQp9km2ZthgKuIt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

On Fri, Jul 26, 2024 at 03:30:42PM +0100, Jonathan Cameron wrote:

> Mostly looking at this to get my head around what the details are,
> but whilst I'm reading might as well offer some review comments.

Thanks!
 
> I'm not a fan of too many mini patches as it makes it harder
> to review rather than easier, but meh, I know others prefer
> it this way.  If you are going to do it though, comments
> need to be carefully tracking what they are talking about.

Yeah, I don't like it so much either, but given the debate on this
series I structured it so you can read the commit messages only and
have a pretty good idea what is inside.

> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > + */
> > +#define pr_fmt(fmt) "fwctl: " fmt
> > +#include <linux/fwctl.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/container_of.h>
> > +#include <linux/fs.h>
> 
> Trivial: Pick an ordering scheme perhaps as then we know where you'd
> like new headers to be added.

Heh, I think it is random ordered :) But sure lets sort by name,
though linux/fwctl.h does go first. Putting headers first in at least
one c file is a neat trick to ensure they self-compile and don't miss
their own #includess

#define pr_fmt(fmt) "fwctl: " fmt
#include <linux/fwctl.h>

#include <linux/container_of.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/slab.h>

> > +static struct fwctl_device *
> > +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> > +{
> > +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> > +	int devnum;
> > +
> > +	if (!fwctl)
> > +		return NULL;
> 
> I'd put a blank line here.

Done
> > +/* Drivers use the fwctl_alloc_device() wrapper */
> > +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> > +					 const struct fwctl_ops *ops,
> > +					 size_t size)
> > +{
> > +	struct fwctl_device *fwctl __free(fwctl) =
> > +		_alloc_device(parent, ops, size);
> > +
> > +	if (!fwctl)
> > +		return NULL;
> > +
> > +	cdev_init(&fwctl->cdev, &fwctl_fops);
> > +	fwctl->cdev.owner = THIS_MODULE;
> 
> Owned by fwctl core, not the parent driver?  Perhaps a comment on why.
> I guess related to the lifetime being independent of parent driver.

Yes.

	/*
	 * The driver module is protected by fwctl_register/unregister(),
	 * unregister won't complete until we are done with the driver's module. 
	 */
	fwctl->cdev.owner = THIS_MODULE;


> > +int fwctl_register(struct fwctl_device *fwctl)
> > +{
> > +	int ret;
> > +
> > +	ret = cdev_device_add(&fwctl->cdev, &fwctl->dev);
> > +	if (ret)
> > +		return ret;
> > +	return 0;
> 
> Doesn't look like this ever gets more complex so 
> 
> 	return cdev_device_add(...)
> 
> If you expect to see more here in near future maybe fair enough
> to keep the handling as is.

Sure, I was expecting more when I wrote it then it turned out there
wasn't

> > + * fwctl_unregister - Unregister a device from the subsystem
> > + * @fwctl: Previously allocated and registered fwctl_device
> > + *
> > + * Undoes fwctl_register(). On return no driver ops will be called. The
> > + * caller must still call fwctl_put() to free the fwctl.
> > + *
> > + * Unregister will return even if userspace still has file descriptors open.
> > + * This will call ops->close_uctx() on any open FDs and after return no driver
> > + * op will be called. The FDs remain open but all fops will return -ENODEV.
> 
> Perhaps bring the docs in with the support?  I got (briefly) confused
> by the lack of a path to close_uctx() in here.

Okay, that paragraph can be shifted

> > + *
> > + * The design of fwctl allows this sort of disassociation of the driver from the
> > + * subsystem primarily by keeping memory allocations owned by the core subsytem.
> > + * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
> > + * callback. This allows the module to remain unlocked while FDs are open.
> > + */

And this explains the above a 2nd way

> > +void fwctl_unregister(struct fwctl_device *fwctl)
> > +{
> > +	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> > +
> > +	/*
> > +	 * The driver module may unload after this returns, the op pointer will
> > +	 * not be valid.
> > +	 */
> > +	fwctl->ops = NULL;
> I'd bring that in with the logic doing close_uctx() etc as then it will align
> with the comments that I'd also suggest only adding there (patch 2 I think).

Ok

> > +/**
> > + * fwctl_alloc_device - Allocate a fwctl
> > + * @parent: Physical device that provides the FW interface
> > + * @ops: Driver ops to register
> > + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> > + * @member: Name of the struct fwctl_device in @drv_struct
> > + *
> > + * This allocates and initializes the fwctl_device embedded in the drv_struct.
> > + * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
> > + * failure. Returns a 'drv_struct *' on success, NULL on error.
> > + */
> > +#define fwctl_alloc_device(parent, ops, drv_struct, member)                  \
> > +	container_of(_fwctl_alloc_device(                                    \
> > +			     parent, ops,                                    \
> > +			     sizeof(drv_struct) +                            \
> > +				     BUILD_BUG_ON_ZERO(                      \
> > +					     offsetof(drv_struct, member))), \
> Doesn't that fire a build_bug when the member is at the start of drv_struct?
> Or do I have that backwards?

BUILD_BUG_ON(true) == failure, evaluates to void
BUILD_BUG_ON_ZERO(true) == fails, evaluates to 0
BUILD_BUG_ON_ZERO(false) == false, evaluates to 0

It is a bit confusing name, it is not ON_ZERO it is BUG_ON return ZERO

> Does container_of() safely handle a NULL?

Generally no, nor does it handle ERR_PTR, but it does work for both if
the offset is 0.

The BUILD_BUG guarentees the 0 offset both so that the casting inside
_fwctl_alloc_device() works and we can use safely use container_of()
to enforce the type check.

What do you think about writing it like this instead:

#define fwctl_alloc_device(parent, ops, drv_struct, member)               \
	({                                                                \
		static_assert(__same_type(struct fwctl_device,            \
					  ((drv_struct *)NULL)->member)); \
		static_assert(offsetof(drv_struct, member) == 0);         \
		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
						  sizeof(drv_struct));    \
	})

?

In some ways I like it better..

Thanks,
Jason

