Return-Path: <linux-rdma+bounces-11899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A5AF90E5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD80540D58
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F346C2EF28C;
	Fri,  4 Jul 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i/f3XKZV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456123BCEF;
	Fri,  4 Jul 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625949; cv=fail; b=Hl8SJVnv+xU8IsL5ahZmuuaI2qBAOqslm5phjxVeEaXcJDYblQwL0IPeCcKgV/stp8S76NfxZwooSWGzven/rWnzn/0yNz6Wo0l5n5QZTDoQ6pDBQ4VuFyiiFrOCRzgh7qkKRL5KfSu9XKHnMfeaBcuMCE7iznaebV+DgxGf43c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625949; c=relaxed/simple;
	bh=6frQtp0wDEInbkgxNXjOdpveJWLTTMxSpWGGfpbkWGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kwa66WoSUTsQ8liuQ5VekGV4ffaGqFeQPJuqF+ioN3AmSw96hWk3COwrE1go560M+NGN/JtQcqSyp9GUXPu1rD88hu6Kv1DoT3C9OutTh4/762peS3C9A6UTqs2zIKb97BhvYn+Sk3oyEco8tY6O7lAYTk1yd4veXC+spUulrVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i/f3XKZV; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWxmJqpzYNNBHmodkwRVozVKfJR7KRA1GXLKH9UrV8JkpzIWf/oqiS+GF55zHKxyD8mpUJSLFVhc79SZ8LvzwXI+T5bBaBhzqM4BEP8lgT1L+n4LJjKSw+E2bDSj8QGMh1phgeTJKLEHA99gbu0XYCRbzeqv6WBRH6Z4To8KBCef4/Iq8bZJBW24WKm1XV2/gZ2pl4KpQbl90mIwOdTTFVHQkUCgh1wvviG7Wc2JoX7JnkvF/9hgfZWihwCSqisc8PLZ2aiiDxCbIJjp4HnOxOxnAmgI9pFITkfnmWl3Ck3bJR0bb5dRkPMxkd7+JAqTCk3VOWYDeip+0o5fN/fosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7EStOB9Zedn3Dxl1WW5d+ZXeO7qPpkUndJHwb0LsbE=;
 b=n9183QXGbfuTxtI6z3ze+9E/lI4brDqgbICa8JwnqdUk4qhhE1UmUqjzmO/UFjtgliDqn+SZ76dbuGGPxCDUzBRCtgXGv8bYC+nut+XesCDs1TX+6XPcdNkrsx5TncQIWz/8Mcv9I0SNXB50AbIchfRRpJuX4OQyhtdLoQa1fyFDLPkcWbkmHe6voRDBBzVK6ZjrLf33NvgxsdkCQkN7R6fsv+jtSbPxkLcioUMpK1zzLxzx5h+1GwNzwDP1dxnnQkKTCogUUEcm5xoMoNpuYU/9eR4Vs0N/Cd5Y8ScY3eR4A7BsY1j8HEEK5ai/Mzqt4nU8oS99mpXYJ7I3NFLx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7EStOB9Zedn3Dxl1WW5d+ZXeO7qPpkUndJHwb0LsbE=;
 b=i/f3XKZV6hfeyrZsHflK3APwMholuhtf27cnSd0Rg233JYcHIRyObsgNEOTPSnrlJxwRhL5pTml4uim/3MgwPIj8qDt1H5vY0bbQNnbs2wfGvtSPym9E8tbap7RoPH4peLW5boWv51+3ZXjgZCF/6iaPMuPbz6AxQcO6GAM1a18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 4 Jul
 2025 10:45:45 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 10:45:45 +0000
Message-ID: <3e119daf-ff7c-d509-4409-9551ce3403fa@amd.com>
Date: Fri, 4 Jul 2025 16:15:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 09/14] RDMA/ionic: Create device queues to support
 admin operations
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-10-abhijit.gangurde@amd.com>
 <20250701102409.GA118736@unreal>
 <23018193-6db4-c0be-05a8-ed68853bd2ff@amd.com> <20250703084102.GN6278@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250703084102.GN6278@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::22) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0b0d9f-e1e0-4635-6141-08ddbae7ee1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW5INVlMRU5aMmpoSGE1dnJXMnlQVXRGaDdsdmFHVzNLTnpncHBqK1NtVW5n?=
 =?utf-8?B?YTErTVh2QmZsMC9EaDREc3RSalBtQW4yYnYzSlpIb0wrZFRkSHhuK2dqRXRS?=
 =?utf-8?B?UDByL2pZU0ZpZU5mc0NqdnNlMWw3bFdlSW1CMjZZU1lJcHhnNGZYeENHWWZj?=
 =?utf-8?B?VzJJRVdQd3Fqc2hGQnYrZTZVOWxCT0Y3SWdTWVcrSk85SVhYZ1dkS2RhRmJV?=
 =?utf-8?B?TDhIVDcyWUdndTRWWjNreDRwYkZtaHZEcXo1SUVZdnozalpVYmQwVmRzZWwy?=
 =?utf-8?B?aGM4SEh2cFRucmJ5NC91emQ0R3VqSEd4OXFkb1Z6eGlMb0tVQWN1SjlCVHk1?=
 =?utf-8?B?Q3MzVFdmVW5KUGdPdUI3VHQrK0ZxWDN1RThpMWhPWG1OOU9GSVQzL1ZKNmlv?=
 =?utf-8?B?ZzBDUitndjJNZ3RNdmUwSDNpNWdxYm4wR3loaU9zcnNtRlNmMTl3OXlFU215?=
 =?utf-8?B?WVZjenZ5WDZReElUUUhCaXpWSlBDdDhPWmVjTVF4clduU1B2Q25IZk41Q1RE?=
 =?utf-8?B?Vk9vYk9kNDVwdk5LSVgxSnZBaGZGS2M0UzNSZDlXeHZTVWcwd05GeXpicS9K?=
 =?utf-8?B?OS9hdW1TTGNMVTdkak1Ccld1TTFFcDFibkpieXVGVUdzbVBoK1dnV1Y5cGNT?=
 =?utf-8?B?SEVXbkh6M2RnVCtCQkljenVFa2llNVA0WjB5c01ReEludnAvbitvbGFWRUNI?=
 =?utf-8?B?RkZKUm1kMnkvMDY0QnhlK1RWTmRTT2t3dlcxaFJoYU9xbmNYVXlrbm5ienlS?=
 =?utf-8?B?UEVSTXhwSU1CRDJjeUVVeWNVQzMzWXJ0MmFhZG9mV0xRV3htTkxNTy9LVUFl?=
 =?utf-8?B?czdiT3VSTHZHWnFvbHJJTnZySjdWVUFycFpZTWtDQThXaU5wTkpKdWh1WkIw?=
 =?utf-8?B?VWJlOUFLRjJnOUdjZVgzMG9PYnNWV3JrUndNeDNzWWlYZG0yS014TkRpbTFN?=
 =?utf-8?B?NmxJVU9iR2o4Ui9jSmNGbTRDcEJXMmdkSnlYWHpUMTVrY1hNOHZvUXh2UkFo?=
 =?utf-8?B?MzZKT2JoaUlpV2xoYTllMjNNZDc3YmUxRzRweTdSMkVVdUNVVXVWRDFyb0d3?=
 =?utf-8?B?dHN4dXlLK0NoeTdMdjhJV3JGbHVSQXFwaGlrVUJxM3BLRWIzMXI4QWM4SU9H?=
 =?utf-8?B?OWU2SENLZ1cvci9JdS9sN2hpOXlLb2liWTc1V3RNcGwrNlFzeHNBeXlaSmJQ?=
 =?utf-8?B?K3dyeWEyZ0xvdjk2QTJGQmIrN0s2L1ZHUkkyZnlZc2wva05JSTRNd1ZrR0Zj?=
 =?utf-8?B?LzJUbE5FQUVONk5Fa0NtdHEyQW1NVE9iM0crK0w5RktJRFB0RmQ1UmtBTDEy?=
 =?utf-8?B?TWtmSlp6aWNQOWYzOVhNVEhmWHU1VGJzQlNKMTdBTFdUc2NyTlRiSlhTM3FD?=
 =?utf-8?B?djZlTlhUU2tIYTRHRjg0SjdFdjNBT2NlZ3MxVHowUlU3bG5wK1NtUGFySGw5?=
 =?utf-8?B?aEtUbEN6dzN0MWZBMXZIc3ZibUdYbTJSbWs1bGFqbWJPYTR5TkllYUxZbnI1?=
 =?utf-8?B?K0lQbFpUYW1yRTF2VE5HWnFmTkhMSENuRnF6c0lsSW5oWFN3cEJGdjhaN1RR?=
 =?utf-8?B?eFF3SHlvM0RSQUs2YmtMSFQ2YUw1QjJvK1pXN1EyWVpMZ3ExUTZUMk9QTU5D?=
 =?utf-8?B?UlFwcnV3RDRic3BieFVSTVRlRWJKM3dEYTd1dGowNTE3MTFvT2c5eTRobUJu?=
 =?utf-8?B?REFMSGllU1k0bE1mN1BnbXI2WW9ZSGp3OHBDUUlzNDl1YS9pV01GK1dTNyt6?=
 =?utf-8?B?c2F3NTlkSEVCQnVIY1pHT1hTWG1GK09CKzBVV25ndE1hcDU0SVgrNjFmcnV2?=
 =?utf-8?B?V1Bwd1dqNjhXMW1kWlhiVjVIR2sraUE0RUlPckhCTmpsRTZIVWtGUEJsdFFS?=
 =?utf-8?B?ZmVwQXo3UG9EeUZ1c1FwNU9waWtKd29TNkhOakZ0alNUbitRZEZKdUpDOEJ6?=
 =?utf-8?Q?VvWdUuBs5LU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGl1VnRzcjF4T2NEOExrcDBwMzhWRnUrT29UUmQrbVZiMXBnRU1YdmVRZmxT?=
 =?utf-8?B?YlFBNUFqZnplTWlkVjN4UGpqWS82L0RvS0lpUk5rNEczb2F4T1hMQUxBNSt5?=
 =?utf-8?B?T2Y2V1hqOXd3b3E0dDEydUxSU1RaUnErRmxzdHlEU0MvVzVUWDFkY1JFWFhs?=
 =?utf-8?B?aXYwbno3RWhrVWt3eHhhaTVHOFlVa2p5WHdHM0pMdEJyMU5LU3dIbktqTmtq?=
 =?utf-8?B?MFo0OTQ0ajlPK1lwQ2hwamVRSlJQeHhTRENOVDJtSzlxYnBUaTgycUtFNWpw?=
 =?utf-8?B?UEhEVUYyejluUmdVOVhuV1BjNldVV0prZ2ZqYnJQRVgxS3FwdHdkN1dyOEJC?=
 =?utf-8?B?K0RkdVNQeGlGTUJyWWlvUjF3eWVIZjVRdGpjNzNrTEdzcnZZcmFTM0hYcDln?=
 =?utf-8?B?bE5jRGxsTWVOSWQwTnhVczB0SEVLOWFwN0dhTXBYVVN4dmc0RElsenZQbG1H?=
 =?utf-8?B?NnF2M1IrWi8yTC9BblpFbTZzNVc4em9VMU84K2ovMWJhVjhnYmw3VkdQcXdx?=
 =?utf-8?B?K0xwWWRHeS8zdXpZN1oyRHFxdjNzaFVUYnJBeVNnN1p3TkIzSlhoa0VqL0tw?=
 =?utf-8?B?QThhMmZJaVBHN0p4RWtBTUtCV0FUc3FPT0lkWTV5MFdYWTh3M0JBY0sxRERU?=
 =?utf-8?B?MnVTL0F6WkM5aTVBa3hjRzdueHVDNlJibjN1alovTEVkdG1mQk9RdVprRDNm?=
 =?utf-8?B?NXRvQ01Gb1NQSEt5MzZVZllKYmc3TzJ2cjg3T2FJY3h4S0tsWmEwWHRZVm90?=
 =?utf-8?B?NzhZayt6ZXo4cmdwd3JaYktXaWVibFAvWUJSclVhcno2U2ljdU9rNmVocWZP?=
 =?utf-8?B?Y2M0WE1hNzNTZTZrN2ZpLy9GSFNWU2ZNdFllSFRCb3U0TGVNaG45ZE4wTWZm?=
 =?utf-8?B?dXNHRmt3NVhVMTVzSjBqVnZTVGg5NFJEZlVacUg5aGhNbGoxWXpMM1JKR0xi?=
 =?utf-8?B?Q0QrNVgwODBDNUpwUGY1elZSZ0Yyb2pITDhsNG1WYzI0UmJmMjdXYkh6Y3ly?=
 =?utf-8?B?VHFseEltTGRqajhHVk9pWnRlYVpPbVVlSDhoT3MzTWlaSEhpdGsvWXhWREZJ?=
 =?utf-8?B?Y05GZmk4QVRGbXRPTzNaQTZ6WFdTeHlzOTFwTEUwMFVmaGZPQjJFNXBYRU5R?=
 =?utf-8?B?YnFrdGhERUUyMWYzTklQMjNNSmYwMjNPamZpYk1SR0FqVVNDUnNEM2Vsa1lr?=
 =?utf-8?B?dFU3YUZGMlFCNlZtMTE5Y1ZwdW1jdzZ4OXhoNlA2Zytzc1cyVDMyZnJ1bGlT?=
 =?utf-8?B?N1BncTFUM00rcXRKZkxERDVuUjlvNG9wNzNsMDRtRFJTRjgxU0FZS3BZa01S?=
 =?utf-8?B?VmZENDcyQm5NUjdRQVd4bUFWMzhmeTJFRFpYaGxLZXRrOFZmSHFIVHJkeXlN?=
 =?utf-8?B?RnUrNzFGWEc1UFFNR3NScTF5RWgraVdOVG0xcnhLYWN2MzVkK1g1K0RTM1J5?=
 =?utf-8?B?UXR3dDFNZDBrRVp5UXVWVTRTTEJuSWp0VGR4UVRPY1FDWkVHUmdCSkQvUllk?=
 =?utf-8?B?TWd5THZ5N2QzNmwwNUpzVTR4ajNRSUIzY0ZpWXo2cWRuRGZDcFRCakovWkxX?=
 =?utf-8?B?SmhBLzBWbEVOR05yckQyTmY2UWtna054NVI0eGoxZXJqa240VEFtVXp0ZGx2?=
 =?utf-8?B?VGZjb1RlNU1pZ1dFTFdNZ0tYZ1FCSjhTVHlQNXVkV2diMzFqTjVia3VTYlF2?=
 =?utf-8?B?QnkyaUEwREozcnZuSDZBcGdNaHVZajVnSkVLVTJUeU1tSUQwUFZRbS9kd1I0?=
 =?utf-8?B?am1BcHRTVkM5VzAyMmY1UGJDUVVRYUg1L2RGNjltV3FFMTlMaG5JRzI5RDgz?=
 =?utf-8?B?NlVuWXFBU2dCRmZTU0YxckNjQkl1bStYZWtSUHd6bEtnWUZFeEs4TjU5YnY0?=
 =?utf-8?B?bTJRSFp5b2RNT1VVVnRFQ2d3KzMwU1J5WEZmdTl2MW9Wb1RkcXFuaXI2Um53?=
 =?utf-8?B?THRkRDVveFNySzNyK2RwdlhmQkNJbmlWeFM1OU1tenJKQk9TNlJETzdUOWE4?=
 =?utf-8?B?OTBMeHhHTDRoY3UvL2V6UXFxcGtsc09CNkRtYi9lYzRwNmtxUkNRREh2Q0wr?=
 =?utf-8?B?V1BCc0xkK24yNFd3bmhGOWZZTkZBTzRud1ExT08wOGc3bWhhdExVQk15Yy9q?=
 =?utf-8?Q?ps+IEpscslSuu3ylr7KZ7/3H2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0b0d9f-e1e0-4635-6141-08ddbae7ee1d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:45:45.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKLRuZVSMFVhQq9RpAKrcgeIeIdRzZP5H3mtvJ9KWmf1zUlca22iWlC0tk7UFA30F4el2S57l1cvvvBUEcVcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882


On 7/3/25 14:11, Leon Romanovsky wrote:
> On Thu, Jul 03, 2025 at 12:29:45PM +0530, Abhijit Gangurde wrote:
>> On 7/1/25 15:54, Leon Romanovsky wrote:
>>> On Tue, Jun 24, 2025 at 05:43:10PM +0530, Abhijit Gangurde wrote:
>>>> Setup RDMA admin queues using device command exposed over
>>>> auxiliary device and manage these queues using ida.
>>>>
>>>> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
>>>> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>>>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>>>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>>>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>>> ---
>>>> v2->v3
>>>>     - Fixed lockdep warning
>>>>     - Used IDA for resource id allocation
>>>>     - Removed rw locks around xarrays
> <...>
>
>>>> +		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
>>>> +			INIT_LIST_HEAD(&wr->aq_ent);
>>>> +			aq->q_wr[wr->status].wr = NULL;
>>>> +			wr->status = aq->admin_state;
>>>> +			complete_all(&wr->work);
>>>> +		}
>>>> +		INIT_LIST_HEAD(&aq->wr_prod);
>>> <...>
>>>
>>>> +	if (do_reset)
>>>> +		/* Reset device on a timeout */
>>>> +		ionic_admin_timedout(bad_aq);
>>> I wonder why RDMA driver resets device and not the one who owns PCI.
>> RDMA driver is requesting the reset via eth driver which holds the
>> privilege.
> I wonder if the one who owns CMD interface should decide and reset device
> and not the clients.

To be precise, this operation resets the RDMA logical interface built on
top of the base device, and does not affect the PCI device or the
Ethernet driver's interface. Apologies for the lack of clarity in the 
previous
comment. I will update the comment to reflect this accurately in the next
version.

> <...>
>
>>>> +	old_state = atomic_cmpxchg(&dev->admin_state, IONIC_ADMIN_ACTIVE,
>>>> +				   IONIC_ADMIN_PAUSED);
>>>> +	if (old_state != IONIC_ADMIN_ACTIVE)
>>> In all these places you are mixing enum_admin_state and atomic_t for
>>> same values, but different variable. Please chose or atomic_t or enum.
>> admin_state within the admin queues is protected by the spinlock,
>> hence it is used as enum_admin_state. However device's admin_state
>> is used as as atomic to avoid reset race of reset.
> The issue is in mixing types.

I will correct this.

>
> <...>
>
>>>> +
>>>> +	if (!cq) {
>>> Is it possible?
>> Possible when HCA goes bad.
> Do you have errata for that? Generally speaking, kernel is not written
> to be protected from broken HW. The overall assumption is that HW works
> correctly.
>
> Thanks

There is no known hw issue around this. This was added just as a 
precautionary
check so that wrong cqid does not result in kernel panic. I can remove 
this check if
this is unwarranted.

Thanks,
Abhijit


