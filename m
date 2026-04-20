Return-Path: <linux-rdma+bounces-19432-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LPQHk/P5WkfoQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19432-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 09:01:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD1427900
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 09:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A872F3008D11
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEF384222;
	Mon, 20 Apr 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WWtIjCBO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E343815DE;
	Mon, 20 Apr 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668255; cv=fail; b=uTpFylZy/RsZjYak9c6kVmuvrO8cSppNEEIgn/duWSWks4NP9nrX0i/9r8ORDrOwrqIkOjX1OiZsPHnfGqo/r6A3+Kv4Nb6icHWF87C8PppMmw/uJUlT9tUbM3U0nyOpJG7v7CpR4xZb/Lyv+q1TwvsKkbHdAmpNkQPf8VHz1a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668255; c=relaxed/simple;
	bh=5tFxZnVskgs2OXSfKhKqY6ICik10b6k7WeKcM9TMm7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d24pQ7fWq0fPDRfJaG49NpoEVktS+0N39YUKsWveOIkGgsUY1bsXpk8Us79PMMezqCD7nPzPH0ifIyBkk/Ti+Osz6AwsrsyrG0EQalqr6bMAQcuTs2th6AQ/zzO1ahyzaTjUf5ubloInugSxYsVms+xuR2gPDSF+S9HBmAynYuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WWtIjCBO; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8TXca2Dd3cVq7Ijl+015g3qfH/aiyaz/r9qASnsLsyZ35IhPMxWnZQ/z24xEcgnihEkYbl5YmRUmAa9vFX+ZhPjXdzRQ+pySfTGZDEXXiPxKCJ5V3BVweU9dRoZtZbz0pbnA4WClpxW0ys6lL/y+fmgAqZIKiYWyCmENA1zHFwgQIl4WmvTo6wW7H49BxDxy85IxS/E8upLdqsJlpkvpDE3jlzcjsGQJevXCMTWN3niBxhWRZIGdQY0bTNDVeqJA2086dxKqhCQlccvnrz93XQ936W1TFws6TsTuHFGx0q2PC8bcRQZ79/I6V+6GS0ZwD9dlroGsPGzmQ6sSm4KFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SRaLstPzYNTURgaduNFsluChC2rDTG0jYnPPt71Zdo=;
 b=e0wLD6sjh87SKimkjOy1p3DqAuSEJTjoahiD9OsrDJDuysrP6Bf4D8tcQvdJUMKGEfe5vgj6G05yFm5LlQW54j6P4pnxzM3aMJ+6CJcfQplM2IilrlHjicd83q7MV4Bhf5t3zmXbWD+cS6V+QF61hFPxlFqrlYTncH3zIi6V7y/0gPhnqNhakQV5pic6o0LrCUJIyACm2J//6u3bNXe998EV9zR/tvqy/wTDkYbyWNuuYrqT3qnuLAr/FFplR50oXpSEbO/kxN4saIbhmxxBSF7ZNbrF9aMKR7CR5c2UofSRai64Xm8YI/ttIUYAcUS04gEU/Bexi2zMVTAlLdKXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SRaLstPzYNTURgaduNFsluChC2rDTG0jYnPPt71Zdo=;
 b=WWtIjCBOIW+dj0E7P8afjg67Cv+zIom4zwr8/Je87l3l5EZRaGSRzlsNmVjWxjN3bWEwwGLzFhkufkOjtbfDsnIe+I4PdZd7AIX+QD2v9UC2+8us/PKX5Lg9DJ1ZQFXqjuJt3N3Xm/1bMTSe7Rg8NsXTp0LTKy3fM4W67bcNM7FQ7rPeb8S2KUKKeEiMST2YuGhTUQJTnEyfKRJ5WTkf7BXfv1MIHYI8fdM8iicmkzz/cETk9z0n+ixJMrxqEo8/ec01P0O2Jd2Aot/b+V9IuEqhEXYgBPki07hUpVdbvl6rBQwV82Ev7HM/5AqI6henNHjlmPiFXdjnnvlEHmW3sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 06:57:30 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9818.017; Mon, 20 Apr 2026
 06:57:29 +0000
Message-ID: <9be83ecf-e284-464d-87ea-c0df5501e69e@nvidia.com>
Date: Mon, 20 Apr 2026 09:57:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init
 failure
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fcf6f5-51fc-479b-d2d3-08de9eaa16a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eSnoVCwnn3rSYjDPvU7oOBLcr66iprS+XN9aKP12nKHO/ZnMo6wUA5SumzsJIv3S1NkVUI4z6D/tOpYnNqOo3KhX9GAr/txbWQI9JrjWz5bNGA1j5nDKHo0sCeDaE0QwRJEciTbJ9jRcgKNJ5NBxR06LytkU16I4ILyIGcN5yUkfGr9DjdD/56IDhfOnJvBjVero6iF7ZnMMlnkeLtIfeV6rAO4fblBNAP9UBaZ3yweAn8MA9PJDO+qsnDtrbzqQJhpuZ4gtn1T6gGpdzwGJHWbPb5x/XBqPKEyIa11Lu757aQ436vzmxLJuwHaDEdGWqt1B5gg9ETxOuQID0FgBq0BQJLmYzT/wt9Pze7n/2UTo0uuQVyVxjMc0K4oLlp6ttUO6g4vcXJzQpe0+b7I+6o3bxmWqWmh3uNRuGuuQdll1U3t5hpBKJSsNUPwBktPQY73j++H1KD5/IXYzwc1uuvrqk7FotcamleuedwaARFuuHZiXsAA1P7eiUtNeM2mlBTjV6SESHGqDxTFfKEQzNgiEeg+IWLTvs3D1BZ4nQRIHmqFvxlb6EONIFf3l4EXzT4EeQD8im3cMlCGW+Nus8OE7L3Cy0VYb1j9xVmnbYacZ9f2Axaqp1RdiOGrZvMceH4Gf78CA8GiOnmncigXfq7qMKYjefSWq/hP9d4x3EKd2JU0iOuCt8kHFhPt535mhs4ch5HsiUE8+CeB/EucckSAK+UxwMLrj5I1NlTwuYVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlE2angvVHNlZTFKdjZtOVNlUWoxNE8xdTlJcDVKZ1daN3hMQTZPV2h2eSts?=
 =?utf-8?B?MkEyd05ZYXVvaTkyN3RWcTd1U0ZCcUJ4S21MaXhPTjFTbkRmbWpYS1BPdXpW?=
 =?utf-8?B?WEVGczVBNTF6Lzh6Qno1T0FRM3EyNXNOb3FyRnFEVFRGaHRURkFBY1NyNzdI?=
 =?utf-8?B?alVMSC9xeWZBYTk5TzVwb0xOQkgzSnhwWndiNytNYzhoS1pLRHJWWndRWEZ0?=
 =?utf-8?B?RnBJZlRtN1orZExtQWFxRkxKS2VnRjByQ3RGczhrcWdhUTMxaHFLbHFWbWE1?=
 =?utf-8?B?VFgxa2pHcE5sczNIZEtpK0FXRGNXMTV3VmhFVCtteDhzcGZJK0pDRGRQWUwz?=
 =?utf-8?B?aHBUZklOaFMvalRIU0RKT0RVM0xnREFEeStOZTM3S3hjS3dMQk4xWDNZR1Bh?=
 =?utf-8?B?QjNWZlRiT1pvRXR1Z3JnZ1JDallqcmprSDRWTUlQUUxxQjhKVUtRS25haXFs?=
 =?utf-8?B?cWgxYlE1TFdXT25UbWpwUW00eDhvbXRDK01sU29IYmRuWkZJUHNmR0RPajNS?=
 =?utf-8?B?U1duZXUxTlpCRnQ3RTRNSzBCOUFBUUwwRzVKQTk0bEwxeTZXN0JaM3Ywc3Ro?=
 =?utf-8?B?TUJjQm91VG1hK2UrMGF4Q01qTmJISTJzRWRvRnlKME1WNGFseW1INDQ2UzRW?=
 =?utf-8?B?V01ia004Yk0wd29oTGQ3dDcxWFc2RXRLNEoyMTJIazFwMUZxWjdzcXlhZC9X?=
 =?utf-8?B?RFVUSW56Z0VRMjdvLzRpUm5idHBDbzAwTjVOVjg1NzVyUTgwMzdPdnVoeWxO?=
 =?utf-8?B?MFBVcXJ2Nm5hV3dLem5ZaHNRMGJXbzNjblJKOTFiQUVyRHNRMUw3cVNLdk0r?=
 =?utf-8?B?WHk1UEJiRFBvM05GNnJpRVRhbEJyak9ldlFidStFeFVCZ3Z0TkNKSDRNeHIz?=
 =?utf-8?B?Q3JtZkljdnVrdHV5N1VISzdBMDAvd2U3cFdscTdrRUxtOXVYT00xUXpRZFlI?=
 =?utf-8?B?MEVYR3orMVIwVGVNQVpzclMrWkt0aFAxeS93RDJXNWljRkJYZ2VHTGcrdGg1?=
 =?utf-8?B?OE1NcWk3cCtvTGJiOGdoUUx1ZFFKcDd5aFdScFNtWGhKOENLcUVOYStwK1RI?=
 =?utf-8?B?dTU1MmNCNWszVTU1S2RZSjBEVVpxbURxQS9hSmlwL3M4Z0kzNlpxWVNjSVpY?=
 =?utf-8?B?NlRKeE4vcnpyMmEvZ2J0N1FHN2t4Wk4rSjdobjh2UTZkK3RjMVFYdSt0YU9E?=
 =?utf-8?B?cjRNcWZuS2xoNndFSUU3TUo4UUtmU015anpkMEc5UG1SOEhKb25TN1oyRkRm?=
 =?utf-8?B?RGhsUUNBUDdhb240OFRyQS94V2ZmSXZFNThFdlJETE8wSlBvOUhIbE1MWk5Y?=
 =?utf-8?B?N1pzcXV3R05JbzJaYmpOUHFFVyt1Z3JaaTliN2xSNU1jbXB0cXNkUE56amU4?=
 =?utf-8?B?WnlkMm5yYTd2YjlaUkpDYlROdSt1aUEwbUJDenloejduMHBIN3ZlSWFSMGVH?=
 =?utf-8?B?aXZHWnRRZ2xJZkJab3dmRHZtL09jL1hORnVONXl3RElJVXNxT3ZxbnZxc1Q0?=
 =?utf-8?B?Njk4N2JFZ3ZsL2UvT1JFSW56NHVDK3VJMlp6cmt4bmdhaDVNZEI3cDc3ZmVJ?=
 =?utf-8?B?QlBqeWR3eThOWmpuam9OT0tCVkRnRml0NzY5d25aL3h1NTZSbU9Xc3lhMmpF?=
 =?utf-8?B?MlNqWmMwWkd1YUZPU2tVVXJ6THlMRG5BV3NOU0NTeFEzSlZBL0tpTndGQ2hn?=
 =?utf-8?B?QVZiZnhsVitTb1gyWlplZDhLNHlVMERaRTR2MEtabStOV0haQU5XYmk5Wmtn?=
 =?utf-8?B?WjdiWjJ0YitodHlBVVBhM1dJUFcrd0JialVJNWFlRnk4ajBtYksvV3NEcGtN?=
 =?utf-8?B?Y0FqMVU5eDFSOGcrLzVuU1U2S2F2T0pteXVqc0NBSW80c1hDcG5WRUk3N29n?=
 =?utf-8?B?V2NnMzZmVkVnb3M1OHFuZXduV2E5bEpueTZsb3pmbW5QTEZRNEQzZUFrdTA1?=
 =?utf-8?B?RFFYSnpzb0pDbzRoZUdPZ09Va2lqRG5VNWcxQnp1c3Nab1h2b0VTYnVhL0dY?=
 =?utf-8?B?a0VhTDNpbzNacDhZTUFaTlR1UC9NU3lTMzhxdmN2RXMzNWZqYnAwb0xxbWFm?=
 =?utf-8?B?RkpJRjNINTZQOEZMdmgvblpHcHNTaWxqeW56SHRpQlNsWXdxV3hVUGV4WG9h?=
 =?utf-8?B?RUJDWkNiMlZVUTM4emxiN3poaENlcGxIakFyakgvSkdxOHMyakF0UUVCbjFk?=
 =?utf-8?B?UERNZDloREJNNUVwSlF1YmhOT082Y3AzMHRKSkJrZlN4UlV6QzB2RjU0czdz?=
 =?utf-8?B?U3VSb3ZpVWo2bWJSYnM2L05QYWFxNG5Uc05NWnJ5RHlSM3hIK3RqRExmNDRl?=
 =?utf-8?Q?lUnSTQS8ynsWhdi8Mc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fcf6f5-51fc-479b-d2d3-08de9eaa16a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:57:29.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS8WUSuk5rOsyMe+kJfQTWXP7aDTCRz/38oeBFgF0zEWans1iNQp0JI/Ykpr3hPBf/OWx2AqmO0mCbATlioxig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19432-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2603:10b6:8:d1::12:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99BD1427900
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 15/04/2026 3:49, Prathamesh Deshpande wrote:
> mlx5_mdev_init() allocates HCA caps via mlx5_hca_caps_alloc() before
> calling mlx5_notifiers_init(). If notifier initialization fails, the
> error path jumps to err_hca_caps and skips mlx5_hca_caps_free(), leaking
> allocated caps.
> 
> Add a dedicated unwind label for notifier-init failure that frees HCA
> caps before continuing the existing cleanup sequence.
> 
> Fixes: b6b03097f982 ("net/mlx5: Initialize events outside devlink lock")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 3f73d9b1115d..fab80c79ff07 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1907,7 +1907,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
>   
>   	err = mlx5_notifiers_init(dev);
>   	if (err)
> -		goto err_hca_caps;
> +		goto err_notifiers_init;
>   
>   	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
>   	 * unique id per function which uses mlx5_core.
> @@ -1923,6 +1923,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
>   
>   	return 0;
>   
> +err_notifiers_init:
> +	mlx5_hca_caps_free(dev);
>   err_hca_caps:
>   	mlx5_adev_cleanup(dev);
>   err_adev_init:

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks.

