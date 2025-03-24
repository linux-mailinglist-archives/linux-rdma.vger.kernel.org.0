Return-Path: <linux-rdma+bounces-8923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA8A6E408
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C231916C2A4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067501C245C;
	Mon, 24 Mar 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hll7k5k+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE72E3367;
	Mon, 24 Mar 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847559; cv=fail; b=WV26pE2dhou7X/IBkHHau4iSpmrQVcL9ADk686Opodbwblcb/geHidSd8Kvf6c/5cm1vrTMzbFMeZVcJuNbQ5Ka1imfoO+uhPm8VtLYIBlNqjBatv32oXP/V9dm0yHa4kTUuwqApoXCmEaCXiwXMfwEZKfVE20euH9geCd8O4yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847559; c=relaxed/simple;
	bh=dg0FSSh0cWOemWxXTAL+ozoRMsnxvyUtuQYeJA6EVWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6A83bYHxd+o3Wz6DdZ1i61z3MsIOrJ9f86jbV4/jgITkmtl5WAiH5Ij3X4AnFHpfoC+8xTGzG1btAQ6/d1YS2BGvbb6qrokFzUowM6sf2qAMYdnNXbGYDE2hDFegcLmyt5tNRMg2KAfT0NwMxONI3iqa2ex4uDgbE/F6M6qlE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hll7k5k+; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8VE2w3xClaJ7ocu1WV+5z0Z3G/JDsBHkgFCDG2z58gptyFJHChnb4bIldffocysS0G9XpffEcV3fcNiZ6KZJDVJOKQWcjJl16PxpijuuZMDTTHY38w6+ZALM9ybFfTWPRTNft7h+su0UT4I1sbKIyzSJipoVKdJ4M7wHlO2c3UGtBDCA1/ilA7mf40mrewuAc7jvzYzQSxohRw6BDVuPEiM7SCrJdaKMysWG14RZYjUmFWbo1ddZXVyQ73AvaK3UArmFJIjR7JOX5ylQPgtgkRqu+bdtPM0OR2lSTgmEeLUbGL8Ip8gmQF5EPmh1eHzGhQZjtWUf5HrjI9FRz6Q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHOa/QHLgniwjaqDGQtSbGVK8Y34t1HO1k5D4w1Xck0=;
 b=vUNd0o6VfPUga7u3h+9XvSYqPmf7ZNzWMm6KI3sth2EK1jDMJSg+vFIkbEdNxVFnqaYDdr4NB/vQaiz/M8G85czxfSFuqFjjyxs/AVv7jJBFo24bGsBQpbhkGdVZN1bUyzAKWpmM7FoPnAUxwKaskiaTgeMz1fwTUYMOlT7wYQtr5M4Zx14GyGMs8QfZ6dGp3qESGCYUFYVlPe3tG3Mp/kvE8utHm2WFUnCTeq0RCStksTMTWLV7UTOHJWtJgyCupGqs0lOmcXF0dSc+1rYHRObrNNn6e/85uiZKlK+gKinyqz4NNBK8i8RoNMwY8gvKQlAelt2SIv7ALt0nCNvLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHOa/QHLgniwjaqDGQtSbGVK8Y34t1HO1k5D4w1Xck0=;
 b=Hll7k5k+SkydK20ciVTyNmbT3gz8Act3vvO6esCzjNIEjgaqL6hpVF8BEvfHb8rWne+5t33RbFeckTPj5UChOyh6daOOXhaVwSOjpTTrSEhGP4O+e9CJ4hCTugCvDHZ67mTqAP2/3bMIB1vCBK/GFYaysdh8XM0cZ31zxAYErEPqMMPijhNpTBkRpmFdaz7xj6XEEvSvM6Afi/JYiea5pP4Rt3X/5GezQw4yld6iX1NCZutnhDZFG+lKUqD8wgj13miaJkfE3YdC9IdevgHmFMoUoFOuHJHiLjv/JNK5JvpUlj+PXMef+IUvE3pI9TMuITou12laMcIXooknFLzSzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 20:19:14 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 20:19:14 +0000
Message-ID: <cdf5be92-1a13-4368-b36f-c3ccdaa866a4@nvidia.com>
Date: Mon, 24 Mar 2025 22:19:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: DR, remove redundant object_range assignment
To: Qasim Ijaz <qasdev00@gmail.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324194159.24282-1-qasdev00@gmail.com>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250324194159.24282-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 254b32a1-87a6-4a96-2055-08dd6b112565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2JQQ0poQlZFZHdiazBtdGZtRU1Za05zczJCbGwwNkQvUE80ZklsZ09nREFr?=
 =?utf-8?B?Z0h4bk5jQ1lhb0VqNk9lZ1gyUElObGVVMDJJR3NoZzh5Vml6ODh4OXUvUVZ2?=
 =?utf-8?B?a3d4WmVKdytyblBpd00zdHdyMFUxUkhNdWlIeWovYXBsMjRhejRyeXNOM0h2?=
 =?utf-8?B?bHY3dlNuMC9WUDZTaFdlb2ZYRk9LNU55M0J4N01kYndIZkJidFl4OHlhYTk0?=
 =?utf-8?B?MjhjU1hhcEU2SGJheGZwVnhUSWxIQVFUUkUrUWxZK0hZL3lHZ1g1Rm5NZEZJ?=
 =?utf-8?B?OGR2YThuUWlUTi9xcUhBUjFTVzgxbHdsTC8wWDZsZ1ZEQkFyQ3BxSGd0L2Z5?=
 =?utf-8?B?MkFPUTljRFZDZmxnSGI3U1dqNzJod3I0Wll4dVk0Vis1Zy9hUWg1cE9WUXZs?=
 =?utf-8?B?bHlsa3FuNzdrdm8vNUlpUGZsOU5lN2hjUzgyQnVuMmR6N04yK1d2aFRXNFln?=
 =?utf-8?B?RzRlZlhqVWNreW55RStDMXVRT2s3OWtaS1k3ejZrbElDbjkxdEJHUVcyVVBI?=
 =?utf-8?B?Y0R3V0hURXBFa0hoQ3ZINnlWRVFKTmxhNURWZWpsMktJdGx4Z25NZFVRZU53?=
 =?utf-8?B?VWJqcndKZ1FSc3lZa0lwamZzWG1CYXhMMzVkaFdBQmJLOGxZVGdteDEzU1p6?=
 =?utf-8?B?OEZ2T2QrbHNtUnkrdnptZXZZRWx5UnRrZm9ucGx1ejQ3QTVWT2tFbGZ6a0hs?=
 =?utf-8?B?VFRSM1JSZDgwYjBLR3V4YnpnbkRKQUx4SDZybUpOczRIMU50eVBaUld2RVJs?=
 =?utf-8?B?aitqTjlUZE5kbzJRK2dkM3grcTFaRWJvbE4xZ1NRN0NjZXNxM0xRNnhzZTZM?=
 =?utf-8?B?UkpNSm5ldzBsamRrNURRY3NmdDdXRzFxOUNPMG9tOWl6OFN1Yk5jOXZDcy8y?=
 =?utf-8?B?R09VbVY0VTQrK1hzWlN0cjM0S1d5elV1SU5qWEx1MDNYNUlBNmlzcXdQQXlW?=
 =?utf-8?B?UmRGSDBld2pPLzdpTnFvTHVuampoLzBtRHUzcCt5TE9rTGFSeG5Tc2NTaWNn?=
 =?utf-8?B?Tkg1UmQ1QUQxK3FhNksxKy96eXh4RVorSFhQa0czN0NybG5xWHQ5ZUpLT3Ri?=
 =?utf-8?B?bG9GbjE5ZkZyV2ZFWkNZaXpYUFY3YjdFYnY2QjBCcjVHYzFaTVpoa3lXbmor?=
 =?utf-8?B?TkRreE11aUQ5aEZsaDg5OWNtS1lEOWxUa0VVNTZvS3lEM1lUMlk1L210VjFG?=
 =?utf-8?B?MjZVdEZFcnpTWHF6UTFRRFFuUmdUbXhITzJ1N0M5STJaNzBPa0VTRlBVUDRJ?=
 =?utf-8?B?UE5teGdYQWNrdTlkTnBNUWRCelZSZk5aYTFSWVB4a3hjMDVDRG1WNWVWRHlM?=
 =?utf-8?B?TFZXSDVkQk1aWjdkNlhBZnY0aGo0OS80V3ZNdW1UMUhZdGlZM2xPMVN5WG9x?=
 =?utf-8?B?c3pHNU1EVWFnT2VuaTIveFVnRVVsS2RjMy9INHZpSThwUjVrY1oySWt4UHpx?=
 =?utf-8?B?N29XZXVENVBvZmFFSEo5TTdWM1dSeUpwbVU5WG9UV0JjdGxTa01JNS9OMS83?=
 =?utf-8?B?bXUwOC9rZWRtQmNzRUZiQ0oyM1V6ZDVNQ1diZWh1Z1Fud3VoK3FhWE9DcFFy?=
 =?utf-8?B?TEd5VlJKMEVMaGxnOGF2VFNCVkJKeGtKS1I3cE05MFpPaE9FV2lJWmd4cklV?=
 =?utf-8?B?Rm9QQ0JBOXNSV0wxUFdLdnd2cXNnSnBGd0VNTEZ2U3JLUkxxTDV4NDRRa0oz?=
 =?utf-8?B?bnlQZEN1Q2owcDFHelZHU0I1VENRMWJIN3paTzhORk9tR2ZlOWpSWUZSNHlJ?=
 =?utf-8?B?VjgyV3VGNXM5ZkhndXNhZ2xObW5DWEcyQnF5bWl4aXAvakU2aW9rYnQyV1B1?=
 =?utf-8?B?UHpIVGtMYzFkNHhNV01EYXdmNVp4cGdyUlpyZEJzZm1wRHhBUFlDQnVVVmFN?=
 =?utf-8?Q?vj1J0aKoA9NIQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1kVVhKVG81Q0FPczk0WjRNWGJCZlpLL0dHTVdGaUlxdG5OSmtpbnBVemNv?=
 =?utf-8?B?NGNMOWhtdGNpWWVwSkVVcEJRRjVaU0pJbE9DM2U0OFVqM1dxZ2EwTkpMS0pz?=
 =?utf-8?B?bERiWFhxeUwrK0k1NjhqUHVqUng0WFhFQldNZjJtSUdRa1hLTmVSRytRMFlu?=
 =?utf-8?B?M0w1OFpGYUkxejFnWDh4M0RNczZjaVlQb3VHdXlxU1RUQmxETTVScnpMS0RY?=
 =?utf-8?B?eEFJMmFCWCt6Qy82cE1qVlVkckREQkxoVzJTV0tjM2RRSnJHS052Nmx6SkRS?=
 =?utf-8?B?REtScVpLK1pxSnlhdWJmOHNhZjZSWFVtTGx4cHhtZUpBakJmY09aU3RwcDBq?=
 =?utf-8?B?Qm15NHBheTNXNTI5Y3cwbHNpcEFCcHRXK1ZmSHdoSkpuTXhVaWczNTM4VFpX?=
 =?utf-8?B?RGUzbk83cUFqQ1hmTDE3MlZPcHVKSUQvQlZsTThUMU83NHZGY1Jsa0s5VXor?=
 =?utf-8?B?RkJocjNMUk8zRFR0dXBZZW9FdHVONGpEL3FjVE5xODRvN2MrUEVKTXhNOVY4?=
 =?utf-8?B?RzNkVVAwMkJ4Q3lORHc1OFdXaml4M3NubFFIT2FPQ1lqWGtOZjd2aDBXRzJ2?=
 =?utf-8?B?MUlhTlRXQ3lsZ3RVOCtFeWllU0NVMzJsbXNKVnVmRDV4ak01eDZhTnRuZUdp?=
 =?utf-8?B?WHh4QkwySU5JNG5Ub3J1NUJXQ1AvK3M2bkRHeGVCN1pVQVdUcDk4QXQ0eC9m?=
 =?utf-8?B?RkZ5M3J2d2JaUWJXcUxxNEVmVjQ2SnR4ZWZhVFVCOWdCM2x5ZmRqQTdlb2dJ?=
 =?utf-8?B?cjR2dmVYNUFnYmtSME81cDJ1RGxGSm04MEF3SmRiVmRFa01DRUl5QnZpZFhW?=
 =?utf-8?B?RVUwQlY3WE0vc1pYZkh3NHRKOVVuNmZ0RHNPR3dSWmQ0dUIrTXZBMXQ4YTFU?=
 =?utf-8?B?WXRpcWYzYk4ySGNBbXBYM1I3eTlZNkVrUWNNK2o0MVRhMlVVZ1NLMERobGh3?=
 =?utf-8?B?Z2loRDZ1UGVDWHdkREZieXpDUDVvQThEdW92WE9Sa0lSeGJZOVhoV0I0TXEx?=
 =?utf-8?B?ZVg2TDltUWVndzVCT2xJNHMwRDFMNGlyZEdTaWVPUG9uSWtBbnhLOCtVdE5J?=
 =?utf-8?B?VVkzKyt5RWgyODF6RmFxVmQ1a3pUa2JaWHJjOFRYRGdRa3pMeHViN2NEbWwy?=
 =?utf-8?B?bEhNUEFjQnJBNmsxYmR4KzlSVVoxdXFCRlhMKzYzdzF6Tk84Rkw3M1ZTdFlt?=
 =?utf-8?B?WDFLdXNoNmR2dDhrNWkwUzRUb2Z6RHhDT205S2kyZWV5VGdSekpuZEJ0L1Nm?=
 =?utf-8?B?b3J2YnRUSG9uVTVRR29TMHJBVHZsSEdzelE2WmVKY3hxLzJHTFBFZ25rNmV6?=
 =?utf-8?B?ZFUxOVY5NjBURXM4WnNybjkxUmVOamRCUTNMU1NJYVBmSTc5bWZIanNpZWZD?=
 =?utf-8?B?Vk41U3VFWlhSUmc0RTZ1cUl0QWs4Yk12Tk56Ny9jZi9ZSUZDUzU2RmF3RVlF?=
 =?utf-8?B?dnlsc3pubnBhWkQzQ29uY21PYXQ2UUpkRUZXWWNRNFFEaUxYand4YTk3RHk5?=
 =?utf-8?B?c2l5VkY3bUxlQzJHdjV0d3BUSjgwL05FcWdzLzJ2d3lmU3NxdUdRYjJhQWkx?=
 =?utf-8?B?MmZGUFJibldBNkVWTy9qSURsZ0JRNm1rcC9MWU51QUFoTnp3OHIyMDNiUmJU?=
 =?utf-8?B?aXpOcXJQbnU2aEpkcnVuL1JrdDFhNTdVRVNCSG43K2IwMVJ3STU4cUJjcXMx?=
 =?utf-8?B?cm1ENHpsLzU0N2hSZmUyN0g0REUyOFBMMVp6WnQ2WEJ0alc1WE9LMVQ3SUJK?=
 =?utf-8?B?V0UwNXVSU0lqTDdCTy9tWHpBM01sTDV2V2FDeTZzY3ZYZVZ6eVNhTlc5ekF0?=
 =?utf-8?B?NGR1R1BVTkd2LzBDT2VqZ0ErYWlyd3kvcDRHR2YyQ0svdFVCeSs2S3AvM2Vl?=
 =?utf-8?B?ekVER0Voeld5bHlxY1pjdWMwQnlKSjJ5WGFxdTVEbXlrWU5RUzhOc2djR0Jm?=
 =?utf-8?B?b0gwbTEvT1VacE9wSkpUYzZuUitKSlJxRzJJZnlkdDRRSHNVa2hWTC9NMWpo?=
 =?utf-8?B?eDROOWMwdDBrNW42YVE1THRyU2NzRHRWRUhZczQ3akhHUnFtQ0E1WnE1N2NU?=
 =?utf-8?B?Z0dHSGJmb21EMy9QdG1DdkIxUmtGK3ovcVZ3c1ZCQkp5bm9WOWhzdlBGdFMx?=
 =?utf-8?Q?DP8xi115zLAw91Fm31YP16P3w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254b32a1-87a6-4a96-2055-08dd6b112565
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 20:19:14.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TlxCML4UHqABFsnon92TgXVwH+N06vh/At/QscF9Qm0LNN82wkBhakysnZw6U3wjgFUroxMthZtwTVsO3SK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

On 24-Mar-25 21:41, Qasim Ijaz wrote:
> The initial assignment of object_range from
> pool->dmn->info.caps.log_header_modify_argument_granularity is
> redundant because it is immediately overwritten by the max_t() call.
> 
> Remove the unnecessary assignment.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> index 01ed6442095d..c2218dc556c7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
> @@ -39,9 +39,6 @@ static int dr_arg_pool_alloc_objs(struct dr_arg_pool *pool)
>   
>   	INIT_LIST_HEAD(&cur_list);
>   
> -	object_range =
> -		pool->dmn->info.caps.log_header_modify_argument_granularity;
> -
>   	object_range =
>   		max_t(u32, pool->dmn->info.caps.log_header_modify_argument_granularity,
>   		      DR_ICM_MODIFY_HDR_GRANULARITY_4K);

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

