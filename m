Return-Path: <linux-rdma+bounces-22108-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UuSJK8euKmqluwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22108-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:49:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051B672053
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DuOSK4YD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22108-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22108-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF1D1309D634
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E693F8EAB;
	Thu, 11 Jun 2026 12:44:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135735AC33;
	Thu, 11 Jun 2026 12:44:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181877; cv=fail; b=CCMYfWn8DrvasEpOt1CvicUUmwayd5iULyFIZk3MJBozEmyi0jby7An2MWP0RxWnK9ssZam5NqKG74rxqco/09AAFpppG0fm0C9v3d2qCUuW90xGzV7SAC5T3KZvShCfWkgUgtYkzj3BN9pp35Ti7kOdmDrabWK+x8hV1PNUnJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181877; c=relaxed/simple;
	bh=qf3laEVDfXeEeZAlOGq7Q2hRetJ3LEsnJPqiWIvTzSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRD5XvHD7tiV/SCbS/VaYFpqp4XHalY/eOKl7r87McNlvdUEiYzuFiFj5oi/Abq7LOIawGim6DF5VjAKm8zXAGNTeSjep2UKXf3owsLmzzk7EviHzB/vQ3Ly3jBQ6cmALyfAQQ648MySxmFLP9BICVm24qWfFDym5GaPs3+Ecxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DuOSK4YD; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHlGcZikPfYJ3qx1JPYIL88eUXcOjsNBvg5bfFFupDmlTnOPW+1B7btgNsUFsC9NYS5gfQVHkxWwK0h5nt/LBo2ppMP4C0hMC+0NPXSsGGV9ldVWXx5tywkfVIt/MQeCCK8iYvr5URafv9ZapnRUjkXbVNqLJDph8Ok5E74atwudlfGMptQaJrCLSO5nz9nqII2RLnmxdtJhONrwa3kweF12PBu/QApRc1qHZfTmpaGuWnCdNDp11xFp41tTXjM5GPE5/TvkG1Rc928EVCY1Ye6P/VHBcGQm4cbzCyXv8P2h9wpipi5IiGp2prp6MRk8kzRyFa0csdQnLbMaZWp5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU93XqR1UXqV50op/vAqnUHiyoXiWKmrPYfqAqvaCQ4=;
 b=sB/1kjICvdSQC/7hhHj31bgsJgvmFuEA28g4kxeHV1NafafFnOpyptNqBkHXrgX5BcAT46RPH/nRCXDnhhHAiiT34a6GHrDuw8UB3zrJP64TiJMQPzWK8218zUN7IkwoCzZB8ZwL7VvlU8YtBsHg0t1k9/oZnG5lI+m9VJHUgCLBMyg4RImn/MNbOQVaZQJ6U5j2EhSb+2IJxvD0nR9y+PfmVhFd1+hV6RxQaszwU163QOB12PPJQ2fU/s0YFM+NRiHKYZPu8auekpVxIor4bFDmrQ/uiPoYPr8hNs+lmfDUpKPqrLtCxcvpNH6Xq3nbcQPDTLdnbKPIUL2MLYDeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU93XqR1UXqV50op/vAqnUHiyoXiWKmrPYfqAqvaCQ4=;
 b=DuOSK4YD/HU8qw9W/YcQ7p1lEC12GM58O9nXTwLs04laPRwfnhFf/5yCXO3c2Nf95c7j198ezA8ehbiB+rFhlEE0o8hBxhzIRV3rL0OjUY+qyFq5hlTUbSsXTWBm8AibSuQqSvyFkMCEGlHX8HxtmVUpgP+3ce7tppMpCmO/JsJMFFtlhQFzGBdvpBkbZFRbOQcjCanH6ZypApxbaRQJH1A6FsXKP+w/y5mqVIFcgro0CJeG1WnByUpMi1OBDJBZSagZPOwFIWX3PLEvgkDbLG/d8l49x8dc/OXuWYTPMeUXRe1FwkcBG4uN8pECC3Vqs4wi1EcyNXZZDDxpG4ddMQ==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 12:44:31 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 12:44:30 +0000
Message-ID: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
Date: Thu, 11 Jun 2026 15:44:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-6-zhipingz@meta.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260610193158.2614209-6-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d9c2b3-262f-446a-b760-08dec7b72e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XmhL6ruwim/c6ih8h5o1JwlYjoXHGZGLzGiRP/2nKUXHrIAqAh6AXDZrlszo+dfK5FczeeLZsGaUuqYhxnKp8owMshSz2j86RhZSPOIQ83FDBieRLRhsHhXRlJs8y47m9Q3HrHGgwBmVD14WAlEQisXWD5jtGLKH/tbHrNvOan3J+SnZMc2jrfDpQIbaXfG4yjuL4uDxJzgmXbkAsLXS2b47HGZfbLkUmB9xzjIUn3weGUAmO7wZPIFn99CAQFeuvqiBSNqQoU0NlYengBr63Fyn8LZfSt6EXb/8Cx1bn0o0R9DgE5M5RVSlphUjB0Vt0n5OBdShtwWhW0M8SpDCyWNyGXnGyHs7HGyCL7+vUzmDi6eQJbE0jApLjMEhdFQjOh4zb5IsswJV76kHAlsoZgCAePmoIYTjOL8t3osb/eday3H5f7zrtvD/OkgQIv3Vn3xYhXYcZoxMyBIs/GSblof/viDJLBHBMGcU7p8fVNwOdSdgCOe6adZd0nr/maumv+RCF+K4pVFpsAZcgGVfPtDtUGDqLUmNet0E7BJ1lJ1pzu3gS+u8/V3+Pi4/JHUzazeQnuPD15jWDWQgfKZ7aCHv0Fun1QNFul1awaagFnCDzWwxd3b7OOHnhImewvGnWhW8ug6Otv5D8hLEjs9p0avWPh6kctS4IdskIbNqG0IQ/dzHu6QaGxoiIgQWXMmF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RRakRrNlRSTDlVRFgrOE11cGQyaWlJQ0pmVDZ5d05sRStiZGVHSnhNVWhO?=
 =?utf-8?B?cjVMajhQWTc0eGxpN1FSYm9CaHlZd2owMnYxeUFNSWNXU1dsbEE5a1RRSEJW?=
 =?utf-8?B?SjRNMTJzaksrMzB5bnhGdWpvbHBZVmdLQmVzSHhRR0tNLzJuVWdXemJwUVRL?=
 =?utf-8?B?TmFTNmZRQkRzMUxTS3g1eDdsS29LbHFmSmdLRDl2N0IrVmRJbU9ZeEhKSGhV?=
 =?utf-8?B?V1YwVUErL0NEVmRyTjZCSEQ2VjJRc1Q1SVlod1hyelVsU2xIUm1BYlJnMHh3?=
 =?utf-8?B?SkdSaVZZdjNRRTV5QTU2dldUeGhtRjVUbHQzM2xOakt6MUFxWDdjMXFrNEZX?=
 =?utf-8?B?NzAybnZKZ2UxOWFHVmFPRmhhQVhnMStYR1RPQ0ZQK2I5SEVQUHMvOU1NV1dy?=
 =?utf-8?B?b2h3dVJua1k2VFlPa2NCUEwyTkdKT09TOUIvSC9BZXdhVmVadjVXZEN5Q3BH?=
 =?utf-8?B?Z1c0cHpmNHlNVkdIeEcrZXJpb3hseVFKamtPUElVc1o0d0FHaVE0cEk1VkZD?=
 =?utf-8?B?eDlvQUYxRXcyRUpUSERidzBOaUN0K0RjZThOTDdaaDBBdThxaDBhYjJRTUk3?=
 =?utf-8?B?ZENkSlcxZWo2VXkrQTJscHV6UktJSkxtL1h4b0ZBUVBGb2ZMSUR5VG1GeTZw?=
 =?utf-8?B?RTF2NFBJVVVUbkZTbmgwU05Va2g1VWxMcTBIUURhNUl3cXdoNzFGNmp0aWds?=
 =?utf-8?B?ZW5xOEhDTVpBWDBnWDU0YkVyU2JoeEt6YkY4dVhpQ3lZSThBRHhNUFVJa2po?=
 =?utf-8?B?VW1lcFgyL3A4RGppajQ0a3JGRkd2NFZSVDJCTGNpa1Z2ZW5hdEJoTmh0SGo0?=
 =?utf-8?B?R01EQjgrWHZsTHVyK2ZtbllqeWZ6ZDJ0L1ZvcU1Qa3c3YmZuUk82cjMvWnQ3?=
 =?utf-8?B?VjgweWcxeGxiV3FzbGx6UWxxenN2aVhLS0cwcE5kc0RHN3lYMmZiUFp4MVZX?=
 =?utf-8?B?Z2pmZGtON3gzWkJ0dkI4L3dFdXpVWklWQ3RKWlpiZWtBRVlWWVJNMHRpN3dM?=
 =?utf-8?B?eDZnVStsMHZ5T1BIS1Y4N25ZcExwTGppM05pRUZGNGlOZkFRSEw5VlJXL1FN?=
 =?utf-8?B?dWc2T2ZNTzYrUkFWNm5ybzJmMExzbGxwNjkwb3NuOXpmdkVNUlpxVGR2Sjk2?=
 =?utf-8?B?a2IvTXhUNmFzWjRkSXduRmg2VFhEeTBNN0JleDZyR0FqTFhnVXNNNjIwQVRz?=
 =?utf-8?B?aGtBZXY5YTNnT2hTQzZWaVJDVzhTQTJMWHhoVjNaN3hFalRUdWRCTks0VkVR?=
 =?utf-8?B?NWllcU5zT285M0ltVE1NYlN1QlppYSszQVZsdXRnZ3AzTGRLcDBaT3A4bWF1?=
 =?utf-8?B?Ty9UcFg4WGR3Q1h0cXBDQktJcjQyTStiQm1BTHljN1U2b1RrbGQvK2dDbTU5?=
 =?utf-8?B?Mnl0NVBYZERBN1VvYXE4d0l4V3grY0ZpTzc1WXlLK3pYbWV4dmdJQi8zeE9O?=
 =?utf-8?B?MHpydWNQR0JuMERJbThzWUQ0aDk4ZUhwWmx6cGs1MWc5WDBvOGJxU2RrMXk0?=
 =?utf-8?B?aWlSajlQRUNLMTV5T0hNSjVjcldTUk0zbXJIbHFWSWNkSDNBcnhzNWtsV0pG?=
 =?utf-8?B?M2ZJVk16V2NqczQ5dXp4a2dwQUdDbTlSZXBlVFM5bVhTazIrSVAxUGFWdmtC?=
 =?utf-8?B?ckNldlpHb2VlY1c4TWYydUU0MzI2SGdGSy9uTS9ZM0hsSWhHSTNRVG5vanZN?=
 =?utf-8?B?cUNMUVprRGk1Q3hTbHlRbk1vU1FQTVNsdzJVTXljQTE4aEQ4TUxkT0JuSzRC?=
 =?utf-8?B?R1BFT3lDK2kza3U2SG1FS3hqU25BT2s4Ky80TXZGamZIVGNNVFMyamZrOXdi?=
 =?utf-8?B?OXUyblNYNy96V2NGUm53MHZwWWxLc1J6SXM0ejR2TnB6dUVzbTEvQkg4Q3Fr?=
 =?utf-8?B?NnlDNC80RnoxeUtXSWVoOFE1aTh6YnpQT0lSYXlFVHh1RzRLQ0c0S3RyeFo4?=
 =?utf-8?B?TDY3WitaSEpHMms2Mk9uZHRUWmhVUXhUS21FbFR6djV2dWRRZTA4U0hjMFZU?=
 =?utf-8?B?QWVuZ0Fjbll0b1pGcGRCY05MUDkybTNmOHhLK1B3SHc2bW40QU13TWZhTnRW?=
 =?utf-8?B?VWphM2E2ckdhaTd5Z2Jsc2I4aTdmejFjUFN3UUgrK0xTQlQ2ZTJUd1FNNUhL?=
 =?utf-8?B?Z1BaYlltc3FkRklBR1FBaFBha2FCeTNLRW5LRHNUc05QNCt1Um9NcTRZVENY?=
 =?utf-8?B?OFdhZzJ0TGVOVlJNV0xJN0tKd1JjcFc3L2w2Wjg2UmV6dEJmSUIwVWZoWkVF?=
 =?utf-8?B?dm5DL29JcWI3U3g3SVh4Z1BpVzVySFYyK3k4TGk5b0JpREFkVFFxcnJ0emFZ?=
 =?utf-8?B?cXNUTm4zbHF3Vjd1RlpVaGdjLy81WkNVL1RyTUt0RlNwWlA1QTgwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d9c2b3-262f-446a-b760-08dec7b72e72
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:44:30.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWwivQ4ZfIkTzceJboIUPJk1puaUlPphDcvxxCFGZz3YyZ9MGTkJO7e06XjhT4+6Vnwx3u2hxLRbuZD6yQOV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22108-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2051B672053


On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> peer access to a PCIe endpoint and use it to program requester-side TPH
> on the outbound mkey. If the exporter has no metadata, fall back to the
> existing no-TPH path.
>
> For TPH-backed FRMRs, make the extra ST-table reference belong to the
> hardware mkey handle rather than the transient MR object. Extend the
> FRMR pool API so reuse and final destroy can transfer and drop that ref
> at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> a ref on an already-known ST index.
I'd keep the ST reference tied to MRs, where the ST is actually in use.
There's no functional need to couple ST refcounting to mkey lifetime.
Once an MR is destroyed and its mkey revoked, the mkey can no longer 
generate traffic, it's just an idle entry in the FRMR pool waiting to be 
aged out or reused.
This lets us drop all FRMR pool changes from this patch and keep a 
simple flow of 'acquire on MR create, release on MR destroy'.
> Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> the requester hint matches the pool key.
I've fixed that in a series I've sent earlier this week, please rebase 
next version on top of it.

Thanks,
Michael
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>   drivers/infiniband/core/frmr_pools.c          |  20 +++-
>   drivers/infiniband/hw/mlx5/mr.c               | 111 +++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
>   include/linux/mlx5/driver.h                   |  12 ++
>   include/rdma/frmr_pools.h                     |   5 +-
>   5 files changed, 178 insertions(+), 19 deletions(-)

