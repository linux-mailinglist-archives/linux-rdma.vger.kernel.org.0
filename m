Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E65419417
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhI0MXw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234168AbhI0MXw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 08:23:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAF3860F41;
        Mon, 27 Sep 2021 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632745334;
        bh=G8Tpk5hzwgcU3mBH7Jk5m2DfSVLkzh6Vh8aRlFIdSIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiN4BK6WbKbVCD2XX7pWQ9Esr3jUzLFD+deJO88xN4dZ4bhiYurMl9wVDqT9wkUDY
         Pu7lLR3swqdS7hHGTjqqXfCo8LZlfY+tzqM4QsgBB1AHmVpBRvVTfAHhM1XjqHIzQH
         gHWT95763ipzi/bfzkxnmfwWRCCfJ8+lJjC+40Wv1zS4sf0nXMhaJllqP4wVaos3im
         1KV9v+xSeZqsysji0ztvAjs1Pz+imcavmqKpJGxGol00+5lR7TZZCRRQ75hnfW3nru
         gyP1v24UwqHEoxlLbHl+frBsSSpDOg6vmAg7eTNUO9EOKjGZqAhbsK5+kLjpZMalcn
         vsOqZQiYj+/Jw==
Date:   Mon, 27 Sep 2021 15:22:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
Message-ID: <YVG3cme0KX9CD4oh@unreal>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922125333.351454-7-haris.iqbal@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> Allowing these characters in sessname can lead to unexpected results,
> particularly because / is used as a separator between files in a path,
> and . points to the current directory.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
>  2 files changed, 11 insertions(+)

It will be safer if you check for only allowed symbols and disallow
everything else. Check for: a-Z, 0-9 and "-".

Thanks

> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index bc8824b4ee0d..15c0077dd27e 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
>  	struct rtrs_clt *clt;
>  	int err, i;
>  
> +	if (strchr(sessname, '/') || strchr(sessname, '.')) {
> +		pr_err("sessname cannot contain / and .\n");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
>  			ops->link_ev,
>  			reconnect_delay_sec,
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 078a1cbac90c..7df71f8cf149 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *con,
>  		return err;
>  	}
>  
> +	if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
> +		rtrs_err(s, "sessname cannot contain / and .\n");
> +		return -EINVAL;
> +	}
> +
>  	if (exist_sessname(sess->srv->ctx,
>  			   msg->sessname, &sess->srv->paths_uuid)) {
>  		rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
> -- 
> 2.25.1
> 
