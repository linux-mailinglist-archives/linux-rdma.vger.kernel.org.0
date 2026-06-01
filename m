Return-Path: <linux-rdma+bounces-21596-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMKQL93MHWrHeQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21596-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:18:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DA623D8F
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA7F73016C4C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427433E5A3A;
	Mon,  1 Jun 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioD+Aa7K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE43E9C1E;
	Mon,  1 Jun 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337852; cv=fail; b=pnO4fIYe1feRT6q/naYE19iZ1fbj7CmnqRQHWvqfyTE0BCPgbTA9oELpsxL5o7u9SxUViRLXpsr6z56O1qZrVZ9NBF37zPLo7l5zAA03NeNGcCbmtoZWEf3YQh09WTgLS060HCynL8UO3i7nGZ20Hb46KnUTQFLXMPWhoNBkk4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337852; c=relaxed/simple;
	bh=XeFZk7cAAG6lUWBAk3W9UwqKZO9VdRTsc7ytfGrBdco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MGCCgJq52cZzA5NVyVM5MV9c02FXKSjT8e8nZSi5SR5CfB8+x8MGBUubChyRdoZWy5D5j1b83YpjqW4UfXJQbjnwzKNlYbGkbxd7YT6HyVkUFGjt+KmNkPqg4UkhTfxoEmJ75gI2ge+vppzK7iCwKFP+hlVqrbzbyCx1Y67X5Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioD+Aa7K; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNqHuSoG9G9SiYFsL44EGGTrwQvNYsXYLJchfTzpG57lJPcmyfEDMT4pspaoYKMC0kTmPYm5Oy1czpe7a7vWUdz2VJHCKX7o3cGkVFppvjp+zDZvl8tYpi/W2cOVpHcQ3eP1M8uJ4NNdmcZN9dLjiEz3RBZW07pratFHo8hrhvbrflFPXtSfkuUwti5s8KJKO1luWPhgWywoOx9z+GH8bm5iOJQnQwk0QFOMH590y5JZ5bXjDgyJbnaDvsGhy9BZYBb3lSdcgdj5tJauJS2dAKaNHpdoJuWl2qAZaQZ/+xOsRuG7gvpDAhvxnwjE72O0BUDbXNPU8GevSaBP5UcfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx9FY8LA5mQhznJL03ZONts/ChEQOkybRbJMeLw6pnc=;
 b=M/vLqtwMiS36KVyup6AlvGpv/7RZyi8Bqi868OWe2pyNbQYhT9fbXGncDKa4PlVNtGDikVS3Ql7vDwNyHGOqHZnhQeK0Gl94EIQu1vPAVgIvHzDRkYuFMw+yqRXj2FZt20g4hfc1hjlOjT+sZ9uz+y8QMJgPSzKM6tBznH2OZ9mowU7N3lp+15GATLxUcZdtL6AwRPdw14VoxMw2UAUKQPYbcB8L3YpWLAkGM1KkQo7VbxTtiiLpfvgIpaeh7kZKGDi1ZyOdPpMrRwS8fqi5Yim77YmpQ1x8hGRImP0mrv1Ud8Pk7g3ybwRRyOGdo/I4G+qeLNPY22DabdldsHO65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx9FY8LA5mQhznJL03ZONts/ChEQOkybRbJMeLw6pnc=;
 b=ioD+Aa7KqCfBa4TgrS1bW8g/pMfOC6O9GbFjBMNqxjjbN5iHwLeFkRma1iNUsn0EmDoyCFFzIiCTQlsXT77/imzPuOyhxE/0xbfJ3AEjlXxioJKrvWxq+MxdgPjOHFlUx7DVQFJ9LNzJen919z/SwmZlGqSXiA3l0HqBBgYFgoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 18:17:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 18:17:21 +0000
Message-ID: <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
Date: Mon, 1 Jun 2026 20:17:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
References: <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
 <20260601174734.GB2487554@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260601174734.GB2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d8bbf-52aa-450f-6010-08dec00a0579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6133799003|5023799004|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sumCnbjVyH84fMyuyA0F+4HdGVmXKAnVUk0dplayfl7BY5V146ja4WnghI9RCyNZCz06gpXv4KowZEnvpU+y5t1x7mNZqSSVa/URn6l6xRjuD054XM1BbcYHJzJfh7izPqsxRojWum+lsD9jtyWEbnqBWiRoPIb1ToWew1U06Rt2wcAvGggPr0zbQaw7ZTg46e8vM6gQBheeqpEZH2fLq6dLRxNjuAJj98M6XxMVmCDblO/7/QUr/zkXTiGkdTuI5BUkdKabbb2/P/PaFTlt3xl0+qOthPn71PI9y5Ano12olc0nJZPi9Hur7duoYU7AG2EJD3WG5Fty+WP4RX0Ikmttsq6hHu5ePvqsptoTV85YfRRIeQ29+OmKTdmpN4U3ucituR40rlE14O7SjT1ZIwK6B3L2SqdmeP8bKjN+XGpwd+MBPjx8zp2rpw8ZEHYoB0ahLv4Cwcg7YcV2LSxGYRoljDskGbCcmrMzXUyFjDNZws1b7bAuGwrV7EOiHIHwM+ZgtchF8H0aWDiufvhHgowQTjjrJDyP1CZz0bDeY529M26mwEQePHBg3OzV3UzFMnRcqoJ5n8kwZRkH03MmwF0qzLlsSVhStLrtZUlI8F6eI1L0vE/TkFNKmOfKMXQsPV5eMFfBU3E+NKhzQVVF9vkxlKN7t3kccVNF7Mm5m4wKyd8/F7pG0WJ500gPF5Nt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6133799003)(5023799004)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWMxZHJETkJqNjJOa3JhMXVqaXdrdzNZcUpjL0o1T1M5aHRTMmpqUkZsMDJk?=
 =?utf-8?B?KzhabFFoOGV5K1ZRVUZZNzF0NWsvQlo3RG03WG9GR2lSQWE3Y05tUlgvWGJn?=
 =?utf-8?B?NWVCNDA2ZnJESEYwUUNvZG9yOUorV3RTME5WaUZaU1J5UTFCNVh1TEtUcHQ2?=
 =?utf-8?B?eVV4MmNJNXhlditsUlN0WlU1eFk5T3F5VXA5c2ttc25lZU0xTkxIMy81dDl4?=
 =?utf-8?B?VEJwNUdFVlBGVlZ1cWJVZnlZK2VSL1hFVnNKQzF4YlJJc01IZm1hY2dqejJV?=
 =?utf-8?B?S0NvWmVqbVZFVVBqV013Zy9mbnJrOWZST3BYN3d5ZVFXUGNLZERONUY5c2cz?=
 =?utf-8?B?cE9hSTI1akhxMWtCdXNielJmbGtHRVl2RXNZdStuWndLMXpGRk1YWGtQME02?=
 =?utf-8?B?TXR3VFVtUlBVTGtRbkFGTC91ck93V20zWnZYclF4dmpJOHpqbG5jRm81cFhq?=
 =?utf-8?B?Z2w0LytWTWQxNys0d2kzMDNqOUVreS9CaU9qNFdNem9iWVJFRGxXRE1MT2cy?=
 =?utf-8?B?ejdOQXd1S1dOZlJ1S2dWb0lTMFlUcnhNNS9nZ3gwUFl2UFZmT1hBdFh6SWJY?=
 =?utf-8?B?ZGtCc3l0aWU0OVVNYk1ibENuWkxDVzRlNzY4aWEzaEVISnJCQ3ZwdFpMakls?=
 =?utf-8?B?Q1ZnWkU2M2NIZkZpVFBhYjVWcWl2ZUpNZTBpWlNMUGJmSS8zakMwQ0gwSnJV?=
 =?utf-8?B?WWZZY3NZT0FXeldPUEZFRktkWmY0Rzk1dCtNNFF5QzhFUElpY3p5NWFHZkhW?=
 =?utf-8?B?ZXp2R3oyTXZnS3ppSk8zZkRJcXNRMUhhZDJBUDl6WnYvSTRFTUlvUVIzNUlZ?=
 =?utf-8?B?a2l1andsSVVIY05ZalN5YkY3U2pDN2VldFM2UllCRkRvTnQxTnEzRDYwYmRS?=
 =?utf-8?B?eE9idDA0YW5RUnFOWXZQVVRKRVZqNEdQNk9SaVo3SU0vcUlVTkpiNmxiTk4x?=
 =?utf-8?B?UlIwSUFGQUpCWVJxTFduS0VQVGJaMDliczFTNHdIam5tMEpmVWpEL2VQalBF?=
 =?utf-8?B?OGJ0eTV5REs0cVl5bEE1OGFPZ2tRNS92SktPem5IWHR1TWdkMTU1cDQ2dlIv?=
 =?utf-8?B?TFp4eVMxeXhoWGplbWxnQVRYY1czc2hYeU13Ykl5RjlFQ0MvQndUVXhZL1Qw?=
 =?utf-8?B?SUcvU3VIYkZKVE85bG9nWmdTbUpnV05Ma2FscS9LcFNKSmkveXdXUTZMMG9r?=
 =?utf-8?B?UjlSSEtHMHU1Z2VzdnByTlpEbG40T0ZQVDY3S2FwNHlhdnkxWmltaGRNRWcx?=
 =?utf-8?B?QUpkQzY1VU1QazYzVXFvYmxKTVlHR3hTOWFtRW1KbGtSQ1Y2RkMwNGcyUDlm?=
 =?utf-8?B?NWZKci9NN3RMRzh5RlFxY2MwYlp0MkRFakZldDNxYlJ3R2FJdS9LVEhvRnlt?=
 =?utf-8?B?OEFnckg4eEhmcUpneHprdDRadzZ2NmR3Y2I2emxGZVpmdjNWOHlKL3gvck9N?=
 =?utf-8?B?cjFBOTJ3RnhXSm9WNUgrMVVTaGx0YmN3UGFhL095allHekVNa1Y1VmUxUXVV?=
 =?utf-8?B?NTZrdW9JMHlRa1J0akxlS0lFOGd5UVd5L0h0OHZpTnR3YTQ1VWNkRkpRRUda?=
 =?utf-8?B?U3lCcjFIVEZxZE8vbjgweVd5SnZNZytFTGZHNjE4RzlTWmFlQ3JSTUYwZ3BZ?=
 =?utf-8?B?VExVY3FHOE5MUm83SEJDaXY1NXJ6RTFNK2ZMaDJUM3o4L0tUTzFQckZCQi8z?=
 =?utf-8?B?K0U1aGlhdzRVTk5wZ2ZVWnpMOHdIU0xzaUpvYTk3ZzV1YXluTnVVVTdpbEUz?=
 =?utf-8?B?WTk1R21aeHdGaEdoOFdacGlQU0lmNzkwU01HRkVvWGRROUQ0WmxpQ3g0SktJ?=
 =?utf-8?B?YnZEUmlQREdxSnRPQmNDbTE2dFdEekl0T3lGRGVzRVpjZHNGeGd5UTQyc0x0?=
 =?utf-8?B?S082MHNuV09WcG9jSGlpaG1ybnlNTzcwRHFPRDdCMmdkanpmSFlNT1dLSUtE?=
 =?utf-8?B?OGsrRmVyaFV2QXY0eWM0RzRxY1U0NkE0SURqaUllbHg2UVk0MThhM2Nnd3Bu?=
 =?utf-8?B?Yk9KdHQrZEt2eG1GcUsxbG53RFZhZFFkOGxreVFwam1aeDBNYUtYbVhpMHpn?=
 =?utf-8?B?ZDgyWWVVSFFLbDA0VE45VFM2cVUwN2VKN0VPSmRSWllGaHNNU0MrOTRIT0FT?=
 =?utf-8?B?QTBqbUxYRXh3ZkhoK3UyRVhZcTBwYmcrTlJTL0pDeURYRXZ6Tm1mZ1FNRStp?=
 =?utf-8?B?QkxJK3g0K0lzQk0rNlRwYXN3b2lNWkc2KzBRb2tORk1zVmdoclViS0I2NmdQ?=
 =?utf-8?B?aUMwVitETWRmV2ZuVTZ4SkkzOE9GS2xJYzV5Z09QYUJYY2ZCRzJhSUJlS1JX?=
 =?utf-8?Q?xR/OdxP8ZsXSmch59W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d8bbf-52aa-450f-6010-08dec00a0579
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:17:20.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeT9AAq5795w8gdHNmI0d8IWBIgq2D7yr8F70r0sEy43l+W6Nk3qzKdL4KUFO6t2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21596-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 760DA623D8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 19:47, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
>>>> When you have a complete open source driver stack which utilizes
>>>> VFIO passthrough as the interface to communicate with the kernel
>>>> drivers then we can eventually talk about that.
>>>
>>> That decision is not up to dmabuf
>>
>> Yes it is. This is the DMA-buf API which is added here.
> 
> It is a DMA-buf kernel API that is added, I think it is overreaching
> to try to veto a VFIO uAPI that calls it..

Well as long as that is a private interface between VFIO and mlx5 I have no objection at all.

But when it starts to affect DMA-buf I need to make sure that it works for everybody. And without even being able to test it that becomes really tricky.

>>> - what VFIO subsystem requires to
>>> accept a new UAPI is up to the VFIO maintainers.
>>
>> As far as I can see vfio-pci is used as a stub driver to avoid
>> opening up the real driver.
> 
> Yeah, that's probably true.
> 
> Frankly, I'd rather they use VFIO like this than to upstream another
> driver for proprietary custom built HW which nobody except Meta even
> has, let alone can use.

Yeah, that's a good point.

>> Upstreaming an API changes only makes sense if others can use it and
>> this here is something completely special to this particular use
>> case, without all components involved nobody else can use it.
> 
> It is not 'nobody else can use it', if it was true VFIO wouldn't be
> leaning toward the uAPI being OK.
> 
> This exposes a PCI SIG defined TPH capability in a reasonable simple
> VFIO uAPI that can be re-used by any other device that happens to
> support TPH on inbound MMIO. The uAPI has sensible general semantics
> based around the PCI spec.

That it's implementing an official PCI spec is a good argument.

But on the other hand looking at the spec it's not really specifying much since everything is architecture specific.

> Anyone can repeat the demonstration Meta outlined in their cover
> letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> analyzer and you will see the PCI SIG defined TPH bits set the way the
> VFIO uAPI says they should be set.
> 
> There is nothing uniquely tied to Meta's device here, or unusable by
> someone else's devices. Arguably this is actually a mlx5 feature to
> allow VFIO to control its TPH generation HW.

Would it be possible to demonstrate the functionality with some FPGA implementing an PCIe endpoint?

Doesn't needs to be anything funky, just the ability to exercise this for basically everybody who can spend a few $ on the HW.

Regards,
Christian.

> For a long time the general kernel has had a philosophy that as long
> as these niche features are generally implemented and *in theory*
> usable by anyone who wants it is OK. Every knows the initial userspace
> implementations of *alot* of stuff starts locked up in proprietary
> software owned by database, and now cloud, companies. Yes, some
> subystems are stricter, that's OK too.
> 
>> So as far as I can see that here is a no-go. But at the end of the
>> day it's Linus who needs to say if that's ok or not, that's why I
>> put him on CC.
> 
> Well, based on what I heard when I argued for fwctl, and the
> discussion with sched_ext, I don't think implementing functionality a
> standards body defined in a logical way is going to raise concerns..
> 
> Jason


