Return-Path: <linux-rdma+bounces-19166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ONHDKGw12kORggAu9opvQ
	(envelope-from <linux-rdma+bounces-19166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:58:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3F3CBAD4
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A66E3005161
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2637B41E;
	Thu,  9 Apr 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j77h1xma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600383D6472;
	Thu,  9 Apr 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743129; cv=fail; b=KkqtmoLLgAfL6QSdjPLDeZ//rSytuD7qs4rdYgO6HCMi+nn4VcNDp9Lo1AZ3b5cgud89Uh3dAZr8azkY40tFtNXSZb0Y+q4qiL8uUgMHJwE7dNup3JnrMdpkTqavIyhhbYVCToztaarHnp1o9rZQru1tAdS9pSznRO6dww5jgMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743129; c=relaxed/simple;
	bh=uxEUi7XluyyALWBIk3pzjuPKJJtF8c7sHaxxjivBT1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UnyFtfhJily9P19nOqXQaMPjT1gpKELgX4NWYKMb/1vC0kupWfBihUz5DlXQuZe5WZ1DCFe5IbnXgK7QOiwStJtyNf+6kUL8mXMuW+M+a4MVR1RQE2W8gnUb5ARPoIupWbID5VmyY0xa7r/xNZWxte1Xxju9LKYXq5xnegJqp+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j77h1xma; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpAfkGiHAhg5nUy+XKBpZeVO8ubMzNliWngg2XAJq93++5T6EcUP0wJovpO56uypa1Op+gbSrD49aoDsAvRTiJHky7NeJdCgSGpCKGTssIjAApc8zfyGDLiDbisMv1QaLodiPolHIQqFJM6bQNdfZhPUkoQjotI5s8A7RmTcs4XK4iWF2EOAbcdOQpl2OrazhYNh6Vr36iGxuKajoZZ0PlKh+P80eP4c/j+i0v2mEx7c1z21h8w6ITZEVYve4qU3nPzaG/Wj52ibAX4ELUF5w8oB+YAY3ge2/xrBcGtuuN+6o0BptT7uh4kzW+FgmEblvjkI3bug0LQ+CtqYp+DTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=mddZ9mL3FhdKs2d9i5MeZPddkB/zeBJqYlIZNEazTOSgdJiw2MqkfY1CooSoorGIyuo76Dcgnfsat6FiHpaE5ZM7awbPjLjLC+IeXwBUQuVP/AH6fD8XXcXuLgM4WPaEuC0lRWAD1RPaimKgeTmHUaR3NdOBNQX0wYRpyyX1y5/2R2TpIDplxXbH7v0v1NnW4pMrMl+09qMx+wOOcPQClJh8o9bdzVp7gTI6ARmF7h60eHJBGLc/cm/IRJsX8DdjWcRmYZ1Qdsm1l9uM/A/9q/5/WKVP5yeVAbsPqwT1vPAhAM5RkR8Xb2lCS7VIledIKIyApF4FZjjQltueM4k3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=j77h1xmaGreTvan3UTi1Ht6A+2v1iqT6v5+J+vp+HKOAWBhT41E5klOwMprqsdGs0O3HBjU+wMaaXJSsH9mR5qu4jJ3L8lSa3x181kzHdDBAgBuIOhDt8Gfa+5wiTGzh1YHFP4mEXYE/USjbVGaWsrYdSNEo/FcYCSBdJbKZikhmovop5WhqlKIRI0uEoznaxqnGsQvDUSDwsVPIU/JqJd1pp79K5CO6XLzVvMqKTKrRf6eQfXTz5TlWhBEojKi1XqTuaBFoqDesUkhIWI/1skJlI7kBig9rs1P+LbKJ9/UfYckEMvVry1cMqUNUVGiVjFIWupMW+qnNfSYkJyV0CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 13:58:36 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 13:58:36 +0000
Message-ID: <413067d5-7a0c-4279-91c8-54f1a703b595@nvidia.com>
Date: Thu, 9 Apr 2026 16:58:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 richardcochran@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com
References: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
 <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: ee84867c-a9df-427b-d167-08de96401810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p4J1OvL53W2hwDKCgzqkPlPdJuIB0lW8eq68ifcvF/YTHRuKwCuNWsoGyib3tEW4rwqesiBK7eKOXFaLQsKYlJtpaMtooamCDWV5X00NvzOGeno1xT2frLUIxETNe9LqA7vmZI8Uchs1HpoPffZXstomwt5/whZMCBVpRIjZFGP7//mX/XI8ejucOzQ7niiPynqyQwm38xU36axlzptAfXmvaIomqEuOpeTgQLtr3H0R1e4jvjyb1KU4yJPIhpnsX1YChVKzhrLxIgxNuME74uSpAgrlPSflRaqkn3dtYCzJrpZybqRH8iUnE5RQPWq0s9HOz68gBYZPOdK3NL98T3QySUY9L62ORh4qS6gOxGx2HBakZBzWRsPM+bIA+QG+yu3ukk+L9k52GWRHnt6xYZ+Jq5tYqbYwoEtcIJ6Nei5huAlfJ8swNWQwkTkEOpXY4T1Qesjt26BkUosPJhbcMuB3LX+M2TcVGte1tEjBIL59JPMhQwtUMQJ5biI1Kb/u9xYYVVFMbNFciASR1LGc6D0YuJy58h4Sn2QqWZUWmJVikbYMAaorTVHkSSAD4V1603hHxwBbxRPkyzmzH//2w2dXX2GwXJEFTx86olOjhNOSicKZmkWwPtinCp27B/6btXOkD/ljq26xARzM21H7hIoH3C4rUD0gKkfMGX+9KKQY5hil0M7hmw/tLbMyPZVXfWofIDyqDwyD1tFk7HYC0vqAhP79KzS54siUwkLnqOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkFiS2RDSEljdkt2aDAzUU42bXlPUDg5cC9ROXk2dzdOdGVHZUczckhwazN6?=
 =?utf-8?B?TjhzS1NzTmJveldMWkNGS3RML25reXdiSlJTL0VjZDNIaU5pOXBRMTdoRTRa?=
 =?utf-8?B?TjByNGN0ckRSR241WjhkYjlMVmczTGFFMFdXV0FyeGRMN2lyV3VBMmt0RDha?=
 =?utf-8?B?T3UxN1lyNm43U1RUR1lZT1psU2MyVkRzRnlEdllTUTVldTVmcDVOY0FSZHFk?=
 =?utf-8?B?enlvMUs2VjBDNjlzTzFzZXNnaXdEbVlqYVc1ODVzOTZ3dmZlUVdyQlQ3a05h?=
 =?utf-8?B?dEtCai9BS3VTQ2ZSZTE4cU9vajBHd29uZlFIUm1qbURQSFJ4RUFKQ3dTVGps?=
 =?utf-8?B?T3J1VnFhUzJFL01UaXFmSWIxcFZmMTM3Q3dGWFZtbFNIcUFGZ0ljeWVQUW9T?=
 =?utf-8?B?SzZiK3RFQmVtM3NrSGk5MS9YRlh3L2lCRkxwZkw4VW1NK3BvSFBUM0p0Si93?=
 =?utf-8?B?U0xnWnkxMTJ1NDJTUWtnZFgvUm9ZclFzNXIxYVNzRFRwbzZHWFN5THB3SVR4?=
 =?utf-8?B?bXJXWkJqSzBxaHd6NWZiZ3hsdWtsZGdLTGZhUHZxZnVGSHJGbG5wZWd1NGNq?=
 =?utf-8?B?eENpVTBmVEJqMVdqS0dPelI0M0hvWFplVnRuSEtyc3hRYmRTYVlSNytZa2Ux?=
 =?utf-8?B?ajlMZHhVWE1ZeXlBMUJKejd0ZkxwOXpmL0RMNXpneFlXdFFhY3QyUHBYd25y?=
 =?utf-8?B?a1hJRlNSVURKWkJiZTdwdnU2S1J5TkJqdzJnT3ZjNWV4YWtBbU5iaXRad2Ev?=
 =?utf-8?B?bWN2UjUrRjMxczRtSjR5RWdnTDJ0WW0yNGxybGNIb1UwY2VJV3JNWjA4Uzd3?=
 =?utf-8?B?dS96MUZUdGhOenhLc1ZhVUpteS9FUk9pN1NQUko5ZnBBa3h1dHh5NzBaM3BO?=
 =?utf-8?B?SHlodk9KQ1JWQ0FxYmpDR3UvNkw0VWEzTVhYT05IV3E2SmVDOWNOaG12bkVU?=
 =?utf-8?B?ZkpaNU1UT2hkRzhGcWFNaW1ReXpUay9JQ3ZEWnFDc09xOHV1b1JNeDMxeUF3?=
 =?utf-8?B?U0Nab3gvRkxuSDl4QzVoOTh6SWVyYTkveGVhWmdvTnlKNE42NzBzOTdqL08r?=
 =?utf-8?B?T0t2WTVHckxYbU92UU5TTjB6aTArZFY2RExvNUhIa0wxcW56S1RJc1J6dnpm?=
 =?utf-8?B?ZGNtVzJvK3p0WmZtb0d3VXJQRHU5Rndpd3kzQWI1blFLN0JoN0h5N3NEbTFB?=
 =?utf-8?B?ZzRJbTVSdTEyOEFEN2NwSTNJQTJ1ZEdTQXpHUVNZa29vbk53K3RoMUNLdG1r?=
 =?utf-8?B?U1ltT25SbUVqek13bEhkbmErVExFSUhqSndDM3FkUDZ1QnFjWFVxNEVqeVlO?=
 =?utf-8?B?SVRLVTBxWExoZGFUbGs1TGkwRWE4UXAzaXBzT0tkNWFZNjBhSzM0ZHlVM25s?=
 =?utf-8?B?b09QMEZxTEFKS0lvUkpadUpFQVFjZCs2VlFGYnRqVE1jbHNzLzQrdm1nd2xr?=
 =?utf-8?B?c3NoRlhqNDVVR1dMaHo0emdpSDhTaExBVWJjT2JiZHUwTnA5YzRQdGRmSVND?=
 =?utf-8?B?UnRjMmd6Z3JTL2l6NDhhWksyRXhUMzRhSlRqajFEYnJXc1AyZ3VrdDBPczho?=
 =?utf-8?B?MnE1UTd1VDFHSFhJbzlweGQ4VExkSkJWYk5HVjc3VG5oakd0d0hYNk9rTjE4?=
 =?utf-8?B?ekx2MHdzdWxuZGVLWkRIRDI3NXlRZjZJMy9TNU5kY0QvbEQ4ckxxZDQ4czR4?=
 =?utf-8?B?SHpXTjBZOVZCKzdKUGZvL0UxMjNqaFQ4VVlneHQxeFdJalNROVM1YTRoSzdL?=
 =?utf-8?B?VUk1RWUvMDZrSXMxNk9PdVFFSVp4VmQvUEF5bHRPdVp0bkhIWWtVcEhWNUtO?=
 =?utf-8?B?bmFxYVZnTGpEZlNHNWlJVUEzeXFWVFJvUXlQSDRqOHpOQTNvZzFMMlg5bklq?=
 =?utf-8?B?VkEraDZ6VndxYVh3cXNWVjRibVZuWHY2VzN0ZkFFNjBlcTZhSmYrV2NIckE1?=
 =?utf-8?B?dEU0T1l0Kys1alkrbFB0TzA2cmtvSTdaQWJ1UEd5Wmd5Y0ZGaUVQVFQ5RU9x?=
 =?utf-8?B?T3lzUi8zZ0NqR05WeThJSWtxQUsyaStEVXVGbk5KYWdDanlsL0RLU2NxRDIw?=
 =?utf-8?B?cmNwMG03SjJRL0wrZmVMMmg2dlpnOEdia1BxbWV4L0Z4dnFhU2ttVDV4QmV2?=
 =?utf-8?B?cFBYdjIrbUhTNEczT3djTDA3MHloTjQ1OVkraHM1b01USm1COHlGSVJET1pW?=
 =?utf-8?B?bjJvZlZreTNFazhuOWQwVUZ4NmRmaW4vY1loT3d4am9PN1oxZUpCZDlTQzg0?=
 =?utf-8?B?NVdsSlZ6Wmw5OHhla0liK3pWdUVTV3pwZ0IrM2RBdllEbTFWc010QlMwQnNr?=
 =?utf-8?B?b0p6bXlmWHQwQUhkQkROSElkR1dxN211VXZseE9KN1JHOTZQQWVtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee84867c-a9df-427b-d167-08de96401810
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:58:36.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8I9vdS68+dvjGVYetuS/3W2ajdDpQLA4D88+kSJ1eG1hNlZ1gYUtQ7SNByq6sCpbEAyhQo/kLKUxmf3uHNljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19166-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 97E3F3CBAD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prathamesh, thanks for the patch!
On 02/04/2026 3:30, Prathamesh Deshpande wrote:
> In mlx5_pps_event(), several critical issues were identified during
> review by Sashiko:
>
> 1. The 'pin' index from the hardware event was used without bounds
>     checking to index 'pin_config' and 'pps_info->start', leading to
>     potential out-of-bounds memory access.
> 2. 'ptp_event' was not zero-initialized. Since it contains a union,
>     assigning a timestamp partially leaves the 'ts_raw' field with
>     uninitialized stack memory, which can leak kernel data or
>     corrupt time sync logic in hardpps().
> 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
>
> Fix these by zero-initializing the event struct, adding a bounds
> check against MAX_PIN_NUM, and adding appropriate NULL guards.
>
> Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
>
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
> v2:
> - Zero-initialize ptp_event to prevent stack information leak [Sashiko].
> - Add bounds check for hardware pin index to prevent OOB access [Sashiko].
> - Add NULL guard for pin_config to handle initialization failures [Sashiko].
> - Add NULL check for clock->ptp as originally intended.
>
>   drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index bd4e042077af..a4d8c5c39abc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -1164,12 +1164,18 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   							       pps_nb);
>   	struct mlx5_core_dev *mdev = clock_state->mdev;
>   	struct mlx5_clock *clock = mdev->clock;
> -	struct ptp_clock_event ptp_event;
> +	struct ptp_clock_event ptp_event = {};
>   	struct mlx5_eqe *eqe = data;
>   	int pin = eqe->data.pps.pin;
>   	unsigned long flags;
>   	u64 ns;
>   
> +	if (!clock->ptp_info.pin_config)
> +		return NOTIFY_OK;
> +
> +	if (pin < 0 || pin >= MAX_PIN_NUM)
> +		return NOTIFY_OK;


pin is defined as u8 in struct mlx5_eqe_pps, so pin < 0 is dead code.

As for the upper bound: in order to receive a PPS event on a pin, the 
user must
first configure it via mlx5_ptp_enable, which already validates the index
(rq->extts.index >= clock->ptp_info.n_pins returns -EINVAL) and since 
the mtpps
register only defines capabilities for 8 pins, so n_pins cannot exceed 
MAX_PIN_NUM.

Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if future
hardware adds support for more pins we would notice rather than silently 
dropping
events.


> +
>   	switch (clock->ptp_info.pin_config[pin].func) {
>   	case PTP_PF_EXTTS:
>   		ptp_event.index = pin;
> @@ -1185,8 +1191,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   		} else {
>   			ptp_event.type = PTP_CLOCK_EXTTS;
>   		}
> -		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
> -		ptp_clock_event(clock->ptp, &ptp_event);
> +		if (clock->ptp)
> +			ptp_clock_event(clock->ptp, &ptp_event);
>   		break;
>   	case PTP_PF_PEROUT:
>   		if (clock->shared) {

