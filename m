Return-Path: <linux-rdma+bounces-4727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F996A35B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D64D28395D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8B1885A2;
	Tue,  3 Sep 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="i1RL1pyC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2102.outbound.protection.outlook.com [40.107.95.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767D2A1C5;
	Tue,  3 Sep 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378787; cv=fail; b=Q834c6XgGo3U/BDx4uYfe32rP3b6FJ7I7vOGsIkjWmULPGvNWIFXZxB5Wyf2tNjDETYEeIPI8o/AD6gl7rf293R2xIjffkyh291cofAFusm6nDv1Mg46HjiPPMORWaYOeY0hPCvj5qEKhusoN85rkyF5Wc3/WJE2LioqNN/3E0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378787; c=relaxed/simple;
	bh=p+TEJ8JW9HnQXklJUuPng1ZK3cBaR3l0+C6FCM7+kFo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=qRh8L6ArF5SmBmpPzyHeHe4zMOayxF3jFVSR8F900D2atMDCUtOtMihdPSmM6ZexI+Jgqesnwm70An37gKKX5sjSY0qucMD01s8hyDOUMRNjE5ZzfW24Y3VDwae2l6oHTS+NZtTGmFWOZ4uB/BlHM93EKDaiHOBNX9mxM5mTVjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=i1RL1pyC; arc=fail smtp.client-ip=40.107.95.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUgP12xNRJFppbAVEzPc9UxfMyWSsXFT3UgRFPLcuT5K8sNgMEE0xxu/ntNN1lUrvx2kMaDmR4Vyin3t82zfo6FcZjYXLyhzBK+ODPPC5FFEhl3yRzzQ3Z00MIhj3Ts+/UFdu3ypaaj+BdC7CqpK3cNugCk9T2BjIbMGoB2GxmPBW7r8dALtQ53Bx7Eg6T3rzG4gyf+BsxgvvKMS1om5yg404PoQsXVyssSekhFBwnBI9MuUleUNcCVYqymzj0T+t2EOPHSf+uOE3+iIOzr/upBR94aZogGtDVnBNwmbYXewEBGZ4/8e6UjvNbZCpLTMKr5wU75vWezevdW3sYFB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+TEJ8JW9HnQXklJUuPng1ZK3cBaR3l0+C6FCM7+kFo=;
 b=mkipJyFNW6Qs90tAWFNU5lP8vcZdEVerpq5THAScO55fUDNz4KMCyxuCM61eW2IOI2xE9xUgVXtIT3mJPIhKf2vlt6P34iSeWPrSe069Av3wutZcuyB8PDSCdRiw7qmx9n+tJNyZwWSimgobOF5EdaZRE0RpHbKYbE2T8lfx1qlRxrbbyGGB6osGPcwaU88wHGPSb3fM4Kj/ifNxeiMIf5QwgoPODlLIL0qCAXE27pL4AkLwA8XIeVKtNSIUTKyljn0RUChWI+85HwX0G2xmaDazMxYiLCaPT0Wcpf3SQY/oix8kZG6gUlfvgx8/mOAtjBvEgSW18tttpgd0qtwFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+TEJ8JW9HnQXklJUuPng1ZK3cBaR3l0+C6FCM7+kFo=;
 b=i1RL1pyCnFQc6s5HDIo8cFVxdnRLInsD8ywkUEeS5Zh5OnktLpWR7rmu45aYZAAZ4cSHfk/xzOZtPh6Ir72oaoXY1Q7EOQN5EFQcvCPxzrItrvion0CIGT6pggAFMvo6n84Akv5RNZxm698OZ0bNzmizbac0TZVTcVYBw4FUq4VFh9Px5d/ucejN0abxctBQepsgxXgH+vEbI3/uWcX7SZ6hxcOE4hJtnmN7yU0iJ+QmKX8vZJtwCdHqEkC+Em/eKQMC2L7vqjXxx0EPf8AT2KAMasq7rT+m1WyYXRvrfMnoLmEMKzoUg8hjht65vfxsWb1zBRpHFezWKRp/VJrRhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CH7PR01MB9052.prod.exchangelabs.com (2603:10b6:610:250::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 15:53:02 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:53:01 +0000
Message-ID: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
Date: Tue, 3 Sep 2024 10:52:59 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
From: Doug Miller <doug.miller@cornelisnetworks.com>
Subject: How to create/use RPMSG-over-VIRTIO devices in Linux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:32::14) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CH7PR01MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ad08a0-5084-4eef-0cc6-08dccc307d87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEJ2ejA4Z1RLZnRCMUVZdVNnVmhMZ1hFVGZ3ckxhenNWWUM1ajAzOWdZU1lw?=
 =?utf-8?B?M0pPL1pXNnhDSUhrbHpTeXZXQ1JEM09ESytvZXB5UzRsRGRyQmNlUWh6ZUJG?=
 =?utf-8?B?bU9Gcll0bm1YdzBkcVUyVkF6NkpTT29MeW1MQmVKM1ROZ2pEU2hCbU5HQnR4?=
 =?utf-8?B?ZXhuUUE2NFFKN2FTSjU5RkxmRGJRMFRtVUR2MG04ZGgxZ245bnpCNURhejRa?=
 =?utf-8?B?UVFMWmM2Q0pIZ1dWa3BYUGl5a0ZEc2tjS0VWVnpsWGtEc3Iybm85QTVOYUYx?=
 =?utf-8?B?cTFtYkp2cDgvSUxNcXphTDdFRGc0YnhiV2doeXB3YXE2aFBUT1ZKVXMvL0VP?=
 =?utf-8?B?Szh2dWlzUk9WRVVOUTNCWGVXbW9PSWszNUNWMmdzc2tjNk1SRVpWUDdkSkVD?=
 =?utf-8?B?dnlHcTdQdGdTVHE5QkNUc2FpdzNNREtxdE9xWktFZ1hxVkNNdVZyQnFjbzJP?=
 =?utf-8?B?R2xNTy9TQ2Jtd1I3NEpWMEFPY1JDNHVKSHh1NG4wMXVUQ1Nkb1h4YVk2S21s?=
 =?utf-8?B?QzNjaXNiU25VU3MwK1puc2pNcWJFbE1LcmdRcVY4eDlnZmZMVzRYOS9nUjZj?=
 =?utf-8?B?aWRIQTBtYjJrTVFiM1c2MnM1OU1BUkU4SHc5SmdhakNKMHdmRDU5VlFtUTBC?=
 =?utf-8?B?R0daeU1mWEJ1QmozSzRqU2pEZG0yRVp6emJONWhZSi83WG92VlpsbTFycDls?=
 =?utf-8?B?UkdZR09KOEtrMVYrQW5zMHNxYktaYVhNTzB3Y3YwbStwV3ZuQ0loK0tWOXB0?=
 =?utf-8?B?Vmo3ZVB5QVo0a29jK1R4UEVyMXBtZnpPS1FxNDRMZHpwWjcwa3dKQWhIR2ox?=
 =?utf-8?B?RFByaTQyeXZTWTFid244Tm51M3V1cHliYUdEbjVkVUFDOTdEdGhnbzJrVk5h?=
 =?utf-8?B?UWhMQ0liSWhXRElUWXB4cm8vR014VndDRE5scXh3dXh2Vk5KVXc3aUxTVFJD?=
 =?utf-8?B?QTN0a3kyQWlOY3I3RUdUS2N4M2VUblRqRzdaTzBLREtnd1VjOC9aZTNOUzgw?=
 =?utf-8?B?c01pMk5VaWZsNWYrVVBPNmtCZFFGRzQycDk1TmZubVY4OFFib05TZHdZbGFY?=
 =?utf-8?B?dDhxN0t4MkJZUlZsQ2FYWWFQdjROOXRNaUFadXBQcTNaQVdsdTR4WnF4L2JV?=
 =?utf-8?B?c1pzRUpvVkhTeDZiUFpxQkhQV3czK3hJa01WYVlOL09idk50dXJBeWdIVnBN?=
 =?utf-8?B?bzNNM0wrQmtqamtTZHdpcXJJU21vR0EwU2QwNWg4MmY4M2JmbjJsSVFhNUl2?=
 =?utf-8?B?ZzUzWGZERzFJWU5WSm9wZ2RUWG12UHVXcDMycWNGNm1NMWYvbC8yc3ZwZGJo?=
 =?utf-8?B?WjJPQjd5TjY1dlE5Vkw3cWZrUTlRU1QzejI5OUFWd1BqQXZWd0N5TlBtU1RI?=
 =?utf-8?B?anpzNzlyOFlKZzVQL2FNRXRkdis3TGtmaEdBYitxZFVoVmV1Rzh3aUJROStm?=
 =?utf-8?B?L0hrVSswYjhaYUVFU1czY1ppSDM1dzU5bmRSN2dMd3NLeUlWd2grOElhMThv?=
 =?utf-8?B?UXZuZjBqR2xHdEtzQXIyWGJMbHczMTBhVi9wZnRrQmF1K0hlSENjWWdtaVgz?=
 =?utf-8?B?R2lSNFl0WG5kSU1sblcyTHhGdTU5ZnI2MkFIZHc2eG1STm9iNGR4S2R0d1RB?=
 =?utf-8?B?UFI3czVjekV4WXAxb0Y1UG80Qm9HSDFYK2s0OWY3TUhKSGw2Y1BjWmU0RmM5?=
 =?utf-8?B?RUJEcGRLdGR3MXYwZHB0SFJZcFF4SWZud0puV0ovK3plbFRDVStJeXREYXdR?=
 =?utf-8?B?dXVmSzI3Y1M3QVNzeVN0L05zYmdzTUdZVDlkbll0TjNZN0orWi9tQ0Q0MFBp?=
 =?utf-8?B?ZmFSMTZra2M2MkJBR3lUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXg4TWpWeUo3end1cHllUjZudjdnTHZieU9wSEdUNUtzdlIzRmZuTXhCQWNT?=
 =?utf-8?B?R3FFcDBRaTJkbDNuM3dkcVJvSjJMakw5c1h3MmxFUm5hUHdxT3h6NGU2cnN6?=
 =?utf-8?B?RFprT0hBR2ZwWVpGR0ZWV2N5UHFPclpGcDZBanNrUVJaOW95QUo4alZ4Rldk?=
 =?utf-8?B?Z3pFeCtnZHVaU3hKU1c0aThNNUd0alVKcHhUWVk5SFZPT1ZuMytpWlJxS2tE?=
 =?utf-8?B?SzZyREMzclQwTVZzdGE1VEkvSTFKbTc5T1Vrd0ZlYkE4T2pLZk5HRzM5bUpZ?=
 =?utf-8?B?S2RqZTdZVDNlNkFCY2EvZ0hCZ3k0K0lxbW5jOVRVWlJxVFlxZXpTWW40TFlK?=
 =?utf-8?B?RTJldzBOY2d5UjB5RlRRWGthTWpLZzVFS0htd3pwaHcrTmdJQjFDV2VmTUJ1?=
 =?utf-8?B?SDkzN0pnbGg2QTBlcHZST05Ja0RNV05ZRUVJWTMrSkRmRkt4aUhJK1l0UmJr?=
 =?utf-8?B?RjJDUXVKVEk4NUFNeDUvQllnNnpTNmd3TXZFRWRqTXNSU2dqYm5makM1bUtF?=
 =?utf-8?B?b0ZvRjMwZzc5L0dFMWhoczZKN1NjVFA1SnRBNWdqMlVMSDR6RGoxdStYNGF0?=
 =?utf-8?B?Y3NLZkxEeWFPckNJbG9WcWo1SHhKalhnMktaNURaZUxOUDdmdGtpQ3JLbmt6?=
 =?utf-8?B?aXZuS09rMHNIN3pjbDhOdjVoVDhNM3NKcUxRbHArM2VBWXM2dFowRjdNN1hD?=
 =?utf-8?B?VlJnSTdwUlRyU2MrTnVidEQyNDR4U0F2TW5yeVBzYjJMZ2t6VXRBeGZiZVBy?=
 =?utf-8?B?dWZ4U1A5OHlmWkxlYk1SZzRlQmE4NTlTenh1Vlpydk1FdlA4QUx6RnE1Z1Jn?=
 =?utf-8?B?amdMMDJCZGVKeTUzSzlkWi9KMW81eDBYam1wSzVkeTFYU0dZRXFRRmZZYTR5?=
 =?utf-8?B?ZGVhd1VYTTZkenhiSWUxa1VQMzNJNDNyYmk1aWo2SUF3Z25qWGtjQTJOZTZU?=
 =?utf-8?B?cG4zL09BWm01cGZVM1pIeVhUTDA5Q2tmcklZanFvbzEwbFVkMzVYSHhyOE1n?=
 =?utf-8?B?SUFwMWhhVjNZUVZFVTZHZFFjcGd4SUJOcWdKRkdLSDF1Q3hBcjVKOUFxVmRl?=
 =?utf-8?B?NzcrelFHeHBQbzVWbjczRzV3WlRkekNOU2ZHUjNIcXpLNU9wYWg4Q0dGTGt5?=
 =?utf-8?B?bzJ5NmRZNGM2UFVCSjZKQy9veUxoZUVrdmRMZkVvd0FuOHEycTV4QmNwUWpz?=
 =?utf-8?B?anN1UTZ0M0luckRQdWgweDdUQVh4V2VIQkloOGhxMURRcEJVRGdzOVFwbXFX?=
 =?utf-8?B?cWlyVTFmWkNhbnp5V0JxVFh2V2EyendET2h1dTI2aUlVWXUxT0JWUWNNZWx1?=
 =?utf-8?B?Wk8reVIyZHNKMjFpT1VtODZmSkF6Q2NxRVBZTG9mNnhpdkhyTk1WREZwMUF6?=
 =?utf-8?B?MUxaMld1Z3ZnVXY3MFlKS0xvNkh4NUxkaHBQU3lmcE9VU0FTL3lCMit4Z0VQ?=
 =?utf-8?B?NU5UQkZNL25HSDhmSHN3dXBSUWduR1ZXYlpnNjZhVUptRk10dTB6dzN0bVc1?=
 =?utf-8?B?YTlSYnEzZHR3YjFUaE5NcnNpenU3a0tZdGR6aDR3Q0g3RncyUU94SEhPa093?=
 =?utf-8?B?eVY2K1BXNC9CWEUvbHo1L0xIWFp5dlRNQ3J4RklZQVdhcld6dmsrTEkxdzRj?=
 =?utf-8?B?MVdNU1VEa2EyQ2ZRU2duNWJMWmZ5L3VhTmsyN1pFRlVqVDhZbEJXdWk4NTJQ?=
 =?utf-8?B?Rk1xOUdEK1BnN2JmVW5rWWFteEwzT1BaWkcrUGFXblJQK1ZybzVYYVc4VGk4?=
 =?utf-8?B?d1RGcElqdVVLdVMxaGk3S0Z0aHVuKytJTVQxUzRFcmc2ckZlTWdyR0FCV2h1?=
 =?utf-8?B?MFYzZVA1cldGeG5OS0UxcENidHhGSWd1bkh6M2x4M080WEdqT092Sjk5cEpj?=
 =?utf-8?B?WVdlNTNTcHk4WURRTHFMQjd6aXFKWTUwYWpLbXA0cUE3Z1VxRU9ZandOV0tP?=
 =?utf-8?B?T0ZOOE9jZEhuN2xCTWR6MDAzWkducnJsaEVkd3JGZkhUelpvNEg0T1N0anZB?=
 =?utf-8?B?RkRtKzJxY3ovYUZja3VHbjR6emZXMzltZGNxL0NWT2ZFb1A3QW1rTXI0eFFL?=
 =?utf-8?B?czJzNjUyaHByOTczVFgwSVQ3QzMwVmxTb0Z2SjlRQkFQZFNCRWRUb3BZajZu?=
 =?utf-8?B?RWNEWW1ZeXBvTjJZa3hsQ2pqa0hRZ2dYTnk4QTJ5SklLbnB4RzhrdVRPRVVq?=
 =?utf-8?Q?6ukR7+DZiK4u+dzuELUAxhM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ad08a0-5084-4eef-0cc6-08dccc307d87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:53:01.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxCoPrTz+vbP9BCK6qIdGNZC4T19ngJzBGYlgZNv3J8hIznjz6Q79vIFeJ8Q6+cKydn+s9XHtYsMVoulZ8hGHRiyDDNj3G3tIDkXUW1cS2DhG8ziY3co2QkGL7lhWNLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB9052

I am trying to learn how to create an RPMSG-over-VIRTIO device (service)
in order to perform communication between a host driver and a guest
driver. The RPMSG-over-VIRTIO driver (client) side is fairly well
documented and there is a good example (starting point, at least) in
samples/rpmsg/rpmsg_client_sample.c.

I see that I can create an endpoint (struct rpmsg_endpoint) using
rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and the
rpmsg_rx_cb_t cb to perform the communications. However, this requires a
struct rpmsg_device and it is not clear just how to get one that is
suitable for this purpose.

It appears that one or both of rpmsg_create_channel() and
rpmsg_register_device() are needed in order to obtain a device for the
specific host-guest communications channel. At some point, a "root"
device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
subdevices can be created for each host-guest pair.

In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems to
get things setup but that does not result in creation of any "root"
rpmsg-over-virtio device. Presumably, any such device would have to be
setup to use a specific range of addresses and also be tied to
virtio_rpmsg_bus to ensure that virtio is used.

It is also not clear if/how register_rpmsg_driver() will be required on
the rpmsg driver side, even though the sample code does not use it.

So, first questions are:

* Am I looking at the correct interfaces in order to create the host
rpmsg device side?
* What needs to be done to get a "root" rpmsg-over-virtio device created
(if required)?
* How is a rpmsg-over-virtio device created for each host-guest driver
pair, for use with rpmsg_create_ept()?
* Does the guest side (rpmsg driver) require any special handling to
plug-in to the host driver (rpmsg device) side? Aside from using the
correct addresses to match device side.

Thanks,
Doug

External recipient

