Return-Path: <linux-rdma+bounces-19226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOgrEAoy2mk5zAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 13:35:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4B3DF83D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5166C3026F1E
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AB329E4B;
	Sat, 11 Apr 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGDmpPBS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9311E633C;
	Sat, 11 Apr 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907316; cv=fail; b=ENdA8mOUtWS/BXPpieWTGd6zoe5ep6AIg2/PWQfrDzYv4ffVlqi2RqYZ9AjEfnoYm2+Mjl6t8E2nl759EQ9lrwreP9FVai7F/VM/z/7q3jhO0jFbihX6Okr8EstImry9cm87UiLu8BVK0p/Yc+xJ5FQNT80M1qRq/AWC8P82X38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907316; c=relaxed/simple;
	bh=grphbegMPQ9mYEeZC1ux2R4gr1tw+9zts46CR+JrM4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VX80WFGEX+E9lCZWAdVOxxg7W48UFDg1OpXScG27YslzHhn+l6+C0Ejp2cCV86nnWdUUnbO6Q/QXYaR8avWpMmYVCHHeirwwXFlJ+kCsm8/OXwUGbJixbS7xiDORtuMbCSw8o6mnUX+5HC/DVUiOvfsHc0plSnJlHhMXlCc/zz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGDmpPBS; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUT104yiKPiGHDbwig65y9e+U7eCgfn5Z70BsiIKVL2c9KuRdtqiz9rkA9hbZWoMY9A656M4bx9iFUnap6E8SDRP3DWx53MdnSXhoyqAL6VbIwbkJp1O6JeQDB4BILDJK3MySRjTCVtzvyh0wHhuDoWPL+YAF5aIYZYEY9Ad5YlkfAyp65qW/GvFa7YApwQ4tsRdc6oO4OmzEGw+K8QAuuNMZV8V2qpmVwYNC7Tg8oG7WPZtIQBNElPtr/iMCAfYOYXK9IQBX/2vs36rzRM3XOHvXmoKFwGZfX0CnpjdM6dZbJUQ8a//0TzGSo0u8YGEbGhG4dOzog/2IFh2nmnM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2qw3w9B95VDVbtRCTpdVMDKTFfXTVIH5yiiTWgNwik=;
 b=gS11GteYOzJzTEMBjsUihIPHvGxXYf2UjTeBChVOHR+Y1itnGWjTU4+E9EaRNBnWEOT4eJ/cNpChhTL0toVvkMpUYG+AcgfvXhVyKrsSdQ/6uixDM0jbY9dXrhyaGz0QrX3yQl3louxQwA765qauDfWofnmC9vWjOQTwCPbcj6SDOL3S36XNVkYZzinRfcPm7uTSSXE5ycQaFsgAa4yMOZtsJY8vCvW0V9a3uFNUbZrNBLJWauejl3ZXrnnkzdXReSxNNug/xXa5rf3GaxFXZt9z1UU7RuwLz/YP763X3YbdSNLl/EGiEp2nAePYMw14uM7OtmtCqdBeDsEgJGgw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2qw3w9B95VDVbtRCTpdVMDKTFfXTVIH5yiiTWgNwik=;
 b=RGDmpPBSB6fI9NpoRvzr5I8AktK9aGuE6u7ZCfOLgOoVy50Py7qo9LDwinpvd5BVjMnKWc8q2m7ZEW8HKVw47q66a85+0m9P3ZjrlPfFBKpHeEflZabES0CEsL8Ht7BDBZAVzryDy38sonCTgrWydQ/2ZaKCVYH48bDff4iph05Eel6uiuYwMaytX55Pmz/51vF18v+iyLXXZ0iO91mZKXkDGiyH/9Hf7dyFsw4xcVGoHmZ9LvRW3B4ME6eHzqRHXHtCvCMy9Gq6aN81kj0IVZmluROMxpJyRnhQmo/C2PE9ZE7kM83/1kZY+KdeaZvhrvGSf8YG9FfoisGR1DH1kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 11:35:10 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 11:35:10 +0000
Message-ID: <c30f21a3-5a27-43fb-957d-107775b00faf@nvidia.com>
Date: Sat, 11 Apr 2026 14:35:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20260410015336.7353-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20260410015336.7353-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To DM4PR12MB9734.namprd12.prod.outlook.com
 (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d06da8-300f-4d12-71b4-08de97be634f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	g1KF/fwVNagmF9/s0aD0ul6tKf9o4fStW1LPev44EWF7aNnpFHVUy2D5jUUJjrF3d0RdmVyWD08txKRLYdpftsoh9KaSS2ILhnZFS6SkY3Hmq0yu4Vp/VuI94Zt8harmCFGc4M4c8P+yY3nh5jtJ4CR31joDwGeE6doJITpGxQWvchOwt2dq22LP8ls8VSKIa26CWH4MuK0OcWz6XtNYS0FCfQTYsw6rF4iQqdWtEnRv6ZOXWQxrRfxMRHqVL598H6w26vWW5OtMAYygxJzCTT87POVDxf+h60IzglzNj/rxFnNCj0XHYPW7xbjgAIJKlP9FfzcqIjdaCusBR5VEK+Cuonl7R+kobQ0GIWn1Aru2zMFgUdCEVwnjfGe5VeeMLCiAhWjbwemXgdCGlssWU5j+3RoFCNqWmxamupJl2aLYPO/v9Cv/HGuCorNRjdMtPqnrSguP+Njs5isicvd6ciWidGeCk8Qcz8ClWgQMP2q0T4a+lnOCcpymPxosTwuWQ2bg1+KU+iJ1UEZmG9u7AKvP6F4QwwDc+9cYR9MVQ8UCiGWn3lOsdM1m5/sjSD7CkKYNRFq+J4mbCFo+MKUtLC1VNw9voQtbSzcz3H7rDlKOOyn1BEY7YcLldMmxPVI1ZfjyD8rBARjf6IGmuxnuRf8DnDn5UyyeJNg5ho7aplC27Y4GQEvQHPy3Tkl/SWFWpBBdfU+n8jEXtGwE4J6br+8ANuh4CMmpL0EblzcrtrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmQ0aTlxWUR2Zmg3TmFvRGtEaU0reHlsWWJMV1ZYSUllQjNpbWxwZGxLNjRD?=
 =?utf-8?B?Z0F3MGlJUUl3T0p0cDJjWVYvL25VT0t6SEFvMndYc3VjRFZrc3NHTGdXWWdS?=
 =?utf-8?B?RVB0ODlWUEdiempuemxsSlppVTR0b00rQkVHUy9pcmR5aHoyQzZCd05Zdnor?=
 =?utf-8?B?NzdyYW5wczhBTDd4ekhGYUEvRmJWeHNJSkdhZUFleThDV2c5Y3J6TVk5Yzc4?=
 =?utf-8?B?a1NNWXlBTjkxUW51cW9mZjVTSzRDbWcrbnorSmJObWRNdHU4ZDNZdDd2czRQ?=
 =?utf-8?B?OFMyYUhncGFZL3JLMFpTY3dqV1h6ZUlWUFNQY2RaTlpFQTA1WlpaOTVXckM4?=
 =?utf-8?B?bUllenRBT0N4ZjZiL00zN2YrQXpYTXJWVTEwUnF3RXdTZ1o5UllOQi9JaU9N?=
 =?utf-8?B?dHpaNjB6VjRQQmtRUHpucE9ZWnZGeHRMRUZ1dm0vR0JqSkxQRkc3RFRweHE5?=
 =?utf-8?B?UXMxSFBjMDFNWUljUFVaVlJrdG5qUXVhWDU5dkJNMU8zQ2UzcWhRY3VjcTc0?=
 =?utf-8?B?QitVNXFUZzRCRFBQNFZUNjhPdlRYbGpCK1RGTkJZdm1QWFlMTGcwenJ5WWFQ?=
 =?utf-8?B?TEcwdjlWWkxuM1BNeEpyYTFBdkNSTmxaSldnMmRIWGd4T3FKNUYyOXBDOGl6?=
 =?utf-8?B?RFk1dTZrQ2k4NHVhZlhYNmMyVmpPcW41T09sQllUWnRBVFpuTEFBS212eDg0?=
 =?utf-8?B?aElBUnlIU28xRFlPQzArZ01LQ3J4Z2cyQnhNd0V5QU5wMzNYQzhucUx3NGMx?=
 =?utf-8?B?Z2I4Z3FsYXd4ZG12WGIwZGFPMGZHZ1VHNGpYRXV6b3MzUkhkVDFwY1JXY0ZB?=
 =?utf-8?B?NG9RQ05PUmRwRmdReFJqUUhUUTQ5dXRHNkJjc0NIVFF0WUJxOTF0SGg3QnR0?=
 =?utf-8?B?a0hQOFNQUWd6UlhUT1F3cjg3Z2tVdTM2M3FFZVNnYVl4elFGMVZ1ZzhFN3o3?=
 =?utf-8?B?Rk1wckZxUkxHejFwRkkxd00weUp0NnFEM1VmYnh6UHdpLytNNDgvdTR6V2FU?=
 =?utf-8?B?L296ZGdDbDJhV3lUc2EwU1RidjVlZEV5Q1I5VEhKN1dqSFVialZYSURKbExV?=
 =?utf-8?B?VDhYVU5FeVptQ3p4bk1aVjdMTStMbDFmeU04emJLaldMWllCdjZXNUs4MC91?=
 =?utf-8?B?T0NmbHdkWkJONkFzR1Z5RHVNTFc4UGZpMVVFSHBJWStiNlZwZG95UzFzcnl4?=
 =?utf-8?B?aDBYL3VDVURwc3ppdkFZU2liOU9NZitSMk5MVmlIR3NPM3NMT1A2emllUHNR?=
 =?utf-8?B?R0F3dFhvWjllZVMxbDdKeUkveUlUN0dvMkFRL1AvUmZLNy9xRHlKa1kzVXlH?=
 =?utf-8?B?NkN6ZzZ0aGdFQmR4SDlXejFOeDlPa0E2ZElVNkpGLytLdWdWUWJocDFtVU9a?=
 =?utf-8?B?UVVscE94Z2ZYaVp6cmJmc2tvMlNPUmhndWUrdXI3REJKNmU1eTFGL1NJRWhM?=
 =?utf-8?B?QWlhV2VXNGZ2Qnl0dnZ1NDJTUXAzWmVDSldrQUFuS3k5Vy94SHpmaFBZZitk?=
 =?utf-8?B?ZmlmT3RqRkZJb2gwbGdQWFNOYk8xaUxGTDB0aUpmYkV3Y2M3QXVFZ1V3VjM4?=
 =?utf-8?B?SHRaSmZkK2IyQTE0aVRnMmlBb3lUZE1YeisvaDBNYkdJMGhDTGpxUldON3RT?=
 =?utf-8?B?S0JJLzhVbFd0TmRLNmJzUDFURmhVaWxZNHlsUEZUMnl5ZnZpQVZWQ2ZrVTdJ?=
 =?utf-8?B?NlZ2TURpd1JaMEw3MjVoQWlBd04rVjVHdmpBOUJCWS9RZS9nYnc0dllRMUlE?=
 =?utf-8?B?eXlvTWw0VjBEdzEzZWFLNEJ3SW8yTUxyeTF5V1hxRVRibGU2L2NTcklSc2JC?=
 =?utf-8?B?Z3pBMDduRjVkTzlmOHdSRktCcElNMmtLU01ld3F2SXJYRnNuSDZ3eG9UanNl?=
 =?utf-8?B?STkzYjMyZGdGdUF4bXJsTTFmNzliZDVLZzJiL3lGTmVXRlVFMjNCMndEV3JO?=
 =?utf-8?B?NlZQb3IrSXpTRFVVTFUyVG1HMTJEYVovMXgwaXEyZWNVM09xRGdmM2VOVTAy?=
 =?utf-8?B?RS92SVVuUkJicXZmZVcwaFpQdTFKdEVPNmVydU5vTmVrSGthZ0dHdHNuS0Ni?=
 =?utf-8?B?OXY3WUxTbm5hNktwVDdMUHZ5MlNrckNpcFV0K2MxVFV2VWxwbVRGdG9XL0No?=
 =?utf-8?B?KzlwM2hRL3p2T2JQaXlKTEZoOURIOTNYQTBjS2ZrY3NOaGJTM1Q1V3pZUGhQ?=
 =?utf-8?B?K2ZDME5oV3lXMHlVb2VIUXRtV0tpNkRpaXhLQk14TXRVYS9QdHRBcVM3a1ZJ?=
 =?utf-8?B?bUhGV3Y4SmNOcVRDNXBUTEo0ZE9TVzlCa2lFeHkrQWYxc3BDelF1LyszeXN1?=
 =?utf-8?B?U1JnTFFDSWhJdjhad01xMVd4YjgweG9BbDdLbndLcmFCNFNVQzdYdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d06da8-300f-4d12-71b4-08de97be634f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 11:35:09.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4akCYRfiqoyd7wFd/yR0PI/2WnoNW6PdRg+Ax48o5vvj5jNBzp74LLtES8VRxMphEtfvbyOq+VPCfeaXq7xl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-19226-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 9DF4B3DF83D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 10/04/2026 4:53, Prathamesh Deshpande wrote:
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
> check against n_pins, and adding appropriate NULL guards.
>
> Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
> Suggested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
> v3:
> - Fix union corruption by using a local timestamp variable [Sashiko].
> - Validate pin index against n_pins with WARN_ON_ONCE [Carolina].
> - Remove redundant pin < 0 check and cleanup TODO comment.
> v2:
> - Zero-initialize ptp_event to prevent stack information leak [Sashiko].
> - Add bounds check for hardware pin index to prevent OOB access [Sashiko].
> - Add NULL guard for pin_config to handle initialization failures [Sashiko].
> - Add NULL check for clock->ptp as originally intended.
>
>   .../net/ethernet/mellanox/mlx5/core/lib/clock.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index bd4e042077af..674dd048a6b8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -1164,16 +1164,22 @@ static int mlx5_pps_event(struct notifier_block *nb,
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
> +	if (WARN_ON_ONCE(pin >= clock->ptp_info.n_pins))
> +		return NOTIFY_OK;


Sorry if my previous comment wasn't clear enough.


The firmware will never report a pin higher than n_pins, thats not the 
concern

here. if future hardware reports n_pins > 8, checking against n_pins 
would still

allow OOB access on those arrays. The check should compare against 
MAX_PIN_NUM

instead, since thats the actual hard limit of the driver's data 
structures. and if a new

device supports more than 8 pins, the WARN_ON_ONCE would let us know we need

to update the driver.


Thanks,

Carolina


