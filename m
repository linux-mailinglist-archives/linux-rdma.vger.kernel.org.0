Return-Path: <linux-rdma+bounces-6579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650639F4A22
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F419D188C632
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF21EF096;
	Tue, 17 Dec 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PL9wAVF4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C751EE031;
	Tue, 17 Dec 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435788; cv=fail; b=gMFMtQX1yNTPbdZB6RCb9GhJLJXP63nj1+imEnKG/B+Hr02Niu9rf1Ho3GT2wIf56ZJGXy7y6Q9qSeaPhaTKrtzy+0d0Qe4DGalLQW3fha9FcxIY1xSkv5iNoQowElrK48Vive4Hb9gGQBgcoiGuTv+ZqJqvbNdm4dGU/luI1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435788; c=relaxed/simple;
	bh=NZYWWpgWDw6v03Nz2DpSW19wWJ1MUlQAg16NVLt1+S8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szHkpx+IVFL3tmCraHitZV3tQC/TL7/K+0d0d6gtvH8vws8snNXI6tQVpQVwx2EBhMlfE0cAUI/LJM4xCEnnUXTKDOr6hRSguRg0WKIVy4HLE3Tp0dBJ7YDoXcnZwx9+uVErthuljtHVQBmivRIMv1SaC9SbssDyB8xC/O0mOwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PL9wAVF4; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unOcSN985hGFo23IghaSonehdWwvqPtEYIeVhtQDX4rVs/JOm1ZZdrTrTUBC5giN2Jls5bhHubOP8lv90LFwQB+pPyyiPqaonr9SanN0qXXR+nv6VFkBo75qx0QALxjzAmYQrplrFsNiVcJiQbtnLSAEPiffagJOtNSh/3SVB2G1XTb0AqpaHC9Slo3hrrZp0Mknhie0B7cT3hS85ESYEdzHkJkWO2AgqN64PjXJbx5OlAww9UGEj6vOiTwUISgg2e9ZYsV+DAGDwvZynfvOHPt2PozAdoJIZHu8Z9AyYhUW3ydwWrmwxt8PfikOKGfItrudO8rA6F4tnnLOp1OEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IJqUvGjHjkYB8KVEuNvQhWl9QkVSVGBljXtoBiib94=;
 b=dBo2lpQbaRwnuVoO0JS6FiXKXlaKSzsLHVfZTGzMJidNlbsl9kd8tXf1zyDjwiU3X/0BbvqwbqlO0re/CBQFW9DXuaH0Q8t6YRTSo9vJCS0igKq3Wi8Flxmv4v9NjzpiNHy2dPsPkL7Q+DH8buDM9IUDiCQwMpLEkpiq4tTIIaEPC9tXLT6P4lHHYPFFInGOiq802wsigyxX0yD9jvYjXH47WkKOUSdUiqa5orQg4K8PCFOWCtA/zy+ax2m5c4EZo5SaaI1heKZcLJNIKl3LeKdVtY/OkP4Z1IHOTr9XEPaaFGQcPudW/mdbBEfkpgnugvYQdJjkepmyYm6lzW0QdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IJqUvGjHjkYB8KVEuNvQhWl9QkVSVGBljXtoBiib94=;
 b=PL9wAVF4gRV2LxEuiJZnHKKpkfXdphztKTjRvHVFYtNppZUuD2svQ0R3X2LZweE6G8SdQFVq97v538pJN5VIlOxx/QyP1SCpkbl+rCQFgwKeDs7FR/CsHq+MXqa2N4Nw5jaCG/Gw94DEIUmG4v1KAPyTkgxudPvRu5SnEeJGvUzpWfri9FcU3ZF9RLtZOu4a0p4+BuYSsB+WMVIm25IjyBL/CvgKl3L7gZF6e+WNcK8sjWKp1U9nL5R4w/0eWIR3IykP00OTX+CTv7WbBBOBg9+KHqkr0MFSfxJ2VqRCMFHlM7PLS96Tm41clphgUYh5nMNLVcDzT8uzjTmjdRelwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 11:43:04 +0000
Received: from DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8]) by DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:43:04 +0000
Message-ID: <b69a5cac-d870-4181-aaf5-715697f5dbdb@nvidia.com>
Date: Tue, 17 Dec 2024 19:42:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
 <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
 <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
From: rongwei liu <rongweil@nvidia.com>
In-Reply-To: <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8443:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b79fa4-5390-4759-827f-08dd1e8ff74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTV6T2VZSGd2YVNHaXB5RWVITllTZEdKYURvVXZxdW56NW4yczBiT09CSVBy?=
 =?utf-8?B?ZFJKQWtpVDlSNjFBMXdyMVBlRXYwQnJhR05zcHlzTVd6aXc4YUFSSWl0TnNH?=
 =?utf-8?B?QUdISHVtUHlqb3FoTloyc2xsWjAxRUlBK0xSWkh1MkdXbitIMFlRdTNGc0JW?=
 =?utf-8?B?ZnV2bmtLNW5mL2dNRTE1ZTd1dCtoSDFEMURlTkgzVGFYWk9KUjdLb1RGNVFi?=
 =?utf-8?B?clNCUG9GOHVPSmRhY3J6dDhFbldPNndHQkdOcUplZ1JGaENTZFVJNjVnV1Na?=
 =?utf-8?B?bENWMDhVRXl0bG85THlpY1dBSWJIMFBUdklRbVNITTA2T0NVZzAwTW1UcjNi?=
 =?utf-8?B?NnR2NVpXaUZXaUpaNHlJNWRFVVV0amR2eWlWVEl3ZEo4N2Jua3BJS29ETHE4?=
 =?utf-8?B?cnNNQWNNRC9Zc2l5RDlEYm02WFViYStjVm1rT2wrcldHaXlYUHFxNjZBakRN?=
 =?utf-8?B?QnJjejR6bEo2cW8zZ0xTdjFTM01lTnhNNVd0S3JOMW9LVng1TzZES3RneHAv?=
 =?utf-8?B?SzRnTDFBMk94aU91dGxBSEFoZGhJaUJycTFlVjY2alhVb2gyTkF3Z01BNHRF?=
 =?utf-8?B?SEVEeWFBQjVMN0tQUzhKd0xuM3lPazFjUEJJZWFubHJLVHJ6dUdxcS8zWHQ1?=
 =?utf-8?B?YUhQTDhWQnJDUExycVNjajBVTzZmL0hITUVBV2RJcWJJTEVuZjZralJNTjJr?=
 =?utf-8?B?R2JSR1cvZitsUEMwaXNnQmdwQVNvOGhwbjZ5NG9MRHBNQmxiQWlDdm5kMmRh?=
 =?utf-8?B?V0Y0ZUxmVVJmTThla3ZCblJwWmZabnN3bjF0RXg3UVJYa3FoeVl6OXo0MzFv?=
 =?utf-8?B?R0pWd1Z5YW9nVTVMTVU1R2RxczFqc1J0QUZuYkRFNGhoVEZmMWhWcmVLbi8v?=
 =?utf-8?B?QlphSXBJNHgxL1JrVTNJTkdKQjlJYktmMGswbUw0aFo1UEk4MDlkdWp4cTUw?=
 =?utf-8?B?aktRWXA5L01yRDJqZUNqK3ovdjZ3UTNWb2lGcVFWblppaWROTkF3YlZVazA2?=
 =?utf-8?B?eU1uR1RrRm9ncFZaaGNVci9aYTFycS9TcjRyZzkrVmZaNnVxQTMwbUJkRERo?=
 =?utf-8?B?NVAwUHVpOHhhcFQ4UUxkcmpZYU1nZ2dBM2Ewb3N3aGhLc20rYmowY3h5akRt?=
 =?utf-8?B?VWJhY2E0clNOazlDcVBaMHllbG9QWUsyMmhrVDU1dVdtdGp3STZFNDZXZDRt?=
 =?utf-8?B?ampDV2xqZFIyUlo4b0twbW9lUERzMmNLZVJtNjR3UXltOXZIODVjSFBoSHR1?=
 =?utf-8?B?akRKRWgxaXVkd1phY2NkTU93NVZKaUpYL3dZbjR0OFJUUFlwU3g3T3k3eStK?=
 =?utf-8?B?anhaZElFQ05OWkZCSjAwVFdnWmZGSUwwL3VRR1dnMThxWU9YUzdrT0Z2c1NV?=
 =?utf-8?B?WTFyYzdkb1F3cFBENjdXeUlJK3pFbTE0SnFFWjEwZSt1R25YTUFkNUh6YU5M?=
 =?utf-8?B?R2tka3NORnZvMzhWZGpOU25mNlRVR0ZEM2V0aG11bUhDNnJNR0FxNERNeVZ5?=
 =?utf-8?B?SFV2ckdBTU8wQW1MYXRKYzBhNWljeGhUK2ZVUlQ5VHF1UGVmMEdLRE5jUitv?=
 =?utf-8?B?M2pTUDdHa0NOQk4wSDJMMlF2K3B4d2RrY2hzUVVHb1pTTjY1RXJBWC95blhi?=
 =?utf-8?B?d2pxTHV5TUFpQzRraHY5S3RSL3lSR1hoOFloWTRxbHROY0s4YVFnUXlTVC9C?=
 =?utf-8?B?aDJSdENlVTg3b0ZJaTlXOS9FRHVoYlRMbm8rTVgvLzYvNmsrK1VtSmhxSE8w?=
 =?utf-8?B?SXowMHNMM0JINXVFZlI5VHhpSjhoTVc0RUNFU3BtUDBZUjNlUWJ2cTM1ajha?=
 =?utf-8?B?cmREUnVoM0xheUw2a0toRzVERXI0REY1Z3FKKysxcjRJZGt2R1BsYm00V01V?=
 =?utf-8?Q?nixLaz9Jqzwk6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8443.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVNIdkNLNG0xWDFnekt5TDJrL2NWMlJiWjltUGVJUXJoMS95RUwyVXowd3hZ?=
 =?utf-8?B?UHN6Z2pvMENxOWdJeHNoSTIxOUgwTGx0YjY3UExxU09aK3RNZUUyakRqUVpw?=
 =?utf-8?B?aUU3K1hFZ2JNa1I3RE5LV1JQS2RaMjdESXZ3UXB1eWlKSW5Nd0N6cmFlUjMr?=
 =?utf-8?B?clgvM2F4L2ZLdzg3SHRjR3h2a0VpbWc2OTUxUEdNNy82THZVMG5QWUd3dlhs?=
 =?utf-8?B?UXF1azMxU1NvVmRINnV1TDFuUUV4cG1jSWpiTGdNaFc1bFBMZ1RjODhaeVU2?=
 =?utf-8?B?eHVncEFmZHI5UTZOQVZNWkVQcHdKTWt6dlNWekNKMWVtUTlZTXpUUXAwK0Jk?=
 =?utf-8?B?aTV0STBPbFNJUFBRYk9aUXhqZy8wdkFCczU5REtock5iU0NrTnFNbTdTbEhY?=
 =?utf-8?B?QkdYejZTOE1UR05ZMzcyL1l1RTQ3TVY1Ui9XM2dDWDRLWThWSlhGbXRtd25o?=
 =?utf-8?B?THU2ZkRKMkZKai9yN1hYVVQyVmQybzhUMlVPR1dyaHh3RWx2Q0liWGVVVW8v?=
 =?utf-8?B?QzMyQTFzSFpxVVNpZWg1RjUrcWorNEtFTTF3VWtPTGdBa0lvdWtLS3VhYVJo?=
 =?utf-8?B?RHZrWVNER2RXQ1NCVGRhRk5sYkZiTldueEdLTklDbSszNHlLV2laMWNVUk9z?=
 =?utf-8?B?MU4xVG5NK1c4THB1ZzRsUU9oUXRHdHd2ZTQzMzNFb04vL2FBd2JsL1p2RWtn?=
 =?utf-8?B?YTdnK0tJcE1ZNThQZC91bmlobVIvUzJjOGYzcnlwQ3FPdkhSbkd4Lzd6Z1Fi?=
 =?utf-8?B?SGpIaHc2dGsvWHI5TTR5dW15WXlQL1FsZWlKV0c5aW9UQjRONllrcEg4U1N1?=
 =?utf-8?B?UWxVL0dLRTF6RUJkaFVaa3c1R0VybFFlWkZSUVdkemY3MmdzQlMyM2cxT0Rm?=
 =?utf-8?B?eUpEZ2lUbFlKRjFBd1VNa3FpWXVmc0ltNFAwLzcrUGFqMDRBNm1ONkpNMFZs?=
 =?utf-8?B?cSs0RjZWMEVaRGZoRDN0U0k1elJwM3VxSzAvRFBtdE1kZUF2ZWw1QVZuTDZ3?=
 =?utf-8?B?ckhxSHJpdTJaNEJUY1FRTEJlU29FWFFTYnpwZWtrUkdSOEQ1eUZ6TzZENlJE?=
 =?utf-8?B?ekRGSWFBK0IvK215bFlDQnJXSjdMZ1g0cXRHS0c5elhIZFcxeVJ3ODRPRGl3?=
 =?utf-8?B?M3dVNDJ1QmZ5UDBTTjVhTzNoZlgrbU5zRCtsVUkydGoxL2EzTkZlWjVOS1Ux?=
 =?utf-8?B?SlAvUmNYbWh5am81SXNzNFhncDlST2xoWFJlSUEvdnJMOTU2bmNxOFhlVU04?=
 =?utf-8?B?Sjd5Q0x4anBZZk1MV3JZSHlhR0RhMTRjOW9QYUp6NUFwNDQyNld4M0VMQm1R?=
 =?utf-8?B?eXRzejA1RS9WSStVM0hybWtoZnJuMW9zQ1BUWEFtWVFBc0FHU2VDQXc4b1FF?=
 =?utf-8?B?ZkprZHF4S2o0WWl6Ymx6NHdlTmdmbVl6SG5OYWpsdWRyUzB1RFN2dEdPRkxt?=
 =?utf-8?B?aCthMFhSeWx6TlNabUUxR09nR3lGYjcvNmRNRnpleXc5TWdaNlRIR08xVzhN?=
 =?utf-8?B?ZTF4aUpURFdXemhXNVlnZ0VhbTc2M3M2YVRFM2tHNFEvM3BVeUovS3FuNFhk?=
 =?utf-8?B?OVAxa09JbDVjVFdhWlNyekR4dlNiQ1BZemUzRHdwMmtJNWxIR050L3Y5anVl?=
 =?utf-8?B?R3l0RjVsL0FPSTNvVTdrdFN1UlVDeWRnZ25yU3N0dGtYbTRTa1dYL29zRFp1?=
 =?utf-8?B?SmlDczFHY0pYYm9PYmR3NmpYOTFyb0s3WGNabjYzVnVIRmtlekJqOGhvT25M?=
 =?utf-8?B?Y2VVR2JUMENVb2hIdUMwU0FpRGZhVEtGai9odEpnc2lmWFRNcVQvZjNDazlj?=
 =?utf-8?B?NjdyR2FCNDdHbmdxbUZHYi9xMEZmcHUxbGpiVVhVV0ZNa0lvbzVvQmhoY3dX?=
 =?utf-8?B?Y1RUR0xZRUZSeFBYYkdmeUJxWXpVYnZsZ1VhTGNiekxxa21yQXNsWk1EVmZk?=
 =?utf-8?B?OVk5eWtTS2NqTGNuaStvZDNZQVJqZFhhdCtpajBSeU5PRjZnYjQ5QytDSUl0?=
 =?utf-8?B?NG9xZWJuVUViNVh6ektySEJsckRaMmdoYzV4SUYzR3AxUkVOSnNhL3F3RnVh?=
 =?utf-8?B?Sy9XdU9QS2NaRHQ5ZTF1QU1tbWRMUy9vUlBncFpRN0x0ZzhWNHFCRFVrQnR5?=
 =?utf-8?Q?xOqfW5KD4GQ9qxWoccjNOdzLk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b79fa4-5390-4759-827f-08dd1e8ff74d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8443.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:43:03.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cqVvKSZkq5qLDvocLJc/PmbiygJBIl0xo+0+eBUdgqjcFn9eDpaWgBj+3onKpqiOWBFWngK98V0IdMmcrrGgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665



On 2024/12/17 19:32, Alexander Lobakin wrote:
> From: Rongwei Liu <rongweil@nvidia.com>
> Date: Tue, 17 Dec 2024 13:44:07 +0800
> 
>>
>>
>> On 2024/12/17 01:55, Alexander Lobakin wrote:
>>> From: Tariq Toukan <tariqt@nvidia.com>
>>> Date: Wed, 11 Dec 2024 15:42:13 +0200
>>>
>>>> From: Rongwei Liu <rongweil@nvidia.com>
>>>>
>>>> Wrap the lag pf access into two new macros:
>>>> 1. ldev_for_each()
>>>> 2. ldev_for_each_reverse()
>>>> The maximum number of lag ports and the index to `natvie_port_num`
>>>> mapping will be handled by the two new macros.
>>>> Users shouldn't use the for loop anymore.
>>>
>>> [...]
>>>
>>>> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>>>>  	mlx5_queue_bond_work(ldev, 0);
>>>>  }
>>>>  
>>>> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = start_idx; i >= end_idx; i--)
>>>> +		if (ldev->pf[i].dev)
>>>> +			return i;
>>>> +	return -1;
>>>> +}
>>>> +
>>>> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
>>>> +		if (ldev->pf[i].dev)
>>>> +			return i;
>>>> +	return MLX5_MAX_PORTS;
>>>> +}
>>>
>>> Why aren't these two prefixed with mlx5?
>>> We can have. No mlx5 prefix aligns with "ldev_for_each/ldev_for_each_reverse()", simple, short and meaningful.
> 
> All drivers must have its symbols prefixed, otherwise there might be
> name conflicts at anytime and also it's not clear where a definition
> comes from if it's not prefixed.
> 
ACK
>>>> +
>>>>  bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
>>>>  {
>>>>  	struct mlx5_lag *ldev;
>>>
>>> [...]
>>>
>>>>  
>>>> +#define ldev_for_each(i, start_index, ldev) \
>>>> +	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
>>>> +	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
>>>> +
>>>> +#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
>>>> +	for (int tmp = start_index, tmp1 = end_index; \
>>>> +	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
>>>> +	     i = tmp, tmp >= tmp1; tmp--)
>>>
>>> Same?
>> Reverse is used to the error handling. Add end index is more convenient.
>> Of course, we can remove the end_index. 
>> But all the logic need to add:
>> 	if (i < end_index)
>> 		break;
>> If no strong comments, I would like to keep as now.
> 
> By "same?" I meant that there two are also not prefixed with mlx5_, the
> same as the two above.

ACK
> 
> Thanks,
> Olek


