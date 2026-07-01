Return-Path: <linux-rdma+bounces-22649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WqwwH38TRWoo6goAu9opvQ
	(envelope-from <linux-rdma+bounces-22649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:17:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2E6EDF8D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CC2pBAwg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22649-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22649-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C3D309B857
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567648A2DC;
	Wed,  1 Jul 2026 12:55:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACF481AA7;
	Wed,  1 Jul 2026 12:55:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910558; cv=fail; b=TfkAv2HvOKYb4Xn2IPAtjVxpgyCYtxSx7wK/zPwydf7L6WxZmKp7w/Ca/1tyxyywuy2FT/QaAYqD4LieD1y6nV041b3SLWSAvkTkB913AEZOZrkpPFTdSE7GeA4EYrGG/Ka6dgCOu1oxTFM6ZBY01cpIZVZDAAKgJpIsZHtjxzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910558; c=relaxed/simple;
	bh=9mVCCjqC3xf8wZF4+BNcgdPj0hhgbKvgnHYkzl2UXU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOlwnE9CIO95Btm4VeI8vUqZjPJL1WxU28ca/1WMW+keRxzwort2i95jMpJBxn6oNt7oPtrI1yO2pW7Ahm/KlAGuJ10bKV2f60kXfNr5UnKf1PqD1t634Po8LXcxS9Z/snsWIsXyYJjupExATmut0GIkGicFZyVPp0CyKNE3Av8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CC2pBAwg; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3F4wgi13NoQF3cxWYxJCsliriD7909t3zRaDt74LZVM/hLf1pG6Nn1J+mfEHdRrp2F3mNV4W+bz1kdcpJvVLMEduT/Uyt7b7oKwjtwT5Mh7yAo5XT7ytNaUrYOd4rB4N32FnPsn/J7LsiyxJtt67kk9dwgyUA94ai1JsuvwEoUJ2gyyHvqVAgQyumCxhxkZ2KHZcF/wBW9INLhNfSghth5GUpyEdYYp6jDy/EAlaYdhqse2dzBO4RFxSkfjfASniNoEz9QfQIjkrt2PpsrOCbPG6ksnLSvzBi3YWXbQ1l0HUPcOD4uJuZlxIJUYtMMyY6TJE5gMAyn1AHN7+/P1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrEtlJXz6LCx8zs4C3kgC+sRQiPW8JzBKuQ8dr50vdY=;
 b=WhlX+m3Cnh3NFbxNbBu0K7MDdiQPfgesaJFD263T1ahss7rshMook4Zbc1F7o+y18dV3pYPrCOEGv4XADYzNFENnRzHSwGgtXqUI0RyeRKwNewJhsP2PFz8xKY9kj+LSeLxeZyyY4xUiAM6aKQd0RSsaNKaCdsckJGA2elHSyl0VzLvt7SYet2GLa7UNZ7jPUlh1c3Bi0iUZDr+n2Ai+h1GOo3ODnUHMa8efQ2PzcrR4eW/I358gwVBXuwKu6D6z9S1oc89Vu+ilfrv4GKG+zfL/MAEHEKHL1Qsmzp0ofeqX2+uHLkTpeYWA8IAwEeE6eVqvGG3MdyJwMMGqjrxnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrEtlJXz6LCx8zs4C3kgC+sRQiPW8JzBKuQ8dr50vdY=;
 b=CC2pBAwgPZs1CEAoPKNTJh8MwwxP8FOBo0Y3zEVydGJ6RTMhTibjaqKbdozLxJquZXljIN1gpmogK0i97tE+okRREYI2J217SsUMvdtUNH6w2BwQ1D6LQ47DXdrm5ZI52KzBNGdp/lg4uBW62RiaWgq/h1ue6RRx+KSFeHGXUR4Lg1niU6LLlO6gRqnrJ/ScN91FzCtMUi03XJZY4rbJIZuChL4SqUbSaaultc4tTXYoSR33ruYzQdoD2qq1mp4OIc4rTnsLkqbslKOhCYxXyGhGyaylonpUxAt6ePmuJzK9g7TBAwyq22iwLhmr9uzpj12WYqUDGfrXu4dFylj+Sw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:55:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 12:55:51 +0000
Message-ID: <188fc320-b7b7-4041-9132-9c71f1e0fe31@nvidia.com>
Date: Wed, 1 Jul 2026 15:55:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 3/6] devlink: Parse eswitch mode boot defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-4-mbloch@nvidia.com> <akTencQhKSanuFeW@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <akTencQhKSanuFeW@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f905724-0639-42f6-bebc-08ded770146e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|3023799007|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zj4c0D2eeGFjMhg/LTuK5xTkWPuZAExykyEQtAUUfeFyxDCT5ehqFDSm+8xLWGEHCZSf39dZ17NPrye5l1PfEKhWskMhtruGx2+JdFU3+EN/wFvR5dwYzxKaGGBL3wawrjsKdwjAmpVqnApdKbTMyHBnc5v41U+EARqTeqm3dA0PlzqQxvvCggt5QwwbMLHHsfVCmcOntsmffOnC5eUdA3beraIVC2B4jbY83JLsVtKj3KboTFy9bdK2KuVXjMwZdAUtI211u8Xdy+1CLo8MnH7K97hqcSX8uBPBMPbpS6dM5Iof5mR9vZv736ficqjL+mQx5Y2C//QqreJ6ARQBhJ2Dv+uVDIB2z+Q3JrQX0p7Ag2SbNHSgjxOK7E6dw92+hxBhrTX8caLl3bL1V2XenonEOJ+Ufd/6aw7zkvfKCwh8fWmtfu1/M1+YLnujO8bFDuKUyLxjRgzWhsEcfssQZMpx4b/fLn3c7I7xyQXHfBDkoLBKJMbLX+GeEOVGFRagKSaUaaZaVaJqP/VCTHW1aFyQZ/YVzPVqGgpCB3XaElDTngEUKnF8w6AeQU1q34WtLPv21t1CHPwnqdSnUyncrR6ZT2K3/FR35eBabTJ3r7/9t2fCM6zmrfzmSfS0P/UnwPZ65rJf65RItbgUco99S3sP5k4EDT6zH/I0wY39FuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(3023799007)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjEybnlIVDkyK0tQb1lxdUZzYWFVS28reWF5aGd6dmZER3hPMDY2cW8wWUdi?=
 =?utf-8?B?VTgxQkZmYU4zWEp0b0JTWEhWUVRISk55TkxsR2tSREtKK1lvOHNRMFJ3WXIy?=
 =?utf-8?B?aDllaFFLWlAySDdEdUZvZTBwdFdmNWtWRnNTeE9YQ1BRYW9FMDA1cnk0ZzRQ?=
 =?utf-8?B?OFkvdGg0LzMrR1RjQUVYcGV3cWgyTUt6SmhtQit0K051eTNKSnR1VUh0RTVF?=
 =?utf-8?B?bnVOTFpKY3FiZEJzczdyNlk2MEdzd2M5RWtDcFMzcnRnazIyUmJyS1VaZlN1?=
 =?utf-8?B?NlppK2QzY2pFUC9wak5taTdtMFVmTHRPVDZWQUNrRFB6cmFKRlY1dWMvUmpa?=
 =?utf-8?B?RUlROWdqNmR3aUxpbFRrcVpwblh4TTJpQjYrNk9ERTFGdXhEOEV5LzNBdlhQ?=
 =?utf-8?B?MUIzWGl4eldyR0ZWbmlvV082Mm9CZG1oMkxtUFRUME5uZjcySHNaY2Y5UlBS?=
 =?utf-8?B?c2RtUWdRODZzWktYUURnSmFURG1OYit4ei9HSCs5TTlIZkcyeWFibDJobVp1?=
 =?utf-8?B?emZ3cmdkNUVhbWw1Z0k4V0NwaGh0YWxwTTkvNlFJRzF1WWpzS3hUSGQycjlm?=
 =?utf-8?B?azVHSVhHS0RhWk9JQmoyUGFEZjM5eDFJOFBISndlV1FQakFWZFp5WVh2dW1w?=
 =?utf-8?B?NDhJNnZZM1RzMW1GNGRCYnNPSkxHckdqUmpaQXErcjcraHI5SXNFRTVFTTBD?=
 =?utf-8?B?c3U5S2MzRnVVZ1RyMXNjSGM3dHpkNU9iOW5PNmtuOEFCbExiVGZ1YXJxNmJt?=
 =?utf-8?B?cjVmRVAySHN4VkY3K1M1Vkc4NkM0dmR3cW1aeVVPMDBkd0FleWw0M1JCbVVV?=
 =?utf-8?B?cElEYmZyR0RCMTRuWXl4QlBKUStWcFJNL0NYZnFJN1BqSTB6S0M4SjVhOWhk?=
 =?utf-8?B?ZktMWWg2V3Rya1lIdGYxR2xDUG1aczhUaDh2TWlHZm1zUHB6cjZBVkUvTVU4?=
 =?utf-8?B?V2YrS0xPaEl5U1BFcGFDUFI3SG1EcldPVWtnZUZpb3Q1TldoamJ0UEJKVEow?=
 =?utf-8?B?bnVFTEJYcGhhMzNvUmtmLzNkbmhwK01MbGp3b0lJa2YxWXZmbUxhc2o1Undu?=
 =?utf-8?B?TXp0OFNZQVVqN3pqOUpHaFA2V2pKRUhtd0hqQVh3dStoSllqYmNzeDBIdkRp?=
 =?utf-8?B?aDZOaTBrNXJCR2YzbkxkZHlVSStDWW5wV01BOVFJRVphOE1RRGJneDk5SHYx?=
 =?utf-8?B?MklNREpyWXUrS1JSZ2E2TFVBdVlwc3pxNmhDMTdFVk5LeldxdkZIWTF2ZlBO?=
 =?utf-8?B?Y2FTQ1JwUkpEYy9ncTEvcGNoZWhvRkVEMnZ1MVJ6UCtXWEl4QmVtd0hXc3Yx?=
 =?utf-8?B?RnpXWHZlMUwrUTVxYVV4aFN5MU5TTXZha2lvcEl6YUxnYkNZTjUySDRnbEJu?=
 =?utf-8?B?NGxYTUZpWXpzVEV4ek0rdDFGdG5wQ1FmYnMvVDQxR1MzblA1VmhCd0hpZ1dT?=
 =?utf-8?B?WHJkZGJYOW5vU2d3WXQ3WDFBOFdyM1FYVXpNUEFEZHFEWkh0WFhUTVpFaUZp?=
 =?utf-8?B?OUMxYkVqUTlWOEZjNjlZRGFkaE9IODRma2RBRHo2UThuQ3ZBcFlMRzVUU3B6?=
 =?utf-8?B?UTgxOGp2ZXI1dXVOMjUvZlNjTGlPdXJyUFhjQUdlV2JYZUJ3OW5OMUZ0djkr?=
 =?utf-8?B?MnNzaFVNNzJzMEV0djFCMm9wMWJ6cFJvZXI2ajREdFFVY2ttbW1rZFJOTGVr?=
 =?utf-8?B?TVNZVFVJM3pzU1lqQUxlSGRMRzl1SWs1aFA4elRRSWk2SE45NkpWbW45ajk0?=
 =?utf-8?B?VTBaVGNqdzdrd0R3ZlFkaFlSMmNCNnpKT0V0dFNvRW9RTVZzUE11V29ZekVM?=
 =?utf-8?B?U0psaDcwVVp3eWltWnZmUUpMOUhxbHpuY3hsMnoxeFcwaFpEbFlTaDQ4amVZ?=
 =?utf-8?B?TVd1d1phdE1WakFCWS9XeEFNV3FwU2NBVFlYVndMWCtvTkxBUCtwck1pZHE2?=
 =?utf-8?B?UDBUUTNEMmFZM2cxS1Q3em5Jb25ReVpweHMrTWNQRnlQNzNIU2FOQ3RWTVZn?=
 =?utf-8?B?SDFlSU1pazY4Ly9BZ1ZrUEloU2RhREtxWlByYjFpYWxUTHVoOGxVSnAvak9a?=
 =?utf-8?B?aGNweGpjb1ZIenlCZTkxVWozSUVjaVdUZDRMOEs0ZFE3WERLUEYwTzNoMzJE?=
 =?utf-8?B?dGJ4TC9IMllNVHYyYjRuS3U2VngzYk9QQkNHNmZKM0NjMjFML1lQWjJHdlZS?=
 =?utf-8?B?Uk9ycmVCVkZ1N2RPMnEvT0hTU0g3M01WaVAzMVh2VGVQV1MwWFlMZWczOGFu?=
 =?utf-8?B?SEdMNEk0MU9UbGpmM1N2V3F6T0hXNE9GNEVDbS85OUs3dFJlZWZXdDZrcHVX?=
 =?utf-8?B?bGlqZnJNSEIzT3lWcVlSd0xJZ0hYWHVpa0IzOStOWXRqd1JXdVVVQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f905724-0639-42f6-bebc-08ded770146e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:55:51.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtMxMDwou8CWejNRYtf2wRxOcJZtAA3fmAVvF4m7DLKbG3jAMvr7rqfLMgikSTF5vhbOWym4UXkWJ9KxYDtHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22649-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,mellanox.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35D2E6EDF8D



On 01/07/2026 12:38, Jiri Pirko wrote:
> Mon, Jun 29, 2026 at 08:20:58PM +0200, mbloch@nvidia.com wrote:
>> Add devlink_eswitch_mode= kernel command line parsing for a default
>> eswitch mode.
>>
>> The supported syntax selects either all devlink handles or one explicit
>> comma-separated handle list:
>>
>>  devlink_eswitch_mode=*=<mode>
>>
>>  devlink_eswitch_mode=<handle>[,<handle>...]=<mode>
>>
>> where <mode> is one of legacy, switchdev or switchdev_inactive. All
>> selected handles receive the same mode. Assigning different modes to
>> different handle lists in the same parameter value is not supported.
>>
>> Store the parsed selector and mode in devlink core so the default can be
>> applied by a downstream patch.
>>
>> Document the devlink_eswitch_mode= syntax and duplicate handle handling.
>>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>> .../admin-guide/kernel-parameters.txt         |  25 ++
>> .../networking/devlink/devlink-defaults.rst   |  78 ++++++
>> Documentation/networking/devlink/index.rst    |   1 +
>> net/devlink/core.c                            | 227 ++++++++++++++++++
>> 4 files changed, 331 insertions(+)
>> create mode 100644 Documentation/networking/devlink/devlink-defaults.rst
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b5493a7f8f22..117300dd589c 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1249,6 +1249,31 @@ Kernel parameters
>> 	dell_smm_hwmon.fan_max=
>> 			[HW] Maximum configurable fan speed.
>>
>> +	devlink_eswitch_mode=
>> +			[NET]
>> +			Format:
>> +			<selector>=<mode>
>> +
>> +			<selector>:
>> +			* | <handle>[,<handle>...]
>> +
>> +			<handle>:
>> +			<bus-name>/<dev-name>
>> +
>> +			Configure default devlink eswitch mode for matching
>> +			devlink instances during device initialization.
>> +
>> +			<mode>:
>> +			legacy | switchdev | switchdev_inactive
>> +
>> +			Examples:
>> +			devlink_eswitch_mode=*=switchdev
>> +			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
>> +			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
>> +
>> +			See Documentation/networking/devlink/devlink-defaults.rst
>> +			for the full syntax.
>> +
>> 	dfltcc=		[HW,S390]
>> 			Format: { on | off | def_only | inf_only | always }
>> 			on:       s390 zlib hardware support for compression on
>> diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
>> new file mode 100644
>> index 000000000000..380c9e99210e
>> --- /dev/null
>> +++ b/Documentation/networking/devlink/devlink-defaults.rst
>> @@ -0,0 +1,78 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==============================
>> +Devlink Eswitch Mode Defaults
>> +==============================
>> +
>> +Devlink eswitch mode defaults allow the eswitch mode to be provided on the
>> +kernel command line and applied to matching devlink instances during device
>> +initialization.
>> +
>> +The devlink device is selected by its devlink handle. For PCI devices this is
>> +the same handle shown by ``devlink dev show``, for example
>> +``pci/0000:08:00.0``.
>> +
>> +Kernel command line syntax
>> +==========================
>> +
>> +Defaults are specified with the ``devlink_eswitch_mode=`` kernel command line
>> +parameter.
>> +
>> +The general syntax is::
>> +
>> +  devlink_eswitch_mode=<selector>=<mode>
>> +
>> +``<selector>`` is either ``*`` or one or more devlink handles::
>> +
>> +  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
>> +
>> +``*`` applies the mode to every devlink instance. All handles in the same
>> +selector receive the same eswitch mode.
>> +
>> +``<mode>`` is one of ``legacy``, ``switchdev`` or ``switchdev_inactive``.
>> +
>> +Syntax rules
>> +------------
>> +
>> +The following syntax rules apply:
>> +
>> +* Specify the default in one ``devlink_eswitch_mode=`` parameter. Repeated
>> +  ``devlink_eswitch_mode=`` parameters are not accumulated.
>> +* The ``devlink_eswitch_mode=`` value is limited by the kernel command line
>> +  size.
>> +* Whitespace is not allowed within the parameter value.
>> +* ``<selector>`` must be either ``*`` or a handle list. ``*`` cannot be
>> +  combined with explicit handles.
>> +* ``<bus-name>`` and ``<dev-name>`` must not be empty.
>> +* ``<dev-name>`` may contain ``:``. This allows PCI names such as
>> +  ``0000:08:00.0``.
>> +* Handles must not contain whitespace, ``*``, ``=`` or more than one ``/``.
>> +* A comma separates handles.
>> +* Comma-separated default assignments are not supported.
>> +* Duplicate handles are rejected and the devlink eswitch mode default is
>> +  ignored.
>> +
>> +The eswitch mode default corresponds to the userspace command::
>> +
>> +  devlink dev eswitch set <handle> mode <value>
>> +
>> +
>> +Examples
>> +========
>> +
>> +Set all devlink instances to switchdev mode::
>> +
>> +  devlink_eswitch_mode=*=switchdev
>> +
>> +Set one PCI devlink instance to switchdev mode::
>> +
>> +  devlink_eswitch_mode=pci/0000:08:00.0=switchdev
>> +
>> +Set two PCI devlink instances to switchdev inactive mode::
>> +
>> +  devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
>> +
>> +The following is invalid because comma-separated default assignments are not
>> +supported::
>> +
>> +  devlink_eswitch_mode=pci/0000:08:00.0=switchdev,pci/0000:09:00.0=switchdev_inactive
> 
> Interesting. I would think that this is something user may want to set
> for some usecases, no?
> 
> 
>> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
>> index 32f70879ddd0..93f09cb18c44 100644
>> --- a/Documentation/networking/devlink/index.rst
>> +++ b/Documentation/networking/devlink/index.rst
>> @@ -56,6 +56,7 @@ general.
>>    :maxdepth: 1
>>
>>    devlink-dpipe
>> +   devlink-defaults
>>    devlink-eswitch-attr
>>    devlink-flash
>>    devlink-health
>> diff --git a/net/devlink/core.c b/net/devlink/core.c
> 
> Wanna have this in a separate file perhaps? "default.c"?
> 
> 
>> index fe9f6a0a67d5..5126509a9c4e 100644
>> --- a/net/devlink/core.c
>> +++ b/net/devlink/core.c
>> @@ -4,6 +4,10 @@
>>  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
>>  */
>>
>> +#include <linux/init.h>
>> +#include <linux/list.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> #include <net/genetlink.h>
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/devlink.h>
>> @@ -16,6 +20,193 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
>>
>> DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
>>
>> +static char *devlink_default_esw_mode_param;
>> +static bool devlink_default_esw_mode_match_all;
>> +static enum devlink_eswitch_mode devlink_default_esw_mode;
>> +static LIST_HEAD(devlink_default_esw_mode_nodes);
>> +
>> +struct devlink_default_esw_mode_node {
>> +	struct list_head list;
>> +	char *bus_name;
>> +	char *dev_name;
>> +};
>> +
>> +static int __init
>> +devlink_default_esw_mode_to_value(const char *str,
>> +				  enum devlink_eswitch_mode *mode)
>> +{
>> +	if (!strcmp(str, "legacy")) {
>> +		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
>> +		return 0;
>> +	}
>> +	if (!strcmp(str, "switchdev")) {
>> +		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
>> +		return 0;
>> +	}
>> +	if (!strcmp(str, "switchdev_inactive")) {
>> +		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int __init
>> +devlink_default_esw_mode_handle_parse(char *handle, char **bus_name,
>> +				      char **dev_name)
>> +{
>> +	char *slash;
>> +	char *p;
>> +
>> +	if (!*handle)
>> +		return -EINVAL;
>> +
>> +	for (p = handle; *p; p++) {
>> +		if (*p == '*' || *p == '=')
>> +			return -EINVAL;
>> +	}
>> +
>> +	slash = strchr(handle, '/');
>> +	if (!slash || slash == handle || !slash[1])
>> +		return -EINVAL;
>> +	if (strchr(slash + 1, '/'))
>> +		return -EINVAL;
>> +
>> +	*slash = '\0';
>> +
>> +	*bus_name = handle;
>> +	*dev_name = slash + 1;
>> +	return 0;
>> +}
>> +
>> +static struct devlink_default_esw_mode_node *
>> +devlink_default_esw_mode_node_find(const char *bus_name, const char *dev_name)
>> +{
>> +	struct devlink_default_esw_mode_node *node;
>> +
>> +	list_for_each_entry(node, &devlink_default_esw_mode_nodes, list) {
>> +		if (!strcmp(node->bus_name, bus_name) &&
>> +		    !strcmp(node->dev_name, dev_name))
>> +			return node;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int __init
>> +devlink_default_esw_mode_node_add(const char *bus_name, const char *dev_name)
>> +{
>> +	struct devlink_default_esw_mode_node *node;
>> +
>> +	if (devlink_default_esw_mode_node_find(bus_name, dev_name))
>> +		return -EEXIST;
>> +
>> +	node = kzalloc_obj(*node);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&node->list);
>> +	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
>> +	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
>> +	if (!node->bus_name || !node->dev_name) {
>> +		kfree(node->bus_name);
>> +		kfree(node->dev_name);
>> +		kfree(node);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	list_add_tail(&node->list, &devlink_default_esw_mode_nodes);
>> +	return 0;
>> +}
>> +
>> +static int __init devlink_default_esw_mode_handles_parse(char *handles)
>> +{
>> +	char *handle;
>> +	int err;
>> +
>> +	if (!strcmp(handles, "*")) {
>> +		devlink_default_esw_mode_match_all = true;
>> +		return 0;
>> +	}
>> +
>> +	while ((handle = strsep(&handles, ",")) != NULL) {
>> +		char *bus_name;
>> +		char *dev_name;
>> +
>> +		err = devlink_default_esw_mode_handle_parse(handle, &bus_name,
>> +							    &dev_name);
>> +		if (err)
>> +			return err;
>> +
>> +		err = devlink_default_esw_mode_node_add(bus_name, dev_name);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __init
>> +devlink_default_esw_mode_node_free(struct devlink_default_esw_mode_node *node)
>> +{
>> +	kfree(node->bus_name);
>> +	kfree(node->dev_name);
>> +	kfree(node);
>> +}
>> +
>> +static void __init devlink_default_esw_mode_nodes_clear(void)
>> +{
>> +	struct devlink_default_esw_mode_node *node;
>> +	struct devlink_default_esw_mode_node *node_tmp;
>> +
>> +	list_for_each_entry_safe(node, node_tmp,
>> +				 &devlink_default_esw_mode_nodes, list) {
>> +		list_del(&node->list);
>> +		devlink_default_esw_mode_node_free(node);
>> +	}
>> +
>> +	devlink_default_esw_mode_match_all = false;
>> +}
>> +
>> +static int __init devlink_default_esw_mode_parse(char *str)
>> +{
>> +	char *handles;
>> +	char *separator;
>> +	char *mode;
>> +	enum devlink_eswitch_mode esw_mode;
>> +	int err;
>> +
>> +	if (!*str)
>> +		return -EINVAL;
>> +
>> +	separator = strrchr(str, '=');
>> +	if (!separator || separator == str || !separator[1])
>> +		return -EINVAL;
>> +
>> +	*separator = '\0';
>> +	handles = str;
>> +	mode = separator + 1;
>> +
>> +	err = devlink_default_esw_mode_to_value(mode, &esw_mode);
>> +	if (err)
>> +		return err;
>> +
>> +	err = devlink_default_esw_mode_handles_parse(handles);
>> +	if (err)
>> +		devlink_default_esw_mode_nodes_clear();
>> +	else
>> +		devlink_default_esw_mode = esw_mode;
>> +
>> +	return err;
>> +}
>> +
>> +static int __init devlink_default_esw_mode_setup(char *str)
>> +{
>> +	devlink_default_esw_mode_param = str;
>> +	return 1;
>> +}
>> +__setup("devlink_eswitch_mode=", devlink_default_esw_mode_setup);
>> +
>> static struct devlink *devlinks_xa_get(unsigned long index)
>> {
>> 	struct devlink *devlink;
>> @@ -382,6 +573,14 @@ struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
>> /**
>>  * devl_register - Register devlink instance
>>  * @devlink: devlink
>> + *
>> + * Make @devlink visible to userspace. Drivers must call this only after the
>> + * instance is fully initialized and its devlink operations can be called.
>> + *
>> + * Context: Caller must hold the devlink instance lock. Use devlink_register()
>> + * when the lock is not already held.
>> + *
>> + * Return: 0 on success.
>>  */
>> int devl_register(struct devlink *devlink)
>> {
>> @@ -580,6 +779,31 @@ static int __init devlink_init(void)
>> {
>> 	int err;
>>
>> +	if (devlink_default_esw_mode_param) {
>> +		char *def;
>> +
>> +		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
>> +		if (!def) {
>> +			devlink_default_esw_mode_param = NULL;
>> +			pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
>> +		} else {
>> +			err = devlink_default_esw_mode_parse(def);
>> +			kfree(def);
>> +			if (err == -EEXIST) {
>> +				devlink_default_esw_mode_param = NULL;
>> +				pr_warn("devlink: duplicate eswitch mode handles ignored\n");
>> +			} else if (err == -EINVAL) {
>> +				devlink_default_esw_mode_param = NULL;
>> +				pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
>> +			} else if (err == -ENOMEM) {
>> +				devlink_default_esw_mode_param = NULL;
>> +				pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
>> +			} else if (err) {
>> +				goto out;
>> +			}
> 
> Move this to a separate helper alongside the other "default" functions?

I did that in the following patch. If I respin I'll do it in this one.

Mark

> 
> 
>> +		}
>> +	}
>> +
>> 	err = register_pernet_subsys(&devlink_pernet_ops);
>> 	if (err)
>> 		goto out;
>> @@ -595,7 +819,10 @@ static int __init devlink_init(void)
>> out_unreg_pernet_subsys:
>> 	unregister_pernet_subsys(&devlink_pernet_ops);
>> out:
>> +	if (err)
>> +		devlink_default_esw_mode_nodes_clear();
>> 	WARN_ON(err);
>> +
>> 	return err;
>> }
>>
>> -- 
>> 2.43.0
>>


