Return-Path: <linux-rdma+bounces-22610-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzpNK6hHRGpArwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22610-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 00:48:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 441DF6E8793
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 00:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aOwt6rJd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22610-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22610-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B6A9301E226
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604531E107;
	Tue, 30 Jun 2026 22:48:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421021CC51;
	Tue, 30 Jun 2026 22:47:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859681; cv=fail; b=TdP6NTnqiuz+oJOVC6hRA6a0hmsA8wlvpFhQ+9vwn+ikvMAdGKibL9Soy/UbiKJR/aV0LYQErPJXaRYX8v/ty9mJHQV1+P9boNnhwaRFB7/Jn4Io37LlglbCkU/jl4ub9i9+sC1HARSd64sQZ5XGlfdPLYki4hd9bJx/1SzIIAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859681; c=relaxed/simple;
	bh=M7aZCJ7A/bwxkwrogZpNpr4UW2/C+w5F9z1djdkTFs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjjzikKHCQIIzsxBT9zcxju2WXKoaaX2VGn3AcF/kcIaFZwjRFfIzbQMs3CzYSQbLNiR7oqwXMUIkCO3VcLMQ15n9kGrW3tLB8KqSs58kDXPYymOYSh2/eFBBv/igec9OjO1vuBVi2I2oJerpfccVuIlDs0iENCyYtbBXNuNt2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOwt6rJd; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSAZ6e/Q1Ivd691n2qcgMbbHTUYOOc5vXM5CxEI/JZLXxzNfr2QVtgu1bw2f2l8AeJc61Yq8/ef6bSP2IyFH7L3adLdVCi+Bn9SAmaGKlZWm6iTzwFK8Pnk2/IjjJSwCaVNjc0iPmxI3n2r3IqQoarzp+f0oWBZbGM030ixp9I7bXIPvLtvmIXBCTjFlH3fukgfnzN/X4w6nIEfizKOniZmZSHo6t+lmsqu305B3NXNbKWRKHkWwRfSNiDd6JBoUGPXDmkmRUYwn2Vt4Ski7xmzUgu0xxkCb4zV5m1q0WVfm6hX0CAcKsEEvooSe0/4ERJ5+Ov5RCyZ8PzLt7CEVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+ug32B4Jsle35MqAfvF3Rxns/M6x/bceS7vOMNw2gU=;
 b=d69lmQ2ZlgfveCvjaXpswolSnajTCSAsa7ZiaBq/dhy6pT3A7WgASx7bkDO7FHb3rY5fKaLqJW5gvDRk91ZRWRjg7aPJb2pWTDPqC1nKo6nuQZUJkYcWULLKm+JyG8fSm+xivJ50doT8B0vRrgFfMv1p79qq1BzDGuMRG0pMtYrPepk7nhbVtb+60IR4hXv3JmE4JfIsQF8RPA+A5j51cHIKvy/hj5EbKHzBExDM6E9sJCZ3Dr5AP9p1GrtQmMKNq+/cucQbAryi0oJI884TKA0eezj4F2rFxowB4WFTFt8kitKeVCPCccGgGm6vhdTphW+WBIZecuFIFCCYZhrNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+ug32B4Jsle35MqAfvF3Rxns/M6x/bceS7vOMNw2gU=;
 b=aOwt6rJdfp2v6IwVG2cgbWi3WvdJlI1qvVKP9OffSn68wGe1sD04RMbXZ5vNkhJg7GQON9ErAIa3r2hjiQ3H6C4wV4V6fRaz2liMzTGLtK7OWGJ1y+dr2Ad2jDnv2B2TH/X5qdWWoH8KMbNyB84OxHe8GVftM/UazXlt15s5hW43talDs/WfAaxQnVv/wl57hl+N23zt504uvXQH6FTepdmvdeXRexS4RuXzf3zG+cDGccBBXt4sZJTx7X1ISUF7P9JloeSk73Ff46EJDsXSdmItYegZYEUuI0QKgGwT0bFPbLyakX0dDj44YRB45ob5Wc1ZEftStqyCBKATiYqW4A==
Received: from BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 22:47:55 +0000
Received: from BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df]) by BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 22:47:55 +0000
Message-ID: <d6c67c8b-acbb-46fe-9f9c-b32232b00778@nvidia.com>
Date: Wed, 1 Jul 2026 01:47:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: HWS, fix matcher leak on resize target
 setup failure
To: Dawei Feng <dawei.feng@seu.edu.cn>, saeedm@nvidia.com, tariqt@nvidia.com
Cc: leon@kernel.org, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vdogaru@nvidia.com, horms@kernel.org, kees@kernel.org,
 stable@vger.kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
References: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To BL1PR12MB5873.namprd12.prod.outlook.com
 (2603:10b6:208:395::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5873:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6396d5-112a-4b5a-0cec-08ded6f99fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/V9Gj5aKd9EbGF/luLFCOMwkeGXGQWCKmidZD9FwGvkP+lcrrF9RXPkijxffsCfhM/mvOrJRU/AzghDGur/thgazr8/1ckqu7VJTQSmu1XDm6oAaVEY6OkxSWHedM2yFWxUCJo3UDrLpXNSdNs5ATX8pn3VRPpGEvcgeCIJngofRwDEwRD9bMuEF6YuTrSbI88+HSLc7qt83qjRWUVr2FaNc2BW00O0KzFmWUE8Iv8McAD4AoUZE4XcgetK0pZ42Tm408wONznsUhH+JcU9Igs7hRBU/+4nngoI1pKmIS20pXtxU3W06PtzwTOrbGdzCxkFFaqfe0TJSUN1D2L/irhyeZttR9JPGyl4yCs+b0uTah8wxFfEjlHe6sAvneac4HwY1OfamhaJPD6+TzSdOUyG5y1U71mYNK5sB6206GAk6PrH6NZxYRL4iR65Cy1/X01KjMvSHcAkAlfaIJeE9tPFJpyeKLlKq6ZwLsvh20ihdHxSLlyhzqn4dXD1QTXh8E8dvdxt7nmMaaMiur3ro73zz9UPhSJPNr2FNDTgyg+mKIqwZQKbX+9pIw5Bpcd8rzO9JLlKRMB9o0RYhnMNSHv7tQo0wJYrokBUtNLbF9BNiKe8USYUZuihFMXHMHZLc1eRZUnFbVohE4MIFltPtE+jFUVgRsq3OVsCNNgCaEME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0xBVHVhUEE3MHJTMCtIcGxZSE1iY2pLV1RrVkUzWHY5Qy9wbXlqOHpBbWlz?=
 =?utf-8?B?a3NXRDU5R2dhQWRIZEFucmpra2Z5R0w4clZGSnBDRUxYWlZtaVVzOGdpMWF6?=
 =?utf-8?B?b3JRQzFiU2RNbUR4YmgrcmM2S2F5a1piVGU4WDI0UWRlMDArQVdRT3FpVTdD?=
 =?utf-8?B?dEltakN0dit2bWNJL1VrUEVBZW9WMG9OK1E0K2F3MHBJSGY3U3dMZEdrRkFq?=
 =?utf-8?B?TCtUbFhDV3Q5WVZqMVh0dXVoc2VmQzNFcTF0SEFDM00razdKV0RRWHhJL3M0?=
 =?utf-8?B?eHFtZ2VSNllDblN5SFYyUlJFb0U1MkVBQXFKSnl1OHhjbVdrOTdJYTFKU1Qr?=
 =?utf-8?B?N3ZEZkI4YThFUVlESWw0R3lzUzgxVkRtSU5nUk15cUN3ZXVTVXdsZCtCNGl1?=
 =?utf-8?B?dXEvY0JiM3BGdnFtU1VxeStpNitQQ3VrUDkySzBOSmQ5c3pxU0Rna1h4eER2?=
 =?utf-8?B?VitzcmMycksrZkE4eWNZbXNONGszZlAzaXFIVmszZzFGclQ0Und5ZFkxL09R?=
 =?utf-8?B?N08vOVVMZTQ5WDFXQTJCSExDL2toVEpnRkt6azVKQVpHNFVVakMvQ21ESjBR?=
 =?utf-8?B?QlVEK1lJaC9SSTVlZ2djbS9CTUEwUkpnQU80ZFdnY2J6bkdBdElCSUwweTdK?=
 =?utf-8?B?TW1yd05jMlBHRld1UzdWcE5sMXVqVGZrcnYwcm5qSGpGdWRucFdUaG43SGJ5?=
 =?utf-8?B?ZG5teFVWOHgyM2U5SjV3ekpXZEgwVlNDSDE0c0grNmtJUUNXKzkvV1I4SUE2?=
 =?utf-8?B?dWM0M1Z0b0g3ZUMrR3pVQ2lPbkxEeVVPNUZkOFNKNXFpTnZmQzZ3blFmOHlC?=
 =?utf-8?B?citteWhRQ04xOXR4RlhoLzY1cldJZmh6WnZXb0NUUnRnTHFKOWVrSkxwRnhD?=
 =?utf-8?B?eFpyOURqTlpoU0YrWHRKdGZhMTAyNHNzVHB6a3BqanlqSU00dCs5Rko3UE9v?=
 =?utf-8?B?c1k4YzR5UmVUME04NmtXcXZSYTl1RTR3bjJlTzNpRlVyZGVMR05LWWM3NWRz?=
 =?utf-8?B?anVKdlN6N0JaWnlMQ01pYjBwR3RUZlVKVVMvQnUrbUdrM1dlZVdlU2JDV2tN?=
 =?utf-8?B?M1Q2VXlmL25lVWNxVVhvNjJqektobzlkRzN5MHFUMTZjRUlRZlk0V3RlOFVY?=
 =?utf-8?B?OTFFWHU5SXFaUHEzYWgrYWl5V1UvaC8vMlZVZkI3MVJrTVlUS25LVUpSVE4z?=
 =?utf-8?B?Q0ZVb2t1TWNxdDNEZkxzVGsvdFB3SVREUWMrK3k5YkxWdnFHMmlQMGlVQUpY?=
 =?utf-8?B?NExlQ2lYdkRuNjFRbGJlc2UrRVZVbEdLSE9XaDBXT2hxUU5maTNzd1hWcmVN?=
 =?utf-8?B?ajJDeEh5YWdyZk81QzI3L0NFTzJRODhVSGpPUHVRNmxRZWdvS3VVVzMrUnE4?=
 =?utf-8?B?MVI0WXpoUFNnamM1SE1yOHNCWVE3YlpCeFRITnJGM0VCSkFOUXNYUnFSY3FE?=
 =?utf-8?B?bFRKQVh1bHEzdXdBVnZ1ODBNYVhGN2FsNkNidE1SNGJzRU12TXRuYkRacG11?=
 =?utf-8?B?YktNSG5pcEVpMDgvblR3a2NiWFViMmtHb3NYdHRPSVZKbGFLVjRtTW82clQz?=
 =?utf-8?B?dk53RVlIWlE4Z2JzWXZlODRTb1RJb0lmS1ZaSDhra0FreDR5U3RVTldSQ1RD?=
 =?utf-8?B?aC9pLzNsMlNKeExQTExvRkdiMUVicmZQNFNXejdsRnRkcEJrRXJ1NzF1RDAv?=
 =?utf-8?B?K1NtVTVNMllUOFlWZXBpR2lxbXJwekkrTWowU0hyM3ZwQnpuK3BLeCtUKytN?=
 =?utf-8?B?MGljc3RXUWhTQVJjZ1E3U2s3L1djTGJnY1BESkdQZGQ3bkpjdERvbkIxKzlq?=
 =?utf-8?B?ZEdzUzBsQVRiQmRYUjFFVW9WUnkvTGNDNGdDTURXQzZRSU53bXpYSURqclVm?=
 =?utf-8?B?YjVVMW9aallTN1dWTlBDa01hbDhMOFFaaVBMaG1VS0Y3b09MVEtSdTdFV0dL?=
 =?utf-8?B?SE9zRTVKdmxlZjRFYVIwRFI2cHUrclU1MVJBaTk1YnVYM3dDNFpVMWRwN0ZL?=
 =?utf-8?B?WURHejlWaUx4bzBUUVhjV2Vsekh6azlSZ2VmOGg1SkJIK09DQUV3QmNnOHI1?=
 =?utf-8?B?ZEt1ZHcrUUh0QVlGVjdEVkhaNmFWNlFLS2E5UEhpWDBub2ZhZDA2aVg1Mncx?=
 =?utf-8?B?Ry9oVVluQ25KaDdCcFo1azZaNnBMUVE1UU1xaWNrMDRuZmlVTDVJa2FQZTZx?=
 =?utf-8?B?NCtRRmF3Wnp5dzVmcjBpNWxuZlNrbHZQcGhLWURSK2VFQ3l4TU43bFhoK1dR?=
 =?utf-8?B?VHM3YWJzMVVjY3hDSjNLdjRqNDNicm1nMldWWTV4SzVUZDc1WWtrdDBlZlFW?=
 =?utf-8?B?cW9DRm15L3EzT3RTNUhNZWRmUWs1aC94NE1Bc0dQaVUxa2MzbFdFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6396d5-112a-4b5a-0cec-08ded6f99fe3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 22:47:55.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InUZiyi7jRBkN0ZbaHohm4ZTOIFEdWcu3pFJO9jSk5uH005ZxGX9YQWLQFcIdoa5mrTbImHZGZ5QzYnZqgwVvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22610-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vdogaru@nvidia.com,m:horms@kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441DF6E8793

On 29-Jun-26 09:40, Dawei Feng wrote:
> hws_bwc_matcher_move() allocates a replacement matcher before setting it
> as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
> replacement matcher is not attached anywhere and is leaked.
> 
> Fix the leak by destroying the replacement matcher before returning from
> the resize-target failure path.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> mlx5 HWS-capable device to test with, no runtime testing was able to be
> performed.
> 
> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index eae02bc74221..3bcf412a08c4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -205,6 +205,7 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
>   	ret = mlx5hws_matcher_resize_set_target(old_matcher, new_matcher);
>   	if (ret) {
>   		mlx5hws_err(ctx, "Rehash error: failed setting resize target\n");
> +		mlx5hws_matcher_destroy(new_matcher);
>   		return ret;
>   	}
>   

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

