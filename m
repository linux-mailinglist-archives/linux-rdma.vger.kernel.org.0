Return-Path: <linux-rdma+bounces-18080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBASGJaMsmkQNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:51:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301326FE34
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 955AD3068A06
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796FB3B52F5;
	Thu, 12 Mar 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYMSQE+u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA537CD4C;
	Thu, 12 Mar 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309022; cv=fail; b=Cd2RB7Yj0dk3nRaWubAQOVMQH/HGqlYYz78Cg+jEyUWp4IjX37e4inCCLQ1j2dsIRExp5VYpwvswa9AEXvHi002nnvb10m1SK0gf1DiLeutPK9syuamu1m0Y7ew/aznI6gOoZ4yST8pkwbVwRU99h2ExFVoftSkueUEbok7HCls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309022; c=relaxed/simple;
	bh=fWx2cLhHW5+7c1bOZjsBwXtCRaTJrw8ojWt73Twrsro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubnF3CYOxBq14ufDisptr3oRG7N1IcuP8oMMDVGBpZW9ZuJmcgqEDZRCeBuR2w9TgR/I0miMeyYTZx9++u/M6kIGLLcD69Vnlx4MGnjIXcDA0w/kjyLOq/hRRfrLHAKkx0GtlFoMgdcPTK64zZf/nZFqCAbG1tVFzb5X13/llt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYMSQE+u; arc=fail smtp.client-ip=52.101.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcIchac8Y48V2lI4261ej1mPtOgo/khbr1QIOfY0j6JwwUhji83LXyDquRKlXs4XxcFm5wnctLhsIqv4ObxcR79FxEnmGH7lZYdVBHuAmwhxOesz3lhTHu3ujqhqyUHOwzmF+BOzPTvnH1b/2VxSg7330eoOtRKlwynHnzgqswU3IM5Joq3bL9BRKCnLVI9510v1/pNEfUc1tVR1iIXTDylT45n4ZYZ3bX8W2jtQrLJB0FO0O43oaeagoBfxzJKvjRDcsu4xWM5o5QJyt6mzUuCb1thZMIVZFHG/mGkMfWdfA1fadHasUJeI30i3s2Gd+Tn8FoK6Hg5olE7NsyarFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+zAam2jLgThAIFtG4j3kUuSCj4OreIpzVHv537I+Vw=;
 b=fOwMmdFlb/MQuzMJ+MGgqW9wvBFyrRMdG1m81DxPPizTagKbb1CKHI4cst53LqrqckQ8Vzyy2UD0Znp2sq8ebfMb1pU/cHAXLE+aDI3FaLAtr74NojPIn+OCe6vgb2M8EUCfYE9qf31Q7KzhNlkd4klajpYMcIOVNEijBDNFdDkj26eO+ui2D+epcK8sahdLuf/9hrOq41FqWm2o4lqKNM95UvLXL7nXk4RnU2W0p7IwOgRKJN7L6ol//PKXFXxIGtpColo2sM0oDe+fKvAOS1PV9e8eZgfM5B1P94DilnCXOH9+UhRYtU9buodjWLrSYCtzqMyFoHBiTJzj0YQvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+zAam2jLgThAIFtG4j3kUuSCj4OreIpzVHv537I+Vw=;
 b=fYMSQE+u4FewwMr7Hkt62++y/VH/QpLdC1RsH+5cQ/f3roTr6nXKx+rJxQmhq+py5BE8WrtU6SzZbLX43IKRKsMSqRsHCeiEILBMJInaOFDRFyRQ4WmLC8Lv1y34ibvI2Z8vomg8FW6Bb61RFy25REM8Q5dFDUHqEnoiKl1EPjLoDOy74rJQmpp2qqC1esjbm6Zaw+p9j6dNkgnLFDcd1eIthj6KeSs5ZcLkiHoGMglwmBu7k326BkLbszOeu8UoAt3V+AzdHfpgWN3YikJ+WVdvjKZ6qYNIq+f0NL2Qhv4/e1kgxqG+3GCXszvTXRZ9+9a13gZ/q/r1Xsr5CDj6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 09:50:16 +0000
Received: from CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd]) by CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd%3]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 09:50:16 +0000
Message-ID: <ec3a32e5-f866-4cb8-bbef-1bce699c461b@nvidia.com>
Date: Thu, 12 Mar 2026 11:50:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/5] net/mlx5e: Report TX csum netdev stats
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
 <20260309095519.1854805-4-tariqt@nvidia.com>
 <20260310201852.0d5d1712@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260310201852.0d5d1712@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To CH0PR12MB5236.namprd12.prod.outlook.com
 (2603:10b6:610:d3::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: d9db05f7-82c1-4718-025c-08de801cc3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AVtpdsLjcl1NZN7HypxIbaTKCYfUT5Tc+OumYBJBnDQXMQaPbyrd1H9WCqAhbEYZ3Jdx/FrNH4bw2ej5PMzwoDFw7dCrdqWAIdU1nXlEtpYrcsIFd9HSDM8GN8PGcPae9NUPGeTm8+WTdhU23bv9MKFN7T67zPremzFoedayqNzjevO7jC4ssq3BxGeJpaUrAMZpyh1VYMEzsMBY0UoO71XkTLfOBdZ9txnpBfAxWuSBsyK98DFooqoq86YdxAFBRq9kLEPAOs61PRjymahyLsnZp5pWSy5q5DvoTwV9t7u8iFGvZ+e8qsWTAiRMADXLXfmy2Bfvm4XxRAG3uhMjdeWYHhUEsiMxR5yoy6dQyVyzWsiTGNmn21NeQFDyPlMT5sTosg4EH0zW8X9lxUNp1GmpZm8X1Wv1Oy6jH91Zuv59M0Vi8z5so/O7GNjeHmLWC0l0AbxZ6UwKCqtESAoiXHX8ayqEGDbR7ftr9x5NYsdTDESJE4eXHLX3eoVHdpi4eqNccKQJUhx5EU90A7aKHwYcNS+x2Y6A3P6ssBI7irTlQWUROjqYBH6AWjqKKLOKwSgGnyJt831iomOQEBC2KcJq8ivBkUat3roU1PckYlGCgd3SGbluttnLP8xxS6WS2IrGHOAtBRXyPY4MZp9MvEN6CUoUexCKNsUwxtlSYQ71dJopazO4UvIDZuHjMj+hUS5VudLE3cY97LZZ6RrInvWtW1nGA6aF201yJEZJnGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dJZnFpTTdSQmdzalJ1M2c1M3A2OGo0RUkxbi9QSi9VK3VsYklOZ240N2JL?=
 =?utf-8?B?UXFNaFdnTXpqTHVrd0wydmZZaFZOdFFaSjl5RytDZU90Z0NxSmlEWkxnNHA2?=
 =?utf-8?B?Z0ZxbjU0TzNscWMxb3hhSjhHcFF4WG1nVlJ3SXVTUm5XZkRHZGpiZWppUTdz?=
 =?utf-8?B?c1p6MGtoamNmbXh1aDJ1Q040WUFrRUtDWXg3S0wvWmdDQTNRU2JFamFUMXhm?=
 =?utf-8?B?Z2ZYYjVYbkJGQ0JpMmE1WWJpbk02YzV4OTFXS002SWc4OGZTaWwrYlNvZnp6?=
 =?utf-8?B?ekJWQjYvMmpWTUlxaFdOS0oyN3E2Vmw2SkpSVHFCZkd6ZGl6cWFtZFFQK0Za?=
 =?utf-8?B?NlhFOEt3bjBoQk9RRDZxZU1PQmhBd0k2TmI0Z21keTZBK0ovYWNONlhxaEZV?=
 =?utf-8?B?Uk83dE1sQUVNdHlyYTZ6bFhyek5OOTBvOWJUb2lVNHdNbXRnLys4NmYrd1BG?=
 =?utf-8?B?UTU3bGxzK2E3dHlVeVJ2aXpZRE9XVVcrSmdtQTgrR1lydmJHRkl3dlNxUy80?=
 =?utf-8?B?OXpleWhPcWU0YlI1eHlwZjJBaGZWSHpxUkkyODJSVzVEMDVjeVlsWktwaTEx?=
 =?utf-8?B?NlA5OVpTTk9waGFVdU1jMFhHUWo4SW9qbFhaempkcE9JdzI2VjNDUlZhVldP?=
 =?utf-8?B?eWtrdlJpb095cE56WW44NDdGNlFaem9RaFZuZ2xKemZSVXV6SGxSVm9xcWtJ?=
 =?utf-8?B?d1VvUUpkZ2doQ1kzYWwzbU05elF5MUNlR0dzNXVyS2VsSi9EektlOWhIaVk5?=
 =?utf-8?B?dis0UDBwOFgzT2tXdnJ3dlpXWi9VUU5pdXE3SGZXTVF4dS9HQXZ1aG1zaFVQ?=
 =?utf-8?B?RmUzREI0aWc5L1pPbFY5QzY1YVRZdXE5OUkwRVJiUGx3Q3hocmJORWFXVTVY?=
 =?utf-8?B?M3pBZ0JUTWV3YkxNNzRYSk8rL2xOR0VtelhSMWU2TWJtUTArT3owT3ROUW9w?=
 =?utf-8?B?NExpS1QxZTJqUXQ1UVFaZG03Y201RHFNdTVCZ0p1Vy8rUzVHVGFkSDhyUXBL?=
 =?utf-8?B?citGSGxzeG1wbmV5TEs0Y2h0SlpuWU1BUG43cTBiYjFIWm10VytTR1paZEpK?=
 =?utf-8?B?b2RISFFLOVRxRkZyYVhvdy9kRHNSeHRRVmJ6bUttSGpLRWlEMlUwdng3eVA4?=
 =?utf-8?B?TVdtNUJRN0REN01KTHorUzMwdS9NdWF4V24rTU9lcndXQ3VKY0Y2QUpmRDhJ?=
 =?utf-8?B?S2xMRG8rSDJCOVdsNFVSaXZtVVVxYmIwSHplRHZxdjMrK2h4YTAxYU9jdUdu?=
 =?utf-8?B?bWRYdlFRUEZhcUZCdStXVnJwckdoWUV4UkxYcTlheFFybU5QRmN3OG9FcVRo?=
 =?utf-8?B?NUVRZVcrb2QyYWUxUTYyQ2xyUnExRWV0SHFaS0poc0UwWkxhK0h2MkZuT254?=
 =?utf-8?B?anYvd1d2Vkt5ek02OUZLV01jZTZQbWlKRzcyNjdBT25QQnNRUUljTHR1Qkl3?=
 =?utf-8?B?enExdFpJQkhBdlZTT2RBNFNHSkFtZFhsdytuS3ZXNTZrSUErM0tlaEhVckE5?=
 =?utf-8?B?MEV3em92b1hPOFNDV2wyRHNjczlQbHBiY1NjcnBLRjNzWW9oT3VNNzF0Tldz?=
 =?utf-8?B?NlRZcmJSZDNGTUg4VGZHZVladjlmbmJBV0RLSmVtQThHLzFRZ3QrWUZXK3p0?=
 =?utf-8?B?MXNmSVRpcmpXM3NiRDgrMFZwS0JaYllRajNnQ20wbHBLSlRnclo2WnpKK3VK?=
 =?utf-8?B?azZFVm1nbUxYKzI4amFnclRWUldTN2ZaTTJDekJyV2UyZnhkbFlWTTZRY3Qy?=
 =?utf-8?B?TG10V3Ztc05qTW5Kb2lmdEZLbGtUekFoT3Q1T1dGbzhXQ2E2am5lZlBLWktp?=
 =?utf-8?B?dmhJK1JIZGltejdtRWR3anUrN0dvMmZhZVVqQWMvUFNsbFU3bWNLVVNTQW5Y?=
 =?utf-8?B?MkE1bUNzMG1xeTVydDRTZnh6am90ZktLZnVWdms1SmtBcVFrbmJLNzNvVzZF?=
 =?utf-8?B?SlNYMFBrRTZTSG4zZlVxdTlhWTNUdytsVW13cUJoYmhnaTlHMjMvckhKNXhM?=
 =?utf-8?B?RVZnZVpmR2xSWmZ2bUE1UTJWd1BzTXZwYVFPQU9TeXBBYVdnNUlZZzZzVmI4?=
 =?utf-8?B?dU5GVGg1WDl2MHNUUTFEUlFmeCtUSFptb2FiQWI3MFJ3dktpTzJFenZQSUN2?=
 =?utf-8?B?b1pDa2U4M0ZncE96cmtTbGptQm15cmxwa2xqeHlIbnVZZzZLZmtYWHloVkJr?=
 =?utf-8?B?SnVzRis0NEZEMEI1cUd3VHhEaWowUU9mQWxXbG1jVGlJMlBib0I3M21lYmVa?=
 =?utf-8?B?cWN3VEowN2p4MEVNbnU1cFl6ckdzWXZOblhOcGhHZ2VtSnlEUlM3R24vWUlO?=
 =?utf-8?Q?oii16ZwoQsVALU1PCN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9db05f7-82c1-4718-025c-08de801cc3a6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:50:16.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adOP3ug0DLX+KTzAuFOA31S2dpfrFo438hKdfmkb/tIEjr/Lt6YiLIMSKTugW+B7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-18080-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2301326FE34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11/03/2026 5:18, Jakub Kicinski wrote:
> On Mon, 9 Mar 2026 11:55:17 +0200 Tariq Toukan wrote:
>> Report TX checksum statistics via the netdev queue stats API by mapping
>> the existing csum_none and csum_partial counters to the csum_none and
>> needs_csum fields.
> 
>       -
>         name: tx-needs-csum
>         doc: |
>           Number of packets that required the device to calculate the checksum.
>           This counter includes the number of GSO wire packets for which device
>           calculated the L4 checksum.
>         type: uint

Yea, we count GSO packets as one, so not a direct fit.

> 
> Looking at drivers currently implementing this it seems like the idea
> was to avoid having to increment two counters in the drivers, given
> that TSO always implies csum offload

I don't think I understand what you're trying to say here.

