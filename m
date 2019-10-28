Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1713DE7221
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfJ1Mwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 08:52:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42868 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfJ1Mwf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 08:52:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so7710804qts.9
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vV5xcV2yh7wC8cTGDc9zmXj0xqv8jF6PvAOFPo9vYzQ=;
        b=oxFMnact3cJwEHovRsWtgif8DlVMaSUydZ6db7A7Wm9bjmCymOfjGGqkR+8X4CbKmh
         el/SgDcCNLa+NPy/3XnEsysvCQarYIYFTG/pMrLO03ilsx6yDSDDmgTzRIlHbz+AnBZY
         MPkh+MsfPv08cb/W4A7u/5uwbsl6p76g/EOsZOiu7rE3p+4hRrvErBzcp97688QNcz1P
         /LEbnEGvEYx1SgRLcUaHG/kLZ5eszxT0W7g9FaOYUmlfX74GBZ9EsoaF6/ZsfKhjTl2/
         H2gBb5iWVu2jPiKi6OjzaQF1eKeic6aYZwyl25/GQ26IntDi2eUvGj+Sb4PzQfigDWLd
         aK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vV5xcV2yh7wC8cTGDc9zmXj0xqv8jF6PvAOFPo9vYzQ=;
        b=hgfeok4qnqQ+Sg7bv925uHreS2CJAPMqbmRO97gF9KulARiniMTWqCcNaRoFcHxCLx
         RBQ70kMfSD0HBy9/Mcfz4Mij0Q2xtYXi9AFH2yyVRSs+rTfNeDjRv5FF2DzwqByW6kcX
         l/3dpiSj6v4+ezMBoxMUxL1NE96O/J3FSXCNOnKwTGNlKwJpIckvB4k+u6EYi5vdlaKy
         e9pbzUH3mIOfZELWrWEsFuGlvq2UzZxftYYfT7nvqUj1qacbLN0Jav9BYhS3NerJGzj4
         f+8nuqhmd5yvOtKericQvOeY+G8tHItwBUzriLuiJFWwIweakKGVtXFY/iIH+Axwe4Ix
         RDvA==
X-Gm-Message-State: APjAAAWovXfOwTQwxip/G0UU6gj8V4BZPlItNlTEKQ8jpDUhWGCVDtqg
        yP2JXaKywQdRR0MTNUtqYrIalA==
X-Google-Smtp-Source: APXvYqxUrgs23ConI3P5jiqJkANCvbA3sBRAVcv4Lj0lW74dfoaDnCGpoRofOiDdHItOBfaqjnUcoQ==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr11039351qtr.43.1572267154603;
        Mon, 28 Oct 2019 05:52:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v141sm6905898qka.59.2019.10.28.05.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 05:52:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP4Vd-0007Ci-Gz; Mon, 28 Oct 2019 09:52:33 -0300
Date:   Mon, 28 Oct 2019 09:52:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
Message-ID: <20191028125233.GA27317@ziepe.ca>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020071559.9743-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:15:57AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> QPN is supplied by kernel users who controls and creates valid QPs,
> such flow ensures that QPN is limited to 24bits and no need to mask
> already valid QPN.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 7ffa16ea5fe3..2eb8e1fab962 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -2101,7 +2101,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
>  	cm_id_priv->initiator_depth = param->initiator_depth;
>  	cm_id_priv->responder_resources = param->responder_resources;
>  	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
> -	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
> +	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);

It does seem like this value comes from userspace:

ucma_connect()
  ucma_copy_conn_param()
    	dst->qp_num = src->qp_num
  rdma_connect(.., &dst)
	if (!id->qp) {
		id_priv->qp_num = conn_param->qp_num;

vs

cma_accept_ib()
	rep.qp_num = id_priv->qp_num;

Maybe this needs to add some masking to ucma_copy_conn_param()?

Jason
