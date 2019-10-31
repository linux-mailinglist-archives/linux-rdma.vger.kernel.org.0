Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73003EB7B8
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 20:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfJaTFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 15:05:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34085 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfJaTFI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Oct 2019 15:05:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id 205so6833138qkk.1
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=peC8a8kfpR3pLLE7fnb6t9NGapelgqTRXDRhiNcpZWg=;
        b=WPPy8D9slqQkMFtE8vdJKhZe7LUSiMG0R9aNlmRqXoN2aw3kIqWO5UluQyuS8wsrre
         Z42Yl62t6/3WBxmdJYYXFqZJhhhAMCYTgBFbcWzNKpsRBaslfrWfhbHhDk/DYBS2ZNVW
         w6Rr+yVdihNED+4jHBCLSMpeCqHHkEyla31ldqsuaQ1JEFj2a107YUIuIXI0R60e9NhY
         LN7VyamEprwkZb6qpyHdwLMyxOdvN45bua3iHFKEF87QztSixr8VNdc3vN9hgJWGPyEg
         321hTbrTu6yVBZ9AYKMEL9wfIYUCo51JrIXiEmmLQacVlV3OBl4Y39NXNLwmRhu6yDj9
         l5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=peC8a8kfpR3pLLE7fnb6t9NGapelgqTRXDRhiNcpZWg=;
        b=AI0mlijatarr6W/NqdkpaNvmGytZWyNmRF79+6Y1hap/4XslAknw7LYoBEAiX7L//S
         3z8422YAOp+M1+MSqYZc2kBz56ral30WVhC1G81suPOO3+5omjA3s/UHUxnO29nrvNLh
         0GxPyCK9YHhVYFBCrk1tfSwiEyzxbyb7hzjPM8jGqEXuVAAykZCS6NPT7Hwy8WWMHRob
         0B1bycsahP5523bTT6br9TmI6r0+GpJjeufsFeXrI+lkYwBJvV4pR3YqXmdHRqefJlBk
         +2GjeB3W0hwjGeKAezueMcilphoqc4IiaT4jhDeXBIr7F3t6m/KoVpNt2J4WGyTvq+GC
         fWYQ==
X-Gm-Message-State: APjAAAV7Y+VrURAArUtPMoxd6JGhPw9EpkMwuuXtBDadPdVej5hzQNoC
        mbJuiUptj6YEksuHyI0lV4AIhg==
X-Google-Smtp-Source: APXvYqwL3a8qFLD9yRT9S+B9ql3/zy5Llx5HGFjfshV0wSBHmmn3XFpb1yGfqK+HlTFaI0ToMFTBeg==
X-Received: by 2002:a05:620a:6d4:: with SMTP id 20mr1402875qky.91.1572548705797;
        Thu, 31 Oct 2019 12:05:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u189sm2514719qkd.62.2019.10.31.12.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 12:05:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQFkm-0001ZC-Kx; Thu, 31 Oct 2019 16:05:04 -0300
Date:   Thu, 31 Oct 2019 16:05:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Message-ID: <20191031190504.GA5939@ziepe.ca>
References: <20191028134444.25537-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028134444.25537-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:44:44PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> IBTA declares QPN as 24bits, mask input to ensure that kernel
> doesn't get higher bits.
> 
> Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  * Not fully tested yet, passed sanity tests for now.
> ---
>  drivers/infiniband/core/ucma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 0274e9b704be..57e68491a2fd 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
>  	dst->retry_count = src->retry_count;
>  	dst->rnr_retry_count = src->rnr_retry_count;
>  	dst->srq = src->srq;
> -	dst->qp_num = src->qp_num;
> +	dst->qp_num = src->qp_num & 0xFFFFFF;
>  	dst->qkey = (id->route.addr.src_addr.ss_family == AF_IB) ? src->qkey : 0;
>  }

This really needs to be squashed into the other qpn patch because what
is really being proposed here is to move the masking from the core
code to the ucma and the core code will assume that the caller is
using correct QPNS. Maybe leave behind a WARN_ON to confirm this.

Jason
