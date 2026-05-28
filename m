Return-Path: <linux-rdma+bounces-21421-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGYREQL7F2oWXwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21421-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:21:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E976A5EE77D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3533156B30
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62E37267B;
	Thu, 28 May 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UNt44OUv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCA372071;
	Thu, 28 May 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956160; cv=fail; b=rp/EoNMpIUEwXRhh0aHTN6upYcd/9GuHrYhi2VGsgKJ597xRHE9Am81VeqQT1iFb5qBeSff3OAuM504GyThqyBg85Vrj571rxJ60Mv0/OxCuAbUL92co6Zh8iYYRrNSr9oamuZomaKyUEzFwK9xlB/1EzREBzfoZQFbUNkOhsWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956160; c=relaxed/simple;
	bh=H4jt4AtiAq1wfsapyyalHRxHKEXANXUyhhXiPsdK828=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsHO3sIP1Y9Lrtty9puSD9xxlCdHrpmP9vOYnlI/2mNqIvMkoguDboOUmFvjJjdffRBHBLMzB+KqOivBtGnVnVyrFCBfE3gWCuYGvkGlAWakoYbHZLWd7HKEq69obGOjRIFN59QRjaYbyllI623KPuQeqn7V20vU1zEJKY70Z8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UNt44OUv; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA/DaobnFFq2RfszbqtNE8FodTopGvp+haOQYPakbzsFjDLHk5agxza+wJKd0KIXqwD5TcrCv4wj/WTn/p5zUARLeoXec0ujWOV7nyWDFMwHihAspAXtUA6lO8i+qFJl+A3UqARxhhteZ0RPLqVnIWDh4zAPjygclxpqjnwYYhSctN2tamnsLvXRPZut19kuu5q5Ex7HQIhSOxfw4nLJn7r01uuaCM/0+IbjzDH2XrVTbQn5wzr4a6aBBdpIKpXi8OD3VUbzzfaSUCzqMQk5JXIC+vjoaQw12bOGoMgp1RARQSHsZtwh1oLCI7pzLE1Dz0hB4x9KRl7EOr0zH6rGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svXbTba++TaIm9BJXMbfYkoPS8O4doA+g2J5da8GG8M=;
 b=OFRs+De1VvWB6+oRxws/fvwH3oDrGKgnLbSdO5SjZH3pbHDWrxrmaN9aLCS3M7zts7UXBdaS2AWqSKl10wcnF5s5h0JepSq+y9DPtVN81SAboF+ISXI7cqO7oM0V6udb9CsuTt3OW3yvgRXB4rZy1yO6inwni8P14qec/KmeAwUBISHIO6P2ovlv4OvQUNh+uaBUwfXZudbm6HS5bKehvikllfO7khOHzIMknJTpZhMoyrxbeMRHPbaDtoiisBaEZ0GSS/jX59Q30zLkn1WAL2DC5Zifgwbl3FSeF6Xj7aNc0Gtql/k5bfW5Yd2wlecTaF0S0YG+db8qjW6s3WDDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svXbTba++TaIm9BJXMbfYkoPS8O4doA+g2J5da8GG8M=;
 b=UNt44OUv0wjr7Ipq88dVH1fGgFJgbzQ5CDzpcelpbXSrrATbK11JDQrJtj2ZAccjIl52BEUBPY5qW/LRBTQ13GRutPTYX3e1VYEcTcGuTuHLVC9QPQqYr/IZGcSibePmNxvwk3JJQRI9pHo6CRJVEoX4snmMj6RGnpct7Yd8/PP6MNv/2WFAVUw2rvnKTZHml+tBwmS7Q2zgl4BLNyjlFgvVqT1aaajRW3SfNLCGqeS+vAHqKxiDANFaAhwBQFwjBUfz3oY1X9c+KX8mX8t25jpC1Xt/qX6HR91Aiih66/N/doiFK9LuYk5SPElxc7kbgH9N+z9JJzz0ny1RUCMsSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 08:15:54 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:15:53 +0000
Message-ID: <e4f4a6a5-9be0-462b-b4d7-8bbf57001cb4@nvidia.com>
Date: Thu, 28 May 2026 11:15:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com> <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
 <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
 <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
 <ahZ9CgIWdjny4N4D@FV6GYCPJ69>
 <b26b9866-440b-45bf-9d2f-7c4d3193c793@nvidia.com>
 <ahafaNDr0x-lzA7F@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ahafaNDr0x-lzA7F@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: f7364caf-423a-4901-da37-08debc91562b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|5023799004|11063799006|4143699003|22082099003|18002099003|11062099010|6133799003|3023799007|7136999003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ozaw0jHwPAe847pAyVVgbuPA6JxFHDpgzuhiaacEt+hXn+Pkkme3wkmYEx0Iupr5BWP2fN81y6ZM0QdgOkGnuNq6PpaRiNvj6zdzIqlbWlylvlsCP6/IiYQUcVspn4yp5Yh4y+cDCGAMD7K3V8rN/979sgSed7Eg37bCqY1uQ2FaMBf5sTm3NtgdVDUUE4wBFxtggfBDqUlw55FK1CoM0d4piYYx31P6SFuyq8vC9VhdfS13JnrEB/chWeWTZUmDHSdgu68A+4AG1KF6gnwdEIsJbLuAPEmer2nDVXSsTxPSELbGaCttWhpA3ZnM1DIlB2ZQLT9JYnngparO0eWsimV5IMlY3Q/HMsI0LhftNw8blJG1BYS/vQjQ7qtOSrExMqxaQ6DpGjZKrWBWsb0Ddif+XpyRwY1PLvYBTVB2YvVP6IXqMU+iQxg15d/JLRgF4rYineyaLrgdOQJOJ/a6CofvCjYRj13IE/oYLr6txy4jq5QDgrlEQqjiWjhN1vyNJyqg4okCjB0ghEDT8QQCmx355BvV4bQ6UQnR0rvWhI3E1/hKTagNz8bfrxKGg+2znP0AWor3JzyHRiaiWaM2nxzS7kyGP/V63R3BU1ZZOhj/EUbUgpTWh5BX99oI+TPkW2PMvKuE2NlCAveTYb+t44uNzS2v9qhV/ItndUAHhODSk84M2r9goLGLuk8nQin0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(11062099010)(6133799003)(3023799007)(7136999003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGQ1V0RYaktuNXFSTmpZblROWGVYZVpubUZjSXZIOFFyeTE3YVFCV0RFYkk5?=
 =?utf-8?B?V0J6S2w1QjkxdWZVc3ZhWWpPemZEanRBSXhGL3FsNmVjdWFjTTcveU5NV3Ax?=
 =?utf-8?B?WVJ6OHlNdUprb1J3cmtRdXV3amsyM2pQQ2hCNTJtQkNVdGlTcm9MWTJvL0dO?=
 =?utf-8?B?emVWNkVJdFJxTTVnTUQ2d29BT0plTW1WQ2lXcmd2ekxrZTRLaTZYNnR2QWJk?=
 =?utf-8?B?S1pwV2gwTnlBUE9JZEV6azFyN2xnWWNYWjljTFkvL0xMMFFkQlA2Z1MxV0xB?=
 =?utf-8?B?S3VIdnNpaWR4WEZ5NFY0K0ttOUZTTG9NY1dwNDBCc05QNkFIK0g5ekZETG9J?=
 =?utf-8?B?Q1BCN1hsOGRIMjg5WHB5OXE0T0E2VkowVG1wbkpaRXJZZGpzVzBldXJHbnV1?=
 =?utf-8?B?RG9VbFRjb0FJOUtQc1JxUnpkcmRFZWl2QVlWSFo5ZVJOYldHUTFHRWQ3SVBt?=
 =?utf-8?B?Mkl0ZVJwbUVma2JxbXFCKzlpNlpYYWFRRjdOb0U3N0FuaUx3U1RPTW9hSnVq?=
 =?utf-8?B?UWJyWjVVMjdDeDNwM3V5ZkxUN1ZSbjBWd29EOFp2T1FtQTRXQy91L0h2a01S?=
 =?utf-8?B?MGNKOUNPelhjV0JFTlRUOVVkOEhCcEZLVUFqSnJyNmh3anZEREdlY2xqYTRj?=
 =?utf-8?B?TlhnZjJYSnlJZ01WdDJTTUt0M2pFdk5yWUxBQjZmQTZJUkU4bStmekcxem5l?=
 =?utf-8?B?STU2d1NQZTY2cWhVMk9Ed1dQRk1FaCtLb28vaXBuSDFGY1N5WUtJUkE0WVo4?=
 =?utf-8?B?emNyRVpEa0tWTVVTbmEvR0xHY1dVWGsraUVhMm1sa2M2WFk5ZnJCdXQxTGt2?=
 =?utf-8?B?WVVuWHNWWTN0L0N4ZjBtNngyRjgyVUZsSzJ1Y0lJV1VvYk9rVDBWNEQzTitN?=
 =?utf-8?B?dmRyaWR1ZHBJWnE2RVYyWitLZWZYcy9xWEg5NHRMNzZSa3ZlR0U1aGI3cTB5?=
 =?utf-8?B?ZUdGTlV6UDdiUnNlTHJKM2dYZldDcWN2YXlabTRlc3llT0pWOStSZC9IOUJl?=
 =?utf-8?B?SitDRGVFbGNWQStWZHJHVTNvSE5CSkNNMFgvZnFKS0p2aitpNUtXNUFHeU1z?=
 =?utf-8?B?cldzTGxtc081Zm1GOGUwMkRheXhIZTdLSHFVeDMvWnVLWkZ5R2pGY1F0SUw2?=
 =?utf-8?B?VFMvTmY0cENreFhPOHZsanFEWVZRclJmNFFETzdRZWY1SUpwam14eG5NNlgw?=
 =?utf-8?B?MU4vM3JOSzl5MjFYcTVNekZZcTdjZEc5Tk1vWlhKRWlCZGtwRVV5VVNUUWt6?=
 =?utf-8?B?YWZTeFBPTWdJLzZadDg3d2JtRjNoTWxqeU03QnV5TUhuRGwyc1NDcHprSVIz?=
 =?utf-8?B?ZXVyRGR5SnlxNHlVaWVzUzVwU0JQN0lwenBXeUprMHhoMEs3eDJJMVFqa0ww?=
 =?utf-8?B?a3Btbm1UcU1DbU5lbGhZdlB1UjhNWjVpQUluUjM3eGV6MWF3TG0yMkhDKzVz?=
 =?utf-8?B?OElxVVRmcm5OL21waXlZeEVvQUZac2ZXcWdyOFN1dXM1NUZjU0Q2ZXBtN1dJ?=
 =?utf-8?B?R1NBQ1ZUZktWOU44QzdhdEh5WUJqT1FrdjB2ZGxIMmxLaEZudHVyMUF1L01P?=
 =?utf-8?B?UkdmbTJvV1llVWFGYjR0MGppZkRuL05pb3FWMTVPbXZiMEdoWHliT05PQ1NV?=
 =?utf-8?B?L1N6TSs2NTBHTXBybEZZbkQzU0RIejQwZU1NQ3lXQkwxNW1XTVk5ZytvbUpH?=
 =?utf-8?B?VVExY05wZ2k5QVR6M0twMjFJSk1hbkVuc2Y4aDU5K01URWRaSnY4NDFuMkpG?=
 =?utf-8?B?WWFsZ3RLYzJaMEVRdzRndHVVOGU2dG1rUlFiRkxmazNIMnZjMC9ZY1ZqQjIz?=
 =?utf-8?B?dXk1QUhyU1ZNMHorWWp1QjR2WG1VOFBkVnJOckZoQ0grQmx6ZTByMHJMWm9r?=
 =?utf-8?B?OGNjTmV2YjNFSHArWDk0UytSeWYvOFM2TzVPZ3RKWUZzdDcyVk1wZy9oMTMr?=
 =?utf-8?B?cE9kUDYvYkIzM1FxUmpPbFZkS2NPYUZTdWpxSFlpZ2EzZEFhaEN0Y1lDYUVx?=
 =?utf-8?B?UXkxT3EzU2VMMENVQ1NVa1pOOVZVMHJIYzducEdvRDVGR1J3bmZVMmhDSm1q?=
 =?utf-8?B?RDZFSlJyT3E0S2dVbTk3eFFwZStRUGhKcG9peTdsajJmMmkxRmc5UnZYbVR0?=
 =?utf-8?B?NWJsYjB6UTJ2bmpWQk1NUTVjWThNbU52VExldjFibzRSczlWNlBWMzZJbkc2?=
 =?utf-8?B?R1psZ2ZlNkFKS0NKRkZwRzdXTjIzUDBWRm44M3lOVllCWTk5SjZpUko2Wm1N?=
 =?utf-8?B?TUZyNW8zRDR2TEk4WlV3cGtLbzZvWXFOK01CdzloRmxNcHFHVnVlR3g0c0Qv?=
 =?utf-8?B?MndCTUV5QXJTSVA1TVpRNjNmSmJZdmRyS0Zhb092ZlNsSjRjNk90UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7364caf-423a-4901-da37-08debc91562b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:15:53.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8Qi30pPsCxMgkNn8xOo8Czo7AfN4Dgk+vmcV12ycxTyRVwYzBnjxYHdFlHExPlsm0EoyZJYIcQwjLNSTHvQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-21421-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: E976A5EE77D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 14:18, Jiri Pirko wrote:
> Wed, May 27, 2026 at 09:03:26AM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 27/05/2026 8:14, Jiri Pirko wrote:
>>> Tue, May 26, 2026 at 07:13:46PM +0200, mbloch@nvidia.com wrote:
>>>>
>>>>
>>>> On 26/05/2026 19:23, Jiri Pirko wrote:
>>>>> Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>>>>>>
>>>>>>
>>>>>> On 26/05/2026 17:07, Jiri Pirko wrote:
>>>>>>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>>>>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>>>
>>>>>>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>>>>>>> device initialization while holding the devlink instance lock.
>>>>>>>>>>
>>>>>>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>>>>>>> operations are available, so the default eswitch mode can be applied to
>>>>>>>>>> the matching PCI devlink handle.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>>>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>>>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>>>>>>> ---
>>>>>>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>>>>>>> 1 file changed, 17 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>>>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>>>>>>> +	int err;
>>>>>>>>>> +
>>>>>>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>>>>>>> +		return;
>>>>>>>>>> +
>>>>>>>>>> +	devl_assert_locked(devlink);
>>>>>>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>>>>>>> +	if (err)
>>>>>>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>>>>>>> +			       err);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>>>> {
>>>>>>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>>>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>>>>>>
>>>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>>>
>>>>>>>>> I wonder how we can make this work for all. I mean, other driver would
>>>>>>>>> silently ignore this command like arg, right? Any idea how to make all
>>>>>>>>> drivers follow the arg from very beginning?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I have a follow-up series that adds the call to all drivers which support
>>>>>>>> setting eswitch mode. When going over the other drivers, what I found is
>>>>>>>> that the right point to apply the default is driver specific, drivers
>>>>>>>> I have patch for:
>>>>>>>>
>>>>>>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>>>>>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>>>>>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>>>>>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>>>>>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>>>>>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>>>>>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>>>>>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>>>>>>
>>>>>>>> I don't think doing this generically from devlink is realistic. devlink
>>>>>>>> doesn't really know when a given driver is ready to change eswitch mode.
>>>>>>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>>>>>>> be ready first, and the locking is not identical across drivers either.
>>>>>>>
>>>>>>>
>>>>>>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>>>>>>> of register. Multiple reasons:
>>>>>>>
>>>>>>> 1) end of devl_register is exactly the point userspace is free to issue
>>>>>>>    the eswitch mode set. Driver should be ready to handle it.
>>>>>>> 2) all drivers would transparently get this functionality, without
>>>>>>>    actually knowing this kernel command line arg ever existed, without
>>>>>>>    odd wiring call of related exported function. I prefer that stongly.
>>>>>>> 3) you should add a there warning for the case this arg is passed yet
>>>>>>>    the driver does not implement eswitch_mode_set. User should
>>>>>>>    get a feedback like this, not silent ignore.
>>>>>>>
>>>>>>> The only loose end is see it the void return of devl_register().
>>>>>>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>>>>>>> probably just go for pr_warn, seems to be the most correct.
>>>>>>>
>>>>>>> Make sense?
>>>>>>
>>>>>> I see the point, but I don't think devl_register() (at least not the only place)
>>>>>> is the right place.
>>>>>>
>>>>>> There is a small but important difference between userspace doing
>>>>>> "devlink eswitch set" after register is done, and devlink core calling
>>>>>> eswitch_mode_set() from inside the register flow.
>>>>>>
>>>>>> Some drivers call devlink_register() while holding the device lock.
>>>>>> liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>>>>>> there, we may start the full eswitch mode change while holding that lock.
>>>>>> That mode change can create representors, register netdevs, take rtnl,
>>>>>> allocate resources, etc. I don't think we want this to become an implicit
>>>>>> side effect of devlink registration.
>>>>>
>>>>> I believe your AI may untagle liquidio locking :)
>>>>
>>>> I didn't try to solve that one with ai. Most drivers were fairly simple 
>>>> so I didn't use ai at all. bnxt was the one where I needed a bit of help :)
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> For mlx5, the placement after intf_state_mutex is also intentional:
>>>>>>
>>>>>> mutex_unlock(&dev->intf_state_mutex);
>>>>>> mlx5_devl_apply_default_esw_mode(dev);
>>>>>>
>>>>>> We can't call it while holding intf_state_mutex because the mode set path
>>>>>> takes it internally, and switchdev mode may also create IB representors.
>>>>>>
>>>>>> Also, devl_register() only covers the first registration. The mlx5 call in
>>>>>> mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>>>>>> In those flows devlink is already registered, so devl_register() is not
>>>>>> called again, but the driver state was rebuilt and we may need to apply the
>>>>>> default again.
>>>>>
>>>>> Call it from reload too, right?
>>>>
>>>> Yes, that was my first thought: apply it from devl_register() for the first
>>>> registration and from devlink_reload() after a successful DRIVER_REINIT.
>>>>
>>>> That covers the clean devlink reload path but....(see bellow)
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Same for reload, fw reset and pci recovery in general. If the driver tears
>>>>>> down and rebuilds eswitch related state, the place to apply the default is
>>>>>> in that driver's reinit flow, not in devl_register().
>>>>>>
>>>>>> When I went over the other drivers, the right place was not always the same
>>>>>> as devlink registration. I'm not an expert in any of them, so I hope I got
>>>>>> the details right, but for example octeontx2 AF needs sr-iov and the
>>>>>> representor switch state to be initialized first. nfp can do it after
>>>>>> app/vNIC init while the devlink lock is already held. liquidio should do it
>>>>>> only after dropping the PCI device lock.
>>>>>
>>>>> Idk, perhaps do it from devlink_post_register_work of some kind? That
>>>>> would allow you to have the same locking ordering as a userspace cal
>>>> l.
>>>>
>>>> I thought about a workqueue too, it was actually my first idea.
>>>>
>>>> The problem is that then we race with userspace. In the mlx5 version here the
>>>> default is applied while the devlink lock is still held, before userspace can
>>>> come in and issue its own eswitch set. If we defer it to post-register work,
>>>> the devlink instance is already visible and userspace can get there first
>>>> and then we might change the user configuration.
>>>
>>> Figure that out and expose to user by setting xa_mark only after the
>>> work is done? This is doable.
>>
>> I agree that if devlink can keep the instance hidden/unavailable until the
>> post register work is done, that solves the initial userspace race.
>>
>> The other part is the reinit/recovery case. For that I think devlink core
>> needs some explicit indication from the driver that the device is now in
>> reinit. Something like (at least that's the code I had initially, but something
>> along those lines):
>>
>> void devl_dev_reinit_begin(struct devlink *devlink);
>> void devl_dev_reinit_end(struct devlink *devlink);
>> void devl_dev_reinit_abort(struct devlink *devlink);
>>
>> The core can then mark the instance as temporarily unavailable/in reinit
>> between begin/end, and the relevant lookup/dump paths, for example
>> devlink_get_from_attrs_lock() and devlink_nl_inst_iter_dumpit(), can reject
>> or skip it while reinit is in progress. devlink_reload() can probably mark
>> this state by itself around DRIVER_REINIT.
> 
> I believe this is orthogonal to the problem you are trying to solve in
> this patchset. Not sure why you bring it in to the conversation...
> 

I brought it up because I was also thinking about reinit/recovery flows, but
I guess I can tackle that later.

For now I can focus on the generic devlink path, move drivers to register
devlink only after the device is ready. Then devlink core can apply the default
before exposing the instance to userspace.

I think it is better to fix the ordering for all devlink drivers, not only the
ones that support eswitch mode set. That gives us a consistent model and makes
future defaults easier.

Reload can be handled from devlink after successful DRIVER_REINIT.

Does this sound ok?

Mark

> 
>>
>> Then mlx5 would look more or less like:
>> 	devl_lock(devlink);
>> 	devl_dev_reinit_begin(devlink);
>> 	ret = mlx5_load_one_devl_locked(dev, recovery);
>> 	if (!ret)
>> 		devl_dev_reinit_end(devlink);
>> 	else
>> 		devl_dev_reinit_abort(devlink);
>> 	devl_unlock(devlink);
>>
>> This gives devlink core a way to know that the devlink instance is registered,
>> but should not be used by userspace at the moment. It also allows keeping the
>> default/config apply logic in devlink instead of adding driver specific calls
>> to apply it in each init path.
>>
>> But this still means the generic solution needs some driver help. Drivers need
>> to register devlink at a point where the post-register default apply is safe,
>> and full reinit paths need to be marked with this begin/end API.
>>
>>>
>>>
>>>>
>>>> Also, the bigger issue for mlx5 is not only initial registration or devlink
>>>> reload. Some recovery paths, pci resume, and fw reset flows rebuild the driver
>>>> state without going through devlink at all. I did not find a clean way for
>>>> devlink core to infer all those points by itself.
>>>
>>> If you don't obey current configuration for example in pci resume, it is
>>> bug and you should fix it. All these flows should obey current eswitch
>>> mode configuration.
>>>
>>
>> I agree that the device should come back according
>> to the intended high level policy. But I don't think full reinit can be treated
>> as restoring the whole previous runtime state. There may be user created
>> steering rules and other objects which the driver cannot keep or replay. Today
>> full reinit brings the device back to a clean initialized state, and that is
>> intentional.
>>
>> So the split I have in mind is:
>>
>> - full runtime state is not preserved across full reinit;
>> - high level devlink policy/configuration should be applied when the device is
>>  initialized again;
>> - the command line default should not blindly override a later explicit
>>  userspace eswitch mode selection.
>>
>> I am not against moving this into devlink core, and I am willing to work on it.
>>
>> But before I rework the series, I want to make sure we agree on the direction.
>> As I see it, doing this cleanly needs a devlink state like "registered but
>> unavailable/in reinit", plus driver annotations for the reinit paths.
>>
>> If this is not the direction you want, I prefer to know now rather than spend
>> time on a version that will be rejected anyway.
>>
>> Mark
>>
>>>
>>>>
>>>> To handle that from devlink I would still need to add some api for the driver
>>>> to tell devlink "I just reinitialized, apply the default now". but nce I had
>>>> that driver call , it felt simpler and clearer to let the driver call
>>>> the helper directly at the points where it knows eswitch mode is safe.
>>>>
>>>> I agree that handling all of this inside devlink would be the better option.
>>>> I just couldn't make it work in a clean way.
>>>>
>>>> Mark
>>>>
>>>>>
>>>>>>
>>>>>> Mark
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>>>>>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>>>>>>> would just ignore it anyway. The follow-up only wires the default into
>>>>>>>> drivers that actually support changing eswitch mode.
>>>>>>>>
>>>>>>>> Mark
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> 	return 0;
>>>>>>>>>>
>>>>>>>>>> err_register:
>>>>>>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>>>>>>> 		goto err_attach;
>>>>>>>>>>
>>>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>>>> 	return 0;
>>>>>>>>>>
>>>>>>>>>> err_attach:
>>>>>>>>>> -- 
>>>>>>>>>> 2.44.0
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


