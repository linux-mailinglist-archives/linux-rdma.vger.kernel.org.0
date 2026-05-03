Return-Path: <linux-rdma+bounces-19877-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y/KONfsE92lGbQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19877-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 10:19:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E444B4DCE
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF5EB3003839
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054A3AC0D9;
	Sun,  3 May 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Am7r8izA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD1273D8D;
	Sun,  3 May 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777796344; cv=fail; b=ZfiBFH7AyQ9TykI0xOFhM7Ti5WfVd9vgMUefxWiLyOcMYyRUkwu2pcbbs/NcG7qILecAD+ehymY560W3Bc4d4l5cimg93MTCSHOYPuXtf5+4uX55W2NU8Gm7nWXY8gSJVIaQkXHJ+X8QNe3AbjQZ8IT3lVFOZrksU4v6y1353n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777796344; c=relaxed/simple;
	bh=86h8u6EewXQ9DmBeYWW86AmCHSpOzCovW5h89Wv+8sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SOwO8fE7H/FwfFF1JczEzXgiDXq1jp7O6KuQqI9JF/9rtA7OBqFcFRGlf2J8WhgDvWUqXOicXEv7oCyo9QuW0yC99D1KgHotrO+msRCBlj0v9OT9/vXlSCsL4QzwOvYZSKY4ATrFwaBnr1RdqBc13IKoPjG52TvNjPpomxB4Dk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Am7r8izA; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnzYQp6EXH3PJOjZwZBE33IozBgFTZtocRWva9+YvfuIA5WKSuAcWsuDpa+wpBmiiumWKDs8YMgsy4PoVH1uBJdVrtf2t24jUko6GBa4Ydxfkdw+9L/ANzhW5ai03Snm+7GlVG63RZNlUcb0Y0pKJpfzaoggUzzJsmcFf0Ux+pEXHX6hqFfe/TolV9ZXMRb4tbcriJc/LEsFLk7/9u0RRtl+W3MKenskNytRJ/KMRXQZLBNTrj/S0zUebnGb29gseI89hLR0OiFPltz4RJqjOafvS23KwQ8JpaVR1X8/kr2jUMsFhrQiz62VYridyPYAcC5YhtGS5NIZQAxrU8Nn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8k23iyQbptQycpxI+vEvceAcY7n15GWfHJpRWXwKOQ=;
 b=iDwZmKb1QMDs+5DEYLPXqA5aA2E/Zu/QcIpMlODkYrQVQslFiHFaruditFm6dGSuIcXEYKLSiZuC3+87Kk6mi5FhSGbJK9D3+VS7g8gIuWx7o24c1pu8qpELgxuj50ApjO7iYBQTk3NA8IsVCmvvkWoSamJuFYSY6NGVF6iQ4oClduB1x7FDHomg/vsO63cKFoWhFJtDZVLnvuyh/BzYM0bLbiJmsg+UBDDAu0SKaE+T8JjYLBkm+1oig+XyswwzkAV5PshFc1Ni98NMf7yslsq12CJkxt4ROA0uqkCV/hiqNbXVQz7rbche77N1tkQus1fUXg3RFGr7NDnrA2tXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8k23iyQbptQycpxI+vEvceAcY7n15GWfHJpRWXwKOQ=;
 b=Am7r8izA0pRS8Y99qjI3ym5wf3l1GSmGeL5RtKeuKs5LtS2LQe3Rx3Wh6AeHV9Dt8siF3ADlMGlViXam1fk6cL9X3Rj31ImbQZvYudg9nfLG2LLLJ/ASOh70F/atcas/HaAprXmfyWgJ+4Jmi4MT6IfldZ/c2EL0ifcZL7G7qTXDyDKugAuMmAx3tbNWjP4xBVmDIYEW5Wgxj6dUhkRjzgib8xBquua32HdnBhBPjPuIyIP93xYGVi8JdPRLWcHQwHPjsE8Xt8TxiSfTalCo290bWVn8Oj1cy/TANb3lMRXbXVFO6ZOZnNaGUpVIJ5ldZq1NPJjTATr05GYMsWmZxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sun, 3 May
 2026 08:18:58 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 08:18:58 +0000
Message-ID: <391365ee-df9a-43b6-b152-00e30ae695b1@nvidia.com>
Date: Sun, 3 May 2026 11:18:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: E-Switch, serialize representor
 lifecycle
To: Jakub Kicinski <kuba@kernel.org>, tariqt@nvidia.com
Cc: edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca, saeedm@nvidia.com,
 shayd@nvidia.com, ohartoov@nvidia.com, edwards@nvidia.com,
 msanalla@nvidia.com, horms@kernel.org, gbayer@linux.ibm.com,
 moshe@nvidia.com, kees@kernel.org, phaddad@nvidia.com, parav@nvidia.com,
 cjubran@nvidia.com, cratiu@nvidia.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
References: <20260501041633.231662-5-tariqt@nvidia.com>
 <20260503014224.4096089-1-kuba@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260503014224.4096089-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d54142c-21c5-4917-560e-08dea8eca00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6jzv6xVLuW+t5xlYDyxTbwuZdpTUosRVwna9zpyOSGoHmXfKE4dNaVzUyS8EivWpA7Kk6u2O/mF4tmypR9LDVlKyV5+Fh2TNMTo+vwgd16Dr+w7b2zweYfCppv6e04Cu3KGvypOoHjc6Yr1K+AXb2RifzLG5XR8kEdnK/x3q7Ai2Z+MrmeWMTNfyrew39Hz5WwEliQHygssuxGO8QQhWq2aUy5/LzaORhAt08xRrjyc7uWJo3Kn5H0oN5r+9smKmKIh2j6Smuh65gO7e38LDnyKkmY9zjUlR8aWgeWu4Jb+cUbBwzaM4mDG8RiTRhzPyh41ZrGaDz98NBgJxmia3aXL5kwA2/YGgpUZjEksjhiuOenMlBXk5S8LXqf8PfIwDquAJlZDgxfLvDTU4rpmyKJgErm+E0a+UYZCDEj2+Y785AIlZglBPMxbbaTlesNxyzE7BrE37UJQlzOIeC1I5O9NoGi8p4d+m8S2dyEM2mvvOqYjbCjFIfIyJscZva7KJKA0A9sfYbtZt0ZOquJWjRpzyP8E/gKkb8nAf4lhMZr/mxA1Y+4NXQMAGC0AE1QTsdNuG9ZCpWN8fKM3Uh2pbDDCaOpcko/NA4VqBF7WphOtdVbBTAX1LTDutSZyRtBg/N7WlsTgNuWiKVdpWp5JS3yLD0lrt6nOLAgG6a6S3MQHiCrsJ3JLsFA3ZmMQ7VMTj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTk2OEd2Qmp0V2JYSjhETEhNZzF5cWpaUDJLUTBwSUNyMmV4aHZubFptZnM1?=
 =?utf-8?B?bTA4dVFOU1hLNEFLYU8vRHgzVEN4MThGKy9EMVU2VzBWSzVOR0lrUTlXUHlF?=
 =?utf-8?B?UHJoZ0Vqc1ZMRnc5VjZnNjBzUUhoQ0tYRzc0am9zczFkQWpDWkUycXk4RCsx?=
 =?utf-8?B?bXViZmZvUkUxU2hpakRQZTJyd2oxSzdxRk1oaG1XQVE4RlJMZlE0RkQ4YUVU?=
 =?utf-8?B?dnhQNkV1a0R0M3owRjU1UzB5Q0tpSjZyWlZIZ0tBdHhrdmZqY1VmbWdSbTNz?=
 =?utf-8?B?UkpTT0xTaFByVVI3TGFtY2RMVnIyeWt0V1p6NnFOU0xxS3IyNVlYWFpzVHBn?=
 =?utf-8?B?ZHQzZjNSVytsQVNuRGlGMmgxWUNUM3V4L2ZyU1BXV0lFeGFzY21LTDhGUndT?=
 =?utf-8?B?V0w3ZGZkZ1JpWmhMNy93OVcveGxkMDlZVDFSc3IxbW5UQ0VoUVMrMDduS3kv?=
 =?utf-8?B?S3M3NkIrd2lJekpaQzhiNWZ2MU1uY0E3dGgzSzc1RE1lVk1yTDhGOHZVcGhp?=
 =?utf-8?B?U01QZTZ0MEFqVkNEWUVOK1FTYVBLSFR1RWRvRU9jSlord09jS1BXY1IyaXJp?=
 =?utf-8?B?MEJKUjlPcEVEUTdJQ2JSMlgzOVphcUpGMy9PVnA2RjdmeWVWdlNIUWY2TlZ0?=
 =?utf-8?B?d2lwZTk3a25zNmdENmVJOVZMTU5IN01ScjJibVdaeURYdGIxM2RMTFZQMjVt?=
 =?utf-8?B?WHBEa2NqYVlxU0lsOFBWbGdIWGtrVDVCR01MVUk4Nyt0VVBQSE5IeFRNQ0Fp?=
 =?utf-8?B?MmI4Z09hZm85c0c0VXI3ZVFkZ01rKzQrWE1rQ1BKclFFMEdaNlNBUVhTQWhN?=
 =?utf-8?B?eXBjK1cwTUtDT0xhcEZ3VC9ZZnpvdFVCRkVGR29kMUtYMllxaDlSVnBIRFJi?=
 =?utf-8?B?cmVuemJPU3M3TXc5L0Ywcm5iQVVlbk0vTUJGaU9KUXFGWHFCR0IzZnluMzhP?=
 =?utf-8?B?ekZucWUxWXJJU04yNmZGVUM5bzBuOXIwVHVyV3RSQzE5elI0eS9uWElPdExp?=
 =?utf-8?B?OXVSWW9TMU5adXRHYklRU1g5dmJObExMUVRlMzdkNjRJQkxkM0lZcXR5c1do?=
 =?utf-8?B?L2x1VHdaeDZCK0VuZiswN0xWRnRzRjczTi83MzUzVzZBN0o0aVBpTFRHOHdr?=
 =?utf-8?B?UlBlN2dqRmR3dUovT0FrOVhpZXU5ZVlkMmhXQXZHbzI1ZHlIdFJualVoWkU0?=
 =?utf-8?B?dXE3OFdRT0lpekFOMTNpMEF6SlpNaVhIM1BCQXFXNVdHN2dmTDNGWnliTFpl?=
 =?utf-8?B?T29zcWFzemZPRi9ZSUt1YUNXRTIrUEhSbzh4QWgvaVE2aEhXOExIS1JLWjYx?=
 =?utf-8?B?YURzTDd2MjNXV2RDdXdMSDZYMWpUaHJGazdUelVodzdVaGZpUUlBNUd4SS9T?=
 =?utf-8?B?SHFxWVhGdmlqMUpnc2RtU05BTFFMcDc3L1cxSXdELzJOTytsOXp6Zy90MTN5?=
 =?utf-8?B?Ky9zRjhhOGw0c0lHVzJqMFRWQXh5cGIrOHhXaC9UU0J6VzhRTHE3dmNhSUJT?=
 =?utf-8?B?bHdkZ1ZxMDdoQ3NCOEo4dDRuTzdlQldBTXBNREZsMDc2NFMzSmJqUFUrQm9n?=
 =?utf-8?B?dHF3bHJSOStGV2kxQjgraHBORzczSWhMMFA1d0xpYXRDYnkzUENLOXB1c0N6?=
 =?utf-8?B?RnkwWUM5a2FHRDVqdmpkWFcrckIrSGR0K3lRV1JwaXZBOWpPeVZYWFBxOTJ1?=
 =?utf-8?B?QkNzd2tlUWFVRHVtRzBkMVNja0tkQXdjVDU2RHNaeGM2UjBjaHZaS3EvcGU2?=
 =?utf-8?B?OU4rNEJrMU1STGlXQUo0R20yeWhjY1VTWThYcGQ5alU2aGdmS0hBMEVOV1Iv?=
 =?utf-8?B?Zk9oQWtpWVN2Ym9YNDN6L2VCYkVTU3lEcGtQYWp2U0U1Rzd1MlVMOHFIdTFs?=
 =?utf-8?B?QU94dW1qU1lsbTc3V1pldHlHS0pPSXRXQ0pTUzZjcXd5MlVQWVE1TGhCUjhx?=
 =?utf-8?B?eG4wZzBqSDZ3RDJpTkROeGFBWFh0Qmw1a0VoSHUxbS9INHBPNWlRRUUyZjZX?=
 =?utf-8?B?UzMyemk3TDhMam02ZmtrbUFWM0RJR3JvYzduMHcwSzY4WXFmNkpFT0lUY0tO?=
 =?utf-8?B?WFIzV1BSd3kvNVBqTi9OSC9wSWwwNUxES0lRVURQbXlMbHFBSHZhUWdrQjF4?=
 =?utf-8?B?Sk9Ba1RKNkxlTU13ZGYzWmg3cVJBd3U3UTZSdHF3RGR5VjZSN1hYSG8xTGhE?=
 =?utf-8?B?TWVjT0hRKzcvUldoU2ozMzJYRWprV1ZnbHlPQ2xpMWQ2TXJ2Y1g5dk13Mmk0?=
 =?utf-8?B?cFFMOHVhZk1CVHU0Z3k2K3dYMFlma0FsdWEwVWtneUpMaTJGNy8zQUxiS3J6?=
 =?utf-8?B?bGVsS1JIZllKV21ielJSY2NtMDhtMjdGc2dSU0V0d0s5TVl0alJSZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d54142c-21c5-4917-560e-08dea8eca00e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 08:18:58.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rhZguzkzbjyIHpvoC2tQWYQlZzKwV2VnoQ3QiqfY0z/6EDIPCCPKx/L/GNk+V2QwHS0jz7IryAHeVkPiEzjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
X-Rspamd-Queue-Id: 96E444B4DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19877-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]



On 03/05/2026 4:42, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: E-Switch, serialize representor lifecycle
> 
> This change replaces the ad-hoc bit/wait-queue coordination of E-Switch
> representor lifecycle with the per-E-Switch reps_lock, adds nested
> wrappers for the shared-FDB master IB path, and clears the rep_ops
> pointer on unregister.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> index 66a773a99876..f70737437954 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> 
> [ ... ]
> 
>> @@ -1825,7 +1831,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
>>  
>>  	devl_assert_locked(priv_to_devlink(esw->dev));
>>  	mlx5_lag_disable_change(esw->dev);
>> +
>> +	mlx5_esw_reps_block(esw);
>>  	mlx5_eswitch_disable_locked(esw);
>> +	mlx5_esw_reps_unblock(esw);
>> +
>>  	esw->mode = MLX5_ESWITCH_LEGACY;
>>  	mlx5_lag_enable_change(esw->dev);
>>  }
> 
> The commit message says "Take the representor lock around the mode
> transition", but the assignment esw->mode = MLX5_ESWITCH_LEGACY happens
> here after reps_lock has been dropped.
> 
> Meanwhile mlx5_eswitch_unregister_vport_reps_blocked() now reads
> esw->mode under reps_lock to decide whether to call
> __unload_reps_all_vport():
> 
>     if (esw->mode == MLX5_ESWITCH_OFFLOADS)
>             __unload_reps_all_vport(esw, rep_type);
> 
> Should the mode store be moved inside the reps_block/reps_unblock
> region so the reader's assumption about stability under reps_lock
> holds?
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> index 6a5143b63dfd..d4ac07c995b9 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> 
> [ ... ]
> 
>> @@ -2425,21 +2436,22 @@ void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
>>  
>>  static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
>>  {
>> +	mlx5_esw_reps_unblock(esw);
>>  	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
>>  	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
>>  	    mlx5_core_mp_enabled(esw->dev)) {
>>  		esw->mode = mode;
>> -		mlx5_rescan_drivers_locked(esw->dev);
>> -		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
>> -		return;
>> +		goto out;
>>  	}
>>  
>>  	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>>  	mlx5_rescan_drivers_locked(esw->dev);
>>  	esw->mode = mode;
>>  	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>> +out:
>>  	mlx5_rescan_drivers_locked(esw->dev);
>>  	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
>> +	mlx5_esw_reps_block(esw);
>>  }
> 
> Both assignments to esw->mode in this function are reached after
> reps_lock has been dropped at the top of the function.
> 
> mlx5_rescan_drivers_locked() can invoke driver bind/unbind which routes
> through mlx5_eswitch_unregister_vport_reps(), and that path now takes
> reps_lock and reads esw->mode to decide whether to call
> __unload_reps_all_vport().
> 
> Can a rep-unregister that runs during the rescan observe a stale
> esw->mode here and make the wrong unload decision?
> 
> [ ... ]
> 
>> @@ -4496,9 +4524,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
> 
> [ ... ]
> 
>> @@ -4525,9 +4585,35 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
>>  
>>  	mlx5_esw_for_each_rep(esw, i, rep)
>>  		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
>> +
>> +	esw->offloads.rep_ops[rep_type] = NULL;
>> +}
> 
> This new NULL store on unregister appears to introduce a concurrent
> NULL dereference in readers that do not hold reps_lock. Before this
> patch, rep_ops[rep_type] was set once at register and never cleared,
> so a REP_LOADED state check was sufficient to know the pointer was
> valid.
> 
> mlx5_eswitch_get_proto_dev() is one such reader:
> 
>     rep = mlx5_eswitch_get_rep(esw, vport);
>     if (atomic_read(&rep->rep_data[rep_type].state) == REP_LOADED &&
>         esw->offloads.rep_ops[rep_type]->get_proto_dev)
>             return esw->offloads.rep_ops[rep_type]->get_proto_dev(rep);
> 
> The state check and each pointer load here are independent reads. Can
> a concurrent unregister on another CPU run between the state load and
> the ->get_proto_dev dereference, transitioning the rep through
> REP_REGISTERED/REP_UNREGISTERED and then storing NULL into rep_ops,
> so the second load observes NULL?
> 
> mlx5_esw_offloads_rep_event_unpair() and mlx5_esw_offloads_pair() have
> the same shape:
> 
>     ops = esw->offloads.rep_ops[rep_type];
>     if (atomic_read(&rep->rep_data[rep_type].state) == REP_LOADED &&
>         ops->event)
>             ops->event(esw, rep, ...);
> 
> Neither path holds reps_lock; they run from the devcom PAIR/UNPAIR
> event handler. Can ops be NULL here once an unregister has cleared
> rep_ops?
> 
> If readers are expected to be safe, should they either take reps_lock,
> be converted to RCU, or skip the NULL clear on unregister?
> 
> [ ... ]

Good point. The unregister path should not key the unload decision off
esw->mode. esw->mode is not the lifetime predicate for representor ops,
especially because mode transitions intentionally drop reps_lock around
auxiliary bus rescans. The actual invariant we need is that unregister
unloads any currently loaded reps before the ops pointer can be cleared
or the ops owner can go away.

I will change mlx5_eswitch_unregister_vport_reps_blocked() to always
call __unload_reps_all_vport(). That helper is already state-gated,
so this is a no-op when no reps are loaded.

With that change, the lockless readers do not get a new live
rep_ops == NULL window. unregister first synchronously unloads the
loaded reps, and those unload callbacks tear down the representor-owned
contexts that can call get_proto_dev() / rep events. Clearing rep_op
after that removes a stale pointer keeping it would be wrong because
the ops memory may be going away.

Mark


