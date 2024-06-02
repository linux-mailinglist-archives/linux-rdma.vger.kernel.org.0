Return-Path: <linux-rdma+bounces-2756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4078D74FA
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 13:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E940E1C20F83
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BD219E4;
	Sun,  2 Jun 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+IMZIsC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5A1865
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717328616; cv=fail; b=mWBtKK2I88oTdkAy2kUIi/ick1fLH9duJeV28gvY32/eQpLxqkCCRFOkD02CuU1Kn1K1iGbfyVhriiCtsxZqwpGrJkqQCKp2HB/dHS3MfRAkXfsD7vHvjtmoiCvcp21moT1uHitDUKeFZt4YkXYEtFhew8YMmlOKpOC3v2w4nQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717328616; c=relaxed/simple;
	bh=mnPH9xGFdSMFk2NM+iaSrof1wj/WVUTvkg2FtWjjOYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNiH9XrKp741b9MFy4CWEGeEuT3inT235VvPyypN3+3tDkpX2SUPQloCrQQ69JVkTPtp2lozd2pQz1x8zioEXzm4bahHCnj+KyS2sVRwo+/Zoc8EebVqrmksFuGIMSP88AsbXoM+WclDx/+2NI/sf86KLtXkmJ8QHEWVRpjsq68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+IMZIsC; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E40XD8mvyRMUQTxyab6gtJqZfWkfQVpr70taJf8PYJtnbRFSlolw6W9Q+mnADhmMYeexTOUqT1oIEeA5M1VsLd8sgrnaPhTm0yFWbMZfx7gMe2M8TqhCR4CjhkXl7iqtvcNSEUmyO5dHxQxji7BIKQLDrZqFgpNlrOgqxtuoiUL5c3xF1HLjD3A7pxNJFOM+j10KH+QGNwg9bH3QvR8EZbQyv1MRgrm+Ox+Ik+BEc7YCsqB4PH4NEP78sA3hzsVLsekKswIK2moEiEqIWLeoDkUnkrZeTRyh1gHcp8qBaAUQvL+mm0on0MXF13Qz7BFl/F8E0+npLeM22Jgm/mbjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mTVH/fQKUHGv3Y8VNjJBXGR+xuMtSDDEx977rner6o=;
 b=GMrgQleDuCNdeGAK6hYC751JjdUd5rEbJC1eCCrx9aGYcOCzWcBuSUgBqdLsFkI7iUEwkH53FgDOXr2TbOa7FyYbKAxvfTV9IfTiml9l3x3WEXG2qItWGm8+iR2i8hhhhqDZFD7BmmuvO/+G94X/cl/1o4VLbY5TnhceCQYnfnSueNyk8fbGHNLf1P4DNp0BFlbYr4iCgLglq7ca1fOisNbC9bOQoYE4DTecCd2crAEuYNjJ4/8i1rXYNaZvNnmW59pAuwMUgc0KLR6CKjFG5p81fg1OlRLzrMYrq95796G2Yy21bDIOM3/1TF4Qt3kq6GanwOIdaPEpzYBk3W8Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mTVH/fQKUHGv3Y8VNjJBXGR+xuMtSDDEx977rner6o=;
 b=E+IMZIsCEp8cVhrLQWI+OtWd5jXk7N3tLFz+F6SEnDVKW+61jS3xu7OAUerV82nQ9lkHfJrV1VLuRgC7N4RW+mFhbL9AYl771sOrqiBw8oYT0zNzhSlQs04yTTMSNXLvCmJ/qa+sFYQIV31P7KYKxi043Ndbn+2YD5zq+Anhr1OyfxT0mZSab62zBlXfMeyOgJ3LTR4s1LIMuY/khoM6OWif/1Hp2KOMXfuA5ADee4aHTLLTctG2JHm9jaRbECuoX4DbIFtTQ3U9oWsmuK6YtwyinVVgcdlJDUKBAfhdmlhUl0nnrROwQ1PaWr+nr9hBZ/9cQ2dMqBm5EgYHSX3eEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Sun, 2 Jun
 2024 11:43:32 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 11:43:31 +0000
Message-ID: <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
Date: Sun, 2 Jun 2024 14:43:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Israel Rukshin <israelr@nvidia.com>,
 Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
 <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 015e97e6-5014-40f1-3938-08dc82f93a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlFS1k2bytmUHJkeFpjbkkxYnBpalNQTjlaVXlETVRYZ1JrRDFtaW9tSS9W?=
 =?utf-8?B?bWF3RFliS1hsczl0Y0pxQS83MlUwaHduSnkzNXp5SUtPTFV4Rkp6KzJnTmVP?=
 =?utf-8?B?R2JzZ0didXRnTjNYdEJpbXFOQ2hra0VBRnl0MnU4YlRNSTljaFFrYUYrSmdl?=
 =?utf-8?B?WkUxK3pHQ25LSlRDc0JOMi8ydlhxMlBLampDV2F3aTcvaFNyZDhub0pyNldr?=
 =?utf-8?B?WDdNQnlFTVh4aUVKVFF6djdURGIzVDBpeEMvbXRGakk0QjU2ZEM2RHZLbHpk?=
 =?utf-8?B?Y2lIb21yblpZZVZYdE45SnF2L3U3cCtRRklXKzIxUEZQNVNvU2RsbmFwSTV3?=
 =?utf-8?B?NitPRkNIUEVvaTNFaVVhaEZGQnZqd2svY3ptUTJmWGEvVUZyZGFSWFFnajlV?=
 =?utf-8?B?eVFQRTZGMHcxSEdRaFRKQ1M4ZDRwd0pOOFNoZFNwdVE5Q2Y1dFJIR0dpb1Nz?=
 =?utf-8?B?UUZJQ0o5NGFNcVNweW5tYnltRXVJVU9DOXhKN3RpanVMRzAzVGUzcTlyVVF0?=
 =?utf-8?B?SFgwWnQ2amdnakFGdW92a0E4SlovRUh0dU1JeWoyb3p4blQwK0RlT2NPU21v?=
 =?utf-8?B?K2RoVDVES0dRTGlkS3ZGd3JKTzdPdXdqZTQxZW0zdHlUYUZ3eVpoWE1xOXVX?=
 =?utf-8?B?SG84VVkzTmM5anlnWHJrZGlGcGNFSnJkekRWMlVqakh3aHp5Sy9raEdkRmdp?=
 =?utf-8?B?cVlTVkptS3BCeEhSVjFNSTFvRzJUZ1Nac3ZnY3lBOFZ2SGNFM2k2VVRaV1pM?=
 =?utf-8?B?anVTa1Y0YWR6QThHYUVTQWdjaWVEQ2dTTUZmYXJUMXQxaXdibmhCZmJ6VHhE?=
 =?utf-8?B?dGZMNXVPS1psbVV1NXhqajJ3dEZjemQ1c1pOUGJuZ2l1ZjFBTWp3TzVxa2ti?=
 =?utf-8?B?Qmx6bGxOanlmdXJ3THBZaTRjUTZUSStlcHBCRnNJamhON3FpQVdEWlpVc1pE?=
 =?utf-8?B?Sm9wMHgvN3FaOCs2Q092dUdkWWo0NEdLVnZ6VVRYdU1CS29FZElyTXEzVDdw?=
 =?utf-8?B?dm9oUjlsdVQ5MGd4Z1lHTzRXYk9BQlYwQXdhVVl1R21qczZpUFA1WHZXV2x2?=
 =?utf-8?B?MFZ4Z0ZRMndIWHhzVytHT0VaQ1R6aEZCWXRGUm43MURQSnBJWnQ2VEV4aGM2?=
 =?utf-8?B?QjdXRlIvbFp3V2dHU1hvMVlTU0NWWGxsL0xQOGZlQlZqNXh6NVZFNGxOb09X?=
 =?utf-8?B?L212K3JueWhCcVhYSTN5eENGamR4anZLVExSLzM1eWtpazd4MDVwZ3ZuZm5R?=
 =?utf-8?B?NGxFSTVybklMWm12a1BjMXAyV3ZNYXY3UXhUREhIa1Q4cUNab0tlQWJid2gy?=
 =?utf-8?B?cG9Mc2VoLzFsa1o0YWlDOEl0bStaUVZjQWdPL0xQTzVpRm5EOThFVTdscnZP?=
 =?utf-8?B?NDc2RGdBTFpTbTFDZUhLWkhTdU5rOEtaMElGemp6dUR2YWJqNldFQ1VsMlk3?=
 =?utf-8?B?M2Z6cmdoMG5ITkpXdExVNnZKNHh5dVltV3FOTjlxT2UxV1plL2YvSXZ6TVBh?=
 =?utf-8?B?TUhMVVZLcHZzN0tRWXdaN1JxSVVVb3NZbjVRWXFGRlpTNHJFbXVUa3RsdkJ0?=
 =?utf-8?B?dVFlZVpWdVNRSCtvNHBNaGQ3dm5IdlgxL0xCL1dnT2lsM3RqUm1zTzk0MzhW?=
 =?utf-8?B?NmIvVTlUY25scTczREtyM2RNdm9JTm1qOHlWOW8wMXVuY3ZXcGV1TVNHVlNi?=
 =?utf-8?B?Ti9sdElTcUIyOXZJZ1QrQ3JCK2paSFFKMlV6bVZ3NjFxY1FzOEovOTRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXV1cUdBRW41THMyMkoyYjRzb1ptL2RVSjNNWXBCekRmUEE2Yk9leGV2QUZJ?=
 =?utf-8?B?ZUZScGtieXVWVGprT2o4Tnp3MUZjdTRlT1hicnNBZDFQNkpXRDZ6cEtCVkU1?=
 =?utf-8?B?OEcyaGJTOFpCZ1lLbVRmMlhsNnB5VC9HT2hwc0NGMnVSZ3B3Z2tlV3k2VVV0?=
 =?utf-8?B?UEE4aHdTV09ZZ2E4N0dEam4wbUQ0SElQblRPRzlKaFB1czljeGgrZTJYbit6?=
 =?utf-8?B?WEgzVFo1ZnJFUWJVQlhqVVYzdENMRURXblFTYVdKRkZHQ0tlTnNlYk9QYjVH?=
 =?utf-8?B?ay9QekxEU2RZcUZzMzVDallLQzF4akdPSVZyTC84WGpCcGlaR3V4YXFtQW5v?=
 =?utf-8?B?YjJtYVZHeWJzOG9oaGk4bUZaNGJKcG9OY2VzbG1Hb1pMZTNWVjVYTGtWUEtw?=
 =?utf-8?B?dFZGbFo1U3NmZWlXT0t3aGJZSXArWGUwRmpqb0JGb1YzZEtDeE9GSlcwa1FU?=
 =?utf-8?B?TXVIU0xTdDM5MWNuYm5BQWcxUkpERnE4Zng4M2ZRYkRtVlgrN2IxSU91UmNX?=
 =?utf-8?B?V3ZKSUZyVnJOSEpYMDdjNVlBZVo3cmlJc0R4dzJiZVJDcWp6alM3d0xDU1dQ?=
 =?utf-8?B?cnpEcUpacSsxN3hSRkFkeTEwOWVRZEpCTEIrUHhkUlhEV3UwWEtVUll3SjdO?=
 =?utf-8?B?YXNPeXd2TGdCaHpyR2NCK3oydVNxQWxJdnBVbit6cnR6TEp2UUJSMGttRi82?=
 =?utf-8?B?SWV0c0xZTVdFcmxXOU5KdERCNHhWMitZMzZSTTdrb1NDZkFvQkpLZGRoc3hD?=
 =?utf-8?B?YkUvN003VHBvVlZWVDRsQnkrbno5Qm12Um1oT1dFbWF3ZUpQQ29SS3o5Ny9O?=
 =?utf-8?B?Z3VMMkZ2WGpnS0VQZVJOdThiUXJrMnROQWE5M0wzaGtsNThCM2xQRkpJY1dx?=
 =?utf-8?B?ZUhDV1FvT29HUkFWSDVibWZDeGVicStCWi9XcHl3MkdkazFsQ05yNWtaZlFs?=
 =?utf-8?B?ZWZueHRZRXh0NU9Od0dUcEJxS1lJSlBiTmMrOWpkaXpBOVhHamZsdzRyTjBI?=
 =?utf-8?B?UmlGSDN6bDJmQVMya2FGa0trcE12SDN5bzRUdzJaQnBtNEVjVGg3Qzd4WEND?=
 =?utf-8?B?WlRiNjUvYXorbnllejJJZ0IrL1BTQzNReVZFYlhwU2NodENrU3NyLzlWSWor?=
 =?utf-8?B?K1NVcjBXQStrUHkzUUhOV0UxcnZvL0JJQWJKMkIyeHEycjFTZkdHbXNINm1I?=
 =?utf-8?B?V0RVbjNlSlRNWGUrY3ByL3BOWFVjcnFoaEV2WkhNVzBPUGJML3p1Umhkd2NU?=
 =?utf-8?B?bm1EcmdsWnBYSG51ak8rQmt1TjE5RGZ3bFRacm5GMFZjL1dna3AwdFE2RWZl?=
 =?utf-8?B?cmR6bkRBNFZSbWg2UGsyNG1vMzczajAySTVUdlBHK0lVbityaGNpbHNmVHF4?=
 =?utf-8?B?VEs5enNBUGtGbkp2dFVoOUJ0WHprRy9kblYzZXpDOWJaMlpyMm93V3JGK3dK?=
 =?utf-8?B?SS9haFU4b2Zsc0h3dEhLaFhIUDZBck5xNnpJcXVnTTFFckNmcWltUTJYOC8y?=
 =?utf-8?B?VDg1V2JPb3pibnBUMnBDNWZ3S3BGVmR2ZDhvenZVb1B3bEdDMGRYZWJEOGFQ?=
 =?utf-8?B?bkZuTWhwR3hLRXk5TGRIU280YTBwckNzYTh6cis4cU1RMzNBMW92NXB4dSs1?=
 =?utf-8?B?T3lqVjFaTjVmK3ozdHppTHplMFdIYlNvdlRTanVzM0U3WWw5SzYycXFVZU9D?=
 =?utf-8?B?SWx3ZHRtYXMxWUxSVlhsd2dzRldadXhLWURDSDhjR1g2MXpHRVdXVGo4OXlO?=
 =?utf-8?B?S0pRajFiWkRseTAwYUdNZHJ1dXpaaDRVWTVVSUxTL1o3bXE2ckZPK21HOTYw?=
 =?utf-8?B?RFhtSFRwUko3N0RhSWIyaDB4bHIzcm56TkZJczZBcVBFbVJ6azFTMFlPcnJm?=
 =?utf-8?B?VFJYc0VjVUdSb1VXYzQ3SlNGQi9OVFRaWTFlMktNczNya1ZxS0lLeTF4cEFv?=
 =?utf-8?B?Z08zWE9pandlMkdIWEMzVGdhVWFWcHVEdmZwRENyQVZKb213QmZoZUhINEZ6?=
 =?utf-8?B?L1paUVk3R0tOV1ozUFU4V01wdlZaOUxLUlB1dDNWMmdhZnBBdFJQNmQxZmJC?=
 =?utf-8?B?dE5QcWNyMFRYb2MwQzVqdEhNT2JYcENnMy8vMFM2UUIrSytETGd1d1EzUXBF?=
 =?utf-8?Q?3RWvOerYHRQs3EJsYFni+b6WN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e97e6-5014-40f1-3938-08dc82f93a21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 11:43:31.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LN6vVxWjvf61naWGchQ6zJD6NqcVUF1v/4cvyuN7MPzHE5ACUeNqfD9I7OOOcYQM+YHEe6eGM0JnqEAWryDYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039

Hi Sagi,

On 02/06/2024 11:53, Sagi Grimberg wrote:
>
>
> On 02/06/2024 11:19, Leon Romanovsky wrote:
>> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>>> ib_drain_qp does not do drain a shared recv queue (because it is
>>> shared). However in the absence of any guarantees that the recv
>>> completions were consumed, the ulp can reference these completions
>>> after draining the qp and freeing its associated resources, which
>>> is a uaf [1].
>>>
>>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>>> once the qp moved to error state, we reap the recv_cq once in
>>> order to prevent consumption of recv completions after the drain.
>>>
>>> [1]:
>>> -- 
>>> [199856.569999] Unable to handle kernel paging request at virtual 
>>> address 002248778adfd6d0
>>> <....>
>>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>>> <....>
>>> [199856.827281] Call trace:
>>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>>> [199856.860587]  process_one_work+0x1ec/0x4a0
>>> [199856.864694]  worker_thread+0x48/0x490
>>> [199856.868453]  kthread+0x158/0x160
>>> [199856.871779]  ret_from_fork+0x10/0x18
>>> -- 
>>>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>> Note this patch is not yet tested, but sending it for visibility and
>>> early feedback. While nothing prevents ib_drain_cq to process a cq
>>> directly (even if it has another context) I am not convinced if all
>>> the upper layers don't have any assumptions about a single context
>>> consuming the cq, even if it is while it is drained. It is also
>>> possible to to add ib_reap_cq that fences the cq poll context before
>>> reaping the cq, but this may have other side-effects.
>> Did you have a chance to test this patch?
>> I looked at the code and it seems to be correct change, but I also don't
>> know about all ULP assumptions.
>
> Not yet...
>
> One thing that is problematic with this patch though is that there is no
> stopping condition to the direct poll. So if the CQ is shared among a 
> number of
> qps (and srq's), nothing prevents the polling from consume completions 
> forever...
>
> So we probably need it to be:
> -- 
> diff --git a/drivers/infiniband/core/verbs.c 
> b/drivers/infiniband/core/verbs.c
> index 580e9019e96a..f411fef35938 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
>                  * guarantees that the ulp will free resources and 
> only then
>                  * consume the recv completion.
>                  */
> -               ib_process_cq_direct(qp->recv_cq, -1);
> +               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);

I tried to fix the problem few years ago in [1] but eventually the 
patchset was not accepted.

We should probably try to improve the original series (using cq->cqe 
instead of -1 for example) and upstream it.

[1] 
https://lore.kernel.org/all/1516197178-26493-1-git-send-email-maxg@mellanox.com/

> }
>  }
>  EXPORT_SYMBOL(ib_drain_qp);
> -- 
>
> While this can also be an overkill, because a shared CQ can be 
> considerably
> larger the the QP size. But at least it is finite.

