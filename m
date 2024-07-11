Return-Path: <linux-rdma+bounces-3826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878892EA48
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24A728164B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB916130C;
	Thu, 11 Jul 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOyrviyZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8812EBCE;
	Thu, 11 Jul 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706882; cv=fail; b=j5l9NnVBxEW9mKtD81T15gny9ZoiNfcg7RBiNTesCRa4bPxPlyjw8ZnpFLKdq3Xx7RbvepfEI4RwlJo/Sf9BeSsUU6OvhcMFIM79COC3GMuxgKwrTt1/5Mmy2REENitXo4r3uKdyD4SuDBDjG6Mq9F6HiARJ9LfX5Au42edKO1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706882; c=relaxed/simple;
	bh=dHyZhgSUOU24a9o0qa+QqtVj3syIo6BRNXxpkI7sQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RQ5+V/obMd438ox16Xqbbet8LRvfDM/rxx2oLisE1x21klQI3GffofoVuB39bKJL5mIEPuNxZM5tuLDUDV8Rm3TlP97xttrTJRf/cQnY7ue3CDuxToEBSK1gmK/G4Ozn91vYPcGj+LB7IzmwuoUp/5lqdH5WKl9dyFIpEKG77Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dOyrviyZ; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as2KJ0RZ8KO0YJ2/dbzI/aHlbXIxP154rl50FhWGyRGhWzNOeea4oA4OcQPUuwUZNvdhzYJwgNu0wRrCcabjbj5Cc4P+9EC9mKAQ/Sp4J2en3CGoUnWfO5FTwdkl69uh+ddn2M+xNpT35Et9flRJLpp9964v7EScsqZRs4TyxqJrO0R629ScqHdPrRvRjPhe4nB4PBl6s1fqWsjjuiijFAw6+i4joawFXBlI9TI1Sfi2NjGbiFEETXck7JFOCggehScddCh+B2B6LMAnnsuCLfZMAzsZUCpXSmVt5hsZLjBL7s01fFZcd/O67P90fKrKLt3J0gCP5B7tEwGl9GJT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/vyK4IPIn2NFOCf8FhAII3WAM8geFJphXhnGhVnstU=;
 b=nVr0D4TFKZFJ7+bBSoysYNsFElRAa2CGQp0Dm8J6jZoSQzfV1jD1hnmlXx5bvAngFCyA29+AM+qWTsmXOsomwUK8m8ecEdjst3hL/HnRPR7zjfKsDSdCf7r7w7VpFbtVejjID8miLFipXv1IvpKpE3mwxoeXCRl8NcguBqifgK7vdPfYXVQ3NRq9Qp2G3akTbtDfoP+ocmn0Skwyte+Xqu3QB8GG64+RKIvnABTX0tLx2DhkPxqtMZTfPek7O7htBmjUOY+W19VKWJnqhPFCJA0JxXPHAvuUuQIbvssc5GoAfOpZiyvQpdup25xWqB4GiceJB2CPjv00X684OjoG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/vyK4IPIn2NFOCf8FhAII3WAM8geFJphXhnGhVnstU=;
 b=dOyrviyZt8T8g6pOiQx5R9U5IbkU0svpfGC07RFAJlWJEqrxyGD++QqeJkvaMCsZVWNwHyyopPpA+w55EAHXCOUdj4rQFNJct92Sumz2/FWvkf20QO++u79INFvNOVZlTip2R471Jp/ErewOk+itfaB/M1qX54Hpj94fl2vkmsn6x+LAli3LekS4h1v9OcjmipO7g+MZM5PpRiGJQ6x9QYRMVO2dCcB8PVcuCU19BI8q7Fe/SFrFNBEgZdMLNk4qbz2TnDeP4HVpgfaAXLpaELLi1/mJoIreyv5lOpZX4Juohj7kDdsoIiFih+XwxxAVBgsJx3mRqEgK4sBU8FwELw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 14:07:54 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 14:07:54 +0000
Date: Thu, 11 Jul 2024 11:07:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711140752.GE1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <2024070910-rumbling-unrigged-97ba@gregkh>
 <20240709122547.GC6668@unreal>
 <2024070933-commerce-duress-935a@gregkh>
 <20240709124723.GE6668@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709124723.GE6668@unreal>
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a864c1b-2b69-4d40-f59f-08dca1b2dba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecf97rinNOTCuQxamemaLMEWtV7CawbHDKw2LXmjt5nl+PJY4qbKWzO/TmIZ?=
 =?us-ascii?Q?6gmuaZ+fDlJ5cR/J5w0FSe7WYk8KQ6HpgGKuTX0/OaPKVahn2qsZgavkK9EC?=
 =?us-ascii?Q?KryQ6lvwvSilNuKgLNBM83GkOCw84sgbA8g/2IORE3zPoyzkz0oOLm8mrX2q?=
 =?us-ascii?Q?jzOyc+OT8x18lC6Mq+5d5rR3vdk88ad8+fKn7CyYxD8MPe8xKtXSZmS+xvdA?=
 =?us-ascii?Q?r0bASPFcKdl3scHmrIWq3tHxS5XDGbZmGfL8dADzR1nU2UuEeItIFMmRua4j?=
 =?us-ascii?Q?tuC1827ljwbQ1tbDFBsByttBasBZzXjoCx3OL/GUSYfmrpB8h5r6jDB20/HB?=
 =?us-ascii?Q?hG86EiH3t2/v2y2W5eVgiDfJ9qvb3U7yDTr/7Y7CyFG1rp/6sLtE/DxRTJOP?=
 =?us-ascii?Q?oIndnZwMQEVfJH/83jVoC2Ot7lAQdLri4SIWHjmqnp/BxEA9RQC8SuckKeqq?=
 =?us-ascii?Q?F0F30bwOpqDmyetaxbT3fK7Qu97y7uJ9Jg3Lf3H6rqjvwIYnwL/23Ietiiym?=
 =?us-ascii?Q?H9e/A4Bn12wdVbt081QPfJlNQGp7nAz2mFqAY08bEjvdKB8eaKcd0X0tFfG6?=
 =?us-ascii?Q?5llyTGFt80HRq5407SsqPspJWPL9i21WtHGkqNwN71mKWe/LWzgjLuPSnnvM?=
 =?us-ascii?Q?F+QMatfTlmdU9rnmo3/dUf98WOgLoqKmCiRiUESIXMLvvK5vMWSPg7OIIGf/?=
 =?us-ascii?Q?hRBMlsv1feZtJ9crY56T6D9ZfIsPtGJ2MLPpZRxqZb+0fbFt6tXhy60PkqHM?=
 =?us-ascii?Q?MjaLu8SoUkxtNkdGGuP/l58oS/AOXwljpCPF7Tj7u2MijWjwHo0jAv9mcONm?=
 =?us-ascii?Q?H4tSS987utIcop1knh9OLkCYKY2qrF5yqW9JlJvkmXAya8R4QGpusfDyp3XY?=
 =?us-ascii?Q?X0gccfr/8UTlGUa0VFhj0soQj5i0BBtQKC4IZ2XINrbcIqpvG14ossJbFaFn?=
 =?us-ascii?Q?a0JILsIuknWkWoohH7zJZ2XuCMUwX/d9aAl7xvM4Mvae4efN+//JDSR2XMy/?=
 =?us-ascii?Q?XGb4G6pthDUttzADbQfjdQwAvvnArxXmR/Yg7TGQwG3EgHZblcOG/VQTpo24?=
 =?us-ascii?Q?wQpYkB3RcNIWgURtgk6HHj7TwGoj+JMTDbQ1eydZRJ+lUfjU1UQo6Zjxn4fO?=
 =?us-ascii?Q?fBtroOzxeEHCiyzGy/G5WGSixc/FZOOLbMcoJfLncq1DuzHHhemPYS9T4UmA?=
 =?us-ascii?Q?xnBawiNPFg2izPITYOBuENXVXKXM2psYexpISFfVSz1f8glOQF/uJPfkCcBo?=
 =?us-ascii?Q?wRNgriuk/A2Ga/h8wAKSvNuOhK0/h9znEO0mHLmkVs6CCt9CzKrKzDY+CzgW?=
 =?us-ascii?Q?Iuf5pCsYGv6gCIKBgcbBiOoeghBV6ioutCrDoP2puEHV9bHbT4rVwOUSCTgA?=
 =?us-ascii?Q?TmFEHIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zoogoWGXZ6Lwda5QkKkmk4t0X8erWa3hurfBDHEHMnE3AraBHkrx29A93rer?=
 =?us-ascii?Q?LMVXpqvVuXKAOy7o61E6r42qscb3+tV71RyLDEIIafDiKYjbWslQ4KXDtCWP?=
 =?us-ascii?Q?Jet42E9YK7hqCzYUbOxJq/+/sDJCLzIIIVpZqRRwD0GDTmdg7qWhPY+VPkIF?=
 =?us-ascii?Q?v3TY7K000d74OaA9CsGbJcvX1TRM+uOy7hLzy087PQJXCKhtQ1nnSb+w//om?=
 =?us-ascii?Q?KYKMiRC6cOAyM1PPLDmwNsWaEdmQbQ3/m7OOtSMeWWkQUxwhwQrEDp0DMfLd?=
 =?us-ascii?Q?4NEGRkzmeQ7mbY7ykyACYc5dvsCLMgeRP92bujYXhQmdFPlpPocD/yXzZe5o?=
 =?us-ascii?Q?SQZr+DCsKikYftNkJkakl+FdTXdM3IQUteHyyabiTHDxEJaXg35iedi/FOc0?=
 =?us-ascii?Q?kLvWIse2B/0jXK0rZLdQL3wzag2l9OAgWzVNWgwN8uKS+UfAUXt1IZsmltMh?=
 =?us-ascii?Q?427xzJJa1RLQ4UfV0cosJt+T2DiqzTRld2Ewloc5LQsWaHjPIsOHVjAb2qnW?=
 =?us-ascii?Q?A257TWTXfaiVutUKrznjL4kRRSIj1sCtIwj/ZyL+tP+dJfvQVIDZSVTLWfg0?=
 =?us-ascii?Q?RzemSOhOq2/xgrPU0rDpfR0dGyUIFRkCWi2kudO1b7USN22VNI97DnbVGpCb?=
 =?us-ascii?Q?ioAE0cSRgkL8JtP3cmOXQHOGfmU53j6f2D7jBgAFt3KJlzxBWnyCrnt+U2aF?=
 =?us-ascii?Q?UAhPyBo693O2OlAW57tzjw85lI83d9CaimuvA27nWb2fiGj3/4fCvKca9O+d?=
 =?us-ascii?Q?u/lsKulBW4BWCkCD5s78DmRkHKwQpnmdkNIeNCWCWDD/VfE4dQocwNGjqPI/?=
 =?us-ascii?Q?9cdq59o+2MSF/et3z+0NWlINfw5WpNY9dGDwuzWj8KDCuyz3H2WqjXLRtqiT?=
 =?us-ascii?Q?Y4nAaf8OdiAHTxIz6BYa2JHHZJMDPLA8UoA+hLVEwg26Pd54nS9XLTtoR6ud?=
 =?us-ascii?Q?oH1wCPKO4FNHaia3NTzwP+apFl8bpYJkwpMJmMq0NnmlQlp0qtjo6Y+HZyBq?=
 =?us-ascii?Q?Lkm+BF7Bnzm37xmMSNdFobRKLQayzEmTb6SLeFbGqbfPYhXQsnRB2EDxacet?=
 =?us-ascii?Q?rB8jonWbTHQ9dKRG9hBvN+wWzUnA4hseU7GZpoCILxjIP3I+nd1sKddFUQy5?=
 =?us-ascii?Q?50NmwyeFlH+ULmv0fZToWLIRxc53iOd1V8wWhuddn1Y6w+0/StICjB6bRXJ6?=
 =?us-ascii?Q?z4xHqvyCqvBPQSNEnyAGjc6GEy4/UAkZ/n6j7ZBOrDZBgLDn83lkOWvopN4Z?=
 =?us-ascii?Q?ox+98AfpAV2rW8ZjxNfOv91JXKu3TbFHr1Dqffr1XKJjdK0yyvF3P8MMDmuS?=
 =?us-ascii?Q?sTdDFOvxXG6M4fZaJfg+kMZyVud8J5WaASgK5JDG7a1aSxEMcFWRDWbUv86Y?=
 =?us-ascii?Q?gUIfT5LHZw8q4kzm2o8z0ctMMneMoIoTHY5jD1+4rM04N5lZfTeJ39G54Ez3?=
 =?us-ascii?Q?aEI2QjNDKXx3K+9AP/ysgi4Tpl1bVDVksl+F9ChWVIAd2c2TfFepvBCBZzQL?=
 =?us-ascii?Q?FPFnjOXX0w1ZUqVrLm6EN0FAfneRBx+Z/c0U+EDwT+bOH6qbbFDL6v9WPiND?=
 =?us-ascii?Q?5JIUtzJgRg1tmH+R4OQ5JgGS7/soPacaKeCo3bKc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a864c1b-2b69-4d40-f59f-08dca1b2dba6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:07:54.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWYVb/s+7TFtbsUo4NQPvJA4Rcue9FnhXgNO8jPN4XkZ4FFhH5i8rnLBAjMAm2/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

On Tue, Jul 09, 2024 at 03:47:23PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 09, 2024 at 02:33:17PM +0200, Greg KH wrote:
> > On Tue, Jul 09, 2024 at 03:25:47PM +0300, Leon Romanovsky wrote:
> > > On Tue, Jul 09, 2024 at 12:01:06PM +0200, Greg KH wrote:
> > > > On Mon, Jul 08, 2024 at 03:26:43PM -0700, Dan Williams wrote:
> > > 
> > > <...>
> > > 
> > > > > It sets common expectations for
> > > > > device designers, distribution maintainers, and kernel developers. It is
> > > > > complimentary to the Linux-command path for operations that need deeper
> > > > > kernel coordination.
> > > > 
> > > > Yes, it's a good start, BUT by circumventing the network control plane,
> > > > the network driver maintainers rightfully are worried about this as
> > > > their review comments seem to be ignored here.  The rest of us
> > > > maintainers can't ignore that objection, sorry.
> > > 
> > > Can you please point to the TECHNICAL review comments that were
> > > presented and later ignored?
> > 
> > I can't remember review comments that were made yesterday, let alone
> > months ago, sorry.
> 
> So I will summarize the situation for you. There are NO technical review
> comments from netdev maintainer (not plural maintainers). The difference
> is philosophical and not technical.

Yes, to my knowledge no technical comments where given against fwctl
that have not been addressed.

Also, please, can we understand that networking in Linux has diverse
maintainership?

These days a huge amount of networking hardware is being deployed
where the software netdev networking stack is not the primary software
driving the HW. Many sites principally use RDMA, DPDK, and other
stacks on some devices.

For instance I previously shared a paper from Azure indicating that
over 70% of traffic on some of their networks was RDMA focused. [1]

We need to *share* the responsibility to support this complex HW. I'm
certain we won't always agree on the right way to do that.

If there is no real technical harm, let's not leap to vetoing ideas
from other networking-related subsystem maintainers please.

Jason

[1] https://www.usenix.org/system/files/nsdi23-bai.pdf

