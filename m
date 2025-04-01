Return-Path: <linux-rdma+bounces-9085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B84A77EC3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9843AC34F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7F20AF66;
	Tue,  1 Apr 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ReDGU0NG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EF20487D;
	Tue,  1 Apr 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520825; cv=fail; b=imscAnWl21j3sCvSI9Dwoq/zy1nP6bvsOq4qOsr2OgqkxcbrBr/tN5uG7jvcYOHM5u/u3hgL1gVe7ZVV8vAIyCE4I1TKoKqLaa4WEtFtDCpiN/LuSczq05QVC8wkFuk3XSk80BchoHHU74FTNl2a1+ea3pCJrV/uVC/ysuwchcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520825; c=relaxed/simple;
	bh=2EqdwAmGiE9IP6zvrAAOIBLTDRu/lcFaaUIhQ3bpq84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BV5iLxpvcF0/Gxa5oQavpuBMK2cydFS67Fs6v78cTuLA/grEaxzcrWxg6OLYGGrUo78kt+w3cHMaGIo0BDmQZQMEaXKjF4oDm/hk/TexlKMb+j6WRrhvXb6yEeoa42Larvlb1ESyfzoJNZis/ix4ShnP7uM3NXsHCpP/QR+6X/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ReDGU0NG; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enw3VNB7BZ2j5O5/kwW5EEU5bfr1RBj6D3to7iTN+MT+uv5ivRGMpSDvlVy8XS7xWAEvmQy604cqSWIwThi5KdvL91CGxzrL8nUjPEBQ6P517arbUk9YSOX8wAwJGIwe7nYb6W8T8Hj6Tn6uux/tEQ3r3rt5IqaqD4+u58ZpHO/3hhYiznB/myDiw8xqYM5/Gt0bUavpoZEKsqr0mlWGxz06ou5IjOeggkFnpost7Q+WoN76kBmu2h+c9nkCt9CWOuhp79+m+rtkV//JA8SeEHf8lb++mJd1pUObK5AUGy0SBo2mfGFXKtYsID7iaUWkNDJIZOT9mPmvMASGLz1xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYUYQCIc/m8bE2TvPmozVHva91UuijpFhZzGxXkYPAI=;
 b=L2wutfm0T8tnHQZZ1jscMh9LzyWPF2v/Cxq58NkHR3xfLeEfSPJ2FylkPTPf24pqgIY6TOzdbFh7SacD1iO7JTfjTWdDZmMN9okPZSLVWxfZeuehAXW73OL4hhtmJhylXhBcl2J0KDklHrfc4zIAQlwz6F74KqS3eibCnjTMH/EPqZQKRqFTUyFQsunG7c6rzYRoqRXE8K0vJgi3pS1P5ofmK4aipqCwA902Y1nsbCO71hrLTZdqoFUzKX5wkZ0jmd+V7E3SB+pKf1/iiDkDpz+GRAzsrbcm8tADkuW3zmaV++8W/EEK2Snq7L8V8R4CcxaDCiyRaMQbiDFZsX8oVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYUYQCIc/m8bE2TvPmozVHva91UuijpFhZzGxXkYPAI=;
 b=ReDGU0NGvg7NTlm7/teXQ/EBIdSM7/dJKkKOjUFrYwvicz/Tem7t54YkFIgTqFnuF3kCZAbNAvRqocWZowskyQQze2ECXiVk7MFJH1Lr5entsezehDCVKoFNCERyGQR3EztPzCd6k1vep7Pl6ENeMaRJ+HArHT2L5FPjm3TfsVc8h8sDTWXlDndhWTtJMK6IUU5TGHXD7c9+kkTT1Cg2hA6XughKDova4USU1czVTDkrRu09woTZ4WOjt0pp0blJubIb/+k6VN8lCHBI7u0WLGB8R8+M4sSI60FsPIvuyjxC+rl3PYf4GX3yzqo5rM7kftgwhl59oEKraETqKum7Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 15:20:19 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%5]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 15:20:19 +0000
Message-ID: <84bf60b7-2d7e-4549-8e81-bc35efeef069@nvidia.com>
Date: Tue, 1 Apr 2025 18:20:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: hide unused code
To: Mark Bloch <mbloch@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250328131022.452068-1-arnd@kernel.org>
 <20250328131513.GB20836@ziepe.ca>
 <a754f37e-d9ea-4fba-820e-cc56204d954f@nvidia.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <a754f37e-d9ea-4fba-820e-cc56204d954f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb77f9d-d122-44d1-7df4-08dd7130b665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEoyeHljMUc3MTJrT0pqZU1sNmlnR3ZDalZOa1crNThNMm1jK2VzbmFJbElm?=
 =?utf-8?B?VUNuOS8yRkdqa1VKaHBPMnlIeUZ1LzRpQms1R1d1MVhDTnYvVWtiTnZqS1NX?=
 =?utf-8?B?UjVBdFNzdkJzL2xSVC8vY1NBeXNKQUxaTGNweEU4WmxPeU9ORnNQUXdpRDAy?=
 =?utf-8?B?Z0FjZVQ1TjNtZnhscDFmcmJQL3VJWmJ6UjJnalZHRGlZb0hpWCtIRHFoUVVY?=
 =?utf-8?B?NHBEY2tHbmxldkMyTHd5YW1hVW9vZ2NLVFlWazhaKytjd00vUUNUdysxTWM0?=
 =?utf-8?B?dzAyWnlLckJpTE03bm5oWi9nbSt2QWhocFN1VzBVcER0bCs4Uk9FUml3WUlp?=
 =?utf-8?B?RkQyT0VRY2lFRkRkQTE4R0tLT2hMOVV3OUVhUzVCb2w4MzJTOVZCRzR5Qkto?=
 =?utf-8?B?RFJRVVBWRno1ckg5eTFsUnNNOGRrN0FUcTdqRlpLSEhDNDNWUzRaaHVOWW0x?=
 =?utf-8?B?MU5WNjNJd0g2azhjdCszMjMzUDZzOHF0SDdaVGJ4aVhRbWFpTXRFellCWlJ4?=
 =?utf-8?B?blVDd1Q5WVlpVkJSckVSYmlSYlJHYndCRlNYZWJjc1V1UXhrK1ZTYnFndVho?=
 =?utf-8?B?SkRBdnovVlJvTGtwOVcrc1daUEFKdUFuSHkrcTNJSlMxZVlEdncyR2VEWXox?=
 =?utf-8?B?ZDhRVDVrNnVOYit0UEdhNk1WZWY1TDVIU3QzRDVKQzZHNFNONTZjZkpLbE9I?=
 =?utf-8?B?N3BsaDdwSWg1TmUxL2dpNlQvTkgvY0llck5hYkZ4WTZWeTJFS0M1c3BJS0ZB?=
 =?utf-8?B?cGFmZGw3QU5GRGZDUm9KbzVpQmNuSy9QK0xOb2Q0NDJlcmZ1VnVQTWtsUjFM?=
 =?utf-8?B?T0pHc3VPZGlyQVJpS0JNMENqR0xxTWtXUzNvQnZGZDZtLzZsOEpUeFREMjNn?=
 =?utf-8?B?QS9KbjFNOU1GZDA2QmcxbG5KTW42S1JxK04xV21iOFV5SnIzNzN5Q0puT2t6?=
 =?utf-8?B?V0FzZEY1NFE1bHM5d3JvVHFSSjc2RDRSQ2Fyc0JJQTlGaVNWZmZxSTFZUEVj?=
 =?utf-8?B?TnR3eVdmSGZXV1lEU1o1dnZlR2NxNFR1MFdsTlVWUlI3b1NNWmwvUTY0MkY3?=
 =?utf-8?B?TG0xTlRvT0hES3lHYTkzbG1YK3JaQXBZUFJCSnhKbmkycnFDZEREaUhTenZE?=
 =?utf-8?B?Z1RtdERQK3NPZ21XRVgwcGdCVG1kMHp5RUtMaWhxOC9qWjFobk9BY1R5K2w3?=
 =?utf-8?B?enBtOUZKNk1udXhIT0trZnptODZBbEtHc0FXa3gvbk9jM3JpSnlGNFVpUVIv?=
 =?utf-8?B?eUM0dnl1QlpDdjBCTm9pckdYS3haVkVTaEhmQi93L3pWMWljZktuY0NCVmpj?=
 =?utf-8?B?eHNYL0xBVjl0VlVqSEgvMGlKL3hEYm4xS3pYeDZlUnlNUTMyODkrZG42VFBE?=
 =?utf-8?B?OTdIMkN2bzJ1Um5RdFNTU25TMnVXVnRNUng5YzI5WVdNSk5kSmFpL3hwYU11?=
 =?utf-8?B?dXBWUEZTcHF2L1lrU2FNeTBsQmZaSUhRSEJNdmtQQmJvdWlwQmdOYTNybCtj?=
 =?utf-8?B?b1dLLy9NNGhxbXhSU2VweElZUHc2NmVZTlZoc3B2UHZtMmN2RXpoQWh0TXA0?=
 =?utf-8?B?dzl2YmppeEZiclYwK2FpN1RRTXZWSkxDSFI0QXV4MEcrTlJiY1VmNGVjbnlj?=
 =?utf-8?B?V2p0YTF6ckZSaTh1TnhIbjFXc2hkOW15Z1RkRFYxa3Y0ZU9jclNrdUdMbFRm?=
 =?utf-8?B?dzBzMlQxU2Q3R1RQdmcxdDBsN3VCOUhYdlgzMmFieUIyellyTUNicFhKd1lJ?=
 =?utf-8?B?WW1KUGdlSVhNb3NnM1hXSnNIQW9QQzdwUkFNSXlmam1JMFQ4amVMakNXcnJn?=
 =?utf-8?B?cFFUMjJiT2xDc3VvS3QrU1MrS3QvVVJXMThpVmZuTmN4UmdMaUFCYVFIUWMv?=
 =?utf-8?B?QmpnNUp1Y3ZWS0VBVmhGUVFzOEFEZ3IzZ09QVVpmYnNPV2hNeDRCZTJMU3Z5?=
 =?utf-8?Q?c9iA3NfpPaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUoranNGNXJoTmw4aFdvUUJ0aUZuaUxBcFlTdkpZZEJScnBwaDBQZmtHK3I5?=
 =?utf-8?B?MTR3Wk4veHJnQVRsanl5Vk1DdkpkWEg2QzNvVnMzMnAzd0Q1YmMvcmphSFla?=
 =?utf-8?B?UW9tdnpkSDUxbTVLMEZWODV1RnNRdXJsQUhVQjZpa1pHVVdHQWp0TUdSckZl?=
 =?utf-8?B?L2FNdUxDNEFsL3pZM2xMK1hSeVdJVW1YNTB2bWtmM1IzN1ZIVFljVjZZN2xE?=
 =?utf-8?B?ZjRXL3NmOTdJU21GUStGWUhZelo3UzYwY1dTdk0rKzZlMGxLbmZGWC9WZUMy?=
 =?utf-8?B?eWtjZWZCVzBnNVcrRlpVZGNlZUEwbFMwc3g2Vk5BVmVKam1CYjcvZEhXZU5J?=
 =?utf-8?B?WjhqK2V6anJlZERGVUs3Uy9vNzF6ZTNsdlVtV29hNXFVS1ZJWC91UU1RNDhO?=
 =?utf-8?B?YnBoRHRNcm1IWFpVQkRSUnhmc0o4ZmVaQktqTTRLRDlQakc4Mmd4d1J2SWpR?=
 =?utf-8?B?Z0JBdlhiZ1BhbjhDVDlTT0h1RUduSzMrZlBoV2phQ0g0UC9YRThVUmNPSk1s?=
 =?utf-8?B?N2VKYWlWY1JFenhkcDlIRG5LRFNBaUZLUDRJUGNneDlBWHF2Tkw4RS9Kemg1?=
 =?utf-8?B?TWExdmhxdENBQVlhK0hBelIzcEh1clc5VzRPT3QrSmEyRk1Ib1RLVFdsTEpw?=
 =?utf-8?B?Nm50ZmRDS2M3RnZuQ2VwaWtuVkRzb0UzVVJtQkkydU51UU4xeFVHMll2RW1q?=
 =?utf-8?B?TGM1Z282R3hZck1ZRlg1TUxpa3YzRTZITEtiemRuK21EbnU0bkp2WkxjZnlC?=
 =?utf-8?B?UHl4WXZ0bWp3MkNSVVVSUFhpc0NTQjZxMFFsSWJocVU4ODdLVmpBL0dOdTAr?=
 =?utf-8?B?VnJPWElaWkloam5SdzZ2eXpXQnBjRDRSN1pyV3IzMis5K2NGUHpNYWd3WU5y?=
 =?utf-8?B?UHQvbm9nKzg1eEVuam5HVjBMeStUdkp0UE1VVDlyMkFpNGVQQTA3dERFUlk1?=
 =?utf-8?B?RDBzd0tSOG9tQmFJcmlNMVRmNnFFeXdjanNuMEdHdTNOM3E2cmF4MGhrRytz?=
 =?utf-8?B?QVZOVmNrU1RFckJQQ2E3clZ1THFwcVVUUkxmbnBBc0JZN3NoT21ob0xzL014?=
 =?utf-8?B?UWtRN09rdzdYS0ZwODduSkMwd0x2cXI3T3NiQzVIaEtIdWdIdHgwSUNOeDFq?=
 =?utf-8?B?UXVXRnFhNlU5VU8xZU12ZjVoTEVrZTVNdWVXNGN4UGx2Q1Q4Znp4eFJjSXhP?=
 =?utf-8?B?NlArRTRwMFFRSitWOG9oSjZXT1pSZC9uSTZwdi9tM2R3MkJuODgvdUE4ZVpN?=
 =?utf-8?B?N3cvKytLYlFMeVQ5K2Z5M1VaVGo2Q0lodEZBTkJEamJCZlhDZk9CTndrZ3pX?=
 =?utf-8?B?Zm9Ec0FYaWtOOFMxdXR4TW0vb2xjODZyZXJxeEVkUUpHc2htSzQyTk1sOUg4?=
 =?utf-8?B?VVlCU1ZtMmhNdERyc3lhbmRXeTllQTZjZWJrTWpPaW45SmNmbm1tT2Q3bCtO?=
 =?utf-8?B?SDArbmk3TTJPWkdFUGFWRlZjM0x1K2VxM1BWZXpIUXhqT0xQZUxRV0ZxQkF3?=
 =?utf-8?B?aVZHNXR3SitnWXZUVEhqU09kd25LS1Fzdlcwd1NyZFBDOG5wMk1saisvL3lR?=
 =?utf-8?B?QWtHWHViRXk1VVdIWWI4S0VObnpLajdiNm5Mc01JSlBldGNURThqeU9yZGh0?=
 =?utf-8?B?WUpEaHRBeHZPQnBtdG1pb3BmclM3c2E1YnUzWlM5OFlBNXJtWTZLKy9URGhi?=
 =?utf-8?B?dnZuV003aXV4UGtlRkx3SnNYQzAyYithNHVnbEdsQy96UDdsclFKOVZ6SGs0?=
 =?utf-8?B?Um5FL2Q5QUJOakVmemZjUWx2cmJHVzhuYk1raFFZZklPOEFiR3JEbFlXeUpo?=
 =?utf-8?B?Nk1IZHZMMk1PR3N5eUlnTjIra3hsTVlmSnRWaVAzVHA3ZEJTOGZWa0xYcUVy?=
 =?utf-8?B?M1QzeThFa1NNck9wMG9DTUFXc0ZmUHUwOW1zS0tjZDRpckpVREI2T0xPLy9m?=
 =?utf-8?B?RzY3RmppTEpQWngzanNwRnBJeGJpbk5xaDN2UVlEdTlHMXJmdDlHYXVDc25n?=
 =?utf-8?B?VTBzc2w3NjVnM1ppNUlKWlE0aHhJSWF5V2xRK0FIOGFEVmdjcHNXSmVIbmlm?=
 =?utf-8?B?K09xTU9GZUQvMWxldmd6NFAyNytXT3JKY3IyQVV1dm1mV1BmUGZYZnptM2Ry?=
 =?utf-8?Q?kxyh3Gok/kxaySty2ROsvymop?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb77f9d-d122-44d1-7df4-08dd7130b665
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 15:20:19.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x5h91gXZsvfR9sKh5plyX4ezLo/EmICS4fNiGzDM5wajp73clZoI652Dm7ECWPWyzAHl4uPqeeQ4qk//i1Yuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232


On 3/31/2025 12:30 PM, Mark Bloch wrote:
>
> On 28/03/2025 16:15, Jason Gunthorpe wrote:
>> On Fri, Mar 28, 2025 at 02:10:17PM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> After a recent rework, a few 'static const' objects have become unused:
>>>
>>> In file included from drivers/infiniband/hw/mlx5/fs.c:27:
>>> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_STEERING_ANCHOR' defined but not used [-Werror=unused-const-variable=]
>>> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>>>     52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>>>        |                                               ^~~~~~~~~~~~~
>>> drivers/infiniband/hw/mlx5/fs.c:3457:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>>>   3457 | DECLARE_UVERBS_NAMED_OBJECT(
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_FLOW_MATCHER' defined but not used [-Werror=unused-const-variable=]
>>> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>>>     52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>>>        |                                               ^~~~~~~~~~~~~
>>> drivers/infiniband/hw/mlx5/fs.c:3429:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>>>   3429 | DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_FLOW_MATCHER,
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> These come from a complex set of macros, and it would be possible to
>>> shut up the warnings here by adding __maybe_unused annotations inside
>>> of the macros, it seems cleaner in this case to have a large #ifdef block
>>> around all the unused parts of the file, in order to still be able to
>>> catch unused ones elsewhere.
>> IDK, I'm tempted to revert 36e0d433672f ("RDMA/mlx5: Compile fs.c
>> regardless of INFINIBAND_USER_ACCESS config")
> I believe the issue arises because uverbs_destroy_def_handler() is
> declared in ib_verbs.h, but if uverbs isn't built, there is no
> corresponding implementation of this function.
>
> One possible solution is to provide an empty implementation when USER_ACCESS
> is not set, similar to how rdma_user_mmap_disassociate() is handled.
>
> Alternatively, since uverbs_destroy_def_handler() currently does nothing
> (always returning 0), we could simply define it as a static inline
> function inside ib_verbs.h and resolve the issue that way.
>
> An example of the first approach would be:
>
> diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> index 251246c73b33..0ff9f18a71e8 100644
> --- a/drivers/infiniband/hw/mlx5/fs.c
> +++ b/drivers/infiniband/hw/mlx5/fs.c
> @@ -3461,7 +3461,6 @@ DECLARE_UVERBS_NAMED_OBJECT(
>          &UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_DESTROY));
>
>   const struct uapi_definition mlx5_ib_flow_defs[] = {
> -#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>          UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
>                  MLX5_IB_OBJECT_FLOW_MATCHER),
>          UAPI_DEF_CHAIN_OBJ_TREE(
> @@ -3472,7 +3471,6 @@ const struct uapi_definition mlx5_ib_flow_defs[] = {
>          UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
>                  MLX5_IB_OBJECT_STEERING_ANCHOR,
>                  UAPI_DEF_IS_OBJ_SUPPORTED(mlx5_ib_shared_ft_allowed)),
> -#endif
>          {},
>   };
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index d42eae69d9a8..901353796fbb 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4790,7 +4790,14 @@ void roce_del_all_netdev_gids(struct ib_device *ib_dev,
>
>   struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
>
> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>   int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
> +#else
> +static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
> +{
> +       return 0;
> +}
> +#endif
>
>   struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
>                                       enum rdma_netdev_t type, const char *name,
>
>> I don't think that was so well thought out. The entire file was
>> designed to be USER_ACCESS only because it uses all this mechanism.

But not really the entire file , as you said below half of it is 
actually UVERBS , but it has the other half is unrelated to uverbs and 
its compilation shouldnt be dependent on it (that half is used by 
iproute2 mainly), which is the reason for this change.

(Also separation into two files, IMO isn't really the best way to 
resolve it, since in the end they are both still flow steering code 
which leaves us with mark solution unless there is objections to it I 
was planning to send it next week).

>>
>> #ifdefing away half the file seems ugly.
agreed, which is why I think mark bloch suggestion makes more sense, do 
you think it is okay ? or you think there is issues with it ?
>>
>> Jason

