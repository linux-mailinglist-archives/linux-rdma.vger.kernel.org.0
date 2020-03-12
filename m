Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B060182FC7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCLMDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 08:03:06 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43846 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLMDF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 08:03:05 -0400
Received: by mail-qv1-f66.google.com with SMTP id c28so2422774qvb.10
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1Wdzvpjgq0rmXr47VZEoreiXSWsPwwFS/Fg+1mqi9I=;
        b=f6V4M7Hj/YKRgFvnQ0ip1pwXT/78X97E4YMfS3/VrzK3Dc9eizGIcR05Sb+2NADqtC
         j/ZGjHCtaX/0DSsBpUED0TJCcyC3MjcD/3wuKE/qrEiQ1roSL7/LFdD4HqGNG8CORa7u
         wJHJp6PcbrXDdqjM6PGcCeoy40bnT52dACFfAGtHnMWLDiAfAXgCsbzQmzRQAdrvzXEG
         CYKssZ+zrnfq6xM0TGQ5KhgU+rNcqPoUq5etc6Gb/HpoPEThuzHg2LbYr5PgS5IL7wK8
         AA3Mi7oUwJCp2UB7a00mC6qImnG6RV1wFF0P8IIxs1HsFz0srIM4/UAn+Pk27Wqdsel6
         DYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1Wdzvpjgq0rmXr47VZEoreiXSWsPwwFS/Fg+1mqi9I=;
        b=XnTnttkgkKCp5BqnOe9vLPN0wufxdU8ei0Xr6nzdR5pAN/Os5I+B7C/oCT0+jG5iz5
         Ub83QhaV27eL/BW7zzFlNYTBE4tiIZJE51cTFeiwGbhRqFK2GIKwzLMOwiN0zrdSxwUE
         8KsWiJ6pT7Rfw87x0/EAOPl/1GkUJMrGClkGERsOKVCrkm9l1Ia1TyW+2nDsRGGtW7Wt
         aE1F+XDTM209vhUvAmZS+cVCG1H5bAjxEENPJgvbuXOxy+P5BGy6cvmXxmhAp6Hj0AI5
         +hzZMLQ1AuTBsd0HzNPEtpQuF+T9IsjXRQqtPQWt9vIS0Es8Q1utR+d7jKvv1rAcMWFl
         n7oA==
X-Gm-Message-State: ANhLgQ2dPHJZ59ZZ+yptlzuQLQGdyqAl96UFI/cKvE6oMPq/wizfiCTE
        NjZ3uTt5rPZBLRGDxC/SR6iaGw==
X-Google-Smtp-Source: ADFU+vtcfzf9wRVww1Ak9MPTXQ7fpkzfVrarAblgpse0DpS7sRPucb1fwZUXlmxYkAKCsOzJdNKfCA==
X-Received: by 2002:a0c:ffd3:: with SMTP id h19mr6933623qvv.166.1584014582927;
        Thu, 12 Mar 2020 05:03:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w204sm14610945qkb.133.2020.03.12.05.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 05:03:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCMYG-0004u9-4k; Thu, 12 Mar 2020 09:03:00 -0300
Date:   Thu, 12 Mar 2020 09:03:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v10 13/26] RDMA/rtrs: include client and server modules
 into kernel compilation
Message-ID: <20200312120300.GJ31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-14-jinpu.wang@cloud.ionos.com>
 <20200311190313.GI31668@ziepe.ca>
 <CAHg0HuxHq7_hEkYjpT7-o9w3_T5WVvot2cGLnDp1_mB62Xd40Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0HuxHq7_hEkYjpT7-o9w3_T5WVvot2cGLnDp1_mB62Xd40Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 11:50:59AM +0100, Danil Kipnis wrote:
> On Wed, Mar 11, 2020 at 8:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Mar 11, 2020 at 05:12:27PM +0100, Jack Wang wrote:
> > > Add rtrs Makefile, Kconfig and also corresponding lines into upper
> > > layer infiniband/ulp files.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >  drivers/infiniband/Kconfig           |  1 +
> > >  drivers/infiniband/ulp/Makefile      |  1 +
> > >  drivers/infiniband/ulp/rtrs/Kconfig  | 27 +++++++++++++++++++++++++++
> > >  drivers/infiniband/ulp/rtrs/Makefile | 15 +++++++++++++++
> > >  4 files changed, 44 insertions(+)
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
> >
> > How is this using ib_devices without having a struct ib_client ?
> Hi Jason,
> 
> After we resolved address using rdma_resolve_add() we access the
> ib_device from rdma_cm_id. The ib_device has been registered on
> rdma_cm module load in cma_init(). The handle device removal through
> RDMA_CM_EVENT_DEVICE_REMOVAL.

Hmm.. I actually don't know if this flow works OK in rdma cm or not..

Actually I expect if I look at rdma cm, I'll find it is broken..

However, it does sound like a reasonable approach, so nothing to do
here.

Jason
