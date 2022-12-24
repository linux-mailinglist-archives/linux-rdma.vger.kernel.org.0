Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A246556DC
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Dec 2022 02:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiLXBWm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 20:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLXBWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 20:22:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2213CE2;
        Fri, 23 Dec 2022 17:22:39 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nf5qL6MzRzJqdH;
        Sat, 24 Dec 2022 09:21:34 +0800 (CST)
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Dec 2022 09:22:36 +0800
Subject: Re: [PATCH v2] RDMA/hns: Fix refcount leak in hns_roce_mmap
To:     Miaoqian Lin <linmq006@gmail.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yixing Liu <liuyixing1@huawei.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221223072900.802728-1-linmq006@gmail.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <2399c7f2-61bf-de85-28dc-ad8fe89ea671@hisilicon.com>
Date:   Sat, 24 Dec 2022 09:22:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221223072900.802728-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/12/23 15:29:00, Miaoqian Lin wrote:
> rdma_user_mmap_entry_get_pgoff() takes the reference.
> Add missing rdma_user_mmap_entry_put() to release the reference.
> 
> Fixes: 0045e0d3f42e ("RDMA/hns: Support direct wqe of userspace")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> change in v2:
> - use goto label to manage the release.
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 8ba68ac12388..946ba1109e87 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -443,14 +443,15 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  		prot = pgprot_device(vma->vm_page_prot);
>  		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
>  	ret = rdma_user_mmap_io(uctx, vma, pfn, rdma_entry->npages * PAGE_SIZE,
>  				prot, rdma_entry);
>  
> +out:
>  	rdma_user_mmap_entry_put(rdma_entry);
> -
>  	return ret;
>  }
>  
> 

Thank you. For the patch:
Acked-by Haoyue Xu <xuhaoyue1@hisilicon.com>

Regards,
Haoyue
