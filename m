Return-Path: <linux-rdma+bounces-17795-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEkiEtvsrmkWKQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17795-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:52:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E33DB23C1F1
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F8930488C8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA53D6660;
	Mon,  9 Mar 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awfuF73w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889D2765ED;
	Mon,  9 Mar 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071295; cv=fail; b=hf5YypQUMBVhF4HW7jNllsVlUK5m6yanm2OfSRm9XO1iYcr/fn9j4yG2sRHUrdTrYCsK3F3L6OqZ+mjGft1kcJ1Mj+pjezsZTGW1I4nukLIZllJjamgATAuHKrr4//iX6psJWW0wYd/VRfbfSAMAvwJWZa9mG3kRkhuhUg1GOxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071295; c=relaxed/simple;
	bh=drYaf/bkP3hIvSj80gRQWh8qg9YStUVP3wgplR3z2YQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRKlrvVDE5Loo5Uj6T45FtASu2PaUds1WFS3W/5R9OY7y7Juc7p+CnV/pbP4xxjCyyITLwzH2U6lgnqrTKmruWdfybXFHwCdagv+7DgAxLPsZvLvFL8v3QGomGhFdNc8tDo9g0DVYlARKPmAglixB2Duz8Xaa4XGbbaZKs+Inwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awfuF73w; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc4bc2dhIcuXJUc1xB4zle+vNN+A9p9BqWIjXDRuPdZ4JPI4FFzM1a/hJxoCpPWuqtj/ijSFHLVyse8bYQzHMxjGtVSFYJlDCqDP4R3QqeMD7yz0iVAKxZ6FKG6fDkUaPF+1/Z+OEnNJWt0pto+Hj8uZAypXJBvz3uctdN7OtysphKhuObZ8M1rjPwj2Aly/ar18DYLqpEQpIYJglsDR6EAW69GMPbt2qHF5y4ui8Iu2D5mZS9M8EdtKCou2wB0rUt0M3eDECF3EVrgisTFgyKChIhn0DgD57aixPsWrDZ7E2Mk63Qbu4w5MZ+PP4IB1Y0uWs40yLZ7Wd23tr7fRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drYaf/bkP3hIvSj80gRQWh8qg9YStUVP3wgplR3z2YQ=;
 b=ByaV1LSkOkBrcMwJIw9zds9oGDY+n5Gk8dPOMaydIsbF/5N/5S3g2NzvXQr6KXBj6Xz7llE2XdrVGuLU5GPrw/1O6SapCSjizcDLJTccj5aclJxwgJx225ofZ4/dJnngR/PxiUaXTwoeCxVxjEqVGOQvcfamx6p/Rxu1TdfWehu1GZEEmdfKeE3XWoJjqasB2TU8iXQFd62gxKQ0GuQBcNC+hnhItx8L8bok2zl6lteD/T/NxNb2/NxCrIQBAMSPhfnqbOZSy2TeSsITO9dDWXsPN5MPeYOVIkze+cE/DhhS8SES/rVQl+YVqx5W4pX6MfPio3/JPsd9MwdeekQfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drYaf/bkP3hIvSj80gRQWh8qg9YStUVP3wgplR3z2YQ=;
 b=awfuF73wB9MH2NnBLslQoN+KfW9h7RTNpY0rXepcoJsPQQ8QC3PCCWcktl+dQFqlXKk95/FbMvlDe4xK7wDYcZyrOyiZa5IQx3aVmSCZoZOMXFgbE7nF4ubk4DgHGrvKOPtzGwwqlqkhFNl6VthcTXR4/usDJqkopmlVeVsGXsDLcsAfpnMJDjNaYoZbEiLkXsyC1sWzAXVpeuvX+t0qjJmCSE6iikzr7Ec+R25KV4/jMUNWjC9FqlSQaMH28SZpOkixeDUoUVXjvSKuF+KBTPXLNdOySQhuYswVxIyTpk168aab1HpFjtkMqrQzkfYblLmR8e+wwaCzRvSvbZD9sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 15:48:11 +0000
Received: from PH7PR12MB6835.namprd12.prod.outlook.com
 ([fe80::c1d1:1540:b713:5db9]) by PH7PR12MB6835.namprd12.prod.outlook.com
 ([fe80::c1d1:1540:b713:5db9%5]) with mapi id 15.20.9700.006; Mon, 9 Mar 2026
 15:48:10 +0000
Message-ID: <0260a707-8fc9-4921-9adb-7295108d9f2c@nvidia.com>
Date: Mon, 9 Mar 2026 17:48:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/4] Introduce FRMR pools
To: David Ahern <dsahern@gmail.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
 <8d4e0668-9f96-44fa-bfd5-898e6f5a2827@gmail.com>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <8d4e0668-9f96-44fa-bfd5-898e6f5a2827@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To PH7PR12MB6835.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6835:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: f82732c9-d5b9-4398-73ac-08de7df343f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	z2kxiP7fCegIA9pU0e1gO3PjPCozP7uqk8Ns6sr/2r3HGYTu3xQLfCeZO+X/5jQPqGN3fnv//Sh1w0YOHoiJAyRLZkhI6knPGrVgP3dkccBXxRhT+p19xfT8VrCS01cSKs2DRAteCeDroUIz2GrExLoiAiKZFor0de+wPCCY8hRw+8rDgICTDr7US9pwRiiuNOkZL5ia5mJMD2wHWs5Nu0xcDSx/NxzTvTzP2YDrYQJwCl/AGGcc7GNEwUlEJ59x5cqcbCKxMnMOXl7ttb9TsAykzqkGs4X3RSvVB3F9dWimZ04jAGQb0+GBYimjvdGxuADTa7okWBcyjY2ZdA/p8KRRK7be/cmCPL3Wpf8TUGSfnsg3/ZTSk3TNbGf6UNXXlsDE3w8PKL2yZX00DOl+5w5cNLfqiaTX5rGLqts7C9PbxlEfldgG+nk3FBpZMpq2X2e0Z48gq/8BeuWDv4X5hefz6JzTyINM3HS1shKHVmnN6mr+wqHY4W+MquPUt4ElV690XeLspQRuR1O+yY4e/hrjExzrjQIMPHpZEa2ogrZKBw9WJbc73AB+JRSfdY2K4dHpSxBXfeVGvEs/PPKafd5tzEHRKyVdXACFmzKIbOORFe0wO/NYOPYiXLVcTmihImF+SJW1l+O0HgEh7hQUlweQU88cBTp21Lry50KXOcIrO3vbOXyElnye79U53kL9mLRyMz/JEU+i/3k9uze+A6hQnA7ua3ICC16pJ1LuECI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZhd1NZeTJsZ2lIZFp5SHQreElORFBETDV6MVNUL2RzSTk3bmpyNWpaMnU5?=
 =?utf-8?B?MUMxeVlMZHczS3pTekF3cWpBcm1jbm85WEFFWm4vZm53UnpqRUMwNTZzdEFJ?=
 =?utf-8?B?d0U3L3dkMVE1TUtHbFlDd2dKM2lFOXJEeENWSVg1NjFCV1dxT0JhVUxGNHRM?=
 =?utf-8?B?dEN6RVRlRVYrVlZCS3NOVktJOEFnY0N2V1hjOXdYUGhWbC9SRFJXT09YL01W?=
 =?utf-8?B?a0dUMGNmWUtjbDMxcHpoNUFPcEdjdXBmZFVrMTRoeVFDaThyRE16aW5Eb3Vq?=
 =?utf-8?B?SVNlZjVWMEpibE9oVXhjV1pGVlNYMEQwLytpUmVqMmsrSWRzdlptejZwTjNR?=
 =?utf-8?B?TEhmd0dUQzB2Umw0L0JOdC90U0hrVGlPRFFQOTFkZkltVlg3YzZxRmtQeW05?=
 =?utf-8?B?Sng1b1hVWXU5cjFJK2p6MkhOWmtoWFVSOUNHZ0pPWks0QnI4Z3FnKzBJbnEy?=
 =?utf-8?B?dlE0cGVpcGx6Y240NzgwZ1BacUFhWVRwd01nYS9tZVNaRWNVaDBTaEM2U1M2?=
 =?utf-8?B?RzhvL2twUW1OVkZoOXFId0RoM2FicUJaYlZhK0lwbm9LSllmczc4V3lSc0pB?=
 =?utf-8?B?TjVzRU5UalMvM1M4d05hSmhXdUp4cHdqeFdHR2lFWi9wZlRRbytjNFd1ZW5u?=
 =?utf-8?B?NHY0ZDlZTFFmUTBOV0JaOXJwODQzbzdJRmdSZnNBNURUMzFjMVRnMVYyRWx5?=
 =?utf-8?B?USt5ZEJZeUF4L0hRdUxGcGMwZEhDaU14WkN5Q1JUTW8vMEdDNzYwTmJqUjdN?=
 =?utf-8?B?WDYzdkliQzlTejhXbG1OR3J3RWhON1J5YzU3NmVxL3daZklFYjRoTVZVUnBx?=
 =?utf-8?B?dzFzWXh5bDNxUlJ6dXJYOFg2S0g3cldDQjcrV0JLYkI1ZFp2eEt3VXVoRVI0?=
 =?utf-8?B?WEgrSGg0QmRaNDlIL2RSM000UWV1MHFjVU4ySG5ZbEY2WHZCUjB0WE8zaWZQ?=
 =?utf-8?B?NzNPV052Nk5EcitIUThmT0o0aE5HdFR6K0drZWoybnhWbUprVTMvNXZVVUtK?=
 =?utf-8?B?dDc1N2lrbERxWFpnMTNHSlRHeFZuaW90MnV5QVRLNng3UGc2Y3kweWdSeWtV?=
 =?utf-8?B?NTJkQU8waGlLd2NLWDJNeHJ2VUgyN20xMFd2dDZwUzl4SWI5VTJUNEJkTmZz?=
 =?utf-8?B?UGNlNFdxa3Z4U3lCUmRyNVBmSGg4d3RPTWs0YUwrT3ExNGIvN0hFZ3NjNE5n?=
 =?utf-8?B?K1BkVFAwTXRMaENUWE1HVlltZ2ZSYVpBZW1mY2w3eHpTd0xwYXhZa1BBT09J?=
 =?utf-8?B?ZytCRjZEU3ZmaXlabHJBZG1yY3RhTFJIcDN2UmRXNVJtZHhlSzVRRFVrU0VD?=
 =?utf-8?B?RDAyN1pNdjJjektHcFBnK01jOGpVUndSZDVSTTJhU0pIZ0txVmpJTDAveVQv?=
 =?utf-8?B?MlJaREZkZWdYMWxraVRITGhJM2FGMWFBdXFnWTkzNEEyblZEY2F3NDVNd25o?=
 =?utf-8?B?czkyU0tobjRDN0NuY1VHMWRYZDh5MjJ3L00wZEU0WWZQUjVsZytBdk9zbDdo?=
 =?utf-8?B?YTA2ZjVmbzBHMUQyTkVvN3BuNWZ4QVpoRkZXNDFFVFkzTVZYSkRES0lYaGNW?=
 =?utf-8?B?OVZZbVZQL250ZGRnSFJrYjV4N3FzN2Y3TDAvWEZvbEZvVyt6M05wS1o3S1BO?=
 =?utf-8?B?cTdqQ0djTUI5QWUySm1MV1Q4cEF0cEVRZis5VENienlGNHRCR0dIczdvQlJ3?=
 =?utf-8?B?L0FjbVBnaXg1c0FyR0dQcElZOTlxdTkveWhreWgvb2FPZ01lMzR4QWRJVGFL?=
 =?utf-8?B?YUR5ZkZSdldkcitmeDlhT1FGU0YrS2pkQ1luYUY1SVFXekV0UklGTUlTMzgy?=
 =?utf-8?B?cDlYWWJPK0U1YzF3OGk2Yjg5Q24zSDRBRnBPMXkyanlpZUdqV0RpZEw3Wm1F?=
 =?utf-8?B?Q3czMHNscEs1SnhiWkY4QnRoYzZFNThRMnNEV1ZDTGFONW9VV1lBVlNyQ2RR?=
 =?utf-8?B?SkVSMW0vSjdhY1lRZDY2YWtFVVIvMGZQZHc1ZWRhMit2WmZ2b0dOV3VGSEs0?=
 =?utf-8?B?bWF0NXYxRENWVWFzMEJNVnBDN0kvUnVtV01rQ0xDditGVFE5TkUvSW93K0gz?=
 =?utf-8?B?aGcwSVMxblVIVW5VQUZjYjlIZVpIMkhybjJUU0hXVVZJMURoOGVqRVN6MlJS?=
 =?utf-8?B?ZmZxdytOQmpuaG9DSzMvV2VsUUUxUzhDZCtjWUxmM0IzUGhQYWpuWEo2QU10?=
 =?utf-8?B?WTFrU0llL2tKSDlYSTJ4WHc1R0dySnZqZVpDTXNVUFlIeXdOSUNJbXRJc1Ar?=
 =?utf-8?B?Q3NWbklMaU01SUhlUDFFZnljWUJhbTFoSnFvb2s0OGp5S1NpQjBEdGdYenlQ?=
 =?utf-8?B?T0ZTREJpTHpCS0hNL0FDYURLcGNyNTVoakNhVXRTTHNLZFZwQzllQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82732c9-d5b9-4398-73ac-08de7df343f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:48:10.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L0aA9h8rZ7o6rjLEcMlXf9cOfcw3o85xOgiq6/5/p9PH59AzatCdyYRS5HVLf06q9YEBepxVXMgT6IGa7U6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
X-Rspamd-Queue-Id: E33DB23C1F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17795-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 07/03/2026 2:16, David Ahern wrote:

> On 3/2/26 8:51 AM, Chiara Meiohas wrote:
>> From Michael:
>>
>> This series adds support for managing Fast Registration Memory Region
>> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
>> pool behavior.
>>
>> FRMR pools are used to cache and reuse Fast Registration Memory Region
>> handles to improve performance by avoiding the overhead of repeated
>> memory region creation and destruction. This series introduces commands
>> to view FRMR pool statistics and configure pool parameters such as
>> aging time and pinned handle count.
>>
> reference to the kernel side patches? have those been merged?
>
yes - the kernel patches have been merged:

https://lore.kernel.org/linux-rdma/20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com/

Regarding the other comments, we're looking into them and will address them soon


Thanks,

Chiara


