Return-Path: <linux-rdma+bounces-8841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53FA69914
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34610982042
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93F211704;
	Wed, 19 Mar 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BUJEK0Zh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC42F37;
	Wed, 19 Mar 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411994; cv=fail; b=Z43Yv45R/Ny6qraSPr/js9LPIQOgBqUiYSW8Y0W6TiwvwStw9dY5JJ1unIXbyqR9E6JI51kpzaabWBYUfW6bW7UCGkqx/LNF+n2nAsvcoeZIV2W4GO/PvuX4IiTJCxpT3MU/PFxLGPU4SEyWn8A+9N3rgv9PsLuY2ygxLlRiCi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411994; c=relaxed/simple;
	bh=3eGoRpIc1W89uHUrKxij7Pj/nwP0EY7oWrApl+jfyX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LuO6pXHJYekdQh7xST6AWRORJUiKyLKG7d99Z15uGfH+7GoFO8aQ1mYvG3dLRdHVlJ04DEh8JbQxti/hYYXRePUaAzFbKfPWoaWqK0Y0shioJ0nO3jn97LA02gyZ8n0NYmscZUqDD0wDmEMIvbYpIhHtvYabK2zMWmRsMTxtgEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BUJEK0Zh; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN8Ew2SiiCyq/uVr4zBCvh5HXRx6MVn3RRAwFTzHzfbKy9JfRqfp1ujcu0jD6dn7ff/QTSV+EoAVGtptvloGdb7MLtkztrmwL1cw+TCbtSESpDyBGpcsvQKAugtGyr1GA8LNC8FUDy1nyNQQZ+0dSTR5e9mZcIhKIiwmzwEs65sFYL/X8M+FpM/4vebCVIZbN9/Wqwl4Ikm5QE189MQW1MtMUpzVNbfFc0g/mqJ/7vX1qtG903zFIMM7jPJHMYNy5SlKexB/EDFBlAxeu+FdIm16V3vmvkTSJawdq9hBpJNg1nfhIicOFZ5SlLR8RcZeeyIwKjOz4OEFOUeis85w6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4FF+NiNAEhP1ddZxr/48VuPN3ktY//8Z8V1GYNz9YQ=;
 b=JVsSagF35H7UnueRvbxMh1rtjWZCoHBIaCUTEgTT38y6umpbwPKDg8OU+CrOebOPb1TaFYVfLHC9aQHlJdoOnV82pp3o0wOq2NCSnHTINxkvHTkakh/M5JOUI0kPQOaCZuBA57ge+3JQ68kyzXFmJlDLNsbezf/0s9fr49veRALj03yhi3rDfd6uNmN8QKtt8OjTknBlXKRVUxkaB21NN2KFr+/xDbzOBxmEDs1v4hq/H3PN0AVPo5JzKqFdtpW0mOPforvKc3bU4oKc7RtWMUSKYGuI/NRZdK6LW/4K9x7sF23t5k/euQVBSu3RehM8SFL0lJ3SU2Dz3+zb87moEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4FF+NiNAEhP1ddZxr/48VuPN3ktY//8Z8V1GYNz9YQ=;
 b=BUJEK0ZhW98QGtywCcb19ckcEXMAjkJ7lEDs+is5gxfhlFFEt20EXCHn+nAwQ9RYacracTHcjAXSGeKR40B2zndW6Qt2K9eQmowCzb1Zg1N3okjL/HgSmc3OqjjlinqLRDxc8DQgmSDm3fvczHA8EmJo120fWWOMv0ug7iCtxXZoN4OT7WpDyJBmwHf7xGYEGD8flFAbneqKDGjvMU0i43azDlSPEwlAC1URYXV0zs+0Udi6oHvFpq4l/p8A7PzJ9aDQ9UvZ9zIwoJCXDOf7nQnXKP6ZBUyQQKE0115nR1pVP2CkRHSIRSJCTWVOTm9o32wh2MV+LM+zpy7A9QFGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:19:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:19:47 +0000
Date: Wed, 19 Mar 2025 16:19:46 -0300
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
Message-ID: <20250319191946.GP9311@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com>
 <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e99eb68-a87f-4605-53f4-08dd671b0316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s13C8vfsBUUM7qRswFE84RGa+Kdd9jxvOZbM68aO/eSTlCymSIW3w9K58uaD?=
 =?us-ascii?Q?mm7R9Vab/c4sbQRTF+47APcqYLiYeop/8riDbJy5NXKSHCWs319l4kLRHxfc?=
 =?us-ascii?Q?UKWWb+IeVhpuEqwe7H7wiI+AZXXJdTlbd+h06tgyTNvH9V2EP2FGcTteDSNt?=
 =?us-ascii?Q?BE8qXUQ1/ozffT0kUTM2kZroBw/Z4lNiLCHjnQifVRnu62CLaYqg2H2usas5?=
 =?us-ascii?Q?Qz6uxAekyTR93Eo/jTJpQu259pakv+2HdGr3Ob+Q9R/QGdedBgcvOSSFo4bw?=
 =?us-ascii?Q?NN1BTl2ftZtR0WlLw6DnWe5/5qQdYUqzmjVHN0UCXIlhQvhFulE3A27A80Ah?=
 =?us-ascii?Q?0sBtu2nOPFr+t2QB6AyNTB1lB+gQ+YUUleMbC6p+KuSG/qCnBJ2JuwHqeJ2H?=
 =?us-ascii?Q?vEgH4nA5nrVzSmNLhC3DC+Ffg9ah+4df6K/Dshpj7URR4dsSyqjqsmsvJ9tu?=
 =?us-ascii?Q?1Pz55iJMxWjqldR3xM2p8e1yXQHdzhjtSyBTDl/kcjdf0w5iFOgntSOU0dt8?=
 =?us-ascii?Q?0buArfBh0XkfYxI2B2am6+uzskKXI7sQwOBlbSQoYlu4X/8I5cQIKftxNH8j?=
 =?us-ascii?Q?8KMAnMpBy7HBLw6JM2OnYRAdb/lXKHpZn7SF7622onfYhizqVz4z+e0Q/+Qb?=
 =?us-ascii?Q?MfWXS5nx7ETGYUzTd+7nc3QDATErCyzJH2FiWThUZpNOrATp14H4dLE7N7Gw?=
 =?us-ascii?Q?NXrjrm0xdf+193nrs04REIcjx4/yIAaLpM27TBx4WUvUn8ahuDWa5/g/jyrG?=
 =?us-ascii?Q?EFY93z473XkyJdwV/pMXFnuAUIq/Njsb3oX7zv00A3uLlhNoiTswsVNEV+yo?=
 =?us-ascii?Q?GEnYwppzexWNnSSoa8+QgcSVeZYSkEFJKuvZ5yybXYMvWDm1AcbID028axdp?=
 =?us-ascii?Q?hKdLCvZr/5A0L82lc4TtxQM6cgL+NMmyMSBcgm5PMD2oc3q6lUL/hdMDRLN6?=
 =?us-ascii?Q?OLJn5TipYJQ/W6E9oFr1uUskCHUacyeav8bePAezGtZfhwTlrY00oiOTftIJ?=
 =?us-ascii?Q?9Uj9BQIHAYDgF7DLPzBOhjgYFRa8LDSkrZgUUoOZ5xGJ3s2XjSIJElXCInwA?=
 =?us-ascii?Q?zTlsqf2dDrUiZ/tjEh6MeVaXBoL55h2U04bARQsq6jHIg3hZoOj+YDyPCOsj?=
 =?us-ascii?Q?3kL84pnJq1Sr+T5oqHzkDyCdkzRGBnipzoL4qehUS3BJYr5XAIrhFIeH5EXb?=
 =?us-ascii?Q?YXFVjqQqulkMKigUtjfmlEePJ9JRdVJft9H942lbQnvGBxk0yFKBZ4unHlnp?=
 =?us-ascii?Q?27pU9MH6y042VypmARogm57iBuziUO6J/L1K+7fnHZHwEshMGdGPLoFk2GoB?=
 =?us-ascii?Q?yRwu2nDoJn5DCXjFjy/1ZEcR5oweOS7GIAOP6OVb3TBVZpajy0snTFH4SpfY?=
 =?us-ascii?Q?nibmGZDsNe3YZ3r+oGKdOXgTAFCw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYX2clethza10UnXnoiZvtoJ1x/bsEKU96VvwGLmeI/kFYjEej2N9JxU5haw?=
 =?us-ascii?Q?WMTrMfN67VISkQR6ALWSrMBYBYwzacHTosdzyh6y22YHRJ/8+Shr9p81gZrL?=
 =?us-ascii?Q?IvmE1aCh+uUqPnV5Gzb+7kmyYYeg9J0Sa6/SCCr78FKOGteJzwszkjnd81gT?=
 =?us-ascii?Q?mdyVc34eQsVaz67N7PACaJoBUIt3FmK/c4aNhwcURtTss3wLb0oLd7soq55F?=
 =?us-ascii?Q?QYZ03s2Ztdk6X/S95OO0WnlzHEN7y8qz4izumkzc0C/ku8m5gLZ6g160vFkC?=
 =?us-ascii?Q?Ucl7OBKysl2qMdV8qjbNNgLXYIGZ4U8dvTLYbZ4PRNcszSzha3lQXE44Rldi?=
 =?us-ascii?Q?txUU9aqTVa8JTqUeLSAsfypXVOdrt8iOViBfjkH9/WHIis0YiQtfE35Et2Qo?=
 =?us-ascii?Q?xjT58vAp+DSBPSNq9zv6NLwkxSyIi4Z3zLkHPcR9zJ3r4wVogqswHwrb/anl?=
 =?us-ascii?Q?K83z5AX780V12xDuqj9PRppgjh8itfdA1q/8LIX1qgjg08EsqzXaPQ3KQtyn?=
 =?us-ascii?Q?68s3UzbMCVOMpiRFQxsnxcOSPFOtlgkwS+YF8psbKY0p5CUX3X/LHKG+hKV+?=
 =?us-ascii?Q?a8paiWF0O0t8EOQQKv1UBmBeyXFrOySDooG1r3DcxjFXn62/1KPSsf8my4Ig?=
 =?us-ascii?Q?/MLNz4C9V4uWSdsuwUW0OP2gzXpon4DbONKQd797hpGWN8qF+1lcSidYdq8s?=
 =?us-ascii?Q?Oq4HQEjYsLwK/k02bU3000GX23ZWJQ+DojNogzfWm6w/uNhUGZghvw1lGhJx?=
 =?us-ascii?Q?YYrZM3l4u1OAvOqh+kTpYny+rZ8E3LhLpuTvPhWafa7NILGArt15m0KhJMS9?=
 =?us-ascii?Q?aqaaIMRpkPoFHgcnBwT8PWEq6+JlU669Mv5xqj/vAQ6ACIIbqkGQonQYILs+?=
 =?us-ascii?Q?ZVw9NexzDRzH6fLXHsvfwzHECUoycejP/hq9ltGbNS9IX5ruRsrXdIpOTcmu?=
 =?us-ascii?Q?uTvQPCsesaTcppx21sftUE2QrlQxvPicEqu7IhttZ1WD1CjqI76O19/c2QEt?=
 =?us-ascii?Q?cbD8gcTQ1NfttS5P0UfnJlm1YmAD/u+wP8ekN3112zpOZkgWVzU7USF0/BKJ?=
 =?us-ascii?Q?E225QkWh3qCq3W7yo4yC7ec2PF/rutxRIc0rXxDVO6Vd8S9mDvpfHStxGWc1?=
 =?us-ascii?Q?8sBMOC070J9n3H4/Ie+NI6pBwaJuihMhLFNC3G8II/+8wA5WnFxinkCEwEqA?=
 =?us-ascii?Q?06Gr4ab/XMZZ2FrKqH3DnYCDDw+Bnq0jnn+39OxbwcscMAwlXJjhybt8iCxl?=
 =?us-ascii?Q?Dw/KiG9N5MRyPEVJvic+2cE4oif4NvekVYvej2XsgSynfwEjv5/MmAOqaaUL?=
 =?us-ascii?Q?xMf9sLF6xl8OhPgBUjmNY2mRH4i3VfA30+QO1hGoi5/4CTd5b9kdJUfle3ko?=
 =?us-ascii?Q?ydFKJ5kkHA4oP2ZJmqBSALXbUkzpRkdOfxZtSp7JXtu/amqmQnfYNiwJvbKc?=
 =?us-ascii?Q?tRsJsf77BNdlYmkUXnPXlUOJehzIu/BEfCOHlnlYdWCSZ0Fay/Eryo4753DI?=
 =?us-ascii?Q?8/xv1pXN7mNq0BBXPjFwFjmWqBwrGKXX2OvJajJeRru0femcd8j5G/RcT7dh?=
 =?us-ascii?Q?MKAd540L13c2fYRio3k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e99eb68-a87f-4605-53f4-08dd671b0316
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:19:47.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vgAth+BgOTqJRuJnViYLe1zxAXhsHQUsn0RQAgAF8Zyeaspr+Slh0cuU2tWGbwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

On Wed, Mar 19, 2025 at 02:21:23PM -0400, Jamal Hadi Salim wrote:

> Curious how you guarantee that a "destroy" will not fail under OOM. Do
> you have pre-allocated memory?

It just never allocates memory? Why would a simple system call like a
destruction allocate any memory?

> > Overall systems calls here should either succeed or fail and be the
> > same as a NOP. No failure that actually did something and then creates
> > some resource leak or something because userspace didn't know about
> > it.
> 
> Yes, this is how netlink works as well. If a failure to delete an
> object occurs then every transient state gets restored. This is always
> the case for simple requests(a delete/create/update). For requests
> that batch multiple objects there are cases where there is no
> unwinding. 

I'm not sure that is complely true, like if userspace messes up the
netlink read() side of the API and copy_to_user() fails then you can
get these inconsistencies. In the RDMA model even those edge case are
properly unwound, just like a normal system call would.

> Makes sense. So ioctls with TLVs ;->
> I am suspecting you don't have concepts of TLVs inside TLVs for
> hierarchies within objects.

No, it has not been needed yet, or at least the cases that have come
up have been happy to use arrays of structs for the nesting. The
method calls themselves don't tend to have that kind of challenging
structure for their arguments.

> > RDMA also has special infrastructure to split up the TLV space between
> > core code and HW driver code which is a key feature and necessary part
> > of how you'd build a user/kernel split driver.
> 
> The T namespace is split between core code and driver code?
> I can see that as being useful for debugging maybe? What else?

RDMA is all about having a user/kernel driver co-design.  This means a
driver has code in a userspace library and code in the kernel that
work together to implement the functionality. The userspace library
should be thought of as an extension of the kernel driver into
userspace.

So, there is alot of traffic between the two driver components that is
just private and unique to the driver. This is what the driver
namespace is used for.

For instance there is a common method call to create a queue. The
queue has a number of core parameters like depth, and address, then it
calls the driver and there are bunch of device specific parameters
too, like say queue entry format.

Every driver gets to define its own parameters best suited to its own
device and its own user/kernel split.

Building a split user/kernel driver is complicated and uAPI is one of
the biggest challenges :\
 
> > > - And as Nik mentioned: The new (yaml)model-to-generatedcode approach
> > > that is now common in generic netlink highly reduces developer effort.
> > > Although in my opinion we really need this stuff integrated into tools
> > > like iproute2..
> >
> > RDMA also has a DSL like scheme for defining schema, and centralized
> > parsing and validation. IMHO it's capability falls someplace between
> > the old netlink policy stuff and the new YAML stuff.
> >
> 
> I meant the ability to start with a data model and generate code as
> being useful.
> Where can i find the RDMA DSL?

It is done with the C preprocessor instead of an external YAML
file. Look at drivers/infiniband/core/uverbs_std_types_mr.c at the
end. It describes a data model, but it is elaborated at runtime into
an efficient parse tree, not by using a code generator.

The schema is more classical object oriented RPC type scheme where you
define objects, methods and then method parameters. The objects have
an entire kernel side infrastructure to manage their lifecycle and the
attributes have validation and parsing done prior to reaching the C
function implementing the method.

I always thought it was netlink inspired, but more suited to building
a uAPI out of. Like you get actual system call names (eg
UVERBS_METHOD_REG_DMABUF_MR) that have actual C functions implementing
them. There is special help to implement object allocation and
destruction functions, and freedom to have as many methods per object
as make sense.

> I dont know enough about RDMA infra to comment but iiuc, you are
> saying that it is the control infrastructure (that sits in
> userspace?), that does all those things you mention, that is more
> important.

There is an entire object model in the kernel and it is linked into
the schema.

For instance in the above example we have a schema for an object
method like this:

DECLARE_UVERBS_NAMED_METHOD(
        UVERBS_METHOD_REG_DMABUF_MR,
        UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_HANDLE,
                        UVERBS_OBJECT_MR,
                        UVERBS_ACCESS_NEW,
                        UA_MANDATORY),
        UVERBS_ATTR_IDR(UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE,
                        UVERBS_OBJECT_PD,
                        UVERBS_ACCESS_READ,
                        UA_MANDATORY),

That says it accepts two object handles MR and PD as input to the
method call.

The core code keeps track of all these object handles, validates the
ID number given by userspace is refering to the correct object, of the
correct type, in the correct state. Locks things against concurrent
destruction, and then gives a trivial way for the C method
implementation to pick up the object pointer:

        struct ib_pd *pd =
                uverbs_attr_get_obj(attrs, UVERBS_ATTR_REG_DMABUF_MR_PD_HANDLE);

Which can't fail because everything was already checked before we get
here.  This is all designed to greatly simplify and make robust the
method implementations that are often in driver code.

Jason

