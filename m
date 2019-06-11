Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF923D49D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406097AbfFKRyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 13:54:21 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42873 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405972AbfFKRyV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 13:54:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id a97so3085556uaa.9
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsTFrOK7f1fRD8S/7eny+7GL1ftE9w2WFZP66ota90g=;
        b=D9nzSP3nm0xe/QXpQnu5Z04QjKhCIKA3DxKrM3G0cspp2n4ElOeDXazEVD5RFrMwUa
         f4AKQQS+h2BX1e5Jd8nMRzAJMNKL2RDxBoBKF8BI1c6cgiPNDhiJuCGsy6XekYSFzvVG
         Rq3lOa2M3bKnoHeiZa+RSby+zgqG91Ga4OymATgJOmLinlr6+1PxTNEmw4sS8eRTtBKL
         RxNITIIhLrbdhw8ICjz1DAz5Q3OeefuhMt9zz3jAP216TNtWJQmvlisaysinDMPMg+bk
         +ZiqrPvxDvI4ibVd2Bkpda2Ahx0qkjplBvn9tTc04l5+3y6RZuJD4ExX8PV3Z+TgZRzQ
         yNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsTFrOK7f1fRD8S/7eny+7GL1ftE9w2WFZP66ota90g=;
        b=H08X9E9UlX67hsHl1ftSQZo0lwIN3seUGRX44ksiHKurqip209lVYMVdT16KYY5O0j
         ZTabmrdrSPrbqkPKqLeCAtNs00zs6Ct+uS5F/QHxhZTFWJkN3A1kELmql/9yn9sYC/GD
         AFJ2h1YTB0AHCKfpx/vF8V7N8Py02gtcdjamACPPLh+u3UOtSxOihSnQL5VCYPQIMTTo
         e5KuEggT+rTTbur93PgWFZ9MikAmFk1OcMoMlExt39xLWS8zLW5OavwakegK2ZpqWlTe
         hGzNXHZ5N3+P0Gbh55S5RsRpxvvUdF58h0O+i/qaTi+2I2k5pLpJvEwdYnyDelH/ox9h
         7cjQ==
X-Gm-Message-State: APjAAAW3ld1eQUqNIIQ9hU3bj6oEWf9hlPD6wcHsBagRJ+oTiPFw46nc
        if/VuXwMjnon40A6TQu22TpW7Q==
X-Google-Smtp-Source: APXvYqyiJUAwl4okY4gsjHtOcrrZktxhxSrMgKtpg7Ex+oABcpBbtMlBvIN67W7A+O0mC9Kb1hZrPQ==
X-Received: by 2002:ab0:5ad0:: with SMTP id x16mr6169357uae.124.1560275660613;
        Tue, 11 Jun 2019 10:54:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j92sm3243692uad.2.2019.06.11.10.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 10:54:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hakyR-0005Af-E4; Tue, 11 Jun 2019 14:54:19 -0300
Date:   Tue, 11 Jun 2019 14:54:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Message-ID: <20190611175419.GA19838@ziepe.ca>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606105345.8546-10-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 01:53:37PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Add support for ib callbacks counter_bind_qp() and counter_unbind_qp().
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 53 +++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 8b7bcf8f68fb..66c94a060718 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -5533,6 +5533,57 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
>  	return num_counters;
>  }
>  
> +static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> +				   struct ib_qp *qp)
> +{
> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> +	u16 cnt_set_id = 0;
> +	int err;
> +
> +	if (!counter->id) {
> +		err = mlx5_cmd_alloc_q_counter(dev->mdev,
> +					       &cnt_set_id,
> +					       MLX5_SHARED_RESOURCE_UID);
> +		if (err)
> +			return err;
> +		counter->id = cnt_set_id;
> +	}
> +
> +	err = mlx5_ib_qp_set_counter(qp, counter);
> +	if (err)
> +		goto fail_set_counter;
> +
> +	return 0;
> +
> +fail_set_counter:
> +	mlx5_core_dealloc_q_counter(dev->mdev, cnt_set_id);
> +	counter->id = 0;
> +
> +	return err;
> +}
> +
> +static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
> +{
> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> +	struct rdma_counter *counter = qp->counter;
> +	int err;
> +
> +	err = mlx5_ib_qp_set_counter(qp, NULL);
> +	if (err && !force)
> +		return err;
> +
> +	/*
> +	 * Deallocate the counter if this is the last QP bound on it;
> +	 * If @force is set then we still deallocate the q counter
> +	 * no matter if there's any error in previous. used for cases
> +	 * like qp destroy.
> +	 */
> +	if (atomic_read(&counter->usecnt) == 1)
> +		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);

This looks like a nonsense thing to write, what it is trying to do
with that atomic?

I still can't see why this isn't a normal kref.

Jason
