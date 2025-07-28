Return-Path: <linux-rdma+bounces-12507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22CB13D52
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26573A98C0
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC326FA62;
	Mon, 28 Jul 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCR+q2Ze"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772926FA4E;
	Mon, 28 Jul 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713389; cv=fail; b=F7E/7aH9ipdAXlzRBhLZVGxsoP2pRPowFp1dwRnGWJ64slXess3VE/zEfDYpU28eS9OJhoUSJ06hFk/o5f14Ot1aG+QIyNz3VhsAGsRtwzQpjEEsjUy8osyzBdjv7jjw6iVRUk1BCAoYtAz9Ukc2+gtIj5OGQ64TWyBYQv4Bz38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713389; c=relaxed/simple;
	bh=uHjN+vAx6bxCmks8Sytxm7eqcGk1EDaU9bYt+2iKuQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VpLykc7xnflOPGysSdAIaHtP8YLnniVeT+wDdLeOIZpSiL2dmSW44ilNmLZOb7pqTOrMNVsm05exaoJZy3PTJyNm/fgbtrTLvmjZeyaV/YQpDrSwvEVJjmH0f9Q15FZSHpVfUjTzUNT9bq1dUt/3Zs8U1x+uQ91WGBuOej6LpHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCR+q2Ze; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khmmKiOi7GvnsRQoyfdBOCPrD1jW3KvbGSG9BczvBCuS164WuOwFmaVhZ6m+cvHySy0YUIWyu0Ey/qwxS47Fu/xN1TMwOfz9qB3Y/nRH77/YmeujiMYb/S3BE5AvegKu+/SR0zPkPmQqLxVXcgY5fgoNAZHJHqrzCIJnKaf3jZhGr8+P28rHgpzj3khWz7txUNX7A1Q3L7MsYebiYvSIXP4J8NwbzsIBJdf4nK7z5Q5ysS41tXfbqpFhGNcMCy80btuSfZrEFCBpiRDpFCAufDBtl1IrXJGlcYs4tnmfRLrcOvtvkpUtPsKgwV3h0WyQdW9jvaAxuUp/GI0U9L0Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUL76K9A7wsQiLo0Q0KLvVlrXSgNkmJkeKN0iwY9h8o=;
 b=KPNjFiu77SQb2ZKNOYwXvrSo3yQJGze9zQVdXbRYTeHCfpM0iTwpI68yLvVscScCM7Z98mqN22ud+2oHPAWEu5ROxuNbIuLVo8HUe2C0rPKSHHo5bmeSdDnFxvKM5kqz/V/9WTYedLyOHBiskz45EJjgbm4zQto7G+oCScz3m++NvuDRRV0Un6NDCYXT7uKijpNda15yTvBzVbtD+csT/JEZHdRGgA0uN3hUSNXNp+QT9RFVUomoewRVF0VhNkgmJupGp9OgIo1knkifmo5zMbxCwco5vSus/Ev4AYMAw+ZXhL6WgxGjTER1lAeJCKGvjXqROyLAy6h4ztR4NznVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUL76K9A7wsQiLo0Q0KLvVlrXSgNkmJkeKN0iwY9h8o=;
 b=NCR+q2Ze7RmWShuiWvsZ+pUj+vZQ9pOpyxYltcge1cVAGxCp7Cx0VWmzNgIgi2jdLQQZoYxBuxUJ2QG2M+wwRecmeKd2fcnEBchBL4BUykb0Q3GTxwoerPZk9Jfc5u784Dxua3EgBgz2UHkHWBcGFYm+QosxT6cN9pk+mvhq4L8j59/G155GFBM8gaWT8/6FBTxNMNBJD98lXErx9LVKUTEnsS6S+MsbMwEwYc2z60KGYPKtwMbKw1hSC04/kohqcIqJrryQeUwZpcWm/SIoqc8XHMsO1vtkU1cgNi0Rt1NCEAeiV+OY3M1tD8jKKIIe+ru3S1HwCsXz/EFU2s/Xqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:36:25 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:36:25 +0000
Message-ID: <6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com>
Date: Mon, 28 Jul 2025 17:36:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: f22878b8-5697-485b-a9fa-08ddcde42123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0E0bzVLRnhhSlROYjRGamVWdU15dVk3WSt6Wko1Q09tTHZ0YkZ1ZnZWaWlq?=
 =?utf-8?B?TDlRS1FSc0VhQWgxZGVSV2lLTk02ZmRGVzgxUjZ2VitUc1lBZnhPMS9SYUhw?=
 =?utf-8?B?TXhYTFNxY1VDTmdhM05ZVVQzd2pTRmJBZmt3bFBZV0F0RUovbEt5QXkzc0xS?=
 =?utf-8?B?Ynk1SmZ2TE9oT0tnZ3d1N3B1d2xEcy9MWEF2YXBtMHU4bnQ1U204d2dsSXA3?=
 =?utf-8?B?QXFWZzYwWkVPUGQrNFdlakl3aW1PV0NLK3c1Q0pHQlVlUERvSmZMdnMxbHMx?=
 =?utf-8?B?amNIMEMxNy8vTXUwZnd1eTZqNElrNzVPY0JncXFrM3R1Q0ZtY0p6b1orRWMv?=
 =?utf-8?B?a0hiUzlIMlBTOXk3TnZjK1dmL0Iwby8yRzhnSHBIdHIrY01zemNaWTE0OVRU?=
 =?utf-8?B?cStuclRPZUpLeHA4Nk5DKzdJRGgybnlVdVEzWUJpdGs5cDB6WGJ5T0dHTlhS?=
 =?utf-8?B?c2N1dThUREkxSWNUZnJsdFp1VTFnWGp1cjFsK3UvWEh5WDJGUWE3a09LT0lY?=
 =?utf-8?B?ZzNWTko0MzQ5M0IzbmJtdmx4em1lUlpzM1hRc2sxQTd5VTI5bjZwbzZKS2h4?=
 =?utf-8?B?MHRXaWNlME1ONkt2eTYvbUtDNTFtK3k0UjA0YVFtK2V3ODh3elZZK2xEQ3Na?=
 =?utf-8?B?WkFiUEFDYmNZWjQxUWxSTWtHVitTNGlUb1dadnN5Z3Q4eTVSdERJTHNHS3lu?=
 =?utf-8?B?eVIwTUM2Q1JGdUJFdnFlY0JHcEhQK3psb3BEQno4RGpjcVMxaDZ3L3k5QUYx?=
 =?utf-8?B?OGUxdmpiUHN6dTVWRUh5SjZiRmNieWRnR0ZheG5CczBLLzFSTkpObEoxdlIv?=
 =?utf-8?B?cHB1Kzd2NnhsTE9mMDY1Z2Z6NEVBK0pBeFdWeHJhalUydXRPcTMxL3hFVWps?=
 =?utf-8?B?Vi9Gd0oxeXVtUHcrVDg1ZG1YNnpUR1lRWVlaSzFFbGlzWno2a093dFFYd2Z1?=
 =?utf-8?B?SkdENUxLUXZTWTA4RWI4U2VqdFhibVdFa0lzNHhydFM1Q2pIT0ZOait0OGVx?=
 =?utf-8?B?dVVFeTNGVVNRVnlCMlpDOXROakZjd1Z6UmczUXBIbE1tRDY1bXZDOGZDQllo?=
 =?utf-8?B?S0pWWjdJMTVweEZvbzlZMXUzK0tDOXdYU0tkQmpwc3pQRDd6OEI0bmdFL1lM?=
 =?utf-8?B?eGpVRGc1S3RjcXYrQnVROXh4WFZMVWJweHZ2ckJPLzlITUUvekpxMExSaGpQ?=
 =?utf-8?B?ODdKQW1FVDBSZk91eFRVRWtSSUtCQUhwSTE4ak5tSzR3MGhhcFVZNFo2Szhu?=
 =?utf-8?B?NnNBTi9QWjNDNzB6Nm5VUElvTTYrbmFiZUlzcG1oaEphM3JzUE5pL1hrQ2Z5?=
 =?utf-8?B?Q0xiK1kycm9EeXA2VWFUUFM3dzFQb2tyMEVWLzhiRVFzSVpYYU5TekJNQ1Vn?=
 =?utf-8?B?ZmwwK1RpQmRUMUFCUnpqL2N2YWk5KzVJWG9WeUE4U3UwcEFHQVVmOS9telVt?=
 =?utf-8?B?cWZkdzhORW9lTGN1a2ZvWU5sV1hEeGp5N3lHSldMTGxRKzBCODlrZE1mYXZ1?=
 =?utf-8?B?SHkxdGQ0dHN3V3ZXVE5Iek1pUExJMm9hYkNlT3dWdWxKMHNLRllvOEQyY25v?=
 =?utf-8?B?WjV2WGp1QzB1SUpaWEdFSlNaSTlNdFJKTVBhN3hvQWpEYXpFdmp2MjkwY01l?=
 =?utf-8?B?dnAybTFrbDVDb0tHSGpEV1NLblJoS1dhTm8yK1JrQ0NtM0NUWDRrUWxJc0li?=
 =?utf-8?B?STdlcjlDcldKNGFuS0JXZ3RVdEhoSFd2ZUJmR3FjUVpZSVZqZ2MvZUxiN0tG?=
 =?utf-8?B?eEJNNkd4QTI2N1dQQmR3cVJLYVBzdzZlZUNsZkEyMGRmMktRMjJUVDBvR3px?=
 =?utf-8?B?ZFU0ODZUb2N0bU1ra05kak1IdTU5S3BKUmxsMjFVNXR1ejUvUUIwQlpiNkFq?=
 =?utf-8?B?T1AzSFZaNUVDUnNmQzRaaGVNMVlWbVJyUmtPSCsxaXB1MXUyVVVKcmxFY1VN?=
 =?utf-8?B?bFRLTmtPVm9LV3ZaU2w3cTdzaDFkQlE1dW00THhIcEdUd3BKZ0hhRTc2Nm0x?=
 =?utf-8?B?aEcyT3VIQUJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1hqMWVqNGo4Yk1TeXdHNVdxSk9ZRU9oczF4STIwRUhxSlNUOFJPMDhuTFho?=
 =?utf-8?B?MXdxZVNsOHJaYks3S0ZzTlhWN045RW5kZStxMXNBaEpETkNFUnJDN2RiQ0xs?=
 =?utf-8?B?bzB0VUpwUDRzclkwR0VhbFpKZlhGQlRic0gwOUoyZUlIOFM3RFFjSXBkTVdl?=
 =?utf-8?B?RS9KQVUrbFZWRVRvVGoyVWNQcCtsVys5N2ZXRVN4d3VjdWhPdzEzNUVPY0NJ?=
 =?utf-8?B?ZEVHY2lRZVdqVlR1RGVJUi81Z1ZPcXRQUVBCRTVIRDd4aWJqM0hlYVVsV2Ry?=
 =?utf-8?B?bVlVNjIxYm1BNFMwMFFkeUtISHRiWXBmYXVhdzlaODlTclJmRzlMS0tiTUYw?=
 =?utf-8?B?emRrTXVpREtqcnB2Y2ZtMWthL04xWVUwaHNCd09vclY3d29PQXBFN2srTzFH?=
 =?utf-8?B?eElOSDNkUmZiSDIzalF1OG0vT0VBVTNHR1dVUUZWckg3SDRpdFlneW1xUlow?=
 =?utf-8?B?MWhqWEpPUUNoaGl6MHVlWUxRN0FLY0hxK2dmZDVYa3R3bTNXYVVYRUJ0YjJM?=
 =?utf-8?B?ODJpRCt1NkNRZFZTYzQwVkJEQndIeXFkYTViZEF0cXFrZk1SaWZsNm5zVGxF?=
 =?utf-8?B?R0lSYTloV2VnY2ZnMFQ5TG84NjgrdFdCSXdMSkVobmxWRStMTnlNb00zUSsy?=
 =?utf-8?B?TmRsd2c2UitMdDg3OFZMY1FYNlZaMG4vcUQvWmtEdXUzbjBiWGZ2bVlXSXNm?=
 =?utf-8?B?OVlEak92c2JRNmt1L2JRNVZMNlhqNWNJdmt6TWNyQWFjRURVUFdGZXNnVHZj?=
 =?utf-8?B?bWZHUkVyM05BQjRJRGdMR1AyT0pCNEVDc0pBeEhkejdQWFg5WXJtTWZ0Q2hn?=
 =?utf-8?B?QVJXNmhzeEdWa2sxNHZlZktVaGtqdHlQN2g2SmxUcTNxNEVCSGlrU21scVYv?=
 =?utf-8?B?SElkb3NXUldOUGpPclI2WkFiVXNleVVIZUJiVkxBK0ZJUmdKVjhybEVTTzBm?=
 =?utf-8?B?Z2NISnVtS2ZES0sxdlpuck44MUZMbGk0Rldja3FiWWpjKzVJc2l2cXcyWkNE?=
 =?utf-8?B?YUpMRUlYNGovbnh1L0pLYXZwV0t0TTFCSFIzYTlJL0pQdmV0dzE5UVRGcWo1?=
 =?utf-8?B?SDQ0bXQwZUl5V29lMXI0U1NCamhKNWpsQmJOK2VhaHo0SHlkN01QVTVhUllJ?=
 =?utf-8?B?QzhyT3pwZk5YZ3lnR1BGaG42dTlDSXMzcDFROXloS25vUUJ4TXRJVDBWN0Zt?=
 =?utf-8?B?dmFSZ1R3Zzc2dEFSNGIyb2U2M3UwcVB1TW05WWRYcmN1M3JLZ3pEcUt1Tmcv?=
 =?utf-8?B?dnBnajJBNFplNVBNVnloMSt0b2I2cU9nSFFJcktyNmVIek9lczJxOHdtcmJV?=
 =?utf-8?B?M09RUzQ2aEVhSDcrYlg3dkxVUk5jMjRwR1pkZUdMSUlTdjliYkU2UG1sNU1N?=
 =?utf-8?B?MW1YbkRsUnE4Y2Q1TFd3K3NHTEdIMjl2TEIzQnZqQVhzc1V1UmlGcnBEdGQx?=
 =?utf-8?B?cXJNcmpnd0pMZkZCbTd3WFdRUVMvNm9ZSmU1alI1Sk1WZGI2VWxobWxqSFh4?=
 =?utf-8?B?c1ExMTFYOFJ6b01kQVZ3Rk1RczNDcUVHVGM2dEh5eEVIa09kaldIeVVLQk1i?=
 =?utf-8?B?ZkhEcGZoRFJTY09uMTQwUFc2YkVnODFiR0pBK1NZK1dDeVRQQXBFUVZLOG1r?=
 =?utf-8?B?UGJON01VY2NxWWZ4WjZkSmQ1bXJvVUdQdHRya3JIcUFoaStSS1k1aXdEeHBt?=
 =?utf-8?B?ZzlhZXNBcE9qaUZlbkltenFmbitWUWJxeDNBZ0N2Q1crczljdnArTVRONEJu?=
 =?utf-8?B?R1pPejkvVjlqTndVUm5qKzc5TmM5WnBSUGpKVkJJVTZWOHlhVzY0OWVQWjFt?=
 =?utf-8?B?aVExQTIwV1Vjdm0weTlEZWcxbW1JQmQ5cjNwdFNrTWdIYXpsaUYwY0FpS2hz?=
 =?utf-8?B?R3FROHZ3RFFkeDY5YjZnREhVeC9qZVhJemhwTlJJNjNJbWxjcy9KT1lJTTV2?=
 =?utf-8?B?NkF3d2Y2MXJiOStxQXM4SVhwKytCSzQyK010UkQxMlpSbnRqeVZ3Nk5aaUl4?=
 =?utf-8?B?K2NBQVMzMjFqVGp2TFJ6OWY4cjlXUHo5M0pTS21md1YzbEZaMldFUm05Ri90?=
 =?utf-8?B?S1EyZTJDNmJHeEh0anR2UVRDUXNwQy9IVVJzalVjQ1lhTmZzbTJ6ODBBckpJ?=
 =?utf-8?Q?II4oDSj3fMbXLu+CX6a+EvAQo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22878b8-5697-485b-a9fa-08ddcde42123
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:36:25.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ3lMQYq59ULUmFZialrGiEMj81JsCGLgLP/0DBkePGgSUV079E5dhpOamAhcCGT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

On 15/07/2025 23:20, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> gso_size is expected by the networking stack to be the size of the
> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
> is the full sized frame (including the headers). Dividing cqe_bcnt by
> lro_num_seg will then give incorrect results.
> 
> For example, running a bpftrace higher up in the TCP-stack
> (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
> though in reality the payload was only 1448 bytes.
> 
> This can have unintended consequences:
> - In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
> will be 1448 (because tp->advmss is 1448). Thus, we will always
> recompute scaling_ratio each time an LRO-packet is received.
> - In tcp_gro_receive(), it will interfere with the decision whether or
> not to flush and thus potentially result in less gro'ed packets.
> 
> So, we need to discount the protocol headers from cqe_bcnt so we can
> actually divide the payload by lro_num_seg to get the real gso_size.
> 
> v2:
>  - Use "(unsigned char *)tcp + tcp->doff * 4 - skb->data)" to compute header-len
>    (Tariq Toukan <tariqt@nvidia.com>)
>  - Improve commit-message (Gal Pressman <gal@nvidia.com>)
> 
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Hi Christoph,

This commit results in hw csum failures [1] when running iperf tcp
traffic with LRO enabled for a few seconds.

I don't think the patch is wrong, but I suspect it exposes a new flow in
GRO which we did not exercise before.

I am still debugging this, maybe you have some ideas as well. If the
debug takes too long I recommend submitting a revert until the issue is
properly resolved.

[1]
  (NULL net_device): hw csum failure
  skb len=1480 headroom=98 headlen=222 tailroom=0
  mac=(64,14) mac_len=14 net=(78,20) trans=98
  shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
  csum(0x307d002 start=53250 offset=775 ip_summed=2 complete_sw=0
valid=0 level=0)
  hash(0xa7670845 sw=0 l4=1) proto=0x0800 pkttype=0 iif=4
  priority=0x0 mark=0x0 alloc_cpu=9 vlan_all=0x0
  encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
  skb headroom: 00000000: 68 30 05 7b 72 80 41 dd 88 59 c5 69 18 93 df 2d
  skb headroom: 00000010: 1f 56 e7 47 1f 9c 53 e9 5e 5d db c5 ed e9 13 0a
  skb headroom: 00000020: ee 94 c5 27 ba 91 d0 f7 6d 23 94 95 d3 ab 09 70
  skb headroom: 00000030: f4 c6 f3 4d fe 57 03 99 bb 9f 15 3b 2b f1 17 cf
  skb headroom: 00000040: b8 ce f6 64 0a 58 b8 ce f6 5a 9f 1a 08 00 45 00
  skb headroom: 00000050: 05 dc 8f 86 40 00 40 06 a1 91 01 01 01 01 01 01
  skb headroom: 00000060: 01 02
  skb linear:   00000000: 93 54 14 51 8a 86 a7 aa 43 17 dc 38 80 10 00 3f
  skb linear:   00000010: ff 5d 00 00 01 01 08 0a 23 69 a7 b5 73 7a e0 19
  skb linear:   00000020: f7 2b a7 ea 7a 16 5f 4f 7c 5b e5 6a f0 b0 80 d8
  skb linear:   00000030: f9 fc 03 d6 3f e2 52 44 72 85 09 1c fa 8b cf e5
  skb linear:   00000040: fc 70 43 c2 89 1f 06 30 e6 6b b2 85 c6 3f 4a b0
  skb linear:   00000050: 8f 02 3d 05 ef 3f f0 98 68 38 63 6e 0d 83 2f 6a
  skb linear:   00000060: cb 31 38 ef 8d 66 17 15 0a a3 e4 9b fe 10 5e b6
  skb linear:   00000070: a9 3e c4 ed 39 6e 2b 4a 9b 3e cd 1a 87 c3 0e 50
  skb linear:   00000080: ea 6f 35 f7 a9 ae 66 b2 6c 4a eb 25 4f 59 f2 d0
  skb linear:   00000090: 6b db 42 01 dd 55 8c 67 6a 29 e4 58 12 35 9f 98
  skb linear:   000000a0: fa 20 ed a5 9e 90 74 e6 07 b8 ac 59 44 0e fd 86
  skb linear:   000000b0: fc d7 cf b1 13 da 8d e1 fc b2 b8 a2 ae 2d aa 72
  skb linear:   000000c0: 18 42 49 10 f4 c8 ea d8 dd 21 6a 97 cb e7 c5 a2
  skb linear:   000000d0: 3c 08 7b f6 92 99 ae 5d 84 97 a5 e5 b7 87
  skb frag:     00000000: 6d 0c 20 b7 86 71 29 cf 49 98 47 25 d0 9f ae fe
  skb frag:     00000010: 35 36 7e 49 10 df 72 8a 83 52 f8 2e 8f 7b 8c 3c
  skb frag:     00000020: 2b 11 43 b0 d2 2f 44 b9 57 f7 df 53 93 65 7f 8b
  skb frag:     00000030: c9 37 ab d1 a7 fe 20 b1 5f 7d da 76 ea 10 01 fa
  skb frag:     00000040: bc ce 23 b7 8f 9f 66 39 0f cd cc db cb c4 f7 82
  skb frag:     00000050: 7e 53 cf 8a c5 56 f9 bf 1e 14 ca a7 a5 5a c1 ff
  skb frag:     00000060: b5 dd 1a 1d 7e 40 01 25 a3 43 f1 cf ff 65 a2 6d
  skb frag:     00000070: c1 ff 8c 90 27 fb cb 40 d4 da f2 05 64 06 b4 aa
  skb frag:     00000080: 67 4b f2 49 22 fc 68 de d3 e8 88 00 ad 59 28 31
  skb frag:     00000090: 6a 8b 24 b8 be f1 59 a6 7f 9f fb 8c a3 57 98 52
  skb frag:     000000a0: 7a 0f 31 3d 20 93 d9 d6 cf ae c2 00 e1 45 8f 9d
  skb frag:     000000b0: b2 b1 54 b1 3e a5 c0 ab 37 76 02 25 84 aa f5 90
  skb frag:     000000c0: 29 0b 08 07 00 b8 84 ed a3 de d8 c4 c9 50 f8 f6
  skb frag:     000000d0: d2 51 1b 79 8c af c0 f5 89 56 cb f4 9a 2c ed c1
  skb frag:     000000e0: f2 f9 1f 73 c3 9f f2 f0 a8 f6 02 62 56 b4 3f a8
  skb frag:     000000f0: 9c 0f 35 5c 63 80 b4 f1 18 b3 c8 91 2c e9 0e 6b
  skb frag:     00000100: 4f 99 83 c7 ba 35 8c 3d 3b 9b f2 de 56 ab 50 a8
  skb frag:     00000110: 57 8f d8 f3 40 58 7c 80 17 a8 8a 8e bc 9b 92 5c
  skb frag:     00000120: c9 e8 11 07 f8 d1 9b 53 75 5e 22 ed 3f 9c 6e a1
  skb frag:     00000130: ec 6b eb d5 f6 a5 14 8a 73 80 3d ec 9d 13 dd a2
  skb frag:     00000140: c6 fe f1 22 41 62 24 10 56 19 4a da b0 95 a8 34
  skb frag:     00000150: 28 da 38 7b 66 6b e0 c3 c6 b3 72 50 dc b4 a8 25
  skb frag:     00000160: 46 5f 10 39 c2 59 99 f5 f8 ca 91 1a c7 63 8c 65
  skb frag:     00000170: c5 95 68 73 08 b5 ed 74 9d b9 bd 05 d5 16 76 d8
  skb frag:     00000180: 5a 0f 4e ea 70 58 f2 bb b0 2a 7d 1b 53 0c 0e 63
  skb frag:     00000190: 87 9a 05 ed 9a 68 60 b3 cc 42 e5 51 b7 62 f2 69
  skb frag:     000001a0: 68 89 a3 3e a9 bc 14 3d 4b 96 f9 53 3e 0b 59 54
  skb frag:     000001b0: 54 57 2c d3 fc ca 35 ac da 0a e7 91 1f 73 ae fe
  skb frag:     000001c0: ec ff a3 36 4c 20 56 5f 0d 2a f5 80 44 e8 f2 99
  skb frag:     000001d0: 22 e8 8e 6c 19 26 d3 ec bf 8b ad b2 f4 8d b8 25
  skb frag:     000001e0: c6 17 34 31 80 76 98 8e 55 89 03 fa f8 56 eb 75
  skb frag:     000001f0: df c4 bc 65 3f 85 67 e6 5d bf 4c 08 94 04 9d de
  skb frag:     00000200: 7e e6 19 b6 a8 a7 8d 03 51 ac 39 ae 17 8e b0 5c
  skb frag:     00000210: 32 4d 98 f7 8c cb 8e 44 25 f1 56 6d 53 d0 fd 0e
  skb frag:     00000220: d2 5a ef 74 19 cb 1c c1 ae 97 fa e5 99 63 76 a7
  skb frag:     00000230: 94 fc 0e d8 97 68 3f 2a 78 64 e0 0c e9 b9 ef fb
  skb frag:     00000240: c4 18 8c 5c 6f 05 7c c6 57 95 85 1c 19 54 65 96
  skb frag:     00000250: 14 d7 f9 a3 27 69 29 d5 64 fe b8 87 c3 83 b8 28
  skb frag:     00000260: e0 8b 81 44 86 e9 37 da 61 9c 52 06 17 73 8d 36
  skb frag:     00000270: c8 01 f5 a2 06 2d 1b 4f 79 ea f2 f5 6b 14 23 e4
  skb frag:     00000280: da 7c 65 c5 f3 7b 1e 96 49 72 99 96 93 e0 4c 5c
  skb frag:     00000290: 42 72 8e f5 af eb 9f fc d7 d0 22 61 64 af 30 e8
  skb frag:     000002a0: d4 46 83 88 f1 f8 cc 01 eb 99 c6 8e fe d8 30 8b
  skb frag:     000002b0: 7d 01 db 89 b0 b2 9f 1f d7 19 ec de dd 87 9a d5
  skb frag:     000002c0: 7c fc 20 93 a7 36 29 02 6d 31 f9 92 31 7f 9b 7e
  skb frag:     000002d0: ec 4a 28 46 5f a5 92 7f 4a ae 09 d8 5c 22 20 27
  skb frag:     000002e0: 49 7e 81 bc 7b 9e 12 df 50 a6 af b2 16 80 ec 5a
  skb frag:     000002f0: 11 2e 5b e0 3e 97 49 70 04 46 37 1c 83 e8 a2 40
  skb frag:     00000300: be a9 97 6f 7c 68 bd ef f1 a5 d5 75 b8 cf 78 86
  skb frag:     00000310: 85 47 ef b6 9f 7d 68 c7 ea a6 63 41 c8 26 78 1a
  skb frag:     00000320: 38 67 90 17 c8 e4 8c 4d ef 1f 00 15 11 f9 5f 11
  skb frag:     00000330: e1 f8 89 93 03 cd e3 74 f9 98 aa c7 77 90 9b 59
  skb frag:     00000340: 25 b8 9f 10 7e 19 98 65 6d d0 51 67 e1 d8 cb 70
  skb frag:     00000350: 78 f5 65 42 97 a7 e7 a1 d4 29 fe cc 91 a5 1a d0
  skb frag:     00000360: bd e4 da 6b c6 f2 d1 05 5f 6a 1f 09 62 95 45 8b
  skb frag:     00000370: 53 66 ce 07 53 90 cb 54 82 3b 86 39 0f bc 9c 3a
  skb frag:     00000380: 03 6f fd 5a d1 99 79 e4 85 6a d4 16 72 3c cb 26
  skb frag:     00000390: fc 94 7e 0f 86 50 3c 44 4e 63 ce 5b e0 a2 e8 60
  skb frag:     000003a0: 62 3d f8 b0 a0 89 e5 d8 f6 2f 3f 9a 29 67 df 11
  skb frag:     000003b0: 61 fe 4e 94 01 6d 4e a0 ff 6e 71 b6 10 43 01 ae
  skb frag:     000003c0: db 23 59 30 82 fb 19 75 06 06 35 6d 9d e0 80 d0
  skb frag:     000003d0: 70 e3 d7 25 2c 95 63 e1 6b 71 ea 7f 23 b6 68 a3
  skb frag:     000003e0: f1 20 54 af cd 44 81 c7 d8 59 32 bb 1a 64 32 50
  skb frag:     000003f0: 49 d4 e2 d3 b1 9f e0 3a 66 36 ad 64 b5 b7 bc 37
  skb frag:     00000400: b1 ea 38 b8 b9 42 67 f4 61 fd 34 69 62 db e4 69
  skb frag:     00000410: 22 75 94 d1 97 bb 1d 49 40 b4 03 a0 78 32 60 00
  skb frag:     00000420: 6d 7e 91 f2 a5 44 ca 6e 4d 24 5b fc a5 65 8f fd
  skb frag:     00000430: c8 5b 93 99 bd 6d d5 06 9d 68 15 03 23 db d0 5d
  skb frag:     00000440: e5 2b 73 53 34 8e 77 35 df 5b cf fe 72 e5 b7 6c
  skb frag:     00000450: 72 22 42 0d 1b 37 b8 1a 45 ff d3 70 e4 01 67 b8
  skb frag:     00000460: d2 e9 05 cb f9 90 94 cf fc 39 b6 73 51 91 b7 e4
  skb frag:     00000470: 7d dc 95 6e a4 84 a9 ad 38 58 7c 53 77 40 c8 a1
  skb frag:     00000480: 67 78 12 7e b5 e7 49 f3 41 73 95 2c 6d 4e 6f 8d
  skb frag:     00000490: cb 36 9c 47 67 9c 66 89 00 bc 08 5b 88 40 19 d3
  skb frag:     000004a0: 94 f7 9d e3 ce 70 99 4c 33 66 c3 b2 00 0a 90 40
  skb frag:     000004b0: eb c0 79 d0 14 2b b5 9f 24 2d 77 47 0b c4 42 15
  skb frag:     000004c0: 23 09 c0 6e 38 95 15 87 89 11 59 41 da 03 a2 85
  skb frag:     000004d0: 24 68 aa 27 25 48 ab 52 2f 3b 74 ec 03 e9 a4 3a
  skb frag:     000004e0: bc 3b 0f 37 0c 56 ab 4d b9 53
  CPU: 9 UID: 0 PID: 0 Comm: swapper/9 Not tainted 6.16.0-rc7+ #177 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x4f/0x70
   __skb_checksum_complete+0xab/0xc0
   tcp_add_backlog+0x2b6/0x560
   ? kmem_cache_free+0x204/0x400
   tcp_v4_rcv+0x11ce/0x12c0
   ip_protocol_deliver_rcu+0x2e/0x180
   ip_local_deliver_finish+0x7c/0xf0
   ip_sublist_rcv_finish+0x6a/0x80
   ip_sublist_rcv+0x1aa/0x1e0
   ip_list_rcv+0xfe/0x130
   __netif_receive_skb_list_core+0x228/0x250
   netif_receive_skb_list_internal+0x1af/0x2c0
   gro_complete.constprop.0+0x108/0x150
   __gro_flush+0x9b/0xf0
   __napi_poll+0xfa/0x1e0
   net_rx_action+0x335/0x3b0
   handle_softirqs+0xda/0x2a0
   irq_exit_rcu+0x75/0xd0
   common_interrupt+0x81/0xa0
   </IRQ>
   <TASK>
   asm_common_interrupt+0x22/0x40
  RIP: 0010:pv_native_safe_halt+0x13/0x20
  Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 8b 05 6a 8e 51 01 00 2d df 3f 13 00 fb f4 <e9> 88 cb 00 00 cc cc
cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
  RSP: 0018:ffff888101cafed8 EFLAGS: 00000242
  RAX: 0000000000000001 RBX: ffff888101c695c0 RCX: 7fffffffffffffff
  RDX: 0000000000000009 RSI: 0000000000000008 RDI: 00000000017c7254
  RBP: 0000000000000009 R08: ffff888101cafe18 R09: 0000000000000007
  R10: 7fffffffffffffff R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   ? ct_kernel_exit.constprop.0+0x5d/0x80
   default_idle+0x5/0x10
   default_idle_call+0x39/0xd0
   do_idle+0x1ca/0x200
   cpu_startup_entry+0x25/0x30
   start_secondary+0x11c/0x140
   common_startup_64+0x129/0x138
   </TASK>

