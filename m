Return-Path: <linux-rdma+bounces-20374-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KkSKSmYAWqXfAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20374-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:49:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C450A53F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD16301EB60
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D03BA236;
	Mon, 11 May 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3ux8YjY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD22E0925;
	Mon, 11 May 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489352; cv=fail; b=QD+xJUeNiDzhUL4ooMKyjplRj5PuOf3dhNcdEcUJdV96Ky7lDcovBcDsyyIP0ZvSaQ1A3AwtsbBri75hdmFTgoDsLaXay9C0uGZhefxVcklh0pwnIl8nbPerzTxhXs+ihWuAR4LE/6Ww+5+nFvjod5QdqGXjhMecIoKnLoWk0lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489352; c=relaxed/simple;
	bh=gS7ftNzuV4GRXA0aGkeUO7aRVqG6Mv0jMDCswjzMhxI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlQ/nXlFShYo4F3m4ioHCgE1bhee2ampu0TpcfZCP7odNFCp2kX/r80yCos81WVNYcWkYJ7dzqBYd2c7Ijex3iQCVQrFLsfMv2BGRZuLr/z7O7sjOCqnCYCxkyeDrHt6uUSu06cedLCqKGxEjFr4skHKt/yi+53xIkd7GTEyaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3ux8YjY; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5vB87Y12CwzNnOTYYdtI14RWAiR9PzumkdXuU2A76VsPyIt1+cFf3u6c7xa4FXaQZ/zTt/qqP79o7c0kNO6bsl0o2kdv6jnqu6wljHf7pKm26wFSon8yF+vaF9Wv5zkmTfXGG7loCebN295/oWttwOHS+0Ia80v3bvfV8Gh9j7rSIYF3VgOQ9CFE3LpYUagISP0DWAJFWYMmtkZOITfpai+2etD1xg3cWa8Rs3JuKc6Dg84ArwAmrNBR5qWPffrbR3AOTUzcKOZvkP3GjydxUDpzr2daBsPVHnZF8mSc72064XwROzR0kvCjFXuJq/Tlfh87KDsv+27pwgDCRzqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIj/Ktz9Lc3oODZJt3aK5KoF3Pu2l0govBgR0/oTs0k=;
 b=sVxv70yQi4tcV+S5EaTYr3AA6uvGAoyZHF2PpYo45QCpUCSCF+fnOaRcZE4LE7kc+9mSL0r5k6ZPpOlpv1T8IOtv0XBN1TLrAws+7v5t2lGS6/bfHGV4gj2tfjuav6Ye4RrPSily4ZmrfmolTtPKuJX+H5CO+lX2JTSKmQWTV0Gv7zF6BAE1pbrXFGxJt1/HlVzQNkwY0yIy+JEgxIBPHxk/4stNXtvrSnHrfwueHFmPrSBBpT7skaZZBDLD4+q5jx7HdQD70KTA8TUguSPCpTBFgUtKip6QIiSYDYkIZ6bs3Z5WVDHQ7RYsPTfO1j7owXYU1HyxiuhaFClGrIOaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIj/Ktz9Lc3oODZJt3aK5KoF3Pu2l0govBgR0/oTs0k=;
 b=B3ux8YjYMfawxni0isPD8zG+kMPVXaE0VXVHrLOkjmuvmrbOeqYmWlr7S6yuTOtnzM4ClN/0SCma3fCHhSIHWDudGOyoH4DPoIAmt1wrcHDWl3gwryNeCA4YlDQR7ZJkd10lB+2wqTF3prW3GBh6rUSmyv6ze/1U0D/Uo32E7fpnQYT/xzcJpqDxEhAy3fISZng90NWFSCWPYL48A1eyHlvQzWpqX4cLg3S9/WNDWUsU1NO4HDJ4eojfaLpw9lUHp11xHWPE5kZLVH9Uy8Mv4M6prwEOwZHrQiY1tyNLs/X2M/H59HAUI9Opf/QtbUHmUjWb33Th3djJRsmDOIcN2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 08:49:05 +0000
Received: from PH7PR12MB5877.namprd12.prod.outlook.com
 ([fe80::e6f1:aca:28e7:eed3]) by PH7PR12MB5877.namprd12.prod.outlook.com
 ([fe80::e6f1:aca:28e7:eed3%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:49:05 +0000
Message-ID: <0a39da37-6e4d-434f-9416-f102d1d6a159@nvidia.com>
Date: Mon, 11 May 2026 11:48:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net/mlx5: HWS, Check if device is down while
 polling for completion
To: Simon Horman <horms@kernel.org>, tariqt@nvidia.com
Cc: cpaasch@openai.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com, vdogaru@nvidia.com,
 kees@kernel.org, valex@nvidia.com, erezsh@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com
References: <20260507173443.320465-2-tariqt@nvidia.com>
 <20260510190351.1422486-1-horms@kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20260510190351.1422486-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To BL1PR12MB5873.namprd12.prod.outlook.com
 (2603:10b6:208:395::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5877:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: fce604c1-cbf5-466a-58cb-08deaf3a27ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fa08S93k8Us6WYaXAnbLkK/lIr8Vz82P0ehTKMqIOVhGR436m6snqI3q6xJH0JdmXCqp6pRnMpZanGKuLVf8G/vI/gfuU1fIQNpVYnCNrrdR/kb6BX5pzh/7vgANchlrtZvc7LK5FkXwE6a0uIhLvZ8sZcMbzhMeoDpk0tepQYyYuTiOPfFTFy5Cx05ysFG+d0zNQlhXvX4WcB8QTHKgIQwawCRcpbdjchDgmONgCpTRqr7MNj9lBZ7OSLQdZ5Q1jIUsYxMFgCrsGkcQ246u2erpUFCKW6Evt1JJdyDPqwAH0sdZLWgSklh/TJywPJy1GRxCUBLyMP9tya9jzmxJJIw/fedBU+xWEuLyAzdZhwCpc1RfbEOAptKHxzHTYPui+iWzu2GPr461ymyS8bidTuP/JPe9+hFMx6jl3NI1q7K3Y8nfuCgC1XJsW+p1s5mCSViBGFJ+a4PVNt1I0WcEYiKI9TpgVB9axiss4DKBZca/aOup4XXIUBoQkEIaci1fptzwSMKpJJC2qfpHWblgNkiaPsJMm+4FCondBZauH95kAo50jyBQYVDbCS914A7aJeSbAmoGrSN2urNBD9T3S1c29LWL5WNKZDwI3r9OJcRbzxUJ3kZ8JSbu3FzJOXbeOObd3AMvHn0RPJBYwHZ4RYWeXeYTKwKh46B/aFNQuUFdyYq8JFKnD+LhV9gCbWKl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNOR25weDlaTHR4dENiM0orUUxFL2ROWGEvTXp5YWRsR3RrWXNPU0xoeWRy?=
 =?utf-8?B?YkJhdHU5cmZPaEJKVmFiR2F1NTN1ZUlUV0s1YTBOZ0hEcHJZSXZ6RGVMeWRt?=
 =?utf-8?B?M3laQzZDSlRsYW1ldmVKajd2ZkFrdWp1Qk1GWHBmM0ltWWlCQmxKQ3VHVVhx?=
 =?utf-8?B?Zjl4TWVRQSthaXNPVkczUnFpK3o1d3l1aDl2WDBRaGJjUmx5ZmxJYWI1ZUE2?=
 =?utf-8?B?R0lzZ3JZNlhzd3BoMUo0S2xLYitIYzFESFVQRmljMkNmbzEzcmNqR1hEakNh?=
 =?utf-8?B?Mlh1dDh4RnZlYkN6a2VaVDlRN0hOdHZiOU40RHNvSVhZUXhWQTlFZUZHRFJL?=
 =?utf-8?B?S25UUnZyUUVsZVF3RThkazI3QmMvQ1pLc05VMkdiQ2dGek8wKzZSRkdIQXAv?=
 =?utf-8?B?NG1BaWt1emdhdzZXR014d0RNSTZ5SkNpYkQycVA0NG55QWtyUWZSUmJjekxp?=
 =?utf-8?B?WnE2YkNyaUR0U0RBaHcwMXZTWnRpSlkySGlFSlk4aktoOTB2YUJObmVOZFBu?=
 =?utf-8?B?UEVmOWpyZHg3anpPTk5KcmQ3M1FZNk5MWVNydXd6VzdsSEVHL0R2UUd1d042?=
 =?utf-8?B?bG11bUdIY25wTFFueHAxLzlsMVpsam5JeVIwcGZxRWx0RUhUVGVJOVdZQlJU?=
 =?utf-8?B?QWdiUU9iUUgvSHdSTW9rZ2hxYUtpZXJyc0dXNXcxZEd0VmdoSzNsY2xWOCs1?=
 =?utf-8?B?RlF0NU5qd0RQZ3hxamM2Qys0RldXUTdjY0hoRzdKWVhQb2gzY0xwYnlYcGsv?=
 =?utf-8?B?aE0yRllLR2ZwUnI1NVdwQWozbjA4c0drMGpkYkViODY4UDQ3b01PT3FEOElR?=
 =?utf-8?B?V2JaRWFLU01YYm03ZmtCcDVNRXB5V1k2OTc5cFFZSkk0OFlYS0ZHSmdwWjVi?=
 =?utf-8?B?VlE4LytrUkttT0VObDFNRHhpdmVnVndSSFdXOEdDRjMzRHlQelhuMjgyRHUz?=
 =?utf-8?B?K204QldsWHZIWEVnSjlmc0VJZXh6Sy9UTFA0emxRVFphdDdRTVVGVlZZeURB?=
 =?utf-8?B?MFFLck5nS0xPZDdoZExBdVhheVBxYy8zYWZHWTNTanpmNzBneGVLazliTzlq?=
 =?utf-8?B?T3BjSXNYMWMvT3o2SEdXVGkyeHYwcEhDL3hRd2N2MFB6NXlZQnovUG9STysr?=
 =?utf-8?B?Nk9Qb2U1RDlDNThiVkduMlR5VVJwYVlOdjJvYjZwdW1MT3dtWmZEeUNCYlp1?=
 =?utf-8?B?aXZRNzVXRVlPQzY3eVRnTnhIYndrVzZ2a0pJdnM1M0V0UnN1UFA0QVNpdXNU?=
 =?utf-8?B?OUkxVzJqVnlRQVFGNWJoOVhhdnUza1gwbWZwZHdiajJ0RFBrZTZzSEYyaUs4?=
 =?utf-8?B?MXA5a1ZzcDVNWVloYlZHUTBrdWZCcVg3blpGaEFhNVMzalZBN28xaWY4cUJw?=
 =?utf-8?B?ZVpPUkpnZHpKeHM0K1RzcmhWVWFoOEV0dlZRZzZQb01oeHArVlpHWUxuM2RU?=
 =?utf-8?B?bVZPWmxKcGdKVm4wTnBjV2NqYmY1d3kwUEFFMlU0c29EUTlSSHQ1T3puTDdn?=
 =?utf-8?B?ZGFaSVo0MXZ4TUxXSkJENzBDMk42cE94dUE5RG9RMG1DNXZzeHJYenE0MEtS?=
 =?utf-8?B?NHhSVUpVY29mZXhYNGMxNzBBODlxS081NnlYTWdHSUhEb2crN2FlZWFnZWpL?=
 =?utf-8?B?c05XdFJBQXlyVFdiU2pucS9CRDNhMzF0RFFLY2UwYjhzNjlER1FzVVArOVpm?=
 =?utf-8?B?SGFFbnVyV04wTlRQK2VjRDFGUTJ3N0lxQXRJb1pJKzM4NmdYbEdVckkwb0VC?=
 =?utf-8?B?cjBCOVNPYUpac3BLbmMzeFRHZDM0MXZWTVVLVjVhUFpaZitpbEc4NnRLV01I?=
 =?utf-8?B?K1Uvci9Ebm9yRlZ3UjE1RzlpSWFXdXo4ekZ1cC9vQ1R0b3Frd2RjazBpTWR0?=
 =?utf-8?B?RGtUb043aEJkYUkwSEc0YTRwS0ZPTUdEL2FiWUp5WkV5ZkZ4cVZObU9QZ1FE?=
 =?utf-8?B?V3pZV1Nyd00vbWZvZFBHVHVzYmpXTmlobmdzNTg2eno0Q1Y5RkFmdTUydUF0?=
 =?utf-8?B?Ym12Q0tsTzVua2g0RUtpblQ3TXptUEhkUkNQSDhKZVBiMTFQUkhISk52Tk1p?=
 =?utf-8?B?TnBKQ2QzcFJ2VjA1a29VL29XYjJGa29QcjhCbzZXLzdFU1A3ZFhTVWxkd0lR?=
 =?utf-8?B?dFNJSFV0emhGVWRrOHl5REpXZ0lnOVVEa1dJOTE1ZEhTanloWC81N0ZoZno1?=
 =?utf-8?B?YmFEUnJHWkRnbHJHRnk1ZG9GRklXZE1CZDd4RW5kNHBJaDhXZ0VJZTBVcHBR?=
 =?utf-8?B?citpQXk3RmNVdEM2eUhzMThaQ214NGJCdmVlcytuNmMvS0JGWVBCYTQ4RzVI?=
 =?utf-8?Q?gzrmE59AJxz+oiCRom?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce604c1-cbf5-466a-58cb-08deaf3a27ad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:49:05.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/QcYRr0jl0LiaHhNIpgapAQepy1yC7ylxwikjF0VF2F36KKKx6qE4QW2hWX7tm5E5oJI9X0plClYgNwIi4RDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Rspamd-Queue-Id: 5A3C450A53F
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
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-20374-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 10-May-26 22:03, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net/mlx5: HWS, Check if device is down while polling for completion
> 
> This commit adds a check to abort polling for hardware completions if the
> device state indicates an internal error. This returns -ETIMEDOUT early to
> avoid long timeouts when the hardware stops generating completions.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> index 6dcd9c2a78aa8..eae02bc742218 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
>> @@ -422,6 +422,18 @@ int mlx5hws_bwc_queue_poll(struct mlx5hws_context *ctx,
>>   	if (!got_comp && !drain)
>>   		return 0;
>>   
>> +	if (unlikely(ctx->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)) {
>> +		/* If the device is down for any reason (e.g. FLR), the HW will
>> +		 * no longer generate completions.
>> +		 * Note that ETIMEDOUT is returned here because the BWC layer
>> +		 * already has a special handling for timeouts - it breaks the
>> +		 * rehash / resize / shrink loops to avoid chain of timeouts.
>> +		 */
>> +		mlx5_core_warn_once(ctx->mdev,
>> +				    "BWC poll: device is down, polling for completion aborted\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>>   	queue_full = mlx5hws_send_engine_full(&ctx->send_queue[queue_id]);
>>   	while (queue_full || ((got_comp || drain) && *pending_rules)) {
> 
> Could this lead to a CPU stall if the device goes down during the polling loop?

That is correct.
There is the possibility that the device goes down while we're already inside
the polling loop, in which case the looping will continue till it reaches the
timeout.
But what we're trying to optimize is the "normal" flow. We prefer not to
add additional 'if' into the polling loop, which should be as efficient
as possible - it affects rules insertion/deletion rate.
So this patch aims to prevent chain of timeouts when device is in error
state, which is happening during deletion of all the flows, and during
shrinking of the matchers, while it still leaves some probability to see
a single initial timeout.


> The hardware state check is placed outside the while loop. The loop has a
> 60-second timeout (MLX5HWS_BWC_POLLING_TIMEOUT) and lacks cond_resched(),
> meaning it can peg the CPU while spinning.
> 
> If the hardware fails and stops generating completions while we are already
> inside the loop, the driver's health thread on another CPU might detect the
> failure and set ctx->mdev->state to MLX5_DEVICE_STATE_INTERNAL_ERROR.
> 
> Since the check is outside the loop, we would fail to detect the state change
> and continue to spin uselessly for the remainder of the 60 seconds, which
> could trigger a soft lockup panic.
> 
> Should the state check be moved inside the polling loop, perhaps using
> READ_ONCE() on ctx->mdev->state to ensure the compiler does not hoist the
> lockless read?
> 
>>   		ret = mlx5hws_send_queue_poll(ctx, queue_id, comp, burst_th);


