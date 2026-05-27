Return-Path: <linux-rdma+bounces-21341-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEjXOaKVFmq1ngcAu9opvQ
	(envelope-from <linux-rdma+bounces-21341-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 08:56:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633365E0139
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F123E3049225
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901573B5841;
	Wed, 27 May 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0Ous4fF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F03B5311;
	Wed, 27 May 2026 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864963; cv=fail; b=UxPZ3JSF92IlUCCt3+jRGjZbYkUydSdFPmssytPUOiICMXl2OHhYbqBD2c7oDb7dVtO9dDwp+Xa1ov8OrZTKAPbAkAiz9qo5eMyJRaEqVjttOrptwBSSbwvnFISeJIwvqARErsIhSzwNEif5wxF+9/EcKnvVTUv/Sr7/Fv7ejEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864963; c=relaxed/simple;
	bh=TwkDF2+zKwxXXLDg5DYgLdpha4V931M+vuOje0zf6DE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8BL3D4CdqDYbNn+DxS2IxI5xopeVoMZ92AuEuWcQy6vcKe6uoMrWGTamYkQhHArX0Qwl0Lf99gPk19/tqCxXsXkfOpRPo9VyWJI0IzudLCRWxxatDA2w4HLVCdJnYJeBVYP+3nuOsrYj1YBQZorHw6elYwTUEWK1kiZxgyAjE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0Ous4fF; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSkxuStpQGMijdyAGpqr/vcWSo/UKRwZ1fG7qeKYJAm/0yzKtv5Y/RZaA3gtTjcMVLu06M3e7OYj0BKG7XS/NYde4BFVDMyCSJnjRrIcXhkq0bSGNLjdoCwb4HTdIwKZv1h1pSma1a9fo8/p5GH+fr3P7LenTenEbrZdFsUtpXsa95K+7Jz3CPGFbOSH7ylvUJkgmbJ6iytm8s3L5iG5xb7IwW/BHJPLEs1orHrb2sk2Dhq2/ZhdGRKaP6MUMU4mVV1eplU8hGXoHp2mlB2SQs+yet62ycrEa/hO1+WUCmL3TWMaNdQ2zPWxuIoy78VH1mY7aHQG10Z6h+PKGKJx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KdhAiOu1jCECggD3MB0rF6S4Vy0EOWwVy20oKe+rnY=;
 b=cwhZciLTw8K91szOimQ9RPliAPMHDYz5WrjGpeVFB7vSbz5hwWeH34GH9EsXLq8NbnAo1eE7E7N1XN2wQC970XMHCrGhPg1spJKtHW6eKuoljIivTlo/CYBjBA+fNPq2Ah6NIX+eOZsCF0hGsAPw+tCRjBZKgRomEClbMRmhf0iHka5BZ+20wYvscRt56hWVFvhw62BE8lC6tH6EkRkxA6cwY8cIKJrVawvY9BHfQzL83hpsbTQEiVTp11iUYyC3rrzT2maSZZ6clBUS88dllk+vKym4AvBTSixENOlF3kpQGfiFVvyQ+KVZ3I5w8w6jQirv8nQKbqDAQC2nXb1yuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KdhAiOu1jCECggD3MB0rF6S4Vy0EOWwVy20oKe+rnY=;
 b=m0Ous4fFpIvIv1wCfN6E6vy8TRL5vnMMfBgHeAAoIH8ADQNgT/7s21pYHAUjwflMur2D8KXRtcy7m46uV7JCC2aM64Vq9VNX0Fa3yi5JKXBHAs6uTPWqHyd3sMFTHNXHEPWiXSeBn640p16Q6i7koLoQC4LOrTtes3d7h9p8pOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 06:55:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:55:57 +0000
Message-ID: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
Date: Wed, 27 May 2026 08:55:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526144401.1485788-1-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0632.namprd03.prod.outlook.com
 (2603:10b6:408:13b::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 207960cd-9d8f-42a1-b837-08debbbd00b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Dp7R8ahTlYCJJuXcAvjSrFT2aCC7Qe0Qqiex4ng4C0fe/O9ZJpUvea4me1l1eJAsHMQUPddZt9L+CtJiY8mxmSWO8FqlM9Jroqoyb/DGw4KBmCsTlz4nUBDuSt4r0mf8cP0ilZsHGucs0yXJqntLGYOagoaAVCXJFeEZuFdRkBs5sqKC2IhlXDYBefUqUqezkrEM2SeaKLFdZJVsAEAdLUDWc7srwDOOQwWSAWTF/tNo/gszF7b9SSLTWkilYxJ/Qt4CTe1BGJ3YVlUAg1Pht1glcl/+czPy+7GRTK8pXGQsO0bryCIj9MWRDQ9f5zbDx6RRY8wAl5//t/6JqwBC+g/iZ2VYt8snNOWzr6XPYu/6DeebC9SCbnKjrxGhJWqQ8qV+ZQ1w0f1GZCVwZCiIUTS4Px92eD3miJDhmyNUl2ei/4JB/ain43jX2XDf4gf69xxeb5M/kgWKIjaT942A1/yC1JwIRV7sMzTOJAkgc0ItWTJkcmyWJqFITCX/quPFJZghiCBJto2s93bdUwh8xX+mw6IeHrC06NKhrOyLxAaG/Sa0xB1OPD3vulDt1B4ghIHoAuiJPTzZmozXNIC/Rqj8wssKU7PL5V7Pv7fC/XxW3z+2i951j45vRCIN/1HLQ/z1Ss3iChPyLUs7aahJUFRxGFl12mtdXymd22Opd8vcSAXGUE+VBuwKe0/pKNcvEYgHA2KqVW65oG2f4GEEJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStzS0Nlb3VyVEExYjAyVGtvVHF1cFU5cXMxdko3M0ttZ2V5N1dRbDNpZ1U0?=
 =?utf-8?B?K0FBMERKMkp6dVgzZHlTTGFod3V1TW02bUxseFZzNW9OVUs5RjNsMGgzRFdh?=
 =?utf-8?B?SVpoRHlLaEJSL3dURFlWZmI5cXBzSHFOTXVLYUVrZ0srdW9UU2JibkwwenQw?=
 =?utf-8?B?M1BTSlZLQVNJZklmZVRhYzRqOVJVY21kNVRLNjcwVkhLa2xHa3J5azJTcXFG?=
 =?utf-8?B?NklXcG0zeHExek01R2dHYVRmNmhtZldIeE42VUU3V1JoZjZQWWRhOTVXaDFG?=
 =?utf-8?B?bEhYM0J5bFpyL2VYTjFMNTVZZXJkUmdmamNRYWJ0azRpNWpuNnM2dGxrZnhO?=
 =?utf-8?B?Um9VdlFzdlhVcU5yKzdxT0N0TUJUYjcwMkYxWkNvYjFudHAvR0cyNUd4QWZ5?=
 =?utf-8?B?TUZmYTg0VlBRSGxpR0FkWllOTFJhVzEyKzhMZkh3VVJYQ3RhbXRrWkE0a0FR?=
 =?utf-8?B?a1dldXdHU3VQVGxNUnJBVHRsNmd0K2U3Y3RTakxyVENlVVpldHNaYkg4RFJV?=
 =?utf-8?B?Ulg5SnlZd3Rld1crZFBQQXMrR3NSaEMwTWw5QTE5SHpOdlhuZ0pZSTIwdDU1?=
 =?utf-8?B?YmhtRWx5UVowL2pIVFdqRER4cEYvZnJ5RU9wN0lBS3U2Qk4rb1J4M0ZiMzRN?=
 =?utf-8?B?SGhrbkNpbzNaVGRoVzczVzNCYTF2d3crelM2ZnpqM1VyVmlHL2dUdkZTUk5l?=
 =?utf-8?B?Z09pdWRoMzVaM0EvTVRmN3lTWXJuaytXcmxveUNlWXBWbWRoYjlFa2YxZ1Qv?=
 =?utf-8?B?MjJ0SFROYmlGeDFKUzM4M3FLOXNpa0pDbnV1cGM0cURWZy91cVI5ak1hbjNE?=
 =?utf-8?B?UzdoMXgrYjd2VjFTSkZkOWg1a2ZobGd3NXY5bzlHbVhPNG51Z0grTDExMzQx?=
 =?utf-8?B?ODRHRWVSMlRHWGErV09WT2xnLzZmUXp5L2xqOG01bkNsNW5mUkgzUEJHZ2hs?=
 =?utf-8?B?bWZwcGVsdW5KOGFFWnZDbVVBdnR6VUVsMThuaEh3NjNvYStUS3RiZTU3WHJt?=
 =?utf-8?B?RUhhMC9RYWxUQmRkaVZ1dUVRTkdpMjJNUnQwbEt0bFZzUXVoa1ZPR2hzN0lU?=
 =?utf-8?B?Z1lwcktDS2dxT0N2SDduOFJqOTk3S0x2OERTaFFmeXNiOHY1MnhBWTUxQmdR?=
 =?utf-8?B?NGRjb1E4KytYbDgzM2VUYithSEM0MnpBT0dXTDZQOWJVdGM4YXQyY0RoVHpD?=
 =?utf-8?B?R0xJYW85cWY2ZXlYSjZvb3FGYWorZGVGUzVKMTd2aEZtVng0YkExNE95UTNl?=
 =?utf-8?B?eEwvYnVCdFgrTWsyRGRGZkJ5S0NKNDFVQ0xvZUFMUWY0cUp1dStzc3hsUExl?=
 =?utf-8?B?aVpVcHBLRWNCdFR3SStiY0VYR1dscG1jYXJkS0VJOEFDdFlycXJvSWQxdnh2?=
 =?utf-8?B?SEdUK2JkenNEay96WFVUZkxYUTVJYUd5TWdqWFR4NHVDS3cyNlJzUTNsaDdY?=
 =?utf-8?B?MXYrMTRYaVVLVTJBNWpsQ3FiMDdpd3ByeE53TTd5UzBqVzJjbHcySCttSWNT?=
 =?utf-8?B?SjJwak5Dd1h1YlpuNXhVbWxZLzYvQlIzY1lwNGpEbzBiajJ0ZVNGTUhUMTdm?=
 =?utf-8?B?SnZkRE9MMlNFOXBybXNhL1JEMVhYT1loZWZUdVVVWG5Ib1Z4R2VROVRZU3NO?=
 =?utf-8?B?bzhyV1Y0NkwraWdCbkpKQVcwV3E5VkYxV0FtWXlPa3pzNDFlOHVRY0lRNWV2?=
 =?utf-8?B?dHJyOTBsQkxTQUpPUHhRMG1XTVJSQ1pYTVB3ZDZ4bklwNkYyUVdYQ3hQRWJr?=
 =?utf-8?B?UEZ2K0QvelkyYzVNTERMUFdGNU80WW5acXpqTzAwZTcyZytHQjFyMU9QUlZW?=
 =?utf-8?B?N2FYTlBadVBrK2w5WTJZZ0VublZ3T014UnNQQzB5NCtOYXRaK2RhWCszQ0Mx?=
 =?utf-8?B?YXVRYjUydHZPQ29BRmVOK01zVzFJT014cGF5SFhTYlROcy92clVkQUdRcGk5?=
 =?utf-8?B?Vm80aTl3S1RYd0UwNlUrU2I2cXhKVGdFVmhHUFRBMWVwQmNuclpnNCtHRmtM?=
 =?utf-8?B?aGl5eXhOVytJa0xQY1VpYTEzSHJ0ZEdnT093ekZRd0drS1JiY2hJeVVzMWdr?=
 =?utf-8?B?NXVXZHZGeUJPc3FLNS80dXBuOVpsK1R0VTFaZVl6YkgxNzZkS09XaU1zRHps?=
 =?utf-8?B?ZlRjVjRFU1hLWFUzOGVUZ1BNNzhDcVYxZ2cyRnZwOHBqWUVFT00yck5vWEdW?=
 =?utf-8?B?OURDMjd3a2k0cjd6ODd0ZFBwblo4LzVGYnRQeC9pRUUvdTNmQ056WFRxR1JD?=
 =?utf-8?B?Ny9ISVNnc1YwcjRER2NMc2JiZU1CVUl6N290bWJoYzR1aEx3VjNXSTJSYUNH?=
 =?utf-8?Q?KFU4/zJXQw6HDkfubf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207960cd-9d8f-42a1-b837-08debbbd00b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:55:56.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZAlWRUkO5GISC34g5RGjaDHFndRd52TNgTD6cbvSNtOMY9xMEHn2igk9xrONX6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21341-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 633365E0139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 16:43, Zhiping Zhang wrote:
> This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> export path, allowing importing drivers (e.g. mlx5) to use the
> exporter's steering tag when performing peer-to-peer DMA into a
> VFIO-owned device.

I'm not an expert for TPH, but that sounds very strange to me.

As far as I know the TLP Processing Hints allow devices to give a steering tag to the root complex together with memory accesses to give fine grained control about cache usage. In other words it is an extension to the classic snoop bit.

For P2P that is obviously nonsense because we don't have P2P support for cached accesses.

So what puzzle piece I'm missing?

Regards,
Christian.

> 
> Patch 1 exposes the enabled TPH requester type through a small PCI/TPH
> helper so callers don't reach into pci_dev internals.
> Patch 2 adds the optional dma_buf_ops::get_tph callback to the dma-buf
> framework so importers can fetch TPH metadata from an exporter.
> Patch 3 implements get_tph in vfio-pci and adds the new uAPI
> (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
> Patch 4 wires up the mlx5 RDMA driver as a consumer.
> 
> Previous link:
> v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@meta.com/
> v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@meta.com/
> v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@meta.com/
> 
> Zhiping Zhang (4):
>   PCI/TPH: expose the enabled TPH requester type
>   dma-buf: add optional get_tph() callback
>   vfio/pci: implement get_tph and DMA_BUF_TPH feature
>   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
> 
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +
>  drivers/infiniband/hw/mlx5/mr.c               |  86 +++++++++++++-
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  28 +++--
>  drivers/pci/tph.c                             |  12 ++
>  drivers/vfio/pci/vfio_pci_core.c              |   3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c            | 110 +++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
>  include/linux/dma-buf.h                       |  21 ++++
>  include/linux/mlx5/driver.h                   |   7 ++
>  include/linux/pci-tph.h                       |   2 +
>  include/uapi/linux/vfio.h                     |  37 ++++++
>  11 files changed, 311 insertions(+), 13 deletions(-)
> 
> --
> 2.53.0-Meta
> 


