Return-Path: <linux-rdma+bounces-4734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88896B47B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A579428AE76
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C5185948;
	Wed,  4 Sep 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+OVqaYH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79254156F2B;
	Wed,  4 Sep 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438462; cv=fail; b=u7fMJNTKpvZ+1v1iN6xhMYXW2tlbDGzIJRw0Lt2Vl77uWh5bHLTn6w6a8BDjstoqH4Q5IjsTbgU/l+rNZ0BHPkvEQBUEbCva2ZPywqbdrJ6/DjrUd4cd28IeauFowDDJvYdtYg4sV+5+pLvSWtJH1uACyzOXoo0wqNjm/G3YBTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438462; c=relaxed/simple;
	bh=OaYv1YeqEBG4Qwd7XtEoRrPA+6RJVVRx/iof7qAyRew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lAFP4yV58H0RBSjWZ6w0n6YoLmtivTXFZQc6/90iLQ7JlNnGn/H2DfNv1I7FRxhHPpVEhdFAMmgtDFUfsIJ77WtRy5zZXUvvjkqcK5s/dpupWzZy8uhqQymxg66Jb25ll1fSFdkFw2OYjWb0DUcQwf8eEzsjTtEwugA9apkKU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+OVqaYH; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y37bbyYakWHnLR8a2MyV8dpd/FEcthouPQ0ckkgPpdvCK4kDmHRIBsh/9CHx21BifsUr969FanwqvH9Z/XhTqHKE6iwVTPcnD6VBgfkYV4ebgWXmdcWg6o/YDpiMiCkLSO+8XpPQ1gMJhQGwkemWsAkNWBfEjeoy8/CJ+8QI/pbcR5LS8mx4/6FKdMu6V0H/ptjpt6DfAPEX9p/46wxvYRRAO1CtAnV2BU6RKQWQF8jrwNRQcV3Off/lFMPCFykdyRtDB7mh8WuTcRqkoJLcyT07z/UvFfpsdykCw0fhRtr2alULTlgFZu/STwIA1lWo0QmA3JKhsgwqcNxLnaF+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj5b58m8kPgBWLCKtR0+vWahaecSNxMRYsUIi6c/K0s=;
 b=dqBdiPs9NCHS31fngdhP/5U/7v7sp/c978DrbZQu0NzWmgwWyAX4pMsFRoDu75SAngKQW8RfbA6gBQptRnDJHmUpFyyjIEAnoD2uM52sd4ILXF4AvtEf9GKl97UHUNGpEX1WP8L9FRHR3u6JQIl4fPSSRwqmFX4/opg5RyqiHFFsV7j0jLmHkg1gbOYhVa/V/Zf79TN49AWcv+FZ4rC5e3sB39hlrXwbt+LY1D9PZVz7kYzrSypEW3iR4NcGEMT6cP7+CFoVcXSzoLXUJBaZ7UAzkQHwLK0naw0+P+5rcHBW9x2t8geedChm61aJ8H4t9fD+XvjjRBNx5KB5Ul2NZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj5b58m8kPgBWLCKtR0+vWahaecSNxMRYsUIi6c/K0s=;
 b=N+OVqaYHvtK24FfWWiDkG+k6Cq/GEyIcP88JWQRR6BPVJzP5fyv5tErNmk2CsNEZo0yxn7brw0J0DX8ym00lKGE8l1Txu8CXj63XfM8RjeVxvVuHtj0Ouylo8ZtWfhXPH9rQ7yNSeMdPkv3RPPI+1Ssy3CqqrDVOThIQEAMvW+pFS71GnqoH5lOlYJBQ6TzFc3+xW6t4Alnnhcq0Ap+qM6nk25l6/iDXrwJ/Nv/+QbCt7A7z/ApnkbTRVUBfA3frrHowkiuoOMpLDCDbHa9TPjKR0ik/FC2yZ8FV7xFgCo2SVoc1D/k6xUracBUcpxQILoWtMeTLlqZ3xJkCRUBPbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) by
 CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 08:27:36 +0000
Received: from DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f]) by DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:27:36 +0000
Message-ID: <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
Date: Wed, 4 Sep 2024 11:27:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0168.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::11) To DM4PR12MB6637.namprd12.prod.outlook.com
 (2603:10b6:8:bb::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6637:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: c8afd327-c886-4a8e-773c-08dcccbb6e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29mb1hVWk1GakRHZDFtaGFxb0lCMWRoVHN0UnY5aldHVSsxKzBUeWRSVndR?=
 =?utf-8?B?K3pxQTI4K2ZqMUtaVHpzNitLMXl0WmlZRWpJdmtKd2MxYW1UUGFxckl3YXhN?=
 =?utf-8?B?bDZ6T0srVG9sbkNWRjhrc2tYSGNSellxbjNhbjZJWWN4V1A5aDAwcTkrNGtQ?=
 =?utf-8?B?TEZ1WC9Ick5TZ0hKVVZMZjNmaDVFUGljTVJ4MDcyeTBpa01LV3JtdWJQTVhL?=
 =?utf-8?B?Y3FuZDFNL3k3Y1NpZjJXaHZ5bDR3Z2Y1V2dRanVZNkJ5ejVxd1N1WVZJQk83?=
 =?utf-8?B?RkZTeHZSNGxMVEo2YmxtTVFDUmdQd0RnY3ozZFFTYVNLTUpGZ3BpZENaa2RF?=
 =?utf-8?B?b2JlRjhiR1ZoVTA4ZEhpUEhIUkhuSWlaYlRWZU5OMEhQYW9tMWpnY3NLdkp2?=
 =?utf-8?B?Sko1YzRYa1FWTDdKQTczVDFDY0hIdTgyTU9hTjRXdGp1My93NnFNMVc0Zlc4?=
 =?utf-8?B?V0RNZTFtSkdVYS9XTnZQT3hhb2R2YmdtdE5UZzhYblpFVG96V1o5VSthNURo?=
 =?utf-8?B?Q2dCQkpTV3NUcTMrOTFVUTFuOFljc2QwS0pZUEZsQjdhUlJXSmNZZVhrZTcx?=
 =?utf-8?B?TStPckVOODV5RzBKVXZyK20xcEdIRnFHdER6QmtZZXRCc0JMMmdiOGU3c0lQ?=
 =?utf-8?B?VnV0cDJrb0RyWU9MQ1g4MjRqL3Y4WnFsV2NVZ1ppVUU2L2NYdmVWaFc5RGtI?=
 =?utf-8?B?U2hkaXI3UnlJUEs5ckJ6cjloblVzZng4ZmJ1OWdVbkdkWWg3V25Ia3dRUThC?=
 =?utf-8?B?RnlHOG9RN3hTZHIvWXRXd2txemJ6cFNaclZzK1NLOHorR2diZmRORUoyeWwy?=
 =?utf-8?B?S2hiMnozSWNRaXZLcDhkR2IxMnV6UXBwZ3hWUjBxaUdGNHBaWGxUeDRYdFZr?=
 =?utf-8?B?T2hLSFhidm1LNW1RQWpnT1YvdkNGMmFmM2x6MS9FNFltNTBrRnFySzN4R2to?=
 =?utf-8?B?T29vSldrbVo1NVlweklzSk5uNWpZcE96cGRnWnVGOHJzY0xPQzVqMExlcWw0?=
 =?utf-8?B?VVlIcHRNeHFYWC9vaU13S3l0YWJBVjYzM2Y5RkF6bVN1SGNHOVdzWlNPYkxi?=
 =?utf-8?B?Z1NENmxLRFZCRklSdjk1d0FhRlI3MXdVekVYNXZQNjg4eWZZS2RFSlE2aDBh?=
 =?utf-8?B?ckM2dzVrdHJtVisxRUthekV4bzFmTmUxWjVTb0xsNzBud1lJQXZpMm9ObjF6?=
 =?utf-8?B?NGFGZGQ4S1RmSVlmaWpSTFhMc1NscStpSUkzR1BJbXNPYmxZeGlCRUx1NlhU?=
 =?utf-8?B?ZnhOaXZSbk5Gd2lJYTR6OVVLRjJYQ214RlA0eDgxV2taV3NsWWJXU210dWd1?=
 =?utf-8?B?V0tESUc3WDJoRVhhRXB3OG5CTmhqL1FsRTN4UTJlaE5nMzlWQUNSRTVMMzFM?=
 =?utf-8?B?MzVIdWk1NHlJVExsbm5NS2hUMVovOFRrdjVzblRjaCtZa2wyTWtJdWNVcGRZ?=
 =?utf-8?B?WkJyRDExeHJna2pRRWs2MHJmUHUvd2hYK3pYcU5lRGlxbjZiK2EwYnJaQlRP?=
 =?utf-8?B?dkVWSTc0Sk92U3lRUVJRWUtlZC9mV21mV0lhSVBaMlh2alZTZ2VBTTNYV2lj?=
 =?utf-8?B?M05zRVRaRUs4clRtOERqMUZXdnIyOFZIUGhRK0VibTN2VDdQNGVtVzNTZ2kz?=
 =?utf-8?B?b0lEQTFwU3R3b0tYWFF3WDZkY3l2VlduODlIbzh5Q3B5ZlVld1dxV3NWOGFW?=
 =?utf-8?B?aXdsbzVUWVRYWXB1b3lWM09aQTRqUGo2dkJ4cnk3VW9qZElQUGRSZGh5cmxF?=
 =?utf-8?B?QVF5ZzMzai9PdUFiWGM5VFdmOW5nMkZURU5JVG0yRHc4aDdJRVg2Smc4RTlZ?=
 =?utf-8?B?azVQcy92SDJ5QVZaU1ltUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE5OY3JhUFg3Mk9hM0Q2bXBGMDYvTFhzWkVqaUhpQ0Z2NnMrWnlyZ1ZnOGQy?=
 =?utf-8?B?amREajBodlVCWTJaZGkvU3NuMmVJY3hPMUJWVE5IdjYxdmdhcHNva0lZUC9O?=
 =?utf-8?B?MnBEQzF5NzJaNHIwbXhxb3RqaW41Zmwxd202TmFqQ1RRRlZyMldRVzI4YW1S?=
 =?utf-8?B?Y3prV1JQTHRoTnRHbU15RlpBTFZnQVJLaFJlbXhTMW9CREN2YjF5WjA3T0Qx?=
 =?utf-8?B?SHRXYVFsdjhGWlFmUkg5QTUxYmhHSnZKVHUwVDJSNXEyaTZnSmJ1L1RXKzlK?=
 =?utf-8?B?dldUQ1VoRzdZODR2S29xdHNsakh6VjVueDVsWGRpR0N6RDJNYU5nQWV2eisr?=
 =?utf-8?B?WHJvMFpRYmpNd0tOMEFabE1kVnozOENwUEtSbXUrNFBMNW42ZTZlSzRZYmNN?=
 =?utf-8?B?bE1vTjdaR1hRR0tmZGxDdFhCOEJTejcwcnlhRG8xWWp5TmZnYkpDK0FkQWRI?=
 =?utf-8?B?TUx3bzAxRHRvZU01T2xQZ3ZiNDNhWlRvTDRBb0F6ZzdyNXRMWDB0ekNTRnZ6?=
 =?utf-8?B?NDNwNG1nOUptUGZqMWNsMEdaMnVJZ2F4RG1LUzJQMkRyZUROdG5BaUlINUdh?=
 =?utf-8?B?VXQzTjRRcldhMVVZSndSZEZlT3NPRkMyMGlJei9WUXNVMks2NTdRYSsvR05Z?=
 =?utf-8?B?VUs2dmxlQ2FJdXByeG9RNDBHTUY4YUphV1hXMHFiZGFsc0xrZEJoU29KNWtV?=
 =?utf-8?B?ZUtObG5la0wxVk0rQzdUSGNJcG1qZlBJUXNvakZwamtsNWdFVTIvV1J2UDFH?=
 =?utf-8?B?QW5yZFNTT3h4UWY0R3prWXY4dDFMQUpReEhpaTdOWk5vV2FDMlNRcFczTTkz?=
 =?utf-8?B?VGJiWGpVR1pmZTNNT0ZDUU5qck5TQ2JDdmIyQm9OUkMrbDUvUUM3M0phZElk?=
 =?utf-8?B?RXBqU3hwWW4zRHhJWksraWZWQkR5UDQvKy9NeXRYdnhCYkF3ZmFMN0pwNENF?=
 =?utf-8?B?bUtqcFc5ZjB5Y3J3WFgrQlBWS29Nb2x1cUcycEdqNHV4ZzFjQXpTM0d0TnJk?=
 =?utf-8?B?TTF3L2lybDlsZWtabEhOQnMzay81dHNFcURldHFIQ0NVdDNJeXQ5Z2haa2pY?=
 =?utf-8?B?MVd1VnhOdmtyS3czVzk2QWtNRkxVcTB0K0oyMTRubHBNU3B0NFVvZHhpZDJz?=
 =?utf-8?B?TllYN2FJUGJOeUtDc29ETTVmNUhTd2JNWWNNUWIxdk9hR3k0NXpFODN6WXFN?=
 =?utf-8?B?RXIwTVEvMDFjSUwzOTVzSVIwOWxtNE11RTArN3Fyd1ZISkVINlVTamRlT24r?=
 =?utf-8?B?TFBXTzg1NzNldzBWMGNzblRPWTRGU1N4LzlwTE9oQll4YzJBTmVzUGlYalZu?=
 =?utf-8?B?Ny9kUHEzMS9weVFMWVBxZkoybFpmNU9DbUJtbWY3U2RFemdqMEQxNFBFaDU4?=
 =?utf-8?B?MGpSMHVSTnE4UWFrRWJlRmxBVVpMRkY3UWlNbjFackIyMTVxT1JxVkIwblI1?=
 =?utf-8?B?UStTSThnZjY3azNISi9Ib1Q5K1VLdGY4V0c3emR3YlF5eWxzVEx6dUoxZDIz?=
 =?utf-8?B?WFV6RlVCK3grcXppZVFwcXNJeU8vM2RZNU9MNW44anF1ZmwyQmxNcFFYUG1H?=
 =?utf-8?B?N1lwY2M4QitYdHlSa3dhWHFlWldsanV3THNrNlNDQzNKQXVUcEVjL0F6c2F2?=
 =?utf-8?B?OU9odTc3eWJQSVhVbWI0TEVsZkZiRm1vN3dxRmpXbmpkdlU5cS9SNjdLQWRl?=
 =?utf-8?B?TnBPNEQvZmlKRWJGUk5VZ2JKOXo1OGQ5TVh1REl2cytFc2swcjcxT1ZMOWNh?=
 =?utf-8?B?TFNQSUZJOE8wbjVIUE51R05DOXJMblZDQzIxWHlIV2RseXdyaFdNdTEvMzZ4?=
 =?utf-8?B?ZlpNbG1TNk05WGlOTWdRdWJjcG9UNTZLanllRVJtK2xFSy9JSnB5UXlIekph?=
 =?utf-8?B?d2dDcUFreC9xazdXd2x2Z0dhWmJIQjBuN0hqSEtoTGNBazlWNTN5anY0eld2?=
 =?utf-8?B?ZVFpdzA4YVlUQWZvWnN5QW9uZEhaSER6eUZLVGoxS2hXRjJRdjNlTTBtL2JN?=
 =?utf-8?B?a0R0bHNEc0kzY3RWNjF6dVVoSnZoYU1NNWY5d3N1VkVlL0JKZyt2RXdqNDh3?=
 =?utf-8?B?dTNKZnZOamN0ek9VWFpDNEhkVlRJVHlaOGloNlN4R1lDUmhRcGNxTFNWemtO?=
 =?utf-8?Q?trs9Mo9LB52zzWjjZUEGMvvoG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8afd327-c886-4a8e-773c-08dcccbb6e48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:27:36.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caQBox8gO6SNz6lAgZuXyjcyrd3mdbTwiWKVQJvRlxEJb6Sao7gz/kw91WqGvxBICYfOC48GnGtjNAyQfSSc5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249


On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
>
>
> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> Hi,
>>
>> This series from Edward introduces mlx5 data direct placement (DDP)
>> feature.
>>
>> This feature allows WRs on the receiver side of the QP to be consumed
>> out of order, permitting the sender side to transmit messages without
>> guaranteeing arrival order on the receiver side.
>>
>> When enabled, the completion ordering of WRs remains in-order,
>> regardless of the Receive WRs consumption order.
>>
>> RDMA Read and RDMA Atomic operations on the responder side continue to
>> be executed in-order, while the ordering of data placement for RDMA
>> Write and Send operations is not guaranteed.
>
> It is an interesting feature. If I got this feature correctly, this
> feature permits the user consumes the data out of order when RDMA Write
> and Send operations. But its completiong ordering is still in order.
>
Correct.
> Any scenario that this feature can be applied and what benefits will be
> got from this feature?
>
> I am just curious about this. Normally the users will consume the data
> in order. In what scenario, the user will consume the data out of order?
>
One of the main benefits of this feature is achieving higher bandwidth 
(BW) by allowing
responders to receive packets out of order (OOO).

For example, this can be utilized in devices that support multi-plane 
functionality,
as introduced in the "Multi-plane support for mlx5" series [1]. When 
mlx5 multi-plane
is supported, a single logical mlx5 port aggregates multiple physical 
plane ports.
In this scenario, the requester can "spray" packets across the multiple 
physical
plane ports without guaranteeing packet order, either on the wire or on 
the receiver
(responder) side.

With this approach, no barriers or fences are required to ensure 
in-order packet
reception, which optimizes the data path for performance. This can 
result in better
BW, theoretically achieving line-rate performance equivalent to the sum of
the maximum BW of all physical plane ports, with only one QP.

[1] https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
> Thanks,
> Zhu Yanjun
>
>>
>> Thanks
>>
>> Edward Srouji (2):
>>    net/mlx5: Introduce data placement ordering bits
>>    RDMA/mlx5: Support OOO RX WQE consumption
>>
>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>   drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>
>

