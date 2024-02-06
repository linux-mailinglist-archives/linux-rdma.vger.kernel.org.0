Return-Path: <linux-rdma+bounces-935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1B84BDF1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE981C24109
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381513FF9;
	Tue,  6 Feb 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SgQ00VO2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AEE13AC7;
	Tue,  6 Feb 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246638; cv=fail; b=N1dC8kCLuSpKQE9CUD8heCMw0pUAzpmaJlWaOzSYJZqYSc3y44bS7WmsrZKeNgHo6Vh87swFrfIRK+EDHwURye8o9sIY0HycaRHfYH5s7amhYEXgytbss56BnAiFW6HAd3SUTN7IpwsaqabQKCKXZFhydTFwoFUcXhBfOXZaSjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246638; c=relaxed/simple;
	bh=mWloTn0KFmOvhY+jdhPWwNn1z7QDlte9fZxuljnFZVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBN7bwc8fzSjilXBzl5N0x/UE1xYSAShgk4UpER92E59jhgDkyydcIQDSS5DErBhGw+QfuJc2OSGaH1xk2CPuEf1JSgxLF8fJEAof2liIYLd7A2yRLlIaKha5jRgv15LvqXAknZDnqVGlhUFSsl7QklecKu1PIHRZiVl67l7Dxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgQ00VO2; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsHuIcGicuLjcC2tik0KRr+bu2EYcfCuWRtpAf0A33yqvmNtoQaBFhe2qPfTJSuWuc+AzrOB9CSxiw+kkk7+okswMYCGdXfgI5KWER5BLA/5/MMes3Iz9CjlIYmbir1/pQ7xRqHgE2XK09Muq4aFnXfXA3ol3TJs4lpYZXZPmD5jAQxN18wyIpTR/4ehDdVjFXrIEGtnCkSA7Y8JWdTegJJJHYvzzq0qDhNFsqY/gVGI6LVZNY1S2y6y2s6RNCGdF8RLAzbmTJGrMePrlfASABJdFI4+qJaoHLOWVq5m3S5TGpNgNhLavXYpKk5v6wiVOHgl72I82fpTeK2+HJWOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xTuwAnb/izJd+SFabWfx/EDA3MBo24ZpyiPGpkg+oQ=;
 b=A0gqOd0hO/pIZwzSLImggt/yk2UHp5ZLN/c4VGy5h2H8q5KbfR528FMmywNu1H5ADBU2kHamUaHPUsbi9HoQ65bkLLSIH9p9TtM2i8gheOCW7bwzN7BqXwAOLgeeL9kWq16picf2c2JZsHdolQGB06As7ujvsEs1U72YSVd+q+T7ayYZsKVYi4Nu2yZz9MuWlmY4oCrB3wra+IcYIwxzngBGjgcr3wf5oN9cdgrzQsueDuICEwIV6jX+ebzyDWpGXYdFsTkv2hWLkEII990qzY9iRU3Tdg5Ry8lmBKZx952ekHA12cb0M8CWoZpWW6VvSAsqaDYykKmGfAc1NDwFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xTuwAnb/izJd+SFabWfx/EDA3MBo24ZpyiPGpkg+oQ=;
 b=SgQ00VO25/9n4NeEzyjO+R7J9WprL6cnqugnN8HqFPcsADnzBo0pVoIgUpSMAO2hF4BHoCpWovviK/Kmd1pugMfZeEdoI9Z2z/gyHgCxikCob+QfqzMGFRVTpw4LZpjHJXU/nVogQEzdC0g7OWofVRHeJholU96eGu7ooh3rsMpUp5NAE2poyP7EUtjEiXx3m2FKkWmXAYHohG6fH+ZvZlwvvpTmA9Ldt7JazCSm9TDk+VSAAgRgguYNawksFdHMFWkA/Ir5PkOHbiFfP9NpkkRjLU5Jsj2tEPi8BrF0m0bhEOar4ru/Vm0PadKWHwjHRzGnjuviFPZyzQ8w22xAWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 19:10:34 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::7549:82b1:b8ff:95a]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::7549:82b1:b8ff:95a%5]) with mapi id 15.20.7249.023; Tue, 6 Feb 2024
 19:10:33 +0000
Message-ID: <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
Date: Tue, 6 Feb 2024 21:10:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20240206171159.GA11565@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0451.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::31) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: acb36ed6-315d-47ce-a64c-08dc27474b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aEnklTLv1XcfEDrE9w3ptiQsXW1Gf8QfDgedvHiGwu45CGIXVLnOVOGZiYzm+o1Q+6UrEoMKZw3c2v+8RfzY2kFLD1mNx6E0l3kJicIsZ9hv5wbKTWUadMpwvHbPZ0aiRzqZbYRCyO2gkkOEKUbGDYFaHshIT6Rk/Wl9RqD2VLSNhWj1agg9TlD11OnND7p5GFtveUNlLZ2VHgxc28eLcxqIEUO+pe0chbZSedkRpf9kyBFjefK4KLWOO/rQPNGozEeawx/3E/c1DPUnTw5+WqK8Kk0i9LS/nIo385kFE+L0QC27vADijcaL1N5yyUqncmqGGwb4IMMXOZpJ7IqPl5WDl2EcCe11ZGgnsva2tfZnVgaqBSsEmOEcGHvvxJZl8f72LgJxAgFBRACasjrRYt1orEeLqOEwvHgfRqPBPhTb+hQwMeQmt/yDZvgRH4pNUKsyrnUIO/WqT0ZI9WOLKgG00A2vDk/pKmT7ehu69qGsOFO3eIeillIk5UFi6ZMwkVfejsYI4OdNAjuOO+s0WOJ6tIZvM2X7MgZ88yZLi2shWNjP7Fq3xRt+PQPr/KZq+CWYwz7W/WO5caUBB95g465bmAEAunRTPNp+Dh8Ojz7aJMgEJXVR1701TRkWEO4Sx7tFQhgfrjdLyWKfnoox8H9uQzRNegtz17S09qp2hOechRm8K1A1NjQvjDTsA1ui
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(31686004)(2906002)(8676002)(4326008)(8936002)(110136005)(5660300002)(66476007)(66556008)(66946007)(316002)(54906003)(478600001)(966005)(6486002)(26005)(53546011)(6666004)(36756003)(2616005)(6512007)(6506007)(83380400001)(38100700002)(31696002)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJ2OEdYUERnVzFnc3BEcnFjZC9saVRrd3hqQTRBT1lZVHhhVkk0ZWc3MG44?=
 =?utf-8?B?eTVzSlRyaUNMOXFPYXpCbkJua0RGYm40aWo0WjlsbFMzek5QVVQ3UHF5STh6?=
 =?utf-8?B?SU5mQU9VZUxqSDdLZllYMVRBd3Rtd3NsUVlrKzl3bFNmcnJjUWFRS3RGdkk4?=
 =?utf-8?B?cys0a1RYb3ovZUZGVnJSOVM0RlpRRy9BMllWaVNDWE1sY3ZlWlhHZEFvMUJC?=
 =?utf-8?B?Zk5DaTBHUnRtemp6dmtOSFYxYU9DNjhuTkh0WEMySkg4MFdWZ05CZUlDNUJo?=
 =?utf-8?B?ZTNkNmc1SFRHN0xneXZ4bTA2R09KRllhWC9OeXRxRjNkb2FlWERGY1FucWZU?=
 =?utf-8?B?S1VFanUwQ2U0K1diNmg5WGw4NnV3a2NvU3dNSTdPMXg4MG1kMHdSbDBDRTlY?=
 =?utf-8?B?UXg2aTlPbzZqbUxVMTRmOFg1Szl3SnVQUEdYaFhtc1RDU3BCMWhPdWR1ajZ1?=
 =?utf-8?B?R1Y5OEtSRndvdXRSaGJpbGlZK1RoNUdtSnN5bi9ONjR1RW5mYks0d0dYWHZV?=
 =?utf-8?B?ZERjL1ZPcXJjNVpNbzNMc1BWa1diZzVFVmhQclZ0ZGIrZWJVTDBtYWhGdHZV?=
 =?utf-8?B?QXJMeWtNMmtUb1pSdVBHd3IyNEluaXk5WnVqOVJJOGRDeUdlUllwWWdNazkx?=
 =?utf-8?B?M214VkwwSXhPVWwzZ2k2Y3lKeGI2OVBMRUc1bTNWMVlVU28vd3Z2cm5Fd21H?=
 =?utf-8?B?cUdOVGsyN28xTE45anNvTDBzZU9vUjBMeXhhQTdPTDY1QmUyUUNGdTVBY2ZH?=
 =?utf-8?B?Yk80aHpzSnNMNGZmdkdYUDFrSWFPaXlmcGREaEhSaEpaTWQzZGYrL013djdT?=
 =?utf-8?B?Q1lXNzUxVG1tdlY5cDlZbFNqNGE0T3BiNDEyZW00WXhNSWMrdkZzeUZVVFlr?=
 =?utf-8?B?ajVDaDRXZVIzaE45SDNUTjcvSVF0QmlRSFNzOFhmVEVWc3hvUXVLZDdxeU1h?=
 =?utf-8?B?cmp3YUsyYXJDMkdjWE1xZ1NraUQ4VU5LZWRPMDRteGlpLzBlOC92QTQvcFBm?=
 =?utf-8?B?UFc5aHhCMUJvZ3NMNHh1T29mWm1lNEtTdlNoV2RJcXJnajRTb09TWW04UkUv?=
 =?utf-8?B?R3pUQ0ZKdHRNanhTOEs0M2ppbWJUbnZObXpCTUUrZGhNRkIrVUpNZGRpcXRL?=
 =?utf-8?B?dEtlV0xDZEhLNS9nOTBtRTBLd2x0cG1uQ2UrSG5NaHhUYldoMUp1TnZrK3dy?=
 =?utf-8?B?ZU81WEhFU0JUaHhqNHJheUdlQXVjeTVRUHR6Ulh4WGIzUTh0c2JaY3RlWVVW?=
 =?utf-8?B?RCt6a0pjK0ZOWUpWTUxTR1hkZHBMVGxFb3lndzB0d3h0eDhwU3Raa1o5RHNm?=
 =?utf-8?B?M2dLSWM5Y2t6WUl2SVFIN3VkbUI1Y2hMNzdSQ1JJL0M3RlRTa0FZSTlGOHlp?=
 =?utf-8?B?eWNnbGlYQXpGbVhHZW5aTmd1amZ6K0NPYnhDajBPUG8xbEs3d3VrRkN3UUFG?=
 =?utf-8?B?RTg2dDdabGs3Vm50LytGcDRQcUtWQVdsMmJmKzVEWjhSUkF3ZzBrTE9kUEZI?=
 =?utf-8?B?M2FCM2pRYThGZHhWS1RCMlNmMENZZXhWa0VQVnRhanc2eVhRWnRQcno5MnZo?=
 =?utf-8?B?Q1JQb2JaZWpsR1REd0piMlBqSDFGMVgvK1BQaGJ5Z3hoYWlVamZzMkU0ZG55?=
 =?utf-8?B?RlgwK0RrSTVzOFE3VXpDNThQaFp0cFZjWUFqcTZHU0J2a09SUjFPN2kveHBq?=
 =?utf-8?B?VVVDbXV1SHZqcm9VakM1YXpoNDJXdW1UMGVFZ2F0Ujh6Y1htS1d5bS9xTWxH?=
 =?utf-8?B?UW9TalMzMHR3Uy9zN21vdWRXaEJJNFcrcG9NdW5mS3ZrWVYzck43bCtUUjBh?=
 =?utf-8?B?d3NhS2w0YjRWY3M2M05Na2tpcUNObnpMSG84bHVJL1I4UmRTUzZyVnhISmRi?=
 =?utf-8?B?eWZKSDJWOUlzenJ5SlBGc2JTQlNqUmtXb3NhYnN0cVZDdlZJa0FzbFRnbkRY?=
 =?utf-8?B?R1FsR3ljQ09jK1liQmRaenBDclBWaUcxV1NhenJUNUVBUmJaVmlkbndmajla?=
 =?utf-8?B?ZkROaFBqQ09SMTg2eis4M3hoNCtVV3c1dmVpUGRubGVNK1U5WGNxZitlMGRL?=
 =?utf-8?B?T2p6OGZjYTdRT3BrR2FqcXBrcmtEWlZCUUVIZzRyTXJFSnQzejk5OU9OQXFa?=
 =?utf-8?Q?Tqr7DIq4AYDHQvHJEi1LkOdPG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb36ed6-315d-47ce-a64c-08dc27474b26
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 19:10:33.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2Ia47vKvaBE+JSRHy50lAneShnWO06GB3vF/r2E8UP8VEiXPrFBLaSYdl1eyctWhbOAyIJ7s7TFcqSk1OpT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196



On 06/02/2024 19:12, Joe Damato wrote:
> On Tue, Feb 06, 2024 at 10:11:28AM +0200, Tariq Toukan wrote:
>>
>>
>> On 06/02/2024 3:03, Joe Damato wrote:
>>> Make mlx5 compatible with the newly added netlink queue GET APIs.
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>
>> + Gal
>>
>> Hi Joe,
>> Thanks for your patch.
>>
>> We have already prepared a similar patch, and it's part of our internal
>> submission queue, and planned to be submitted soon.
>>
>> Please see my comments below, let us know if you're welling to respin a V2
>> or wait for our patch.
> 
> Do you have a rough estimate on when it'll be submitted?
> 
> If it's several months out I'll try again, but if it's expected to be
> submit in the next few weeks I'll wait for your official change.

It'll be in the next few weeks.

> 
> BTW, are the per queue coalesce changes in that same queue? It was
> mentioned previously [1] that this feature is coming after we submit a
> simple attempt as an RFC. If that feature isn't planned or won't be submit
> anytime soon, can you let us know and we can try to attempt an RFC v3 for
> it?
> 

The per queue coalesce series is going through internal code review, and 
is expected to also be ready in a matter of a few weeks.

> [1]: https://lore.kernel.org/lkml/874jj34e67.fsf@nvidia.com/
> 
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
>>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> index 55c6ace0acd5..3f86ee1831a8 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>>> @@ -768,6 +768,7 @@ struct mlx5e_channel {
>>>   	u16                        qos_sqs_size;
>>>   	u8                         num_tc;
>>>   	u8                         lag_port;
>>> +	unsigned int		   irq;
>>>   	/* XDP_REDIRECT */
>>>   	struct mlx5e_xdpsq         xdpsq;
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index c8e8f512803e..e1bfff1fb328 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>>>   	mlx5e_close_tx_cqs(c);
>>>   	mlx5e_close_cq(&c->icosq.cq);
>>>   	mlx5e_close_cq(&c->async_icosq.cq);
>>> +
>>> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
>>> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>>>   }
>>>   static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
>>> @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>>>   	c->stats    = &priv->channel_stats[ix]->ch;
>>>   	c->aff_mask = irq_get_effective_affinity_mask(irq);
>>>   	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>>> +	c->irq		= irq;
>>>   	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>>> @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>>>   		mlx5e_activate_xsk(c);
>>>   	else
>>>   		mlx5e_activate_rq(&c->rq);
>>> +
>>> +	netif_napi_set_irq(&c->napi, c->irq);
>>
>> Can be safely moved to mlx5e_open_channel without interfering with other
>> existing mapping. This would save the new irq field in mlx5e_channel.
> 
> Sure, yea, I have that change queued already from last night.
> 

I see now.. I replied before noticing it.

>>> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
>>
>> In some configurations we have multiple txqs per channel, so the txq indices
>> are not 1-to-1 with their channel index.
>>
>> This should be called per each txq, with the proper txq index.
>>
>> It should be done also for feture-dedicated SQs (like QOS/HTB).
> 
> OK. I think the above makes sense and I'll look into it if I have some time
> this week.
>   
>>> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>>
>> For consistency, I'd move this one as well, to match the TX handling.
> 
> Sure.
> 
>>>   }
>>>   static void mlx5e_deactivate_channel(struct mlx5e_channel *c)

