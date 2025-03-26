Return-Path: <linux-rdma+bounces-8981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEEA71B0E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827A016F00F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926AB1F416B;
	Wed, 26 Mar 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZ24Edpl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882701527B1;
	Wed, 26 Mar 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004208; cv=fail; b=ibg25AbA+vMpkU8mL6Zk70C2dQuJfIDs+yP/XxwZIQBu3OB6xqJ85dm52MO0ANSNiNTHV2OYDIs4xg7seZO0IL5uZFjUNa7tjM4bhYFBw5340kdvFRackHYzpu+q9LSx7tto6/ZjniEq23xkyiH+Zdfsdw8vxTlL//GsET/Hj78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004208; c=relaxed/simple;
	bh=yhRM1CtjNrcs91HDco6FhTe8F9JqTdPWuDk3YeDaois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jElySvF8JaG6sTv53e8MtwnAy7zahszlbvZti3fvxqY93ngnULEcKmT1U4wf8Dg09YuCMUG0x5lDEyr2HAUdiycx2JpowixMbufrv+gnhSGmCmxFay/Gwk6psnFcw7677DZC6ORGevgYxpYj5PO0/M5vZLOsi9U+CnZLKTe3gzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZ24Edpl; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTkGI6HUdW3MZE2ZzD/6mW2KkrIvaUKJNlvJltx0ylBMww/jsmgy754mi2y3EelLZmam8FdsBBTBwT9CxId33b/zp2SUaLoA1HlfrVcRJ5vh9/DkyoO99YO3xtozMjUS8ro8f15n8yRCeeHGqwZKfMUXuDHonrx+Nrir45cg5WJqmZMFXl0N66VUuX7ly5eqonIEunJQB5oN7IwYLJ/zgi0OQkyDM7kr0XQyEqNyIXekyvNKmn6P3JnrX+ta6GDCH0UNOg9a6cstZIg2bD7odl7r7FhswFcDSuwMNE7KaWx4wwHs8va6ar8WfuENKFM1I6aTH9f+bdfc8WvyuOKtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkNLFTMikD+Pho9Iz7T191/n2Jsg/uuJsrqJ6VSUFJM=;
 b=yFeE1aF+T5K/A/AFrMEGFvKc1Kpada46+B1wHnU9xsrelPkvWAMWIGX0hjFxsTOZrkLXzCIzh1GYdFkD0vAfN3P/ic56JoxQWQrgCHXN2L9qv44qWZm1jorNW/FCPY3x9Lx08gl3xXB6Z9w62ErFNbEd+ICvfhIDKAoMztdsaz2EBJ8Ntd0bN+OTvBofXriolAp0d8xywDN1thr10Rb0A3PCWSzU4/8YFiC5NgmjLM2SU+DShM4DIddDgVLy0MDxnWFOfZiLXzxS0dXDw1QejRzu8tvdRyPVnK96NmHpGkRi+T2H6nBCdtXAzqbmVK9aX2iQg8XOsmtbZeI2DpYlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkNLFTMikD+Pho9Iz7T191/n2Jsg/uuJsrqJ6VSUFJM=;
 b=OZ24EdplcQU4nOEBHUJbOqRoxGJd6mzC3O6CLchsDVaNI3u8A9uKoP43wM9Atf2zSxaqsjFMdb45oyQ+s20mOrgxSSmZOwgBxmk57ev6KlPc7glay+cY1+dJ9ATaZnELfVOqTLPzB9OOU2bsA76BYC0fo9HQJ7OHEeeO70ZKT8FtG4fOhGcwjCU8XBMyovebR0nj+NL1jRwRI+u4J1wWE7/w/V8hgqMS5SKtunL8M3bsvH6vIpWjr9YrUVMI+PRM952b4vADc8Y0BTaCylec8YxQQFLe+QYPMTUj1R6G5hCDFwfxLxcNaUhn1vdawRqVTb/FY2flct/zck4SAzxofw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:50:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 15:50:03 +0000
Date: Wed, 26 Mar 2025 12:50:01 -0300
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
Message-ID: <Z+QiKan/j3UIhwL1@nvidia.com>
References: <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com>
 <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
 <20250319191946.GP9311@nvidia.com>
 <CAM0EoM=7ac-A=ErU_PojZuuB4eHnoe-CdPxBi3x9d+=PxikfgA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoM=7ac-A=ErU_PojZuuB4eHnoe-CdPxBi3x9d+=PxikfgA@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:408:ed::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 568bff53-4d0c-462f-fb93-08dd6c7ddf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9CRW8+KO5hmZ57c1m8OfzfTLwmFkJgAXPdPSbEkMT+LQP6LREl4lZ1Aera6?=
 =?us-ascii?Q?dn45DTVLz7FOXt+wcjpacznmJxRBoyAYOnHFSOgzNQTy8EtOsU5eFf1vmTBj?=
 =?us-ascii?Q?nmcy+Rm8RbJDv+HQdMbctqJSgF3rptOBQf8/szHKePim+IkPiLVthKIfUQoJ?=
 =?us-ascii?Q?i0qn96+pH8x7wWNL0O/jMSih0LKYCNmd1LIJKuPjP0QHdCsvooP0OY/rfVa3?=
 =?us-ascii?Q?UdmRbGw26RTJ+ypHsd4Tt4/u7nCX89siH2nKERWqjVU5hAFyr5CkCh2QJ66L?=
 =?us-ascii?Q?9fGqMaeXZBfqkPOfbiUrKtjOEm+NChUih7gxhi5hU7qqpbTIIbuZwUAL+uGx?=
 =?us-ascii?Q?+7JX0IrGTmq2PaVyhaW+YzMY/P3emCvU6P7uQQfH7qAOh+0oa0Xz1+l//v9u?=
 =?us-ascii?Q?YOQU04KF0sfbhZfAYYKwXL9KFelUNZ1gZJNRR3xbQL5BsEnzTJx0NR/5hOSM?=
 =?us-ascii?Q?xYkO0jmGDocPRRFUZ2X8Amc6XgbuOHo3M1uQSIT6cW2xPvYsQvtm04vwmvB1?=
 =?us-ascii?Q?UIUASkByHM0sT4/H7FhEVBvByWQUqc/EXo2KGns4e+9oUYqf92Li4E1TzpBP?=
 =?us-ascii?Q?0VgUtGn5NATUI2jrB7FZRh+7dcp2WeGcf9n7w5sxDbY1u+ngfTV5H8yCgb+T?=
 =?us-ascii?Q?lWX8I7qYSBfUt9aco1cdBg8DQ37vdL5KOMlCgQDh4TtS4tqgZPfzc9r9coel?=
 =?us-ascii?Q?tbwdE7wQXw1ORABBNCt9TO1p4TqocYcyqcdOomjX90yGRYRZeYZYsyet1rNh?=
 =?us-ascii?Q?Hs3wu93wdbniGLQv5OMXcQ8235sF5QBGSreigre2pq8CyALsrn0hwRf2JLOz?=
 =?us-ascii?Q?49UrpBKmTEDb8nzWyupTSDKtveTBoAbGcTauHLBKj5pCn69qO/cqwsTk3L+I?=
 =?us-ascii?Q?CsKpCFL+gmAEDecEiIHb7hliB3peYLloYjTDXdmSjI4WB4UxURjwXw1ebIez?=
 =?us-ascii?Q?R9/BK1wUsFCJzL8ENaL1GWv/4wkyGx9yVBEX0bMPF/ou2FeAuY/O1oHxb8B1?=
 =?us-ascii?Q?PfF2uzZEqnwBE2TyeAy0bOutQrsa+NpIuNvJnv4UYsqQud6Rvqu3cU1Lp9wx?=
 =?us-ascii?Q?yp1fMmLE6FPQaJlW4xEY3/JVS7cfO+WZ8KgTqL0HOrnsmu/c2Yw92ccFwerB?=
 =?us-ascii?Q?DtVKVtfit77RboKTWe8/yeYiIhutChAZlTbb0lRPzK0bd+6bD3VRmT42shpV?=
 =?us-ascii?Q?UxVVaP1rQXAwEwzM31WwsAZxp3b8tNzJh9i+abDN6xRYXZVrWoNusWsuqLJm?=
 =?us-ascii?Q?HlJvjyrwyWLTqRwIl9jocVXb5u06inONwPYSFiUvYkUprZbPc3MgsL1sWAkt?=
 =?us-ascii?Q?SxrxK7AnvA3GqEp2HsQVPGjQAeFPDfLmN3zwWR+YFpRbuHTw9eQhwMi7m455?=
 =?us-ascii?Q?TbZdTJlLIfIu4kXzi7nt4Cd+JoNI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5Jrj0RSCRvCT7C02TjGwMd1VpdhKAFtZzvLjpNCAabg/97miM7U7+4MIsaX?=
 =?us-ascii?Q?+tmA2Dovje3ciI4E5JU9/Ygfasd7dhf226Kx/QKXib1YurT83IgVVLKZD5bS?=
 =?us-ascii?Q?jaVKWQre13IQfI13k4pmHg5/l/mxynjWIJGmTVO28xZXZnz0fSoq9MUG7Pbq?=
 =?us-ascii?Q?Ji/gy33YliUEOIF4hkZ845yUiCMO+jlfSIMTVCOh6xfVM+MtALxg4TRG6iAX?=
 =?us-ascii?Q?Np1mxGvX6/mJizMFBIBWTRLLuwHnPMrX58+A99mBssQSeBwhAkAeFbeG+iH9?=
 =?us-ascii?Q?UHg5tynHolLXC9LFGmPw2JPS6AU4mkhOQFsmxx4IzTcfB18VWDCY5i9iUOXZ?=
 =?us-ascii?Q?FRALRix10AUiEuKa7YWPl3qYlHLa6MyxCSz80eIyjs7oxGVi9p0u7hMDPIg8?=
 =?us-ascii?Q?6WkWl+rR5NK0OP4vyQjWcJycWmGAa87lVTFUfksHJ0Bnc2YSntj4etqv6djd?=
 =?us-ascii?Q?qus9CTVJckgCW6aknaA2Xt7p8tMSpExKfuMuJ1I8Y7sE7Xg4PKUjh2YA1OeF?=
 =?us-ascii?Q?xN8CdXfg2Osfs+6FIH5Wfw6L7Vc7yqQafpc7ge9uwZmhNrAjBQKfuYLx41rv?=
 =?us-ascii?Q?zdzCwpLRaU9sUAp/2lQUuKIR9zxIiU989MPNdiIb7abXoenxyMGDwsnKaIHa?=
 =?us-ascii?Q?Xwu1Ah7h41cxVRGD8X5s+0w2bCNTPqFqS2j6qTuV+cDWwsSaVXNWgucNjIVG?=
 =?us-ascii?Q?Y+Rs3eMntHrCt6ZSa9Eyys3vGt8UgdgV8rujOUHsLMgLO+HKBy6+K/6ABVV9?=
 =?us-ascii?Q?vFTO0ZwocZhBjt28f8QgI4xsfJruGNTGo2pEDE8+IfAqpu6rTdW+15gsjHQV?=
 =?us-ascii?Q?VqfXMjQHQJBDb1aSY7gufF1/874lC2nYJjGvAbO/5TmT77DYtyfjERH4iIiZ?=
 =?us-ascii?Q?jVqTGhhAzX/Ok5S3c8Nham2q49z30Q3cY8Y2UfW3zWlabZPOhZZZ76RTtjkO?=
 =?us-ascii?Q?blhfQBsw8vF7P/KSqohWirQiM7GXKz7nt65PECXLF9qU9w3buLnfKDPxbrAU?=
 =?us-ascii?Q?WSs2rDDXDpXBHTy3qV/FXG33jqe64rpJijawiUq7uxwE1m8uIQYcbscx99K0?=
 =?us-ascii?Q?Dm88D9lM64dx70Rd0/4Hz4dpkuKUXvM/+yqMZIheVwOy4naDaCy0GV0KNaI9?=
 =?us-ascii?Q?1T4bGpkTXNQxxOlSrtibuHpkWj9kyQBNlEInbqEhxQv440Jt/uQGO4hjQiYU?=
 =?us-ascii?Q?QEeALepLJaJizLzJu5catvbYRmmwxMCSWn/Zmt6LflyK4kYAigoN77Itz4v9?=
 =?us-ascii?Q?41XhjkSWv0D2kP9UW7suw4zQksNWJ345BlxbEjQQoEtqfj/B3nr98fMmM+eX?=
 =?us-ascii?Q?dNlL7No5IglPWe0LLRB3FDE8ZZLA9xYEM6a7RWlX6yiR4sw+q5/WjySniv2x?=
 =?us-ascii?Q?qgBOpWzn5yvyGUT97X7jqOl7zutgWI5SyM0iUD24GYrTN2KqgyhDeLf7ljoV?=
 =?us-ascii?Q?95uFWiCOeRFnnlnqL4KfnXh2jPsCOlR2YxS9ZD0aKysIS5S8DYjYTOtOuaYN?=
 =?us-ascii?Q?WWh2Q7NpsEP9Xvs4r1OLhLGvvmc2Dt1B9UMtu5vmiuH09rp3lSdgvkH6pale?=
 =?us-ascii?Q?ID9lXaNARRBEZnweCzY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568bff53-4d0c-462f-fb93-08dd6c7ddf1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:50:03.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXKmjZfOP9fgdOMuLHoHxrMy3zuDG9FEulaehAE6kRAX40vvgiN1Z0Rsaowksx2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

On Tue, Mar 25, 2025 at 10:12:49AM -0400, Jamal Hadi Salim wrote:

> You need to at least construct the message parameterization in user
> space which would require some memory, no? And then copy_from_user
> would still need memory to copy to?
> I am probably missing something basic.

It usually all stack memory on the userspace side, and no kernel
memory allocation. Like there is no mandatory SKB in uverbs.

> For a read() to fail at say copy_to_user() feels like your app or
> system must be in really bad shape.

Yes, but still the semantic we want is that if a creation ioctl
returns 0 (success) then the object exists and if it returns any error
code then the creation was a NOP.

> A contingency plan could be to replay the message from the app/control
> plane and hope you get an "object doesnt exist" kind of message for a
> failed destroy msg.

Nope, it's racey, it must be multi-threaded safe. Another thread could
have created and re-used the object ID.

> IOW, while unwinding is more honorable, unless it comes for cheap it
> may not be worth it.

It was cheap

> Regardless: How would RDMA unwind in such a case?

The object infrastructure takes care of this with a three step object
creation protocol and some helpers.

> Not sure if this applies to you: Netlink good practise is to ensure
> any structs exchanged are 32b aligned and in cases they are not mostly
> adding explicit pads.

The alignment is less important as a ABI requirement since
copy_to_user will fix the alignment when it copies arrays to kernel
memory that will be properly aligned as required. netlink has this
issue because it bulk copies everything into a skb and uses pointers
to that copy. The approach here only copies small stuff in advance and
larger stuff is not copied until memory is allocated to hold it.

> When you say "driver" you mean "control/provisioning plane" activity
> between a userspace control app and kernel objects which likely
> extend

No, I literally mean driver.

The user of this HW will not do something like socket() as standard
system call abstracted by the kernel. Instead it makes a library call
ib_create_qp() which goes into a library with the userspace driver
components. The abstraction is now done in userspace. The library
figures out what HW the kernel has and loads a userspace driver
component with a driver_create_qp() op that does more processing and
eventually calls the kernel.

It is "control path" in the sense that it is slow path creating
objects for data transfer, but the purpose of most of the actions is
actually setting up for data plane operations.

> That you have a set of common, agreed-to attributes and then each
> vendor would add their own (separate namespace) attributes?

Yes

> The control app issuing a request would first invoke some common
> interface which would populate the applicable common TLVs for that
> request then call into a vendor interface to populate vendor specific
> attributes.

Yes

> And in the kernel, some common code would process the common
> attributes then pass on the vendor specific data to a vendor driver.

Yes
 
> If my reading is right, some comments:
> 1) You can achieve this fine with netlink. My view of the model is you
> would have a T (call it VendorData, which is is defined within the
> common namespace) that puts the vendor specific TLVs within a
> hierarchy.

Yes, that was a direction that was suggested here too. But when we got
to micro optimizing the ioctl ABI format it became clear there was
significant advantage to keeping things one level and not trying to do
some kind of nesting. This also gives a nice simple in-kernel API for
working with method arguments, it is always the same. We don't have
different APIs depending on driver/common callers.

> 2) Hopefully the vendor extensions are in the minority. Otherwise the
> complexity of someone writing an app to control multiple vendors would
> be challenging over time as different vendors add more attributes.

Nope, it is about 50/50, and there is not a challenge because the
methodology is everyone uses the *same* userspace driver code. It is
too complicated for people to reasonable try to rewrite.

> I cant imagine a commonly used utility like iproute2/tc being
> invoked with "when using broadcom then use foo=x bar=y" apply but
> when using intel use "goo=x-1 and gah=y-2".

Right, it doesn't make sense for a tool like iproute, but we aren't
building anything remotely like iproute.

> 3) A Pro/con to #2 depending on which lens you use:  it could be
> "innnovation" or "vendor lockin" - depends on the community i.e on the
> one hand a vendor could add features faster and is not bottlenecked by
> endless mailing list discussions but otoh, said vendor may not be in
> any hurry to move such features to the common path (because it gives
> them an advantage).

There is no community advantage to the common kernel path.

The users all use the library, the only thing that matters is how
accessible the vendor has made their unique ideas to the library
users.

For instance, if the user is running a MPI application and the vendor
makes standard open source MPI 5% faster with some unique HW
innovation should anyone actually care about the "common path" deep,
deep below MPI?

> 1) I am not a fan of the RPC approach because it has a higher
> developer effort when adding new features. Based on my experience, I
> am a fan of CRUD(Create Read Update Delete) 

It suites some things better than others. I don't think semantically
update is the right language for most of what is happening
here. "read" is almost never done. Like socket() Fd's and it's API
surface isn't a good fit for CRUD.

> - and with netlink i also
> get for free the subscribe/publish parts; to be specific _all you

publish/subscribe doesn't make sense in this context. We don't do it.

> 2) Using C as the modelling sounds like a good first start to someone
> who knows C well but tbh, those macros hurt my eyes for a bit (and i
> am someone who loves macro witchcraft). The big advantage IMO of using
> yaml or json is mostly the available tooling, example being polyglot.
> I am not sure if that is a requirement in RDMA.

I agree with this.. When it was first made I suggested a code
generator instead but at that time code generators in the kernel did
not seem to be a well accepted idea. I'm glad to see that improving.

> Again, I could be missing something but the semantics seem to be the
> same as netlink.

AFAIK netlink doesn't have the same notion of objects or having the
validation obtain references and locking on referenced objects at all.

> BTW, do you do fuzzy testing with this?

syzkaller runs on rdma, but I don't recall how much coverage syzkaller
gets on these forms. We fixed a huge number of syzkaller bugs at
least.

Jason

