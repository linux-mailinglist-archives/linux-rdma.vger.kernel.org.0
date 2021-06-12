Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232163A4D34
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jun 2021 09:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFLHCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Jun 2021 03:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLHCt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Jun 2021 03:02:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54FFD61184;
        Sat, 12 Jun 2021 07:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623481250;
        bh=srCK2MugDaYFXWX/uWh3/DfgCIwl6gc0kEkdHZSXuxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsDf4xxh7kok4uIpF/Cj4hEBM6F/ddqqiJ4GL+XzkUQuSFEfg5d9PUhIdN3kjy/ow
         7RHpscUp3ZZPg7j7T4fL9YOhMfjFaYLfBZ1WRu1lUJSq5WcLqm+gvHTP2Dg1AwSFlk
         FeUemuAcTtZzQf7TCYjou6JD6cuGw574JSZkJMRo/JeCVXFksLc6k34nWkLbwmEfoN
         UvhR4ONa6cVdpqhgjnjIgTqFZfdJLAtaHXLzLXpvBZZNTQqgx8zIALIpQqqMWbnEvU
         Y+HBm20+YSt3qYQ3QWWhUC7PDoUSmVA/oEs3Bsk2gncTCvLhOzIfO5NIfZRryQ45nz
         SrQGBNStvgeKA==
Date:   Sat, 12 Jun 2021 10:00:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Jiaran Zhang <zhangjiaran@huawei.com>,
        Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH RESEND for-next] RDMA/hns: Solve the problem that
 dma_pool is used during the reset
Message-ID: <YMRbnjyO0VxhYojL@unreal>
References: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 05:35:56PM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> During the reset, the driver calls dma_pool_destroy() to release the
> dma_pool resources. If the dma_pool_free interface is called during the
> modify_qp operation, an exception will occur. The completion
> synchronization mechanism is used to ensure that dma_pool_destroy() is
> executed after the dma_pool_free operation is complete.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    | 24 +++++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> index 8f68cc3..e7293ca 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> @@ -198,11 +198,20 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
>  	if (!hr_dev->cmd.pool)
>  		return -ENOMEM;
>  
> +	init_completion(&hr_dev->cmd.can_free);
> +
> +	refcount_set(&hr_dev->cmd.refcnt, 1);
> +
>  	return 0;
>  }
>  
>  void hns_roce_cmd_cleanup(struct hns_roce_dev *hr_dev)
>  {
> +	if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
> +		complete(&hr_dev->cmd.can_free);
> +
> +	wait_for_completion(&hr_dev->cmd.can_free);
> +
>  	dma_pool_destroy(hr_dev->cmd.pool);
>  }

Did you observe any failures, kernel panics e.t.c?
At this stage, you are not supposed to issue any mailbox commands and if
you do, you have a bug in some other place, for example didn't flush
workqueue ...

Thanks

>  
> @@ -248,13 +257,22 @@ hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
>  {
>  	struct hns_roce_cmd_mailbox *mailbox;
>  
> -	mailbox = kmalloc(sizeof(*mailbox), GFP_KERNEL);
> +	mailbox = kzalloc(sizeof(*mailbox), GFP_KERNEL);
>  	if (!mailbox)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* If refcnt is 0, it means dma_pool has been destroyed. */
> +	if (!refcount_inc_not_zero(&hr_dev->cmd.refcnt)) {
> +		kfree(mailbox);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	mailbox->buf =
>  		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
>  	if (!mailbox->buf) {
> +		if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
> +			complete(&hr_dev->cmd.can_free);
> +
>  		kfree(mailbox);
>  		return ERR_PTR(-ENOMEM);
>  	}
> @@ -269,5 +287,9 @@ void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
>  		return;
>  
>  	dma_pool_free(hr_dev->cmd.pool, mailbox->buf, mailbox->dma);
> +
> +	if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
> +		complete(&hr_dev->cmd.can_free);
> +
>  	kfree(mailbox);
>  }
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 7d00d4c..5187e3f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -570,6 +570,8 @@ struct hns_roce_cmdq {
>  	 * close device, switch into poll mode(non event mode)
>  	 */
>  	u8			use_events;
> +	refcount_t		refcnt;
> +	struct completion	can_free;
>  };
>  
>  struct hns_roce_cmd_mailbox {
> -- 
> 2.7.4
> 
