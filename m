Return-Path: <linux-rdma+bounces-17216-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCjiHmhMoGnvhwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17216-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:36:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA51A6AC0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25763093A47
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70366361DDE;
	Thu, 26 Feb 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HICw1oo9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD33612F7;
	Thu, 26 Feb 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112784; cv=fail; b=WEQS37gZLLGwfyBv0v6dV/TkkWl61+kZ9e+ClQbl4jkOyPFsA4UcGq4OJb7nUv5xroudOMqvsM4Z2QOhmnFqYaF1ub73ehdZT2pTThmlMyPBglwbvFJ4CPlw9MWjBh/YPH1q1AamUct/rnCKKWxoNSOfXtGCGAGg8jjnkxJEFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112784; c=relaxed/simple;
	bh=fwMyc22Bj6aZJMHuzWDVEFu8RWTsFK5OKizcV1opvgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYyo24O/kZqJGSYpUmhsXTeKNnjvlP9Rc6kGI3v/Jr9PhXMxtBfjYaPuUWtVUV3Yp7xNbJ0afv5IblvMCwL9LXoQd/fZ1joZ9pI1h9dRLgxMlm+8Cb39X8lftXo2SBJ90QUwXYT3AjSKklfdH3auofkZE8vqfjJE+biQn+nI+Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HICw1oo9; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ikrjwms7umJnUrK5gxusMUrdoEfNk5jS+/ibj5iAqbY+PrX4AaU0sAWAo/2E770QBB/+JLPFCJolx5gJ+msrXVBkibWnsyIexoGbWa1KIneDVChHnapHy6WWYyk61ahpNF/xaTW7k0WKcNWSPI0INNxuWRPihv+WRi7rXnzb+Bpde/tkfPzl7cf/e9LKPbYfSzHzYSzmQtoIEqHsrVLlPk4yxDbZ0ojNidc3bgy91L6p+D5XtJdkjYmJZLv9cuWzMuNz+dLXvkMmWFPpStz8fByTFFCeCVxl5DjfZZXsYjNOlBc74QcPcIKHrYxMNy8rAAhTmkPv6d9SE8NOStAbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3CVZ5g+lzvwmUxSsDLbwSpZavLGPePQtvIqaB6TDVc=;
 b=pvRND41wj1vhAM8Tn+4NOGzaf7sS1/0pcrT8OAc7GrYIwU2dy9UObLg6geWacqKviIOsPbsoQc6bZXgX3gFJhK0+SygX6JkdCyD2yhXr5VtZmFyZnXRfDwUw5UKLMKwxXKvF8hEJ3ZLFHiIgOlmIoLeczajevvpGifOcVNfycsPeVql12YC2w3gywcQ2zx9jd5NKfNgiDgWnuokvjuJFCNElCiSNk0lMZC7mtXvhZGZuXVqGn5OrsBIy6L0IYbFB8WqNbdpdQpwVU32cAVdDnaw0TA5IpL9x6/zVwGfNhCrp0pqZRsVpPe8I6NpeNlcultCYnfYs5gaElmTFtuisng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3CVZ5g+lzvwmUxSsDLbwSpZavLGPePQtvIqaB6TDVc=;
 b=HICw1oo9utDowflmGjC0fSpm3BAsmBvzwXDgm1CDqxuseg9RU+9stFizR24B/IdUS0nWqlyVdF/EE6nXwUyVGEo5h4eE8n/33BLJrCpPcPNoXLsfj+MYXloCbMgFdWLQK9L3F/9Fxs2dF4z8k5YmihvtbG2qIt/0K/pG7EdUvc9atww2qOrrcyLrdkg/8syYW7lTPXz7WuhiVp4kHr1c+6dT8hTBz6UvxDA3t5jeEO+OWGUwK+pn4/YdT9WZhD9NShw2gqOYfcJpldsiTLlfdORz9QNfuq/jAd77YQ9YdAIrbIfG8JI7YIp4305umwEceqkbeGGM0aPThk18nAjbwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:32:53 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 13:32:52 +0000
Message-ID: <071e2499-4c7c-4e5d-aacb-78c85c4607b1@nvidia.com>
Date: Thu, 26 Feb 2026 15:32:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v3 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
 Chiara Meiohas <cmeiohas@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
 <20260225114716.GD9541@unreal>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20260225114716.GD9541@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 051eaa45-fdca-40c8-f3ec-08de753b8ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	j9oOF+6/wK3rJp4tZQdcoN90nqsZR2NZrLdF6LJtTvYfC07VViX+YhZhu1XGIMeig/XkCs7Seq/emE+gOdLRKi3IU5hZNHI2U/ysAuv+gte3cpYh7pVD1xcTaPaS53BSCgBHzVW4G3v81se6twpFAoDML6+fAtflDqQXpq1VZX77UlUKAU+HWnVutsEEwmC+5i+bQfUj8LE86eWpj/mloOvtDHTh9TTYfSUb9Llp7qib/mzQLfPnhbNnx3sLAaR6EuRtgKTaQhj1JaQgmj2QnIZu3tokJrf/QX5CXDyozr20w3JAQ82yzi6HYNzv3fyxoCHdYDLmOiYTV9AGkovYdFhTVeqKcZq0k/BTOti+6LunfBKrfFJLw6guYfM3gwDOKPiJQmo5QSPhYZsSUHdy7A7C/iTRb2g/s42IVP/6jTsJWxFZtrrpvrvhkKPedkNN6fmgcKY3J6nOiP2IjjqDKOwtzfCZBoSBKZNyLkCYe67gr1CNprqPKUjd7FqmSPkYjpyUb9hlGAfsspZMm0DaNgg6wsPXharbeW9PNSEk+zo2hGlcTKlyvwZARI+0pTXM9JoajbmYVLKJnCN0nIsQx1CqYwN0Bnx8pOo4d307jRrECNDcfszO1ou1NMAfAHoTOKh3nJoB17+z0YbHw+kd9l0wT9qabCTs/ZOGTs01iQrxJvHimqC2/ti0EDMDtrIzNgMMgcbqyBn6UZXg4EOV5GKUtbODIEToJQKpZKndRuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THptUmhkZU0zT0pCYWRyMEYzWDBGSmNQZHdvMHNHV1ExaWVUemc4TERwV0xh?=
 =?utf-8?B?eFNDRTdMUUU0K2EyQ1pwQ3hyNHpoQ3YzeXVKYmRkM0RQZGZEbUxmMGhaMGcy?=
 =?utf-8?B?QWNkbWpxMlEwekJoclp4MlFYamVFWFEzdDNJRUZMUG1EckRjTGlzNkFyRFpG?=
 =?utf-8?B?Zk1FRHZnRlNlTEdDWU9DaHUvNEVMTVZoV1RCMFlVOUJmOWFtdEFMSVZzRWNP?=
 =?utf-8?B?L0ZpMEZ2UnNGZzVFRm8xYzZTRXdCVlFiT0MxMlV5bVNTVEZwS3Z1QThYVGNu?=
 =?utf-8?B?cXUveVJpWXZNZ3orTWRvSVpKM25GK1NsN0FLZG5MSTRJcjJnUXlzcWZqczBB?=
 =?utf-8?B?NktxeVJINWxrd2V2bVpTYzVWRnNzN1dQbUtFcENIREsyRHFJeGl3OXJsVmVN?=
 =?utf-8?B?V2VIb3FnNGZobTVYMldiM21DQUllVHcwQWJrMVZHaitsMXZzalF0aE45d0h5?=
 =?utf-8?B?VzVIR3ZOK3BsbGpNQjhzZ1ZQODZ0UzBkcWhtOVB4b1VkRUorV1J1N1czZGRX?=
 =?utf-8?B?YXZlbzN5Q2YyendSeStCOWNPRlpMcmtEcVd2Q0xqZXdWdjloVmZ0VkZSemJX?=
 =?utf-8?B?MHg4VU9nM3Q1K3ZZMUsremZ2RWovaWQ5TzhxZGl1eko5VVRna2x4cjlPRWV1?=
 =?utf-8?B?T25udjZ0LzNyL28rcG5pTnBqUFpGUGlsVmRpcmtHem1YcTBTVEVSRHVGSkt6?=
 =?utf-8?B?UGUzOGNJTFgwKzNsaDBUQTdkY0J0OEZwUzFrbkZsL1NET1FOQS8veWROY2o0?=
 =?utf-8?B?Z3NtSXM3cXhnNkZJR3luNFJ4U3R6bEV2V010WnZyNmVRdDFxV1NVRDE5OTB0?=
 =?utf-8?B?L1ZNOUVCNU0rQko0U0RkOTA4UTNQenJhVFVPc01sWEppWi9wNktXU0RQVjdY?=
 =?utf-8?B?TjE4SW9TeGowS3BRMkNYL0x4UWcyZURUdG1JRmRqSXdqVUhlV29tVmM5Q2VH?=
 =?utf-8?B?QWV5UWJMR2k3djZHa0Q1NWxQeG9meEs2bmlFSDRNSlhZbDdBL3IxOCtEU2dP?=
 =?utf-8?B?bEpYMUdkZjZEVzVCdHZoUVhnOEV1TWxBaG41SldpcTdtc0JzUXJOOVZ2R1gr?=
 =?utf-8?B?V1Q1NngxeDg3OFVQL0tDN2swdElMWUpEamt6NWVqYllZZlpJYlNiYU95Zjd4?=
 =?utf-8?B?V0ZnSnU5Vm9MVHpQRUttUG1RQkpQcDhGYkZHRlN4STZxT2tTK3pxcU5rZXpy?=
 =?utf-8?B?VytVSnU0THZwS0VZRlIvTEdvK0xMbWNKczUwMm9zV2p4cnhiOHhieTI3Szln?=
 =?utf-8?B?eHUrc3NjWmQyb3NPZE1NTkROa0ZoUTNWd1Zva2g2aVY1UUsrQVlRLzBaNHlk?=
 =?utf-8?B?OC9yeFFGZ2VLSFhUSCttZkZZVWRJNXdDakZBTWlsQmE1ZXJhSisvaUhQUUtU?=
 =?utf-8?B?YnIvSnR3UXNZVDdjRThIZDRsRmdxQTFhUjgwWlNQRXMwRHRVdGc0dGd1dVlT?=
 =?utf-8?B?WWFaN1l4WGZJa28vNi9OcDJGMmJCd1RVdHRacE1YUTZ0NWt3TFdobHhNNjFK?=
 =?utf-8?B?Y2hlZ1l1V3ZqZ0ptdmFMZWQyVEp3bEMyVUhSQVJKaEhNWXp3Q0Z4U2JuMkVF?=
 =?utf-8?B?eHFtWHVjYkk3YURwVDdSK0RzcmJ1ZUYwTW16RXlzM3UzR05uYmNncWdrb2Rn?=
 =?utf-8?B?dnNBdmlmMmp6elJVR0lUa1h4NjBIVCtzUDEvVnZRSWZSK016MXhWSW05THdS?=
 =?utf-8?B?RHZZTzdOR1ZkVHdONTBTK1hsb0ljdDZPbHVTa001dENpR0U0UmxHbExhWk95?=
 =?utf-8?B?ZStYL3RUUEZ5QmFPK2M4eCszMmVhQ2RxTkZMZFJuT1MwcTFtTnQxUzlDalY5?=
 =?utf-8?B?TFRrblVyLzR4MXp6dGtoVFVYOVVRRldPT3RNYkovZnhNYll4L3pSN3Q3aGlm?=
 =?utf-8?B?UCs3MXBXSE54ZG44R1BWSGxHcGJaQUJYVHZoTXNjanVSY3Bib09PTExkc2Z1?=
 =?utf-8?B?UVBQOUh5Y214eHhvSEpweWZGQ0xzTnJKNHVGTit5Ynk2aSs3aWVhYnRMT0U3?=
 =?utf-8?B?T0lDM05SekM4cWtQWlZnMkJKMzNXaW94bmI3RmxtYktBUHJuSDEzRlFlWlJO?=
 =?utf-8?B?U2J5VUYzWXY3cEh0UHEveGtCMFVwVTQ5bEZ1eXZubnpPTUdFY3ZhcklhVklV?=
 =?utf-8?B?YXcraWpSNDJYZ3V5bTRJaVo0eGNtYjJkV1RLUHAzZi9LZmpralkvZUt4MVFz?=
 =?utf-8?B?ZDlCR3lEOFJkR3RsODJaV0J2QUh3a2VVYXBPdHV3MnNnMmFhdTcvVmJyeStu?=
 =?utf-8?B?c1pqR080eUxsaktFOWVUSVRDZ1pLaWdzbWpRc3hUWUlDbTRCcFl0Q2gyNW1D?=
 =?utf-8?B?S1RjWThQTFBXVllrOUZJVG1Cejd1VjZsRXdGblF1UmxaekQ3UTR0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051eaa45-fdca-40c8-f3ec-08de753b8ace
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:32:52.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFNlwcN/r7OH4vzSneLF1EMJv8lAL9Jsyzybz34vzqOS8TL2coTswLy1N0aXXN7JIphr76wPxM1rIyjJ5Gr4ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17216-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3FA51A6AC0
X-Rspamd-Action: no action



On 2/25/2026 1:47 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Feb 02, 2026 at 05:59:52PM +0200, Edward Srouji wrote:
>>  From Michael:
>>
>> This patch series introduces a new FRMR (Fast Registration Memory Region)
>> pool infrastructure for the RDMA core subsystem. The goal is to provide
>> efficient management and allow reuse of MRs (Memory Regions) for RDMA
>> device drivers.
>>
>> Background
>> ==========
>>
>> Memory registration and deregistration can be a significant bottleneck in
>> RDMA applications that need to register memory regions dynamically in
>> their data path or must re-register memory on application restart.
>> Repeatedly allocating and freeing these resources introduces overhead,
>> particularly in high-throughput or latency-sensitive environments where
>> memory regions are frequently cycled. Notably, the mlx5_ib driver has
>> already adopted memory registration reuse mechanisms and has demonstrated
>> notable performance improvements as a result.
>>
>> FRMR pools will store handles of the reusable objects, giving drivers
>> the flexibility to choose what to store (e.g: pointers or indexes).
>> Device driver integration requires the ability to modify the hardware
>> objects underlying MRs when reusing FRMR handles, allowing the update
>> of pre-allocated handles to fit the parameters of requested MR
>> registrations. The FRMR pools manage memory region handles with respect
>> to attributes that cannot be changed after allocation such as access flags,
>> ATS capabilities, vendor keys, and DMA block size so each pool is uniquely
>> characterized by these non-modifiable attributes.
>> This ensures compatibility and correctness while allowing drivers
>> flexibility in managing other aspects of the MR lifecycle.
>>
>> Solution Overview
>> =================
>>
>> This patch series introduces a centralized, per-device FRMR pooling
>> infrastructure that provides:
>>
>> 1. Pool Organization: Uses an RB-tree to organize pools by FRMR
>>     characteristics (ATS support, access flags, vendor-specific keys,
>>     and DMA block count). This allows efficient lookup and reuse of
>>     compatible FRMR handles.
>>
>> 2. Dynamic Allocation: Pools grow dynamically on demand when no cached
>>     handles are available, ensuring optimal memory usage without
>>     sacrificing performance.
>>
>> 3. Aging Mechanism: Implements an aging system. Unused handles are
>>     gradually moved to the freed after a configurable aging period
>>     (default: 60 seconds), preventing memory bloat during idle periods.
>>
>> 4. Pinned Handles: Supports pinning a minimum number of handles per
>>     pool to maintain performance for latency-sensitive workloads, avoiding
>>     allocation overhead on critical paths.
>>
>> 5. Driver Flexibility: Provides a callback-based interface
>>     (ib_frmr_pool_ops) that allows drivers to implement their own FRMR
>>     creation/destruction logic while leveraging the common pooling
>>     infrastructure.
>>
>> API
>> ===
>>
>> The infrastructure exposes the following APIs:
>>
>> - ib_frmr_pools_init(): Initialize FRMR pools for a device
>> - ib_frmr_pools_cleanup(): Clean up all pools for a device
>> - ib_frmr_pool_pop(): Get an FRMR handle from the pool
>> - ib_frmr_pool_push(): Return an FRMR handle to the pool
>> - ib_frmr_pools_set_aging_period(): Configure aging period
>> - ib_frmr_pools_set_pinned(): Set minimum pinned handles per pool
>>
>> mlx5_ib
>> =======
>>
>> The partial control and visability we had only over the 'persistent'
>> cache entries through debugfs is replaced by the netlink FRMR API that
>> allows showing and setting properties of all available pools.
>> This series also changes the default behavior MR cache had for PFs
>> (Physical Functions) by dropping the pre-allocation of MKEYs that was
>> costing 100MB of memory per PF and slowing down the loading and
>> unloading of the driver.
>>
>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>> ---
>> Changes in v3:
>> - Use rbtree helpers for pool find and find_add operations.
>> - Use cmp_int() for pool key comparison.
>> - Make key comparison inline.
>> - Link to v2: https://lore.kernel.org/r/20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com
>>
>> Changes in v2:
>> - Fix stack size warning in netlink set_pinned flow.
>> - Add commit to move async command context init and cleanup out of MR
>>    cache logic.
>> - Add enforcement of access flags in set_pinned flow and enforce used
>>    bits in vendor specific fields to ensure old kernels fail if any
>>    unknown parameter is passed.
>> - Add an option to expose kernel-internal pools through netlink.
>> - Link to v1: https://lore.kernel.org/r/20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com
>>
>> ---
>> Chiara Meiohas (1):
>>        RDMA/mlx5: Move device async_ctx initialization
>>
>> Michael Guralnik (10):
>>        IB/core: Introduce FRMR pools
>>        RDMA/core: Add aging to FRMR pools
>>        RDMA/core: Add FRMR pools statistics
>>        RDMA/core: Add pinned handles to FRMR pools
>>        RDMA/mlx5: Switch from MR cache to FRMR pools
>>        net/mlx5: Drop MR cache related code
>>        RDMA/nldev: Add command to get FRMR pools
>>        RDMA/core: Add netlink command to modify FRMR aging
>>        RDMA/nldev: Add command to set pinned FRMR handles
>>        RDMA/nldev: Expose kernel-internal FRMR pools in netlink
> 
> 
> There is a need to rebase this series, it doesn't apply.

NP, I'll send a rebased v4
Thanks.

> 
> Thanks


