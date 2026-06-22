Return-Path: <linux-rdma+bounces-22411-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 53AECAb6OGqGkwcAu9opvQ
	(envelope-from <linux-rdma+bounces-22411-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 11:01:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E504A6AE070
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 11:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aGMmzOhF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22411-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22411-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69C31300B9FE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC26395AD8;
	Mon, 22 Jun 2026 09:01:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09613955F4;
	Mon, 22 Jun 2026 09:01:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118909; cv=fail; b=jrFzhKixdAmjkroW0sfym0MUDvPTBAz+YekKnyLRiUBZeiHLOwXqLxIhsL+gSqU8a+4poUVc2VjN7oQN0ljkfiXBm94mLhYbmedxmLwYLYYnM0S7M/AeWUfm9fE+fhqQYBqLw4rQbJgCi+p6tAme6fjslapOb4IQ8SKacM64GJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118909; c=relaxed/simple;
	bh=YWO9FCs+3h2mbRpJ5xPaNG5kJCbkZrMSy3zuoq2N2To=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGpIfiP/MwMfRylh4AwlD9Af8utD95ht0fUj2H3J5wlvD1vWIUDmV86kNPdl723C90g8Et9oN8fNhH4jTX+4DAyI3WVnxRryPLcRZTwtKnYRmnt7kt+7hDFBochCMw+LXI2g98QcL2ytftK/AhMEi88x+2/8G13bytFkCyhMAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGMmzOhF; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuMKmqFoRZE5kv4lPvn4vLLjzqI7//wOgcaA4NCQkMh11AXzcCSBVzdrIs67eXSAkU5coLSIs+lNwYnCilKqQ+rl0Q68EgeklcroQTz88M+vOUZvqKQ5w1SEUZAf123tQZ2LGAO5FjMDm3QPVuveUlDMGKfTnnY5rJZRYskvOoCt1MZArWKqdK6gCcYtuJAENEr26pQEKcBiCtsV0NTPFfVcnphDRjA3zSpGgZVGKyJ4do2VjbDLB/VGw5c2mkTBjpVY0FGQxiXNQIUM+8WNdtqKHfx0AblufuLm9E8eYPTmFTFlkfYlqQZ3RasRKLQW97hEKYuXY03ahzmYs2YeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM3N+Of2MvR2Qh/K5xlqvmbpI0WS9m9uPHk3xbeAp8w=;
 b=KhZJSxNQ9Zw08TOCHzVVwDXsl9WrBtwRS6kaD6FSdGNqaHiGIAgwYGCdmqgRUHy6CDhlqPqvu7DQWxvY4T7XAZb65I21+li1zFpuU5B9bGa4FYTJPaCxqIsykEYYXE7eqNRoDCv50Wvo3y6MEyAGVNkZukXPP1nB0LQIRpiA+HHBi6L4k2Y504fadyBYUb0msHN2T4G78Zzt1sVx/tM1MfvwhhGl2Ru2YDlKEFhwr1fqd+q/ZuF/piP1k4u8XcIvtQl4HWbI78CE6Y1v5B8jxRCGXSbzJQzuQNhRktLqQzmD+GSfEdOpFrdOO3eCtC0HtCqwZDG6nu6chMbYdGTH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM3N+Of2MvR2Qh/K5xlqvmbpI0WS9m9uPHk3xbeAp8w=;
 b=aGMmzOhFuAF8RV5XYpF/NILm3KS5/dsiMGe7jXphwLo3eGl1xvld3qdEVciqeoqqHaizrq652qMbYrnXlX3l46AL3oBm036s2VGRUJ0FPwUHGAKVw+6rkHtgWASW6GBWbs24s4Mk6dTnVSUGdOxitwa9zBxpyN/zq65ff/YzV/PdAo6sLfegaXgrv2NOX3u/1NISxhk2wZyaRUXFZ+GAxHUFGtWH6VL56capBBl9MYEUh8SWmhNneUis8qX2gu6VFC8Z8Qsre6yhI63J3ZRKT4YBFuvFRCbhbFMv+Z7/YvVTPXx09oRuWmSrcv0zRdlnY65ap/TDJxwHvBHHJklMEQ==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:01:44 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%3]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 09:01:43 +0000
Message-ID: <293db0b4-f308-469e-99c1-ef1b57d41451@nvidia.com>
Date: Mon, 22 Jun 2026 12:01:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Use sender devcom for MPV master-up
To: Manjunath Patil <manjunath.b.patil@oracle.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Patrisious Haddad <phaddad@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 285c296c-74c5-40eb-39f3-08ded03ce133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4qlJYGM5iSW/XXLOSeXFjEFeTl0LKRqPYjK4Yo7vY+KcXOwwy0s9/YgW6RgzlgP27egmFejZUxKpKzaIdS4EYHgTX70hUxHZYwe9ScfHHIaE7xCqMTDZ/NOaRrqycJQ48UaqF1lA2+26sAH/L096G1mBA9GuoB6DFIocKE8kfZX8d6/2CzQypGJjpQ7/Uvg7ZlVKDbuHXwTHxtxW13BnpTLEaX5SF5LWmOKC9faKpKCF8Albwml1GTes8uKK9rv/ZkhoinVLwcP/mZLzE1A26+uCVr7r9dc0uYIELIKoV6bHE23Mm6T8KNPLHiqN83LHFv0525ipjCP8UiJlWl07HaTXs94hMRk9vaL5rYAx0XjEsUVb0FroT7tTUEujDhcQwPQi6nhDAYCocCLrcP2VtmkUzudQl96e7DH2+4wL+J6dXXum1UVqVds1eLD/P0xKLVXxkUrEgXbQ5EuMC3cMx5Jxbftkzu4FaOnW24KumiSar452Sfog6Ww0j53KLyPKmkAENI4/S8M2k4rS/rKmdQ8uGPhyybHquNGFzpQ7DwZx32aYYVr38AZ3thbVPRHLGca8DrdhI971+WMl29JiwXaR7x85Ho4JWVUmwI/JIMS9K5A/DJWHBSw0/AP1QCKtVioBFqpmQrKXxBZ6E5UZumvzDhixVKyBuzXx7ni7N8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk4wSEZYZ3I5R21VOUNJTEY3SHdkRmV6L2U1QnM2VWk0MFRCUFl5YTZrNnZ5?=
 =?utf-8?B?cFkvR1ZXY0FkQTBYeGx5L1NFYUpMSHhITEtsWTJKT1BzaW1NRzZDaHlmQUNB?=
 =?utf-8?B?eHhrWmx6cHp5RU5DNC9oNmpDbVYxL2ZIRE8zZkRXMkQxbEZBT2YrK2lzd1Bh?=
 =?utf-8?B?RDJ2dVU3cVU5UmJMRVlBTkk2MGZKQzlvU2h2ZXJ0SUowd1FjL0xXaklMM1M0?=
 =?utf-8?B?NEsvOVI4QVVTVnphc05LMmg1MUpucmU5OUIyWjVvY1U0WWtLOVQvazFEbjg3?=
 =?utf-8?B?L0FTZGVRdFNFeW5naWlicCtIZWFTZXhtbWpKUWtFby9qZmVPbmp3ZUNzM29Q?=
 =?utf-8?B?Umwyd2pOTEVyUFZucWlySkFrTHMxNU9RTzdyOEZTR3RjbEE2VXZPUzNJLzVw?=
 =?utf-8?B?ZlY1RGJ6UFVjZUhWK1V3SUswZFp6N2FDc21yTTNLaXJIRGh3eldXanBGN3lI?=
 =?utf-8?B?WHFMZURQamFXOXZEVDVQUGRTNDN4RTBocmdoYWR3UHd6b05LZ2pKWGpNTVpq?=
 =?utf-8?B?Z0x6SnZ6REtrNnpVQ0locTBpUG5xZjlCbUZXT0JmSVlTQjFPdDZUUGl4ZGNK?=
 =?utf-8?B?VnVDb3pUZUY0clp5dXYwQU1RYkNBL0dDdWxodFBweWZuRThCdlg0a3JMQmRy?=
 =?utf-8?B?VjVHM3Vld2FsRWQzZEphZU5vZ24zWXEzNVowRzhObWp0OERXcDQ2ZXJMd1RZ?=
 =?utf-8?B?aUQ1MkZ0SWwwcXBWYjNyQ3Y3UEtKUDlYSDJCRlJic2Z4OFJ1M0Y4M25lMVg5?=
 =?utf-8?B?TW1waVlkYU9EZ2szKzkxMFNSTCt2U1d0d0VQRkMxWmhiY1NJeXJsK21ROHo0?=
 =?utf-8?B?K1M5U3pJRXFlVW1FYkNBUVZjT05UOE5IY0JBSmN5aHpwQWZkZk5MNEJSTUtO?=
 =?utf-8?B?bmV1ekp2N1RkeGVtRFBPMkI5RFBDdk9ST3paTUNPUFVrWHlkSURLUU50c3Zl?=
 =?utf-8?B?bFl1M2orVEJ6dk8zTTdBaG5WcThnQlQ5RjRoeGd6NWdYbzdOTkF5eW9wWW1G?=
 =?utf-8?B?N1dKK2llNzYvOUloY2xzb1cvOTZrRkcxOXJ0S3FuWC9EdFM5Qms2dnpZbkk3?=
 =?utf-8?B?RzNUUUxyR1FKQnQzTE1pL2llOThOWStQVlJtSURjOU15dGhFRmxMaFY3eTdk?=
 =?utf-8?B?WllKTHAvOVgvYVoySzhHWUs3RDd2bkxncjZVNHpvbklUbVpxNWc2M1AzSDlO?=
 =?utf-8?B?d3dOYUlLN0QyS1cxazY5d2ZIaDZPUUY4NnNTVmJyMm5VWVpyT0RwZkZmdVNX?=
 =?utf-8?B?R2dDVDBDZDJGc25jaEE1WFhaM01IRjA5UHoyaFhveUJEUHdrYnFnWERtZzBv?=
 =?utf-8?B?TkwxVFNuVkdlak1ORzdwU25YZnRzQ1UyUzF2c0Q3WXoxMjc5Rng1Z2lWY1FW?=
 =?utf-8?B?SEZBWHBGelBqRjJlemtEYW9GM1ZlR3pZeGNLVXhPeC96L2g0dVh1TzVPSWRo?=
 =?utf-8?B?aCtQSzlhMTNOclJ5eXRWSjBiYTFESVltWHhWTkRyQlF3K2hUU2pKK05leEhT?=
 =?utf-8?B?dUlnQnhCRWFBZlFFWmpLcWZSeU5yQ2IrWUlGRUh6MnM3QmxSMTBkSHNYU01s?=
 =?utf-8?B?MHgxNGVDbjZCdFFFaUFEV1poMnVmcU0wdmZxQUhBZHR6dTNWSnliMXRPK00y?=
 =?utf-8?B?L1FzYVJIN09GQzFzQnMwVW4zNVJMa3dWbDhCc29MWHRzRXE5QnptNE96NUlK?=
 =?utf-8?B?N0tCUTFqOGdXa1JvZkc5akJWOERoOG02VTM3c01SQlFPRXhuOWhNazNTUTZ6?=
 =?utf-8?B?dm02elp6QTFnNXhIbGtMQ2dscnVFK1Q1VjA2Znp0cjNTYjZNd3MyMHlxZG1n?=
 =?utf-8?B?S3pPbXptcnZscERhYlRaK3hyTDl1Q01yajdBb1RVcUZqTWYydzlrS3hRN3VS?=
 =?utf-8?B?dzhscis3NmdLZlEwVXVJSFJPYkhLVFVTME85NWhMSjZQMWZ6cWg0VWpRaC9u?=
 =?utf-8?B?UGFiNjh5dW42N1FTNDdGNlkybkpuWXlVbzM5d1pZUm8yQzZHVzMvUkhjRTFX?=
 =?utf-8?B?WThGQjQ5MFBIU0lrVGFGdDdkTEFJOUZRWlFnUnBZNkhNWHJiejJYYjRSeUJm?=
 =?utf-8?B?Y1JHTDZzak5HK2JnVHp3azZZQ1BkNjFQTXQ5OWJiV0hHTUg1eThDM1NuZFgw?=
 =?utf-8?B?SExPRlpsV25tZG8wVFVwUFl1c1FDSko4aEJqUk1iZlplUmNOR2N3OWhHZXpp?=
 =?utf-8?B?ckphQkRCOVZKNURSRXFHRVBWM1RGRTJHVGNSSUdmQ09PV0x5d3EwZFJFS2ZC?=
 =?utf-8?B?U0dicWlscXk5SHBGR0hDZ1ZYNE5tV1VIUzI1d2VzS2oyRmlwOTRFbVQya0pO?=
 =?utf-8?B?NFpGMm83MUI3YWRaMWl0bTNkRWlVb0xrSTNJSFhOa1Y0bjF3dVVFUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285c296c-74c5-40eb-39f3-08ded03ce133
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:01:43.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg8K0Zv/zfVOQHjGpnybB+QtR2HtZ+AdWwBKgcdspiD0NzQV8VIhS3xANIjDlkdE7xEWqotzMk6Ys1/lM1y0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:manjunath.b.patil@oracle.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22411-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E504A6AE070



On 10/06/2026 20:39, Manjunath Patil wrote:
> After PCIe DPC recovery, mlx5 reloads the affected functions and
> replays multiport affiliation events. In the reported failure, the
> first relevant device error was:
> 
>    pcieport 0000:10:01.1: DPC: containment event
>    pcieport 0000:10:01.1: PCIe Bus Error: severity=Uncorrected (Fatal)
>    pcieport 0000:10:01.1:    [ 5] SDES                   (First)
> 
> mlx5 recovered the PCI functions and resumed 0000:11:00.1. During
> that resume, RDMA multiport binding replayed
> MLX5_DRIVER_EVENT_AFFILIATION_DONE and mlx5e sent
> MPV_DEVCOM_MASTER_UP. The host then panicked with:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000010
>    RIP: mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
>    RDI: 0000000000000000
> 
> Call trace included:
> 
>    mlx5_devcom_comp_set_ready
>    mlx5e_devcom_event_mpv
>    mlx5_devcom_send_event
>    mlx5_ib_bind_slave_port
>    mlx5r_mp_probe
>    mlx5_pci_resume
> 
> MPV devcom registration publishes mlx5e private data to the component
> peer list before mlx5e_devcom_init_mpv() stores the returned component
> device in priv->devcom. A concurrent master-up event can therefore
> reach a peer whose private data is visible but whose priv->devcom
> backpointer is still NULL.
> 
> MPV_DEVCOM_MASTER_UP already carries the sender/master mlx5e private
> data as event_data. The ready bit is stored on the shared devcom
> component, not on an individual peer. Use the sender devcom when
> marking the MPV component ready.
> 
> This preserves the readiness transition while avoiding a NULL
> dereference of the peer devcom pointer during affiliation replay after
> PCI error recovery.
> 
> Fixes: bf11485f8419 ("net/mlx5: Register mlx5e priv to devcom in MPV mode")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Cc: stable@vger.kernel.org # 6.7+
> ---

Thanks for your patch and sorry for the late response.

>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 8f2b3abe0092..f7ff20b97e8c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -211,11 +211,14 @@ static void mlx5e_disable_async_events(struct mlx5e_priv *priv)
>   
>   static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
>   {
> -	struct mlx5e_priv *slave_priv = my_data;
> +	struct mlx5e_priv *master_priv = event_data;
>   

makes sense.

>   	switch (event) {
>   	case MPV_DEVCOM_MASTER_UP:
> -		mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
> +		if (!master_priv || !master_priv->devcom)
> +			return -EINVAL;

is this currently possible? or just being defensive?
if this return is unreachable I'd drop it.

> +
> +		mlx5_devcom_comp_set_ready(master_priv->devcom, true);
>   		break;
>   	case MPV_DEVCOM_MASTER_DOWN:
>   		/* no need for comp set ready false since we unregister after


