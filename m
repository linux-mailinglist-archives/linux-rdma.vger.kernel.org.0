Return-Path: <linux-rdma+bounces-122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB457FBA8B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117F8B21075
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E744F895;
	Tue, 28 Nov 2023 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZSyEaMW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14743D51;
	Tue, 28 Nov 2023 04:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSWhMy61EWeH4Vl3gqKF8uJFNkiK6vPvUrDLKq4Nd1GqXwqM+G2aTgYKnVB759+8RWVheLDJraaZAU3Cljuwr44nnbMKZRPU0cRQQ/0bL/G93HCARIZaFO8f8UGlMG21WPditIz/KvB78sx/hPRsPDncf526/jAN4eoyBhMJDD3XJ4f0hseYQRsJj0KNcWWnCmzWTCKM7L3Bk8Beg3g9QPbI7O/yeWR/5MCHhP/DQVrXgWr5IaDpew3rJJ48OpW/JWL92ovkG64nxjpOcqdXGaI+gbHR3bV8SeptykFU4V0mRSd5mshDbYSEZ16pMR3CYnt0DEkvbUxxZYnSivHg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjuLq6lrapfZo7Nn1kiUPlwNY6uGifn9QDdE9z3qe68=;
 b=LVcgX+YvsI0w9g3ETOe+gl1H7oedoHOO0PbSc7W/XqaNzJhTHlqf5Un/FWAO2N6TJBpTAUqfpljslSpB3TMtkiI2X81n6PUi4AcedENenc62p8ShCDcwmZmJjIDA0wt6d2XIzMFxLQ+PdlmfNGL2trz6i1pgwMh4oebKHbpBd/lyuqdSG9ey0vNCfH3xMFV0P5xBuP21CI7O+cSZ2MfsuxhN+MTBywfbNZxQ8BCAolTyJLGSnPhzlEMcLUulBmZQcPFUTuonbgmwMILtlSfPfD0lLJjV6zwj/uK421ur+YjWAkOD4aZf+zYxVuaAYsr0g0+N2V8orYHZcXNG1wc45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjuLq6lrapfZo7Nn1kiUPlwNY6uGifn9QDdE9z3qe68=;
 b=nZSyEaMWp5xt7s2XjweWgUq4XczUNGLMpXqlu3Zcc/908IFK+FXtFHkFHnOKaUUp0wKxuIbci8ueVBA3SBedWL3p/nTaFTxvcTe6QGsMJZr1aH2hiyGzWTyqL/hF+9rr+5jB1fUnJgw7H+ZbI5GNkhxtiRb9Xn5LgEKgD/aBGkeE1bgmn3r1dwnyx654OrrzgxF8oqKgG6iHIhjvE1Of/UB3U5ZcrteA0TJqHYVF5ic8SnjmC6vgw/bZbWxE6eKxChBVOnup4diQSZRLgw614PyRXlMlwFASreqmi5lC37qD75qF5D/ZCTrUjSXxw8HUJj4oB1pvLc7UpTswdBQ6zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 12:53:41 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::1f02:538e:871:9bd3]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::1f02:538e:871:9bd3%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 12:53:40 +0000
Message-ID: <b7300fbb-41b5-4a30-b086-a8dde8ede207@nvidia.com>
Date: Tue, 28 Nov 2023 14:53:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_any_create_groups
Content-Language: en-US
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Zhengchao Shao <shaozhengchao@huawei.com>, Simon Horman <horms@kernel.org>,
 Aya Levin <ayal@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128092904.2916-1-dinghao.liu@zju.edu.cn>
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20231128092904.2916-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: f94c2452-4df4-4302-fd03-08dbf0110bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7BSSbbgDOrohucDqq8EFXVwwOh0n0/o8IvdN3fYZv2uE3uhOCu5honiCajw351PhGCAy/kBNBN9cMh1KQIMXC7KH5CQHg/pcP43GGXPNe7qKaM/c767LWXHcFIHI+/KsV8AC+u0m6jCjqHhd5HTDJUEFjQ4Sa/yjOiKdZEpbbmGhGv3Cu5aFrqyAGBx4mq8QP+PmbCaUdVObIAVR7E3hvlvLgk3f8mY1Q16f1dj8V1mqnOBHzI+cAacNlFdc++DuUh9oDl4XBuXkMyhr2C9noo4XLTKuh/s87+gTPlFH6FLIKRPalBL0jjVbERhsYAFNtmAHDpdDO5kxFWv1CszQYF2Qrb0Zb4v2477FRKk7MnwB4QGdTZnP8IDzNf40TofgmqrPXnsTkiPV3rQhq6wFqp/1QO7RbzYYT0RMLT/g2QCbQ2wjhODFUd6ha+R1psR+S0tb1LSVCcYuXV85oqlXtMHN/a/rfxd2Gs8KkKWkyY+3kyvN55fjVLtcqM9OAPjLLOrbd5eHd5uIMlPqikgh87I9LwWEHcJ5nFyeKV3rveT35MhSHt9crIXlDE054cAJzsrDBHU7NFcRq2/ITsGBT8nAXPFgqzFdBhg9Pkolcz7FYThtZCBkK+ErIFNwE2WEppUr11Enr17045GpX1l7aQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(41300700001)(36756003)(31686004)(86362001)(5660300002)(7416002)(2616005)(2906002)(31696002)(26005)(6512007)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(478600001)(6486002)(54906003)(66946007)(66556008)(66476007)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U012RHpKbktVb1M5U3hVKzdFQlEwNlgwQkpKQytxSDc2b0VBaERiYytrampM?=
 =?utf-8?B?MVd4a2ZsZXR1K3BGbHY4dktpeHhRN0J4bGlKVWRPcHpIYnZPMEdnc3NwMi9Y?=
 =?utf-8?B?dkFKVkRoc0pMWWFyQkpzajhGYzNVNVRET2FEdUN1TUtMeU85dlBjQWM0MU1s?=
 =?utf-8?B?TjF1MmVmczM5V1hQbTd5NWJsTjByWUd1NGVLZXVzQXhVL2RxTzBsUElEMnVr?=
 =?utf-8?B?YnY3UXNWdGN5bTZnZnBYenFnbkdtRXRnL0JaeVp6dTg5bjBOajc1OE1DcVl5?=
 =?utf-8?B?NTdFVU1adG4vdFRBaHErUVFPSU9lemtDWEtyYjNxSlFPb2pVWWdybWxQNVNK?=
 =?utf-8?B?eElncmovOHA0aU5ZVTBBTk4va0NLQjYzb3UxMDlkOGlXUUc5c0duL0Z0bVF6?=
 =?utf-8?B?TlJxcGN3MmYxVFkyd0d6bEFuZ2pMbHZGMGFlUjNmaGlTczVzd1BiNHo1WkFZ?=
 =?utf-8?B?SkZIc1RIQmtrZFVLcE5saEZvQU8wdXovYmNBRTVMU1ZNK2tXK0hEUHhGR1Jo?=
 =?utf-8?B?dUZVOHVhMzdRWkx2Rm9NOENMMy9KR04vQWVTZSt0bmtvbDRPYXdIb2RUVENJ?=
 =?utf-8?B?S3ZubXU1TGlueFdZdHhIdlE0WEV2K1c3T282NkFSd1EwOHFJRmJsNXJ0b3Jt?=
 =?utf-8?B?UEFYdXl5ekQ2ditvaHB5TjBYUkh5VVNaZUVqc1BNV2VJWXFPUDAvblo5UVAx?=
 =?utf-8?B?NFRmdHdiVzNJa3hMNEhSVUlYcnJxVTV1VW56SzhPc0dzZG9rZXVJTDVVRGhQ?=
 =?utf-8?B?SENzQXRtaWpCaklPaEJkU3ZXSlRpRTNwR1lpeDRMajZQeXMxd2U4TTI5ZUV1?=
 =?utf-8?B?WmlHMmovRjU3TEFJQlBVT05uRVdUMVBteStqeVpINTRkM2F6Vm5Vcm5lMFhw?=
 =?utf-8?B?MldHM3hFenlyOHB2dzEzUXFpTEsreVZabEl1Yk00NUwxK011aVYwTXZlTGpW?=
 =?utf-8?B?SVJwMVlMU0czdkMrdXRPVnRQVk5pT2ZUbXA4RnZSR3JKYWM1eFFkZllGY0s3?=
 =?utf-8?B?RDJlcE14V0VMTG5jMXRhZTBJNUJLdTBnVnBaYkZiVWpuNTUwdXY1V2d5bmlw?=
 =?utf-8?B?MHl6YWFya2NqcS9vZUNYc3VLbW5mUFdPRDNoRVZLU1RxNEtYVVlFS1VML2pG?=
 =?utf-8?B?OGxUNzVDSHhMVDNDZ1BQWlhucDlxWUVrYmlHdldLRVlkOWQwc05nV2d1Qkg1?=
 =?utf-8?B?VlRFbGdOdEJ0K25uWCtoY2RwSFZONUF3MWJMMkRsZVFmcUpqRmJKdkxnVEZh?=
 =?utf-8?B?MUdPUW5BdWE3d2o1TzhXVlBqK3YyTHRZeTQ5cFR1RGZhVWhaVk13RFRKMWVS?=
 =?utf-8?B?UWNEbUJJRkI4SWZnUVl2WHNSRlRkcTRvcS9Ka1p4RHh1TWV1cFF1MzhMWHJT?=
 =?utf-8?B?WlExd1hxQm9rU1ZkQjlOOG1NNmZ1SlN2VEhLM2Vxa3ZUSUFmTXdrSUNmWmdW?=
 =?utf-8?B?MEVmd2ZUN3ZYT21EalZoMEgrcGVoS0dnbVJ3S2RrYlRqS05IVXN0ZlUyTUtX?=
 =?utf-8?B?OFNWS05QNVlaVXd0Y3ArbG9pMXV3K2hHVStNTWNyaVI2UXh0azFmVzNhMzZD?=
 =?utf-8?B?aW0xVGxKamVERFN2K0FVMkZVandpZGY4U3ZXREFpUllnZW5NSFM3Z1JwdVJt?=
 =?utf-8?B?bXNvYlR2U05laXpFUXB1RnptQnFPbTU4MmJ1VEM3Vit3cEhsd21yZWY2YjNK?=
 =?utf-8?B?cndKL1VmWm9Rb3VoSFNDQ3RUSnJnN1R6NDlyMG9PTDE0azhDVUZ1ZmdHZ1dx?=
 =?utf-8?B?cFZFREZKVCs2NTZlSFFMNENXOXdxOEEvU01hUStKOWVxUXhKcU80dldWTGQz?=
 =?utf-8?B?QUdDZy9zMHNZc0liWEZVb24xaUFOdEdNK3NhM2RKYWIybkM2M3R3QXJIaEQ1?=
 =?utf-8?B?OFdlZ080OEtLVTg3MHdXVHJuczJpdG5FNmorTXpzTHR4V2NvR210QWRXZkNV?=
 =?utf-8?B?TTZpUThoVUlLVlhrRmpkNHJYTEhKL1JIQk1GK1dMZWd0YkNjQUJQc2ZUZUlY?=
 =?utf-8?B?UGUwc0JNMmNPMG0vWkozSXFSSVdEeVVWczluUEluS1VtdVZsL1p1UFl4MmNt?=
 =?utf-8?B?Y2wxWUw0QVgrTWZzL29vYUZtbG9BZUdVZktGMjNRbUgreGJ1RUZudHdmRkRw?=
 =?utf-8?Q?jN1uc8sDOI9vGBVP5RB562PCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94c2452-4df4-4302-fd03-08dbf0110bea
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 12:53:40.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK6a3DNQqS60FZ4VazHK9eU6a6g+UPhuT/dFUwH+jhd3Kjd8IDPkQvAnlfLnZhuRlt4ZvrbOlrBzzLTc82kATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134



On 28/11/2023 11:29, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_any_create_groups() will free ft->g. However, its caller
> fs_any_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by setting ft->g to NULL in fs_any_create_groups().
> 
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: Setting ft->g to NULL instead of removing the kfree().
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index be83ad9db82a..6207ffe74233 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -435,6 +435,7 @@ static int fs_any_create_groups(struct mlx5e_flow_table *ft)
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if  (!in || !ft->g) {
>   		kfree(ft->g);
> +		ft->g = NULL;
>   		kvfree(in);
>   		return -ENOMEM;
>   	}

Reviewed-by: Tariq Toukan <tariqt@nvidia.com> 
 
 


