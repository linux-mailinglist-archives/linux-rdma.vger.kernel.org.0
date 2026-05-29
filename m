Return-Path: <linux-rdma+bounces-21525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H3YAC/pGWpazwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:29:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B7607E14
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F3530180B1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114E3ACEF0;
	Fri, 29 May 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bd73YIl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AF352C3C;
	Fri, 29 May 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082981; cv=fail; b=uS8J5jbcxANOiWmdvP8sttEdlhGGcFVP52QMmFLjMrbUISUje0GtgF3881CEwD/fvwzLwQAJi1FQJ2hZCDFQG0X6z5NsqHlZ3XM5piAPYjR9CypVlKu58ABrZ/s+zCLo1tND9c1dIp8yt8e8hz+8bWML+heTLh7/VvQLa+/8H+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082981; c=relaxed/simple;
	bh=FeheG/ONU7/YgoZ2wZoN0DhJLc1RDmbVSbfQ9t1qhYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJS9jsgOtJyCgkNW39cNxkl4E4BsuIXYOp0Z1QbIX8kjE/lIeYOo5uc91jL6qLCzDY2tmsIH+GAJzWzVB5WIxZ3RAmkPB+7yoyYgSZEUf/AouAMHHmyxJ+TqU+Cbibi0aKZvCUgFpd74BPV+nsZMlftQ2dV0R9dbcGoM5IKql8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bd73YIl1; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIqyarYpWRS1P2z+COuCzXkExzCKqlKVo7hHCv7tD6UI4fNCa0mJiEGaswBiaWJGX2hhGVcWUCN7yip8Gqffq1qPwiv5aKu5Be0IYQwv9rJ85/x7dkoaZ0PQt2VSW0YS6IqB6Mf2JfQCr0615YPRgwzo8GK8F2gx7rei1XsDwvSHoVJ0ld7VsxmJw9baZmrfVtT71c/CazW3J2Km0OmANq7XEBXZlZEkPxZhwy97/hERfljBxg1Kz59/cs/4cPv5pp3tUymeF2nLL/52U1eE9vyIYcwdy4+X76i0biBFpqUOs6uE1m5Ats2xo0obGppAkeKZZCRB8Uxt6y2kLZ6XLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B3Gcof9DE0dlnRsNMCahCrRqgG6nPNM/0oXGtzKDLw=;
 b=nYa0CirJ8sxO5XQI2nkFn9Hcp/OE3HpEAFFDHRchKrMfM0Q424WezRdaQKptoUTN8UCW2BFdIyYqM7oFXfvuQIwOQowDJasuozXn0koWtk5h4Htrn/+9827Y4EsVxZ6hRm1vtRSI5bwQfSb4zT7ItPbSiZn9vr94n1kIZy2sglzEuDFbQfn8tDFciRlvIRBR/TeYo+CIDxSd+++J57dqqZNQqNOcEsqyRMuGI9HBjsz6TNtmU0k5lXi9HKFDSdBild0HVtCBRUqxlu+27glC1a5ib8mJWDviT8U6yWZmqXfIOwmx9XyjQESnjWWsMG25OmvTqIyb/rljOeDIqAjynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3Gcof9DE0dlnRsNMCahCrRqgG6nPNM/0oXGtzKDLw=;
 b=Bd73YIl1vffZRBLSfPG6ohHoQMCSTtAYJJrp2B0LB1RCwYYsHbrhiiJHbnzvyoIjUPCK9qIK7vA2PHD82+omRW1bokdikmg6DXrkhn8UoMJJCvrUSHoQc1r6gtPSwKYMzr2UK1bi1O4xs+OmeKAa0OumeH0JYDG3LFTYOTFl161EiGQTEiEG3QT6vl4kODaEVQgChq3oItIYqetdyDuuVci3RWPY9OnG1Z1WBBMb8dVOrt/0ivyMOBQ+Dii3b1NAMUzadcFAwOCr3y+BPjRUU0FJQh1orDGqjvwn7LRcF91x2pL8ugUwLMWqtWFBVVWCuD2ULjtEwialcFBTmdBrkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 19:29:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 19:29:35 +0000
Date: Fri, 29 May 2026 16:29:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <20260529192933.GD3195266@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <ahiFxtmspbETiqWw@google.com>
 <20260529134947.GA128816@nvidia.com>
 <20260529175516.06d5788f@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529175516.06d5788f@pumpkin>
X-ClientProxiedBy: YT4PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cf9161-6384-4b00-9a0f-08debdb89d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uAAzy/JbMPPKa0eNxFqfKXG5PXQtVYmnKFGh5lxyM5+8ZydYUHEzMIlqxlT5chwoCz4h1A/K8pKPDZ6rDO3EKrgt6wPSJDIGUntal0/qw58RuYp6xh8rD5C6UmzIwBs+7DfeIO+tGD2Kcy9dNyOTsCiTUKzmmNOJZ5zXnHdTAEUa2P95mZe9tlg0SDNAIn5yxjf1lxHgg1oEj1qGe/nXXXFtt/JEcSs6jaif8ror/WouG0tXDB6pDNl7VYHaGFXXKyp1Gid3326bPzaUIkMvYnT7qoorIXnZTwwlHDfXM0lf7JD2zIjmGGjttH7dGV73ZkrF0Gs3YwMHcOt1F9M3IrJO7nK243UMDnHrEJ6bnDsH4KjFaoGk88onSb/EXH8pCgQsEiC2nPITPsjayMy11gKgZuqfkmS2JCtS2C62dYVrlRuvDmHPdzryvmhbG77jzy648CTOFHOUKv6vxqU2+RTVFLatF7fsAlzFw7FdjQI3+/GazVsFlh1s5m3x5u5/uCJufKmk0+kBDRiE9sr7IGdfIGtJYv1ZiGDwA0yGtVBD+HGixuTITjG74pIp6McBF7MEfJDTWeMrsUrdt8q87S4zCNeT08do9D8CCt8T80og4w6R6W5jZahMNXgxBz0mta84aNOpjdMkqFRMZ+MPZ4n1cgru8XlYq+Nx/xej3loCLGnwODjkP38kgpy1Brhi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DUoNCoUDmcdxsi7hzhK3Q3gQHvf1cOsCL6DqCmJofVR6ZX7htRbGNA9FRbL9?=
 =?us-ascii?Q?mgyTtuS1ESfYtMzXzjTPgNB3WP8DmAWpjP6MHJ/7fwubZpt9B3N8GX6fZzR4?=
 =?us-ascii?Q?R9jPSAug4JgpN7e0n19NnzJX+lu+9XV9Im3wEfzeYD9Q5bG074pXOuAWg35t?=
 =?us-ascii?Q?wlzTxCfzSOstn/7jFWEfllpgoc10O8jBGac6kUcs2i+WDlpvXx5o6ehehhUF?=
 =?us-ascii?Q?HX/Z2lhQlmJDLY21XAvpCOVh5+JcvG0zONkvta52JHNeGEOwvbS+9PAXEZHn?=
 =?us-ascii?Q?9B18DVQT+fuKV6DsIC0SovdjTK3U2Rx8BSoO2fp1kVNbAn8aADLTSM1hZ4gZ?=
 =?us-ascii?Q?SEuMyBrStP0oTqf9c2Die6K71lb3c4zVdMlK4Dk6Ur+hGyqGWD6+4/C0E0pR?=
 =?us-ascii?Q?IeGNUrbcXc/IkU4kwguLO7lcJD2Uy6ECGf6SXf3tCPpAJ7BDcsAssWxfD5p4?=
 =?us-ascii?Q?GzebYtvgjjkVFs9xwIkKfAKv+3Hdqc+ubvpEu4ZwBIFAWMEVioMd/s1+bhnu?=
 =?us-ascii?Q?cT/7RSxwJd9KJINaZy9SxfgBTGwj3XtrlQxOFh+fOza952I30DUJXn+sVHyz?=
 =?us-ascii?Q?VMJhwwj52pdlDegvTFNr3SJFmGhNJdesbmLfqmqTSvlajyXSgPlieK/qWUiW?=
 =?us-ascii?Q?HwafozMs8jji70hMkgoAY46joJEJNFts51uBa1Vi80gFUtadRPb8Uk3oDC5n?=
 =?us-ascii?Q?KecBJu4/90CFeEhXTKk2K9x/PS5JE9ycN33tPXQIEU+dTNe4zCYcpw3d3i/o?=
 =?us-ascii?Q?fBfkj70rIVUlFxg5Sf98hR5r+tbgUlqDzUGZqszHDVkhCrP5jHgsNMRqqjHQ?=
 =?us-ascii?Q?uUeSfaCtXEFPVVhZskil4UDUkIZLjOD2VMNnAf7f1pShhK1h/p0oLxT1Yyua?=
 =?us-ascii?Q?M1t2qbVNu67K9IUnEXJQnIJJSWBM5A2Q9jm1E+Km7SbbFSHGnbnJUnxiD++9?=
 =?us-ascii?Q?7AT2tpE5uEzG6D7iP5+Gc92bzFOHQN4zlBljodEl0iumchfMXbjRxRGK2cXc?=
 =?us-ascii?Q?N2ezXtFPbGRDfGXY0Nh08DibWVcIlNNBmvqk7OZcWf2DWhpSWN7aZO1rA19d?=
 =?us-ascii?Q?zRV774y5TKafWvRCkbsRozSFU0JaJtZeqyje6FOsFQStLnmyAJtvU5XJC4uQ?=
 =?us-ascii?Q?gXPrEg4asPAl5ght/K6mhADndNTRWGK+LCjXewAHsch61UYB/6xOTARaIQq4?=
 =?us-ascii?Q?d9yNacDVJvS6dHt3L18Kr/84zWv058jl5y0cb5UQTHjd5GinzdMCmF3dzqC6?=
 =?us-ascii?Q?e0jA17gBLd9h8tR4wPadugFG09M5TzdxnQVyn/JHHefIU+0Qw6UAIC6gwxoe?=
 =?us-ascii?Q?35SFRiaCw/b6/4JLpd8pzvvdVdmFtFuo3T0UiifcCzBlvDpVligBrm467+0W?=
 =?us-ascii?Q?8J82rcaKIXrJU+2YSfSxOKXVZIXqFhweq9Gvugl2BEqsf0cuzcim9mtv2lGv?=
 =?us-ascii?Q?+3GlqvmieUue/Nma4BDD1zeEb1U4qAubgebTWA0FMGkO6iLgIvY8hucOstIu?=
 =?us-ascii?Q?4ihOHLd8+blygoZDoPNp29+CFngdtdJBqx8Mbx02Woq007Y/WSDoqQLZPGnW?=
 =?us-ascii?Q?2qi8VA047Dk6zf3j0Gb4UYiNHd8OdT23mlsViUzyOtn0/GTiFyhSP/Kx69+T?=
 =?us-ascii?Q?i7iUug5liDSkcT60ZkLYPcTuh8ueg5N1H24gROYtcd7O8Ana0wNhJtJjkFI4?=
 =?us-ascii?Q?puwBZUUi+R7SQvrzNPCGuSyWmoewZ5PZG4qpOmOdg74v1Y+c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cf9161-6384-4b00-9a0f-08debdb89d99
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 19:29:35.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K429EpNHBSNt9imFP4ij44+0HmH0NP49dOr4lwl4Tmef8r0hckCT8ZozZ17YO6ZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,crashing.org:email,Nvidia.com:dkim,arm.com:email]
X-Rspamd-Queue-Id: 981B7607E14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 05:55:16PM +0100, David Laight wrote:
> On Fri, 29 May 2026 10:49:47 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> > 
> > > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > > headers are more aligned with the kernel headers, and so that the arm64
> > > io.h overrides are done in the same way as the x86 overrides in
> > > tools/arch/x86/include/asm/io.h.
> > > 
> > > Something like this (untested):  
> > 
> > Okay, the disassembly says it works:
> > 
> >     1db8:       ca080108        eor     x8, x8, x8
> >     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
> >     1dc0:       f9000fe8        str     x8, [sp, #24]
> 
> That looks strange, I suspect the C didn't match any usual pattern.
> Normally 'tmp' would get thrown away and 'v' would get kept.
> But you seem to have discarded 'v' and written 'tmp' to stack.

Oh interesting the optimizer isn't turned on for selftest builds. So
the str is dutifully writing tmp to the stack. Another register has
the actual value.

> I'm probably being stupid again, but how does that work?
> The cpu can speculate straight through the control dependency into
> the following instructions.
> An 'eor x1, x8, x8' may not even have a data-dependency on x8.
> (Most x86 cpus just generate a zero for the equivalent instruction.)

I can't say, this is copied from the kernel and Will made it:

    arm64: io: Ensure calls to delay routines are ordered against prior readX()
    
    A relatively standard idiom for ensuring that a pair of MMIO writes to a
    device arrive at that device with a specified minimum delay between them
    is as follows:
    
            writel_relaxed(42, dev_base + CTL1);
            readl(dev_base + CTL1);
            udelay(10);
            writel_relaxed(42, dev_base + CTL2);
    
    the intention being that the read-back from the device will push the
    prior write to CTL1, and the udelay will hold up the write to CTL1 until
    at least 10us have elapsed.
    
    Unfortunately, on arm64 where the underlying delay loop is implemented
    as a read of the architected counter, the CPU does not guarantee
    ordering from the readl() to the delay loop and therefore the delay loop
    could in theory be speculated and not provide the desired interval
    between the two writes.
    
    Fix this in a similar manner to PowerPC by introducing a dummy control
    dependency on the output of readX() which, combined with the ISB in the
    read of the architected counter, guarantees that a subsequent delay loop
    can not be executed until the readX() has returned its result.
    
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

Jason

