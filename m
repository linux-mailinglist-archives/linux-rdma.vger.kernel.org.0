Return-Path: <linux-rdma+bounces-21741-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TF/zOQRMIWoNCwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21741-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:57:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16A63EBC3
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:57:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Eg1ZJ53y;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21741-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21741-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E4F306C137
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433593CCA12;
	Thu,  4 Jun 2026 09:50:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E893976AD;
	Thu,  4 Jun 2026 09:49:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566600; cv=fail; b=qncMO0hS2OAgq4IFm0X+iLBlWx+H///E4wCnsOJwSptd/XpRhTJTfcXzDgduYV0erUMZ7kmJ/dWFNl2ziq13luYIjm3U/zAaG46in6QPW7ilr3tRasLfqWT2NHunAsmDrfE1Jy0atj3cEgZJANcOv7LdnaxN1HIto0RKcI2+58Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566600; c=relaxed/simple;
	bh=dTsYFryAEdDrTnQXxLP9BQxJ0syRkpz+aAI0mthz8rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XuISbLQ3g2iu0UY6MiT7/FDU3ExOJiGpwYfO7qX8wBAO4uomj7836OWTVyeeIZQ9JOerrpuTlBP7l4kZXxw9A2EDmq9sVxCebmjRVsgww9bVany6y7cSm4TJUCCDqzHsrolQ5xyqBM6a3aNrnXNhtrXRDLoZiGNFWHWF9/f1BxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eg1ZJ53y; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys9niReipIyN0EeRhOe8++Ju/7BnB2LHDVAKutkNjX4eYUDYHnO78Cqss+kVUPDgbdn/Sltt1wmS0kH0mzAs7RV4GZlj46/0PWhTiNmfT2f9fsUK6gBS5tKyYtKBTIDmQEB1jwiugIjLSWXP8GfhXM4MgV+U57q6aC+UYrmjO6aXmsanQJzhJzOxydYPrGR7DNOIg3Y+hluiW4fJTJriyCrjGCt/iGFSy5W/bKqJrNi0Z5G2RcAT9IKSkbjeXxlyD0T6ZFpxILQ0fYxnhM+E8VIBWAWcsoy7iSNKAFcRul26BwEJqkJrfq7xyzysTHyHgUWQMsKPJJPo5ks4zeznhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBTh+PzZYLqNYhWHWlcoIYbqM/WUl+Q/NWAeqPw8eLA=;
 b=DAHbVlA7PhsGJhZoCcxNZ1yOqAe4jFJbEwT9T0t09vFy4UtYdgY0pXr6QXLXGeeRzWlyvMTVu8P5flfP3Bh69BeyCOihh6BYD6dafBQgRtQt2l8dZ2HwCplO3Pg6hquteiK3DVEcX5xwKCcawnLu1EwdNYJvz8dAMbAXUC/0k165ewGve8B/zER4xWvViYZFastLyk4FwGaPtsbuNjz0sfCnuo5fiiAoqbfFbPEMTaafge+4kJrTj/TibCI1NWrX0VrRJOXVTDButnHQF2browUMyXjc2H+6/qs5AMgmlKCQwH92QfgOa1neClhEJwvdLChyW4QMAqgWwDZ8zWhJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBTh+PzZYLqNYhWHWlcoIYbqM/WUl+Q/NWAeqPw8eLA=;
 b=Eg1ZJ53yDQLuhEADCsicR3U8wKza3DKVkRRYrRNuWZNMG6jiKVXXvl8Y+tBlgtbElx4NuVUOFuiUs45/i5D3xW6KrOEgQJ7Sstrg2ZksgQRkbq1QthBdDtLX7v1fuqURozXyNtYtpG2Ch3cY/lK6mILSUstmcJRznDU/xXB8cArJBDK44Mcnxa1UaXmK1Qx8ZtTM8P5ip8Dm+ds1+Wiw0ZLPPDUWK3HrHYLJW9STcBZIHXkuFTOLkkYlPAVuxXvAEc8bBnGsP5CtJQKqZIMcrVwmv8MsuwRqkGfkqIFrQxrcRAKORSGsY3ME54ZGJBmEajBx5VSDDF4hUe5XKLS7sA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:49:52 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:49:51 +0000
Message-ID: <91d12ffd-6bd9-4951-8351-655262d44874@nvidia.com>
Date: Thu, 4 Jun 2026 12:49:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] devlink: Add eswitch mode boot defaults
To: Randy Dunlap <rdunlap@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260603193259.3412464-1-mbloch@nvidia.com>
 <20260603193259.3412464-8-mbloch@nvidia.com>
 <d276e842-dd8f-40b7-806b-71572503005e@infradead.org>
 <e4aada53-fb80-41a8-9a8e-d19414f6466b@nvidia.com>
 <909ada9a-a398-4e3f-8ed0-596a1e4bdbfd@infradead.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <909ada9a-a398-4e3f-8ed0-596a1e4bdbfd@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c602f4-ff9e-4bb6-e30c-08dec21e9f9f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	5x4HKfC2XS8re4cyW/CGRIyPTE1RghNnhDyENoQF6kbZc7h5cysYxzeVdWNbvSTlklidY0yObB5I1Elo8uDJZGFtu5zp7P6+jdIYs8DRGCutylitMxCiDHFXspGIBZYCELkJAnBg2b1pLloo56DHipLiQEDNu567ALZNw8sfECjuE7ifKaGI8mCm1Hl8P9t0A81zHgrHblFsSpvOXUq4FPh3BLbc76liPCtoo7cd8N5LoPLJMpNib4tqX76GcUzyYJJKB6qQDpLk8niHTDqMmLtnyLoqq89CbpaxXeTL431nC37L/eVSxulgnB3hKcLP7nz3apJUVHo4APKVXV7Lwh1jL01bSsRBdT8sxNP2PQQWUeUfdqFxQSvax3LNlUy7dakiN5/xo6gLMztTVPKsb1mIlfwnVHKTAHecPX/0Qs0GDhyZr4QxcKysqa3R2vDVRG//S6rM42LW82fNwk4AVIqM5kYDs57f0/ngS9hLP7Vb1kqMdgupr9i+ZuW0CwgAHXfX3SYRtYba/TPlUDMqIfn77ng/i8uXh/bj/5QwPVfxY2CVqca0L7ynYCSbzbR+YFfadkCM5d1sk3BBLxBnbqTQIhzWZGRzqVHJmwpb/wt/bogtWi8h9SDUyPMtdph5Otud78+E/PT5QyElHew3KCxcGsJDIjf055viESG/mlCTBg81Dg8SyJLx3tvYIEe5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFYLzNoS1ZTbzBubFFrdXpRdDJQdDV6ejFKKzZ4MFF0ODlnL2N0UmpZV1Js?=
 =?utf-8?B?MFlaRmlLeXcwTk9obEJnVVdqc0hrVVJhZ2doMnllb0FVeVU4NUtsemIvR2Rs?=
 =?utf-8?B?d0trL3QyajNub0pHQ1BGSFBzVE5iZDNQRE9xWUVFYjNVQlV4b1BJd0J4U2x3?=
 =?utf-8?B?RDJ1eXp2eVAzZ2NCdTU1bWFyckRWQU03MWIvSVI3TGFQRXVHTzllcEVNaHRP?=
 =?utf-8?B?dkJnMXI0T3Q1blNZMnZlaFhsZG5zK3VXZWs5bzRYRmZKb1d2cnZkWm9VVmhn?=
 =?utf-8?B?cjNqbDlqMlMweEtzaitPTFEwZjY5NG9RY2crd0pRbnY0c0RiZUVKR3NjR255?=
 =?utf-8?B?YzA5TkU0Y0RoT0piQS93dldTYU5STm9oWUtuTTlnb3pTbEg5YnNKbHpLdm00?=
 =?utf-8?B?Um9NOE1zYllpS3h6VmdEVno0eE5rK0Q4Q3BmUVJBWUk3MS9VcHEzTUw3cVgz?=
 =?utf-8?B?RHFMcENoa1k4UjdTdktCb0syb3JIOFNjeGNuUFh0VVZURUErL0JiSzdYTG0z?=
 =?utf-8?B?MnkrUHZRUzlUVDJ4NFVkL2J5M3YwZTFKTFlkdDA1YjJKK29OZFVabHBxczlp?=
 =?utf-8?B?L1MxUExIN3NGRGNqeGZhWE5vVFNtUmNncUlpWnhZWVJqemo2NUdWNjFuTEVR?=
 =?utf-8?B?T2NzdVVpZGNsb3NScHNEQ0ZMUDVydU9nOGRZQlFuRjRZNEx3QlUzNnNGeEZW?=
 =?utf-8?B?aThSSUJ3VFF6VldLa1FCRUtLK0JWZnpFbnNKK0QzMU45YkhpWlltNUp0b1g0?=
 =?utf-8?B?OGVpd3hlQzdzZXo5cWNrOUNuVWxSVXNqbkVvNzlHM0dwS3VhVFBZd3h2ZENP?=
 =?utf-8?B?clRSYzBIanpBeThWZ2d0SExpSHlmSkFxRC9Mb0tlU2hHSE9JZ3FOWDB3L01m?=
 =?utf-8?B?NUJ1WUYvaG5lRG1OSCtvY0lyNVhKell0TC8yU3MveXBGU2dSMnh2VjF2UXJn?=
 =?utf-8?B?aEdIeVdVUGhYSWdxSlNweHNuUFJuRXE3djR2ZHJ4bDFuMVVHY05wRHB3SUdW?=
 =?utf-8?B?UzJZTkZTNlF0c1p0TDlXYkxsRUd5QUc4bFVsbzlINVRDUmNWaEFOTFVMR1Zi?=
 =?utf-8?B?WXlPL2xtd1VDMjZYcDhuTExGTERtdzgxOFdJQWFQZGlnV1A5VVRkOGtiNnNh?=
 =?utf-8?B?MUVxSllsZFJEWG9CaWR2OXdaZmplb1JVdmJrNUFqb2I3NHBJemRKcWk3R1BX?=
 =?utf-8?B?TnJ0WjhsMmd3ZkdJMUxZRk5vckQvZ1RhY3Vac1hyZ1NDdkNyZ1pjZjFqdzAr?=
 =?utf-8?B?NnRCUGo3RGJiVThQQ2w1STF5MFBEMlgrSVZHeHlnb3F4NXI1WS9UMDI3aEZD?=
 =?utf-8?B?V04xVnZHb3NkNTU4UG5jOEc5WGwwNHMyUFh2c0FkeThvQnk3bkJTWlIyVk5l?=
 =?utf-8?B?bFZCQlhVNDJJYTZ4VTl0eCtOSFdOVi9HZlpSR256MGsyd3dlRXZJS1pIYXFl?=
 =?utf-8?B?MjZVZ1VFQVdaeGZWYUZSbVYvU0ErZlpBUzQ1ZE9IZzBuUEowWmZ0OU1NVGow?=
 =?utf-8?B?b0NldXhUcmc2S1JUaFJTeVlRbUFmbUVxOFFzalZ6NDJadmFYQjVVY3VjOTdn?=
 =?utf-8?B?M2g2c3FXbGtyZDh5OFRIL3hUdGhYT2NDcUMwVmFTTi9ZQldrcUdScmwrOEtl?=
 =?utf-8?B?a1ZkOWtQekpmT0JxRmZDYjhUY3JoaTl3ZmFwRnZZT0llRmQ3Nk4vSjEvQ00z?=
 =?utf-8?B?VXZDVkpCOTFNaStHenhwcGMwRDc1THR0ckdHSVhKUGhMTytHc091KzQ1blFK?=
 =?utf-8?B?TnFVdjZ4YVdOc3o3WjdaYUFvdWlTNkdvckdYdjZjNHVQQkZIYy8zQVFuV2Vq?=
 =?utf-8?B?eHpkaHE0WGI1dVdYV1E1RFNNNERXVmMrQno4UVZGOVlyUDhnM2pvN3h1aFdR?=
 =?utf-8?B?aURZMDhzY1BtSmZmQmRwMmRFVGlDREc1eGswTDBpQUMrbGJ3bi8vSEJ4WWM4?=
 =?utf-8?B?OXRUZjN3T3VLdGQxTEFSb3VhUlRkbllnbEpoS2JpbFZVbUpJbk5Kd2ZzdHdz?=
 =?utf-8?B?cGNUMi82TTlRM05FY2VjOFcyUEt5WEVEZUtpcjhhOTZRVWJyMWZBTVNGZ2Y3?=
 =?utf-8?B?N3lCdHJHRGtKa3hxZlRZYUJVbC9aRzFDU2xaTGtmVm12Wk9xanM3VElZMmF0?=
 =?utf-8?B?S3piOURPbXdieEtreCtYa2I5a3l5WUV3VVMwR3RvQ3prMGo4QTBoVG5QWFZ3?=
 =?utf-8?B?Rjd3a21vM3ZPNmVrZmRCL0JTTEpSWTFZMFpzbWNiR0V1Y1RUQ0NMRVhZWFpi?=
 =?utf-8?B?S0NydlRCZEIraWorQlJXL0hVcU80N3hRalZLM3NOd3I1NWRCdHBTZ2Yza0Ji?=
 =?utf-8?B?MkVCOGZNNmpsNnNUQnRvYUFvWkhtdkVhOVRIeGphVVhOdjJOMFp0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c602f4-ff9e-4bb6-e30c-08dec21e9f9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:49:51.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObTZG40zH1er0KFAl6f1hqm70nYOiNn78xMT4v2tOTzsLMJnsEhFQRbS6SG6ihkwpafXDl08rWV2FyhItkVAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21741-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B16A63EBC3



On 04/06/2026 6:53, Randy Dunlap wrote:
> 
> 
> On 6/3/26 6:16 PM, Mark Bloch wrote:
>>
>>
>> On 03/06/2026 23:06, Randy Dunlap wrote:
>>> Hi.
>>>
>>> On 6/3/26 12:32 PM, Mark Bloch wrote:
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 063c11ca33e5..7af9f2898d92 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1264,6 +1264,31 @@ Kernel parameters
>>>>  	dell_smm_hwmon.fan_max=
>>>>  			[HW] Maximum configurable fan speed.
>>>>  
>>>> +	devlink_eswitch_mode=
>>>> +			[NET]
>>>> +			Format:
>>>> +			[<selector>]:<mode>
>>>
>>> It appears (please correct me if I am mistaken) that the '[' and ']'
>>> above don't mean "optional" but instead they are required characters...
>>>
>>>> +
>>>> +			<selector>:
>>>> +			* | <handle>[,<handle>...]
>>>
>>> while here they mean "optional".
>>>
>>> That is confusing (inconsistent). Also, if the square brackets are
>>> always required around the <selector>, what purpose do they serve?
>>
>> Yes, you are right, this is confusing. The outer square brackets are part of
>> the syntax and are required, while the brackets in "[,<handle>...]" mean that
>> additional handles are optional.
>>
>> I couldn't find a better way to describe this. What I want to say is that the
>> selector is always wrapped in square brackets. Inside the brackets it can either
>> be "*" to match all devices, or a comma separated list of handles. If "*" is
>> not used, then at least one handle has to be provided.
>>
>> Maybe it would be clearer to spell it out explicitly, something like:
>>
>> Format:
>>   [<selector>]:<mode>
>>
>> The '[' and ']' characters are literal and required.
>>
>> <selector>:
>>   * | <handle>[,<handle>...]
>>
>> If '*' is not used, <selector> must contain at least one <handle>.
>>
>> Does that sound like a reasonable way to document it?
> 
> Yes, that helps a little bit. Better than nothing.
> 
> But why are they required at all?

Jiri suggested using the square brackets, and I liked that they made the
selector look like a grouped argument. But if that is too confusing, I can
also drop them and use a simpler separator, for example:

	devlink_eswitch_mode=
			[NET]
			Format:
			<selector>=<mode>

			<selector>:
			* | <handle>[,<handle>...]

			<handle>:
			<bus-name>/<dev-name>

			Configure default devlink eswitch mode for matching
			devlink instances during device initialization.

			<mode>:
			legacy | switchdev | switchdev_inactive

			Examples:
			devlink_eswitch_mode=*=switchdev
			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive

Does this look better to you?

Mark

> 
>>>> +
>>>> +			<handle>:
>>>> +			<bus-name>/<dev-name>
>>>> +
>>>> +			Configure default devlink eswitch mode for matching
>>>> +			devlink instances during device initialization.
>>>> +
>>>> +			<mode>:
>>>> +			legacy | switchdev | switchdev_inactive
>>>> +
>>>> +			Examples:
>>>> +			devlink_eswitch_mode=[*]:switchdev
>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
>>>> +			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
>>>> +
>>>> +			See Documentation/networking/devlink/devlink-defaults.rst
>>>> +			for the full syntax.
>>>> +
>>>>  	dfltcc=		[HW,S390]
>>>>  			Format: { on | off | def_only | inf_only | always }
>>>>  			on:       s390 zlib hardware support for compression on
>>>
>>>
>>
> 


