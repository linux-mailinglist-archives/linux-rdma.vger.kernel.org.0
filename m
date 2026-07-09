Return-Path: <linux-rdma+bounces-22922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UD4hKww5T2qbcQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 08:00:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18EA72CF3E
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 08:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Q3dUUXuS;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22922-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22922-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BC133011398
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 06:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878303ADBAF;
	Thu,  9 Jul 2026 06:00:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7C27B357;
	Thu,  9 Jul 2026 06:00:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576834; cv=fail; b=cbSo02UQjpgaKr1oIRqoO7bqMqF5YA6l3N6tBgmRA8oG/yPB8BNdXb2pxoPgpUxNyVWVWtCaZ2+8a/vTDUc/GvEDRKJGht4mUfCLMd0Q42qMxz9KQw6DxOvM2muRrVBVQPxCM3OYhC6Muz1Rvo+KHkdG6jg+RPxBRWtJXJu5B3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576834; c=relaxed/simple;
	bh=RXFSrSLtXTQw/12tjN8WFmhiqngkBXHXV3yG+LDkteo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AE9mP3ajFDuAhsmrSuNU3dkB3PeENWBIhoA/SJnmkhCDp8eaCaf3mFiQ2jlXW/xydZz2uoO1pAOnBjXcKZ78VLrKhY8k/xC2bEWrgroOcfuSKAAw2HiHB6vq9bgNJScpfKUIzm2Hq92kqm2h2vnHXBCjjHAUGGfeFA1Pg5yMQ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3dUUXuS; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZAFu3fgBYTgtvMk9zs7cIrhSM1CbuRl692xbKKNTgGbWMLZpshzNXHWeovBYZW5p0X+5fWTcTce9GRpzzgS8RUnV9Q3HT5MTvW051RS90Wj45kwi1jrDRAAAagjtGA3s4YeszkOkBbldCAyVXN1GshQHRZ8Hae5NxZGD/UoxoCiGjOBAjYDKTJcNVlcARt7Y27Dy3y4lfMUA74JNB8HaoMBMVyfatJjnx4UOSlxJOFPqtmY8khFe+XduNBBpae1GOWW7qvKbKBgCw4Kc6AOP21nm3nf84+m+oTNKkQTzDPnnHdKXNaMe73o55cGWztaugJiLMGNov1/64MJ00Ddsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5acZOqQzCFp12+SLQHfG95WXA0ojtztcFMzZ6mkpQXA=;
 b=R0JLDPfy+R+wvdk/0T87NNdVfl1QWclODvkKHXCFNb1yxftDAP3/xSmBx4/sSWUe84A1w+xl2sgub5JePKx9kQ8eCVKPuY1vG7Dr5ElB5w1YSeIZ+oC4adaFk92GQ8znxk2XxRUXeZixFjDTgj4Q9qHQtJXJ9L1f8BZRoDt5BnFJLACFFgBs4YEUrdh4C/3LWgo48v1dc+nd9Y1dzhbz5xrk1WVC6VGojwV2O+fbW5z0XlnI1uKygKy0HcK3A0jS3uGaSu3lkgzIKpryhoT6eH/zsQNUqcKhvJKJwj8Go5HAcQJcXJKVz/pYyV/elXRTA4bfo68eMdqWOp5yWYW3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5acZOqQzCFp12+SLQHfG95WXA0ojtztcFMzZ6mkpQXA=;
 b=Q3dUUXuSylBfeV5EI1W7FfDIFGil67PBXkvr2KmSC5lVQdK1mCzs8e/V/rVzNddhGaKmSLli4YVuO3Lxu60bsk+A1GQ9e5XGzofrAkSe83gYBwxWlyUMsJFQMPgMD1Nbz9R+oA7PTzSDpiCrx4CZmPqaa+f/Qb/Kgg0X3N+xvS1b0tpyjXEL4zWEXfBVF9WtIeu5Ych96IdHvSMaxRmfNeT+BpQaTMoXWj10/OAy+CIZ7dpOj1SqhbZO9KUCJxM0qC1XPMt7cg8LtiTfUmGZp2NiSOInqpFpNLmdTNLnWLo/h/8qJTJUYz8Cpekt8DLmn+pTiXzCGPEaCwQHxcqBAQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 06:00:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:00:27 +0000
Message-ID: <7309e57a-89bc-4e4a-97e9-d843b02efa42@nvidia.com>
Date: Thu, 9 Jul 2026 09:00:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 6/6] net/mlx5: Apply devlink eswitch mode boot
 default on probe
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-7-mbloch@nvidia.com> <ak4LVcyKofmtrWcU@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ak4LVcyKofmtrWcU@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6810f302-ba54-4e86-ce86-08dedd7f5f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dr8krUQ9SnHrsf5hJflKLotq0guo+xWQppbPqkGhdOAd2mdAs2vadEL1pg5VJvj+jsyNBSb1EbHAN8abLZlAtDriTLzfnksT91dNunEjm+knfN1Dl8AY7aMzRN1XxRZRXX1/DmlBJFuixdr7fs4TOyekw3B6NuRkLtn+b2xTs68IES9+5i/e1IA5mvbQ/q/OxV2YQgnm8ArGI0vTXFiO/0u8C5z/nyBfb3BcXAc4tmYxm2RLvXDbNPpEWdYCQ08vw2mNUwSLh/au8bIlS9W2ga5frGgVIjSnZqzZwMh0A9ppAfCqruWDPVuNZ8l1o7cB8aPZRs80zwLblce2RuuMrdEumba/RlPHLeQmPxL23S6tSL0OkeCFSOzjLDldbRU4RyvbQBB2aJm2erwwZxa/2tMhiAwemK+SR15r1so9BrLWMyccHHRBMc66E0qQEDm6koEJtZYiZeOGMVWEMM22U/QWsq0e3zkCcusCDESppJ7I10Cyb0X3euTDxyFhLspZNMhQpbVfTcgd//QHQ04uU3a5v72tkV3mTf9AMWvsU5jaiu6QGHyK1lIYAqRn8dli/hkHkow+c/ahHK6c96FX7AoL5MklpMALX3E5zvTcbORQ5gElXmWzmyTcch4DFdZoMTtXGAXpyaH6vcUDdNTgrQ7BRrp6WOB09cPaWpEMP7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09KaTVFWWNGbTNDYmFqVldrNlYxMEN0UWhYOWt3STNoM04zRG1uY3FtTGVD?=
 =?utf-8?B?UUIybmNzZExZMXpwWGk1V0U1MjkxaHljZ3VGMVFLVkovbHpQRUp1MDFVelVH?=
 =?utf-8?B?OHIxdDlpajhweCtwSUlKa3ZQMy9xbEFXN2JqQnhublo5NzRxNmVLTGgxT0Jy?=
 =?utf-8?B?aENnVTZneXVreW9OVzZiTDQ5dEhJUXVtNjRmYWlhVXN4SnE5VDBuVzk5OW1N?=
 =?utf-8?B?b2Q2WWdsUmpBNE4yMFRoMEFFTXdtVmEza0hmQ1lTdlZiWGdqaENQbDd4K1Zj?=
 =?utf-8?B?TWM2eG5YOUVLNVg5UWV4ZFNRQWNyNWRWRCtFbzNWbjNOeVQ3Ym1VaHZZRjRi?=
 =?utf-8?B?c3JsdlRLS2lLMHhHWEVQREdTYjU4a0VoTlJGcVMxeTNLM1VHSEZmRGR5U2Z1?=
 =?utf-8?B?TUlvZHZ2K3NEalRydWVMdVZhNlg1NEFrR0YwZDN2ZEswWUxGQTRnZGRHSzdD?=
 =?utf-8?B?aEVWSnA3OEdxNFFjOUl0SkRWWm5GQktzR0ZvZXhXdjVJejF0U3hrbVFUTWdu?=
 =?utf-8?B?ek4wVDhOSHNUQmF0clZTQ3BEcHRpcW5lMjBjSXpCM2NXR2h1bDVPZ3VUOS9F?=
 =?utf-8?B?Vm5BM3JLYnVkL2NDU29ldU50eXpXVy8wWlY1TDI5VmFnam44QVJMNHFnVld4?=
 =?utf-8?B?NjB0bTM2SC80a2czQ0RyTW40YnJkaklSd2NIdVFIV0JWZ2tIQTJUclhiMzc5?=
 =?utf-8?B?MWRBbXJXQ0ZNSk1McXRieGdaZE5HSFdGV1hRWkx4eXBITkR3RjRzYUJvbGo4?=
 =?utf-8?B?S3hjUkU3aHRtTW0xUUJ2YjFBdWZSUWZiOFBOUS9lZGZCV21MWlAwVkErdXNo?=
 =?utf-8?B?c1I0dzBUemhzeXZVR0MvMDJuaDhYaElQcU9Bb2VNcTZacXdicVRYRjBpQXp0?=
 =?utf-8?B?OWVQQk9QcDNGcTBXdjBjbVg3WGVmbFRiWVJWUXJwb3Z3SmxPUi9YUWxIMDhh?=
 =?utf-8?B?eWpQOGdxcGRoOUdrOGF0Y1dObmhpSTJ4QXg2YytwL1RMNTlsRFNremVDV3VE?=
 =?utf-8?B?ZUJlQW1peDFVN3NDUW1TK1JZQnljSlFzcUNDNFlyVVFYcUp2clRMUXg4VHB0?=
 =?utf-8?B?VGl5RStlN2ZFaWVtSTlFYnhSQ3FoUGpnRGc5TDRlOHVHaGZEb2lhckhvTkN4?=
 =?utf-8?B?WXk5KzljaG9OdGFPMm0xODBaMElZU3o5OFVwbVFTK1p4Y3U2dUlQSk9wQ2RC?=
 =?utf-8?B?U2FGY1ZQaGtKRGtOUlNORlFxQ3pVbm5EMUNZMmZwQ05NYXo5czJqajlvaWVj?=
 =?utf-8?B?RXB6aHlTL0hvTTNHTzVwQjFuQkFLT3pQS09PY1QzWlpIVTNpM0lzKzNMUTJW?=
 =?utf-8?B?Q3lFTTdERXd4RjY3bDlGRW9uRldCYVdGM00yV0JhRWNvcjhraG9LQkdFa1pB?=
 =?utf-8?B?d2dnNXEzeU9iUEZEamFQc205dDJGZXhSY0FnMWFzT2NJTTkyS3M3VXNsdmU0?=
 =?utf-8?B?Y3BhelhZUVdacEFiM3JwRERNNE9abVlJWmthd0ZwQnJFWHN1ZmZ6S0RobEh5?=
 =?utf-8?B?ZDdzUURJYmxEVFBpZ0pLbUtFQ3h1Mks3eUpUWXBJZXFXSXVha1RLUFd0bE96?=
 =?utf-8?B?Qm9EVU5iaXJacnFSdWhQUDR2STVyL0FZZEh0Ylg4UjJrTFovSjU5Q3ZSb1A2?=
 =?utf-8?B?UFF2ZWZmMDFWc3lPcTQ3REtSY0NVRncvZE1WYjdtUXp5R1NidHd2Q2hTc0FY?=
 =?utf-8?B?bE1sRnBTNllrVjM4VmZ4MUVMb01qdHRLY3FNQzdVN3hZTHJlcUFqT0huOXlH?=
 =?utf-8?B?NC91QjE2R1pUZ0VmZjdpYjh3R2tQdXIwa2lEMDl1VFkyYWQvR0RoUjVkK2Z6?=
 =?utf-8?B?dElWc1p2K2RkQ1RtOXN1MWhOZEc3WHROZ0xIT1E3TTE4L2RHMC9SVDQ4WEdQ?=
 =?utf-8?B?VTdxa253NUxXVC8zOTk2aHpSNzg0a2RmbkZZQVZFZzBrVnQxNGJnYnI3RmFa?=
 =?utf-8?B?WVhyVkJJNDZIdDltSTR3WjFzRWdqUTNseUw2bWlVejBHZU5ZR2lZSjJlU1V3?=
 =?utf-8?B?V054eEovM0k3ckxVZ3ZhbWo0K0szOTlrOUF0aCtWQTM3OWE5YytDc2ZjbUp2?=
 =?utf-8?B?ZXhHYWpEaTB3U1dxU3RHUC94YWRBRm0vQUhkc1BMUWZzRVdmQTZYU0JwNWRR?=
 =?utf-8?B?bEJVQVJYMzA4Qy8ra2l0UjlEdGJJcHNaR0tySXNZM1RtbnlGQTlwYTI4QUtC?=
 =?utf-8?B?alZMZjE4eVcyWEpBUVIxZ3FBNXF4SnVwSVhRc2dNZ09vakhIZlg1MERSOHFs?=
 =?utf-8?B?YTFVbG9jSXd4UlV0eFBmTGdVWnRWRHFGY29HaG1nalR4bW1vM3dRU1E1OXdI?=
 =?utf-8?Q?d5pfwEGgDxt34dVell?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810f302-ba54-4e86-ce86-08dedd7f5f9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:00:27.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2ApsAdADZFBbeaZP2kMoY2trDMWnUgX7HuLPParFAmn450IRqnDwDXalmlXjQ8jkRZcg0Y4z/ocjWnpnR9Mvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22922-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D18EA72CF3E



On 08/07/2026 11:34, Jiri Pirko wrote:
> Tue, Jul 07, 2026 at 07:45:27PM +0200, mbloch@nvidia.com wrote:
>> Apply devlink_eswitch_mode= boot defaults for mlx5 after the initial
>> probe finishes device initialization while holding the devlink instance
>> lock.
>>
>> At this point the devlink instance is registered and mlx5 can perform an
>> eswitch mode change. Calling devl_apply_default_esw_mode() also clears
>> any pending default apply work queued by devl_register(), so the queued
>> work will not apply the same default again.
>>
>> Keep this call in mlx5_init_one() rather than the lower-level
>> devl-locked init helper. That helper is also used by devlink reload, and
>> devlink core already applies the boot default after a successful
>> DRIVER_REINIT reload.
>>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> index 643b4aac2033..0712efea74cc 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> @@ -1392,6 +1392,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>> }
>>
>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>> +{
>> +	struct devlink *devlink = priv_to_devlink(dev);
>> +
>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>> +		return;
>> +
>> +	devl_assert_locked(devlink);
>> +	devl_apply_default_esw_mode(devlink);
>> +}
>> +
>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>> {
>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>> @@ -1471,6 +1482,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>> 	err = mlx5_init_one_devl_locked(dev);
>> 	if (err)
>> 		devl_unregister(devlink);
>> +	else
>> +		mlx5_devl_apply_default_esw_mode(dev);
> 
> I don't understand why this patch is needed at all. Just leave the job
> to the devlink core, no? That was the point to not pollute drivers with
> code like this. Is it some kind of leftover?

It was discussed with Jakub here:
https://lore.kernel.org/all/20260611085440.4fe36bf2@kernel.org/

The main reason is timing. If the default is applied only by devlink
core, it has to wait until the driver drops the devlink lock.
For mlx5, that usually happens very late in the init sequence. I
wanted drivers to be able to apply the default as soon as the driver
is ready for it, because on NICs with a DPU the host PF can remain
stuck until the ECPF moves to switchdev.

This API is also useful beyond the initial devlink registration path.
Follow-up patches will use it for driver controlled paths that are
not covered by the devlink core, such as recovery and FW reset.

There is also a race window where userspace may take the devlink lock
before the core gets a chance to apply the default. Letting the driver
explicitly apply the default at the right point avoids that scenario.

Thinking about this again, maybe the simpler approach is to apply the
default from devl_unlock(). That would avoid the whole workqueue
infra.

I avoided doing that earlier because applying a default mode as a
side effect of devl_unlock() feels a bit odd. But compared to adding
dedicated workqueue handling maybe it is the lesser evil here.

What do you think?

About the extra API, I still think it's useful and would like to keep
it if possible.

Mark


> 
> 
> 
>> unlock:
>> 	devl_unlock(devlink);
>> 	return err;
>> -- 
>> 2.43.0
>>


