Return-Path: <linux-rdma+bounces-20100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PqVEul7+2n0bgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 19:35:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E213B4DEE73
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5135E3021D35
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6E4BC029;
	Wed,  6 May 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5G49KzS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E813F7A83;
	Wed,  6 May 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088932; cv=fail; b=OW80T2N4OL5CFoxRWdq5+uOtUkNJk3a8QI/Rnd75S7neuojxuDDybm0AFYZa2+ufFa3X7avV/83KoKwTwvA2inNuR/2V/XJ8NLM63jPidw9fOs8ViHgvVqXTEQwfsbCe9w/PaKrpWIGuiWEeIkt/VEHPGoHURi3zaao6emjGBSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088932; c=relaxed/simple;
	bh=fEE0ttaR7d1I8eSLXlAbPkzTBvB8qCgnKKJvyuCJvFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0yr9p6NmvvPcvecm7c1YaCQAM/zkL//PEDBhQ0wZOa90i2/bm4L5IjCd809y5Hc/i+igEjdVv4pLDXD/jzGC1lWQ/MybCIZGqFABpVtzHUlpwxGvSTRWNo4j1N9Vu7pbzxdXS61QOogfhhfrl5eO8LTJ0CeusiouvhpI1RZblM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5G49KzS; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wloABKU7WEeRsozsCwBUwOAQDm/VSK/XeEYqlYRlkddpljOSOrcZwz5A3ZR1wtBKEzxoc8Zi6LUAPDT3eYwq6ZwwXhfe9EqUujgLPQUvS2iaGnIp1zpEizeo4wYFFFzlxTwXnGfRb5IzzM5uC7HNPHb28jP0kKM+CRHHiS092Hz0avJYXol9UlyJeDpbfDVlk7smshc20EfTUVKtYG2N94IN9RrRFWgQq2Uxr+kMvtbOTrEHRV7RLl5Gh6DpCqktDlIvvbNa3nWv4t21L7pRB8N5+y7qTVzzzNg2STGV/31MxM43WYd/eYpPbcIYDjJFNfrZtxmZByswYFpdX18M1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbpixR2QX2IxfOqzV6FjG/PQYRqWrS+gWPCKQ+y6mX0=;
 b=mmzey6lKmWBuBNWO5Bp6XHIAUIweUY4yvWPNkYZYKjztTFNgtouYinnqhpUR+FpNvEVopB8Pez42vBPrxQ/d7aTGkhEOf9bGTze4e2zXuTRBL5SZZOSIDVyjSRP219iUSQxGR3kE7kTuJipuCgYl9lCoyW9i/FkP43UVZ/PO88M2vh9+ASTeP+GVx3yi7E392RXzxSyEmPawPeB9HEb6bfq7xb1ezedXLUqojwc5iLFp/+Z1cQHcKkLw8qSp3xtJHPiARZ1BMCStIB2VrJNLW4NxXa/3FpzVmqJ/uX/mXrXq/E+qO5/FP1Tz0tKBvD9W0dFshNBejwa1WI8gW7xIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbpixR2QX2IxfOqzV6FjG/PQYRqWrS+gWPCKQ+y6mX0=;
 b=a5G49KzSYREqWsdJ3q8ipKcmX3ow3DBe0I0Xa/Ox324a3JALUHPOUcyHOkTilbyMQpLAi5fst9ohOM4O5avhrSOu5ChwKWX+fmzkc+aFhWg5/OGwpLpJLynDngrc6+glya8oOpW5XNfOz/Yv+md4QObM1jHW2j2omi0iFm2s+iXJZ1ns/FttYl33pyuVTg/hu5vk2Mb5xBiscKEu2GUAeFdNsSExXrOoRPmpP0K1HGGbC93QbxMn/uyj89dtDH4+lPZEy0IhmipuwoP0VVo/IwG5M4D1+U+OY8UUq1sdECpgU2uxHPdapeu5l4dnciHa3D+4GHbx8AjAIYNxdnuBxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 17:35:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:35:16 +0000
Message-ID: <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
Date: Wed, 6 May 2026 20:35:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap
 <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <aftaW-irGmkfA7FS@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9b58cb-1ecf-419a-5377-08deab95d61f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|3023799003|3122999024|56012099003;
X-Microsoft-Antispam-Message-Info:
	mpbAvDbWA1sjl1H4sY9TEeFF/HjJIJ4LvUnOtBHxmId7YgVPW5Kyf/sU/N1uOGDeKoSNKPumleu6uZUIIb5bCI0EFfjReIg+FlQzpFOoOw1CCMYpN7PlJvIxbtIpa86xPB3vrI6xbLyHmJMdowDgnkmVEaqYiGJ6Gweh3hg8iHKp42OTJPZPz2vvZjBT+QOLtFa+sbxBf4u65zXacM0NSrSxRGaA90s19iuVO+SgZ+Bk+R9ZJI6aYI55YwSii3ssgyzyVV4QJEaLIw427o899cAQHjuN0n3p7YonYYDhuDhcq3YuG4fp+jfpIVVT3037oLv1gLBFqgkvyyLJj7xteqeWCrZso088zAwE2/3pfighRySVphf/sw5h0y+tM+wkmINcx8cNYXyLPwQolYX/tAoqLa0kxnOO7+6dTKbMe/tDgY1PopGGX3q8oEAkiAB+pPSB0zMID8rjqE9CDOqkGwV/oNnwHK1eq74Z9OyrkA98frt5iPl2BdQ+VhQGU/fnfhX6Z0dG4HfkMgGPAs5S3y/MYZ+MucTS1zBgzu1VfYH5VyZnnOMPBTmIgbKUY4tvWGuTLrNzlvNSgp2yxGgjAyoyWvl8kpSuZrBwR95aBQ6mKVY09wPiCbJ/C57eHuJsQT609Yp7LfQqx0Zh0fvgtf3jCrNj79Iyw0thBLcS7ypX9t7A0zveuuWksxtQyoU9vr3AVX9sCOJDMBVHU1D5gA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(3023799003)(3122999024)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTBDTXJXUzkxUjBlZVNNcjJISm1zQjFSRmcrbFhzWGtBSmY4V3NLNnNPNGZB?=
 =?utf-8?B?Y282UjhmRUxVU0NlbWN6Ry9kNDVFY2dZcXM4akZob3gxNy9tS3p2bTBIZmNR?=
 =?utf-8?B?bk1FcXlSUWZhMlN3d1BRdFVZT3orc1haVzlHZkxrWkZ2Z1JTYU9uSHliOGND?=
 =?utf-8?B?YnplM2xYNFZkSGNPbWFnOGkxaGE2WmZ1OXpXcElyT1ZnV05TSmovc2VPUmNP?=
 =?utf-8?B?NW8wMUNaQmF1clFFbFhGWTlKbVY4MFRYWDFiQ0p1RzJrcWptd1ovd0FvdEhr?=
 =?utf-8?B?Y1JYdGE0cS94UTRWWGg4czJCN0kzTTZ1VG04R0JXakdWb2RBWUJjL1h4UHAw?=
 =?utf-8?B?am5pOGpBYmI4K20zYjJzMHh6QjlheEg2c1BRUDAzcWdWSUZJZ21PZEN2N0hw?=
 =?utf-8?B?cmRmcW0wZG1HWWl2MUZ2MlRyT3NsRmcrdy9nU2xnTFVjeE9BWjRTUUJ0dWRS?=
 =?utf-8?B?RnphVXVqbStyREtaNHpzOUFwNmtkcXFwWWxpaUxCVitnYkkxM3RHdWdrOWdD?=
 =?utf-8?B?Wnk2Vnh2MldCRUlwS1B6N3RuS0h4OHZ0NzM0ZzBTSzV3Z1pmTHFsVmU3Vk1P?=
 =?utf-8?B?ZSttek5Bd2RhQ1pxWXN1akpkeWtkL3pKYmtXV20yeUd6ZmhqQjdoQ3hwZmxm?=
 =?utf-8?B?Qy9VaWh4dXFrUEFLRnB3K0wxbVF6Y0VvRFl1SFJOWmpGQnIvUmJGb2JiTFIy?=
 =?utf-8?B?RStlVG5XMzZpZElLUy9LblQwT2thNkdPdHhseTBpYWtJcDJBTUhzbEV4K09l?=
 =?utf-8?B?QXBEMjJ3VC9RcjlLZlUrL09tQnVhSFpYalova2UzNk83NndiVTh5bnhDTjB0?=
 =?utf-8?B?Y3dKN1FWYUNVMDhWa2FhamNYdVQzRDUxU05JS1JqbkFvb3hKM1RkWWFPbzA0?=
 =?utf-8?B?eG55UDRUOEMyNnZCUnptTkh0djVPNWY0cE02bDB6NVhYQ1VWU2dXR2Z6OG9X?=
 =?utf-8?B?dGxWN0Z2SHZFN3ZlTmVJeW9ScHpOWXBCNWhPNnFZUUh5U3dKdVVXSUtWenU5?=
 =?utf-8?B?bGQ3MGlJcmtOdEV2RUVrbWN0Yk9wOWxjUGlTdndBN1RVRUk3bzdiSG5SRmc4?=
 =?utf-8?B?WmhEQ2VvZVBpZnBGWG80SkE4b3RTbzFhOXdWOUNDenQ1SkpFZ0JobkhGMGg3?=
 =?utf-8?B?NWVRNU82WnNDL0VUU2U1cUc5NFN1bWJCbjVaK0xGdGtDY2pYN0d6aXRldTNJ?=
 =?utf-8?B?TFFhUnlXYWdEcDREQmhhNnZDa2VWOVpTeTBMV3ovRjhBbHpKN2ZrVnQzMllZ?=
 =?utf-8?B?MnBMc2wzeXBpdSsxNy8rL1NIUkRNcDFJOGhnSjZVUHd1d0hBMFlESTlqcnpI?=
 =?utf-8?B?b3YxODBkcE9FbElDQlJzUzdFZUFKTWlWTy9tUDdTMDFjajR5cTBaUllJdjh6?=
 =?utf-8?B?WnNrbkFBa1RoVVdYQ2hkOE04Snh2T3R5NUQvVFBOQ0haU0JaTWptVlh3b1N3?=
 =?utf-8?B?V3QvVUVhYmVmYk1xUHltUy80WklKOHlzMjJOY1psVnVZblBMMXl1dmk5S3lS?=
 =?utf-8?B?Mld2OGdLQlJrMkZ5c1JFMDBtVVdkZXhhTllQZmUxMEhWZS9CY0lxakxvejNh?=
 =?utf-8?B?VXNFaWtENzFkMmQzaHVtSkpWeklNTkhGMTVsaHBDQThET2cwWThUckliYTNF?=
 =?utf-8?B?aG5nY09UOFNZUWlxU0dxTkIyUmJYY1ptTkZsZ3NjZ0pYS0pwUWlqK2lRcFpF?=
 =?utf-8?B?b3Z1cldQanJkNWZDZXVnUjZKb084TTQwVE5oNllPblRMeFViTjg3bnVNZHNB?=
 =?utf-8?B?VHBla0QweXJUUXh6a1c3YW5UeG9aczBRRVBCZlJpYk5xRjROWmExK3pLS0xq?=
 =?utf-8?B?bFBtdis2RlJzclZ3RWpNVWxQNnlkZ3FaY0dlZUNtd2gxVVhFMzhGUG5JaTUr?=
 =?utf-8?B?KzZRbDZIblZPaFdvNzlOcTBHRCs3dkxyeTIrN2dqUFY3TFJtaWwvZDlhTU5R?=
 =?utf-8?B?V05GWnEyRG01cnlka0t1MkJpTW5jUklmVXFjeEdMUHE3RElkSDdsWC9zcHZp?=
 =?utf-8?B?SW5nQU0wR1FxZHlHRVdmQTdyR3I0Y3UyTGd6NG1rdWhYVThVei9sSms1Vy9l?=
 =?utf-8?B?RjJqRDZoWHNzK1lBVmNkcUtYemdLSThTODNrd05OeE5UL3N2QTBDZDZxRWZV?=
 =?utf-8?B?ZXpVeDkwelJrZjVuajFMbEV5YklwZERITWxUYmxFaE9ydmlZbzlTK0RaN1JN?=
 =?utf-8?B?WXpPNnF2cHgzdGlkRXlOUG95QVRSaytHZzZpRVZjODJnbHd2ZjF6UjFVZ3Uy?=
 =?utf-8?B?TWxIR0JiV0pNeUlDWGVvSlk2bTFMdzB2dm5vMW9DQTljZGxPQWtrTko4aEpm?=
 =?utf-8?B?WUxFNThmQzlnYXdSSGFHTGovQ2pqQ1Q0bmNUbmFXa1czNjFnRFkwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9b58cb-1ecf-419a-5377-08deab95d61f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:35:16.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB/Ipal8yy9YUxtzvTPH7xx5WbvI7BX+EktEpr7vvdOiHjDAh+CCwY+PZQoHb4yrXuq/4gbPcwxCHc+6KQv4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-Rspamd-Queue-Id: E213B4DEE73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-20100-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 06/05/2026 18:22, Jiri Pirko wrote:
> Wed, May 06, 2026 at 02:37:35PM +0200, mbloch@nvidia.com wrote:
>> This series adds a devlink= kernel command line parameter for applying
>> selected devlink settings during device initialization.
>>
>> Following a discussion with Jakub[1], I am sending this RFC to get the
>> conversation moving. I started from Jakub's example/request and extended
>> it to cover requirements from production systems and configurations that
>> customers use.
>>
>> One important caveat is that the parsing logic in this RFC was written
>> with AI assistance. I am also not sure whether the resulting syntax and
>> parser are too complex for a kernel command line interface. This is part
>> of why I am sending it as an RFC: to understand what direction and level
>> of complexity would be acceptable to people.
>>
>> The implementation is intended to support the following properties:
>>
>> - A system may have multiple devlink devices that usually need the same
>>  configuration. For a configuration such as eswitch mode switchdev, a
>>  user should be able to specify multiple devices to which that
>>  configuration applies.
>>
>> - There may be ordering dependencies between options. For example, in
>>  mlx5, flow_steering_mode should be set before moving to switchdev.
>>  With this in mind, defaults are applied per device in the left-to-right
>>  order in which they appear on the command line.
>>
>> The intent is to let deployments set devlink defaults before normal
>> userspace orchestration runs, while still using devlink concepts and
> 
> "defaults before normal userspace orchestrarion". I read it as config
> before config, which eventually could be skipped.
> 
> 
>> driver callbacks rather than adding driver-specific module parameters.
>> A default is scoped to one or more devlink handles, for example:
>>
>>  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
>>  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
>>  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev
> 
> I don't like this. What you do, you are basically introducing user
> configuration tool on kernel cmdline.
> 
> The same you would achieve with a proper userspace tool/daemon.
> I did try to come up with it and push it here:
> https://github.com/systemd/systemd/pull/37393
> That didn't get merged for unknown reason, but the idea is sound. You
> provide configuration files for devlink object and systemd-devlinkd
> will apply when they appear. Wouldn't this help your case?

I agree that systemd-devlinkd is the right shape for normal
devlink configuration, and it could probably replace the udev/devlink
plumbing we use today.

The case I am trying to cover is earlier than that.

On BlueField/ECPF/DPU systems, the host PF driver cannot always finish
probing independently of the ECPF side. When the ECPF is the eswitch
manager, the host PF is kept in initializing state until the ECPF eswitch
side is set up and mlx5 enables the external host PF HCA. That happens as
part of moving the ECPF to switchdev.

Today userspace observes the ECPF instance and then switches the
mode through devlink, usually via udev or similar plumbing. That still
leaves a window where the ECPF has probed, userspace has not applied the
mode yet, and the host PF is waiting. With many ECPFs this becomes visible
in host PF probe/boot time. A daemon reacting to the devlink object
appearing can make the userspace side cleaner, but it still runs after the
device has appeared and after userspace scheduling/uevent handling.

Long term, for these DPU deployments, we would like mlx5 to initialize
directly in switchdev. I am hesitant to make that unconditional because it
changes existing behavior and there is no early opt-out before probe. The
cmdline parameter was meant as an explicit opt-in middle step: ask the
driver to apply the same devlink operation during init, before this path
depends on userspace.

We previously tried to address this with an mlx5 module parameter. By
design, that was too coarse: it applied to all mlx5 devices handled by the
module. That makes it usable only for narrow DPU-only configurations. The
devlink-handle based cmdline syntax was intended to keep the opt-in scoped
to the specific devices that need this early switchdev transition.

Mark

> 
> [..]


