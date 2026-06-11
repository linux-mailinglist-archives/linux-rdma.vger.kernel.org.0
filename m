Return-Path: <linux-rdma+bounces-22104-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y9FWM5yPKmqgsQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22104-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:36:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4257E670E44
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=du5SiPXU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22104-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22104-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC54530498F7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 10:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFB3D47A1;
	Thu, 11 Jun 2026 10:35:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C543A1E80;
	Thu, 11 Jun 2026 10:35:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174159; cv=fail; b=sbo3UC29GcO/m/VHfnpnQ837M4X2EMXyiLIy6ePl2wDwtbGNYYGRqHc58qZeLZZmlU79Q8E0UKKsJvCJEawWvSldBEKSe35qTZKL/zRyloC2JXj8OUV64LjksCR7kccKRyB9Q7NPGcqmAKMFicNgMMQs91ozrHODrSN40oDkFSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174159; c=relaxed/simple;
	bh=0k4RvdjTPOwFZvub55agDgnL5ObACJy4CeYWb8BedQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uHFjb80myPuCJ07fotOTJFsecJtgiRj1061SEAXSa1j6M+INniYi5O4MY9Cmp0gvK0U6Ygf3EjFtKujGsDU+erFkjPUV//ZcIZUe5N4nLxxP4KsIzOuIZbaZ7M/EShzD1Z/eGHSB1Ai46TFD0TxhMbHAjuvPiHpo1B3Xj3R6xS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=du5SiPXU; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjfoZ6aHN4TXHsKLLsTZt4fBTlbsgLUV7hLXZacKoFeeLjOlESfhNmU2PgeOWqDtM1Rf0DQmMiSc5r9xMdeUyXXlB11hVe5w1vVBNf+EP5hYlXTQv9wkqkYHcqxfFcZPUrnMSOdTVAqHJ4Zry5uzJGzMMy2CLAmJTWbpLmWam0KIcybjAIhCkdlD8+SKM+acDjfWdkSTXgC87pVYo4BX9eZn7ZHI7mqMCbSltWre1msTBg5/BHqKhmNszT4KbIJNcOW+NdpgF44PV3Hkowyyb2XCQ9MGe13U69Taxcvxl/j+5f9d//2VLdbcOX/PmL7s5WCh1av567MqzFxcNaGG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAcwaZj8eHwJstMvuUB/CMAzs+/rEsyPNb4Y/wauwsk=;
 b=xF+DWrfgRgYISrgPuUdMhBmHpQU/cgpLosrsDbgeB4R62xrBjgf5bHudqk8z/VHDEZ4r6Bjo/8fLbSUBAa27sTAE2vWItub+/F+xHjFfmXPkiolLeLpvd7onmKxQsEh+TFnnf7RWEtWgeBvgEiOAcOPLv8qjNnAXioerWwhnYEIiV+PxQ/Zte+NaylOpHZJhDnoZTCvjAK6yRBACpH7oV6zsjipNFkrI0mF2JcatdOaXhGa/YDlqKgwGKvHaH81aab0iSctyDtEAVX+IOt0gG0zm+uF/+MoEuiaJbhcBp6H4hS5ZznfOQ4NqCELgMIA8b+SEItZo5kF/56Kz8wgrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAcwaZj8eHwJstMvuUB/CMAzs+/rEsyPNb4Y/wauwsk=;
 b=du5SiPXUj2teAdieutjAtgUxLsTrkzzraQoc5lM0DcpTwtpB1zXjmqcgPyg7lU3WszUa1EUBJFBfhrpv0L0apI23uThIC3K8Mm0RNxv4bStuU9NqE+bPxFm+J0X2bfAd1Cuw/qEyAorVQP4RMVHUJp/ksmU8upAHRUN4/09SvG8=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:35:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 10:35:53 +0000
Message-ID: <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
Date: Thu, 11 Jun 2026 12:35:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-4-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610193158.2614209-4-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f989fe-ddc8-423a-01b8-08dec7a536c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+x0kA/gHuFdlIPcikkLk0qgue38taE9uCNY0fdiWDONgoj9Dvbb4F2sAKXURavSoDhr7hQWi9+fwXqr9/MHaWXYawJochstu0hKjG6nCzqJRFs3hnHPkCrkVEfKzVGgPvpbHU/orXBLFf1ZsKxhAvlN2/V0Knf/qDTAeIHFdSDBPi5L5M6HfpxtVOC3bPMm6H8yxo4DrYiHqSJKRqmT/r0WUcoTcVTkvV+4CYouJ40dsutiY/sHDXTXKS2YGt1RbFf4pSOH/7yAqVfflkTueoRN7k+7uR822tlg2qyGDxoF8JMqG3wgQijlnPOSnQGeBSTUaFGDHq4bAYaVwuoC0OgtQDLrD0kzH4tesvjB7MIl1pXcXB64aylJK1ub0dvJ8+lyRzUpz0tbbIT6H7+R1Vg56hwc+veaf4VgnImnJauLkp5vc2iBSUoMNPXMrAY4tFFlS6fnafS1JoiXyYMIlyWumuV2ULjkr23UdnBTmCQWhfsL/+j2W3GT9jaOsbQH+apFa9SLIxhTF7K19plbhy/4+4K/W12+9dKTNRukqlAa5/qhKSLu4ONwhJ5ec+SbVvWG5+9BNy/Jz6GVSrP9nlJQVouTaiQ822FL25aWxvHXLk+7BmLIbZxaZXfMG/vM3ooOzB6SmxK+WJgcXkzCySg19PImSqoC8h66ckzNN858km3O9W95IQ+gFtMPl4+HG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFPRFZBWjFSc1ZUM1RQTTBwTjJiL2J5QXdLcUc5Y2w4RERpdE9GaWIydG83?=
 =?utf-8?B?RTdHZjQyUkh5QWNuUDdGcGNUNHB1b2RRSFA1VTRWT1VRSDBMSnB6blNFZS85?=
 =?utf-8?B?Q2NqLzNTMWVJSDF1bWRXQ01WMWNRbTQzUVRTV2VReFRzZzlLQmRmMHM5aG8y?=
 =?utf-8?B?cEFueE5mZE0wdFJnZElSK2NYY2toYkh3RXJGaGZtbjBwb3N4Y1dzWURzN1pF?=
 =?utf-8?B?a1cyQ2Y5OG5qckltVVIxWThEN0xiS0JoRmpLTld3Q2JpN2xkNU9QSlkwdVdW?=
 =?utf-8?B?YTIvMlVUbGRJYmhvbW9adUtPZjIvMXhMaUN2MGRFZkR0c3c5ck4zaDF1NWsv?=
 =?utf-8?B?Q3lmOGVZQkt0MFZBUGpROUNOMWR4MUplc2Z0NzNwd0J6bUt6ajRJb3ZoMEFv?=
 =?utf-8?B?L3c4OUpNSEpWRmlCOVNOTHFzTzRwTDZuTkYrOVJqTEsxd0p1VEEwUktXQkpF?=
 =?utf-8?B?UVJONVFOY1VhZEtyUlYwb2Vmb083UFpUUXExSDhKMkpNU3FFRFhGa202MzFw?=
 =?utf-8?B?WDNHaU1DdklONDZTQUplWlExNVNJYXp4Vk9zZ0pkWjdLbjZTU29WcmliSjNt?=
 =?utf-8?B?NHdCT3ZHbUkrUzhrTHE2OURrb001UTFlV2YyeHZRZzlBMVUxQ21SL2lZUXY5?=
 =?utf-8?B?Vi91SnBsdmQwamxnOXcvRlQ2NnhKanJWUWFpc3Jic0dwN3ZxUDRPY1RlTkwy?=
 =?utf-8?B?eUFUTExqc20vQk9iZE93T0JnbU8rcUhHU2UyMmtSTjRCdmZSZ2ZNRHFYZUVW?=
 =?utf-8?B?b0RlVUo5Y2hDb09tcnkreWVoY2E1UlJzU3N5cmVaU01BTWk3Q0VIbmIrMnha?=
 =?utf-8?B?TUU5VnRtMDViZlV2RTFHSmhnVEZPTDNsSHUyT1RPKzA2SUkzc2FQYUd2Nitt?=
 =?utf-8?B?VHhDUi9lS29ZSTRNNGh0azMwMVlsVExiZ000bC93eHVsTXN0NXovSDBuSU9o?=
 =?utf-8?B?QXI5WEFYNlozalhGYWMrVW8zUE5SQ3NxMnBDS0NqN0xieUtZQXZFaWtqYmN5?=
 =?utf-8?B?NEdJSkV6Z0VlVVFSOTh6VlhsZ0poWkpOTTNwdHpUb0t0VFFEcE5tTFpvZmw0?=
 =?utf-8?B?SUN4RTZFOUw4UC85eldaVExVU1dlR1QrZGFDVVFUUmFzUWVuMU1zWE12SXBU?=
 =?utf-8?B?VWNHbGphV25reFJJT0hIcEUvTzhwSDUvZElDaU50Q1NrK0tSMGwyeEV4YXJo?=
 =?utf-8?B?aUdFeERtbHc5blpUZ21CMWhEbjJuZXJWOE1nMW92eCtYK0I3OW5UTUN2bXlQ?=
 =?utf-8?B?UlJwTG5yVDFzMjBwQVR6OEF2a3FzRzlMTXdrTnVQamFnQnpKaldLdVRKOFVq?=
 =?utf-8?B?RStuN29JSGltdUh0SCtGN2xFR1ltU3djZ0s4ZVVWSFJyOEVzcDJyaFdxbk0v?=
 =?utf-8?B?TkU5Q1pQUkd2dVJGY3hTdTBjZnB2dzVJeUQ3M1V2VHJ0c0ZIQ1BTSzZVYk1h?=
 =?utf-8?B?S1pEVkkvVDhOQk5pVXNVM2xWNW1jdE1pbG1idXczVEQ3R0JST0tHU0NRV21W?=
 =?utf-8?B?RmZ1cUVqclp5b2xCWXJZb0JldWE3dnR1QTJTaXhqaG5ZcmlFWUhqdXNsR3NY?=
 =?utf-8?B?NFNqMlFzVyszKzd0T1crVlJKcTBROWRPRmJ1L0k3dzRqak5CTTd2dUI1b25E?=
 =?utf-8?B?b2Yva2ZHR2pFMi9NZDhVdlhrNnIzbk1WM25jWjZDYkJ3Yjc0aE9ob1B0Yis3?=
 =?utf-8?B?emhaTThIMlppR1pUc2R4bk1kTGQrRVJKZis0Z2QrN1FXeVZVRGhRVDJiVlpI?=
 =?utf-8?B?eG1yYURhNTFnOFVmNzgreUFpd2JucEFSdEpmdFMxcFhHSTYzNUVCT1RMa1NQ?=
 =?utf-8?B?NFBqOXZOOEJEWE5CUEVkRXgyOTRpY2pKdFl2eGs0OHN4ODZFdXlXS0d5QjlU?=
 =?utf-8?B?dmw1N0Vmbnk1LzBPY3dlQzJRZ0hNN0hCWnNESHFmSFk5TEpPL05JYXlNL3VG?=
 =?utf-8?B?bktvT0ZJMHAwWW1HRzRsR0ljbHBPWFVTOFBpczNLQ3BBcUt2WFQ3cXBqTC8y?=
 =?utf-8?B?YThwbFlpcU4rckVkeDZIT2JDaDlPYzdIYVlUTkhZWURvR0NrMzZCMkovczly?=
 =?utf-8?B?enZOSjBsSGwxOXF5d0h3WGlHWUxDWnJGL2RpSXpLZTdLbUloYkhvNzNsOTJO?=
 =?utf-8?B?Q3V6cWxSbVFwNWxvZ1ZkWUk2S3Z3SGo0aW9FL3RuQzNzSlY4YUJxREp0aUpQ?=
 =?utf-8?B?MEVNU2dLcTJKM0UyZXAxK0E0UkVUazZ1eGlNQURuakJaamwyeXVPMEp0dmFv?=
 =?utf-8?B?RlBiam5IQlN1SDdZMTFTUzUycTVLKy9FajVXQVVyRzlYN2tsRm9OL2FuTENv?=
 =?utf-8?Q?tWWNhqaSMBv9xHzE0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f989fe-ddc8-423a-01b8-08dec7a536c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:35:53.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNjfRwgUyw4ZkT0GAx3V3FksHb7IDhmpFGaRLFKJjTbeH7KTUz/iGpo8ByfSwqSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22104-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4257E670E44

On 6/10/26 21:31, Zhiping Zhang wrote:
> Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> wrapper for importers.
> 
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> the importer requests the namespace it can emit and the exporter
> returns the matching ST/PH tuple or -EOPNOTSUPP.
> 
> dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> when the exporter lacks the callback and requires dmabuf->resv to be
> held while the callback runs.
> 
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 21 +++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..aff79ea12e43 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
>  
> +/**
> + * dma_buf_get_tph - Retrieve TPH metadata from an exporter
> + * @dmabuf: DMA buffer to query
> + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> + * @steering_tag: returns the raw steering tag for the requested namespace
> + * @ph: returns the TPH processing hint
> + *
> + * Wrapper for the optional &dma_buf_ops.get_tph callback.
> + *
> + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> + * exporter does not implement the callback or has no metadata for the
> + * requested namespace.
> + */
> +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> +		    u16 *steering_tag, u8 *ph)

That name needs improvement, maybe something like dma_buf_get_pci_tph().

It also needs some brief explanation what TPH is, maybe a reference to the PCIe spec name etc...

And document in the list of functions that this one should be called with the lock held.

> +{
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	if (!dmabuf->ops->get_tph)
> +		return -EOPNOTSUPP;
> +
> +	return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
> +
>  /**
>   * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
>   * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..6a54e0f251a2 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,25 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
>  
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
> +	 * @steering_tag: Returns the raw TPH steering tag for the requested
> +	 *                namespace
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 *
> +	 * Return TPH metadata for the namespace selected by @extended. Return
> +	 * 0 on success, or -EOPNOTSUPP if no metadata is available.
> +	 *
> +	 * This callback is optional. Importers must not call it directly;
> +	 * the dma_buf_get_tph() wrapper is the only entry point and handles
> +	 * the NULL-callback case. The callback is invoked with
> +	 * &dma_buf.resv held.

That most of that should be obvious, we only need that it's optional and that the lock should be held. Everything else can be dropped.

And most of the description/documentation should be on the wrapper function, exporters who implement the callback should know what they are doing.

Regards,
Christian.

> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> +		       u16 *steering_tag, u8 *ph);
> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
> @@ -563,6 +582,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
>  		    struct dma_buf_attachment *attach);
>  int dma_buf_pin(struct dma_buf_attachment *attach);
>  void dma_buf_unpin(struct dma_buf_attachment *attach);
> +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> +		    u16 *steering_tag, u8 *ph);
>  
>  struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
>  


