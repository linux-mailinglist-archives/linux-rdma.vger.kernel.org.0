Return-Path: <linux-rdma+bounces-9676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9BA9723F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F98016A1DD
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885DB29114D;
	Tue, 22 Apr 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9NQCNX1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B1290BD6;
	Tue, 22 Apr 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338432; cv=fail; b=eUW3a//UZ/g0Gwtl3JELrU8t7hXVClgJvMXqZ/HP52ppParPE/xcITXc+m2Wwm03pa8A3yVObyYOCEE0HZ0bZxFzFofmAAgdfmPuRiYrBGAJj3BWpv//doOM2RNkoRCoXT9by7y9VOaPVWvHRBWSxYXPb7MkhNuzasxcfDk5Y5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338432; c=relaxed/simple;
	bh=aiXqR3Mri93r8YsJRj/XQYuKFCw5HPpaheCdU8s1lYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T/w4UoGmAR/NjjiZcxpBup9c26KkRF9G+II565l8TrusdkEa8L9ZoCjno42DmgR9MyNuOjLcITxIAJH6DQ0/9MESy7SyD8r9sCfHYlCIkzFH7hQkMxlmR0FY7+FlcZoBV/cvxjoEAJowEcQIN1UTh73OSgp2jORPe5ANStNw9vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s9NQCNX1; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoTSyKbP+2H8ByZR0geAFWK6s8GUX710UFYSwdCGJ0gXNVKlAUsHn8mxQ9MWEpCyhX1C+b4KLkB3f2TgUwe9b5OMuLkqrAZ1d++u6szjiZAI+Xa27B85VFctlOg408t5CMbYkU+vHjt9AQOxwyR6gdkGSj0ZSuwdu8lG56+jgJnhkSW/JxLWkhJ3jlt598c7I9V619Tb1F3+HP4yuzfMRcx2X/Esr8iTj8M/doc2jXd8N4o07GrarZsfUKVBGAHaHXGDt4dj36aKMImda6txY9ztXaVvog/BXkTJ5r7KxMpbrpLl6yKTve+rsKkJBnuVZygrghrLAGulhAPubyuYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcOdR4LTRGf69kP6IN0ynFCpohSXngYaICF9ljHGd0c=;
 b=DB65KdcRf5NDvf4D1vS3zcNTyrYRh1ireLLMvAr8ASBxbsLVQnGF1qsTGRc7JH3CD8OQvnCxVTOnDNFXgV4fyBZIbHGUJEefK02ZE28ma5Nz2BOpP+BGXARsdo45vTgmnXk0gsyd0auQx+PAEAbDiT2duh1L8FbAAMuOhMQplMuPQ7YmUIVAga/8fOUQdit27+9pFHoAvrJ4rZbYMJxKzbXNucGf7xY9GBb1/FbwvFy/trjzdt9esCJxuoKFNtM7e29FU2CbiCo5vXMN2nTzV7k69eI4sbW4BJwGVSQ3ZMma0QxOr2vsvu5YabZTUA2pwRUZbZUYyIjjmEkELqRZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcOdR4LTRGf69kP6IN0ynFCpohSXngYaICF9ljHGd0c=;
 b=s9NQCNX1E8tBCx7icdP/TLJ8kPTuuEjUtwBx9hzA366Zd4bXfqltEPal2uEnHUqmKUh9fnx6yXFImBQ/Ttm5/oPKJpUa57fZ1aGkI8wOgO5lGwsA+t9k/yEpjoS7py25TQ+hqjoq0/9zFT5BOoeSDTTLAYTzwFMteZVZMlvfod/kBU2etrSPuZ/zbrFu1HE9Yi1AfRHtepuzErhex0pey7AlUlFQsbeOsCzyiGLe8C8uaYrX+uKtYacnRfo9m2chreezizbkLn0WXNzEAe9sqW6ttbX9hnY1fJPEjq6wLWG3tsP2QE5q83t46KgrXWxOjwUk/4QK5bZ/Dvdh+A5NlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 16:13:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 22 Apr 2025
 16:13:48 +0000
Date: Tue, 22 Apr 2025 12:44:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: "Ziemba, Ian" <ian.ziemba@hpe.com>,
	Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250422154433.GN823903@nvidia.com>
References: <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417012300.GC823903@nvidia.com>
 <DM6PR12MB431337B52F88E8E22323E066BDBC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417133156.GG823903@nvidia.com>
 <DM6PR12MB4313E0C29EA74A94748EBD53BDBF2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4313E0C29EA74A94748EBD53BDBF2@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7f5583-83db-4947-a64a-08dd81b8a99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYz4ECx+mUeWfh4WyVNMLZqW1y+c3/wnYIRu+w3bv15LPOSKSURtxBuigjO2?=
 =?us-ascii?Q?75zWQOoxxOiJBQowsB+GffFiq2hL8BL7yliEibHzPSrh6mow8sos0asOSg78?=
 =?us-ascii?Q?yHTION739FfjY8dNpSS20tpFEF3qlX+P3AIm8nz9Mb1uzdhAgvaI34WmwZsq?=
 =?us-ascii?Q?dqNsj0Ms2TmKyxWgnvqGqWsOqIcxZ+BJylpcZbxf5IAfv041FG0smgibP4t+?=
 =?us-ascii?Q?oqhlwKpui0HNntzkqBIDpGccUAmnbj8SoTQb2xxZcFegiJT61V8niL6xGOUz?=
 =?us-ascii?Q?80srR87xX88PKnTbpxJyzJQIis9JZVvxQs4tAzDXHcpdAsZKBP7+xz7wG9sE?=
 =?us-ascii?Q?Xf/bmWDLQioMGMm2/JRI5U81gyRtCCUgCc9w4h/UAv1N4yHgslj90WoWehF9?=
 =?us-ascii?Q?u8z47FD8fyU9pC+SqXHaDOUuxvFdSKdWd89WbG+yN+qhrFW/7GAltWqewtbn?=
 =?us-ascii?Q?zOMSRham5LPh8FdZ8TKQCNiT42jewWGrVvupLtVLj92Qt8Mo6gJeyvMUmm4V?=
 =?us-ascii?Q?OjQZxMa4+7pmvr4DUEq3sFrkm9wXachV4EfQlutqE6pkgmmA7E3vdoh1z6ZP?=
 =?us-ascii?Q?bwxfg/p/89V1EryxoBIQi8NUuBui57QjCB6SjDzCCOXN/aoogEmclbJZurmZ?=
 =?us-ascii?Q?NrcAmiH59qtkObqEBetVtdwQmB+ALRhPLbrkU1a6tMOu/af6ir8H0ep6r4wS?=
 =?us-ascii?Q?sNBLnVbgC2JvKUNqve/ip85Hcj6l/JhKIAsq9eBovsWbyZFiVIs5/VwH95N/?=
 =?us-ascii?Q?s1fPyTrsm1hOHKo6gGgeNhr6P9ovZvpb9uzG747VX58RnMKOqGiN5j58QB//?=
 =?us-ascii?Q?ilzBIx/5jmSoBeYEDXxw7UX7JXSVRECoQs8aw0HQgocKbHqyHrrIroe52CXp?=
 =?us-ascii?Q?gxz8LbtzBZofDbSWKWuZyfJ0ZmCMlNBE3Zi8Y3aSR5qk6+11VHNGjvbtforC?=
 =?us-ascii?Q?7vlBcrzp3gvUgcJcJd3vPFU8Qc72iRu1efahgmZy1l2bGN2TlrHn3twamlTD?=
 =?us-ascii?Q?uOnwr6H4PRa8vEc/ezxlINcJdtucsbATQ7qkLlO37hEpnqMCGaNXQP09mrUt?=
 =?us-ascii?Q?yiEBKaAo5D+yagijDmK64H5aRYs2i1QsWnppOFjoBbWAF/zHaoV3ymhkxAYs?=
 =?us-ascii?Q?ht7HSM94iYOb5eyi42p0o4njGW9xM1InCJnmgCgLTqMMwg/C3PxgKsWLWuA8?=
 =?us-ascii?Q?3u+Ur3oQelyUe5TlxrcmluQrYHadoM3ntBYFoP6ur/OnGupWcmZ5L0ml4PVG?=
 =?us-ascii?Q?uXHbQrk7WMoXZVcBuDKOdIubPj+XpXUh1oQXHXY7pTSrlqleagyCeGfuzOiv?=
 =?us-ascii?Q?S1spmtHW/BHkFfCR8H6eGNersNiZc8dZnsbzlOjXejbomzvANRF1HSv5aCKh?=
 =?us-ascii?Q?MC8fyhYOicwUVUGBJcRsvNKdHTUS8jU4qC84PnyemQ9jV/jAQ6fgvg5O4KqY?=
 =?us-ascii?Q?YH/XM6+t744=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6FELNS8ronqR7pXt35Dxp8DH8NMTi2o9JGPXvcTqx8hpyL8RI5mx2DY06mm?=
 =?us-ascii?Q?Dssoa9yrMlTJuPDpvTDII1SusF4NTuzcF4hYUq3AjHnhGLxrlE4bt6S7XnUn?=
 =?us-ascii?Q?0vDMkqZTIGX6GVxyrVncO6SmDX3ivNWbStptGfSDrqvdGTGWd/2kwvFcVkQV?=
 =?us-ascii?Q?trgMm02l3vFWPgzwXfmSkSE43ycnIVLPUq+lLj5fJjdklGGlbKoRvduRhY36?=
 =?us-ascii?Q?Z5Yi/hgtuF4lpW2hJlURr1mePNoOanNmpLyn1xfkIZGzkqicGH6F0WU7nzcz?=
 =?us-ascii?Q?A7mkqWw6L/mCbM4bD7AL+DWs9g4PjuT7EZX3qx6eA3A4/yKWyVh3BXYJEUqY?=
 =?us-ascii?Q?epp1aDU9MRWDE91V0HqVo4QCQniTeqpUhROJcWERi8KTeJY18lNY/TGsg6eg?=
 =?us-ascii?Q?D5sw+CmaEIfwFa64bGCbYzAHgeKGOMnUoipDERz2Cm+xyTkW/I/KctOvFnZt?=
 =?us-ascii?Q?gzk02Bitjlyph4hoRvppJBld0wIj1VNP+xe2M09Gd6TaxzWJ7uYcS5rN3Ww/?=
 =?us-ascii?Q?v9oMdN2LRDk36Iv2ZmiIvJjvLXrUVXISXutI3xkOfNXho3bBSZPxd5XGu5Lm?=
 =?us-ascii?Q?7DiZhULramJilcwRuhAJIUl3/H8lLtBLG6uoadxsByUN78d5qle4PwKTOnwb?=
 =?us-ascii?Q?iJTsz51G5ylBK5TZk+hHCzIYsuFp32S7jgdpuBmOUpJt4AbaDaiIvAEg/ojS?=
 =?us-ascii?Q?MPvs41TForcyb6CCRLhRmo5XWoyfVJEybbeGJLtNSM+AQAbBTyXjaQBfFsGw?=
 =?us-ascii?Q?v4wC/PqUk4vvjjvAoW2pQE3HV9BQ6KLPQdGxXhe30DXfwsvs5VDYQBvBK1ey?=
 =?us-ascii?Q?W/wUauI+fXEsX8NBxvwdv84JtmKz3b/kmxzF+xVR7o6VyQ8pB+iomT8fieQk?=
 =?us-ascii?Q?PYZYye86n93BEoEprG3QUvGXeE7AMumu+80Uv7DBMaByYEU5QhKilstxUUho?=
 =?us-ascii?Q?czQ7L7Ibr52nfoJQCVMoBLjasuJU4e0zdt3wgJ7SI5+j5NpDQRQ7Fw+VQKg8?=
 =?us-ascii?Q?ALsBVNJ8W/wP9DvJvjJHHKKCO63ZSjO3WRrdRbcBA5lT0Zv2R/LyhDuBum6X?=
 =?us-ascii?Q?CENQlInl1u0Twc/kMpVVmN/5NvwVheOk2629qaGKhdysZoxUjnbQBOIzpFYT?=
 =?us-ascii?Q?KcGzcNVy1LuG6fYZ5AwV4g/5NNpZB0gTKBaMOpK/cYh6xp2zpXzWguF6i1iM?=
 =?us-ascii?Q?7VB53Pizwzmre22sMq+GEpyc6yPhmuvYfmUDKe/IFqG0az6X0V/6VeZgm0lH?=
 =?us-ascii?Q?c661ww0+qyK5AETZagPGQzk35IUF4Q3wurbzlk0ru9PnxzCw2fqFa6mYFZAS?=
 =?us-ascii?Q?ofy+MoS0lyKdgBcwQm7lSaC5yiOvkXfnUCaLuwotLEn0rzl37V13evYINkms?=
 =?us-ascii?Q?2i05b5FwcNvB39W4R+Oey5nZCZsu11wNcxq0L+dflGRq91T89hsRcOYi5TYI?=
 =?us-ascii?Q?JR0yp1T9lnUi/4+bMSYF3NoGZyDjyI5h9vlDaaNN2n2AF/WNBFhpF/pR26Jf?=
 =?us-ascii?Q?5Xt3OAdK8KRvhyRPVj44Kjzx3hbb7DEu5kE7+RmKy5uWD8qz2Myy7CW7OM4A?=
 =?us-ascii?Q?LoIPXEQlacO/6YwGBv4vDucJonSs/MhVZg0Oi9ET?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7f5583-83db-4947-a64a-08dd81b8a99d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:13:48.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlMCXvzp146nvs494pkvHUU8BiOv1BuEzhtSNWA+s2Xbd9a7rX9LsmZ69+Tjc/jI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On Fri, Apr 18, 2025 at 04:50:24PM +0000, Sean Hefty wrote:
> > On Thu, Apr 17, 2025 at 02:59:58AM +0000, Sean Hefty wrote:
> > > > I think the "Relative Addressing" Ian described is just a PD
> > > > pointing to a single job and all MRs within the PD linked to a single job. Is
> > there more than that?
> > >
> > > Relative / absolute addressing is in regard to the endpoint address.
> > > I.e. the equivalent of the QPN.
> > >
> > > With relative addressing, the QPN is relative to the job ID.  So
> > > QPN=5 for job=2 and QPN=5 for job=3 may or may not be the same HW
> > > resource.  A HW QP may still belong to multiple jobs, if supported by
> > > the vendor.
> > 
> > Yes, but I think the key distinction is that everything is relative to, or contained
> > with in the job key so we only have ony job key and every single object
> > touched by a packet must be within that job. That is the same security model
> > as PD if the PD has 1 job.
> 
> Relative addressing does not constrain the QP to a single job.
> QPN=5 job=2 and QPN=4 job=3 may be the same HW QP.  There's a
> per-job table/hash/tree used to map QPNs to HW queues.  A multi-port
> NIC may need separate per-job tables per port.

I would say QPN=5 QPN=4 are the objects, and they are constrained.

If there are other objects outside the PD/Job (like some kind of
shared queue) then that is a different thing.

It is why I asked if we can have the "new queue" inside different
PDs. Forget about language, there is an on-the-wire lable that
identifies the QPN and that QPN must be 1:1 with the job. That can be
a direct software object, even if it does not come with any queues,
but delivers to some other queue-holding object that is outside the
PD.

> My guess is storage is allocated and configured prior to launching
> the compute nodes using the mechanism being defined.  Once the
> compute portion of the job completes, the storage portion of the job
> is removed.  I have not heard of a specific plan in this area,
> however.

That seems too vauge for an OS implementation.. We have to define how
"configured" works, and how do the various components, for instance
kernel storage components, get permission to use the required job
keys.

> I was thinking of security key as an independent object, passed as
> an attribute when creating the top-level job.  The separation is so
> a job isn't needed to apply encryption to some RDMA QP in the
> future.  It seems possible to define security key as a component of
> the top-level job (and give job a new name), rather than an
> independent object.

I would probably duplicate the keys, both as part of a job and as part
of an address handle if that is the worry.

The schema doesn't need to be fully normalized, that can be harmful
when we are talking about different security contexts. A job
encryption key is some global cross-process object and a AH is a
per-process, per-uverbs context object. They should not be the same.

> > > A separate security key made more sense to me when I considered
> > > applying it to an RC QP.  Additionally, an MPI/AI job may require
> > > multiple job objects, one for each IP address.  (Imagine a system
> > > connected to separate networks, such that the job ID value cannot be
> > > global).  A single security key can be used with all job instances.
> > 
> > I haven't heard any definition of how the job id is actually matched.
> 
> With absolute addressing, the QPN finds the QP through some
> table/hash/lookup.  

I meant how the job ID is matched starting from the head of the
ethernet packet.

You cannot have "separate networks with non-global job IDs" without
more strictly defining how the job is determined, by including things
like IP addresses pairs and possibly more.

If the job number in the packet is port-global, or vlan global or
something, then it is global and we don't need to worry about
"separate networks" because that isn't possible.

Jason

