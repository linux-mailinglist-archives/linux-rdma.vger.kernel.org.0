Return-Path: <linux-rdma+bounces-22175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b9GoG+XzK2rMIQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:56:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E067925D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:56:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=M3IBj1+j;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22175-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22175-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE8F30B8446
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95303E8C6F;
	Fri, 12 Jun 2026 11:52:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B6395D9F;
	Fri, 12 Jun 2026 11:52:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265131; cv=fail; b=JmUGugMTwJgcy9hu+OV+NOqvmQdqL0CAJVlaRXSOW5fegSV0RT3Eg8JGnmNpdHxyVAvVOjMpJV5lpJdtYKi0KFG996y8tzbV+BGWjp0sT1ACmv8bfHF1je09/cIMhOHxgiqkdJmp7OM9Y87uib5pBWXfCIYmBE7HFZyrx52PMWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265131; c=relaxed/simple;
	bh=tOHqwmw0V3wIUqzLxu2VWnSKPDqw1pqqy8UnAmNaAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iUIaTAQfKQy2xgxe2qjNZk3RGctsQK2j5sbOpHvQfDD8/fDejgkjjycw507a5hP19oQv7CPb+NtYUAnY7E2Kh2Vz34FLM1qXq7osSFd/JFJifxjR5N0LOzpeYpmVOAcOKgCeiXFoTfs8ppyjPQ7dS0E1IkmCfw42qxiyf0IJVpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3IBj1+j; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPYX7OHwF0BkXtAwgefFkbTwv6zyFAHXLUed7qDp8gNExKam/8SwHZNSv3YibJYGuGNcHRtCZXp6Ni3FVIooq6RBz17QQ6jSDfLqf7DjQmrRsKXXwsgSbWmVGaeGyPyy/pYR+GSU/uImG/luBqjizQfcR5HdwUsFSiE1qkV9MOBEHuq4mtHON3oS7qMZhxG9MP/yjpFpSWhprYhzVX8B0vZHY2WXKeFhCmrXnEY5/sb95egfPZhjDruJuVYBEvkW+PBejAkSnTRTiVSPyrIHWodef8dn51kpUaMue1dZKPS8bVJ2mL3Pzd4cC4UUAm6ZlAYcCXXSmfe+vQDcKlz4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6zZTkzcdG87/WNR52f/nTHcxm9QQyQ2xoal47NMnIA=;
 b=VMkB8OZDZeyRJklyoDaLRiqjrLvBf3tEvGHTN35XROI5DPU8Fl5mqcduO6FjeejBuR05V3880tDBxqdxYVN6KzBxQ7Tsr6mxlwqbLGlpXZvCeztIHNXE8B2Y0/csFMnFlI/x170kjAIijvF4hwTTmveA+gen3jnDT3m/BjECu1Lg1ug1hhnx6ICSokUMEnN7Yt3g2IR8+indw56lI6UrvEOHKRqPkgnhWujbPvd7tr+vnW/vBcdD3KPLTxGAJMJGXEcGGc6ApzcRuaj/530usEy9UhsHIu9aC7Wu1KDObTvtDosqjFUJMdf5PaMsX+XQNYTFwyoHQY7qOdDSqbbSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6zZTkzcdG87/WNR52f/nTHcxm9QQyQ2xoal47NMnIA=;
 b=M3IBj1+jTT7Q7FV5uI0VqV80sIOMBoLzYY/E9C9Yyy0dLngZwCaypvZEgsekDozJNWY8s+5nw9OISvaXOymvDDPyDsq4J6eE+AA/m993DGKvpmx7qxZ0D3H6RZ6OSBEUTExL7D4atpI4Z9ieU0RpgmUUXDHf+zidc0S0uj/QI/2I8sGRTHz6wFl03huz7vmCiMPt6vbmPPgPghO6+P+QW/yS7LGSfER2VhV82kEaOZS2disMSAfI1WSVpT4DPU/C1B5gmFRTLWvMrhjbY/qqalUUZFwu4j2nESiGS78ybj9an3qHMVyylsQeo+4RGcbBAb/LHt5ZZwH8TNdABCoWcw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:52:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:52:06 +0000
Date: Fri, 12 Jun 2026 08:52:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Bloch <markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] RDMA: Fix restrack UAF in QP/CQ/SRQ destroy
Message-ID: <20260612115205.GE1962447@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
 <20260611191104.GA1501742@nvidia.com>
 <5760fd46-247b-494f-9fbf-fbb520c829cd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5760fd46-247b-494f-9fbf-fbb520c829cd@nvidia.com>
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: f17fdedb-67bc-48c8-83cf-08dec8790670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bnGwkESFP6mk6L7pbrB2wrjV4Q9wD2pha1jmFfN4/PWoR9fQQJr7OieJOfSru5+qGqG457NmIjgRqgTFwZufJ9xOJJNDADSEano5PzGUQj86cZh/Ozf+5bdX9AxEOYHdyA9KIIOR536oX4jJz/2h/hQWV+cgY+UEI0g+ViEbAoA3qYJA8SIP9BdoHYKLOPGClJKYxn2cefGXYsvuqiOnylKanHgnXsfrDOVSj8A8+wqzvjoShkZBwA+BZNm3kZa2GKm2KvexxshFjNj/ur1qqfNXNuWbDQ+tuRaZ7YfPMF0oeOMDqPQflFEOiYVRP2tF2HvivmcCN3rQC7CiAVpTgDVLTh734erWl/7zX47WyfU6mrfO6HCK0I8umSZPQ8iWps3zDNDhShPgrvt7JP9+/vlqRS4un95cS8O/zYr9Yzq5no+rL276Jf6dIQzIZV6NIS6v46Vr3Z7eWferVwFuIgSkIeaEsHhB8RQers60vfB0ostSk83GQ47Db+YyQASCuWAQ4p9rvzWwaxAwUYHuHg8kVv3gLGa5jKr8+x//FmNApUx3q6CPq9yV4JVlYuMgmQDsok9+WWCJTnvdKiKnbVx4jSpAIYquKkbqev8UC6WRVhrJUNFryskw2rWfaafLyAB4vTUKMKrhr00KTWv2bd7byLrlgQHmlOWQBVxoRen7hGuGt9SOjcuvdoC8eEzN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBGT2pPajhWTmVtRWRhU0FZeHdMMHBUNGdYeWVJclZTT2NKQTVzODhKTUY3?=
 =?utf-8?B?RHlyOENidUNpRGZwRzkvWTZNYTFyTC9YTExtNmhoSmVTNDNuY1VEL1YvSG9C?=
 =?utf-8?B?WkZQSythNjA3NU5XaEI2bmtkUUxkdHlkcWU2MGdnQmxwcmY1VXRJN25QNXN3?=
 =?utf-8?B?WFFDNDBxL3hlSzhsRXRyNGUzNkRzeTRHeFNIRklqbWllWW5EaTAxcnBEa2tq?=
 =?utf-8?B?dVZiS2U2dURaSkFkM2xpMXpuRWJsR0dEeE1HT09ZcXhsMmtNZ0t6eTh2U0pO?=
 =?utf-8?B?R0VVNUVNVnp3YWIyT25FVEd0d2hIWDBMZjlYSTQ4M2kvUGxXVUNYdmxrRVV1?=
 =?utf-8?B?cEtDdDRjbnV1SHg1d2VMaVd2eE4rajkrR2tudmxJNy9pSU1ldWdiNU9NNi93?=
 =?utf-8?B?ZVNWOCtONTh6SXB4RGE2MDcrMVRvd3I5bDl6TllSMi9HTEt4a295VXdobTgx?=
 =?utf-8?B?TFcxWUhVd01CYThCR2VzbjY1WmFHbXVsODlScXFvblAwMzlyL05Ob3pjdmhl?=
 =?utf-8?B?aVhjQ0R5QU93M1Fod1ZNaFdHQWlWR2tQR1RPc3FqaTRmSU5HM3NUYUJqTSsz?=
 =?utf-8?B?R2oyVDZhOXF4aEJNVm5QQU5HK25kTThPNit6NzhBMVRtUWlVR2JMM0JVNjB2?=
 =?utf-8?B?KysxMzl5NmpHNy9PcnMyWWxZd2ZPUGRHZHlucEIvUkZTSndHQmRPNHd3eVE5?=
 =?utf-8?B?UFBSKzNRbitPbHBvYkRmUWJTNTFLN1QvU3lVSUR5bms3aXlMQVZobnRMM2s1?=
 =?utf-8?B?QjllMlBOYkJjVml3NzNXb1NPUGprODI5VXNoaDdoVFhWNUgwT09aamRPeHJP?=
 =?utf-8?B?VVUrSXZxUXBpb3NtUm5rRDdvaWpZQUxOZnNKQXRZVVMzMnRHN1NjRlJ6VVg5?=
 =?utf-8?B?SlU0OEdhZGFpckpkR0I1MnJVd29qcUl5Q0VtTXlHMWJadVdvckJZMjZrNEN2?=
 =?utf-8?B?WjVoa2I4d0VCMDE5eDA4MlEweXEzUVFjcFI0VWI5MUtXdllrNSs2OUlVYmxm?=
 =?utf-8?B?cTZZUGVnZVhrQ3BGdnVXTU5nbEs0NGJoN2xDSDhvbjBNaEZFL0FTRTJmRDha?=
 =?utf-8?B?VUJtWkJoc1BOaGljT0RtcitzVVkzY0ZoMkpnekpMdXUvcDJwUWE0Q3JMQys1?=
 =?utf-8?B?czBjYjg1WXY3bE5MWHJGbEU1MERnR2JpV2JUS2FSVXpDSTVOUnFkZXprNWVz?=
 =?utf-8?B?WW90R2xJZ0pzUzBJUURlQ1V6c0NXZ3Fxb1k5RzM2UWlMNlpYRncvcm52ZSs0?=
 =?utf-8?B?K0loTW9KN2RVVVR4Y1I1czRvU3doRFlDOTZOZnFxRjJtd0RkNWxPZ2tMcFFU?=
 =?utf-8?B?QUxZYmF0RFVxM0dHNDNCSVl3Q29iOCtrWmFYWDBKb1YzZ1FkSTFGOUowOVNZ?=
 =?utf-8?B?UWJzaHczbHJGdVFBV0tXTjViQk9OYmtOQm1USzVLUnQxNnpFYmEwVmJOc1cy?=
 =?utf-8?B?dE5XUlBDV24rM1BLblRldDYwdzhTVjQxQWljOGxaQys3TzlsV1ZyVjBicUJr?=
 =?utf-8?B?Y0t5QXFBRDgwV1U0VlRJa20yWHpKUGp3ckVudWViWG5UZnpqVnd4cjU2VERN?=
 =?utf-8?B?b25WWFBPaTVXaC95RlVOVzlMME5td0ZycU1HQ29nQTlZbmF0bS8vakhhWXFN?=
 =?utf-8?B?VWdLcytnWjRrMkpQakV0U3lTTTdNWHZrc3AzNURwekFkOEtUdGtHZnM0ZjVE?=
 =?utf-8?B?Y0xjb0dUTk9VaWNWejA5eU5iWlFObFBPRXlydkFKVUZhMFJFc052TzZRUUZt?=
 =?utf-8?B?aW5OSlphZjRLQ1Y5UER0QjhaMWZhQ0MybjVpdUt4Uks3bFpWQk5YOU12ZzRO?=
 =?utf-8?B?Ykt1Q3hicmtyMXBBNXpYNklWYjl4V0hMVTQ2bGJJMDNNNmxMcUN3Tmd5VkxM?=
 =?utf-8?B?VmNvVjNiQlAxSGpQY1hzZmRjQnppbVREbENtSWlUdmZrbXdSN0NTN0syTi9D?=
 =?utf-8?B?OW5FNm1ZV1k3SnplOGF4YmFWVkh2RW5PM1M3QVJBYy95eStEbDhCcFZCZ2Va?=
 =?utf-8?B?VGc2OHZHNFM0Q3pJWHNUTFN5TWlNQ3pnMUJKSW9LTjYvS0N5WnhRTm1TaUJT?=
 =?utf-8?B?RlpuWjcrTHlSQVNMZHBzdTRiNSszQVdXTnk1SnlYZFNsYzVUc1dKL1BVbnpJ?=
 =?utf-8?B?VlVwTTl6dVA0YWJDdWxqRGxlUWVJeHR3MENvMFJqWHRMM1ZBTldKSkF3U08z?=
 =?utf-8?B?RXpoeDNLUGZsUVRBM2c3OTVUSW1RVU4xL3kwUnRLeHEvcW9uaXREZFViWTRv?=
 =?utf-8?B?SzhBOEN5U2dKMWM0YnNZMlV1ZGFIYVBMMERUaFpRMGlHNjNQaXVRRk5yb2JR?=
 =?utf-8?Q?bbNP8TisMYM+HmjyZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17fdedb-67bc-48c8-83cf-08dec8790670
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:52:06.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsHHCxlyftjVVV87hZ4YZz0C2bfcOPAnGyi+9GDjRc4mJr3Dyfha+nZzHa9Dz306
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22175-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phaddad@nvidia.com,m:edwards@nvidia.com,m:leon@kernel.org,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD5E067925D

On Fri, Jun 12, 2026 at 11:53:23AM +0300, Patrisious Haddad wrote:
> 
> On 6/11/2026 10:11 PM, Jason Gunthorpe wrote:
> > On Sun, Jun 07, 2026 at 09:18:07PM +0300, Edward Srouji wrote:
> > > The resource-tracking (restrack) database is the back-end for the netlink
> > > "rdma resource show" interface which pins objects with
> > > rdma_restrack_get().
> > > The QP/CQ/SRQ destroy flows call rdma_restrack_del() at the end of
> > > ib_destroy_*_user(), after device->ops.destroy_*() had already freed the
> > > vendor object. Therefore, a concurrent netlink dump could look the
> > > object up and touch freed memory, causing a use-after-free via
> > > ib_query_qp() for instance.
> > > 
> > > Fix this by splitting the delete into a begin/commit/abort sequence:
> > > begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
> > > drops the birth reference and waits for in-flight readers to drain,
> > > while keeping the index reserved. The destroy paths run begin_del()
> > > first, then commit_del() on success or abort_del() on error.
> > > abort_del() re-inserts into the reserved slot, so it needs no allocation
> > > and cannot fail.
> > > 
> > > The first two patches remove DCT and raw RSS QP restrack tracking as
> > > they have never worked (their ID is unset/reserved at create time).
> > > 
> > > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > > ---
> > > Patrisious Haddad (6):
> > >        RDMA/mlx5: Remove DCT restrack tracking
> > >        RDMA/mlx5: Remove raw RSS QP restrack tracking
> > >        RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
> > >        RDMA/core: Fix use after free in ib_query_qp()
> > >        RDMA/core: Fix potential use after free in ib_destroy_cq_user()
> > >        RDMA/core: Fix potential use after free in ib_destroy_srq_user()
> > The pre-existing sashiko issues look real too, can you fix them also:
> Sure but one of them is a false-positive though:
> Before destroy_qp() is called, the counter is unconditionally unbound:
>         rdma_counter_unbind_qp(qp, qp->port, true);
>         ret = qp->device->ops.destroy_qp(qp, udata);
> If destroy_qp() fails and we abort destruction here, the kref on the
> counter was dropped in rdma_counter_unbind_qp(), but qp->counter is never
> set to NULL.
> 
> This is actually wrong the qp->counter is actually set to NULL(inside the
> driver though not the core) so subsequent calls will hit the NULL check and
> return safely.

That doesn't sound very good why is it like that, why is a driver
making any permanent change on destroy failure?

> I wonder what about places where switching to commit/abort doesnt fix an
> actual bug.

I would change them all.

> and ib_dereg_mr_user() actually calls the delete at start so it doesnt have
> this issue (but it also doesnt readd it to restrack when driver OP fails) -
> but here I think thats by design since the MR would be in weird state and we
> dont want to track it ?

That doesn't sound right either.

> > I don't think this should NULL the task on abort either, it doesn't
> > seem necessary.
> I dont NULL the task on abort(I do NULL it on commit_del() though , or were
> you talking about the restrack_sync() ?

Since begin_del calls rdma_restrack_put() which calls through
rdma_restrack_del it NULL's it.

Jason

