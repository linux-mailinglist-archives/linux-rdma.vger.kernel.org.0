Return-Path: <linux-rdma+bounces-3827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECB92EB45
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A95B22416
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6E16B735;
	Thu, 11 Jul 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bz3UDvTs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077315D5D9;
	Thu, 11 Jul 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710373; cv=fail; b=qKJqMboHfZ8jc4I9D/NOI9s1pJvb3tU4z22xvRJ8pq3rPjpciH4wk/KTWMquG/2KFQdAJhsVzrNb10XBg1KdC9Oe0SO862Ro+ojbQEfdepJudGQyF5roBt00jV/Jj+3l3OpAEEbTVucbOG9jvc/ttabYP6muyUSVDYcvcqHBGeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710373; c=relaxed/simple;
	bh=h1CJJ/aIoB7NY1z+jdeJLDbN+zcGpjdICzhaYLUq6qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EkSryxFVToryPmQ7pDWGz/j/mMmMeoMLJUlM0N+LGoVGbJ0tzN4+A4nuOWaHaxYj3Uw/LvK3o0dF1eaG2Uf4UGda5JOWg4D2iKnN391aEsxb8iaBXMX4RRcQowbMy9+n26XmyNH92evyh+lU3QT3nGzC9PYdkeBp2jzoLiJSyLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bz3UDvTs; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZKTqXoA0K5dr+pg6tbCydBnb0ygKSyWqWlvGK1dibPKsBnW+Woil6ul+XbgPv+dwBjxigrQreIAFJk/L8GeBeTXHD+ek6cKpHpQHf9/ifEGhcr2wsunuTxUfDAhgTM29WOrxP27rAV01b/J9ix33cPH9zFAiyF4s36GiUoX48mxHyY7qeol+avCY8F0ppb+VHdOCoL/j0FxeNA4Aq0IviFSzIXBHd08WDksE2iGZbY5TVpBfadLQgfczgwSFraGnDzdISaBYEHBq1kJ4avCnZu9pWHte0M+hgwhKmPETyqhtVpsXPnf3W54+x2We9/vJiZ+v7Zx4dJhOcsdyc35rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KEFaRHb8sJrrvRbZJMqQP9iUeP/wIeQAQRoBNEKfPg=;
 b=XooU2ScYOt34G4KamhDqUYtDkVmxDtP7yQwi7idae6TyTW2utWGU0FaSzMWDfzXibPdJHiwN/0+Y336qnTa0Dk8UPLG91ZitfRBpuFqBBMPyq5BeuSl3nK/809aCGYa2HdlWdFtPY9pQlSKShk7SF4iBnVCo6gffRMoTmKul8RfIRDdWobq4j+Z63AZ5jShypT4EWti6Ly7RKQSnY4IM0T04id4vGlEKLO96xZccU1lfoZXRvzgfOvpEdwIcaaODrCESDcCwuh0UQgQ+3UHjUp/0W1cfTBAeiv7z6JpEq+NrKQm/uPmPMp+L4Gef1SFKSgx7rmoKiGzQv//OHwQ5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KEFaRHb8sJrrvRbZJMqQP9iUeP/wIeQAQRoBNEKfPg=;
 b=bz3UDvTs6oTEGay6xQWqh0380zklbtjJI56uF7IKJZfOXwwzBkB74cO7UsrM1pUbla2lLHfWwgg9HBYkj1AECsPviee4zGLGhpu63aK+nTcHOcbXoJjPV3Hoo/AxhDP7e/lgmB39zKDTRlhCt7oJTM2dkqHZo00EIx++ZFK9wIYpwsfKULiAb/kVZJGv4iuUL9hsm2wJf0MHDrDVbZGLtI9d02p4J+9O9ecmPjwU6MqNuSHrclFYwo1gBWudkQPoGAEfY4aeDV/RrF8fQ1J12k+X+5Fm2vXetGOEdAFpRhWRbT+LT8Z3ZTtvf1vIXbpY15oFZD/DvbAzlSsPwqIbxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 15:06:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 15:06:02 +0000
Date: Thu, 11 Jul 2024 12:05:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711150559.GF1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240710142238.00007295@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710142238.00007295@Huawei.com>
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b39ffd-afcc-49f8-6c72-08dca1bafaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dz38mw4GwPa9j4uXAPLZyfZabBanQod2nuudBKIgsDcx6O7oxD9me5Ri0ix?=
 =?us-ascii?Q?dZPrnXasdh4k/Y68rZZPcXGfX5D31toV6OnfC6ynZ5Vg+WoTu3aMkYhdd2d/?=
 =?us-ascii?Q?h59tOdwaBQ4zS4pyY9KSXTyKlnk4SxvOAMuQxgPhzlth54mbntC1ifn7pG20?=
 =?us-ascii?Q?bVAG1hyHf+Nc2bWCKpCvSkrRpG3EM3NkBdwotgVlKx2CxtQRCn8W6IHpahsE?=
 =?us-ascii?Q?BwGcwg2vDpiyObQX2zSGuxNmEKg4Vk0z/EmLeWTGbjwIL/pWDqrV6zbjyWln?=
 =?us-ascii?Q?UlIXj6v7as6tX080jZehaIFlwVFqQBlXm2iqgq/nCKi6WqGvHCnrAIu/twyN?=
 =?us-ascii?Q?WULhAzLXuDW3TERbKYjEslgIuYQxKvczZCDwZ91LFhXzWhFBgmVKrYe/MkPg?=
 =?us-ascii?Q?sPRnM01UL8OpmU3lARnjQPB0EbnbqvTb44vAt2rJvya4HjUHJDJt3hYWuJLX?=
 =?us-ascii?Q?4jvjf2N3lk5+QYEiczb5VeGGrtd3YJ7iCsXMXQi0/HVG+dswL3Cd3wIJzWci?=
 =?us-ascii?Q?FQP60OJaLceri6qXlvbcG9vA/h0/D7EVvDdiMMmLIeqorHEesOe7phkxCxGJ?=
 =?us-ascii?Q?9qBbxyy0BU1nJUz9CDPNeCEky0FSWBzGWGwVXpluR0SoJ6dwQjpQ7smbv31R?=
 =?us-ascii?Q?Tr1a0Xn01wHVRu8KHLM6y+tdTFSIEil2B+dZAi2DZVAFosADvd2uGkhMPxjl?=
 =?us-ascii?Q?TBuY+1yPz2SONK5q8z9QFUYrFS/fwyjgZNJIlfCbXcwi7DCT/njNOujrg2I1?=
 =?us-ascii?Q?dJy1c+/17myqw04LG4ePhbTcMbYem6COt21T5TfvOVNdPe1Nzb/zXFhAL/mW?=
 =?us-ascii?Q?iDzgzLxtTM0/QcoCBmcfPvYxVtPcw9DePLvgyaN3HzIkMMgo14j5MwqCGb/3?=
 =?us-ascii?Q?kk2rJEugrzzpValjAHupS8auhkb6A+trjk4kHPPSYwcuG16gLXPRnG+Lc7pU?=
 =?us-ascii?Q?zQGxZoVP1VYPG98nrKxR3fYUUvZH7+Fl5x4Oi8lPc9vVO6j+ZGPyX28KTW/l?=
 =?us-ascii?Q?ROwuvkU+4osybl33NX2Ur5w1UdbHyFhSmgn5eDcM5leRYGbZ5HlchdzlQxtC?=
 =?us-ascii?Q?+e+LKVo/rBsXyFzy+hiDi1n/tmOSz7QE6Jc4ckfuJqu1KdFPHRJYxGm7QpVc?=
 =?us-ascii?Q?YgrH4+Ox8bnJStwU+BiV0rOzFYwp9VCL8gUpurr81O3xvQ1UmH2wWDTT25zB?=
 =?us-ascii?Q?h0RVbBNAvNBkpjtTmZy73WiJt7d0MZV5gncQJTNykCB4xRdsDJKKc+tAN7u8?=
 =?us-ascii?Q?X8Wavwy00LIauuVLmdhn26AyrbcPmrocjwxKwsdrlW+Gtmd5fRYBnjRsFDrz?=
 =?us-ascii?Q?YnozTXv1qLf8A/dVtoCw/mGepEEFmX8UpO6MfqiNG9UxS4h5P1+KqfY5UWT3?=
 =?us-ascii?Q?nyRf1sA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzImJfuWw1rf1uxGnJkGzET48sfQT8fMJrdZSgHPu+NRl/0Llce8s3e/xjs/?=
 =?us-ascii?Q?azWOcpXN22KPeEDuKczVr2DgG9db4f2xDEBXVyXzohjUJ9ohg1es4ugxw90G?=
 =?us-ascii?Q?67rsSU5NUtJH7oy4aG2QBNZzqSegpNUFg4zGsVD0wv7wDtoTORpEppBzm7uL?=
 =?us-ascii?Q?lUXeFogUDurFMbtkhQUqtonVT5+lzUXSovPwc+TZyx5jRnrOreIk2vKfyUsy?=
 =?us-ascii?Q?qdvr+DcVpGnT8DDnZNznKxmzIb8/Ofa4EAxwfnr8WBQnZ+UeRJYuBKmwVqlt?=
 =?us-ascii?Q?e3e/Rh0Crg18bjNhOPelhVTRDU3eG4pC2YEI8w26/CMy3wpQC6li+dHz9khi?=
 =?us-ascii?Q?y22/7eGCFNsZulbM8mbKa6LlHGyzz5dz93/RmuT0gJdgsY2jik5jpfF/O+3J?=
 =?us-ascii?Q?64XHHJ3EoPgbSX/mTPTTQ4SIQ/zL8vEZ0jVSCtOgTSE4SXcCjy4As3kklN6w?=
 =?us-ascii?Q?B8962OqTsvm/bQc+XaWLRPFphg5NR1FkFUIlMBInIZrH2mhVIb0+PyKu+1sl?=
 =?us-ascii?Q?kSyBErgMaZqSpu+c1FqhsxfeoZ7h44NIgpHyeq9LRHLZ5W9AZdyvC+07xl3T?=
 =?us-ascii?Q?xjLxXTdZWn9+uqeeP5uPQXFI4GJxXXtqDDYCoa5Tm9vv6Pem8+rB89wiWDC/?=
 =?us-ascii?Q?O+rTkM2nLTErU+XKtda3JldTIaVJKnDbGxHHws30KDfrh9Ec4gOhx/gjs6Iw?=
 =?us-ascii?Q?4z2pdrhhM3aPwXO3jFaIcFd/dvl7iD5dHeqlcpakiwfjP/Db0QW4CdIBUOi5?=
 =?us-ascii?Q?FpcawxQ/4fVIxNpyKf9TO/D1CmBDCuPxP6Pm3eqAJPO268O+phH0JOCAf6sh?=
 =?us-ascii?Q?qxCG70033FWvzWym7sGHDeotZV2x+nqmDz5aqePLTPv9PVVKUC4RbJXDhga0?=
 =?us-ascii?Q?ElhL/E+D30KQ9p297WkgcmhXtQ49/n3rDJB1lYF4Uj2i0XbosPG66qdvvKUQ?=
 =?us-ascii?Q?cznHFXhSQmJQnn0XPHiBtyVD7zrPs58MZ+yq1L6cbGdxrcZjn5Q98kNpfPJk?=
 =?us-ascii?Q?95Q3Q3MOu6UWDYMtdnkWAt3faw1NmggZXqhMXDXbYH/gjEazo3BFKdmAEdpM?=
 =?us-ascii?Q?lMzJhbJuVAB+8YT136kChY/uSrZl7+Mnjl/EDhHXmldITn5SQjuMnoGTm8TN?=
 =?us-ascii?Q?i1FxeeAhoDCU8f+TvD7+Z9HjUnntSAwDrJ+DiC9gpZdqm+V089UcrkjjBgJX?=
 =?us-ascii?Q?3z2UXdVPOALFxnusVshS7pPEiEvS2+uZ7O86WRmNRXWlxjxLZOCxohAa8LIH?=
 =?us-ascii?Q?XI1pdxXXhQe2Xu4g7cx+lCJtXHB+duiQj8J7fxtQs7eeEaxDUInpXP385hR5?=
 =?us-ascii?Q?lyfcg3qmualjvIr9kxH4qJlQYBjf0use9BdLVCoNwXXctUud/f3WT+lJizpu?=
 =?us-ascii?Q?4BKXp+iiXdAW7AcCqvAalhpGS+vk5IzDfIrl1YX8+VMJ5K6LiyshEZ0MPUBa?=
 =?us-ascii?Q?U/AVc6NlbHbBgYYdoR1bqWEfImRVA671DbkkdjU3C8yahMQT0oiQMtAi0nro?=
 =?us-ascii?Q?DngcTD1/hejzEtyz89KypP65p6wleGtufxQxlRPU2kAjJKlFtCsCnCRATV22?=
 =?us-ascii?Q?bwtg+VR6VomYRvwAFqwL2iazlxpoaW0ABl9xOGhL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b39ffd-afcc-49f8-6c72-08dca1bafaa7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:06:02.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNRSNfxfDxH6slPRYEtWcwrITwPFQq4H8C8o0SUmVS9Nsv2N2jlxSfHrYsLWw5hg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

On Wed, Jul 10, 2024 at 02:22:38PM +0100, Jonathan Cameron wrote:
> On Tue, 9 Jul 2024 15:15:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > James Bottomley wrote:
> > > > The upstream discussion has yielded the full spectrum of positions on
> > > > device specific functionality, and it is a topic that needs cross-
> > > > kernel consensus as hardware increasingly spans cross-subsystem
> > > > concerns. Please consider it for a Maintainers Summit discussion.  
> > > 
> > > I'm with Greg on this ... can you point to some of the contrary
> > > positions?  
> > 
> > This thread has that discussion:
> > 
> > http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > 
> > I do not want to speak for others on the saliency of their points, all I
> > can say is that the contrary positions have so far not moved me to drop
> > consideration of fwctl for CXL.
> 
> I was resisting rat holing. Oh well...
> 
> For a 'subset' of CXL.  There are a wide range of controls that are highly
> destructive, potentially to other hosts (simplest one is a command that
> will surprise remove someone else's memory).

I don't know alot of CXL, but from talking with Dan and reading these
posts it seems to me that CXL turn into a network, with switches and
multi-node and then somehow hid some kind of 'raw packet' interface to
communicate node-to-node. But never added any kind of node level
authorization? ie trust the nodes not to hurt each other?

Sounds sketchy to me :)

> So if fwctl is adopted, I do want the means to use it for the highly
> destructive stuff as well!  Maybe that's a future discussion.

With that kind of security model you probably have to trust the
userspace, even in a lockdown kernel.

ie can userspace replace the CXL HW that has the command interface
with VFIO and then do anything with nothing more than CAP_SYS_ADMIN
and root?

If so it is not unreasonable that a fwctl interface has a similar
level of protection.

> > Where CXL has a Command Effects Log that is a reasonable protocol for
> > making decisions about opaque command codes, and that CXL already has a
> > few years of experience with the commands that *do* need a Linux-command
> > wrapper.
> 
> Worth asking if this will incorporate unknown but not vendor defined
> commands.  There is a long tail of stuff in the spec we haven't caught up
> with yet.  Or you thinking keep this for the strictly vendor defined stuff?

I would allow as much as possible in fwctl that meets the defined
functional limitations and security model.

There is security merit in saying userspace will run, parse and
convert to output complex commands if it can safely do so. From an end
user perspective running a common tool to view the output is generally
always preferred anyhow, and the typical user doesn't really care if
the tool trundles through sysfs or does something else.

Jason

