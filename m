Return-Path: <linux-rdma+bounces-21418-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILKJF/TzF2q5WAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21418-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 09:51:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 168025EDFB1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43267314D067
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451835202D;
	Thu, 28 May 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wuV2tRdp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F03502A8;
	Thu, 28 May 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954398; cv=fail; b=jj2eK+OagFg6fN2BmdO5EF8k4ZKEMgTTOoHquTH5j1+/hF7inaJeA4ns4rrrcCbNH0Hmz0bGddar0DvDtpe8MIdmFdy+enc1pVyC6HEDVH+rSfpC2v1W+CDJucSpan/1m/y8pM12AeArDwY825+i4lZTxB9xV/MFF4b2NtWphYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954398; c=relaxed/simple;
	bh=YoCmMSStYE6UgmmHGNBOCAuy1+y6c+u0V7hI0VY2t2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S49I/2YXlvCfjUiyA1dYWNe8cQpCXph2NDEzlmfEGdMpJ4cDHXN+QGbSZreJE8ikKY/oLxAVMVOBIdoYVygnMqvcbXcS7LBx9ECixGLOPgiswqjqKgsuqaKi8W2hhiA5dSjhEPNySCxpSi1SFxAL+plIqgGbeTu4wLV1IAi7HJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wuV2tRdp; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4n07kDK1YHSRnthQf7iiOjMPajqbbgd5bIqcHbl+kjY1p2poRFZTVywVBsXThDGkr8JcmcgBCI8iIlOQ4i48YfteMPSFm8lNwARr1f9HmFrB7eagYJLWWRWDs3Yv6t2NpAZF/GiPc9PCeXAM0q8Psjw5DWJIXYtUy6kv/azS4j28QnvPy17Ly9ZLt7efFZb+UrBXsibQTKcJXeNp2SeqDmK5U6yTzWOmoRJ/32Yd4F+NxdNhnjDxQRUxopKKEpG59x+Ns477G7F61q0yzxrFFjQpkha5ZxykzYzmZKqCzVjQ4ZsNeSa8WgVRRt0ztJ7YH1J0YXsGjAw+j0gBUOCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNyy9nGJwnTLxOCmqZvcZQYIcHUCzZlZkRYy3B+/3Wk=;
 b=iFRjOU4m0Zll8gy6wXbXRZTN2yQmjyusN7t4bO4pqFkDbErs4ZuKpCad8dyRmj7q/BqoMUUzK1xA7hRIxKzDNyF/YUIla4tIvKBQFAkzI3DIjWrg1rUcV1Hb0GtzTp3ZviJ1YNMrtrFS0w1M11C1N4KUJcTxeNe5uFRHdcM4ZaKNE7ZpJ+FBLkksPVsF30SXx6K4AjSaelNofOlBb1KChFP6eSgZsYPlKcpbzn7NvWX+QxSM5x9DGkwJvp6FSzsO9BHbmcYhINeuZ2H2TMcHBrbqrnzLGP+j/zf7hMLUpUitc3g/21TtPqWneBBc6T7AkVejBaHd/r4Be15O29j4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNyy9nGJwnTLxOCmqZvcZQYIcHUCzZlZkRYy3B+/3Wk=;
 b=wuV2tRdpksL32EcNyok321lTxTRWQyJhVb9lhlJzEmWERGTP30bXk6+w4b2kXajMoKPFMmwUNX2u/wHHNNdKemmPkW0RBEaU++SRsdoA6EKD7p7812olUiTLY8phFkKyEQ0IYiPtop9lyZNCnG1+YgjkRBGVS4ycbPjETn9m8bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 07:46:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:46:34 +0000
Message-ID: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
Date: Thu, 28 May 2026 09:46:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 276a91b0-997a-4abb-c353-08debc8d3d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|6133799003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Q9FXqnjI9/mCngo2YBuDkS95MHKegrllR0FOJ7y5AaBlhz0gEsalBBfK8I9Dq1ZpEB6+iwYeOFp8aEilvT9MLI2+7YGwrkk66hW+a200Cfg8YZCWkHPkE+4WqWI0MJ9dmneBnI4wEMdE47ZRVPraMQXMYtRZOOxsLch+PN3vrWsIhpNXlFV+2GAzncekMe+xdkopu0iDRrmQgn+tWeZyWmSpxU4CGJzsDCx8D2LhzcxE2RtsNi3GkrVa/VSLV4tZgkhd4BpKHMPEYs+XsbFLI5hHrC2d6QrwMtrbrQV8si/cqks5D5SqDbWZkYqpwjMcWYhfhr0aFvLEx3tQwuxit9AIg4jtOfkKKx+zhl1fP1WSJj/QeOhYWQnN+c/AeS5Tvq9lfxMMDbjEr41ZXskhORrv2Nk0r2u4ONxXpJDMirU3j14p85zkMZOXWwuA63/2m1kI0PSgHaGSb8Chizey5i8FYtq0daeYOisobtecIYoYBlMbbnEKD9l3kIkK+5TdwD3v/4PxUquqOBWv0gV+BYWtiFFaxGzdJACJB00KWqewg/ghmQD1KI87kk1sW8lL38qIDeRmzycogD+XEIabQEa/mJJYPF6mmJ0GDaxfJqJSntpw3ReTBYqC6xErZJWxzCH1+Qh9T/YV+lisrTYfuIJpkXiRt+I00AR/NrdUtQRJHbA48gXSpoaAAOz8fSUy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(6133799003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZpZ01VQXFyWE1HbWxCcFRTMXYzTkFvNG5HOEhNT1k1b21iWnBYekRva2xP?=
 =?utf-8?B?cGY1MlozUUVSN1RnME53RzdZdmFrSnNrblZUaTVTVHozVlFUZ21rUkFqZERp?=
 =?utf-8?B?TW52VVhoYTNLNjBYNXdEMzFWMytraWpjY0xOd2tqb2pyQndjeGh6T1ZCb0po?=
 =?utf-8?B?V1dqN2hrb1JoWWtydGJZUS9RQUxFeFEwU25OUytQVThZK0p0RVArL1RZUHdQ?=
 =?utf-8?B?azQzdnYwd0Z2MEM1WGtSWll6SExnWW94SWFuRzZZVDZIRk9WNUdrU2h2M1Er?=
 =?utf-8?B?eUhXMFFQSUJVU0xUS0xIOXFlVVVsbmJESG1yZXBpalB1ZzNoR1BxTnlUYjcy?=
 =?utf-8?B?czZNTC9YajJwUjFsSWd1cWFjQVpMNk1sOVdkbHpkN3lEUGZ3U001ZlR6ZWN1?=
 =?utf-8?B?TlBpT2NzRkdvRzBtUnlUWDNUR1lITWpqRE9VV2Y2bXIxTHJmMW5xcmk1Ynpq?=
 =?utf-8?B?dTVRZ0d2SXJVWk1kRG5hUk5rV09sK3dxZWhTMzJRNDIrbUw1RTNOcS80a2Fu?=
 =?utf-8?B?UFFNczdVSzUyb1F0T0crcVNKd3NvVlU4NnNLN0lsK0dUSVZxOVlMMTIrWjV0?=
 =?utf-8?B?NzJjU1B1dk90dlEvQktEN1A4Yzh5bVZRcTRRUC9KbmZhYWFLUjJOTlFSUE16?=
 =?utf-8?B?eU5VZDJKKzJqUWE3bG13czVjRHlvaUZOS05hb0pUUGh2clhmT3hPSzNUSFI4?=
 =?utf-8?B?K21UVEhlUVE5Tk9oeXAvMDdhV24rQmpneDc4R1FKVXZ6Wi9QT0lLZFcvT0FX?=
 =?utf-8?B?ZVQyTXRmNU1rZEh2R0ZXUUV5T1RXWDJhVlBScHRjWnFwcGhrNXBMd3NGN1JW?=
 =?utf-8?B?dFdJNTdJSXBZZ05GbEFqWFVpQUZncjA3dWRQekNXRThSY2txV01ocHlmYkk1?=
 =?utf-8?B?cEhOQ0JONEVHMlVYbWRyRzYyRk1LSVdyWVJmT0wzYjJOZjFMZXE1Zm9jdi9T?=
 =?utf-8?B?c05Da1lidEY2ZkVvZ2luTFVmVjVBeEFrRVU3bklMVjJJTGpCNVdxMVU2T0hB?=
 =?utf-8?B?YmhmNWxSYTd3SkhZTmdWNncyYUU5WmdrK1dMYTFybUhIZDdrQ3RSbXUxU2pQ?=
 =?utf-8?B?M2Y0RjJwandFeWszQXBCRkphc1h4RlRPZFZINTlLek1NUnFieGpldzNxMnpv?=
 =?utf-8?B?MEEyWEpDenNZWHROZE5oU3dIRXRKU3hSREs5T2dlUVpnb05SaXVhcWVPblV3?=
 =?utf-8?B?eHVBaG9HclZ4TDAzVkNldlNqYnZndkpGWjhxQkRqMGNuVTVGRVljUEVFQ1JC?=
 =?utf-8?B?d1J3ek5nUE1VYm4yN3JEMGxiWkdMakpreXI2UmNINDd1UDdqSzJXNWRzM0sy?=
 =?utf-8?B?ck5jSzdXdFBUdDV2Tk01T3hlYXErd1lZN09VRFd3akkvVXlBSklnQ2ZDK3Zy?=
 =?utf-8?B?bThXYWE2WkdmelFVLzB1SFlMTnU2V1V5WTgxUnlYWXVKcEt0WGd6MlY5T2VK?=
 =?utf-8?B?T2dPSUpnUlRZM0F5NDQ0V0ZhSUhJVCtUWGpkUDJxZkhncDVCVnFxbjhnNmtQ?=
 =?utf-8?B?ZXAwUDlVZmpUaW95cXE5a0ZOUDY3U0NwdnFSeUFNVzFqcDk0UXVtZUVweXli?=
 =?utf-8?B?bkJQUGwrQVJKYWt5YW92V1l0OXkzS25Bb2N1WEZocUY0V0hkUWgyaFdYYlI2?=
 =?utf-8?B?M1lJMnFLdWI4RFZxcTJLcnJtcXA1SFpaRUdMSzNmeXdiZUZVUnBqWlZDWExL?=
 =?utf-8?B?cml0TVh0bzNSbHBzQjd2VnoyQmNsUm1iNEIzbUFwdTFMWm9jS0oxTVpwZ2F4?=
 =?utf-8?B?MWRhR2E0RkVPZFFlS1FSaW9yNDBRRStGMzU2Q2hyK0ZWS0x4N3VjZVlsbHNY?=
 =?utf-8?B?WFRQWXczUGRuVVVhUmlTR214S2JsR3FZVExvRWQxTUVRdlowYTZRUHpHTVgz?=
 =?utf-8?B?QlRnMlFQNDA5S1JjN3RGM1NHeUx6aWMzVGp5OUROVU81V0hub1ZhajVMdTQv?=
 =?utf-8?B?dTJVZGJGNzRlSnhCb2EvenJRaFpjOFRtdjJnditJZTZ0UnQvcHRmcXZjVC9t?=
 =?utf-8?B?YzdicEhtODUzVlVNT2pFUGluaVpGZlRHSDBRUlhxZStzVlhyTFZkSjNZY0Z4?=
 =?utf-8?B?TmN1MVo2QWdzOW9OT1Joc0RBNytoQ1JiSHdaL3BENUt3czZ5em0zZDhoTGZ5?=
 =?utf-8?B?VW1IeFRTbklqRmFuWEpTUkJ2UTdkZnZpcUdmVEY3b2hxdjlQSDFOK1JUYlhZ?=
 =?utf-8?B?ZDk3UmlwWVEvN1piVGdHUEtiOVBkUkZjSStoaU1zdllDNktQL2kxaTdESS9k?=
 =?utf-8?B?Nm5aQ0VoM05Ham8reVZjTkFvYjdDQjZOd0dQTWVERmN3d1o0d3pRSWhYNkk5?=
 =?utf-8?Q?gNMNA5RwOyl/ClfGur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a91b0-997a-4abb-c353-08debc8d3d6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:46:34.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HULpsEeKgpt0luu7NFNfSXr8giO94Cs0zpLnPNYLilINSgRhSBCsJ6EFC/B7E7XL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21418-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 168025EDFB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 06:55, Zhiping Zhang wrote:
> On Wed, May 27, 2026 at 5:53 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>>
>> On 5/27/26 14:36, Jason Gunthorpe wrote:
>>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:
>>>
>>>> Yeah that's a good point, I should probably rephrase the question.
>>>>
>>>> I'm aware of how TPH works by adding the extra ST to the TLP.
>>>>
>>>> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?
>>>
>>> TBH I've never heard Meta explain what their device is doing with
>>> it. At least it seems to be super important to their device..
>>
>> Yeah I think at least a brief description of what is going on here would be necessary for the review.
>>
>> Otherwise we have only the info that the exporter wants to give an opaque ST for the importer to use and no technical description what that is good for, how to test it etc...
>>
>> Regards,
>> Christian.
>>
>>>
>>> Jason
>>
> 
> Fair point — I'll add a couple of paragraphs to the v6 cover letter and the
> patch's changelog as well.
> 
> The short version: in this series the vfio-pci device is the completer
> of the P2P
> writes and mlx5 is the requester. As Jason noted, ST semantics on the completer
> are implementation-defined, so only the driver that owns the completer (here,
> vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
> importer treats it as opaque and just places it on the TLP.

Yeah but that is not really sufficient to justify a driver 2 driver interface.

Which PF driver is backing the vfio-pci and what effect does sending TLPs with ST to it compared to TLPs without an ST?

Regards,
Christian.

> Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
>  end-to-end P2P workload yields only expected results.
> 
> Thanks,
> Zhiping


