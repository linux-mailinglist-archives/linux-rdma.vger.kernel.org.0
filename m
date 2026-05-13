Return-Path: <linux-rdma+bounces-20569-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAO2HppqBGprIQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20569-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:12:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2201532D71
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D005314CA7E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B65401A13;
	Wed, 13 May 2026 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/HsxqJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B23FD128;
	Wed, 13 May 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673993; cv=fail; b=jF3V6I7nu40Wz6TZesq4qUs1sgNBbrjdJEwrPEXy1mqaV81DIB4zqECcWAyUoLDDNvflbTfHg4XRVsUpMEz1Zq/j9kGsZo/WrrDOn8OLYKmHjJtaRqFgEZ2reesjIMwsAbtfyGpeAFfUxisqxLX6qUTsIM8GZ5n0LgOESPWvcRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673993; c=relaxed/simple;
	bh=aZwW7ae5qdlVXLy+HqvdpEMiXPZYKiw0QT7p8yE9vvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqLxr6Rs4gfZJvAo870p92TgvPS3v9eifSuGfguEU6ZWrL2czeieQhrijyA/VxgnYGCkuOhUlZF4olyPyqAozuMwpYKiD/vgxqXlfHFuWvR9wv/gzmLCdE9FmDNf52liGATqbVaggPyfvDtivrbhHOhTmj9Z3rcodehWr+ULKyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/HsxqJY; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymjESS/uJse1v7fZGUFF6kWDzTwpR1bP0S74A50IQchsJK6WenrVvs+8S5t4H+UrceWDxCvY6HwQ3ww/yRwpkUUQvKY3R/xwM9AHs60k9c06pXiMukDOimLVvGjwDhKfW7EOrXXwISxDlWTXdeChhuxb+8wOk31T3LSgKsx9nKQ22k603zUmiOfkcEkgg1faB8eYDYdQPDgHHsK6kCTZkzxAumceCTsMaecykJHJW6yzl06agWrmXQ8EryaCxkJ25pLaj2MknNuNpct4us9mihUZVM6GEOJqUWS3ET+F3XPWjNVcHIt78MZfJyDoId6nlihFQMRoRQha+lcNKpV17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o+loa06WTgPZxij1Ofn7VOfJnxWmqooT6LwKwNV+0I=;
 b=sz6tqn1Y9zg9oMhHrnhCULbd1hpHOplA0UEK6mcsuHD2zKavRBewHFILNONKW5f+x21bJcWRufSmHyp8k6G2sVW6Jyh8av/8siOvsoFRiyxtNWr/J7wlkBJWuzl5iPVlAx6MTw/CZNMDbs+pbvJNlOeyj7xFDU0siMkpqDTfGfuUrD4ytbNLQ/4krA5zlJBR+JoNxGDVykK52Uab0TSC4GdCyjDXXH5CjovTVKvoR6AK9JJU/jhZX+IxcmFRRpISyyztzQdfpqxAtw6ZdfEE9pd/VemlbK+mt/LU2XkoibcbDYs4I18D7xlW+k1kJkj0KWBEBIl53tISwTW97+foww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o+loa06WTgPZxij1Ofn7VOfJnxWmqooT6LwKwNV+0I=;
 b=M/HsxqJYepRfqwkkrBrcdhKbFSh6NfVRj1Yi83/PucirDPugQ+/XjtNU9fnNWtEectWQL046V/U7tDa0o4Rg4Jv2XaYU5k2Xq+86wlUlNEQ4/950zSZ1MQEnfqZai3so4v0d5st1/jmltWwyC2JpFxX/VTcU8iH4kVJym3taga65ZNRlOnnJTNbTbYDLP4iyUo6ieFpOJelU16VuzVSj77+BJy5CqLf+XfJGp/yEN2O0LWzdA2Ee4xrTr9B37ZD1Pmt/5NIMRiclQV8caXgiEfRNfBKJzgckRHX0Li2KSct3E9M2f7DOSUUhki5CWCQyfo/Xq++D8+wVYKQ6+CdWIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 12:06:16 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 12:06:16 +0000
Message-ID: <f3e38c07-d410-4c8e-a572-68d52dc55353@nvidia.com>
Date: Wed, 13 May 2026 14:06:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
 <agRB2QTbzceRgpzX@pedro-suse>
 <1817a749-8232-43ab-a0f5-350e5aade235@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <1817a749-8232-43ab-a0f5-350e5aade235@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffb8f3f-13e4-424c-c0b0-08deb0e8089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u57HsXiC4887Xme+5U/YFADjYo134KT3vk9KNYqpk3rbqeo7h6lgMouu8IKNN31NEr5BEULySW/3VWD6qUorBCq6v4b3pXyILqt1eAbCJ7CTfFhvmXivCktH3XKP8U9NfZSjJpOv3uA3bcZ6fFld8aY+CxeSl857KTNmXa6YEleXq7NLuNa87AP86IVZxc4Evaw0iO2hwuA+LXIrzyZ5BEPiml7teijPIQFajYvKMdKyerom9p4yw/iFew7FeqejkqNI7e3yfQDdBA6mU5C6JJ5UEJ+N+ny/K6uANeiC4318F+Okc/ZjvahqAnqWMAwM2FQFLgkDCLOxGbdIN9mXIXga/xNU5zh7ZkCwLyW9PKZ6HL2bF1MMY96BZR5EPvJ/gMc085+HGknpvcZT7IMGW2zMYpqC06+hWXhvLid5ZIUSulstGTYAhSP7VJ+sUGDzQu+e4B+DFK3wn0rqmUokdTNCMQ9L2/eLMYB3GUAbxXkxOBv98RUGyxVBlrbSrSPi78j/oXPw23ugRacq0xocICkoz6GsGckLbEgQSx/PB78BbONZhYd8uo6v5z08kxpW96SqNOHozZIqyXwLYbLC/CUNXFzr8CUk5BIYnjsLSwF77rr5V1FJwGYKpzpfccSfH6tyAFAn5gO/30k8dDummCLIS2dhDF7dqC9qlses6MciARd4X7R/lyLto1Tej9Sr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlTT3kvMXRTMXVWeFhTR214VkkvWkV2b1hhL2ZHWWE5bW50dGJIdzBxaUZ0?=
 =?utf-8?B?WTZRV1dzSUs1cEt3WkEzc2VMdmtBNG16NTcvTWduNzFsSUlvcFBsRjVXYW9j?=
 =?utf-8?B?TS9FaTFJNlJocG1YbTZXSHRzaEFzdjJEbDZYNTV0OGdPWGY5MlhNRUpvdUl3?=
 =?utf-8?B?a0Vwc09xcHU2OE4ya0NWTkliWHpTVkErT20zbVlaeHpQK3hISnNzeHhrMTY3?=
 =?utf-8?B?a3JuTVUyd3JvSEhaVzFJd0lrL2dCd0w3QVdiRDViSldXVVFmZU1qK1hqNUw3?=
 =?utf-8?B?TFQwbGRNV3U1RlFEd0pKUlRDTEpnRW5EeUoycjBzZVVOajFwRVYzL0s4bUtR?=
 =?utf-8?B?bit1T2ZTNmZKU0NQTzBnZlhETVFNa1FCZmpJS1FCMXBHemxYUDcrd01PeUlR?=
 =?utf-8?B?QjZtNzNIRGF1V2hLWGV1aWJqSUVRZFROMERlVHltMjE3K0twSit5Wk4vR25z?=
 =?utf-8?B?WUNKUTFSTEZnckZoVzliZmtES2p1QXA5NTQvRmp1RkFWNEJUdWlVYWp6Ry9W?=
 =?utf-8?B?eHhvUDBiRXBpRHlBMjNCUnJoRHNmYitOdWJJcWFNWXlQVXhiSWppZklRV21m?=
 =?utf-8?B?MHYvc2ZxMWZvWGxVQXRheVk0YkpOYVRIZmtzL1VWMVZ1QTlmVFpFS1dQVDNS?=
 =?utf-8?B?RXNQZklLZWZxVzdvb1BFQitkY0xCbG55cUxudXJ4WWRLVm1PeEh5Nm5yN0hV?=
 =?utf-8?B?a3gyTjgvR09GV3NTT0FUTlFVL21ESGM2NFArSlFpUFpBbTkvYkVHWElSZ3Av?=
 =?utf-8?B?NldwOXpqYWNFYTlueURTNTlFYVMzTllzUVJBcDBnUlRQYi9rRlVWSWtTL3R1?=
 =?utf-8?B?d0tYVGRmV0tqK2tFeWpSdTBlblRCZ3pSaGVOSkN6US83bWl1VU1mQ3pwbFMw?=
 =?utf-8?B?Zy9xWHFSbk4waTlDVFFUVmg4ZUY2TzlJQ2JSVXlhWGVOcWVMSTdXa1R1NlMy?=
 =?utf-8?B?c1lBN0YwT3NCam5QODJPUG5UTHgzUzRKdDJHQk45VDRVMEozbVdaVlJtWlFQ?=
 =?utf-8?B?VDdNZGE5Q2wraC9vVmIxanpkeCtiamRhRGs0OGVoMlgvSGpOdUFiUmVtSWh2?=
 =?utf-8?B?d3Rvc2dFNlhZZStJSUxFMXA2U0xuWkxVazIrUW5UdUlhTzdEc3lUMnNZRE9U?=
 =?utf-8?B?THlhRitpczZJQ1hIc0VMMUhZQzk2eEdDUWVBYjZiZmlkbkZHT2dsQ0FjZk5j?=
 =?utf-8?B?eDAvbzR3dkNrMTdFSC8zcG5qbW9sNU1FYmpielBpRXRzUlhqaUtmeFYzR2I4?=
 =?utf-8?B?NnFmTTM3TjJWN1FOYW5YU2VmZ2pKcWRKZXFHV0FrWXlONkNTM0VXSjRILzZN?=
 =?utf-8?B?dDVzUzdHVmFpZmluaVlyQkNhZ2Q5UmFybVd1ai9BUDFkc1VDM0FncjlYVFBW?=
 =?utf-8?B?aTRwSllwbUJwS2s5VnEzdENEY2FqSU1KYmkraC9kVkFVN1JaVG4xZE1ieUJP?=
 =?utf-8?B?YkJnQ0hLUDhRV1cxak5NQVh0ZE5kQ0ZXT3hCVzdWUWxSMmNsS2taejZHR2or?=
 =?utf-8?B?c0puRnlrb09uaVhDVTl6OGdGOUI4cHk5ZjFsV2pqaDllRWlGZ0o5WS90RStG?=
 =?utf-8?B?VVF3RjRHOHI5aUhoRjFYcVlSc29qT2VtTWpaRFZqK0xaNzlrMG9nU1FYdWsv?=
 =?utf-8?B?YW9CWG9iQTdxa1Aya2paSFFnQ0grejVPYVdCRlRtbjNCK0E3d3lJUU9xd0Er?=
 =?utf-8?B?TVRlNm9HRXhYVzRBMFpqT0FvTFIvdXJaWDlJREh1N2NLdUdQV3k4TXU1VUU2?=
 =?utf-8?B?b3grSXdOV2RtdWNXdExhT3NaMW1yK1R0MjlDYU13RXBBa2FIVUlTbTRLa3FL?=
 =?utf-8?B?WTcyaXp6dHlRckJvRk5kYTNCM2JpVVhoMGpuYTRERzFnRHRibmtMUVNyYStw?=
 =?utf-8?B?WTA0Rkl2YlpPMGVRZndPcVpwZ09ObmExUjN6N2VtOFd3MFJDMm9tbVcwZmhQ?=
 =?utf-8?B?ZnZOajVKSHpHWWNPekQwV29ZTit3MCtTWFo3K3hZTUszRmVXM2pMdFdKTzdN?=
 =?utf-8?B?N3B0NnRJcEZXaDFhNCs1OFFoTVFlUkVybWNvODk5T1MvSUt5aTZxS1I5VkVL?=
 =?utf-8?B?VUNGUzUxYWZCdnJtcmsxcGVqMW9nKzEyMjk0d3hCcDZSaWRNd21HeTRVWmxp?=
 =?utf-8?B?amNjS1E1VjV6c3Q4UC9sYnUxa29TUThqdFF4aEVNOEdBdlNraU95WlFEeGly?=
 =?utf-8?B?QVh0NFFFRDBUOVVXR3o3VERwQ1htYU4xUm1pRDRhSUp1QnZvTHA0eVJNZmcw?=
 =?utf-8?B?Nk5ZZkVzb2swWVJOaUkxZS9zSE43VisrRzBnekZlZ3F2NEYxN3c3S3VteDln?=
 =?utf-8?B?UFdQWm9NeXVTRGNMd2RvQ1FEbEVYMDNMNjUxL24wRWZZTmxiejBIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffb8f3f-13e4-424c-c0b0-08deb0e8089d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:06:16.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HpqWrBp7H5acuLUCJMTZZvfWsRotzxhWlNItFBZgaPzuf6kvWzyagWlxSvwxYjgK60WOX1AndayWwBttBe9kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
X-Rspamd-Queue-Id: C2201532D71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20569-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[sk.com,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Action: no action



On 13.05.26 11:36, David Hildenbrand (Arm) wrote:
> On 5/13/26 11:26, Pedro Falcato wrote:
>> On Wed, May 13, 2026 at 11:12:43AM +0200, Vlastimil Babka (SUSE) wrote:
>>> On 5/13/26 11:00, Dragos Tatulea wrote:
>>>>
>>>>
>>>>
>>>> Seems like this patch broke tcp_mmap because
>>>> validate_page_before_insert() returns -EINVAL due
>>>> to a page having a type. Here's the full flow:
>>>>
>>>> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
>>>> below flow in the kernel:
>>>>
>>>> tcp_zerocopy_receive()
>>>> -> tcp_zerocopy_vm_insert_batch()
>>>>   -> vm_insert_pages()
>>>>     -> insert_pages()
>>>>       -> insert_page_in_batch_locked()
>>>>         -> validate_page_before_insert() returns -EINVAL
>>>>            because page_has_type(page) is now true.
>>>>
>>>> The patch below fixes the issue. But is this a valid fix?
>>>
>>> Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
>>> mapping typed pages to userspace"
>>>
>>>> Pages which use page_type must never be mapped to userspace as it would
>>>> destroy their page type.  Add an explicit check for this instead of
>>>> assuming that kernel drivers always get this right.
>>>
>>> So uh, this doesn't look good I think.
>>
>> Yep, you fundamentally can't map a page with a type as page type aliases with
>> mapcount. Even with the given diff, just mapping it will increment the mapcount
>> and wreak havoc. I think we need to revert this patch for now.
>>
>> I'm not sure what the long term plan for this would be. If page types are moved
>> to memdesc types, then the two stop colliding and that could work. I don't know
>> if that's Willy's plan, however.
>>
>> (then there's the other question: are page pool pages really folios? not really.
>> they are mappable, but they aren't part of the page cache, or anon, nor are
>> they in the LRU or have rmap capabilities. perhaps we need a different memdesc
>> for those. we're one step away from reinventing class polymorphism from first
>> principles ;)
> 
> Zi Yan is working on this: non-folio pages would no longer mess with
> rmap/mapcounts, and page table walking code will identify them to be non-folio
> things to skip them.
> 
> It will take a while, though ...
> 
So do I get it right that the path forward here is to revert this commit [1]
and wait until the work from Zi Yan is ready?

[1] db359fccf212 ("mm: introduce a new page type for page pool in page type")

Thanks,
Dragos

