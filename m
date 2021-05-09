Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA71377652
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEIL2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 07:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhEIL2R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 07:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0963613D6;
        Sun,  9 May 2021 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620559634;
        bh=CUb6XiTslRMA++3a24z876mske8vyztssjU/uX+396M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCELK4X6eYcrylckqqzLn2B2KvDZyu7LMLGZG/VXeVZgBORBRI+5UOJeKlHJrx9RU
         Me0Ljrd4s99ew1zZ7y8sDS7LktbXprTgfYJNoXabQMwomoNZ6um6WNqdMv2qiP/MGA
         IG49rtocyyrS2CsftrGmUpBc1S+lUg2h95uAakSmXMwCHn+MIyVndmXuJmw00OJzlV
         FM6YiEFjl0Ong1yGXQxdQvKqEwpxbvELk2PSUIycOdxQT3j0BabPSOshadEJ+xyzCz
         LdkE5k5nlCmzjx5KasRTuf3ckhmmi0QOvMyfQbMjvcPCR8gGJUl/gQh3BDRreNjaGi
         h2yn5FGow6H8w==
Date:   Sun, 9 May 2021 14:27:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 04/20] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
Message-ID: <YJfHDvkc4BK7plTK@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-5-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503114818.288896-5-gi-oh.kim@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 03, 2021 at 01:48:02PM +0200, Gioh Kim wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> It was difficult to find out why it failed to establish RDMA
> connection. This patch adds some messages to show which function
> has failed why.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 3d09d01e34b4..df17dd4c1e28 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
>  	 * If this request is not the first connection request from the
>  	 * client for this session then fail and return error.
>  	 */
> -	if (!first_conn)
> +	if (!first_conn) {
> +		pr_err("Error: Not the first connection request for this session\n");
>  		return ERR_PTR(-ENXIO);
> +	}
>  
>  	/* need to allocate a new srv */
>  	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> @@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
>  	if (IS_ERR(srv)) {
>  		err = PTR_ERR(srv);
> +		pr_err("get_or_create_srv(), error %d\n", err);
>  		goto reject_w_err;
>  	}
>  	mutex_lock(&srv->paths_mutex);
> @@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  			mutex_unlock(&srv->paths_mutex);
>  			put_srv(srv);
>  			err = PTR_ERR(sess);
> +			pr_err("RTRS server session allocation failed: %d\n", err);
>  			goto reject_w_err;
>  		}
>  	}
>  	err = create_con(sess, cm_id, cid);
>  	if (err) {
> +		rtrs_err((&sess->s), "create_con(), error %d\n", err);
>  		(void)rtrs_rdma_do_reject(cm_id, err);

Unrelated to this change, but this (void) casting should be go.

Thanks

>  		/*
>  		 * Since session has other connections we follow normal way
> @@ -1865,6 +1870,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>  	}
>  	err = rtrs_rdma_do_accept(sess, cm_id);
>  	if (err) {
> +		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
>  		(void)rtrs_rdma_do_reject(cm_id, err);
>  		/*
>  		 * Since current connection was successfully added to the
> -- 
> 2.25.1
> 
