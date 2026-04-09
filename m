Return-Path: <linux-rdma+bounces-19168-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC6WJCS012lURwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19168-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:13:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D93CBD3A
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8D0303DD1E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6134CFCF;
	Thu,  9 Apr 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uho1rItT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EDA363C4B;
	Thu,  9 Apr 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743872; cv=fail; b=deqwb8FTwQfu61IpxAqkqWJ6jkQT1rDeNk/xwPZvHp4OU5UiZe3MLEYX+y3G2UW7D+kXuOZXyVH4eINgkWWkFH0Rgyag9nqAvdutq9spiDFYRHhrOk1uOQdu1lJCaLRPuOlGvMvVwnZ4se2UYQBFu61xnKLBXEz1bqqwOfK6Y9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743872; c=relaxed/simple;
	bh=uxEUi7XluyyALWBIk3pzjuPKJJtF8c7sHaxxjivBT1A=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idaq0+3J9fD7iCa13QF7xa2feBe8za9EbX+hLx4mMvyRmDiL0BiR4Ssk6m1nFelbETcu9QfJ+L56hsovoJYf9uK4Ge4nYcHlLyaqWxttSLUSjV3CpOfq/QcfadvJ1uCtxJNbyHhTWwH5wIcK69rilLmqGUwZcMqeYESEEMzFXqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uho1rItT; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjM9b+Ij7il7ADN8jFN0eJK5qLTgHUV44hj6isWX+QsZJgcj/qaGp9+IYX5l12/0Y0kuLl5SkGDCbUCxZyRho2HUsYAmeLdv4mtboXPldYuu6jGGxTVskloHKg+y8WWd4Lgvfyk2A5q6BNlySCZD3VLggip2PIIjnbN+Qnad1vqfL1TNNwDEBFC3XwmnbQW05lQk5/u/r/8H/Ffn+gr/ynoyPBcfbCzaqFKfzjAnv6aPULntZmuvT615lRXRXiq87GvZCyYOvXRB/NgJONnJ4JmagJp8Y7/cZ/rhvDlLoMJlLS5frIswDnc2ErV6gWChdNISN8DIY2MEb3yuu0AsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=EsEbadahpoqE1yt5L+chvRH8lkOa2Igol60FsdYmdLd8qPM8cKJO5Gv8aEBTECnRt/q2Jle/SD6FUMjIiBUnA7dr3uFuGCtcUEk9PVvTWWADDU84WrPphGruAAuxmoAtUpLEkiyvY2or3BqS+qmi9cW+oMQHMdyExAtAu+KW//jQVyXgvLWuJysABNoAo9Oy29mu66O6DsXzRDaGVfEK6rwQgJxubf2LC/A4L/nlFq5GTUEi17PL51D9OEEOCcMKBbV3TTMOoKpn5+wjZJ1JKg8ZJWjKl10qTTkdKrwHX/CgV+bKZDcArv8rEz8GJaYH2MEH5q7Xd4a5nPTYsnNqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=Uho1rItT/f5FMTipcF8Igtz91HdDHmY5qiQbxaUAwkRWkC49pUMOhoE+G3hIa1RVP8OUXAtLE+jXGdw5U4Waq5o1DCNSG1PALd4Nh8eEJackyB+g3Yfws5gwS+RgaHNgeYnLDqStGqY9ThbVd1jnKMIE4iAhc2Q8PuccKuZWt/UThwZdrM0pQYQdwQnbQlxDB7JD+bcXqEqq2koSQVHUfgy35+zCXaAWCuEUip4Vwx2Lkr9aTB75wTuaa0SIPBo3V8ySEKaLtkR/d/041PmGb6ISB18oZWKge3aH0x2skV/Vd0N4KIfP8nPy2mrWz/zQL/hA73FER9J4Tw1cqjGR0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:10:57 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 14:10:57 +0000
Message-ID: <866743c9-020b-46a7-8fe2-46936a73b534@nvidia.com>
Date: Thu, 9 Apr 2026 17:10:52 +0300
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 richardcochran@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com
References: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
 <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
In-Reply-To: <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 222c3285-d265-4456-e4e5-08de9641d232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DYGnrH6ieMx1MKylRttemhDIcQbpx8rzCNScB9PuxtHdEjsByFN8XRBYzXw2OTKCIS0+4UDstjePPAwwThOlF4t4tsXZINABsxVft36lukCOjSVpSZHs7GgEg5TnUEsaL9rd5975VLSbmDvjgv9esYKckHE4TKjqfh4EzH+OKPLY4L1SXnZEphFgAfw0FxQZ8iPd8veoaGXUjmax6A/6b+Rmiaci41Kdl7Y6L3AOkOVKsPjzb0nw99PDJev9JmdzGslP5Wl8mmSQ7jND80OEftRE1z+3sVf4x09eBqgoGh6DXIOG8nKlm1M3ikDe1Cv5OnIidF6Y4s8SlL49Gsm32O5fDPUrxfkylJrSauOi+VERc/lGgT7Viq8tt60UbR6n8ASuE1PtQg/8vXmEYM1st0teiN0y09Cv5B4vglWWgSiKCF4c299GOJHwuNk9ohhSS9EXM8TOZmrDsQzohMS/tFm7p2GvBUoD6TH4vdzDitNG9neQ418x9P2xNQ/mfVIv9Tmf5Zf6RpKcIE58OixK8cJ9myTn7Znbyl5+Jo2RJY81W4UxixsFyd8dlllDIPWQVxCI+QHcuxzA84KB4U8b+KLkCYnWW9M+40yiFmnr6Y5v8Lror+8bM90HMdppXWgUhf4+3O+1cR408FQfs78ztn1sMXLxgcB5bXzzuUow6o4/Om3DkZ62EyOIl3sgGCdPgD8j7K/NQ2XVmQTyK/h0TQHYOxWmnI+rjVbktYNqiPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmM4TTVmdWYwempXNG1DbDI4ekJ3Rm9rSEZBQ2ZOUVlTRm9CdGp6d1lxS3Vp?=
 =?utf-8?B?eWVoaWdnQVFreFMrTW4zbEZob2VzazdsQWU4WURaL2YxUWZaTjhwVzhUL3ln?=
 =?utf-8?B?cXh6bzdTVVJRTDQxUUFMQ2d3ZFZuMFFpWnRuTXovdUN5S3FnN1VKMTFVbEhz?=
 =?utf-8?B?SGw2bnRQYXh1d1JTQ2tBRE5uVVFSK3A0TXpCNE5wejV0QnhGaWNZMHU5Tm9a?=
 =?utf-8?B?MWhNTEhQQmVIc0lwbWxaV0lSWTdZd2o0TE5sbmwyZ29iZTB6U0ZobU5jUnRr?=
 =?utf-8?B?RVNkYko0eTErNzAzV3lxcjhzQlgvMmtiTEgvKytzOUNQQmF4emEzZUJ3VlVa?=
 =?utf-8?B?MXBpQytkU0Rhc1NPeVoyY29KTEVtUmhYOG1wWmh6enhLS1dpdGNXZFRlbitM?=
 =?utf-8?B?bHVOaVhVUDc1bWQrRUNYcmlyMnB6TFFiaU4vN0JHRUxCMTJTR1dZbzdrSnhF?=
 =?utf-8?B?dmtHdHVPdm1jcGgwVEtaemp5SWt2ZDZkMzA5MUdEdDk2SkxSQVY0cnNGNW4r?=
 =?utf-8?B?SUVxbGFaaDVIM0VBK3RXQWNVZUt5Zm9Yb3dmbHN0WG9pMWZlNkp5MWdPSU4x?=
 =?utf-8?B?UlM4YVFmZnNQTnRVSHdtUVQwTHI1K1lEV1dLVzFSSlVhMlJkclNsMCszSWxD?=
 =?utf-8?B?S0xBZFNPdndTTEhtZGM2VDVFaDB1eWFEdDQyQWhleU5HVEszYzhPMWFJM3Fi?=
 =?utf-8?B?c255RXYwN2RGTkpiS1ZHRkFOU2tncjlaTm5idjRxNmpKUmltVGJlTkFSNjlG?=
 =?utf-8?B?N2pCaDZGL3hsNVY3QjhjeVVLZW0vUlVrbGR0RFlKbTBmZnhGUDNtb25QUnBC?=
 =?utf-8?B?UnJXU0p0c0Q0NEd5SlpmZVdsWGdVWFNhZXMwTk4rNHhpQlFxVGxCMnJ4RTlZ?=
 =?utf-8?B?aXZwaUYvUzQ5STltRDFCbGI2QU5rWi9Kd2JEeHNQcE85TER5YVp4Z3ZmU0Uy?=
 =?utf-8?B?QUVUNmVKakE0d3NBbHh5dUtlZXgvV0hZL255cVNTakZmN3dSWDBHQ29DTjRl?=
 =?utf-8?B?RmtVaFJSY0dEeFh1L3VTTTJVQWlqTGE5R1RNTFl3UDk1OXlUSWE4TGJpbldP?=
 =?utf-8?B?YytreHZidmwrM1RHRU02MUxXVkxPR0NJaFE3dmJnV2NnWFN3eHd5WCtXNC9H?=
 =?utf-8?B?SUxHSGZqMWpzVGI0UUZZSDJKWGZ1RkRicy9hdzlQVE5ORW5hWGNjbzFJcXdI?=
 =?utf-8?B?K2tObm9sejJUU0pjRlJFL2dVQmd6Mm9Ib1pRR1VhOFNoRkhsWHhVTEc3RjJQ?=
 =?utf-8?B?RStUVWZMbjFQbWNYZVhLQVVHSlNYQmJCV2krZHFOcmR6QS8wZ0VDdFVuREky?=
 =?utf-8?B?TUtsMGFQdnFCR0owdTJJUlFPOEdGdGlGOTlvUXlhTlRiVm9lRXBsVGdabHlE?=
 =?utf-8?B?NG1wSHdJYnc3QURPQ1lwT2xDbnQycUp3Q1AvSHJBOHlrVHFwcytxblMwMndN?=
 =?utf-8?B?L0JQM1R4WUdPdEpMajNSdFpvY011RmwxenRlQXFQd25MT0RTNTVtRmsrM2Nx?=
 =?utf-8?B?blVvQUU4OFloaXlJNXp1MWtjdGJ3SXhCY01RUDErWGtrN0tXczBvbFpFZWhV?=
 =?utf-8?B?NVorN1BjbVBXMmZ6bVFaOUFUeXl2TjFVKy94YW5SYU1OWUpIU1lLbkJQM1c1?=
 =?utf-8?B?UjBUdW9JOThjOFRXemtRRFZWQTEvR0dWckdXb3BCYXQxbUR4QWViMHU4ZE83?=
 =?utf-8?B?TjVsMzU4NEFyNVNjVkdSaC9NWjVDZ1Q4VVFlVVdrSDQ0dS9tZDREeEVTbCtR?=
 =?utf-8?B?dlBwVTViZGUvaUVQZndxajEyV3NvYXRCeFVDME43YkZhQ1dIM2hxZHdUQ1R0?=
 =?utf-8?B?NmpaVmNhL1UyaU1wR1M5dkpaRmE5cDVMYnB3Zm1wazc3dEhnTEN5Wm1hTkI3?=
 =?utf-8?B?RnBxdzNaTnowNkx2ZzY1RWhoZ1pOdHRZcFNjRmpJVUFsd3lKOTBZbjNTN1FQ?=
 =?utf-8?B?WWRFR3pGcWh0VEMwM1MrdXlxdDNkSDVGVE1RMjU5L0tuSXl4bWw5bU1aVW93?=
 =?utf-8?B?S1pVeFJHclE1VEFib214Y3c1aGNmdm9BZklmN3ZEYW40Y2hmVjJueFA3Sksy?=
 =?utf-8?B?aFVnNnQxYTN4bjltdmh1ZnJhZEptcUU5ZzB1RDE5dW93N1VLYisyOVR5SEc3?=
 =?utf-8?B?WEVxZU1SaWdVV3QvUjJyM0ZTUENuRkNjNXEycjAzbWpVODd6M0cyQnd0RmR3?=
 =?utf-8?B?Ni9NM0crYzRWVG5sNFQraU8rMXhHczdzc0c4R0xuM0lPajJPSTJETlQ1ZU1o?=
 =?utf-8?B?RmoyVUFSbW5ZT2gvZjE3R09PUzhtNFRScjNSdW1JRW5SSjNObjFhWTBIdVVR?=
 =?utf-8?B?QkpYSWw1OFBIMWVTOGlvTk4wUUtUQWlwQ3dHenJUN1V6RFBUelZZQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222c3285-d265-4456-e4e5-08de9641d232
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:10:57.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSe4VlWqvs5Z4lH/bFnjFptjxXrMUKoKkulCZAOb/QogB531ZaCnBwoCqrqD7pgwHiqWaITFbH/PDLqIsAK99g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19168-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 007D93CBD3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prathamesh, thanks for the patch!
On 02/04/2026 3:30, Prathamesh Deshpande wrote:
> In mlx5_pps_event(), several critical issues were identified during
> review by Sashiko:
>
> 1. The 'pin' index from the hardware event was used without bounds
>     checking to index 'pin_config' and 'pps_info->start', leading to
>     potential out-of-bounds memory access.
> 2. 'ptp_event' was not zero-initialized. Since it contains a union,
>     assigning a timestamp partially leaves the 'ts_raw' field with
>     uninitialized stack memory, which can leak kernel data or
>     corrupt time sync logic in hardpps().
> 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
>
> Fix these by zero-initializing the event struct, adding a bounds
> check against MAX_PIN_NUM, and adding appropriate NULL guards.
>
> Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
>
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
> v2:
> - Zero-initialize ptp_event to prevent stack information leak [Sashiko].
> - Add bounds check for hardware pin index to prevent OOB access [Sashiko].
> - Add NULL guard for pin_config to handle initialization failures [Sashiko].
> - Add NULL check for clock->ptp as originally intended.
>
>   drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index bd4e042077af..a4d8c5c39abc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -1164,12 +1164,18 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   							       pps_nb);
>   	struct mlx5_core_dev *mdev = clock_state->mdev;
>   	struct mlx5_clock *clock = mdev->clock;
> -	struct ptp_clock_event ptp_event;
> +	struct ptp_clock_event ptp_event = {};
>   	struct mlx5_eqe *eqe = data;
>   	int pin = eqe->data.pps.pin;
>   	unsigned long flags;
>   	u64 ns;
>   
> +	if (!clock->ptp_info.pin_config)
> +		return NOTIFY_OK;
> +
> +	if (pin < 0 || pin >= MAX_PIN_NUM)
> +		return NOTIFY_OK;


pin is defined as u8 in struct mlx5_eqe_pps, so pin < 0 is dead code.

As for the upper bound: in order to receive a PPS event on a pin, the 
user must
first configure it via mlx5_ptp_enable, which already validates the index
(rq->extts.index >= clock->ptp_info.n_pins returns -EINVAL) and since 
the mtpps
register only defines capabilities for 8 pins, so n_pins cannot exceed 
MAX_PIN_NUM.

Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if future
hardware adds support for more pins we would notice rather than silently 
dropping
events.


> +
>   	switch (clock->ptp_info.pin_config[pin].func) {
>   	case PTP_PF_EXTTS:
>   		ptp_event.index = pin;
> @@ -1185,8 +1191,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   		} else {
>   			ptp_event.type = PTP_CLOCK_EXTTS;
>   		}
> -		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
> -		ptp_clock_event(clock->ptp, &ptp_event);
> +		if (clock->ptp)
> +			ptp_clock_event(clock->ptp, &ptp_event);
>   		break;
>   	case PTP_PF_PEROUT:
>   		if (clock->shared) {

