Return-Path: <linux-rdma+bounces-22076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id thZDDI9YKWqFVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 14:29:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D630669470
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 14:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cAd8QHbY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22076-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22076-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4098312F854
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570740680F;
	Wed, 10 Jun 2026 12:25:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC3FFAD7
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 12:25:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094337; cv=fail; b=QDYPI9bg84/8JIfQsUDO+GO+M4K0RqbVv4gf2z9XNg773yjc+ZKprUM7IQM4NAuLyk5sMD2tbUDXdDXDT0cFoorDyv5Ea+T1L4Ezr8QS1DLc+1BGrrHM8aRwzLOZFlgcQm3fohq7wf5udFl9CTtrZ5vEFHI0roefdB+Dv2I99NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094337; c=relaxed/simple;
	bh=NFskgCeuxWfgLffY1RLbwSpieZ/wId+aNVYSi3bbXW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddT5ArCAmcvRhKuZByC0V2RMxnpYHi03zOwkGAiLB02pcF2lbT5/u3qc6kTmjCHID0QxcF7VvEN0gnVNLmkzRSGZn59q4NgSb5sjg/7hjpwZa552yD+jLaG5nIMrv7Qv9HwBZpxE/eKi5mOxRloqFmoZ76XXQi32l1LPZyy14gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAd8QHbY; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6KeV78OleILCPyl7l4FVOy7TsSK7cuB/dn0jLBIBDeFaMIKfY371J+x0+1DDBxZeS+MUOeSv4JJ8cW2M4+REv0lS7Zh77iTTmf8NvE7uvUd2NP93znyG7HK1MlUHZpJ/8iO4xSTCDjtInphMfApYO/FX3LKsoDzF6sZyu6ViekmURxKlCmhKS3WY6BYLwmSHDcH9/+UThui1bMxng6ZzJvYtLqmmgq1uJVC2h0W7FhD3K4IJaXeIfvrYIuG6GjbicbclG+ZnUa1ExA8MXGaCZ+Xh7zbjYsMX+xV8mrNWJGiPg0g+4MyRtPpH8BAhQq6ZvdRiT2s5i66cSYdjfFPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGSldoCH4hKkT+6y7dVA3nO3vLoG6HPum4fF+QqLPqc=;
 b=fsUKoIaGM7n+h4wzZ6BCPySoLTA/kFyWAi7DTNtP4vgyyb+f9fwnaU3aHUd41ADe7OOr75rMxSEpgIsAlpP3OjXwFDiMl4b+oSO/8cZeZIy1KxKoLIpQVBg+4B38dDA3bFzMLstAmk5c5Dah8ezvljG7RFEfCBbWqmB6VOrBRJIY7b/ppEn2bNT2Cz3DN+eSrOTIK4BJa0UBzAMoEkZyUkB3dYDFeVxHLdHzsn2ebj0OTw1+krW8h87pHICQ7nSSbDOsl/5uurUf3Ni9JDPENPSyr3W7I7GczxJ+om6yhKlZ7lc8Sk/QV03gkvHRF0SnEsCh+CxWNuGczTKi08pIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGSldoCH4hKkT+6y7dVA3nO3vLoG6HPum4fF+QqLPqc=;
 b=cAd8QHbYVO4xKHpFeASMQZZsQPdTnmNgtoyaBLe8WhudEepTUKtlB61VYY0N/dmvhFIhG3BoTB5VvKDuxA4hcqra3Af4J6tUvIHwMrh5gdsp3wt3s4MRmnnRySaTdtUOgWtFCrla/qzp9JIlR44AvWUu+5KGCjBS/M1tl9g8nfUQz3k3uja5Q3OJsULL4SEBToUW5vTEvYEa3LKfXY25NcS10fFpN6zlgJN2rlwR4DDzAPvshGTJcqNJxa56lue4MkXulotwsoXts0/5uEOkSj9u/OTwadOQ+kGPsDs+W3Hm+Nknv9awpth3+qNDZS8Yx/6jv55PtHdT3S0i+tSS4Q==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 12:25:33 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 12:25:33 +0000
Message-ID: <d791de9c-c100-49d2-ba69-7f79751556ef@nvidia.com>
Date: Wed, 10 Jun 2026 15:25:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/core: Fix FRMR handle leak on
 push_handle_to_queue_locked failure
To: Tao Cui <cui.tao@linux.dev>, leon@kernel.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
References: <20260608045657.2715472-1-cui.tao@linux.dev>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260608045657.2715472-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ae032e-b895-4006-25f4-08dec6eb5e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PxadM4gHTCk7xjcfKGPv9/SXRhkuhXF/gXa1qBypB0KhCftbyqGrXK5VoQVQCA7o+8xd2DZKOvMvFk+Hh9ycFGlKItcqVMU07q2HiHUdj+8nr0fSs3+rWsvTPcj5mET2hrWWtkLEzoUMdH+sSl8D/IAqEsJhnebc/NxOOHlcnHmoWKigYzzDiN6aSggO2nS2XlEozz3PACf31p9ujw0NzPnKcWrXvcMExW1gYBtdNl3AqPjPyMqpbShiBt5xvImK46c/PbbQ6rCoDbQGuX24Ja6V1kGEKCVnHerhP6Fj6xnafIxryLGCZqT5xRtfSjwVg/b/F0dfnV13fdoW6a97yvC/7w13eJSsKNAh5qlZQG+Xvsjl26F63U64EcChOGjWlK3iwUJENGzrpajNS2g0C/hmt/e7TCOQNUacde7FvWhgK5+kZXZaDSEugFOQQNCRfjOCdKvUnRZQXEk61trzlD5CqcrzFfgQ2vIqzoNmx5dF+VzOAGEnFO0gnsjiDliNZ9HBmeoUcckGVGRj71xIWoXTaiiIUhpU+c3ko+yhZP7h1J66QYUD5rDj40UxqwBieHOOqs+lWm7VIFsPT4X2+caKLIhbwZsYvV5IEGZv3wuakPieuP04gKVp2Ge+KJLKSo7hxGOweTiHU4dbVXVFhtRQaK+02+eL/KK8Je4q9JQ/A3G5Mpum8aTcueku9nqADWwsNrF6B+zawryAaDdvWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3hvUnZvMUJsNWpOb3ZGeWF0SHV3czFiYnJKQmUweTJlWmFyeGFZTjlIdjRF?=
 =?utf-8?B?SmdhS05lZTlmOERBd2JlWTRGYm1BcnVLZ2lzYTNsL1lnSlNHc0JnL2xZTGph?=
 =?utf-8?B?bnd0UWFXd3JxUlBYa3RLWUs3anNLa05ZQnI1WXVEY2xoQUh0dzNjNFVRNVgy?=
 =?utf-8?B?OE1JTktTZlYrcnE4aXBRK1ZzS3NjZ2YxQUFRR0JUdU8rWGFhei9HRGhORXNM?=
 =?utf-8?B?QkM2UkZIV2NBcVAyZDRFdFMrLysrMW10NTJmanVpY3FBY2NCQkVkcnJYOVN2?=
 =?utf-8?B?YUpHOWFBOG5VWE40UWs5dEVTeGVqcUtwL0ZrVnFrN0dSYjNKWmpnSUlNL2w3?=
 =?utf-8?B?Nis4emZxNjFIU0MxM0J2UjAvSUYzWlZTRHZjQUxiMkkrVUYvOUFBdW9VZkFI?=
 =?utf-8?B?alYwa1VIa2pQaUg4NW9jcnpUM3gxZnRacTU3M2VSV0FCQVRCbEp0TS9Nb0w2?=
 =?utf-8?B?MW42c3FlaVFLN0ZzNmgxak1xVVVSMVJYT1R2b3U5S3V0dHZJNlR5ZjB6N0hZ?=
 =?utf-8?B?MGJyOWh0Wi9ub2djaXRXcy9OMFVWQ1piYWtvRXZmNWp3Y3VYcUhrQkJSc1J5?=
 =?utf-8?B?SEJiclc3UXVGdWtoVUhHVzZvTXc3N0VUT3ZaMzJRemxHNXdJOHVXMkhsVlBa?=
 =?utf-8?B?SWF2SFN6ODQ0UW01Q25HUFVYOUo5eXMrMkJ1YVRnWUl5UUtQYUxSejhHd0ZU?=
 =?utf-8?B?OXZTMHF1bldMdzYvMXVzSkFnbUVMczhNRGgvTmZYeHcwb0dnTTNVUk9rUUVO?=
 =?utf-8?B?Q1RmY2xBYmhuOXpLRGpCV0w3TDN3dTJXYkxMMGRGTlR1NWxyWDVna0J6dUFF?=
 =?utf-8?B?a2Y3OHdqV09wTUdabExFeDhjUjJVMm1sQjN1QldPTXRQM09aRnlHUVBCMFh3?=
 =?utf-8?B?RG4zL1hZNnUwa1pCNlJjMmNYbm1KVTVxOUtBUmJRY1lFM0hYRmtYRnRiamhH?=
 =?utf-8?B?Q3gvTXk5c3d4RmhuUWRWQ09rN2NLc3h2SWVZTklScmRrcDZaMnhYamRpYkZD?=
 =?utf-8?B?OWJBOFV5NHFRZG1SK3RGMUp5NjNEeGdLTDZhait5TUdhOEhGTUxhNGMzVmo4?=
 =?utf-8?B?L0k1ZGNtOEJ4dk0zV1cvbEJUc3pOcmZvRmJabzFYcHk4UkRJMUkwckFyNFZM?=
 =?utf-8?B?enlEWGJVQjJyV3dsMXFZVENKTGlnQjcyT3haZ2FLTDlXdjk0MDNCNW45V0kv?=
 =?utf-8?B?V3RzaFluZ045Qnord01HSEFELzZoSlpZSWlhb3hVVVBvVWxHcjdlTmVyZVh5?=
 =?utf-8?B?Nlp2cGliRWZSTTNmYzE4VHo5ekNZbzNyOElDaDJHQld3UGN6eWIvU0pRTW5j?=
 =?utf-8?B?aFpOK3Biem5UZy8vOVdabmtzaEdtbDc2YW5DS3JraGQvVVVrZEFyKzl3T28x?=
 =?utf-8?B?dmQwclBiblQwWXpxM1RmdlBnZ2lBcDJhT2FESkp0NkV4MkdqZHl4SUtaTFZn?=
 =?utf-8?B?aWZZV0tLR3V4NmtLd2JPdFNMNDg3cm9tYlZZOXJ6dlpieFI2VlhLa2RLckMy?=
 =?utf-8?B?TS9pbjVFaG8rbEhyemhKMmVObFJOMlQ0MDcxbHNFR2tzdTFZSmtrbHFFU056?=
 =?utf-8?B?dm9hTkNWYTM5KzRLOHo3ejIzWW9INnZUalZURGI0OXNXN2JaemFRQW5nVHRS?=
 =?utf-8?B?S0hucTRKUEI0RTZRTE5YNDk1R29LNzg3dkorZmRWMk94QWc4L0UrWkVkWUhD?=
 =?utf-8?B?Wk9LY2RldFdUa01yQXcxRGZIajVyY1IyaFZOZWxHSmNvc1ZUVmQ1cndncDFX?=
 =?utf-8?B?OHNQQmhYcmNJZUM1UktEWU9lekdheTRCS0psa2c4TXc1S3RUZElWR002cGZw?=
 =?utf-8?B?NXkyZ1p1a0x3MHZIVmdVcmx2KzNzbDZEb0g3M3ZWTUVra1daZWxTT2pFTGJL?=
 =?utf-8?B?WVllYzdZWndsUm1uOUVPbHE3OGhBMVBYTjlabkppeVVLTWNodXduRFZBT3hW?=
 =?utf-8?B?ZlJPRStVNTY2VDArWnVVb2RHbGI3MXV1Q3JkQWplN2dXN3FMSDR2SytyR21k?=
 =?utf-8?B?enIzakNDVis0UC9ka3BncEFWRkpNQ3hRYjNIa0VBell0RWVjNStYaUE5cW44?=
 =?utf-8?B?VjJtM3VicHNVYldYQ0ZKeHRpZmlLNy9leVZjckhZVnpFQkRqNm0vaGI2VVhL?=
 =?utf-8?B?OStBR3lZd1NKeGdINThNUUJ0bjB2Lzl4VnRBS0lXd3J1b0xvdkhtaWtEbXYw?=
 =?utf-8?B?dzJvU056LzJKNnFlVHJiYVJnQ3ExVjI3QlZyVmVCdmpsVDlMSUV5SHRVNGJX?=
 =?utf-8?B?aXpqUjhsd05YQ0htYmR3SUtZRFhtMWhoSVFOTjh6TzVYL1QwZk5ZQ3VIKzRB?=
 =?utf-8?B?bGdVL1daaE1aN0NLUkY1aWMrbjZSTzRmcU5RQ3pSd0JyNmJYMGNOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ae032e-b895-4006-25f4-08dec6eb5e46
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:25:33.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fHC9LiNmwaG8c0eHPaOYIgS+Ey+k4aMZv70MokBx5+pSr9HDQt8WTtRcZDWMBjtckfSQd6R2w/X5wv4ATwCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22076-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,kylinos.cn:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D630669470


On 6/8/2026 7:56 AM, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
>
> In ib_frmr_pools_set_pinned(), after create_frmrs() successfully
> allocates handles, the push loop may fail partway through due to
> -ENOMEM from kzalloc in push_handle_to_queue_locked(). The remaining
> created-but-unpushed handles are silently leaked as they are never
> destroyed.
>
> Call destroy_frmrs() for the remaining unpushed handles before returning
> the error.
>
> Fixes: ce5df0b891ed ("IB/core: Introduce FRMR pools")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   drivers/infiniband/core/frmr_pools.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
> index 5e992ff3d7cf..d7906fab033f 100644
> --- a/drivers/infiniband/core/frmr_pools.c
> +++ b/drivers/infiniband/core/frmr_pools.c
> @@ -443,6 +443,9 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
>   
>   end:
>   	spin_unlock(&pool->lock);
> +	if (ret && i < needed_handles)
> +		pools->pool_ops->destroy_frmrs(device, &handles[i],
> +					       needed_handles - i);

The second condition is redundant, only failure to reach this point is 
push() failure.

I've sent a similar fix in a series of fixes for frmr pools. Please take 
a look.
https://lore.kernel.org/linux-rdma/20260610000145.820592-1-michaelgur@nvidia.com/T/#m34f6910f8b8e998b079fcf5f468cb3c5056f78b9

Michael

>   	kfree(handles);
>   
>   schedule_aging:

