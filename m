Return-Path: <linux-rdma+bounces-11210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41098AD5F3F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 21:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C448A178C44
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 19:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E4286D57;
	Wed, 11 Jun 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciVj9pfh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667B1DFF7
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671230; cv=fail; b=NHBXxlYufMMC70U5R7BxJJDRDFejw1+dZ6T/riZk1vb76E4jV7QW3N+DpcNGR6yYK8Zq8MQbUJW7OTCdGRIBnH9Wg8YF/ajgYG+kuMoflZjSCggZlYI0Yq0xyIQbMF0+76f7xrWpODygHXDyQdjCENgKc1udlHhi80+3457vnAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671230; c=relaxed/simple;
	bh=U3Td1FpGLV06WkQ52IwMJGF/pyqQo7fWn73MU0YOaS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5cQKsGXgZsi8BVDWS0Bkn1Z2qlz3mDGA0NwINIK6llZbxfdZMLvQ9xCBKU74Qw1Idrw8JRwJVYPFagn5aBJ5PjDcthmvP8blyRa2bwFspU8R4i642xS+T4AqQFVNTG1xQyZ8rwwmDLdgTToqsuKOwaJo+WAwvrhvFZmxRXA5U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciVj9pfh; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewaGb+S7WFMGVbcu86AKlCutLHrFo90jk97J07eKfCJjTXex4XBtn6KBQYS4vixtQYB0Lp5OxxaX8sbP3qtesEX2B0QtnosbpB7GsrOyNxUI5LYIqcn6kdv6VAX9fwzpBc8KL2shKTbe9He0YfrozCF9oucqd1VKz4PU28LqC0vcBGbCMes2DfyG/53MRPZQhzSadoizIHyS82+qcAeTS0KA7eB5adIEXKhaaxnXLUDtPaX4WKY0c1AV1FGbnJRHC+WFdwxKyIy8Lkd+nGa1aTQOK2KP31K1l0iaGQg+jLTfsyfvmmyyCqGagxS/IIPqfRcFxGPUh4JANN9waykuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+8hB0+HUDUEZ2H8M0NEYLmjGw8ZW9elKWeoaD5xF3k=;
 b=BTFtKH5l0KkoahGW9P2E7G04EgAeFzKNZy/KSsR/v/IymeQh3ITErVJelzgDnOhjLPcwNZORiSwG/jCaffMwP02SU+s5w7I7YQ/fLRknBga1J50OxGWtpodAOVmw9CcDUqjL99PWZqeS2QblEd9owfNFJfKVD995OHL2GeZt3qNWED5fQfCyDmW4HgIQBHB/7ry16N6LC68j0WILagvTFRE+AcayqbZ/nRGPlXWr1REU8fXgofqsYBno7VPt9PxINsw16/gtnDC9oXyd6HfgYVVmIdPWdzEvufExMjVIkS5cpqiOcCc25xzg/xpTKZJRWjMiT2VACrQ+1RJ4lVv4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+8hB0+HUDUEZ2H8M0NEYLmjGw8ZW9elKWeoaD5xF3k=;
 b=ciVj9pfhUqP+yKE/eyQiaCmF8AqMCF+oKQPEhID1fsO7sRfRkO1M8YBp5Y/pZwUSO+o0BkRm8sQZze09hHnHHarl8TJWrEPlMXOgBqaUDT0UmTrCYtUWu+hpBiXi+rSUy5x7PAEurWJjzd5Kek/wpdDOJYyAtUN+ejCfu1hvjvBdP2Me0+1JS3QCNCabfStlPezKMd1E8OXc70i0tt45tOG8UDE6qyFae3HA5GWzYzbqsPm6xnDIEZciHwOVs6lZf3YaucUjpZcDyh7dzLFLN5pEld4h7LrTCkJZmHHXcbeGtm4UAKE8oIsxlYG0zeTvNq/Xzmylc8XX6NFolN0sKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Wed, 11 Jun
 2025 19:47:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 19:47:06 +0000
Date: Wed, 11 Jun 2025 16:47:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Message-ID: <20250611194704.GQ543171@nvidia.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
 <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
 <20250525175210.GA9786@nvidia.com>
 <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
 <20250526160816.GA61950@nvidia.com>
 <cb06d3d2-a8c2-459a-af32-bcbbdaa297b6@amazon.com>
 <83eb7ecd-ac1e-4472-a688-bc3f22900546@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83eb7ecd-ac1e-4472-a688-bc3f22900546@amazon.com>
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 64337828-5f00-4df0-db45-08dda920beb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30yz3M5X6e/cBwLFMWQQwym5e8CqrAYevWnCtoNje2SpkLn0KIcHEMjgHOtd?=
 =?us-ascii?Q?kHnWMOTVKrWSOCOOD3m1kHRgKty2KHmxuxovNix8ngwKn3O0btXIaOj2tWlU?=
 =?us-ascii?Q?RxXFb/VlYqo+bubpC/Vg1r5Fp9RT96c46RUsKdkxxbrecDkuZcyvCbqdbt1Q?=
 =?us-ascii?Q?ddMuh7IeuNoL8I72DS4kNsphxVy6UikoxkO1K524F6HB2liHhn6xi//4PFQ0?=
 =?us-ascii?Q?PXDlXBoD++f5AIcwYUqVat34DTzuER6T9DB3HHvw9X61Sz+eru9ZN8p0unk7?=
 =?us-ascii?Q?4kb2afj6agHXh+vygcNdcyQyvK+o3zKaV4XadZaLDq3MH1XWeRioIxgVopV8?=
 =?us-ascii?Q?4W1ejjMpPGRE2cUMsDVXzPWP997aO7FXCyMWxrTaiDs67lWx0LJ9LfqKgZZj?=
 =?us-ascii?Q?V0t06piMfAUonyOY4SYkKWcYEq7a8JOv6pDo0o39xh3gcUEROsub+M2RbzZv?=
 =?us-ascii?Q?FNBsLZblUcakyArsJEduBDRSJPLcE6MH2D2dZx4wdXBYGc/K2lKBgqjP2Xxx?=
 =?us-ascii?Q?JwaafszghyZ0NPO2+hXXAA7aVh0NUrIZk3N1pcXBLVM2ppLOp2UTNiPzGx+s?=
 =?us-ascii?Q?csJkYn23og9NWtfyfLgb8V3WwDevFO9QcKJXGhFLAloKTAkVaPBm8sf2ZgfT?=
 =?us-ascii?Q?LRCMpHE6Pldd24Piru0q050IBcgh7J9nrNKBRvHzXChOCcsnWzrRWfvDyjjn?=
 =?us-ascii?Q?LYoBY1VVjbZhP28T/TV3WceJN00MmJz9yv6jIE37UJtu5vaAhF2fIUJKYXPs?=
 =?us-ascii?Q?ogVZaMMJt+Y75c7WSDDHmUFtUsmXHQowKzBq6S4920fNpMWsV6oU2q/QBWSX?=
 =?us-ascii?Q?46cZkeDg8NoPn46R9zgrjD/5nrtC4d4J5tojGRwYF22PFwcrkawAVYgtVOQe?=
 =?us-ascii?Q?iCBh7elc0uSnmfcMFtyBwZWNPc0GXMk2PGVG0v3vWLXafJQeOdg57jtyYps8?=
 =?us-ascii?Q?HggmPle57Bc0xXt58C/76OgTsllBE43Y/HYLccfSakE5FKApgF1Ozt6tSK8w?=
 =?us-ascii?Q?7WdcUNb+Oq3hJCh0jGsJw3nYkOT9YHanBuoMdCcsZvq72Arf+RNclaZ82UTx?=
 =?us-ascii?Q?QtHrfcoVFS0dluZnA4efuizbmJohx3b17MHQ9hrvStze6lJu2LErWkn+D1+F?=
 =?us-ascii?Q?WtVmCMR7Muyc4U/43TkR7Xd38F1H/O/njNzlcOOxgNqX0tLlMJKzEkyT5ab7?=
 =?us-ascii?Q?Ep6j3xH05vRqHviKpt9UeyyiXmE/BcJcbOmbdj6yMBVN7mDpabTHfaJKtTW3?=
 =?us-ascii?Q?6ZSxnD084TlpOO5OeucE5C7zHHKELkfnq+wHVTX7z6fTVQNijkV/lmNsj76e?=
 =?us-ascii?Q?1/NZF8KIGeU4aXrVfgZ5/rcu6fa797Po3LWrAcjy/t6euC0TsvNIXqwAFt2X?=
 =?us-ascii?Q?Yxo2XVLMPbp/o6r7MuahxRlL9h44/YF/VyORVhh0bmehXO6y5kk3vj0ICu+2?=
 =?us-ascii?Q?y3z82Y+gnFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jckyLQHiC0idmjBrjHABC30U7kOgGFE5acgUks+9LFScACCAe7S+VUmhEn7?=
 =?us-ascii?Q?j19CyoQyvQDwqCveVAC15gZ/KP3lBQfk6NumPR9FarrCbaH93iX0qKT3ufRx?=
 =?us-ascii?Q?NyxZHwWe10I7zgXAV+yoUVWmdazlvCVm8GIq1LU88QCNdJtcouv0nbfm8DNU?=
 =?us-ascii?Q?CnFsR1aXQnqGAw/3Fix1odBKodPVysnpGcDLPPsCLLk3F1LaEq5rjL2pG2vp?=
 =?us-ascii?Q?0f6dByTbEbdPI9Mmjg+JzdemWYvrlHlxl2N3ZK2/UQol8vpkTnyg7uYuELnb?=
 =?us-ascii?Q?1uG6lVM7089c1CP90Tp7a7/mYknvaFouZShmTEW1JXzzNUlr1+787QlT/0xn?=
 =?us-ascii?Q?fwgAH+t9JHxbKc/PDApVmnuIt66csA+WTS6SKONYEqXfDdUunisXwxGnJytZ?=
 =?us-ascii?Q?mVUO9PermG75kN2/1dERkxWpRIOk0IQ/CoqnYL/BvPklcuKN7SJ8MN+rrwoL?=
 =?us-ascii?Q?ZeTXNsZ3qYyVX6SLgYHbuUDPguAdDi8AkftuUNtmVvrmfafcWVpfWajznJ9M?=
 =?us-ascii?Q?+sv1Ef/8rAr4jh7NbLRQnZhxNsjvK5IIz5TSNCnMCq3J07ChX7irUlRqiBch?=
 =?us-ascii?Q?RNxM+k/HEy6LfEaRrIbiY+es6jHOy1wT1aDqSwHsZIcZPe82KQr3ZU61Nt3+?=
 =?us-ascii?Q?DjeX4j1ZnfkEEBlenkUYRp6V1e2eawGJaGItDWu6IjmOalUUA39XY6uAdaKn?=
 =?us-ascii?Q?QukE0f7p12G4xzsa9RvvtBXgrSYziRwRySEl6o5o39GzUWAep1rmKfPAJTIM?=
 =?us-ascii?Q?sMxwqRHd/G4oJEnm6qzGYeVkeMEaXTLhXNOXx/QVqHW9o2PuqYjJSBk3goUw?=
 =?us-ascii?Q?lxeEdhMLyMsMFyAgvpS9CoTyZ/d+PBweaDQrIBKsenfMOG04eX0U3Ixhrr+Z?=
 =?us-ascii?Q?z7p7Km2GSHzxdlUi8BxcM+r1ubOH2ChaIH0BypLgEngw2ANZnGNHC23K6e1T?=
 =?us-ascii?Q?U3QRMzF0iwBqv2DIMxFK13Tqd90rM6UIPquC+gUHw0Zlx1ydIG3LEMV6emY7?=
 =?us-ascii?Q?lm7J24rhisispsDrx6NmxnLtAA4a0/aiGdwVLQ6urC246THOpi9f/mObv6pa?=
 =?us-ascii?Q?FSIoCWZwbOh1DXOkSNie+6tjUJmwdE7UU58JvVBljraDAMKiF+SwcVT7i+L/?=
 =?us-ascii?Q?taPimokRpv8iHWYVpVcaM+jCp0RVESJwktRCorBEmBlRvolARqpPtJ/Az9hR?=
 =?us-ascii?Q?H4mLFelivpU6tm2mEkd+R+pLmf4UjYMSKjEXnUEgjdiNDCjGq2TrKtYI79DO?=
 =?us-ascii?Q?ySXZXFkGvm50B9YXkeNYiaZoIT6Wl6upcnqd2sJoTEr7zgYRKAnuD15QgMFd?=
 =?us-ascii?Q?mcV2bzpoEzPQrJlAh9+N/QeAKXEuPqwclVKxWLUoCPxCIH3Hv+9W/pWyIBeB?=
 =?us-ascii?Q?3JQkS7siArCp5/Ut0JVvvCqUR6GVll8P/GTMmZ4+ikdSnr89dt4whDLjsEsM?=
 =?us-ascii?Q?k9jjFhs/K8K9xENuUdS+3RvT5r5zNZEcH95yz4OAKq3oMhpZZA8GTGkoAzfn?=
 =?us-ascii?Q?G+opPENtR6i+mFuthZArwqF7ZOlddXy/CCTH5opDvUSIGfDT7sUBtPyXhU16?=
 =?us-ascii?Q?VJwfrmyLOHgcuFM0rDwJFBoCPbmKsUUW2TjcX22/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64337828-5f00-4df0-db45-08dda920beb3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 19:47:06.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BD7LXDM++BlpB1U1MF3/ULr0y7etjUMhvDQ2jFpkzuzVHylXkKSSRu71Wdo140t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

On Mon, Jun 09, 2025 at 06:03:32PM +0300, Margolin, Michael wrote:
> 
> On 5/26/2025 7:17 PM, Margolin, Michael wrote:
> > 
> > On 5/26/2025 7:08 PM, Jason Gunthorpe wrote:
> > > On Mon, May 26, 2025 at 06:45:59PM +0300, Margolin, Michael wrote:
> > > 
> > > > Are you suggesting turning mlx5dv_devx_umem_reg into a common
> > > > verb including
> > > > the kernel part or some kind of rdma-core level abstraction for passing
> > > > dmabuf+offset+length / address+length to a create CQ/QP function?
> > > I think Leon was, but I'm not sure that is so worthwhile.
> > > 
> > > I was thinking more of having the ioctls for things like QP/CQ/MR
> > > accept a more standard common set of attributes to describe the buffer
> > > memory and then making it simpler for the driver to get a umem from
> > > those common attributes.
> > > 
> > > But EFA is alread sort of different because it normally uses a kernel
> > > allocated buffer, right?
> > > 
> > > Jason
> > 
> > Yes, EFA is an example for a driver that doesn't need this on the
> > "standard" flow.
> > 
> > Michael
> > 
> How can we move forward with this patch? It's possible to add additional
> attributes to the common create CQ ioctl and use it for EFA direct verbs but
> it won't be easy to move existing drivers to use it.

Then it becomes hard to make the other drivers reject those new common
attributes :\

Maybe what you have here is the best, but it really does seem
unsatisfying from a kernel POV..

Jason

