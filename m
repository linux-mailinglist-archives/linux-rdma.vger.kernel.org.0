Return-Path: <linux-rdma+bounces-22210-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yirMC5qYLmr00AQAu9opvQ
	(envelope-from <linux-rdma+bounces-22210-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:03:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE8680F92
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 14:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=nJXe5hIK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22210-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22210-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62917300C31E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CF286415;
	Sun, 14 Jun 2026 12:03:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8729827E;
	Sun, 14 Jun 2026 12:03:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438592; cv=fail; b=pKh5ujuljW0CpVdR1bmUNeLqwdrZ7tpigTgaZQF01C1H7NNdEZGxA4LJJoZVJbEeeyNuaqXVpHkE9o5DwTnVCb005feywUniTLTFp0mDbV0sFnIHXPn2NdsRMkdqoHuXCvXYNEmJJQlkDLuAWXrFU09bLOllDfmJL1h/M8SvHK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438592; c=relaxed/simple;
	bh=4jwruzzDh7QBhP4b4mfcpa5e+NzNAfQn9Ospl+mTAa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pczeX2NXdNBssMdweGtXJsBB7IuiMF+AgTLFQj2aFZ3LVrvmZJBbBr8cJyfWd7CmfYUjJlSUmLEVuMqhWNA6aXt0mmmfMrwLV8+NOmF6wmmL3nW+OaXfYCCCU+jz9GMplYypz2+y38XGHHKKdF6FBAU3lB66wS46V/YxS2t/D/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJXe5hIK; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCJj7Zi2xySDS6K+IP8E91uKHNCXizUrZwzXN0B+PgSvGsc2Km/x+GFIwd8IOkPb42oIfwss35eHqGMY17ORtdYEMsDipFuCs8fYix8g8A+DM72LuMpYWP4l1ki+8TyHAsFHGD3swQF0ctvI/HKpe18xaq6PfNGqypVcARs6TQEkLZgIq670VhQ8HpJWIfJ1yZghHonUHrZSK2mLC9hdWlGUcD5osUXkd1fn9T0CEu2ltY+/LfSNYUKQxRDQQNcyWXuIwGJgdNHe/6zvb9x0ExQb69cJpu0YeJNKCQzi7xvONTDl4vdVCb163FfRX2vklsSOqo7Tju/zB+uPtnfNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0s1j+HoPahgSYzHmxzvm0qVH8oI+m+/rpRV7xxb9DE=;
 b=weKkU9S0XEQzWDl1MRamx3fbIMeGTXkhkhu8TN3pyX/jEdZtKNLZnopyBZiWBzgkJr2Tgf/gFtbaJqvffwNZ6bJ1Ma4/Nvq197Q0RKqdlp0OrD4tOMtyFZn587qvZLAXyN9pa1+atxgrpVI5yogETcEdKX/ocrQpESA02NGpV3/5a4rnPODnbAJmJEKeG+i1bdotcTabnMX8k6fNgWVGz+21gP/CZt/uRDbzI9zZDbRhL4l9bjXjk8rM3g/wSdtuMKpfxj31T3t8M/el1Gec9mt/ULUf+9VVYLBhG76rVlSiDujy/ZBySnnLVNBWnZGycbUrdbprbWQs/BM4x1N94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0s1j+HoPahgSYzHmxzvm0qVH8oI+m+/rpRV7xxb9DE=;
 b=nJXe5hIKdrThnp1FM63sQnwVLCtZufh316j7bbtIGKMq54rCJ7fay85y1lkRZDV3BmrriPFyhcwykBJhjKkom4dkeTJkxA1/vtfTl6OGAZ8zDrg34j+PwvQNcfmqnomnYL/KuG3YUVOXJPwCAi+eMLkmCPHC6iYTMEHtwsVqlY0lQspqhllPzlu16PieXa2L0SwRA9h8QjDuhxOllpZgv4ZS+3uMG/l3h3T9sw21/iK865X+KraJclNtCkzrszQnpMVVyEvh5cA1Xmv5eZ7KyEBfgUT0NEBd9K4OKRq11sSlsm5tlC0QvBI1U7v9KNilxmKhlSXFkH669nhnAtOJdw==
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 12:03:05 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 12:03:05 +0000
Message-ID: <bdbcd7ab-68cb-461f-b21b-814685764461@nvidia.com>
Date: Sun, 14 Jun 2026 15:02:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 7/7] devlink: add scope filter to resource
 show
To: David Ahern <dsahern@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Carolina Jubran <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Shahar Shitrit
 <shshitrit@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Kees Cook <kees@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Petr Machata <petrm@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
 <20260609053953.487152-8-tariqt@nvidia.com>
 <943b4932-17f4-4a52-af92-b9485a0e8c7a@kernel.org>
Content-Language: en-US
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <943b4932-17f4-4a52-af92-b9485a0e8c7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a075ddc-b9d2-4bfc-0389-08deca0ce438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	aJ+3AjzVq3C0c5Ux9zHWS4RXRZm4VkocxpbS5ierviSHC3F1C0y/s+PUCd5weiOREjpdTMSuA53Mh9Ep5Hlx8qdupMxky5UJpDvJ3po1r4C/6zwHWeAfyaapklS2HweWAL/xJTtL4Ma6j7baOOHTEjl9esEJ8396KOqC43mYOpirGhy+aOxWSYZF1roVwWdTUXIQgtJKZ7i27gYQYgekzWcCG9eg07JU0+Bt0wWOiumtA8qP/Qg1+ZsvNA8zts7GJwlsec2M/6xtrQKUNkq2x90lLlsBifGbX4iU+WlbnUo97zFHzymLXuEnJAP9++K42YYdzMq2P11Y48iSN2soXR+wG92SLV1UtW3Yyz9AxfGxxa5EfGC7PFyKmPLORtcuAM98rD4tlQEqE3JsKBPFnrHBzK98UJdJwKG1fwijaXMUhaBoOtfRIMVqD5gv0gthLdac0tifJMcycl1fPzbCZN7nV+gaZQWU6T7okXgbmOR2tuTPZ6fWeZDeN2nhkyt1iv80mvrGUahMa/s/pKzzhymmEyLyOeHSwWVltn81ExjETmQlb7l7J/5isXOl+VDGENOUAbYqrNTSjvQOCT7tTLIZaazRGSVlgNuZRQSRSU66mTPA+TVt2tuBoacMhxyafaV/JdK7GOfDeCrSQQxUmPg7NQWOYtao/Y95xHNOo2qp82pqvRbX474gXIWMrhuP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJ4Yk53K1dKaW4wdlg4dlhFaStPNEU0YmcyRSs3UmZpVkt5ckkwRytORmlj?=
 =?utf-8?B?WkpyMjhhRTQ4ZHA2NlJuV0lrY3FPdFozM1J6T0UzSCtHOVVRbXNFVmFqYkZu?=
 =?utf-8?B?Zlp6QkhKN3I0OTNQN3hCQUpFSlR1V0c0UFAvUVVQN1pjaFdzQ2JHdFdkdnVO?=
 =?utf-8?B?czlTbzVKQmF3b0hyTFhqUm9oZ2YvYzBZWWsrSHM3OWxEcmhPN2VzSURhNFpj?=
 =?utf-8?B?L0pYSzdmdUVlZmhBRVpZWWNaOXZTcHhMV21ld3FzZGNCMUxQMlJoVDRybkFa?=
 =?utf-8?B?aXlMNGtwaDA0ZXBER20ySFV3QkM2NUR5Z2hUSmdZVnFGMG9qOVhUTVgwK1M4?=
 =?utf-8?B?dDRmMTIweDhyaFF0aVJUcmwyMEF0OVVUVkRpeVJaa0hpU2RNU21uK3NYNWMx?=
 =?utf-8?B?QW9KejhQL0EvVUdaZDlJVUVMY0wwNFhYK0VvbHRwczcydXFpUkJUc250V0t3?=
 =?utf-8?B?RjFrYitmZDcvdTdhd3hmM25Pc0VBcUdYSWtiU1JzRVczdzVzM1JYUWxybUhJ?=
 =?utf-8?B?YkN0LzhISGJ2Yi9tUWtSRnBiaFNESEp1U1BBRmJJdE9KTjI0a1dKZnI1NEJz?=
 =?utf-8?B?bUVvYytEa2thZHprRlp5aEFaTkFIbHFrZWxWZGJJR3ViTzU0aGVGMlJPM0Vm?=
 =?utf-8?B?OEM5Ulc4dk9DMy85WHZaMVk0b1hLM0d0OHNnL3FPa0dqWkRwQjJwcTRTZnlM?=
 =?utf-8?B?dCtBM0sxaXJNZldmMEY0a0kyTU9kZ3UydWszVUtQZkI4alJtYko0ZUlaRHV2?=
 =?utf-8?B?L2dsanR3dzVZSnVoY2dEOHNGaXlWZWhFRkFjNFdselZzTVFWczNmbUZBbUl0?=
 =?utf-8?B?Z1kvV3g4TkFvSW9hUHpQdElBMFpKTnlWTWFsYld2VjVocVhlMjNrem5rVys5?=
 =?utf-8?B?NGd4MHltZHJaV2NxRWZSbGd6WnhiVDFaa0xJWFR5YTIrOEFkOW9ENzVMMjVI?=
 =?utf-8?B?ZWNEN1l2THJPcFloRGEyTXZxbWRYc2p6TWZkNlZCZlVXRmtvcmU2SytDTU9l?=
 =?utf-8?B?SzFIRUlZdXFSZkdQQnYza1ZiWDhLWjl5QlRYTE43MEwvUHBaV2RQanN2NG4v?=
 =?utf-8?B?L1RpTmZPenYySFp3RVNaWWQvbGRwLzIxclphQ1NndExuUzFGTmVyOXlTQ0xn?=
 =?utf-8?B?MCtObFBUejRrOTBjaEtMcjZ4K01sNzZyS1hzZ2ZKZXloQkhnYXZoTWluN3VQ?=
 =?utf-8?B?SFZ5SW5rR3lWUUdNWXhHR3pTaVlkM0xsNGxSN012OTJBQVVaQTArUitJaUd0?=
 =?utf-8?B?YW5tVmw4aXlucHRENU9PdGQ1dE56QVZWem5pVGRGZXRXZkpkNEVieUN1dUNr?=
 =?utf-8?B?WG1tR3BnQW1qdUlSRjNqSFV3OXQvREpDUkhhME50R0pITjhnNnVCRzVHVjJh?=
 =?utf-8?B?UlRFeDlqemxDUEdMY0c4SnY0bTAvQkJqZEJuRUhGRWQyTi8rdHp2THVYZ1Uw?=
 =?utf-8?B?ZWhlckNwbUdLd0tVRGlxYmMrNERaRXl1Rkp5QTZsSHhYVnU1ZC92UUl0QUpU?=
 =?utf-8?B?R0JMaVNld1cwbHExd3luUVRoY2gxV1hIL1BtdG1jTktxUjJ1ZjRHZi9DMHdr?=
 =?utf-8?B?NlZ2TXEvRzY4cS9HZGo3MVJOTzZpdmlSNlMvTzhmRXdtbFdYN0JPVnZmM0ZR?=
 =?utf-8?B?ZlVxSWhFeVpWalYzeHRpalAvOWR5VlorWUN1dE5UUE9XaTgzQ1I5VkQwQ1Yv?=
 =?utf-8?B?U2tDQ1prSXI1alFDZnpoQ0ZkTklZTEhJN1l6YzF1MGJBV0s5L0RwL3VtQXA4?=
 =?utf-8?B?RVEyVVZpbkVGN0dOK2VWdXU4SXlUek1Lb3RxTjJLdkJnVmFJclRzTWg4empE?=
 =?utf-8?B?SU1BemUzODdDNkxzZGYrdkoxNFVQa2J0MTdVcEM2MW9zaWNUWWZnVE04NFFr?=
 =?utf-8?B?TDYzQ2pKWVZ2djVQRXJJM1YxNmlQaWkyTnpZeTBDVWREd0lYQ1V0U0M3Nm1t?=
 =?utf-8?B?NktwOE53SlBRY1IwTFptSGJmQ25QeWlWK1JwcDljbC95WFpLT0E5ajBMQWdk?=
 =?utf-8?B?NEwxMVdrNlljU2JLY0xuNkVmL0pOTU5RQmNlVWxFd2FDSU8xVzRKbDNDQlhm?=
 =?utf-8?B?RnlZaHhZZjNSZUpqUWU1aXFCZk5rdjdwcDIzdkpoRXZxbUUzN0VXUE44VmMr?=
 =?utf-8?B?TDBLaGNOdUdxVmRwbEQwWE9NZ0J4M0tiTnFJMjZEVk5RMnpFZzNrZWVyM29K?=
 =?utf-8?B?ZGZaNGMwY0N6bWtZWmFTWGR4SlQ0elZxNnVvNkpQcTZlZGZnL1Q1WDkyM1hD?=
 =?utf-8?B?SDk5ZU9OTGhIKzJ0SkVsTzBaaEJwc0xsVUJ2YU9QMm9CMDRzTEVYLzNjV1J5?=
 =?utf-8?B?Nlh5UnBBbTJ5cCsxc201MUl6SStMTFBNbENDYU9XTHpXT29BQTVwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a075ddc-b9d2-4bfc-0389-08deca0ce438
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 12:03:05.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0/XtkC9r5CM50KlXWBe9LIqNPd5ZLVFxNGbTWIfXEiCvMcEh2wzOveI4yICgnyq1Fdowkql9TanfVWwG3nu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:tariqt@nvidia.com,m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22210-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABE8680F92



On 11/06/2026 21:53, David Ahern wrote:
> 
> On 6/8/26 11:39 PM, Tariq Toukan wrote:
>> @@ -9010,13 +9029,29 @@ static int cmd_resource_show(struct dl *dl)
>>        uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
>>        struct nlmsghdr *nlh;
>>        struct resource_ctx resource_ctx = {};
>> +     struct dl_opts *opts = &dl->opts;
>>        int err;
>>
>> -     err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
>> -                                       DL_OPT_HANDLE | DL_OPT_HANDLEP,
>> -                                       0, 0, 0);
>> -     if (err)
>> -             return err;
>> +     if (dl_argv_match(dl, "scope")) {
>> +             const char *scopestr;
>> +
>> +             dl_arg_inc(dl);
>> +             err = dl_argv_str(dl, &scopestr);
>> +             if (err)
>> +                     return err;
>> +             err = resource_scope_get(scopestr, &opts->resource_scope_mask);
>> +             if (err)
>> +                     return err;
>> +             opts->present |= DL_OPT_RESOURCE_SCOPE;
> 
> Comment from Claude that seems legit:
> 
> Issue found: In cmd_resource_show, the scope path sets opts->present |=
> DL_OPT_RESOURCE_SCOPE without first clearing opts->present. In batch
> mode, dl->opts is shared across commands, and the non-scope path
> correctly resets opts->present via dl_argv_parse(). But the scope path
> bypasses dl_argv_parse(), so stale bits (e.g. DL_OPT_HANDLE from a
> previous dev show) remain. When dl_opts_put() runs, it writes the stale
> DEVLINK_ATTR_BUS_NAME/DEV_NAME attributes into the dump request,
> silently filtering to a single device instead of all devices. Fix: use =
> instead of |=
> 
> Are you ok with the suggested resolution?
> 

yes, thank you. let me know if I should resend.


