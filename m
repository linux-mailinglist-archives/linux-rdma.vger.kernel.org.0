Return-Path: <linux-rdma+bounces-4810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA1297046B
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 00:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD01F21E66
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46249160884;
	Sat,  7 Sep 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgH0QpWA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E6136664
	for <linux-rdma@vger.kernel.org>; Sat,  7 Sep 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725749441; cv=fail; b=m3zvGE3XHudtGss4D+ZBCvNzWd/4jAu3aX/9BO4kjDF7CDxXsapb4X6wwrRd4r3e3uUF75QLk14UgI/amAnQ/4IeYIW1uq5zsC4HYaUQQAgekxoYnJW0j4v+Mwp/7E94sSnERFBwg0VlSD8vKDgAxc7WX6zmARFdKXeBM9HVqaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725749441; c=relaxed/simple;
	bh=VUxHuXaeK3VAdo8vWH4QTJxfxXyiXhSBhKJComFs2zM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnjwyIsEnzFKHrLUOdirHK7KowPguGHUBEgsCQIc4mdDIfl9pub5rkjm501ytS8sOHDSuJzpim0cTH/G7NCdnJiOiDsgJ07v16IurBIEprX2MQFV2FGBQEmb1NFUMDhwcCt+Wt9vPKlhS35axoZ/3uGjrykCzHuHj/ZD64gBRlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgH0QpWA; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsYgwLCvff/JBlng21w4o05co7mHCp3Xvj4tLlVtcL3yoM28m7FGEKDsu3fGTt7zPZKU9hWrGgfVHF4SaGlcAcB64eNsibpraGfx6GbjX3ICespV4rzzurwUQhLa9VRhydSPjJwh0dprZV86dfwOfxLVW8yjGN3KbuWX5IlMrvmMr0JYJIo7aSERPWzT/y3Wa9RpZY16mov9yGcAhlONzCndfMLR9rX8oardreGbz3igpknbDwKTV6tsFkYkHP3Eg5ouITj4XcELj1iBIXxxaxiarT2nuUrSOpzjJNPs13is1y8uYg0tcq/G1zyTh18hpbeTpodch8oycHDn4TfjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndm3Lq/8sM87wI/yqKNuk0kuHQObBlpWvEmjZxRS8Vk=;
 b=gzQjrzUCHCjKexEv5sjvzUpcgiyauM19N8pwFU6SwAJF4YDJOKC38qWOYh5bayt8loo+nTOnDov0FojGh/jY4xAcx7HoHrAWdPtvtDNGhAVMBqlBEXMDFpO7Q/p6GWAAZpQ/uDdYPi23crIYxtqM6bBhBoHsj+9usgWl+Qu/+hr/AEgSMMtrukDC3+oeUjYgm1bX3q1qvyBE951kHm1z4P22jv92gRqaU0iApSCrkzMWFfBz++LycIuWVevgGGHarAfbaR61xMFkAIXn2rnxKsA/6mHvKaHjHxArk6G68upAMJP6rl/FZKm8mw5PUvyYgXIwWPEggeSK93piDwzshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndm3Lq/8sM87wI/yqKNuk0kuHQObBlpWvEmjZxRS8Vk=;
 b=XgH0QpWAcv/flqJPgmdg2KCZbIMhLjD0lX+jiWtM1m0cozyzyzGusazNKm/KNeJTofbgXVqhzs2aiaIAFuFhgp1rXwsoSNzwDsnu+El0guyeiCwSBMBqSFJFX+LfXAVjxzXgSjykl5tsaUvqzMa564+Q6GtsZBKlR9y+5FNlzLI0mMyQmQdM7pF8FAhbWrlgN5ckU2iE5qUunnrVuiw9Td79kVxV1JBvrb6sRM67Qf/uV5SnE34afIm3QNK6pnrXmGVKRmdCn2Bjwjxg3R0VwSLgeoKdk4XgBb174awZk6OKDY3nwu+UPeMFabtRtFJdH1y3tw2112zJ+JUOAZiFsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 22:50:35 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 22:50:34 +0000
Message-ID: <2920b373-38ae-4599-a0bb-ff177a0de937@nvidia.com>
Date: Sun, 8 Sep 2024 01:50:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] IB/iser: Remove unused declaration in heder file
To: Zhang Zekun <zhangzekun11@huawei.com>, sagi@grimberg.me, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org,
 dennis.dalessandro@cornelisnetworks.com
Cc: chenjun102@huawei.com
References: <20240907083822.100942-1-zhangzekun11@huawei.com>
 <20240907083822.100942-2-zhangzekun11@huawei.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240907083822.100942-2-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e06136-98cf-4333-278a-08dccf8f7bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXZPdFhCa1ZjcGhGZW1Wdmdnby9pdm9hUHJhRlFIUmg2RFBDa1NsTkNyWlZQ?=
 =?utf-8?B?b0Q4UEN6dWdoOFNhbUlIZWNoeDlub2cvWHROR21yTGtXWlN2WmYzUjdLVkpl?=
 =?utf-8?B?c1FBSFVsL1pPaTd1RHFWc2JENGMxZHJYanFTOFUxdnI1ckgwcFdhamRLS0M0?=
 =?utf-8?B?OUo5TVAwemxreXNVRmVUM1gyWGpwZzFVUXo2OWw2M0tIQTRIaytTY0N2T2dX?=
 =?utf-8?B?YTdqdzlZRWhtazU2dFpMODYzeWpSamxpOFJ5amhwVkxOMGl0MGwvckp0VzR4?=
 =?utf-8?B?dlJGMEM3aGdTdUtkd1hDVDBCRm05TXMrVHlwVmcwY0lXdk50SjdiOW1uTEYr?=
 =?utf-8?B?eDczUVIwNkdYcmlmLyt3UktpVlJOdjRnNWk1ZVNwQ3RJYWROakpCM2RnMldS?=
 =?utf-8?B?SVV5Q1llaEZvSVQ4aVpLWnNubmNEMlhsT1p6aU1jVnRGa3RwczVrZGtjR09z?=
 =?utf-8?B?MzJKcnZkZkt2M1lIUGRaa1NoeW13WldRcVpsQTdyU0oxK1N5Ym03bUxXR3ZC?=
 =?utf-8?B?QzBqVXNMWWFCeHdwcEcwb1I5bTRGd1ROUjZNR2gxbHhGTlRYeXpVOHFNVEJT?=
 =?utf-8?B?eVB0ckRHbkYwTC9MT0oraHBFTy82S2tib0crRzd4N3RHcW1IR1FsSlNTSy83?=
 =?utf-8?B?a1FLUzV5OTBieTVGYnZiQnlqQzg2c1gvalltYThYOE0wQTVZcEVoRHdQYVRo?=
 =?utf-8?B?OS9mOEJwRXhrNkIvSTdQS0oydDlIQzNGNmZCVkpucHREdVhMcVBrazVTS1VY?=
 =?utf-8?B?U1RrdkxSWVhWZU0zMUQ3aTVRQ3lsRzVQbEJGdXp1OWR3ODVNSnN4M21LNVRj?=
 =?utf-8?B?dC9IVjBGTkhCY2Fxa3JNQ1hvL043ZXcxYW83VTFUL09mSWRiUVZRSUU3aVJ3?=
 =?utf-8?B?Uy9rOU44VU5qaFRJdG9nQWZhWlNhNnJqNVpYSUd2VXk4WVE4ZkE0OTJ4L3Fw?=
 =?utf-8?B?NVNHMjlpTkZOOGVJRml5Tk1wV055Q2tLTWc2dkxiKzdhVk1DWlpUR0NVZDYv?=
 =?utf-8?B?My9Rakd2NmhtNUkwVlV3NjFJc0lNaVlDWEZSODM0aFM5elRHdGpWWkhGTGt6?=
 =?utf-8?B?a1o4NzNuMWU5bzJvNWZKRU5qZGRxcDlPVkd3ZTVPcHNWWVBBSnVhS21Sc2tq?=
 =?utf-8?B?OUJsUmNnS3NDaUdKS2FnamFpdWl2MzhoOW51OWFDUjkvMERoUzM5YjdwRkpD?=
 =?utf-8?B?TFpsQmxNd2piTTdJVk1UUkhJQW4rcVJqNThKR0VodXpQeW40UzRmY2g5bjM2?=
 =?utf-8?B?UlU4U3djdSszN3RXTC9vQm5HOWxhYkRQdkhwcUt5S1lLeStCZkcxU2lkVEJI?=
 =?utf-8?B?M0tCRTQrcnBiM0ZHMXBYRDhEQitSMjJMUi9NSEplN05JOFlhN0sxaWtRa3NH?=
 =?utf-8?B?Y0ZXZDdld1Q3KzdoTjNWMjVBUnpIWTBuKzZ1QW1Za1QzMGo1Tjhhelc1UTNx?=
 =?utf-8?B?dE03ZGtWU0U2WVI4aDF4dGpaK0lSaWdxZ3BxYVphNDlYZzZsQmdOVGpnWWFu?=
 =?utf-8?B?cVMvbUZoUHBzWlZhZjdVM0FjSGZ1bnF5bG1NamZ2bGJsMjNZTXdhV3Q1Umc3?=
 =?utf-8?B?cW1ldUZudFRnejNORkIvTmdrWU10SWsyb2JNcXZ5aW1FUkZZcTNrQU56MWFH?=
 =?utf-8?B?Qzg2emtPMHhqc3VhbGdQYlhFV1hFQjFwd0E2Skl3RTdjbjZVUlFiemJsMXIw?=
 =?utf-8?B?ZmdjYlBOdHNtYUVWYXhpZ3Z4SXJNVmxrcHRER2JSRDQ2d3FXQ08wdGRQQk1N?=
 =?utf-8?B?dHJiMHVMZTJ0eGZyUWU5d3JTMHZhWmp2Q2VUYy9wOHRjKzdsS3U3cXd0TTk5?=
 =?utf-8?B?SmpNb3VQYkFtTCtVcG8rZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGM3Y1JXZkMwNFNYc2VmUXlTTTlXUGlTbnE0c1VCMFdWN0EwU2cyZDU5Zkhv?=
 =?utf-8?B?Wk0zZ0RIeHNVN2dYQmc4OE1UVTRMdDJXSFEvVkR4UlR3UVFDdGs0UXlFajU2?=
 =?utf-8?B?MVlhUXFzaThVOWJ4b2RsTEFmSVk1UUxFYTdOVmpSVXNlNGl2ZFViMCt1cDJq?=
 =?utf-8?B?Y0llNDR3QWRPeUlkVlRORGdMMk9XZ2VveFJHUVc2VHhBdkROOFN0UmZnSHBE?=
 =?utf-8?B?VWlKQjlzUHI1OElIR0xXdVEyNEFYZjFDSTlISUhhMnovTk9jT3Q3MWIyQTBx?=
 =?utf-8?B?SnZrNmowSW84c3NuK1dpZkJyUUZYZUZIU3BkTStGWEl5MWZLUHNhbHRWbzhl?=
 =?utf-8?B?QjVBMlRCdTZVUXNaNVFCb1BCZkRrYXlJT0ZaTXAvSTVucDlMR3JxMWUwSm1x?=
 =?utf-8?B?dG5yWWo5TVM1RE9saTBXL29HcUZHNHU3VWZ2OXFZbUE4ZEM0OWxPQTgzQlhW?=
 =?utf-8?B?cUo0Slk1bDYrd1Fra3doYnhxQ3lGUkc4cU82elh6S08yZEFtSHBnRm9VU1Ew?=
 =?utf-8?B?V0p1eWZJRmRhTjg1ZWxxYVZrblF0N2M1RCs1WXMyZUVRMmNMV2d6c1dnYm9O?=
 =?utf-8?B?QVZteUEyWEJhSGdVT2pjd0FRSkVuRGNIS04rdXVoRVZQdHFmSmZxNVlieWZy?=
 =?utf-8?B?cHhsMkdEVnRyYUY1cEcwdjd3aHlwanhPcVh1S0lXblZDM3BTMTdRQzZRNEJ6?=
 =?utf-8?B?ZHNzQitWRFRXb3ExTzhDZGdBc3FOdnlJNFNjTHE5ZVR1R1RqV2RaTDU0dE5u?=
 =?utf-8?B?WnJIZTBCUGxlNEJtb2d3Q1ExL09QcGJVU1FHWnd2blhiMllZWGR0NVhmYUE0?=
 =?utf-8?B?SEZ1dUI1ZXIxQzVuMElvRGY5R1VId25xTnJRWnRqelNMYlpsd1gvTlk5RWJu?=
 =?utf-8?B?bHhFYkRGZ1hydG9CMk5PeTZkN2M2RWtjZEluNGZ0OGVzMUdEV25BaTQ4WkxQ?=
 =?utf-8?B?VWtPdGI1MHZRSEpLT2hNbS9QRzRUT21JRG85aGZlNUNrZXZiSXZlWWNQOVRz?=
 =?utf-8?B?aTRqNm1TeU5iN0tvSTlFRCtIclB1VFNtdFV0ZTVqeTZHNURhVlpIcEp2TkU0?=
 =?utf-8?B?aERqZDMxd3liQ3RHZ21MSFNzU2JmRU9RNkk1UkFQeEE1WllxQ1BFcTZRbXJZ?=
 =?utf-8?B?UVhvMm1NNzhPa0ZTYUl0VlZiTXIyeFVsTEViNTZaWDUzeW9jd0V6SmZMeUFx?=
 =?utf-8?B?am13VVRteUtuN3pvZER0azJkYVllNlJ5TndvMmlLR1FmUkZjdVkyZ2hxK05O?=
 =?utf-8?B?RXhGRmhtM3Y3WW5CUWYyMlE4UFVWY3ZtazFxNlBQR3V0RmJyT25LM2lvWDlM?=
 =?utf-8?B?RFVFUnUvZXhGa2lLVmFLZTVya3Z1NkZqNzIyS2ZYR0FyQ09BaVMvUFBRNzBZ?=
 =?utf-8?B?ZmtETU1qd2htSDg3NEJjN3VpQVhmUVRxTWJQS1Z0U0t6dFpHWFdNME1FMy94?=
 =?utf-8?B?YzZvMjcrM2hWaytWTTRrd3doa05DSDZtWE01V09NazViUVBkcFZac29EcG15?=
 =?utf-8?B?VEFadHNqS1F2ZXJhNlIyZVg0UUlrVXkrbGRRaS9CQjkxUVdyTW1KMW4vbmtm?=
 =?utf-8?B?cXVmZ09PTHh6OWpQWFJKSFlHM1Vma3ZPQVNqMnFUaWoxeFZqb0FTbkgvZXdJ?=
 =?utf-8?B?TkNlc2VIWW9oVnhXNzcrUUM5VU8weFREQVI3a0JRQy93bDJJNHo2RzhzQVZZ?=
 =?utf-8?B?SUx3SDFJdVlzWUx3Y2xocmlhZzNIaVpMOEpnbGl1M1RDcEVta0dKMHJ2a3Fl?=
 =?utf-8?B?NjdRR3RJOGdlRTF4d05DaGpSYVZ5SFR5NmhCRkhXMnljT1VCbWJNWlVDM21a?=
 =?utf-8?B?emNWaFNQWnhHN3o3ZDZ2WGZFWU5YbkRodTFaUStWcGsvWThOdWNwcG5BTTV2?=
 =?utf-8?B?Q3ZqUEVSaUN1aGlNWUdXTFYrQkpTYVlaZERRNmY3N1NyQzYzb0VJVzBDVW9t?=
 =?utf-8?B?aUZZclBYbFpDbDRqc1oycERHZ0ptbGJZYzJQRmZ4aW5EQnZQZWFmTDNoakdY?=
 =?utf-8?B?enpFdGtVNXV0ZUJDSVFob1BTYlFlZ3E2SkZqM1d0eWMxMzJIV2hnRlE2SWx6?=
 =?utf-8?B?RHJwZkxIcllnblFTRU9QclJpQXhPVFBpVkQrcVdFM2FCTCtJYlkrVlNHU2xl?=
 =?utf-8?Q?CTBcNKcpA0t3+tvuXoPlvaxH8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e06136-98cf-4333-278a-08dccf8f7bf8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 22:50:34.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHvyHNQl8S6v13wfGfpz1kdvrN/ljpdy91lyHC30R/dnJMW5HAmE9LD3zVyeJ9QCWrLYKPQ6mQN1eP3EbHTnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917


On 07/09/2024 11:38, Zhang Zekun wrote:
> The definition of iser_finalize_rdma_unaligned_sg() has been removed
> since commit dd0107a08996 ("IB/iser: set block queue_virt_boundary").
> Let's remove the unused declaration in header file.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> index 68429a5f796d..1d7ac24c4c00 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -507,10 +507,6 @@ void iser_task_rdma_finalize(struct iscsi_iser_task *task);
>   
>   void iser_free_rx_descriptors(struct iser_conn *iser_conn);
>   
> -void iser_finalize_rdma_unaligned_sg(struct iscsi_iser_task *iser_task,
> -				     struct iser_data_buf *mem,
> -				     enum iser_data_dir cmd_dir);
> -
>   int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>   			 enum iser_data_dir dir,
>   			 bool all_imm);

Looks good,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>


