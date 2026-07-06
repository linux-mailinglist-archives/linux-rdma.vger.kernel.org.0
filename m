Return-Path: <linux-rdma+bounces-22801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryirNRK3S2pZZAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 16:09:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B3711C01
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 16:09:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hQJCyOnh;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22801-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22801-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3BC032ABADF
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDD424650;
	Mon,  6 Jul 2026 12:33:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E33EFFC9;
	Mon,  6 Jul 2026 12:33:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341237; cv=fail; b=gTDUlxK3dPY9Ez+J4bnV5vVc+jBCZfCKQr8xHVtVpJ0agxZlgmXFZHiC223H2XQO7QdbZbWQ5+WGmp6Dyf9t0FX1qE6tYHZ9ge4UxIgzzylbQpYankpz3NsPysCVGXFG1bCkRd7vcPwnU2IReSJGkLa1zcn1rVvRtLPlKxEJQj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341237; c=relaxed/simple;
	bh=aRK13mULutdJRKapVb9aKwk1XEtRfDiyk3vhcBp/AdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g7qEf9VEK9UJN8j1y/Zzu2atVCghrXG86vq6XjHPR2mAcNg6spkBPKW5ZDwggUdVswnJzqaVsPPGx9avQ6/O53VUhTupkT4YZD0/SV3zrEWUMrAZYXyfHwHokiXmN8aWPg4DMq0FnH9tS/H17S/I7Co95FkXw/g6wnoPIlxZeOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQJCyOnh; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv6B9w4EBrraj6NqluBhyuTyp0mcvSE9QY3egEABBIeVMV0FpjT+8QSoXMWombMiZOMszXWG1Hr1H+oYHlISjiWTJN/5nIXd++Gf0oWbURUJS25PBU4D1TnM3MC51HVnch3zsxdUEoduNpvC7e86wyu9kXxMIKy9lRB4JcVbJcaNkBHv/IfX0pGsTPxw3PgVoQF+WKsK0VUm0BBPlfhei37GpaNAgzUoIOXMwGcp+O+y6vCqLEAiS80x3GBqeVi1Nt4zvG3ypD/usZYIfvmAcp4NQ277JN9y3DApmJGiY62i2EIrv+FQpn2j/E4/9B7tgZVzrrZzCj0iG/kepnrdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Meug4fjL0SBb2TnlleURJfrt7Mr6AzkFqQL0Q4ZWF+s=;
 b=b3nBxF+agIj7tE72Aa485eeutKsZrS6TOeYrHU4cyNc8CChZBRY/oWCwGoMFwYc2hd2w6ujm3J9SgdFwvUXvPuMyqF3fiOjoAaPj6CcbHm/+nqvUcE25Xo/kXqLotTXIYab6V1g0KkFN4Gt5jVZki5EP3RKPQTBVa9e9NdOBZYxQMQWSVifQTUOSmEwsGhaCroVafx8ltxHCrL1KSo7AxKYZrhoLzK5cEVvgN2sx19tam8doFUgQBXaeW4ufD68nfQUoNqX8Gtzto22Ugfv6qdQgHWRsVP3Wl/cAzrzEJscRlbHHKT0cMy2+bPxzNmi/gKMAxiLJcDxjcPQ5ssRpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Meug4fjL0SBb2TnlleURJfrt7Mr6AzkFqQL0Q4ZWF+s=;
 b=hQJCyOnhGXtf5mVCeQZofbz+S7EQyhae/h37Isoz8a8QJdb0RsuRe39A435JeovgSvzDoSczofLI3cxsXA1vgJ15j78XHC2Bez4hrjnaSAvz6mZih6q/uWL+Yx+Aa2PZ1/hPYpg1xRbUPVeTSFsOHlQOdnkPt8RVNRlaeICNoLv9W/55IF94bFKpxqFCA/Wj3yBhovePEU1ES8YPMvgq4sRVihQltuQD8V4RyMVP4agibUf5Y2+tgrnaX8tPVw9fPj/SegKRs9IL+jSoq4wxivzE+YhRarD4v5HVq0eewmcuTZ9FOQYFQ+BDLyxCIRIvECQkzWFHTRpZhLFDharSOQ==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 12:33:47 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:33:47 +0000
Message-ID: <0bb37f75-c94a-4a10-b115-186b71daf14f@nvidia.com>
Date: Mon, 6 Jul 2026 15:33:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Zhiping Zhang <zhipingz@meta.com>, saeedm@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 michaelgur@nvidia.com, stable@vger.kernel.org
References: <20260630165324.2859353-1-zhipingz@meta.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260630165324.2859353-1-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: cacacbdb-5c32-4f90-4bab-08dedb5ad329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fgTeeHfhUxEVuxbKYdCEemOFjNHGy6XZzNHx9oNnxjs99MTtdMmZqsSQXbOp+AacwRvO7Lr9ihGAol2NIhdj6+fDy/Y95UTmB58NN5XPifziVTdhjilEbXuFamI3TLiBpcpUo2K7/aK3/HfpLYsRXZtNqdNv7BIL099H9Jpec74CSk1qx2jRclTSIRszkmzAerdBTrdVS5nSGtsCAWm8RrCuMjFYGOCfGQj+vMwsIIE+9ebYHzqU4RWgZCgWVbPAMvtxEdzryt77ofEjdMbpQ+ol8+W+jA69FZljE/YQ1q2NNWDR3rGvoEihqCxXDnlv3mCpYW/Sh9FDL7D3UsQIALxM2QawX/9DgOodge+s6zKfa1r2Ua+rP9JSht2345BizpNdJIGXB0lPEvXVc9Ml8ykJmb4d++KwTYJjfK0bw2IvYG49zaQmcLTO2c/6il0/49bEC3fVgsXJ8thRexPLAQcQuDKrl+I+K0bPymfVNL/KnNDl/BmGSx7ake0syPnJfg7WIncGIg7YiioFHMY1KJDmBuzz5/AnOYAO6kzhwVZ5vDXCFWG0RwPKav7WM3NiqYMnpBUTL+uWSOqhi/cSVRd3s/Wp83cJ/9f0F5Y++O8CrYefYLQb/jnpuia30T9t5TgjmZKgDianT+lZQO45R/fakaNpr9+PKX7uMMVwMbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVNMU9mUm1pVVdURGpFUUcxVHRUdG02Rm5uT25mSzI0dHRheHJNMnFPeDRo?=
 =?utf-8?B?WjhCb3FoWllFUGZtZSt1a1hmTks4aFVkTk1ZM0NRUDg1aTFieWF3YUhDbGlQ?=
 =?utf-8?B?dFlLeGpIWWtYTVVwanVVcWJWdzlwaXI3eGhWSlQyeEJUSGNJSlRYL0lnNUpL?=
 =?utf-8?B?ZHBXOTVRQVBiTnBETTdrMzVuRlNGYW1BdnJJNnpXckMrcFB3bENpMzF5UVJN?=
 =?utf-8?B?RTRpenJ6Znd2dmorNlF3R3FEd1pmdFNIc1l5MWF5ZzIrNWJTMkpyekNtWlNh?=
 =?utf-8?B?dU9iVkJHZmVCRWdjSFp0OGF0SlJDUGU2SnVkQ3hBemIxTU5UVjN4QUJYOFRx?=
 =?utf-8?B?V2xjTksxdXBUQ0NvQThzYkVLU3lMMHJ3SFN3YVl2WndPMjhoMWRmczd0MENE?=
 =?utf-8?B?R1NaUENPcVppY0lmSkZpcHVSYjVtVXFwaGVsMnFkWjJOa0ZUL3JNcW45Q09a?=
 =?utf-8?B?ZnVtcnRQamFhaHFHVlZDS3dOZFdPdGdYeWVnM1Z5UUx1djU4L3pnVk9JS09x?=
 =?utf-8?B?djJYNmdrdlFVZVpTL0twQjhpdnM2UVBhQjFVRStzODhvbVNUancrclpLV2Vk?=
 =?utf-8?B?cWd1RkpoNEFQb21jM1cvVFFzd3pXVXRPdGtTeXE4Wi82eU9mcmRBM3BQN2lw?=
 =?utf-8?B?Rm5nNjB2MG5ieEV2dkpYN1FJeW16TmFBZmwvSHRaUDFXNVE3bWVNOUlQaHdL?=
 =?utf-8?B?N2REbVcvUDcvYmtKVUd5Z2xnbUs2OWVWaDgyV1grSjJTUzV1TUVIcFJINkpZ?=
 =?utf-8?B?cWJwL0dEYk4rU0R5TkRkMFBKV3ZXNWsxZ0s2YUNVMkMrUFhZNUg4Y1V3VTEw?=
 =?utf-8?B?K1A1MkE0ZTZPZmczRGVtSUVkKzFESlpQeXlYNUJDa0w2UXdOdEVhaE9kMWJh?=
 =?utf-8?B?Z1hJUXk3UGI4Ym8rYXVjYlBrNDFRaDZEWHJIUDQ5bUNFQVUvRWo5cDFEdWla?=
 =?utf-8?B?SW1yZUlhbkcwWEtERk5GLytDNFVPVmJPbXhQQnZxTkxxZ01zSy9iU3g2ZHVx?=
 =?utf-8?B?b0kxM3ZUSzhjSURhaDNGRXdnbjZSUUxOb2ZnZnA5ZDJTaEFZYkRzY3MvRjVG?=
 =?utf-8?B?TmxGWG96Ky96VHg1UHduSTYycHowTTV5MU5TL3l0bWRlM2tjYXAvNjdBa3d3?=
 =?utf-8?B?cVJYaWRZZGIxQ2dES1pib0RZNE8rZitqd0dHWStCckx5ZVAxWGlUcFNIZWc2?=
 =?utf-8?B?bDdDQ3dvOTVELzZpMEtJZjF0MTUyM2JnQk1mRjNlRTVaQkY5d2dqUVArWUt5?=
 =?utf-8?B?Tjc2RWhzWEZFa2I1RUxUMGFSR2ZRSTAvT1haeXE4aHVsZEo1Mkt3RTNQVnh5?=
 =?utf-8?B?MjZUUlBGUmtQMHF5QUJSUXYwUEQ1TzE4bC95UWthYWM0dFFmMUxwZmhURlI1?=
 =?utf-8?B?Zk5nYmw3cHRNRzY3QWxyR0J2NnZKQ05OUFdxb0djQ1VaRENPcTZ6WndZTEdh?=
 =?utf-8?B?U3N0cUtXNE5iWVloQklsZGZibHZ3Q2tSUk85U29uR1UvMUphd0x6N1Npdi94?=
 =?utf-8?B?WU5MWjVjUkRsY3o3ZXpnazhEN2lNbklXY3ZsTTZhK0Ixb05tQ1dGaENEaWhw?=
 =?utf-8?B?Y1lrSVJpcUpsNHdFSWdpemNuOVBodk53UmZVajZtckVIUHJPeEpKcGFBR3RY?=
 =?utf-8?B?cyt5MFdWcUgvMHFKbVM2ZGdsVHBjRHo1ZWZtTFhFUXpaaHMrSnlJYzlyaTNV?=
 =?utf-8?B?Qk1oQi9yY21adCtWS3NEUmUrRW1XbEZ1V283dUxXM1l3OXRFVER0LzVBbkVy?=
 =?utf-8?B?T0ZUZTB3cG5tRGJoREdLeEhYK3owaFhITEZYcVBoRmlXcy82NStaeHQyb256?=
 =?utf-8?B?YmloUDJJeHRocS82OEYxdnhvOEtyZkF0Kyt4dGNzcld6ZVlHMmdFWTZzZFNB?=
 =?utf-8?B?ZTZqNHc0Ulk4Q0o3SmZheGRnVEt4WTFabksrMWpUTlhNYWVuMm03RTZWU2Jz?=
 =?utf-8?B?WkZuU2JHbjdCK2F0VWYvRVBITXNrcHZoOGhORlU2NHVtY1VsMy9uUmJXbklL?=
 =?utf-8?B?YmQ2eEg4cjlaelZybGEvYzRFK2Y2dzkxeW55YTNHc2Q4NjJhSlZQV1lhY29q?=
 =?utf-8?B?U3pJNno5RktjTnlFd0FBUFBWZEdoWFBZcXA1ais0UVhHeXBzRnhTTGJwOTFa?=
 =?utf-8?B?d3Q3c0Uyb05ueGNRaWx2Qzd1a0xDQ1NrcnBqVEhjWVovSlc0R09ubnhCQTFF?=
 =?utf-8?B?MFM0OGtXRTd0Zmo4d0dCNHAxTXIvMEx2VVgrWm9JS1VlRkNBWEZRUU82bDk2?=
 =?utf-8?B?ZGphc2llTFdab2ZDVCt0bzlLcHNsNnZhUU04VUdkUUZvVE9RcURMUUJrYmt5?=
 =?utf-8?Q?YNStEYrfMzdPAXEW3S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacacbdb-5c32-4f90-4bab-08dedb5ad329
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:33:47.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNXhdKudVsGK3+Y+9gwxjVvRxrv8S5PrZavf1/E4csYA69JHZ4Ubc4ZAWK+XKQrUUn4pvc53WV21q1QhjS445w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22801-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelgur@nvidia.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 221B3711C01



On 30/06/2026 19:53, Zhiping Zhang wrote:
> Workloads that repeatedly allocate and release mkeys carrying TPH
> steering-tag hints (e.g. churning RDMA MRs) leak one
> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
> and the kmalloc slab grows over time.
> 
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
> mlx5_st_idx_data allocation was never freed.
> 
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
> 
> Cc: stable@vger.kernel.org
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
> v2: respin per maintainer-netdev.rst; no code change.
> v1: https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@meta.com/
> 
>   drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a13..7cedc348790d 100644
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

Thanks.

