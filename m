Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28D813CC11
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 19:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgAOS1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 13:27:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33091 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAOS1X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 13:27:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so16645270qto.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQJ4n7Imvc45CINTxiOSO7su9csn5NiNHGyhEXcXKpA=;
        b=PWfe/8B1+aSqhrwQGQmtkMFUT5fR4OyKzUJlXMFoPW6bmaGMdbpBAwiMekAoGR486w
         ERc4rKwrgN8NhKWCPBemLfh3viO7WUy/r/66W2AwS/aF++kvAk9aZPNapJZQHYxw5UYA
         cZgjs4jOglZqmBlOdzNAWjL3jxc9OB7/kQ/RAQjEPACY9zWh+ZW5JW0LELCvHDOS8Zam
         6Tg95meXrJ9LlxsISeKrzyC3tzO+8TBa7I5Xd4eMfyCKBWE3vVh4fP3PJbNftkqzyGGa
         CaOKFDy3QlZ8YKYI57vmda7sHqIVjffIXbBjYqBTJIbwjxAViuNsjB8Q1v+L3jtTwCRi
         njTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQJ4n7Imvc45CINTxiOSO7su9csn5NiNHGyhEXcXKpA=;
        b=dI80N+p+yGtA4dc7rcYaSkt+MwodiZlbGjsLSE9fMGbjxEkSoj54oBJ0FaQkDo5VMz
         /ua+t5X2sHI57fAYaTgfiWHHAB7GzD17goOs1G0ZPVy+Ho+a3gJ3AGgz1ZMotHvEZDvh
         qVKsyFKHlBEjMw5+dgO6QXMBCcFjU0dLyiGba0I534BMtrxT1hDSQUsVwi5M56wKX8a6
         ypFAvhE63seD30idM58AJ56Lw646mULYzwZe05vpX9yEaPt8ER1CICxfQCoDV53OSdqI
         H2ZvaGpmf8DIfRKlWCpTGAJIG1PoRheHZQtwVMFqpgLenZTHfV3q9zRIYnFOhNzOJznH
         FgtA==
X-Gm-Message-State: APjAAAUc1AwBcVON/GfmEn5oLJ2JBmWamkPbuF4x8Dr1yhUR02F64Z2I
        bXQ/wjvEdsbItmdI666FULtoLg==
X-Google-Smtp-Source: APXvYqxrMZO9CYChw22Jq2odmveya/mceWiYXKXM3T17YYpGG0/8CHQp69lkNKDCSaawM8rHSVwKVw==
X-Received: by 2002:ac8:7586:: with SMTP id s6mr4834838qtq.309.1579112842544;
        Wed, 15 Jan 2020 10:27:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b24sm9783378qto.71.2020.01.15.10.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 10:27:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irnNx-000721-Kr; Wed, 15 Jan 2020 14:27:21 -0400
Date:   Wed, 15 Jan 2020 14:27:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rao Shoaib <rao.shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] SGE buffer and max_inline data must have same size
Message-ID: <20200115182721.GE25201@ziepe.ca>
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
 <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 13, 2020 at 04:41:20PM -0800, rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> SGE buffer size and max_inline data should be same. Maximum of the
> two values requested is used.
> 
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>  drivers/infiniband/sw/rxe/rxe_qp.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index aeea994..41c669c 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -235,18 +235,17 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  		return err;
>  	qp->sk->sk->sk_user_data = qp;
>  
> -	qp->sq.max_wr		= init->cap.max_send_wr;
> -	qp->sq.max_sge		= init->cap.max_send_sge;
> -	qp->sq.max_inline	= init->cap.max_inline_data;
> -
> -	wqe_size = max_t(int, sizeof(struct rxe_send_wqe) +
> -			 qp->sq.max_sge * sizeof(struct ib_sge),
> -			 sizeof(struct rxe_send_wqe) +
> -			 qp->sq.max_inline);
> -
> -	qp->sq.queue = rxe_queue_init(rxe,
> -				      &qp->sq.max_wr,
> -				      wqe_size);
> +	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
> +			 init->cap.max_inline_data);
> +	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
> +	qp->sq.max_inline = wqe_size;
> +
> +	wqe_size += sizeof(struct rxe_send_wqe);

Where does this limit the user's request to RXE_MAX_WQE_SIZE ?

I seem to recall the if the requested max can't be satisified then
that is an EINVAL?

And the init->cap should be updated with the actual allocation.

So more like:

        if (init->cap.max_send_sge > RXE_MAX_SGE ||
           init->cap.max_inline_data > RXE_MAX_INLINE)
            return -EINVAL;

	wqe_size = max_t(int, init->cap.max_sge * sizeof(struct ib_sge),
			 init->cap.max_inline_data)
                   sizeof(struct rxe_send_wqe);
	qp->sq.max_sge = init->cap.max_send_sge = wqe_size/sizeof(struct ib_sge);
	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
	wqe_size += sizeof(struct rxe_send_wqe);

Jason
