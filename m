Return-Path: <linux-rdma+bounces-4075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07493F974
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3382C2824BD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB013157E6C;
	Mon, 29 Jul 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebP36zV5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C8156883;
	Mon, 29 Jul 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266984; cv=fail; b=arZK3U6lZJ1ey4tgSHIXEuwXNJR89ki4ZbjGr8xa9TvEE80Mokg/ivP4lWJ6m36jhAGM/H9o8I4xR6WhnXWDg6mVa6Vs0xwvDjFnWzepDpZO1icKEVSVhIt3trOZqe7rjLuQbCIWId/Emh2okNpBZC3tvE3rNz3TQ1pH18mbOps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266984; c=relaxed/simple;
	bh=+W8tl39QAVPSjn80dW3YMJ82toC/xfzV9BNAHniyuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gZ5hdtd9QCQo4uBpZkWiA7DMGmmct5HMqQ6M7cAf8bp39fmEkJCocSiUqT9AvmdKfsB6lfflZ5Yf911Qja60/R/IhXpIPfoUG+O3XiWSbNIBb1MRwzLhWK1MfKoG9ZhY+bRQ9R+xAGODFbXIU6opBaWtLKSiysC11TAuZy+DRqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebP36zV5; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCGKhVeO7v8mhEF9kAvkZj4PT2v4rArw+su/UsFTkSrgd64Qy+wZZ77498yvx2Uuca3+7W/JPXm4dMn96q6x3rxmaKTYq/AtdTyBIncKjuIFQqJSS86yGKi1+tKohTAtphE04nQUmfioVRtmpFknk/CcMAm1y6k+iD5mw8tSJWDpkT5OeyZPTjSSSKN52HJ73rjIU56LppqMUMQsEOWAjoGEuE9QpE8syuASvnD+2jKbulbjNHfzR6Yc4tublfZC/c5Ad06VUHe3mf9ogAd168RsadJ8FYSax/W7zk7RkNBNnc7yyYodCRvlnmdRHcKnl8KCoLkxsQkesa2RvVVYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8sAuKlr1rZ/qHfDno+8keTVgD26sxKUbnWFshyBDrk=;
 b=k5AEXXALMiY3akSrk2KbZtgl5p0dRzMFinT1s78bYAGaeTIM6t6LVMUdWWViMu6LQDgwfRtI/JfYx/043n2pWCxVOD5Mzd9ROxnqYSZjxXqcIeWurjdurpVzUlhCwX6djW2slRbLiNANID+nfFSnw2l9+eZbC/kkF+DbRhKqTpda18KXNcFbAMLzqh3FzCXGeMpHpDrG6sRyzrvEPPnv4LmnJdDS7d3jLfbS7408aadbpEitNnUlVSHh6ZKAvHEdU/YgvEgNC/Oc/R3S7Gq+2peaB+aM6MigFzxdPBvbUanwTcW0VQhwUJfiJwn741dvmDy+qpxYRoMkAjbNGlm5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8sAuKlr1rZ/qHfDno+8keTVgD26sxKUbnWFshyBDrk=;
 b=ebP36zV5SkLA9CtyP1WjsTWduGOaaMdbHaSLX+QBdi+ohPQ1JNROiBsKCUds+bdfmK8hG8kiSdbh2W4cBOtv1DwyLMnA2Hi1Et3q3FiE6PwkYg0NHUvDfK2VKLumt97ZUMEFawqUKM8d65ISpc9v+MbSIYNVDWT2SycoIbE2jiOAo21WUl2V2cKTdlY66SJ5P+qMmL8NSY/qjMZjsBoSobZV34A7x/3qK5gWIbt4BtsI3k1ss3lA0zBcvtDzZcMKv+HYFLDC7FMUQCbCDRLbmSLrmYo+K1kw4kv1q2Ku7x+Y4kaCZVOkgMcs82hbSWkMPPWfSoaDDEAmYhNcoP43lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 15:29:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 15:29:39 +0000
Date: Mon, 29 Jul 2024 12:29:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729152938.GE3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <20240729075607.71ca5150@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729075607.71ca5150@kernel.org>
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ae34e1-f0e9-4be2-42ab-08dcafe342c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvtaidNtq/wS17AJzMBb1oojFtbjOIeQ9Aw3mceUAtBTDttjtQ8jGv36D/Mg?=
 =?us-ascii?Q?s1fUBdPlR90Ljvj9VsOB/hwwEolormTh7K3lKUw583zPk7+yH6K3Pmx6oefd?=
 =?us-ascii?Q?tZQ+x+X+HSv8RjNHHIDiIl0Qt69HWP24rJ2H1eUXZVMvhH+Hj/BftahdV1BF?=
 =?us-ascii?Q?i41WAAfQUdzzxlNVDcmOsQ3C/u2CJ3FHbNcZyqWTblFj8KmtTdkRBtN+u6dN?=
 =?us-ascii?Q?+q4ozUyPpWZaPICCzoLujoArZgXNT+U9xtU4ZA4Vew20rEAejnH1+PH2mbus?=
 =?us-ascii?Q?zE8J/X7JrsfBsNYfYVfFGE3FZe0s09CTPaS2zQ2FddzufaO/c3GJSOSHtmY3?=
 =?us-ascii?Q?RAj99fYmYjAUgiFDt8JmUajg26p8LSoDW2mV5Uxi6NJPxaYjHt2pOoMiVMmd?=
 =?us-ascii?Q?Atmpjg72L1vJdmRU4yGOftu/Tuk/DhmBCAwa33jbrDeLOQ75hvyqi4WLZxLu?=
 =?us-ascii?Q?aTXDYU7LNp67FWIcndw9q7t/EDQSKWR/dy/qBVBR/Sr0cfM4K3Su/3x0W5AN?=
 =?us-ascii?Q?NFfAIa90KKISA6NKznVUfsq+lDF5Vr6gTz0asHT4gGJyF6KDJ+WqMlql4GTf?=
 =?us-ascii?Q?yG/T9F/mG9PlpzXHtUE/AsIlYf7in82k+qdrnxNlkR87OH6h3bZIxTV50qQT?=
 =?us-ascii?Q?WvGYg/+pTbWnCYMYGMYB+aFWvw981caQN7eGz3z1l7Zq1DF4KPaf8UrmQaSS?=
 =?us-ascii?Q?qNtJVv1i7/S3Tai+QHkGYIaGuKrfnRYs+3k6uBqbjT3JM9c8buG6p5X2lgGE?=
 =?us-ascii?Q?VR3qUlTcfUDD5ept2B0fd1Y8wQe1ECoC/Xlek+qOq4doNSUMZzMAwHGRhdrn?=
 =?us-ascii?Q?GvQT3BMQA7b6csZjifXGd1GGV5PAITYaYyiNY42C25jFEj04ffjQg5Vzutb6?=
 =?us-ascii?Q?RuAuO5UlXapLOCJAPiX904pl0UYap29RmjoJ4RvQbqy/y2DzvvE92CJesj3O?=
 =?us-ascii?Q?ybfqMvKWUeiFkkPSgRA1xv05nTdaJMWLFML1j0631+IH9g497qqzqtjmyDhl?=
 =?us-ascii?Q?PLIBu7CkYsHAzIsXKhPsV3Z0JEPZ3D7V9Wxg8g2JTY0zyhO4j5cvQ83gwbBR?=
 =?us-ascii?Q?kl8M5kIHsrhvNQu8HZVvVgVKL/9lgw1wA0EnXmPTX0BJrllFubBFnyM588tq?=
 =?us-ascii?Q?OKJ79mszUpyjhhFYhngctgRqTbSqSh7FHkshtoBvoomV9O6jsTz9BZtTIHBv?=
 =?us-ascii?Q?BZW8GCUX9qc4MO/T6T5/1GXj71bqSsZNCmWxmtbbhosq7XJnOiqKIYm1USGj?=
 =?us-ascii?Q?vh5GIvrzdOhxVj/g05N2jyLRBX5GauaL1gGx3cSK7prKiLANAK/hDbSioO6g?=
 =?us-ascii?Q?JHHcDjZPQFYPgD+vXCpb04LRPBR4FM6VWW+PLAipcEovUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2rlxTm7O5OoDSovNO7FCuUSW1vtiOgG5OCZgixpu5io4NjhNumHG6eOlLSvI?=
 =?us-ascii?Q?nSvJdtDfPmiLR2N8iW0H47r9+je1klSrYOkm8SJwhwo0yuCMQzANZNSDXFP2?=
 =?us-ascii?Q?NecSmSALPMizkUFwapLYhjBiggGJLVO9j5+NN0kk4ug3kMFuYS1TRSW6iYKT?=
 =?us-ascii?Q?kbixGyFXM4cT5lyzhcoH4YH8RIDoaIpqPV3Khk4OKqDjwpR5BEpb1QTSpZzM?=
 =?us-ascii?Q?OwNXQwS0I3AJoSrT+5MLPvfWjR9LFqLMTBWDVE4iOorJ7xd1wrEk14ziD5T7?=
 =?us-ascii?Q?K12piP6Xc2FYRu6hpHLmkt7ylD9v3uBQSi/vcIiIl4lWy3w9pej1XF+U6C7C?=
 =?us-ascii?Q?GkG+m1LehelytmpWlEZco0uKNpkpvLxf/Sxep/ztLw5OhIh5l2AgACOXdH22?=
 =?us-ascii?Q?GTJKKvfIBSSKHCWdagSmzjOn9Zv6QzIIYuxPxdfCh+XcVpRXfp0ambCEQYe3?=
 =?us-ascii?Q?Trtqt5LS9Wpb0UQaAtgiYtlgVZ8IdM1YLEfmZrRZcI8keEezu0ah5uAQmFtZ?=
 =?us-ascii?Q?ChTB7aWa9zEXQj7gizxIjcQNxm2Lff/xzyrEfZzEFEOKCPvPh6w12eZ1vL1o?=
 =?us-ascii?Q?TmW4Y97i3czsKceCj15HFS9FSEC9+d1EauO0TkwUwv6Vzj1WhhLem0bQ/B50?=
 =?us-ascii?Q?zPIhDnrhd1wAJfLnFd65RW/TNIkishABp/Zqrbm60UhPDitpaoH4M3h0IjXd?=
 =?us-ascii?Q?/9aVCz8ympxXT9BspEWQDraKVm1jh0RQqRNXnOsMCPGMSSf5Lk1AwOkjcKZq?=
 =?us-ascii?Q?nanVF3LkhGsFu91DQy6gFRkPr78lpgEf4i4spy5eWDardF3ifWJ1KUsf7Vym?=
 =?us-ascii?Q?+CcId1WaRVf6qvilADGXGPT2u/Y8hl71PrhigkO9JTeE1DTd/yoBNNf5ot4J?=
 =?us-ascii?Q?TpO9ZspeszKCscLbAcBXBTgRGJW71wC1kjKJ7r0CCgI09TD/q3d339phdABp?=
 =?us-ascii?Q?d7WUZNqR5n2JIWCrgq3Ar8GzLEXDKULKqWgSY+mlyFEwM1RpmvqOA53Q7xCI?=
 =?us-ascii?Q?DylwNHOnkJsrf2ITUvbdtqB9DOoptK+H2lGgL9HKEodBnBsC/LmCvYs/KEbm?=
 =?us-ascii?Q?imMtnkTC3Osko9uaHxKHgIrIo20crSPoXL5FjMrO+jDYBO4ADu4CWgMTtcbq?=
 =?us-ascii?Q?tLLxVMQRBcINfotXTkHiA1j+Z88eHTm7LB7Vf/im4xjmVTGwFl0Wn4un3QT0?=
 =?us-ascii?Q?Omv2SyBnt1vUyTq42P2qqiSLEC2ErGwObmyKZuwhqcROlu+Rbc4ZANXu4LZG?=
 =?us-ascii?Q?PWv+0dec4SrfWAQTUhMD6TQKmqktgJprRZ6OZTWsFDE8xTgL3HqNeoULw+YH?=
 =?us-ascii?Q?pQXJE2yabp9Xilc26CVqpq/YUOgGsGq/8s0yqVnRThOlhDz/Q2tz6t6kgqKZ?=
 =?us-ascii?Q?0Mbitq68S+EMxZpcmzn/n7yO6zFvkG0UJ5gYJhe19ZiqFmHxxvCBXja3JRP1?=
 =?us-ascii?Q?KhHZsYkKzw8lXSs0vIi6OyizbFCDxTivkfHEd2nMOJ8wVE4DiySUb/9UBcmg?=
 =?us-ascii?Q?hnDOB/48wa7c6fhm1VOPEkA64N3y34zKA8qeZeHJPNB094vP1ZduxcO0mGQN?=
 =?us-ascii?Q?KMjAlHLWArVYIZezh+LX4i8iXhf5KuexAH9easxS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ae34e1-f0e9-4be2-42ab-08dcafe342c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 15:29:39.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OodJ6Vy38cQ/6GU2ScvYaobtkfKH4ut8dgJx4O2NxFnUhLAOVCZHuCf088inxI5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

On Mon, Jul 29, 2024 at 07:56:07AM -0700, Jakub Kicinski wrote:
> On Sun, 28 Jul 2024 11:49:44 -0400 James Bottomley wrote:
> > cross subsystem NAKs
> 
> Could y'all please stop saying "cross subsystem NAKs"..
> It makes it sound like networking is nacking an addition to RDMA 
> or storage. 

Well, that is exactly what is happening. You are NAKing stuff we need
to operate RDMA, DPDK, and other parts of the device.

> The problem is that nVidia insists on making their proprietary
> gateway a "misc driver" usable in all subsystems.

Sigh, open code is not "proprietary", we've been over this.

fwctl manages the whole device, it is not tied to a subsystem and it
is not "usable" by any specific subsystem. This reflects the design of
HW/FW that is obviously not split up into per-Linux-subsystem
blocks. It is technically appropriate that is global and not somehow
weirdly split by subsystem.

I'm not going to backdoor generic full device fw access through RDMA
into the kernel.

> If they want to add something at the top level, all affected
> subsystems should have a say.

A say is fine, but it is not like netdev is suffering any real
technical harm to justify a full blown NAK fight like this.

Jason

