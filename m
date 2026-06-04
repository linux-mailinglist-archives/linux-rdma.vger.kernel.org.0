Return-Path: <linux-rdma+bounces-21717-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DUfqLYXSIGrU8AAAu9opvQ
	(envelope-from <linux-rdma+bounces-21717-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:19:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25A63C2D8
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:19:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=A+JIZChn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21717-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21717-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A073C3020025
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09A25783C;
	Thu,  4 Jun 2026 01:16:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085E1F3BA2;
	Thu,  4 Jun 2026 01:16:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535779; cv=fail; b=R4GMiH5RnwVigkS+KcXcN66SWkdJe9R/+4D0E2VpX89g+odX8itajcu7ikLYPpUvDLBAtPO3sWmfir9DSFezAy6LCnFFJ7/5adlqOTDzJ4MgAs5ZQi2ck51WRTvKIGQSUPxvXwDUqaR0nXFOvfaCbC0SQFBlHJARm91oTlP/yj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535779; c=relaxed/simple;
	bh=KTEg2fyBA41PtHIpoWy/maZGrhL7cB9wPOdgQN67W+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TMyMGoxqnG7KKqHch6LaHq0e8cEj8IOzkRTtXoEzZ3UwyF0jPoehTPGqztDUnUSBJgz5qHHwl5OwDjRQqj7boUhpW90Lk79qqSVjh6qdfr3G7hDdOrd61iAXUZePKra3Z3sqpp2mjtsZ0eWxUQiDlcm3TKO/khAN3LJA+rNbKNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+JIZChn; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPBDK/oG9AYJTTpvtKngXmBaWQvYoVAqIx5155ZkEeVhsELgg8xn7ENswyzbn8N7AFUGy4N2iOg1WATStt3ai2MjL0y2HOzSnxWha3mhgsQPOrqDlQqiZ8SS102tJ419LCv8hO4LHRPvhLKdQCDXuDLlER86m5VFgXPM6DWaq9p1toktR23Ahbr60nIpQM4FQCChglF7bc9pMBhtai9Tzuxv9eR01kAeaCEMLsS53BHH4eglR0ptre/Y5EHhaRSXrVNiWPIro84MVFxUx7aOP/FKdXuuF7WEvdM0O55pLm3s2F9q+Ypps5HBAJ2vmyxK10v8ym8rGJdg0ezBpTrcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtds3UXxTFxgzSKhSV5mvPtQO78+A4V7qes4PZ0PBOQ=;
 b=PkZubIXktYAZUtxWCaF/ppuVJTlkyDTErvKKNG6u1EF0HlkFPIT8PxgePfMVu3phVTXcEVSzEVD2Nq8kgDX2QhafXQmKAHml/IFdY8caJxkCiVVEl5FYgbGtHT7dpYbesQoNu9O98BF++wb4XMXO1rZkLeCC77vCSqvbXdNM3w8wdL2nAeEZC20wqK3mEvRveFUb+dmT94JWP6SUYBzO5geQBtQTb4k4sZkechdKUWmAYHpsbGB1QHevR2m4i7KpUVXnyYgJ9IVMFq88T3CmV59LH5N/oPaz+aEx2XHBui1R2i8487YFl0F9kUYpon5yFBAFJ/AXgWekvNK4n5wcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtds3UXxTFxgzSKhSV5mvPtQO78+A4V7qes4PZ0PBOQ=;
 b=A+JIZChnBsdKNA2X/QOb09t+q8UUAAVD6SsnksfflU0zEsdUzIycXulHlO76Zb9UB2YoR3At+cMRa9x+S6N0NwM+wtUzffMEDqxB4PAeILoRG1VKmdZsF5NpwcqR8qDt+LefhYzA5vOI8J45t1jmI/5UcfBPuG6ZNy2VqnMYkXdE5TtI7yLFLTnnaSGsjREs/MXeehZ9ThGKkLtHXd58ueXOZhK8AX4YS9SSeUAKYzMcUGYS0bgLy9NpmBzMRVH0n1AC/lE+pfVEyOqFtBwNvrFZVgI3w2uUjFBB5gaANEvpSTBvGeI52YoS1EQvPoCwkUYa/HEc5rn6MuVYXlF0mw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:16:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:16:13 +0000
Message-ID: <e4aada53-fb80-41a8-9a8e-d19414f6466b@nvidia.com>
Date: Thu, 4 Jun 2026 04:16:00 +0300
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
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <d276e842-dd8f-40b7-806b-71572503005e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: a07b5b6d-823b-4b7d-7b2c-08dec1d6de2e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|3023799007|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	b+UkzPJNObFJFjCGLyhkMh9Om/H5OcLio9CXAILA0RnzBWH3aO2rK6syQGVqpbxTcjS+vR0VVLqOa8A4xqo6ebM8p6UTen/EG7yds9Ej4ghjZ2r2j0pfFcx0u7CDb59ClvKeTFaVafJaqzlbB25Hl6pU6cQh1YWeqNQzKRIU3T8RPxMN4xFJrna6e6F+CEM+Ye1fxdz5jVaYM1gqUxAbKhRsUyHW0//N6iar/rhWmFZOKRM5/pkbXASji6YGmJjBjbMpJFQhl22GS6aZy1lhmJEWJHDjHTlpu0zdPM0uB+o4OZtcy32zdw6udZxwHxpPtsbHVx0wGTOxPQQvUza8R5bG4wr0hZTQhosSbUQzXOMt9VsefsUnjRaFfv8Noxlo0OzT0pqAsqFfbFoQxhKIXKgx4i8KOzXVItTPxMiRwpF8A1v9wQl6PzqDdkgmQurqG2UJoR0f957q7jickTtyZdbBZDfzjpniVbqiT0ABcWSjETNixn/6fr7zAdwvxmnaS4haZyX117+VAQtgQx5/emfTyhYA4pzeZymWD78zI/o8/TlZ4H+qFMk9fSKqWFly9phtHMKRbSqnQ89vJJNw8tmIw3h8qYQ1ephUSBfxKjQI0rYDpZZ0QxhgS5VXXnJFSNwZYnIIXoU6mMs7x1NhEhN5Nz7iKNWsKPF9aqLX8cVmJdJJowGZv/ViO0uF9mcP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(3023799007)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUZxZXZ5cVljdEpWUEoxKzBLNnYyT2k2VGRGTFNtSVdGNHEzbEpGalVNNzc2?=
 =?utf-8?B?YjVXU3NJcThBcTBVMFFpUzNZYm5uejkyOU1yeDFMSWpTTHdSOGVLRXlESTRy?=
 =?utf-8?B?U2ZSVnBncFdvcC9MR290V1MvUG5DRXMwSEZQVjZaZXg2eC94M1d2MlRxOUtV?=
 =?utf-8?B?NWc0Q1p0NlpBMHdsVmgrdjI3MElmbnp5ZnhuMDVodkkwT1FyNk90T1NyYVZX?=
 =?utf-8?B?WTR6SDNCSzZkcmRmaUE1RHdDVnc0Y3l6U2htRngzQUZvbm5EdXhiNTRjemVG?=
 =?utf-8?B?REh1UkhJVHk0emhtQXJxdEMrUkgwUThDVnNxVUZ4YnVla1JBek45MGxqWmNS?=
 =?utf-8?B?R29hS3RFYjhiYVdlMm52UUZTSGVhRUdBc2RuRnMwSjg3T2lzMzRYT1hJb1Vv?=
 =?utf-8?B?VnJTWXd6M1QvUEUycFJiTy9WQnVPTUk5RjViWkNFbkpmOWVDYkw2bnlvVlkr?=
 =?utf-8?B?Z0QrZXg5bElUOHVlWCtjZ3pQNkwzTXEvcjhSWDRhNHgvYXlqSDl1NUx4b0dy?=
 =?utf-8?B?UWFFTXRDRVd5SEpjQWhhV2I5bmNVWll1NE10aVlPOXNZVHlDUVd5M1poNTRv?=
 =?utf-8?B?bUVBK0VTbHFMR0h2WUJ6bU5Pd1E0aXdGNnpSM2wzd3V5T2Q0U3lqZlFJVW5U?=
 =?utf-8?B?UDF2UkJaZVlwYlpNMlBLbmZCUVkrNXJ5NTQrVTQ5d1c4dTIwWnE2YWZTTjEw?=
 =?utf-8?B?djdkNjJwYmZNWGlDRjU2K3VjUHRnVGNjV1hUa0hqVEQrL1RCSnZnRzFIekhM?=
 =?utf-8?B?QmdnalFsYTJrQzlYdm8xUEIwbFlUZWVTaTlKMUMzREpOY0NwaGNOTUFuOS8r?=
 =?utf-8?B?aG5mT1dLeG1GNElOYUl3V3NlTXhVQ2dFOUtueFlYYXRVZmNNcTZ4ZytOeXpH?=
 =?utf-8?B?bjNoR1ZKWTkxbE1lejJWYm94d21HWFF3ZFp6SlUxdWVyTjRoV1J3TTR4ZEdC?=
 =?utf-8?B?bG05RmZ4ckhzczlPK0s2ZGs3bU50c3U4NThZdFJZV3p6STk3cVQzaXR1cFZT?=
 =?utf-8?B?Y1ZYSmx4c0lqZzJsM1h2UXlrWlRhUVl6WFZ4aVhEcG5TZXZTMWo5QWNUYmRI?=
 =?utf-8?B?UVVYS3dBSW5IUEoybkIvODBneXJQRUlZY21oOE4vZ1pyOUhuOUxWV3FXK0tl?=
 =?utf-8?B?ajVORTZRcjJNM1FtZWNOSmQvWVAyZk5QSVJBMkc0STdIeGpvTDliZjgzUEdT?=
 =?utf-8?B?NmJoQWQ0OXZXSVZyY1dyUG43M3JGenZHNUhLVkg3MkQ0aW9NZjF2TnMrZzVj?=
 =?utf-8?B?VDZTcFltZmkxUXN6ZklxdFg3UmhDaTYrYzkzUGdrSDlZeWlNM0VCRGFOdmRz?=
 =?utf-8?B?MFd3dGhtZHZ2Q0htbUZTaWVNRkNUcy94SFJ1VHdPdGorWE9UYnB1eFpWanVw?=
 =?utf-8?B?UlJxNk5ERytCOXY0N3BqTzRCN0FiZ2xXT2JVLzhuU3dhWWxFSFFqa2RENlZY?=
 =?utf-8?B?aFpMeDNWUlRGRmsra1RwNDU2ZVVoNFVIVS84N0JJa1A1bktZL1EvcE1HYXR3?=
 =?utf-8?B?Rzgyci90RTNieXdCc29CNDcvTE9QbG44ZWRwUkpmajBVSUZDcldhM1c4U1Nz?=
 =?utf-8?B?UGk2eTJ0WVhyeHFTYi9Ic0dNOXBvVXgvTHhaa0ZhRk44eWN3bUc5TWRwZ0Q0?=
 =?utf-8?B?Q1luaE1TZUgwZ3lqZzd0aEtRWmpoSWp2a3dSN3hrMzNmUjFWQzNjSWMzMjVs?=
 =?utf-8?B?TUR4aXEvbkFZSnFtMXpER3ZLRmxTV21ZZ01kSFcyTXZjU1FvNVJxbGZlaUxP?=
 =?utf-8?B?dHQwaXV4RWF6bEhaQWIzckVlNktmdnAyNHVSV1FPdS85NmVTcVY0aWlHMlFo?=
 =?utf-8?B?TVlHaEtSV21xM3Bkdy94a0lMTlFDSTM4cktGUE1kRVNMOCtrMjNXUDlORjZU?=
 =?utf-8?B?N2NxMVBRZkFSUnBHckRqalkzV0hhZFRkVGRLQlJrS0FHQWh3WGlOZ0NOa0Vz?=
 =?utf-8?B?YkhuQ280Y0hNNElBTVpUWkh3WmZKMGVEOWRFZ3k4QTE5T3QzMUNrZDRQSHcr?=
 =?utf-8?B?dFc3Yzh6N1l2R0VUNGpucSs2Wk9hZ21OUTNPSmJUREFNWlQzUWI1Y01zU29U?=
 =?utf-8?B?MkpUcFN6RlVsMGpLaUw5ZTVQaUQvMXNrRGxyVHpiU0swOEpHYnluWE5PdGRR?=
 =?utf-8?B?aTE4WTlvVXNOdkQwbnFBbVdQbTdPNHdLYVp2bUJIaWxkc3dPRG9jdTc5MHU2?=
 =?utf-8?B?c091ZDBDWWJ6WmdLK2ZQS3RoTEMyaFpwQU5BbXFIUjBncEs4dmtxMkxnaSsx?=
 =?utf-8?B?M3NRbDB1ellPeG4zWTNMYzRFQWJCZDhmaGJpN0s5UnQrZ3JsWjRrKzZFbE90?=
 =?utf-8?B?QVJMM25yVStCeW5GVERVZVY2NlZ0UWh5bWlrazIwUHU1WStuWXloZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07b5b6d-823b-4b7d-7b2c-08dec1d6de2e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:16:13.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N6Ow+YT//ZOC0Xg7BaXjrzyjXXqX1t5Jfv/pMmEWQJpMzsDddTsecWRFz71+nH8V9a4/f3fbW8hTdZNZlBb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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
	TAGGED_FROM(0.00)[bounces-21717-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A25A63C2D8



On 03/06/2026 23:06, Randy Dunlap wrote:
> Hi.
> 
> On 6/3/26 12:32 PM, Mark Bloch wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 063c11ca33e5..7af9f2898d92 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1264,6 +1264,31 @@ Kernel parameters
>>  	dell_smm_hwmon.fan_max=
>>  			[HW] Maximum configurable fan speed.
>>  
>> +	devlink_eswitch_mode=
>> +			[NET]
>> +			Format:
>> +			[<selector>]:<mode>
> 
> It appears (please correct me if I am mistaken) that the '[' and ']'
> above don't mean "optional" but instead they are required characters...
> 
>> +
>> +			<selector>:
>> +			* | <handle>[,<handle>...]
> 
> while here they mean "optional".
> 
> That is confusing (inconsistent). Also, if the square brackets are
> always required around the <selector>, what purpose do they serve?

Yes, you are right, this is confusing. The outer square brackets are part of
the syntax and are required, while the brackets in "[,<handle>...]" mean that
additional handles are optional.

I couldn't find a better way to describe this. What I want to say is that the
selector is always wrapped in square brackets. Inside the brackets it can either
be "*" to match all devices, or a comma separated list of handles. If "*" is
not used, then at least one handle has to be provided.

Maybe it would be clearer to spell it out explicitly, something like:

Format:
  [<selector>]:<mode>

The '[' and ']' characters are literal and required.

<selector>:
  * | <handle>[,<handle>...]

If '*' is not used, <selector> must contain at least one <handle>.

Does that sound like a reasonable way to document it?

Mark

> 
>> +
>> +			<handle>:
>> +			<bus-name>/<dev-name>
>> +
>> +			Configure default devlink eswitch mode for matching
>> +			devlink instances during device initialization.
>> +
>> +			<mode>:
>> +			legacy | switchdev | switchdev_inactive
>> +
>> +			Examples:
>> +			devlink_eswitch_mode=[*]:switchdev
>> +			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
>> +			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
>> +
>> +			See Documentation/networking/devlink/devlink-defaults.rst
>> +			for the full syntax.
>> +
>>  	dfltcc=		[HW,S390]
>>  			Format: { on | off | def_only | inf_only | always }
>>  			on:       s390 zlib hardware support for compression on
> 
> 


