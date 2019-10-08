Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79777D0160
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfJHTob (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:44:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41829 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfJHTo2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:44:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so17927114qkg.8
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSsEZPTQg8l8YHZdSCh+wDFOVE+s2j+rzoUqLaEq18I=;
        b=OzqFClqJ6oekWe08HpZ7lmwfPfFobrg9AadnFY8oK7PaaIlIH0rAUm9i2CawAfgc4m
         Nj9pSyYBhYwKZXI+3TnOy1T6ePt0LeZKPCa77CdF5gyNKtO646l1GX+gaITloi2LlgnY
         V+rwz7eHyKQ90jF0kCvMoKakeeTxoDgrkzOl8S9STZ6/EV8g8SlIWXViBfvdO69E4hkQ
         LA1HvQhF/gp7ouwiNl1mr0jKo/e39ebJyaQfuUnm7Wn7OvoEh3rvpYF+qbynHr9HMhyT
         q9Edy2DfIQqhH5gxZv1xfg5FF+jG/EaWc0yQcWwqaOZTChL7veJR+1Qkl2GRz0M/jzlU
         9Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSsEZPTQg8l8YHZdSCh+wDFOVE+s2j+rzoUqLaEq18I=;
        b=LrK9auAYvMWl831SM28zBP7x34MzHBQZvTyxdusT+IZEzevOixUXx9jihiUbnNr79T
         1mRYpdRS/mWZPyKrVxS79kCNR3k80fOUVf240Tq/aORZjkDlSBARA4gAusHu4wZ1v7qi
         kBxhV05Te41wt1lWO+vwQKG9jOP06/nm6mcFTGFrOk0om8iPy3nubXTtljaN9COMHzsC
         KtwNzcuf+LykWJhu5InCRCz8G7JtP35OHQS+wMBxdGYVbvF1rzuvgzzjCzH0F87thrY+
         +x5n8HM9q6fcSnFLNuJAJ+GoK3oA6ai/oaIQUENvtHsxnX3bEEeb4fHkxFr/ZmKfN0cZ
         cboA==
X-Gm-Message-State: APjAAAUDiUjynQtfPjzmhVsDAhrEuDGBBUiesn7K9jwfg1IgE+9lDeYT
        OeivXsnjqfeoX9Vd0adoSvOIow==
X-Google-Smtp-Source: APXvYqw/ggbr2Q4jcHjWzNrBFlHgNFoE/rBMsjO/VvOM/kcybGO47TgrWijN4Abjyx3I7K4lrN1W0w==
X-Received: by 2002:a37:8104:: with SMTP id c4mr32348380qkd.367.1570563866533;
        Tue, 08 Oct 2019 12:44:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q5sm12672993qte.38.2019.10.08.12.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:44:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHvPF-0007Nn-DB; Tue, 08 Oct 2019 16:44:25 -0300
Date:   Tue, 8 Oct 2019 16:44:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] uverbs: prevent potential underflow
Message-ID: <20191008194425.GA28067@ziepe.ca>
References: <20191005052337.GA20129@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005052337.GA20129@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 05, 2019 at 08:23:37AM +0300, Dan Carpenter wrote:
> The issue is in drivers/infiniband/core/uverbs_std_types_cq.c in the
> UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE) function.  We check that:
> 
> 	if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {
> 
> But we don't check that "attr.comp_vector" whether negative.  It
> could potentially lead to an array underflow.  My concern would be where
> cq->vector is used in the create_cq() function from the cxgb4 driver.
> 
> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/uverbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 1e5aeb39f774..63f7f7db5902 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -98,7 +98,7 @@ ib_uverbs_init_udata_buf_or_null(struct ib_udata *udata,
>  
>  struct ib_uverbs_device {
>  	atomic_t				refcount;
> -	int					num_comp_vectors;
> +	u32					num_comp_vectors;
>  	struct completion			comp;
>  	struct device				dev;
>  	/* First group for device attributes, NULL terminated array */

I would have expected you to change struct ib_cq_init_attr ? Or at
least both..

This is actually a bug as the type of
UVERBS_ATTR_CREATE_CQ_COMP_VECTOR for userspace is u32:

        UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_COMP_VECTOR,
                           UVERBS_ATTR_TYPE(u32),
                           UA_MANDATORY),

But we are stuffing it into a int:

        ret = uverbs_copy_from(&attr.comp_vector, attrs,
                               UVERBS_ATTR_CREATE_CQ_COMP_VECTOR);

So very large values will become negative and switching
num_comp_vectors to u32 won't help??

Jason
