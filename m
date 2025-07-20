Return-Path: <linux-rdma+bounces-12320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E327B0B44D
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA21F1896712
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB01E1A33;
	Sun, 20 Jul 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XYT11pEF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415053D6D;
	Sun, 20 Jul 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000758; cv=fail; b=i/Vyi4ltnsbsmzvMSm0ZGToSluaf+CkfiprTggt7l6BKKCwV7MRSFWL2Xjf872ZypFbHCqSNx/69YSny/CZzOktcRUdD8PJIj5mPBrZ0vu3BvIDO0drMysiZpyoSdf1HwRzPFTD9OpHxJ1B7Btfc9eEf9HcLjY01Jvy0acsMRVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000758; c=relaxed/simple;
	bh=MdgSMuUTC7yrsuuLDCeIgUuFa7mL7fpTWiD8MTe+sHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJiffaOOq85s3Je3Btat850kOnwvRciT2AXvLXN8Ke/hIVWohS2pX5zvL+ffLqL9QsTRl1IjflzmgMpdOlKjifu2qfCQVr3kBGV8zNFO6xSNos2/gDB8rMOJOZwct9LGa6OonUG9SGSsOAp8annSRfykyE3VMkGGq4AkCBfvejc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XYT11pEF; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8Fk0legoCEtOM3YgnI5Glz6EjYgykPLSDQD5CyumHZacGtQD+ovcEmthMhAjB/jAwjopuYrUcK8HhXOuTros7mQHREupLNSJ+ATCiXw94/7b5mGtp+L0BNj5FrnLmQDbAFPp5OBohqNhMuEKl8OUaFIq6EzBxs8qjWm4ZkHLmBJhZl97trGlIDLer4vDLeznuDdpAjaNsLpqz+EYTYP3rLGb2LqhBcioolJGunR/mclSG2q9Rtcac3VeOXFv4B2236YVDaSs1mSZBn/rBm/kVa1aNX9pDgxjrzlAYCvcJwulqSs9wi5Bqr0ctiRUnl1RzL+vRWtdlsZ/khXHeL2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3VNFlCykZegaueLqHv0vCnW26cUzf3t8TjZZ2Z21WU=;
 b=kCTBt3QuVePnds2ds7cba9y0SxxhtJL3Anh9rD15y+BAoqRtoc2aQMm+5usEKnRaqIKlx3ELC5KtohlmAl2mBX8Q1cdNGGPZcAtpkvvEgPFecHUhc+6SdKd0ar40PMBzXBHd93KXdK4ugbKfhGxk9ficKmn3QTQRIEHq2cbG1/6jWNjCoIyDqHemsBIvjUt71DEg0NL3UYez2mrqECBsI0utBTSUbfPmns2YUWVbJtOgsM29narSabx5jLhBTil/s5nCAveo0c2mRfZoKtx9jcB9fD2/j1XvbM55QfdarGWkazLWBoQxFHqc9d5kYwMRpOz/v5g7sJPEH5jQa1KhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3VNFlCykZegaueLqHv0vCnW26cUzf3t8TjZZ2Z21WU=;
 b=XYT11pEF37vIGmOs/BMNqF9iSq13oA/NvebnFp0z1KeLpIRkQfLfvdPCtPOnVH1GeApXZ/f137QaD1WFful4JdghYV1g8qmTDUEqMu4u0oUo+inpkbggFhf4cW3zjBIxtFv/XjhNB1EbzWRu5xDx5gzWRofaiZecvGhRF78+XfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 20 Jul
 2025 08:39:11 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%5]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 08:39:10 +0000
Message-ID: <4218f338-f3c8-460d-148b-20019d32b841@amd.com>
Date: Sun, 20 Jul 2025 14:09:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250702131803.GB904431@ziepe.ca> <20250702180007.GK6278@unreal>
 <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com> <20250704170807.GO6278@unreal>
 <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com> <20250707072137.GU6278@unreal>
 <1a7190d4-f3ef-744c-4e46-8cb255dee6cf@amd.com>
 <20250707164609.GA592765@unreal>
 <76a68f62-1f73-cc81-0f5b-48a6982a54c7@amd.com> <20250713062753.GA5882@unreal>
 <20250715191629.GA2116306@ziepe.ca>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250715191629.GA2116306@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::10) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba9b44b-b9ab-488f-731f-08ddc768e5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmJRT0VPODl6QjVGSW5EY0xJK1h6MHltdU42dWtNTDI5VWw0SExuNEhxNlJn?=
 =?utf-8?B?TENmdExCZERYU2FhOG44TzlMeDNmME04V1pWWEdKWHlrZFJvVzdOYmdtcVFL?=
 =?utf-8?B?ZU93Yy9DSUNmYXJ4c01uQVcwT2VrUzV6bmRmWDFkNTRSZ3p2RnJFUUVVOFFu?=
 =?utf-8?B?ZjBPRC9rWEJzNUt6SkZUUGt6WHJzWVdBQ1FsQ2JZQ0ZqclVXekxzRUJOaTYv?=
 =?utf-8?B?WExzcDhabXhNYlhzdTVMWmRyRURGNXNZcm1kOHVSeEJOT3dnTjZBazA4QTU5?=
 =?utf-8?B?K2tJYUJSMTFXa1ZTeHVOVTBpQ2hWVUZKbzMwbUZ1Sk9VaUw0NTQwYWpyZnZW?=
 =?utf-8?B?M2MyTmZVelZ0bnNKSXlHZXZHSkdYcW80RndZa1ZHV2h2VmlPMWRCRFdYVFFF?=
 =?utf-8?B?cmRQWEV2YjVwM1VHVkJrQnMzWm5oWTBCNW00SElINEZtZkxobXJNcDZGa1Nq?=
 =?utf-8?B?bFBrUFdNWE5XOGsxL3lkdXhSMHJtSXNvWkt3ZTRjYjc1T1BUY240Wk9YOE41?=
 =?utf-8?B?Zm5xUFZYYVpiUzdQY1JIY1pwREJJczhqeTYvdUV3elRSamZEZ0Z2VHROanEr?=
 =?utf-8?B?aU9ZTUdhWndJd2lEamt6cWIzWUpaeXpGNks4Yi9rWDc1ZVJCTUpvVnJJa0hF?=
 =?utf-8?B?RlRsREFkRUlBVGR0NzUxV2hISkdweDRxMTFNR2pZcnM1U1ZLTDFpYkhuSnJE?=
 =?utf-8?B?S29OTHhkS2xVQm9qeUd5S0lhNkdSdG5uZ1dQQU1LUk9rdWZFUXI5NjVnbGk5?=
 =?utf-8?B?ZmdMNGViUmpMNlBrb3N0T096Tzh4NEwyZjJQU2pVOXE3cFAvN1Jla1RlZk5p?=
 =?utf-8?B?U3VWM1REU1VDVnh6eVBjSzBKRHk1bXJaeElVOUdyMVRzZ25DRHgzeHcvNTFP?=
 =?utf-8?B?NjdoZ2hrdVUyL3MrRHQ4SkxmOWdYNXU3UWtHVURuaDkvZzg1M0YrS1JiRlhs?=
 =?utf-8?B?OWpzMy9GYU1Qd05OQ093TUVVR0QwTlNZbWZySVE1Q0JHODE5TjNNOVppc1dt?=
 =?utf-8?B?a2hvY2dJM3U3RTFMSkZSQmROKzJQTEZpQXlaREdpMTlXRE53WVMzenA2WlY2?=
 =?utf-8?B?QjMxQlFIUGttMCtKVFdzQVo3cHJycWtpMlFMSTVhaU05SDNHaXRCcGlmOFRX?=
 =?utf-8?B?blZ6N0E3VWhYOVRrZzlDTFFlMk1oSnR1NWxlc0daSitPZy95Q1IwaURFUW9R?=
 =?utf-8?B?Z0VYM3REa05pbEVIN0VvMVZIRjJBZHVoMTJZWWVNL1lsOXR2MDFFTG92M1FZ?=
 =?utf-8?B?dWtoWGRIcmlXdzF0RDIwcjVkWjZiamdUcnZHTG5hMXNRa28vWTlnaVRCMzhR?=
 =?utf-8?B?NCs4MVRPTzB5aElCc2FhMFR6aUppZTcxa3hKS05MUU0yVDN5ZWFQWEVpT0RE?=
 =?utf-8?B?cm9CVkZhRVYxbmlFcUdsVFBiY0xXaEloY1R6RTZtd05QSmF0SU9kZzdOVGdr?=
 =?utf-8?B?dGx5ZTg3OTk0bWdVblVkU280NlpzQ2Q2WU9BNmtmZmFwdzN6YVpJYnZnWnhH?=
 =?utf-8?B?OHljaWF1Y2k2ZUZTT2tYbjJHN0U3dk4vVG9WSGtDRFI0UmtucGs2V2MraXN5?=
 =?utf-8?B?QXhGbVZjWnJ6bExFY2ZRMWt1QTkxMU1PM1F1Mk1ldk1mTnJqajR0RnBoNktZ?=
 =?utf-8?B?M2gwUGcrMGtvamRoc0hxU204aGlxWkdUbVcvNEZ2RXJzK2NhdXl1cU5DdU5S?=
 =?utf-8?B?blBxQUxiZy9hb1Y5K3FjQnJXckJ0T0w3Sm1WUlhGQ0NQeEU3Y1AycWl5OG1T?=
 =?utf-8?B?OExUWFMxQ3c4TUdvblFMY0hyNVlvMisvdGJRT2ROQlRLREgvZUxmWDB4T3N6?=
 =?utf-8?B?NDBvMkV2WklWd3Y3ZjFTN1pzckNQODNkVElaVXZGemZ3WkRYRXU4V0s1MzVo?=
 =?utf-8?B?UjZwWFlwUldiVStnZmgySFpFbCt5TWVMWmpTTk5NOWZUeUNOaXc4Mm1MYjl5?=
 =?utf-8?Q?CI3jAbup3mw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXZUVVRoaDJadnlDUE5BTGo3bTkvRWNWRkdwRjJnd3RGMTlDdGltb0prRXVO?=
 =?utf-8?B?STczemptbE5qd3lsdUowYlN3cnE1NUZqRXovK01HdmRBaHMyT1ZGSm5VSWRS?=
 =?utf-8?B?dVdReGVteWYrUUltcGxnNkJXTGZpaHFWd3RCUTNFS0dGOElibllsUUtGU2tV?=
 =?utf-8?B?cmlMMVBlVUExZnlpZHFDRDBOaFdwMGt1Sk1meUtZU2tvdzFzSEhUWFozamUy?=
 =?utf-8?B?UnNWbUIzMEJwcFIzZEh4UDdVWGUrZlhFVFZ2S2dKV0VnWnV1RERINmtEYXAw?=
 =?utf-8?B?NEFLZnpLeFVZczQ5SjlsNWVobC9nUkdiWnZ4c2NKaU1NSEF3d0Y2Tk9jZ05o?=
 =?utf-8?B?NFBvUHhZTXpvNVZTbU96K09ZZ2owWUZMeUxuR2hzbTdmcEZ1MEQwQWdkUFMy?=
 =?utf-8?B?K3RxZE80ZFR3TVRlK2JqbmpKY0xheXFkQ3pCeTluRS9VeFRWRnVzZDRST1Zt?=
 =?utf-8?B?TkNGUlNYQ2xpRSs3d0JGczZvbnljTGhDbGtWU005clRvUmVrdEhuSHFodkti?=
 =?utf-8?B?SzFCTHAzUFVQTkxQc3BFV3lkbTN3N2dJWWVxakIvK2pxMW5lR243OUZ0aGpK?=
 =?utf-8?B?bXFXQ2lRTEtUTXdxSjQwL1lod3M3a0Jhc1hZUFc2M2xzVzFoZ0N2dzR3YjVk?=
 =?utf-8?B?dFFwWG5BYTkwZUxGWmp1V28yc1FPZzRiZDhCQU9vR3pVeEUwR2RFSGF1dzU5?=
 =?utf-8?B?UXhERUYyeHpDeTRsQWNMeFdyTDZZb05zUE45ek1NSnpVNjJNc2dwK2VobEpj?=
 =?utf-8?B?RWp2a1NHMUU0YVJZNTFLWlROL2xaWnpnTUdvTEI0bkxINjZCSWlKKzRobUgy?=
 =?utf-8?B?MHFhcUdGQk5lNnNHSEg2bXZxYkkzWU0zSTZhOFpvTjRCbE5KdEd3aGd2ZEU4?=
 =?utf-8?B?YXcxZmdkM3dKK3JGV2trNG94SkRiUGhCTExwREpMOGNHOWc4dTltYjVzQ1l5?=
 =?utf-8?B?Y09DWnJTTm5yZWJIbk9YenJnTmRHTjJXTzMyL2JnRm1FZVZWem9hZVVjZlI3?=
 =?utf-8?B?VURsOVprWTBVVmN1LzMyYXpqelJyaUhScVdTdjZHcVpVRllDaG9GMmpoRFZY?=
 =?utf-8?B?dGE2VmNjaEpYVk5hQ1pDVG0rU2o4dVZsL01hcHZnbjZKWUU0bHBLZHJzUXhP?=
 =?utf-8?B?KzB1WE41eWVFQ3l3V1J3N3YzWlNYQjVRWmF0c2tFWFk3OWF3cmo0elhLRHlX?=
 =?utf-8?B?OGhHRnBIbDR1SmwwY2gyS2NFMkFUaEt0bDIrMlgwb0RuTDVqNlBjK1BjZ1BV?=
 =?utf-8?B?VDlpRVpXb2l3amhjUjY5OWd1MEc0WVphMURnWWxFQyszQzRLYk5DaDdqR1NQ?=
 =?utf-8?B?YmM4VEVRbFZIT1V2ZHlrWVU0WDFoQ3lUa0Zpd1I1YXMxZUxiNjBVZ2ZMWUpl?=
 =?utf-8?B?Y3MwdkdESERIYnB1eEVuNFRQWjhaclhKQmFsdWtueld4QVQ2V1RscnYwQ29s?=
 =?utf-8?B?R0l2UWJrWjNpVGRxQzVqSC9UOUlDSzIrK2ZnaHM4citTRzFBVHVZWmN0RkR5?=
 =?utf-8?B?K21vVEhSMzg5ck1kYUZPNnJibnkrVDNMcVJ5TVVNRkdQSDBJZFhnS1lWR3pP?=
 =?utf-8?B?TlJsN0JsTTJhK3lZVTZ5TE8vNmNuV0laeC94Z3NNQW5KcU5kanZ3VG1ZRXhH?=
 =?utf-8?B?WjhoNWN6UHV1NTFnQm9yaVc5cTNsd1FhVmorSjBqT3A0dUNuaHZYSURoMWpG?=
 =?utf-8?B?VjEzc2tUTEFUWVFrSThOUWt6UWhwTlpIZytCT1A5YjJqVGVJVE1KckxMcUxH?=
 =?utf-8?B?dk9NU3VxL1hXc1hBRFRlLzlBZDl4dFpnU1MwSGI0WWZFM2VIazh5c2RZdEVw?=
 =?utf-8?B?WXozY1hVVDRaa1o5di9jS21jd0YvZEZJM3RyTW5RMnlVQVNMTDFMNm1xRTVs?=
 =?utf-8?B?ZUdoRTJDUkg1WHlGTVpvZEpwTFJpcFZ3RzBwRHhTVzRESTg4dEloQmsrREU3?=
 =?utf-8?B?Vk1obTM0dUcyY0ppalk3MDczYlRlSUM0L2FQQzBveHl1Znkvc21LOVVDYWxp?=
 =?utf-8?B?NnhkbStxdzUwSVlRTkpGaHNXVnpSN1F2Wjc2Ly8vV05zVGVmYkJsMGxCWHdj?=
 =?utf-8?B?S3NPNEdmYjR4RjBCTGVreDc3U2l2Z0ErZERSWllYNGpkTXluaCtzK3dTck1z?=
 =?utf-8?Q?Q+woEIthJ0x+FJF/PyTfQ6kKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba9b44b-b9ab-488f-731f-08ddc768e5b6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 08:39:10.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cYQEn0qW2lABj5EByO+wcgf2jDeKEK7rgJXQ/L052TAKQ00UspRHHjYRtvlfCKloI6Zgc1+tWq6gfvgZO2YcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

On 7/16/25 00:46, Jason Gunthorpe wrote:
> On Sun, Jul 13, 2025 at 09:27:53AM +0300, Leon Romanovsky wrote:
>> Let's do what all other drivers do, please. I prefer simplest solution
>> and objects that can potentially be around after verbs objects were
>> cleaned doesn't sound right.
> I think it is OK, at least QP makes sense and matches some other
> drivers.
>
> +static void ionic_qp_event(struct ionic_ibdev *dev, u32 qpid, u8 code)
> +{
> +       struct ib_event ibev;
> +       struct ionic_qp *qp;
> +
> +       rcu_read_lock();
> +       qp = xa_load(&dev->qp_tbl, qpid);
> +       if (qp)
> +               kref_get(&qp->qp_kref);
> +       rcu_read_unlock();
> +
>
> The above is an async event path, and the kref is effectively the open
> coded rwlock pattern we use often.
>
> The unlock triggers a completion:
>
> +       kref_put(&qp->qp_kref, ionic_qp_complete);
> +static inline void ionic_qp_complete(struct kref *kref)
> +{
> +       struct ionic_qp *qp = container_of(kref, struct ionic_qp, qp_kref);
> +
> +       complete(&qp->qp_rel_comp);
> +}
>
> Which acts as the unlock. And then qp destruction:
>
> +int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
> +{
> +       kref_put(&qp->qp_kref, ionic_qp_complete);
> +       wait_for_completion(&qp->qp_rel_comp);
>
> Which is the typical "write" side of the lock.
>
> So this is all normal, the qp doesn't outlive destroy, destroy waits
> for all the async event deliver to complete. It has to, we free the
> underlying memory in the core code.
>
> As long as the other case are like this it is fine
>
> +       xa_erase_irq(&dev->qp_tbl, qp->qpid);
> +       synchronize_rcu();
>
> This should go away though, don't like to see synchronize_rcu(). The
> idea is you kfree the QP with RCU. But the core code doesn't do that..
>
> So in the short term you should take the lock instead of using rcu:
>
>         xa_lock(&dev->qp_tbl);
>         qp = xa_load(&dev->qp_tbl, qpid);
>         if (qp)
>                 kref_get(&qp->qp_kref);
>
> Jason

Thank you, Jason, for reviewing the logic and explaining how the 
kref/RCU mechanism effectively ensures correct synchronization and clean 
tear down during async event handling and QP destruction. A similar 
mechanism is currently used for CQ event handling and destruction as well.

Your suggestion to avoid synchronize_rcu() and instead take the lock 
directly for xarray lookups makes sense. I will proceed to replace the 
RCU critical section with xa_lock()/xa_load(), as you outlined, to 
better align with current best practices—unless there are any objections.

Thanks again for the valuable feedback!

Abhijit



