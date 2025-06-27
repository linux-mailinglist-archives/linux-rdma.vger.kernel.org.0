Return-Path: <linux-rdma+bounces-11718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B2AEB3BF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 12:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3874C17396E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9DA296152;
	Fri, 27 Jun 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O84Zivax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225A14A82;
	Fri, 27 Jun 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018789; cv=fail; b=T4Lydbimnx9MR2i5muDm+3WErybG/KCMpbabYpYHcDvdlMlbYgKzmrLzV4L7cc6WEeh9m+PX3/DVSPpDn28N7X1JxNYKO/yPN4HTJQg2+9YlnVRn9YeHw1gbnh3EX4QE/I8DqQ+yENiA2Qwk89qB5nd6T9ZQ3evjuh4nY9jUTcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018789; c=relaxed/simple;
	bh=UJ/Oqmx3Go3wWshC+lfG6XNZsX7NHVCHncmtrS2gmj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeRa38GSluJRXgRQpkoQZa6ua1Jqp6fouTp551Clmjval8adPvlYIpEtZ2bkZ/DElXyf2uzplDUzpnvA2N0/RXMPL6mmfyjade1/mv7lbb7d3+lTxDWg+Py4zrBSQWXs83RlFoHwrQ3b5zmI/qJ9eeZUpTxDNQd1Pk9YFkyEBOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O84Zivax; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnZTxHF+ARWOjgx7fgDuUUlDZalmyEQaBFUdPPtb32/9dnZsyuNZ3YRzV0tqLBt86bkdjkokrXI2WtmJK/+4IEPdy9uIkHoUtJPSwmCUPu+w+pj/lu+Cg94/redTVtPnMw7kTE4pWT13CtnNMArrzn4MMgRiRvUO7HRUO10Y2J2y2d98YtKpIAAtoBtJ5YG0iP88xjsiZ5fPVw68+suZJomn9DswCwaT70G/xlaOo2x49J26GUPCJzyCaYkDucz9577t3bvNs8Iqk00QgLkoC5SPbpzcC6xa5J27JIGTre1P5VznA26q9nWIUGi2o/tBY3NjjPZau0hVaRBmqwhzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ/Oqmx3Go3wWshC+lfG6XNZsX7NHVCHncmtrS2gmj4=;
 b=BgZs9rRHmQYM5xP9WV3iMAHn3CEK2PZ80BEiTL2l2DWQHPE5ip24UnLyjDP3d5+oFWOSQIxBbPqbDBSE3Kv5e0MppCEgTd9lnSaJwpyhtMjxPAKtR4VUBCLWCxA87ehK7wzvCI7ncuydLYDf8pMXIcBtszL43V79LTNgZnkcfi46lWPR1vC93NDCwguh2BV8t7645BYSq8xci52HdUnNDbvoy4ypMckeRT6nX/E83a4n3S53Ir/UufBCzJccRVhijE0BkXk7gwbS+27CurHU5IgFTG1BuCQ9Uw8DLYfuejwVoRGNzj5S+pMmlldJHtbNTELNIQb8msrfCfoyJ5rpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ/Oqmx3Go3wWshC+lfG6XNZsX7NHVCHncmtrS2gmj4=;
 b=O84Zivax6IE/L6dB9QcREg0k8CKSQlAOemRPIWLAo6e9fu+Jdb1/J5AIRKetz/UMhEP1FmdrhHEVK5slVEvh3BAK6w6COckIcMu80UaEmmOd0e2EjHNZE/gauplVYwEYJ6+aAdJVcgVRvAce+044Jl2n6ZDZgc9cLMMf+vOWR78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 10:06:24 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 10:06:24 +0000
Message-ID: <68b70504-b9dc-4997-96fe-0ae0e6b7a205@amd.com>
Date: Fri, 27 Jun 2025 15:36:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 00/14] Introduce AMD Pensando RDMA driver
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250626070748.GH17401@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250626070748.GH17401@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::13) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 400ff8c1-da41-47dc-074f-08ddb56245e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkxCM2FsNnUrdGtuMU1CMUdqeSsxaGRoS0syc2EzUmpVTGpzZkJCa0dUbzlR?=
 =?utf-8?B?QkZ4bmlsdTZZZzRKN0VFYnRVZS9vQUNDVUpBWjdmUjFLdnRyeWVFQStIb21O?=
 =?utf-8?B?bURPVDFZM3dnWmNJL0F3VDE0UVdVYVAwQkRJUWQ5REtFTlNoalk1QXFzYmZ5?=
 =?utf-8?B?REVwTWh2OUlBT0FsM0hGSlMyVk94QU9kZXpWMkF3QmllZmRPa0xLcURZWHNF?=
 =?utf-8?B?ekpPYlNSbUhQbjlUbnFLSjY1bTI0cDZnZGhsVERWaklPc25MTldVYkR4dHgr?=
 =?utf-8?B?eThTSXB1cmJVMmlZZmdVZm4wTGttK0cxVFc3QnJjUzBqdW1aZWIvVDZTcmRj?=
 =?utf-8?B?RFFNYU9rQk5CK2JuZ00vKzNmRm5TZnFvbGtaU1Rza3FLeE8vT0NZNDBvQW8w?=
 =?utf-8?B?cnJqVGcwMk1qVUdTejlNN21CZkhzLzJ3cXpVekpqU1NGaTdaV3hZTSt3cXZq?=
 =?utf-8?B?QjZCY0JtTXh1cEJiUi94OUxyOXVrUkYrYi9BdTl2Zy9GYzhlU0VETWxjNHRU?=
 =?utf-8?B?QWY5bmVyQ295QlZ2NG1jVFJMWVUyNlhEWHpVVSs2WlNZckl4bi84eStDQmFj?=
 =?utf-8?B?Z0J4M3IxYjV3U0ZLZW1uMi9mTVIrUmJWbDVqMHFuaW11MTIxOVZTWG4rOEox?=
 =?utf-8?B?RzM5ckFUMmk0aTN1OXVEdVQyY283RE9hWkcrMnNMSmVQbG84UjZpb2ZjSkVT?=
 =?utf-8?B?MFVkd0p5VE01M0lxeDBBM1Y3V21MR2dIc1pDUnVFdHJBeWJQRHVrTmwxbHFP?=
 =?utf-8?B?MzZ4aWlEL3ZiYmZKMW1mQnQvUktmaEdhdEJCQzZTOUJqeDRPUDVYOHJ0cWlM?=
 =?utf-8?B?a0V2MVJxeTVma2VxSisxcXppRGkvZ2ppQlZUL3VHVzA3RmNjVzFRb2tzSWE2?=
 =?utf-8?B?NnplNUljT09kVmJOTFNlc1QxbENLS0N5eTVHUjNWSjlCOGhTNmZLTUNqQzhy?=
 =?utf-8?B?WnMrY3h5N2VhNUFaK2MwZW8wbmplVzBuUlc3a2FSeFJ3bUN0ZGNiaTZkV29E?=
 =?utf-8?B?cnVrRlo5YStXQnA1RE5vaDFSYy8xaC9IaG53T2FKR3l5Q3BjR1hLUWlkR1dj?=
 =?utf-8?B?dWtuNnE5ZlJ1N3ZJM2tvZjN4b0J0cjZmRDYrOTdleEQvSExXUy8vdGw3d2Rk?=
 =?utf-8?B?aUJhK0l6enVBWHUzMEM5SmpIamM4L1BQdHB1a3BxRHNnMG9abnR0ZFl0YjVm?=
 =?utf-8?B?Q0JyRmY1UElONnRUMTNqVCtLTkRWeWJSMDE0TEMvMW5yYVhBdS9RSTA5aGw1?=
 =?utf-8?B?RGUzWmFwOERDTG9EVXl5NTlaNXpZM2QwMENEVmZkY2lmTXNBTndwZnpkOWts?=
 =?utf-8?B?SUZRZlRCZE40NzlGcStlZmpCbHJhQ0lwSjRVUmd6bjFwVVFRZUsvR3c4UWg0?=
 =?utf-8?B?L3I1b1kyQzNYMG5mQUc0Q0hOTldKS0JPU0syRlcwSDVhSTlJeVFPazZhNkhQ?=
 =?utf-8?B?U3JDUGgweStkeXVpM21Hd3FSV1FLTUdIYXQvcnJXSXhOSE5lZWJxVUpwQ3JH?=
 =?utf-8?B?bE5uMk1Tei9NUTk4QjNJTko4TnBGQitTcnBmRXFNVWJnVTl0aVErNzlaWmVS?=
 =?utf-8?B?d0lGemJjckp2M3htdzNNb2U2dGxiRlBMSEc4emVkUUtrM1hEUXFiV0NPT1pp?=
 =?utf-8?B?Njl0T01KUUlCbmY1Z2VBcS90eTNFU2FyQWJ3QjJuYVFkeVNOK1ljNXlyaFNs?=
 =?utf-8?B?REUrbTRPTytyQ0pLR3ZWWlAvKzdxQ202dXRpVTJFU3d0cmx2Nnh4Ym1sUjZB?=
 =?utf-8?B?MytsZ1M0UlJkODJsNTl5NEJGcTlkaTVmdVZTaS9mNXg5SS9JY3hJZWZwREtk?=
 =?utf-8?B?VGk5WXZwTk83eGVFMkNXdkVTcHk2T29waEFLeXNqLzRUcm5VY2Q0NXF0aXBD?=
 =?utf-8?B?ODF3N1FpYkZWTGg1NnhhMGY5VHdjOVhVdzNWcHBBQ1MzS2ZmeFVCUVdoamtJ?=
 =?utf-8?Q?YfOlgu2JJD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERhN2xNWEc2YUtsTmZzemJtWU9VVFJoWGVBUElqMUIxSm15eHBQUWpJbnll?=
 =?utf-8?B?OXFPYnlQdmcyZzF3bWdPanBwNEdwTDRmS1ZQT0dhdHoybml6SU9URFYrc2oy?=
 =?utf-8?B?MHhRWUl2YkpGekFjVGFORjlJZndVVEtldksxUldPUktNR3FDTnJwQ05zVUk1?=
 =?utf-8?B?QnNXU2pkYVJBODd5Rk5VU2ZGeEVOQ3o1WFNHMUZnVWIxSFdjck1NbG9pWHl6?=
 =?utf-8?B?QWp6Uk8wc2JFZ083M21QYjdZRnlZS2JqeVdWRGZiczQrTlliV0dHRGQ4c05i?=
 =?utf-8?B?UE1xOTVudGwrM0VZZzBaa25UQW5OaDlDSFQ2ZEU5UjI0RmlidDgyLzBYdmFO?=
 =?utf-8?B?OGNyNTdZaGc2dnR6OVlTakZXRGZVN2xoa2pCM3VDdmxGMVJldXdVUjFjeWV2?=
 =?utf-8?B?NmZvdUcvRjJiTHZXYXBicDNLUGFHQ0s3RGcybTBPb2pQNWJXbUg5OHo0MytP?=
 =?utf-8?B?NnhxcGJZUzh3N0prdGZVcXJFYzBUVkFDcm5qQmwxVVllOVpzL3ZLSjk0dzdl?=
 =?utf-8?B?NHhwUm13enB5VzVvd2dReVN3N2U2SEZLa0xZN0xkak1Ba2k1dStOdGVzUm9n?=
 =?utf-8?B?OFRxN2wvVjR3NG9NSk5OdTlwaTE2M2pIbDBOTlJQbTZ6VWhHVzhod213UGVZ?=
 =?utf-8?B?Y25TUk4rYlRlalJmMExycitmeFFMZ2lNeEsrcGxOYXFuUXBaNnpZQXM3NEI3?=
 =?utf-8?B?R2FrY0FPRjRRRGJ0L1haZEVjZlVhY21ITEQyMFRId2tqV1lQWWszZWpVZU5P?=
 =?utf-8?B?WnBTZnFEU1ZubFBFMDI0SXV6RUFLOGV1Rk5jSFlKWklaQ2xXSGxTWXA4c0Mw?=
 =?utf-8?B?dFEzWFZZOCtwbDNVNEthdzFhdDN4b1FoNHY0UXV6b2tUbWt0REMzT1hBSDRI?=
 =?utf-8?B?OWFzODMwbkk4ODlYbGRJRzVTUkxYQm9zeW9WMTJWRlhPNWZ6bmd1cUxUQU9C?=
 =?utf-8?B?ZGtsQUt4TDlzYVNHZU9jTy84VVBna2h4bmNLcmFSMnBjRERWaHI0bi91SWoy?=
 =?utf-8?B?Ky9Qd3hBUGsvTHJpRDRqaXgzRkVRT1dTV2kxYUNKeVQ3YzBnZTZDdk9wcmda?=
 =?utf-8?B?KzBCVUw4YndvNjAyRjRYaWVyektrUTZLOVJGdDU5WldySEx5RHN2ZXVxbkRt?=
 =?utf-8?B?YUdPdG9wRWsyeGFneVhtTTdqY2Q3KzVUR2s3ckZ3WDkxQjI1SnE2TFBYdjk5?=
 =?utf-8?B?YVlLRkJ6RmNnQXlsam41OTM0UVZYeloyN1F5d3FWa0xZUjVTQUZVb1ZDcnZZ?=
 =?utf-8?B?b2taU21pODhhSGVDOHFJc2hra3VZcTl1N3NVSUpHckdqYWtHbmZiNzMzV01Y?=
 =?utf-8?B?Q3J4TDc4WjQwY2V5Z1ZUU25CcElVbzc4elJKaWtMZGJ0bWNnZFlzRmhtM3Rr?=
 =?utf-8?B?QTd2ZmRkS1U5YVp1aThwL1NId2JEaUhzNWQ0bUoveEpmTVA1ckx6WFZoQmJi?=
 =?utf-8?B?YlpoUFJZeDVHWHhmblArVGNpRlkzaUo5d2E3UjVJcXltall1ajFYVmhDYm1Z?=
 =?utf-8?B?aCtrOGEvOFNjdnRVWm5YQ2pQdXoveEsyQlZvSnpUMTR6RU11TTAyNmtmNk4y?=
 =?utf-8?B?QjhxNnFoWDdMWFkvM1NDQzhwYjZJeGlqbTNvUE95OFUvU01pcTU3UmZsRmRk?=
 =?utf-8?B?TjNpcnIwZXhZZGM1MkFSUk5YcUJZT2xhZjJkeWZnbWpCTE5ERU5QRkIyYWNm?=
 =?utf-8?B?L003d2Q4RUpVdVFSWmhpaEczUzhkeSswdzhXMjl1K1pYQVdubnFrekNBbUJs?=
 =?utf-8?B?YkZmR0hqTmdTd21uYmc2VDA3S3Z2bGF0dkR5MTlzQ3oyUkdVMDVaamRFUk9i?=
 =?utf-8?B?VDhGUTYxZk8vdmZpSGI5cDNzWHZYL3BqNDA3aEZhd2JEVGx5SEs3NjZDUlMz?=
 =?utf-8?B?cW8xSU1oK3YwT2k1NFVUd1FreUJOdk9QeE5Lc0xYeWZFM0JxbElrcXpsd1Jq?=
 =?utf-8?B?SHZOZkZpNVdaM1FWN3pQd1BkNElNTFBJdTlGUUJvcTc5UnFTNEpzN1kxeGM3?=
 =?utf-8?B?VVM1OXRXSHJMVU9CME5NU3JSMVdvWFJveUw2eUlOaUxqOXFkK0tNOHdTK2RV?=
 =?utf-8?B?YXZRdm42SkRBdlovV2diWmpCV2lCMnNGdmtUdTVtMldoMU1mU3dsOEVBdnl1?=
 =?utf-8?Q?dCaQAEucbmOsPi2iwRQIhFZ26?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400ff8c1-da41-47dc-074f-08ddb56245e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 10:06:24.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJo+OWxoxG8RulJMn9QARZvkCJHRAr2vWgVh7e81y6wZzZ/aDBq0o05uZ7sbAr+C2aZe/qTallVXWUCcKzqAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019


On 6/26/25 12:37, Leon Romanovsky wrote:
> On Tue, Jun 24, 2025 at 05:43:01PM +0530, Abhijit Gangurde wrote:
>> This patchset introduces an RDMA driver for the AMD Pensando adapter.
> Please send PR with user-space part for this driver.
> https://github.com/linux-rdma/rdma-core/pulls
>
> Thanks

I have raised a PR https://github.com/linux-rdma/rdma-core/pull/1620

Thanks,
Abhijit


