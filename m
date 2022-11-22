Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11F63355F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 07:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKVGen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 01:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVGem (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 01:34:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D402DD8
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 22:34:41 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGZBs37FpzqSPy;
        Tue, 22 Nov 2022 14:30:45 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:34:39 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:34:38 +0800
Subject: Re: [PATCH] RDMA/hns: fix memory leak in hns_roce_alloc_mr()
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        <linux-rdma@vger.kernel.org>, <liangwenpeng@huawei.com>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <liweihang@huawei.com>,
        <chenglang@huawei.com>, <wangxi11@huawei.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20221119070834.48502-1-shaozhengchao@huawei.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <719e15d3-cda0-ba0b-a749-47fab86c386e@hisilicon.com>
Date:   Tue, 22 Nov 2022 14:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221119070834.48502-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/11/19 15:08:34, Zhengchao Shao wrote:
> When hns_roce_mr_enable() failed in hns_roce_alloc_mr(), mr_key is not
> released. Compiled test only.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 845ac7d3831f..37a5cf62f88b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -392,10 +392,10 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  
>  	return &mr->ibmr;
>  
> -err_key:
> -	free_mr_key(hr_dev, mr);
>  err_pbl:
>  	free_mr_pbl(hr_dev, mr);
> +err_key:
> +	free_mr_key(hr_dev, mr);
>  err_free:
>  	kfree(mr);
>  	return ERR_PTR(ret);
> 

Thank you. For the patch:
Acked-by Haoyue Xu <xuhaoyue1@hisilicon.com>

Regards,
Haoyue
