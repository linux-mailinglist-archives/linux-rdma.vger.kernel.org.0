Return-Path: <linux-rdma+bounces-19865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIB7K9RZ9mn2UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:08:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 231384B3651
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25C45302307A
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BAA38C42E;
	Sat,  2 May 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adCSrE0E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77E37C0FA;
	Sat,  2 May 2026 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752467; cv=fail; b=UUjj79snIcOUs8r5XgbNejwqLQFnNiB084Uu+NPKqeis9BZ1G71G6oIj0zAGdkIXhTyI8t/YOXjeoGfIT76Q0/aS/bCe7vnXUMBMUrDhBchBt677RRwT5s2L7vsf64IC59DnteUxqy9pImX36YT7mEWlLY1m6u505G7iI9eHxas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752467; c=relaxed/simple;
	bh=IdqhlsoCFczFHbGhJobtjg0oNlYXXcuM9d/i1gSDwpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OaJVrTBxSCIM6j5hsELlBZP6DzqOUPwHO9LUEND9doOWWnp9RN7JsxLwGC//aEbgtGIyDfmnmSIWG5cllvrAIqCVxmPiD5WDe5HTT/C69hpAT8ipSpUQ/KUtv/ubcdx/LRl00K+/oC2kbjFe/j95OmeyGrKjSwQlFYKAN+BigLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adCSrE0E; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYDrF7WHMvrld+IVKIoXnyzzwmW6XF5CkdZpu87GluQRmIq8YKQSZTqUVJgYtMjirYbczx7f0jxrrnT1zDlXlbIO+9b8UeHvBuiuFO9J3C99VHcsKxefSdRjnW6Sg2yjTIK1SV0kBqmbea1RGudhHLKIEEQFBACHFtRR3Ny2cFSkbW1D9RdoSR1iQJSjSSn5Rz3mUZCzyG0C3ZUecjRffVJKeY9UCoy30KvanVVULrCozpZNlwVZ6eZV4QWcVDk1UNYMozMzTwG02BauCAd/rSb7xd268avwtga+2ePO/Q9dur6NVczqivjIxzIH1XKR19lOuYfAxZ40VFz2o2eiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBoKMYfAloCvVyU37PAxUtVFQBr+NBYfU0+Ox9m+5go=;
 b=oDvz0ECbN2AYwJPFBL8m/5rglZ8dlyrQGEJb6pmeVDTLp7mxiCsYJ9JERZn5qGeAMSsvO3gYh8W2b2M0ovV72Fhc80zoocQU2ZoUsNtST6VGJikSR5Q9gkDSebtKV2QIhLu5UQyDfAFRYcsrCszSgN5qADytOCc9qBA4uCYqDTRKEU5//WHH7TLZyXSPvm8Pc8K66T95N+ZstQoaEc7hv9HXwX9DmGYQSssjRCzDui3WpZHCbJXCgJuKmg9VXMLvfNE91y8DKeALLUCdYwi1gdKg9wrn3Xt82v29HmS+MVLHwc5xlynYSA74TkuqrRSQPyB4XUIAoASlC5YsHStIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBoKMYfAloCvVyU37PAxUtVFQBr+NBYfU0+Ox9m+5go=;
 b=adCSrE0E27AE/6c0R9BNO6frQu72B5LVNe99eIwLIdhw3fRkiDxbWccM8PUy+rLgGqCVPmfwX7abSdw98/r7NpI2JtJv1Mmxs94tbJIurxt0qE0RaDSRHzEj1BTD/1c510ouzZpNBTKBiM0hhFkqXf1lUwS/Esev6Gul9t+1RKfOVEEyKTd36J3coluGKdUbwug71vgv7ZX0MOGUwGpU/r/YYwQB8hUMRGem76s6UQA3w+GJjXXlS5lvYB4giBdyk1bOVSzfVGNQU1zvu0n7H36zGRa1u6uTb6GWm0XkOzC7Bky5HXZIm0JeJ2KIC9xBlDD6mWf4O45L/U3okwrW1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 20:07:39 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 20:07:39 +0000
Message-ID: <ae38e991-9b17-47db-b22b-9147335617c4@nvidia.com>
Date: Sat, 2 May 2026 23:07:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 6/7] net/mlx5: E-switch, load reps via work
 queue after registration
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Simon Horman <horms@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-7-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501041633.231662-7-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 040ee541-269e-41fb-cd99-08dea88675b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5cjto3ff1sb93n0rJSIg1hP0UJG+VgrcAQyX4FEFG2ReotQUeFm+iK555/CQtdpUZ5ZlxH8lmYhbjOuc0hE0PMRZgWv65kCz89vaRyeU1rOzwuXBPnRI4bUpxuRvXf4WLt7guI87qy7aT2w7mbPPlVRowxqbXKMNumjcwwu9OQ6AgI2pd1l9ZwA24qYkQXRDqi+BaNJcB/A8v8RT6SEzP6bpDA2TubMkU6o8rKpcSh400ZkQefAK76xVgyEqsPUCmS2fM2mWBvG4B4DpVSz8g7GTbGBfRMWzz7M5Mc/w1KZ7TiJCeg+7ZOJQD8Ah11eAUo7xK8JMGbqBmnhlXx5aGtpL01w8YsrZArUrxgZgFMPiY15bKRz8rSyzWrOnZe70mc5sm/7j9e8pDrocP4kmb8bD/whnKXf6RuVb+D0Y/WVaXZSkynNK4H7g+aLHvSo0itkSJTrIV6uo1qPDHVkbR0rBLx15Ht0UxWv0qilVbjbv7hxpBFS7MfeX9zKk9efZXvglcGOf6eRbwBGUo+pVQty0w7xcgVusB78EB/de8h1zEKiEq++jza219OW23F6bRRLlA1OAMXPOHuKVLOw6qdVKs3VxIZkJQzYBSXJ4TDVzD+1qopjzetpnZbwnKgcqZxgPsISLXivgifkmis3whz8O6qqdFCW/x69LMC9llOg3nj1YkbJcaR5JjzI4dV1E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1piclpJemxZdllRQ2Rid0ZJNS93bUlZcHFDLytXVkpuMk93T0FxMFNFWWwx?=
 =?utf-8?B?cDJSek5TNzZxa2RQMXZ4ZmxnbGxYV2k0L201V0IyNThRNyt0MytFZWtLWURX?=
 =?utf-8?B?bGJtcUVOT1JDRVNGdmxmYU9qazhYcVljZGEvVVVoRFErQkkzSW1Qa1hHRDZV?=
 =?utf-8?B?aTJTYzZpMkFVQW1KZGdobXZJR0RpOUZYZkxjRXBBQ08vemQ5TlZidzUvYjhS?=
 =?utf-8?B?RDIweW5DWnFUWHhHU3dzam8vWDFsOG9makNxZkt1bTZJTFBxWmV5R0lLTnBt?=
 =?utf-8?B?ZnBBU0gvMTR5Tnd6eWV6OWZMb2YwTkcxWVl0dTQxRVUvZ0xxMTZsbC9UVmpu?=
 =?utf-8?B?Y2NiN3oyekRKVmpsMEloVmxJM29LRXFBTnZYeFpmSGdLZEEzSzA0MnlaTllU?=
 =?utf-8?B?dURWbGs0R1YwTmRRWDBNRGNoaWg4ZWFEWm01UDRXazRZYm5TRmdUMndRSytC?=
 =?utf-8?B?VlpVRld4UDVHUVpFeUJTT2xJOUhmQzlDREJ2WlUyTG9qUjFpMmFPc3NNTzN6?=
 =?utf-8?B?QnlIWEt0MXdoWlVsZWlES2V3RjFWMEhwbjJCUHdwWWdlTjVaZ0ozaCtvU3Vq?=
 =?utf-8?B?Rm9BUEpKQWJmNU5SNTdyRzdrbnUwdnRnRU9PQnBzYXh3VkdSK2tWMUEwVHlC?=
 =?utf-8?B?LzQvU1Bqd3ZLMU5XakZpSDVRWHpZOGNRUDRTUUwxMDdGR0thT1Raa1Bsb09B?=
 =?utf-8?B?ZU1uQjAvWVN2OUl2UmtEMTJCeW1oUFM1MDdXTWtwNnZLTzVpQUFuUkl0Um85?=
 =?utf-8?B?ZGI2a2trUXA3STZQL1hGaUVnaHlSR1hFN2UrMERxZkFMdlFyd0FVaTBUS1VQ?=
 =?utf-8?B?R2hnZnhTRW5BUXNNNTY1akRsNVNzZ0RKeGNLL01Db3Bra01UeHhOTzRXc1lT?=
 =?utf-8?B?NENmR3Vmcjg1Vy9uRGFTandUT2lrZjF6QXVZaGRhVGYxS0dRUHVKcUpoN3Jl?=
 =?utf-8?B?bnREOXZUaEJERTA4cXFFV3VKcDhHRHk3QlJBRWpTejlmMkhxWDNKbTVoVnc3?=
 =?utf-8?B?S2YxMzN0WGtmTXFJUUJ2MFJIeStRVmJ0K1VGVVhCem9xZytDdU9YQjBLMW9F?=
 =?utf-8?B?L3NKY1A0KzFVRFQ5TEd5VnBENXNkS2JZMkg0U1FnZG1SWjBDei8xU09QTHVw?=
 =?utf-8?B?ZFIwMWV3aldJUWZzR2owWUhFZmc3Z0UyeElKTERxM0RpWlFETDliUkJvVHNH?=
 =?utf-8?B?WGpuZFBQaVdjQjEwZGdOdEUwS2RoaklFYlJrcCtkMDFKYXkyTUtwcXJIMnBD?=
 =?utf-8?B?b0V6dnVBTmRpSjV3V1A0VlRoaHdsdGFXNXRJa0xSNEVYSUd2UEFQc1BDcEVh?=
 =?utf-8?B?b0VZNy9GSTVvcU82aUoxRDZIUnlZL2lZTXFKNS9Fd3Y1OFd2NGhIWHhZYWph?=
 =?utf-8?B?WmpFT0ZoVGV3cTMxMVNHRU8zTUJzSnJMaC9hdnFIdVdOUGtlNmlmako0aWZq?=
 =?utf-8?B?VFpLeHJLWnNZMHJiRWJWRzJnY2lKcUhNUzBscTdseWNVVGg3Y2JjaTNVTGZJ?=
 =?utf-8?B?aEk0ZWRWdVRnYTJ4VjVzeGIrM25OVGE2SzM4V29HQm55UC9ueWFtb1FaV3RK?=
 =?utf-8?B?dkZPTmFhTDkxbFlzWDJ3TS9RMWtLbm1zTXB0Z0hlZDN1R09vcW1RbmovcDRF?=
 =?utf-8?B?RGo5Q3RRM2RtV1hzdjZKRkNoWFRteDF0dkF1RnpRUVJkK3gwZ01nUHlINTFi?=
 =?utf-8?B?N24vWENudjRGNXNaR3daUks2eWlzQkNJMU9iU1ovcUVDWUFNNkFDVFoxempj?=
 =?utf-8?B?eEFzZElCejh2WTZEbWp6Vm5MUXRER040UGdOQkRDdm5qRjZUR2tuWFRqMVRu?=
 =?utf-8?B?MHlkeHErc0cvRVdEck1GeEFRcDR0SEIrdm9jZmM4Y3FQcFQyejN6RkR4cEVF?=
 =?utf-8?B?cSsvajB6bEd2bEpOdVJSMXpzTm5MbExQTkU1SWRoZXFSanZrWkhlN2VlTUd0?=
 =?utf-8?B?N2YvV2dHTTdRbUc2dnpRbmQ2MTExK3BMK3dtSXFBSWttdnNOT0hvVjA2Ykpo?=
 =?utf-8?B?a3krMnBEalpTazlNcmRJQmtoRVhUNlF4ckM4dDAxSzNSVzZaNzkwR2NoSUE0?=
 =?utf-8?B?eFR2N1VDeEpyaFlFaDhsYVdaKzdyRFZRd0VnemJ4dkh0cHBOTHpxY1FDUVdj?=
 =?utf-8?B?L1hUNVU5Zno2K21RRUdqS0J6MHJsYVhqM1dwVFpzeFhBN0dJNlJVVXVaV2Rj?=
 =?utf-8?B?NWpuYmQ2dVZqNVpXNW9zTUMxSUxNd0NkM2puYmxjTitRTXVQVTgzOEs0bWpw?=
 =?utf-8?B?VW1Dck1FNERLRDdMdTRWWm9Vc0JWUEJBdnQ5NFR1UXQ4TzVvMENLYUpHd0Rx?=
 =?utf-8?B?b3A0cTJ4NkJsRjUwYWFYanQzTHBYeExYNno2dGZiT1hkT1B0eng4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040ee541-269e-41fb-cd99-08dea88675b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 20:07:39.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fvtGvwcIJsgPOBZBNYGBr5KJ/auT7jv1hNiztAJ1OQRzC6Sh5Bdct1eVhqLf+CTaiaEb6SZK7qpJZOZQyIRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Rspamd-Queue-Id: 231384B3651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19865-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]



On 01/05/2026 7:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> mlx5_eswitch_register_vport_reps() only installs representor callbacks and
> marks the rep type as registered. If the E-Switch is already in switchdev
> mode, the newly registered rep type must then be loaded for already enabled
> vports.
> 
> That load path needs to run under the devlink lock, which is not held by
> the auxiliary driver registration context. Queue the reload to the E-Switch
> workqueue, whose handler acquires the devlink lock, and load the relevant
> representors from there.
> 
> The unregister path is unchanged and still unloads representors
> synchronously while tearing down the registered callbacks.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

sashiko.dev says:
"
[Note: The format of this report is altered due to recitation restrictions. Code quoting and inline diffs have been omitted.]
commit f4f3e4872e599ef6d13a1f2bacffd52e6dbc8d37
Author: Mark Bloch <mbloch@nvidia.com>
net/mlx5: E-switch, load reps via work queue after registration
This commit defers the loading of representors for already enabled vports to
a workqueue when the E-Switch is in switchdev mode. This ensures the load
path runs under the devlink lock, which is not held during auxiliary driver
registration.
I have a couple of questions regarding error handling in this update.
Looking at mlx5_eswitch_register_vport_reps_locked(), the return value of
mlx5_esw_add_work() is not checked. Since mlx5_esw_add_work() uses
kzalloc_obj() with GFP_ATOMIC, it can fail under memory pressure and return
-ENOMEM. If this allocation fails, the background work to load the
representors is never queued, but the representors are already marked as
REP_REGISTERED. Could this result in a NULL pointer dereference if callers
attempt to access the representor data under the assumption that it was
successfully initialized?
Additionally, in mlx5_eswitch_reload_reps_blocked(), failures from
mlx5_esw_offloads_rep_load() appear to be silently ignored. If the call
fails for MLX5_VPORT_UPLINK, the function aborts early without loading the
other vports. Within the loop for the remaining vports, the return value is
also ignored. Does this leave the system in a partially loaded and
inconsistent state, where representors are registered but uninitialized for
some vports?
"

REP_REGISTERED does not imply initialized representor data. Users that need
private data only proceed on REP_LOADED, and failed loads leave the state
REP_REGISTERED. The queued reload is for late rep-ops registration while already
in switchdev, where there is no synchronous error path back to the auxiliary
probe, so it is intentionally opportunistic. The strict path is still the
switchdev transition: there, representor load errors are propagated and the
mode change is aborted, so this does not change the consistency model.

Mark

>  .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 8f656253981b..f26d1652dd05 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -4563,6 +4563,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
>  	}
>  }
>  
> +static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
> +{
> +	struct mlx5_vport *vport;
> +	unsigned long i;
> +
> +	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
> +		return;
> +
> +	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
> +		return;
> +
> +	mlx5_esw_for_each_vport(esw, i, vport) {
> +		if (!vport)
> +			continue;
> +		if (!vport->enabled)
> +			continue;
> +		if (vport->vport == MLX5_VPORT_UPLINK)
> +			continue;
> +		if (!mlx5_eswitch_vport_has_rep(esw, vport->vport))
> +			continue;
> +
> +		mlx5_esw_offloads_rep_load(esw, vport->vport);
> +	}
> +}
> +
> +static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
> +{
> +	mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_reload_reps_blocked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +}
> +
>  static void
>  mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>  					const struct mlx5_eswitch_rep_ops *ops,
> @@ -4574,6 +4606,8 @@ mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>  		mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
>  	mlx5_esw_reps_unblock(esw);
> +
> +	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);
>  }
>  
>  void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,


