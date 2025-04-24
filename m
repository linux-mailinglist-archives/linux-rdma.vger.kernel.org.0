Return-Path: <linux-rdma+bounces-9776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E507A9B066
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561A87B1A4C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D127FD72;
	Thu, 24 Apr 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umxpRsoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5371E1308;
	Thu, 24 Apr 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504037; cv=fail; b=sSQx++DMOpUijQ1/dLOlX5JUyj9K1qIftUP+w5Eu/2y7lGgbhcyycQCYHqaOzXe2VQGFkCs6O5DaZEiF7lhBrGMzeffPJ0C20fdO7u7hhK6CzkTsIvuZSzl7CU1kmKaZyJwm/4OMe5/Ykd52gYePMBs2NG73pCtf4nP+sP/opHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504037; c=relaxed/simple;
	bh=gumeF1Xg0v1FZfsu8yC++3xZtzX11m11T49EZG7SAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Im1Pkm40CGcIompPgTvLcq3i7sV4z/qetRk29ikwDcUzFVd4anqNmdiIbW4vo+chlaXtRJ1ezgP8Sk2N7452Sk8uHizwLexCKjYQNJzn6oCUSV85nrCg5Ec7bmA0asKVlKsUycEtRuU+j3C+sf6IglGUZPerYcbHlLESUzJayh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umxpRsoL; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVft2Lj/A317xxuczvU7rW4BR6W85hXjocgbDOAIU0cvsY5ylVVh0my78uOywi1yAGjD1x96ExlMQZ/EZ0WG+PXBvyaC/91oerkgTbGkzGCi2X1l4W9RcQx8psWZ2opwsqLF5dyVkzA4oenbGdSlM5VfOJ4bVkgtllwhVOb9l6eK4f0sSy4yvuEtIKqPJp5bUwB6yJeEUrLt+BfFyALr/WxxM9XruIUyhzJ2r7JfzJ417NqZlgnIy28xxtdubyyKyEdTCy5FFlnA4+oTEfm9mfmuf2/RFKheKY8sMUsFoBIcjHD/VmuBsSCMDf0mIIYLNjtgGkcRT+hqe+iMdjXj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkgl7H8hBXqiYDnpJR4guVUHni+L77B0smwm0OWRtXw=;
 b=eZYFE4hx8pmGcbbQPkP8hYMFIxtHQrncPzq5bEolsir13/SMcNECNAeHeRhYMM19q4Z7Zk7caxYkQHQQZSsp4E8qyhGFFDHkERq0mremdxi85jL0LsUpJoMhvwug7asqoTBMTdXsrV1RtpnZXr25i/VSpjlOFE0pMWhYsjwYKgvzHBHl5rsM/95FjBCag9DwGazdYxqnklFsYeyiTL5IVLbYpjkgBNnwIxeFsqvAF197TosQPm4X1+e2mhlCjes4SsrqHlmpf3bEq9WEagk3jbYGN3XL+hDcSJBRWW3at91VkGRTmTjXcWvvxaXfeAojFCZ4pCzyoh4n5o7hnrWzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkgl7H8hBXqiYDnpJR4guVUHni+L77B0smwm0OWRtXw=;
 b=umxpRsoLVuuUw45erdhJYA7e15Dg9CQIOc+88O6Hr+osOVn2fcx2eztO1Lfq+KRZk/wTmgwqIwPHyFh3oIUDCtVCi+DMDZTaxR5qaf1VVVw7ltlGHlwIixMO3zgN+IN1eu39vv7MvkF+/uucO4RKG+GturPS0vnUJ7Zvv2xnmIZ/IqQ92q0aXaPE9htituR7Yblrchjh/2O+poBbyJdl2wfBt5RKzhCsCGpUxBMz7e/teF3Cv/coH/QmCUGUtPLXSRCofoz525gmRcGUxjMA+0IkPrqhU/1IKkyx4iuQtntU2Shw4SKzvPBux6XmGkzD0Nua39qlbZMDK0lmc5apRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 14:13:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 24 Apr 2025
 14:13:49 +0000
Date: Thu, 24 Apr 2025 11:13:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250424141347.GS1648741@nvidia.com>
References: <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN8PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:408:c0::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: e9974616-c8f7-4fd0-020c-08dd833a3b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R7dNzPCTmoknQQgTOoUFxMNsvYbxuXTnlqwK/DqkaI4tQe8Jo5cJplp+1rAJ?=
 =?us-ascii?Q?KpRW4S7x4NcBy6YSI6x+Mkj9fc3Xu/f1gMAS+XO8+yYJJa5Pg2nkNX9fDNlC?=
 =?us-ascii?Q?J7l59t0msuDqQjtqXWQr7dLtQV9c+wj+q0Fktzmm+p+QyL47JiweYD/Z+5ta?=
 =?us-ascii?Q?J8t1PVlRvrqUaZkJ3x0W6aqUO1SQ3CW+mQmd7lUPvTq6PFpeEObcoDqTHzmv?=
 =?us-ascii?Q?R7xLn5y6XgZrtESj66UcEyUbR7ud/0mKyeoRDExNQB0YDoDqw4LGo+tsFoLh?=
 =?us-ascii?Q?KJmq4xqSgHJ7kZeGxvx1j5Zqk+3r+Lul2j/zplCb3MPUS58wwv7rPTGCqFJz?=
 =?us-ascii?Q?vm81ESsJGiYL8pHrJDVqowU3rTdwsYkz0U7ZMI4Wns4arxAlQRL4F109nVKr?=
 =?us-ascii?Q?wOlm+nTC4YPKYZYSRi1g2qw1gNcFGYQWp8+LoneQmPUYX9GSQfOwjyHbFo97?=
 =?us-ascii?Q?s+1iFD6h2Ecl5sRaPT2db1Z1MWgghteYwMh1ocw79H0a67wWG6zuHHxPV7oC?=
 =?us-ascii?Q?GJg/xFEH00qn1vBABtwzRiFM52mCpU5W6CYHwQS92gFpapmSvC5fTvgOfGMI?=
 =?us-ascii?Q?5KoCbLXMvt/3zSCzV0zsXbcw96zetPi0x6WLNcj8uHibN7l+APqq4Zu7Eb+v?=
 =?us-ascii?Q?maICEQ9TsFnN5iJICa85Vl7ojiqi084tyYWCvFAZDTQnsUEU6MA17hJbVMaf?=
 =?us-ascii?Q?61epKSAGEgTLdUZ82rwFKOaLF7w6oUSMvcBjthM6H+8ha0r3392R5rzlZzX5?=
 =?us-ascii?Q?E6Cj7L9BZSm9eryM5tiu0oNRHs1honNBvWnRinq9rBLYU8WvdhVBthuLc1R/?=
 =?us-ascii?Q?L4vKrhxHbOqHObnY+yxmLDAIQGzDV2AhP3BfP1JZoysrC4RS56qC8jXBJk6f?=
 =?us-ascii?Q?RKowDYXDnvghFBscUjRDRqeXQ3Br6CA788UFGBZZvO/UFPxeT3p6Vhs21Ee6?=
 =?us-ascii?Q?VDQEQILg5GuMrKmkB89HxR5rzcRsW/U5scJ5XxpwvbXMfKd0DPn5QjaWFA0x?=
 =?us-ascii?Q?T9W6I0g5I8V7krYMO7biD7lngjbN9tdQJMegkr+ZD/AxUj0GT54lvRgRhiSD?=
 =?us-ascii?Q?GAQChIS1D/KwTXksv2XVusGbXPwxhSwf01I0pIFSzgy716KmNizPGZRHxCer?=
 =?us-ascii?Q?LzUuw9WlFlnt5lvq2M2LcIaOObrDkMbNryxz5SvDnZcIcTGT9ua2hemN9p0+?=
 =?us-ascii?Q?jj4uiHDQByoNbZ0aoU2z8LX9cKFx3Xn9LElMCIagGLxhK+Rf8ZCXrM4TRDkn?=
 =?us-ascii?Q?y/Bu6K2SsGvwEyuJlkwyYRvQ5HrxQ3zCUPDaveYSEeR7fIbQhbsAoy2H4ps6?=
 =?us-ascii?Q?669vQWoztF3F/9wul0xLvZIMNOVO/wo2UCnvrpTYIa+OM86iodKs2fCvDIID?=
 =?us-ascii?Q?aUwUmFCbY7ucGSgFYsvZmX7567uz/0x3GHHz0hWFSllNGMmR0Bw1QlncHowM?=
 =?us-ascii?Q?IUWot9n8IZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75ba9CMO1K+EbLHZjYz8Lih3fW0cwaky3LHsmLeAZtfdx1lh7/G8FmL5kPdF?=
 =?us-ascii?Q?1gmqct3nxK44CfOYUkfgxhJuo5jvQC0gQv+oN1lEe9t6f7j9kqRKaZkeiuQm?=
 =?us-ascii?Q?MugDIBUmbER9bzk+1BjrEFq+8U60kez9oJbdBAcTRggs4xa0SPAurF0nx44o?=
 =?us-ascii?Q?kvQ7A+NIsNV39mgFMxFhkrZYGziDW9EgAoJDU92uEQCrNqjbJMsN3mktNhuZ?=
 =?us-ascii?Q?T/0XV1y+t4wkoZCfvqd7M7EBCA1eZBkMtxy1ZNkgpJNlbQC3x1BQwBjRW3Rj?=
 =?us-ascii?Q?4wsUs+yDhhQls5eYhqthrMqvrynLh3MGs3XbmoUoReQIiO70sd3545Mid4we?=
 =?us-ascii?Q?9v+vvwA0egD+qI24fS4GM7EKYULOPitTvJJJkqbPL8RFcEjkAkoBYD+8eOmu?=
 =?us-ascii?Q?wSo3i8h742IhBGQFlXijRUG7V/qM7kN1/9oAQSDtZSi+qxbf7BhFpQqLXAqv?=
 =?us-ascii?Q?7fL6mZf2HPZ1I2ELwEYpHzGYZuapPESyl+QZXfIUagC9ttn64SsfMSj/90t2?=
 =?us-ascii?Q?G89IccggYFjLnqH2HxPMpIG2pNtVdC7asuBs3Zdxt93fa6N2B/MvpqZlop0O?=
 =?us-ascii?Q?stFAe6SHg6Wu0KIRd8Qnz8yz8W23AJUgYLwYAxlOPrwq8HoqWMcGye8cUugN?=
 =?us-ascii?Q?rhevE3FJez1j0vlqWW2AKr1MhBNYHRtm1zJoldkCwuIcAnX7zsdBhbtbQsA2?=
 =?us-ascii?Q?xq0vZ4CMzxMBI/shvgeqj0ppF/vprxhEfuIuHTPVfug6sXbFc2/JJ22Y9sRs?=
 =?us-ascii?Q?oyHm438TpFcDM3V2RLIy3GufWTbcSlvB8jmHYnh0qYsXP+dwH9YwdBVYgN4H?=
 =?us-ascii?Q?JcBXJUg9Ezcxb/9N2+JILLnOeFA4KHA9I9RfQdJCflLTDlaOqERxvvDXqU3a?=
 =?us-ascii?Q?IbsTIfrcOUNRm4RVL0b5v1M7o+ucK4X/rXqhbgXnuGfJ2HTnBStLWUYjL4d8?=
 =?us-ascii?Q?A+SiZhAmFjLO5+saqKv/+qpjF1j2fDbDGf/94rC4+w0dQKp4XRgunTFJbsfd?=
 =?us-ascii?Q?kzzqCVK2txyluzz1/V0H8n6ZhZcxolujLKVNxnOtwmUbvo+H8iY15LbtZYg6?=
 =?us-ascii?Q?Qx361NX5UHi8ovkPXXqioHnLQFTq66vPVrRZtkRtMOpwn/MLFqvXuvNim9yL?=
 =?us-ascii?Q?Y1VBBTj6znjoPZdHeZ6BQidjAZEBQHtlBMOEMLIU6e+HN2fHJEwF+YRcqufV?=
 =?us-ascii?Q?6UHN9TyidWcAKNV2Qi6YL/R0b/chL4ejcI9cYpuHbARaBYgkgaVLdD+XVXP8?=
 =?us-ascii?Q?c/10RvLtXSfPsVwP9g6LJT33ZNlPOMR+BnhpDTJQjaRDEsSRW1CsarRcyTjd?=
 =?us-ascii?Q?7gA3It9yRMAizG+RRK+uzMPUF3wHwq9Z21C/bhS6GcYE7C9RS1bb8ZYrV9HZ?=
 =?us-ascii?Q?0j09nMdt7CW2pqKp/59pkBRypc1H9fT8hZxLflBk0BxFze9/1C/RH93vIo3h?=
 =?us-ascii?Q?+Ic4de0FAyZz26kR7FQiM9LoxYTIa/JjYawgylZWKxTMjXVW6DTdl0MFGbnh?=
 =?us-ascii?Q?cVEj2UO9D07nXIHGtxmc0mPwv9EEtrjobq1OtFxSHwpz2unByPFuNdztPCAV?=
 =?us-ascii?Q?QGSq7Xz2peF0b8SnZU2ZuJ1NcFTYD/FzDlybeLiW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9974616-c8f7-4fd0-020c-08dd833a3b84
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:13:48.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgHnle2f/qk8bzKpZ0+HH3Pijtclk+/FTrhQnJ1zw1HyTq226pojLuzKuv5wpaY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

On Thu, Apr 24, 2025 at 09:08:17AM +0000, Parav Pandit wrote:
> > Since ib_device has a namespace and ufile is tied to a ib_device, can we ever
> > have a situation where the ib_device has a different namespace than the
> > ufile's? This would mean we changed the namespace of the ib_device, and
> > IIRC, that means we revoked/disassociated the ufile? So the answer is no?
> > This means #4 and #5 are the same thing.
> >
> Right.
>  
> > Can a uobject affiliated netdev have a different namespace than the
> > ib_device? 
> When a uobject when created, it is not affiliated to netdev.

I'm asking about when it does have a netdev. When you create/modify a
QP and give it a gid index, for instance.

> > The netdevs arise from the gid table, and the gid table population
> > should strictly follow the ib_device namespace, yes?

> I wish it this way, but unfortunately, rdma still have ancient
> shared mode for example single rdma device + macvlan.  Until that is
> deprecated, let the gid table entry's netdev drives the QP modify as
> done today.

I have been ignoring shared mode in all of this analysis. I don't
think you can make sane statements about container security in shared
mode.

> > Can current have a different namespace than the ib_device? I guess yes, the
> > FD can be passed around. However this would mean that the FD caller should
> > not be able to get any gid table handles as none of its ifindexes will work. So
> > #1 is != #3/#4/#5
> 
> Well, it can pass the fd after the ifindex is resolved (i.e. after modify_qp).
> If fd is passed before modify qp in different net ns, its can get access too because rdma device got shared.

That's all fine. The uobject retains its affiliated netdev.

> But that is the case with raw socket too.  The difference is, every
> send() call checks the ifindex, vs here its checked when raw qp is
> created.

Also I think fine

> We can add the additional check in the sysfs and in modify qp, but
> very long ago (2019), we envisioned that users should use only the
> exclusive mode.  And hence, those checks were not added.

I think we should ignore shared mode, it doesn't work sanely with
namespaces.

> > What other NS users are there?

> Incoming rx IB mad packets are looked up in the GID's attached netdev's net ns.

Ultimately a GID index should not be delivered to a userspace that
does not have that GID index in the objects affiliated net namespace.
I wonder if we are missing some validation here

> In-kernel ulps (nfs, smc) do not seem to have the interest, but they
> do not created uobjects nor they access any uverbs fd.

IIRC we have open issues with NFS/SRP/etc and namespaces, the kernel
ULP doesn't have a way to use a namespace?

Jason

