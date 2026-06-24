Return-Path: <linux-rdma+bounces-22441-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6htbNAONO2qkZggAu9opvQ
	(envelope-from <linux-rdma+bounces-22441-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 09:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDCE6BC5B2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 09:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="mWy3/XF9";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22441-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22441-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39CE1301C137
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2039A7EA;
	Wed, 24 Jun 2026 07:53:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34245388E5A;
	Wed, 24 Jun 2026 07:53:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287615; cv=fail; b=kgge/gIOeBqIMyc4ahyoVF5iaJhk8xoYHu61j67xdeXxeMmNTYsQ/KY4UIdG/hP7fOJspogrF5YNgiUTANuzMkWqWN4ZbaFeuYSV2aWkXyP2AdC5yJyUMkqewmmVjJTADZgXiWBlBtHeJ2ocAsvHLmwvYVq1YMn+iWS6Jj9rEWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287615; c=relaxed/simple;
	bh=t2ikTl7J5oobg98gYD51dMZ5G0HemfB3120zx8KGTBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=raG+3ErDJTH6ZlY1jqvfYNGN8KdnwyA292VElB/bveEIHIU8PgNXDX7GhlTuhSBgcp1kHx0+pr4XBboszsR4p5Y6QS9I5ebuTCbP9uRvtWR3+CAjv0bAQ6h2g1Xzm4DnUKw+V4rDimJEDmRaYbvjKohORCDQDsZRq4ROauGWyUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWy3/XF9; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itO1e1+TsfmK9sSdW8c46tCmPwejjytx9IPJtrrXshkBTyVU7y9g2fbVU3Df6jgV53m3T3YvTvanrRnGwoOH4+pvwI4LuSMW0sooj0zXwjeu1o1T21zhhzunjH2TrLbyAZMKcFAA5yNQs0Oxo5kmqKTHK3FNgVZUMIKk2QZOmGDFncp6kKD+m1eifCzKcceyRk0ebJnPTDUbbYDsRtYDL0lf8C2eLug344rHNvN78on+GVLMroBbF1tLHuMKSMSGKx6k8r+UuQepiUVELLvOs88660Ctw2U0bMHX8J+vZ8aJN67bNewLtlSX1wfPkl9vPklnsZLreycTu8wVG3mqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q8eI0qDm5J0jgeZSUqP4aN3F/fLXwolnJVaKvWoBgg=;
 b=a5y9oNrkFn1oIH7DU3GvP1uT2jL3lXBBddVSsSQaa2JzvCcjNG+af7JPRk90P9IroSUCbzcweG15yWmp2BghY6bckOXeyYElRo+9WgKUg5O1v2ws7i9dyc0IsDtN/Us3hESmlXpbXMbkPanxQBRMfTw14I0oJcyLEzcVKEHP/0N4hplcDd9XBPo2eYXGJ1X9lnUeiokXeEVsVxoXdhfrtTHmtJWSecCzvVkvfnTfqZ47NhkyGQX5KuuhA0C1vp1PiUavu6MDD1GMJYVjDkGRX+dZXL5qRytlGY6UNBQ8eEB5fKfJ1/LRMp8wsM8cgXR9B0x7VaRpa88uVYkeTaOLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q8eI0qDm5J0jgeZSUqP4aN3F/fLXwolnJVaKvWoBgg=;
 b=mWy3/XF9J66srCVEBofT35CFxZ3BYSGPuHRsNu9nCKlUtw1lqKAW69M9R3lyWrqOo3l4FG9e4AWyYKig9Lm+er/QaXKeYTH1JPh0ns+4sYS6/xh8dtHsa0d2+P6bjO07pNvfYsPVgKGxItbobLH8F6wFi9sS4K4NqsyNxqGfJEEW7rtZSGee9keA1TXC/h1JrLcXxvqx9VU1o3/Jj6Wbo8P+K1plajDkb8TCNHM3IuP1Vw/tkz0UfR/OTGUJd316jK631n3pDeSgTBPcnmNb2dfIQG8LhBlp7UsLSd89s55KXgml93FYmeDaoM5AZKmCzqkgCO1MRdBY/U4pMebXjA==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 07:53:30 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%3]) with mapi id 15.21.0139.011; Wed, 24 Jun 2026
 07:53:30 +0000
Message-ID: <c99a9e39-4791-4c1f-be47-9eb7a5f30045@nvidia.com>
Date: Wed, 24 Jun 2026 10:53:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer
 allocation
To: Simon Horman <horms@kernel.org>, tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cratiu@nvidia.com, eranbe@nvidia.com, feliu@nvidia.com,
 haiyangz@microsoft.com, lkayal@nvidia.com, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, mbloch@nvidia.com,
 noren@nvidia.com, saeedm@nvidia.com, gal@nvidia.com, alazar@nvidia.com,
 cjubran@nvidia.com, kees@kernel.org, eranbe@mellanox.com, saeedm@mellanox.com
References: <20260622083646.593220-2-tariqt@nvidia.com>
 <20260623104624.1073738-3-horms@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260623104624.1073738-3-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4373d7b0-ae87-4fb7-1642-08ded1c5ae90
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|5023799004|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	6joFvkAZKwxD9ugrtz9HdXAOv4LrNgCxsqyBmwwxNVqrWlotOCIisPUwM0cpmdRh3t3L3IKeglxCm0QX9ZJ7OYyuPChLEuB9e2peY7fUGDda+MqUwD1nh+VCWFF0eBDh+EE5XHkNQvdGZOqApL/Fc9/u7ZGKXmo+6f6yq/49BkbJz9KHD4V2pZ258IrOc9HK2JvFCRGMlZiL3veE+wSaHf1ix0jPz6Xoe6mmMSlcjoHHQ7hxFk3BvdRrnzUoQHAfu4TZGnXUjvK6ZAxy4n37B4/GZpKrr9m62owX2YxGscBof0DXbJu7R4/L8j5dBuyotTo+c+arKrQttRWkXZwi5Q5JJIz4n7IFu8OWpZvmI9NJg0JqYHS3fA59wDydlayFSYT+iJ5hHCS2gCNCWkZZ1/M2beOGo1HtQVK/G0dz2be8XE3l+tTopJZJ52d4Py7G2Z9WPSn8wgJIWEtoZYN9zrxXLcvYg6xCUt7F5HZPUZhQf7cRwbwjF87bH3RdKyT3cG8bVX5i29sTlu6l1xRdcLU+yv0cLYsUE/Dz+laJnQPzQP4+YeFk9rL22Cpwcztnxf5NZrpOTrNG+DIMvaSP4sThZVaIz0u25O7iWleJQLZZzyh9AHQNX4kvjbdaHvMAHhchhGMjCUGuNfO2y2Wyht7EY9cnIMjCzXytROPEPh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(5023799004)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZvcmFNUmx1ZW1oR0F4MkdXOHVUem1MR2hGNnZVRUEvbmI2THZtRnRRMldl?=
 =?utf-8?B?L3ZEVGpGMGUxZFNVVHE3UFJEYWhNc0xkZEhUTlNIVm1ndGk3andzaExyMHpW?=
 =?utf-8?B?MnVVS1ZjT29SUXJ0Z09vTDRMbFZ1d1ptbjJ2aXIwN084UmRKV1J0NDNlWUNs?=
 =?utf-8?B?L3R3YkFTYnhxczZxSGR5Y0hZR3JSSUxld0lBdVd4aGNLR3h5b3hGUUc0RkI3?=
 =?utf-8?B?MWx4UjlybmlIN2ZxSjBCelhqYXNSQysxMVd5SXBhbGptWXFEMDhiQUZ6QTUw?=
 =?utf-8?B?WHArNmR4cU90aEJFTkthRTRYT2VOQmIvOElHVitoUk5FUjVKSWE3Ymp0ZHNL?=
 =?utf-8?B?TUJDdzVDUFY4WUlHTzVhSXMyVWNxTjNkVXZDK3BSWDhYSGIra3lYaGw1RGVp?=
 =?utf-8?B?KzMzMU84MjdwclNZcjhTbjcrZnJvbzc3V2ZGQWZvb0VqaloyaHZUM3Z1dnpa?=
 =?utf-8?B?dTc3S1N5YnBBVmU5d0lJYTdvMTRtQkFtSXlHMi9tT2VBSDRhYmpIcCtkcmV5?=
 =?utf-8?B?Ry94aXVtVCs5R1hpcDltWUMwUHZTbkVnVk1RTTNDNWlIVVNGaUpzTUJKMHJP?=
 =?utf-8?B?MGtuYTBFd1dqTXViZzNCbUlYK2lDbW1wTXBiUWxiNFNFVVh2VFN0Z3dicVFl?=
 =?utf-8?B?V05VWUJDOXJFOExkSEFNMFBEUFVESUxDN0ZtYUFJUFozemc2QlY4RmI1TUcz?=
 =?utf-8?B?cG9MYm8xT0FRYUlFYlltSE1xNXZPUnFSSWsxSGllaUdJbmVmMnFORDRvNEFV?=
 =?utf-8?B?R3JETlQ5SjI2U1Z4Q3hwN2NtY0tydzVNZGNNZGcxZ1ZnUklpWVBCNHk3Rng5?=
 =?utf-8?B?VjczZXRPc1QwVlJELzVZeDExV0R4RzhYK2hQczFYVVFTOGpqMHdCM0cwWVBC?=
 =?utf-8?B?eUVqMFE3dko3UkF0UmZTckpUL1hsVVkrM1Z0VzR0Sk0yM0xWNUNUcVVOOFZQ?=
 =?utf-8?B?WUdQb0M1VmRib2t2ZWZEUWhuUWJBQjNjVUtzYjNrck9MbGVJZ1FqNjJ5U01K?=
 =?utf-8?B?aHRDQmt0MEdEdHUzS0dObHJSckpCdU44bTB3VVhEb0thTGQyTmpDaWtSNW5m?=
 =?utf-8?B?TnFLNkUyRDdueHhpSmxpN3VhVzJNZk5idlBWOWE2SnpEKzJuajl4ZEhSRVdi?=
 =?utf-8?B?TlZvS3JoTGlRT0NVWng3RWFoMlNhdFlZTUNEaG9PeEVFdklrZGRVMlJUbkRt?=
 =?utf-8?B?K1RscHJwMXN1bXhzZmdLZzMxTE03WXU5VGtYNGt2TUxWVWVxWWtQSWZSSEoz?=
 =?utf-8?B?WjA5MTBJQ3NIbEtsZERuWURud3EyOGNHemljZlE0WkFqUkFQdXp0T0dqRURa?=
 =?utf-8?B?dXIyQWVFeEpWczdvUlowRHUwaXFxa1RRY2wyanZjTkk3eXpmYjdBcTdjT1dO?=
 =?utf-8?B?MXZ0ZmQ1eXV5WktXL1AvOXVQVXhqd0FYejUxNUd4NENTa09iV1JXOHIvZjBG?=
 =?utf-8?B?REVkYmVZem9qZ3JkUk1IVkpIQ0ZGaTRuS0VjODIrVXJ5VjQ3SjAzcG5Cd2JZ?=
 =?utf-8?B?c0lzdEhNWXh2REo1L1ZMWGtreG9IemdrUWR3TjZyNW1UUi9menoyRVFvbFBy?=
 =?utf-8?B?eXFnWW8wWW5EYnlxa3pXUUNIazZGT1B6U2Ezc050L094enVCTkNHdnYzVVd3?=
 =?utf-8?B?MzZTQkRhaC9oa1cyOVUrdk1LY1FSMnZEb3JRNTJGVmp5elFqSFlYb3ZSN2NQ?=
 =?utf-8?B?Y2ZHU3ZhOElFRHkvdG50eVdIdzdYZThwNUZFNUxSbWMyenkvQnpPcUZUTkdQ?=
 =?utf-8?B?dDJOUW1lMTh1NS95aXMvSHpsbkl2djhGck1Qcm55UlNBSkNQRUREYnAwdzcy?=
 =?utf-8?B?L2wzTHd1R3BuZGVMdmlJdUhTZFVFbldBVzF1aDJtK2szWjdvamx4TVd6dXRC?=
 =?utf-8?B?L1RwVFVIN2pXYVFad05aeW5uYXNxYmxrRHVCUDh2d2lDZUNURFFUQXdLZkty?=
 =?utf-8?B?RmNSNVl0cVFGTHlCdGNZRHErZ0pJekxKYlc5c0h4Y1dvUFR3dE02OVg5ZDZh?=
 =?utf-8?B?Z21abWFEM0lpRjBQelBkZGNiRWcxaTNIV3ZxT2tQbmIzY0R6ampvdDVQTGZn?=
 =?utf-8?B?MmIwL21FNVVnNnhaT0hsSk01bnBrNGZHd3A0RmUyZ3R0SzRHWm1lZHZpRWNy?=
 =?utf-8?B?UXhVcVhURFpJaWZqMWZjNDFkcHBmVXR3ZlFZU1pDNUxJTmh1bWFFZ3pabk5V?=
 =?utf-8?B?TE1yY0ZvNlV5a09BOU96aDAyWFljakYwSXNDUFgrWU8vWnVBQ2IrZFhDUXpk?=
 =?utf-8?B?ZTBxMlZvRE5TSzkySUJyZUw4TTY4SFNNcGxZbFFFUDcrWnA5Q1dPa3o2WDJ4?=
 =?utf-8?B?Q3hvT1l2ckFJbmtMN0JVZGMvL2l2WG0xYll4V3ZaQW5IdXhiZzI0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4373d7b0-ae87-4fb7-1642-08ded1c5ae90
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:53:30.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3Xkp0ScE9R9TnD86Fx8JvZfOo4j2rC1729qPePXt+b6Jb3w+495pAYEqlREqdmQFFjNaWE1rvCDy7qwzWmeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22441-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DDCE6BC5B2



On 23/06/2026 13:46, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> 
> Simon says: I think this issue can be addressed by reversing the order
> that patches 1/3 and 2/3 appear in this patch-set.
> 
> ---
> net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
> 
> This commit fixes a zero-sized buffer allocation by using max_nch instead of
> stats_nch when allocating the buffer for HV VHCA stats.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
>> index 195863b2c013e..06cbd49d4e98e 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
>> @@ -122,7 +128,7 @@ static void mlx5e_hv_vhca_stats_cleanup(struct mlx5_hv_vhca_agent *agent)
>>   
>>   void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
>>   {
>> -	int buf_len = mlx5e_hv_vhca_stats_buf_size(priv);
>> +	int buf_len = mlx5e_hv_vhca_stats_buf_max_size(priv);
>>   	struct mlx5_hv_vhca_agent *agent;
>>   
>>   	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);
> 
> [Severity: High]
> Does this change introduce a potential double-free regression on memory
> allocation failure?
> 
> When mlx5e_hv_vhca_stats_destroy() cleans up the stats agent, it frees the
> agent but does not set priv->stats_agent.agent to NULL.
> 

Good catch on the double-free, thank you.

Swapping the patches has its own problem: patch 2/3 also modifies 
mlx5e_hv_vhca_stats_create(), so applying the race fix first would leave 
an intermediate tree that still has the zero-sized buffer bug, which is 
exactly the condition the race fix builds on top of.

Instead, I think we'll make patch 1/3 self-contained by including the 
NULL assignments in mlx5e_hv_vhca_stats_destroy():

       mlx5_hv_vhca_agent_destroy(priv->stats_agent.agent);
       priv->stats_agent.agent = NULL;
       kvfree(priv->stats_agent.buf);
       priv->stats_agent.buf = NULL;

This closes the double-free window in the same patch that opens it, with 
no ordering dependency on patch 2/3.

> Before this patch, kvzalloc() was called with 0 and returned ZERO_SIZE_PTR,
> so it never returned NULL. It always proceeded to call
> mlx5_hv_vhca_agent_create() which overwrote priv->stats_agent.agent.
> 
> Now that the buffer size is non-zero, if kvzalloc() fails it will return
> NULL and take the early return path in mlx5e_hv_vhca_stats_create():
> 
> 	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);
> 	if (!priv->stats_agent.buf)
> 		return;
> 
> This early return bypasses overwriting the dangling priv->stats_agent.agent.
> If a subsequent device detach occurs, mlx5e_hv_vhca_stats_destroy() could
> dereference and free this stale pointer again.
> 
> I noticed this was later addressed upstream in commit e600849cc1e0
> ("net/mlx5e: Fix HV VHCA stats agent registration race").
> 


