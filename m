Return-Path: <linux-rdma+bounces-22012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yMPiIIrkJ2ra4AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 12:01:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA07865EA9A
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 12:01:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=WVCUS52p;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22012-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22012-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C92730421E4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D73DFC7F;
	Tue,  9 Jun 2026 09:59:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAB17A309
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 09:59:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999173; cv=fail; b=k+lsA26cbR+0T1aaFivhyjEpUDLiPj7pbcKw0vylLDkgf0cCJijgupaEBo5nwzNImCAZMCELEzh/i1BTHJH6G0bdjwAS+G3EpgeHC8emuaOSy1uns87U7d6QnxUK1VST32ObrR0w2Q6HFS04Vz6chxkhxWvgB/iQr/59Ogh70KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999173; c=relaxed/simple;
	bh=jbyXKp3dUirK+gLG/eKy1nFyJq3pwPF3Er0ZQyutFIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBN1Vl+T6VJOVStLeLZMtCSS8lNIQKEeA+aIgP1/A/0vH5D6yyQLs3ANIWTSYptzsWGnzErtxhnAu1hiudXS40zY4d8gAyOHyUP90qzfILNjTTzF0UupDrGIVngSKNTuRk8bQhyBNvXaFnXKyu8rW36q9PE2on1fBUTBKiUwf+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WVCUS52p; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPJSjk4LxqP+R14FLcE6LgLchJLUSEF3pnUwAvT2WVQNx1Idxs41TIPWzY/prFaTCUX7wMSutsVK7cRu1FXVQvdKuYvrm++iTpN1U47WlyfcJOBLK3E+/hL9eDARuipgGCMhk+0Rb9HPs32G//gPomgNHrS5kgvzP/d9uYjlUWLWbJlO1vc7MeeZbe8ofwdip9QH9n6n/Qp6sGZaGd8gO49YVuGxsmJXmj9riaNsogGuvxnN80hj360DvWWe8tMipBbJXYGR3LXi14p33Lno36NzpSbw5TKb0wyr1IMjKKLgCp1NXwG4cKlQHwQbXFlEUkjCPvsxRef7c3EuA5MFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZGUcNRO8Y1Fb+rrdAxX/mG9yG2Okj2IN6piAZ7I/qc=;
 b=T0mHJ8dPJRudnm1+K4CQJW/q4yiGD7bzDFvCQ+S/REgL1QrRJuSgLxRNm6f9OYwHnod6e37aFxr7XlubiwZhrM3OB/jGmlud7dB1/SQ+l5urnMQG2trvpWPK+lhnzan33ZMaUG9XUkpzdQJ2hga4yQCvVgEC5XNzYBi/HCMq+Ns4T1akc5SGyQyKO3Z+jp5Hq51Fzij+oak0jsS21cEEGUcS0sNdsP/rKXdx0iOmT1Nnlt6tNfWWABkjARdeaY0WvJfCzRqDkeBqOyA09i79hhj8PNvpUatDfXZjW/Ei3DgqiMZNpOuC7q3Fma7hq5SlYNtlJfGzGtzdgPqFhQMvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZGUcNRO8Y1Fb+rrdAxX/mG9yG2Okj2IN6piAZ7I/qc=;
 b=WVCUS52pCZG0yMnVHf5+TVh1nW/mqsQnGZ6aT5/LoSE/wZ7odWS6PCyf/6P1u/iO3Llx5INoRlP3ZE0QfhReGN8r/U2XdyZuWWU2znCuGROL/bPED/pDMVmuR4ttbLVJhljR/fELVYU7+YCODywJoBfJwaxbJUkpnn+dlaXA2vzWx1QDgcBGjNItMfl/eUffqOPw5CSkzR2JE1AXus/vJKdgD36lgh8XHUpTH/Lc7nvwfmxQpDX2EDeEQOqIu6U/SI3eNprvyN1p+LwaYORg35PBYrs9k5DCs+cds/WG/i7HNhcBAxdMDBZgk8HA7Vd8KJ9TnYxyR/pf5bXTF+sZQw==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:59:27 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:59:26 +0000
Message-ID: <d57d8c2c-3def-4805-a738-ba8a8bb9c5e2@nvidia.com>
Date: Tue, 9 Jun 2026 12:59:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix NULL pointer dereference on
 INTEGRITY MR dereg retry
To: Tao Cui <cui.tao@linux.dev>, leon@kernel.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
References: <20260608050745.2715590-1-cui.tao@linux.dev>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260608050745.2715590-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cf63c6-ee6c-4bed-4844-08dec60dca74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+s9maR9NbGWwJ4XHMgZuEUWb0m0oD8uANtU40moKPszx+wsbrEY3ILY9XWS+cC8IWdBTyOYKRnThYxsnw0WBYIf7RhbOZcl2Ep61x6S9ae0TfKagCWrpyiigs5jGxXJffrWkt58kx2ibVXZeEl/ne6ks9gUqg4ddTcASJ4ezWyq1qL1iL2meAxNNN0xeLeJ/3qecogdgbek0OGb2SaTCutGzr181yJZcKsDhJ8CcCCSLNE5mDNb8sqsgdf1X5Y37iUCi7zxlrZcnUWicmQwKCyskwocgu5jr75MPIpCUOutfNFeOjLGTa846TSgvN4FvG+vWzIwDlRc83Hi2lsdRNpAHDs86+sckP13Dw+Qns9WNlxN2QBQICyBGvCsD80E1e6eft0hqgI6F9HYIIymNn+fDsnV91nc2aSM7QDFsYMPPOZtFIqk15fGh9/lLvHVcv4URho8ehj8vRq8qQg8H7eAq6BcqJ+r3CUPbqv/G4jGEpjhQ41PUzdswF/SoLG2TttD0aHNp/jUCZEx7OCOTZbl+Bi+Eg3wY49Q9hxQNsNqqpU2uykLp4ISPDbvsrM9gDF7PQGXOONa0O6ChCm3R4/+uabKmKELjPKSLgU0bVM90fB7o0vkb0nK2B57ZQL11d1vdQg5TqnRzXWiEob79PMgGn6vcFWEJT6o+lYSF4oSzPf4rbHFX5zMqhbEg98Yu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjVaOWpCbnBVeEFwSGhPeHhxNm1Rb2plaGZqRitqbGZlMVhvZFhkb0d0OWps?=
 =?utf-8?B?ZVR0VkJrQVN1ZE02Umg5S0NjRmllTm5xMkRoQk1KYkhpdnBaUXc3STlka0xm?=
 =?utf-8?B?VVhkRVc5S2lyVFJBdXdkYTNQUUpHekZjMTFhMTFUS3pVMFIvOTJ3VGZXOTFx?=
 =?utf-8?B?T1VsSENZbmwzOVNxSHBWNlVJa3dyMFV2TkRIMDVHM1ZURTJFSVZkeXRmSlZX?=
 =?utf-8?B?eFlFbkNLNnZpMzRHSmVxMzljbWd3RXdjS1lJd0pUYVA5VElGbnBZa2tqYk5k?=
 =?utf-8?B?Z0FFdHFHOUQxTWZJTE91c240V3BRbmFJOTFwNlZzWUl5REtmcTdOQ1prTTVT?=
 =?utf-8?B?dGlucVg3UGt6NnRPalRUSzhieDVBNVhMKzQrRTJtYnRGY2tEbFR3eUlIaGJt?=
 =?utf-8?B?V3NjUUxjZkxDdnA1cDFHaEFISmV4TnQ4WmlwWkZoWnVRTFZPMkViMjJyNnhB?=
 =?utf-8?B?WVNZbytVNnZhbnlCT3ZUVmJFanJ3Zmd2RXh5M0IyQ2hqcWlkOE9YTHM3c01k?=
 =?utf-8?B?K0lDQWpYR3hPdm9iNHlOTE85QkU1Sk5MRUNkb3JpclErdWQxSU5NNFAyQnd1?=
 =?utf-8?B?YnRmZExhcFE2azhkeFROOS9VUFZVYnJseTZFWkV2ek9PSmZ0TGlQSzFOTGE4?=
 =?utf-8?B?bC9uemV3ck9jbjZ5VUYraVpCYzlVZE15Q1ZaZGFGUnI1QzV1RDhyaU1TNGlp?=
 =?utf-8?B?blBOWC9HTzJ3QlJXdGtTQ2gxUUlWU2Irb0ozYUNDL3FYc2dpSVVQajZLZDkv?=
 =?utf-8?B?dXBsZXpEUjRSOFVJaUhBdW5LWDBKUEFDakduYk51VktMYjg5TXdHL3dlbjk4?=
 =?utf-8?B?MlV6ZmN1TFNTT0l5MzBxYWVTUnk3MzYvQlRQaTl6ckdMalJJaCtBNzZwWFJt?=
 =?utf-8?B?OWlrSnVQanVqdmFCbHZNd1FKOWpUWjc5K1V4Sm5DNUZibzdYZEs0c1lzN0RW?=
 =?utf-8?B?VUVSdWNROFhsWmdNdjFEaG9pZEVNZTFsNWJMUi9aWmkyRWdtakI5dG1iM0pD?=
 =?utf-8?B?Q0NvRngxSnd4N2pJT25xanFSNXhoQTI4VGx3Qld1K3pWamNnb3BEaGd0b1Y2?=
 =?utf-8?B?WEtPMWxrZzZJemx5YnJSZDRTdVF0WlB1T2VBRVFKOGYxejBGa1BDNllDMmFF?=
 =?utf-8?B?SkhyVlhUMjhkdk00OVhLaUk0ZXdKZTFHVnNsYU1WZ3RvdUxUejZMblg1SzJz?=
 =?utf-8?B?Mlhvc0JianFlTzZhQXVvaVlQZi9RUzA0eHFEV29kQ2wyZ094Ri9NMmlNbFEv?=
 =?utf-8?B?blZYckk4bjJHdWh1QkxKb2lCTGwwYlRHS1NRUEttaUltZ2F5U0ZiMEZEcGNN?=
 =?utf-8?B?eXBxeEt1NkNqYUxUeURyYUNLQ3FObDVMYjJRbzFSL2s2YmZaem5mclJJaHJl?=
 =?utf-8?B?TDJDRkxOR2NDYi8zZ0dwWTRRaElIeWVhcnNZRW1WZEhKK2V0SjJQSzVJcWRz?=
 =?utf-8?B?ZnIyNW9wQ0pUUXVYSjhpRURsNExaVzNyYzl0OUl0QVlBN1NmbytXS1JiNmVw?=
 =?utf-8?B?amNUNFVKVlNxMThsOXBZck95MUloOXJvV3g0YVJ4SEFydENVdERGTDBrb2ZZ?=
 =?utf-8?B?U1Y4OEhWWk42dmxrQ1F5QmVLcWwvakt1cmh2Q2h1R1dNbU4yUGRMUjdwTHRh?=
 =?utf-8?B?ZXJHeTFSN2xtQWxGdHp5RzZPSnIxZ3VoaFFYU0g4QjNHU2J3eCtleVI4VkxN?=
 =?utf-8?B?cCs4YkdsVGE5c0wrODRkWnlsMFhXVUtaZmIwMVR3dDVwR1B1dERKcHNhVnhN?=
 =?utf-8?B?dnVTUExuYnc5NUhHMEtsWnZYbzhUMXB1ZmxCSzIreFJEZlBhT1J2YWpPaHRa?=
 =?utf-8?B?bEpkTXI5cVZKcFZ3YWQxUXp5bG12RHZxbGJVUmROUjNYTmJJUUNnTTlvckJW?=
 =?utf-8?B?TzdYUmpLSFUzOXdjdXVHOWhwd2NIQS9UcEVmZXNEcGNpTXdDbDltVkpLeU1x?=
 =?utf-8?B?ZzRJRUVBNGR3SFVTd05rL1U0MjRzZTZjN2dtdFJUNFZVTURUaWxzWWFFRGR6?=
 =?utf-8?B?SWxZcTZOK252MHhiTjNOaDl6WkVyOUttdUJLWS9KMlFMM040bVJJYjJHRTdH?=
 =?utf-8?B?QWo1cHd4ejhiaU9jOVd1dU8wYXpQSUNpNDdhUEh4RHg5OWIyMDlRcDBFUzh5?=
 =?utf-8?B?K2txSjNsd3NWMEJISTY3L3NVMm9BL2V2U3hSNmYwaW9FNWxhQkkzdFB0YzV3?=
 =?utf-8?B?WTY0cUtMRFhRYzJ5Nmh5ZnhmZDdva1F4N3p0L0Y2TmorQnE3WTR2RU44M2FF?=
 =?utf-8?B?eVc3a0xsUGVYbDI1WDNqemxPTjh5bm9nRGlMZmxQWHZKNXFkV21SMmVsVkhU?=
 =?utf-8?B?VlJuVVJxdVBDYk4wbzR2dStGL2xBVldSc2l2bEpzYmJVeGIvK013Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cf63c6-ee6c-4bed-4844-08dec60dca74
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:59:26.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bOkzbmNTlgYcv1GNMxg9YIjFTme9TPY1Uur/g7+Yu2oXjdNq49ft5O8gtg7L+YwszApLaeZ8zZIysndsdOoLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22012-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA07865EA9A


On 6/8/2026 8:07 AM, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
>
> In __mlx5_ib_dereg_mr(), the INTEGRITY MR cleanup block destroys PSVs
> and frees mr->sig before calling mlx5r_handle_mkey_cleanup(). If the
> mkey destroy fails and the function is retried, mr->sig is already
> NULL but the PSV destroy code dereferences it unconditionally.
>
> Add a NULL check on mr->sig to guard the PSV destroy and kfree block,
> making the retry path safe. This is consistent with the existing NULL
> checks on mr->mtt_mr and mr->klm_mr in the same cleanup block.
This is unnecessary defensive coding.
The kernel verbs contract is that destroy should never fails for kernel 
callers, and ULPs do not retry on failure.
That already holds in-tree: no kernel caller inspects the dereg return 
value for anything beyond logging.

This convention is already present in the code for other verbs, see 
ib_destroy_cq() in include/rdma/ib_verbs.h, which WARN_ONCEs on kernel 
failure ("Destroy of kernel CQ shouldn't fail").

The motivation is spelled out in commit 43d781b9fa56 ("RDMA: Allow fail 
of destroy CQ").

Michael

> Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   drivers/infiniband/hw/mlx5/mr.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 254e6aa4ccaf..3b5216752017 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1436,15 +1436,18 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
>   			mr->klm_mr = NULL;
>   		}
>   
> -		if (mlx5_core_destroy_psv(dev->mdev,
> -					  mr->sig->psv_memory.psv_idx))
> -			mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
> -				     mr->sig->psv_memory.psv_idx);
> -		if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_wire.psv_idx))
> -			mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
> -				     mr->sig->psv_wire.psv_idx);
> -		kfree(mr->sig);
> -		mr->sig = NULL;
> +		if (mr->sig) {
> +			if (mlx5_core_destroy_psv(dev->mdev,
> +						  mr->sig->psv_memory.psv_idx))
> +				mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
> +					     mr->sig->psv_memory.psv_idx);
> +			if (mlx5_core_destroy_psv(dev->mdev,
> +						  mr->sig->psv_wire.psv_idx))
> +				mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
> +					     mr->sig->psv_wire.psv_idx);
> +			kfree(mr->sig);
> +			mr->sig = NULL;
> +		}
>   	}
>   
>   	/* Stop DMA */

