Return-Path: <linux-rdma+bounces-20829-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFIMNUODCWrJdQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20829-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:58:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93A5600C7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B59300AB0B
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CD34EEF3;
	Sun, 17 May 2026 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwGxIKa/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54542DEA95;
	Sun, 17 May 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008317; cv=fail; b=kkfC5pM5UvAcAvYE9zGIlZdaR6cv22TJPoR3lZueg6rqP0WKdoQayuP3EKGXiMvH4V3nXo8mCLc0avzIGC+ZpC4CZnAhoFo0Kp3CymLuEQf8DoyqqOXjzp3wbpMJdu8ls4c+G/VIcrZxok+My+d3jcrfS+MO945bv4C9wPNtzdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008317; c=relaxed/simple;
	bh=Bc8WyVpD8ilaLpdN/PIqWXOSkftUQ5SMml7g2tufaWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dq3FvNYMHr0ii+zk1tXu32i8PcyelY368VY8hLX6Hds55axY9I1n5Yv1zxtbK92ip1zkd+laaMiaq6oDv2iWrDvwc5lEX4VDd8Crm2NmPm8a/30HCub2MoJVIEnsaYr9CbEKNzVk06VoMeb96O5r91MvV4I5yYOByuMBbfn7MN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwGxIKa/; arc=fail smtp.client-ip=40.107.209.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udDoZxQLUnfUiwKOq0qqE3SuU2hQ4qkw8ReRcN28WMBT7JTtGutS7CVfvj10V/6yAEUd0dJxvenpHnYw5yZOE1IxdTIYxQlrjSgwQe5tJMWhFNT3Gb/CMKpLR8PidhtvFPcrTVpxctlpkhOFkeo+uRQNQe1b2gWxJtbs9JEYwXFkzD7Jq0JTFeAut0Umxm221EoIOBZIhN9A6MUul9a98jF9hzsz/XxZiQR8PhmO7qG0b0BT2u5NpORW/E3DBFIDA9KSDb8CszHax6jmUTmbf9KlNYCdIGRfi/Rgj19A8hMlkIMW7fwC3ueT5qoLc5iBrxwb4m7+e4X0kx/E1blzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V+RJLhC8mhJt+xJYPxJd31aByMvM0xzPP8Q7UPhoBQ=;
 b=So2TKvNsoyt9Zpj8pLDRgsamkiZezRY5GHJxMOelaqyrnjhLXNC99RVkFzrwNwET3jO/o9MgxibgqpG2GIGBxBjQ5PquDg+H6x6IlSU2t6mGQTqNnNJrYDo36S2LAFt+16yAWQ7JADpxaA9u8a6OGiW9nT0fA6GeHlTKWf0cjnQJDpSgo0CBNrohOeeOJBESXhi08NZXmHynJAaFiGuxfs80H/nPqS0RcYzAMyxn0WeppOp5Y/w9ImA0ZTGCHliBSXtX/ZcNCyxiUjv5tIeZFSDDWcKlmmcbTgpfpVdi9N1yQoA6P6mMHZaMBVciEOKebWnK5IciYTQzF6dF1i5s1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V+RJLhC8mhJt+xJYPxJd31aByMvM0xzPP8Q7UPhoBQ=;
 b=lwGxIKa/RJys7dgVhOqlTL0TvmM1hI39azQt9refQ/fkpdaaBbmqVreySeX/6Tv8KkGmhuoNIrPWT4iY6n2jsjcsbMmX3kkeahQkGybNGOqzTsey+Qi45gDv6BFneAwqIndqTC92MBjPEZVkwsbDl2kVFNCy6BF/NM90MQ0fSeCwDUOmIaii8s82WpdPb1UZ0/btcaT5DWysq+YnpI5Bm19m4hawRQUcCxG3nY5ZbFir6pt3qXs0QIHwasb9uD8LxFNe5mVW+CLM5rMhlayLEZ+owXcF/QCHuB4DBV3nNt+4/rG+//QojCCotKwp7ggT69U9gwqOkKPHmZGAgleMeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Sun, 17 May 2026 08:58:32 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 08:58:32 +0000
Message-ID: <99c99bde-9800-4a5e-b8a1-7cc472af52cd@nvidia.com>
Date: Sun, 17 May 2026 11:58:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Update mlx5_irq.mask when IRQ affinity changes
To: Yi Li <liyi@hygon.cn>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514074208.23353-1-liyi@hygon.cn>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260514074208.23353-1-liyi@hygon.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 112ead22-967c-4d8b-572f-08deb3f278af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ibMNn2flyvOgVmDSg6IldPGWKROOApYbUbrjx/TEekA0vzkc1H8LX3EvI8u/4uWvfh/8fPM9ojjTW1VPZGLkak7pazjM/SmsVV7F7HgSOBgdkaGlmrYK1ranqJ+Eg9T2PONeaiF2E2sTYHBjrPHlhetIYQctIib0lcLxvXAd/aWANdhWRkpTnu12J9hfzOgY+YsZzVUjDw4xmZYfGrmdY/6C0R2yv4UFbOprR6s9gHhHLhW4a8mMm7a3NXm3gMr/NNMyyyeh413/Hz2XzX5wJJD3KY0MxlmSNM0HBF+F8mpf4qz69WjJnWqzk4jTKoHr7oueTTmR6qpo9OQoJ0YhALMAtVXPJYvfN9ED089LConHJp6Ue1X7hrQgYAuN+TIUD1MZQ/4a/1UaNx16xdKG0yUQ825ACIcIB9hyC8QyG2Z5FALR+YLsffL1kGDF4EXXLq2oeCnTMkfEjGiSEGl7xuxN3tknCTNJKxrxbX9WlW9FulbAe2nYz76FTzAAPszDfAH/vS6ioAPucSRrqkQsA6LTgqaJ2hV6ENA/vI+5k/Q1aJPGfoxQ9Q9eiTwmQ2QP59OaOqZhTblG7uvI8fxLz9sHW9XdWPTTR4JP6D2g8vaVAGg9brLgmaHpnvYemt2jTt11Jz9RUbmiH5vrV1TUtwgZWjHt7j3Fiu5faNVno8KOd9oGo2uKOHsHWY5RFHDT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0V5YzNlRXB2UVpYRFhlK0w3T1h4ZWZIL2loSXV5YyttQkQzSHMvZy9odG9i?=
 =?utf-8?B?V1kvS1g5dEk5SmlxanJOOHNBVlo1YTZSeG0vdEtENnBBSTF4Q3A2MGZsNzFO?=
 =?utf-8?B?cXhFOGwxZXhqZjQ3NkhrZjVjT1Z3V2YzNkl0UmRiekczWkhEZzNwdFN3RHhY?=
 =?utf-8?B?SGR4bmZUcFFaaXRaeXY0cXg3ek1KSUZVYy83cjZOd2tNMURXVFdSdXIyNU9j?=
 =?utf-8?B?TlVaRFJna3U2eW5MSW5NSU9kaElYcHBzbE4vWndPTHhrN2pCTkNrRlZmTjla?=
 =?utf-8?B?S05BYm93dldRWkExT0x4ZkVKZElLdXcvdGh3cXBITWUvTTlYclE5azFmck9D?=
 =?utf-8?B?NUpiOVdDMnB4bmk3ZVlVZzdianJ0YXJ3eTNpeWYyR3dkTHlBUGxoV3N0dXpx?=
 =?utf-8?B?aUZSaVZpNWhlWkZBMi8wWTZPZS9mY1Z1clQydWNHejNlekJZN290a3dBd24w?=
 =?utf-8?B?dkpjTkExU1FQRzJ6M1lBZ3hrQndhZHpmbmV0cG1QQUpRNmcwTm9WOGRIVzMv?=
 =?utf-8?B?UXZlNUl1dklPT3YxYk1kOUpiVXM0dVEyQVZQMlZsUFlpSDVBcUtZZXNBUXc5?=
 =?utf-8?B?WWVYcjQwM0hqS1dsT3YzWGl2WTZZN3hFQlVoZmpDWUFqaWVQSFNSanY4NTYr?=
 =?utf-8?B?d2NKQzdVa2xkZ3JZY3c5bURJeGwvOTJRUG5NZjZQWnNjWGp6WGNIOWhobERp?=
 =?utf-8?B?ZnRVdExNckd0Tjc0Yi9rd1hSTVhVWmg5VU5hRlQxQ0hKdWRvQ094VVpnNkJw?=
 =?utf-8?B?RklSWEFOcWZnQms2TmdDa05meVdOSTNVZkZ3TVAwbC9iK3dzZzhRd3dDakIx?=
 =?utf-8?B?aU94VFV2dTJ0blZqaVlvWmFKOHM3NTVZc1dzMWxialNlSUgyYlpUYStPQnk1?=
 =?utf-8?B?UnFHaFNCZm1rS3d1TlBKaGtsN3NCbzBLUU1kcmxFSEZvN1ZoZW1UNllPSjNU?=
 =?utf-8?B?dmFhMGpycnBSa3Z2Z1BVMlFwMEdtSEpDZHY5dENxbzZ1Q1BlMFIreWdsNGVk?=
 =?utf-8?B?YnAzQ09iYVB6clhxQ2pFcUMwOUZwOGJsSXgxbyttYm12QVdibi9GbUovK08x?=
 =?utf-8?B?aHByT3B5bUQwbk9qZXpqd3JqbzBnalkyU3lHRnBWY01RZEhTMUllc042bnY3?=
 =?utf-8?B?T0FPV1pYNzY0a010MFNWUWMxZjFsMHpKaTVrTjRIeXB6UXVzSkJlUGpLUytJ?=
 =?utf-8?B?cGc0N1kzZmd6bE1neFJrU3VkY0V6ZnZnNDUzWEovMThuakZGQjhMTm1KNm9z?=
 =?utf-8?B?SGZvR3ova3dCLzVtUCt5NVlYV01CWWZVYU03ZEl0ek5KVExQRkpKOEdjU21Q?=
 =?utf-8?B?WGltb2lTcGJ1eE45Uzl5ZFZKYy80NjFTNnRSN1VGQnhiVFQvOTNlUHJWdzFl?=
 =?utf-8?B?QTNERm40Z3NZOEVYZ0pUZVkyakpJYUdQenBsVzZ5d3ZpL1FMbldHWnhsRkIy?=
 =?utf-8?B?RkhCbit2S2UwUXJYMHc5UTEwVWZLNjlyQ0gwcndNdXdyL3QzOW5lYWtEMWFX?=
 =?utf-8?B?eFZoQlZtajZncjZmaENvNTVTMk5yM1VWT2d6Y0dXZXpUNXJQN0ZjTnYxOStM?=
 =?utf-8?B?cWR2UE5NRTdPLzR3Sm1NT2lRVEdPeGdVUWxaczBLWTBCZm43NVd4ZUVqUWJJ?=
 =?utf-8?B?YWI1bXZ6VjkzZEVYbU5nT2F2ZXY5MFhvMTB1NWJuYklWUzc5ZkZqcGs4ZlBr?=
 =?utf-8?B?cnNXcnlWNWE2Nm5vNGZWYlpTYVBnaHpVcThQMnRlWC96RmRablcxK0duWW5u?=
 =?utf-8?B?cTFPcnZqSVMxSHY0c0w3K0d1Zml3Q0JsNXRIOWNMaldvVzZOLy9MN1RJdHJq?=
 =?utf-8?B?eE9QZzlqMjgvbVRpUHJKOWJLcHJUM2o4ekc4T3huanhyWjNSWElKd2UzNXBN?=
 =?utf-8?B?Y3hKUGF4ekl4Mmx1dTN0MW9DTFBsTy9Iek9xaWZUajVQOU90ZjZCSFlhVVlq?=
 =?utf-8?B?MDBmTVlXN0piZFJLd3kzMFZTZSt5NFl0bWtzakRNbmFKeCtKOWhFQlh4emJi?=
 =?utf-8?B?dEV2N1VrK2dpNDE2ZUFmMGxVVTVLU3NxaGtoTmw2VzRPMUpyd1dFYWdYRzBi?=
 =?utf-8?B?MHVrMmppcDdtSllWUTlERWQzQkdLOEZDMzlySDhOVGRRenFibkVNYVdCQWJW?=
 =?utf-8?B?aytNbHVWeVNlMG1WTTBZTmV1ellwbk9Ub3ZZVmwyNS9nYnFTdElyb0N3czVa?=
 =?utf-8?B?U3doM09QSHVnK0RVRG82Z01vOU0zSkh4S2hBbFpBQTR0NzdYQnNqbE81cCtF?=
 =?utf-8?B?KzYvMDdycjRwMEtFUWZYdENQb2FJYlNRaFRFd3VDZTlIZUpKY3lRdkRwSDBu?=
 =?utf-8?B?cGx0WGNzM0pjRUVMdjhUV1ViYktkdnp6aVA2dEdXOFl4c241VjVJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112ead22-967c-4d8b-572f-08deb3f278af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 08:58:32.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISCmLnFdLnrYAf9ynlfGtcCvGbPfDt3vNp8tNmO9zvosAl9xlf0u6TL/k8jz5M/vkmFu7x9OQC4nuYonbBsoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
X-Rspamd-Queue-Id: 3D93A5600C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20829-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hygon.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 14/05/2026 10:42, Yi Li wrote:
> mlx5_irq.mask is used for:
> 1) Setting IRQ affinity_hint in mlx5_irq_alloc()
> 2) Determining mlx5e_channel.cpu in mlx5e_open_channel(), which in turn
>     decides the NUMA node for queue allocations.
> 
> When a user modifies IRQ affinity, mlx5_irq.mask remains unchanged.
> Consequently even if mlx5e_open_channel() is invoked again, queues are
> still allocated on the original NUMA node instead of the newly
> preferred one.
> 
> Fix this by registering an irq_set_affinity_notifier to update
> mlx5_irq.mask when /proc/irq/N/smp_affinity is modified.
> Therefore subsequent queue allocations reflect the updated affinity.
> 
> Signed-off-by: Yi Li <liyi@hygon.cn>
> ---

Hi,

Thanks for the patch. Looking at the proposal, I want to discuss two 
distinct aspects:

NAPI Execution Location: We already track effective affinity closely 
through irq_get_effective_affinity_mask(); NAPI processing is 
dynamically moved accordingly, including a forced NAPI cycle break if 
needed.

Memory Allocation Location: This is the core focus of your patch.

I have serious comments on the proposed implementation, but first I want 
to discuss the idea.

We investigated a similar approach a few years ago but ultimately 
decided against upstreaming it due to stability concerns:

High Volatility: The "current affinity" value can be extremely dynamic, 
potentially shifting multiple times per second depending on system load 
and tuning.

Performance Risk: Sampling a highly volatile "current" value to allocate 
relatively permanent resources (like channel queues) risks severe 
worst-case performance regressions if the affinity shifts immediately 
after allocation.

Because of this, we have historically relied on numa-distance logic for 
channel allocations to ensure a predictable baseline.

Do you have any benchmark data or specific use cases showing a clear net 
benefit over the existing numa-distance logic?

Best regards,
Tariq


