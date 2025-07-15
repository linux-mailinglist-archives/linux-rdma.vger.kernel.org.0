Return-Path: <linux-rdma+bounces-12197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB505B062F9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E80565E14
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1023496F;
	Tue, 15 Jul 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrdxqFE0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE7533D6;
	Tue, 15 Jul 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593505; cv=fail; b=KjRLvV1kypJ6Frcx40LlOCgEIRnOfkvrre5KGG2TL1Z9obmFdjO1yjPBOSy044QYmHO07hxjmudq3ga1r7fNqnblzOE9TxPx64cSUAXz0HhcvDpyh1Okaln6E/4wNFGzHQgUhl4Pkpg1B5OT/OJgXDeF2d1p2ivZ9QtwNMVQJXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593505; c=relaxed/simple;
	bh=IPS4nmzsZ0u1mX97vemBZJlNjbiwrpnjOS+tg2AAHng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHo4+h8IV0xILzYeVzdP49EFYS2LVCW93iHFolp1MhPTWWqvx/pj7Axpb1FCJalg5OyjMKQXNGO9PTCg1WfC9/yonopPgCkiofYICln8SI5uk0UrldKj8YhyGBCbWwCEMD8B8a8ow5KfeJ6QdDxnZVpAeUPd5Lp65H6hW0SrIPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrdxqFE0; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTQd96LGGHiubgnTIt/3pq8/8aopusKh5o6/dJwBPNKcd19ifrF91cn4njxfdyyscZmKAQM4ZagKOmnJIdoDA89AqrC7oHmV8TjHs2XTAvJFmAWLkegh1sePEvULYeJAUUB7sbUl9kKiA/sv2Pgb/8C7ip0TwRqYCPnFfgbqBbRm+q1K9pavv3ebXzCpsiilo3+nsthsm9A68hmDuMTjG+5uPWNBfRq8DCz2Q9HPPA4L6vcxvAxbuFPlx8LwEbH/wyZBElaFfhvl+gWDXiqWvcoi6zMnsiic/czsxZpEvAys6QGohyGnUgsacgYPX9TauvDasQHfQRBjzgXgCAQH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHhYQkmmgB7DQuLKk0RiVW3hr/xxg+R+eBRR04SMjyk=;
 b=qFuv/07NROEwk8BYIzjyUIhl19z6CfH+UR5V+7QQG6I+tV/K0Af7HWVxyi2CynEr5WZbJzfXVqDWvGkt3jp1XwsO/uxM9adV9lqr5vtSinBxFVKyVAFX6SMW8Nt+4i+3yQ5GZ28aGwbsWK/05Jxo0t3c+z0JjuZ1Ih3mjr9Sp6BD4BxMvNoXPTkXcQNcOxDN8yJyHHAGxI/gFxtCFj6daaxt3buvt7/3ayxa/skfCGJyuXTDx+DKl/RqAlOb1lRPud4SlH+BNZozdDxZXPVLKaoi848MPNwxyzhYDwULjnV1KI3cI9tV2wO4uh3yxJdkQ5WJtP9J5Sm21uFhQsj++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHhYQkmmgB7DQuLKk0RiVW3hr/xxg+R+eBRR04SMjyk=;
 b=lrdxqFE0xd9HmvqwJCrF9R61Gipw5rhhaZ7IYpGCWMqyy6HKcRLVaHGSrjyMl0XCKK6nzAS1xOOSItN7po0WdCaRLiCnT7xYjze8fRQweWUGs1wrJrzaqyiPPLJm+c1DBZjIGDfMf+7/aWK9AkbbYXW7/P86sq+pWvQdLWR8hcx/hEqnCmSpxr8FLAY4mmazuZcICZcaPncL4UzWT3B/WExS1JlMPabpFgE3CZNL4QGQySppJZDFOYqf833Y4UF2RvyQl6C+1MuBlx5Q2ac1ClwNMhnWwZ6oBIKkd7vMEAEAppHmCzsdsJRDvNa2InQOHNPzwS4hinQ2ffPPWtsoFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 15 Jul
 2025 15:31:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 15:31:39 +0000
Message-ID: <b1158b1a-ac31-4703-bac1-dfe3ab7aeb98@nvidia.com>
Date: Tue, 15 Jul 2025 18:31:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
To: Christoph Paasch <cpaasch@openai.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250710182629.78456-2-cpaasch@openai.com>
 <3661dbe1-2a17-413b-8353-af12f4f37038@nvidia.com>
 <CADg4-L9EWE2ch5j5KqJk+hwC5X6yPxAERbjiPuLN+ApADHD6qg@mail.gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <CADg4-L9EWE2ch5j5KqJk+hwC5X6yPxAERbjiPuLN+ApADHD6qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 751f5e3d-2973-4fa4-9ada-08ddc3b4b121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWc4Mk9weDVZUEUrVS9vZWgwMTBJSEJNNGdCNkJLZHkwb1d6WlNzV1VyWEs2?=
 =?utf-8?B?Mis5NGFReE5RektGaERkcjBteHpFRzNrbHNFT2l1L1BpNlRYNGRlTWZIbURY?=
 =?utf-8?B?dnY0cU4zN2NQUGRGQVphYWUvYnp3K1FRQlZjSGIxSU82MUhid0NJTzBJc2da?=
 =?utf-8?B?RzRFUzF0SEg1OFZZdy8zREpyV2twOUJvdVk1NmI0ZVZRL2dKQzh4ejFjZG0x?=
 =?utf-8?B?S2RWNE40cldwdS9lRXdxWUZINDYwZDZ5eFRUU2N3aDlvdUlYMDBEbm5WOUpt?=
 =?utf-8?B?OXljT1lYcGNqVE1ZYnBiM2F2TnlmQlVWSnorUTQweG5MYVI2bTFEcGIvcjZj?=
 =?utf-8?B?QWs2bVlBOStQNWZ4ZEpzRVU2aFdlbTdBTTJDTEFiVG5hMkdFalZRSURzZ3FD?=
 =?utf-8?B?R3dGNTd3cExKRkphNVphK1E4Y0NZNGl6bGpObnRXVTEvd3BCSjNHekpwWlFj?=
 =?utf-8?B?d1VxTUY5djB1d0dISjlRL29aTHVxdHlFNklzemRLaXlVSkFRR1V6ZVhQeTZP?=
 =?utf-8?B?eTdBK0lZVDBPN1RZQ3VJdFZ2Wmd6cTZwT0xDbEkrYTFIcmIrenoxSDZheDlC?=
 =?utf-8?B?emM0cnFzUmRHeUd3bFZMUWxyZHk1a2g0MjhRVUZacDJZRDEvU2NtNmpQVStv?=
 =?utf-8?B?SDMvUjd3UnVvNjVXUnpjVlQvYUwxLzhWcitFS3NYckxnZEtKd2dXOCtFeDlv?=
 =?utf-8?B?cStlcjF5UU4wakZta1hPMnk1TkNNLzBxTDZVTnJza0pDcjBUdjhDNjdueXdJ?=
 =?utf-8?B?bW9yMHZPdDQwc1l2c0VIeCsxbUdTRHFnaEtCQnNRdGRLZFdlZ01aenNQVW5w?=
 =?utf-8?B?WDlQcnZiNEJKWFRBbjdWU1RxYmlxdC9qTE5LK29MRWE3MndKUGI4ajI3TFNt?=
 =?utf-8?B?MFlYeUlPN2pFQ3o5ZzJmQlpFVDdWdUFITVpJMTlKakZDNGd4RWhmMkFJZndy?=
 =?utf-8?B?TGVqVXpENjNaMytFbmgzMHllbGYyWmhHWXNkdDFxa2JkQlozSDRQeEwxT3JK?=
 =?utf-8?B?T2lzd0QwZWc4Yms3bjU4VmJTdDdla3o4dllucXhlWG80WFhYT094aWFPZm1F?=
 =?utf-8?B?VkFqc1J3RFdBVEY3d2l6S0laK0l2SWJqZEJzRzhncmdYRWl3NHlmR1d6WGxU?=
 =?utf-8?B?dUxCcTJpdFlZSktaQ3R2Z1Y2bEI5K2JBM1UyaUt2ak1zOXIybEkxdVRwWmVW?=
 =?utf-8?B?MUNmdi82MUVXNWVud3pCR2lRSWZUOU5vYjR6aXJDY0l1TlRtK3lkL1FUY2dR?=
 =?utf-8?B?SFVoWmlvL0ZGWm95UnlkdkdyYU91WkR0SVlHVzVLSzExU015S01DN3ZWaW9q?=
 =?utf-8?B?OHVtTHdiYlRuWFdzVm5mVUlkWjViMk9IWmRoS1JaTFRXNXc0WmxBMHV4aUZw?=
 =?utf-8?B?UURmS0pCRVBTS2FuUEZOVGRoVnprNjFQRGRsOURMMzNVdXp5Mm9jaTloYkFQ?=
 =?utf-8?B?TVBOSXNsYlhlTy96aTY2T3k1anVDUVgrMWZLRG5oQm5nbFVFd2lGNGJhTHhK?=
 =?utf-8?B?SnZibllVUVgwM0VoZFpyL2h2aTdrSUdGTGhRcHFSS1JqZHYvYXBDckV6amgz?=
 =?utf-8?B?VnV1Y1NlOWVlVjFnZ3V0UXJpN3NHQUNVTG85MHAyUVowd0VNbkdRWEp0M3Jt?=
 =?utf-8?B?NzkxRUQ5VDNOS1hHTmJqZlRZRy9XUkthTDZzdTdmZ0lIc3YrUnNHc2p5SFFs?=
 =?utf-8?B?VXcvNC9Ub3VXSENQYmpabVlrZ0xYdjhPRVNOUmh0cWNpVjNEWHpFZVIzKzJk?=
 =?utf-8?B?U3dhRTFQUjd5VDVnTitNTzB0Zm9aSCtQMjY0MXF4SFBUR1JPa2pyaWhZWHdL?=
 =?utf-8?B?U05YeWpzV2VSS2xEb04rSWtUeHhhZTYrc2xPRlZVT2hHTzg0V0tHUWQ5ZTR0?=
 =?utf-8?B?UTZodHdQWGdRVXJlWmQ2aHI0Wk1pNUZJQ3NmSU5uRUVER0VlcVhpdkpDY3RH?=
 =?utf-8?Q?G3R+cVJGPeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0lrWUtiRmZDellpZm81QUcxTWU3eTlncDlQNjRFTUpTMFoxOC9NaHdXT2VC?=
 =?utf-8?B?SmkwY1AxTjIyTG53aEh6K09RakVtZm5HQ09LblA1L0FiOFhob1FLUGxsMXhZ?=
 =?utf-8?B?T2pyWVZrZHdzVEtpRzNXMUxFendHbkpMc05FUU1nd2hjbUI1NWRrczBEc0l4?=
 =?utf-8?B?WnZNTXFwYlZOeWJHRzRYMmd0dHJGUG1jK2Z3VjZaSWdnTjgvZ2I1QTBsMng5?=
 =?utf-8?B?UWF0RGZyVkpNN1JWSnQxdExmR0FzY2oxTEowVkgxQThSMUZLZEdoZDV3RHRy?=
 =?utf-8?B?dXYvNHJObEdFZUxKUUtVZ25tWDhPZzZtV1FFZFB4dmJPYXpQbWVTclRmNUJH?=
 =?utf-8?B?TkpwRlVXYlNtK3AwREF2Ty9UMjJka0RrdW05c2ZVUjR6a3ZhcFk1cUxFakg2?=
 =?utf-8?B?bDlMbHNlc2hPb3JGTkdSRkFGWEpsemwzenlxa0tSVktaeEdqbEFkWUdGay9U?=
 =?utf-8?B?R2JyVFh6MmRzN1RHeG9pTzJFM2xRT29KcmpOTW5RU0puMmZIa0FMTGJWcHA3?=
 =?utf-8?B?T2RscFk5RzhSRzlNUGs5RGFKWTJyeVVrVk00NVVCUzBlcGZ4OEVwMVRnUVd2?=
 =?utf-8?B?R2FTRC9NcXRPZjcydk5Dcks1YVFTSFRMNmxXQi9XaXhYL1EvdTliU0pHYm5s?=
 =?utf-8?B?RDNXTVRsenZ5RzJMb3FtbXdCR2lkdnZMSDJGVURSYStHaTVBOVpORHVuYnZD?=
 =?utf-8?B?UXFhZExFS3pKUVo2ek9xOW1KUHJFOERLUE9wSk03RmVYcXFFRnNrNFEwU05C?=
 =?utf-8?B?c1BjQWdHVkt5MjZ3VEZpTUE4NXJ3VEw3VDdqTUNLWG9ZL2xiaFZHUXlSR0FE?=
 =?utf-8?B?WHNnOHNaQWlZT0p5d1NDRnZXbXJyZkdrNXBKUFJ5cXJYeXJGb05hV3pFN0NW?=
 =?utf-8?B?Q21Lc0VPUm9sR3lhbmdxUFpHRlg3VU8wUGlOMVRLOHc4Q2dOM0VWMFNQaU1J?=
 =?utf-8?B?azdTSU5kYkRjK01zMzZndXJKSCszZURkWXVRVERBZURDL0szNEE0czQwUjVx?=
 =?utf-8?B?WWNCc0VIcUJGK2ZSWUhHUXVpQVZVVU9EQnEvVTdHbVAxdlN1MnVHWkhVekZY?=
 =?utf-8?B?NXUyUW1DbVRLVzRZZ0QzTlNBaWpFdnovbHlZdEdWbU45YXVZZzY0OVhTcEwr?=
 =?utf-8?B?ZStzMXRUU0xjcnRJTE83SjF4eW1SdDk4TXU2TlFwN2ZTb2taTkQ1d3hrS1pI?=
 =?utf-8?B?WVM3RHRpYzgvRU5CZUJMTHUzbVlKZ01mV2ZjcHBSTGVzQS9kNGhZNGdCZzJm?=
 =?utf-8?B?ZHh5NHFYRkI5MEhwMnJETVlFTjRpRWFlUG8xSVR3Ylhid1VSVVQ0Y1FaZE5m?=
 =?utf-8?B?bVJkOW9YMk5NRTVzdEZCSEUraGFqL09CdG1UTUlBY3hDNEFDMlIxKytMQ1Ev?=
 =?utf-8?B?MW51L1pRdDBYM04zcGUwSTM2bnlOQjMveXhJa0RFeUVjNC90dXRWN0ZLSzdU?=
 =?utf-8?B?OXBCYVJLWlp6N1JwOWdVc0xuWmYxbHM2RnJrM21lam1TR2lXN1d0bEhxTTFz?=
 =?utf-8?B?UVNBUy9WZE1jTHVHVXhuS1RHaVh4VWJJTG5LWVQxVU5LazB6dmc0a2txWnhC?=
 =?utf-8?B?RkNoT0NMbndJM29SNzFLU0tyajduN2xQUjJKa3lnODE0bHU1czYwY3NtV2ZS?=
 =?utf-8?B?UlNrY3NjZHZiSVhRdWdRYjdpeXdKUWQvN2swQnpJNXVYOUVuaDFVRlN5ZDN2?=
 =?utf-8?B?TDk1SXdLckdpREtud3ppZjY0NDdMQys1SEh3OXZNMlpPc0dhYWxmaG1xK0pr?=
 =?utf-8?B?QWlSZmdLblJ3cWh1cDEvaDQ5eWRJZjljUVc3cXRGNjJVUHRYTjVBNkZHSXFM?=
 =?utf-8?B?eFUyalh4NFNkbHpzUE5QTkZDSGxDSUI4aDRIZjVGbzBMTWNIOXc1QkVpZjl0?=
 =?utf-8?B?czVDcXpqMGZNSzJmNUx1NlRnUVlvNVlNUG5MOWpOZ1RLNWlCSVlsd1RsaGEv?=
 =?utf-8?B?L3NkRUpmeXR6UTBWMkpTMVl4NjFSNGRnUmYyTXA5WmJqd2xCZXZmT1RPa1BI?=
 =?utf-8?B?WWRFallNdS96a29uQjNEYzlGOUpTK0pDU0NHaUNaczFQMzhoZkZuZ2JHUGVr?=
 =?utf-8?B?cENXb3pUME9CYk85b1dvZWRXdUc1WTA0UWxTcnZhOEFGUTYrT2hSSXloS1BZ?=
 =?utf-8?Q?q2QsPKFnN7zF344k2B8dzQ0z4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f5e3d-2973-4fa4-9ada-08ddc3b4b121
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:31:39.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXv7iAdhyDRfqQBugug+hGcGsVbhq0J3qt43WOucDTsNRITKvf8o73f11YKWHA2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

On 14/07/2025 19:54, Christoph Paasch wrote:
> On Mon, Jul 14, 2025 at 1:24 AM Gal Pressman <gal@nvidia.com> wrote:
>>
>> Hi Christoph,
>>
>> On 10/07/2025 21:26, christoph.paasch@gmail.com wrote:
>>> From: Christoph Paasch <cpaasch@openai.com>
>>>
>>> gso_size is expected by the networking stack to be the size of the
>>> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
>>> is the full sized frame (including the headers). Dividing cqe_bcnt by
>>> lro_num_seg will then give incorrect results.
>>>
>>> For example, running a bpftrace higher up in the TCP-stack
>>> (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
>>> though in reality the payload was only 1448 bytes.
>> Other than introspecting the wrong gso_size value, is there a functional
>> breakage that can be observed?
> 
> I wouldn't call it "functional breakage", but definitely unintended
> consequences / lower perf :
> - In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
> will be 1448 (because tp->advmss is 1448). Thus, we will always
> recompute scaling_ratio each time an LRO-packet is received.
> - In tcp_gro_receive, it will interfere with the decision whether or
> not to flush and thus potentially result in less gro'ed packets.

Thanks!
Please put that in the commit message.

