Return-Path: <linux-rdma+bounces-9675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B8A97215
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3816A028
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1694129114D;
	Tue, 22 Apr 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q203+0xg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32D28E608;
	Tue, 22 Apr 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338293; cv=fail; b=XFeZ6o8IUEjrlAmBUmjri0uxgObVhuiIjZ9DnswEULDGoRqNTmwV3tNY7CWl764Ir1Vj2LQJbTVES5+uP5Zd6fn0dtnbu224BSmSeEbOgusUzLD8OUZ/MlHIOxQQsq8wKgKRh0KQFh43VckPnbrLOoouKx0HNKmW9xg6ZFtPlNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338293; c=relaxed/simple;
	bh=MgB8nr7M1MHQ4IlW0nSa8YYKdjRrrBjbG3kYW/1IOSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FCzuOTWMfAMmPhRdGKNN0pIR3z/3fsu8sX8LTF+AIgLNkA0+/T57hVDFQipwYQUAzJFnxt96sWgxnGH7mrawIC3chjhpkN6woV/GXDX8ySZlzqFT/aNP/jmQxoJAbdvR0F/+sr1IwICaqAUPjoBT5whTXl4xluQQ6+G8Nri+aAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q203+0xg; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjUQJlVvZmhmIV3auWFAe0O0UDInjhWeqg8KWuoKZeE8zvg9XuVapXEcdgI7rgmPRQj0TLVnsG+7SPTQ1WT2AnEtVHbAGHs9I4oaPjpUH4Fpf8UX4ps/2vONnlbFwFJrt62qhcqo8bt5Vf0U6qawPinNmabcbFCg2kRbEzbY/R1RNCxLY4uV0AQg28fWAXg3IRHTngFnOq9mns+gGtMEN1t2aaMxs5C71uIP9VIo9xe4KEoHr+94InUwYWtJt7YV/PhUlZwtv3J7ypfCCdbo709fGqkhzboNzYQ19pTAUg4BZDHuH6YywjMnWiK3474eE5+6i8l4KO7cHgXQhXuXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCxnb3pepQPtjwPLxwclNg19wiNueYVBjRcVW9CiB1Q=;
 b=UtrbajmOLMRbpRVgteFy5OFeFovDSBfOI98VMAXkyZiNKmpliexBhCHLNmFXFwAKGN62NV+EjC15fwNDDlB0i0xpOtYd9I1YBSpivrufI9f4hC5naygaxS79Vexsq3DekhNdC5gWoXaqd+9HL4HXgMHL4i34rHVjj8yp2TL499rijiyzqBjHlSmUz7NBhU4/6/F78/2Szq5MZNT3DhNQRXH6zMuKw31Q7NgD5+FZIaN58LE3ZE+ZNu2fOyyQTiffL3HlhZk7EzYfIV1GhLxi0+BHMb/oGH9KvJasDOPKq3CqyLzoeFk8vsrxHEcxqo/j0Zk9KCbFf6y3/EyrqUm4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCxnb3pepQPtjwPLxwclNg19wiNueYVBjRcVW9CiB1Q=;
 b=Q203+0xg8IrTzvucwPXgUOiTYZ3BfJ69unMOK+yME/s6aQ0vT6jLp7LgjqvT3NGIKYJcsmksVZP25czY4yK3a/yHXuSJ694j77V8z/uHBJ+iatADAdylYJ4NA+gNEmf78fIlr0ymCLz4ihfeVBC1FlNvGUZMiC0ncV6uNKKP6b7tU52r9mFNAnJpt6cInW2B6dtFOw90+SDqHuqvD0vsSlmwZZKGe1KUhEMECEmFNa2KPwAXz0z2SpLq64nl6ne8A9P3lVtAVxoedoEgniodXPbaEXXY4Uosh7AEbdd2XvRwLtzc5zyakuzYvtIlzEr/8xCP6ppWDm9MVVVSXDbVww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 16:11:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 22 Apr 2025
 16:11:28 +0000
Date: Tue, 22 Apr 2025 13:11:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250422161127.GO823903@nvidia.com>
References: <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422131433.GA588503@mail.hallyn.com>
X-ClientProxiedBy: BN9PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:fb::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fd8f20-72f8-4e74-2aee-08dd81b85685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hsot1RM9K7AkHhvPJwpAx035TsjeK1j6Rt/s4uMqogwXIUnvVXgtijP0aHAu?=
 =?us-ascii?Q?EZMarPYgYaNCiIL5TNKhSPsUQA7qz6zHFNbiHi/Xhwe2TQexsVJVUvLdRqg0?=
 =?us-ascii?Q?9xAhZJnmBBh8c1meWwUb2+S+YmBkfhESsKsZwBdxuXL3I/TsItmDifHaGkl/?=
 =?us-ascii?Q?ML0V0DRHJWj9t1DefaC14KVTsCE6goBwIsrorBZyqku0cZoyZXCEhuZbHWG5?=
 =?us-ascii?Q?tQfK5+NnQsDB73FWH7lCbcjsvKs8w6tkq0lYTIEIDTmQ/l6PZlfXx2rYOPpS?=
 =?us-ascii?Q?IHPgEYsxIVL/2olmciHds8rDol+/tGnzYGUIRcpk0ayb4ZK5PkVbyE4NDQEG?=
 =?us-ascii?Q?r87lNL8SmfRtmxoGWAGVWHyvMtBbu6/UcK7MlKccnnqwaEv6ZYrjNPNUGdrO?=
 =?us-ascii?Q?m81c7gS5esFQ3Vc5QlQWXXp7lsMhFN0pG/NPldPmRzf0r8sKZEyW5YJhDnuT?=
 =?us-ascii?Q?a2p3ws9uUsMe7u5tT3Tkh2qP9w1DXnt1RTVw16fYMzIovGbd2VxbthPjkmWM?=
 =?us-ascii?Q?y5iGXWKothtXM13iUeeAOOpuvMv9pErgztaY2fGPUTgKd7R8YPscDiZdC0g4?=
 =?us-ascii?Q?xtcOyXCJSpBmztadPJL6+YZ19m7U6AIDOZMbE/4DeZ+h811HT28GRgItq71B?=
 =?us-ascii?Q?HBV9Me/rw0q1+9OjPBXlfP2pwxxSolkjc8tWdAGRqYpnZSH8eIcr1c0RmBxf?=
 =?us-ascii?Q?Kr0EzVy4wozWmX3P9VkTPsmZ3FHLcWWyruf1zYkpSimjDAlCSwHfotrgFUbd?=
 =?us-ascii?Q?nob4ftcdHbzSiosaf8x0sbpxSteaj1QaQ9vGUDwW8jJUC6Ll7pMEfujE2q8B?=
 =?us-ascii?Q?7JTRVIYzZTZvmdG+5Il5P/KalF+xt84PResSwlqHobHFzA5ry8+vIUPcd9MV?=
 =?us-ascii?Q?vHnEVK7e/24+cnPggHJ/m6GG8G+M8gtoxd5395VBFCNURrMulfk3y8+fDzpt?=
 =?us-ascii?Q?Ledg4w7sIWovJnIomCj6+0HDfGjNIhFcfgXBP6lR9RwFNQfu3/N+MhhmuqUA?=
 =?us-ascii?Q?OEw29iqhUsh7GeG5Y7CTx0SyQXk//GE6ijGLRBa2pdZuAPJpXD0n2kprg18V?=
 =?us-ascii?Q?Km74lmS8E9LSRLskCP7MBzx1hwbigJYLhXeeFEzG0j3Ntc+w9AnomeGAMRr1?=
 =?us-ascii?Q?6walHw1/Ik8pMMaY81RlHqP3UmS+eDKGxc3GAhcfCN3xWQdZSeAI56g/rK/I?=
 =?us-ascii?Q?ij4FjMHXJDhSwe03vZiIrhbenFOyfWLVt656qqB+HsYs3It2iWT5wim+qJO7?=
 =?us-ascii?Q?AhEqKrvzTemABVT3hA95y0HP3/0Dbwt4RilkBELanzM3dM751i7vhqt8/uAz?=
 =?us-ascii?Q?kP9t07W/fw9qbtWG1XDvJU2zYJInrb9eu36I67SY8sX0EGvdevxJVUNImOdI?=
 =?us-ascii?Q?KY417taOWNqsZpvubGWU1+zSUcSzL/EB/BYw/VKIk/LxH/YYM/YglT+2gTvT?=
 =?us-ascii?Q?SjeAg9tbJ7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/T+rlH+oS4rGmsKcd+aPlq1y4CfSEaVK1YZFY16nlbEwNRE4rJFKUk6uURs?=
 =?us-ascii?Q?p/4iBKTiljW97+IHon3MzHj5xEJOL2CMEwNu6MrcenHTERmmTUihBYjWUFTj?=
 =?us-ascii?Q?qoUs4LHMftYr7UILbyGlNgOMDy1BxNPkLYEdlHpkBD7i4pF1xTy+5nRn2Icc?=
 =?us-ascii?Q?v4qADk1N1vBMjtw4Qoe+Fl98C4JCiFtPKLA4ZW0dVubidHMpjs7ShLluNIpf?=
 =?us-ascii?Q?1fgxkhyBspGY+8PfjeOxydHGJuDl3Yz5bpTXeawLCbZG8GeEucRyftzKMPtG?=
 =?us-ascii?Q?A2nubz9Z1gkUFIPqBMC3hXPlDdFNufrdkqlBGZXCOgQnYjUTi3cbkIrcqWcF?=
 =?us-ascii?Q?LD/h00lffJP2quNj2w1qneoSV7eZAHJOwa4o/8KLFZmKop76npGwtAklFBRm?=
 =?us-ascii?Q?k69GzakT68F0KFaC52x+De5ZRzR/gzTUH9ivMDOetje381gs9U8+KrKbToZB?=
 =?us-ascii?Q?Ugld8reD2VDBZMGBdZQjUt0jkHAcVDmxIph9pDgNpB6dpGLtrBW2vyI50IfF?=
 =?us-ascii?Q?2p00ufZKObMjg2Iinz1ONA2Y5zE7L7HWexkyG743PfGPMv2RjCskyfqTU0GP?=
 =?us-ascii?Q?xCbcFkvMWKoDJNLT163qBYkVcFvvzd/uqdeXOcwm4g8AbL3j2Xna246Kfk45?=
 =?us-ascii?Q?q/qCWEQ+oZvfDpsKrj/iuxrTVATDXVDoSxMxoGeCPz1Ezaxjjlzs9O2wbElt?=
 =?us-ascii?Q?iusTTumlsIVbrf8laZCSd3tHfDbktcjAS+e47MSKM5vVQilnifpH7TWQzBS2?=
 =?us-ascii?Q?WG8qMZlp2MgFquTWiWUQLhePJLSrbj0XZZxyZzi0924uVs33m8lUcmH1zCJi?=
 =?us-ascii?Q?lU+B1MxysuulXVBIpyJRK9zUmvvjn4j8JqN7xfrxulPLfwS3KukvCB9puJW4?=
 =?us-ascii?Q?kDoBQrH1qWYeLy5iOQS7aUuuabUs1s+7bCQS2m+dPxbbRlZX8SjS05OljUMv?=
 =?us-ascii?Q?Jn37RZo61Tj4FFtsP4iW4lxboJLOZEdSjBEwwEHUZQ4aUsoPPow/1vtV+fV3?=
 =?us-ascii?Q?d7m2rkEX1h0ql1uyGygYJIJ3ykd35nMNX7PV+aDR+9PHArj1iVQVv6lTbUM7?=
 =?us-ascii?Q?jBtHzT8YoWciuU+P94cLXsgTt4c00BFlzUQM1zTvCthK4KsMXkSehi7nQpdp?=
 =?us-ascii?Q?yrl/34ZU7fVwbbAsEa+xkmUcmmCno5f4sfbcvbnsO2Jo6TLigkwwESxQlo2Y?=
 =?us-ascii?Q?C0e9dv/fUe2WTfKRIaefk39fm3lQ7UGNox39NOJhSN2mH0jTk5O2W/A9ABmm?=
 =?us-ascii?Q?7ZA1evCmF5/ZhtL2e83lwEKhHy78MLtkyiM9H8nbrARVl3AMKCqnINYo0Hdw?=
 =?us-ascii?Q?75EOh9ZAE847JYB/ebKo3Kd4kzkAG3NyGUJae0ZuLDzMx5jgzgMO+a24pXD9?=
 =?us-ascii?Q?ncNBz0gyTi4OkWzb8Dx0AM6DDrfnLF7xVoiOmDxx1/aE9n08b7uRZELaF8EN?=
 =?us-ascii?Q?Qh4cenCVuHHq4/xkKGHaVB45bh/nD7aLt44GhfShv20psBsNUByd925Fe0B/?=
 =?us-ascii?Q?VNh/iRoQN7wcQHo5zhfJIDZriP2rNuCHZd01GazvNDzWBs19YYnCBsb5Wy4V?=
 =?us-ascii?Q?ZclfGppatFa16HN2dzClNEKMV7GrAVVvW7d0wlJ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fd8f20-72f8-4e74-2aee-08dd81b85685
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:11:28.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mX93tWqg/ZjU57HmJay7zFI/iFLGNE3YXub68j544v8lFMz404JsfgnY9N6WXVR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
> Hi Jason,
> 
> On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > > > 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> > > > > CAP_NET_RAW) 
> > > > I believe this is sufficient as this create call happens through the ioctl().
> > > > But more question on #3.
> > 
> > I think this is the right one to use everywhere.
> 
> It's the right one to use when creating resources, but when later using
> them, since below you say that the resource should in fact be tied to
> the creator's network namespace, that means that checking
> current->nsproxy->net->user_ns would have nothing to do with the
> resource being used, right?

Yes, in that case you'd check something stored in the uobject.

This happens sort of indirectly, for instance an object may become
associated with a netdevice and the netdevice is linked to a net
namespace. Eg we should do route lookups relative to that associated
net devices's namespaces.

I'm not sure we have a capable like check like that though.

> > Even in goofy cases like passing a FD between processes with different
> > net namespaces, the expectation is that objects can be created
> > relative to net namespace of the process calling the ioctl, and then
> > accessed by the other process in the other namespace.
> 
> So when earlier it was said that uverbs was switching from read/write
> to ioctl so that permissions could be checked, that is not actually
> the case? 

I don't quite know what you mean here?

read/write has a security problem in that you can pass a FD to a
setuid program as its stdout and have that setuid program issue a
write() to trigger a kernel operation using it's elevated
privilege. This is not possible with ioctl.

When this bug was discovered the read/write path started calling
ib_safe_file_access() which blanket disallows *any* credential change
from open() to write().

ioctl removes this excessive restriction and we are back to
per-process checks.

> The intent is for a privileged task to create the
> resource and be able to pass it to any task in any namespace with any
> or no privilege and have that task be able to use it with the
> opener's original privilege, just as with read/write?

Yes. The permissions affiliate with the object contained inside the
FD, not the FD itself. The FD is just a container and a way to route
system calls.

> I was trying last night to track down where the uverb ioctls are doing 
> permission checks, but failing to find it.  I see where the
> pbundle->method_elm->handler gets dereferenced, but not where those
> are defined.

There are very few permission checks. Most boil down to implicit
things, like we have a netdevice relative to current's net namespace
and we need to find a gid table index for that netdevice. We don't
actually need to do anything special here as the ifindex code
automatically validates the namespaces and struct net_device * are
globally unique.

Similarly with route lookups and things, once we validated the net
device objects are supposed to remain bound to it.

The cases like cap_net_raw are one time checks at creation time that
modify the devices' rules for processing the queues. The devices check
the creation property of the queue when processing the queue.

Jason

