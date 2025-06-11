Return-Path: <linux-rdma+bounces-11218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A49AD6232
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 00:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524B93AB590
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35318248F6F;
	Wed, 11 Jun 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZEG/BsPg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E61E9B28;
	Wed, 11 Jun 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679825; cv=fail; b=cw5HB4rseuyIRhwDvGSnIDjRUifV4YbTURtu13RVN5z2lPUJ7dF7jDbqwS4EfkaBMLuf0kstFa0eUN9MOIE5epzL65aUjktAuNi0w+eEFdjPL/rlEIeaE4DUV0eps87vrXtGdo4jm7yGD2c0ROnaAjiGUUJjEdbZehy285N4e5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679825; c=relaxed/simple;
	bh=sMRp0wzPgt9ZGZ0AlAOKkVzQ2norRs8p45m2hgxdpNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReEBBWeDE/8y6PO+7ogxhahf2PdzBYYKLdOwFbtG6YmdHZp0Da5SWTbXUAaAP6VDuoVD8VgS9+I8CKTuGegy5SLbZLogX2NTDS4l0ps/FHLrfQTOqzfihBZU7s4ihp5xR97D8/aXp7yGjrgJEPVIagLFmyTsqMQMa/bH1dtXSgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZEG/BsPg; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQdqlavXHISgCSMzitm+oxHAEMkNYy/tIevzsFixdBw6yDogKyjJ4b9C+nk7PKBH5NlNt+8xS6nFeuBNBM1SirFtDo+Z/yyJQAuN0w6X3CjesTGOrKF3H08ADb4MwY9U4cWvxXzu1hb/ZyB10jtx+gi7ZNKSt+LONFIWvHUMttxBVRfna+cfpdsCZ7Jv/mmFzJTEJpI5Q9B5DAg5ryEynsH8cPqvUGFz6OZhA4nCdS6vE+6pEK5oOjU2GkpgToBi5SYmGHPHQVymL0VaMx0M0YDY7cpO9eWuiNuj95rN8rQzX+LG+/lzddBYPyRd3uDLGx4UKJclGXBSoxODt9nfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqK4SjJx/MwWGDemjFlH3eqbamPC/QIVx3FpKCLi7Tk=;
 b=styU9ipK9R0awcgRlZWPQB6MT7vYQR/rJAeorDnrBYldw2dQpZLFuc+FWHlJpTRxkW80h948CPq33uZzoEB8fG416qqDHsD5vdjDDTc9tEuwIT4HzqkP38GkCl1ep/XcuCwixhPIQw4CJSl1RFi+hcYpV2G7C68jIzXHBsCzI1/yTP+9Vlg45ekx8AV4VvzUaQNHzDX/NJisM0IfRgdn1KIwayj2XF78e63Hlnump5wxZbpf9fIlDDCDjy/Ac6yHcTq1xbuEly8lMJ9Lo2Tjcq39yFCE/9q/eG+dM1wmpV8IabDW1FeYaq1uuwm8Nf1rHongmaDrJRMXvZ7ooYX4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqK4SjJx/MwWGDemjFlH3eqbamPC/QIVx3FpKCLi7Tk=;
 b=ZEG/BsPgKYO1x+wa7qkiRVGIAsa7BbD7CDoUBTZtfKorfS6KJsAg1ZJtuvr7RmSVV8iQkk18qRuis2wvRFzIQD3mD458yOcJGfdQ4uwl1cu8UjD+CDHUdKYC85Vj82JkJUdN7e7//OPCb05Fkop3c8gyO0olB0VyASBueRp8pUce0bFPgca7acxz6+lVoqVIhitAcYD5Fxm8PRaw6nFhAExXEYCapIXIe/AUNvuFtGhFiF+XDVPTqMWpRuU5uevAcG8WU41lsKt+BAXUyo0pp+Gg64ZX8ZpquXykCRZy+pmhFhyKQSPQfsKzQuodS9r6SghMNLKzQyVAffkxb6oZfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Wed, 11 Jun
 2025 22:10:19 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 22:10:19 +0000
Message-ID: <1070a074-d1ab-461b-b003-d91bfe024df3@nvidia.com>
Date: Thu, 12 Jun 2025 01:10:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/mlx5: HWS, Add error checking to
 hws_bwc_rule_complex_hash_node_get()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aEmBONjyiF6z5yCV@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <aEmBONjyiF6z5yCV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6d084b-210f-4d5c-0fdd-08dda934c06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmM1OGhTT2hLdC9sSVoxWmdRRnI2Ny9TQkp6ZW1qVGJoNS81d1JCTUZzVmk4?=
 =?utf-8?B?T1JNSjJKVUVrOGpwdFpnYXFzbURnenNxVVFiU3RQci9vK1Q0OUsxWlZIRzYw?=
 =?utf-8?B?SS9xVTdSeHpvbzJYMTZMZ2VtQnBCdHM3d3NCazVhV1V1bVlMSDl6a09yNHBi?=
 =?utf-8?B?WXZXem1abkdkcTFTSXhoYVl2UHlML3grQ0MrZVFIRXBaYzVkYjZqUjZKdStS?=
 =?utf-8?B?djU2SzdRM1dVRDRRMVRYemp2YkxIclZmTThYaE9pK28vZm5yM0xpazNCVVNq?=
 =?utf-8?B?MjJhUlNYbXlnSlVYbGN0OFM1Uy9SZHRFM1N2T0hIQjlFU2p0b3dBdlJmWmVV?=
 =?utf-8?B?dVdYenh6bzJVNXp4OWJrZ3RHUGFBMGNIbGJYT0I5ZVBJZktSdE0zOU9NMUov?=
 =?utf-8?B?bkhtd29VZjY2WURURzh4dHIvbEpMNEhlbzlUMUNRbnhEVmROZTl3RXVhSGZl?=
 =?utf-8?B?cWJPdnBDT01aVTV6WDNYeG5ybVIxVk1SSDl5RXVYYVczbnE4RThqQzhUbjcz?=
 =?utf-8?B?bXp3cURVdndVY01EZndOeG84R1RUQm1CdzBjekdxNWdtQnpWRVRLT1BNYlZt?=
 =?utf-8?B?WGszNXpsRUl6dS8zQTBpUXJtSjV3T3RXd2d6eXJwbkRsY3JNN25zVjBraExn?=
 =?utf-8?B?dTVjMGFDRTJ3c2RsRXp0dHVVRlB0WG54M3VSelFHYVVXSkdXQjJDQjBmaUtS?=
 =?utf-8?B?SXFiZzhtUDlZY2EwUkt1MHBwN3NFQTBqbDNIaHJjNmVmVnN1Z2Q5aGVsa1dG?=
 =?utf-8?B?aFptbCtGUHkrUlJBR0NKM1F2TUhmM3NNczBCRmQ2TEV5VUxJaDBvVVh1cnhk?=
 =?utf-8?B?eEQydzZVbitJVFd4NjJod2ppUmhXeTRIczVwWUY4ek5BeXBhMm1qRlV1dGdF?=
 =?utf-8?B?cWRTVlVUN20vZkZ4K3h6dGlMTFp4OGhpd3lCUmQwRG51dE13WmdTZ05MWDlz?=
 =?utf-8?B?NUVwSDBEZFRDNkNiSlNGMlF5bGZjNFNTNVhURXNRVHo5UW5hNXV0SnhySjhU?=
 =?utf-8?B?Sld1b3V5VlNZaEs3aXl1MTRqVUcyNVJFeFFRU0Z4T3RseUhHaUNoay81azBS?=
 =?utf-8?B?OHdKTjVpQzRmZk92OEpkQ0l6djJsWGhPQVhlUFNIQmlWQmhyYytwejRnYm9u?=
 =?utf-8?B?TTdTaHNGRkl4RU9weStRMk1qQ3g1ZXExeUNFZDN2QWVZT0ViYVhDbzBKQ3RD?=
 =?utf-8?B?RTU2b3A5YnBwdStEclhEUlRqMVhIc3BSZXhrU1h5VTVCS296dXVCWlRjak1q?=
 =?utf-8?B?REgxTWNLOS83UGRaNHZ0RjZmQnNjYTZOL0Jick95T0t2QnhPQWQvOVFheU9P?=
 =?utf-8?B?NjBST1ZCUW12MDhLVzJZbjViTzM5RXFUMVhIQk1KU3lDakRTdllUUndBcmRS?=
 =?utf-8?B?Z0pWOFF5blMyTkxBWHRkcWwyTlJQbGIzMWhxMkVkQzFqUHVzU0dScm1xc1Mw?=
 =?utf-8?B?QWtvZDhJeDQvR1pyWmx2b2NrT0oyUDM5OWtlU3BnUWZLdWNKRzZ3dXpjR3lF?=
 =?utf-8?B?cEh0RkRNK0ZuMGQwOW5wanVxTzFGcDZsNUhjZXJvczJtWGRBVWFlVDRSSStU?=
 =?utf-8?B?RXUvM2RHQmhwQ2IzNk5OY28xUDZFWFRrWCtNZldRR1lvdGF0Tm0wNERlYStB?=
 =?utf-8?B?czc1VDV3a05MeThxclZtbG9VOUFFaUVNaEYxZmxUNlF2ZGg0Z25jU0JTMDRF?=
 =?utf-8?B?ODZPK05sekJPMnd0WUpuNm9xaGVZdEpETTBLM1hDN2NTTkllajdPT3VUK3kv?=
 =?utf-8?B?ZHE4ZE42VXpibWZVTUluRUlZY1V0aTR2a1BZWHRDU25lRU1sZ2Ftc29zVWli?=
 =?utf-8?B?SzhUeUhVRnRaSEVoY0RST0VGSDlGQVhQQnNJNENVRldZb0JzeDdxWUpQTkpS?=
 =?utf-8?B?MnRpUjVqbGxyNGRxT1BYZU5JMlIydjFWRWd2WFE0RmpYTzJ1VGpiVFAwQ1BV?=
 =?utf-8?Q?kXASZW1z9yQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpsNVFBdUdhaWVrVXNlU0FwYS9vODFPakpmR1NtWGRvQUluSnpoNERhbjFk?=
 =?utf-8?B?QllRZEdGVk5JdE92WnhBTURUV21XVUM2Qy9zd2tDeHJJeWxTTUQxanU0eTFV?=
 =?utf-8?B?ZCtHb0ZZOWtNTGNiN1hDYnpvUWZ2OFVieWpIVHpYem56WU5pU3VZZlFlK09l?=
 =?utf-8?B?SVBwQjJnM2ZYaUlhU0VzTkhUeDU2R0pENkI5NlhxRWdweFhWd0t2Z0hyRmp4?=
 =?utf-8?B?RjdYNHg5Rm1FM0pzMHZkS1IxNkIyOVhwQjhJSkxRTGZORnlnOVgwbFNOOWNm?=
 =?utf-8?B?VkQyYlR1YUJiUmhJTjI1bUd2cmFDdTJ5OGlhMCtQTldwZ2s4RzVvQUtkbitm?=
 =?utf-8?B?R3E1cEdrTHBBdFZtcSt2THg5WU9YZFFrZGEvUEY3T2I5dWZZZmxBQUk5UWRP?=
 =?utf-8?B?d3pnc3hXamJZMXF2M0pDWHd0YUpYeXI0TWVlRWp0Z3h1YUw0MWdOY1NaMU5r?=
 =?utf-8?B?clgrUGw4eGdsdDJYcEdHeG1PQVIybElrQ1VrQk9pU0d5L0s0OUZURVRYRHla?=
 =?utf-8?B?U3RSNERmeDVUVUxXTE5zNHYwVjl5UDVoQ2FNeTM3cUorTmlVMmpCUFdyR0M0?=
 =?utf-8?B?THFya0hyQThQbW1EQjJMNjdUcng0dVU1NTdjczlaV1IrVTJmajFiT09TYWYr?=
 =?utf-8?B?YjVjNFY0UWpReDExeXdKajlwRnBEejdjdkhYR0pZa2NkQzBwRWNNcDN2ZmM0?=
 =?utf-8?B?RjVDYmROdWY4VFFmN05VK0R4QURibWxqR1FmSktNcFNNTlJIUXlCbnBKckI5?=
 =?utf-8?B?L0RPQWU5enRvNStvU0xHRk80aVVrV3BCaWw1dmthaDhUOFBhSjNVcVg3NzA4?=
 =?utf-8?B?VzQ4U0E3VE9YYTVHempLWmJ0SnFBYWZOZHZwKzZiclk4OXRMbnJMcWRnb3Z0?=
 =?utf-8?B?d1dEZENnQUNLcnBZdmxNQUJnWXliMjdUUEt2eVJxQjBIRkh5Yk91YmFQMnBw?=
 =?utf-8?B?UlpXWU91ckdtL29lelVBUmpRblNPblVlMUE4WUNpajcxYUZFNmhzeXMrUmFl?=
 =?utf-8?B?MGFPeHMxc28wWjBaeEtKUSswV2ViUnJHRVl1M1l3WVdJUkhiekloNWx4dWFy?=
 =?utf-8?B?UFF1QVI2Nkw5TmF0T0dHU0dtaU1NYlVTMW1pY2JYTS9zQmRBSjFlWU92VTVZ?=
 =?utf-8?B?d3k1YUdzNUV4cTdSM2xYeWJCbHQwTkhQeTVpWHlla2dYS1o4QkRnUFZuV3ZC?=
 =?utf-8?B?anNRelhERkg5VGdCcVV6ellRWXdaSVV4Vno1Y0J1emRlR0hRS0luL1JpNGxY?=
 =?utf-8?B?Q2dEMzEwdmg0L0hQZjJWRFQxcEJremZwWWthRmY4ZWR2cTM0elJQYm00UHVs?=
 =?utf-8?B?RXJMRkRpV0lVMkdwOVBINE95bVZBVTdXQ0hnMjcrR3pzZ0Q0d2N5U2h3SXp1?=
 =?utf-8?B?ZkgwaThVdWh2NVhHTGVZdlcvbFJWQldvQmN4YktWaWZ1bURsMTVUSUE3NVI0?=
 =?utf-8?B?MXVRem1VNG0yN205b0xrOTBqR2R6ZStRYW1EcWRwVTJWOE5FMmFqS0Y1WjBm?=
 =?utf-8?B?eEhHT29wQWFvNlZMK3A0MGJsdGFNNmlMZ3Z0TlZHcFdLT1V6cnd1YjM3VWFw?=
 =?utf-8?B?dVpiRnJSMHR6UHN3NVNTK2VWdkRwYUdMYkZSQWtpLytGQmMvUld6cHV4UFpz?=
 =?utf-8?B?NmN0OGdLVys4M1JWM202cFdvVnhEanQ2U3NzaU1hK1lXZEwrbiszN0FQN2Ny?=
 =?utf-8?B?YzRnbGttdm5sUWVBVmF4RjN3T0FhZHg1enJmaUdZdGhiTWhHcWcwOWxCVDkx?=
 =?utf-8?B?RnoxaG5rdjNsWnRsb05EdWxwTUpxWHppMXZteTJrTkJMbDBlU3dxNkZMMTRB?=
 =?utf-8?B?c2h4eEFMU3p3L3J6MmxiNWRJY1BubDRjRUVZODc2Y2ZONHM5VEFSTGtPdEJE?=
 =?utf-8?B?ektxS1Z2ZkdORzJhTDg0TERDMkhWRFUvcld3YmF0cUxpMmhqV0cyTFd4MHYw?=
 =?utf-8?B?U2wrYXpFRkx3bFpZYUc0dHpIYWNsNDVNL3JpK0llcTVnbnVIQWVpNnpaNjgy?=
 =?utf-8?B?ek1GeHdUZE9Sb0s4cTdCdmZjOUtMSk1RNysyMnFKV2F6bEhuUkNDem9qbWtl?=
 =?utf-8?B?UVBZKzZBT1BMU2lSc1FzcjIwTzY2NGVUZTlzWWhmWDdpV244NG1YMHZqNFBa?=
 =?utf-8?Q?B8Hp+nojHJP1Kg59y/ElR5sdH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d084b-210f-4d5c-0fdd-08dda934c06f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 22:10:19.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /h7o4oaeQ8LxTp7c1ofeW8dlBjqEvpdiPGZ2wubSLjhm9myqooBwS94qwBIeT9mGtOOvLePGpWzllId1L2THdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

On 11-Jun-25 16:14, Dan Carpenter wrote:
> Check for if ida_alloc() or rhashtable_lookup_get_insert_fast() fails.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add error checking for ida_alloc() and add cleanup.
> 
>   .../mlx5/core/steering/hws/bwc_complex.c      | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> index 70768953a4f6..ca7501c57468 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> @@ -1070,7 +1070,7 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
>   	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
>   	struct mlx5hws_bwc_complex_rule_hash_node *node, *old_node;
>   	struct rhashtable *refcount_hash;
> -	int i;
> +	int ret, i;
>   
>   	bwc_rule->complex_hash_node = NULL;
>   
> @@ -1078,7 +1078,11 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
>   	if (unlikely(!node))
>   		return -ENOMEM;
>   
> -	node->tag = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
> +	ret = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err_free_node;
> +	node->tag = ret;
> +
>   	refcount_set(&node->refcount, 1);
>   
>   	/* Clear match buffer - turn off all the unrelated fields
> @@ -1094,6 +1098,11 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
>   	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
>   						     &node->hash_node,
>   						     hws_refcount_hash);
> +	if (IS_ERR(old_node)) {
> +		ret = PTR_ERR(old_node);
> +		goto err_free_ida;
> +	}
> +
>   	if (old_node) {
>   		/* Rule with the same tag already exists - update refcount */
>   		refcount_inc(&old_node->refcount);
> @@ -1112,6 +1121,12 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
>   
>   	bwc_rule->complex_hash_node = node;
>   	return 0;
> +
> +err_free_ida:
> +	ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
> +err_free_node:
> +	kfree(node);
> +	return ret;
>   }
>   
>   static void

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

Thanks Dan


