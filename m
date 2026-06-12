Return-Path: <linux-rdma+bounces-22151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l8UJDc2UK2r//wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 07:10:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C9676B38
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 07:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=nFZSaDTH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22151-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22151-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5203193DA2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 05:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15FC3955FA;
	Fri, 12 Jun 2026 05:10:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697528C2A1;
	Fri, 12 Jun 2026 05:10:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241016; cv=fail; b=RZdh+7vT35qJKriJ4NOcgyDz49zffTDgIC+RlkpFnqel/9PVDl6WS6Lr/5T6SifTjq44WxDq81LX7RkhXM67qpQWq7qxGaBfwzp+ujEL3oc0OmIkvExNC9kL6R6cLp0MHX+vIdz68wpFVtaFXfbWSNcsf9j6qgIR2fO/IUDAHRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241016; c=relaxed/simple;
	bh=fKuiP2Ou9C6wrT7BW6RKyozSEMS/Hu+tWsjUrUX63R4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ASHDSUPFuc1Dd33ygOXeNY5+68ZNmk6FKMlEV/6E0zbt93Mq3SubQoj0KRzMN93RoUAlIp5Q23ELsfmiTUhAnpJK01h/IbwkCI/2utu9sAvtVNy1QHNwY2XjBw4ybJoTiEJmpxYbpCus1w7bNNT+4KWVtH2RfRztA5FeF/hQhSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nFZSaDTH; arc=fail smtp.client-ip=52.101.57.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp7tOpV8P+/bpzivTSSoFuTAkr/iRJs0dDBFhwjOcWiJo4SIT/PngvKA8QuFjX4Cslad1+YkDkfQfmjJGYSBw/mVuaCrmccPbEeeXrg5SLB35fwL3GNAdLqEmiiTrMarrEe0FUPU+ysgBwvQKkrsEbzjbMW4UZu3T1UyYNV3+BU9AwM9yIp3KizjayijfaFB6m6eHi1eq3UUYt3IUQHE9pIWYrUncql0YV8YQECdo2EKICDJgv8KeCV1eSwGWVFv/PsNrp3+1jiB9LECdn36Tj5wEAMsgcAZ8WGu+iKj1O8jRtuES2sbAH4f/pUK9BDRBjgdwM/qhCqgmh+VqxqC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63du5uV+Nys288M1qoSbnIM2HvL1NoC67xoV1Ai8oAg=;
 b=W4ovewkSXtqM9etKPzb9ICz7C7svhPijtv6pDqpiNPl8MqPEm+2IgdjAA5xf202K7JJnmd/lrt/sOJxyy8ZZ5QHR75DxDBDgPbq+KKms/+NKc0oZNxrEVPRnffWE3htxUhzheOQ+PjeBbhFvsQqvvdAHQzOD9OIDwEGY94+/XbPkfZXHF/GH0VtpuQ1G9R6U+5stLWQHkYQ/lrI1mCRCnwCOYJROxe2wAzPNC+V3qYQZvO0dichL8bdddkrk9mp9DIlAjD+W59/lr3AmZxYjxColbQW2pkuj8hLSZTSS0elvErlOGzhldmjOEJWBYsUYW+5xeJSX8fR2xsjh5yc8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63du5uV+Nys288M1qoSbnIM2HvL1NoC67xoV1Ai8oAg=;
 b=nFZSaDTHENasbkysBAUkXViZCqv5NRqYibQiEvV5mnDD2JvWqfQcRP+ozvX+h1LOJdEdVApNqUQDAKx0U2HWXg3IGtf5b+QdoZP/tYX0cODG52fUTae+2aSJbN61OuvSjfAogCxloFILcOTQrXw9I5HcAmUJ+LBlrfyFxUe+UMwh5XngTd/XSTo+BAO8pFM01O507TT/Vr5k+6wuST/gOm8kJGkIZBuy9x8hTvvngqO6sIjx5IE7lUGq2MikiUx6U0KbllmmfsY7EssZM2aujcOs+awZafrU+ryg1rZLAA3mTf9JPH9SHPioUVMlrFQhfLH+JHruxnNYpIB3iDd5eg==
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DSWPR12MB999176.namprd12.prod.outlook.com (2603:10b6:8:36f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 05:10:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:10:03 +0000
Message-ID: <ebc989c8-f317-48d8-8fda-752d30aff2cd@nvidia.com>
Date: Fri, 12 Jun 2026 08:09:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 00/15] net/mlx5: Add switchdev mode support
 for Socket Direct single netdev, part 2/2
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maher Sanalla <msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Kees Cook <kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
 <20260611192031.1b3f7d0c@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260611192031.1b3f7d0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DSWPR12MB999176:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c3a7c9-2995-4012-8a35-08dec840dc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a+REuBuKaMSMOER3/rpqIrJXR7ojMnflE+OigxNxOeJqQvOaUPVH0LaXzmzB+UHDD4krC+gvMVvF9zboMQsDIgIf37hLM266s+01geUI9U886Be8lrc1CBgfRaNg6Wj5RHsostX3Pw2QKjizBT622BkSJEQopXyw0vi6M/0TQo7SPMEXTCCocjqLnuJ/1M1yXN2pPzUqd3KYsRf48Fmw77jqVa6CZZ8hfcBR87VEEZzmcI7/6aJJlyTHi22f+Hym/4tgIRy/lVxDsD+mspTh1bvNkF0v/L4Uhx4MjlLo+76oJBE8zznU5Qv/FpLbpDjg0qouNRRazpkmk/yqsjBHNiFoTIStQwJ+6m5akBJKMYzBbc82z5/+OEOCiH//VB6HUBShnlNYAFjBNmU3C7fR3xsrudILlAUBnJOobGtELTQUikA2LFvETmMdjzYrlN2Q2/8dUv/Y6ifAxZpHV3hUVoMK//3BxyE8GoZLCC9zUxHGuAVap/Wu58dXNmI+8A93qATXq3KMULRdkeekvBhEO40HbpAE9fmDolgCFK0q3jh6CSJtAMGsv+33/8jvp1EHzFNGLGUm0/QazGMyXZpVtF2IG+3O9Vr71TMQX+DcWk50pMRliTxjZHi4t7NnpXVlGc7Y+m9tWWAIE/sqhP1ZU2we2U9m3xClIqdU2f2dZKP1nxFAlh86r5t25KkgMFdV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkh6bWV1MGtWRmtlUE1nUU84WElaVUdacUE5ems2RkRyM2FXRkU3THF6N0Nt?=
 =?utf-8?B?c3ExbzE2UGdSQkhNTGtiMk00eGxHenJuZUNpYW5uMzk3RWRja01qNmNRc0NY?=
 =?utf-8?B?cVNEc2tIWHlXZHQ0RzR4VkpneWFkbGVLeHdPVmk4dXVlSjluaEIyZXVuMXIx?=
 =?utf-8?B?c3lTR0N2bThFWUNBekZwcW4zNVQwdkRUQTRqRElHK0svNjNmbUhDZ3UvTmhI?=
 =?utf-8?B?VTQ3SGcycDI4cFpFSUZiWTNZc0lnZkhweTR3OGhtbEFxMVVWSnBhQjVtODFt?=
 =?utf-8?B?VkdGbHhkUWx2Sk1hSUN0UHNzaTh1cWFQKzJ6eHNoWGgvSmF6dWtHVzV0cXk2?=
 =?utf-8?B?alkrOVBlUFIveUV0aXVvZnhXMnd0aTBsTDNXaGFXMXNHcWdZcUZMUEQ5OUxT?=
 =?utf-8?B?cFdVRFdpc1hCc1FwM0tXQ2t3b2h0TnpNUHBNVXREUTFLc25hMGZueG5SUzJZ?=
 =?utf-8?B?bmQxdk1CS0RnVk4xQzhmMTVtRmo0Qk40eURaWml1Z3BYbVIxYncrZ25BNm9B?=
 =?utf-8?B?d3BpMGNUY0kvc0hMd2xiVHdzUjZBdVZiWHNKR0VUWDhQcmI3Ui9DejhXQVlr?=
 =?utf-8?B?TTd1YnpnRFR1YW43b2UxbmtZcmFXMGgyWDB1WHZnSUNnMDg4S1NiMkdteFBa?=
 =?utf-8?B?L3ZCc29mVVovWEpOS0QwckRwMEpkZnozY2VTdkhFOSsrRkxJSkQ3OTk0eUJB?=
 =?utf-8?B?UUM0R0RKV1d4VGNoN3NLUUZ5UmdYRjdvTTQrWWdFYmQvTUZYN1Y1RSt1VHpZ?=
 =?utf-8?B?RVc0S2NoNTRTWDFOMDAzbUpJQ0dnSWFZZW9xelFnN0llN0Z1UFl2VGF4YmxJ?=
 =?utf-8?B?WkhEZjNGcFRONFQyOVJaWVFKUkpKT1JzOTFSbG9WOTYxQ3g0dTFMZmh3QVE4?=
 =?utf-8?B?TTh5NG52aHV3elVTdDRudEladFliWmRDMndYQ1czNmhZeU9SYWNwMFB4RDhS?=
 =?utf-8?B?NG1XMmlVRE9zRDhMQmFyblZmdzd3ZGhhWHhNQlViaHJDNGl3U1VuOW5HODF0?=
 =?utf-8?B?RWNscnlxYmFkTDFqYnV2YnFoc0tlZ1RUN0J5Sm41Z3FVYStxNVlkNUI0K1ZS?=
 =?utf-8?B?U0k4OEpmWlJZaCtuRFhnNG5ocUFGZW9JeUNmbGZ4ZG1sK3R5Wk4rbUQvYUgz?=
 =?utf-8?B?cGlhK0Nibm9qbHdwZ2x5bG4rVC9DZTI1ZTRRc1phTXB3dnFZNEdTaGhkemNU?=
 =?utf-8?B?YUREM3ovWGE2ajJzOUFncTF2UmMxd3c1S2RDN09nR1J4WWJ4dlc3TlNtZmtV?=
 =?utf-8?B?QUR0R2ZXMzRHNnpCeUpNM1YvMjRsR0Zsd2h3eXNIaDNuTW5jdVFOUjc3L3Fn?=
 =?utf-8?B?OWpOVlZLdEdsVnNJOUVBaUpWblN5ODV1dXBEWk03aUJOeGVuaytJQlZZNVJC?=
 =?utf-8?B?VVVUOW1BenlVc1E2cDBlelcvbW8rRzdRMkN4QW42YUx4Mnlqam52SFgvY0p4?=
 =?utf-8?B?aGJSb2lRczUvSVd6a2FQMHhPa3lUelBMOTNXRG82YzdsaGhOaVY5c3g4WVE2?=
 =?utf-8?B?SlR1WjRhczQyWGxKclh0WFJrQTJBdjlrK0dXdlFXa2kwQi9UU3pPSGRyUXdU?=
 =?utf-8?B?SjZnNFY4Y0VRSGlpK3JjQmxReklLdC9pYk9Mek1Bcjg0V29pWCtFbm9odlFr?=
 =?utf-8?B?ZVlSUWpjcndSTU9TcTVTV2wxenZySmd3MDkxemVRWmtmUG4yamZjQi9CMWdF?=
 =?utf-8?B?L0k5UzllZENCdmVWZkltYjhCbzJwb1dnRDFOYnF6bGlDVGRRQ0lrcFpVSFMz?=
 =?utf-8?B?ZDBoYnUzYkpGRFd6NS9mS2tEZXpkQzhoMm55dmVsUTl6UHNWSGlaUDNaU2hp?=
 =?utf-8?B?QnM4UEdSczQzMUFycGJ4cFE4UnpvUUkzeGRCUTVZN0EzVUhrMmZTU1BIRTZH?=
 =?utf-8?B?cHBCS1ZhNGR3VEZvVXJ2d2RwcE40WEg4eTAxVXhJY2hwUjZzclZGOXF6UmVz?=
 =?utf-8?B?MitISktac0trUy9xV0pwRVU0NHpOUHJ2WTBUNlVEbmlYRzAxWmhyZjFhUWhU?=
 =?utf-8?B?VmtKUUoybGJOYjFvZG9sNG5QVTIrUjlYRW5ENVBQTjJHOTViaTF3MUpVL1V2?=
 =?utf-8?B?LzlqV2lWQU1KZ25tRVB6aDdBcjFkZmtTRktRQ1FvU3NtWHNCKzIyU1k2Q3FD?=
 =?utf-8?B?eEpVRFI4SXhYTCtuYytwWk5FL3MzbHR1NEVPUkt1UDFRUmM5alV0R1g3b3ZK?=
 =?utf-8?B?MjJIb0s3SklxWTVyL1kyVWdMUWRYczVubDU2OHlpb3dQaW4zbFhXemRnQjNY?=
 =?utf-8?B?VXk5L0Rxa0VCUjlIYTVKSjltbTBUR0Q3N08vL1NJcjZ4c2JFaVRXRXh3QmVy?=
 =?utf-8?B?a0hnMGh2WXcyckhDcVcxMkh3STBibnE2K2R1NFpvTzE4Z3o2M1pHUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c3a7c9-2995-4012-8a35-08dec840dc64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:10:03.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: triYpqVAYlrJ4U9tEdwNWSFQSkuWn+83auEhCCJQlqAs+Rf1iuuxGr/xQkl4kvKHlyngIGuFMfw5FsH74m+dAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999176
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
	TAGGED_FROM(0.00)[bounces-22151-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A0C9676B38



On 12/06/2026 5:20, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 16:55:32 +0300 Tariq Toukan wrote:
>> This series enables Socket Direct single netdev to operate in switchdev
>> mode with shared FDB. SD single netdev combines multiple PCI functions
>> behind a single netdev interface. To support switchdev offloads, these
>> functions must participate in virtual LAG (shared FDB).
> 
> Have you checked both Sashikos? I picked 3 errors at random that show
> up in both instances and none of them are covered by the list in the
> cover letter (netdev's complain about patch 5, complaints about
> buggy unwind paths)
> 

Hi, many are not real issues.
Some are, however...

We are working on a new fixed version to be submitted soon, we will 
reply / address the Sashiko comments.

Regards,
Tariq

