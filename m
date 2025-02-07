Return-Path: <linux-rdma+bounces-7517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D53A2C421
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D5188AD9F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84F1F4E48;
	Fri,  7 Feb 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WDy3YrIo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B02E64A;
	Fri,  7 Feb 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936387; cv=fail; b=YiSwWZuj9lJ/KO53e+UUpsLqBZxeTAhKWhBlCyaPwy1eE//yfV1/oQAw6JbWDIj0RM00qif96b5U8yDZkbVW7WyFPmaifZlYRNDh3VSHcVg5hQr0ZYfEeGEmTmrO1T82J6ra+IqMHDKV4pEbxU37ofq/7htpqV0Bg/PaOV5zc58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936387; c=relaxed/simple;
	bh=1WefNiM2xfg0MMwO49KpUEiIgCZOxWJR1Y2rYAV4xBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NO7U1M5oimTHd5/ArrKQSs8CMmrcwuY8udMGzYrbG1NiHAewunNDuoKAE1J2UmRscvI5x5ASFbhlCrVsodvopaSsZ69MCFn3gpfIreWGlVP0fZwou8YQ60IePQm3I4CKRr8naq/EweWj3PilvJtM/yC3x44FSNDGbcg8ZK+9PZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WDy3YrIo; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0CKWwNk84kUnycqQ22aZLLPtwb5FI/2IwMXCFSQhfmX2tHl3M2DXo3wAvZx2YXn15NI4pcKZENJDC10xtb8ghAuU2OghUhKUyL659xpH6p4NrCB0YrHPeuCs1JhJvCoMn/NzwHDjuLHqOQLsItBuw0Bg9LH2uAnF3qyNorBJ10tSID1oT33SmqVsihgwtwIiG+6rH9cBp25JG+AF7dAzSZbdSH7izI6kuecp3FzumRNEk/WLuticGkFJu0EpMWEm6AgmXg1rK+HxVTBQuaERIQrRb9XK0Hrjj/7ZaoasBEv3GuJc3f6b43t9TwjRg0aumIJcqzCrSLdAlEDNM4+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ig92Z/4Z1RI/ffJg2V71Xxk+hDX0KiFAkSSUs0Cmkw=;
 b=UETAl2UjKw4UROehqtGbCU9CikrtA7oy4ni5Qw7GrOnUKrfj12BeRQvIlXXki6SXoQ0K3RQTvNR8lIC0zzEO8OBncPgo3Ax3N3HunB93XVCKVAQ3DV0uyWs2Z+s7ugS++o+2AP67aazr/Od0P//oEHhnXAyG4VTMu3D5PuLNSjq9L86ZHjZ1Odj4XnunIRZuvM6J6c31hdnmifmE8BNqFvxkPq6MQC2YP0GpMDEElSLvWsK5A5iaeYBgnxj6zgG62pLPrHxv+b5HmuVZQbFkm/yNPjPGRLDixhlIUp9xx1WezSQb0H1YvK1U4z5F4Y7dfAQ02kTsfzsjjjd+zf62GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ig92Z/4Z1RI/ffJg2V71Xxk+hDX0KiFAkSSUs0Cmkw=;
 b=WDy3YrIoqkg8omkmKKEO82MoF5y+WCnmfGAZ9Vl0kTRrv/NlpRKVBsptMcNSSKrzDDoo0uEE7MgM+oHxyCby47Dzx/GSvpxX0zBqc2mW9tt2+YJtJ7pma6Yu6XOXmtBgED2Z2NnKJ0pytrxaSDBhb87r1GJxYEEG0OdbaKvdB6fIh2U48Ci864QGNFPwgywJRoCV9XqZMCx/fyX9yGTMD8lsdmLc6VK03KbbnJvaT0hystCvN8n8Wtedyt11TULHWkaGE3P6ii9IE7myIoKfVj+bB5GM8V5gDsGnkkdeeW8Lb88sbmJYbusdhGhRrv72BwrWtzEJKAM4QaL4SiQ8ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 13:53:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 13:53:01 +0000
Date: Fri, 7 Feb 2025 09:52:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20250207135259.GA3633558@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250207125915.000079e4@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207125915.000079e4@huawei.com>
X-ClientProxiedBy: BN0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:e4::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fb8b19-47a6-41c5-440b-08dd477ebc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t1ikV38zBsg/2avA8a/2zSBiU0ByFoivyYapO3dLTdjSJSw4hyX7ynNJKInY?=
 =?us-ascii?Q?Q8WgTvscFB9NnfodLJq1RGTvRE8eFkjZR3aFnv2J5Pr8THCjUfVWtZdkvuKd?=
 =?us-ascii?Q?xlwTJRUdMQCYtlBH7VTaFsZM3QIrHjH7iUwIhUDoLzHxfFYYY1OZjXx1kxf8?=
 =?us-ascii?Q?o7K/JKXppyLsuCvEmRUDAfhm+w7/XSOxz8VmYJA4KLGDTYg83FBL91U1EOMo?=
 =?us-ascii?Q?VZdDyieunPLkIelIixmUbip0HfsTVDCr/YAdlrFyj9O8wCQ/+JR7YrH5uLCI?=
 =?us-ascii?Q?sOTjwu1Y2EmJ67HxnyW/rM8SU8/ckDjnpcSblQqHEOlrmE+pLqi+7CCiK15D?=
 =?us-ascii?Q?d5igGMfhcVtOarqlF0YxpxRA0RREToL8knnFQOWxV8bZkn9ifkNblsCssQeg?=
 =?us-ascii?Q?mLmE6VJ4cCHBbyTp+C3w/tct6PyrPy31gLEpxlHeE6NSVm8KBef3JYGodk2a?=
 =?us-ascii?Q?4cH+Ax4pQ5vQ7Uw3wsK2SbmF1xSsf0TmL7ivDfSfT/aLBP3ExY886GEQ68Sb?=
 =?us-ascii?Q?AA6NREgTIyZs0ONbs5kARusxJCTdRH1iINSuI+5gVY2CzCSBji1DKqN8iLcM?=
 =?us-ascii?Q?VL/GcCHGyZq7OG9zZLSmmO4RMhoIXSYxT0F0DSKsLhSxodH48dLdkcUsUWQs?=
 =?us-ascii?Q?hNVuNdLpSnVLy1iLN1RqtqEG5734RvT6wbIQMfSVj1yp20E3Ttli4ZB1U4Ux?=
 =?us-ascii?Q?1GBquKZ8SnjqT7ngSSwtoSg8h/J9kzO1XmZ3d3G/dloapS0sa7Z4vpKYNOCI?=
 =?us-ascii?Q?jzKcLMumqXSJ9R90WjcVnpfpm2v+3vhG8/TARt7PxtZNmPyY9sfqLgfT0Tqv?=
 =?us-ascii?Q?1ToJ8j7mkuWhjq4Co9nd2gIFByCjhkzwR5IQ6ituvxjUJWU0tmtEqKVAudFl?=
 =?us-ascii?Q?9/E21e8tE33wy30+E2xlg4zDWyoq5O7BXnMZn0uLUpfEVSIRBtZDRuJx264T?=
 =?us-ascii?Q?v222ROMFnica+5LXbWUt4spGr7zRVS5bMiQEkPEdSQg1P300e0XL0rieXvek?=
 =?us-ascii?Q?bt2cOlmFkKWdZCc5TT271OXLJ5O9s6bBNy/QpWjpsgxcKfM+tssHOmbw+U8r?=
 =?us-ascii?Q?sCA2pUxMryE27vDDN82JPEXkvRBwSP9kQaVKp19nZb7w3nXsGU4ZaiJ1VY0G?=
 =?us-ascii?Q?vP5P1seIP0dZ2CTZsUydR2pNWMYQIa5Rfmi/0xELxGEL0oX1NJsa4GI3+qCe?=
 =?us-ascii?Q?iWfwl8YrByojl5e6iPHKMk+JQxdDhVWZ6qCBcOvQZxSKJOiaBrQSGhrxK1bz?=
 =?us-ascii?Q?beMhTCDaJVuoPnJKFYAhhwqf3yhx0wnKbMoM0SuMpJy/Bi/T8FHrsuZEGClQ?=
 =?us-ascii?Q?4Oz1usYqFAMltxi5onsB4cuNQZGHtlc0qHsQbzZYA1cf0jRVIJuRqh6kZ23E?=
 =?us-ascii?Q?9Do8rCmxBtUopalLal2FtRcmOYhv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0hf419I3UNCE+GL90gZdNTr9QTstxDm5rh8olrXRUyhJy+YU+2koS8vGT/w?=
 =?us-ascii?Q?fKvX1MxJ6aSOEsBEX1NZOQFlm22XpYiPVRL3joKb91n+pvaE+Oj2XaXxzfWG?=
 =?us-ascii?Q?mVn+5DQmE2U9tMAehD+r1tReTDv9Xg43mOs9H1BqTw/lp+VUXQETaXPeiuHw?=
 =?us-ascii?Q?t9vAZPnFyxR7NkzwhLEoX4CDRUC36ULB5pNSCcjo78UpHbHwT2xAi6Cm3RE/?=
 =?us-ascii?Q?tEebkhPm45ND6J4+RGvfCy2twSRyITV38swbQWu0ADrwcCjClqBheUM7SCNj?=
 =?us-ascii?Q?YR24vrDYyOI4Cm4tX9d1+wWO/N1cxB3C2YawQNgLVxGKXObH0BqcXnjo9ocI?=
 =?us-ascii?Q?ixO77z0w1Po4prXj07h7Qlznp4cBR5QDepDaIAW3nozU4JWA9HucoVEjzxdy?=
 =?us-ascii?Q?Qmb6fRnZcr6qzeBZuIdMR0m6bK0oRctX+u1SLrYlo/VJQexyrFZY365njBFx?=
 =?us-ascii?Q?zHAAg46L4GKpqDhmItXSIxhJhlXdHGW+PPWlGZLdNhlby36KWUWsD4LJxKcT?=
 =?us-ascii?Q?S/bLYAZgcScFAjHsCg/5dT29ZZiRyhoz1/cr2t8JNsza0xTIlAbwwC16D7W2?=
 =?us-ascii?Q?lMaourS7UjScAgQRPoCz81Dg0sdrqL/l5l30U98egTTiIr15cV0jBekZIjGS?=
 =?us-ascii?Q?YOMi57YXZ63qbX5+XkzOIQN67QPGY3677G2fHFvm7gzypAVkpRhxQnCIKxAF?=
 =?us-ascii?Q?/6P87UW7ZtV9qzyS58aGLwFqsuezjDsQita51PMb45BzIhcEDtlYTamW16yV?=
 =?us-ascii?Q?bOmR7AwEAGEcBjFbMMNNaesvpTimaRe9DjXs0BBqRQN2s5cJPSTp/shbrJFG?=
 =?us-ascii?Q?23JLbncUx+yJNpVp70cwNQld6h0DbHsvYUnPGPFtTMCEMt2Aj1uKKQwRnVSP?=
 =?us-ascii?Q?IpfnjGqjHLBxVKnJ1/+/s/EQj4DHpphDgoaJvEOnD9NQy0queRveqHR37gTy?=
 =?us-ascii?Q?EmSmTXrkVGqG7WE7Wou+2eod5/2VXnAUy/PaHRO7q9y5g/aS3z580XPzzyaz?=
 =?us-ascii?Q?UENvevYyf8LJRjlkvfbHpAayvK84WDJVOOeuVqL6RZvfPm6iOo3SAPDEK2X6?=
 =?us-ascii?Q?0tVPWp8d09JVjLPbaloVAgxIwFOo7PcKr1avzZahmPwncM4Q+HQAQ7wAhjoY?=
 =?us-ascii?Q?a9kd15SBrWj+1z/Am0uiT+qaiMhtxC8gdQvwAk0ymVzX/LDBvZfBES28eTWU?=
 =?us-ascii?Q?woFfWXJaRNqTD+aTJpq6HC55rKba7hFJGERMkl8Wl7gSTBIs0cn2cGHyZJim?=
 =?us-ascii?Q?ErHFopz1VLXpnZ+FgxTZ3k8tufYVveQyP0hiMAEVHrTpBIRSarDhkv9TI0Bi?=
 =?us-ascii?Q?Bb/2ApWH/aVHR5l4iwDVj6ker5niIrlPwigGppRQD3Yr3hJSXqUv8rl9V0jG?=
 =?us-ascii?Q?IvS4WoKNSXnup7sJonehYieznXFzkAQu6KHHfcWrAmoAA8T76ltuN+GlgTpu?=
 =?us-ascii?Q?IG3h3P1zcHLHFDSc0RcIXTMbDKi7h7HBMUsZ1NTjw34rjp1hMx4wLeWKdFrL?=
 =?us-ascii?Q?XzqfPPjqyFGKMo09dNam/XWl4VDcTVL43NBuZoDh7kSnUFXmjiNbphGHI7NL?=
 =?us-ascii?Q?XT1Fb8C46e5tEcNARt7q3Cr/EcCLPRxxUxqFqVnQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb8b19-47a6-41c5-440b-08dd477ebc71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:53:01.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTxAfe+PXKKpLHEEw9OI78ee5j0MiZX9zPNzp30ZeYuNWYfQSJ91AX2b8etz244R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653

On Fri, Feb 07, 2025 at 12:59:15PM +0000, Jonathan Cameron wrote:
> >  static int fwctl_fops_release(struct inode *inode, struct file *filp)
> >  {
> > -	struct fwctl_device *fwctl = filp->private_data;
> > +	struct fwctl_uctx *uctx = filp->private_data;
> > +	struct fwctl_device *fwctl = uctx->fwctl;
> >  
> > +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> > +		/*
> > +		 * fwctl_unregister() has already removed the driver and
> > +		 * destroyed the uctx.
> 
> Comment is a little odd given it is I think referring to why
> the code that follows wouldn't run. Perhaps just add a 'may'

It is intended to describe the if:

> > +		if (fwctl->ops) {
> > +			guard(mutex)(&fwctl->uctx_list_lock);
> > +			fwctl_destroy_uctx(uctx);
> > +		}

So let's do:

		/*
		 * NULL ops means fwctl_unregister() has already removed the
		 * driver and destroyed the uctx.
		 */
		if (fwctl->ops) {

> > +	fwctl->dev.class = &fwctl_class;
> > +	fwctl->dev.parent = parent;
> 
> Shunt this move back to previous patch?

Yes

> > +/**
> > + * struct fwctl_ops - Driver provided operations
> > + *
> > + * fwctl_unregister() will wait until all excuting ops are completed before it
> > + * returns. Drivers should be mindful to not let their ops run for too long as
> > + * it will block device hot unplug and module unloading.
> 
> A passing comment on this.  Seems likely that at somepoint we'll want an
> abort op to enable cancelling if the particular driver supports it
> (abort background command in CXL).  Anyhow, problem for another day.

Hum, that will be an interesting thing to fit in. abort from userspace
as an ioctl would make sense. auto-abort to hotunplug seems a bit
tricky

Thanks,
Jason

