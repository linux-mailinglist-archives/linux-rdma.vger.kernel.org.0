Return-Path: <linux-rdma+bounces-20258-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEV5BpUk/mlTnQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20258-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 19:59:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA734FA4E7
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E025530598D8
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA270410D2E;
	Fri,  8 May 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WBB8vOGM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFD3D891C;
	Fri,  8 May 2026 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263158; cv=fail; b=ST+t7LVYdoK2/hNn4mm17Bb5TYYUDNBnydKU1zS5Ppky9F96fsTViT66bqO4JIHQEH5gDJXdRzpPZA8ACSrc/cXheEALQIj4lTf2kk8GEygjECm7iihkap5BMENDd94e0nbQcRESX1d+WwJcF80zFIRKqsiuqfRJ+v2eLFmMHb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263158; c=relaxed/simple;
	bh=mLb//v6M8jWWIODlwSTSTQ0nnhLZ8+OpSJh1t08b9JA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X605z+lIXIm9v9+mGE9E06ptRT1lKl7K7IdgvDuUHeLSwdX8pKLQRd65BgNy2Gmr4YkmVva53sFFZNkKuAMyrrtvZwv8Y7FZVNgbsujc6J07P3DgAOX5WapljlvM5eF7X/jvmqtBqTzXL1I3+/iJKQ+lIbJRbWj/L27osrpR5as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WBB8vOGM; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL/FHeenTPm3uhB3xf9DALhqgYP8D1CpyZPDpRhb0ppuCG/zBGXXwgMfHZfgfc9/DHEbklxPWJZklJ7kcHPFCv285Z/HdGaTdTBCXKUW87mmUC4FmOD6KlGBs+KbIE3TneH7udCpJOCelxkU/0p78u+VE3SK224Ih0WHYjeIWRoAhppNGyIN1GJrOTTpmc9qydS2BtafSu8JZ6xtUi9MWEYj5r1a91237/DU0YuWk9uIgtMy4CvfMhV0q+HdSpZhVrWwOnofe4ASwgf9Q7HkNqG3ha6nTS284FK8iruatyeM2ldQak17bQw13g+38U4smiz4vy8n5K8bOB+m2Hj8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW83zg3kDEpFAByyv53bYOGAjqM5RkwAu/rv/m+Xqmw=;
 b=q9lEw66K0JDQlnLW4MWX4H8QBEx8jLBhf1a9opXOfCWV7k9ffeb9sn7OHBTktnrKiK+RjT1pNv97WMmGO08o+OgjKos/6R+hCDNRLuEUNWsh3eXaBou9hl9Vee+u6lIZFmYeER9SKZs6gpXeK06jEZJqLEW8ytpNJG3XyPXsELiZVqSFnTty1jvyjBcwN4fipqlVi+u/XtPe18OzFQbY2cIMBjo4JdCtfYcFFu9RtRfTQKFpNty1G6sYgT4Y0TZzGAQ4rDLMeLo64OO58P7zv1k16GwTduiglv9TE0WvUIAratUsbG9moajzOybqHlxuc5BTXKHBafUcJMltzZIA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW83zg3kDEpFAByyv53bYOGAjqM5RkwAu/rv/m+Xqmw=;
 b=WBB8vOGMBzZf/786AdbuPRCN03cDsVuFc95IS24TsTYAmiG36RNCu7e+byol6Ko3DE3PATrTypqEeGs9oZ3XiGTT9RqKwrifOiqYEY5EFGi4vSMbd0O7U+IU6AXNuVkNBFGNjuh+fvqL9qNTrzGgfOvBQpiSUicxoZT7JoGDSVK8v1VXoz3O5wJy6ieiL93H9tfJT2acxbT76g9uLuy5ZCETZGKjEtS7r7reoE0ulKQbZudnYgVyrlEd2fUtzPMoKN1DLC7nsquqQQvxvochwOGapP0K7GLm4CeUzf4BfvvuoSN8I/wz+oTBBUfGx7QSsezpD8buEk2OvJ2OquWIoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 17:59:09 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 17:59:09 +0000
Message-ID: <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
Date: Fri, 8 May 2026 20:59:04 +0300
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
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <afxvzOjqw-vxUAED@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfaf233-7020-4530-9561-08dead2b80c7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3023799003|56012099003|22082099003|3122999024|18002099003;
X-Microsoft-Antispam-Message-Info:
	AO+BO6iLlbOTAXtCE3nfO/9PaUiRNmTfS4t9FWXVU77xA+r6Ch+btjg7gI3gwNdNaX2aOaq64MFze5wj1XshAFzk5pfE/GaMo0qJ3A8zY9Ju3NBcoA6sMkkAi7RFhF4id0HB98EO/ivRV+mHHV2I4pJcQIY91As5ocSc/z7GFNYr2KK7hcYaZ3rFc2zoZoO0QxUIbAOOfRWpwTMtqTkYYWYbERzBCq/SWcP/6c98qToNRW3iJrWptFqZK2tNEdFBcWrFWIVY1gYI5qUnzYrKP4Kx6sqZEXNiWhBqTqyguRoBTGtc9aUHMW1tcUyNRHjwJs695SeJ/Ic4Jl0CigpzgdLsAm0Dfy7mTmwVdQxZizyM3W01x/EsaPK5W4X6vsEHaOw+8XdyG+S+R30kvXp878Hk9RQPWcS7wBDaEtTRATpmX02T9juzXWIPyTbsBK/7dEZbhC97JpgWvRjQV9s1VvPjmExDygNt2jJe5/SFhil5n9PhAKT3ikSHMkrYqqjR6gv7Txi35wQkxaXZBhea7bEfkuiRNgymUVzKzghztnKcL/6li6Ud/49k2dEa5NiAYlEeF2IqYQYgijgRp2ExeDxDeR3hfmXy+i/efZ8O1e8qhkLAt3AxWvVUpCjNwi8A9caCtGIvJLccNvHckxfTDGrVj0pX/jWnw3SIUvz7TPgQZKM1+Y96J0fLMu5ls3N0a0EzAxrD4J7kcibvHsmqlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799003)(56012099003)(22082099003)(3122999024)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVLVmlSSG9ZYmRtODBEZ29NZ1ZZODJmVWZWVm9yaUltdkU2WHpFNEhnL3Vh?=
 =?utf-8?B?SU5GMDFSOFNIMEJyM2NvV3ViOFlrNzZGWTRsQWpTT3diUEl2UWU3UUJzeFIz?=
 =?utf-8?B?OURJZFdwN2FQcVIzVHRlSjkrSytJejVSNjNCbTBLdUlUb1FiazdybTBFVFAv?=
 =?utf-8?B?a0E1RXNGUzFRMlZNZWRiMk9Sd0JLNkkzK2lEanczeHVpNVZydWlvTzlBbllT?=
 =?utf-8?B?UlRiM0dLbHRwOXZibUJ6UXFoZUN5SFVVeXNFNVBSUk1weHpBamM2RUIzR2lH?=
 =?utf-8?B?ZnFpeXgvQTA0MzBac3NwU3phSmQvM1lJOER5dkd5UWt5VUhXRmF2TTN0WjBG?=
 =?utf-8?B?VG5GQWtiQUphTHJPWGlYaEVlU3cyWTFjT3Z4dSt2Z1h1L2pUQXM3SnJPL0s1?=
 =?utf-8?B?S0hQZTU5MGlFYUw0NVRjRUdBK0Rza095dmoreFRBdFRHZU1QNXlRRVc3Mkpy?=
 =?utf-8?B?KzRXTU1nNFNJMWJYYU5BS3lnbEIyaFhhdFBlU2J6Q2V3Qnl2YUZvN1pJZkpH?=
 =?utf-8?B?TXQyQWc4TEtuRytPNXF5eitzN0NaWDhWQk5JYmxvem03RXIxeWxWZW9FbnRF?=
 =?utf-8?B?dnZhakp3dmc4OUNHNVhEZ2tuQUhlYTRuYWtoR3JkZktaeXpoLzIvQ1I1TkJ6?=
 =?utf-8?B?YVczQVVFOE1WWWN4b3FyRVF0MGtqTjdpc0Qza3NaK2JSNkJlQzFYMnNHZkdu?=
 =?utf-8?B?K01LL3hRdU5ZL05CVHBLcSs1YkxlSkUrU0FuQjlYUXphOVc2R1VaWXhjWm5x?=
 =?utf-8?B?TXhPNnVQSDlJSW1pVFJWeGRZZzlISmlFWmhFN3R4Y2VUR3AvanJjR0xPQ2h3?=
 =?utf-8?B?RHI3NG0zbE1vV2xkOGt3WS96UVFSeGFicDNGUGlBUTNrcHl4N3B2OEllVkh6?=
 =?utf-8?B?OWNNRVlyVDlRbFc5dElVSm9Db1lnTzFLc3NtK2lQRDZWNk9rSzhVZU1QSWIr?=
 =?utf-8?B?MlJsQmpYZG1KTVprdGRNZGZvM0tMd0NoUFoxbUVaY3cvcnc2aG0wVjMya2po?=
 =?utf-8?B?dExvU0NUZ2s3UHlUR3Z5bXBWZnBJdnFMOTdUa2poa1NVZVc5Tm90MzhnVzhF?=
 =?utf-8?B?YVRyUXFkclFPeURZVkVVMXFXNVVWcVBoVmtLYSs2R1ZDOTl1S3dmdFNSdEM3?=
 =?utf-8?B?Rkx5ZkhmVk9CZ3BvaENCVithOEJ3NHh5WXl0dW55Q292WmdYMkd4T1BFbDdo?=
 =?utf-8?B?M3lLVTNRclY1UGtXZjZENnV2Yk5tUnd0K1RLNk5kYXJPaDlRQVJycEdyMW5r?=
 =?utf-8?B?QmxzY3hVV3FhTzhFeFRhbzVkUFZsbEpCZXZqVDhTOWFsNU9Sc0p5S3o3cmI3?=
 =?utf-8?B?L1I0WEVZNVdpMWJ0OEhrVnZrU0QydEJxVTRkc0l5K0tKS0lLbUV2OWpUcEt4?=
 =?utf-8?B?NWw5MDRISC9FR0JxN1gybWZJaUx3bDF6NG9UaVNaS0hTVlh4VmtkTzNYZUV4?=
 =?utf-8?B?cEFpQVkxamxmUXEzT3ZMVmphbEFValdYanVxRWpsd3VTYVJzdUdiT01Lb0Z3?=
 =?utf-8?B?eXQxQXd1MFhUVC9OM3FJTHdYUGN0NDNOYkxVbSt3ZEhrd003T3VyU3daNEVt?=
 =?utf-8?B?OC9DbjVRWDB3ejBlWkw4Z1A3Q290Wno0b2Vud3hlQUFRYVBhaHZTV3lyYnkx?=
 =?utf-8?B?L05xVFVlYmZySXVFUUdQUTU2dHZGYmdtampTZ0k0WDBLeVBqRlRxR3VlWDdO?=
 =?utf-8?B?U0x5T2libVdIU1B4NUVrSTFHUllSZlZoM2VjUndYUERZcWtNV05SbDRlaHZi?=
 =?utf-8?B?SXNoaVNyc3NrRC9EQlFVY05DVEREVlJtTkk5QkhpMEQ0RnZLUVVvZFpiNUY2?=
 =?utf-8?B?dUpsTExER0hsSm9lYXVkUGRYUHp5NHgxWmFPSTZJVWlKbHRFZGpNdnV0SlBk?=
 =?utf-8?B?KzladUY3eDF6QmdQQ1htRDRKWkN5V0R0QTdROGVjUXFtVFVUdmpsSDFIVjhk?=
 =?utf-8?B?c1JUSWtXbGFqQ3JCd0ZGcy9zOXArYzI2cFVZQmhEK2NqVVZmRUU1UkNmZjRY?=
 =?utf-8?B?bThWMk9mdjBtV0tvVDQ1enVmbFRaM0h0M0ltR1Q1NTZHYkpKQTkvWXZBOU11?=
 =?utf-8?B?NnZmS2ZIdkg4bmlLQ0ZrR0tXbVdudmtKRWwxZmhCZTdqc2N0NERHc1J1TURZ?=
 =?utf-8?B?bEZqYVN0SmRnYmY2eEpUZVliMkkwM25zZU9hTXM4bEplNUtTNnJPdWZDVlZS?=
 =?utf-8?B?UXFQUmhncjRqWWloR3Q1YXJITmlvc1VOYm5pb3RLcTZrc2ovNnFYV1dHenhR?=
 =?utf-8?B?Z21TTzNtdCtGRU8wWER0MHZwR1AvTkhvd3dLWk9Xb3JVZHZEU3JWSVpocWNV?=
 =?utf-8?B?Qy9LY3NhQVBPRG5TWFBXUFZNV2VTVFFSTkVOSExTTk1CZzN5a2hudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfaf233-7020-4530-9561-08dead2b80c7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 17:59:09.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUmtVmq1W+IIHrsogdJsLAeCkrLXSqu4PgpP9A6bwr+dQYWLV4esDNjC700TxdDOKLVyLvWsVfc+NVVZetY4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
X-Rspamd-Queue-Id: BEA734FA4E7
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
	TAGGED_FROM(0.00)[bounces-20258-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 07/05/2026 14:03, Jiri Pirko wrote:
> Wed, May 06, 2026 at 07:35:10PM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 06/05/2026 18:22, Jiri Pirko wrote:
>>> Wed, May 06, 2026 at 02:37:35PM +0200, mbloch@nvidia.com wrote:
>>>> This series adds a devlink= kernel command line parameter for applying
>>>> selected devlink settings during device initialization.
>>>>
>>>> Following a discussion with Jakub[1], I am sending this RFC to get the
>>>> conversation moving. I started from Jakub's example/request and extended
>>>> it to cover requirements from production systems and configurations that
>>>> customers use.
>>>>
>>>> One important caveat is that the parsing logic in this RFC was written
>>>> with AI assistance. I am also not sure whether the resulting syntax and
>>>> parser are too complex for a kernel command line interface. This is part
>>>> of why I am sending it as an RFC: to understand what direction and level
>>>> of complexity would be acceptable to people.
>>>>
>>>> The implementation is intended to support the following properties:
>>>>
>>>> - A system may have multiple devlink devices that usually need the same
>>>>  configuration. For a configuration such as eswitch mode switchdev, a
>>>>  user should be able to specify multiple devices to which that
>>>>  configuration applies.
>>>>
>>>> - There may be ordering dependencies between options. For example, in
>>>>  mlx5, flow_steering_mode should be set before moving to switchdev.
>>>>  With this in mind, defaults are applied per device in the left-to-right
>>>>  order in which they appear on the command line.
>>>>
>>>> The intent is to let deployments set devlink defaults before normal
>>>> userspace orchestration runs, while still using devlink concepts and
>>>
>>> "defaults before normal userspace orchestrarion". I read it as config
>>> before config, which eventually could be skipped.
>>>
>>>
>>>> driver callbacks rather than adding driver-specific module parameters.
>>>> A default is scoped to one or more devlink handles, for example:
>>>>
>>>>  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
>>>>  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
>>>>  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev
>>>
>>> I don't like this. What you do, you are basically introducing user
>>> configuration tool on kernel cmdline.
>>>
>>> The same you would achieve with a proper userspace tool/daemon.
>>> I did try to come up with it and push it here:
>>> https://github.com/systemd/systemd/pull/37393
>>> That didn't get merged for unknown reason, but the idea is sound. You
>>> provide configuration files for devlink object and systemd-devlinkd
>>> will apply when they appear. Wouldn't this help your case?
>>
>> I agree that systemd-devlinkd is the right shape for normal
>> devlink configuration, and it could probably replace the udev/devlink
>> plumbing we use today.
>>
>> The case I am trying to cover is earlier than that.
>>
>> On BlueField/ECPF/DPU systems, the host PF driver cannot always finish
>> probing independently of the ECPF side. When the ECPF is the eswitch
>> manager, the host PF is kept in initializing state until the ECPF eswitch
>> side is set up and mlx5 enables the external host PF HCA. That happens as
>> part of moving the ECPF to switchdev.
>>
>> Today userspace observes the ECPF instance and then switches the
>> mode through devlink, usually via udev or similar plumbing. That still
>> leaves a window where the ECPF has probed, userspace has not applied the
>> mode yet, and the host PF is waiting. With many ECPFs this becomes visible
>> in host PF probe/boot time. A daemon reacting to the devlink object
>> appearing can make the userspace side cleaner, but it still runs after the
>> device has appeared and after userspace scheduling/uevent handling.
>>
>> Long term, for these DPU deployments, we would like mlx5 to initialize
>> directly in switchdev. I am hesitant to make that unconditional because it
>> changes existing behavior and there is no early opt-out before probe. The
>> cmdline parameter was meant as an explicit opt-in middle step: ask the
>> driver to apply the same devlink operation during init, before this path
>> depends on userspace.
>>
>> We previously tried to address this with an mlx5 module parameter. By
>> design, that was too coarse: it applied to all mlx5 devices handled by the
>> module. That makes it usable only for narrow DPU-only configurations. The
>> devlink-handle based cmdline syntax was intended to keep the opt-in scoped
>> to the specific devices that need this early switchdev transition.
> 
> The switchdev mode was introduced at roughly the time CX4 was out. What
> stopped us from making it default for CX4+ ?
> 
> Introducing this horrible plumbing only bacause we were not able to
> change the default sounds so absurd.
> 
> Can we write the default mode as a bit in ASIC NV memory perhaps? Simple
> devlink cmode permanent param to write it, the driver can read this bit
> during init to decide the init flow path?

I don't think switchdev by default should mean CX4+ in general. If we get
there, I would expect it to be limited to the DPU/BlueField/ECPF case, where
the host PF probe path can depend on the ECPF reaching switchdev. Changing the
default for regular host NIC deployments feels like a much larger compatibility
change.

For the ASIC/NV bit: maybe technically possible, but it feels like the wrong
layer. This is boot/deployment policy, not a persistent hardware property, and
storing it in NV memory would make the state persist across kernels/hosts in a
surprising way.

I do agree the RFC probably went too far by making a generic devlink cmdline
configuration language. Maybe the smaller thing to discuss is only:

devlink=[pci/...]:esw:mode:{legacy|switchdev|switchdev_inactive}

No runtime params, no ordering between different operations, just early eswitch
mode for explicitly selected handles.

@Jakub, I know you wanted something more generic/extensible, but maybe the
generic case belongs in the devlinkd/systemd direction Jiri pointed at, while
the kernel cmdline handles only this early boot eswitch mode case.

Mark

