Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89A7689EE
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 04:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjGaCSy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGaCSx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 22:18:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4719C;
        Sun, 30 Jul 2023 19:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MJVYuhAb1PMeAMctMHtXz002wNdYX1zjbVlmQqllQe4=; b=TnyTZSp2ZbZx6j7bnbvUtBogDV
        jsU/iP8GxRvnlqA6920VzFiGmbpqFdjQu6BHb2j5jhzXi46SMJGdfj00NN1cQYkJ0BlevyxEjeLuS
        7ln/SLHPWK84DaOS33gme+N0iV1eOfDAX3Neyuca7anE15X02uljDKt5jN7tlx+z+Qyw8OKljGiUA
        FwJjsaXzG00KlcLm8yKk/Q5YyOUxVXJJzhjRot+UnNsbsM7myKFooT6JuMm0MzX0C+b16oG3bcKFc
        6XweI7aFBgMI4ygAkIl3qJghoKOywiBCotbJRYt3CjGkI/txs+mwMW+EZfvsWvKbKFD79CCU+k+Y/
        F0iWl4AA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQIUf-00DVVk-0R;
        Mon, 31 Jul 2023 02:18:45 +0000
Message-ID: <2f743117-f0a7-9eec-ac8c-53c2468057ad@infradead.org>
Date:   Sun, 30 Jul 2023 19:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] RDMA/irdma: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Abaci Robot <abaci@linux.alibaba.com>
References: <20230731015915.34867-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731015915.34867-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/30/23 18:59, Yang Li wrote:
> Remove description of @free_hwcqp in irdma_destroy_cqp().
> to silence the warning:
> 
> drivers/infiniband/hw/irdma/hw.c:580: warning: Excess function parameter 'free_hwcqp' description in 'irdma_destroy_cqp'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6028
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/infiniband/hw/irdma/hw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index eaf196985f49..7cbdd5433dba 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -571,7 +571,6 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
>  /**
>   * irdma_destroy_cqp  - destroy control qp
>   * @rf: RDMA PCI function
> - * @free_hwcqp: 1 if hw cqp should be freed
>   *
>   * Issue destroy cqp request and
>   * free the resources associated with the cqp

-- 
~Randy
