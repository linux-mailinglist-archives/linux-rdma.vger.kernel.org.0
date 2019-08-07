Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A762484BB5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfHGMfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:35:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37489 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGMfM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 08:35:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so65581695qkl.4
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5i6fTBDVLzIJhkDZo4O9K4KZ4wl04X7nsfhNuK90P8=;
        b=i/lDTCorsC6jeGAd9HeIo17qXpwYG2YfmVEVgQ+G+JHLa4VqPuZ+rUIErfAhVO0Qjn
         Jbg+OvwVvRy9Xx4XrRKDtpeQSTQcTDc2KQPIBxWaoGZmd+Ar2ie6ZLttkTA8v/t9CUik
         3GwSQcoAyPngsQjFSjwP3H2/AIWRb9AgUtkTXBwSPH2HESe3b3Ty4Fh0sZHzR6f0qSR1
         bI5YaF6Mff7N376pUALQSzgYEkGw30RmE6rFAbKsVWMO/045ioO9r0fIxTqQTaUdtwiC
         RDgj676UowozBgGc4TUpO+KoOv3SdR8wn+xT8yi7neAvRfeY9i5MGPEuXntr3ACu7gXc
         6UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5i6fTBDVLzIJhkDZo4O9K4KZ4wl04X7nsfhNuK90P8=;
        b=nBZoaqQm0F9N6fOSEEZi/eIPyWJNEDLMre7bMtOMxidIdZITJ8Tb4tlcmsdIC7YNEG
         PMTR0CRTyn10ppY6WqQxrV/Sc4gKAh5BG3h5Wf51Pp8G/UVbTKDmXiokc/E0vSoA18D2
         uodYOogS2y8T5dS6bhbqlM/WyruoUTm/Dhwjo75zG28DIDWZ8/amebPU7ZZXzBQdppQu
         J08M/vkrBD38VcoltI5Z2E4uNlyiow7jD/KUJR+zIDBdSQzH1H3w2fcXyeTMHAg0WQoO
         qLIezVLs5MmkF6qCTFJ+dMGd5czEJV5yDUzp0+4z+9oRUuXpNGwQNhCkV1ESp7Y7vhwl
         yx6A==
X-Gm-Message-State: APjAAAWsFA4ElVLYQ5QaMG+Q8iEKbBfRneG/sNLEOGJy6OogNjKOpVUF
        3B6sttunHI+m9TZi+6DmJQ7Peg==
X-Google-Smtp-Source: APXvYqw+5mqrpk7QIXfh8CebTWslLYto6KWAZSZYJycaEuJ+yx23LTk4SuCbKNOw2dCCEWHAn7S3cg==
X-Received: by 2002:a37:9307:: with SMTP id v7mr1121508qkd.495.1565181311727;
        Wed, 07 Aug 2019 05:35:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x10sm35522621qtc.34.2019.08.07.05.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:35:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvL9q-0001L4-Qx; Wed, 07 Aug 2019 09:35:10 -0300
Date:   Wed, 7 Aug 2019 09:35:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Message-ID: <20190807123510.GF1557@ziepe.ca>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20190807114406.GC1571@mellanox.com>
 <20190807121335.GC32366@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807121335.GC32366@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 03:13:35PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 07, 2019 at 11:44:16AM +0000, Jason Gunthorpe wrote:
> > On Wed, Aug 07, 2019 at 01:33:59PM +0300, Leon Romanovsky wrote:
> > > From: Erez Alfasi <ereza@mellanox.com>
> > >
> > > ODP type can be divided into 2 subclasses:
> > > Explicit and Implicit ODP.
> > >
> > > Adding a type enums and an odp type flag within
> > > ib_umem_odp will give us an indication whether a
> > > given MR is ODP implicit/explicit registered.
> > >
> > > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/umem.c    |  1 +
> > >  include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
> > >  include/uapi/rdma/ib_user_verbs.h |  5 +++++
> > >  3 files changed, 20 insertions(+)
> >
> > No for this patch, I've got a series cleaning up this
> > implicit/explicit nonsense, and the result is much cleaner than this.
> 
> It doesn't really clean anything, just stores implicit/explicit information.
> 
> >
> > This series will have to wait.
> 
> The information exposed in this series is already available in uverbs,
> so whatever cleanup will come, we still need to expose ODP MR type.
> 
> This patch is tiny part of whole series, why should we block whole
> series and iproute2?

This whole approach is really ugly, I even object to the very idea of
patch #1

The umem is an internal detail and should not be exposed out of the
driver for nldev to use.

Jason
