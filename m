Return-Path: <linux-rdma+bounces-19506-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIGEDoQq6mnfvgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19506-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:19:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C1453976
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16F593013BAB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A9318EC4;
	Thu, 23 Apr 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qg3Zr6E3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A0317167;
	Thu, 23 Apr 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953984; cv=fail; b=WyvByqWJRH6FMC3bOR8g4VIHE8ua19vMubCjWQgEE823zURt0KtGRl9IxvUVysGdvfX0/2CQ19Lf3bjLAyg/K5kHaXJ1Ed2V1YKHmUepg/WW5U4F4HDbgKOMuA8Fcy/0nnOtmPIYA7tDcmmHerjfQSz/tHaUJPpuvd25GFZ+tlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953984; c=relaxed/simple;
	bh=gY8jiflxaRnnN/uNI+PB20Cg+x+6J3AGwElmg8/KXpg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHzieX8AJRxsvSK8B69gNj5VciD9ZpwtfU5/lF6gwztazLi9f43I/K82iAyJCE3GQ99lqPx3AuTvEGlUwa+7xSBEHHS3tHoOvv81nhIZ3KBu5apnu/Xkd3rO7tCOdkcnWkNTzihepPabBFm1bmD43tcn8//b0TZaoz9kN2JNaTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qg3Zr6E3; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8gDpCataFQ4Qs4LDnjvu/VwDzyQBCvCMlrjUdnDYsCZsqn2D6WXOpxyxb0HSLUkS0xMMq8LaZnWdyR1XfBh22zaLd/Qhj1urCJ7b7UQNIzNyVmzGoW3RGFZep6tfV698zGshV1CCWoTQAUQu8dRaMvnUagq356YwXr1dYXZngtkccdbHXt9rH2fsUhEwyqjo8RmSotmg3yDCdAxK5sEqdOwq/S2NqgQTG3O34NzdAdZC2xGXC8xRG242eWzbN4W51vfQ99/rrRtHQ8cSVn4aAxRebsDxNeDxIo5JRL9t5htuWwGNm6/dncnjsjOb/2es82Myy+xi0fXDKWQushXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbN2l8bgHavLRf9ngCCuGfpR+fvnGWVRQtc2y+5zHSs=;
 b=SvMXXZYGEmd0wvfp+21f5eZNP17nrGBUUx/pFdqNWSIZ0AZnfnB5CpXmtD8GOGT3JtqkIyh3Tzbh4KNhhuOWrIxb7tmh7OZVOJkitHLfVAlWJA5JStBUrXfurdotHVLxbQ3obc61WuNKwLaHG3jLaJx6Knmzb/gucaf/aRINiV84u52IxEFWPlUStuK7rTAXWvXgUm+MnqE5I+xY2l0di7tAiXt4HUqbspXYbYOzAJOuCrlYs2n5uXbb0HZleJTK26itEOXBhBxnVlg/bqU/qtAR2cLJliKoSa3s62o+3673lOZXEACrNo68pQlCqVrmiB5a+ZoRdgDZMI8Fjd+MHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbN2l8bgHavLRf9ngCCuGfpR+fvnGWVRQtc2y+5zHSs=;
 b=Qg3Zr6E3Yj+IJ5vI/3vkFGMW7mWlJzvI36b5wc+aDYQ+WgmTI/mvepfiGlDHg52csqUbruwbXk5fpPROTYPEBrCqpQ9DHq0Xk5ZTM0dmuLR7L0WOTy6tkAWwGLEpc0rKEIb0oea9MOmUCSiTf6/smlLEjZYOPIabmG+rf4nwzursrAGN+FIe4aV7Rzloo0OZLSAhJIX50x6RhzeQHDka1iZUu98yMjM/rzAp/pOapYNtvH8N9IKC+I4pqkNa+xU/a/xzSXaQ0Htg3qJJcs8PfAgTFJOp7nBZP3lRk0OntrcDfkockwnTtkEr9r6IyBznAVAMb2OnJA8EjhtV/DyhDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 14:19:36 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 14:19:36 +0000
Message-ID: <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
Date: Thu, 23 Apr 2026 16:19:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: Paolo Abeni <pabeni@redhat.com>, chia-yu.chang@nokia-bell-labs.com,
 linyunsheng@huawei.com, andrew+netdev@lunn.ch, parav@nvidia.com,
 jasowang@redhat.com, mst@redhat.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 606fb4a4-10d9-4cd9-71f5-08dea143591d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|921020|22082099003;
X-Microsoft-Antispam-Message-Info:
	PqS07wrBGG3upygM+1KtEkTgE3Mn9JI6WtzwMX4Gh8/K8neGqgSyypCMvHo/c6H9PCVdwAPL1SNPxXRR5vAYFB0/VftRjzRAaAijWTdPmDzsbNzolSvpbugrGXYXH4zWTgyEnT4iY2X1eNK553Cs71cfjU0i9psOytA3nTeWQtEvKp/PnKZX9KuPJnsTxjACBA+BoUwnolgWVnrf/OcDvjQsBo++KWoWJGfLFx6W5Td1kSSwZpruSzbLnqFy5hx2+UgvGzsVvUtCDl11DrJe0GOlXpT+8qRnaLRgSpTfAPsh2JZYWgRG/cMUTjqbwFQqfwKFtjQQXgNC/vhaS1TpauNwIlyiZGw2Fum2hOX1UfRj8CQBIRlsVTzjMHPhmbf1AGY6ckJs/T0V+x0/r6syAm4c8A/pQ2i0fMAqDrsOzIlu7sLdE1/vZuFZUE5f1752M/2vRPAd5hqKlyd94onCu87ERyOBs6UMLROBb5smUR8ZfesqB6BUnGDpCjCkSeOS95WRXGVJ8N7KCupkX6lrAy6ljopCYoGT1ld0ad9ViqcGBm87ZrFuw3nR3UUGiDdvMihVSs9Is4j+2xUNiAsDGZ/mr9YXcspqHASp6TjW6T9YMkIePgS3LNeqaeW1H1n+pHYmYsPR/jYAGupqP+9WuVxlAFcAfjB6y9yZZZdtw5UrLtyZ6PNLALmNFiPVFYLsY0YHS4g7wDWp797WR/KChd/IBhW3Wp+7x9z4f3HENAUF7aSi3L7sN8zLVDswfu4i47nPlUo56vQueTmul8Us9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS8yaDVjVUkwcEtpbW9mRXRnb3RwNWlGa1lCY0dyS2hkRzErcXF3UVBYRDdK?=
 =?utf-8?B?dmh5QW1xU2Q0OFlRTWMrWkYvWFUvVDQyNEFQMGZCQzVsc0lIMXE1ay84c0RB?=
 =?utf-8?B?aTJpdm53V0lNMUpwK0ZBMFZ1VGFCbEozV1FBeXMwNC96WGJpQXlZa0xQNVA3?=
 =?utf-8?B?QnRVTjQ5UkpUTE0zbHFkNWdldlFpbE5GTHl3QzlCRTJwMEFXL3B3QTBST21o?=
 =?utf-8?B?VlA4b044SzFWSmJ2amVweHFTanpUSUwzVVFXVFBjVjNtZWUzNmtqYWtpQUxF?=
 =?utf-8?B?LzJlRVZZeloyR3FZQVRDZW1VTmdwNTF2Z0l5MzlEUWFJVWMwa0Roa0ZKWHNs?=
 =?utf-8?B?SWxCdCtGcldvWnkza2tsRi95dlA1ckY5RDV4bnBMUnpIUWFSQloyTVRUaG1i?=
 =?utf-8?B?M21IRWNFdGVUOXVTQjBVMlZRbEtlYndrVXJCMFk3aWt3aU05U0dkRTdMTzRX?=
 =?utf-8?B?Wi9yNTRuZ2ZycUkzZUNJVDhHdzY0M2hraDdYb0hMdXFITlBqeFVWcHByRGwr?=
 =?utf-8?B?MDVEVHhuWTl3S1BieCtNWmRsZlJJT21VS0tQcXdIMVhZL2tOOFozQ2tTRWtO?=
 =?utf-8?B?aXJwckI1LzBoVWpEaGZHY21JWjFDWkltSk4yZWJsU09CTk1nNjUybjhXdVVL?=
 =?utf-8?B?UXp6L2FLUmVYSnNYaURhdkM4d1l0K0xtaGpOMlJCc3JJdG9aYmxhQmVYRUdq?=
 =?utf-8?B?VTlocXBPbG1jdEVuYUlLZ1pJSjdBVy9UWm8rclVmVzZ4S2NPbk00Z2sva3Vz?=
 =?utf-8?B?eVdMVmpFVi9LaVBnTGQ0a2JDZjJHVDM4bVN3aU9sMEluVFhacll5Wi9yZlI5?=
 =?utf-8?B?ZkNIUVVlMGpGOHhwa2krSktvUDlaQlZTalNiRjUvQmRGUUYvT1pSMmZWbkN3?=
 =?utf-8?B?MWw0SWVTWUlwMDBDcmdMbjM4QkMvRkNxWk5wWVk3anFlRlRlOHE1NHNldnpK?=
 =?utf-8?B?V2hVZ21RbkE0MUw4QW9mV1RoV0x1UTRNc1dKZk80RUc5R3MzUithZm4rMkxw?=
 =?utf-8?B?QlI0SHJaL0xabGtmQ3Vod2VxUmlSVEJjb3NvRlJWZVlUcmRQd2o1d0FDZXJh?=
 =?utf-8?B?RVVNZ2RxaXB6Tlp4aGRXWTVTUnVCRkVrUkV5Z09Fa1NxMnlDb0hleVlKblE1?=
 =?utf-8?B?R1Q1STdBSTd6c2dXdWF0SmhSM05XeGU3MDhuTFJtNW1JZUNpTGpjWm52ZnZn?=
 =?utf-8?B?QmoyaFlRVmdSNjVXTkF5Z3lhUXVGRkJtbm90QjBCak1jMGFYaUJKUWNwcng5?=
 =?utf-8?B?Sm9RempFTmwyNUxheFQrWDA2dW9sZXBQSWJGV0g0YWVlbzJSa3V2TTJYSVBj?=
 =?utf-8?B?UmI2OS8yQUltTnNNWWZhRnpwR3pEdFU1VGpDMnpvdWxtbGgwNGFsZVdKOEwv?=
 =?utf-8?B?Um1pZGpxNzZicm1Td2diTWE0cUhIbGIycXR6OWFEbHBoYjZzeW9KYktTSmdm?=
 =?utf-8?B?UHFzNzVkTWlUY2FLK0JERURZWHo1ZUlvMWRuVk1YeW81L0RWcTBUcnVnMHZZ?=
 =?utf-8?B?a1dsUXhyR3YzemF0VUpWY0xhRzZVV29PNHl6RGwwYVp5TkVYNURCR21ESXdK?=
 =?utf-8?B?b1czNTNOL2tXNlVyRTFhd2QwZFlnYWJHWHBNY1hZWTByelZmaDZrVGNLQUlh?=
 =?utf-8?B?RHJEcDJVZVlMNnB5dGhxK01XT3hEVXhWYUQzZUpmR0FTWi9VSi9HZFdDOXdV?=
 =?utf-8?B?RURDQVNVNHM2RmsvVC9JYkdaMGlIZklnK292cWlHL2hWQXlESVhjOEV4Sjd4?=
 =?utf-8?B?TGdZZmVDbXNycDdibHVZOENLTzM1REFSejJZWk02QkUzaktTcHdVS3lJd2dw?=
 =?utf-8?B?SWdkUUtqZDh6WWp2a3o3cGQrV1N5VkdSRFRUTmR1anE0MEt4YXhrVFFHUWN5?=
 =?utf-8?B?L0MveXNMakNXM1hrRmpDYTBTQkVnc1VKaFhneTM0b3d2S0JUM0RzWVhCVHdM?=
 =?utf-8?B?RXgycGpBUnVadUZDVXFBaGR4aVZmTmVVRTg4cnhxV1czdGdkNG1jUmtKQTA5?=
 =?utf-8?B?Rnc0T1ZNczduZG1EeTAxWkMrV3kranR2VUJHT3kwdlBtQkJNTldNc1NmZlVT?=
 =?utf-8?B?bVZsVWxVN1NoWHVaQ0lCTXQyWjdXVFg0SDR6ZFFqRnFMUU85emJKb1pWQ2tX?=
 =?utf-8?B?WFpWSGlwTWNXQVdlZGhaUzF2ekdqUGJ4WFhwMGZzRkdadjl1NzhIYVFhS3B0?=
 =?utf-8?B?RG1jT3VvSzA4YUhTeDJlWGJhVnRuRkY5aFZYYzJlMzArV1RPb0x2eWxWNjBL?=
 =?utf-8?B?R3VmakQzRGh1bFFHdDN1OVA2R2FGQkI3OGdUaGx5RFlRQ0NkWkowMCswSTlN?=
 =?utf-8?B?Ykt6dFRUTzlSQlQzSnNoWjFIK05jM2syVWhNMURrd2QzNE1QZHdZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606fb4a4-10d9-4cd9-71f5-08dea143591d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:19:36.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhVs+5SkecjVFX2pCi6RdB6kwNHTCz18etABFd4leFD12H2zLRHxBN6u8BGssjVFnmIYegfQjp2jUGFnBfFAiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19506-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 059C1453976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo and Chia-Yu,

On 23.04.26 09:30, Paolo Abeni wrote:
[...]
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> index 5b60aa47c75b..9b1c80079532 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>  
>>  	if (tcp->cwr)
>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
> 
> Here there is an open question for nVidia:
> 
Sorry for missing this question in v3.

> Is the above enough or will later segmentation lead to the wrong
> results? I think/guess the firmware is (still) aggregating the wire
> frames using the ECN schema, i.e. the first wire packet has CWR == 1,
> the later CWR==0.
> 
For mlx5 HW-GRO a packet with the CWR flag will flush the previous GRO session
and will not start a GRO session for this packet (napi_gro_receive() will be
called on this single segment skb).

So this change won't impact the current GRO behavior from the mlx5 driver/hw side.

Thanks,
Dragos

