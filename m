Return-Path: <linux-rdma+bounces-9305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BAA82C1A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C472D881D60
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53125FA10;
	Wed,  9 Apr 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O1WwPfsm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301E433AD;
	Wed,  9 Apr 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215059; cv=fail; b=tdA2/moezzvuuuNi4psJv0gsdCFdnZDQYUSd3iH/vQu3Ck/SNNiKd102sWZC5Yk45BFzqqtVl42u7Vf8kHkW3exwD6NkjWyP85r+ov077ka3AG1z4biZ+/u0b0+dhBNAmsskIpw0h0UI+Uc1zbsHhxGcgqx4MonJlWeN2d0xeig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215059; c=relaxed/simple;
	bh=HeKe4TLj5L1MGfrvI/7MZ9fkJc6TdBWg2LC/jqUq2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G11AeuJaHolkSjYz6ZLgOhTDlTzdGngi+R8UiGrd2uuGMLrjTCVmJG8zfI27YQIZ9AyaJwqlpchMnIKcFffXXkkIjFxVRGxeJ7jF+4fBJDmt82hB9Keaa9COWTvwrVrMPvaN93/tooVHyzUzEYQFJX9Z0R62Q8i/t95zJ8j4I80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O1WwPfsm; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZRRbIulvPUwy5rqLVUkEFs//Sw3B/dJ0flbuxkHv59Z7C5C/M/Mq+8Ay6MYrL0jS0UlvvHyCs1FcXi+XhNJaS+Z31KnokoKT6S3hhPH25BZ9ZwsgHACBJjiDSk3ipQnyEcI2zQWN6S6HgesedzaWnpPXwYrqphKmd2AriRsMuMWxBtMppPJZc71cq5amC9T+RdHYiVQ6HqH0IG18yMaPP2EJYVl3WfRPBihFk1Y4Qav0moEC6AegB5OTBTPWqjeKaFvxsB2XR/lWh9tF5G2jAi5YRYHr5tz5vYFaFoM/+kgLUtDPlM09ASBc/RR3OZ14DOpidKExjW8guMDj3OCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HARWgR/zDeJu5piOGVmc2dxgrb8UPyraQ1SdL2huwhY=;
 b=afuJ4VmFxASxY8k0IEH1A092tJhka19IMOH2cr/lYr2Kdl3t4szHUJ8hhrZjipbvlyuoVMN7iyiN8SxEi623ljS+6yF7z5pEcIl/lUx/gHH/h4u+mRnOayQcByJnmu88caHtNu/Q5ud/85APAbWSk0moa+tXoSwVNyhFuTkwCR+oz96rv3Z7wf8Ep1acl4hH8j9Fh/WgmxWJL/TwQqC6yBdEG8QGOyPGRcq62DJcSnU49pglFLu0ujL7vSK90iLbpYUKfE0odwkSNwAtlQgBxcyQ3CN8bp5EespKjUHAy06xQIdwTEX4uNO+N96GdIbISHlc2MG883IqYgS/FRD+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HARWgR/zDeJu5piOGVmc2dxgrb8UPyraQ1SdL2huwhY=;
 b=O1WwPfsm9fA5ZD63c/hiskrevrwm5f5i98BlJSuzo8Mu0U9ZnOjtTUXYqnAiyumVKBTziJw4xlC20OFQ313cKVMBUCfmrAKTG/cORZZ+HnL6UZRmnRiMSRpCDcJuAd2umGIJ+B4/BTeVgPln05ZxxwyThUufwn/Gb0QI49ara9aectyybhuxNN7HddfvESoN857Pjq1HsxTg+BVvORTUi+zbIsr0MEGyXrRY8M2raIj0uh8MuloohstAg/ovPrPx9Yirq4AculmuK3Q0K4HCGoruFyFURs1JgunR2DeNMMXJnfStbqHVHZuDfgK1TqKMUezTbU8e/wEDzcAk9ZRlQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 16:10:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Wed, 9 Apr 2025
 16:10:51 +0000
Date: Wed, 9 Apr 2025 13:10:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Shrijeet Mukherjee <shrijeet@enfabrica.net>,
	alex.badea@keysight.com, eric.davis@broadcom.com, rip.sohan@amd.com,
	David Ahern <dsahern@kernel.org>, bmt@zurich.ibm.com,
	roland@enfabrica.net, Winston Liu <winston.liu@keysight.com>,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver
 introduction
Message-ID: <20250409161049.GM1778492@nvidia.com>
References: <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com>
 <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
 <20250319191946.GP9311@nvidia.com>
 <CAM0EoM=7ac-A=ErU_PojZuuB4eHnoe-CdPxBi3x9d+=PxikfgA@mail.gmail.com>
 <Z+QiKan/j3UIhwL1@nvidia.com>
 <CAM0EoMkdTuJ8Oe+S2L+t6m3Q4UdMfJhFFhdjpdZbD7HLAadsdg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMkdTuJ8Oe+S2L+t6m3Q4UdMfJhFFhdjpdZbD7HLAadsdg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0e5c5c-9988-4819-dff2-08dd778118df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c0HogZNttACkwA15Xg87KZOEPM2XX2a7cV+uPiX1tjJLCL8YzyA9MRXbQmvL?=
 =?us-ascii?Q?NGCyXHGkq4+RDRkxJdIMBtDK4/LvaXLBBjFqINjkMfVMpDjpw8o6NHQTU0yT?=
 =?us-ascii?Q?GOMfdYVSRFH1fD5ao97c0yGLxR6AEG1jGZt3DzSaN4gZ1NYZTvwyv3VK6hYW?=
 =?us-ascii?Q?tI1SRJ8N7wwdzMYW7BKggU2QP9WSzIItQ6IIXN3coSs6MuDZugtcE/L4c0+/?=
 =?us-ascii?Q?wyHXE5v3whV/Au+XSixftjKBh+PqYCOuugHh+P5bAGA3PRJtALSjW7oWw77k?=
 =?us-ascii?Q?o7GCfer2n/dywfsxU6a59kNbVr70CW+YAUDvSLe6dYaow7pNhn7hZTB7Y+y/?=
 =?us-ascii?Q?QoKDpi2g9N3IDudyV8XHgDAsW+NYZGaBdcuDAadT4VOPmeCpsd2ounvQiC2c?=
 =?us-ascii?Q?uTVBRHDV4TdhpKndjlFiVvaa7cQwWhg40PzsysWmeihPdCv9SF37e4Fry3GV?=
 =?us-ascii?Q?D0HakQu+7QJ9DPW3s03Y+tZgJ6/jDFHgsXgJPkW+lpSCBkEG5mSONOItOeBJ?=
 =?us-ascii?Q?/+6jFOZw+EGVb+rNUVGtpyVdqis2LL1V1hGm5VkvEgjb8P4F7QBpDepnoQPR?=
 =?us-ascii?Q?v80VQU7LgZ3n0cEwkYXK/RTb0iOu11Ax20pPtZS1Pmi/NCooyNL41Av+l3/h?=
 =?us-ascii?Q?PAeXI8CKmAoxBibbe/yiRNVKRAK8IcJyrJAsDxpg5pYutzc43ZG2TD4DXyzS?=
 =?us-ascii?Q?fYWAO3dFfrEXlDxcMNhaKj9rSqQ/FLRiuDArd9fZQ55eiN8AyrJhY3bWwi2n?=
 =?us-ascii?Q?j4qmLpP5s3MyqpNmL5eRlhrlY+tVEK4vpK3rq2sQEs9MoELBu9PuOfW/sSvu?=
 =?us-ascii?Q?EbBKIjL2ZgKXwtlieDJsaF4dnKvbtHbGS3ibECMbxzYmlqA1Z0dfEtJScw0T?=
 =?us-ascii?Q?VcvZyyxZwKkvdXBNVAHF3hYADlY9eF3BM+og5GVL5pTtrETHjgPgOp8OjQPh?=
 =?us-ascii?Q?0ZZ8WRi+c9lVcPmZwXjUWOnBvE6QAvblqrBYGBmA0uiLlL4ZWKsL/pxbqcr6?=
 =?us-ascii?Q?bN05N5A44tvAUSGJUSlf7SZe/ZEQxmJrxNDWPYlaL/jDZyB+51ya9TtMNKdO?=
 =?us-ascii?Q?n+qWQ88TlyuJ90w7RcoGYQ9HPAcQqAckH7jgu53q7Z0ejtONAuDKgAgbojPi?=
 =?us-ascii?Q?FAhVMgzASMipUsGzRjW+Fukm8x449sXjDvw72FlMpIy/Pgf0l43sKSg/8Mi0?=
 =?us-ascii?Q?HbMqEtB+pASgl8dVBk/XpJzxtdmobLm+C7awh5rveEPVPe983+IMortpU9Fe?=
 =?us-ascii?Q?R1qqzk16FW2+W/YR5LJ1XgagEhJUw9JC9Oar3CAAkHf+MuJcrIt3qBn+nMnX?=
 =?us-ascii?Q?ihVIlWQN7MyDfrHsKRlqhb1XAgUsNHttOx9M6Ilwn+X1D2ILZJJR/cdzBxHv?=
 =?us-ascii?Q?rgegq8KILJHAuNZK6NQe1u0mdM5Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99FQh1K53ogQcdhBM5CRJP6XKUwALO/8sRrM0m5k5Rs4eJ9+jJlgePInjgTP?=
 =?us-ascii?Q?VP42uZidV/r/N10W+PnX+Wm8P6fXbKKl0h4A54sMeqMfSJXT0s2YuN6ZP87V?=
 =?us-ascii?Q?F0LdxvwPMx1NnDAXYpZpC306V7Z3sGoL0ouzD9jvWhlUEXjiVC4K0N5PEzMS?=
 =?us-ascii?Q?Dqmb+qLmypC/fE+t4R2jPtohJWIC+efZCVPwcT817+GahbWerqP39tUjJtdF?=
 =?us-ascii?Q?Sh0hkL91GC3ieIXFbHAjVHdNEumZUCemfrj024GFzKGS6OsL7E4SreVLDSm+?=
 =?us-ascii?Q?HvvC8RqLC9LaGwyXyHP5tPTv56ia3VBdFuEw1AZ2rkC+KSuNyV2rd0NvPTdN?=
 =?us-ascii?Q?8KmuhSbf8Zu+tYA8UUSwp65A2qzmNHG0oBzmjyvNWdZBTrggkSu2enCpeIxu?=
 =?us-ascii?Q?kMxVXZND8otOZHmigsKvFkL2Eq8PQM6C13k7oLqVZzHD6UaDHoil2D2kAbpO?=
 =?us-ascii?Q?RNCg7zjPga1farS24tSeAxy3FFrGxx+xtAywBJQIhqsVsMVFCQcQ/hA3rg+i?=
 =?us-ascii?Q?rcIz+Ir7FrZhth8CXAdcvgIELbzst7unSJ81Bph9FWqV4N9IYgGLQHUfJQnZ?=
 =?us-ascii?Q?JWyh+RkTuCstFNurzG5+rjmytxbwjWWW3w4dZY2o+J2ZcsvCdSij+AV3MvX9?=
 =?us-ascii?Q?0kT2Y+vc5bwgDnELntdBaFaz2j7KvMCTx+JSUflRdzlXgzLseChaSEQtbI9Y?=
 =?us-ascii?Q?KN9vVuO80tfajJXVeBHzuhDRzrFC3U63lHjBxKKQugacV5HgTrT0+tTVOQdF?=
 =?us-ascii?Q?/k87wNs6Mv8oWRpOb5Cwfera/7kmrI5CKdmPiwLySEAGOsYu4/RRGuWIzEkE?=
 =?us-ascii?Q?mlwExfFA5xeDyhvk451G/2YZHu+gCyKTzwgteRal89lQxxydVtotC8Bje4jl?=
 =?us-ascii?Q?PpjoZP3TLK8Lge3fg5l0oIp5SR9cNVPNHr63pRxFXhIEHr40eT9xPEJyPr/O?=
 =?us-ascii?Q?zMhlBnLP05cEge/55eNmmzEWj2vIIUqKf04rZ8+Aqzugr927UDy9/86i13ms?=
 =?us-ascii?Q?Cqn3cXpRZDcALpzZqQiwozPL/yHEYVqa1Zx4PWjtRFBZ6x4ko1+xiDUQ/VRY?=
 =?us-ascii?Q?ygbIWLqYNsBK+C6RZHb7O+s8T4PGsIID9vuUIWR8jJxFPRCwao6+uXyQXN5T?=
 =?us-ascii?Q?PBspom7Ld5ExkWrCux2zhKq6swCwJ9jtAL4ZKYevbBfxNwv9Xo/z5LVZTGlB?=
 =?us-ascii?Q?02M/5+1K5GpGA1t8lM51JtYIWVslxZzXy68K0jbHm7iFKX9vvEO945zj406b?=
 =?us-ascii?Q?pEtKTty8xOOGWFAEH05jj5y4XrdC1zZGLhPdriiWp5g80TSTry1TS14u7VXP?=
 =?us-ascii?Q?XQmcX6/rLiCnc/tpXVIHwx9mgt7+EXc0TGz8+/yo01QcE9YEueBZwfh/wm2E?=
 =?us-ascii?Q?jgg4k4ExIkPX0EymGZBcZZNotY2JKZZ0BBRAniICkt6qE/UxO+yV/+0PbWAW?=
 =?us-ascii?Q?TTa1kly3BZUh6cciUh0khYgSLxhO56WMbXmsTXnlfKTYPEwuSlmUlU3MG4qU?=
 =?us-ascii?Q?jGqwu9PStw1i/1uZ/eOy1iYrO1x4xPiVFYgUiVvM6HLr2ys3A+NBfiNZM8Vl?=
 =?us-ascii?Q?p5noUhIgWvZQBfhVJGhL7Z3dOfNzLXkDej9zO/AF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0e5c5c-9988-4819-dff2-08dd778118df
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:10:51.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJKuPcw5mn20XpwSe85WuRKnOu07YiQSOt2aAwHdtC4EYTaHELWyBQFmlLbpv353
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220

On Tue, Apr 08, 2025 at 10:16:45AM -0400, Jamal Hadi Salim wrote:
> > > I cant imagine a commonly used utility like iproute2/tc being
> > > invoked with "when using broadcom then use foo=x bar=y" apply but
> > > when using intel use "goo=x-1 and gah=y-2".
> >
> > Right, it doesn't make sense for a tool like iproute, but we aren't
> > building anything remotely like iproute.
> >
> 
> My point was on the API. I dont know enough so pardon my ignorance. My
> basic assumption is there is common cross-vendor tooling and that
> deployments may have to be multi-vendor. If that assumption is wrong
> then then my concern is not valid.
> If my assumption is correct, whatever provisioning app is involved it
> needs to keep track of the multiple vendor interfacing - which means
> the code will have to understand different semantics across vendors.

It is like DRM and other places. There is only one userspace
implementation, coded into a library that all actual implementations
use.

For example, one of the ioctls is 'alloc pd'. All user applications
will link to libibverb.so and invoke ibv_alloc_pd().

ib_create_pd() under the covers has detected what kind of kernel
driver is present and will load an appropriate helper library, lets's
say libmlx5.so. So it calls mlx5_alloc_pd() which knows how to talk to
the kernel mlx5 side.

It is the responsibility of libibverbs.so/libmlx5.so to present a
standardized library call interface that is largely perscribed by the
IBTA specification.

For DRM this is similar to how libmesa/etc present a standardized
Vulkan/OpenGL library call interface but the kernel ioctls are all
very device specific.

There is no use case, or interest, in making it easy for anyone to
invoke the ioctls without using the single userspace library.

DRM/RDMA are all building things like this in pursuit of maximum
performance. We cannot afford to put an abstraction layer in the
kernel. Instead it is abstracted in userspace code with a
userspace/kernel split driver architecture.

> > For instance, if the user is running a MPI application and the vendor
> > makes standard open source MPI 5% faster with some unique HW
> > innovation should anyone actually care about the "common path" deep,
> > deep below MPI?
> 
> I would say they shouldnt care because the customer gets to benefit.
> But on the flip side, again, that is counting on the goodwill of the
> vendor.

In this space we have sophisticated large customers, it is not good
will. The open source stuff appears because the customers demand it,
so long as that is true I feel pretty comfortable with things.

Jason

