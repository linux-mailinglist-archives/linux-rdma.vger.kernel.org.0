Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE0654BD0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLWDvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Dec 2022 22:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLWDvl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Dec 2022 22:51:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150B2BC1;
        Thu, 22 Dec 2022 19:51:38 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NdY9Y2GN6zmV6V;
        Fri, 23 Dec 2022 11:50:25 +0800 (CST)
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 23 Dec 2022 11:51:35 +0800
Subject: Re: [PATCH] RDMA/hns: Fix refcount leak in hns_roce_mmap
To:     Miaoqian Lin <linmq006@gmail.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yixing Liu <liuyixing1@huawei.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221220113047.1463078-1-linmq006@gmail.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <a7632fa8-450b-a0ba-2a5d-648017dcdbb0@hisilicon.com>
Date:   Fri, 23 Dec 2022 11:51:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221220113047.1463078-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Thank you. This patch is right. Could you change it to this form?

	default:
		ret = -EINVAL;
		goto out;
	}

	ret = rdma_user_mmap_io(uctx, vma, pfn, rdma_entry->npages * PAGE_SIZE,
				prot, rdma_entry);
out:
	rdma_user_mmap_entry_put(rdma_entry);
	return ret;

On 2022/12/20 19:30:47, Miaoqian Lin wrote:
> rdma_user_mmap_entry_get_pgoff() takes reference.
> Add missing rdma_user_mmap_entry_put() to release the reference.
> 
> Fixes: 0045e0d3f42e ("RDMA/hns: Support direct wqe of userspace")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 8ba68ac12388..fbff8df9236d 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -443,6 +443,7 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  		prot = pgprot_device(vma->vm_page_prot);
>  		break;
>  	default:
> +		rdma_user_mmap_entry_put(rdma_entry);
>  		return -EINVAL;
>  	}
>  
> 
