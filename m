Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464B81B78B2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXO73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727021AbgDXO7Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 10:59:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46EC09B045
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 07:59:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so10356293qke.13
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xjYsVZHDw4SC9mlHBGyGF+E/ZmG6pBAai8JJNEZgwo=;
        b=RqZpI0DJw+Masz39wUHuq2qfwcTQSD++6RoeMqgZtIgRt3dD3mq3Gze65/Xa7ql2fT
         10ao9ncfQOG7CjkBKQbjuCW6Pmlg6vG7OY3bUdv2ItIjHXy8+RC/QT1BreXEmNloFZA6
         czM9v8WB7UByPJUzoDP8c9WYi/ZteN9UhRcuE23m1CJfyTbHpI50BjLDJS7FPvQDgzi3
         d4Tu/BA1g830RrM1lWK14gSX9W/LsGs+9yLQ2JPJGzwtuCRw4FzZoFZb7wiL2OfLqCUv
         abIpJcRVBi0vIEARA4EluhdSWyARiiq+UI7R5FVCIbaR9D8iF7WaNfO5xZA7wgzGVtxX
         Uceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xjYsVZHDw4SC9mlHBGyGF+E/ZmG6pBAai8JJNEZgwo=;
        b=J/edkZhtO1TR6RSVh3g9e4zm1fXnUN28hKpj1P76XZEQie+uJbUg1xiMsH2ieRK0Lg
         ZFfPkN+8AqgLie8QBqcmmIIBIRXU1VmC0LTYSrVjQXabEUKKw7cv7JXDkrvdUXJvxlxJ
         qNOgwD1nWFQ13PEvHb/gLZ18/I2xzDr/M3Tkj7r/rcmgoZgh7TkW1Kgug9Ibj7/2RtnY
         Nl2CN+ZVjBD8fkr4UllZBNnlV35/aAyzRlepUaW2T2GsTUOqu6bgU0cImen0/qIrsfBQ
         15cXPfiv//WZaoxCPkVS6ay3p9W+rMFQYmSvPO8Ez5b7SaTp6wmCw6H9m61qwSCIgyXw
         tazA==
X-Gm-Message-State: AGi0Pub7GUtn0T3LzApoL0DpxHvVLrG/7ZuO081oKiZYEtZr3heWiYWi
        ihSwVqbPcVEPs5iJtvoVCqBGdjSyimitsw==
X-Google-Smtp-Source: APiQypI3/SNNnjuVTqitJ0ZiAeWD0ZnpdfFgF58ANQ0c0LOpLwuhwzK2klofzI6skY/yjdLPuiPb+Q==
X-Received: by 2002:a37:404f:: with SMTP id n76mr9208471qka.442.1587740364761;
        Fri, 24 Apr 2020 07:59:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w42sm4123965qtj.63.2020.04.24.07.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 07:59:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRznX-0001LG-Nz; Fri, 24 Apr 2020 11:59:23 -0300
Date:   Fri, 24 Apr 2020 11:59:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 2/3] RDMA/efa: Count mmap failures
Message-ID: <20200424145923.GH26002@ziepe.ca>
References: <20200420062213.44577-1-galpress@amazon.com>
 <20200420062213.44577-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420062213.44577-3-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 20, 2020 at 09:22:12AM +0300, Gal Pressman wrote:
> Add a new stat that counts mmap failures, which might help when
> debugging different issues.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/hw/efa/efa.h       | 3 ++-
>  drivers/infiniband/hw/efa/efa_verbs.c | 9 +++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> index aa7396a1588a..77c9ff798117 100644
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_H_
> @@ -40,6 +40,7 @@ struct efa_sw_stats {
>  	atomic64_t reg_mr_err;
>  	atomic64_t alloc_ucontext_err;
>  	atomic64_t create_ah_err;
> +	atomic64_t mmap_err;
>  };
>  
>  /* Don't use anything other than atomic64 */
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index b555845d6c14..75eef1ec2474 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -44,7 +44,8 @@ struct efa_user_mmap_entry {
>  	op(EFA_CREATE_CQ_ERR, "create_cq_err") \
>  	op(EFA_REG_MR_ERR, "reg_mr_err") \
>  	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
> -	op(EFA_CREATE_AH_ERR, "create_ah_err")
> +	op(EFA_CREATE_AH_ERR, "create_ah_err") \
> +	op(EFA_MMAP_ERR, "mmap_err")
>  
>  #define EFA_STATS_ENUM(ename, name) ename,
>  #define EFA_STATS_STR(ename, name) [ename] = name,
> @@ -1569,6 +1570,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  		ibdev_dbg(&dev->ibdev,
>  			  "pgoff[%#lx] does not have valid entry\n",
>  			  vma->vm_pgoff);
> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
>  		return -EINVAL;
>  	}
>  	entry = to_emmap(rdma_entry);
> @@ -1604,12 +1606,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  		err = -EINVAL;
>  	}
>  
> -	if (err)
> +	if (err) {
>  		ibdev_dbg(
>  			&dev->ibdev,
>  			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
>  			entry->address, rdma_entry->npages * PAGE_SIZE,
>  			entry->mmap_flag, err);
> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);

Really? Isn't this something that is only possible with a buggy
rdma-core provider? Why count it?

Jason
