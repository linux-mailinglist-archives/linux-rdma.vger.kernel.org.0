Return-Path: <linux-rdma+bounces-18880-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPGkIgvYzGnnWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18880-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:32:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C476376D76
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B54300DF48
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4673AA517;
	Wed,  1 Apr 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8t7cabQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431637FF75;
	Wed,  1 Apr 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031715; cv=fail; b=KvsrLUBQxS5ATKdqD0vhJlz2zOdY1lrBE+Ot7qIoJKHvgVKfdDcVxDmleqmGFR0s6jj4cun9YO0rofkr+6gqbKDGYK4HnCD/SsjO+8pzbS0bH4IJtadJP5zJTKflu56ZFEcpF1eWd8vlxMI2RySYY9L2tizuK5X3vaqgfvEHDnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031715; c=relaxed/simple;
	bh=M2xfqB+SPM8rph/J1fSQtQaMMLDD5L3c+Bv9oG1ub7E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jh4s+VIb2jf1pEuTcFkp2igp6DGzkOBD2nF3C2gmKx//CQDOtJQdUfQk8jno/QLKhofBK2bL9hUVME8TxhD3rthUPq04eYmzgyqHYYIJ/Q8M4wy73fgYljv+dyIBkLVSmSx/SnVWQpkq9s5IYoS2PjmI9gIZ4rB9tldvx3QyTxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8t7cabQ; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzLhYRzttDkcCFJJ0n7Ojan8zM1GW54DnIKTdcW0LdCp5k46END+2G4oIqDnsJiL5BTt1edGfZLCHeaxpc0B3CmyfOTLDMWhI/1UGNcagcmDJS9C+hxCm6Ph4CUTWDiPU6grhkA/umFZntyUwH2wntcgHzEvgZWSl4KiIXi6hrIEHbu3QiF+5o9Zi4tqetoHpyUn1HI0nLRit/JS3awde42XRASwUcaj/B7D2Hk9f+gLisMHRe7f1drChUkg9NuNBko7+jx2R3zkj0J7opFyqdngL87FTzPigYLylDyIYZjitMAqIHVikSnIx+Lbq05LesroNuoSOxXh7r73UVGmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUchSeN1ur+pD6iUdeAuBbNc460wnYNr0v4fE9tnVbg=;
 b=nCh6MCA1ugUMldp7CnXOX6hayDCuoxLrXcmu9+V3zFsgSRHOsPLiz2Qrq+ScBn9i9pT6t5zL6SFP2GaLMFzsrjqftipx8U8TW8cek6FO+0zGMynciLpiGiQvpzDk4JTR1wVOw27Pyb30zKxkS7x96fE7c3AH5Bx1wZV37YuhH80AEws5B245nzqWkCPJfY038ReH2wpQPFquLzV2yg16GBxu7PRdDseMkZrHfxOSPra8F8ygDr/2IxaYWZ3OmQg0ICQ6rieTkuwZmRGZ6mD/AEHL1Mr6WHlX8jgjZ8j9MLf1tvB1fd5khBOHmXwZdA07WcgmKnUcuJd2Z6V7iX9gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUchSeN1ur+pD6iUdeAuBbNc460wnYNr0v4fE9tnVbg=;
 b=K8t7cabQXzQgo1LjjtKfuaQgCzHW2e4TaNNmqNYmzJg5NsqfT2ipBcLbXFIyVkk0xRZoYYxz8QQw5pZnPALwC6LoQvj/r8yG6O3hvgbB0duE0S28bdIV3ISfxAX1nSkZ3pOoMVzg/1QczxlZprKh4mc2N3Z4mchiLaS9r8BtR0oJoCEyyNGdc65fGiKpRXesQEseksz4PzFZdRG4muFi2g+cK/PbEz93UD9UWeRoEF18WSgycacZ27KuFojQub5pqRL+2l+pE4K69Kw8m5hBRksVBMUDqV5EYB57tsg3vxktiEnaddlz11axaDocuyVMk7eCc6/0IEMXHybRxBG7cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:21:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 08:21:28 +0000
Message-ID: <03875684-1c5b-416a-967d-4c81ad565c10@nvidia.com>
Date: Wed, 1 Apr 2026 11:21:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][net-next] net/mlx5: Move command entry freeing outside of
 spinlock
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331122604.1933-1-lirongqing@baidu.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260331122604.1933-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: ad88e40f-b45a-463c-116c-08de8fc7abf2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fyPng3JidESIuz7PbXUfllx9oMDACwyJiXstqlNW/B9M2p8yIrE+KG5ephsn2VCOvnqrVqtT9qfYzG+mB1Kmo9h4g3v4mI9WM8y3+YOrQC+XHrHH+Tj+y4LscCXn8a0gdLkjUugu28wmwRy/n9C+kcN2QAMsrxiMIG5YB2xhB7D4CSchrUvZti1EKtXrZ+24lV3u5FqCOQNm3YfSyeC49adbWnksDLHWbTezo5GTXNzZFVh/OQuP342Efe9sNBz4f1n04yZZ5698uHL9j6Ah//+iUGnCBZZSScWSIH5+cYGW2kdJNy8Ir1UzXttBgcMXciDa9Nw2iei+BX+jRryLcMox9C3VXpkoBgtI0LH+g2tIWGSUy9+MwwD/jauNYUxq2PfvSBy5Q1FFDxm9fOM7RAMzZifEqlh46lo82aMnodCQLW15/NUuVNXGyOrxbNees5RUTl2PRGSVL/0z2xcoiq+oUmydp9iWIoSgk8heXvRjGsZHm+P/Fvesx1yYv5d9wIctPL2y4epNCikj/vbMdyaxqQNetVeIje4qJOanuDM2oN3PoN7vdhS8ABNJHk3GHs7dDKmY9u6PWHhb8wg6suKuWVO/gIfRUzSSN2xSEdXsM5Ddw4ugT56ORhGzA1zBT+G247t9+2TKKDQN8vIxBI0hf60UVsNAJetxqVyzT3q8MBt7xGEhf7+QsIqUyWhHF95/flBJ5/XsXY/ABhVb8avRMc4RZPXF6gIwOTN4IrHLFlMziGTd6rTT66OhY136xjZHffxJqTiXuzc4iUVJTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDJFbWV2enc3UkcxTkhVVm9DVENMZ0pYNWxxQWliUWpBSW96bS92VUtscUIz?=
 =?utf-8?B?RVc1ODJrMDFpenRyempvQ2NRSTM4MjFQV0Vkb0xqTWVOUjdWTEs1REpUbThw?=
 =?utf-8?B?eEtHWFNOWTlZNDdydEhjMVFIZHR0bDcyNHhhSVhJK3crNGM4Y3pva1h6UEVk?=
 =?utf-8?B?a0N0clhPN0xkczZzWnFDdEszTDRmM25yTHBPTy9WK3V3MTNUMDVjSFVzMnlF?=
 =?utf-8?B?WFVEYy85YlB1b1hTTUExOG14OWZZcEhlT0NRSWU5b2FFMk9uQzZ5dGxCUjZk?=
 =?utf-8?B?aFhJN1BwUU9zZXAwSGF2a0ZEcEVoT2c1ZHpUTzdxN3hnVytyQmVtNGxmb2Vo?=
 =?utf-8?B?cEsvd0twREVITGc2dVh4TlVUMzdJWUwwYUhlcGQxSVVSMnF6WlhneE5yclhr?=
 =?utf-8?B?emZ1WWlrdDNLVjl5cytWd2xKekN3NTVRL1BtZkVQbjNMcDV4RnprbEhNMlU3?=
 =?utf-8?B?S3lZblRpWEEwZHNLUW56dnFCdk1ValM1Qkx6RytHQzdmbGdJUzZaWVUxZ1hI?=
 =?utf-8?B?dzNuYTRGMnR6ekxWVm1OZTkvWVpuYjJMMURpS0JNZW9UcDR4MHNGcms5b2Zt?=
 =?utf-8?B?OHVsaTRzanZYWDZKa1Vnb1RBMmRsWHFmVFFZSDFKbnBMZXQwb2Q4S052d0Zn?=
 =?utf-8?B?NGFWUE54ZUlDVjBzanU2WFNpNDNTNCs4QzZrVSswQzFFaXN3ZTM5cXVUOTlB?=
 =?utf-8?B?ZkVxcnV1UGwxL2R6YUZKdXhtQ3JETy9zWWI1ZVJ1bkZERGhIVUxXT3E2VDNw?=
 =?utf-8?B?aUROdVZWZ0tZbEN4SWJWUHhwRGxUWnR4N2ZjYnFyOUpGQmZOR0lTV0p5a1FL?=
 =?utf-8?B?MVVnUzIzZFpINzlRVE12aVBlanZrM0w4alUxRFBrSjFhMm1ocWw5NVVwZTE1?=
 =?utf-8?B?MS84bHZVbzFkZy91c0U0MTVMOG03eWp5bFZ4ZTBDOFo4K1JRRzN3ejNvazFi?=
 =?utf-8?B?dVl1SndjQTJhRGx1cU4rcVowU2FmcUlEOElZaUZnNDg2NEJVN2FuWGozdHdN?=
 =?utf-8?B?N1lteElteUZPWm9hNEE3U3pCUFQ4VERtZEY5TnZYZ3YrNm8xY3FFYTlTdGhH?=
 =?utf-8?B?R1NodVYxT0dvc2UvRi93QWw1UHJleVZDaUZxdE1YYWY2eE1sY0FKSUp0Y09s?=
 =?utf-8?B?UzhPaWJsTTV5VnErNXZTeFJwbTFWRmlWWEtwd2p1NGJZejM3QUhLZ0c5aVJZ?=
 =?utf-8?B?dE11cUJ1djU3ajNDN3B6dHJUdUNWTFdiS1FDd2VuWXY1cUVVOHIyMWg1OEJt?=
 =?utf-8?B?UmZzZXcyRG5TaElxcFB5MnYvZEtnK3JnOCtDS2wvTjlOQWNqL3ZnQ3VjcERB?=
 =?utf-8?B?NXl2N2xPVWVWYjJZWHdqWUQxNlFWcnRQMnpSUzdBTWNqdjlhMnJsaHlZbThY?=
 =?utf-8?B?c2h6cFk0M3F4bFFUem81L0ttL0pJNmdCVVhHWXR4Um81MloyMlBzMjg4V3dZ?=
 =?utf-8?B?M1FYUTV4dXo3SzRGSEpGSXlJaC9wTzVKVlBwY0hwMTIxdGpVK1hEQ0NSU09M?=
 =?utf-8?B?ejhPV1FMWXpQcGFLYkFJWWo0UTZqSzdqSEUrSnZUdDhsejMrU1RFaWlKUWE1?=
 =?utf-8?B?bWFUZ3U4YjBiZ2hSMW5jamlYaUxyRW9KL2RwbnBYekFCeGZOYkNBRlgrVU9o?=
 =?utf-8?B?d0c4YlVZR3lxVTZpK0FEbzBuYk5JbVlGZUYwSG91emJ0WHdXM1lzeDk1UW9y?=
 =?utf-8?B?eGRhallvQTZGcWw2c2I2dENNQkUxVFRqYzU0ZUtMbWIzbGUwQnV2THZhaTMw?=
 =?utf-8?B?U0toZGVYOXR6VkZPTkY5Ni9JVjJtL2E0RkRWT1Z4THR0b3VxVEpqZnQydnYr?=
 =?utf-8?B?aUVQeG9SUFJGblRkUEc0RGVPWXYxTUMyakpkcHRSOGZvd2dINkVaaDJCYUNE?=
 =?utf-8?B?OGtBUVIxSVkyRGgzQmRqWUFLYkdoeFVpU0ZWcE5aaHhtdHpwNDV2WGgvd2N6?=
 =?utf-8?B?QjZVYUg5a0NoK1hmNUhlZEFkc1hBTnF2ZEMxcmVjSFpSc1lYTk1Ub25lMUIv?=
 =?utf-8?B?Z2t3NHJsL2R1NzlQODJyZHhoTUFlcG42bVloNVA2N09sLy85cURNSE8wZWp0?=
 =?utf-8?B?Y01LQlVESkYvRWpDNXV2UEVZemFTYThvTTdscTl0eVZCMHhiZnhvLzZBaUov?=
 =?utf-8?B?M2pCaW1nNDFEeCtFY0lidC9QU2xYditPWldsc3pMN1VkOVJqc3dSN1BVNWkv?=
 =?utf-8?B?SjFBeFEyTVZUaVltcjJPYzBrZWJ2aUx3S1F2b0lNSHB5QlNSV3Z2V0tWSHo1?=
 =?utf-8?B?L0VuTnB6SDQrelJYQy9uMzVYSlVnU2RjcG9LSjRJRHRIb08yOTlyVjF4b21v?=
 =?utf-8?B?WWlxMEMycHhQTWtrd0ZiM2VJaVMza1RVRWZzY0F0blg1ZzVrNFk0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad88e40f-b45a-463c-116c-08de8fc7abf2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:21:28.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIqpvOQv6VYy0t87vb19fJP8g41cPyLb/I0O9uawL/LMxIK2pRnx1kWH9/Mk3g3Pvl3c+tRuSgvpXyUGJ/jhyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18880-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 2C476376D76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 31/03/2026 15:26, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Move the kfree() call outside the critical section to reduce lock
> holding time. This aligns with the general principle of minimizing
> work under locks.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index 6c99c7f..c89417c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -196,17 +196,18 @@ static void cmd_ent_put(struct mlx5_cmd_work_ent *ent)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&cmd->alloc_lock, flags);
> -	if (!refcount_dec_and_test(&ent->refcnt))
> -		goto out;
> +	if (!refcount_dec_and_test(&ent->refcnt)) {
> +		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
> +		return;
> +	}
>   
>   	if (ent->idx >= 0) {
>   		cmd_free_index(cmd, ent->idx);
>   		up(ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem);
>   	}
> +	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
>   
>   	cmd_free_ent(ent);
> -out:
> -	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
>   }
>   
>   static struct mlx5_cmd_layout *get_inst(struct mlx5_cmd *cmd, int idx)

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

