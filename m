Return-Path: <linux-rdma+bounces-22091-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2iqBBAamKWpibQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22091-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:59:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C466C19D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:59:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sfHSuHIo;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22091-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22091-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF920304FA6A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203F34AB19;
	Wed, 10 Jun 2026 17:57:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE8350D7D
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 17:57:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114236; cv=fail; b=JNg3UhD5rEEViZRslNdjLLTlb8AKnDf4fCUc65S0ucbOqi+T//sMiATBbjagdi7Xqoy08DdhIPM2EfpASo9RiOuw05eCgm601z5J0JI4Ijb/a2QSwqAf9FHEvc0oLPNHcs2yshkBXW0HEQ0L5z6Bi4pHMcWd6pJ7su7jO6tdBCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114236; c=relaxed/simple;
	bh=hY/Lh1+AYXH/9nh7nDH7xXbjgTBf2/AzJAYktz/I0Fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IctsgeKK3VSjCl98h7ALY51+DoxfWiHXJoMf+p5vhbQJnKUDQqxbhTmAJTfV7Rp3apTPQQIh8IkdXx/MDUTgWWuZB09AwDNuIsFU4m/9YNIRx5Ft8xLZC7GkXTJPmLpYYm97T1wPaW2YHsgJ+sT7c94zVCHFIxuhCi7idTSHSMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfHSuHIo; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpEGaHERc21WV9UXZWEQ7jGuDJSVEd0GL9TRONJHTvrAQFkaqsici+gzObVrC6+JZhgnFGlMknKgdb72OVrS/NG8rMsmCbjI9sngh4Ekx3L1/yqkWFhX3PNkOhJQ4IjyVNSCpAspscn+BFmMADDoweSqRAMmlx4nm6MHuNkPWln+V4snH1Q/wWv+01Z/EPH+UNck7UPlXFA2ih79hS0OCsx4d9dJsim3/1QFOrrjH5j/2p02WwIIchOoYT54RHWFWRoxA+BrUzmGpUM0m8mpNjiGVBco5DPhS0ZYZ/l1UclTatvjY/g9JJYnfsZu1kLh3OtAmaMXEMNL72IZ8u6gGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viHHN3x2zvV/aVIEGtmOMSAOmw9oEbeDL4rBAf674Js=;
 b=KMsCngpPzSGdWyS1jIR3maSoC+z84tnRCWfGg8FRs26P/msm9G9K9NTo4/Xl771N3GghAHssnrIo4olZLjyUnCK+2l/zpDfDelAX8vZ7WlfUQuKoci/hdSpDkNsUGzIzfcxyHBgV31waiiy58I9DpH1mgV9Z+DA02PStmYz/69PkAI14MNO9YWlmRgDtIC3SzF9WEgbVgxyM8WWjZosOyIlC1y0tqwGlY/qZVo7kS6mBmf7ayOdK/R/qhPBWf/phnY5cF8fsyghxY3bKlQ2Nf2Tjum1xxg/cqcy0a4lWH+PlkDCNkHSFfqDJj8nbIAq+cDf0urnyrrOa9VELfkXtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viHHN3x2zvV/aVIEGtmOMSAOmw9oEbeDL4rBAf674Js=;
 b=sfHSuHIoiSxE6B8l0pAe/z9p1GXqQY05tcPNBDMKfawAknhwHoDu//CJSttBss/sqRamyBSqMFS/qxaYjKU6itgInDq2Kv7U7bBzoBeAtguAHp5VBS8gefPtyRGIkMellZ9gf6Mwpd0Em9FagLlpy+q2QpacNOsWgefPp8rQoVWlfQYnGP+JG+uuqcSPAWj7o+unTOc8tdKvLRPG0OPvI8Szo220Ha4TaOzyYimbwbqbttMugvXPqxpwN3TK1hAUdxikhFjkR2TNDcZU/wqMA1Ubf/FFxf9oeqkDCxQ99E7f4o0TsWfFKLe2ZiB47E3hx9dBbo2avcqdFw8zmu3MGA==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:57:10 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:57:10 +0000
Message-ID: <6c3014db-6fa3-4010-8575-e7554b3822bc@nvidia.com>
Date: Wed, 10 Jun 2026 20:57:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/9] FRMR pools fixes
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
 Edward Srouji <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
 <20260610174510.GR2764304@ziepe.ca>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260610174510.GR2764304@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: e01c95ab-42e6-4f73-3186-08dec719b1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	emKenAS4UcclwM++SloQ7Ao1JP0xGzAE3OVJLnE/OthyOq230Vwz5ETORkzE/k8Xo0cpxRSUOgzBVYr7jH3tBrQN2QzSVPAVARqSkfpK+Tqx8nySVRx920UUvpxJbVLzEyP+u7mAqGVZWH/cxv3KsKtzV9t3L3lhxuBaY5THIxjp5+s6auPkccLtd6OkfsBJ3FqEjaD/PLF3wPENF4XzdHZcw0oWZIVH4xEfuSs+x7TS2++8LtvRbKO+SRdakiIQUb9xNLFjepEd6YJBd8rIuG7v+yYF0guAbL6SYTU19Fri12F5EJD70G84X/jL++PdGCE/q7w87bG6BUHiEQ6zUxDf18Ys6KFaQQJvbeFxmXqFU4Y3TEpMfiO5OKzJwIm6KVCi05EEsTFfaVMnuuNAkGelOH3mrTFNVlOhljEVNTifKghApu+ozaATc7cxRotVHEjZxOKAh7ABn+/GnOaYWCYkg2bhMHX+kazFIlYF0WvqQdXmo8ExPzaRXacN8SJNdXHV6HMajIseU9G3bTGSqXt7dC8a3jRaNWk9+c4YKWaqvg3dj0k5frjhkVHBsrosPJ3UxZIYiFmgYcvYrAxTZtbT0FzgHiHKfoGfzpDWIIgM5tVhNBjfjG+zF0UW1QABw2qLqrTt1cctT1/G+dFqYPvWny8ATT5oNkM20ej1pgoEfzTVLceDAPGKxG1P20a4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpXUE9zZG4xcUV6UmFJNnJidUpoZzB1LzhnWDREV2kyUTliNnl2TXdNZ1V0?=
 =?utf-8?B?RWptZVdNQTJLa1Z4VU5YYlh1d1hQWXVQaXU1M1RNVkppbWM2MElyYnZTZjZs?=
 =?utf-8?B?U2NlUm9uZFpnRytkWEVYdVoxVmhRMUlPQXY5aG9aaW9XRG5jeW9UVzNyT2cy?=
 =?utf-8?B?dkxPS2EvWGY3RURYZis1OUNnWkNVRVZCMTk1K1FOY2FwZFNUR2lpZVkraVhk?=
 =?utf-8?B?RjJCNkwvRERtYndkUWdheDVHRTcvQzdFRmFnOTltRnMrZk15TTVpNUVMNHc5?=
 =?utf-8?B?eXlTMyttMzkvTkovNXBsbVQzVnhucjFIWmgwYndKajNqU3dhNWxVVWd0WGFU?=
 =?utf-8?B?WEQ3YUI2SHdIVUNIYUlnTStYdHlRRGhBWGR3MjhFUFF6MGFJYW5pcStxN1dE?=
 =?utf-8?B?RHkyamNTdnpobXdBVHVsbFV6Y2RBYVpHSFhRNUM2VDhybWRUV3hyTE1rVkNy?=
 =?utf-8?B?YWJETm9ZaFEyR1dtd1JIQU53c2hSbzE5V0JXODJNZUNtMVF6S2g0TWRuNCtq?=
 =?utf-8?B?T21hY1Uxa2FjelRaVExIRmNSbmdzVFM3SzVkQWlVYUFOM2pPay9VQmcxWFZm?=
 =?utf-8?B?T3hLTS9DeUdtSjN5UEJhaGdRaUNpUXMrRmoxY2lBTlRlNDU0YXgwMCt2emtH?=
 =?utf-8?B?dEpaM3Bpamd4V09oSGlDcmZNUE9MVWc0R2FrNndLSGt5LzhMY0crOEtZNXUz?=
 =?utf-8?B?bHFmWUVTYkgzczJoSDBJb1BGbHQ5eXpZM3lUeERrUzNuWHVjbVRua3ZMQVht?=
 =?utf-8?B?QlNZUkRJK2VoclMybXY3NHpaN2F3SC81THdPN2lsbGowZGlIVFZDWEU5NVpy?=
 =?utf-8?B?bXFpb1ZMUmRDVzR2WnNlWkp2MjRaMTRZeCsxYVFoL1RoNlM1WjIyTUozdEVY?=
 =?utf-8?B?VXBHaFFZZnk1WHBiMDUzdEFFUGNnUUZIaitubk54YUNHbXdtUjR2K0xlRk1L?=
 =?utf-8?B?Umt1TzJCWFB0WXpTVFFzdnA2NXpqNWVmMmtUYWh1d3V6d1J4bVdhQTl5d0pD?=
 =?utf-8?B?WE1nOEtJNlRNRGI4M0Ftb3RMcWF0WjUvQ3pmTW5rbTc2UCtrM1VNYzd4Tk9z?=
 =?utf-8?B?SGMyMW1YYVAvQjdRWnpzUy9zaHI5NVU2R1NhVDBQN3htWEZZSTQ3Y3Y4ZC9h?=
 =?utf-8?B?ZmFPVkxCU3BMY2VOazZSUjNNSDdXakUyWFlmVHQ2SGg0eFlxV29lbDIxRzdN?=
 =?utf-8?B?anZhS01Ob0VINjFIWW13VHowVEJBNlFJV3RMNjFNVlBQTisrdVBQUFpnSnJp?=
 =?utf-8?B?YXd3Y0Nybnc4bDdma2NtRDZvZ0tVQUxYMVNGakZhUVJ3WFpCbUJLejVNenN5?=
 =?utf-8?B?QmFYSGFOT2RtM3JyL0pHWUoxTmFpNzNuSnowc1VSMjNoUXE1cXIwMUtFQXB6?=
 =?utf-8?B?TTZpSXRqSXFWQzEwWmxtbVZwQkNNbjZFQjdoN2Q3UnhwN0orSnZqQUtnZERr?=
 =?utf-8?B?Rmlydmx2OGliVXR0L0R1UG54eElKWUpKc242cUdQWVF2Z2wzZncrRHMvLzFw?=
 =?utf-8?B?cUR3czJzeGpoVGttcjVSeUxSTkhCWmpsdzBPOVQ1L2paaWJLVEdVNS9FN1Q2?=
 =?utf-8?B?T1dML3Y1My9CU0daNllRZTROL3BscFY1aXV3QSsydE9ENTJIVDZhakZ1Nzd3?=
 =?utf-8?B?bWIyQm5jczdDVGh6MXQ5YVFIQVMrN0tTaFNPUDV6NWllbkx5REE1SWszOEEz?=
 =?utf-8?B?NUlWdUR2emtLdGVuM1VwR3pSV3FnaHhkd0VMeGFyRVhESzA4QUgvc2NLY2o0?=
 =?utf-8?B?Q1JNaHBLREhmbnpWWkdpeGxkV2xVL2hiTFFGa21rQmltZ0E2aHg0azl0eHQv?=
 =?utf-8?B?RjRiYTVXcnJUYTFGdUJUc1FnZW1CUERvaWZLT2hCUFg0MWNGS1dKY29sQnBK?=
 =?utf-8?B?MXdmd0Mvd2RWbGEwODROcitVNzladTBtOWZnRzExRktxQ0lXYlpEaWtTVk4y?=
 =?utf-8?B?YlAwR05lVUFLVkoveHlvcVdWTy8wSlA5Rm9WTHlOTTU2bUhnUlBwdVcrYXFV?=
 =?utf-8?B?dVVnMmQvY21xbnJmM0wzS3RBUkN2aEF0ZVpTNUJrZTdlQXpjeFc4YUZkTHBS?=
 =?utf-8?B?NVhKOWRLd3JabGw5UGhvQzdpcmxpMHRYV256emJaVmQ5ZFFDdmdJUG10cCt3?=
 =?utf-8?B?c1piWjRQQkYvUndiTlErWDNnbG5aY09mMzJTR0ZCSUhOV0lwQ1FQN3RhMlI5?=
 =?utf-8?B?L0NJbVdmZVRZZm1wbG1TM2NFd2JIMWc5WGJ5eTJFeE9zTEt2ckNtQ2dqYjZL?=
 =?utf-8?B?WUJjeVlKamZVYUNSVlMrMjc2dEo1WFQ0TFRrazBINlRkYXc4WGRXaXZvVHBB?=
 =?utf-8?B?MG83YVloT3A4bldjN1VVUmphN3YzcHlheFdmMlBoelVJYkN4cUw2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01c95ab-42e6-4f73-3186-08dec719b1e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:57:10.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKzbHWlU1NoIhNaZ/9MM3vqMeRPvRHRFS8xFpr/cQ6kuTSZdxCrgEQH5vDvNduTLQCz2nMFFQiT8tocAcyR3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22091-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 621C466C19D


On 6/10/2026 8:45 PM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jun 10, 2026 at 03:01:36AM +0300, Michael Gur wrote:
>> From: Michael Guralnik <michaelgur@nvidia.com>
>>
>> This series addresses several bugs in FRMR pool handling.
>>
>> Patch 2 fixes incorrect masking of TPH-related bits in the FRMR pool key,
>> which caused stale TPH values to be used when creating handles from an
>> empty pool.
>>
>> Patch 3 fixes set-pinned flow to use the pool key returned from the
>> driver build_key callback instead of the raw key supplied by user.
>>
>> Patch 8 extends the FRMR pools API with a new drop() operation.
>> This allows drivers to update pool state on handle destruction when
>> revocation fails, without incorrectly returning the handle to the pool.
>>
>> The remaining patches fix error path handling, covering cases where memory
>> allocation fails during queue expansion, and where handle creation or
>> destruction operations return errors.
>>
>> Michael Guralnik (9):
>>    RDMA/mlx5: Fix mkey creation error flow rollback
>>    RDMA/mlx5: Fix TPH extraction in FRMR pool key
>>    RDMA/core: Fix skipped usage for driver built FRMR key
>>    RDMA/core: Fix FRMR aging push to queue error flow
>>    RDMA/core: Fix FRMR set pinned push error path
>>    RDMA/core: Avoid NULL dereference on FRMR bad usage
>>    RDMA/core: Fix FRMR handle leak on push failure
>>    RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
>>    RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure
> These fixes seem OK and Sashiko found two more:
>
> https://sashiko.dev/#/patchset/20260610000145.820592-1-michaelgur%40nvidia.com
>
> Can you send a followup?

Sure, I have a few patches around umr and frmr pools I'm testing and was 
planning to send on the next cycle.
I'll handle these as well in that series.

> I'll pick this up tomorrow

Thanks

>
> Jason

