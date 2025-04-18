Return-Path: <linux-rdma+bounces-9598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13160A93E18
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 21:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867CB1B67AC7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17359223326;
	Fri, 18 Apr 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISafC1qk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D51126BF7;
	Fri, 18 Apr 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003069; cv=fail; b=qbJFzjxKpXLVL55jKsAMl5pywhVZkHlAY/OBuJRq2ZuBH+LSJnYMPMz8n3cY13PxLyvZNAt6P2L2FQP05iYLa0Gx8YVJ4ykSnKz1Eo8qJqq+kABKMDhGFOtXfFiqU/NkCQLho7dvyr4QpjDOpFOsTIP7LzFN3zqm559LygYaMDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003069; c=relaxed/simple;
	bh=Z8FK8RAAUj7EhffJaDkDd9WQsPMk8abLjt7PELf6yOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plui/ovRsUGyUzTA1aynuREVAYcmyZBguBE4dg1XBUDKMjiFEhaVKTvMwSwHNxpUgSi63nIGKpdG5u39vIP4jjydHfzMfglLIaVayfBuCqfXG9loFHMmjEY1nqZZBpZTMK7pEOJUt777Oyj9ZZdXtHuDVywDsuierVkZs2hDx30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISafC1qk; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ner5gnvS182qvzG/urvA5eO26N/fqnldgAGqr4ILALhqfpat7p4DIPZTnIP/fxBtcDQ5AhM3hvJ4lPG5L20j9YyTHHwEMxe2Ufph3oO8OCiNovlRYh8b0zAIYbLc8T0LzBi09CB5ss1dOtpoQwBXkXkt/F1A2e03xaK2GWFCld6TUhY9BPh0LbRRMt8WsFcwPUxcev79/JqhR4BBahfvY0kq6rToNthFjHWxxF7KSjafiSuzUn3BiQA1AfhCbiGQOBVifkB2T1s8U6wDVQ1V7c46rovhMvnh6spnorgIbm8g0NKtnzmXl7qMmFESB4kE2qxE/csn9nmtRSaaSdVzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wbq+tLXpX5LWHidqkhX4CBYn9jlviPcR3w1DVCIgHo=;
 b=bdvT3lFsrFp5+qLzImRRJykC4OYmSeD5QjCO0UukCzx9D9v4vSM7PWTksXFt92znekDtFUnbBV3OZkxOjY0Im8NFrAt32YXoMNupXbdefbEsvTlJwOwiZKOTLA1C+xYfDNr/dZKJMTRXZ8UVophO0mXprjzIFoITH3eOvCT5ps0dwNFWxojQdbIxh3QEyvM2jp8Cg1dngS1R8G5ak9/hDMq8uVdH31yN44/K4PzqScrvxwjPkxb9xnkh4xMYe2r4gR2gkycLC3tNx6POsDWfBNc3BxEXiSSpHXhRaY2cmrdowuzFQPSSK99mDGnK6fGKNdw+3bDK7dfReZCvtyrhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wbq+tLXpX5LWHidqkhX4CBYn9jlviPcR3w1DVCIgHo=;
 b=ISafC1qk8/s+BeREmCWorCNeYrb+25txlQPeNkA9ue6XoA0ZIYUY100/111E3d57BZVhgGhC8QVOUMfAF8ZJiDiWOBE/pFbvoA0rS+Xy7bMeRGzglXb4qXx13cbG4ybfZL5p46ZYexnAB+0jvW9ne9/U7kGzmDqaOpoP/RqDyhZ8bGZLQAfpbkxRSs/27RqWTJH/Jf9Ag6dcLByf8EN57mkLPRjjUGTvR5KIS3IbTvuUEkzrUb6ZL6NpZ600vGVjLJlGLmRANo3z/nYLX/wy44LaZEWQQTh4zC9fIvu+RyFi7U935HQXCoayIbD1ZN4czI/crslhZf5s3fu0esKv9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 18 Apr
 2025 19:04:25 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 19:04:25 +0000
Message-ID: <d72ba588-65f6-4ef0-888d-fb7032ca6553@nvidia.com>
Date: Fri, 18 Apr 2025 22:04:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5: Fix spelling mistakes in mlx5_core_dbg
 message and comments
To: Colin Ian King <colin.i.king@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250418135703.542722-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250418135703.542722-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: a2583f4d-2a91-44f2-9a39-08dd7eabd5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlNRN1U5RWdSZHdJYzBEbVBFREUzSncrcG95cHpvbXZDTFpIK1VPUGxCbnN4?=
 =?utf-8?B?QkQ5alB2L2Y3SFZrdlBWOHpocytLeWF4cnY0cXR6SGFzQjlscnhVVE9ES3Br?=
 =?utf-8?B?RmVScDFUOVpmclRnWFBBOUNMWVlFd3oxNlBQVnJSQzdwVEpSRnQwOVQvTWJm?=
 =?utf-8?B?UTc4NmRLZkx6QmxQNGlBVHIrZk5aaHlKUWNGTHhZYkZVcit0bTZHTGVoYTBI?=
 =?utf-8?B?amNiOUcvNVlFVXVMRmNQUXJYUWJpTHNkdnZnenl4aFJ6dk9wNXExMmFxcE5q?=
 =?utf-8?B?UmxFNVY2RmZqVHNoVitQMGE3TDYvZDZyYVM0N0doUmFiVHRjV0FMY1BkSWhh?=
 =?utf-8?B?MzlLWDl1SjhQcGRBNms1bUFoYnpFbjZJcEJza2puTjVWTVZFSmpia2tlc1Ir?=
 =?utf-8?B?TUx4bmNLUnhobURaSktxR2ZzMGRjQStHZ1ExZUtDT1d6MmRGVEZqSDRWY2Nw?=
 =?utf-8?B?VU9KYkhiSGltSTl3SWVOMGgrSjcwWnNCdXdDM08xVGpSY3BEZmkxd0hVcDNo?=
 =?utf-8?B?OWNibml5TTZOalZld1E0MWpvZlBXa1RYWGNCbGxGRkVjM3NhZjNTYVVOb3pT?=
 =?utf-8?B?dWdQcm5tOVhETGtlS3RoZzlTeHpzNTdWZnU0SjJLazd1UzlLMW9GbCtvdm1l?=
 =?utf-8?B?bWRiY0QrWGErb0tUVE12NWdiVTZYMCsveHRoZnJmZ1ltdzJ0WVIxSm8wL3o2?=
 =?utf-8?B?dXhqVEJHUC80UTYrWVZMQjZyYzU1NVpJczdRNG5sVnd0MU9qYU9zSWJGVG85?=
 =?utf-8?B?ZHowcEsvaXVUdzY4UU1iZTFJSytRaktiSEM0Zk85b3g4SUJNTUlzSjhJa2d5?=
 =?utf-8?B?QjFKVTY0QXBqck1OWXY1aE5vVklNVWlqWHlVK1JRRXgyY0RySThoU1VQV2wz?=
 =?utf-8?B?UkZNRnptWHJqc0FocE9zQ0NyVFZCMzA0MytDdXYrUm9YWkljRkxBaVdCUHBS?=
 =?utf-8?B?V2NQS3dCWkZFcm02S0xtcllWRW1qUlJjNUpxQ1Q0Z0Z4TnJrSk9kQ0xOYWhG?=
 =?utf-8?B?NkNuanB4eGlLM0ZjZk9hWnd6MTVzYnp1aTVraVNkN2ZqamRkblN1V2JzZFM1?=
 =?utf-8?B?ODdWbHNva3ZHMFpFT2IxdlU5WVdDdkswK29pVFRBbEFNNVpBaUYxbms0RWtZ?=
 =?utf-8?B?cmVQU1FUQUwydTZ6Y0ZaR0tXRG9HWW1wOWgxM291d0FWL2p0ZnRiVWE3eXgv?=
 =?utf-8?B?V01vbGZGSVNNMWJZY2ZhMnV1eFNUVzFCMHR6bFlMT0pRMm1TYUZTU3dGZlVr?=
 =?utf-8?B?dVNBZjhNcEpVb01lMEI1RUUydElTQTAyYXVEL1V6R2RGN29WVzIxVTBXY0VW?=
 =?utf-8?B?ZS9PcUl6VHgwemtZb1FUTzdjWFdhV2U4ZlpRRGU0d2VrcEJWOG5yamxVZFkw?=
 =?utf-8?B?L3YrY0dlaHE2b0dMaFRBcFFScDFVVkswUlplSzJOUEloVmVLakFQU2ZCZ2Np?=
 =?utf-8?B?US9IRGRDV2JIRkRpNVRPT3VRLzFGNTJWbTh0WnN0K0JucUVZaXFsSXlXZEVD?=
 =?utf-8?B?aUFtRFFzTGRuV1dlRVl0dzM1STdYUHFURHA1M092QnNZdUVUTVV1eE43V0Jx?=
 =?utf-8?B?TmMrS2t6R21Xb3l4T3gwTktQK1ZXSWpmTzJ4RlpuQk5iMVIvb1o4YllPdWNB?=
 =?utf-8?B?a0Vvc3k5QkRVT2hEbkVoVk5FbHluWXZQNmJLL2w1T1NNUW12OVd5NFZMM2tw?=
 =?utf-8?B?RzBmZnFZeFFMQy9rUXdFd3dxY2NMS1lLUndybi96NVlIUk5sNGc2RHRPc1d1?=
 =?utf-8?B?MFprOXlVY0MydG9kUHozYXVCLzg3Zm05OXdodi9tcFpWVi96eDN1RUZVRER1?=
 =?utf-8?B?Sll5U0dWQ0Y0WVRMMVZ3TTJUeTRFQ2tnTStwTnJxR3d3RUdFbHozaHdZMm10?=
 =?utf-8?B?anFkWC8yZmJidXZJR3h4a1dsY2F6RTd1UlBzZGR5aTRPZG5ZRStENyt6SjU4?=
 =?utf-8?B?SWYrSVhzTWU4ZHZuMThuMTNIdmhMc1AwWmIydTM0eHhxczBJNUJCQnd6dHdt?=
 =?utf-8?B?dUFoWWRIV21BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNuU0VnMVFiQi9VZkRkdWQ1UkErdURVMTNBdTI1ZzFDdE0rR1NHblI0U0p2?=
 =?utf-8?B?NTc1TnhNTmhpSmpreHN5cTV2ditzWVRFRDN1L3VnQXFteDFTeUlpUWF1dDdz?=
 =?utf-8?B?MXVtNXFibGZrK0dkM3F0clRxQytmSEc2TXMraGdwQ3JFTVpBYWg0bDZJNWxV?=
 =?utf-8?B?WmFPTjBlM2hRTnQwTzNOQlp6SEVrNXYzbldLV1psTU9GbG1jRGdscUV3L3lT?=
 =?utf-8?B?RXZYSWgvSmFBUlorR1h1QVhyVDRrSFkxditaYXI5cVd4eXdzV3g2eStzVDVu?=
 =?utf-8?B?NC9Zd2RYb015V2lMUjYzLzIrMU9kRWU0RjZYaVpnUFdRWjMyTzRVQWNJRVlw?=
 =?utf-8?B?cjY1b2pmYmp5eERkOWpldjRVQW5kS2ZwU0ltTnZzYzdpaExDN3Exd3AyVTND?=
 =?utf-8?B?emRQT2ozSHlkTEJsc0ppVlN0YWZyaXYrUkVLK0s2QW14aUd3MG05SlRJcU84?=
 =?utf-8?B?OEt3QVg2L25tdWVQdGM3WXg0T1B0cTc1TjloUXpaUGdkdmVBeWdGTVlsWXp4?=
 =?utf-8?B?MjdiNURnbXJYbVBGbTU5TnkzUTF2U1F3TVpLVVI3REdpSUFhejVrdDRjSE5K?=
 =?utf-8?B?b2NnYk14WDNvZjBXSGdNd0MwNFpyRkJibll5UGM3SWl1bHJPcXllT3NYam1H?=
 =?utf-8?B?VkhxdXhIR21UR1hPZlFIYjhFV1YyR2tDdVJZQ09nTnpyTHRwcG5zRElBRzV1?=
 =?utf-8?B?SWxMYlpBa3gvZ2hybEhYUWxFRXljdEQrRDRvMGtzUC83aXFFbnZvSFMweUo5?=
 =?utf-8?B?U29FbUtzZVlJZ2t6V241NHoyWVJFUWt2UjNhSHA5c1ovRTZSZzBCeGNIL1pT?=
 =?utf-8?B?azA1aW51RGN1QlNNSDEwL1Z6WTIvUDZwdDh6MDd5aHpQTDIxenlGZ0dNYjMw?=
 =?utf-8?B?dURVek1OQTM4Z1B1NmtxeUs5U09ZbEN1SVF2N1ZKbjQrRWZWM2lXTW1PSDN2?=
 =?utf-8?B?UHhkdG9Vem41TVFETnVsOFdVYnhTN3pMcFZ5VDFCY3hBTlU0dndpeXpjUm9S?=
 =?utf-8?B?MGNoMlBjdysxUklQalorRzJBbXh3Zm90VENlMkw2TS9BWmk5ZG40cndRNENZ?=
 =?utf-8?B?RnRabzhQM0NCWVFlU0tFQ1F0VG9PbVVHdGdmSC9tVjJuNHlWZnJEQ2JGR29Z?=
 =?utf-8?B?YzFoV1o2bnVFOU9BT1o5NWJtbmtFZEJqT0JrZXpaSnZiK1FNamExMDFBbDdi?=
 =?utf-8?B?YllPcjlaNUJOanRTNGJJd1dGSlRyVWRuQmtuYi91NjBlaTZPaXRQT2hCQUNv?=
 =?utf-8?B?bTZNcFZYN0liZG0xeHZXN2cxMUVJNnB2QzJ3dVVVMDFlcTc4UUVRSjFRdmEy?=
 =?utf-8?B?d05yK0prRVJHRGIvWVBRVzhDcWJ1TVptb3hDUlhNOFJualFnWXI3Zzg4OTZV?=
 =?utf-8?B?V2ZiS0Jra3E5dFVaRHA4bld5NEJud2xzRThyeXc2di9ybXVER3QwV2NFV3lj?=
 =?utf-8?B?ai9NR2xhbnM2SDFVRzBLWlFQOHVYTDRqaVZkSFVHN04vTTJoNHdKT3FlTDVH?=
 =?utf-8?B?YmRsdGZwbFRoaGZyNklxb3FtRmE3bFlWWmQ0cTIyUFNhMFhrOVdXVXhJdkkx?=
 =?utf-8?B?N1FQNnVKRGJNcVNKNld3eTZvRFNYamxvVmFIY2FMa2VrYnArKzNMczdmbFVm?=
 =?utf-8?B?cDkzYXhycklTRVFoSnBBZlhsUDI4N096NnlQQmR5cit6Qk8vMUkrWXlucmph?=
 =?utf-8?B?YzJqeldsaDBxd3VQWGE3MFB3ZENXVXkyMUMyU3ZrS1BkUXMvN1htWjlSdkF5?=
 =?utf-8?B?VVhTN3VJc3pMYVB5dm1xeExXMTRwa05ibVpyZms4Z0dpSjRPd3lTdmdNdjRm?=
 =?utf-8?B?MDRnek1oTDJqZllPZXBKRCs2U0ZJOStscTBpQlVZRUIvTU41VGs4endCSm43?=
 =?utf-8?B?ZTBDMXlCRDJDdk8ycUg5Ukt6WWpUU3kvd09GVWlJRHhkWG16UmxxWGVYVEJM?=
 =?utf-8?B?SmxITUxIZjNYTzMxNHMvYzdRdE1WRFUrOVRRSzE2ajc2aWVSRnVDTXdVOUNh?=
 =?utf-8?B?emtOZDhIL2luNEpHTGRNSDA1OEpMK3JCRkVRWDFiNUxvaXN6Z21HTWJEaExa?=
 =?utf-8?B?ODZoQkV3TTl5R0dqUm9pa0xPaXM0R0hHTHB0d05BMWxxdFEwZGYyN3g2TWVM?=
 =?utf-8?Q?+FikZadk4SR/1jVcEaYvXu2Dh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2583f4d-2a91-44f2-9a39-08dd7eabd5ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 19:04:24.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BGdil1UkXJ6Oo+kSUm1xrGycCO3U3cmZbvbKl0bXkMQk7JUKlOyGVg3E0rm6SQFC+YrvW1kqkTzwm0IXYnmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229



On 18/04/2025 16:57, Colin Ian King wrote:
> There is a spelling mistake in a mlx5_core_dbg and two spelling mistakes
> in comment blocks. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 2c5f850c31f6..40024cfa3099 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -148,7 +148,7 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
>   * Free the IRQ and other resources such as rmap from the system.
>   * BUT doesn't free or remove reference from mlx5.
>   * This function is very important for the shutdown flow, where we need to
> - * cleanup system resoruces but keep mlx5 objects alive,
> + * cleanup system resources but keep mlx5 objects alive,
>   * see mlx5_irq_table_free_irqs().
>   */
>  static void mlx5_system_free_irq(struct mlx5_irq *irq)
> @@ -588,7 +588,7 @@ static void irq_pool_free(struct mlx5_irq_pool *pool)
>  	struct mlx5_irq *irq;
>  	unsigned long index;
>  
> -	/* There are cases in which we are destrying the irq_table before
> +	/* There are cases in which we are destroying the irq_table before
>  	 * freeing all the IRQs, fast teardown for example. Hence, free the irqs
>  	 * which might not have been freed.
>  	 */
> @@ -617,7 +617,7 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec,
>  	if (!mlx5_sf_max_functions(dev))
>  		return 0;
>  	if (sf_vec < MLX5_IRQ_VEC_COMP_BASE_SF) {
> -		mlx5_core_dbg(dev, "Not enught IRQs for SFs. SF may run at lower performance\n");
> +		mlx5_core_dbg(dev, "Not enough IRQs for SFs. SF may run at lower performance\n");
>  		return 0;
>  	}
>  

Acked-by: Mark Bloch <mbloch@nvidia.com>

Thanks

