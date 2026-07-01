Return-Path: <linux-rdma+bounces-22651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zMNwGPIbRWqh7AoAu9opvQ
	(envelope-from <linux-rdma+bounces-22651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:53:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1B6EE660
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dd6JwEce;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22651-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22651-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2289831C7828
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441EE48A2BD;
	Wed,  1 Jul 2026 13:14:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707B3C553A;
	Wed,  1 Jul 2026 13:14:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911697; cv=fail; b=chkrEl3D3oa0cWr33xUkGf4D2eSRsn0x+jnw/kqoyI9Cdv1jfE+KEw+aWwwyLI1bXK2yetcWex6waJkMtbeTCkPHRpv+XBl+nr2aXLbaxXc48h9b7z7SekIEDavf4YQjylqWd29r0YaVv3g/aLfaCdbDSF80q/BRcmo4tWuzQfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911697; c=relaxed/simple;
	bh=E8ROv0SwZ/SauPEh9ziChlsHOUZOJpsOCoixjrU92lg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XI4bKEljHMlGuoledQ4Xt3vboLodHuQPk3SWYtBxz/EiTE7iqhpehdW3obVFu7nd8rDbZZrtWH7B3WtzF9rncUKDr4gVfB/JXmGKSx5vwpIbjYKPwzrwDmflCoijZoxgNLIioSEk2tq/jRVkC0bosIwQBz57Ktx0pJh8UaF1LN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dd6JwEce; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU4LBw14o89OVe956biWf4i0oNvCno2PGBOxtigkOQTGtlV6yTgHHotffOQIApUUHGj5EDiBRhc+HxvPEU03DD/+B8wv+BGzORE6EN8mGDFaG6qttM6Zhq42tLdgY4xADkXURftHZwvwSxAybgmFxnzgnVf+ZmkMVNxdPrMHwsBUlAXf+4yIxafS/6nQs38aUBryamppwJ6iv5lvyHYS+jeNQ9LIzIBMopxL6+BIKLTu86zykArS9xQk9LiMC7GcCHCBoDRaTVSxlg1JpCYQEWjbuRkjDv/evWMB/flTZFgCuNILhvtn4tV4zxKC5EUoWAnq/XTXhyTibjwirMWuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14FO0Bknk1VRFLR9Kwerhg6asx7NbK4J027Fp2RlTC8=;
 b=Y41B3lnZXlKBD88lWLpufHNH6ipLwewpGgrJOiRNMmOtOm2DpK2AefzrO0afdvM7vzGGoiW3p9RKolKdc250yRjsIHWZBwyDt7qbfChiqx7BXDRTwpvuG04542H5PYSXSv9twXN4+OS344dBGnKgvCWxU9uBsbcCNWsId3z+h9ipcS0Q6/VhtOc49LPwE5zRGgtyJ6PsYy5RuB2S/llwFDx+ck0dhteC9ERQoYbjwZS0PFt11QPicYvDZeDI0VUN1qLUOfsCSHtgNgVtr9TQhVKdGSg5r/SbNAEa58ydhrgMDqaugnns8tU9BpdlQpk1q6pxXzzyW9WoQn+9khd/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14FO0Bknk1VRFLR9Kwerhg6asx7NbK4J027Fp2RlTC8=;
 b=dd6JwEce6u+SX47jB+jfM+9Dvo4OOdolRKHIW4OQFf2L10kNVcDSsuasw/3DxMWg8co3NKNUjtO8QxsYmar0+ksnzXe7NQQcDiBl44Xp2x0d8R0+gOBTnlUPpEphA+8Sn38XB2JyRn6fAsrKRCSO8GBC33uUHHtpazJXXlNBXDFHqBeJxy6Uc00HiNhoVAUGao4dNNWzjA4Zs7qNw4jRsgYt5QUBUKR6sPjEqNENlX/OUlcHADM8VCWZYu/BPt1ZTu2XSN0Kbc39VRAIPs1DCUdDoVGVvEH23DCJCtxFqomAa2OORvwHI5815TD6cObscoOGZIlcK0kQhcxISveVsw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 13:14:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:14:42 +0000
Message-ID: <861b3140-4174-46d4-9fdc-d3b90104410f@nvidia.com>
Date: Wed, 1 Jul 2026 16:14:39 +0300
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
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: de675724-91b8-4aa1-4d5e-08ded772b6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|6133799003|22082099003|4143699003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	12EDdz6bO6JNG/5Wv3YfLgftLehJBJDP/Rc5YxmjZXaXO9no+erFkOttAr3RuMUGXT17hdlA/st5J1+IoNvsJ3K100pudDnZ7hqHyzp15RTEOktkcFvjvAsFoKFdkpOiEzdV98usuJB1T1y4ApfE6zaIGO4TF88hqsV8aBHiEsRYOgOEVf8R6UTfI1DvXzPNkjlXksJCmWcJyGIsi0Rc5ibOpzrfUP5bXNjUeGwExiNzLHnviaskUk/h9cQhBKZizX+EaE960vliIzbpr4mlNV/lZd1l0hUVsHwRr/Bp4Z+h5TXTB8M3ru7u0OnxSw03oF1Pjy7ArbBUnegUr3OPrY8vK0t+POb5xP7e0gwQF/i5IXR+f7w9eBgH/8JXXTo0mBSnFk8yhnHLR1mqQyNIVVkAgga7tMUr5FwGkJV1eQdv/qvH+W35n5UeRS0zWJyO/67S7n/rTHYFnpp09g6DaX5LJeok0ONKX3sYMgfFp7/fd68kzzD6qIFrNaknlfE0eK7TfBugJyTEvASGabZjaPv397zYi4HcftZ46ceEC9c6t4Dp4bJLsM/AV0Srop2+42IBKMNNSj9BgRL1JglnCQisoFu3Pl+65yDGtKj9fYR/mGPS4G+IFMrrg8lh74D7Irf8LZ6N6Fa3kGM2AptSnAv4JvT9lmXgIrgg6rMUYBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(6133799003)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEYwUUYxbFJJSi9pQlR2ZHVlV2R5Z2VOOW9DeC9WNm1zc1k1UitvQjNSWGxS?=
 =?utf-8?B?S0E4QzkvWFBUeitFZGRGelVhZG1uM3Bvd2FYZXpZTHh0aWxPb0owNW92OUZz?=
 =?utf-8?B?bkJwQXFkOExBbndSbkVZaFFOdjJJaDlWeGFFMjNmcE5GNld1enpmNFdWT3VF?=
 =?utf-8?B?cmVOcUhLL1dwVGVMUGl1YmpNTUVQWkRhRWw0bXlxaU1NTnBiSHJmWE9NQnli?=
 =?utf-8?B?WWg0SGVZYzVJRjg5WUd5S0ZObklFSFRCOHVPaE9FQkM5aTYrNDdwYVg0bjdo?=
 =?utf-8?B?dCtXZ0Rxbmt5c2dBc2dDY2RQLytWTGZ6R1F2R0dSb3JsZWNpNjdYUXBlRmpo?=
 =?utf-8?B?YjBZRnBzVk9hWE9JNzRSclRFYmx3c1hoTUpDNjRFZlJwaU12UWphcGh6UGFP?=
 =?utf-8?B?b0prcHpEOGswbnBhVGhsSnFwVTNOSGZCeG5TcjNQMURnTnR1SVMzakx6M2lp?=
 =?utf-8?B?TWlTckJScG8weXNGY29iMzVyMzV4SVZzZG5LOXJXalMrSWRwNWoyOGJSSFQy?=
 =?utf-8?B?bWJPU1Zha3pPc0owOCtkeWRSdHBhSmNWYXVXNDgyUVBCRS9sdGxsWUJJYnNL?=
 =?utf-8?B?NWFseVErMGNGeXFWOXNWNlRBZjR2OCtVK0VISTJQdXBkWHBjMW03MDNaSDRt?=
 =?utf-8?B?dkxpQ2s4N3NSM1JVc1FmVWx2SkFnZUlyN0t5R3NqeEEyTjZqdm5rcUtFMUxh?=
 =?utf-8?B?WmZ3V3doMFpSTTZHeDN0MXJoQTJVbFlwdTlIZC9jOHJGZDBPQUZRMzdJdkp5?=
 =?utf-8?B?NTlZalUvVFR3dFh3Mm1jYXovWm9BWEZpQVpzQ2RZblJsLzBjbENVd3NxY1hH?=
 =?utf-8?B?c042K0JVeEN0WThKOGtxb2MwdEdMaXZDbUdGcEtUbFlVOTY1NmV2NHlnY0U0?=
 =?utf-8?B?UUxhZU1zMGdreW9KLzgrL2g0MEZYekg4Y3dneGdLS2hkVFQwM2xlQUVwM01w?=
 =?utf-8?B?cnNnY3VKYkI2enJYakY4d1ZmQlpFeWRXS2RyRnEzTmVsd0FxR1JONTBXdENI?=
 =?utf-8?B?QkY2bS9iUUQzY1N0dGxHMGZuaDlGT0VPQUlzR1duTnZIT1A5a1Ixc1h4YTlS?=
 =?utf-8?B?T0x5OWIwdkpmS1VaR3FxQms3VGpBQmxnMHlIekd3ZDRMNVVwOTdYWVVEaFZn?=
 =?utf-8?B?eGVRQzFkM2lNcjBwNTdWMHBEejR1NVJhSExBMmt2NlI3U0VFYURreW9pa2RW?=
 =?utf-8?B?a2EyMk9TWUZqeUFITjMzQk5oa0VTTlhMcEpUeEhYQ0gvWDRZdmFoeTFYOTRQ?=
 =?utf-8?B?OFBOdFo1R0JKRzFqRFMyUzJaQ1lrelo3TmpSR3JBMTlBU01XYmZqa3hWSmVX?=
 =?utf-8?B?RzZ2a1NKeFZITURsZTBwb1VpV21aQkJ5M3RVNW9oL2x6eFhPUk5iUEcvY0pu?=
 =?utf-8?B?clFEcFM2SjhneUVkVVY5YTFnUERoWWNWek44bzFoamY2Z2pSNXhvcndtT1po?=
 =?utf-8?B?WmVCeWlvaWNERW9ObUZuakErQlMxVlFjdmV0UTdpcWdiQTFlZERKR3c4ZlQy?=
 =?utf-8?B?MXppeFhQSUY1TE5lNzUrUTh5Z1FoQkFZRWJXTzVQa05oWFFWY1F3SFdWMDg5?=
 =?utf-8?B?cmlVdHhVSlpGTkZOZFBPMjNvcFhna3JESXFxSi9sdjY2Y1pYdGMrSU1XRmpV?=
 =?utf-8?B?OTJoZDdWKzRNUTNYNlljTEUvRkxCWU5LcWRGQi82aGZLTlBGbWlQN0llUEla?=
 =?utf-8?B?QmlmNFdvdm9OaXI0dmJnNEw3TSsvc05rTDFsREZSRFlncDhwVGxYZDU0bzRN?=
 =?utf-8?B?MFhGdFI0bXJ2dURaTzZGWTdIWXZjY2dLUXlEeU43S2ZvdC9ZNjdqR1AvbjdT?=
 =?utf-8?B?RElndTFGeGVFaXJXRHRMdmN1R1lyckJYTGNaSDROZEVEVTFjQjNqK04zMWVY?=
 =?utf-8?B?THFOWU43OWZmbzZoUkJBQk1aTEJxNWxNMDVacGtGTEVoaERpRnk1U2hkaGlz?=
 =?utf-8?B?YnFkZTRaT0lrWUxIQUlKNHozUHZ5VkkxQnN6UGlCQldLZW45ZGpHaXpkcldr?=
 =?utf-8?B?TlljT1NxV0JUZEJoSEFUcTVHNWFzbkNiOTNiYmt4eTBDSEJrTHRmUEp6Zm1y?=
 =?utf-8?B?RGgrS3g5bTUxZmVJRStweHdHbjA5ZVJVUU51QWJXanVySEVDb3YwWTdDTXlM?=
 =?utf-8?B?NTF2RmNLSDNEZ1JhaUhaOGc0RVFzanhqV0RLS1ArdGhXcks5TlVsbkgzd2Vm?=
 =?utf-8?B?dW9TcTQ1Qkk2OG1ud1JNK1pleUM3Q1FFaFd2Yklrc2E1QXIyWGVHRDUxVUFh?=
 =?utf-8?B?T3h5am5wU1hwRlB2V29SMmVzemVnUStzbG01ZXcyd1dCZVdEMnh6TXRFR2xm?=
 =?utf-8?Q?XlCZs6EXhX8dpBOjyv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de675724-91b8-4aa1-4d5e-08ded772b6c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:14:42.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cZ3JdPY8IuSgEaZYYTCuRkJ6AtWpQ6fSWzKBEV9xEc3KduHCaf9shfk6qesno2ixTGtlzeP0tWtiWSC0pdneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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
	TAGGED_FROM(0.00)[bounces-22651-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B1B6EE660



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

sorry, totally missed some comments.

Wanted to keep this as simple as possible right now (the inital version was
too complex), we can always add it in the future.

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

Okay.

Mark

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


