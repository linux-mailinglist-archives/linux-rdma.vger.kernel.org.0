Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51251BDF86
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD2NuS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD2NuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Apr 2020 09:50:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1FC03C1AD
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 06:50:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l78so1964194qke.7
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUQndDA0pZv6pffi9b4yKooKJp8qnymGtdDgO0A5dR8=;
        b=B7V//DAk+HJH+h5BlrujbB56TatFsqD0eGxjoJdcgMTAltGNk9un3524yRd6jT5/h4
         xDbWxyTPuQtgiuZfgVnrdtUhZ8I1ZIewhQXlaubYB+aw6EjA4TPWer61Ht7NMQXfGn1Z
         fvkP4Vg75mPi712pOfLcQu0oR1nyOAxmbAAn8ZvZNSK/bhlAtBnPH/vlDewQWVjr8h2a
         yD1AkzfLvknHLfruaNZK3qwjW5l+yR5BfFYEH7qq4XAOA2Djocds9JDyG7vP0Tg8ZciG
         3TGLArLXF/9Eot/2MyhZbeOeXolmciX8fesRZUKQEaJNuPr0kzZ3sVqt3HyzqbUbWpj9
         cfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUQndDA0pZv6pffi9b4yKooKJp8qnymGtdDgO0A5dR8=;
        b=DL+oacF0AbMDEVElrjUR57yWensosX+33IN4DvXb302dsjfX8tCy7loyk+ILrB78Av
         dkbbQi6JdsA4svEV7rYqTRQML3bzbNxurkdsvOTglEIwe0fiY6CXdMKZuoHyQ76vaiRq
         Zb2OfmL7YdjXzWaB3hw5Uqe0MRAwIB9JYZ3Pvns0llExHSOl661wqY7Zigq+lhfw+vWe
         iJfjj+W4FcTc23+jWDHzk8Xg/RT3gnJcvqO2FnMhPdiAYnljPUvcLMdyvEe7eZlC7hO6
         bltL9mGLdPQxXvhjve2WFDq6d5DRywgT1pwPfuv8WmODNTJbZo8ZWm7RJLcAe3/l1Sth
         lrlA==
X-Gm-Message-State: AGi0PubhSBuSqpNQmvjIdYZPANsIP2yT5pjIt0RLjBDWcqNqmO7h9Qmq
        DtTICEdabLDJvb9vOfRL643p0Q==
X-Google-Smtp-Source: APiQypLdPh8dMCh3k45ND/bcy1sFK+2sgluJLt+WV8Rk268K7O9fl5MJUBAa3+4xewmcfuHP+mYosw==
X-Received: by 2002:a37:d93:: with SMTP id 141mr33366795qkn.32.1588168216487;
        Wed, 29 Apr 2020 06:50:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n4sm15431777qkh.38.2020.04.29.06.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 06:50:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTn6N-0004Px-3g; Wed, 29 Apr 2020 10:50:15 -0300
Date:   Wed, 29 Apr 2020 10:50:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Weihang Li <liweihang@huawei.com>,
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
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <20200429135015.GA26002@ziepe.ca>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
 <20200428000428.GP26002@ziepe.ca>
 <9a875620-3f11-22ee-b908-59c8e49e3b24@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a875620-3f11-22ee-b908-59c8e49e3b24@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 09:32:16AM -0400, Dennis Dalessandro wrote:
> On 4/27/2020 8:04 PM, Jason Gunthorpe wrote:
> > On Mon, Apr 27, 2020 at 05:55:57PM +0000, Saleem, Shiraz wrote:
> > > > Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating
> > > > ib_device
> > > > 
> > > > If the name of a device is assigned during ib_register_device(), some drivers have
> > > > to use dev_*() for printing before register device. Bring
> > > > assign_name() into ib_alloc_device(), so that drivers can use ibdev_*() anywhere.
> > > > 
> > > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > > >   drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
> > > >   drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
> > > >   drivers/infiniband/hw/cxgb4/device.c           |  2 +-
> > > >   drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
> > > >   drivers/infiniband/hw/efa/efa_main.c           |  4 +-
> > > >   drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
> > > >   drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
> > > >   drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
> > > >   drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
> > > >   drivers/infiniband/hw/mlx4/main.c              |  4 +-
> > > >   drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
> > > >   drivers/infiniband/hw/mlx5/main.c              | 18 +++---
> > > >   drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
> > > >   drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
> > > >   drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
> > > >   drivers/infiniband/hw/qedr/main.c              |  4 +-
> > > >   drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
> > > >   drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
> > > >   drivers/infiniband/sw/rxe/rxe.c                |  4 +-
> > > >   drivers/infiniband/sw/rxe/rxe.h                |  2 +-
> > > >   drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
> > > >   drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
> > > >   drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
> > > >   include/rdma/ib_verbs.h                        |  8 +--
> > > >   24 files changed, 95 insertions(+), 86 deletions(-)
> > > 
> > > I think you ll need to update siw driver similarly.
> > > 
> > > rvt_register_device should be adapted to use the revised device registration API.
> > > hfi1/qib also need some rework.
> > 
> > It is necessary to make such a big change? :(
> > 
> > > rvt_alloc_device needs to be adapted for the new one-shot
> > > name + device allocation scheme.
> > > Hoping we can just use move the name setting from rvt_set_ibdev_name
> > 
> > I thought so..
> > 
> 
> The issue is hfi1 calls into rvt_alloc_device() which then calls
> _ib_alloc_device(). We don't have the name set at that point. So the obvious
> thing to do is move the rvt_set_ibdev_name(). However there is a catch.
> 
> The name gets set after allocating the device and the device table because
> we get the unit number as part of the xa_alloc_irq(hfi1_dev_table) call
> which needs the pointer to the devdata.
> 
> One solution would be to pass in the pointer for the driver's dev table and
> let rvt_alloc_device() do the xa_alloc_irq().

Just do:

	ret = xa_alloc_irq(&hfi1_dev_table, &unit, NULL, xa_limit_32b,
			GFP_KERNEL);
        if (ret)
                return ERR_PTR(ret);

	dd = (struct hfi1_devdata *)rvt_alloc_device(sizeof(*dd) + extra,
						     nports, unit);
	if (!dd) {
		xa_erase(&hfi1_dev_table, unit);
		return ERR_PTR(-ENOMEM);
	}
	xa_store(&hfi1_dev_table, unit, dd, GFP_KERNEL);

Jason
