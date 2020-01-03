Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239FB12FD51
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgACTzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:55:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36272 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgACTzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:55:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so35029457qkc.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCY4YU1eH+1UlfNCkb3OX3JUeC9TPIJMKWwKJzmuR6M=;
        b=StS9T+T1SjSPvVOZL/6emn0F3Zwgy8tfiINoixHog4eR2Xrh7rv24GYbhLCz6nQumL
         2uSlmWgr227sAVzxwDgppJKjSLnbG/mXwCIdMTqLSrLysBKSLyJQ+wcrQB4ZpjyxMHDA
         bYx+p0NqgbEomcU+UhCOJxpa8HiNvtUS8QCRAkImK9qV1KsXndz4BJ25rJVFgmM3FFR+
         8NhIo+kByXbF+NGDCmTkY6ptHcBVXs7WJ/omcBhdwD+ewKWSkrzDks7pvISZJs1kcdHr
         0KHSQ1d4UhttTCejI6gLzO27qnTWiHTBjYICEYc4cBtk4ZO0vc8XgNgbiI8z9y7QnA32
         /Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCY4YU1eH+1UlfNCkb3OX3JUeC9TPIJMKWwKJzmuR6M=;
        b=cduJgZkjYQWeyli/7fZenag1lqLc0Wn9G8OoDMEMnmI2NbrlbgJHPsWbGZSa8pCAcD
         F0B9Nf38DifxF3aQcnG6UZYl7qEnnYUSCmjrklQuBgAzW4H53qPe+D2UFL/B/H5SuL7j
         6srfY8QX2idkMceK8D2Auqs5LQq3nz8zCjj1pJUENqvGoF+UgOScok7mg4QylL5EGNJ+
         D1wn5C0CUQZCVn4Kg7duCIJDs93uaUwzRQsfCKVe1egrbWsJEE3wz6eYmnifXSpChFzv
         S61fP5J2dabbhKwoAvtVRkpZ3FipI0OtNLNWiHy+SblKL+dtBaOZQ/g/HuggXUY/7Cli
         sc/A==
X-Gm-Message-State: APjAAAVfhDjdMX7+5MQJ7tQvaP4Y57NOrw27Tw5mV/dQoOiuUBvBhvxM
        Gl3VzU4bEuDZxpmuN/8kfhYsBQ==
X-Google-Smtp-Source: APXvYqzG2wCotXsHknnWbILUDbHuuzQ5y91I3y2SOoWyGD8bRtagfuW5kufrAy+wG3heU2sk+ofrbw==
X-Received: by 2002:a05:620a:1183:: with SMTP id b3mr69419706qkk.316.1578081347908;
        Fri, 03 Jan 2020 11:55:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c84sm16973836qkg.78.2020.01.03.11.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:55:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inT2x-00078p-2Y; Fri, 03 Jan 2020 15:55:47 -0400
Date:   Fri, 3 Jan 2020 15:55:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
Subject: Re: [PATCH for-next v2] RDMA/siw: Simplify QP representation.
Message-ID: <20200103195547.GA27379@ziepe.ca>
References: <20191210161729.31598-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210161729.31598-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 05:17:29PM +0100, Bernard Metzler wrote:
> Change siw_qp to contain ib_qp. Use rdma_is_kernel_res()
> on contained ib_qp to distinguish kernel level from user
> level applications resources. Apply same mechanism for
> kernel/user level application detection to completion queues.
> 
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> Changelog:
> v1 -> v2: Use rdma_is_kernel_res() to detect
>           kernel level application.
> 
>  drivers/infiniband/sw/siw/siw.h       | 26 +++---------
>  drivers/infiniband/sw/siw/siw_cq.c    |  2 +-
>  drivers/infiniband/sw/siw/siw_main.c  |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 13 +++---
>  drivers/infiniband/sw/siw/siw_qp_rx.c |  6 +--
>  drivers/infiniband/sw/siw/siw_qp_tx.c |  2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c | 61 +++++++++++----------------
>  7 files changed, 42 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index b939f489cd46..2bf7a7300343 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -7,6 +7,7 @@
>  #define _SIW_H
>  
>  #include <rdma/ib_verbs.h>
> +#include <rdma/restrack.h>
>  #include <linux/socket.h>
>  #include <linux/skbuff.h>
>  #include <crypto/hash.h>
> @@ -209,7 +210,6 @@ struct siw_cq {
>  	u32 cq_put;
>  	u32 cq_get;
>  	u32 num_cqe;
> -	bool kernel_verbs;
>  	struct rdma_user_mmap_entry *cq_entry; /* mmap info for CQE array */
>  	u32 id; /* For debugging only */
>  };
> @@ -254,8 +254,8 @@ struct siw_srq {
>  	u32 rq_get;
>  	u32 num_rqe; /* max # of wqe's allowed */
>  	struct rdma_user_mmap_entry *srq_entry; /* mmap info for SRQ array */
> -	char armed; /* inform user if limit hit */
> -	char kernel_verbs; /* '1' if kernel client */
> +	bool armed; /* inform user if limit hit */
> +	bool is_kernel_res; /* true if kernel client */
>  };

I changed these bools into bool bitfields, and applied to for-next

Thanks,
Jason
