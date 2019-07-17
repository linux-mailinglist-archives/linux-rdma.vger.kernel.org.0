Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812EF6BBEF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGQLx4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 07:53:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44357 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQLxz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 07:53:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so22902715qtg.11
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iKP7Oqv0B09hxBqnnuswVhE5SrGFXYTIj6JSY10OutA=;
        b=ixlmq5UCyVGtZFXD5RQ0V43N/+GVBcD+eTUl/pB6DQIeN8nFxYgtom0Ygi8iwE+nWP
         O/FtoAsMz6ZPbmQyj3tSoHw7ZzdIxAs5J8PtCqK3KZ2S8aoqEteUbsRVDLiuP3Ok8gYo
         jI1Z4nvmontHWkvclPn4RC6gaKbzuayVZqkHLo4YATfBEmeDJn19uKXl4BmlfaY1tlB6
         V+9evJchspl/qcK7cYBQGLJBweQx8PQsMnhmwPVnSXclGPiO+nGS8j2duYeCUGG4fudB
         Qi5EzJYZEZr5mWfLaPyHczgyHK8nra7HzG+vlEgYXwYHe7otvcwKPr2idQblJbHm50ih
         /18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKP7Oqv0B09hxBqnnuswVhE5SrGFXYTIj6JSY10OutA=;
        b=NbOz60zDk/iEJDGZrwvA53s6z5ohUBU/iBjqdzMbIecU7Z+rBY5RBEzWn9BM6N+hYI
         FV82Y+oxo6fNbb3k8dYJ4+cMIDn73IXkWAZ7FxGUXknHm1m4bE6HhIiL9RoDOYeKbJJU
         L8EgpgD9BmHoUyXfM0iTvigJ3WVlvE5hdeMLVwyK5EFJGcHk5tSIgwsCimgwzNlvOS7U
         pnfty32t1WPWwZNXQzpOVFVCDy78phqo6W3v7wDub6oqlKgpRCNq4vX3pNfzgd67/z72
         19kYITUoLsbYODjmacm1rkE+U7GqaPUsbKt7bv5lW+ZZRDSqyLVXLguXcGUqAypttiRc
         f7pA==
X-Gm-Message-State: APjAAAVSytKa4eNJbI+jYnkIUga2dwCqE3YdKL18xLJ0gRZWj+QKifga
        C2STrTwg/k4Gqhw2MyUqeeOPjQ==
X-Google-Smtp-Source: APXvYqyclZw7PHgwGk5QzSm59coNb2PtBjloRhMKGql6SaKx1GPNVx6lLbJ0s7hY1WiyJ0KCPNjyRg==
X-Received: by 2002:ac8:34aa:: with SMTP id w39mr27852382qtb.118.1563364435072;
        Wed, 17 Jul 2019 04:53:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b202sm10772187qkg.83.2019.07.17.04.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:53:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hniVO-0003TM-2K; Wed, 17 Jul 2019 08:53:54 -0300
Date:   Wed, 17 Jul 2019 08:53:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, monis@mellanox.com,
        parav@mellanox.com, danielj@mellanox.com, kamalheib1@gmail.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        shamir.rabinovitch@oracle.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717115354.GC12119@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716181200.4239-9-srabinov7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 16, 2019 at 09:11:43PM +0300, Shamir Rabinovitch wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> 
> ufile (&ucontext) with the process who own them must not be released
> when there are other ufile (&ucontext) that depens at them.

We already have a kref, why do we need more? Especially wrongly done
refcounts with atomics?

Trying to sequence the destroy of the ucontext seems inherently wrong
to me. If the driver has to link the PD/MR to data in the ucontext it
can't support sharing.

> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
>  drivers/infiniband/core/rdma_core.c   | 29 +++++++++++++++++++++++++++
>  drivers/infiniband/core/uverbs.h      | 22 ++++++++++++++++++++
>  drivers/infiniband/core/uverbs_cmd.c  | 16 +++++++++++++++
>  drivers/infiniband/core/uverbs_main.c |  4 ++++
>  4 files changed, 71 insertions(+)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 651625f632d7..c81ff8e28fc6 100644
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -841,6 +841,33 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
>  	ufile->ucontext = NULL;
>  }
>  
> +static void __uverbs_ufile_refcount(struct ib_uverbs_file *ufile)
> +{
> +	int wait;
> +
> +	if (ufile->parent) {
> +		pr_debug("%s: release parent ufile. ufile %p parent %p\n",
> +			 __func__, ufile, ufile->parent);
> +		if (atomic_dec_and_test(&ufile->parent->refcount))
> +			complete(&ufile->parent->context_released);
> +	}
> +
> +	if (!atomic_dec_and_test(&ufile->refcount)) {
> +wait:
> +		wait = wait_for_completion_interruptible_timeout(
> +			&ufile->context_released, 3*HZ);
> +		if (wait == -ERESTARTSYS) {
> +			WARN_ONCE(1,
> +			"signal while waiting for context release! ufile %p\n",
> +				ufile);

????

Jason
