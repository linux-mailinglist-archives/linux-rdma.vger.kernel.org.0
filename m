Return-Path: <linux-rdma+bounces-19648-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCmMOe+J8GloUgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19648-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 12:20:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBD4827BD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 733F7305C2A3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA903E558C;
	Tue, 28 Apr 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nXYLVpB9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7803DA7DB;
	Tue, 28 Apr 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370780; cv=fail; b=Mnr4Le2VMM2DrTvOhxWTdS5qLkA8Uj23XcjgdgROrfKCOMkRpR3b8LMe3CDFjtpATJXmybOdTt2Pt95vYRLrjPejAh5cDgtIOQWLBvJrQsXddUqx/XGWc7mYmk4ih3jq9XW9mlxBME5c7HISIs3YEM+wl2NqhLoI5gTpNltGwjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370780; c=relaxed/simple;
	bh=af3QgH6n0m9iYqKghbd3ggFYJ9UIezo8lj4fuYHsJ60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5krQmPR7zh41QdZpNwveqQG/YekMIC51W1LSWeVa16M2ORdOfyNoUEw2EWE8MHV12igfMnOtgPcb1KlDeLKyMbxOrd2hQt7CUmI+Qz6uNmTVhYpDfv5I6H1mhgKnf8O+AuJezwKG8BYfJoGA3drjm5epLPA3lc0fSV3TX9O698=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nXYLVpB9; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnREC9faOCZVMD5PC+HhEojyxqg+ivd9xkY4gndT8RrfXj9s1N5CLkeL7+zC7+CQdf8fZRTMbV5Ko2wI/M/rg/TPghRa9x5amV7azhQ/4uAdzoMcUUW1wbCOSA1UdloEGqW8+pV5ZTDRmQCNCAsTbTC6/05PniuBlAiLq9wVTRpf0QAQDy1T3Qb05BgG2QmXVJ+7hj22oDAKZ+sz14SaJqUthRAhgdGwYVfjGM2g0mE1Ufom4zRQ/mnNKnUUKt2zB/pKiYudUw8+xd2PtPRKFxd1xXwJWsHOc8F2LK7G0qYFLyImteDbJRrbOZsylBiPxzDFleZQWf2pOhl4LwbycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc1Uvwfs4unQLAxIUhD35HCLQ0eCBMI0ZD7xNXuv2pw=;
 b=nDaPNbLZp2h+gTlfhFxGkO+YnhKYAA35JvScAzknSLauIzpP/ptJZOPKOwMvzx9ldTw3WXfn3xqkhPQ5cP1ayWkOjiYmlHNxeYRnjQhfprxqcmu9fb5cu+ES2hWTYpL4dNOGXgu+auu7EXTQUUuhkMnG5IcCqRV5wnYqBGKJS1IXrDJBni49cSVIB3X3Sw7QmyO44Y5wxcYi13zuxVfbnYh2PwSCPin9CQhXTzkNZWrhOJwTVQjlIbfQqFmfi20b5tL5erioFl8dMUWlzuu1bFw1l2fm5aePpyM2pCFPGA9fl8bM+CrI3igoE7As1jonESICOxJgzGJBuKCE4gyQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc1Uvwfs4unQLAxIUhD35HCLQ0eCBMI0ZD7xNXuv2pw=;
 b=nXYLVpB9TbTUXuvFwGwiOcUR4kSCEXvcxHhqw76U4hJVGUJmrXIMqvY/xX64krlBDAOFcQNMyZ0Wo3kLzhWMYCSZmabg6eXJMH7ywR/zk0frF+Yy4/wmrERDr8HGqA7iNv7rJZhZZAkcgclkxAWeOjO7kTe1lTKFDYwLJe87rAZ+HSLsZgrTycl0CnzemgIz48QQlxT7ulaCQC+iKkRmSXgv65K//KxsWJ6gXQDHsJuoiMWU5+0DRmF6vP4TfGN1BrbaBTAvuGCGoU6iqlW9v+X7ykwTTYyOGlkS3ahDh3MDqaGhcBDStGXu+aY6atTnnnFQwaZxraZdh1RDucj5Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 10:05:55 +0000
Received: from SN7PR12MB7023.namprd12.prod.outlook.com
 ([fe80::e329:4fcc:313d:2e3e]) by SN7PR12MB7023.namprd12.prod.outlook.com
 ([fe80::e329:4fcc:313d:2e3e%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 10:05:55 +0000
Message-ID: <98c17c60-6747-4c2b-bfe4-ce9bbe560f6d@nvidia.com>
Date: Tue, 28 Apr 2026 13:05:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/4] rdma: Update headers
To: David Ahern <dsahern@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, michaelgur@nvidia.com, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
 <20260330173118.766885-2-cmeiohas@nvidia.com>
 <20260427112505.684c21f3@phoenix.local>
 <77e1a762-e204-497b-b7cb-40d5a93f8ec7@gmail.com>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <77e1a762-e204-497b-b7cb-40d5a93f8ec7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To SN7PR12MB7023.namprd12.prod.outlook.com
 (2603:10b6:806:260::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7023:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a5940a-291a-48bd-b79d-08dea50dbcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ca+5UGBUcS16wDOHnCCZG2llvavz+1DHmy2F5/KTMwzdW7uSs4kBfPSs9jphHXXcC9Dh3LzQb1J1coLmI9E6jCvfrMBAWymzNdH0Vxal+bILxhNFmVUCzFhNDyKEwD3dGz8+kWr2pyXD+VNOoolFA54eHKTy6796zrTxmtTMILruibKQZtVvNPX581kxcivn3+jqUdcmJ/DpTeTqbsyblgdjlxGXBtuICJIqdSJI2jAoKv6p79Wrcal5/huaqzErIyFxX+9tBtv8zdYvDVcoxW2LBL9aFXBnvYNwVIBchp789/RImmyQ6af9exg71d9R4PaB2Vs5YMmKQfEfxRWduNhKLoPrTggz28FidB0ziPRmsRak991arcPHMF15jLwmdzwI3SQggNlx1Lw0Hg19EQLp3952I6s7AHyfADoOBhTKVIB4IwBCIs4RAA39huF0PrShK3Dfm/ffqjxqVXU8EjPqh3IuQbVWAQnWOcj6ToUOV6RBG9v+juYljsihtzLWMVNG/Dn70osWo2CMDFwjvodGjvXXLICdbfZ+/ueu8IR948h/124YMncX9khc0mNib36bWJVPg0CqQxxvNuQ3fOV9s5AIjjo7PfZSJhWeHqyTU1qst0MItNcGkL/FEMcGTtjfkA5iwJd00PJ+cRIpxFrza2gZhTaE/RGiJWTEb8EmYm1qnVVQS5LmNp8XSzAiv4kkXlUctSiDtcQOsHNs9ZU/+/u3s1YDHSx8ysXYjYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7023.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNRMVVHeW9nYkFSeFduSHh6NzlGL0wyT3c4S0t1czR4MG5aSGl0MnVYbmZL?=
 =?utf-8?B?Rk5FRmZYV3FkYmlMOUw1RDBSQTRHK3QvSEhYYndETVpuOWcvWlhnVHVNK3hn?=
 =?utf-8?B?amNiT1FzUmRsemJGZHErazl0WXJBSVdNQ3Y2RW45L3ZLUzh6dkl6bS9md1JB?=
 =?utf-8?B?WFdCOXorTUZhNnFTUFpibFl5bWpjVnNMa2VNNnFBeWkxQVVsc05yKyt4UDRC?=
 =?utf-8?B?M1ZYWm1DTG9lMFJ3V2czZDhkNmQvOEt6d1NzSGwvOGd1c1pFS0d3MGpzWktR?=
 =?utf-8?B?RGdZY2w4WXJSQkxFaEdyTm8wMTBaSjd2SDJrWDJCMXNCYVQ2OWdhQjVPV1Nq?=
 =?utf-8?B?RUtmYUNGY1NqTSsvUENmRDdLdWJFb2V2OGtFOVFZZjBJbjhoQzVkUlhHTlBH?=
 =?utf-8?B?c1BHckhMeFIxVG56bE9pcHlETkw5QlBrNFduTjdRbVpSWk4vS1d1U3dyd2VY?=
 =?utf-8?B?U0lIWmpMVThwVVZOQ3Zib0dZTjMwMVpZbkN5eG5LR1VoeTdWbERjRmpFZ2N6?=
 =?utf-8?B?TmJtTFlSNnFCS0tsYm55cndpNUZoODJHbmJBM3BjMUJMbU1lQjdlaDNvbHJP?=
 =?utf-8?B?RGhOYzZ0WXpGWHRDQUxFSTBud3ZxdmYyOWxWYmkybjlpamtIb1BxOFJ5cjZv?=
 =?utf-8?B?dEg2U1NVQTYrYnJwTmlmajV3Z09SVkRrQkZrMHFuSVErS1FPS1ZHR1ZIUmV1?=
 =?utf-8?B?alg3VTVOQjJVMkZzSzVRRWxjOGFBcnhxVTEyN2p4SHhJZEg4SGxMUjdOaVpu?=
 =?utf-8?B?ZWhOU0dhZ2h2N2dTcFFLNFczbjhlYWUxT1RnZkJ6VTdTM0MyK0w3c1B2N29T?=
 =?utf-8?B?UDlQa1QxbVVUOVZpMG9nWXhWMGdrM2U3R1k4STUxYUlleHpkYUxFNzQxZzN3?=
 =?utf-8?B?ZGh0SncxbUdxcU5Sc0xvTXZXNS8vRkJyQzR2dithbDVYRWFlYXg2d1lnYVdV?=
 =?utf-8?B?WFNSNWRoTEpFakJrcitlNGxYT3c1US9zUzNGN0RUOHBJeW1IZk9jeGlrR1lm?=
 =?utf-8?B?RXJCbWRkZFo3cjBBbTIvSkF2MnZrR2JOYzV2YVRReExDcUVBTE8zYy9lUzhG?=
 =?utf-8?B?QUFYdG0xSjBYcGpJVGcySlJNWXZNb1JyUngrdVozSEwwbG9ULzV3NEtiVGEw?=
 =?utf-8?B?emc4QUx4V3RacC9tWVVqWXRQaENCRFZ1TTFGZmVITmRmZkpWR3p2MFg5SXd2?=
 =?utf-8?B?a2hVR0FHblZlbmorcmlhYzBqaHB5Nlk4NkUyWkU2and0Y1NyUUVDc0xZK1Jl?=
 =?utf-8?B?cHROdjNoUTFRZEFleWpuUTNtaHNuZmRuZXdRT3RTWExuUlV3a1FaeVhna3g0?=
 =?utf-8?B?NUlpc3EraG9ON3lmT0ovS20ycXBJMDNncXhJS3licGVJK05UK1luVWtDT0Z1?=
 =?utf-8?B?ZVNSL1JxMTk0akhYMFhaODk3M2c4QVlHeVNkMkpYVzQwc2sxSEdPaW5xdmlD?=
 =?utf-8?B?THZ4bWVnbDlJZmtMc1MzUWdyT3EveTV0YWIwQytyNFJETXYzQmU3TEhjVUoy?=
 =?utf-8?B?emFUQUxSVW9DOXVabE5wUnpVZ1Nzb3BQTmlXTkk3QXI1M1Z3Zm9NV0RJMStU?=
 =?utf-8?B?TlJrM0d6SmFSNVhrZkJZdTN1TC9sdlgwcFF1NVNyYUx6bVNqamZrRGhFZTZq?=
 =?utf-8?B?cUVSTzRsay9lSmE0UzR2QnVKeDU4NWM3eDhXVGR1eTN1d0dMVUJHdE9XQjNB?=
 =?utf-8?B?ZUIvcDVkYmJadGxHTG1IU3NCdGNKdGdaaTNlWE54NEN5SkhMaW8weHFYVzdI?=
 =?utf-8?B?clNhdnExWFptNW4yZVY1amNIZW84dXpkY3RCUU9VMGFvTW5XejZIdlZKcmQ4?=
 =?utf-8?B?VkpzZFRTa3h1NUUzVGRaY01ndUJ1TWhRb3JySVlwVWtZbldjUXNMZUJ5YVZG?=
 =?utf-8?B?Sko1eW5SY0ZLeU84aHpGZGcxNGQ2L21rVTJpNk9YbkZMZHdmWk8vWS96Rk96?=
 =?utf-8?B?VzFUa1BPN1ZLMVkrcDVLaXBVWklyUlJ4aUwzRE9pMUlzL2xMdjJkS04zOGtW?=
 =?utf-8?B?MER0ZXg2Sndlalp1T3JvSkNBa1Z0TzFtdlRPRklVeThWSDdLQkxrOVY2SGZ0?=
 =?utf-8?B?c0ZzRWNlZmxmdEI3QncxVTNHamRodW9oNVZhaWN4QVZibVZVOElhRVQvclF1?=
 =?utf-8?B?N3d4TEdtZFpUbmh3T2VjR1BZRW5PbjNZcjYwY2ZPVVQrSzVZdWo5LzJhRUht?=
 =?utf-8?B?MzEzRDJoMlI2cHZTNDJvZFpITTc3LzNnWFV4Z2E3WHJPQ0FiTzEzT0h1OXlH?=
 =?utf-8?B?Y3greHNaaVlXUVJyYjdtR0VPcEdwWTYxYnZmYUVPbTVRZ2NpK2pYQXdxbm55?=
 =?utf-8?B?YVdxL2FEakErRllvOEJpdTdnVjYwQWE0UC9tVEVpdm9mUU05eHJGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a5940a-291a-48bd-b79d-08dea50dbcab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7023.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:05:55.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9WGNdZ7bFCA9dhJVuBdfZ6d80nesAze1xLtweb1O4MJC9IkSbCNjtdERN2gbLgosSJzUBEFnRwATeqU33AW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
X-Rspamd-Queue-Id: 12CBD4827BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19648-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

On 27/04/2026 21:27, David Ahern wrote:

> On 4/27/26 12:25 PM, Stephen Hemminger wrote:
>> On Mon, 30 Mar 2026 20:31:15 +0300
>> Chiara Meiohas <cmeiohas@nvidia.com> wrote:
>>
>>> From: Michael Guralnik <michaelgur@nvidia.com>
>>>
>>> Update rdma_netlink.h file up to kernel commit dbd0472fd7a5
>>> ("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
>>>
>>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>>> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
>>> Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
>> The upstream macro names changed, the iproute2 build is broken after
>> current headers sync.
>>
>> In file included from res.c:7:
>> res.h: In function ‘_res_frmr_pools’:
>> res.h:203:26: error: ‘RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET’ undeclared (first use in this function); did you mean ‘RDMA_NLDEV_CMD_FRMR_POOLS_GET’?
>>   203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
>>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> res.h:56:44: note: in definition of macro ‘RES_FUNC’
>>    56 |                 _command = res_get_command(command, rd);                               \
>>       |                                            ^~~~~~~
>> res.h:203:26: note: each undeclared identifier is reported only once for each function it appears in
>>   203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
>>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> res.h:56:44: note: in definition of macro ‘RES_FUNC’
>>    56 |                 _command = res_get_command(command, rd);                               \
>>       |                                            ^~~~~~~
>
> Looks like the merged API does not have the _RES part of the uapi:
>
> kernel vs iproute2:
>
> @@ -590,19 +590,19 @@
>  	/*
>  	 * FRMR Pools attributes
>  	 */
> -	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
> -	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
> -	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u32 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u32 */
> +	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
>
>  	/*

Thanks for catching this.

We will prepare a sync patch to align the names with the kernel and send it shortly.


Best regards,

Chiara


