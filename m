Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE028742BCE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjF2SS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 14:18:59 -0400
Received: from mail-bn8nam04on2075.outbound.protection.outlook.com ([40.107.100.75]:54310
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231634AbjF2SSo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jun 2023 14:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbzWEEM7ZSb5MkcDUjvNSQZm1Hwh5Q+G74L7MpWrh7xyGekeUCL1UgOv2XdYV8IvIoHjo/lJlsdy8m7QqHCxP8y2LNkVnQK+tlm5eiq5hX1B545Yd9ueN3NiGf3+KU1v+wcbY6LJzt5b5G/TIRZix1/oP8lUbrdOuDW8BSUASG5qMbFRJfkZEOz7u2843wqtRs/ra4KJdiFzM7cE6cKUEL1xeq59B0RtFbupml6mw6DuZOAC7HqiboRdD+CcdtVM1Ha7WpZEjDdn1dYMAaiIagq7WHfNd2lyM4EUdkU9fZXzntlyBKyaVfjBHpzcvLr7DPD3Mv+4uonzJX9T8kIofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcCLa+bEB73yDqPy4dZqdAoE6MSzW0RVIZ1HxQnffgg=;
 b=j1v88YGKzmsX2T4SiXTA/PdU9AZba6C+zZ2KcC5iwwHs0jcHxr1hp+wCCr7kqKvEB0VEMFj1zoTq+o1YibiFuRLiKytGrRKgead5ugvJqjxv6GHfVOggJIv6oui5ox1STe53DqXgFHPQjJRK1HYHj7zcj7RJ4LeESUcEMWyni/BXI+k902HBuCyjkGQQVPD2Q9Gu3Ub8GYh2xK7tZhA/NrS/RwJs0Zygnc02IjzWtM/BYYE6eyS8v9uB+g+QVnTSBy+AxO07SYmChHHdQSyw+YHTmBnqGP8OtNEkeWacHpT9cbYS58zkbXuRp/WZz920nP+ayjSmUbzkAJNmsxPU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcCLa+bEB73yDqPy4dZqdAoE6MSzW0RVIZ1HxQnffgg=;
 b=MVDQIa6WQ9eWX1dHSNGOVpoBB48kaQjZUQDJnf6O49YM5h5fcbZTqNiLrhOejub4RRgkFbM2IabfoNUNoDv1UNX9aYs6PxJ1YKATkWtr+nMYowTPKP0A01RS55IWxNtAVMjUlI8ZCP/1zVNxjfjf667jKf5T6Ci3awY80Tmm4lMpCWpsj9BUaakjg0XpIPZr6snojB3T/yGltxrX64+hbthPU37PqQtqW2ary/RhzBrthYJ+zOSRB+QI9JTS1tTmIlW6THJxw7RWXCdIkLm69EPOCetAl9i74HxDqqndunJb/uEkLHfDhA++KclwlkCZBRo/k8lpNPHh2mNQJLqnFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 18:18:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 18:18:36 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
        <tariqt@nvidia.com>, <gal@nvidia.com>, <vadfed@meta.com>,
        <ayal@nvidia.com>, <eranbe@nvidia.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: fix memory leak in
 mlx5e_fs_tt_redirect_any_create
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
        <20230629024642.2228767-2-shaozhengchao@huawei.com>
Date:   Thu, 29 Jun 2023 11:18:22 -0700
In-Reply-To: <20230629024642.2228767-2-shaozhengchao@huawei.com> (Zhengchao
        Shao's message of "Thu, 29 Jun 2023 10:46:41 +0800")
Message-ID: <874jmqb09d.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b27ac86-9a5f-43ce-95fb-08db78cd4116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5ULEsi5EvkJd97nBIGNM2PtoShdnNZglSbbADfCm8z3JdU162kp8vqzEhxpKbUXWUE1kA5yPKgY6EAH+QUnvukiodRPhTgk4kTckX9rTFuZfKzZKBUXDpE3LosrIz4k7Exh2OmhVxDFJG7NKRwpwfnQTZoAy0XgtD18S096PHPjlMJzAF/XsbvhTdpHolm+H+zvFQcD6EQ0vK8Amkcykx2O/OnFhRwwe8gxCG4YBx0TzADmzBxPxEN3mv3tTK47jES+7NJHj6RsngiLv990c6VtjKvrD6QQFyvfsCKi4/bw1Reg+wgs9AeH3uFIl1xfmjjH4e1TMo868vTFZhX9fvGcJUbmMCN6VD+JO3m53LgYPD2cRpOS27Zz4cFzOZL2pLuijFEcRpeXnUsozmjUR9U4Gzvds9PUHgLCEt2xY2W4Bvy3Ogtdz5X9Eg2SugnXntFp9CVFdizygSqDYBv2H5X5ptjUO11uNZe8m9tt8rRnrxB+OdkwMCws8DcjSruu+i21zPFVaSqo8FdhOqz0aDQFW4+lfmg8pf8NMmHP81UcUA0sHL/pk4mMh/itYQh9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(26005)(36756003)(66476007)(66946007)(38100700002)(86362001)(6916009)(5660300002)(7416002)(41300700001)(4326008)(316002)(8676002)(8936002)(66556008)(6486002)(6512007)(186003)(2906002)(2616005)(54906003)(6666004)(6506007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYwHVu/Y0e6f4mPJ8ep4M7cgOxxEU18e+nFmIRc9y8WKXeL6jKmZKLYr8J9i?=
 =?us-ascii?Q?pEo58MqZGAl8hrh+6bmH93tfwfALMMvCAKaEAdiRIsDy6362jQGxR1SyM5GA?=
 =?us-ascii?Q?rZUyEKz8eLlT/EKgDf6DGxC4vKkHmI+v573D11yU+Ry5eCeFrPtoZc1cJnYy?=
 =?us-ascii?Q?9djYSHuewQpD0s3zEnq4dsZPXDQEcJGFtZqDVQzl0yKr3HhPmiFmrNceIdjS?=
 =?us-ascii?Q?7VjFG61zIub0HjfyA/LSXxz9SWe77b5RDuwrJc+fN9lfUIrJ1HzxQlLq1LMM?=
 =?us-ascii?Q?BZHSohSUrlLnqDZHN6ZvufVw0oiDZEZuyJo+d6qy/a08fnzojAs746wxSs4I?=
 =?us-ascii?Q?RyE1ameb7dMPrSvvCqLJUIXt1z0E2JDsrc/42gUWW2au4pfdTyWVtT9O6gtS?=
 =?us-ascii?Q?GR9JjkJNL280cuDILlt0/MSBkI0bn4XozM29+ZdgN/2PrnGiGF5idMWLfWNw?=
 =?us-ascii?Q?9dOd9bSkAB1Cn7cl+xsD3OjP5pNbDK9G8B3OwpM/NyYWwjjod3oFRKKzsaXz?=
 =?us-ascii?Q?/QNs/i1QIAz/7BwDo0PRCMALqMddFMOh8+RK0ya4AxuNoaHB9Ao7pqSM6vcg?=
 =?us-ascii?Q?GrYjrozrsKKshxxARyQrlDrGaCToBAr9jseBFAENEhAm1UpeN8NMlIro02/c?=
 =?us-ascii?Q?Bp2cVFT2uZIHPX9f6RphPwvwAs6LN+Brb1XPODj37ojyhV+BLlYUCuaXSGav?=
 =?us-ascii?Q?eg0vX7H1/sG0W0lU/8w1JzsAz2Htpz9wZHQUr4sl1nVrUz9TviFmpj/NkGew?=
 =?us-ascii?Q?YMXLr6BTYBNMokVrzbGip3eTIDi8LbV34A5nb+dKh4mUKyCuNMq/EFF7ByRo?=
 =?us-ascii?Q?5O/ZChX93qd2HzcFnXZgo8keT8DuQBE6Aul74VZAuj0O/ch4AT0BJBO1+nGb?=
 =?us-ascii?Q?0DZhyYODJQIo4qcbQ9YvgRJ0aNXIQSDx8ZnB4y4Kx6c20bLu6qNboyGS7jVM?=
 =?us-ascii?Q?tk3eT6AHYhrn5h1LGL3tFCz/hC6SeH6NdLAkpU/8umAFViNbfSVgVe6vy2Y/?=
 =?us-ascii?Q?A5yBR++KSjxDOM+hjJ/X1cEpyWuJlZeKwS2h7DbWRFVFzJmwE0cuZAog49z6?=
 =?us-ascii?Q?WjdBEFg7jJPpDaCIB9QOsfYaAyrOhySsrBeolO3LBoQACdtSMuiJUx/lQeN/?=
 =?us-ascii?Q?zAtbKOJHf3JM0ereuTz5V9Wb0tAug3LH7+nDN6KVt4CRXrcyTABvAx+pMyJw?=
 =?us-ascii?Q?89Dtu5xkm+dSqBo44usqHyUqbwpZU9isNv0Uhl94kIJGbvype3bvwTGzHd0N?=
 =?us-ascii?Q?3DxsTexvW5ct2IYYDR/pyNvuvRSXNLv7Zr3pPfyC0507puyCTmPZ4HMNPxn/?=
 =?us-ascii?Q?ezktIGF3GAms8WYdh1qtounz50yrMyhGVhjVbn0DscSJzmu7+XD6VOSPcVLc?=
 =?us-ascii?Q?LRxzAwq/6vb1WKiQC/iEF/J1uSTM1xaAN+u3aGDMHuC2F5ygqv0jF7D2jBSc?=
 =?us-ascii?Q?jaHJ2bwzpm6jMcAMrPHRIjH+RU9go3V0tGjiHXqu6bpkmZdin9KoZz3W7nFk?=
 =?us-ascii?Q?p7xdfeZiBtaXcWrKdtzaLrXyToOiXgG7PUHgjLl0ipCtuGaiWD3VPfxBiNhR?=
 =?us-ascii?Q?m/9ab7ugsb55DaD8IfqbAfbg+f2+9+1ra/gniBIw8a2Cp+8AfbhqJwCiuFqW?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b27ac86-9a5f-43ce-95fb-08db78cd4116
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 18:18:36.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxZp88fRK3QWi8hpiLARobNTBWddN8x7FybUwDR/e+5+zGnFW6yishve95kGpbmL/opL6SnKL4P8Qo0klxztvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Jun, 2023 10:46:41 +0800 Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> The memory pointed to by the fs->any pointer is not freed in the error
> path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
> Fix by freeing the memory in the error path, thereby making the error path
> identical to mlx5e_fs_tt_redirect_any_destroy().
>
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index 03cb79adf912..9cf4ec931b8b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>  
>  	err = fs_any_create_table(fs);
>  	if (err)
> -		return err;
> +		goto err_free_any;
>  
>  	err = fs_any_enable(fs);
>  	if (err)
> @@ -606,7 +606,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>  
>  err_destroy_table:
>  	fs_any_destroy_table(fs_any);
> -
> +err_free_any:
>  	kfree(fs_any);
>  	mlx5e_fs_set_any(fs, NULL);

We probably should update the 'any' member reference in fs to NULL
*before* free-ing fs_any. Otherwise, there is a period in time where fs
is referring to a dirty pointer value in its any member field. It's not
critical, but it makes logical sense in my opinion. Lets swap these two
lines in this patch.

>  	return err;

Thanks for the patch,

-- Rahul Rameshbabu
