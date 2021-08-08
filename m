Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4374F3E39C0
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Aug 2021 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHHJDl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Aug 2021 05:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhHHJDk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Aug 2021 05:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 325E3606A5;
        Sun,  8 Aug 2021 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628413401;
        bh=1EneDM8JHs6MRxv0MlsGKD0BEOJSmiQpL+z5bxZlzcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmPhD2FNIWzXreWwaFLe67fyBiGxW2IOkn5Y70qbQnsvQTxqfHkvpkzj4f0PVErGa
         HJ+Kyr/03Tbpaut3VXCv9WmuQzXFPU/RFC6JSy9bnttCBQZCzgu4DoVBLBIuLnl63G
         yR97cy0mpa/4PqYN5jK2lxi6lepL2K1NwKA6SrBM0CAYR+Im6LsRWyGBFMSHgIwNNy
         7BCRywOinAqsjGbwG/DYFUCpg3u7ssbVUPKa6SSQ1F4YhfqC31G2TjdE42pD6PfXjq
         3zvSUnmfBW1+zPMitwLookKGLmw7aZI4z1jW57nMX7znNMVXQWXkUzSW29e5sYf89Y
         vxPJ6SfvwiQqQ==
Date:   Sun, 8 Aug 2021 12:03:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH v2 for-next 3/6] RDMA/rtrs: Fix warning when use poll mode
Message-ID: <YQ+d1Ssiw+G5THYe@unreal>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
 <20210806112112.124313-4-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806112112.124313-4-haris.iqbal@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 01:21:09PM +0200, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@ionos.com>
> 
> when test with poll mode, it will fail and lead to warning below:
> echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
> device_path=/dev/nullb2 nr_poll_queues=-1" |
> sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device
> 
> rnbd_client L597: Mapping device /dev/nullb2 on session bla,
> (access_mode: rw, nr_poll_queues: 8)
> WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447 ib_cq_pool_get+0x26f/0x2a0 [ib_core]
> 
> The problem is, when poll_queues are used, there will be more connections than
> number of cpus; and those extra connections will have ib poll context set to
> IB_POLL_DIRECT, which is not allowed to be used for shared CQs.
> 
> So, in case those extra connections when poll queues are used, use
> ib_alloc_cq/ib_free_cq.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index cd9a4ccf4c28..47775987f91a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1768,6 +1768,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
>  	strscpy(sess->s.sessname, str, sizeof(sess->s.sessname));
>  
>  	sess->s.con_num = con_num;
> +	sess->s.irq_con_num = con_num;
>  	sess->s.recon_cnt = recon_cnt;
>  	uuid_copy(&sess->s.uuid, uuid);
>  	spin_lock_init(&sess->state_lock);
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index ca542e477d38..9bc323490ce3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -228,7 +228,12 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
>  	struct rdma_cm_id *cm_id = con->cm_id;
>  	struct ib_cq *cq;
>  
> -	cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
> +	if (con->cid >= con->sess->irq_con_num)
> +		cq = ib_alloc_cq(cm_id->device, con, nr_cqe, cq_vector,
> +				 poll_ctx);
> +	else
> +		cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);

I see same "if (con->c.cid >= sess->s.irq_con_num)" checks when calling
to rtrs_cq_qp_create() that will take poll_ctx and convey it to create_cq().

Please take a look on nvme_rdma_create_cq() which does the same without
passing poll_ctx.

Thanks
