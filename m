Return-Path: <linux-rdma+bounces-3825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC65192E9E3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAB1C22F47
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78515FCEB;
	Thu, 11 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QV2Jh6CV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78A15F40D;
	Thu, 11 Jul 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705838; cv=fail; b=fJUqvFKIMvpEfAmqqxaNGiB42rb47jenCnymyiQu8d6cADXYLNmDLgVohtlxTfOXHT4WjAL2cc10NlsRVEw2AiwpXygVnXs+Cjv5Qj7SNmIgDi8EkaEr10rEYYx4uri7wzgtg2YQPbh+yXLWISevYz2oOqbDN/bOK5o8pc9hIzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705838; c=relaxed/simple;
	bh=nsg9pam9dUuSnN/M1iQZ9pOT5/oB3wIAtJ7tVcX9TC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ON6nmH16pdfrTk8qyxvIcuMLA8iGZPKNJzXfJ4OLv3iUnA+eOtSTYolTeDyjD1aVY2KS47IPi+dUKAFLD7Umegyh6qirr5UbsXpJJh/df7J9TFNW+xwFQL+zrPQ8vQ2EejFwDQYJOH7SrB6i9nlMDiZ+g9ekmgiYWhZRIoQZelM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QV2Jh6CV; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQOnYmF9Tou0DaCqKqxuTh8SzAqy//HYq6AkFteo/wIIjj0jSw9/CSaHEyNayb9bfT7keiTniAIeblSz7ojmw10kDnLbfEBm3raOzRQfhtO3Ju9j6BYLjKsvHgpdoB6miJ/PDLkASASs+yCxOOuyKsI4s+fkSPZng5QWirYOjrNtChMnHFZetEWWKkoLpc74h4Z38n4DfAYbFsJ0HBQ2pZ2OfT1PJmR23Jt4W4zogTO5BkLRFcFX1Q6bAL1CpUVyrF6lft+TjKa9GMbYwx9sixlPfRXAb70oG9aGyDBusFUIIT4dGxfZ+gFB3GSOGGgFUtSDrP1s47v6kkeb8ftbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwGqxbsjI/ipmmqZJF9wbI7qDdV4+QMeHj+865phEr0=;
 b=ZpHEEhMZurIi4O7zVbtsXXFm2GW6LOCVSZOHX9UhSJNUJH717AIlR2OmoZxz37Lafi0BTsuvMx2aJ6b57Ka81K+6f0wKdToJkO7Qze73o7Zr3X7fLvj4O8uq4jabeQxbMBJxYhv7/Bn87tblLDgfDp9CTimJKL0srshge8GqyGGMo3YNa1eeajfDdcUcWg+T4V275JLCMtpeUNCSyykZ0vnrdvyVsCK18mOB55a4pq1tCa1W14DBLaLeWmSEcAWVNPj/YN6VPmSintqt5sHsFuuVe4AJtxXOZqQm+TcMpuCdqUMsqphmdwXzIhSiB1lXUDsc7fD3rw6LQCVrbEVRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwGqxbsjI/ipmmqZJF9wbI7qDdV4+QMeHj+865phEr0=;
 b=QV2Jh6CVT9ymbKQ/5xhOkyLm8v6bItY3jCKi1SKR6oddV1LsFVTncIg1lKo5vsoMEv4ddqv0WmQRyOJ+P5XoJ7Kf9Mzh6w59b9fo5eGn6Q0B2wzTJ1xEPYixw0Pp8hH1idEI0sZYSBZE1hdf4UeVv72ycJBqf5m+IlG+Eo2zZvlM8okk39NEdAK0wod0ZFZRtOQn2rtEd/54bxqHT5cJ0tnFg8+Z7spJFhXV8I3MhIaKsL0SunQ/2RJrIECKz7XAFcSpc/lqs/P9dhv39UmkyaDYmTUStYd29pZ/Ur3HVxK9Ud19vkt0GF5Hm8hB5p2PnQBEDkktdTuOqYVqIqGHhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 13:50:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 13:50:32 +0000
Date: Thu, 11 Jul 2024 10:50:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711135030.GD1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: dfff4a82-c667-4a6b-953f-08dca1b06ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJN5dX/SWUhCdUMBV2G8Axy+rpYPGIkfgDDF+98WSJ1Xlj4PJc/jufKGz0uY?=
 =?us-ascii?Q?ZMe0GKgUu806CQoq3GqU89widpIn7itB+eS6/Ry7I3/gQDHA8lv1OlzEU5DW?=
 =?us-ascii?Q?r6Fs1QyLKqXmErpZcxjpE8b//v3nflLTPSTUByt9G62zAU5RjcScqRbasHfD?=
 =?us-ascii?Q?CNnI6IZyx3ooofhpr7YFSmCe3ktaccYnqgZArontNh4JmJa2WiYCf+8/fIWN?=
 =?us-ascii?Q?2D4FEHzjNWJjmCoMbwwKjj/rLaJ/+qZ8Kw11yCDYufrGlNCmCNA0bD/RKpa8?=
 =?us-ascii?Q?nZA2RBj8fR1elvwDItmZiDUQC1YJ5fQ81ccySf7NcEbVqh8kMmuzdHo5Pm0c?=
 =?us-ascii?Q?qbAfXiMf7nkQM/ErpfLkv9rYS5icCy8Xbi4vMlNsENb71pO0rvF5nfaplSQG?=
 =?us-ascii?Q?53BSjbsd7NPuxKECgPiilyGV9Dno4vTSQ/neZY38lDkXg8qIBMJ/7dkrIE5W?=
 =?us-ascii?Q?e5wa4N4riNGm4cM4Jb9QRE5rbWZ3z7PewIXRSNHZt44KUoK39u1/AFC6ST7z?=
 =?us-ascii?Q?Q+X2K4bRdwzT0AeTS9hvhnQQbY8iXtnkLRjhbiSz86qOKQcjm1WZb5wVvW4g?=
 =?us-ascii?Q?PGqlkM1kRUVETCe6BnJCEo5JjCsm4uVRV1KS576Na90C6iv39YLR/XBX80EZ?=
 =?us-ascii?Q?aqllzgYBIp5iKKx6fk9Qg5rKRYot3es/8dqPIig+ozpmmR7VqSJIPV5kRf8l?=
 =?us-ascii?Q?5nuDrUTm/DzZMvWP2asY0CVvxxOxR497A/Bmy1YdmfViA52lJ9xQsWsunS/H?=
 =?us-ascii?Q?kKgrYTtQsp1REr54XZ201bCUz5MoGbM8+m3akVdqhCsvbYl1ML16mGxya+1b?=
 =?us-ascii?Q?AidMlbUAlT7QOpaqJjmPek5zW6Poi+5cGb2whM3hoFXwUP0WIbJWCB3R3QqD?=
 =?us-ascii?Q?yjeFK4qsAozK14dAIu3W/3tXjzXug3v8MqcgmWd++clr8NVgRYP+cQBg9dPs?=
 =?us-ascii?Q?wp0mDaeFlWbh2BV5rC1fa8rHakVfChjZYKaBgzjxUP5Ze4usMDeBi24O+w5Q?=
 =?us-ascii?Q?ZsbjzPHmDyytRykp8br36/UYiQm4Mw5THbfaGD1Ju4ugFY7uJYfvahTyyDwD?=
 =?us-ascii?Q?sLC1yzDa9bOK13z1lJM4huIyGciyTi04LXPmxeNHMBZLV/zr0hZsZ3zdB5Pw?=
 =?us-ascii?Q?3CM4gFV+vpfnt0JVR1ndISlgHGPxPIyxCkedkIzFDtPTFyv6KD1M0fluyRdA?=
 =?us-ascii?Q?PjHgh6gwzb09kfVTQXBTwTd9Nn6wj3P8Vjlmdr1vr5enbZhaAmWAbfoICScJ?=
 =?us-ascii?Q?/UeIYq8jo3Php6lcGHUrB9Vf8BF8rUvwHcDDvfp85mkVKFWO1L+/HIkwgQuN?=
 =?us-ascii?Q?7T/ynZWjObFsLIt2N+ZsnMR+axhR7SWE9ZFQL85ZumWlNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JxiRECmSj+dR/CQVzm2Yc8mVnHbcuvuGas27oSviyC80y306szqcOVHqm/TI?=
 =?us-ascii?Q?sC/dUjavXtNhrHb/DyIuH0GPYodRpIr2U7qFHk/oaWQE6BYOtv2YmiplcxLe?=
 =?us-ascii?Q?EC795d7kUm5DBu/NdmynrTFZt+IJNASHBSjCmqPlWl6WVttf2KMxDkZ21iUw?=
 =?us-ascii?Q?2zzjZmEsidZTEgsvMIEJvgrv+GR7N1wu1ZEXY8kDaoV1oYoq9pxkRiA390Aq?=
 =?us-ascii?Q?JlM0vhraWejoY6DV6VsdXHiwgefAHW0m87R1tTLm0f0dZpelQT80Blp1CLJd?=
 =?us-ascii?Q?CureSKVEPsoaLLczs4C+zJEZvkFBG8ajXz88kxu0ns/Gm9oKxrqidaStkORY?=
 =?us-ascii?Q?8iZYrFIU4PQGYU21hrS1kY6mDGxnHaUOXMzcm6VwLxw5faVH956LKHmpPvUU?=
 =?us-ascii?Q?/SG9Fzzw2b6+xfBpG9gqAY8mu3msykwgkV5iXMmK4CzK8DFZY2uFknsddLRD?=
 =?us-ascii?Q?WcLaJL1nxetoDZ0HjPQh7Vxlgsq9qLXQDC5D2IxF4GPd+F/34FW5nsvGOVQp?=
 =?us-ascii?Q?v3MjqIUQBJJfi4mQ/sc7NQLUX5EMIkEhiz7XQM4RyaXauZyfOy5bQkWrEDmv?=
 =?us-ascii?Q?ryT8DQim5TieKzE1wn1XEQw3Ildk6nn1hlfCtNvCvWhgOWpSfzGqfv+J5gB7?=
 =?us-ascii?Q?/olPYsU5U0W8UtE/olGAUeFPW8uOYZzrzyGbTlM3SD2hc324lYdLgl8cJQtt?=
 =?us-ascii?Q?/rJcWWMyQEp5Ptlu70GK7nsZwAOdpBKWZX5jrYNAeChGu7Fpy0TVVMKnMzKg?=
 =?us-ascii?Q?8Mq1arGrRMVNxOi7jfY6O1W2mMekV/6rlGqTc235oWhflIY4P293/KOYzs+H?=
 =?us-ascii?Q?Q3JN3ak4CnosJj/MGK+U/Rl2i69K5QalUdU0vHvNU00UT4z3+AwITXKx9Nzv?=
 =?us-ascii?Q?gYpwo91N53nqUxPIKv7mODEsCN7U2U9Xw17It7+TZTTiM/MDHih5Lpdo451Z?=
 =?us-ascii?Q?P3vdoMNRyYHlo6qtNNadTkc5PF03J2w7dAgzFfTX8vmcgB4d+dd26eHZU85V?=
 =?us-ascii?Q?FFEosdYbZFx0N/THGuVX0eiYoD/UVO/3irT7aSrwkf9zTOz+l7SMDGGIRHKI?=
 =?us-ascii?Q?C+hdPkadGBb7WU9NekhXdH1GvwEHAR+oXIoWdAC47OtiW4HbhHoeD7w60itL?=
 =?us-ascii?Q?82lP6XBPfHRo8tsjxRWiXxCYWwcOQ457kYBLKF0yxze/oZmqDZySraV6Ffcb?=
 =?us-ascii?Q?K+5wZKt7Hgm4WQ6O+x5gyMWinGb6F29HZfhhuMhrGvRtZKRfs9f72b8guYhn?=
 =?us-ascii?Q?3z7NB6W+zxrZp5dMtOTh3/0TeFQHfHZGS2Mt5Kdwx36RONkO3HTDmt53bhY2?=
 =?us-ascii?Q?/UvOCsVl6fisqUEwdfSk2q+QCK1gpFl3fL3Ip+PdfAf0qIxkAZ6YiXRDb1qS?=
 =?us-ascii?Q?mkqha1zyVvANSwldFo6KzdUUfSYtwtGVn6rsdAitjyIRvSsDcYFYOXZcOrsm?=
 =?us-ascii?Q?7sVNVB7W1Y2fEBeRyVuduVSKR3uJZlCH7u2OyUJERttaAz4lQSp3KiFWPywg?=
 =?us-ascii?Q?g1Oh7PmAEsL0y+B70WGMNQ1Kw6UEEJpTnRMfw2t05mjVmcpUoGRZmVk6YU0k?=
 =?us-ascii?Q?HHGNEYcf1Ul0MHcZHTsyVFltMjnELm+Tpzh8+LcZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfff4a82-c667-4a6b-953f-08dca1b06ea6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:50:32.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbzkdFzI5RFNL/dSEc3AcG1gUFayzJp2BEZL5GL2z8X14DMjKDIpIxZDKG+7xIb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Tue, Jul 09, 2024 at 09:02:25AM -0700, James Bottomley wrote:

> For NVMe and net we do have SPDK and DPDK.  What I find is that people
> tend to use them for niche use cases (like the NVMe KV command set) or
> obscure network routers.  Even though the claim they both make is to
> get the kernel out of the way and do stuff "way faster" the difficulty
> they create by bypassing everything is quite a high burden.

[..]
 
> What all of the prior pass through's taught us is that if the use case
> is big enough it will get pulled into the kernel and the kernel will
> usually manage it better (DB users).  If it remains a niche use case it
> will likely remain out of the kernel, but we won't be hurt by it (NVME
> KV protocol) and sometimes it doesn't really matter and the device
> manufacturers will sort it out on their own (USB tokens).

I don't see it as being linked to big enough use case at all.

The kernel gets involved if there are good technical reasons to do
so. Databases running over real filesystems with O_DIRECT is really
technically better than raw block devices.

While DPDK shows the opposite, userspace is the technically better
option. This is now shown at scale. DPDK is not some niche. A big
chunk of internet traffic is going through DPDKs, especially for
mobile. Many ORAN solutions include DPDK on Linux.

What has been improved kernel-side is the intergation. DPDK
deployments now often use RDMA raw queue pairs instead of VFIO, which
laregly eliminates the "high burden".

There are many other cases, like DPDK, where the right answer is to
reduce the kernel involvement. It is not so simple that things always
get pulled into the kernel.

Jason

