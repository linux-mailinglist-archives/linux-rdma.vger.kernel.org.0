Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF61BB27E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 02:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1AEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 20:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgD1AEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 20:04:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6FC0610D5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 17:04:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so20041371qke.12
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7We4wQPfGVzbLfm2tt1UyuIbkpEYHuxn5M+03yD5qVU=;
        b=balZ31xu8iZwCBel899DYUkc7jPkKRXu1tyqZjRGfAN/hySXyZqDeeDxLNBy4y+sv4
         HQ7J7Vbi4hNNbLufrPEDhjwJW3IqQmBy94DJ9hBH/SzOmtecc6RpTTHkp/mXai3G4CyH
         lK5B/eqQ1kaJj7pnM2TWm8imNp6h2598I2vnvd4NZix6P8fN4FTx3tG9CzwpdCiPMswI
         BnyAOHk05O9Qgdcu79EXnV4aRu0JPdS4saovG4e8a76z8q+tzNJ4Y7K/7dWvWqn9SZXf
         YKctVUEczkjdVrhC+WsK/su1WTUIWgvSi6H0tECkeRtgk0kop9Lrh5uVT9+u6tKxXRWF
         TZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7We4wQPfGVzbLfm2tt1UyuIbkpEYHuxn5M+03yD5qVU=;
        b=DytEtLcAjcdqgVWGBfGIz65MWYSL27peblEc2p8afRp6w1WXWHMfMNNXrkRqCF8e91
         UZiVOaQkl0SzBZ9zPOQD81xVxWcBqWylKQtRuW9TXdOtMoHKhUOJgheLL+chXSFaXEwg
         qzFeLQjfe/0O9YBibIb/wcdmENMzVQs6H0qsXg6Gx/8QiyUt4tFAOgcrX5eU7oni8ZTa
         BEUq6evqnP8LWv0CUwgxOyKzjnygNjm5osY/Ps18ChLOjhujMZsnQXucn8Be3UeZ2WaL
         7e/QhltmkNteqjw2iKGwnmLNIBSnsvhIQb/ws2ojNLTXf2jxXi7QYOfkbPuZZpShSnbT
         h0Nw==
X-Gm-Message-State: AGi0PuaHvLSXKFbAX1urBh6V81ApmlAqgWhBe5TKpKqf/zKxXjFm3fd9
        qzY6j/VU/QYnf2ZhdUd7dG+feQ==
X-Google-Smtp-Source: APiQypJTjXxLkspO6C4IHnRhDdSK9ondxVkt3Wv8LOMlv+xJ5OX+kjjmMilCGdck3XAuyP5D0tek3g==
X-Received: by 2002:a37:63d4:: with SMTP id x203mr24331906qkb.391.1588032269224;
        Mon, 27 Apr 2020 17:04:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a27sm12839532qtb.26.2020.04.27.17.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Apr 2020 17:04:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTDjg-0002Kc-2u; Mon, 27 Apr 2020 21:04:28 -0300
Date:   Mon, 27 Apr 2020 21:04:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "devesh.sharma@broadcom.com" <devesh.sharma@broadcom.com>,
        "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "neescoba@cisco.com" <neescoba@cisco.com>,
        "pkaustub@cisco.com" <pkaustub@cisco.com>,
        "aditr@vmware.com" <aditr@vmware.com>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "markz@mellanox.com" <markz@mellanox.com>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <20200428000428.GP26002@ziepe.ca>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 05:55:57PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating
> > ib_device
> > 
> > If the name of a device is assigned during ib_register_device(), some drivers have
> > to use dev_*() for printing before register device. Bring
> > assign_name() into ib_alloc_device(), so that drivers can use ibdev_*() anywhere.
> > 
> > Signed-off-by: Weihang Li <liweihang@huawei.com>
> >  drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
> >  drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
> >  drivers/infiniband/hw/cxgb4/device.c           |  2 +-
> >  drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
> >  drivers/infiniband/hw/efa/efa_main.c           |  4 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
> >  drivers/infiniband/hw/mlx4/main.c              |  4 +-
> >  drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
> >  drivers/infiniband/hw/mlx5/main.c              | 18 +++---
> >  drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
> >  drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
> >  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
> >  drivers/infiniband/hw/qedr/main.c              |  4 +-
> >  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
> >  drivers/infiniband/sw/rxe/rxe.c                |  4 +-
> >  drivers/infiniband/sw/rxe/rxe.h                |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
> >  include/rdma/ib_verbs.h                        |  8 +--
> >  24 files changed, 95 insertions(+), 86 deletions(-)
> 
> I think you ll need to update siw driver similarly.
> 
> rvt_register_device should be adapted to use the revised device registration API.
> hfi1/qib also need some rework.

It is necessary to make such a big change? :(

> rvt_alloc_device needs to be adapted for the new one-shot 
> name + device allocation scheme.
> Hoping we can just use move the name setting from rvt_set_ibdev_name

I thought so..

Jason
