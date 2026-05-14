Return-Path: <linux-rdma+bounces-20648-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHYtBytgBWrsVgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20648-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:39:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 293AC53E09D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A84D8300BC88
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51713ACA62;
	Thu, 14 May 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4wjX0+Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF44175A83;
	Thu, 14 May 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737188; cv=fail; b=iJg8H7lxjuLJTs2dsWitfJYVFxf/NRbG/Srls/6rBWBa8Y+Lzy+m3NrM9eK9flioy6Tb1ZIiO2HgbifHa15yonGpFat7thsuGtTu3lCH+mUuUXArQiIDjB66Br1pzpnUTiYqfCxBO66rl3Pvm1MG5KxsCMBL4m84kbA0bhjPXrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737188; c=relaxed/simple;
	bh=kFJPfYhujjTmrQkBF1i9BUuIcXIlWMRmAQhK+WMsdIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isOJF3bdvZ3x+mLeuSVGOHy6KQBjfZnBUD0kT4gzPZHDpIPN9bMcA8PUkFIlGRT2J6+Q4wG0m2HvbOkGf1bJ6g41D5uBQFZFbw2ibvflhDy7c/32ts+I6bPNtmdzPCbLSOaoc3+v7TGopIpAzWPZhF81ozrLaRLaPMNyHUCzR0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P4wjX0+Y; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbvGqf10fv6UP7IEIWWbYzz6wQ9e4pEnWPZM36VoRJe+uMyj13hBg1av1Ef6tgsZvCdgy3AADZo8Y08luT4sDW5OwYwWjKD1i944fMP3hdmU0y/49Vrh4BCLHMNQBM6uRrkM1qeVA8RtedPQG14ly+n2ZVVnVSBSnVl2oq1EdX2gQOgJdnIIhDpD85bMXzwEsn2U/tx0GbRTZsZAIiKhXsmN2YG6CBzdMb2qM0l9vs9YfZBz8PvJWgO/qPcCZFIUCIWEgnVA/qrvBqBEBsmfJnthXg9HypTr3s2vprawMZrdSHX16cAXNM4/KwntRxjIu0cTmCG968UDungMBadD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXOMyInf7E0JEhRuYCb99UEORw476kJt2f8R/bvdR0A=;
 b=hxzuLe7KywydqLF362hGeAzS48WZ+9rPvSLAQ4Ypzi2xtv+36sLQQVR/NSUtel98tAZPumKa28X3UqzgKd0x59mI73uPItTW1PboX8lYp/rB/ZbBeprZgzSar3jDBQBPmE8damIOBNhu5WYlMf3I08V5OHSi+KSOx47o1eL/cDGe2cFDTsTC2XMkves8jmn9qx/TRkv/xK15JQ1r4+KAZk+7vGG6M+idBrjNvOEo8bIi5vNyi0aprV0gMbQ5GAG7o9B3sJJAdHK9YvS5xABSaFbvRpPcvZymbNSGZdJTzclytT58XoKconX5FJVx6thl7Ai+doVKLRtszQrBA6QJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXOMyInf7E0JEhRuYCb99UEORw476kJt2f8R/bvdR0A=;
 b=P4wjX0+Y6sQQGb4ug+Yhzp1LRt45sjK4EqMZ3u8mK6h5Zds88Q22d0ynvML6NWNpDhWcW3CDvs5YlBCitS+93KRLFxiVt6eKwu2otOjXP2Vrl0mDuQbuUhoaBQLl2B0s+/+1tbrUjW+G9ypq1VOfx/2d5f9EEm8Bs98fnXfT1Sl3pL4jUREDo7TORPCBGnnvjGJMZbHc63Si/a4Ufd2hePm210ioUwXy5HBouNXCIVQhar7hK0hEL/fgjyR6baQoFeNjecund9cNzE9/76DxnVOcvcFX+AyjSm5iWua6X4TxZ8q7N+TPcd6C3YWuOoX5oE90RgsYGFdZq5nxBl7mcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:39:43 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 05:39:42 +0000
Message-ID: <b635e3ec-9c24-4347-9495-c421b7d69243@nvidia.com>
Date: Thu, 14 May 2026 08:39:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Marc Harvey <marcharvey@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org>
 <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org>
 <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
 <20260504181022.60ee2a1a@kernel.org>
 <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
 <CANkEMgmhh40uE8asRO3WJpAtDZWDcSjJNVCzh54TgwcMUonhdA@mail.gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <CANkEMgmhh40uE8asRO3WJpAtDZWDcSjJNVCzh54TgwcMUonhdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 011a7c76-e728-4498-4917-08deb17b32e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|3023799003|4143699003|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	vqC31JHQZr7kUWOii6PSyxDmfkXMznBaaT3oOaggs3B9o6mWoxDVQJ4xeeCOn3zEGs3INh2XhDpBPBJKqaz4Y2tJ8oeUkQ0Qiddm/w+HXO/KCZfz4XiMpkrVhKdTAa3CWvKTZfUunFWJUDc6wGSP+wHFldF/7z1MkAuBYuALvAyXzonfHX/KxU4QpAu9QH2Qimxaj8bYtEyDdcTIFivbxIiTj/soXdLthouWM4Ln75BxcJ/bnkMTcvGFkItsdt3xyJRGwZXICw4wczFRhUqRbEaXOmlH0Mjs2fPmen5k1Ds6nrO1efCJNCW0wGq2uxXOofCce8UZmeQDJ7JJCyhXo0SudITIK+XlKA0v1wnK274plP+jo2gKM/dteZFV0cTe3v8H/wavfIPeJZMfvj0uxi/1rMJ7dSd2oeFrIxJr8j1CVa22rOVb3P2mzKnqZKUHPELPgxFTt6sH/KFTiA3IR8uizDC2Z6CzPBUemFtZV7m7PmM1Orpb9gYWy667x25upLEOQX0VtZE+3sf6YvyBQVViyGY7br8Y4ws0adxaF6/kBTxf8sWT5h+r0kxg36V8dB8dOnYzmLU2HtV6DPOJx9vbIqTvKR3EaG0ki2gRdpUC1DYkpIhLMRmqzHCNvSHpDtXH4R3deFJ+dE3hq+gS2j32bZqyGQfIgsuGmqixY8fCBTlheZVqBORJ1INIBXX4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(3023799003)(4143699003)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZYbm41aklMa1NlVGtqdFRKYnJVY1BIWDZFcjhVTnV4cjZGU1hWZTQ3emlN?=
 =?utf-8?B?cTU3dG8rQm9mV2RTTzViVlo0S0NoR1JCVkkveCtPbVArMGNLcHc4SWFFVnJi?=
 =?utf-8?B?eXlIb3lDcmxoN3BVRlE0L0FVR3hPRmtxa0M4bitHNVRHcHJyNFFRbmpkZ1lj?=
 =?utf-8?B?ODZTSm1TdkpLU1l1S2REa241L1dTT1RGZjZqdUVGVllxSEhpZW14aE1rYnpG?=
 =?utf-8?B?Q0JUZE5xeWl4UGV1VWJNSGtTSlVCVkYxbCtBNTI0b3FPL1c2SVBOQ0xQRnJR?=
 =?utf-8?B?eHhCK1lRMzlDWkdvM2RhdGJYQ3RqcVhpaXViKzFZWVkyVnVUcVBUZ2pkcStQ?=
 =?utf-8?B?eVRHT1VFUUd2aUZtWEpNVFA1MkhzbWdYMG1NWmpnOUdidGVOdjY5YVdxSFoy?=
 =?utf-8?B?WXk3VktVd0dzQ3ZBMTZCR2YzQ0xQTTREVTA2bmpDanhFL2dLQmJ5d3Z6blMr?=
 =?utf-8?B?bktRTlJJSGZjY2Y2TmJOYUMzTmdxNXhCVml3VVlPbm1mL2R6QkpIREVOOWRB?=
 =?utf-8?B?R1lHTXFaek9IT2l4eEtaUEtsLzR0VFBhUnM5ejUzazY2STBYWFdBQkRLVjdQ?=
 =?utf-8?B?MzM2KzdxWStDcFVaRWJSYXhZdlRBUUpDOHNyM04xWC9RdllkQTNuQSsrQnpp?=
 =?utf-8?B?a2FTTStsOWtBMVZQWVZwL0NKektLelZ0ejMzMHlrSFkyTi9hbENQQWJzNEZ3?=
 =?utf-8?B?QWJaMlZtZFJzTzlSZDAzbWk0MDRpRFdMcXA0Z0dSa1RLbWZid2xSRHdLRWQ2?=
 =?utf-8?B?SEFsMHdqeTdaZ0xEOXZ6dTluRTZNbVNlajhIeTZYSXJaczRwVmxMSU5JeUQ1?=
 =?utf-8?B?Y1VEVngzb1hSa2lRT1hTRWpwbVdVU1JCeW1UMFNPR2tPOEtRd2RFa2pOZVgw?=
 =?utf-8?B?eUV6TThtd3hDelNWT3VMQkhpZVVLMkppUnU3STIvcTNMcWNTelRKYlFONk1M?=
 =?utf-8?B?dThUVU5lUDNKbk9veEFiVWRvTnozaThEaEJ6QndveXdiYTNRWmI0Nis0NzYr?=
 =?utf-8?B?YytWd1RIcUpFZmhkbFJyRlZ6bjlRTDg3ZmphMnR4MjNKYWZtTUx1SWN2WTVT?=
 =?utf-8?B?TVdrckRCb2hOeUtnb2JkTU84Y1I0bmt2WUdQTDhJcDZMa2pKdlNnTnlORDhM?=
 =?utf-8?B?eUN4Vys2eklKOWo3RWI1N21ROWtVVnJkQ1ZWUmJHWXc1c29BaU1GQUhIdmtU?=
 =?utf-8?B?U2xaU3BzdGRKSDludWQwUm1SejBaaHBhd3VkVmhKelhoQnZoV1huVnBzcFpj?=
 =?utf-8?B?K0J0OTJwbm1QL3BvNjR6MnFaeExwV1g2Qnc5Tko2dUtTSEx4UUM4a3hkVjlV?=
 =?utf-8?B?dmxRR1Q0NDZoRTZQcW8wZkR6MzFacjBGVEtVMkUxRDlXek50QVcva05jN0Fh?=
 =?utf-8?B?TWoxaFo3WmwrSzloeFFKT2dCNDFBbVV2TzRWaHl4WEZRYmYyMk5ZdWpOSVNa?=
 =?utf-8?B?c01obTB4aUQ3TkxPK1YxZjk2YjMyL3RSbHpGSG90Z2JISzRxa2VwQVdDT1ZL?=
 =?utf-8?B?Q0JYZlNJWVJJVHJXZlRuVFpEazRyKzlobi8vMjBDTkc3blpUdmROcmRVWHNK?=
 =?utf-8?B?VzdodEFzcEQrbjAvSUFPTGROU1ZmVC81cVM2MEtuNkpjZGxkbExnbDdndzRh?=
 =?utf-8?B?N3ZYaFJ3MUwyNzMzKzlEUFZOSjNqbVFrcGZyalpiUnAwbisySldKOTAzL29k?=
 =?utf-8?B?N3pSWFBHRVlXZE9CSFEwS3pxcllZTWZ0S3d5cmRFb0FoSy9RL1l4ODNjQXFC?=
 =?utf-8?B?QkIwOWNuR1VuTHhscjZVdmVsZWgzL2dhQ2VIZUV4a1gybjdSWXU2TnhlQldL?=
 =?utf-8?B?bThncEpSY3lzMnh5SUxTQU1pOUc3Y29BYlE2c1BaVWNobCtUdkR3ZVdkYXRD?=
 =?utf-8?B?WGhYSVhKSk1neVV0VURTK0NFREtYSFh1ejh6clN2bktnaE5TVnp5ZktJK1BO?=
 =?utf-8?B?MmU5QUthWEdXT0V5dFlkdHhhVnQyVGNWQUx6dXc3dlg4MXliMEVENGpQL2xq?=
 =?utf-8?B?NGNzSFhDZjFxUHVOTDRjZXZHK0RSVUNaaTdNS3lTbGRnNWw5N3dFNEljd1B1?=
 =?utf-8?B?Z1RvdmYvdU9GMlpSL3AxcytPSDhEZ1J6TmZaell1Yk85VzRRMjhWZmo0Rm40?=
 =?utf-8?B?dXhEN2FOeWpreXk1bmNMTXlPSWVWOS9teExDbWt6SE15ODA1VmlTYTJyR3FG?=
 =?utf-8?B?TzlQdFFQcEppZzErNm8zVnROWmhTd0xDQVBsblZVNEZHODA2ZjFhRTY1RkhF?=
 =?utf-8?B?ZFpuU3BCWWlhU3I4OTI4RTZXd3lWWVZiNEVzY3dUSFN1WS9nRGpGemlESkZq?=
 =?utf-8?Q?987q76ZhyT8oreJj8d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011a7c76-e728-4498-4917-08deb17b32e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:39:42.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43y2RA2SNnYKRWRutf7u8V/vRJpMdPe3G3ElQDUqdvQx41V90p8D63BivLpjFwze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
X-Rspamd-Queue-Id: 293AC53E09D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-20648-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13/05/2026 19:20, Marc Harvey wrote:
> On Tue, May 5, 2026 at 1:21 AM Gal Pressman <gal@nvidia.com> wrote:
>>
>> Hi Marc,
>>
>> On 05/05/2026 4:10, Jakub Kicinski wrote:
>>>
>>> Sorry, I don't know mlx5 very well. Sounds like you have to talk
>>> to nVidia or/and run some experiments. The current patch is a no-go.
>>>
>>
>> The hardware offloads 4789 by default, hence the
>> UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN, you cannot simply remove it.
>>
>> Have you tried disabling tx-udp_tnl-segmentation through ethtool?
> 
> Thanks for the responses.
> 
> Gal, by "the hardware offloads 4789 by default," does that mean the
> hardware offloads 4789 even without an explicit command from the
> driver? I ask because mlx5 does send a command to offload 4789, but
> perhaps this command is redundant and only for bookkeeping purposes.

Yes, we add the port so features_check flow would see this port is
offloaded.

> 
> I haven't tried changing the offload related ethtool parameters, and I
> will, but I suspect it won't help in this specific case since the
> perceived regression involved non-tunneled traffic.

What is the purpose of this patch then?

> 
> If the hardware indeed offloads 4789 autonomously, then the perceived
> regression we saw might not have been real or related to enabling
> vxlan.

Can you elaborate more on the regression?
What is the issue? When did is start happening?

Maybe you're experiencing this?
https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/

