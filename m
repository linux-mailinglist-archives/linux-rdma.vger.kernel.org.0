Return-Path: <linux-rdma+bounces-1800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6E899DCB
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AE5285175
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893D16D313;
	Fri,  5 Apr 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOYFzSbx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2116.outbound.protection.outlook.com [40.107.223.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86E16D315
	for <linux-rdma@vger.kernel.org>; Fri,  5 Apr 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321921; cv=fail; b=dgGGX3ev53kpiivkyYlXI7Gxpi4NydU5YuuCm5q14IKcF6OdmonVhnvKUuldwWYDlMEqa8ngVFgGoDUBEw+S8Uwa/eWw2MBL043tT7hzVZT72jF1nT871tGhxKunCkPt0EMQbXFF9iEKoQxotchNbNOq1HdU7xusTww7bRALC9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321921; c=relaxed/simple;
	bh=LzqaWrj4euwr/AFq6kLeO8i79mXWqQWJY6TSEP2k3k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uCxXXh3rttdKHoRrRnuNZUeJ3obgVtFjxcaTw5zNlvXZdtSt2Ct+Wgeta9KVhQFVyiD1910qim1Tji0iy9z45JoRBw/NrI6vM0o2j6JumpzGbnuchNaYoS86gmHKAISu8xeRb7B6ciFxYZUrWbFzHUgYRP7bcL47Ej7gQs8v9mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOYFzSbx; arc=fail smtp.client-ip=40.107.223.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLpAi/pEtd4Y34uiLYq3H8poBYnFRmbVF8Fl9HCEQx7Z626O5R0q9wibcBLv5P2R8q2dHy88+quH5dr8B9MwFhT3ZqX/w55VcOUVI+jkxkjtiRRy8AFNY/j3qCjCFYjICh4zkjdkPS8yJcx0OLg4PwgLDkZPA1nK0jXHEnFVwOiFteiSzoWvSZOA7XXk1RMzlE/iAU3mJywueJvN/ibJBVvtDF7QYAlo/xaoQotAoDvXSGm6IUo6HHt+2Z38i/Huxftqk/ELnrB8lnOcpRnBpKqqU+bKzezl+sYh+THAecrd74JEFzJ/cla7MIb4RwyeRs7zai947VQxcmO1BvefTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXswmnjYxPsya0VcaviOXPbHU+527NOF2QGHdU9hAE8=;
 b=AR+KwLtYHpqInYQPN2QAPxq5x3sc/r4EG3g5zcnm17bhIEwWJaKa0c8SAdI5AXee2DR3Y2ceantwzNXkkbUVKsKFQBoZe6On5c03WLP9q3ff0IJuNy0eHPTm6gX8fiUIwgVy87eMB8p05c+hR8teKVfHWjXwBtwiVWhez+dfYZmMapKH/33/df//ofNSEcttJlyZ+h7+3WhON+rouF8dUGwuY78z0Y2AoYXmc0Z2H0luuJJ/ZGElo0sNtZ3hi+Qeo0JsgFgCPt+y7IeA96g11umVYOVAVs68VT9McARht2/Y7NluKI0lyLSUafJOu1ZtUs5cUhMOiQugSVxuyiHHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXswmnjYxPsya0VcaviOXPbHU+527NOF2QGHdU9hAE8=;
 b=bOYFzSbxE8uYvPL9gNKFLeN20uHP+n4lTDX106niU0ZO/GQhr5Up2PxCDXTuBmM/s8RXQYzZdmtY3U3lF3W9Q2MdkIG0xGVWo7jt6sx4p5U8LQMhA5i4h9da3Gr1UbLY6RdAtT5Kq5RWBN7EO/xc3gOZJmodBc1xR0tEbMSyzAyMe5suRWQ4f4QPFLMcAqAzScT+Go00E9gEF2HFc4QIps4dfB4mTaAk1n29bGhwmzmNnmvPvwXLNmCggZQfEGdg8jJZlIxDDKRNsYPVW45dpTF295QapxsIMAqNA9coAd7sV2Tl3V+gglGSWx149x0xv64VhEI06KQ7/bObWVL+LQ==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:58:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 12:58:34 +0000
Date: Fri, 5 Apr 2024 09:58:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/core: Add option to limit user mad receive
 list
Message-ID: <20240405125832.GE5383@nvidia.com>
References: <70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org>
 <20240404140113.GJ1723999@nvidia.com>
 <20240404165103.GW11187@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404165103.GW11187@unreal>
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2mOtTFoMsZmkGc4iG3/nVPTzerp0yuGOfUafXFcj/lDGBlR62X9de9+I8JMP42fMy1YsxR6BFXaYKFkp+DjU1M6lqWH3pL3F2KDExa7h/s/npSQ9mpzyosjxHLpwpSQT/wyzpIh8v+XWC8WYHzhKl3oY4PAkXyNTJp8a3KA9RRVNtfx1qwdRPKd6iah6ZHuV5SPgLzIFPKyYRZvwVtIUZOzhpmU7kSoNWx9FftjFPySP1nVzdSxMRQKRe3Yl6ib2ssFcboewipMp8Sm4cbpKuJamXa4+jLgu1D4qqDtTEB6VTy3Jys++AZmDZ2XG17M0XWnmSipRKh50ljIFqbdBcy5brIHHiCsvp4ldFAh9QCO6MPwkfdrfukW66sMGQ+gtbFDMFhCsdaPSkL33Kleq+06S6OsGidDrr/gQwFFhW2jUXAdQBXH6r4TTWJ9spqe7HhvpENTgSlv6UGyGOOhNCmmQDjuVLdW15/o2vvUAM+4Wr7AjFWAjfGnxbbWBVh+kz8Ed0Uvg8L1GOOxdfFkPJcXxGnZVBSUAjacgELBWLWhiFtJ3/YhXNuGYXS9kMizu/xZbyLEh4bQUowOItm3o65Zc+q6+lTm34GEdrpRqGhzxNyHymGfNf0ZDNQyjo6k8zJiO47wp0c/Al4Ib9l3msUIgqCHPAfYXUrSPwOgBKaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oppsGUu/kKdqsvakv/wm8PY+B8P2SzCVRXWUrbs780wnKsdMVoitj0dgOzsc?=
 =?us-ascii?Q?6MLgLlta2oqxCe5eu4jO9vLf1STna41h5P0d/yirAtyGKVQ411uFNF7WsaIv?=
 =?us-ascii?Q?QCi2tVLuUTa91G9mOGfYinjba4UnWBPxPkIonpMh8/jWwvX9WWx6eIqyhPzd?=
 =?us-ascii?Q?qTXVIqRDnf9gEppzT3fY0c/BYawRm8d7hTv+yi1fEbCNsXdyAodD3GZWqIks?=
 =?us-ascii?Q?EC06oBYXU4FDai45TDTcrNIOmtqi26gdUpsnrs1MK/XLTm10txqG7Wb8wwid?=
 =?us-ascii?Q?/zOfgb7YWD+RBGYRmuSqPpHP8M0gecykTJR+JqSNItuTxNKb9AWBqqWrY5vR?=
 =?us-ascii?Q?yv7Vbf5TSW44Sl0J8w2kSwtnFDRUly0aTm/fXKAQzvBARfBCGHXLU7fgBzcr?=
 =?us-ascii?Q?XmImdHnp2q0T3DEs3cz+Na9l0YbPfMDVspzFNvl7xDDLhCUpw/ObxFlbh+8G?=
 =?us-ascii?Q?eFm+wx6LchYAItEO99zhbolI7XqBR8ImY+/LFks7c8fMrmwQc6Hlh4TTxPMt?=
 =?us-ascii?Q?c9+nfuoDRcMHuPXDkaRmmKjIob15hqH0gYzUKlH23sKcCKdnWlcM3RIvUaJ8?=
 =?us-ascii?Q?ePemTfq7k09SEsroE12iXpkzAuJ8zcODGsUXuKHC2IDCBbCZH7nnjD1bOtqO?=
 =?us-ascii?Q?J3PfrN+rsmSQLKlv1uTMQuJ1oe8YXDmyAaiQfWO/1TOp2tv1D8yh1/csB9K3?=
 =?us-ascii?Q?RTMeSn/TXi61u14YS9Bw1bnsvU1WO7xQ5anO0LuPHfP3yVDWI4dlVlHWVAI8?=
 =?us-ascii?Q?ej65FbUZk7SDRt+Taq+P+GGUmCeBnTrkFvpBIDmBeeLKe7BNjmnuo5n4NO5p?=
 =?us-ascii?Q?Aa6qHxTPKrzEhl5/ZetMJ7/Ssafny2OBwuT3HXrU6by7qqPZuP6YkBZquVfo?=
 =?us-ascii?Q?PyhGXKQnVZqHVbpLORI2GMkHwnSWKAk6tz44d+Ivak8e2C/8GH40/hD7jkMV?=
 =?us-ascii?Q?YmM+dPthr4BXnFyajBA4r+3hMpb8d7IK25Da/tScUrZn8iiVa746ayC3M8pZ?=
 =?us-ascii?Q?6UID1vMNmObYk+CHOrUzNStJWE5Ey4Xwzm/RgGhh+c3ZHwNIy5oe652i5zIh?=
 =?us-ascii?Q?mcGi2SCN69Gr4Cy1fksXUGOZ0Jy3o+uthyKYufGWBDIrelCT6OK8updhEK+R?=
 =?us-ascii?Q?8tLo98WD5yXRNvQXGAQzHC875+lkkk2cBp6yo+TsbbvetoJKuYJwNq+qWDor?=
 =?us-ascii?Q?B4bQfG/I5BTkgEzXSGRYvlMYhG2UIUnuztLcPPLrE46XFsMnjElw7AkvtPZb?=
 =?us-ascii?Q?DVpBiGLzVHqrwmJZOim5huZvci+tdU5S7mDrHlzSx0dLAPP2m0XdgB1NlbFf?=
 =?us-ascii?Q?t/7P4saPBQ+cZmfO/25YpJkESXL9CyvIrMoc4mYpuQYTlY4wrYq/8ESnhLo5?=
 =?us-ascii?Q?xHmm0E2EQRA5KtpnzwB75yBdQMEQq7u3Z93hEdoutrKyaCQHNndUnk+HQXzH?=
 =?us-ascii?Q?3lOAAIZy2SABLcSgMBUdlu/5e1goes8HfwlxLlixGvMXtqP/0wR/XWQUse6O?=
 =?us-ascii?Q?fS4t2tBy74g8ad4Cq84de6mrr8STBJXXsKWs3EBPWBi6sAQ9+NBv0QvKE58N?=
 =?us-ascii?Q?wkZvAogqJjI+PNjpGRImcn10ZAYJ4sJzJDp5y1xk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27975a45-20cb-47e5-5e1e-08dc55701a13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:58:34.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpnKuMw8u9vDdNO2U5143Iqz9rYHnGz9Q12RhVul2t4LGbtAMSK08BrVW2wfUriE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

On Thu, Apr 04, 2024 at 07:51:03PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 04, 2024 at 11:01:13AM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 02, 2024 at 12:50:21PM +0300, Leon Romanovsky wrote:
> > > From: Michael Guralnik <michaelgur@nvidia.com>
> > > 
> > > ib_umad is keeping the received MAD packets in a list that is not
> > > limited in size. As the extraction of packets from this list is done
> > > from user-space application, there is no way to guarantee the extraction
> > > rate to be faster than the rate of incoming packets. This can cause to
> > > the list to grow uncontrollably.
> > > 
> > > As a solution, let's add new ysfs control knob for the users to limit
> > > the number of received MAD packets in the list.
> > > 
> > > Packets received when the list is full would be dropped. Sent packets
> > > that are queued on the receive list for whatever reason, like timed out
> > > sends, are not dropped even when the list is full.
> > > 
> > > Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  .../ABI/stable/sysfs-class-infiniband         | 12 ++++
> > >  drivers/infiniband/core/user_mad.c            | 63 ++++++++++++++++++-
> > >  2 files changed, 72 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> > > index 694f23a03a28..0ea9d590ab0e 100644
> > > --- a/Documentation/ABI/stable/sysfs-class-infiniband
> > > +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> > > @@ -275,6 +275,18 @@ Description:
> > >  		=============== ===========================================
> > >  
> > >  
> > > +What:		/sys/class/infiniband_mad/umad<N>/max_recv_list_size
> > > +Date:		January, 2024
> > > +KernelVersion:	v6.9
> > > +Contact:	linux-rdma@vger.kernel.org
> > > +Description:
> > > +		(RW) Limit the size of the list of MAD packets waiting to be
> > > +		     read by the user-space agent.
> > > +		     The default value is 0, which means unlimited list size.
> > > +		     Packets received when the list is full will be silently
> > > +		     dropped.
> > 
> > I'm really not keen on this as a tunable, when we get to future
> > designs it may be hard to retain this specific behavior.
> > 
> > Why do we need a tunable? Can we just set it to something large and be
> > done with it?
> 
> I don't know which value to set to be large enough from one side and
> small enough to do not cause to OOM while host gets MAD packets.

I'd say something like 32M worth of packets is probably good from both
directions? Or 1% of system memory, or something like that.

Jason

