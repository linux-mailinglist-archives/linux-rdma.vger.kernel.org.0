Return-Path: <linux-rdma+bounces-11806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4EAF0196
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B6C160572
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D327D770;
	Tue,  1 Jul 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="e3ckRlEE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2120.outbound.protection.outlook.com [40.107.236.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C05195B37
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390276; cv=fail; b=AR0CaLtOeeR17xyKg2TgshB2HWWL+SqO1vm6t0W6dV1TWsS20w6C/xjzV53jh/RPOWJlg0FTQ8sY82xcWLEnKamDaiN/rCxxMx6KLYHdzHS0p+0xno3J0NhBzRXFgbBJ5mEDZtzkFlyyI2EDSWuFqbxus/oajz/UfVeblYIPWys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390276; c=relaxed/simple;
	bh=4uoOK+yN5wWoBO4KmaGwURph+v9As+NbFej1D7SQ6t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/NPdZ11/nO+NUR7u62gUIdpUMuamsv0k8aEqCLjDz6RMDjDGSq8jJuTw5Mvlc/w+uCfwt/cMYU0H/f4pLHffBk6x5Q/sOLYyZMKtwNtWP2Ul3nenCp5t4WIbw+uG8AF8vHsRc+wABXmMcXY2hzPJ1BVehlwJKMcWDjp0H5pj0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=e3ckRlEE; arc=fail smtp.client-ip=40.107.236.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuwBt80OTDhETRWDcicdbp0lgGdb/0z2LjJxCNm+1UnxQa14zcmL1I2LDokXvIjHDu0sJbmXl3aCfyrtHC84ST0UPzwhU50mGkQ6Co5EKuxPX/gAVHiG/fUdUsvmEmrniKJ144SQ3c6QqRYdy1AdgoTKYj00pKj6nC80fgwhFn28uckAZyrpUXTQKmfUmaEKtkEghABY58p27qnLivVYdDzbQJVkz6849tvefyr9mNqA1ug0Aj0QpqBWbt2OHE6Ncae4mJYrTTxBBR4+FPyugfXJp3g9F70SZ3LupcZ0We7si5H0IVrDPmK8XuYthHk7GmFzQXtqx2tK72eUCNUG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+doqwPcDIXytMZ9JNbbehCIZqgux99n139LA/Mt9Vo=;
 b=agTqLDIbTGp5Fvx8RxnT36Lc04IzUN1o2jLnLhgawlWrFO77fELPJ4CAR9Og0f7WyIjcSalMgAOabyuR6ERHXfHyaReHw7YyxzecJOT8HI63X2mH9FdjH2c0zZbPc13JeUV+VWHDoR7yPgefHAxFNMeG08vIy76Lckhq9b1TxHErNOg2cxWKq4T7G0UJxNdKkgWSwAw2SJMj0sF6flEzaU9Q+UIIAGVuoy/8aOQFmDCtY/lEFU1DjJiVXSkho5ryvxapxRFhz8CDpa8DQcg400cXVtsN4HHkBcA+M8J2u+n5prGlVYWmMwpW4TE3Dp1n9AepeIm7vd/pyGyoqVDX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+doqwPcDIXytMZ9JNbbehCIZqgux99n139LA/Mt9Vo=;
 b=e3ckRlEEe66JcanlXbw7wTt0P0F2XX5qA0BQhZ3ekc0Z+ENEToagwFJtvO2W3OM03tecldZuB6qVt1wdE2ANp3A7PGibKf265yAMqPbZsiLmscC3YXaNlQ9CllOmhnkWSCIrIZNRAaWgXAV3sGezTpC92F8A2seOLGFgYPRdM3eG+beMx1wDEpWOnd+VK6w9QSp0LWSOMkiWQWlOU1Nm8XXNsDj1rdwpevOnixOiAdDtXd3dFXlNJJOdXammOgtKdGdtgAskW8HPzvLRS2RIm4OFFWhY9EIucHO8/YMbDRxvhGGS2Qgx5A5aaMb2gbkHZEI7nSCyyCRplpISv5ApJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 CO1PR01MB6647.prod.exchangelabs.com (2603:10b6:303:f9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Tue, 1 Jul 2025 17:17:51 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 17:17:51 +0000
Message-ID: <aed06612-2e0f-41ed-a0f7-e9f3c55ce657@cornelisnetworks.com>
Date: Tue, 1 Jul 2025 13:17:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123254.GC6278@unreal>
 <32fb1fe6-b21a-4105-ac2c-cbdcd277a59d@cornelisnetworks.com>
 <20250701160415.GG6278@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20250701160415.GG6278@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::26) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|CO1PR01MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 20da1624-556e-423c-eced-08ddb8c3353a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDBZR3g1Q252cytWOVdOaDEwVFpNTG5LQVAvak9pbGhnVHVsMys4bmhyM1pa?=
 =?utf-8?B?WTRieVUyOFlkb1FxTUpnNGxJRm16em12Vjl2eG1wVWZGMzE5UGpSak9GYkpZ?=
 =?utf-8?B?ZVRFanA1QjhDNDJCTFpiTlV0c2M2K2FtL3NMMXgzZGp2WHdqMDE1SW5rZ0Zy?=
 =?utf-8?B?TE9mWG5YSFVmQ05tZXN5Z1BvMVZlRG91SmJEb0llRE11R2VNZkFneXQ2OVZu?=
 =?utf-8?B?U24wOU40Zm9BNXZWSStxRXlwUVorckRtODJsbWU3Ylo2QXlORnptWlJMRkZ5?=
 =?utf-8?B?SndqRTZhK04wcmxvU0hGMWgzc1FJRFp5VG5UZjZNRHloTUM5VFZkVkgvak1q?=
 =?utf-8?B?WVdrQ1N1aXlQc1FKVHF5ZGhzUXZ5eTJ5bHI5Y3pXaEs2a2ROclNtOXdjd0c0?=
 =?utf-8?B?V3hkVkd4MFZQZ3ZKalIvbVVkTE1MTUlxWEkxQzJ3VnNZSTFubGxId3ZEQmQx?=
 =?utf-8?B?K2hBVWhudStMQW9tY2ZrVGhVY0hNekVuS25JT0pLV1VvZGplNkpzczUxeW1w?=
 =?utf-8?B?M08wMnlvalB4b2hqRFVwYm9sOFVFWVJZYXFxa2J0Z0Q0L1FPR2lGRkZQQXl6?=
 =?utf-8?B?ZnhXdFJaREIvNmNFKzBHTGk2TWE4YVBGbzNjbHJwY0JCdUJsOGlqV3Z3RDNU?=
 =?utf-8?B?R3VWZmxTS0RWQ3NEZlhoY2FuVGtZWGJTTHU3dkJzeDdBY3BFNnBQcGYwK1hB?=
 =?utf-8?B?OXg4d3RNcTNqbTJRK0V6bExhME9saFJiN0pDZWltOEVxUjIra2NOUU1EZ2JY?=
 =?utf-8?B?UVgzS2dNbEtNQVBWNG10UnMvT2c5OTF4ZGRubWM3emxkcVpMZlh3YWE5NDhZ?=
 =?utf-8?B?b0RSVkQ1SFBEbVIxNXdVcGlsbHlSRVFzNnh6WUp6a0txN09UMXZIMk1jSkhO?=
 =?utf-8?B?VzlOVmlWWEhhK01lTEM1Rk1MbnIrOFFxMEgwNnhnSTZVTG9UZEtRWFdJUzVt?=
 =?utf-8?B?VjJwa0toRGJ6Mjd5SzlsM1NvdDhLWC9HMk84Z3JwMmdnTzFXQ1pjbXZZOGNF?=
 =?utf-8?B?VDV0eFNHN0JvZ2N5cWVNNm9tVmVpVkZtMUVnMzYxalg3R1NzMVF3N2l1MVlD?=
 =?utf-8?B?Q3NVU05aNlVpaExGSEdvMWRjZStKMWdLQ0E5S2c0UlFNWVdGMUV2R1p6MEJE?=
 =?utf-8?B?aVRlSnFmSVY3VE1sdk5tcDlzNmdqbitMR3laWDMwVnRzOGpLWEJrZ0dmUVBz?=
 =?utf-8?B?dDRZUjl4RHNqT2pKWW81eStDWGZhK3FGNXloZDF4dndHRGJVVmNBN0lsenRB?=
 =?utf-8?B?djh0eDBOd3JLZDJLSXZzdVRXN1F6d2tlVkhZeU1YbEtsb2kwVGsxbVd0S1Zv?=
 =?utf-8?B?TTVLL0lxZEFkdVRES3cxNzk4S1FaUmNDSmJaYXJRVCs1eTVFU0hkd0hGZ2Fy?=
 =?utf-8?B?dmlpRkd6dUk1R1NaTTlnTytRNW9JdnF4VDdMUk12WFdvMDRtUk1tamxDVEZk?=
 =?utf-8?B?dy9mQllsOUZ5a1lHUWIzL2o5TWNDeklkOVQxODdMSDI1bHQ0aVdDZVhVWVor?=
 =?utf-8?B?TitDSXliTkdGWlkvaGNJQm01S3MrL21hT0hDem5jZld0dUk5Z1ZMbG9oMXpK?=
 =?utf-8?B?ZkxMWms2VlZVdjlUdlIwb1h0UXd3VUZtZjNIZm1QTXQ3Q2htMWhWL1VCaTdX?=
 =?utf-8?B?UldFazZGVzM5RW1tblRLL2h3NDByU3V5Z3hmcDBjaHdxRmdDQjhLZ3Jla3Bs?=
 =?utf-8?B?V1J0U0pOVXU5UTNXSE9JS3JXZ25ya2VtYjh4dkdmNFI3MHhoS3pYQTRSbmgy?=
 =?utf-8?B?eW1OM25nb3c3RzhPK0dqV09hdFIzd0QvU3B4eVhoYjA3VCsyVmJHUlJ1N05s?=
 =?utf-8?B?bU4vb2lZWnJRODlWbzQybUpYai9QejJHYlZ1a1gwWWdQWENBZ2ZGSVhDOEdk?=
 =?utf-8?B?cWhKSExHZ0NLTnZnekZDWFVmcmQ1UUp3UFhzZUxtK09KaTVGTVBJYkhrendv?=
 =?utf-8?Q?KkxdIZBI/cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5MWnN1T2s2L3Y4TEQ1cGYzK0x4UzhCWFNhbmdkTFc3UEpQTFY5ckY2c0M4?=
 =?utf-8?B?MmIwKzdXanFkQlY0ckQyQWU5OEtzV3kwV1FjdERtVjZxQXpmRlg2OWNnbkl6?=
 =?utf-8?B?KzBFbjVSdURlZHBBT0dzUWxWeW5oaHBXbXVIRHdTaU8yN0dOWkE4cVFyQ3Bw?=
 =?utf-8?B?emt2M3NqNCsxQ05iUGVKRWJTdi96SkNVNmJBZ0VrMVlOQ1k0ellPdlQ1UzRL?=
 =?utf-8?B?Y0xRR3VGV2RZOWY2Vzk5RndHRlBtektZN1c0SEZkYmZJUVJsMnhwQ0hjb3Jt?=
 =?utf-8?B?NXhyb1J5a3RqVURhMFBVNVNUUEpUS1h1TlgxL2N0Rmp1cjVQdUhZWXFwbGox?=
 =?utf-8?B?VHpKcGt0R2t5UTN6V0VQNG01Z0tJdlROdDVtUnFEWDBrK3c0QUVYdlcvbHA2?=
 =?utf-8?B?cTMxZkRmZnA1NUdjVHBiZnk0eitBa3lGa2FmU2IzbFMySTlHZ1VRZjY2Smlz?=
 =?utf-8?B?MTBaR085OUhCM0RxeDJvZE9NaXFlYmtDUEpPSkg1aXRQV0U3RTU1OUFMcTFv?=
 =?utf-8?B?Vm13d0xZTXNQVGtrdDVzNUtGcmpJOHp5bGxQUEJYNFFmUFN4VVM4VEwxcUg4?=
 =?utf-8?B?SlpmRktpVEJOazFFVU1QclBWS3ZpSldtRXl4Q21GVkIzTUppNTFHU3ZoMEhH?=
 =?utf-8?B?VEkvMndOWUR4K1IrOFlZNkNWWnhBT0tHemNmZU5Wb2JXNjkwZWwvVjhzaDRx?=
 =?utf-8?B?aWZhNEtOZmV1MGZmdGlvVC9QWlV1ZG14bEVmWkpoT251QmlITFFLWERnWGJG?=
 =?utf-8?B?d1NlZi9vbHN3RW1sLzdERFJCaXJwNnQycGpPUEtjazVMc3IxSGVOVlhjR0Q5?=
 =?utf-8?B?ZlU1RnhCaHExakJvVVF3Wld4cHQrbWdOOWE3VVlTSURDaEk3ZERncmd2VnNC?=
 =?utf-8?B?aEhPazlKZnpBYzBYVk5jOWRneUNJcFBpUXVvRFhOOHZRMkk2d2M1Ykx2OTVJ?=
 =?utf-8?B?cy9DaWdpa1R0WEkrbWc4bmNlaHlpUktFZENMZlFjQ3FUWUt4Sk1yanlIWU00?=
 =?utf-8?B?OUZsekwwRTlIRzh1UUVCQ0xTR0NFSWhWTWt0c1psekdXY1dNbm5SSUtCU2Nm?=
 =?utf-8?B?cGYrRGRacC9zZVorZnVYdjZ1RTBzUkNkblFCd2N2c0lRNU5oUU9WemdldW1P?=
 =?utf-8?B?NldnemlZV2M3TUZxNkZMM09DWnlkSmFpTU16RXYwVGJrSFRTcW5NdFJMdUxr?=
 =?utf-8?B?dUtLYWJKKzBqSG1vbm5aMEtoOUZidDdqakhLNjhaSXl0T1MzaDFLNUU4SHdR?=
 =?utf-8?B?OVZWcEZWd1lGaU9WU1lNRHdNVUd1ODZOVGM5c25peGd2ZmNBVkE0aEd1eFBj?=
 =?utf-8?B?YVNlZ3hUZEl0aXRSVFpkVFRBeXNaVFpaS1UxYUZJd1VIbzNsSUJRM2doNXhZ?=
 =?utf-8?B?VnhmVkJYWjRkdm1MWG1jVkdaTno0UW92cC9qdlZPZGpJdTlBNVVjZnVBR3hy?=
 =?utf-8?B?NVg0aWVZYUlRMTBwRDl1aXB6ZkdSdldEVkpSRmEyZ293Zmx0d3J2Rm5Zd04v?=
 =?utf-8?B?d3JwUFQxN0xsQ2pCZTlUMHFmekxMOWs3TStkRTZDOGhLRGJDUzNuZEwyakp4?=
 =?utf-8?B?SEsxVVVPeUZGNWRadTZmaUczWGRhWTlHM3ZKTUErdVJwRTh5cjhzZUJXV2JP?=
 =?utf-8?B?aDNxak56dVBWMWhHK05NUWQzTDZYNWRzTThxWGFhZjVPOUJJRW5jQzBoeWdY?=
 =?utf-8?B?QkZxZ1g0aHNoclVYNFM4YUJYVDlQcmtmbG16QnN1RGFHak5nWEphSEpEUnd1?=
 =?utf-8?B?bCtuR0dEMkJ5NVRuRkUrc1p6K3JGMytoMGFEb2RtS3JzQk5ZVzM2Wk5vc290?=
 =?utf-8?B?ZCtHNUlSWkNaZEoybVpnMzBzRnN0RzY2MlVGUjRob0ZVU212UHcyT2xSSDlJ?=
 =?utf-8?B?ZGp6SnBQQjRveGRZK1o0YWRXUmhlT1k0MzZCOXNQYktsNTFZbTJ1dlBVZnZK?=
 =?utf-8?B?SlVRRDd4c1V4d0N4SCtRVVRJWnhIZENLZnNuY2k1b1gxZklHNFVQci9tL0hO?=
 =?utf-8?B?VG1BWjFNOG1QV3FOaTFPbStySkRiNG9KdUp1TS9FRmVlMlN3LzcyNjFpaW9Y?=
 =?utf-8?B?UHBUVzFGak41VFVCWHNTdVd6bVZ2UDFwdDBnc1BiUFhLQWhXaGQ4aXlBOWJi?=
 =?utf-8?B?Tmx5WGNXUm5oSTdqUk9jR2ZYTnp2cVpYUXZkbTl1d2NFUEgwaFZyVHYzVzR1?=
 =?utf-8?Q?0JHA0RUkXLNhLcQrzi/C0HU=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20da1624-556e-423c-eced-08ddb8c3353a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:17:51.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZPqySO2mT5LXDtR7ocq0LgLmMBMB85kV2+tDzJlZ2GZk45u+Wsv7XDH4b8/oUNoMZAOFW41n/tior3ow/hq75kcnoeQfr05tPnqrS9GwR5vh0t1vDS3xqId+TDfTSl5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6647

On 7/1/25 12:04 PM, Leon Romanovsky wrote:
> On Tue, Jul 01, 2025 at 09:57:23AM -0400, Dennis Dalessandro wrote:
>> On 7/1/25 8:32 AM, Leon Romanovsky wrote:
>>> On Mon, Jun 30, 2025 at 11:30:12AM -0400, Dennis Dalessandro wrote:
>>>> From: Dean Luick <dean.luick@cornelisnetworks.com>
>>>>
>>>> Add a writev pass-through between the uverbs file descriptor and
>>>> infiniband devices.  Interested devices may subscribe to this
>>>> functionality.
>>>
>>> Aren't we use IOCTL and not write interface now?
>>> Why do we need this?
>>
>> We wanted to keep all the semantics of the user interface the same so it's an
>> easy migration to the uverbs cdev from the private cdev. The idea is that all
>> the command and control is still ioctl, but the "data path" is still using the
>> writev() to pass in the iovecs.
> 
> ok, just add this to the commit message.
> 

Will do.

>> By the way I'll get the rdma_core (user space) changes posted soon so you can
>> see both sides.
> 
> BTW, I looked whole series and upto MAD/verbs interface everything looks ok.
> The latter simply broke me with >3K LOC in single patch.

Yeah sorry about all that. The advantage to the new chip is we don't need to do
all of the MAD stuff in the kernel because it's now done in FW. So most of it is
just carried over from hfi1. The driver just needs to find out about some
things. Would it help if I point out the major differences? I could take a crack
and trying to break that up more even.

-Denny

