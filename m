Return-Path: <linux-rdma+bounces-20182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHFoOfjh/Gk2VAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 21:03:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0814EDB60
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 21:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB5A3034648
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F243D51E;
	Thu,  7 May 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLc5SA7Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64D1A316E;
	Thu,  7 May 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180596; cv=fail; b=ficQg8VRCeHyJHI5rEkbf8MHMx7M5jLW0hohY7wRMfQ8BPqc7scEA5zbCNwOIyTDF+GElE7vXCJoSYyWKReL1yi4QVT66Bj2Fn4qxHRlJtemDQhLnFkWhTPN2EmWZHSSNlaHTkFzSztjlU+wmJ4pGDPSdsYEPT6w7s09cu/GSqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180596; c=relaxed/simple;
	bh=wR2ek/BAPz2jl9tyJXfpbvIcWLQBo8V1wdvcq8aK2y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VP3k0dm3ZJCnNNh5zPnnl5BtuCJlVwOUv7LLvNd9NHqrDvpfm/e77KuHJL5NUElH+Hj88Bzrh8Q0Vv7aMLV/dozdcZ7YHOgiXYpVfB9RCd28bpApEmlrWVhN24sWwQ1EJfpPS2QcKHDS9DLY8eKBwTH7WfOWj9zKqPzFLSQycss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLc5SA7Q; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqWp9CV2kKc1zQ53RhM1XblFXn07Zx4n0r7/DMbsiVyb6xoozqOET3rcje6x05oE/JOPkCImHGbNj8kiBzC935Kfzl/ZNXY8JtFSZxxcF/akSYVfW/EfQeLYWizCCSwZRCZ6R0KdEMO3dkvh1VN1iiAjeQwywKjkpQvcwI+s2a5sA5k6Npwj+9FJvjqsw1Wby8fIv/tcY3RVsiHWVCOurSI42GNqlKVcd0ZKV2JHBw/2/fqmr69jYL812DF4LZnfAUfj55HhsmHqHnnNbUmnnL2oBhh5W9P10g8ITBuQGBdjUPTSAHIXCEow8LKoeSkvnPfe7WWLngmjfrcnBIVhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR2ek/BAPz2jl9tyJXfpbvIcWLQBo8V1wdvcq8aK2y0=;
 b=qCRNwg762TokVmbP5l+gvR28JTnAUIfMs429VfcyHvUq+1bSiCzRkwh6XyYFPnCPbG5V0c9fA7oGXiZMLmMq6NJq89dQ7eDzt26W3cx0MSkhqX2qE2JSidspr2y46ms5ppEAW+P5XkKksjSldpsNZkyTnK6oCubipAXdLw/uXM8GvM60lRA4rL4RNar8SrhnQVLGpGTQzfVYaKXvVmM029fD8w/MMiZxMGdjz27ju9gG08Dm52dKLoNK11pn9AQ3STMfjxLJKU49cTN9dEaBalWYNDG7u27151UZIxEMTXceACsk3w9jf7dCMYoHx3QSxhCXXRgsZajL3tXaRYOvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR2ek/BAPz2jl9tyJXfpbvIcWLQBo8V1wdvcq8aK2y0=;
 b=fLc5SA7QsIp66fIEmQXL/xEZJ524K7xDX308YA4KNkz2zY32XwgCnd5mvIAWT++ZJ5z6ZaPcAglZvQTU5I7APZEzFA381apMMWZ45paChdkXp8oYoEX8x/jEruWCeyfEQ2aehWdMpKlvXbDtonnTPNTLSWNPk+bOwaMyMfBd+RVInHuTW8GMYs17EcM4gJUn05ZeTHqezcmxRPxnQmWAbqb51kDyzYzipkF3GxudKQFGiU2Vifvn3ytBGbtk0NzFp7kilvm52M2GNtNeuI/aVdHW5NG0LNhCkHAI3W5eS6OV+kvcBkSXcvRprdmYfgyzzU/nabcMm5lG4ggsLNp9IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 19:03:10 +0000
Received: from DS4PR12MB9682.namprd12.prod.outlook.com
 ([fe80::e675:bfd7:21a9:f330]) by DS4PR12MB9682.namprd12.prod.outlook.com
 ([fe80::e675:bfd7:21a9:f330%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:03:10 +0000
Message-ID: <7f4f54c0-a71f-4664-b934-9ae71e8c5056@nvidia.com>
Date: Thu, 7 May 2026 22:03:04 +0300
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
 <98c17c60-6747-4c2b-bfe4-ce9bbe560f6d@nvidia.com>
 <3cf0dcca-9a3f-4cee-83d7-f058f33bcc04@gmail.com>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <3cf0dcca-9a3f-4cee-83d7-f058f33bcc04@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To DS4PR12MB9682.namprd12.prod.outlook.com
 (2603:10b6:8:27f::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9682:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: e268311b-2dca-46f5-9d8f-08deac6b480e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kO/naCzPHQvX6jz5g927BxQXWNQ6xEdxBcziIsepUmG0T390+pdZBSDbLQFoyqd0GMUnoKnOXTlQayTGaqtSs7cTHzLUwo+T7wjssL9KeN2oELFciAHAtua9iEhrrxzFSSV/kT4nKTY8ycqhI9MSeZORSjZKViL44YIL47ZiPW95hljOkBKNvSHYIE0UTT5jwt5o7dcivywoGr374cy611i9aR+2glZuNGbWeEPu0Hf0CEXKrCnSQi1ccn9qctIrZfCzQI7HZYes6SQmJ176UbNHJ4CkFKSYxij7UXsrJB46lSYQojdt8hqxg178Zx+fwBrYZKzNP7G0QMDachaCr+xJhp31B5t23Zw1P1R6xW20tZ3g4ZNmFKUmogec0qK2xvoka+MWjSDkC7MB3wzEhRKIqlJZGvgivb1Ihm3S94JimIfXJdMX83SnFROACbW3QGXUtMUYbzSSHZNtrhCUlWLpYpbwbClLODqLMAIpW+bGfIzCKZaXy+YQ2sdnson0+cAW+gNq2GGnsW7oaOy52kXE60pxprg2bD3oCv+mMQfPSjHQfPqKFZ7CmBYfPYlTHk72/ANXxOiI1q4IllMMcodCUzNCfu+OR2E4Qmgu/yDF324+Zd+mbNzU0DXvDqEBXX73LsGZ8Lh+MVG6QutV8szfp8hf4eoSBxJ1AUok7ewqk5BSWtO7G+ZD3C0aC8NPjDPC6Rv3c+xo3qoZZpvv0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9682.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkJubkhuQ2hJaUJMUW9sbGtMa3phckdiY0ltM0pEQWw3VjhXbHVBenRUbWZl?=
 =?utf-8?B?MDFmLzhkRnBlekVHY0N6S2l3T2dOWnQ3WmJtS2F2UEZEcllxRzFtSDR2N29W?=
 =?utf-8?B?c2t2MkoraHhIb09id0pTZ0x3TFJWSU1TZllUY1pqOHdBZzEwQ3FIbVpPQ3ZZ?=
 =?utf-8?B?aENKT2RKOGRJRjVtUHVjVEtSLzdmQUFKYnRYZ2lla0psWkUzNXJTQTNKWFVw?=
 =?utf-8?B?WVIvUjBpaEF3V2dXRXdoZVZaeWpUdXVnUTlQYzM0TVZtbGZuMFhkYnRNNVht?=
 =?utf-8?B?Mmc3Wi8vTDFRYklOMXRVNk0xRSt3bDdId0JibUVxQ3BVWkViZTJEMkFMRkhE?=
 =?utf-8?B?QlVIUFZTaWg1bktDMm5POS93T1ZvOURCQVpuRGtpU3d0eHlveWI1dlAvb0Rx?=
 =?utf-8?B?QUJQUXZGc1VEdXRmeWhpMzN3WnQ1a0dTcWQ3cVM0RldjZUdiSjIwV2VVa3VI?=
 =?utf-8?B?UERweXJnajUyZnV1U1NWSzFnVGh6bkxmM1JLKzdxditwY3JWS1BhMXdzR3JN?=
 =?utf-8?B?d291Q3cveXJXcTIwY1JJN0YxOUorcjJidEQyZXZMYXZGOGJLU2hOSU1jK1FQ?=
 =?utf-8?B?NlJteWFIQkNRcVZDcCtkcU1aWVRWT2JFeWVqa3ByRytKZWZOTVVTZG03ZVVp?=
 =?utf-8?B?VDBJMlg2N2RlbU55cTRsNlo5cC9yL0IwUzJjWUVZOHd1UExFMGlaZVVYbVNw?=
 =?utf-8?B?QnUxWVpzZ21OckdJRHY4VVpidEd2VFhUb3FCV1NIendLdzJjTHhPZmdtUzVW?=
 =?utf-8?B?K1lEOThvL0N6dVFmL3NMMDlFRlcrTXVCUzlWZlFrS3V1ZjNpVThkOGlIc0ZZ?=
 =?utf-8?B?elRRaXJTNzhidHcxQitvMnNsSlhmRnJrU1pGVS9NTm12bDIvUmx4Q2pIdXZp?=
 =?utf-8?B?QU5FNkhKbVJEV0duaDlFdmhiOTBxRWltMEtVWVJBQ0tMbSs1ZEN3eGhrSFAw?=
 =?utf-8?B?bC8wWC8xbEQ3VmxZeDJLWjdraUhrcllNaS9uTUtISG5kS3I5NVBDTzk0QWdI?=
 =?utf-8?B?UHYyMk1PRG0vMFZyZWhSTU0yeTBwZmJ0R1Rtb0hUUGtBTEJrNlRkZHh6Rmox?=
 =?utf-8?B?ZjdNc2R4QlU0SnlKVDlBRER2bUd2c0ZRcGZoVzAzMnhkT0lPWG55SDdxVGVR?=
 =?utf-8?B?ODhsWmxURFhVcDc2T3h4ZVlZTWVBeDZvTFlsUnhSOTNUM213aTE0R3BvTkdM?=
 =?utf-8?B?N0RSMm5zVXVsZlZzSDc5QzdjUkJEYU5DNWczK09jUXRvWnI0WkRINDM4S2RS?=
 =?utf-8?B?dHVLSmpzUC9PVUVIaThNeDNDSGRDTlBMeTlPMncwZEJpTEswcU03MCtkMXhB?=
 =?utf-8?B?NUZZMU5PY0lyRy9ZTmRPVGM1RFBlOTFYbTMvc2tqeng4REFPMVIxVTNsYzBV?=
 =?utf-8?B?V3F6cFFSNVZObnI2eWxvMU56d0l6TGRSVGp3YURBaE1FOTI1Qjc4WFRzY3RO?=
 =?utf-8?B?UVRrOU5GNTdBanNtaC9FZHUrcXd3V3lJRSsrUHlPeUZvUXVGWDFCWlFkenlU?=
 =?utf-8?B?N2VoamJDalIxV1hvNDc2SkxXWngrVkUzdUJ6UE8wN1pQLzRoWDFiV004WXhl?=
 =?utf-8?B?a0lBdlVzZzFVR1RTem96Wk80VjBQY09PUDBxK1ZmS3pnM0RHNEtxTFNBV2F3?=
 =?utf-8?B?dUI4WTRnYkU3bGdaVWxGRkpDSE1jcld3SmY2NGNaTlpySHNwS21LSHpkTnVV?=
 =?utf-8?B?NEk3QmNRdkFVaUttWHNYNm9FZEg0emdzMWZQMjFiK256SEVjOW4xUmpidGM5?=
 =?utf-8?B?K2Z3Yi9aRkViR0o4SnBjdXNLRllBZjJweW9aWFNZcU16akRXODZ2YXRDbHd6?=
 =?utf-8?B?MldxM3ZEZ0JRWUlPUS9kSmN4cUcvcjBjcFVnVGN6b3FoaWpncmxEVW9WM0Uz?=
 =?utf-8?B?N0ltSERwcUxRVXNtQU92SFBodWdCQ2ROV0pwVXQrYmZ2cEhzRXdEMGNZOE41?=
 =?utf-8?B?R2xiL1BHQmFsSExoeG1pYjdvRDFHOS8rMFl6L1JnMkpJL2cxRkx1UjZVcVVX?=
 =?utf-8?B?eTRVYzJjYlR5Z1BsQXhBTkVaSDgrS2tYQW1nN2tzM2E0NG9XUTdkYndZdGZw?=
 =?utf-8?B?SnIvTkhOYSs3R1QvSHUxVmdaWXNva2pac2tHSTNFM3l0ZWRUNTdpYWhXaHUx?=
 =?utf-8?B?aEJlR3hZM2NyaGxBaUlIMTRZbXRGTW50azkxd0hyZFFCaVBzcU1LVDh4ejNW?=
 =?utf-8?B?ckZaQUxMdVhjMzlIaDBPUGMwRlJpMkhjK0tZNVdvRGl6dzZCRHhNQWs0RjVt?=
 =?utf-8?B?bm00V1dWZVpCc1o4WGhRUy9pTWI3SDA0Q1lkTkRyMUJYVllKYXBlcmVNbFZ5?=
 =?utf-8?B?RnhMSmg4RVRVWmZuQ29LSEFGUDU0eDhqU0xYVHUzc2tPa2dtdHp5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e268311b-2dca-46f5-9d8f-08deac6b480e
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9682.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:03:10.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eLkXm4WxD4yYKEsu2k3A057N6mxuYxJKTwQwNfaGJgFPs6e1+BWpCcG1gnNvQX55D3VHv91omWyqj64JN2M0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Rspamd-Queue-Id: 4B0814EDB60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20182-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 07/05/2026 19:20, David Ahern wrote:

> On 4/28/26 4:05 AM, Chiara Meiohas wrote:
>> We will prepare a sync patch to align the names with the kernel and send
>> it shortly.
> what happened to this request? I see that Stephen had to post a patch
> (not yet applied) to address this problem:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20260505181045.748088-1-stephen@networkplumber.org/
>
> We allow rdma to have separate uapi headers for convenience. Responses
> to mistakes need to be timely.

Hi David,

My apologies for the delay; I will make sure these mistakes are handled

more promptly in the future.


I have sent our version to the mailing list, as I was not sure how you

would prefer to proceed given the overlap.

https://lore.kernel.org/linux-rdma/20260507184609.3439875-1-cmeiohas@nvidia.com/

Thanks,

Chiara


