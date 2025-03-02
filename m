Return-Path: <linux-rdma+bounces-8227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFAA4B071
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480AB7A71CE
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37B1D514A;
	Sun,  2 Mar 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dC8upmTc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0EEEC8;
	Sun,  2 Mar 2025 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903488; cv=fail; b=Ww0lYRO/hqaIdTbiM76UuIlgh5DO0YOCsmw1UHXBhoLsn+1JDD0MWihDSBkUHOpkXX+5HVcZqrOu+pHoWSrq6qgyXPi3w9HIEquV92CLwx6DrvZRlu91agBS8CWUV6bdJ+vxn3mJ38zNEZ+EJkBTjzZ3z2Mh9GuAC2QLMInwUXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903488; c=relaxed/simple;
	bh=UTDoLUhgNCJiQOU1Q7FeEGtECsp7VC5im7NaJuqhvW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qk04zj5s8NGmSOIEaYSwmQ4Vk4qJbS89ODx5nSarG1I/RhDP5a6X0RWLvm3QaKddHhXTuHoqt53i8sC6ialegaeBaB+04cKWM88t/eTYHfHs9tgz/ELTFEYwrG0PkClaoQarCEHuXFr7sqAxgznLtEyfNPMZ8PSnzxtM9QfWrgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dC8upmTc; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUMwKPO2KPwpCHl4o6uqsRfYSnvtkvpvrYhYcuDALRNOmyOTIczZkqHFiG7xh15kKfYxBr1GlFRQptbxisKcUSvkYD4ghjQdkfDHMwr1FTTsTl6D+0Vpw3mjVc/P3jwaUbacReUxB7qiLIPng2/POLPnx/ULViyWeLnrLBT/jrpOdCpr7cAmL8BUEhzPGy4yC6vGCk6pWEx52+isPdRa4TjBI7qnsuo/ek4bRii/lovaAdiwgL6Er2LUevmP+TsnlIyCrHrYAJfe+ucD5hWZJL23k3SUc1BitQ6QEqN4/OJMRUeu3RcUvxSOd7bqrA1UitMkSXZAf+JWjSVFx3SK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c2SmZ7jEB8ns3AFSyk8ANHwGKzeIqPTWEsdoPlqnwg=;
 b=wz1b3guO7tK1xCZEnYrPuvBWwbcZvX9+WLdKHvQRgT6lbypIiTOUL07zsJ8L0sekdhaiMLtp+a2sH2sePqR86RXGgQDz8Qfkd4+hoKQIXYSI4Y/QwsCKb/wniZFvETs1OgRtxbgRzjI57WrK1FT5HEDwt62NpxoSdLfnZG/BNWQz/Krgf9M04IttZho2UyxK5MYz6A2ys1cpRGLjCaSqvde6GEtcFAfIUxLXL/cdIdk5eWzRFfd7fG/nsOAT6Bez+3aYbtv7tiUziDkpDsgKgh8m6STt6BmduDLFy0eTp9vv8WBZhRPdP/70IlCZ1KEikUIXqzYJeLDNNUtMxFQNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c2SmZ7jEB8ns3AFSyk8ANHwGKzeIqPTWEsdoPlqnwg=;
 b=dC8upmTcPWMq/UYatHXFRWqrG7Qts3zOi+8igsa20/BtXrx4uBTZUxbzghCtNool+9u5rdq5idh/YcsypXVh6Q3dh76LHUA7c26ZqTZ10L5BfpB1X9whmRiH2j6BsTFUa8MRe8aD/FIaGqblhUQjzVY7AMrp1VRPo76AgMIycA9X/sy8YYMSxYVlZx4HDavxzkrTTemyxgVOipCJPHYnrIWtLUcHANgLgFzfjbjnUI4PQCjNh9vSVsjClHhkDobTm13RPS1AZ4qvcG0ZIpWhaMyQMKKMgaB5aN1ochfa0wWWPIxz/fT/Qf6O6Xo5oX4NmECmV02nwEvywyBMOs42mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Sun, 2 Mar
 2025 08:18:04 +0000
Received: from CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e]) by CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e%4]) with mapi id 15.20.8489.021; Sun, 2 Mar 2025
 08:18:03 +0000
Message-ID: <c57977d0-5af6-44b7-80a4-00024f3e5e49@nvidia.com>
Date: Sun, 2 Mar 2025 10:17:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net/mlx5e: Enable lanes configuration when
 auto-negotiation is off
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-4-tariqt@nvidia.com>
 <20250228145135.57cf1a73@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20250228145135.57cf1a73@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To CY5PR12MB6322.namprd12.prod.outlook.com
 (2603:10b6:930:21::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6322:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 7116edca-16ba-492e-8077-08dd5962c0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGtBbFQ5c2d1Vy9WVGlaU05CNENucVd0R0lFVTAwM3NaVk55Qjg3Y1U0bWtE?=
 =?utf-8?B?VmFaU0VpbEJrQUNVZHIvMXBxWmsxVkNLODRDZlZBU0FWc253QzM0NlZCU1dY?=
 =?utf-8?B?dGs2NFlXSU9ZZGZtSXZQemp4a0pXaXRaUE9iLzVQMjU0eUtFZjQrT00zTTFX?=
 =?utf-8?B?OGxuWFd1b0lkVk5LSnJhYUI1ZjgxdjFUNDM0K1JoZE40NlVoV29VN0VyQmFV?=
 =?utf-8?B?V0lCc0Rka29WWlpUdzNwOXFTQkV4R08rWHJwbEp6ZTM1NEVzWTQyQnNTdmVh?=
 =?utf-8?B?ZXhoVVNOTjl4aWhGY0RPMmZ3WjV3dnYwSkIwRU1VSGIrTjZpNWo1TEpFOGRk?=
 =?utf-8?B?VW1oaGlnaktCVkRsbTdGbVA5cU51YmlQb1BNRDZ5R0dEbk5tckMrRkFlQ1V2?=
 =?utf-8?B?MTZRSFZrUEZ4cjhqQlU3T1podW81YlN3dFdJTlo1MGZhMStBWjhOYzd3c2Rx?=
 =?utf-8?B?U1oycFVYT29ocXRncmZoUFRqUDh1djIxTDRiRWNFbkwwRkgzYmRMdFdJZWlz?=
 =?utf-8?B?N1VNQXJHdDBBUnB6M1IzZnJobXc4UHp2cFhvaUhpeit5WVN6b3BqSFp5YW1S?=
 =?utf-8?B?YUJDeDMzakdGclpqcEcvM3dPVlZwNzd1VFlvMWxFU0d4VGZ4Y1BSRGswckZW?=
 =?utf-8?B?NHh1eS9oK0t6WGZwQWJ6YzhjWEJwWVhFR1hGa3dRTGpaVUVXRFN0dVlUeDR5?=
 =?utf-8?B?WnpBalJURUVETHlYbFljSHVRNk9yd0xUM2gvVEhNT0V0L1pwVE1iTGhPMjM3?=
 =?utf-8?B?L2tsd3ZDU0pzcHpCcG5XSHhBNmo3M1B5ZlVjSHlZOVg1bTdwQSsxVXE4Rnhs?=
 =?utf-8?B?cGpuYWZ5Q1BqNndTSEhDcjJjVGM4MWd4aWlWT1EycGppMUhGcHZDRXpwaHBi?=
 =?utf-8?B?cUNnSS8zNFJLNjVxSk82WWJrcUt6QWw3UUcvSi83NlhUcHRsQU5ZRFdNWnhV?=
 =?utf-8?B?MWIzT0p0dmkzbENpSkZlMEVoWG9uNUlFUWw4QW1uZVEzZzlzOHo5WXlqZWRQ?=
 =?utf-8?B?dnB3WnZPYTQrU0FFbitwNjBLR3YwTExWTlFCcGlpbzJCL3MraWhMUm1CbDZK?=
 =?utf-8?B?SGcyaHpmSmNVanhUYW5OUGl5V2Fzd1NXUUNjTFJYTlFXc3JVQXhISVZ0dE1D?=
 =?utf-8?B?dnZTS3A1dGczTVgzUnVjMTRoNmxlYzV3R0o0YVhuTTBoVHNzRjY2bzJubUo5?=
 =?utf-8?B?MkRvYWgxTTBtSjk0L3p5ZW1oV3UzTzFsYkVVR2NyWkZTdVVPY1ZvNDdSOGpJ?=
 =?utf-8?B?Mk5JUjhONmdVMHd4aEN0Vy9tOXQvb2l2R09VTmdKa1hPY0Z2bkgyS3N2VHhy?=
 =?utf-8?B?UDZnZEUwc0RkZVJPMmVkWTgvRE9OcGxQamZ1SURnWUJmT0VSeWFjRFBwdG8z?=
 =?utf-8?B?SFphS1UrYVVKRlVBcDBRN2U2NnVPaWJBZ1NLMDdZVlZiTnRvS3M3SzBVd2lH?=
 =?utf-8?B?YWR3czM2eFJMc2ViYmhyMEloczB2b3VqTmJNd1FVcURQK3JhUzdKdWdDYmVT?=
 =?utf-8?B?TkZva0NGLzNzTC9tMXFqYi9kZTN4R2gvaXVLNzc0SFU5dm1aV01LVDBxSGo0?=
 =?utf-8?B?cFZTaWlDdmp2U20rSGszUUxxYUF5QTdBVEhkL3c0dnkzQXZPUUtHakFwTHVh?=
 =?utf-8?B?ekpqaStYOVdWaUhTTW5lWGlyTnFsZ3RrTi9TRHJHUFZuRHI3eWxhcEdFOFQv?=
 =?utf-8?B?VEMyUDU1V0pyZnd6b3R2QmxQN0JGYXVZcXRzNXBEZko4MnZNNENwdGN6V3JP?=
 =?utf-8?B?WEMya0JISGN3dHkzZmVZTUp3K0E2K2JoUEhCRGFjMUk4aVp4a2dMLy9pQ2VG?=
 =?utf-8?B?cWVFMjdMUjJ0SVJJYUhxUEc3NWZLem1FZ09waFR5TFVEdElIUFNYTldya2Rz?=
 =?utf-8?Q?KaD65QbM6jsPy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCs3WjJQQjZrMVVDV1NpdVlWWjhVK3F6K1JTNHJoSldYaWNXczRWYXl1T1lG?=
 =?utf-8?B?UE1vWUE5Q0F1T05SQk1XTU1RUVVNOUtlMkVNc3E1MDdleEU3WkFOZ0RJb1Js?=
 =?utf-8?B?NWpSNlNaWlZwMlQvMVJwcnp2My8wVWwvSVBHbTNtOEhrS0dXcnpRNjV1TW5M?=
 =?utf-8?B?WFg0TTVOK1h3bWFFb21IZHJaQnZhTnVKRVVVa29MTUFPS2lEZjVxczdPR3Yv?=
 =?utf-8?B?bEtLelVGK2NHZkw5RUZ2OGo4blRFV3Z3Sm1CQVZ1MDVnWDNxSTI3SjI4OWVp?=
 =?utf-8?B?YlZaMmo2YUNyc01wVzJBNzJVVTVqU0tvbENZUHFhWU5jdU9nZVQ5OEhldzBz?=
 =?utf-8?B?YVBvcjZad1BXNVJjeGZLQjRpcmQydVRIYnRtYlY2QXNLemxpbnozOTM4bmV6?=
 =?utf-8?B?V0ZpRzRKUWNTQkE1Q1htU2NKL2kzUUpuQkZQaVJIR0dFaWwrWHg4ejAwbWFa?=
 =?utf-8?B?VlNJdmI5RmZheEx6WlZVWkMvckE2WG8zb1ZvN1hhbGpDVFVla1NySkpiOTIy?=
 =?utf-8?B?UlQ4U0hLc3NETVdTQjlVZWZEeUJEYTNmSXN2UHFEVUsvUGlVdHpuR1VSMXpz?=
 =?utf-8?B?U1oyMmVidHJZWmZ3N2NpY252ZFd4dzZtZThtendmR3ZxaitWVkYyT3ZGM1hP?=
 =?utf-8?B?dFVZR2YzcXRqZ0ZGUlZ1SG9qWGtneXZqZ2dNcnk0LzIwVzBvaFFyMGFDakdM?=
 =?utf-8?B?eUtQWHVROTRSdGkrQTJUVmNvVnlHU1c3cDFvS0tNUFpZVzVYcjlIUnllWTZ1?=
 =?utf-8?B?VFNwcmIyMytjMFBWWEJKeWNTT3FtRktqeDQ2bk1IakZob1BzeGVSYVozWFpz?=
 =?utf-8?B?MGdyRkhZcjY3akdoblhlUzhIeVBDU2JJdXRSMWpIMXdvZEc0U0pUMG9Pbkhl?=
 =?utf-8?B?ZXlGU1pOVm9RbUZjekQyaHpHbjVOTkxGYkpCdUZZUHhFKzVpbkVEalROdUhD?=
 =?utf-8?B?RWhZVEZ4MjI2VExiUVlZV25aSG53SnBUU2hDOTJnKzFZZTJ2K2JlZUc2YUJo?=
 =?utf-8?B?N1lDakI0NXZscEoyY25YdndYblhLcldYN2F2OXJCYmJrL3UzRG9kT1B0QVdQ?=
 =?utf-8?B?NjU1YW56UTlyeVpEVTJsbEVqY3Y5V1IyWlJXTEM0Vi9KWnlnVVAzeW5la055?=
 =?utf-8?B?a2djVmZ3ajE0ZVZkSjNyK0k2cDNEMlQ1QnZyN2dSYlFkOVdaVWtPSTYxRXBx?=
 =?utf-8?B?cElVYzB6MEVBM2RNZEIvYUVWbzJsQllDWDFKWXE1Q1pYWWlIR3BqMjZiYlpH?=
 =?utf-8?B?aEp6TkxTWWFJbzRUaTN6amRXZzlWM2MzTjZYeXpMNkZwYzUzM04vazFibEpU?=
 =?utf-8?B?MUFUQk1yTEdvZ1RyUkxsaDRSWWZqaUtTWWx1ZjR6aldudkFnWll2b3VvejEr?=
 =?utf-8?B?cDFiU1NHY3o0djhUbjM1Z1gyTHMxS1l2c2kzR0tqTi9DNVliYWhSRldndlFT?=
 =?utf-8?B?SlZaK1VrYS9sb1VMV2d5akVvTUF2MFI2YmZXb1QxQmJieGlMUmttdWZWMEF5?=
 =?utf-8?B?L3ZDTDNiS2pnWmJ5dXNySmlzYXVzeDEvZ1BtNnFSRUNYMjBSMEFFdDh5OUxU?=
 =?utf-8?B?L1R3cUUwZGR2VVozSWowdnQ0ZjFXdWxxcHk5bGt1RS8wb0QrVkgvZW9YRkJj?=
 =?utf-8?B?aDYxNGNPZlk2ck9SdU1YUW9XdWNnRzF6cjBTNFUrRmF2dzdlOTNmN3kycnVn?=
 =?utf-8?B?ZC85V1dmekJkRVlVWVM5V2kzbVRmdkFsZUdJdVBGYTNjc21uMkJ4SjJHNVQ4?=
 =?utf-8?B?MklBZWF3c1BLcWNweDNXandubFM4TVRXS3BPd1lOUlhtQUUwS0pzODZlYXVv?=
 =?utf-8?B?T2NoSEhjSmsyQVg4dlBDTDdQaDlPbllqZitUZVdJNFhsT2dwdU5lelRMOWdM?=
 =?utf-8?B?Z3pFaGNxZ1U4V3hoeWNRNElCL2VRUDZJWE1JaTZ0TGRITUtqOXBRdUsrblpv?=
 =?utf-8?B?UWtpcG54dEo5QUhyV0dFQ2RoRXFpeG9rT0pRMkZYcjd0NEtncXJYT2RUVnpW?=
 =?utf-8?B?K3BaUGNqdEZ6UUZ5OGhiVFdwNjQ4WW5XOVgzTHdNVytnenBlS1ErdnpKSzcv?=
 =?utf-8?B?QWoveHFWN2R6WjJrSmxFbWVRb2hWM29IMnJaNHRpQ2NSaHJzeTZGRGhQQjZy?=
 =?utf-8?Q?3HzURIB1/Icrc13fFmgt1ThoK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7116edca-16ba-492e-8077-08dd5962c0ed
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 08:18:03.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PSOhXlm2vwClpF3w485Rbm1oP++80ZdTxUwuE4xJORfa4who5ijxUQWgTQfK4hJvDT2ZdDtS/c5cgbzj4muNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677



On 01/03/2025 0:51, Jakub Kicinski wrote:
> On Wed, 26 Feb 2025 13:47:49 +0200 Tariq Toukan wrote:
>> +		if (table[i].speed == info->speed) {
>> +			if (!info->lanes || table[i].lanes == info->lanes)
> 
> Hm, on a quick look it seems like lane count was added in all tables,
> so not sure why the !info->lanes
>
it's for the case only speed was passed from ethtool (then ethtool
passes 0 for lanes)

>> +				link_modes |= MLX5E_PROT_MASK(i);


