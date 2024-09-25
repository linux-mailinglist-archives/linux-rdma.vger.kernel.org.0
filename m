Return-Path: <linux-rdma+bounces-5082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28509852CE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 08:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4971C228D5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8B1547EF;
	Wed, 25 Sep 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxIN9x2n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6C20E6;
	Wed, 25 Sep 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245055; cv=fail; b=Gdi3oGzNJjrZKUjJ6vFDaju5qb1MOpmFQ2olbHnlhfe1FjjHvNwus9L/DCtNd6RcTkMeaMtbwomwQInOsPWmBr3Y1RhJ3gWfMNT+lac3aCQkhfef4FEA5F82XbQxFztVgqUab/i5a6nQn9icNRzl0yIIa/yzDJmkN1a6pG+M+fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245055; c=relaxed/simple;
	bh=Y/vlkPnCSHck/Wg1Euxc0tqXiFX0+Fqq1z0qkT8FUWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGDiHum3QvuBl0wBr9+OYuLNttlfLNVmvNmpqKDhIg+fLPmNwwRg5qpKCCyzLG1jPbdLzkqIG6aQqNG6ElQeT9/BhGO/PcW6H6XkMf3rA6hOGZoq4YBFQjt40PlLcQiFR/bAhOZgKgrl9mhOqvHks3eqEiMkj30aC1eSVSTkaV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxIN9x2n; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+M5wlJMUC+I3Y1p3nPYtR7pA2x2R1BZBjCsZZ67sdxG6KV8nb0OL92VTPFzuLLETUg2bO6Ya6rRYQa33XsYrxxwwY6IVRAtcny+pGPCyCh3tuBgwK8JZPpQj3ABplwHDGGPiMDspI2kmDmCrSoJPiTs7Gr0DUSJSxcBXePlFYxBzFm3ORDTM8PqU+rX2pSzb9+aJ35INCwlZmWzT0c1xH4192xA7JunR1bWmPnQNpBCHt7poCI/ya22t7mWW5zy0EmZWruMW+SbpRlpPyx/MdGjULOtPfeTVumcKOpExqmATvFN2HWQAL9kEGV1e2VsMCJA7g5+JaqmlqOgPuj5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htqyn6EdlibfdNDMmWsNykqVwf5CfWMuHjlLS7kFz3I=;
 b=qhavcA/SOHy6Ma6tKddreVz7x5NWa0EMeuls3jZsgth/Z8gvI8W5T+02S+p0m5O6lsdpu+Tkz109jO/nZRd+sNstkNxyST51B7YnzA6bPfcvcuIWkIyjfh2/sxXjyfAvXMczjr9yPxJi6mPloldCqK885YgCpUkj6t2DAIR39CmBKcXK5WHwduf6N+38WqhQX0JfGPb9MCatqrWH7hyNjz7SbFQj0rpeFYZUrD/DpUUJf9e6K7fAlf4YGBzjfxB5BLPuUXOnpQobGu7gJ/ghPVZP2YA+DDHwksq/8M0u1Bge/gH2e11jUbrJAZG0Tn4TBynE/9PfXeAoNGCmEj6jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htqyn6EdlibfdNDMmWsNykqVwf5CfWMuHjlLS7kFz3I=;
 b=lxIN9x2nVPKnBKheEOu8YQg+9gUu6esBi3iaMn33y1edbEQfVdIbYfG44EUrOcKvkm59oAC0CFrIrlfwPk7p/9GBx8ClnXHXDMSsuGSOKaeWVOnZt3ddy+obVIapiUn20Eq9REeYuxr9NrlAdGpwKT3yYro5qPQ/4Ov/qf6RgrYxqbX/7ZDh/sEdToRe6sHxcPOfRaqznQ0pGkMGBl1Kf28MWYKEve0O+YM/77IEzgkvA6DRM0KnrYVYIZhp4t5msr1KBwFXzwenhy8/a9JVm7TgrPv+riFemS1cDiCM+IHG6XozmjUASubT/YrP8Yujq9CNuM72/7y7hsqVaKcqrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 06:17:29 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:17:29 +0000
Message-ID: <dd887023-673c-4303-8707-14aab8ccb045@nvidia.com>
Date: Wed, 25 Sep 2024 09:17:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: Fix NULL deref in
 mlx5e_tir_builder_alloc()
To: Elena Salomatkina <esalomatkina@ispras.ru>, lvc-project@linuxtesting.org,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxim Mikityanskiy <maximmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Maor Dickman <maord@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924160018.29049-1-esalomatkina@ispras.ru>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240924160018.29049-1-esalomatkina@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0095.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::13) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: e67f5ef9-3b90-4c44-ef1d-08dcdd29bb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVh5VkI4ZHpVOGVieWUrV0pPb2hlbjdqbjZyVlRjbjhuL3V4R2hLeERzbGpP?=
 =?utf-8?B?UHBieHk4S2pRbjlteWU2UW4zbkFYTmovMnhrNDdFSFZXbUcxZHNuL0dQMG0z?=
 =?utf-8?B?dHRxNkhYTlFuN0F0OXQ5c3ZFMnozSis4TmI1dTh5TkxYTnJPN0pzNDdBZ1Jz?=
 =?utf-8?B?Q3JITEVDSGt6OHY4ZlkvcVJFNkVqTU9MRkcyK1liUWJHMUJuRnUrbU1FV0Vm?=
 =?utf-8?B?SWtHeVRJT2tPQmZ1YXhtQXBFMFlYeFdmMEZQTFRXaUdYdldwMEFycnZNZi9y?=
 =?utf-8?B?MkpKRDVKd001Z3dPVm52Q0ZDQlk0dW1LMzdXRmMrNmh0c1hKLzJjN3cwTHdX?=
 =?utf-8?B?Qlo2OTQyTHNib3V4Ymt0dHU5ZVJrQ1M0YXE2bXA4R1gveGhpcklwdnRhRnQx?=
 =?utf-8?B?cGtWWUJraEg1MWJpaTMzUGdNS2NoczBYckdmSUNhNWZDeG5jUlg3NUVDMWhP?=
 =?utf-8?B?M0JMZCt0K3hmZ1MxbGJCTkg5cXBuNGZ5eTI3RklKZVZFUFpaaFJIRDJsUWho?=
 =?utf-8?B?OGZXZS94YlFaQ1h6N0FLZjJpNXNBMU1xZWZyTTJibGphaDdQc0MrZ2FmT1hK?=
 =?utf-8?B?TzdzczQzY080RVhTTEU2U0hNZ2VLdzFMQ2E4S1VaRElqMGxYWlRBV0lOd29t?=
 =?utf-8?B?aUs0aVBZYXIyanhaaTBNaFhVck84dSttRjZ3WXdrZGYvQSswTUdDNzRjWTN0?=
 =?utf-8?B?aGM1dFBZS2w1aE9DeTF4RktYalRIRlkwQjA1QlBPc3pUeXgzbEpiVlRaY1lo?=
 =?utf-8?B?WEhEZGQ4Qlo5Yy9TZXlZYWI2dy9uRmZ6Sk8vQkFXeTBEdFRwa1NTaXp0dm9x?=
 =?utf-8?B?OXo4Y3AwR2IrSEw2SXgwWCszTUVIWFN2Rmd0YkRySW1hcDFNUU1xVVJzaERV?=
 =?utf-8?B?U3Fuenl0NzBmTnpIVWxValM3WUZKSENsVFhXMkFEODA1ckNRc0RPNVREa0pT?=
 =?utf-8?B?dWJRSldnVEdLOVlJbkxVeE9GV3M2dEtRTlNHL0pnMGFWaU45d2lRYi8xc1hz?=
 =?utf-8?B?OEdTZzUrMzZ4cHVGOEx5Z2YvU2lyY0ZSUmF5a2dWVUlZdjFYTzNlOHVoL0Zq?=
 =?utf-8?B?MEZ5c2lZV1hkL2dVeG8xc1g0L21jL0pQYWZ1akRLWFNjQldiMit4NnpqSUtN?=
 =?utf-8?B?RGFXNGp0OC9JMEkzUEE2T0E5cFR5VzVEdE5MRTdNemJIUDFtdVRJVzFxSENC?=
 =?utf-8?B?b1owcUFOWW9LaFhHaUM1YVoyRHMzbVY5V3AvSXJSU0Zab3oxUXRuampyNHlN?=
 =?utf-8?B?RmVLYXdrUldydUxjVzZVMW1aTG9HWkNqVFpVR3ZoS244b2hrSWJycGlNNGov?=
 =?utf-8?B?WnppVkdKM3hkTzA4NmloVkE3QkpTRVlXVy9wSkVLaFVDSU1qS3FSb2t3ZEx1?=
 =?utf-8?B?bjlZUjQwb3gxRXVzcE1rck9DTnNLYm1BeUYxSEdKdStxZWtxQjhPWDhpRUQ0?=
 =?utf-8?B?ckZ5NjZqSStIcTcxWmpUQjdQMEp1aWlML0psTmJubEttNTZJcnZEVEQ2MHNP?=
 =?utf-8?B?VVdCTFA4K2l2bkxZRGFRV3RPbEZSWEo0N1dhK250Q0JYcEdzYWh0SjF4NlpR?=
 =?utf-8?B?eklwbmxPTlNEY0hCQjBFd2pXa25FbHVRQnI4NXRia0FNK3JpZ0l5UW5ZVitE?=
 =?utf-8?B?cDhPMGRIL3UxUjRXa1Y0TXQ2cDh4Ukp2Z0JjTDZHcFZRNGw1NGVOZXcwWWFP?=
 =?utf-8?B?emZxVjI1NHFPd0I0U0RVbkI1QWNweVExMjd3dVRXb1lBYzhhWWgydk13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJhUXVHZWZTQU9iS1psOXYwb0RXdTFKZXROSHRjTERzZWtueHNVU2t3VXND?=
 =?utf-8?B?VVpGUmsySGxNL0hONk5kVVVTWk80NkRvT0ZXQzVCUkM5VEttZXB2Y2FXUjNo?=
 =?utf-8?B?Tld1V2U2UlhXb05aUTVYaWwvcEtqL1c4VElzL0RTQThMRkpTVlRSMnArOUtS?=
 =?utf-8?B?UmJpWlh6MkJRTitRZ3ltT095TWI4MXNkRHVJMFJPRjJRTlVXTDRHQW1Qb0p0?=
 =?utf-8?B?VmszZzk5S0dFdVJiYmsrSTR2RDIyMlpOQVhiUWhYaEw2VnBqS2VUUmFNamZh?=
 =?utf-8?B?NlJ6YVY3NXN0S1hrSjh4LzdTRlNGSVV3VXFmV2JXT3FCR0tOblNvbDMzUTNM?=
 =?utf-8?B?ZVBOTlhucW9iK0hKU01XRzRpSk04aCt1dHNtUzd4NVowbXhja2I5TDBkV1h2?=
 =?utf-8?B?bDN4NXcxQWpMNlFLMjZVTFJsRE1ZQkwwVHVLdHdwUVVPZ0Y2QWhZc2UxYkU1?=
 =?utf-8?B?Y0xtMmZtQ3VST2E4Y3RkV2QvQ1dBUzVZR1JyZ1UzNEVFOW5aMy9sSVozNUlR?=
 =?utf-8?B?eEZWSHhvUEIyK1hEMktLM01mNmhSaEtTYjY2YWtEdXNaVGp5a3FtelF5VGRm?=
 =?utf-8?B?cWRzd3VpeURRU01Ed1FzeTZFTk5JMG5WM3RscXRmdThoV3NzRThBZXN6a2dr?=
 =?utf-8?B?N2E5RWRMS3BNWDlGTXZmY0h4N1lzMVMzQnRjU1pmeHZFU01WaE9uUU9BTTJI?=
 =?utf-8?B?ajA5aWt5Ky9DZlRpaTZkT0poN08xYzhLZVBaWW15RGY4cGxFNDN3Q21paERN?=
 =?utf-8?B?ay9SL01EK3RGSFA1aWVZSU5Md2p0djFrTkNFWjUrc0JKZVZ2bmwvVEtVREJa?=
 =?utf-8?B?WVMyUVJFbjhtWDNOYmNkYWNjOC9MbHlnejJEYVJLOXQrQ3NnZVl3RVJ0ZGoz?=
 =?utf-8?B?QVArVzBZL1NzTm11dFdzMEJXVzFOSk5sVWNKb2pKbFFNN3RoekU4K2c0cmw4?=
 =?utf-8?B?L1lqZlI5RDBjMnVEWUVLcXpHc1N1NGJjU2EwbDlrK3RYUExLVWwzbFd1aEdF?=
 =?utf-8?B?UjRCQWpYaEV1N1daaWdvaTIxc0ljK3FBeVN0VjF3YUYwaGpaWUtEV2xSWUR2?=
 =?utf-8?B?enQyeTdseUhNRzdTQXpYeGtWL0NUUFZqUEFFaGdpZGZ4UU1udVpEMEZFdGNh?=
 =?utf-8?B?S2RRb0hmZjdBRUFTMWVFVkpJUTM4Z2FOMzlZNXZrQkhOcHZIOUs1L3lkVFI1?=
 =?utf-8?B?M2hFbzltTkVQQWx2MFovOTJGQ29KY2RwVFlKbzRPdWozek5CckNVMlpKTU1z?=
 =?utf-8?B?TlFIM2NrZHdFeGdnRnJrK2xLdzhvSkFHS01HTWlmQURpNGYwVXNneTZza3k5?=
 =?utf-8?B?QVRwTEhtdUd2MUprS2srT1JaYzFHRWlPRWRxOWN0Snp0Qk9INTNuU2N4NmFz?=
 =?utf-8?B?ZGZ1WXlMMmJlM0hQaE4yMWFUYzdTSTlIbjNFRmdlUXRCMTFzRm5oQU4xVnlq?=
 =?utf-8?B?c0dlT1hZYUFOQm5GRHhNN2pZMDZ3UUlNeERBN2NYU1RvdmtlS2hybUdIa3pD?=
 =?utf-8?B?UExKWnVERTVNSW1uV0x1R0tFRUxSNlNGZmxwZ3FuR1JVcitDTFFIMzN6RStB?=
 =?utf-8?B?NzRLbmdjZ2s4RWY0eWFOSTF5dk1Bbkg3aEhMS1ZlRlE5Q0NKTWV1YS9pL25w?=
 =?utf-8?B?ajNkeUluaW40UzdETzhIVFhNNkxnM0dKWWZnVU9KMEhBbU9Nb3lpclBOZjdO?=
 =?utf-8?B?TXJVWnVPK1VqOEIvUEFWalc1eGwyNmVjMFVpRHFJYzZLMmMvTjFMRVkrcnJ0?=
 =?utf-8?B?eG5XR0V6dnN0NXJ2QzU3TkR5aHo4RVpKQjAyNUhjT0ZwbG5WNEJpa0E1dk10?=
 =?utf-8?B?L0JzWEZyZEIvT1RSSWJad0t0aW5EdEdseGNZZ0JXd28yRjNOd1NCL211V2Iv?=
 =?utf-8?B?dU5PWXVicTM1TWFpc3RyM3hlKzJwZ0VuNWttbGJzZFUvNFd4dHFBOEFSeGdx?=
 =?utf-8?B?ZHJaRDRzUGVWMDhhcFdjNTV2SVlTNWhKdnFVWFo2L0dhMlFEV3B3OHl2RFp6?=
 =?utf-8?B?VkU2WmV3WXZ6cmR2TEFacDYrU0xiNC9lSXd2MERyejE4SnNBVkpLdWdNa3NH?=
 =?utf-8?B?OCt4c051Ri9pR0JoY1o2dHJPbVJaaVlXVTRJSVhwYnI0RG1wZXI1SnhVK1lt?=
 =?utf-8?Q?02GVhTTz9oYX3Ks7S5B9gCcf/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67f5ef9-3b90-4c44-ef1d-08dcdd29bb9a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 06:17:29.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP1zya8V39t5CqZRHrnF8mMeWpaLmglV7262R6NjOwTWz0UDQEcK6zmelcoiTS5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

On 24/09/2024 19:00, Elena Salomatkina wrote:
> In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
> which is dereferenced on the next line in a reference
> to the modify field.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
> Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>

Thanks!
Reviewed-by: Gal Pressman <gal@nvidia.com>

