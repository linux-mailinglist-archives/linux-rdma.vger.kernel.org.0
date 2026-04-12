Return-Path: <linux-rdma+bounces-19256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J5iMq+s22mzEwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 16:31:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFA3E4488
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA47130479FE
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9437BE8B;
	Sun, 12 Apr 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jCMotGYc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EF244667;
	Sun, 12 Apr 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003947; cv=fail; b=WCYOWNBH7OHPRbmakeOtK6zaMpZZNukMOgb73mdFMjCk9ln6o2aXybTIMuvJTn6UnJUFrBxGig9O5qEf1pjzKZwUeG0LMU8hxnfj269yr5xEKdxTdrQvR2APPu+Hi6APhGi+RJ34lT0KNzPBGknTyjled4h4SqhcfiKlvm+V+RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003947; c=relaxed/simple;
	bh=fNNQbe+kpEsBKZyKxSW4V0VnlwZF1pW8Ykyaz/op5N8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=panDTI9RuYVLxjGcjmaqK09R+bC5yjHYb597Jlyw+8qNq3U6noR8B7A+hLVp4RjAS7DM7KavbPMczUxyoDTpGaTPGZXFdRL3RBLPmjZOCgSEL84RSBokvitA/WnS7WwqdjNlRruPXOyiaIfQwbXqzrDUVMSXVwssEuJNfTMByZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCMotGYc; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD/Pon91+TxGqljz2si5DzwzJLhcOjEaMVwA4GDLVV+8Ire0yoH0ay0Xkmv380Jbl6qLFy9HI1AkKf8WTe5/iSN2GKZ6f5X9Yqyg3ZDKITY3S6eYk/jCLIG96QUb3jclVGw242ayxlmKQQFEKubbD0ieiKu68yGKd1FGrfLJoufudBo1OZX4iT4bfxX3CX2xtuzMREsPtFkmw8Ocdk+GqTzYRsohgFYCGqKBoo3znXiLCljJ8pNeP0Q2RRYFZd9HKnqHqubSyClU9g2Q9QdTdXJaakGG3CbOUPK7V/7evEJfWj9RfyqxMIYXsfrVfsTIbpwmiVyl6E/lwJ6GRf+1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvxxAxQncUCrEOOaLc/79AjPZQK/DHf4CDK9EYc60Tk=;
 b=JqFIZDXTDME43ZDJgRqb/jSkaC4hJefwU77iDcOe66Np5b0sbDj2zJqa45i16P0HRD5y4pmwqfd1zntiCb49CJA2eccPzs2JyOeCG5Ks9Fpu9aTq8KnYqDjRAUzRRhjmnvBQ9m5P+98XyJp+JxZoGBSqiZtIcOQBqgaJk2wOO6aY01Z4+r4KRmns00Yo8UWNM8Yd+ffCLqF2qglPyTwA0hKO9yDmv2W7NV3RTRib2wPto1iPSbMJ41jv5G2tEUazNyPKqdRWTd7ioBD3q9CinbsZn7QVPjObl6NKkWHwLFlbVS9Xc2NMcMm6x4GEL/IGD1oEjZlV+vp+s7yXaWymEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvxxAxQncUCrEOOaLc/79AjPZQK/DHf4CDK9EYc60Tk=;
 b=jCMotGYc0LRcJdkdnJAWd9S4XszrP124/+tsqpDO8lp5slrSxqzVOK9pK6HWBm1izzpaSG9wYAgrnDBNhpRAAUx8PKaJW5oCJz/6G1iIRJWGMQS2zuks/X8ZZ3KE4+D1rTmVE8WKpU/dIKG/xDfpa4mg9BVgQtPQzqZQfF1+RwF1fIXmQKS6af7JJG+gEy6x4DYkl5aQEitU7HYPZpgcpcpXWIeA/11ho33ypcYmACfCGEvHIBCKZrO7vWAEpNl4ZoKEO7wVbZ7eI3+Ee1IqQSPaImJqPSsUbKgdSngvxChe7L+8FBrOx29WQ6Zf926oDIH3q/f5dTjGn9nj1/GDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sun, 12 Apr
 2026 14:25:41 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.044; Sun, 12 Apr 2026
 14:25:41 +0000
Message-ID: <4d54ff32-810d-4fe8-9ba8-3b8743146541@nvidia.com>
Date: Sun, 12 Apr 2026 17:25:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260412000418.8415-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20260412000418.8415-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To DM4PR12MB9734.namprd12.prod.outlook.com
 (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 291a92c9-8b09-4519-9b2a-08de989f5fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	snpvNPpfskoUcOa4Sq1WD83UGAFQ6SbY7hee4NhIQIxd8h7XPW/++H5gps5Go/5iqnrF9P+7aULQRB35cxHRCgUjHzx8zW3yv0xz727uDE7aJ6K+S6zTzsmsPXNt4A8KUwrlxLLBOmavKjC+S5zIc35pNQvuULKqkoizPLEPq6AC2eC/F8R7IePtbZqDWWBO8j2Ijh75/5aso1rA171MZ+Mj4xUP9G8p8F0+Er6liwM830FAC1wMXD40K6CyBxxkqecsL8o/xDgM08nLdIzVkzwgmv00A6KgZV1eh9Kr2vrK7WT+Lg2E4bZLCKxQagfwchYXmlewxGHfeiNIe/gLM3tyj7c1IslkiT3n+zvkZArceknFPObsoKcSkK+B0kW3QJUjBR6QCTj3+fsrTV/o9S63kPh1l2y+/CPEEp00DlLQsjnohUVOOl49F1k0TqxcYoX1ENC7lMLnu4vADb61y/da9a/QABTRrcmJaliNEoqYs30zI8hp1Z91nq3nhfMnEvrIJuVonuV52bd0nFfqO8hZ2izbFWXZ8cOuClAXnfCjdvJB2C324Dvs5BDnuwNDVfNuEL51QajCpHJgNqLPb3WsXL+Fh6q6yztbjDT6T5nu3p3yNEgfkMLyNsdobZmCqwrA6Qzn7a0x2iIFzHavguLTQsM5SZgCVYXMERlJLFYWDyVmltlLujbCyhbbn3Mo4p3PbguXTnFTcO2yj5rFdLqEiDDyp+du1bwlxZYQduc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9GZ282eWthc1hsWHczVVA3cCtWUlRhNERCVktJZTNVeTh1S0ZPTm10cDFS?=
 =?utf-8?B?MWtoSkIwS1V4RW9NMHoycnJGdkJHMVNkNHUwaE5VckYxT3loMHVNaHVtbDU5?=
 =?utf-8?B?eHdIZG9IUjJCbXdKbGFJenMwVk5uU2hreWQ0UVNZQ0ZTVjAxc3cweFJtV1RD?=
 =?utf-8?B?R1RSZkFEZnM1OVk2Y1lXWDA3UnVjZ25CdVNRaEpDTk5zN3FueGxVMS9KYnNX?=
 =?utf-8?B?WDBwS1lKZjVRQmJHSGpJMXlpRS9XeWVFbVBobHdoRjhpVlJrQjZFcitoU1Bh?=
 =?utf-8?B?bldsaURETjhMRCtYRGtNdzRDVzlvbm9meUM5SEtFVXVpTzlzaFRLSXVqaU9u?=
 =?utf-8?B?TXdRelVTN2d3MGsrU1NqdDcrSFZVclFCY25tRmUrbXNxRlBwM05OeWhDVVJh?=
 =?utf-8?B?R1ZCRC84NmV3aVllMWxObkVwbTh4aXVMd3h3eFRuU3o1WUtMVTNnSFA0bWc2?=
 =?utf-8?B?aDlsZXE5WExvZEdTR3NnUDJ1cXlWTERVOXZEakV3akhXZ215aTJhYTRlcDVI?=
 =?utf-8?B?Y0o1N2JYQ1pQaENTTkd5b0FPa3ZvdFZFS3EyMmk2K2lFQkdKS0lpMmUzbFpr?=
 =?utf-8?B?THdCRGthb2pBVXhrelMzUm91Mkh0WmhqallpU085OUtGMU52VGJRSy9zQ2lj?=
 =?utf-8?B?bEg0KzZ5d2RNQ3RqZVJDSFRQdVQyYWJ5dWJnb3NUb1pXTnhRdGEvdFU0a1la?=
 =?utf-8?B?L3pCU3NjT2dTOHJtZXNMMXNGdndwZHF5TGJLeXVXQkdzK3Ribkh1Wk9GYlN0?=
 =?utf-8?B?Vjc2eVdjclVwUTNjZXRNNG1TSnozUnVBbDJlVUFUNnFBYXR3dS9nN3Bra3ZU?=
 =?utf-8?B?c25LajBhb1krQ2gyTmd1blg2ZG10SVc0d2s4YWMrNUxZelgyOWdZd3hRaHp4?=
 =?utf-8?B?VzNaV21odGFJbFVWOTNYSTBzL1Jnb2N3S21LNFhXTUVRRlFKcHpiSDlyUzYw?=
 =?utf-8?B?OFlkWEhiU1VkVjJzZ1FzbGJDRy9QNDB1b0FuVk90Tk01ekszZTVXZVg4RHU1?=
 =?utf-8?B?NEF6OTZkVHdnUjJKaG1Ja3o5c3RYRUxzUTlsRyszcXg4YXlvYmhzSlJLcHpl?=
 =?utf-8?B?NzF3TlRETXZQcTlzeWxzTmFWSzZ1Vk4wV3hmWUo1cEdRM2JMR3dwbmo1RDNk?=
 =?utf-8?B?eHdPMWZqL2pyeWFkSk9VazZtL2NJQXRzRkUwTHNrR3VTRC92UGNSOGhiZlFQ?=
 =?utf-8?B?bU5sU0FQODZWanh3eTZnWWt5MW5ua3FUeWErR1Q1M2VVbVNkeUpZdWlIRzlR?=
 =?utf-8?B?WHFzMUo2L0d6TGpYeXczM0tVbjZPdHdRNlpkWGhRNzNtL0dKaEV5TW9lcDF6?=
 =?utf-8?B?a3lDSEZJNTZKaXZwSFAyL1pvcFIrNkViWVJmYW1SODNOeXBZUHpVODJxK2c3?=
 =?utf-8?B?LzY5NWdFUGxmTitLVU11REVLallFcUhGbVdpK2RPVlFLR3dDMzFKZVBLbjhj?=
 =?utf-8?B?WDQwWVZHOXk2VUNLckVZSklxMGk3VmdGOXAySkxzQUZDK241Rm9sU1l4bUNK?=
 =?utf-8?B?cFZKWkZKL2lTdTNsZDJMdWp0TXI5ZGFzRGE2RThseTFvVGtSNGdxbmhGVmxr?=
 =?utf-8?B?RklNdFR1UGtpa2hYbGoyamVkbnFMOWh3cS9Tb1pMR3h0cTEyeXJCTFFFZW1X?=
 =?utf-8?B?T2RHMmJFK3dtcU9zWStuU0FsNGthMzIzbWduQzlrOWErNnFxMk1EZVhkSi8x?=
 =?utf-8?B?QlBzOTlWUFRlaFRWcDNmeTd6cm1SM0J5WmJrd1NxZVdib21ORmFjeWdTL1ZM?=
 =?utf-8?B?a2JlQS9HblNPYzFrWGZjK3lEN2pQQjhJMTd3Nm1rcjZtZFZZb2gyNFM1bGE1?=
 =?utf-8?B?dGFjZkZLclh5SWEvbjJ6MTQ1UlhZSW1sV2VBL3FlaEdZdXdhMm5BazNMbFZO?=
 =?utf-8?B?SzZ5cWtDQndJaitna3lYRGNaUXdWRmVEcE8raCt5WmFQR1JsZHhnUytEcnBj?=
 =?utf-8?B?ZlR5Sm04MUUrWW5mTGhLK2lDSVNUYU5UZVdpSDAybW9tUmNlZDNFNHk5MzVw?=
 =?utf-8?B?NWg5K3ZDcEs0SDhMT1MvaFUyNmJ3TTJUQkcxR0t1WVJoUkVCTll3aENKZGNF?=
 =?utf-8?B?dStSQ01OOHp1TTFLT0tJUU5QcHNRcGtVVjZJakQ5eW16NzREU1F6ZHB0aWZN?=
 =?utf-8?B?ekVIemgyVzRCTk9zQjAxZ1ZxVmRNalVnTm9IUEpOSjBNZXhscXRmWjJwT2JM?=
 =?utf-8?B?aFZFUmdZdjVpMk5BbG10N1hmRDQycVJpWVFqM3ROWk9DQVAydEdnUlMzT3l3?=
 =?utf-8?B?VHFpU20wMmlibWRUVkxlbndlUnIrTWdORXVXQlNFamFmU1dPeWt4WE9HWFNx?=
 =?utf-8?B?RDJDUkErV1Q0M1FPS2YzUDlicFFWdXpLNFdPTWVyOGE5MDRtek13Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291a92c9-8b09-4519-9b2a-08de989f5fd3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:25:40.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF9ROJavDiIG7/I+RTpbsrUouvY0WN2ehwPo7hiZrOeil6tUN8gy10cb9mY7BLpORGnxhqDLNGGlOWYAJaBukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19256-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64DFA3E4488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 12/04/2026 3:04, Prathamesh Deshpande wrote:
> In mlx5_pps_event(), several critical issues were identified:
>
> 1. The 'pin' index from the hardware event was used without bounds
>     checking to index 'pin_config' and 'pps_info->start'. Check against
>     MAX_PIN_NUM to prevent out-of-bounds access.
> 2. 'ptp_event' was not zero-initialized, potentially leaking stack
>     memory through the union.
> 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
>
> Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
> Suggested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

