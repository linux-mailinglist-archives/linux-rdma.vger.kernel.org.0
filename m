Return-Path: <linux-rdma+bounces-19595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI8VJTSq72kCDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:25:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FA47889A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9891D3086D03
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8A3E276D;
	Mon, 27 Apr 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQlOCa2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFB21D590;
	Mon, 27 Apr 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314154; cv=fail; b=i3rQnm2JJ2NZ1BpQAwG09IxTc1YuM0KA85AW5nX4gZbHNBvlOGMxQTCvFs0ztyylfUWeRcWqykr26FErji+Kx24iRu3nXzTxoeaX/X+jeP2+CgOKJIuBaI/Lw/E4P7OEv8kGl3uKB2LYQtLPIID5zC151lzga/ALmvujGcGWmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314154; c=relaxed/simple;
	bh=f5XyaOBX5ugnMxvW0tHBXO6+WBDnylY+wIF7m6gBKLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h1EkvTud12eJNv+i6rPGvtWCK7pvyZPfRKkgzSwzpGUnPpG3viP7djrFKRQpM3Iu3cnGE09RqkhXtifviNBPP7XQjlQ/1yg6grIRcyZiIPYWT0OkV+87Mx2VG0jr3+YsbXgUatEfx4TPM9WL9U0966PgDLB7KMhOfEGGs3BW7dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQlOCa2u; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAnswx0srV0t3gvDwmKw2k64M9jIXBQHj08OhObA8maL1bDdxoaoPfp1iicP+xFcsLEaAvwDv4xwfi6GXeN6e9DlH5PqHYztfrnAtKJNLEmXjOP3Ckrs0GqE4Ugm/d4Tjf+gDDr4lTCIC1qNv8Ni7NT9QgoZfyw3oOWzbPNOKJh1E7bFprRS6qN4DBpDgfNkl6TE3oFbhCFY5lMAMdC3RHagAOuBy9Q9ZBEULEYPwoR6OfkyCRl4NxtOJzcFzYtgUzWSJ1i0GWeZYybjZj5Dh8n1WJ9o0/pXSeoIXBKPId8Wv8CVxRzV8k0VLa03lDqS7HQw492J04dknpT/OxSWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHf8CtCbB+qYjAH1n1PiVb/3u2rn5zXqzwIW6UNj4X0=;
 b=rYgYF1j6Sk9MzMLFeucRs8QSJTD/VhPnH17oIi5O4YEtZfRVKgoUEYwi6I+Mb2XNsGzkAQLYA746KVv3O19XEu9VYxp7yAwMvNifTNz4zaXalmggZ+8bjpZTlHHX+AHmRvut+dZgGO+eEVUSu6Z5YzP4p/BbmXX37BqeMzFLtmNOobsDqV6pYCHi+jJLFaMXApvtuJK+RDSm4BsYXvAKjFDdvBAsg4Wv3s8dMkkpxHiVpFl/MUEOP/j0kyI035tmQfaJ9cVd4xCS123lcArx+Dmc0GOmIkg/JGQsmt2ED55i49Q7dM6FQ+Bjr1wJONtuLssjJhjgx/9U11Di6BuuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHf8CtCbB+qYjAH1n1PiVb/3u2rn5zXqzwIW6UNj4X0=;
 b=rQlOCa2uJMMm1kInQkj03pAfRfF1PEjHJshFDfzqwABYcxkoAbs496aza/eb3Rt7CedWBy0zRywpY3vRfQ/gX4FmIzSL73dOnqxjqmKRd0rpKglnrTiJtmWGS2kwBxw+vNmeVrR/C09146afGR3ZlnOM9fC2pIl++2aysmzGjViaf1ywPKwdMBV05hM9XTW47utxngfqzr+I/8Ro93pw/Qfx+W31cjiOtDSqv2I51zLTVRQB3RqiuGh6kZQWM8ZEuDAY9/W7DnZ6meKU0mzbfw+pI2fadLZ1jDFits9e6PqXmBZbFAipYb1oS1Lm6c74mdW9ps2+hk7LcqmWWtPMWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:22:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:22:24 +0000
Date: Mon, 27 Apr 2026 15:22:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
	leon@kernel.org, michaelgur@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
Message-ID: <20260427182223.GB718365@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
 <a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
 <20260427112025.49ebbd73@phoenix.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427112025.49ebbd73@phoenix.local>
X-ClientProxiedBy: BN9PR03CA0629.namprd03.prod.outlook.com
 (2603:10b6:408:106::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd1a63b-a1a3-4619-1cb0-08dea489ee0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k5LBs4AGvkfVjJsYnUPvwB/jgv2CIUQwFaQvnP/cm6/s0ANfaKDm/pRzWfLAFJGwSORHGqmUB7ee0NTnVNUp764TNPpnnNdcOcKRsajV+p/RPyC7ea/KRboIl/LZbgIMLjsQenXbjHTKrVlRJ7GLjFy/XfdmudjMttNR6skbZWuV4k0gSg35CqM5pWoYgU1c6Z+PDp9qlaWqBfsQdfk+8YL2G1laJNVTMoX0BGzCVqxa1+6JUOoLB2Hg9iQfzCcMMiX/SaGA2ijA1OK+eTkQgV3e7CQLzG4cKFHi38DX1riFr3P4t5JSpEXCRoX8KMEhRXxzuKj0YqKvrOXsHxW0MwBWvEnkGDVYFZqDaMAjQVDGarDrUCA3ip9M3wwGCVpK97bFjZXHFFxhzg1oVM6AePtg+dyYNXCmi61G7AcIp9/pZg1TTH5SS2+jX1UjwlXlbc0XYDgRzdpBsyUN/dcogzquLmWaO0gFS7oGLnL1bEWvlVipx5dT0cGnolgX/PPytyjgCoWPWo0xuDzj7W2LKgIkkPQZnSroHuPt6HtYD/a5gmYF39uNaIHbKhegPPYX6U4gxNtBIcle/q+UFT2XcEHl8m+JknXLakbqFXjF0K+tqlX6qn1TDheFpm5Cea60gYHIuGRB1ElKflo0Z0b8lmKjX7y9DctmnUkwDptec40SnSwVrmK+TBZyLvazfiunabfWl/OmXww95rGaaEFjmZc8aSsT58Dj6IaVLAV7oMhNhjFFYyK+b1iX9dihlMrP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FoH+1l/OveP6yP4MKbE0pbg0CQUIapUYSpMKR4v7H+0SNqZbbd7QEtKVBOVJ?=
 =?us-ascii?Q?ynkFYsS8HA07Wm1Nu/R7cGJQ+VieRL2qW1C61Pry1dFtBKzrJD4/SuXwDyaW?=
 =?us-ascii?Q?9Gca2Mav9VnjxccQHtNuWUOOSx1bhqjPi36GhuG13in8dJzZU/jDqhd8Ug38?=
 =?us-ascii?Q?lyw8fkdaMW1OdVWXuQMPbNZnapHaPa+R5E02xc8EPsSCeNyNhU+GTHJWeDMp?=
 =?us-ascii?Q?L7k6Rlz0NWIqUziiYEADAwUgdFkCFu/81HVn/fCcY9ikoADazlqMCg3/kXhV?=
 =?us-ascii?Q?ewZXFcLgdXvmTYlQBVi6F3E9rN6v/XxLiWpp+pjPEZJfzoISaexIQibye/JA?=
 =?us-ascii?Q?NgZtFHUuvF7pDz3stRECa3CxcpwFmkc34XJkbzeweUj4rMFeSm1Tyfsm3/B9?=
 =?us-ascii?Q?+u8OMI3hwpAYlSd6E62e4ihdtnz7SQRMCChMX6TQzOQhgZeKqXqHT+Z9R3mO?=
 =?us-ascii?Q?bqpW/n+rE920KwahzujsxD5QzWhhmYM5/xmFuvy4snQKQJ3/1OfFk94F287b?=
 =?us-ascii?Q?n2TzrnklFJHD4DLRm4DQTCfOTSONz6XKOaRVMVntoqUzHNqPldUABpJHAhAB?=
 =?us-ascii?Q?cGC8gzUX5I1mJ/E3qfvdTOQ/oGD79ipsISH8khR8k9B+EG6SfUkCSFfxXqi3?=
 =?us-ascii?Q?wz1Oz5KuhXmMD2yvvrPmsetuiDn42nGVNT+mOKbhuPN8vdLoUNwQrwr08ODe?=
 =?us-ascii?Q?IVYgibTh8rqZPUsCWorWGcXux4WBWyrJ+S49LuwxW455KV+i9wS6u4exy0qy?=
 =?us-ascii?Q?UTO6UwVNEQuM5Qhw9sDxcL4BOTDm1PyR3HMqtXMhqKlSFk6XktVh+229O3ac?=
 =?us-ascii?Q?zxBWrehIeLsWkTq3gYK9ZjyU37JsK5QaoPQEEaW0OquL/stK6Yl2f7WA/HY8?=
 =?us-ascii?Q?7zcIceS850CWDzVRxORwNcK8rl1h9EyPDSd63bOi6/mUWWf0Dtzm8rc6iyqL?=
 =?us-ascii?Q?fMisKnV6tesNhXmehkWayF6MQJTGw8JRPqEJphadN85TseZncdIe4vCq89vU?=
 =?us-ascii?Q?8sorpt9aY+ijDbHhgJ+esKbh0WtKBy8tH35Y21tWuNbbqPpo9feAnub7wXwC?=
 =?us-ascii?Q?nUMxp9nCGMQgCxVMMrChNC8zDl2RB1/UxOqFPPPmeMzBmk7P9qnRl+DVKIct?=
 =?us-ascii?Q?ceIkhesR5YwV7v2sax7oRfHcATcriHHD0QAMKhA4iPOo2xVxbs1U82GxEuag?=
 =?us-ascii?Q?T71/J4R4s8QNSC6odVvyeJ6SLgmp7zHej+CcSzru0dqXNMjc6fb8sqd7SDM3?=
 =?us-ascii?Q?gApaVugB5TJimPMSXK8/SxTwaSdC/mKS/c7BBfuH07d2Y4L/Zr2C0lLtBJF1?=
 =?us-ascii?Q?cwS/6EcuDFFrEm+uLmwwbbbmIeEwo/Z0P/NNSmsDzgdHdJpjuoKlVeJtLeQj?=
 =?us-ascii?Q?LRwdGzxx0bfuVCYulbbj8QIn/gtvxiLcEIZwmi5ii21Sxk76gwC2b837q1QF?=
 =?us-ascii?Q?bp1/CWu4Cp80F8STXZF79mJaZqLsRbeTm0njzpiVQDdr0TDV9L1xU2v0ZLQg?=
 =?us-ascii?Q?bfR1BRLDAUTY9wkxcnlyjnChJGeOFvgJzHCBmbE8CNydihL606Dh/hAWPCgu?=
 =?us-ascii?Q?XeN9vOoo9257EnDj1lE9/qYSXIurRnY07Jt5lBW6WZ8NIegdh0716Yc68oMf?=
 =?us-ascii?Q?s7YUT+MmyJwT0tUcJlqsII8yuJud7/U9AmGBflX3f85TMaDfcJ+iFUSR6UJL?=
 =?us-ascii?Q?VDdnlMb+SCME5UkCUHuJKE6G0EhZZptYqD/HmM4ctOjL6sAF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd1a63b-a1a3-4619-1cb0-08dea489ee0d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:22:24.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNT6mYsmqqF2Prp1A6+Gc7gMb5+47hxdsK7lnGUsoGedKLUvowHUw3L04nSdnue2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
X-Rspamd-Queue-Id: 289FA47889A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-19595-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

On Mon, Apr 27, 2026 at 11:20:25AM -0700, Stephen Hemminger wrote:
> On Sun, 5 Apr 2026 11:09:55 -0600
> David Ahern <dsahern@gmail.com> wrote:
> 
> > On 3/30/26 11:31 AM, Chiara Meiohas wrote:
> > > From Michael: 
> > > 
> > > This series adds support for managing Fast Registration Memory Region
> > > (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> > > pool behavior.
> > > 
> > > FRMR pools are used to cache and reuse Fast Registration Memory Region
> > > handles to improve performance by avoiding the overhead of repeated
> > > memory region creation and destruction. This series introduces commands
> > > to view FRMR pool statistics and configure pool parameters such as
> > > aging time and pinned handle count.
> > > 
> > > The 'show' command allows users to display FRMR pools created on
> > > devices, their properties, and usage statistics. Each pool is identified
> > > by a unique key (hex-encoded properties) for easy reference in
> > > subsequent operations.
> > > 
> > > The aging 'set' command allows users to modify the aging time parameter,
> > > which controls how long unused FRMR handles remain in the pool before
> > > being released.
> > > 
> > > The pinned 'set' command allows users to configure the number of pinned
> > > handles in a pool. Pinned handles are exempt from aging and remain
> > > permanently available for reuse, which is useful for workloads with
> > > predictable memory region usage patterns.
> > > 
> > > Command usage and examples are included in the commits and man pages.
> > > 
> > > These patches are complimentary to the kernel patches:
> > > https://lore.kernel.org/linux-rdma/20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com/
> > >   
> > 
> > applied after fixing up a few nits.
> > 
> > Please clone the ai review prompts from:
> >   https://github.com/masoncl/review-prompts.git
> > 
> > Run the setup scripts and have ai review patches before sending. This
> > should really be part of both kernel and iproute2 development workflow now.
> 
> I rebased UAPI headers based on 7.1-rc1 and iproute2/rdma will not build.
> Looks like RDMA did not get merged in 7.1.
> 
> Will have to back it out if not going in 7.1

I see it here:

commit dbd0472fd7a5bdd0b86c21c36f8afa713baa7653
Author: Michael Guralnik <michaelgur@nvidia.com>
Date:   Thu Feb 26 15:52:16 2026 +0200

    RDMA/nldev: Expose kernel-internal FRMR pools in netlink
    
    Allow netlink users, through the usage of driver-details netlink
    attribute, to get information about internal FRMR pools that use the
    kernel_vendor_key FRMR key member.
    
    Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
    Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
    Signed-off-by: Edward Srouji <edwards@nvidia.com>
    Link: https://patch.msgid.link/20260226-frmr_pools-v4-11-95360b54f15e@nvidia.com
    Signed-off-by: Leon Romanovsky <leon@kernel.org>

Did some part get missed?

Jason

