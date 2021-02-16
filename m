Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47F31C6FD
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBPHvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 02:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhBPHu7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Feb 2021 02:50:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A516364DDA;
        Tue, 16 Feb 2021 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613461818;
        bh=oLbYVR/7uQ2FOqhX3AoEMOEOlOVnZwG5sLX6yhmxPfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mt46m9zbQRwk5sHbbvHEkvhqjFSbNAx28VnsOSH+sockMI/Izt2nmd0WFBhxjLMsw
         F+s2nGbnxWPr3X31B0X2tUWBNzViHG4DIQXvM/3yBenBIr8M2/gB0wJGaDlomeX3sz
         TrrCPyXqBSA/Bfi/OVOL17Ps+zOOcBk/HXftzQHhC251SlNijZouQdUoH1By4eQ/uD
         0uRp7kUOa23vR5XuBMo7tS6BN8iPik52hArVz2vq6jV9Ildwdco/BrQKkf6QhxNLsE
         FDa+C2aC7KoD/jWqQ2NDSSBfQZjsFFuY3UTzvzB3QB0AQNigvOomQz4AXEaUcPIYSD
         U9lEfyMzkexxg==
Date:   Tue, 16 Feb 2021 09:50:14 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: suppress warnings passing zero to
 'PTR_ERR'
Message-ID: <YCt5Nv+czQtYqQL9@unreal>
References: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 08:39:58AM +0100, Jack Wang wrote:
> smatch warnings:
> drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
>
> Smatch seems confused by the refcount_read condition, so just
> treat it seperately.
>
> Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index eb17c3a08810..2f6d665bea90 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1799,12 +1799,16 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  	}
>  	recon_cnt = le16_to_cpu(msg->recon_cnt);
>  	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> +	if (IS_ERR(srv)) {
> +		err = PTR_ERR(srv);
> +		goto reject_w_err;
> +	}
>  	/*
>  	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
>  	 * allocate srv, but chunks of srv are not allocated yet.
>  	 */
> -	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> -		err = PTR_ERR(srv);
> +	if (refcount_read(&srv->refcount) == 0) {

I would say that "list_add(&srv->ctx_list, &ctx->srv_list);" line in the
get_or_create_srv() is performed too early, relying on zero in the refcount
doesn't look great.

Thanks
