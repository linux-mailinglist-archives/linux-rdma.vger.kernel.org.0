Return-Path: <linux-rdma+bounces-7785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50295A3792E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 01:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E2B188E58B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AA7E1;
	Mon, 17 Feb 2025 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmYi+Jd+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFEDDAD;
	Mon, 17 Feb 2025 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752091; cv=fail; b=WFmAFz/59OZZcGZmRkGPSgnV/EmYAepER9d/gHFQvcsc7+ZZSwhD7BXOkJtHx0bsUlZ9LadVdevOxG3hNkGfUHTK9El4SSswXstWVJfLYqUKr3p+/X1TxOswpRfaqtYKdbW1hdZV+vFLHDonAg8MlHIomxef2kwS4h8bvyS0Phs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752091; c=relaxed/simple;
	bh=20fBs55NW3kycLGJn5k0Rhs8gEagCL5b3sGhFYga0ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bu+FPE22LCIIdU/6etOVuUq6VXdRTQeTtbX+v2iHR6IkLQIYlnpfBMSMrSG3YYOUBycXdit+niJteFJDAzzWsHlabQZg0YPjHLch4g51OSGiDeVvdxZ5PQiCyvU3vF0ERJqmCNGQbAYkbWJznxunXUmrTdz9YUamUXq2lPjMpfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmYi+Jd+; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZay6C6wTY92//a0jOLY1yskJxLdtERiy35d6WwaqRoKnXjOXoDyRSrUZTtLJtfuc849LldNTgrJMiSbgDj6YfDdhiwUywNQ5ty6rlQUBehcs+m9uv42KlJrRNaEgUs9xrVnW9ZXaQq/ZzG52EY2gdEKObbFXyrdiSCs70/IVecD5zD4Ws7PDpkitYaMmiqx7FsU5tQdHmeX+ZbvFRZ0jsz9PLJNJxk+2zAfEA9qVf2pxl/2zJeiL5ftMHcXhRSQHjzQhWd9r1nu+f+SJfPyFhkWOkfFA5UnNvmBRZTe88zwEQ6+3ntKflQd/rBfy4yOeFvWplin+Dt0ImFIUTcy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeOqopaOf9g+BmvFlaXVFTkk5rnlbECDIAdT3tV3hLY=;
 b=KbnqSuu7CUtjwiQyHWv16cZOVh09uvQYtQbGKfLSe2GbuCRnpr/hyav4JD27qhZFFOf3aXzs5a9xma92s3BkJ9NEyCwZ1B3W3EPAAPojojIP2e3jj9EG6qBPBDQuhe5iVCw6i4y5750/mG2qJDZbbNugPMj9Uaa1gGnouSJL66Ma7dde0MVm7b5LzhSCttqEXeb7tu395fvrOql2jJdKzbIR0K7ZCxxYSdlPmCqAXof+9c8kjFrw5+rjefdlB4h//5jqy98h0DV6CRkHIrfNS7X+rRw77wXaLKvHrRnfoFGiVd+sWurHq4EbQWJhB088MBRykO/m1LQzlv+k0aClzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeOqopaOf9g+BmvFlaXVFTkk5rnlbECDIAdT3tV3hLY=;
 b=DmYi+Jd+THgavnMd+nEr5zeSrKcGXd/2zpaGffkN3ffqdX9EHUYiUwkm6q5s9PEFNNyzzBVZT1zvIvlY6iqyrB71ot4mB9yIcAlWMybdMiet0Be2lVXUBaD1EU2eT3MmiXbgjFSPYCp9c0PgEO+2308sVj6KJAviyQgrFsVSVTm3iB1q7t9D4AaJumh+oTvBnwtEuYXruc3jiJYbNEoeqLUjY7RHpqrCcEJ5biAjAQ/mX32bD4uytSDeZFlAJ74DI/tX5wNqpby+mekIB7CUmZHrY4BOHOampfNvnzuJxLn/whmU2A3SdAullWVj1aoEb+s5JBIAgNiGEYzmgGsSRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 00:28:06 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 00:28:05 +0000
Message-ID: <e123e1c9-21d1-4136-a26a-931135c477d3@nvidia.com>
Date: Mon, 17 Feb 2025 02:27:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] infiniband: iscsi_iser: fix typos in comments
To: Imanol <imvalient@protonmail.com>, shuah@kernel.org, sagi@grimberg.me,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216235602.177904-1-imvalient@protonmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250216235602.177904-1-imvalient@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a50b4d-37b6-4abe-b659-08dd4ee9f236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djB4RHNLeUJDSGM1WVJ4ZmY0SGMzdGFlaDI3TklZWHNSZFhBS1Z4YTFDeDgx?=
 =?utf-8?B?V2lFdys1bWoyM2IxeHNWV3Z2MkptRzN1NUJYYkYvWXdSWEIrOG5BN2xJYktx?=
 =?utf-8?B?ZUVDUTU0empWUDkwcU9FWmJFSXV2cXdYL3UydnZIeU4ySXhIaWV5UCtnck5q?=
 =?utf-8?B?SWRjRXB1d05sd0ZkSjd5ZC9BVXlIREVsTStCVUhBZDB6VzZ3V09GM2NwelFu?=
 =?utf-8?B?OTRHYno1c2NIZE9nOTFCS01sc0xqOFdIa1JvTWdyakVPSnBML1NHS2lRYUt5?=
 =?utf-8?B?Uk5aa1hZcDhyMGR4cU1sN0xXSm9iZ0V3a2szYk1tQ1pNT2lPVDllb05BWGd1?=
 =?utf-8?B?M3NjWFlpS0JRK1hvY0FzT1FLY2swY1Q4cGtmWTZ2NnFRNVNOTUhIcFl1bkRB?=
 =?utf-8?B?eStGN2NBNy9pbkRlTU9zdThaVi9UWTBScjRqZVF0NEF3VVRYSFg0MHkxcnlK?=
 =?utf-8?B?THZPWkdaZmpCb3hDMUZRZ2RDa2htNU1MQVduak8ybFhVNmxVU1BuMDVmWXVu?=
 =?utf-8?B?R3hyaE5BdzdycVBNRVNLcm5jd3JVSHdiNlptdjltNGFaS1NBdGVuaHI0bVh2?=
 =?utf-8?B?NjhVcUFKSDE4RHNZWUVraDFIbXNOTE9GYUhYMTBjRXN4anlpMjBhVzdMSXUy?=
 =?utf-8?B?b0VYMncrMTVjVVFoVTIwUWxTYTd4OC9mckZ6aVhMY3Z1K08vMW1qRlBXTkVs?=
 =?utf-8?B?VW1BMHlRZzhOZGFINGY3bzlYTllDWGNDM3RsenJyRXYrYnkrMzRzRDhTdVVS?=
 =?utf-8?B?cDMxallWblZjenRaSHhOR3JETDJ1cDVjS3NaNFhROUNVSG1rUEJwVHgwaGdl?=
 =?utf-8?B?V0ZFMmtZbmVxaHYyUVVVWWh1MW1NRTV3RHVZT1UzL3JvMmxFNzhscVdBRmRw?=
 =?utf-8?B?eTdGNjMzU3JRWGdjMjZGRUhFMEJBNkpVTUdyTGFwaCtHMmFTSXRMb0dlajB0?=
 =?utf-8?B?N1ZXTnZubVRTa3F5bUFNSmVMZ0lPdGRtMUV6c1VJYTh1WTVzWGVrdkorVEgv?=
 =?utf-8?B?Wk44TDBnblp2VTdoQlp1UXRBQVB2aXRCdG9RMWhFYzhEdjJMQnRJZWFCTy9L?=
 =?utf-8?B?TFJLUi9wVXBuUG5BL1JIN1VpcGJoYmJHU2x3NUdZZTVSYnJLOEpzZlpJWnJT?=
 =?utf-8?B?d3h5b3Y2QzhvL1pkUTlRRzFQMUwwT3gzZGZjUWEvMldReDRhSS8xa3UvVlNY?=
 =?utf-8?B?d1p1NXR1dDFmNHEyQThiOHk4L2IrOXJSNXdWYVVzNnNhRFhzL3dFbCtKcTZ3?=
 =?utf-8?B?OTVVYnJsL2FVVW95cXJUZ0c0aXk5RythYU93NndMbDRYclJnVC9RTldralRo?=
 =?utf-8?B?V3l3RVphWUJySmxaaUJrYzZ4emEwcjlKTFpzbXB0R0ZuWGhFWVhWbDNaRUdQ?=
 =?utf-8?B?aSs0bXdDTEpjQSt6bzQ3cjJDck1sMmdCSUcwZ2VmYW5NQXJoWEVscENibEJS?=
 =?utf-8?B?WFRYMFFlUFpTanFxTWhUaXZNb3NSeFNKSjNkRk5vY0VRZGQ1c1NFZzUxTlc2?=
 =?utf-8?B?YlpxMy9wb0pxaXVTSS9CTWk0ODkweGppRW5XVGlkcExGc2V2TkpneU52cktL?=
 =?utf-8?B?UjlCbUhVdFlVVWVXK2ZXUVJQRW15OHlzWmJkNW0vNkJnYW1qMThOaEtMTWM1?=
 =?utf-8?B?YlY2NE12TVZDYTliWHgyUUNTQktWRE5qQXRCTHc5TlVySjUySE5tQzUrVVVI?=
 =?utf-8?B?NXFlYlVXbnhwbFpaK1FCZEJ2VWgxVmgza1R6TXRDRHF6Ujg3dVRtbXh3SlJC?=
 =?utf-8?B?MFZuZEJab2htdGNBcVZUa3YvOWFRcVNhdTVHOFU1VEJpUmtYbUt6N0k3WjRs?=
 =?utf-8?B?TWVhZEkzaGdBR0tGeWxCQmpudXhTblFzMWtXQmZrZWtCNStQOTZpN2x6L1pp?=
 =?utf-8?Q?azz1beNS2AIsx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWQ1OENyYW95Wk9FZlN1Qk1XdXhmVHpHVXBMR1ZjZUdrQytMb2dJZTBCTHRx?=
 =?utf-8?B?bWJnbkRDc1RwSXpGc0ZGVWkvQXcra3ZscjBUK0ZiUEZxb0xnSG9leXlpT3cr?=
 =?utf-8?B?OXU5aGxmeitoZkVHenFvejhTL0g0YTBnWDVsQjFFNFhtcnFQM1VlTTNFMXpO?=
 =?utf-8?B?WlZQZHBLRHB5V041WXhNaU9zcDNEcmIxRVFNZkJkc0ZMTDY5aFlyMjJOUktp?=
 =?utf-8?B?S3VpcmJxUVVyZkwwTm83elA1ZWlKbUxCZWp5aS9TQi8zcVFqcEx1ekxjdXFw?=
 =?utf-8?B?cExLL1lUTDNCbzlsWEQ5a0NLLzBZTHo5Yk1IU05kVjhYSHBocjJZWUV5WHlr?=
 =?utf-8?B?RXh1V1pscTRpdmhkaFE0ZVoxVzVWMzN2S2RkaVp4RXlLY0hhNC9WZ1VGY1Y4?=
 =?utf-8?B?Z3p1MWh5VkMvVXJ3UmtQQk4yZDdWeUJoUUlNYkZMTkQ3Y1pyWlEvdjRJV2tU?=
 =?utf-8?B?ZmN2cG12Zjc4R1RMSEhHK1hNRXZLeWpyL3lkUTVqNnFaN2FKbHBUdm1MR09J?=
 =?utf-8?B?eDkyKzVyeHhMRGFkd0xaMkNOY3ZGSEU2MklSZDgyM3AwTDdqUnNkR0tSOU9C?=
 =?utf-8?B?eUhTRWsrdFMwNWVMZzFUcGszbXFNQmI0OUZLOFQ0N2JScVJRdUVHeElWaGhp?=
 =?utf-8?B?NjZpa0M0dXBVdDRpdkRTdFRQVzZOZ0Frbnovc3hIcXRYMFQrdjFoRmZGdGdU?=
 =?utf-8?B?TjVIRUdkb3M4ZkdIa3JObWhycFMrNlJ0ZWR4NTJIZ25qd2k2b1pNd2I3OWdv?=
 =?utf-8?B?T0FrakoxYWhqY0hySWN0aDVtMkxtdXc3VStVWlJ0bW82VkhEbXVIUDQ0bVdq?=
 =?utf-8?B?NG95V3E5V0xGODYxUGU1c1dQOWRFYis2bm9Vc1U2bzVKNnVVUFRMVXA0ZDFh?=
 =?utf-8?B?Rk1iN1RONWF5dXVxZjdhMWM2OVAwMmNmVytVbGdCUUhQMzRRMlNNZURoNENi?=
 =?utf-8?B?NmNVYnI1eWNrcWN0OEdnZHg5dE85eGhvbXB2L2liQlpQeFhxeXdOT2laYUpR?=
 =?utf-8?B?VjhWNmxTOERmL1d6RmxKZUxacFBPdGV4K1hKNFlWS3lkUEZLR3A0UEV1bVYv?=
 =?utf-8?B?OEFVUm1hT2ppS0d5VUVGWGYyck9EZ3pKQ1lzUUNMN1hTdVFWTHhKcFZSQnRw?=
 =?utf-8?B?YzdBL3BYejhvb1NQK2pabHlXM3M4TGRZcEpVYUhZRzNzbldUU0ZQV3hxVkRZ?=
 =?utf-8?B?enJuM0xqZmFKRFlraUdrVjlXWDVDSFBoaUJUeHNLR3gyT2lJTWhPQm5LVDhi?=
 =?utf-8?B?OFM1VGNQYUxRTVNFVm8wdXdhTllTTzRzWUZ0K0U2aFZmMHE4dG9ON0I4amdj?=
 =?utf-8?B?dldudi8wb0tYMlVZNGFnNlhkeFF2ZXEyTXhCa1l4SnFmczFlZysyZFdadFRp?=
 =?utf-8?B?NEJCaFVBNy9EM1RDVXh0bmZBRVBRUVV6ak9qQXJmV2tEZ3lMbGJYTk9vN0FX?=
 =?utf-8?B?MTNYT0MrZDYzbFB4TEN4aTBEZURtM21ySTBtRkNWbHlDd1VqYVJQV3ZQNTVL?=
 =?utf-8?B?ZW9aVmdPWFI0bGhyS3dsTVorb3NoVThlbHoxbnkwT2NXSGZJeU9sQ3Q3S3BK?=
 =?utf-8?B?Ryt6aGNhWTM4cVViT0Iza3lOL1A4MHNnOGdFbEV2NUVCUThWZGJsSW5UWmtG?=
 =?utf-8?B?S2pwMktCVEtMLy93MVhyRFhkNmoyYlRrRGgvV2hHUEJuR3NGSlViakVjTWpT?=
 =?utf-8?B?L01OcTRYS0NQeGphZFFYQVFxVWdPUGsyRWEvRkR0WEpZdlhWN1JsNWUvT2NW?=
 =?utf-8?B?em8xK0tpY3o1Ly9Qc2tFSmh1Mmw2dlV5ZldaY3JCRTZLbnYrV2RodlI2Q2p0?=
 =?utf-8?B?am1kOUc1NHBEaXB0RmFtOFl5UkZyNzZZK3FBMnhGUXBLd0ZRVXVFQTI1V201?=
 =?utf-8?B?NmIzdklXMGNWMXhFeFI3cWcrQmx1Z3h5V1A1bk1HdktXczZJWFVtckQrWG1p?=
 =?utf-8?B?QlJMU3pzUlVkanZaTWZ5a3VsSkY0NjUyQkxxOVFUSHFoRTcwdjV4V2R5bDJZ?=
 =?utf-8?B?OFhzakpadjdnZ1hiU24vMGdGa2ZxTTdJcjFMRW1iaFh6WEFISlhEZFVhWTFo?=
 =?utf-8?B?R2xkcFB4R0xjeWdjaFlQbUNhRjNnZ1VNeGdsNWJnNjdya3JoVWVYV0d2RGRS?=
 =?utf-8?Q?H7BYniMVBeCJQte1Udkxs2AGL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a50b4d-37b6-4abe-b659-08dd4ee9f236
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 00:28:05.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig4K7sECMtZfVwlcqG0CykUPoUQ2EBZtahXxBF9aO9M7ILrVnwyZj+aXPD4UxCxdQAfhYA0d/nKDVoAtv46mjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443


On 17/02/2025 1:56, Imanol wrote:
> Fixes multiple occurrences of the misspelled word "occured" in the comments
> of `iscsi_iser.c`, replacing them with the correct spelling "occurred".
>
> This improves readability without affecting functionality.
>
> Signed-off-by: Imanol <imvalient@protonmail.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index bb9aaff92ca3..a5be6f1ba12b 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -393,10 +393,10 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
>    * @task:     iscsi task
>    * @sector:   error sector if exsists (output)
>    *
> - * Return: zero if no data-integrity errors have occured
> - *         0x1: data-integrity error occured in the guard-block
> - *         0x2: data-integrity error occured in the reference tag
> - *         0x3: data-integrity error occured in the application tag
> + * Return: zero if no data-integrity errors have occurred
> + *         0x1: data-integrity error occurred in the guard-block
> + *         0x2: data-integrity error occurred in the reference tag
> + *         0x3: data-integrity error occurred in the application tag
>    *
>    *         In addition the error sector is marked.
>    */

We usually use: "IB/iser:" prefix in the commit msg subject.

Can you please replace "infiniband: iscsi_iser: fix typos in comments" 
with "IB/iser: fix typos in iscsi_iser.c comments" ?

Other than that, looks good.

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>


