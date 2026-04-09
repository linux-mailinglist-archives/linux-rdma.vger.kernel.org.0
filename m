Return-Path: <linux-rdma+bounces-19183-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEF1KOPp12msUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19183-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:03:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3FF3CE69C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37B03026A8E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524623E0C55;
	Thu,  9 Apr 2026 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/EQjOLH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F703321DC;
	Thu,  9 Apr 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757753; cv=fail; b=Xbo/TyjZO4Lmb0A1fr0F3mlqgwyKc/zPx8aX8zIbLBaqzsrBbfluOqBmbxiW3fGD00WE1rRS9bR9DpAneR5sBvqRSYTNvKOldlSIdfjz7V9Ka5nG+8Iu615DO5oAncPteGbPPW7G6SOH2UGqf2N92gBXhBYBEYD4YYcUcQBKoZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757753; c=relaxed/simple;
	bh=YmijSEkUsb0iY51z1i/HikJVOBC3MBYMU6L2SppTgTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CMTe53QVkqQl9joLF2VRzLj5WIhLPG5YL00YqZyZoty1rlMEqAmM2yulVYAfLy7LsxRTIgnK6w/JkMg5SVGNxoi2nTabE00LvVoSDRYT/PljXJne5kz+56CdIlQAdAVtNLJC1rePNkU7agWpCBUENdCo+95qPpRMQqulFtzVhcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/EQjOLH; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH8YZemGgAVXoSn/lNY+ipi0aa8sLEzhva/WbB3Up1YbUB2EK3UTkR+3eLf73DWmMHmYdcKjxy50HZQSyRzB3MCxljbKdq6LPpVU+sbdNYNxdoXRt3FyzThgc9ABYYgkYk6zYhEHiO+2GEWHXlZZT/HaScqwqVjfq2zkljES/+nv1FdFwOC8sRStGkMdQzlz1SQVV8VPIkBBARhPCqBfjbghefV8ihjgVkfW+45EgBn6QukRVigSLOwLmTwrMRw1K5AKZfTrvUsQFNvlfVPsyu8PAhgpyfrTBIwqZllmrIP7QgUN43Uq8fzDShqmfxxzUU25YZO4yqqmrAMJqCKb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r992cBmiKdLj8/gvJFcGmafapo5pBCHX2hu3j/nuEnA=;
 b=yMxKByrrneEvZXaWpgPJ+lo1LpVdW1Gjs9LtEz3zTOC86P5FQTRYaZ2LSLfx4m4Dy0AW0D9jbCj+tmmZaKgIYKqgVbd8O0wo8crTnktspMFMItN00eZL8Mf9wUMOP2CHd/k6jODgVxoYoL6X7SjSE4OstsjG3vxzr4GXoUa4xXH/MXqXY3khuuu1S7ahPmsFUQ3NErLdDpwZvPNG3naxzoUezgDi1IxSjpmlVcuLTo2KWJWi9RykTBlTlBjXcJb/yMAyvGLvXcp5vRy6AWRumitpqNzDpGZqtTJNnzFAq++gIakjFr3ZFpuix9zGUfP4PaSCTP7kXxtl7irfgZE1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r992cBmiKdLj8/gvJFcGmafapo5pBCHX2hu3j/nuEnA=;
 b=k/EQjOLHMfTt67jP9YRY+2KYTpY71JYDTJxuIEeS5uU+/SG6C3ma2Jb6qLB6zdvPk8ypVhKGOomyN5Fp8wJj+bJM8KoMXZT6Lttv/8aBawHTOi6P6hw8wB601KRpXqxyBOXIlzcMmWO50MhLqOmOEepf97yeddlT4xtCQSWlMrgf7bUmvuM1VxsA/4FnAQAnz6WDpA4weSreXvBJ7LLqyc6vazND0BoxcIKaioWpwsZ16kQBdwvfoCgw0HjHs17B64lbH6CzIt3Q3O3I9ul2+W0Wxzmi7jNesImUzoQdZSYR3NhYz9mGh04/D/s6mC5MfcXcYjwkm1MIQ4kjDcqVBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Thu, 9 Apr
 2026 18:02:23 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:02:22 +0000
Message-ID: <99a9bf58-a2d9-4857-9f98-8ab771e94178@nvidia.com>
Date: Thu, 9 Apr 2026 21:02:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] net/mlx5: E-switch, load reps via work queue
 after registration
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-7-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-7-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e3422e-0f25-475a-573e-08de9662263e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nG+TAkxd7isYAZxYU1o9CwzH4DY7Zko5S3+tJZ7WEoSSvC6dcs6H91HHLk3zOqtOUiQBRJcW+5jfSUukETQqLLTYAKM2tGddG6sINIMOjxkzoxcNEJ7Mfa8wfE6j7++xvirjNmb7dewskp9LZ4U0Xv9nC6hA+EmumSOHmOmm6G34nZEftT6wWPpHdzH1vszcXyE+1DWRthSJau38YGb+0AJHUvy0dhggKOmNmYRKXnGYAz7ySHq9rm/Hf70nywcYN5VFaa6Ru7Z+F2ZUmExJ/Pch1HwAHBcEHwkB9Yn8QdUm6diTC2b3w5qcGeC1XtbRySsNoLo6f9+CW2r5uzn6eojuUS630HKQypYx4ZrC+BzJ/p8HhcJToQ3/zbUMvI6/DezAGT1DpcQdrjtvOitPuxdLs7YBS23pwL//4LCmdDPxsGSkt/6dXGI8xhCu4eIXE/pr5++PCsCof5caeGxUAObxz7E34Sune3qzKGzwWJi4KVYH4OGa6Fq+PPLTWWtj8wIZD8Shjb5Ilr+ZxglgwTWhMQWEnErPfxOzlX2FtJrREi+xzm1ClUC3zsRukJRzFnSgWOQjCtDaY+bMUO+/Kgbtw8lAfTt0je0esFHNrwqF5kdCZC3iGnyN9wN9hmeuvoOqXkdUbzMMbSwn/i0Rg8bmztm4EC88LyOL20Tc7aygqQM6HFaMzud7yYhuXme0UmfntywFOGPkMknMMINZNK/YaInlghyeAs//WEY2emc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnB5ZTR5VWFmUnBkOFRHZkJZYmJ4MTRSM3dKc0oxMkdxM1hQd2daem8wVUFD?=
 =?utf-8?B?blBDclR4ZHp4MGRpc2c5V1RVMHlUSTlDVGpYS0Z5bHVSRGw1Ui9SUDEzR1Mx?=
 =?utf-8?B?TGRLd0d3bEhIQnFYWXlucnJJVitGZUYzV0ZsZGFtbDI5KzZBMmluS3BNOVpI?=
 =?utf-8?B?Z1E5cmhKY0Z6dzZOdUlVQi9mb214ekpwUjU3SmVCNXpFalpNQ0JCejlpemZz?=
 =?utf-8?B?cXVMdXhJWUxIcTRNai9ieUhzU2dsZzVEVnZYUFRSNWVjOVdtMlFtc2tkSE9Q?=
 =?utf-8?B?RW5hMkhENE1HdnJrV1BnRU5RQW1qR0NabjRMd3NYOUN5dGV0TG8zcC96Rmti?=
 =?utf-8?B?Z1JjOG1rdnQwMERHejZlRlIxeFN1NU5ybjVuU2x4OXcwV2xGUVd4TzhpU1V6?=
 =?utf-8?B?L2NPTnlNNnF0Q2xtT1F2T2diQU5UclJYdVJSamxNNUpTbHRpUUVoT0hZc2Vh?=
 =?utf-8?B?OWpzcFBLUXd5alk5TWxRVisyZDNZQkh1cElrRWUzUnlLWUlGd0pJeWoyY0dV?=
 =?utf-8?B?dVFKdDlsajQyREc1Q0FhNXA1eDlVREd4dzF3MXQ0VHNXV2t3YjZpaTcyQzV2?=
 =?utf-8?B?RW5WWjJ0cklSSHgwTlZnYWZ5YXNydnJKUUFlWEJUQVNyYXJZaUN4cmt2blN5?=
 =?utf-8?B?dngzY1VwTEx5bXNkMWNGTjA4dEcyRTlVaXJETUI2T0FRUDR1dEF5TjdwbldK?=
 =?utf-8?B?QjRVQ3o0V1Vwd3JkM254VHV1QXhQNWtqYVFkK0c5NDBrTHZZc2d5WW00bGtP?=
 =?utf-8?B?Y09wT2YraXgzWndOazlSNGsydXVoWnBHNHFwL1RrMWVhNXFndGZXam40THB3?=
 =?utf-8?B?RGJVMGN6SFdhR3dlRElEb1EwNzh5cXN2R3NyaWpKbmVTNmlpQXlrV2xNRE1S?=
 =?utf-8?B?Rk5uNkdxSDc1dmRQRVVlcDRYNzlDdDV6Z3hlaU5Vd0UyMXFUTzEyTVkwYW9w?=
 =?utf-8?B?MG54azdsMjAyRWlHMnRMbE5PVnIxVFl1SEw3NVUzdTRpOXVpTnFXakNjd01P?=
 =?utf-8?B?QU01STlMVVg5dTVldlo1c1lkazd1TDRnbEdDbjJHY0YxazIxUG53cEdCZmps?=
 =?utf-8?B?SGJPQU9zT3N0RUtFR0hWSW9ZR3ZUbkhEOTErN1JWK0E2SWdxZVk1S0w0L0Z0?=
 =?utf-8?B?dVh6Zjd0SkNwekNKRjZrSDRTbWYxc1VNZ0dKQWhKM2Y1ZW50bmRQZFFELzBv?=
 =?utf-8?B?Qi96L3lBVmZYL0d5KzNxWkJjaThvUlNSdXJSbUprSWJVdVlvUm9WSmxOZWlT?=
 =?utf-8?B?SzluRFh6OXMyZ3lBRFl2YmlyMGlWWE9vNFJUTmhqYzViZlNCdUhtRW8zd1pL?=
 =?utf-8?B?eDg3RVJSQWRzblNDNHZHSHpvSXpJRWRRS2xvWTcxaUwrYlZ1ZTBmTjQ4d0lw?=
 =?utf-8?B?YTNyWTZKZTlZbkM2RHdvS1M2Qzc2U1EvdHcxVlRweGJYaEQ5ajVGd1B2bW01?=
 =?utf-8?B?YWlhaW11RURYTFBGTDlUOHRBdG56MncwVlA0VWNlbWZucjdhZlpWVGlvRnV5?=
 =?utf-8?B?STVBQWVWZDNzRndYKzBuQW1RYlU3akUzNUlWdk44ZEN3cnBoOFlHTWdPOTV5?=
 =?utf-8?B?a2ZjZnhpU2ZpWXRPNHFrSkNLdi9pT0l5REVOU1k3dk11VXkvcnRiNHVZNGh1?=
 =?utf-8?B?dDJwZWVRVnB2b1dHZlAwb29oWUlTUzhhcGIwTkRjNzJZTVlCV1NMRFZNajJy?=
 =?utf-8?B?c3k3bldvS3JvOStjTzgxT0JHSllpdk00V0hpM0tWUXFaYjRnemZlMXlxa0FU?=
 =?utf-8?B?N3F6UDZ5MWhjZmcwSGgzQ0Npenp0eUVjZGcvL0ovaVVNb2NpTzlwMlNHZ203?=
 =?utf-8?B?ZFVCSmhlVGtVdmJrbTg4S2Nmb0pIV0hvaGo4MUx5SGtCa2FWMExpUzJ1RytS?=
 =?utf-8?B?OHNvTTlSR0pCTHlydWRncS9idGJBTDJaZjJYaTdSelYwdGRSbDRldzBwdWEv?=
 =?utf-8?B?VzNRYnUyMFNSRE1CNXNOSHc4ZzJvQ3RyY2U1TmVwZzhzS3d5bXRxSjk1QmJq?=
 =?utf-8?B?V3kyOUtBdnhsakRrNjFLZ3FWR0U1d1IwV3FrZ3MvNlRzUWpxamNseGlqTkJ5?=
 =?utf-8?B?MmV6RS92dk1NRnJIZGpyc0QxUFVZaTJVMktiVGc2a2FuRlNGMHkwSmxPdFJW?=
 =?utf-8?B?SDNTMllwcllZUHd0TG4rQ09JQ0pJdy8yQnA3SnZkQ3dBUnNsSUJLdE5ZUVB2?=
 =?utf-8?B?V1VOT3U4NFB6aWpjVXNYRHlSRHlZb1pMcktNYzBHano1V2ZuT2pISkUza2dH?=
 =?utf-8?B?aWZvbUxycysrdGxDMndkN2NtZ0xKa3FQRzNnU3l1eUxqQ2ZQMUVkY0ZTdWlR?=
 =?utf-8?B?OTNJL2lBSlNuWGhPZ1JmenZQcFgrdHRJMit3UmdHM2ZYYVp3bjBoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e3422e-0f25-475a-573e-08de9662263e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:02:22.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGBd0ITr2nNWnYrVysEMM3ooNNNOoapBO7TA9bSJHpunTfFMagZSp0KvH3gbziidcn+4z24jqWUJrr7UNGlzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19183-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0C3FF3CE69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> mlx5_eswitch_register_vport_reps() merely sets the callbacks. The actual
> representor load/unload requires devlink locking and shouldn’t run from
> the registration context. Queue a work that acquires the devlink lock,
> loads all relevant reps. This lets load happen where the needed locks
> can be taken.
> 

Sashiko writes:

> (Note: Due to system recitation restrictions, this report does not quote the
> original patch code directly. Instead, it provides a free-form summary of
> the questions and observations regarding the changes.)
> commit 8bc15ac3cf1f185bce88ba5499055d1546dae606
> Author: Mark Bloch <mbloch@nvidia.com>
> net/mlx5: E-switch, load reps via work queue after registration
> This commit shifts the representor load operation to an asynchronous
> workqueue so that the necessary devlink locks can be properly acquired,
> avoiding locking issues in the registration context.
> The commit message notes that actual representor load and unload require
> devlink locking and shouldn't run from the registration context. The patch
> successfully defers the load operation, but it appears the unload path
> in mlx5_eswitch_unregister_vport_reps() was not updated. Will
> mlx5_eswitch_unregister_vport_reps_blocked() and __unload_reps_all_vport()
> still be called synchronously without the devlink lock, leaving the
> teardown path unprotected?

This is not worse than the current behavior. The block/unblock mechanism
ensures correctness even without holding the devlink lock, although this
is not ideal.

Fixing the unload path to follow the same model is planned as a follow-up
series

> When mlx5_eswitch_register_vport_reps() queues the asynchronous work item,
> there doesn't seem to be a corresponding cancellation or flush in
> mlx5_eswitch_unregister_vport_reps(). If the registering module
> unregisters the representors and unloads before the work executes, could
> the delayed mlx5_eswitch_reload_reps() run and dereference stale callbacks,
> causing a use-after-free?

Each representor maintains state per rep type, and together with the
E-Switch generation counter we avoid executing work on stale instances.
If the E-Switch generation changes, the queued work will not proceed
with loading representors for the old state.

> The call to mlx5_esw_add_work() to enqueue the representor load operation
> might fail and return an error code like -ENOMEM. Since the return value
> isn't checked in mlx5_eswitch_register_vport_reps(), will a failure
> leave the representors in the REP_REGISTERED state but completely unloaded,
> without notifying the caller?

This change addresses the case where the eswitch is already in
switchdev mode and the IB module is loaded afterwards. Prior to this
patch, no representors would be created in that scenario.

After this change, representors are created when possible, improving the
overall user experience. If workqueue allocation fails (e.g. -ENOMEM),
there is little meaningful recovery we can provide in this context.

> In the new mlx5_eswitch_reload_reps_blocked() function, if loading the
> uplink representor fails, the function returns early. Similarly, any

The uplink representor is a prerequisite for all other representors.
If it fails to load, the rest cannot be meaningfully initialized, so it
is treated as a critical failure.

> failures when loading individual VF representors in the loop are not
> checked. Since this now runs asynchronously, are these errors permanently
> lost, potentially leaving the subsystem in a partially initialized state
> with no fallback?

Failures when loading individual vf representors are intentionally not
treated as fatal. The operation is best-effort, and partial
initialization is acceptable in this context.

Mark

> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 4b626ffcfa8e..279490c0074c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -4535,6 +4535,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
>  	}
>  }
>  
> +static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
> +{
> +	struct mlx5_vport *vport;
> +	unsigned long i;
> +
> +	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
> +		return;
> +
> +	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
> +		return;
> +
> +	mlx5_esw_for_each_vport(esw, i, vport) {
> +		if (!vport)
> +			continue;
> +		if (!vport->enabled)
> +			continue;
> +		if (vport->vport == MLX5_VPORT_UPLINK)
> +			continue;
> +		if (!mlx5_eswitch_vport_has_rep(esw, vport->vport))
> +			continue;
> +
> +		mlx5_esw_offloads_rep_load(esw, vport->vport);
> +	}
> +}
> +
> +static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
> +{
> +	mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_reload_reps_blocked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +}
> +
>  void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
>  				      const struct mlx5_eswitch_rep_ops *ops,
>  				      u8 rep_type)
> @@ -4542,6 +4574,8 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
>  	mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
>  	mlx5_esw_reps_unblock(esw);
> +
> +	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);
>  }
>  EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
>  


