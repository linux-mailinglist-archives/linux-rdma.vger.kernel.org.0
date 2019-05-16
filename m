Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF2204EB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEPLhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 07:37:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39677 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLhv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 07:37:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so3419000qtk.6
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5I8+gomYdPGh4ATdNI379hsq1rbra0EBy8iG90Vy/mw=;
        b=PE8RIm0vlFjGsVRS9NlLNxLLyovoNzSK0Wdr/9KZcL0oTuFIkVE+NrahBeAmDeKPV6
         BFwj3zXmO/XkUVHWR/d+R83IqEyUIfQNhMfKVFQPGt6+l1QsMQZ9fOgHpLtA2MzLBjdA
         Idzh8XR4zSMGfh10EFohuTJ5LakCvHdv/B5xM9YsAuQj6/HdYHKVWRdrM34+2W6+gstn
         SxBJW+mV6Kn/qXVHWdrplrjd31OiH+VLuOR8grYfTxgXxEuoU1yFuFaNFMu1RNqzyNjh
         MLtn1qQ2E80Hi5Bq7kthAj5nnCQPb96JpkM3ZY81S+Aggyy8pamyXwdht0m5ScvDQKYq
         JcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5I8+gomYdPGh4ATdNI379hsq1rbra0EBy8iG90Vy/mw=;
        b=gzyilKYwqR44ui8gkyIYovCY8LxXA5iFmW6u3a10NJdf5r9QzHMQNzhWphBvhrExiE
         gs0VfJ3MU1sV48rcasPJcv5kEyIpXBk0A4jZsPd3zdEdDfVVZNavS+ggPK4OXYbRyD9h
         nKDGYne4qOlG9k9CU/F/MX4hxjwZ9o4NO0f8MXaaeTDEVbKEAxA2ixqX41HcYi+8DtZE
         E9p62eUWMCdOWRajU2jMEzfKwTbrDmtPYUmFPIvGhJ1DfBhPuqJoDf3RzN9psvoRw23c
         VdSf6RlEX0a6vwYoWdqI7x/gHE5AN5X32gU2HQDdDeVCGV8zM7d1ljoYUmPjgnnbLudR
         qPrQ==
X-Gm-Message-State: APjAAAXUZulYvg7QPpG6jd+mZpVVJDPIR9OhMQ7OraERryUFoUAWBx5t
        thm4OZuxArv/Svj2YN/QbXcstf4uh2U=
X-Google-Smtp-Source: APXvYqzMt+AsP5YDMPYBqYO0rennj0/pVREJivT//2rOjHkacDA7zRcs07TiNtNNSK12qi6IFdWNVw==
X-Received: by 2002:a0c:9baa:: with SMTP id o42mr40621375qve.184.1558006671047;
        Thu, 16 May 2019 04:37:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id k53sm2695201qtb.65.2019.05.16.04.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 04:37:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hREhq-0006SQ-3y; Thu, 16 May 2019 08:37:50 -0300
Date:   Thu, 16 May 2019 08:37:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190516113750.GB22587@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
 <20190516111607.GA22587@ziepe.ca>
 <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > For RoCE ports the call for ib_modify_port is not meaningful, so
> > > simplify the providers of RoCE by return OK in ib_core.
> > > 
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > >  drivers/infiniband/core/device.c              | 23 ++++++-----
> > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 -------------
> > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
> > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > 
> > We have more roce only drivers than this, why isn't everything
> > changed?
> > 
> > Jason
> 
> Not all of them implements modify_port().

Then why didn't we just delete modify port from the other drivers?

Jason
