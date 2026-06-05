Return-Path: <linux-rdma+bounces-21862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QhqfDAYMI2pkhAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:48:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9264A4F4
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FSDYGN8b;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21862-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21862-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43348302D093
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567B39DBC0;
	Fri,  5 Jun 2026 17:42:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631D28643C;
	Fri,  5 Jun 2026 17:42:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681349; cv=fail; b=Eo0SvrIdaU2kHu2fFiZ3I7aHJ1C388TPWtj5A0bjyLTwt0sguqFRfvmBTyK9ZVKjFPZQ//OXJCx4mMZO71OMcrmzGNdZhctpAYlWHTlJ8RRiRFTsN8+XxrdKEuYe4iP3jj9M3qY6jKxEJflOWeZdB4VgkutFIV9swpGL4SfQrUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681349; c=relaxed/simple;
	bh=IrF0ItQ3RIjwHgeq5Yp1ZdxMvZvn/9qYkgEeW5i/Au8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jzV/vInMD/c8ybqaL4na2bRPXSdIXUt312tMVIIa+RKFPLnfa9KdacNNqknObodSGgeHbQzWM6UonhVGHUw39ZHgV+q/jQAMd2paVPnueHgvuN9kBdpDx1weYEJGJT3e0hZ6XX8eKOfaV0DVJMhaj/3Qd7k7/2CuiFlHP7UUX4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSDYGN8b; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7VZlFlbUJQbqb7KjX1q/8CRdhFfyMjcvBD3d/9loQAUlPeaHgSxm6CZHWNOLD9zse333finGMJc7A2WyVumSUaIgP0WtMXHHQ1huywYiLkJGtpBTj+nzHXbsW0twdDOjrYqXIQ8FG4USfVVFW9N63zlUNWJJw4oDZK8eWIpS+Jr5stpmyhBUqzYo8L80RRjEXN5dnOWY2Vy52mesPN8oyowwZyMbIovSWR/SqxG7W3+/D6EKdWaoD/D+GNnVTgdfrwu0Oj93VM56tEKIAhPpL7Sk/454N6mp3KPZUeJbHfCLnNqREYOH3xPPqKpBmnuFHZbKFHScJeQSnwwnwNPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1na3breKKWu2a6om/2PxHDnJtLblWuS6PCAdA7fP82s=;
 b=UU8Zny3/ccmBo8Vh999pbKQp3xb12x5IKxbTWIjqndteUjv7MYi+aHALHtIihtHsvma9FEKdKsA1cCEoDa3S+X1nuXdXpvtE3WQ6+xlO32JTm3AYLVA3mF30QiQJBdTvbyBUN3X2633f0yjkVz4q1Ge6+sWTBnTUvJde/r3Ai1zs/U7CKrLj0ueR6HWIJIRWa/Q3lccWRBSk0HSZW1aFIgAMZkiGfC0FZU2p3aGKRYpjwECGSK5Fwd+xnSLaHOJZe1y1E2n9cgSRjr46oQx1mGCZasN1dy9ST2QMDiXIV7BTfoYWJHnYzO03F2WG9Cb2SiYcCKcYEc2VDVL7YrYaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1na3breKKWu2a6om/2PxHDnJtLblWuS6PCAdA7fP82s=;
 b=FSDYGN8b8rRX+iO4qC8cM1J+ro0z9SAFGkXar4zoa3EUH16LDaV9QcWlevMnAH0zLEaiUMmcG3H5WzQejBKicOBq7Q1R3VeGEVOO+vfjHr8qo02hRd/UZy4puCxRwBD0PLt9pX2IlgJ4emLtBUsg3CPX0+8lZv0FRwNWdBCPL/LoISfrutC2/bbTEbzNCe7a7bGVkLMF+Ad99//pRb5FYALzQBd8IPet9Pi7fDs7gcZaFNzvleuIdtYZUtAymyWO8U8qzqZg/JNVNFDrs6Lf/AkYqnMcu4s/rZulzSHcD1htf8cIK/t3KohaDj1cqN/oQNVhAUBVIfbMSQLZfwLJCQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:42:05 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:42:05 +0000
Message-ID: <3e8b0954-5f63-424e-97ef-ba841cc8f2bb@nvidia.com>
Date: Fri, 5 Jun 2026 20:41:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] devlink: Add eswitch mode boot defaults
To: Randy Dunlap <rdunlap@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260603193259.3412464-1-mbloch@nvidia.com>
 <20260603193259.3412464-8-mbloch@nvidia.com>
 <d276e842-dd8f-40b7-806b-71572503005e@infradead.org>
 <e4aada53-fb80-41a8-9a8e-d19414f6466b@nvidia.com>
 <909ada9a-a398-4e3f-8ed0-596a1e4bdbfd@infradead.org>
 <91d12ffd-6bd9-4951-8351-655262d44874@nvidia.com>
 <fa19f1d2-832b-4b9c-824d-29ae48e4bc2a@infradead.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <fa19f1d2-832b-4b9c-824d-29ae48e4bc2a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a1f4e7-3f97-4e0a-61c9-08dec329c258
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|11063799006|56012099006|4143699003|5023799004|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R500DLeM69yF0MCgy/d8xdAk11nhfWhyZU4qvWiZO6dqejtsPStNLLg3zfObg3RDF5WAp3NfRl/EUlir5nlw37Jmg+PG1oIFOXDKvT6zqajIzWM+5lxFTW/ncS8OmaY0X93zYi5hs8WpWskJ6U2c9b5FUxn6hYK5YgMCFtiRqzXsZZ9FFWpsGUzu27slwR0Cs/zbQ9BllwCxVHZJtPm6hmZBd0CR/7q6tcZFOL0KR+tLFFeRFV5SyWPzRTyu7bsYiKyoHQtiNCltz2oxnGH0ouSI7FvlIOv6VyCM6sXvyleVLhKUJwnnp+4rDDYJ0DI94M/C2DiQza1fFiNAypFQVinagy3zHnvOrdVanAVaXRsL2EfTrS+sm5Szt+jMduF6jDvMfjb8gGPzYeMgMODD4K2AYqeJSTHuIWP+SDTdh4KnW6Zb2chMuTRVMsPs8qZGEcfuIGzRtKUCO21ZV2awh+Vz6hhYZ1faTOYo2uwuqKTRzxSa6tmOOmz7e9PVLq0KpqzeWY+tNZusONwXooPWouxMOqE5HBiMXNC2qMskLj/XptYCMjIViLRrND5kXW97bjfgm2SXTLIyIeYH2OxMQdOa+6qhmqNzuieQMf7FnjJ1PQd8vTImMD9Z4ApxnP8QUV/8rtm7Eg29NIxuID0CIvKzwZzacTnUi7Lmx+nxwHq2fsHE+J/krDEj/5ep3OAH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNLenNVS1gvYU8veDhBUlNBQ1M0QzhUMk9nb01YcE9WZXIxaDVJSUY5enVE?=
 =?utf-8?B?QlFhL0U1SkFiOVJaakJvbEw0MUFCSmVxQ1E4dXV2UEZ6UWR5cVNyRzFVUjVr?=
 =?utf-8?B?VlZWalVXSk9mRko3L0x3dzlRZDFqQTFUbklEV2xVREFUcG5QdVExdGtrZ1Y0?=
 =?utf-8?B?VTZQc2QxMDdkekN0d0xhZ2VnY3ZXbElwZzBHSW40MVFlZkhWU2lZNUdnS1JP?=
 =?utf-8?B?RkhDRXVmcklPWndmM0lITXlmRUJkMEZEbzdTd0V6SnFqMHpuWGNUQi8xUUVj?=
 =?utf-8?B?cjZ0OFNHU04xWGphOXNYRjFPK3BHbDZkYUl6blZiSGVhR2dwY1pBZ1FHZEVQ?=
 =?utf-8?B?Yy9xeFg1TXcvd0xDTFFhcElKeTJobzFyWkJNQ0pkaGhRV1N0cGZlaiszaTN5?=
 =?utf-8?B?NC9oYkhzWkVxcXU0MnZMZTh1dDBMVkYyTUIzd3JMZVJrZnlNY0RoaVRzMzRy?=
 =?utf-8?B?REhSVEE5TTN2OHhwdnhRSjZMakpwdUt5OWI4Rnp4cXBWbHRmWXdOUjFYbjhG?=
 =?utf-8?B?MDZIbVBScVpTRnhaNlZzTVNsSi9XdHpkOFE3ZlE1WHhIRFRRNVdhTkUrSDRC?=
 =?utf-8?B?OHlWNTRlcFJmMGNJZndZQzF6M3N6RlhSS3FjbUl2QUpCdlBtcUFKaTJiWE9S?=
 =?utf-8?B?d0Qxck5GWTAyc2tlS3J5T0hFSTd6MW9DNzZGK2tSOVdBNExIbEw0Z3pzRnVC?=
 =?utf-8?B?aGtpZjhsMjRIR1NNUkVmeWh3OURCU0VjQkt4WnNqYUNJN0ZXbjJDcURMams3?=
 =?utf-8?B?RlYxSnpZNkppODZuYnYvN3ZoS3hOZE1NamU3cEdHSGd6VnR5ODBiMm83eWtV?=
 =?utf-8?B?dTFWMDltY0FkL2U0cGRGNVFYRXEzYmNVUDVucWdSekpiZ0JLd1ZDYkpUN2FV?=
 =?utf-8?B?bnpUdDNlRThvbk9ickdQQVdIbmdQUWRhYjJQNGduT1VwcXdOSnlibjlsT2VV?=
 =?utf-8?B?QmZWQWQ4M1VNcFBYcnNUbXJ1UmlSalpsZWZEYlZHaFMvQldGYjhTUWFkZjZN?=
 =?utf-8?B?NDZ6cmdFU3ZBaDhiblFwL0xOY0R3Tmd4VkFsN1ZZY1FCbUlVRVU5RFJTMXdm?=
 =?utf-8?B?VllEWG10MytRUTEySndXMW50aGZJQTlJWkxTMEpRRUduVkFZSWgvZm5oWHVX?=
 =?utf-8?B?L3JsYm1PRjd0ekRjT1A4YlNId0RXT2xWNTM4L0U2d0tRbTE5Yk5xZHdQb0x5?=
 =?utf-8?B?SWJwNWd5ZHo2OWw3ek9kcy9seUVjYnBYTEN2TDQza2RQVW9YYnFkemZVbTlV?=
 =?utf-8?B?ZDd5czVVbFM2dzAxdk5Gd0p3UEY2SEdBME5Qb3NTNmgwZUtjRml3K1lJVm5C?=
 =?utf-8?B?b2F3cXUweU0ySmR5ditzcU9qZS9Dc2lGV1E0RDFpek01bEVMUXhTSTJmWWxr?=
 =?utf-8?B?UmtnS2VMYW41bWVBWHJFNVBtbG5UTVJnZ3BNbzg1Y0MzdVExS0NqU3pBQmpK?=
 =?utf-8?B?bEc0cjFGRnlhcTkwSnNXYWVWZUhiNHRrc1g4a1NlUDhpU1hMQ3BrNkErUEpo?=
 =?utf-8?B?VW9sWXV3cmh0NFBsUTA1RGJJeVRhbGYyMEViUFdqZzRrek9HUGo0U1I5cFVa?=
 =?utf-8?B?S1BDK08wa3MvMGFTdllJZmtiY3ZOWU5yaEY1R3lzNTJqN3EzbVRsTmtRdzBV?=
 =?utf-8?B?eUhkNndTNks0M2w1OEt2WXM5c2Q2RHVycEhidmp6OEdsQzlKOXN1N2xINXV5?=
 =?utf-8?B?UnYwakNLT2h4Y2pTNFVZT0hua0lxUkh6MEIyWXZMTXh6VmlJa3VHenoyRE00?=
 =?utf-8?B?M2VyNjE2SklYZmhId2FDWlZ5Z1VJSnFnR0gvbFMySGJlcytXb3pjdTc3UGF0?=
 =?utf-8?B?UkZxUHpCRlVmY01lekU5S2VVSUFJSHVFSXVBQlNGa2IzSEtjVCthUW9qTkhN?=
 =?utf-8?B?eWEzRUowR2MzdFljd1IyVC80WVNjMThFQ0J2T1RvYVlnT1RWYldkS0RQcXVK?=
 =?utf-8?B?QXUxeDkrSkNpR04xVDUyUXd3aXRPWnZ3UXJrVGlaNTR6T0hNUmREWUNoaGMw?=
 =?utf-8?B?dm5ESzQ5alVqdXhVVVF1M3ZqWnlMMEhsTERKL2pnZmF1OEtNREdWZG11c0li?=
 =?utf-8?B?bVRDSXFOWTZBcEpMWndGWkc3amMrd3pMMnRxbVJyUUVyMktBZGtjc3RVeTdX?=
 =?utf-8?B?Y3lUbHRwMWlzcHZjS0VscXA1QW16WjVQajdPZ2tISU8xVFhwYmxFeit3MnJp?=
 =?utf-8?B?d3VqeWk2anR4WEpjM0ZwSmF5aFZ4ekFsMHBpTng3R2VoS3FnSnoxRnRVU3dw?=
 =?utf-8?B?bnNYdnRyRXZWU09YRmE1TWQ1RjVUZXV0d1ZGcHdEek1DS3pneklmdDRwMFdi?=
 =?utf-8?B?alNBSTJXOGpCYjU0N3JNdDVOSkdXMmE3Z3hQTkFEcjc0ZmFVcjZBdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a1f4e7-3f97-4e0a-61c9-08dec329c258
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:42:05.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OM88OmHAZ6VK5FzYKnY8rzBEGDbI9NJK+sCxa/00+VS0dqBXI/bmhFMLcBLxHOpZ/rTs1eRI2tPRkU6/YNATTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21862-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9C9264A4F4



On 05/06/2026 7:02, Randy Dunlap wrote:
> 
> 
> On 6/4/26 2:49 AM, Mark Bloch wrote:
>>
>>
>> On 04/06/2026 6:53, Randy Dunlap wrote:
>>>
>>>
>>> On 6/3/26 6:16 PM, Mark Bloch wrote:
>>>>
>>>>
>>>> On 03/06/2026 23:06, Randy Dunlap wrote:
>>>>> Hi.
>>>>>
>>>>> On 6/3/26 12:32 PM, Mark Bloch wrote:
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> index 063c11ca33e5..7af9f2898d92 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -1264,6 +1264,31 @@ Kernel parameters
>>>>>>  	dell_smm_hwmon.fan_max=
>>>>>>  			[HW] Maximum configurable fan speed.
>>>>>>  
>>>>>> +	devlink_eswitch_mode=
>>>>>> +			[NET]
>>>>>> +			Format:
>>>>>> +			[<selector>]:<mode>
>>>>>
>>>>> It appears (please correct me if I am mistaken) that the '[' and ']'
>>>>> above don't mean "optional" but instead they are required characters...
>>>>>
>>>>>> +
>>>>>> +			<selector>:
>>>>>> +			* | <handle>[,<handle>...]
>>>>>
>>>>> while here they mean "optional".
>>>>>
>>>>> That is confusing (inconsistent). Also, if the square brackets are
>>>>> always required around the <selector>, what purpose do they serve?
>>>>
>>>> Yes, you are right, this is confusing. The outer square brackets are part of
>>>> the syntax and are required, while the brackets in "[,<handle>...]" mean that
>>>> additional handles are optional.
>>>>
>>>> I couldn't find a better way to describe this. What I want to say is that the
>>>> selector is always wrapped in square brackets. Inside the brackets it can either
>>>> be "*" to match all devices, or a comma separated list of handles. If "*" is
>>>> not used, then at least one handle has to be provided.
>>>>
>>>> Maybe it would be clearer to spell it out explicitly, something like:
>>>>
>>>> Format:
>>>>   [<selector>]:<mode>
>>>>
>>>> The '[' and ']' characters are literal and required.
>>>>
>>>> <selector>:
>>>>   * | <handle>[,<handle>...]
>>>>
>>>> If '*' is not used, <selector> must contain at least one <handle>.
>>>>
>>>> Does that sound like a reasonable way to document it?
>>>
>>> Yes, that helps a little bit. Better than nothing.
>>>
>>> But why are they required at all?
>>
>> Jiri suggested using the square brackets, and I liked that they made the
>> selector look like a grouped argument. But if that is too confusing, I can
>> also drop them and use a simpler separator, for example:
>>
>> 	devlink_eswitch_mode=
>> 			[NET]
>> 			Format:
>> 			<selector>=<mode>
>>
>> 			<selector>:
>> 			* | <handle>[,<handle>...]
>>
>> 			<handle>:
>> 			<bus-name>/<dev-name>
>>
>> 			Configure default devlink eswitch mode for matching
>> 			devlink instances during device initialization.
>>
>> 			<mode>:
>> 			legacy | switchdev | switchdev_inactive
>>
>> 			Examples:
>> 			devlink_eswitch_mode=*=switchdev
>> 			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
>> 			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
>>
>> Does this look better to you?
> 
> Yes, that looks much better to me.
> But you should do whatever you think is right.

Good syntax should not be confusing. If it was not clear to you, then
it will probably not be clear to others either, so I am fine with
changing it.

I will post v3 with this change.

Thanks for the input!

Mark

> 
>>>>>> +
>>>>>> +			<handle>:
>>>>>> +			<bus-name>/<dev-name>
>>>>>> +
>>>>>> +			Configure default devlink eswitch mode for matching
>>>>>> +			devlink instances during device initialization.
>>>>>> +
>>>>>> +			<mode>:
>>>>>> +			legacy | switchdev | switchdev_inactive
>>>>>> +
>>>>>> +			Examples:
>>>>>> +			devlink_eswitch_mode=[*]:switchdev
>>>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
>>>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
>>>>>> +
>>>>>> +			See Documentation/networking/devlink/devlink-defaults.rst
>>>>>> +			for the full syntax.
>>>>>> +
>>>>>>  	dfltcc=		[HW,S390]
>>>>>>  			Format: { on | off | def_only | inf_only | always }
>>>>>>  			on:       s390 zlib hardware support for compression on
>>>>>
>>>>>
>>>>
>>>
>>
> 


