Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1160F216BDE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGLnG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGLnF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 07:43:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74173C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 04:43:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so28477914ilh.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lsu/JmmqI1l8nGeXazuhGWyEzHoJCmqUxYFjMhEkNko=;
        b=i+uZUxmOrdbhB7JG2/FYvPtY0M4JCUrspt7uqHk5+8meUkr64sulayr3CoAj+ZI+FJ
         jDJ94TP44D042wbU9K/wtMV3rir9ymNow0JZ5qbsL/sijDoYzaQuiWZi2CPgz2qvq4aq
         +vYFEuMWljpNShrk9SJ8o96Atm3N35tw5UDFCV4r1mUGLczuT1h2guNT+N26mfAOCR3y
         qn5U1X1/+jJLz7i1eirQNjJTYnR6DaNnOv7ybIzcMCpTN55Ht9CmLX/r/8ObyyDi55cZ
         wl3sJ4LAtlDuM7IqKsW71ryYa+U+SkeP41aMjzQgke6ymOebhfEQjsAowIbl9lbJ9fg5
         5P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsu/JmmqI1l8nGeXazuhGWyEzHoJCmqUxYFjMhEkNko=;
        b=oZagdpHekF2vrC8teM0fZRE8ligfJSKY+RHOQOAnTEXKMrbepdVzOvg+6h0S/FCRES
         fD1V/bl3qgRMA6DzuNutJcLnd0ATDcd56nERlWTQaaJY9qtGyYKBgD+hVITEoBqz7Fvx
         JOp3mWIEcxWuTd19Y5UI4KWuu1F18tuGRsL/fOO05Xpj7yfw/VkD1Y15XcazvV3x6mmq
         hqnBEaA+Oi3DH8DxEFdK46grVQbuS4bnv9j8WZOFmLs4s/54yzqVhVsuCj/GxI93EihW
         /2Rf1B2CMncfm1JmwBeecGfZtyXlwpp5GMcxZXTYg0WlQwIV/S2KgzH0UbaDsitQvAhR
         S11A==
X-Gm-Message-State: AOAM5323p0k2mcg062/UZdpb8BfvJWFaNSwIKyzUazx60Mz3TPJUuPYs
        Vv2YaclgcnTdWZHRHeJzB9ToOQ==
X-Google-Smtp-Source: ABdhPJzp4rcyAoGpxin2cbdYTf67Z0fXaEEhIKk1IQqyK3+JHBOhAznb134hSyYY7hiPKWgkoR8AXg==
X-Received: by 2002:a92:77d1:: with SMTP id s200mr33749680ilc.191.1594122184884;
        Tue, 07 Jul 2020 04:43:04 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y12sm12606881ilg.84.2020.07.07.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:43:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jsm07-005eJq-D0; Tue, 07 Jul 2020 08:43:03 -0300
Date:   Tue, 7 Jul 2020 08:43:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/mlx5: Use xa_lock_irqsave when access
 to SRQ table
Message-ID: <20200707114303.GY25301@ziepe.ca>
References: <20200707110612.882962-1-leon@kernel.org>
 <20200707110612.882962-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707110612.882962-2-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 02:06:10PM +0300, Leon Romanovsky wrote:
> Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")

This didn't introduce the bug, when things were converted to xarray it
already had the wrong spinlock type.

I'm surprised this is only been found now since it has been wrong for
years. Did something else change?

> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/srq_cmd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> index 6f5eadc4d183..be0e5469dad0 100644
> +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> @@ -82,12 +82,13 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
>  {
>  	struct mlx5_srq_table *table = &dev->srq_table;
>  	struct mlx5_core_srq *srq;
> +	unsigned long flags;
>  
> -	xa_lock(&table->array);
> +	xa_lock_irqsave(&table->array, flags);
>  	srq = xa_load(&table->array, srqn);
>  	if (srq)
>  		refcount_inc(&srq->common.refcount);
> -	xa_unlock(&table->array);
> +	xa_unlock_irqrestore(&table->array, flags);

This and other places can just be xa_lock_irq as we are not in an atomic
context here.
  
>  	return srq;
>  }
> @@ -644,6 +645,7 @@ static int srq_event_notifier(struct notifier_block *nb,
>  	struct mlx5_srq_table *table;
>  	struct mlx5_core_srq *srq;
>  	struct mlx5_eqe *eqe;
> +	unsigned long flags;
>  	u32 srqn;
>  
>  	if (type != MLX5_EVENT_TYPE_SRQ_CATAS_ERROR &&
> @@ -655,11 +657,11 @@ static int srq_event_notifier(struct notifier_block *nb,
>  	eqe = data;
>  	srqn = be32_to_cpu(eqe->data.qp_srq.qp_srq_n) & 0xffffff;
>  
> -	xa_lock(&table->array);
> +	xa_lock_irqsave(&table->array, flags);
>  	srq = xa_load(&table->array, srqn);
>  	if (srq)
>  		refcount_inc(&srq->common.refcount);
> -	xa_unlock(&table->array);
> +	xa_unlock_irqrestore(&table->array, flags);

This change isn't needed, the notifier is always called from an IRQ
context

Jason
