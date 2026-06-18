Return-Path: <linux-rdma+bounces-22355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LBZH7IRNGpfNQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 17:41:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F236A14D4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 17:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=RXCUVqKK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22355-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22355-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91274301F318
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9033EAEC;
	Thu, 18 Jun 2026 15:41:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023101.outbound.protection.outlook.com [40.107.201.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402A33D6D2
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 15:41:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797283; cv=fail; b=PvVXVfb/7LATiK1zOToSfL7hP/8bHtralBn3sY8MLcvwc7QbUYFNleUkUkhVikTWaNuSR0OAN5dGmgDMekp8uICFIicMdivaOpA2V5tlLjNqDfymmpBbqKdjsIvmCMaN0nlgx1Gz3DST4dmqthieTJLooZ7sCFoT4HkvvVOSEGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797283; c=relaxed/simple;
	bh=xBs2DFX2BNr/ZISZsdKVdp1fIx+FNZXEBbJSba8wGO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pp5k3lQBcn+gTzgRvBsuru+UkpItruEP4dr69BkB0hJ32ED28wKpZk2QO+lNpnABWPmdkvcgQpH7zYeucBymTPWRBdd4ADAwvuQ32Hpx9TyjUkHoXQhTQ1leFrbP1SMDoNp0j2+mv3zr2yoxMzl76xPZz6FpONe8f8mvZ3kP1p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=RXCUVqKK; arc=fail smtp.client-ip=40.107.201.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw2MKGVQkw+aTpElUbJ0XHFHHae6RLTM/I+lHcB3AWvgHTssE3o/EPn3t+1h3tY2teYuJ+DDEz2qc798q5hTLHW3y2yyfz57gQ2JZzh/XuauTWFVEUZEezl5wIkcKyvQvUMFf9Ducot8M0UmREY/cXHDNnGVV+vOy24BQNCXOCA4QjGxyHVwUbSok6YTSOy1afUq1Y1bDYzRnRJCWd5aKAfv4Yl9+mM8CQgwzmg3ep6qPCK43D3QAckMHdMmDJxMcgxsazzNhHBsl81y+JsB80Zi1EKwdSzHAWV5gOGyBh7mMmUJ0/MyM5BNKecx7Sf6X+Sio2Yb/891/J3br4y9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRlF2qnugqjXNFi5rCKy2h6aWkverbXfdMOwWeKKWD0=;
 b=p+Qt8PlK1E/tCdesezoqcZUml5ykzNR36VKSq5rcyX3vRySfM96rYjC+Jo+PQH0DoI2lOJXspNVTvgZ2rJJeUCWx9rzF39r2zYYdiCXvgRkZKMLKd4ktQOl4obJv3UIGbY2bwmrmDQIt9sXZ3+U/hrFXwzXPilslKp7rY8bNjwZTmGtFOl0xhlZ1ks2ZZIo5mk6NWexGEA4REDSdykz+64o45RdxEldKdSb8/MIywxyM3TV7ZFm0ay6quBkEwmvZwZtk45CMhTY64G8PVtmU7kK1bo438T59UoO5hLRqfNK8HAGAoUcVOLOIjMco3F9w/sUZyxs0sk4JRPnCP/p6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRlF2qnugqjXNFi5rCKy2h6aWkverbXfdMOwWeKKWD0=;
 b=RXCUVqKKdu1zTcHntLSaIljgehTbbDHtMP9XjM5ns9+opRs7q3kph8W8D4qMBFHIwzv0+XR9XjWm1h1wHFXMv+HOZiUyQU6dESQbRIJXpPs9y3Jy1MDKInVyLTV1z96QyAvbsjdHSYT6xi7F7MaOaw81WqRJHbsYXTSuUsOHIrd0qLYPdy30wRP/luViJk7NJRZrnB8wUWr0CN4aBOQXjT4urn42bZbJOM1gHwJxZEjiiRegZLkjXGOfTmZFSl7Nq5ExWd3X7hFx1Nh30xUf9oy0ndNzJAH8UMdj/o3iy+PGZyZoZrrD8z7qM9q8Ceo3lcR38XzheVQVIay3YfjGzg==
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 BN3PR01MB9236.prod.exchangelabs.com (2603:10b6:408:2ca::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 18 Jun 2026 15:41:17 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 15:41:17 +0000
Message-ID: <cb0200ba-e1f1-4106-9e1e-74e4118d9106@cornelisnetworks.com>
Date: Thu, 18 Jun 2026 11:40:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v2 4/6] RDMA/uverbs: Add ioctl method for CQ
 resize
To: Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com
References: <20260615085040.1396623-1-jiri@resnulli.us>
 <20260615085040.1396623-5-jiri@resnulli.us> <20260617110605.GV327369@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260617110605.GV327369@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:610:75::14) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|BN3PR01MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c21bb2d-78ab-4fc7-b363-08decd500973
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|18002099003|22082099003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info:
	5epu/6kJF9sD61rmo3YWiZMP8xSrwA2e2DZL6407ligo8vq0SKkwzfVMqDx69ScTdkYbI7C5aDIBqkT/cPcF2sH9Z3AWO7K/QAwoJ/YrELqef1RrBahF0pyDxKY4Lyi/QVkniHQmIV2Pqar4qCTwZCGoKFyeMayHi6TgusK2oHlOnap6UEVv5MFBjIa8byTXFY0+uxdZ8EgebYLITGIAofNs9UPLSBDtM8DF/ZKFgsPRQqGAj741jSP9Swju66Nt3kbRD6mRCQV2UWbE8tA1T+d+JjMKXCTf9I1e4X3ZVlfNaEIGbyeHTOTrkT9XjKLPJBCa04vs2LUEk3ikVuCC9Y/g+ICE0S/VZo47Cn1w6aQqMJlMb8sJzEzyXXww1oyACCwdmNOlra3xU6B9c9nA+wh17/8trQ+mjuVEQN+tdNF38PpN3ELWeuaoYq9Inr9nUFzMluDQFGKU2lAWft9xKjCNXrvhjGlMQYGyNSAy9z06wH2PoEUfL1vdDwZHLVGME0RCPFahgmq0qWulEnmBNvXZDw7KLfZYnT2NjFfO1x+qcUh3AwKr7/doSWBH+Zi/bo3v+a+iAYT0kK0Uomepa8C15xaFq4ewZIGHXK9Bo5xYQdeujgz93kZQf9/deJKS/XZxtFhoGTEjV/LZkei1dEGTk4ShfUxz9yuh/Hb3XEvzsVajhx0ibvslXcxILU3p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(4143699003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWt0ZEtPczR2Z0Nmd0ZKdGRwa1JoVDluMDJFQXlSTW9vaUFSWk5iVzdvN2cx?=
 =?utf-8?B?SmtpTjF6MFZXUWRYVGlQWHZ1S0ZZOGkvcU0xbjgrd1lWZWQ2MzAybC9kcUVR?=
 =?utf-8?B?aSsxbEZIOGZTWEtudEJybWFQWnQ5cFNEQ2FLckl2a3lpWmFiNlE5YmdVTUhH?=
 =?utf-8?B?TU5BTHMwTnlFQkVYemVGSkViK1ljM3E1V3JIWUt0YnBpRzc0V241b2lDQmJt?=
 =?utf-8?B?ODVIc0hPWlRYVnkxUGorVFdMQjlBaHZEbkNaV0kzVzZCNEdYdVRPTUludVNZ?=
 =?utf-8?B?a255b3h2bnpaYUJLV2ZOSWNXMTZhS2RDMHJvUEx1UGZCT2phTWpyb2NCQk5E?=
 =?utf-8?B?c0JNVGU3WnFESEtwTFMzR2w0VmQ5VnlPNkZrVUI4ajErS3lBRS9OOS9FQk9u?=
 =?utf-8?B?VW9xK2E0d1BtUGNINXRJU0sxR2Rtc2RBMzhySUoxS1Bzd2wzUURpcFhHRTY4?=
 =?utf-8?B?c0FweENPTzBYdXRDMlZ5RzBhbldwRFFhOG01Q202U0lSV3NyQ01FRTlkRlQ0?=
 =?utf-8?B?ejhrcTY0bmNsczJwMzVHMHlCZFVUUlNTV0JWSzdLQ3hWUzRQRGk1aVppT2Jj?=
 =?utf-8?B?NDIwZHpPZEhvakIxK2p6TnY3ZjhYQ2ZmbUM3dnBSdEE2NTFJTHpkSFF0blRt?=
 =?utf-8?B?MnhYMFROajJtMnRuTGFBWGgwaDZmTkExVE1VcVRZUlJHT2VzNnF2RUtOdnlS?=
 =?utf-8?B?YTk1WVJ6SWNPZ2FQeUhjZ2ZOc0FvM0RIdzF1UDNaRDd0VXQ3bDd0QTN6MWJM?=
 =?utf-8?B?N0dXUUQzUW5sZUlZK2hFeTgxbkhlMGZzNnVyOUk0dk1mQmN3ejNDRUdwS0ha?=
 =?utf-8?B?aGVYUVlSR1E4dzZCTFRPd3VMeEFUdStKRjJpdEdBMVRVN3Q5TW5xenNoLzE0?=
 =?utf-8?B?eTQrS3lXUXJmNXlZbGNyVnNKY25LUFVCYk9ydEtUUnVDNGJSbVZSL2hma2Vj?=
 =?utf-8?B?bjZsKzJTcmQ5L2N6bDNES0hmaTlVU0hTQ0JGSWJuMnNzWnQ2VlpOd1ByNnJ6?=
 =?utf-8?B?RDhrTlQxSldLZnBheVF4UC9LRWo3YmpGbHFYT0JBYjZpU3RtdjBEQ093NUFX?=
 =?utf-8?B?TkoxSWVUOTVXQ1EyOUFsYkMwSzFVeUIwL2xFL1g2RjZNKzNrdEZ0Ykw3N0FW?=
 =?utf-8?B?NFJoWGt3ZFkxQjdnbmYvNWtPQm5vVUlBSXR6UkkvanJhUUpBcy9EOUk2NVkw?=
 =?utf-8?B?SllGS3k5eldwbDh4d3Y0TEdkZGkwUVFHZWY4ek1XSmVPU0RmRy9qQTJhcldQ?=
 =?utf-8?B?ZCt1aVF1QmtyUXIwYnZNZ1EycHRKQjVMUHhqeE9zcy9SM2ZSQml4MGo2ZW1w?=
 =?utf-8?B?ZUJHbkFnekRBUUFuV204YThudGJ6RWpZRkRlbWxkVkVMaCs1MGJjZGtKZy9D?=
 =?utf-8?B?dzArNEVDNmhJUGxTdUdNS0xHMWFvbU54eVczZXhydUl2ZjNMNVdSaVlNcm14?=
 =?utf-8?B?ZmVBUjczM3A0WkozWjNmOTd0TXdPWmRicTlPM1VFalBHWEtSU3BSVzUyV0du?=
 =?utf-8?B?Ri9QV3JHZ2RzRTg0K2xzbVRERnRLRGlUMU8xTXM2M081M2ZDUzhmOWZmT1pE?=
 =?utf-8?B?YXR6OUEzYksxZzZ4cGtVdGNueEx3S29ySTdTbTE4SjkxTmNadkdjYi9CZ0Vw?=
 =?utf-8?B?RWxZRFU3M1VVazZLUFBkeDFRTCtlRDNMM0dXZ3VneW53QTg1ZDdCOW1RYlNv?=
 =?utf-8?B?eWJXK3JZN0NjZ05zY3N6L1o1aklYMlpRUHNrR1c5Y0NPZDd2YjNFRkpCVmZp?=
 =?utf-8?B?MlpJeXlRWlcxTEFDeEFGT2lsQXM3SHQ3OGcyUDhUMWh4K21oVDZZVGZwTmxn?=
 =?utf-8?B?bnFPbndLUEtVNGNqbmY2dzBNcDBxVUFXMnVYYTNnNTRvNEQxWjRwRk8rRFRX?=
 =?utf-8?B?eFZpKzNjSVRXNXAvbFlxTldCWGZGUnFORFowQ3RaaEwwZDNFckdMS2gwM0JK?=
 =?utf-8?B?cFlmcmJoVy9vTTVWM3lydHVxQkNlZTR2bkU1QlRwQXhQTEVFNWU1WGZlN2JF?=
 =?utf-8?B?RnJmY21yVUpIUTdUWE96U3NJTkxWbDg5LzJjTzJlMW5FTzcyQ1VYTjZ1dm1x?=
 =?utf-8?B?bmtPdUpPQjg4ZldoRzQ1YUY5SGF3bzlhUEV3Nzc3a3RBWkNrYkFuMkJXY3Yw?=
 =?utf-8?B?VS9UUS92K2NWMTFwL25wa0gvWWVpeHFHSm1RSHMwRjhtQW9VVHRnOFBkSjI1?=
 =?utf-8?B?U3lPZGpOeUlCekNDTm1VWmxFQ2tKZzhpT1JYalNjK1hDMjVsdmt1Z0NvcEdD?=
 =?utf-8?B?QlA0ZFBMUUdNMEYrS1JTVmhzdS9heTBoZ3VocDlNTzY4dnRsalBYSVNjb0RI?=
 =?utf-8?B?QkRPYXZUcUU1bEo4K0g5RVQ3K0tIUXJtaVNPVkU3R2NuVS9YM21idW9qOGdV?=
 =?utf-8?Q?LigF67wMsngqC7et3HADBLZ+UrZrbdpWyikbi?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c21bb2d-78ab-4fc7-b363-08decd500973
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 15:41:17.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W65w/SXzi1zlXFV2S5ad0LHZ05JRDHX6yS7Wbns82M9GjzjPkAzXwK6FLvszs1VCvpGNxa1iLQbG3Fs++JcyOFKIi2ER9zJZjTcJ021eLzxmhWFbCNbx8dluXxHlCuh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB9236
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22355-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:mrgolin@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,cornelisnetworks.com:dkim,cornelisnetworks.com:mid,cornelisnetworks.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34F236A14D4

On 6/17/26 7:06 AM, Leon Romanovsky wrote:
> On Mon, Jun 15, 2026 at 10:50:38AM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Resize CQ is currently only reachable through the legacy write()
>> uverbs command (IB_USER_VERBS_CMD_RESIZE_CQ). Add an equivalent modern
>> ioctl method, UVERBS_METHOD_CQ_RESIZE, on the CQ object so the
>> operation is available through the ioctl interface and can carry
>> per-attribute extensions. The handler mirrors the legacy command: it
>> looks up the CQ, calls resize_user_cq() and returns the new cqe count.
>> The legacy write path is left in place for ABI compatibility.
> 
> I have a general question. Do we actually need CQ resizing, given that it is
> rarely implemented and often incorrect in existing drivers? Maybe this is a
> good time to consider deprecating that path.

Can you expand on what you mean by incorrect in existing drivers? I mean 
I see a glaring coding bug in our implementation but I can patch that.

-Denny



