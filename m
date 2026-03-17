Return-Path: <linux-rdma+bounces-18247-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGfvJ/o2uWnVvQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18247-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:11:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D02A8883
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E65131130D4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E43A7F4E;
	Tue, 17 Mar 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FaQBo1Bi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D134DCD1;
	Tue, 17 Mar 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745629; cv=fail; b=MXaEe4w6lfx4QyUQxdmVfisf0PHVD+QSP7Q6BmUkVXaxRfz/2MZVQnjNNvtNbckZhSisseOTNi/ehJ9ylXZJwXke2AQSOJYUHHu8at9Qj8BZu08G21sOSrTXAenXj6h8qHKhx+PuUwxNLFRJNMwOrlOQUDVZS+b7i7jCZXro9AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745629; c=relaxed/simple;
	bh=QZ4gEzCp87UwWQ74jTw5cjaY799ntH6gGfPT6EZMTok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1ctZQlHRQ4NtzIOxqfSslUzr83ChOemxey59/DLsWAYQU50xseQkv0+I888snuP5RUmrd/zbEfxk4dnZFxt8JcecrqbXFA6E0eI0CHnMQg0/wS7Qd8ewRsykkMO0EKR/N/GXyFKgz4CULA+U3k+FhPzb3rPTS3mKVPXmGIpi30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FaQBo1Bi; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBe0/ZSTm+ic6T6n+YwgXrtaVECbtVJn4e/lYsucGsc7icCgMhjZojKNePD8QCfVjClE4PViXddrWrkp7v53+NYCEgnEUGxg+13HOgkh6uVBRNjgjZXJuH7fYHrrLubwOJ+MIgA8uku0Cc/yJ55MqVwjjYA4Dp730GWdQkzXrqbnFvfa+si3TQCk5prLHQfwNJs5D9EfsPKTvYEVQfEPskMXA6/r+z7udS421PX74bO8YepuPrH98HG7081hq1LpHWiaQVKZqyX2nvwcKphgpUgW1BddykoPtlbl3xpmj0lSKRS3GSmVnTz89XMjY+iM0u1z3fg07RaaHgAA4b9nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJlS+z/oy5pPxJLyMXp1QH22d8twnoSTGHxxZdVALhQ=;
 b=TY2nRLDWwl81eUTpJRSri5666orSWuKFj7V41w/IxDo8CRn0MloF4WcPCsMrTelBismm0us5dzulNM2fS7G4kv0SqUhIfLffd7drdZOUJ7w0seH38JspNmpk8BkdZTfKIDann2go15A3F/GWGySgQ0nUkcM4Ctao6A8jC8F6hZkStW5Ov33DRjmNyJyWwZkaV1W4br6cu9mz00bFrov2r9H76ia/T70RS46qjspa6XcQ8C+T3xbThNEX3SCnspKIDuXECqS9ww4BAcce7VNjZecrgbu82fPxvCBz0sxuUrzkUve7aEjOxLlSa9yOeoZ8KLQJZJxM0pQ+aDQ6Xflnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJlS+z/oy5pPxJLyMXp1QH22d8twnoSTGHxxZdVALhQ=;
 b=FaQBo1BiV5I1s9kLQ7UAd+NNlJEbDKwLylCDMtGXUkW/yq4KBRA97BAcuj1BaE6Atvpl3Xr1GXmXM4H1N+PlSM1nPYskGFK6c2fTXyxbYX0ygCcc6VCOUwnksEycVzVXYnTU1fElLVG98oCpVNufm0jZ7eqiwnEOAYdRSWwULbsRtDdvACVF/G+wMWNdaJaB77ZahqAzbY0RRfKpSf2Jey8ZvL09Z2+iOUi4pRWPYs9OCVz/QB++O8Gg8o/2D4r8n3Daa9VahmwR39Y1Q80muy5KxyWED1iXaJCPf0ayftGwXHY9V9RP3hCtFPl9bWECuBM32l7P/zTForxYr4zZDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 11:07:02 +0000
Received: from IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da]) by IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da%3]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 11:07:01 +0000
Message-ID: <05c0db9b-c92f-4758-a356-e035a174b5dd@nvidia.com>
Date: Tue, 17 Mar 2026 12:06:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page
 type
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Toke Hoiland Jorgensen <toke@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com
References: <20260316222901.GA59948@system.software.com>
 <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8716:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: b506fb3e-c508-4cfd-3f2f-08de8415502e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UQJeP8hPUrCrSMAfIc+2CaNS6GMMDStaHmlyOqY1hozRsAT+Zz0SpERi0KAvhrQfqpcPxc4nGyT2JQ9iyh2kj82lrSt9w0x0FxSz1+UEMYDynPmZylEoek+GK/OFNbzOpIoIyxEey60OqsxsPeEQRUgzWe49kST86P8LDqz6mRl+5d+5kJU7mXH8X6bpAmP307rAet+2QrUQsPTcAjG8SzwCXRf9Y0RHA3EOSl+lTwj6x+UU39IS6cqM+eJaUNjeMK8M/SlKieiJwG8rATVvOpzo0JCUNk/L+4bIy5JiazVIXEyM23giI2pIhExMAV5x3MZFkc1Uc/36OykVZZr7ZW3WaiZ5y5n8qpapWvLV044bboOiX8F57D/esRqXzlte3B++JtgIzVGhPqjQDm0qTEVjPZnlp5egK3yPVzW74siothy5ZSCXXYz9/LWoJcJEbipY4IFTGSPWpcDTOa/80qDfaSknuoRniRxN+NO7ENTHgNWpCfDJwKSegEOictQT3TsnJx2P8/mdrtKB4/rXewiqWeQQ5bb5jlIlXhnkWvmRsfW8WQkK7NUDO+Z5QwANa171m7nUVZMfBlh6TNU2vQj01zajKJ/FZx9M09HVtxzkucjlD1t8qJzLP8tQT/VYQnlqWR0wGcniIMDP/ws/Rz/6uJ5fum0RGfrZ8rPykJKBQpZ9agMg7wPRdRzMoxwxA72j0IPcxoNcx96Kg0/YThtVSuQ4wZDqtQi4gJWun6o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hka2dtcGJKM2FzNStucllCVyt2K3ZvS09iK2MyS0V1Z2VMYy9jcjRGbXBV?=
 =?utf-8?B?NXY5dC9NMCtHWnR5UW5KeGQ1Rk8zYldWWGNKYzZxN1cwY211Mm1WTW5UaTJ1?=
 =?utf-8?B?ZnZZR0RVeThvdVB2UWpha2E2ZEpzZVgwYjMyYlBlZTdWQmJ1TERFVkZjd3JB?=
 =?utf-8?B?NVhJdTBWRjV2MmprVE5pdnFXb01uc0U2eXNPU3lrTGdJODh2c3c2R2pNN1hK?=
 =?utf-8?B?Vi9VeldrU2xKMkhrWVNnVnE3K3kyS0N5bUJyNmJFOEVFcHpPZzNEb3FYQ3JJ?=
 =?utf-8?B?RCtIY0R2RXdFeUVWZXpCSEQ5VXlrL2c2Z3NBVTR5RmNXcU5GVFU1RUJrUC9L?=
 =?utf-8?B?ZHRPaGJ2VG5oeWhHa3h0d1dTSVRNYTJOZlRyTkc0bmI0MW9lNnVyc0JuZDNy?=
 =?utf-8?B?MXZNaTVydUlUUkVaVVc4ajJUT3NjTitVcjBrc29HRTVTMXhIbUNMWWFKb3Qz?=
 =?utf-8?B?d0xhVlpKY01kcUFCQmkxSFhEaVVycjVPS0tkaU9POCsrRlg1KzN1bHljYWNI?=
 =?utf-8?B?dWZCWFNBUDloQS9NZm05WERjOUZrSFhtSXMxN0lqdldmLy9mTGhVYWN0M0tl?=
 =?utf-8?B?M01tb0Z5eUhjMjRyTnZNYWVKdWVqbU5leHVYMjU2MFZyNjdDbnh3ekZNc1pz?=
 =?utf-8?B?QnVQaHI5T1c4eWMwR3gwNmNLL1pOVGd3OTc5eUZ0RWpqdzB6empLNHpFcE5C?=
 =?utf-8?B?dnRHODQ4NWk1OVdKKytZaTNYVERDcFdOUDFSK1Jvbm95aWpRRTk1amZzNEhx?=
 =?utf-8?B?UFpjWkJTWko2UUNOU1N3ZlFYWG00cTNuRXlhbjV5dHBqUnpGVWhPOVB3U2lU?=
 =?utf-8?B?S1NHTWpRN1QvY2lSaExXanpzbFU2aWJkOWxrVTJPczNTdXZRbm1xWWQvdUFQ?=
 =?utf-8?B?OGhQK1Q4dWFScHdMMGJkMHI1U0VBeUZoOVJCanVMaUhvek0yeEg5b0RwdHF3?=
 =?utf-8?B?OTkwQ3FFcGxFVG43cnJGdW1sZE0rU0JVTXkxQUx5MUljUFhCNEs0cHFEUEIr?=
 =?utf-8?B?UVBiMkFzRWxvc1E5aHYwaWdPa0dhU3RRYTZmWVV0RklLcEdtcGJ4Q29SVU5G?=
 =?utf-8?B?ZVJQOUxmTVpFcjQySjliSFRuNThabXlXMmttbEIxWlZMVWY4a0hGSFdxZXNq?=
 =?utf-8?B?d3NwSW1lMnBxWXFHTVorc0hxTU1qSWowOFBSSTYxMTQvcFNNRFdYNWxlMnk5?=
 =?utf-8?B?dStxcHBydW15UHhVaG1wTWc0Q2ZlN1VpRWZjS1orNVBBYWhUQlAzWDQvK1ZO?=
 =?utf-8?B?Ri82QXpmdXlSM2NkeGxTMVdJTEVhaG5QOVN2Nng0UW5zSWR5R05DTmxJcHB1?=
 =?utf-8?B?cEt5QnV6OThCRmhQZFo4TnpmM045a001ZFVxejc0d1orSkxWZkdkalVUYjBy?=
 =?utf-8?B?YmZHbFdNRC9HN3RLR0Q5cytrZ2daalZiN1pkTzVpRjYxd2VQb1Zpak1qWUFn?=
 =?utf-8?B?cHpvbHQzRmNZQlprTHowTW1weEliVTR4QXNWRG5vTWY2YWlnV29VNENUbFhV?=
 =?utf-8?B?eUlpc2t0cU1GVzlwZ0VwRnpHLzZxVHJlc1hXVjVPbkVRU0N2ZkVVTVozWWlC?=
 =?utf-8?B?UkpkNkExRlpBR2VnWGwyOFRhbmdYbjdFQzZ1RGN2RmdkVkc1K2F5VnhJdkxa?=
 =?utf-8?B?N0JXTXVjbTg4Z3Avekw4SlRMOTIybVpDSWRYVG1YaWEzaFdkeHkvTUFpK1Fw?=
 =?utf-8?B?WlNVWFNESjFPTHdBYkRpaGxCcFM3aUcxdUg2b21xbGkxamJmVVRsWFY4MlVC?=
 =?utf-8?B?RVQ5UWlmVU1nbHlQQk9PVmJVQ3hxN2dnZk1zbTRHRWt5cXVENDkvUnZoaGNo?=
 =?utf-8?B?MVVyRm10TUJzNENiN2Y1OWorU0s2YmJsRGZUM3podUR5T3o5bDRXTEpRZFhn?=
 =?utf-8?B?VmJuRjRLU05TdGN3amFmYUlOaEdMdU0rRnpSTnQxZHdscExtbklSM0ZsVjcx?=
 =?utf-8?B?N01pQWFGSVQzdmZCbXYrdkdmeXU5MXRtcmFTKzhZa0lLVzZRS2VFaXVWRXpn?=
 =?utf-8?B?RXUwaVJtVkxpWEZFOExWQzE3czBJcXlGMGZzZGNidE10Y3JSanl5ejRocXZz?=
 =?utf-8?B?WTNQQzcvNWR6MVFHbWx3dmNjOHk1UG5qVEJqbUMyS3hWd3VaWldVbE9rMmJI?=
 =?utf-8?B?RlFMdEQ0cmhyaFJWQkxOQ1NmVkxneEZDRG5PcGMwSjN2Mm5Ta2xlZUdQNUpS?=
 =?utf-8?B?dVNmM0szZ0ZqekhDUTJaWDYvd3lKTWorbktWT2VTRTMxZHFVZldWc214U2Fi?=
 =?utf-8?B?VkRuWHNIbTRkcHdoamNDc094Ym93RWI2Z3FVWmwvbmppaTZhZGZjeWZObWpM?=
 =?utf-8?B?bngyRXpDZkpheFpTY0Y1eTRnQzV6TkRsb3lEV2dycmVBSW1KNkRlZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b506fb3e-c508-4cfd-3f2f-08de8415502e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:07:01.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6v+3fczj7LZIGfo6SODTFueix45pQK13LydVG7c2+81stZOS5NpQdGk8wFN/h3lWHB3dmhHXbR60MzAuaRJpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18247-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 113D02A8883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17.03.26 10:20, Jesper Dangaard Brouer wrote:
> 
> 
> 
> On 16/03/2026 23.31, Byungchul Park wrote:
>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
>> determine if a page belongs to a page pool.  However, with the planned
>> removal of @pp_magic, we should instead leverage the page_type in struct
>> page, such as PGTY_netpp, for this purpose.
>>
>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>> netmem_clear_pp_magic().
>>
>> Plus, add @page_type to struct net_iov at the same offset as struct page
>> so as to use the page_type APIs for struct net_iov as well.  While at it,
>> reorder @type and @owner in struct net_iov to avoid a hole and
>> increasing the struct size.
>>
>> This work was inspired by the following link:
>>
>>    https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>>
>> While at it, move the sanity check for page pool to on the free path.
>>
> [...]
> see below
> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9f2fe46ff69a1..ee81f5c67c18f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
>>   #ifdef CONFIG_MEMCG
>>               page->memcg_data |
>>   #endif
>> -            page_pool_page_is_pp(page) |
>>               (page->flags.f & check_flags)))
>>           return false;
>>   @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>       if (unlikely(page->memcg_data))
>>           bad_reason = "page still charged to cgroup";
>>   #endif
>> -    if (unlikely(page_pool_page_is_pp(page)))
>> -        bad_reason = "page_pool leak";
>>       return bad_reason;
>>   }
>>   @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
>>           mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>           folio->mapping = NULL;
>>       }
>> -    if (unlikely(page_has_type(page)))
>> +    if (unlikely(page_has_type(page))) {
>> +        /* networking expects to clear its page type before releasing */
>> +        if (is_check_pages_enabled()) {
>> +            if (unlikely(PageNetpp(page))) {
>> +                bad_page(page, "page_pool leak");
>> +                return false;
>> +            }
>> +        }
>>           /* Reset the page_type (which overlays _mapcount) */
>>           page->page_type = UINT_MAX;
>> +    }
> 
> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> finding (hard to find) page_pool leaks and mark the page as bad.
> 
> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
Some leaks could still be caught at the page_pool level through
the YNL api of disconnected page_pools. Not the nasty/interesting
ones though...

> Should we handle this more gracefully here? (release pp resources)
> 
Releasing of a leaked page_pool page could lead to many harder to track
side-effects further down the line. Isn't it better to simply let the
page in a leaked state?

Having a way to track this leaked state though would certainly be
useful though.

Thanks,
Dragos

