Return-Path: <linux-rdma+bounces-8835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F2A6954F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B0919C2475
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A81E0B66;
	Wed, 19 Mar 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g79i4LnW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC3257D;
	Wed, 19 Mar 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402890; cv=fail; b=f+NzJ4QqGsmU5JWQaFinj8lntrupbVYCe7/b9kdV345aMKLu8pMxQvBQ43mB1LRp9M9iPajDMeQTmpL6iQdxbvj7u7DCWRn3bbfYymQCT3Nf15AxmDTRk/EjtIi0RC1B3NgpddiHJ/XWx2Jol7yaBloqc0ZcKTBUgBZ5rFsTyW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402890; c=relaxed/simple;
	bh=pbs74ebCPKE1ue0U3FJfUz3Tom9zBH55h8Km5Zk0gQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m6jJdCfpZBB5zPFnCtYXjDqkk30JJzc5XwAYOq2e8ozC3YfgVO7x4TziMjne1pBvTM3JEUi0EQQn1UdjFOgqxP9779HLggl4Pto22R2TFMOAoCfiWZ3sr0VHkiXcqAiCDjWXm8x/iDYXxTtJhrdB8KXzIqB1juRpHwkkXZjoJFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g79i4LnW; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHBMS0QcORbKeHvulWglpiJe+fDRaL1qFwInPqM1/auk+m3AtlTaHb5TaSQ51SXVJUXTi76bML8vGLyRj/VcSdLt9y5OeSsw2Hx8VQo7a3xiHxCmvM6xkhenWyvKcM8IH9U2LngvybH3nVVTHh65Sym/kOh6F5/z78qRJlE0a+lKOh75oW7CSpe5Pd1Fj1Moe3EuPPWszQ+/0cn5QFoC/SMH9GpXgE7MnaxHuXON0bKKmsiiZpUaXF/B7bC5Fy0mFxL3UyZZZT5BAfFSW0GC83X7wstluBLrcDrt2eQTvP3HMoyZr/p0Wh6GaO7eI5SWAoCirarWsPtr5AkeR6bUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvEBDhW5qXJownfkSnqAV3JJvm9TxhCAlS/FOH0w/mo=;
 b=kGmzSi5Pdo9DSPVaSo7tfH8SiwV2pX/wM8ebQRH5IPCNHKs4IElNXQvH1ujljBJBAjd+jG5OVpcL84Bmlc06bPK8opxLbaA2pJewUwPZMmBsGXYNuyE7vDEt6ZjgrH7uUhPrLoc8K9kQS0MG2oioF3q284HjLh10QPagp669EFlpbgYUUA5rn9OMmLHTqKBoE4Bs2YAVFkX0PcX49THR5mLVxrV7+Mo88u/o3d8PSld88fX8cpiLJjtZfStQpv3adMFjutOSlSnQCbcT2T4xiGWbyWFNgC3kprnCoi8KYGtEAkNNZE7wus1cAgHZ0KuT8Ymb+GGWiTyvQNMjPCUBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvEBDhW5qXJownfkSnqAV3JJvm9TxhCAlS/FOH0w/mo=;
 b=g79i4LnWoT8CNmAiSmxu9AkRaeNOzI8rIzy2YcajUiSpT14zgxwaThjkW9qqT25xKtFZz9uHssRsbmQ1jfbnmLyDqrGx/qvR6N5WFt3r9gTQQBsH9dgzD7YwBAH7eek0S1Kc00hTmp3LQM0acz2dqBtYC/ZRPyklROMoOL129jNLU8JEyyGxPFk+zWrc2ySsvwxihyYNz5w1ovekawdtK0bOZ/IrXB2E6SoErbQKbu9ISRsJzcOc1GV8brMXW5c2HzWC6SiHpSLpSOZosKz1ZfzfIJQ0uwp9oiI6aU8zRzQcnndlZJOD+k0zCeQoQageYUUoPQLh4LVhvhL39aK/4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:48:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:48:03 +0000
Date: Wed, 19 Mar 2025 13:48:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nikolay Aleksandrov <nikolay@enfabrica.net>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250319164802.GA116657@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
X-ClientProxiedBy: BL1PR13CA0415.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db3b53b-11ee-4d4b-5a10-08dd6705d0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92LmK00/TA7YdKNoVRtgt4QbQTpYfdN5+hUsQwM/1M/pt/vMEm8XHEetg7vB?=
 =?us-ascii?Q?nzEzitzwk0DUIZ2FHUxpXVF1B0VgHi+aaV0vJ0/h3Ug8jbHUvKvDrkii5Ei5?=
 =?us-ascii?Q?Fk3EEDS9WC6W478XnVLx79qsojENy2fm0Cp4EnS16Q/7JJacpLN/Y/+bqkHm?=
 =?us-ascii?Q?JwbGhuWdTu8dZmKkbFVyA4xOpd7VduvylQQlgfthPUoaYR7QOVxlO8G4WRFD?=
 =?us-ascii?Q?5RvoQ9qY5rg3D1wLRJQbmtQzBJoVfh+gz9mze7oIxc+OfhDrxV6EdivDIWX6?=
 =?us-ascii?Q?3ZwSmqmOj2iXcvreIIeMvQ7CgTupiIOkEzQfuoEbgXWEUSGpr4o/m1GYbKpg?=
 =?us-ascii?Q?WnkcFbu2UR3r3S+c5UWrvHQRglqBVA2NKN8Vn41OH+HrODhtPN0ZEws4Kmf5?=
 =?us-ascii?Q?vDxALr8pUDDhVGXh9A4dn9ns3ArA0naeNVsBOA0/W5EICO+v1cymGIRu1Sui?=
 =?us-ascii?Q?YG2J/cJlxXDfPiBqGhEiaYBeHrhYJPl/rg9BdDcQXPl9lDJwj58AFhSOAVEq?=
 =?us-ascii?Q?4tjGrog4gyF2ih+Sjl5/c0rxmiv26oB4FvYMU/01CAQI2bPYgc22WPli6dgO?=
 =?us-ascii?Q?8wE3EX9LyNM8mF53l5yobH8scpWGTe2kpQmtPtEd/V466wAU+7ueHi1Akb/m?=
 =?us-ascii?Q?NIz2p3qwmH2ZnM1mjskF6CjeJ6p/oUjyIvEIkE6QfV/mkg/8ETu7fcxFDGK9?=
 =?us-ascii?Q?S6Oio06c3/Ln6a37b9xF6xFBNzc0mOIzaQ3KCN+51XVXqkjgby/X1/qDUgAL?=
 =?us-ascii?Q?9BlaBSxkN9x3hrpDkLSG2PeK+v/RSBcz1PVQoKJYWnHGzBJ+atZeIP8pESB/?=
 =?us-ascii?Q?/Fp4RXaFO+6zGgAKT+6b+KaGF6MkueP/uAgP7K0foxSKrvKdq+OH/+r0nOvs?=
 =?us-ascii?Q?rqiRr0KIKq/Dxf2uKUSfPeLuvHD+flgt2h/2lQFyz+X7l57gz4XmNPDtOJv7?=
 =?us-ascii?Q?ZD1+EEMnr8bekK6EiBSHznhWYWPOVJHuOapTG5jaiV7bF1yZdnG0BClF3arl?=
 =?us-ascii?Q?csoo3cTUmaR3lSI5ooJ/sLQKnhVKKExHMo1zBuXTgZ9OQ0SPIVSUfW/99w3S?=
 =?us-ascii?Q?ZIBp+1gWT3CpMvCcmHnixgMk7BeAbLPWevZSUy/h2uJENhDS5HVCvFZgSyP5?=
 =?us-ascii?Q?Qdo7K/G7OeYlkGTxaJstAJnw+a27SrruACfw0jPQCU7n2QXdfnj55WsvPEaV?=
 =?us-ascii?Q?M3cJq4m6WSnKJhUplzxLLgfG+fbOo/BdAPDZ0rRVN1CJ0j9dyR+apBnED9S9?=
 =?us-ascii?Q?K5VZGxyJEyoIV1HMbmdKTsrTvLCXwZ6wFhRBgI3uNtRA0W3H6eGLpspHetgd?=
 =?us-ascii?Q?rcRRbQxC2J8NuvaLRVLYWg2EoBLc65mw2sRKKfzc27lDrJIxhDyM86EiGesh?=
 =?us-ascii?Q?OD2Z5UY04W3XBQ1XlLF3BNV0VBY8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5A6P/MlxaiPWrBAjM1J71A4WNo+2CWN05sS7LXzULSTqXAL3ZEgZ8OAgoEDX?=
 =?us-ascii?Q?G+YbP4A3UNHFeC1ByuZIhglG/5NxwM433nmG+AGYcyFE8F8s+W9a5i7ebfdR?=
 =?us-ascii?Q?V/YNoNUXtYRnrs1SkKLptL2iht+igG8Bzxs/3zvtQ9yr0x7HP3Y2/Z0Ijtp5?=
 =?us-ascii?Q?C6Kvr2P2VRo7m9v10Xf3QnLjTwyFF2bDiPj9RtkeMpLHlDiJ8WMtzFqWHsl2?=
 =?us-ascii?Q?ilOtcrWNlQcXriBwEcuc8TuEW1iX8sB1B+eSAB2JOKrhJfCISG6ZhnAqB74k?=
 =?us-ascii?Q?1knTYow1WhcXGlzzxVSsLwC2goLgnEDY2Dd+asTsl8tAy2W9M0F3Z8Xwvdeb?=
 =?us-ascii?Q?g1RPlA6YWKu1nETEMYA73f4YbtTLx37GP8FmH6WkOr09IJ7NCPXf4Jb7T6Mv?=
 =?us-ascii?Q?e+1TRXD2comSi8QVeBjZWryJEIGgqdPTsO5QGHc/0mBG4SCREg9FBZ8Hadyy?=
 =?us-ascii?Q?QKqlAZqgeuPZN9RwJG1AOsiDFFh6l4JVuFZhy4jl2VrKyXgBJ7Sa4u3Lm/17?=
 =?us-ascii?Q?6KUlzjt0IEKvNce40vw3ifz3XZvjXSV8a2kC6HLuYsGqDkZk3Ff/mcleNV2O?=
 =?us-ascii?Q?uGnqWBV5ISE7cKYzYrVafND/fERL//Y3yUmeGpaqcIpTKlI8o12k4vkPieKM?=
 =?us-ascii?Q?QCMMFG9ZWL5yhfcsUV0ZnT7T/gsWmLQ683NJlzwAfSORbcftXO8YwPqpi4f8?=
 =?us-ascii?Q?wlK9h88m8i7DKAODoQFe0xjLSF05sVDcvbFDRZxSuIeys4qqn45xkzsn8DjX?=
 =?us-ascii?Q?cDiub66YmBUwU6AcunO2teQxNzRAtfohFJBiQIUnDmBI9gMdWdh2a9yHDF+6?=
 =?us-ascii?Q?/YxbvGI7ceNOOfluvp0LRgznr7/X9H6lIVF4ZT+InHuI249r7WVaVd2Eaw6/?=
 =?us-ascii?Q?2S6IuW9MOOxQZAN1Gaf9LS5OxDc6mWDu2oAagVm/dXjeKFEK2HGeMLL7vPBJ?=
 =?us-ascii?Q?0dTusHIcfmkgpMsaTa88E+tc/j3omJNxKrN/Hza1XXlutsoNSgELGPVwKZZq?=
 =?us-ascii?Q?jN5izaa2+VVU4PwS/N3IsdgwciTZcP53BihH+i0tNI5rWc4y8/rslMT7ZPOc?=
 =?us-ascii?Q?UBqbdfNupoHHMrPD+afuIns7bHKix3HceCImfZfmzSVew+g+UKtDA1Wz9yDq?=
 =?us-ascii?Q?ymhQI6pVnvV/n9I9/hnpRI6sBbx49ABFTUl3PfcySAQjSRZX4/GNpR9EBYqK?=
 =?us-ascii?Q?lZBq6F2MCgAisfZQP3QiiJqjJWeRrzc4x8n0RsfVsk863EHjB+Rb1MwfP742?=
 =?us-ascii?Q?chq3fHq5tsxUlJLldfATQV9C59H7dqK/JAqqxDUOjPvKWl+88nJfRNASrGHe?=
 =?us-ascii?Q?rAuOsWtLrkp4QXjvs+vpHGGf+v+Nm3qvJ4G9kCHI7QQXolhBC6jyo8R97rxU?=
 =?us-ascii?Q?oDAwt2bXZsx8dhn8ys0Ff1A5vPoogeMvJm3914PPbst1JHgcTyvFppIoPd0V?=
 =?us-ascii?Q?zrtyJu/ojBOPkspVtzKmFrY/IYbhk0jL9mQI6kJGkWLSR5UC1pxpfw6CKSrR?=
 =?us-ascii?Q?SgzUut8SVOQcAMEAYStt/VSyt9hIigyTMxPBJWgU+5zD1BoL07xMY1rtSX/W?=
 =?us-ascii?Q?yl5rTVVntVddMQZsyUw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db3b53b-11ee-4d4b-5a10-08dd6705d0a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:48:03.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu1pxrXlUmXfQEo03qOYwr2gydeXewxyLEzI2dhO1hJwOwLWdkK2ue+KRSsTsZGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> Hi all,
> This patch-set introduces minimal Ultra Ethernet driver infrastructure and
> the lowest Ultra Ethernet sublayer - the Packet Delivery Sublayer (PDS),
> which underpins the entire communication model of the Ultra Ethernet
> Transport[1] (UET). Ultra Ethernet is a new RDMA transport designed for
> efficient AI and HPC communication.

I was away while this discussion happened so I've gone through and
read the threads, looked at the patches and I don't think I've changed
my view since I talked to Enfabrica privately on this topic almost a
year ago.

I do not agree with creating a new subsystem (or whatever you are
calling drivers/ultraeth) for a single RDMA protocol and see nothing
new here to change my mind. I would likely NAK the direction I see in
this RFC, as I have other past attempts to build RDMA HW interfaces
outside of the RDMA subystem.

Since none of that past discussion seems to have been acknowledged or
rebutted in this series I will repeat the main points:

1) I'm aware of something like 5-7 new protocols that are competing
   for the same market as Ultra Ethernet. We can't give everyone and
   their dog a new subsystem (or whatever) and all the maintainability
   negatives that come with that. As a matter of maintainability we
   need to see consolidation here, not fragmentation!

   Yes, UE is a consortium driven standard, which is unique and a big
   positive, but I don't believe anyone can say for certain what
   direction the industry is going to go in. Many consortium standards
   have failed to get adoption in the past even with a large number of
   member companies.

   Nor can we know what concepts in UE are going to be copied into
   other competing RDMA transports. See my other remarks on job key
   for an example. Prematurely siloing stuff in drivers/ultraeth is
   very much the wrong technical direction for maintainability.

   That said, I think UE should be in the kernel and have a fair
   chance to compete for market share. Just in a maintainable and
   appropriate way while the industry evolves.

2) Due to the above, I'm pretty confident we will see RDMA NICs
   supporting a lot of different protocols. In fact they already do.

   From a kernel maintainability perspective we really want one RDMA
   driver leveraging as much common infrastructure between the
   protocols as possible. We do not want to see a single HW driver
   further split up needlessly to other subsystems, that would be a
   big maintainability downside.

   To put a clear point on this, mlx5 has been gaining new protocols
   and fitting into the existing driver model for a number of years
   now. In fact there is speculation that UE could be implemented in
   mlx5 RDMA with minimal kernel changes. There would be no reason to
   try to mess up the driver to also interact with this stuff in
   drivers/ultraeth as seems to be proposed here.

   I think other HW will be similar. UE isn't so radically different
   that every HW path will need to diverge from classical RDMA. Nor is
   is so dissimilar to other competing proposals. We don't want
   artificial differences we want to create things that can be re-used
   when appropriate.

   Leon's response to Bart is correct, we already have similar
   examples of almost everything UE does. Bart is also correct that
   verbs would be a PITA, but RDMA userspace has moved beyond verbs
   limitations years ago now. Alot of mlx5 stuff is not using verbs
   today, for instance. EFA and other examples use extensive stuff
   beyond verbs.

3) Building a user/kernel split HW driver model is very hard. RDMA has
   spent 20 years learning how to do this and making alot of mistakes
   along the way. I think we are in a good place now as alot of new
   functionality has been rolled out with very little stress in the
   past few years. I see no reason to believe UE would not follow that
   same pattern.

   Frankly, I see no evidence in this RFC of any of that learning.

   Probably because it doesn't actually show any HW or even seem to
   contemplate what HW would even look like. There isn't even a call
   to pin_user_pages() in this RFC. You can't call yourself *RDMA* if
   you are not doing direct access to userspace memory!

   So, this RFC is woefully incomplete. I think you greatly underestimate
   how much work you are looking at to duplicate and re-invent the
   existing RDMA infrastructure. Frankly I'm not even sure why you
   sent this RFC when it doesn't show enough to even evaluate..

4) For example, I get the feeling this RFC is repeating the original
   cardinal sin of RDMA by biasing the UAPI design toward a single
   philosophy.

   Ie you said:

    > I should've been more specific - it is not an issue for UEC and the way
    > our driver's netlink API is designed. We fully understand the pros and
    > cons of our approach.

   Which is exactly the kind of narrow thinking that creates long term
   trouble in uAPI design. Do your choices actually work for *ALL*
   future HW designs and others drivers not just "our drivers
   netlink"? I think not.

   Given UE spec doesn't even have something pretending to be a
   kernel/user interface standard I think we will see an extreme
   variety of HW implementations here.

   The proven modern RDMA approach to uAPI design is the right way to
   solve this problem. It is shown to work. It already implements
   multi-protocol RDMA and has alot of drivers demonstrating it now.

5) RDMA actually has pretty good infrastructure. It has alot of
   complex infrastructure features, for example see the long threads I
   recently wrote on how it's hot plug architecture works.

   Even "basic" things like mmaping a doorbell page have thousands of
   lines of support infrastructure to make the drivers work well and
   support enterprise level HA features.

   You get to have these features if you write a RDMA
   driver. Otherwise you have to clone them all.

   From what I can tell in this RFC the implementations of basic
   things like the object model are worse that what we have in RDMA
   already. Things like a device model don't even exist. Let alone
   advanced stuff like hot plug, namespace, crgoups, DMA operations
   and all the stuff needed for HW bindings.

   It has a *long* way to go to even reach feature parity in terms of
   what the core RDMA device model and object model provides a HW
   driver, let alone complex things like uverbs :\

   This whole RFC reeks of NIH: it is more fun to go off and do
   something greenfield than do the maintenance work to evolve an
   existing code base.

6) I offered many things, including not having to use libibverbs,
   adding someone to maintain the UE specific portions, and helping to
   architect the solution within RDMA. So it is not like there is some
   blocker that is forcing a drivers/ultraeth, or that someone has
   even said no to any proposal made.

   For instance I spent alot of time with the Habana labs guys to work
   out how to fit their almost-RDMA stuff into RDMA. It required some
   careful thinking to accommodate their limited HW, but in the end it
   did manage to fit in fine.

   They also started as you did here with some weird thing. In the end
   we all agreed that RDMA HW support belongs in the RDMA subsystem,
   using normal RDMA APIs. We are trying not to proliferate these
   things.

I feel like this is repeating the drivers/accel vs DRM debate from a
few years ago. All the points DaveA made apply here just as well,
arguably even more so as RDMA has even more robust shared
infrastructure that should be used instead of re-invented. At least
Habana had a reason for accel - they wanted to skip some DRM
rules. This RFC doesn't even have that.

Thus, I don't expect you will get support for something like this to
be merged, you should change directions.

Jason

