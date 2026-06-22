Return-Path: <linux-rdma+bounces-22403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ezKYFhLcOGrajAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:54:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BE6AD0AC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:54:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=i1nwQJZk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22403-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22403-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C2D13005158
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6A360ED0;
	Mon, 22 Jun 2026 06:54:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808C35F5ED;
	Mon, 22 Jun 2026 06:54:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111242; cv=fail; b=k9OHh/HHz+bON8S3ITcdKVztpdP1jWob80oRwi56t5n0BRgR6jtqS25nhk/BZVRCxXSVeRXpwll/x9WuitIuaOt/323vNOLY9ILzHSaeQKXYLibOsEeS3PfQdpw599zF3F/HCHT30rx2IOdDMH0x7L6eZ3IjPY5CKDxtxAOT+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111242; c=relaxed/simple;
	bh=Nwi5A9GTjRqOIv6vnz0qFpGRkhvoEfE4Qv95Wrloh3E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htfgu8H/F9nlTsdswb8N6bzFYnxHLHvbDcpXJ0e8Lv2HaQsj+P8s2/Qx8VU1Ai3IWBrl7hDUpknsZfANxLtVJx4oSUFBGahhe37df8DMGeckJLvh1VGSwwT0RkeWW8eNmqDs4u8KgbGAoVqi1bKD4NV3Zhuy1tlKawhhIU+miMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i1nwQJZk; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn5n9RALsGAaYZlXgiGBSdA0f3bVf4Jkb6SvRV90GoOPORsE5ftNl7+KPEt1UFBZkWdKmXW3pIBtcdJncVsaA+akIyuKSi2ilB852MPm2XMMKtrw+4zLP3x7LOwzZqAgkelGDuAG84gqL3ImT/O4fvOFzLs92YVOBF5cJbZTUKN/ZaokL1K6Y7WYbHcFc1eyuBcOlhe+V/tOdyPsDcl9RFvC9iUPI8i2Dqsa4YbbEDwpnAqgJe0bapXlzEhJxE2frDwDr6J8kexKiOIAvWu+JxELHxq53vUc9W3rPomr1g5WbJMMX6xxyLgqDtiEnJ0G29xGbK+Llqc593OL6q0G7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9EZx9StusR8r7awvbLGjW5MntD+WXKGNVeBwk6Ei7c=;
 b=je1EYiB7jiwbV75xAUoNKVV3av2qNLvdsi2pjqe1FPwuKTx4f6TqzGOJieCsFBp/Si9r7kbMDDEbXBpgFfOrxpfrWa7AC2c1GNhrmEQbAS+samfe7u5ZVODCzaZouPwzzZpy0M/pdTG8V9+BYK4G8WERiY/FYf+/BQoFFDY08Fab/cvF3i+HrvhUmmmV6Or8ixgb0JrDRIbvz0evAARR69iF0cSJRRnUn0x65t0AVMO+TQBPI4evQqpeidUKtWRoanQb1Ke+EgT3Klnq5n8IvEJZS/GFZRN72zLyOMdSvKtTZoXavJX+aB9Lca0UafgVl/aRDNvSoHwGcsZEyXj0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9EZx9StusR8r7awvbLGjW5MntD+WXKGNVeBwk6Ei7c=;
 b=i1nwQJZkKV8/arvGrPxzWPqMFZK29PcX5Kw/6ZOQ0/+p2HNjTKCp9Pr2TviPw7XdVUaFDAbCbMHNHKDD3CK+N68Xv1EuEXouW/HGUJgGJqCc3Q2zF1bKPt9WcvBurKYCoxUqEIucjKNarqa9jjJB3RmAaeDQaTG4C2N7FtWbIh0928sQOkxnBv4GsRjnKFoGH0aT1YMFmq/nlApPYjO94iGRBsX+XE8sDwW870LaxGHX1dhu3NhYB5eiTbYVeMIZCbNX5okYkY+04Uu8TBcT7tKsxjV9djzyOtvIPEsPhPMuSXaWUtrsgbwh5WLZFOm0qJ+sTVUgV2cOMRZwl8qdAQ==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:53:57 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%3]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 06:53:56 +0000
Message-ID: <6c890d92-20d6-418f-b6d7-70ae599676ff@nvidia.com>
Date: Mon, 22 Jun 2026 09:53:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Free steering tag data on release
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613153725.1874-1-lirongqing@baidu.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260613153725.1874-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e13a113-2c5c-4f65-edbf-08ded02b07c0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zy2qb4HGrp1VOt/kPyzxsMUJJKmmuMHP1MpwcRk7lh7uqXT4miViLGqDFFIWdGBOL4eUx5qQQzLPPUeO+oHVrCP5rMFpRQAcx9C5AvVS8F5N7nR2gpvIwrX6kmCACnb3Ch600y66LVWAKNGwy082g5MDvfyIu2eLt0f7lak9X9G1yDLI62erK4dvzixEPoWZaSmAIaV7LwRYHEbSXGLFDAa+Shp0IygyVXxRew8F9u9z7Bs1cJ028trMqGT5EExTVaCVxsoFJzdd6CCVfpxMXuTramSOS9XGkEm6n0KKrxF32WH+3Nb/9z8HMoqoeJRJF7ng6DL0kT5C0HIN31cNRIfmas4odkFSpTZWs0MRvXq82HgPreUJVdzD0v2pEs3l7lOjbprhz8j4mAE16dGbdyWaXMt3zd+FiUCC+eW/UVROD/zonqcUoUHeJ+5/uyNSDATIalqKVOU4UkS4wQQHtbm01WOfanO2GA8mi00NhbyDudD+E2O8iwUj5cV8AvUIanElsze4V8jokHOklhULNu6itU0nlbe4UNHYv1tKuSxzMdZcUI3IHcYIyvXsiXUGbAa95DtXLtJNMplggMFEMtdlZB6+STtRfNOdxLH0qMR0dZ3Fx+gKfAzzN0PuRFyISmJTz6Sg9Kh5JcDT9akjSMbvX72kGFyM0bQYsQiTeT6/1+beC7t8TSKvAfVATzyltGFglisuXxjanuQRXpIETw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFFwVG04Y1EvTHJESUN1TGZvYURIK1FweTNZWVNKQ1NqTThTZUV3R3NIQ3Fh?=
 =?utf-8?B?Ry9jMDk2cGwwKzNhbUlqTFBtUyt4eG5NcmkzRUJuTHJ3N0R3bFR6LzB3aEZE?=
 =?utf-8?B?QjlCYWZxUEtEREpJb0hHNDdvbkJXeFZ3ZGh0VEdEV2xMWXBGV1ZsMDQvK2pY?=
 =?utf-8?B?ZWtPOWdUempIRG5TZnVodDZiZmpXOWgxMkpPLzRpdFArRUlIWG1ZMmVPc09s?=
 =?utf-8?B?MWl5RE52ZHhJbXJmUjFCWHhBc3BuR254Zk5JZzFWdU9HeWIxR2F2YUo3bUNy?=
 =?utf-8?B?aHUvWUpLRDZ0Z0NtbjloSlFTZHNtTWlFQlo1ay9xV0NoTWpXUGZidjFoajha?=
 =?utf-8?B?OWEzamNaOUxZeUJRL1JzZmdvcmg2TXdPcWdPbjV4bWpvQUJvNTBXQjRSYURF?=
 =?utf-8?B?TzVuelpaKzllYVlDc01kZmoyWEcrR1oyY3BKZXVIelRISVV3WVdjOVRyQzRa?=
 =?utf-8?B?Q3VxZmVyUy96Q0c1eGtpam9ScEUyQ2kraGtOYWhPUnJGV1dUQ05SSWJ3d2do?=
 =?utf-8?B?SC9DbDhNVmhmaVQ4ZG5LUVZhQlZyWlkveVBtV3dzdzViK0srTzA4dmlscCsr?=
 =?utf-8?B?R1FiaS9wcSt6RVB1TUdKNDdYa05oa0JnREx2cHhEcHJqakwyMFk1Z09WaERE?=
 =?utf-8?B?VUVKOEpZa085UGRnYisrbERaUEJmakxMaHN4cGFrWUZHcXYrOW5PekNNeHl4?=
 =?utf-8?B?YjAwRW0yZ2tOSm92NEtGcjBJWE50V0lqLzRydGZXNHhCKzRmZnhaekxDVjhN?=
 =?utf-8?B?YUpHZEo4cS9aR3MwMUF4L21wTGNLUlhaaGdLVzVjaU4wRXQyd3RsZlVxTUs3?=
 =?utf-8?B?c0pTSmZNYnp0YW90cGVnYzM5ZXpuYW1nZ09oVXkvdHNGTXFlOG5wL2xTak12?=
 =?utf-8?B?cTdHQWRPQXZmTHFoazlxRm9mM0wrZmREejB0K3MydVZWSTR0c1Q5TG15ZGVq?=
 =?utf-8?B?aG9URy9RZmQ2ai9leHpRMkxkNk1Wc0NpSXZ4V1lheGlTa2tOQ3VGS0FkSDl2?=
 =?utf-8?B?ZysrV29sbHBqa1EyN21uaEg2NS82SlpNMFU3L0M3K3U0UlBxbUprVEFrSGtY?=
 =?utf-8?B?cFlaUHJKNzdFdDIwZ29rZTR4T0tLL21HZ1djWjNzemJ1UDNCUnRFR0hDcXNL?=
 =?utf-8?B?R1dVL0tvWFpvN0F3dzJxUEVZSy9IS0ZWclQvNjk1UVdpaDlvMjByOTkybEIw?=
 =?utf-8?B?bnZveUMxTDNyT1VTWTZReHI3Z0l3V3RtemtVTjBodFdieTJjc0J5NzF4NTBH?=
 =?utf-8?B?alUyU1UydFBjWUhRbi9jNWtpaklvSTQrckdSTEZ6NzRJZTVSMmQ2b2NRS25C?=
 =?utf-8?B?NGVJSXMwWGJYMktxZnliNk5HbkRCTUJBUko2MjRRd1E2aFZyc2JHU1hWSnI0?=
 =?utf-8?B?UFRzNllwUGptTXFzblhTWnNIRmhFTk4wck9KU2pyS09ZZHhPZkVHYnJiMlZz?=
 =?utf-8?B?bWlOMHJ6ZUtTN2oyVUlFQktCd3ZWTHVpcEVzZ1k1c1NBcEFOUlZ3Z2txQjNX?=
 =?utf-8?B?a1NQZFcwRTF2ejZzVElhbW0vU3k0dk93YVRTdWszb2NVRVViRHk3R3FvZmFZ?=
 =?utf-8?B?Vzl1SjFDMzdpRGQvK2IwbUNyWGk0WDV5YkplSzBEVDVQMmx6Z2FKQW12NHFy?=
 =?utf-8?B?d0NZSFJidXFyL0hBb3NFaFExcDg0UFRXVVMwM0RkSjJMWnJJU3RUeTlFTUZK?=
 =?utf-8?B?VElhVWR5ZEc3UUVsT1I3Vml0VEVRVW1ydTNZaUpzU1dmWWMvQ2IyTWVveFdx?=
 =?utf-8?B?aytDSHRUdEhNck5TT1ozemdveTI0aVE5TFVPYWNzRnZoUkhuaFNmYlprT1BQ?=
 =?utf-8?B?Sm5XSWNFTWFYNFV4aXJKelFXcFRzMnh5UDkxb01sMDdxN3RpaEtEWkU5c29M?=
 =?utf-8?B?MFNDQTNrTXU2YXI5cGlQZzZHc1krNklYMkF6emRhTXlQT3pUYXcvMmF3VWdU?=
 =?utf-8?B?cXM1RTBOSGNNTmh5V25mMU9NRUE3YmZwaVoyZXJDTTBCYmZuUlozTE5WQTg5?=
 =?utf-8?B?amU1NU94cEFkaTFRSlJqUTNHd2JKRVcrR1F2WWVZZHdXUWYxTHZRWGNWQlBF?=
 =?utf-8?B?aE56T2pheEpUb0c2dkk0eHVJQ1dSODVWYUx2TEhyRk9BNzE1eUhEVjY4cnZH?=
 =?utf-8?B?NlJzUUErelJuRXczM21lUUQ3RUtNdkdib0RRbHRsTmxTSmkzY3gvNVVxaFVL?=
 =?utf-8?B?bWtqeUthNG5JVXg4cldDZEpCYTBlNmZlTkZXcC9HME1kb3lubFBFbmhmNUNG?=
 =?utf-8?B?VWg3Y3pNZ3VJRG1wWFhpRHR6WTJINVZlSG5WOE92Zm9QZzRIbkp4Q0tNMHh2?=
 =?utf-8?B?MW5DeVBLTXNyL3dycHJsSXM2Mnd3a1FlQXZlYk5EUG00d3Y1ZDN3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e13a113-2c5c-4f65-edbf-08ded02b07c0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:53:56.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPf0nrdp5ZAnqqMfD8ZoWtRcLJroANuKGl1/SyrxnhrezSwycxcXfiailTvFxXrQP84+kZBaSk+WauUm9PT+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22403-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B6BE6AD0AC



On 13/06/2026 18:37, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_st_alloc_index() allocates an mlx5_st_idx_data object for
> each new steering tag table index and stores it in the xarray.
> When the last user releases the index, mlx5_st_dealloc_index()
> removes the entry from the xarray but did not free the backing
> object, leaking memory.
> 
> Free idx_data after erasing the xarray entry once the refcount
> reaches zero.
> 
> Fixes: 888a7776f4fb0 ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91..7cedc34 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>   
>   	if (refcount_dec_and_test(&idx_data->usecount)) {
>   		xa_erase(&st->idx_xa, st_index);
> +		kfree(idx_data);
>   		/* We leave PCI config space as was before, no mkey will refer to it */
>   	}
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


