Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A01652BA5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Dec 2022 03:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiLUC6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 21:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLUC6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 21:58:42 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0EB1A22A;
        Tue, 20 Dec 2022 18:58:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VXnbglx_1671591517;
Received: from 30.221.97.245(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VXnbglx_1671591517)
          by smtp.aliyun-inc.com;
          Wed, 21 Dec 2022 10:58:38 +0800
Message-ID: <aefc7c5e-df05-9cfa-fa43-6a142d7cb527@linux.alibaba.com>
Date:   Wed, 21 Dec 2022 10:58:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] RDMA/erdma: Fix refcount leak in erdma_mmap
To:     Miaoqian Lin <linmq006@gmail.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220121139.1540564-1-linmq006@gmail.com>
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20221220121139.1540564-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/20/22 8:11 PM, Miaoqian Lin wrote:
> rdma_user_mmap_entry_get() take reference, we should release it when not
> need anymore, add the missing rdma_user_mmap_entry_put() in the error
> path to fix it.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Good catch, thanks.

Acked-by: Cheng Xu <chengyou@linux.alibaba.com>


> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 5dab1e87975b..9c30d78730aa 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -1110,12 +1110,14 @@ int erdma_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
>  		prot = pgprot_device(vma->vm_page_prot);
>  		break;
>  	default:
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto put_entry;
>  	}
>  
>  	err = rdma_user_mmap_io(ctx, vma, PFN_DOWN(entry->address), PAGE_SIZE,
>  				prot, rdma_entry);
>  
> +put_entry:
>  	rdma_user_mmap_entry_put(rdma_entry);
>  	return err;
>  }
