Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF24C5EA80
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCRcJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 13:32:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40378 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRcJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 13:32:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so4602506qtn.7
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUTBg9L/T43a75q7/k9LSYq+FZ7PK2ujIg6IXIgWCWg=;
        b=IB/gQuwPL24eJFfmxzZDzOj6SgXQ9wFHhOA94R1+q+N+rW7BTdcJFvleZ8+KhYCLcg
         N2dYX+HUcj+iLsL2D/rYcwJ2Bt1M8lmF8WnL5s8rZCYw/PkQp/VX2eb3OuvfYZp2WNZi
         1+8OMtLMUNyRHUM4BbZr5ZmFIg8m7bCpmk2Km3q8uNggJwbmqxQEX8F47Vt1UP+/UZ41
         uSaFFdwn8kOAm3GaNQ498qqYIetHIQymJgVtslcyi+65XemToXmNfkg9dr3owe+IVEk7
         Q+tWBnwQ0wBOtaHZqjUT3ga3GFO1COwj9uaJAGcbNrjgsyNJbuDLJxT2ypPG+E0Awev4
         kVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUTBg9L/T43a75q7/k9LSYq+FZ7PK2ujIg6IXIgWCWg=;
        b=U1/EPxIXN5DWl8GP9VX4bkeLic8oqXk+Gy1+kHtCzs3U4yAUKRHZO0Jl4ZtwSSu2SU
         QIQrpKTq9SADTchxFTBwC2wz0DoqA0AbYBQyWV3e7yipLMnHtuDF/4azrNwb34AUrfby
         /KoNhscRY381mCBrD0OdgDhBWFQqKJAmDpsSZkkFQWLDf2hrH0s3uTW4NlZKT5FENjQz
         FLlcUTcASksJ4O0WBDAD6CI7CnQejMQxZ+4xPvTBrEep0X3bD8gmAkN1eswwHExsr4gq
         HlapqpS7vYRIy9GA1R/3/lsSyHJ7jZb4qaDvN8KyfHwZPn7+U1sGnWz91W0g0WTv/VIj
         DP1g==
X-Gm-Message-State: APjAAAXJ8otOBSe4RuqNYUd/EY4wP+OsmJbhpeGdyKs48rWroWDZuwcD
        4AbEseCu6vbpFfpi+/x61LIrUA==
X-Google-Smtp-Source: APXvYqz0xBfXdBw9BpScRLZ33MAmFJzNtbyFZbj07iqg/UuZi+78tz+nEusdRi7mimxV63JOVZTZvA==
X-Received: by 2002:ac8:3325:: with SMTP id t34mr31878426qta.172.1562175128474;
        Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o17sm1092794qkm.6.2019.07.03.10.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:32:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hij71-0002nd-CC; Wed, 03 Jul 2019 14:32:07 -0300
Date:   Wed, 3 Jul 2019 14:32:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Parav Pandit <parav@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Aaron Knister <aaron.s.knister@nasa.gov>,
        Denis Drozdov <denisd@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/27] infiniband: remove unneeded memset
Message-ID: <20190703173207.GA10729@ziepe.ca>
References: <20190628024723.15257-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628024723.15257-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 10:47:19AM +0800, Fuqian Huang wrote:
> pci_alloc_consistent calls dma_alloc_coherent directly.
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
> So the memset after these 3 function calls is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb3/cxio_hal.c        | 3 ---
>  drivers/infiniband/hw/cxgb4/cq.c              | 1 -
>  drivers/infiniband/hw/cxgb4/qp.c              | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 3 ---
>  drivers/infiniband/hw/mthca/mthca_allocator.c | 2 --
>  drivers/infiniband/hw/nes/nes_verbs.c         | 3 ---
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c      | 3 ---
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c       | 1 -
>  9 files changed, 18 deletions(-)

Thanks, applied to rdma for-next

> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index aa9dcfc36cd3..c59e00a0881f 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
>  		ret = -ENOMEM;
>  		goto err_tx;
>  	}
> -	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
>  
>  	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
>  	memalloc_noio_restore(noio_flag);

I dropped this hunk and used the seperate patch since this has nothing
to do with dma_alloc_coherent.

Jason
