Return-Path: <linux-rdma+bounces-21322-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMzuHCe7FWrKYQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21322-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 17:24:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB55D8A30
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BAE2303B426
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F2413235;
	Tue, 26 May 2026 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tO0uhGzL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1A409627;
	Tue, 26 May 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807860; cv=fail; b=VYI9EKmiPPczIjFR5mWzpuUi4sm6KgHfh20AQ14Rcbn1FYFAw1p9qMB+oCrG0r1FxE04T9BYxR8Bryiz67DCEoOME9nVoYXE2VvE0roXYFIjMHtdAvOBY3a4jBxx97hvp/driM6E9fq4dfxiYE/LKavznSBNrcqjm8x8o8oFMqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807860; c=relaxed/simple;
	bh=4Q4XcZbQwqXojTkAmdrShOd7A1ILLJph4QbyrivmVPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pyp00raSBDA87uQfJI8KPiseTFM8xRHDKu8tGUbm8Z3rNZaVpqAqOkKPitd8dZxkxWkPb/yrtYuV30XhQEzQh04BIQGBMVCSBzD23YDYDVZbWk2wph/FNhlVtUUSRDt1RYbNT57j/PJtWlY1jrdjTG0YhUj+5fl6z5LmoxnPoWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tO0uhGzL; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9IKIhlMreyOsk4OeiGMWBuRrqc4TvYUqf51kRdLYhnmlZ/Acyu2Uves1s96/Zy5io7e6XLOWsnCJPX70arF//Ih6uLAatVd8cWjbk5tgYuLBUgxKZeIGbaKa8DriLVnLjhQ229bVBNEmc2zcwQzJllTau7BZwPfvgZC+U1TZNSWHh3gdI9KTvXZA3IpNo1rHvhW9hj+eWpUVZS200E+XQc4czVHk+s1xFkai0nWcw+0W8We2YGUWMfRnt/0qeZEhBpaa9Qyzbb/6ZIJIG9o62x1PbjfToC95xIecHGBT72Cczc8qwd/VYW+4kH1d0Cs3fF6dbj6Omd8SAsfJj7gpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5LsmQlvPT4UCRK8/ZsryddoJ4qEIqNyt12AwIRBX40=;
 b=jQy3pN3nDFeLfxkccGQrPITIsSpEUv9jQS57qk4qXUfCLcALKMyQEJT/OWd4XEd+RYQ5NusW0vILNsTikdNfKtzdc5gwmt883WFlMygORMekrIacyXxDdRVEUiO7wONAk6NtvJ+egeMRyQYGQRAtBsNjpQMc8IkLyMZ1frEinWREG1ghR9LodRd0KEXOSVgHj4kbGCpcTzJVxE1tuTGU/aZwf5qu0G2K7hPU7sMZfBTxrEUstqGHw7SRKQtPJtQ7Yrhfbr2vU6lcnloo18Gfmov2Epxm2xW9cNJWjaPIsBof7D1I4TtThcfxTTM2IWZl2FmMSYypZh/9Pm7jD8g3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5LsmQlvPT4UCRK8/ZsryddoJ4qEIqNyt12AwIRBX40=;
 b=tO0uhGzLAl6YMtC22LlXV78tuuLWt1vsq20BzGzG9AnSsPXAeueGnVqTQBtq4Aqk4wjx7BFvX7XwvvejZtIKnUyhs5qErxdF15SxbafEX5KBwEeQEWVNt/xOqPp6La9YtGyzB4a3dtpLtoniWb920eZE0cbnvHWlTwyjlQolqzu22Dm+zcWykVgQoNNrfEhcxXLploDg0Un73VDmZeTpL20rpPQJdGNtxH2UxTKmmT5WXf78WpDG56i5qZFKbSO/UYtR6rrCB/kQ7lwzh7RjhPvMMo6u1turWXftO/8uVNY1JvN/7kbh2NKWn0JindnRJM5sbsy8NjYsruQwu1kgEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 15:04:04 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 15:04:04 +0000
Message-ID: <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
Date: Tue, 26 May 2026 18:03:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com> <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ahWm4NXph9gdazV_@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe02b70-7b7a-46b5-50bf-08debb380725
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7136999003|11062099010|4143699003|6133799003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XtbFdUYJQ4WeajeniKu1XGh0hXYJDeITCz9e9S0MWQOKJOyocI/YtIQJ1fCUUHr85q2EuRbV/GV0hoeNJHmJM8kF1/Gkz8P3A2uvJJZJzTDad0IzU0oW9X6gLzTzAAIfNUuauw+dH8IIktNw8+ZKvmue6FQG/t8LI2pkdlzXS4fxo4jUiRjLgmLZbLIcN8DHV+uhpQ0dni9CyZxiwHU1lWsRdRonmxEizltlzo03YV6ZWIp2HA3ESvI3FXDS4+bTGCaMbf15A7KbeScGfHBw2CHuo18nGoSl+CktwclS+njjPSkus/lrFHJ6vhMxulrWc9r65IHp42yv4z0T8n7scc7ZSHtcnwhORPzmyC4d9Y/L/iNkRpRFm+w3tG2l65E3+XEHPzBEInKfjmtvLKX6UoiLcEUbg33DbWNfSr8ZAQT27CvwUZgpiUw4Wb4LgcTwKjj35oUCDQGB1NqO+OJfO8vRI2p7D5tDqm/M75MIXB/WMuE07g7Pxo0TOY7cfVlRio7TBoai/CdWWkpTwFpKVvDMOqg3mV/zlQOj8wHqPFmxiobVHmljyapkrsN19/ah6DeHI9rLg9LsDcC1xfRwd9lRuYdCXRZL6p9LTu4j08kBHyg/PuTfULZHri+VUNxprX52CI4vZQOQ6TKw+0LI+DJFZSxjo0Go0aQrjAvlQUVDQJwFeFUXL1HERuh00d94
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7136999003)(11062099010)(4143699003)(6133799003)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3lhT2UxVmtkaXgvd2dEZTM0b0VDV3ZzdFZMQXQ2Y3VWejVrNncyNFA2cEZq?=
 =?utf-8?B?T1BkTXE4OUZLaldYcWNBaEdBdkJrbS9pRXljVG1MTUxNaDZwTXFwQTVoWEFr?=
 =?utf-8?B?K3FZeHE1WUlQQlV5anVaek10NjAzNWFvaklBb1hvcnkwTW9YaWpCbHhUZ1ZG?=
 =?utf-8?B?TUtYSFdHYWdjNGR5SUNlc1YzY3cyU09pczJXZG0yK2N0TmkrdVZqVDJxNTNV?=
 =?utf-8?B?NTBKaDBZdW5HYitDVi9RT05uU3BxeTcyYUcvMmxuS0hsYmM4NXkrUFkzMnEv?=
 =?utf-8?B?N0QxMHFpUVRBZmZLVG5KWVNKRnJVSFAvMWJYQmorRndzY1NwMXUwaG1aMHdL?=
 =?utf-8?B?alV5ZmJBMURjM0RpKzhoWVRzUGlSdGNPbHZ4eUJ3WmQ4eWlrRkZwZlVBZ3RK?=
 =?utf-8?B?N3VORjQxUEg1N0FXSDlWRVJPaDFXek1aZEhCck9WazdjL2pmUVlPT0VZM2lo?=
 =?utf-8?B?ZTlhUnpvYUJFcUFvTnVESjZpd3V2anQ5MVVKR2JBaXlhMDI1Vk1zd0EvU1dR?=
 =?utf-8?B?MU9LajFvbzJKRUFIY2dlMHQ2RUtPMFFNV0o2dmllZmdGNTFsWGh3N0k0Rko2?=
 =?utf-8?B?cytPRGYvNEFkZDhOaVFTK0FmQVMycFcvUlFLSzY5c1VFTEJ6Y1d2NkhMOUtK?=
 =?utf-8?B?QjExSmt5a3Z4ekI2dVpDQVdRT0hJZTNxOTEvdVVxNEVzMXU5OW5IZ01vclVX?=
 =?utf-8?B?Tmd1eHROUmd0M2xKT0FnMnc1dVNyeUZ4ZUd1WHJ5ZjdwbWltNGVseDVYYzMz?=
 =?utf-8?B?RjNwVTdHb3NpaC9zTCtRMW4zQ01rU0ZlN0lrV2IySU05cWpJUElZR1F6c29H?=
 =?utf-8?B?RHViZDBaS1M2ZnIvY0l6MzJsZTRyM05Tem9XcTBtZDdoQjVhMGZzbkxuNDdP?=
 =?utf-8?B?UGxUOXNaOW40Vk1HNk93Q1U0MTVxWjJ3aUZaZnNWellYOGRtaStPQlc5dCs3?=
 =?utf-8?B?aUlQUWhNc0FYZ1I1dUZyb0JBUFRwQ2dibFNxMkFRSnN4TXphaHdXQlhKNUZO?=
 =?utf-8?B?bGFpc0VIZjNPREkrYmo0aXBlNWM3d0tqMm8rTW5BNlpmOGJFd2NtYlpmWHFU?=
 =?utf-8?B?QlljOGJxUjBSM3FrZUE0K2JYZVl0UXV1dEpKNFkxTlJTOVREUkNRYWduOUFJ?=
 =?utf-8?B?b2JjdXJoZm8vUXptZVk1ZzZocE1QUjY1TmpCM2psMkpvUUFCekdwKzFaUVNJ?=
 =?utf-8?B?QkQveHdUWk04a0NqTjZIZmFVZFdjNHF5NzEweU92c0FpUnBZYUw0UTB6S1hF?=
 =?utf-8?B?UjlySWJEZHZScHZ4TkNTMXhuSjd1dm9zR1VhdzFUM1R2bnVPbWlUNjJucjBB?=
 =?utf-8?B?ZmNZbkZWS1NiNm9vc0U2TkJMY2hBVWVKVVkrMkxTL0QreWl4MC9iZFd2Y2E0?=
 =?utf-8?B?TC9VVEdscTR3N2paNjhMNWtRTjdLd1JOV0ZjenJXSkZldnFiUVpQTlNHQ2w4?=
 =?utf-8?B?cWNHMC9pbTRSRVFGZ0hkYTlkSHVWQ3BBaEJGbzhtRDJibVJacVFBdnAza3Va?=
 =?utf-8?B?bXM3TUVHR1phbE9jWWgxOE5sM1IrQTJOTjkreXp4OGJrWGhiNjRqamRwR25U?=
 =?utf-8?B?OEQxRlNxYmhiS1JQcnI1bm1DSDQ3VEoyS2tyVkpHSE1VbEZNSmFJSEZEYTM0?=
 =?utf-8?B?NTloQ1U3dzRjTTZkZzVSb0lUeEo5YXdBOVpoTFRVMmlaTFRZcTVZcEt6MlRG?=
 =?utf-8?B?WG5LT2RaU0pMMDRRQ1RPSEJtR1lTWmdKditmeVNncWFUYmtPcnBQUGdNWWtl?=
 =?utf-8?B?NnZyNDZ4MnN1Vk00dWpaVHhCZEU2OGhNZ1p4NUVjTU9mbUxKNDRMZkp5OGFo?=
 =?utf-8?B?S0FNSUx1VkIvamxGZE5GcUYyOUZ3QkVpNk9aNzRILzdRbHRrMEt6R2JiTXg3?=
 =?utf-8?B?bVM2eWIxRVA4WVpDTm9UZm9YTVVKMFFoalNiakxML1VMSXAxU1NJUkpsSnNv?=
 =?utf-8?B?M1pJRE92bmFRSlZDSkcyVGlYU2piMHo1S3U1Z3pTOUxTSElUVTFCT1dMTnp2?=
 =?utf-8?B?TG1WZlhaZzJmQUVpYUo0SVJJL1Vrc1FhQ2ZCNHJ1VERyZEtsQ2ZHeFczY0NR?=
 =?utf-8?B?U1VCTEtSM0MzQ3JGWUw0K1o0RGlKa0ZLaGNmMGpoRHp1NVB4VzNvTHJLVVpX?=
 =?utf-8?B?cG92ZENwVVpJNllpUmdtVjh4VzdNNzB5ZUxwU1VmWkt2c2c4ZGcxbXVRK3Bo?=
 =?utf-8?B?R3AyZ0NNVXpRSG5ZaDFPUFNwaUdSSHB6OTVKTHROMjE5QjFWUHg0M1RScWVZ?=
 =?utf-8?B?cm9Cbi95M0R6QVN4MW5YOEZtS1lVVWNVRjNoN2MxOUxuSlFENTdKY1A5MDQ1?=
 =?utf-8?B?WG4vNVI0YSs2TXJsVmJBbWI2MVIvQjB3VG1ienRaUnFvVk50OUFOZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe02b70-7b7a-46b5-50bf-08debb380725
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:04:04.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwj5Ex724esXvkkzTpwx+gdHz9j2Hm/rgiITmosArWl1xhucQ/Iqdxmpu25NVYjnsV4S8x5jQEiQbB99FYUFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-21322-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 33DB55D8A30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 17:07, Jiri Pirko wrote:
> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>
>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>> device initialization while holding the devlink instance lock.
>>>>
>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>> operations are available, so the default eswitch mode can be applied to
>>>> the matching PCI devlink handle.
>>>>
>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>> ---
>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>> 1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>> }
>>>>
>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>> +{
>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>> +	int err;
>>>> +
>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>> +		return;
>>>> +
>>>> +	devl_assert_locked(devlink);
>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>> +	if (err)
>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>> +			       err);
>>>> +}
>>>> +
>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>> {
>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>
>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>
>>> I wonder how we can make this work for all. I mean, other driver would
>>> silently ignore this command like arg, right? Any idea how to make all
>>> drivers follow the arg from very beginning?
>>>
>>
>> I have a follow-up series that adds the call to all drivers which support
>> setting eswitch mode. When going over the other drivers, what I found is
>> that the right point to apply the default is driver specific, drivers
>> I have patch for:
>>
>> 46e16c6d9836 net: Apply devlink esw mode defaults
>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>
>> I don't think doing this generically from devlink is realistic. devlink
>> doesn't really know when a given driver is ready to change eswitch mode.
>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>> be ready first, and the locking is not identical across drivers either.
> 
> 
> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
> of register. Multiple reasons:
> 
> 1) end of devl_register is exactly the point userspace is free to issue
>    the eswitch mode set. Driver should be ready to handle it.
> 2) all drivers would transparently get this functionality, without
>    actually knowing this kernel command line arg ever existed, without
>    odd wiring call of related exported function. I prefer that stongly.
> 3) you should add a there warning for the case this arg is passed yet
>    the driver does not implement eswitch_mode_set. User should
>    get a feedback like this, not silent ignore.
> 
> The only loose end is see it the void return of devl_register().
> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
> probably just go for pr_warn, seems to be the most correct.
> 
> Make sense?

I see the point, but I don't think devl_register() (at least not the only place)
is the right place.

There is a small but important difference between userspace doing
"devlink eswitch set" after register is done, and devlink core calling
eswitch_mode_set() from inside the register flow.

Some drivers call devlink_register() while holding the device lock.
liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
there, we may start the full eswitch mode change while holding that lock.
That mode change can create representors, register netdevs, take rtnl,
allocate resources, etc. I don't think we want this to become an implicit
side effect of devlink registration.

For mlx5, the placement after intf_state_mutex is also intentional:

mutex_unlock(&dev->intf_state_mutex);
mlx5_devl_apply_default_esw_mode(dev);

We can't call it while holding intf_state_mutex because the mode set path
takes it internally, and switchdev mode may also create IB representors.

Also, devl_register() only covers the first registration. The mlx5 call in
mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
In those flows devlink is already registered, so devl_register() is not
called again, but the driver state was rebuilt and we may need to apply the
default again.

Same for reload, fw reset and pci recovery in general. If the driver tears
down and rebuilds eswitch related state, the place to apply the default is
in that driver's reinit flow, not in devl_register().

When I went over the other drivers, the right place was not always the same
as devlink registration. I'm not an expert in any of them, so I hope I got
the details right, but for example octeontx2 AF needs sr-iov and the
representor switch state to be initialized first. nfp can do it after
app/vNIC init while the devlink lock is already held. liquidio should do it
only after dropping the PCI device lock.

Mark

> 
> 
>>
>> Also, since this knob is only about eswitch mode, I don't think we need to
>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>> would just ignore it anyway. The follow-up only wires the default into
>> drivers that actually support changing eswitch mode.
>>
>> Mark
>>
>>>
>>>> 	return 0;
>>>>
>>>> err_register:
>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>> 		goto err_attach;
>>>>
>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>> 	return 0;
>>>>
>>>> err_attach:
>>>> -- 
>>>> 2.44.0
>>>>
>>


