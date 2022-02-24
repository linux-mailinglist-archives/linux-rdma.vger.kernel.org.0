Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869084C2D41
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiBXNg0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiBXNgZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:36:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68CA178697
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90A3FB825CD
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BCC340E9;
        Thu, 24 Feb 2022 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709753;
        bh=8PK8PQJASAV7gN//NBaRgA9S7m08lwQlCoioZ3BnaEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=td5q4ifjUZBHwO8s6DgXNnLvR5RjySuNizuWzDrIeyopcXHHAMU+C2xRlITRTGobn
         HUqKb/zM47mTjzbb4pe6vVOGI0oNn07vBbtUaNL2Qs+43p0v20kcKiMl7PjMD38X5k
         mrZyYHqnhoDvUsDbZWrgK87sX8Cn5C/nez4NkLF0HkFQKautqUgzK8Hxz4J0bKxZ0m
         D5n1GXHn+TovuqpuXpVon3JsWntvB8aW/ToJJPUnGK5oiGU88eWNzIK1kC1OKc15eN
         6WcmzjC0n8Gmx3q6j8Gp1twmvCVyj4/Xi6IlHKtsG2+LZjev5Ys81GPO5wre6yJi46
         tmjq0ymUo/Vyg==
Date:   Thu, 24 Feb 2022 15:35:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 7/8] RDMA/hns: Refactor the alloc_srqc()
Message-ID: <YheJtTpU04bYtvNm@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-8-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-8-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:18PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Abstract the alloc_srqc() into several parts and separate the alloc_srqn()
> from the alloc_srqc().
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_srq.c | 80 +++++++++++++++---------
>  1 file changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
> index e316276e18c2..2613889a02ef 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_srq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
> @@ -59,40 +59,39 @@ static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
>  	}
>  }
>  
> -static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
> +static int alloc_srqn(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
>  {
> -	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
>  	struct hns_roce_ida *srq_ida = &hr_dev->srq_table.srq_ida;
> -	struct ib_device *ibdev = &hr_dev->ib_dev;
> -	struct hns_roce_cmd_mailbox *mailbox;
> -	int ret;
>  	int id;
>  
>  	id = ida_alloc_range(&srq_ida->ida, srq_ida->min, srq_ida->max,
>  			     GFP_KERNEL);
>  	if (id < 0) {
> -		ibdev_err(ibdev, "failed to alloc srq(%d).\n", id);
> +		ibdev_err(&hr_dev->ib_dev, "failed to alloc srq(%d).\n", id);
>  		return -ENOMEM;
>  	}
> -	srq->srqn = (unsigned long)id;
>  
> -	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
> -	if (ret) {
> -		ibdev_err(ibdev, "failed to get SRQC table, ret = %d.\n", ret);
> -		goto err_out;
> -	}
> +	srq->srqn = id;
>  
> -	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
> -	if (ret) {
> -		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
> -		goto err_put;
> -	}
> +	return 0;
> +}
> +
> +static void free_srqn(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
> +{
> +	ida_free(&hr_dev->srq_table.srq_ida.ida, (int)srq->srqn);
> +}
> +
> +static int hns_roce_create_srqc(struct hns_roce_dev *hr_dev,
> +				struct hns_roce_srq *srq)
> +{
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct hns_roce_cmd_mailbox *mailbox;
> +	int ret;
>  
>  	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>  	if (IS_ERR_OR_NULL(mailbox)) {

hns_roce_alloc_cmd_mailbox() never returns NULL, so the check should be IS_ERR()

Thanks

>  		ibdev_err(ibdev, "failed to alloc mailbox for SRQC.\n");
> -		ret = -ENOMEM;
> -		goto err_xa;
> +		return PTR_ERR(mailbox);
>  	}
>  
>  	ret = hr_dev->hw->write_srqc(srq, mailbox->buf);
> @@ -103,23 +102,42 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
>  
>  	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_SRQ,
>  				     srq->srqn);
> -	if (ret) {
> +	if (ret)
>  		ibdev_err(ibdev, "failed to config SRQC, ret = %d.\n", ret);
> -		goto err_mbox;
> -	}
>  
> +err_mbox:
>  	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
> +	return ret;
> +}
> +
> +static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
> +{
> +	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	int ret;
> +
> +	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to get SRQC table, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
> +		goto err_put;
> +	}
> +
> +	ret = hns_roce_create_srqc(hr_dev, srq);
> +	if (ret)
> +		goto err_xa;
>  
>  	return 0;
>  
> -err_mbox:
> -	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
>  err_xa:
>  	xa_erase(&srq_table->xa, srq->srqn);
>  err_put:
>  	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
> -err_out:
> -	ida_free(&srq_ida->ida, id);
>  
>  	return ret;
>  }
> @@ -142,7 +160,6 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
>  	wait_for_completion(&srq->free);
>  
>  	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
> -	ida_free(&srq_table->srq_ida.ida, (int)srq->srqn);
>  }
>  
>  static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
> @@ -390,10 +407,14 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
>  	if (ret)
>  		return ret;
>  
> -	ret = alloc_srqc(hr_dev, srq);
> +	ret = alloc_srqn(hr_dev, srq);
>  	if (ret)
>  		goto err_srq_buf;
>  
> +	ret = alloc_srqc(hr_dev, srq);
> +	if (ret)
> +		goto err_srqn;
> +
>  	if (udata) {
>  		resp.srqn = srq->srqn;
>  		if (ib_copy_to_udata(udata, &resp,
> @@ -412,6 +433,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
>  
>  err_srqc:
>  	free_srqc(hr_dev, srq);
> +err_srqn:
> +	free_srqn(hr_dev, srq);
>  err_srq_buf:
>  	free_srq_buf(hr_dev, srq);
>  
> @@ -424,6 +447,7 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
>  	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
>  
>  	free_srqc(hr_dev, srq);
> +	free_srqn(hr_dev, srq);
>  	free_srq_buf(hr_dev, srq);
>  	return 0;
>  }
> -- 
> 2.33.0
> 
