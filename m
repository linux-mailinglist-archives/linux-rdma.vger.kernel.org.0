Return-Path: <linux-rdma+bounces-3645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA3927688
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C351F23623
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633651ACE88;
	Thu,  4 Jul 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTmVw++i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095141AE861
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097769; cv=fail; b=J1iItCKSw9n91ci7N98EQcXiv2Q4B811j2YrOXU/4HhiOb2N/wplQt3EAmA7l3dGIa0QKqeoteZCVV9j7MX4oWED7jZoTHSz2U0kq6P45ytqayM/9hGMeXnkc+AQGyHAcPpKjyxaZL1vjKGYofGtwvKV3aj1b0J6jHDo8a6Ea94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097769; c=relaxed/simple;
	bh=Ckk8dBqrM1BrMBaun0abbBc0L/9k7maPNRcBxCIhudw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N4v4yCLVPKdFuGY7R41/mQiBHJ6LAuf3Nm33+ZfEAFS7oCOExOTjUeYJMVhVK7JKP1eOKPorffGgvdxsOPhqdfZM6YtzETYOyznnFlVLRL0/78CfgXUpPTj3Xt8dJrWeXN/MC/8f7tUMPhLqnAuFDhWdUssw4pCQ8En6oT1g8kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTmVw++i; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+8oGKNb6fWIiHLWfXNDdp2MGUEWL+aHxacE9mnbOW6hrtYFHIZlZCr894m1sa3TEWHjVR2zSl2cnxiBySo3+07hBaHimDEuulHZf4bxNVSXBpZu6QGwf5SN8ChsL9351n0OthIsKhcriKtJFOaAfsZRa1LQdOpArkbkt2wxQ9cqHtjngag9I1BAaKYGKJCczqxqMYd818Ukj2ZUBO76T4okdfALl8w48MvnKFXZU6eNMDa+B2VJ5eWn2MTol1jAUnQZ0HpWLVS/yKY2lF7I4Dl/HpDSx1vkwiax96F0t4LaH3+5BMtwZ9gnaa8UAtJSOZXqhzhRvIokE8fih52uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9heMffLfgybXBRBr/mgzaFncA8ydO54E3pJMyhuvn/o=;
 b=GBaWKB6HumaDSBfMjieL4T37iPx4LbppoO7He0AzRN1r0v7bjb7apOCUUsBdxSDiHcrHvtlpwirv9446cjfYv2sEZg3yj3wkptYvNmKPf1x8FHtZmQ2aqLywFKI56HA3t04GVITut233O/CYkoaf4dgyfcgkPe4Utf8GVG/OEHtFxDTs+xRy8E/OMzTGxJ1cDo6ikYM3yz8fwAxVuwV7qiM4LUNjBVJKh2bVx9WHxw4QySTbRGcEp62i+yOy+RP4mHrFF972Niquq9GuKVAMgHgQUJ8PdkrMMhhUJTQquer6BHGZ58ysVw/Zi5cA+qL6Q722Ykrsi7JbGMTpKTBXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9heMffLfgybXBRBr/mgzaFncA8ydO54E3pJMyhuvn/o=;
 b=MTmVw++iEuyPqniXOKTgP2bV1qyqJJVVHJquDPenrLA6HBoZJ1eQAeq3kFkXd6zrayDUVyruAwxrfgEoFj2Gu4dXHl58zTomIniJTrONubrqLwJOxnrvfVvldyKVB5JeZX4uOzT9xKPk+zLNcUVcQbSvcoVOUNAhtyMIiM8mD4HHpO5zUSWNUqaiJpRaE2useV4RFRY3Nb1mJVhfLJe9XbVHEYIn4eVeomJW/TIsZXAiHoWjtd4xuScvb4TryhM5tnDMRZFVy4xEvteTQR87lpUlDp6IYhCD0zzP/xvWVptOk3dPDzmapIkgbfwZ9MWRJYrRI6scEZ5CY6UMuRIwCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 12:55:59 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::60e0:9389:7c55:2a04]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::60e0:9389:7c55:2a04%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 12:55:59 +0000
Message-ID: <2e8d7580-18bc-4d85-8600-10b6be4d02bc@nvidia.com>
Date: Thu, 4 Jul 2024 20:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND iproute2-next 0/2] Supports to add/delete IB devices
 with type SMI
To: dsahern@gmail.com, leonro@nvidia.com
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20240704062901.1906597-1-markzhang@nvidia.com>
Content-Language: en-US
From: Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20240704062901.1906597-1-markzhang@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e4f687-4d19-4036-43e5-08dc9c28a6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZKNWRGYUhOaWdFWUtiTVFTcVp4TlkrVHduRUFsWjhQckpSWHZPOGtxcjFi?=
 =?utf-8?B?U3FDbW1tVGlrcTU3dlVQWHl2RnNoSTVHUG5XbzEzbnl0ZEVucUNFN2gwRk5D?=
 =?utf-8?B?RUJRQktvYXZmT2hxem1GSUZMN2txandWWDhINzNUS2ZxYkU1cE5tTG8raCts?=
 =?utf-8?B?NEl2aDVraGI0Q096eWZFbndQNWZPK1BFRFFGSzJPTjBqOHFRQmFiSTVSRk40?=
 =?utf-8?B?SHNzZWJ3NURlRzliMlB1cjV2VjVQbW95bUhKZThjbmxLZUxlZVY0eG94M0JE?=
 =?utf-8?B?REVBN3RiQjZHVjU2MFZSNEFIY2FBWXZRMFdXYnNIQVRQZGZHa3I4aUtOK1pw?=
 =?utf-8?B?a2VYa1ZZVnB5SW5mTDVpbjd6WWY1ZnlHaHZGd3NUZjJIU283NzAzbmNXVG1F?=
 =?utf-8?B?KzhkczFneEZNcXNpREJ0ZVRvV0d0WEJLUWhUQU5RODh6cnM5NnFoUkk1Y3Iy?=
 =?utf-8?B?cmw4aThYZTZsdWFYWTVRRWE2eTJBTUVObXNHSVVwajBPY3I4cHBxczZTaS9O?=
 =?utf-8?B?T3pCLzFPZVByUkJ6TVcvaHlTOWNKZU5NSUpXNnMxMDNJRzIrSzZMeE1iQTBu?=
 =?utf-8?B?KzJRTFJ0Y1U5WWRmakxnWHVkVmlKaTdDQU02TGl3QTkyKy9YNkRKNzgxL041?=
 =?utf-8?B?SGhlQzNHbThiTGFBb1ZGRmZRUTRYWnNEakpaUFFrSElhK1U3aVA1OWJqV3hC?=
 =?utf-8?B?ZVZadUl3T1BTZUZGWkxzVlVjWGlIWW1RMEhBQkJZN01oYTBkOUZ6L0xGZ003?=
 =?utf-8?B?MjJ2Qlh5NjZFVzl6N2JLZHEwdWFsS1VhMlBTb09MR214ZjNYV0ZNVUNOb2FV?=
 =?utf-8?B?RnVCZ0NsYWRKNFJTY2Z0dTI0Z2pFVVRKZUJIdmFSSWFLWjI0c0c1YkpGc3I5?=
 =?utf-8?B?eFFwdm1JRXlQMWVhR3IzbDJPUjBZQXpKdktWazNaWllkL1l2UVREaTdYL2kr?=
 =?utf-8?B?bDdFZGllZzlkUnFaNjNFUUZMTVk5bVl2a2YzVXJoV3lnOGl3UlJpQ2VkQ0lp?=
 =?utf-8?B?UmlSbDc2dFJiWGpYOUo3TVJ1ODhXZ1FuVDR1a3RmUGlBR0d2R1pxZnNlU05G?=
 =?utf-8?B?OWNuRFV6VlJlTFRhajlUMHgvQWxvb3BsaFdRQkF2anNLN1ZMV3BEU0o1czBj?=
 =?utf-8?B?bEtOVUJUSU1QRkQ5YlMrWTk5aE40MHZMcktucy9mSmZ6MFcxL2hGckFGMTRT?=
 =?utf-8?B?NEY1dEpDVDZhdHBJdHEvT2lZa0FVMWRldHNvbFlqTE1FcEIweGhZS2szZlZp?=
 =?utf-8?B?OWVQWnoxL0dGNkM5WFE2di82bmVuWUpEREx2MlFtWDZMMGNMLzZKdktoaVYx?=
 =?utf-8?B?WGU0dWRBQTlrU1VwZitFQzc2dnZUaG9OT3pqQ1dtcXp5cXZpRzB4aUdXNmpM?=
 =?utf-8?B?Sy9ZaTdQWkdpV2lCS0NjdnBRVmFjS09GSGNSNSttQTJPT3RPVDk3UmVwMkJU?=
 =?utf-8?B?Zy9IWWtVTDI1ZlJPU1poZkpLZlJqUXMvU2ZhSVJqQnlrRWxYYUhxYnN3MlVV?=
 =?utf-8?B?Y2pQR0ZCY3VwZ1FQb1pLSnpxaUxORFdMWUVVbk4vSC83NUYyeWFzNTl1b2lI?=
 =?utf-8?B?N3ZhQW9lTHFQSlFUZDRKSUVsWDNhTklCdWhnQXEvSjg1WkpUVEdOR3hmVVcw?=
 =?utf-8?B?ZWtENkVxbHJGMlU3Mkl2Z2t3YmRNRS9pQU1JUTJCRlE4OVNVV1NKNHFIKzZB?=
 =?utf-8?B?b3ZkaXppS1oxdUFOM0RTamJHeGxwQmNZOVIrMGRDdnlHZkFyc2pEcGF3SW1P?=
 =?utf-8?B?azQ5WW1YTlBOdkpVR3lDYVg4cDNqVXZHK0JUbVUzbXI1czdoZnk2YWc2aThw?=
 =?utf-8?Q?UTHuGkH7gnUsHNwqmFQpXahgwx4VVhej4VWS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5vNFpYdkJ3eUtOdWRlaVV3bTRsY2o1UWVOdjhIOXBGUDNqVnUrMjdqa3lX?=
 =?utf-8?B?TUZMb2RjaVE1SzI2VG0wOWxDTU03elh3R1ArNjJpZWlGYXF6MDJZZDVQcXpX?=
 =?utf-8?B?T1dacnlVSkRIcHY0NHkybnorWCs1YkhKVkhyZVBkOGhZWCtZeWJBbkNiOWl0?=
 =?utf-8?B?aXFnSS9jVWkwaVFVQ1Qva1pCVnhHTjhiMSt5bGJxTXcvWFlmRkVWcWt6c01z?=
 =?utf-8?B?TmthaFhrd29aZlgyUm5ZWURMcG9Ma09sc05pemEvcXR4VXM3RVMwaXR5ZXZr?=
 =?utf-8?B?T05Ya3dBOU9vS0E3enpURHRZakYwVTZQRGJGYU1QSVM4NG1lYjFvREg4ZXhL?=
 =?utf-8?B?b2d3LzJ4eG96emlHeHh6QXdkZ29temVCbmYyaC9sNjFyN053eUVQWnprbU1M?=
 =?utf-8?B?MUVRaEpLemlRaHVzRTByNlZjUElTQ09SeW9pOXlvVjNEKzFGcXJMcmNQSXBZ?=
 =?utf-8?B?RGpXRkJxZWM0enp5WVE2cXd0RG9DUFpXb2VLRjBsUjFLUmpOY0RXYWFicUZp?=
 =?utf-8?B?TzgvZTA2THkvcFRmajZsUE1GUWZyVmdJTTZ3L2haL3FQczZNS1FSZFpSUlhL?=
 =?utf-8?B?cFpUWVdFRlUvMTRDNG02R3hnWjJpc0paa2ZQYmxjZXNUZkFhM2tQeU5zUE90?=
 =?utf-8?B?NnIzOUxzR3kvTFJ2S2NVWm9ZRzVlRjFITXRMbmFGRGw5UU1rV2xjdGZOUWdO?=
 =?utf-8?B?bnppclJIWkcrSTlyMzVSaitraCtoK1lscWhRSER2Umh5clpFcW13aEVlOFo2?=
 =?utf-8?B?RmRVWnZqRjBjNUJIMUxQN2FxQytUNVdmK2l3S2U0VXZXck5SckVFRGNzVkxP?=
 =?utf-8?B?c3prNFlwYjJ2Z1BzWmE5c1BORkFzN3phMU05OEJodkw1bGl6UnZNLzlnMkMy?=
 =?utf-8?B?NFQwYzdvb29zSmdLL2t6eHRrNzRIbWtDTStmNkF6bUlIOVdmelJYYjNwVjQr?=
 =?utf-8?B?SDNhWTVJdTBWNEhua2ZxcjBNN3M1OTNWUVRNK3R3ZDBnajgwZnVVUlQ4NEV4?=
 =?utf-8?B?REhmbUc2ODJYaWt2REhtWFVVRk9TRnlKZC9ZQm51Zkd6VGVFNDg4bmNPNmpn?=
 =?utf-8?B?eWJXclNCcDZnMnRPQVQzNDg3Qkw4d0tIM25UUWpPdUMreWxqSEh0dUlsck03?=
 =?utf-8?B?UkwwTWJjUVVueGdVY0xBNkpSZXJTemo4VlhpVlhHQTBjcEVtZGtMRzlyekpT?=
 =?utf-8?B?TkE0M3ZxQ3VvK2xtK1NKOEIxUEQ0OXFUV1JDaFlnTkllRlYyZDJmNXRuZ05t?=
 =?utf-8?B?eXExQzRCcXlHd2M5Ri9NNkIxSUE4UFd2OGphZjhSWmVmRlZ1aTdsWXd2VGg5?=
 =?utf-8?B?RzJ4bkdlL1lxWThITDRXc0RlelVML2ZmdHpNUDhlWHBneGhMVDBOU0NXRkdP?=
 =?utf-8?B?enZCSGpoZFlRTk5BS0d4S3Y4eTV2dEsyeldiR1VrY2tFdHdGUi9Vd2NoU2Vh?=
 =?utf-8?B?N2RXeit3bERNRExES3BSK3VxZjZKdlF3VEF2OE0yT2VzaDI5NUU1bjVmYWRD?=
 =?utf-8?B?bXI0T1k3bW0wVzJFMEpvR2g5RElQdk5NU3VHTkZJcmsvTkNGdFErclJuRG1K?=
 =?utf-8?B?L2NVNHlDcWZ4djduZWNlWFpzbXlLNE5adks3RWpBVXZQWHZLcmJydGh5aGxO?=
 =?utf-8?B?N0s2czFlbFNzd3Y0d205TFpWSEdyZ1ZIOUJUWDhiYnV0NzJBYnRHQXZpdWJ4?=
 =?utf-8?B?R0wyUUJHWmVSZ0o2ZmwrN01TanBJNFArVEdQRTIxM2c0Z3YvSGluR3REYUUv?=
 =?utf-8?B?Y3VOeDJyVXBRQnZJbTJoSTVoT1JwV0VIbit5QUJ3andkTnMxWVJKdHl0cXJw?=
 =?utf-8?B?bTM3QXMyaEdidFBoTGlVamkrUW9ZNnNYWVBWMEdSRXNzUWRvYnRucTQ3UHNl?=
 =?utf-8?B?YkU5bWZ1NFBoS3hEdm0rYlFoWHBJeGpLeE9yTFdFOWRRVTZHdlJmckh5aGxF?=
 =?utf-8?B?Y0NNSjJZdCtKQzFuKzdTam1Samg1Y2dQRVFiTDl3YkpValFBdGhCeThqWmdZ?=
 =?utf-8?B?L1NPR2grSmorQkZQNDB4NjUyZ3hmZ3FQdDdjWjlhdFlLRHUzUktHNk83Q0hO?=
 =?utf-8?B?SUZwM2tXV0RvdlVIdjFKRWlOSitoUXVoeGhxc2RFeFpYZ0tjVjZ5SkdqK0tO?=
 =?utf-8?Q?/kHcNWhLctqW5C25fwqcaHTIh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e4f687-4d19-4036-43e5-08dc9c28a6e5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 12:55:59.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jexKj0rej0pfuJ7sD/mzQlZlBYRjff52A/T9Zg12TFSRHFY6y4rkQp1E/cWTX2u9tRUysN1I2ZwutkFJbtbjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808


On 7/4/2024 2:28 PM, Mark Zhang wrote:
> This series supports to add/delete an IB device with type SMI. This is
> complimentary to the kernel patches that support to IB sub device
> and mlx5 implementation.
> 
> https://lore.kernel.org/all/cover.1718553901.git.leon@kernel.org/
> 
> Thanks
> 
> Mark Zhang (2):
>    rdma: update uapi header
>    rdma: Supports to add/delete a device with type SMI
> 
>   man/man8/rdma-dev.8                   |  40 +++++++++
>   rdma/dev.c                            | 120 ++++++++++++++++++++++++++
>   rdma/include/uapi/rdma/rdma_netlink.h |  13 +++
>   rdma/rdma.h                           |   2 +
>   rdma/utils.c                          |   2 +
>   5 files changed, 177 insertions(+)
> 
Actually these are the patches, no RFC. Sorry for confusion.

