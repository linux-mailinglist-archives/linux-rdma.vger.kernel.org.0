Return-Path: <linux-rdma+bounces-21108-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL2yM3UKD2omEgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21108-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:36:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F495A6037
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C97AD3181745
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE43D9688;
	Thu, 21 May 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihbMVqQ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090881EEA31;
	Thu, 21 May 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369405; cv=fail; b=qT18gJECTXEVz58stZPYCMlfdHT5mEdTgjcueywu6pbW0qFAlkXPSRsOdFQrbmcua0pfSxABtsfpmikQ4ppTSHEJgOM2lP8d21C51cfDC5yL36s+oIRopK41ha/0URNJjgGZckcGRpVUcJr1ukqDNtSimf/MvOH5cK+H/pvLjnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369405; c=relaxed/simple;
	bh=ku7r43FgiCKs+R4rAYUDf8S6SkIyjMaDMgBME4JoPQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kG2Xu+LxjlTfbdzKlDEUd5duegp3sgX3BmfEK65oy7SRzycf31ulIKDnmivbsljCvJrTLwPdtdIxfszxYLQOHzE/eK0MZYYg0gH5Em4Aze0nCkcNQ6TVcc6LDB/F45Uk2hNqyWT5Y6eSwoL9RUrcHqxEVWgeqI3n1OonPuW5lmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ihbMVqQ8; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X99wtmp0Rlqar47UhbpVrhv4hbgmWgJjCvCL0cNyqXZw0qqeSisgUGkTRBVjY11qVuDmHmkbb5hg0nxe1ndhqVLujx38EuEB86yVLfgq5rYuJKkGeLVH/NfEUEw41o6WUHJlZmWfeuae+5ujnPbppgyl0JsjPIb4pK7JcjMNWATx8d6PgkfUCt9HxH9VeAuAHQFtIhPInkHanLTGZVXMEJSC3Qs1UaWRG9ILYg4Sc5TUv55Qr4dtyw3uoCv9437PG+EdIfuoHeQDWCdvFyhxYiIn92mO+U+n3qZRWA8rq7RbkkU+8vwevgvw265dZG6FrGht4vft8nxbq8oD9V24jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t5AcE72z4++LgVgQmq7GMu5yvJPFq5uR9E1nKuL6mk=;
 b=UoMmw9YRqu+dSMwmJagE1zP3wS5j/Xfn2do7DJaU1YuIuOyW/pgq5pOD6q+YTnjteUAZy3p9bGqzojGzOcJuX8noF6rylYalmNQezxZCvhj+X8ROilQEcSbuZG8OoYojogqFnGILw1xiKSLu8OiKJaQlDcsmUpraPyI3R6aVYwsyunCMJFxVsD1HrmHBsUtow25LwUa9uwg/e8lNdQj/eg3zG9fXWenh+Lp499YARojYt24bPeEIf1uEzPlzyQu1RjdnJDBW5Ux928kI0rv+HVSriuei1lv93WignZ7XWG4x2tIEJG+W916vGlyRYwufbMuWAarg8NPfXQXy4xptYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t5AcE72z4++LgVgQmq7GMu5yvJPFq5uR9E1nKuL6mk=;
 b=ihbMVqQ8656RGYoGFE3pMkhYAgZwLFMgzCn+yEus0hbcB3szbrK5I+qt8gj+O1hcbMYIOLBQ4uJIzy3fn0GGZpNMaaGRa65iKmkzpWXhvQ2wAoLIcpKazuO7UdvKq6P9tthAy//tjgZbo5+nr+3nIQmnab2U+yvUKFzwvxwaVhX41DTBNz1dSZLIsERMbXK+7zcPkLtVSqdL2w4m4K8o6bPykd/xdqCVqXl9hDJoChLFcX/OQK0BZSirEWrtwRtc5vJeV3xmRAuwjKY1T3EdX6PJIlcO93VMHVU3y7PsBMt1NjXGZay7CqX/bAnWgAQXOcHy2LzMNhKhnhXYRvZhIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 13:16:36 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 13:16:36 +0000
Message-ID: <3bbcf456-322c-46f9-b238-88fb8ad227b2@nvidia.com>
Date: Thu, 21 May 2026 16:16:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
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
 <20260521072434.362624-4-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260521072434.362624-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd3fb57-5994-46a2-a09a-08deb73b2f5d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	o3t/UxLaBXxuFrNVdR5IHPeEBLYVFP4K1VKIDII4e87yh2nMwxYwlf2FC1NzYzmrz2S6TfRG3cTIpgRJHxTvpQygU6gSIXEw5ptJsbMXs7Sfd48V2SXXUkgYL/z9cnQSz0DbPTXmgG8Hxoop/VbRAmHf5rV7s1qlNRJPt11ImisTDwF3hfhe0rTWTi5VLqmOoxFyPjN+ub6iRyejZBect5heG8re1hHRQVOKN9FNnIyl96NEiNRo86JFslZVwZtFfbwtL4x4ievU/UAt7/P0bSZSma2OVG61OSUL1I7HNHFv5qmHKHXYinBkd9kVU6HCZnuW0E8aFOqHFl7Kw3UUED7CYf7MLpbatDTNj3GILZvgXoYsr8h1/Mmm1m3IHfjwIyQHYEt3sNuLSR4CenKw7t3dUItJPDF+na/TVUYxwCA6IcQ+B7yUJOgfAQPWTAuCjTx3kbzKnjWfsyk7ilRsGViFSqEebw997iKuOM+GMpdk+Ygp4Fw/VcQncp3WiH3VGi351u3yuQOryruMHngk7gs9uKTMuIfkVsKwlIgG28i6o207PTRIC7hXVHnFIPgZeTk7zXxY+yAuOUiWvIxYkSsZeh4TYB5W708813gK39Aub+PHEzUV8cLzx9WCMS3zIkH26n8jBcUl9h1Tq7e5FpcSaUDwOt/ixoO2o5Uachw94jgFAO8HmIi9c3Lc8mQen2iSfzc4EW+gwliOM8D3kw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2UwdHExMk9xemtTVmEycEtYYzZXMkJ1QjNKcFlQeVE0TlQwNWx6cTV1T2Ev?=
 =?utf-8?B?ZTdSNFphSlExWnJyb08xOCtXb0t0TjRVU2lodlJJa0lMRGNRUFdpSkVRVnNn?=
 =?utf-8?B?M0d3NktXQ254Z3lseXVxQTJuSS9yTWlNVjlnSktqbnV1M2x3a2JYN2dYbGpP?=
 =?utf-8?B?ZUxZaVBnaS9DbFdGbmdVKzZiNmZWN2xkR1A3Q0dPR29GRFNiUGhSQkNFQXFs?=
 =?utf-8?B?dlVQdCtFRXpvZzBSQzduQ0pSZXp6MTdXM1FDdjJyRjdCSmlOZDl3WjduaTNQ?=
 =?utf-8?B?MS9SU0EraUxSckZXSFM1NjFMeU54R3czS0tUNyt1NktiUlFmOTh3a2Y0bTJo?=
 =?utf-8?B?SEpCWXJTWUNZeitLMkVYWXdabTRJcnVvemQ3TTVVQXVHajRJbVJTMjMwZXlS?=
 =?utf-8?B?NUpyTzdEL3RKM3F0bjdNUDdCOVd2T01ST0NRNGM3akZhT1RibXhrbm5COEFQ?=
 =?utf-8?B?dU9RMmpMc2NqalpUR1c0cmtBbHhEYjdkOW1oc3FMN1FsVGZ6MXdybnBDNHIw?=
 =?utf-8?B?TGZUc2hwVFViK1FYdXNpK3YxN241TklaZHdYWGtrSGloZ09IaDRjQ3pVNmYw?=
 =?utf-8?B?RU9vOWZqbUxFT3RYZXk0UVpnKy80dGtnVXNsZ3h5TE5xeWFoWW51ajNsc0xs?=
 =?utf-8?B?U290L3FzbGNETU9XTWFJQThuMGJ4YldBM0oycENvRFhLN3YzaEZMMWszMm1y?=
 =?utf-8?B?c0pxYW14TjFQbjZBMVFCK0liWjZDLzB0alU5ZW85NTRMbGRramlodi9VTi80?=
 =?utf-8?B?K2pYSkFUMEtlSVYrOHdiZkVCTnFYbVNCR2ppTmEwQVhvZ1ZaUHFiVmV1MTAr?=
 =?utf-8?B?eVI3VGZaUXF1UGtXYTVsSzdPRnEydEx4RVk4dGN1WUFpRGo1aktLb2QvazhJ?=
 =?utf-8?B?Q2RNczVZQnYyZnVRYWlBb0VlTWVNQ2w3TlFYZTNBeTZ4QWZhd05IWDdocTda?=
 =?utf-8?B?Rlp2Wk5qZm83RlllWTIveUZDMGhLWStXdyt2bU00RVdIVFhrUGRFZE1PYUJU?=
 =?utf-8?B?cnI1UzkvWGFNN3JkWDRMY2VaQ1NqSmhEQlVCTFRPeXR5L3grZnFYZEQzVHlz?=
 =?utf-8?B?QU5UQWRLQU1LM0M3U0MvYjRva3E5d3ZwaExpbUd6ZWV0MUFjOExuVmxJdDJI?=
 =?utf-8?B?cittcWZFLzVoM0x2MnVob0dWU1Nhelp1Mi9rSVdNd0k1azFEcjJYbGZ0RDR2?=
 =?utf-8?B?bWpGaGFkTzFXUFA1azFQdktFUldLUUhzWkZGT3kwMVRtcWVCV29tb1ZBcGZM?=
 =?utf-8?B?T0tHcFZqODAyWDZmVCtiUGxXdXZZdmNVMFl6RkExUS9oNE9QM2VJQUpNODFE?=
 =?utf-8?B?ZGVjODA3SWM0dktuUi9EeWtxY3FpdGFBTEFHSENKeXVpbTNUUGMxOEZOL2hZ?=
 =?utf-8?B?REhqemlFVm9yVGc4RUJuYTByVDJzV0lZZENUemFKdkRDWmJhNm02ditrM0dJ?=
 =?utf-8?B?aE8zYUx1MHFQVHN5c3NKS04xYnVyUDB0aFowZ3JVY2ZqeWE0azMxLzYwVERv?=
 =?utf-8?B?c1BWWlB1c3BhUXFvRldGb2hTeWs1STc4SXIrOWFNNVpHeGZjdjIxcnVMcFl3?=
 =?utf-8?B?aXVtNWlpeTJGeGZzL21mNVdyMHVrS1I4QTBGZHJJWFJPWTR4OXk5c3NRUTlj?=
 =?utf-8?B?N3gvVndRaHNGMDhDSFVRUzVIVnNWbE5LZGc3Rkx6YUsva3lkUkVvR3hiWUVI?=
 =?utf-8?B?L3Zxdy9wcE4vQjdNTWpkVjJUYTB1UjVzV2ZUNXptd3QzVmVqUWlxU2FrNDQv?=
 =?utf-8?B?ZE5WUUFJYjhiRm5mRVRkWVZ1UldDSjVOWlc1VEdSYWFXbkp6cElKSjVFNkV3?=
 =?utf-8?B?T05pSU41N2FjaUN3aVE3RS9MWHBjZVh3M1FTSnE3Y2lwV0phNUlDdXl0cDQw?=
 =?utf-8?B?UXYzR1FFalExYnlPdHAxcklkYWRqTGFEREhGemVxKzdjQzk2OE9HQjRTU3gw?=
 =?utf-8?B?c21zV1VDRWJ2OTNBcnlVNUxkckdjSzB3alFGRlBvNW1JRkt4T1Z4d2JFZXJT?=
 =?utf-8?B?SEpFR3NELzE0U09BbS9RVThNcis2NnpzK1lLSDRzd0RPamMrMWxvaWk5UmQx?=
 =?utf-8?B?VVFsK2JlbWNGVitFdnpmR0dZTFZtWWJsN0UxdXpQNjE0THcySUhlNXFhaysy?=
 =?utf-8?B?bUhWZVdaWmJnbm96eEJ2MnA2cU9NbnRxVy9SU1dNbXJSWlBVVzNpRUE0MG5r?=
 =?utf-8?B?bnBTbWJNSHFrSEljbE9ycE56d0xWSFcyTlpZRXN1bDJqUjVWayt0RHNVMW1j?=
 =?utf-8?B?V0RhSXhPdGFGc2VQV2NZVzdiekh3M1NyTU5VWUpMdHdYUk5EbGJzZGljc2JY?=
 =?utf-8?B?VWdNaXpuNzZPMkE0UzF6RmZja0l5ZFlpT3JYcEF3YWZ0M2ZOcVVTZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3fb57-5994-46a2-a09a-08deb73b2f5d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:16:36.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwRvgRtdqgRcOEYaK1gNOVwICbHBhdXxuffzM70VMGhf3TqpYfJNiya3eyOmCQpQlw2LbA4koi5xH6s3DRKKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-21108-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,linux.dev:url]
X-Rspamd-Queue-Id: 72F495A6037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/05/2026 10:24, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
>=20
> Apply devlink default eswitch mode for mlx5 devices after successful
> device initialization while holding the devlink instance lock.
>=20
> At this point the devlink instance is registered and the mlx5 devlink
> operations are available, so the default eswitch mode can be applied to
> the matching PCI devlink handle.
>=20
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net=
/ethernet/mellanox/mlx5/core/main.c
> index 0c6e4efe38c8..4528097f3d84 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>  	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>  }
> =20
> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
> +{
> +	struct devlink *devlink =3D priv_to_devlink(dev);
> +	int err;
> +
> +	if (!MLX5_ESWITCH_MANAGER(dev))
> +		return;
> +
> +	devl_assert_locked(devlink);
> +	err =3D devl_apply_default_esw_mode(devlink);
> +	if (err)
> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
> +			       err);
> +}
> +
>  int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>  {
>  	bool light_probe =3D mlx5_dev_is_lightweight(dev);
> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev =
*dev)
>  		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\=
n", err);
> =20
>  	mutex_unlock(&dev->intf_state_mutex);
> +	mlx5_devl_apply_default_esw_mode(dev);
>  	return 0;
> =20
>  err_register:
> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev =
*dev, bool recovery)
>  		goto err_attach;
> =20
>  	mutex_unlock(&dev->intf_state_mutex);
> +	mlx5_devl_apply_default_esw_mode(dev);
>  	return 0;
> =20
>  err_attach:

NIPA flagged this patch with a build_allmodconfig_warn failure:
https://netdev-ctrl.bots.linux.dev/logs/build/1098506/14585935/build_allmod=
config_warn/

I do not see how this mlx5 patch is related to the reported issue,
but I looked into it anyway.

After the kernel has been built once, the issue can be reproduced by rerunn=
ing sparse
only on version.o, which filters out the unrelated noise. I had an older sp=
arse installed,
so I used a local copy:

rm -f arch/x86/boot/version.o
make V=3D1 C=3D1 CHECK=3D/labhome/mbloch/bin/sparse arch/x86/boot/version.o

This gives the same error reported by NIPA:

...
...
make -f ./scripts/Makefile.vmlinux
make -f ./scripts/Makefile.build obj=3Darch/x86/boot arch/x86/boot/bzImage
make -f ./scripts/Makefile.build obj=3Darch/x86/boot/compressed arch/x86/bo=
ot/compressed/vmlinux
# CC      arch/x86/boot/version.o
  gcc -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -I./arch/x86/include -I=
./arch/x86/include/generated -I./include -I./include -I./arch/x86/include/u=
api -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/genera=
ted/uapi -include ./include/linux/compiler-version.h -include ./include/lin=
ux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -std=3D=
gnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EX=
PORTS -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 -fno-strict-ali=
asing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -fcf-protection=3Dnon=
e -ffreestanding -fno-stack-protector -Wno-address-of-packed-member -mprefe=
rred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-unwind-tables -Wimplicit=
-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/boot/version"' -DKBUILD_=
BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"' -D__KBUILD_MODNAME=3D=
version -c -o arch/x86/boot/version.o arch/x86/boot/version.c
# CHECK   arch/x86/boot/version.c
  /labhome/mbloch/bin/sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix=
__ -Wbitwise -Wno-return-void -Wno-unknown-attribute  -D__x86_64__ --arch=
=3Dx86 -mlittle-endian -m64 -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -=
I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include =
-I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/u=
api -I./include/generated/uapi -include ./include/linux/compiler-version.h =
-include ./include/linux/kconfig.h -include ./include/linux/compiler_types.=
h -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PR=
OFILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregpa=
rm=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse=
 -fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address-of=
-packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-un=
wind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/bo=
ot/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"'=
 -D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c
arch/x86/boot/version.c: note: in included file (through arch/x86/include/u=
api/asm/bitsperlong.h, include/uapi/asm-generic/int-ll64.h, include/asm-gen=
eric/int-ll64.h, include/uapi/asm-generic/types.h, ...):
./include/asm-generic/bitsperlong.h:23:2: error: Inconsistent word size. Ch=
eck asm/bitsperlong.h
./include/asm-generic/bitsperlong.h:27:33: error: static assertion failed: =
"Inconsistent word size. Check asm/bitsperlong.h"
# cmd_gen_symversions_c arch/x86/boot/version.o
  if nm arch/x86/boot/version.o 2>/dev/null | grep -q ' __export_symbol_'; =
then gcc -E -D__GENKSYMS__ -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -I=
./arch/x86/include -I./arch/x86/include/generated -I./include -I./include -=
I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/ua=
pi -I./include/generated/uapi -include ./include/linux/compiler-version.h -=
include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h=
 -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PRO=
FILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregpar=
m=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse =
-fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address-of-=
packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-unw=
ind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/boo=
t/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"' =
-D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c | ./scripts/genksyms/g=
enksyms    >> arch/x86/boot/.version.o.cmd; fi
# LD      arch/x86/boot/setup.elf
  ld -m elf_x86_64 -z noexecstack  -m elf_i386 -z noexecstack -T arch/x86/b=
oot/setup.ld arch/x86/boot/a20.o arch/x86/boot/bioscall.o arch/x86/boot/cmd=
line.o arch/x86/boot/copy.o arch/x86/boot/cpu.o arch/x86/boot/cpuflags.o ar=
ch/x86/boot/cpucheck.o arch/x86/boot/early_serial_console.o arch/x86/boot/e=
dd.o arch/x86/boot/header.o arch/x86/boot/main.o arch/x86/boot/memory.o arc=
h/x86/boot/pm.o arch/x86/boot/pmjump.o arch/x86/boot/printf.o arch/x86/boot=
/regs.o arch/x86/boot/string.o arch/x86/boot/tty.o arch/x86/boot/video.o ar=
ch/x86/boot/video-mode.o arch/x86/boot/version.o arch/x86/boot/video-vga.o =
arch/x86/boot/video-vesa.o arch/x86/boot/video-bios.o -o arch/x86/boot/setu=
p.elf
# OBJCOPY arch/x86/boot/setup.bin
  objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
# BUILD   arch/x86/boot/bzImage
  (dd if=3Darch/x86/boot/setup.bin bs=3D4k conv=3Dsync status=3Dnone; cat a=
rch/x86/boot/vmlinux.bin) >arch/x86/boot/bzImage
mkdir -p ./arch/x86_64/boot
ln -fsn ../../x86/boot/bzImage ./arch/x86_64/boot/bzImage

To me this looks like sparse is getting a conflicting set of flags.
The command line contains both "-D__x86_64__ -m64" and "-m16 -march=3Di386 =
-D_SETUP".

I confirmed that the following patch "fixes" the issue, but I do not know w=
hether
this is the right fix. This area is outside my comfort zone, so it would be
helpful if someone more familiar with the x86 build/sparse flow could take =
a
look:

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3f9fb3698d66..80923864f6f9 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -71,6 +71,10 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE

 SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))

+realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
+REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) $(r=
ealmode-checkflags-y)
+$(SETUP_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
+
 sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub=
_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\=
|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'

 quiet_cmd_zoffset =3D ZOFFSET $@
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..341b0ff20c3d 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -29,6 +29,10 @@ targets      +=3D $(realmode-y)

 REALMODE_OBJS =3D $(addprefix $(obj)/,$(realmode-y))

+realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
+REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) $(r=
ealmode-checkflags-y)
+$(REALMODE_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
+
 sed-pasyms :=3D -n -r -e 's/^([0-9a-fA-F]+) [ABCDGRSTVW] (.+)$$/pa_\2 =3D =
\2;/p'

 quiet_cmd_pasyms =3D PASYMS  $@







