Return-Path: <linux-rdma+bounces-21913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KGjMBlouJWoIEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 10:39:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2D64F24E
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 10:39:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=seJU19+S;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21913-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21913-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A68F300691A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FB36CDF3;
	Sun,  7 Jun 2026 08:39:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736082853E9;
	Sun,  7 Jun 2026 08:39:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821588; cv=fail; b=BD0HaHLhfoN5nUO5SWnpPv3DNvjt9a5Nr+ZpKZzQZs2VPPCp28o/MBeYX6OwE2WJUZwYqRBVqoAYSlDnEwBLMLqZNKm+RfK1+pgOtxfoq9Gzk0X2Ii8v585o9+9I5A3VdJywGLskFzwNC1oTb43Iwk3ED3w8LSCkNfhwNVl2RDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821588; c=relaxed/simple;
	bh=ozYt0RIVfDA/MMRpXEoENoDDmY9dH0XTRT8Lc4fN8cQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X9LZub7MkXASz16i19XG43S+eUkXLe4mYW7IivnLAyjXDoc4da7xKBChs0jTaQw5dQX5epImTg/cE1rlBMsgSI2ti0/+EEUhvU8ampA+8oeOtcdJ0nCiHZFkU+2PSs9qotdP5a9F2xHggoAVnXV3Bp++X4v3tTEAoOYtOfSTjvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=seJU19+S; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amRx1f2CmfskbJXyRhmhtRSZxHmTPuWwGK6Di0XRlos8kCGhCdoo5brgqD7A9mMslQOd1/NIUiQhMyYnX+zUTG/wFcpDjCmpjGszLkMmvDwNpnRfgfv85KXQx8NE5nJgiC9Xv2b/nvvhzLpKOzP9D0401iSawPSyv2WazEOaAbaaLZhKwylek+Fg1D7P+Tg4pGii6X7zmPakpHmY+0LSRe8MLtx2+OWjt9DY/HoRE4cdtx4O1fkpQMEdDJ2BAJwhFIOMNL8v2hHnzUxn8Glm7kfsvrD4qCOuMMYrEyj/GQTAT6kqgq3rDsm2eU4dVAdkMYB+nZJ++DiXcAn/SZiVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5d1j0hJoTl/JGVjFmx2NKpQPhAHSgYupTv0FJVjN1Q=;
 b=SNPOfgDUgso3RRL9qabTgJq7/1lLj42cr9BdLUamITKpZkiC1BBW7sud7xJfnABP1WNhciwVn+RaOWpWOcEpUMYxWVkVGFVaiqyZpuKevtyibfvEPBnqlepchMUeC+mjI98BuZX2k91yN1YBnt+7fYWfTPBNQ+na+0ixWR6xWpIBB96Rsi4+8XEfF1fG1ceORYwhGOa/3wBs9sikf9qSB8NYGB8LTY9MLJPa1m+IEUHexntFbjNkRvU44tIxLb+YVZnq2gk1amNsz3wbThl8k886WteqWH2ZHBREAJlHBCvSdEZq4/+yStXoobzSJPpSvI6lyxrLKvsOEtQaCHuX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5d1j0hJoTl/JGVjFmx2NKpQPhAHSgYupTv0FJVjN1Q=;
 b=seJU19+SNYoLJ0Dg2QqnMidYMrDNiT7frgGqmj/KVQxm6QWp8Wh9h2ATZbU5k/iviwQLNmv6KGRogJm/Gtg4Sesvl/7Xd49sS4rci7wYmDuVT851jeGu6NDCPSToEn5sYrizLNCoeaVrsGvhI5un+aBNNBM90FJFogcQECMN8/uVs/UeBDp2eTmGqkB1NZk7mQ/jQlVKC3vx3QjsRlAnSJysXknHUZuW7r/ptOHq3EkvilcLxn+pyjBSm9udtfsLVIoG6BdGkmRQALoLn7KROjxZrdAoFw+hN0+2/iiEwjVGVq7ipM6ARZrrmXBB4ZYam8v8lVjl0f/LRelqvCFH4w==
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Sun, 7 Jun 2026 08:39:43 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 08:39:43 +0000
Message-ID: <2f5fae68-fc76-4604-92de-7e88d5cb8e21@nvidia.com>
Date: Sun, 7 Jun 2026 11:39:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/mlx5: Use effective affinity mask for IRQ
 selection
To: Fushuai Wang <fushuai.wang@linux.dev>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shayd@nvidia.com, parav@nvidia.com,
 moshe@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangfushuai@baidu.com
References: <20260605102112.91772-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260605102112.91772-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 93028828-4214-4c95-f453-08dec4705225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007|22082099003|18002099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/M43SP069lk2pXuOhzrB5wRPlNbIBEUtjXyLkhiXKVH5SSljTUkEa+3CtTc+Hd5Oc2fmRdxCdUDaf6x/3v3fPBhYHF2wM/Mx2ZrHOQhuVpqWiKX33P5LHwqIjFEZMH0O2MzcdDSfFrrQRuL6J/1CCbGqX66nzI/rwzr2nHxfIsydNfP1/h+VxACddrniXqieqGM2c80QZbI8A198qNdD1t3HPTXTncOw/Mm+5URze/ZaWNEffvHTSy27WnF0kghYyWpVHz+67XiLdZm72Hsd/97GgBI8qJKvC0q5mKQxgDAKa6uS6uNbdkyow10PyHl5TL7qQW/yoy1HRR8L3z8ZcPHDmMKbIjYLsjpqBssCfVkqbL1tq9MJxF0Aqog4SeBmm5LENZrSXd0j7AYZav+B6YROZEcyE8krvIbeOVM1zJytuD6I/3nfZ1/tBj3rq8y9XmoxqhNHLrt9Z1uNP5im9BoF00HfDwvJaj6CfwPcaqud/lYPCTHj+GGpN1gEgizuTzvKg97D2iplmxKjmVTI/GPeLHJ/lIt3wJips7xJqpS6QvOfH59dmK45m2yR+VbvgP+x5FJZb9FV+xjvLXOsq1U5kJmYZq+T+7T4lTAdbdlytNpc0MazzYNUCgrrltDcBRhDPn4w/P2c/5L8xJs2Yi4LRaoOKJJDhf/CvM9Tt+n8H4+346pRiA+7EYR6LP4O5sqai4K6iyLeJrv+2ZEvoTiANC/Dy9f5l1dqbFiPHGstEQosot6BMw5jTG2kdTAH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(22082099003)(18002099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2JFbHhVbFdPMDlYYkRZUkdIZTNwUHoyNWRTUTFNbmNxb0puUW5YUG5WS3Js?=
 =?utf-8?B?RWR5K2IwdEhWYTUzcCtSSVIyVjJGQnRPOGNyVUZWRVpGV09RR3ZxenhuWFN4?=
 =?utf-8?B?L3JrWTVmSzZiMVFBaHVaZis4WmU2Q1I1NGVZTTR4ZzliV1gwOXV1U0tvY2hE?=
 =?utf-8?B?ZXcyMkdCTDRGcUFCSjByLzUya0x4L1o4M3oreTV6NXlTaXdueWlPaWFRVHB5?=
 =?utf-8?B?UTFRWkpoWFUvQjQ2RFZBOUw5Y2k5NDFicVBwQ29oRlZrSy9vU1Z5clBIb1pR?=
 =?utf-8?B?bk1QckdTSGZsNmZ4VUlNQ3VkbjFLNmFjWXVSWDI4OXNxYS85SzlUeTk2NlpE?=
 =?utf-8?B?ZmpQcnRTVDJQYVlSMHMvWmlxZ2lrUkt6czQwVGFCVlhQTHJONGt4Q2QvOVFj?=
 =?utf-8?B?cWlWM2dSTlJQKzhDcXhoUWpjTGhQZ2NoYWlvZ1FIM2cvNy9uTzhtOUNRYWsw?=
 =?utf-8?B?REhZOEFRRDZmWDlKdGozS3FHTjlETGZkRW5FQkNoY1g1eGs4ZEhkVGZBVUF3?=
 =?utf-8?B?MjZMRjdxMGlHZzRNcmVNeVdvTkxETGRNd0NJUzlNVHVzSmJVV3R4djVKV1A2?=
 =?utf-8?B?NUk0ekVhRXdJWUhJc2cxRHp3Ukg4KzlCMVZyWTdMbkoxZmZiNllUV0oySXhY?=
 =?utf-8?B?ZGpvMk4zcHF2VXF0dE53OUhzRjIxZmJlS1FDQmVaT3kwV3NEQ2lEdTh6SVBE?=
 =?utf-8?B?dTh2TjMxQkNyTDdVZWpnWWthdThBZGNGVlRYaVE0RG81N1Q3bzZPZm8zMmsw?=
 =?utf-8?B?N2toWEhVd0xneC9LaGRPZElYRUpoTzZYUW5XVmVBbjkwMmhOOGN0NFdJdHM4?=
 =?utf-8?B?VWEvekN1eCs1NnU4WSs0RXN1a2sxakVDUkFQWTdoNnhZdnNDakhqN3p2b1h4?=
 =?utf-8?B?alhZQjQrbWFETENwb3ZITlVlQ2J5VDFnK0xHb2lTTEpyMGtVM2h3ekVYZUxO?=
 =?utf-8?B?Tjl1NUNJTkxFb2gzaGI1aFhGL0JGRGRBanlKSHF2K0dWanV4b0hxNXc2WlhU?=
 =?utf-8?B?NXl1THdhcTZLYXN0bVR2cWJaNFdwRXZJU09JTVBxb0xmVW9XQ29ZczBnUUVl?=
 =?utf-8?B?WUgvbUZieldSM2ZkTVpBc0pmY2hOMmtRVXM1d2toVkxLTzlyM0xKekFUWUh2?=
 =?utf-8?B?ODdscTlWT3RNMERVdzk5dlJZR2szOFFISW9yaEZzOVV1ek9EVWxaQmFtVm5l?=
 =?utf-8?B?emwvc241SUt2Q0ZoU1FXdGZyWlNIVzNwOVdFNENPMkNhb01CZkpnS1pWejRq?=
 =?utf-8?B?alNuaDVwek5FZXdHS0lOU2w2bzZZY091bk5aQTdqTU8ycnIweXZkQVk2Q1la?=
 =?utf-8?B?L2k4elBjbEJqYkZTM1J5MTBYOGJMblpCNW0xMWQ1czl4TFlHRXRxZ0pObGNv?=
 =?utf-8?B?NzBYcHNSMUZqNDJkdnlNdTVRS3FLTTB3WXU3QlIzcTF2OW5Fb0M2MndiMFFE?=
 =?utf-8?B?U3NNQWxUMm5wMFY3UFJibWVSRnZJejhNUnMrbTRocXl1czF2R3lsRGpwMy96?=
 =?utf-8?B?QTN3V2Y4SXB3bTBTK3MwVWlYU2JMeUVyRGdEQ05BNTZhdm9MSlIvZk9XOHZm?=
 =?utf-8?B?NXgxWDhwL1Z0S0MrLzlOb2JvcWhnQ0VCMDBWcjVidVF6ajd5b1RCeHE4aWhn?=
 =?utf-8?B?MTF5bVRtcmdFMXlxbEQ2ajIxV2h2NlJJRUxxbkR5RksvY3BQM3J0bUZva3hQ?=
 =?utf-8?B?a2hnM216ZmtEdmZxUzNNS3Vod0NzV1RDenJqZWMwNE1LYURPcjJoUDBjY3R3?=
 =?utf-8?B?QWNEZmY5QUErNkFWUlZ5dTdxUmFGcmk0ZnRNK0I1a0pldmtXSzFwaFdNK0F0?=
 =?utf-8?B?VnRKQlpPZG5aOFoyRGZpZXM1d1FuUWJmOG9aMkkvdThGaDVoa21Sc1kxSkps?=
 =?utf-8?B?V1g4Y0NwckR3ZkJZRmxZdHBNNXA3QmtFNGlkbXpyNC9zcW9uenF5L2p0bWhu?=
 =?utf-8?B?MFg5VHkvbzhJWVZ6MEZwbERqdlVPdkpXSkxXK2w4NHFiOUl2M3hYN0gzeVVo?=
 =?utf-8?B?aXFtS0RmdkdubDlkY3htOThzQkJWRDhTVERIVElnUWdrVFFsTEdEcTJMSzZN?=
 =?utf-8?B?cVlhQkhTazBCa0l6elQ2c2duUWZqY3hidHYralZUTEZTMFF2djgwamNCaWZW?=
 =?utf-8?B?Z0QwUHpncExZZ2g2UURYeGp5cWNTYzJBcW56M0Z4NGRMbHVmK2liZS9vcnlq?=
 =?utf-8?B?Q29jWktqdmpEYURadVdoVnZuYTYxWTBKd04wY2ovSmhveDlqcWdiTmVZYVdP?=
 =?utf-8?B?SlpFS1dNNFBkSnMyLzZwN2pLQmJUVmFxZVNlNzkvSFY4ZGJidmx3MHhsUERp?=
 =?utf-8?B?WlA3R29jb0hWSG9JcGIxZlpOV0tUcmpmeTdCclJodUhzRHNiaUdkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93028828-4214-4c95-f453-08dec4705225
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 08:39:42.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnhCgar/m0J/hgf+zNNTKgjuObSiheKTPd/zWxyTqrkpa5Ua4MBl+QSiY8SbeJeay5VEyj3rddUFBbfynU964A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-21913-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shayd@nvidia.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DE2D64F24E



On 05/06/2026 13:21, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When a sf is created after a CPU has been taken offline, the IRQ pool may
> contain IRQs with affinity masks that include the offline CPU. Since only
> online CPUs should be considered for IRQ placement, cpumask_subset() check
> would fail because the iter_mask contains offline CPUs that are not present
> in req_mask, causing sf creation to fail.
> 
> This is an example:
>    1. When mlx5 driver loads, it initializes the IRQ pools.
>       For sf_ctrl_pool with ≤64 sf:
>       - xa_num_irqs = {N, N} (There is only one slot)
>    2. When the first SF is created:
>       - The ctrl IRQ is allocated with mask=cpu_online_mask={0-191}
>    2. We take CPU 20 offline
>    3. Existing ctl irq still have mask={0-191}
>    4. Create a new SF:
>       - req_mask={0-19,21-191}
>       - iter_mask={0-191}
>       - {0-191} is NOT a subset of {0-19,21-191}
>       - least_loaded_irq=NULL
>    5. Try to allocate a new irq via irq_pool_request_irq()
>    6. xa_alloc() fails because the pool is full(There is only one slot)
>    7. sf creation fails with error
> 
> Use irq_get_effective_affinity_mask() instead, which returns the IRQ's
> actual effective affinity that already excludes offline CPUs.
> 
> Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
> Suggested-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> v2->v3: Separate the patchset to two patches, reverse xmas tree coding style fix.
> v1->v2: Use mlx5_irq_get_affinity_mask() api
> 
> previous discussion:
> https://lore.kernel.org/all/20260603072657.10868-1-fushuai.wang@linux.dev/T/#u
> https://lore.kernel.org/all/20260604125705.21241-1-fushuai.wang@linux.dev/T/#u
> 
>   drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 994fe83da4be..a0bb8ee44e35 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -105,9 +105,12 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
>   
>   	lockdep_assert_held(&pool->lock);
>   	xa_for_each_range(&pool->irqs, index, iter, start, end) {
> -		struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
>   		int iter_refcount = mlx5_irq_read_locked(iter);
> +		const struct cpumask *iter_mask;
>   
> +		iter_mask = irq_get_effective_affinity_mask(mlx5_irq_get_irq(iter));
> +		if (!iter_mask)
> +			continue;
>   		if (!cpumask_subset(iter_mask, req_mask))
>   			/* skip IRQs with a mask which is not subset of req_mask */
>   			continue;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

