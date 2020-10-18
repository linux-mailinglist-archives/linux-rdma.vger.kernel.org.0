Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533702916E5
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Oct 2020 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgJRKQc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Oct 2020 06:16:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18555 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgJRKQc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Oct 2020 06:16:32 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8c15a30000>; Sun, 18 Oct 2020 03:15:00 -0700
Received: from [172.27.1.130] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 18 Oct
 2020 10:16:13 +0000
Subject: Re: [PATCH] RDMA/core: Fix error return in _ib_modify_qp()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>, <leon@kernel.org>, <maorg@mellanox.com>,
        <parav@mellanox.com>, <galpress@amazon.com>, <monis@mellanox.com>,
        <chuck.lever@oracle.com>, <maxg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201016075845.129562-1-jingxiangfeng@huawei.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <fbca7f4d-aad5-8b0b-89fc-f87caf873828@nvidia.com>
Date:   Sun, 18 Oct 2020 13:16:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201016075845.129562-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603016100; bh=xu20L7kd47iKzkXqoWHQBgj12XJ/iPczDhZM1gwB/aA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=dn1NfZXiLUInfRQl6NLYPUld3LzjhhDwHWZXxP6iiXjjtE8h9Lc0NWqW0C0DJmQMO
         FB/q91afg4sMCUtknyc3rA1jhv/pnv4bI3wJOAYAa1WnG5Va2JwLb95x8m/ykypgce
         T1mY1a5n0PPTaYDW6k7YJylqeYeh8dQ37DJFnlj/Mpcs01MxOdN/RLPfgMHeApZfKf
         Je9Kh7hL+3OsvgQYJles4ZX1ESql12ZMHYNJ3AolyXPYt+unINcXwPO1AeM3xgxEf5
         sPssKpPC7bqeelfVyKyjDOMSloIZrq8vcEENbqWz7/vKiIVFlgpel5jfkDGZXrzD6X
         En5DSo47bvhTg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/16/2020 10:58 AM, Jing Xiangfeng wrote:
> Fix to return error code PTR_ERR() from the error handling case instead of
> 0.
>
> Fixes: 51aab12631dd ("RDMA/core: Get xmit slave for LAG")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>   drivers/infiniband/core/verbs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 307886737646..bf63c7561e8c 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1685,8 +1685,10 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
>   			slave = rdma_lag_get_ah_roce_slave(qp->device,
>   							   &attr->ah_attr,
>   							   GFP_KERNEL);
> -			if (IS_ERR(slave))
> +			if (IS_ERR(slave)) {
> +				ret = PTR_ERR(slave);
>   				goto out_av;
> +			}
>   			attr->xmit_slave = slave;
>   		}
>   	}

Looks good,
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>

