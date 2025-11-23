Return-Path: <linux-rdma+bounces-14684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 333ACC7DCB0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC84E1971
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BE23EA83;
	Sun, 23 Nov 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNARWUVh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477B1DF75A;
	Sun, 23 Nov 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881886; cv=fail; b=cIuH3W5q3QLuwlzPFN5EJg602E8eOxrXOFrbrp3NvJSxwpMUY9SmYxs6RYk1RLPP2enj+VYa5nPNJTifqcNZxe9y+WUYmH2rQw68Rf3yzVsA8ojU1XVPMdISziywvaQ3ZVbWAPi4GIfr+ak3F9F9iowbg3hWJZLMvcyxz8B6dQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881886; c=relaxed/simple;
	bh=4655yzXyN2ZUCy49J1J73ghcXxKiYYrHha2VHqlUhNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+/3gzo6lOP0SjtUDEM7iNwa2SEj3YEq12qgwdURWFNIGZHCer/WMYAchG5XklSFxjC6pCnXMe9KKPJhwZ/p43N4R1e3VLBCLZsGagNhuqvagjDsYn/qfjqZ7zgDYk9kJMYZpSeXM03eQ76cX1dmgBu4hFv4GZCdPkwTDIXBUIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNARWUVh; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnQTlT1kMo22v1I/eHnBxwJrZGLdbO2OmfWhaucgTt1IkrhqLvcCj2GXMIhdrhJXicJdRmku7wkfdBXHBOGRwrkR8Ny100Didp92y6SLSyA5C5VCPx8cGsIztdcuv/1WvWJrnNmbn0jVniguCNkzHOBjQSHiXuWD2OonPUGDuD8OBx2xQpYz3FOo/cTI1ARLwZSDje4lKITO2gmtotxNw8uYxZ/zxMDgLaCWULGHxLLRsEh/dBAg0tWGVK2NznpDLBNoAwjKhPPbyDUYlcpixD193faWVEDGvnxqaogVbiyoDnofp5pPnkCbDgNPxL3Qw8xmxR6FbkLT37KibGTQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qGYgv1eY4RTiHf1C61OERrqdmSFz3jZe1x3nTWrMaQ=;
 b=dvYQw67o7Yt+jKiuFrBLZSVHrMRMwFGhNragPwEYvYDj4J8md4HaL/3WmYAUQUOOjWYJQh8YKEAcJMtJtFiJuwgsnv9dQnZA/9R/X1PmXz73d2xnZzGK8/ezOWNKqiNVMVW4uhpZhbD78U65jcuch9ExOeJC/rq98f0TsrTp/SKwOcM+MCwlXL/kCVEr3cD6wH+lB9/FNE8y2zmIFIkN1fAZU8HixW9oPpdFGhSYA3E5TiEUTzC3hDvTVv69qIrXge5kXZGUi1yXoz1i1EpQP7kBQrf7fQa0xWJ2vM90VQmYWmujrjiWpEp6X1LI6nPDIdMsdV1chX0qBoqmsfiLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qGYgv1eY4RTiHf1C61OERrqdmSFz3jZe1x3nTWrMaQ=;
 b=ZNARWUVhAVhFC4Ldkmn4fSqjZaTPx2nxpEKkl+c5D+i3sKFgpCE4Ls0M+d1FYUZntJ5DtJoRjclQuDwCMqolHZUM3924/gJ60eENiFkaxjrNNJEXhe50QCHqt7JvQqoj9Zw20VnvFIZ2xy5zjdVuvz6LVecdwHZcQ1CJMzpfoCcyHgMHNysgW8vWcU1iot4OZihVxXcuwT2IpNfgm9U7kjAlssULWYkZ1Ohgf7uSa/5ZalWe2T/3x5gG16nBQ2CkYqzdIOYtdu0GaevBCQ92O23GuYk8KKjCvtG2WrAf6rdEV7OMD0F/+OICsbZ3WFJ6jfI3P0pm/EANq5/NecDHug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sun, 23 Nov
 2025 07:11:21 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 07:11:21 +0000
Message-ID: <f0ceaf9d-f5df-4616-b3f8-561bf92a2f45@nvidia.com>
Date: Sun, 23 Nov 2025 09:11:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net/mlx5: Refactor EEPROM query error
 handling to return status separately
To: Matthew W Carlis <mattc@purestorage.com>, tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dtatulea@nvidia.com,
 edumazet@google.com, kuba@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, mbloch@nvidia.com,
 moshe@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, saeedm@nvidia.com
References: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
 <20251119231115.8722-1-mattc@purestorage.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251119231115.8722-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb6aebd-b4f7-4995-916b-08de2a5f815a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTFEYXNwRVJDVEQ2WnNrY21KVi9CS2NhcWVlZnlrMmFlNVgrWDd2WWcwK1Zv?=
 =?utf-8?B?aExIVXlmSXNPQ2FRRFd4RzN2TjRibm9LWVRqTlBURGIzekR3OW5qSFFFUkNX?=
 =?utf-8?B?eG91N3lMREhEMkhHNENSNHBPY3BydmR2UmFxY0tDcUdJTmp0emxabUwrYkFt?=
 =?utf-8?B?eGNNRkc4bFhlbXNlL3dZUVJaZXIyQ2lDZE4zQVJTOFVaYmR5WlNaZWNZMkpq?=
 =?utf-8?B?UlQ0S0toUXpUV0RUV0p6eTVyN09wY0xRVFhaU205dnhDK2VQOTZIR2NBL3lR?=
 =?utf-8?B?QW1RS0hhRU52dmlGRjJBUU9uWkI0eU1RL2QwdnpJT1N0UlVhaTg4cURCTmRL?=
 =?utf-8?B?NzF5cVBiZ3YvbUJ2czF4UzlUenZqVXhhMmhkWVNsOTl2bFJRcGFqQmNRRmJw?=
 =?utf-8?B?WUdYSEhnWUhIb1pqT3BlcUd3ZCtpeTY5alhWSWR2VWFESjlHeU1TUUdxekFX?=
 =?utf-8?B?RldpOFZEYTlRNE1YM0k2a3VGL1FucjJHQU00bzVNUCtCTlJMR1A1MG4wRVZH?=
 =?utf-8?B?U25XM2tPR3VRdXV0N1p1R2doQ2tHVFhycjMyVVBCS0NhZ29RMkRWVWpIc29P?=
 =?utf-8?B?Ukp1M05neWxLU2hINW9wYmREdjBxK1BvMUVSQW50emhzeXh6Z292N2pYenQv?=
 =?utf-8?B?RVZ2Tmg0akVBVTdMZDg4d01PTlNmY0huQmNzY0RRL29BaFJWWHhwNkFOTzZh?=
 =?utf-8?B?eFVBME9lQmNlanM2QUxCYUVqeUFIVGVrQUdPalJPbHNMTDFJcVpoMnNrVWQv?=
 =?utf-8?B?UTVHT2hsemx6aG5pVXFlc2t1UXo3Q1JGMHAwTkk1TlVYem1pYlZsMVVIVkNr?=
 =?utf-8?B?T2RQbXZNV3RZK0tINHM1bnRCVXhPcnFZbHVpTlF4Y0RPSnVmMjcvU0VENTZM?=
 =?utf-8?B?Y1ZzbXM2WVV6YTdBL0xMWUdZTWVEanNCT2REcDhYQzNNUHY4NU9NL3ozZ0hB?=
 =?utf-8?B?MmsxTEE2Sm9PdVhuL1RDRmhtYUhNbE9vTHEwQXF4MW54NUY2WWp4Z0g0dlpJ?=
 =?utf-8?B?YWpLeDF3VlBNbTlZbVdGYWRLR09haStGbVhrYXh4c2hLZXQxVlV1OE0yMFEv?=
 =?utf-8?B?eUt3Wlk1RlFsajlXRjJtYTkxVUVEMlo3NjIyMnZKWlZrVzRHM1FVejVQeUVZ?=
 =?utf-8?B?bXkzQjBIT1pWMVBOMFhTaGRpS0R4dVhyYmFrcjhpaFNNVFdHcklBY05DL0Nx?=
 =?utf-8?B?TUt0MVplMFdZc282azYzOU13dUNaNVViRW9ES1hSRFl1Q2tWQzd1TThYa05w?=
 =?utf-8?B?U0RVMzE1aXBwOVNRM09XSytiMHRNNDFncnpTMURaa2xEMmVNbFhuRS9yZlV2?=
 =?utf-8?B?czYxNmZEZU16UWFoS0ZQRTNpWG9jRHQ1d252SHdhTjlvNkR0Ymc5dkxvYldI?=
 =?utf-8?B?ZjRPS2xLZlZKNUZtdHkweWxxUldhSVVWV2Z5OTJCWlpNVFQ5K1N3emQrbERk?=
 =?utf-8?B?K3QrUW1pYUJISjEzQzdsOHp2WE43QWFKemFSMWpoaEhmamZETUM2ak9XSkVl?=
 =?utf-8?B?UGt5MXFwSHI3UHVPRDF6KzJVUUY5UC9hc3ZHaTA0ajN5V0h4OUdIU2RORSts?=
 =?utf-8?B?VmtMVFpBYzFacmpuWWNkVytVUjlaY1duY1p5bjN3S0U0Z1dHWDROc3Bad2pI?=
 =?utf-8?B?cFZ2dVhsZUcvTkJ2ZllFbVBkUWlRRFFsYk51OEtXYTVuekJ4OTl1TXd6bVpG?=
 =?utf-8?B?M2djTERha2paNEE2RXZUVFVKWndTa3pVbVpjaHpJRGgxUUFLbi9oTWg3SG4y?=
 =?utf-8?B?elozYnBrYTdpa3ZFTExBdEpFc2prTHplemQ1aHJZNCtTNTRlMlVGOFFpbGRs?=
 =?utf-8?B?Mjd5U2VteElHc2txRmVBU1VnZ2VYR3JqMy9BMmthU1BmYzZrN0twUEtxWHp1?=
 =?utf-8?B?R3FtYVJ2b2ZZYkJ6Q2YyT0dNU2g1cW81bjJwcUVFUFJXa0ZDbjR5TERXTDFH?=
 =?utf-8?Q?KuT2Vh27I9Sawihg3eRHx26ZnenmELVu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0RUZUYwc2R3b2pmakRWdUtubTc3UG43ZVNjQUllMXVpQmhUakNtNDNTZ3dk?=
 =?utf-8?B?ZmFCRVpmay9CeHkySFdUQkV2amZHMkV2Wlh5MUhyTFdXRWN5UG9JeEV3dnN5?=
 =?utf-8?B?ZVdhbzJKdmY3MDhhZzU5eVBydFQybE8xSlpYajFLUURpc2IvMG1GVWNFSzJP?=
 =?utf-8?B?enJvd0MvVzh6V2ZHZ0JSZFA1VjhsOTRsaGtiSlJqM0kzaEdadndXWGhQaWVK?=
 =?utf-8?B?RllhTjliY1A3K1hRbnRMTlFIQUdHN09xdklTajBhQ3FnZVZhVWpQalZyNUwz?=
 =?utf-8?B?RmhhU2pCaURnaW9XL3JJUUx5azFQUENWUnlxb2xzVUFtY2NZN2hRWUc3V29J?=
 =?utf-8?B?QlVnZldwSnJweVhTa1dJWG15QVViWkdMbTVhSjlMdWNpbW5ndytXc1lJWWJK?=
 =?utf-8?B?MkxTeHN4ck96d1l6YUVpSkhKRk0xcC95MEZENWlKMjF5WnBpdCtzMzhyK3pa?=
 =?utf-8?B?TkRQdUNlNmEyc08zNWFwNnZkNHJBUEFzQTkxQUlMaVN3c3YyTnFLWFZlUVVo?=
 =?utf-8?B?THQ0UmhGRHhkSm9QSWZKeFVhZkdZc3RrOEpzTjR1WUN2cnZTUXpYTlFGM2FW?=
 =?utf-8?B?UkNiZVhYZXhVTnJ1anAvcC9xSXhWNitiOW1mQUpxckpYdmxnOHdXcWNsWENI?=
 =?utf-8?B?eURTdFBBRURsTmxacDlma3c3eTVISStvYUZ1WlN2VUQ0UjJ3b2RYaDI1eHFu?=
 =?utf-8?B?Y2V1Wms0ZU9HQzE1cWgvbmZaYUZ0ajh5QmdSa0JkUW1ac0N2alJjeDduUnNG?=
 =?utf-8?B?cVRMaTBJZXhmZkQyTTk2eml0cEJDajZmTzVZaERaaUFHbVNWeUJZOWhQdVVo?=
 =?utf-8?B?bDZuZUFpbEJ4elRrbVdpV2crdyt5dTJTdm9xRkhEZEF6cStPeWo1UytYUjd2?=
 =?utf-8?B?UzRWRzdYczUwQUd2elNLZnNNS0xqeHEyZm9GZk1IWUR0eDdieEk0ZUFZNUNn?=
 =?utf-8?B?RTQrWFRjYUphTHVicTI5MGtVaHpMNDRPamVwcFlYQXBnZU14VWZvSXJ1ZVRF?=
 =?utf-8?B?ZHdkbVp4a2ViLzFYN2krSmxwOWxJNVJxd1ljZUFLbU1hUFZ2dXB5L2lzQmRE?=
 =?utf-8?B?VXZqR3BTTTFHay85bHRwckdBMUVsS0JnZGl0VGE1TnpoUFN0NlhqSy90ZUJr?=
 =?utf-8?B?Z2Nlc256OUY4aFluSXoxd0pVVnh6SWszNVZjYnJEbUVaNVJmeUZOZTVQSEN6?=
 =?utf-8?B?ZEc1a1huRFBhc09NYmpQelUvWDJGbGQySURkVnk3UFpVbVE0REkwNG9kTmxq?=
 =?utf-8?B?eDE2VWxBemFZUHh4YWJjYXoyb1doa0FHYnN3MmxSQjhGdHA1Ri9pTjc4QWJs?=
 =?utf-8?B?MkdEUUtrNVJCZldJZDNtQkF4dHY4U1NkNlM1NVRFa3FzVGVVbFdzZXdrZnhL?=
 =?utf-8?B?L2tsQnZqVzI5Z0lXcGZSNUFXNU5pS1RTR1RZY2ROdEFoazQxTktIWktNRzNG?=
 =?utf-8?B?M05zMmI2S2ZsN0o1cjc2L2VwU2NXZVBNMHFLSDNHMWw2ZDNxL04vUEc1ZkFv?=
 =?utf-8?B?bHFsS29TdlNqeUtGSEdvaUVUbXdPUXBkVlVScUpueWpjZTNONkFCd05JQnpa?=
 =?utf-8?B?RWpkVytjYXdvODNRWVdmZUpKU1VGb1g0U1JvZ1phUGFNblpNTVhxemRUZmVW?=
 =?utf-8?B?VElNK3hicVRsd2dqdVdQWlExMkFhR3pSVWwxTGJzWTNSSEx4WHBZbVY1K1BK?=
 =?utf-8?B?YlpiTGxpSHhmTlRoano2Tmt0UW9uVC82U241N001UnhDVnZkbTZLcFY0cHdS?=
 =?utf-8?B?MThFMnlJdmpQVUNWSUhTeEc0b01KZDVNN0MzemJYdXBsb0YxbGhaaEdBTTRT?=
 =?utf-8?B?VkU4L2hKZEw5ckFQR0c0akI1djAzeTBuUmVWK2k4UnZxMWh4bGE3UDlIWms1?=
 =?utf-8?B?b0NwaW1EQ0hHaWlVbVZzTTIzYnNYZ1QwbFpWWTErTVdaUU5ldXdublJRUmZL?=
 =?utf-8?B?RkZ3ZmNLQS9XMmRwTGNqYXBPYWZreDFMQ2VoTXFZeEFhd2lIS2ZWclhYOUVT?=
 =?utf-8?B?NkR5SExEdXBUVEExWXBuU25nZ3EydGtnSFMyQWhUc3dCcXhidEVoTjZQRjR6?=
 =?utf-8?B?Zmg5RmdQVXIwY0xVWUoxQnFjVkMvRWpUMWliczBxVFBVTHAwS05HK1Vra2g0?=
 =?utf-8?Q?LiswjzcGAwvxpheBRLpxHwLU2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb6aebd-b4f7-4995-916b-08de2a5f815a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:11:21.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOB6gUjjfEzcd8UE/mqpoSdINuNUC+iD3u5uvZWK7w0QeDzrHpRNmVFam6QZPKEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

On 20/11/2025 1:11, Matthew W Carlis wrote:
> On Mon, 17 Nov 2025 23:42:05 +0200, Gal Pressman said
> 
>> Matthew and Jakub reported [1] issues where inventory automation tools
>> are calling EEPROM query repeatedly on a port that doesn't have an SFP
>> connected, resulting in millions of error prints.
> 
> I'm not very familiar with the networking stack in general, but I poked around a
> little trying to be able to come up with a meaningful review. I noticed that in
> ethtool there are two methods registered for "ethtool -m".. Looks like it first
> prefers a netlink method, but also may fall back on an ioctl implementation.
> 
> Will users who end up in the ioctl path expect to see the kernel message? In the
> case of users who run "ethtool -m" on a device without a transceiver installed I
> think we should expect to see something as follows?  (Is this correct?)
> 
> $ ethtool -m ethx
> "netlink error: mlx5: Query module eeprom by page failed, read xxx bytes, err xxx, status xxx"
> 
> 
> Thank you for helping on this issue.
> -Matt

The ioctl is the "legacy" flow, maintained for backwards compatibility.

The mechanism to pass error messages to userspace (extack) does not
exist in ioctls, so the output you mentioned is relevant for the netlink
case.

