Return-Path: <linux-rdma+bounces-4774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3196D872
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC66F1F2776B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4419D094;
	Thu,  5 Sep 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdrXfJFC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52A19AD8B;
	Thu,  5 Sep 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539025; cv=fail; b=kAM210khRw32AqHFdcglcf/87MBc+MjGrYwVkwKUBHo9gieXoIYLyGhc6+zuxuYNCYRDPgFV2gQ1xTqRnhaxw3yEF2n2y14vuZV1Aw2cu7UpYy+xgi0cMHKCLYrcM3GE1oDfKC9jAuDgVl4q6jc5frURbMN53pMHwsUYWzW3wmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539025; c=relaxed/simple;
	bh=DqFRHc0JZBq1K76IFNROLtcYUsFfMnrZPhwUuttYu+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NazsIyegXsOmfcFPK/wCSiSnh8vMGXrs4+iFO7K3oeIwizBOeGRrzjB4ks1pMA7ooa1I0WVNCdTbmYBHZjSdGMzuZO+RTtaql8u+miDAs9LB99Kjsjo0UyzSwOM9uVqUaKaeN1YUAsk2VcQw0T0D2JVkmdF85uPMfRosVX/hbnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdrXfJFC; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqvvI8q2uYk4sPbIFtffkpOD5lvohR5PY9juLTvu94vcOTTDrHiz2EsVPkPAG6OmWLa9OEwCjnRdcBrbpcEBA+dKnmtE9Bd+USWb5kS5ANy71JtObi65Tq+1zugxb1pVRmyg6kvZPYPc4sqXOPd6AWQcQrFclhieaRuvxuJ1B/rbveV41+wY50mVi/FOe/0gCgYkpkDIwpKtTkvE5YqclhrnqWDVPv2afYTYZRovLut5Yy2pT2xnmHTkdzM7MRAXYSDTDZOT8X2MD2jAKsibXYMxPOfh/ozSlHKF0YeEI74vkgCjg1S29zJYHZ3uSjP+JrQSXY2W99nf+75+7t44aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lvD2zkkVFct+49Ifw2aXuzaAHMABy8sxtgnCJQwELU=;
 b=A+xXU/FrZZsea/HOBOwDH4EIPzCmPPSeBuat3n6goh0zsEUcfpxHv5EiKuy3/RYemqzB0yU8k9oWoQ4bO3kgH0Uvi43tWf9yqKlx1jVeoTlSZr6X2RiEKCk2lsx7LSckQ17MaykiGjo9nBHY/p+YW+IrPDUBRrKWSblgVA8XHKdR0n9eb1Y0rvyWjWTB9TWsHs+br3ei/QGtlar1+m4kjcD+MmL4NcFzl83i31ExX7FHYXef5wD5/rq3fbOi28iZmzq/CE1OZ7YgbdeYxLJa//fdMDmsA0wGUxX3byHwaZ21r1nhKlhTILDkixNHVk9c8dptZGX66kGhr6j1HunZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lvD2zkkVFct+49Ifw2aXuzaAHMABy8sxtgnCJQwELU=;
 b=fdrXfJFCabNu1Jg/bIch8ora6ZmvkmPRXiAvZRM/LMHM/KydFThR2oavoNjcQDCSSLkvmMMc9hO8ZoG5DZcFnNQPI7K+gc9pi+rbEch8P6nHpodrE700Oa2mlUfnPE9RUNR1CIEQuajSsS6AaLSrOtgUfZUCcCp81ruvH1OiWunG5gXgN8FiOiHn3wpny8wKhuze2TVAAsbNdxGoCnt6XmDN1Q7pBgf2Oe53H5TBHSRInyqoRkhLR5r3O/PynKUBhnXMhjB+Lq4ski7n1cYFutf+5DgxLkDiZ4pbwzMw+IdG878KTTFyJP1KirkLLymJYA+SmKz53lvrKifNNIrZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) by
 DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Thu, 5 Sep 2024 12:23:37 +0000
Received: from DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f]) by DM4PR12MB6637.namprd12.prod.outlook.com
 ([fe80::fd9f:1f31:c510:e73f%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:23:37 +0000
Message-ID: <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
Date: Thu, 5 Sep 2024 15:23:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
 <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
 <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To DM4PR12MB6637.namprd12.prod.outlook.com
 (2603:10b6:8:bb::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6637:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d154fa-189e-4ab3-c190-08dccda59148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU5md3F1TUN6aStrejliekk2R0w1MlZqdXpJT2xEenVTU3ArVXpUOEgwTmZp?=
 =?utf-8?B?RDhKWTE5ejAxMmUvWmsralFYS0Jrb1BNVTJZQ2JzQWx4VXIzTy9Pamw4S3Fl?=
 =?utf-8?B?a2dveWJudnVkbW4wZlI2NWJVcHI0dmZSdmF6cEo1MVJOVWFyUmJ4K3VJT2Fz?=
 =?utf-8?B?eXFwalpjYmZMaE01NyszQkdWZ1BuMkJWa3U0S1lqeGxpVnNidWc2eGZhNHVa?=
 =?utf-8?B?RVdwaEpKMnZLQWh1REQzdHFCbEJIYVMzRmpzV1lWaTFYQnVMVEYyT25BM2Zo?=
 =?utf-8?B?a3p3emYyQkNtRmxSQ2U2enc1T29PWS9ueUVLNmV6OWF6LytZanFaWjZVU25s?=
 =?utf-8?B?b2xnKzhyOCtaajdCbkhHQldNUnlnNWo5U3FoNnU5MU5jdWZWV3o5RHF4NERP?=
 =?utf-8?B?eXp5SEcwNVF3N3NmQnYrbDh1UmpSSGFjVkJwU2hDd3kxQ1IvdklEZ2R0U2tP?=
 =?utf-8?B?YmRMeGpHSGtsNDJWSUtINVdoWEtRd1ZnczZEY2NtOFRBY0xjdFhxcDBjblpo?=
 =?utf-8?B?SWsyV1VYaWNaK0tKODNnNUFEbENmVDVBVmFxdkVicmMxOXBHUC9Sb2lzRUJR?=
 =?utf-8?B?a0JDSHpsS1gzYlBGR29qaFh0MDZpenZGS0M1d2s0eVZvdEtieW9wVUVQZkpY?=
 =?utf-8?B?VlN2RGw4REdaRWRlR3dIc0pYYldCSVltZVdxZzBGT1ZXVzB3eE9mVnl4RkdC?=
 =?utf-8?B?OHVSME12dVd3dlpJeGVWZWFqWUdoTEVtK3BBQnlDUUsvZTNWd2U5d2NNdUtJ?=
 =?utf-8?B?bUV0QmZoazFFWjlXTDdsN1BWajBzY1FwRVNiRExhd2dGc0VXMEMwRFNxM1JJ?=
 =?utf-8?B?c0UzNmFKQjgwMzV1dVphZzNZYVYvNEpGdDZ5cUZwR2JVTUxmZHlYUUFQTCty?=
 =?utf-8?B?dDFFQnlIYndHNEhNMit5amxOWnlnYmw1ZWtvM0M2Yy85Z0sxUS91WllqUGE2?=
 =?utf-8?B?QzJDOUo0dXk3Z3lFTXR4SVZvMUxSY0QyZkdYTTJaZUFzbTVDQVM5cjliNWlE?=
 =?utf-8?B?K1MyaTJYbE5nTkZrTUFoSzhSUXlyWGVPQ2kxdlBiMCtDZmIwc2VVVXh0eDly?=
 =?utf-8?B?Vk8xQW5IZTdNcXRvdllVWHRzN2RidjVRcVh0Q3FDU1FzU0hCaHA2WWNLZUJB?=
 =?utf-8?B?bmtuV2pOUWdQRDE4d1p4SEtGRXpKYWt1eHFaV2c5VllWcXM5aWNXRmtMOXhD?=
 =?utf-8?B?eGcvU2Q1cWVHNVZuYTB4Zmg4MW9vNmE0TXFodTRCUWFvWG9oNzJZamRZdkNh?=
 =?utf-8?B?TWh2VSs4SWl0dGVPQS82VWlMMzFCN05rNzZpM0tjNWhBMVdOU2NKMFozWExG?=
 =?utf-8?B?NUR4QkFCNXBJRnRXK2JDbVNVS1I3UlZ6SXdRZk4zcHNvNVg4OHdRbUFkZ0tJ?=
 =?utf-8?B?ck5KSjJkNlR5R0NDb045b3lNWGcycFgwUmdQVDhUdm9XdzBTblMwYWgzOHQ2?=
 =?utf-8?B?Q3B6a1FOV2JsL1VUZTJHS2YvWFpCV2xsQ3V2WWhRWUdtZ0hYOVoxVGpPeDc3?=
 =?utf-8?B?Z05yR3VTRTIyeFlndXNFVTRCQTYvaW1rU3hKeWMraDZBcHNHaDNobklieXFI?=
 =?utf-8?B?RUVYcmQ3QWF6SWNTSFZKa2ZiM1cxdkhzdzd5WjlTQjlrakVHQTdlU1YwUzR6?=
 =?utf-8?B?bWdSdTBoOW5lYkJoT09BVkxmQVVxckNMK254SEdLbFM3Wmt0TUZHelNQUWtW?=
 =?utf-8?B?cFRaM0VFYWwzd1hIMElvZWJvOGVqSzJacnd1Rk8wYW02UTViQW5YdFB0ejJR?=
 =?utf-8?B?RmtQWmJyM01NdlNta1A4Sk55SG1yTEw5cWluN2s4SndXS0Y1dERpT0ZjajE4?=
 =?utf-8?B?TEdocG8wc21zcDNJOTVCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFZwMVpTNjIxaUtGT1p3a243YlI3SHlabjl6cGpxdmlpQ3BBZFdPYkxVUXN5?=
 =?utf-8?B?aC9wL3BkREU2eDE4TGw2bE5XdWE0RVRMUEpFUzEwYUQwajgrVWdKQXp6Mnht?=
 =?utf-8?B?VDVaZmVkOUg3bFZIaUxOcmFVRHlhT3Y2dk9hSlUrekJIS2VJQWJiREM5cStM?=
 =?utf-8?B?amtFRm4yZjBzanQva0YzczVqSzBEd2w4YkFHY1cyTUEyeHV3aWZCVy9OM1BC?=
 =?utf-8?B?YTdYellickhLMnZBVVJYRkhkdW5ZVGx4aC9hZ2hsWFV4VG9lM1VwdGNSUWw0?=
 =?utf-8?B?NWdOS3l5V2FaWWloMlFMREpnVkE3UUZvTHNKcUpiN3lIWnV3ck1PR0pGS0NW?=
 =?utf-8?B?aW1uWDZhdVNqRDZDdnNuNFo4YWk4a1Rvcmt2VFE0aGRFaFZCMFdwQUxsa09w?=
 =?utf-8?B?UEtaRWo5V0tqMTBCbEpwZXcyL2ZzbVdKeTNCYklqSG5KSmx6aEtPdVZySDd6?=
 =?utf-8?B?RHZibTFTRGtjOUZrYzBpc05sWnpCa3pWZ1hneDlTVExYRUlTYktKUUhZYlNk?=
 =?utf-8?B?b0dSQURzZ1NSRHdtOElnOVRIVDdCekNPTTBmdVlIdVMxZ1J1OEZxdUtlWXFt?=
 =?utf-8?B?L2Fhb0JEYnR4UHdhNWR1ajRmRE5UZUpud3BZY090WWIzS2cxRTlxSWZ6K0R3?=
 =?utf-8?B?c3lWT1FwbDJrK3RUNWtjMG84KzFYTHFZUHpEZW9sbXhwSlpwRnpWUmxvdWgz?=
 =?utf-8?B?eTZuL0NqQUx5L3BTcHZSL3lVV3R4dVV6NDVBVkN3Z2FnaTBxRWlsWlVsWnBi?=
 =?utf-8?B?RkNmb3VuRkpaNFM1VEpVNjR5U201dzZKUTZTTjF2UGtiV0djUFFjSUF2L1lN?=
 =?utf-8?B?NUdsVldDYzlvVCtnaEtWRjlRQXBvYzdOYTlJOWxOd05wOEJoYm12bXRnSVhF?=
 =?utf-8?B?aEFDcUdoTER1aUptUHhPa0hyZXkwUTNFc2ZyRVpkUWw4aDVmVy9qTFp3bTRj?=
 =?utf-8?B?OTBQZzk5UDFPOEtvZEFlaE5ma3Z4SjhSUmJsNEtOVy9ibmFXYW1Xd2R4Zmhi?=
 =?utf-8?B?bUZjWmc2MEFZd3c4bEFjbGlGY04wK203UGhtT3Q0SXpyYVVEVXhKQXppRDlj?=
 =?utf-8?B?OXo2cVo5UnF1UGNoYnR1NmRNU0pXVTBtV0V1U0RJVnZudlgvMzB1ZlBhbHh0?=
 =?utf-8?B?VlROOTVvVzVZd1kvbFZwbFZBZll1UkU2dU1oNWtJU1plWXpoUGY3dm9vNXBT?=
 =?utf-8?B?ZSs0dk10TFlYUjc0eUlBRnNYSXluS3dPWnlFUlM4VU5NeGNiOEFNcG1OMCtx?=
 =?utf-8?B?cFdhVG1IQ1N3d1lKTEltT2tzM3g4SjFpS2xzNUttL0RxNFVCUjVSTUtoaGRh?=
 =?utf-8?B?cmhxYTE1SmVqKzVhanM1M3Yza0x0ZXp6Q3dpMXBRZ1FKQUVnYkxRRjFHMjdD?=
 =?utf-8?B?NEVidE9XM0YybERXeGdPT2FyaEZwaUlEakxGUmRpOG83SHl2Y0RyTWFzSUFj?=
 =?utf-8?B?SHZjNkhhOGMrbThpbnRZbWpWTUg5VHNDSHJvd3Nab2tCVGR3NU4waFRIbkhD?=
 =?utf-8?B?cVBDUGhRMUFSL3BqbldZUlFzbnhNaWJzckpIeVJZZTFiSSszeVlxVk5reG53?=
 =?utf-8?B?ZTRoMHFpU0tCNHhXTjRMLzNzYVZ3bzYyZjFldGcwTlJNRk41OURsbHErd0tr?=
 =?utf-8?B?bnhwamhSek1oVTlRSFg1dStnaGpHblhXaWtaRHB4TFY3d293bFlwbTJVNHpC?=
 =?utf-8?B?MXZqbzNucm1ETGh4WXRKU3VvbHBwQndYL2Fra3NxY0xBT1pOdVZpWGlSSHVo?=
 =?utf-8?B?akgwaDRDQ3VuMCtvTDJYY29jdnpaRTd4aEU0Qkhub2VLYTBzVXoxeExLd0VE?=
 =?utf-8?B?OHpPeS9HUCtYWHJCL0xGWHdxVDVVazVWaW5xUCtSN1I4M3VweWFtUmVqa0Y1?=
 =?utf-8?B?Y0JSUFlkdnUzaldKYzFyM1VPUkNGQVBzY2p2VUcyYkZjaUlQeW5jTmVsY2h2?=
 =?utf-8?B?Q242S1lhMXloQ0Mvc3FlZ0xBOU9ibWFqRU8zU1RjcDZoMXNmejN0Tzc5Nm4w?=
 =?utf-8?B?bkNjdGlrMlNvbndlN05EeEJHVTArbzkzV2xFUHlPTndDVjdoQ0FGUktKaGdI?=
 =?utf-8?B?aTkwTGp2d0NtT0hCUkRWai8vKzloUFI3ZFpMWkV1dTZJNXBlanF4VndkbEJa?=
 =?utf-8?Q?3GgGYzuXk6n6egiJM+86dG5Fy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d154fa-189e-4ab3-c190-08dccda59148
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:23:37.2968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arnD+044Bi30Xhl8tk2/UhM0C4uiNwlht2vWjMkw6a59v48PifQwoT45EvCTga66T4JlrSrMXF96O7LKQcfZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085


On 9/4/2024 2:53 PM, Zhu Yanjun wrote:
> External email: Use caution opening links or attachments
>
>
> 在 2024/9/4 16:27, Edward Srouji 写道:
>>
>> On 9/4/2024 9:02 AM, Zhu Yanjun wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 在 2024/9/3 19:37, Leon Romanovsky 写道:
>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>
>>>> Hi,
>>>>
>>>> This series from Edward introduces mlx5 data direct placement (DDP)
>>>> feature.
>>>>
>>>> This feature allows WRs on the receiver side of the QP to be consumed
>>>> out of order, permitting the sender side to transmit messages without
>>>> guaranteeing arrival order on the receiver side.
>>>>
>>>> When enabled, the completion ordering of WRs remains in-order,
>>>> regardless of the Receive WRs consumption order.
>>>>
>>>> RDMA Read and RDMA Atomic operations on the responder side continue to
>>>> be executed in-order, while the ordering of data placement for RDMA
>>>> Write and Send operations is not guaranteed.
>>>
>>> It is an interesting feature. If I got this feature correctly, this
>>> feature permits the user consumes the data out of order when RDMA Write
>>> and Send operations. But its completiong ordering is still in order.
>>>
>> Correct.
>>> Any scenario that this feature can be applied and what benefits will be
>>> got from this feature?
>>>
>>> I am just curious about this. Normally the users will consume the data
>>> in order. In what scenario, the user will consume the data out of 
>>> order?
>>>
>> One of the main benefits of this feature is achieving higher bandwidth
>> (BW) by allowing
>> responders to receive packets out of order (OOO).
>>
>> For example, this can be utilized in devices that support multi-plane
>> functionality,
>> as introduced in the "Multi-plane support for mlx5" series [1]. When
>> mlx5 multi-plane
>> is supported, a single logical mlx5 port aggregates multiple physical
>> plane ports.
>> In this scenario, the requester can "spray" packets across the
>> multiple physical
>> plane ports without guaranteeing packet order, either on the wire or
>> on the receiver
>> (responder) side.
>>
>> With this approach, no barriers or fences are required to ensure
>> in-order packet
>> reception, which optimizes the data path for performance. This can
>> result in better
>> BW, theoretically achieving line-rate performance equivalent to the
>> sum of
>> the maximum BW of all physical plane ports, with only one QP.
>
> Thanks a lot for your quick reply. Without ensuring in-order packet
> reception, this does optimize the data path for performance.
>
> I agree with you.
>
> But how does the receiver get the correct packets from the out-of-order
> packets efficiently?
>
> The method is implemented in Software or Hardware?


The packets have new field that is used by the HW to understand the 
correct message order (similar to PSN).

Once the packets arrive OOO to the receiver side, the data is scattered 
directly (hence the DDP - "Direct Data Placement" name) by the HW.

So the efficiency is achieved by the HW, as it also saves the required 
context and metadata so it can deliver the correct completion to the 
user (in-order) once we have some WQEs that can be considered an 
"in-order window" and be delivered to the user.

The SW/Applications may receive OOO WR_IDs though (because the first CQE 
may have consumed Recv WQE of any index on the receiver side), and it's 
their responsibility to handle it from this point, if it's required.

>
> I am just interested in this feature and want to know more about this.
>
> Thanks,
>
> Zhu Yanjun
>
>>
>> [1] https://lore.kernel.org/lkml/cover.1718553901.git.leon@kernel.org/
>>> Thanks,
>>> Zhu Yanjun
>>>
>>>>
>>>> Thanks
>>>>
>>>> Edward Srouji (2):
>>>>    net/mlx5: Introduce data placement ordering bits
>>>>    RDMA/mlx5: Support OOO RX WQE consumption
>>>>
>>>>   drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>>>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>>>   drivers/infiniband/hw/mlx5/qp.c      | 51
>>>> +++++++++++++++++++++++++---
>>>>   include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>>>>   include/uapi/rdma/mlx5-abi.h         |  5 +++
>>>>   5 files changed, 78 insertions(+), 11 deletions(-)
>>>>
>>>
> -- 
> Best Regards,
> Yanjun.Zhu
>

