Return-Path: <linux-rdma+bounces-19169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOG7F7S012lURwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:16:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E4F3CBDD9
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C774A3004242
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A733BBA1F;
	Thu,  9 Apr 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwzwcFSg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775027FD4F;
	Thu,  9 Apr 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744177; cv=fail; b=XiYyc7u5BRiNdO4gxX56peZvCR5tOJ0c3iXRfCEgjZ7Y2x4nY7LohbS1fyzt4w09eeZVXghWE6W4AAusSGO0Y9WLfe7z+VvE0an+f+Wxhyyy2XaofApWHBjKSSbJPU/iySwp5BpHQq5J222FQoB9YsuS3OH3SocJU/ckAOnpRkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744177; c=relaxed/simple;
	bh=uoGwfb3Olu3/tpldeEaAh0TGLMltl14RHOToYGPvNds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMlVOGejUXZFcUMg15Uq0Ec33rWok8ShWYUyeGQKt0RnKeF99D8kWiRxW3XHfQwjs/hSAnvKO3Ol7whSyAS3BXURICHMG888kICM0ax4pKt5+of1Sj4o05mlEW27h+n8QDjoAWz0p/FKc4fOLdGbREiwXhG6/veO16hS7FC9dHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwzwcFSg; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCLPB3HM5RAbT9qynjQDIMtF8l2DpBs/i/t9qnpn+kpZuXxgUMgnJR5a0AL8iJ4mM1/SXHKD/fVbe5Wqs7diK0IUcm9PNh1DOAXAP6OlEDMQJEDkNeyKshkPvNDFCZLqeUNzCY+bPjrh3NaPcvzKTjxmtQngdJl1uaKdVtBexU+POWnsBdnUzYTfiZqebzWeOEw0OlVCMeCZbxjyXy8B6td1OqYOopmLxvno8y8pR/KXAFbHf7WeTGUwifObQS8djEb9yEywGccRnxSsVqo6ZqNKSy83CeUAAPuw9cn19q5teW8f5MP93uTcr1y2d7+wp1UPqpWYd/V+neyp3vW0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/31Nlq57GVbpejc2hpYVa8BiPlzV1+DLwd2VwIfuhmo=;
 b=xZL9GM9IG8Rmgq244l7gnUcvNBxgC+XK35Zlqd/Q/Y67MioWptnIl70h4FQJx/hhf40mHeuAEeOAOtq7TuqVM1QrwIebMjzxEy2t1OCGmCmg8yz7k2Ww/PD1GSBfM9MqVNTO2shj42iYjNVEvK7Fc8XJ2OxwuJ4OoCsOLRW2FpOu3csDhuF8IivqKPCwvFfv+8Gm9t4dUli3WJk5lFKGz0gMPQvZdZHcJGYVyLRbkjRJFnUROsWLwEYcsi5KvgvxkQa5Ooszk4iP3mOlLRIR7QXH/12uaW6BBH/UozC4tjNVQPyNIqlRBGLzJTj5oJVhva546A0m0KRR1lIFeZuTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/31Nlq57GVbpejc2hpYVa8BiPlzV1+DLwd2VwIfuhmo=;
 b=UwzwcFSgaLHdEqvLJt9fCOrZkxM/hH6HTs8D8l0MysAh3T4w9lZ2Em6lDa79gR2ZDunHA7U9uovaATGXqheCNQxBYeovUnEgmFjvs9gJCXuxVjawwKVQESRXs685owSm19aNmcQRYQwZ2Jk4rlZlRyBbgflx8JsiEJpCf61gXaJ9HPEVVjxonUwmu7Ka3B1e7ZIHJAsfjlg1oYhh0AtooEq3kZ/fFmQ4S1QFoWDo9pj1WADzF0xbRznFTrFlneC9jZnoIcl1c+mTEWS0CBJWPGF5GI19RPvNRE9OovPtngBVUxAbqMq/jZ83+qTMvl2KJ1acmdkSjhS2DSeCYnqLcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:16:06 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 14:16:06 +0000
Message-ID: <3a238d0c-4ec1-432d-995a-19d7db3e310e@nvidia.com>
Date: Thu, 9 Apr 2026 17:16:01 +0300
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c55605c-5889-4d86-aecb-08de96428a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ogdv/0a4sNy6EejGpK9k34HQD2OTZ8v/B+sqy7IxHiObhIuN5v4SRWElVspi0BDLjRSGviyWXB6Q4GzcIP890vYPQcVYo7m8SbZhlG4a8HPR9BLptEi1ytn7kz58904EkQPs1ZbKfpfUxAjGiqVVnngA/HqahKds+ZM5Kv35G4l9nMShvefOmbDz882LGnnoMZU3q9unZG3ahdWI/B61TLi6GNtJGr2Kt7/Sx3GHluIBg85LkMV/xhQjfstB+0zWzt++OCNTyV3XhzyJ0xZqIVifGSqFJq1qCoO/7vzFbCwKQiIiSB/PPIfuIKVo+GNlcGZ2GQUeDXp/ffvAIvZrT+fqyln1owBlFtQAbNBQKpXvVzcIioxzUHJPVSXI3/BjKbrzsK8Qc+ZSbPQkOiT4m7/qolHPuOF+Q5sGBeKa3cBHdI5N7TUJj8dRQV7U1BhgdgXD3Mq0L/tFpwqj5JfqJC6H4dt5rNZuh/0044Hjqi35FCJBemhXgkui3b1gBYR+tdZRTSdyt7jZH66rwCmjpCyz1otCi3FINAJS8nXMnfNRgLJlhj104dTkUH8mEtw7letaLp32ROK2nztIjjQ15tnsLLgmJmABtUF/G7+0o+2Yjlq3L3Nume9DnAoZbwpw67NWe4fc1Ul5xr+Eb5nEwNrkT41cv1Lr5NO4Ib6fvr1w5vtQeCp5dSXeQodOWtS1hPzMzbXLlhlXstUN/AZ+Le1buiSdnnBWl1ajUXGYLkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm5LcjZzNU52L1hFeWdPOUlFUFg3U2tEYmZiS0h1SG80SnphU050USthK2N1?=
 =?utf-8?B?QXpmQkRTSzdkcmxneHhzbTA0aW92L3FhT1FCVmR3MXpud2gwekdkcnl6TElx?=
 =?utf-8?B?V2tPVzVwKzhaMWVLT2dTVmwvTkJldEZNbUZpd2hBOVZvYkhwRkpxcmdIUTdJ?=
 =?utf-8?B?M3Fzejc3eFVPNEwzdEROVGhqUElqckF4RkpMaWJzanJic3M3dXo4OUQ4R3Y0?=
 =?utf-8?B?RVVLd2oybHU3N09RUFJzMDY5YTFpUFFiSXNZSU9sczh4cjIzcUVOdzJPRXpm?=
 =?utf-8?B?VVNNUUloZTB2MXVBenMxRng3K0x2UVJuSk5ZN1M0OVk5KytQZElVWkZvRjZE?=
 =?utf-8?B?aFIrTis5VGdjVmNEZWN2dEJJUy8zaHpGSTlhZllSUm1nUlE3MmVMYllQUXhU?=
 =?utf-8?B?K3AvMGI4djlNdHQ2UDhwNTl5N2RuajFCTzFUMzJPYzBqZlZTbW8yT1JhQ1F0?=
 =?utf-8?B?WWZjRGJrTXMwVWoxa05VUy9mZG1Qb1dVRU9zRnBnVFZWZm1rSWkwL0l4WmpM?=
 =?utf-8?B?TGJpTk1nRUdHMUptR2xGYW1kcTFaU0g5cXltRjFmbGFUbGI0ZTZiWEpyT0R6?=
 =?utf-8?B?Y2NvUVJZc2c3WUNENjJ5VmFXc1hoMnZqWVloM25aRDF0Rk5IMFlqUUdFMGxZ?=
 =?utf-8?B?ejJmQzlHTjZJYkJ2NjZGNkN2elMxbk5NNXlxVCtnNXJrdHI1UkZ0cVlHTnZs?=
 =?utf-8?B?ZkxaMlBIRlFYQ2dncEVKOFg2MnkzNnRJQy8vMjdzb05rQnNFa1NTdk1PWWUx?=
 =?utf-8?B?eExZaVhBY0dzN254bzdQT2hDTlRIUXV0c1FtNytzemxhdXpLN2VNQktHMk5L?=
 =?utf-8?B?aHMvbEN6RkQ4VXVQQWg4WHE4ajR2TVZCcUVpc0pWdE85TzhDdnBPK3BPNWQv?=
 =?utf-8?B?QkR3N1ZkZEZIallZM245cXRGK3p5M1N4clVDUXlYSE9qaGVnbmxydGdSQ0or?=
 =?utf-8?B?R3RJRWovVnY0NElFbEFYZ0k1Uzc2RmlwRVN6anM5bXM2TkxxWGNZU1JzNmRk?=
 =?utf-8?B?NXdSaW9ray9NWHJCUVZ2ZytPMXJlRGlwV1lOUUNvbVVSTVJvWDliaXo4Uy9T?=
 =?utf-8?B?b2xqVXJKTDY2UjFhSUR3eG9HY2N2SnV3bjVSNTM2RDROUzk5LzZmY29lb0V0?=
 =?utf-8?B?TVlhUlQ0SGsrTk40WUR4RTJYZ2c2My9uRENOM3VySHdCN2NtVlNwVXRPN1pv?=
 =?utf-8?B?OCswcVN3d0RpL0I3OHFZSmgzbW14Z3pvZXlWVDJwb2JzV2dyYXI3bmZ4Ynp4?=
 =?utf-8?B?dzZjbGhwOXp0YVFHQWZ6a0d3YllCMEJiaUZ2cHlNaDI2THpNWXRtZ2Q5NW5n?=
 =?utf-8?B?V1pvdWhkcnVxV25zZGJabHdUNTZFRVZVdVNndU1JWmlPUVhwNGQ4TjN2VHhI?=
 =?utf-8?B?R3ErOGFPZ002NTlOTi9IK1ZyRmxHTHhnNHdQdFp2SG92RlQ4K0Ftc1NiQmxE?=
 =?utf-8?B?Rnd0N0dIYzFkSFVqc2l5YnBrYXhBUE9pRUN3bHlkQzVQUVpqYWx3WS9GQVBT?=
 =?utf-8?B?RzJFOXd2L0JtT3FiT3oyTG81ZGxidExVTDU5aWw3cjZlZTlZUlFnM2Vkbm9w?=
 =?utf-8?B?TEJrYnZweTd1aDZ3algxRm0xcEQ4b0R6c2pYdmJoenpKV3ZMSHpjalBVbitI?=
 =?utf-8?B?d2xqY0NmZ1pPQU9kMkI2QytTRjlGZXl1VlFvYTdzYTl3bTQzRHZXd1ZRWE4r?=
 =?utf-8?B?K2VneUxUMWREaXhNL2diNStZSTBLTlczbjV3RlZJSGY1eU5VZ0RVUjd2YmtV?=
 =?utf-8?B?M1U1eEJZb3Nxc3RKeFlWZDdPMGhrKzRwK2RhNC81QVR0NEVrdmczMkhkbUlt?=
 =?utf-8?B?cDljTU9nZUlRbUgvQXZFd0lmMDYvNVVtOGVWVlY3S3ZneDRDUU5ERS93ZFpF?=
 =?utf-8?B?YjNDSE1QZnpIdCs3ZWFvYWxJbWJzMVdzTTE4YUFSd1lZVklHc3dQL3pWYmFo?=
 =?utf-8?B?TGo0S3hUcTJCWUhVMytYL2t2YXUwVldOb0JTQ3puZ3pNait0NFVHemc1dXB6?=
 =?utf-8?B?YkdXaC90NWpnZEJPWVJGZ3RJZllYK0hra3VTRVNWNUs1REh5dTErR2dRanNM?=
 =?utf-8?B?NkFSS3Q1RXZTL1BheUJudXpQNTMzNk5ncEpPYWY1WHV3OEVMbVJQQjZJOVQv?=
 =?utf-8?B?K0VPY3crbDlmRTF1WVpqRGpoditFRU1EK0pWVkp1enExamp2Um5iQmZIME41?=
 =?utf-8?B?c0pXREFVcGJlNjZRbm5IMG9FMk01ZzdGTnhvcVRid0FiOXBBWUxKTUZJc0Vj?=
 =?utf-8?B?RlJoUlNnNGc0RDJZRENWdVpkaDRSMnR0VnRJOFliakFoMlFidmtEanF1dEJ6?=
 =?utf-8?B?bFpodElxdGg4NFlwUGRqekQyeTBjY3pNWXRJbjhvTTFuekFKcjU0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c55605c-5889-4d86-aecb-08de96428a00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:16:06.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5rF0KsXYBCMChr5omy+NJ60FW2CF5a93Djl/3wWf81M/KdBRp2JLSaI0UdPqOiNh+luteJIwfsF28NSKyJelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19169-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4E4F3CBDD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prathamesh, thanks for the patch!

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

