Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313AE16B94
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEGTnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:43:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43559 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:43:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so10612935qtp.10
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ee/vWvn/Ifzj7Fj8CJW5WypvdZbF3rI74RwswfNy3s8=;
        b=SlqXQH6cdfmDcoXK151NvgNOEL8C9rtVLRGZYegxJ5pRaiMErghgNSEUNcm8XOgnBm
         Q7Olw9WbgFBUGU2iDCkwi5y4P6LbPvssY/y8G7sAy2o/IDwVIW3UNJk3oNH5uTnEQBe6
         xnWNiXRxQs3KTm02xrq9ERvEvl5ab/N6pff2NY2lmzVtA6niaZiWeWugHSt5nXVR8rAP
         HfJg3A/UXegsz8XhYGpG7nzAqlNS2FaltaSNlZrWib25/KUPpoCEj3wQ43V8sDx7W81w
         TwgyJAj04iwS6mmd+p6VlrrTRvtd2PQDCDNh26OQvcQ/YuDQgItrhSo51NDIJloaDsLp
         l6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ee/vWvn/Ifzj7Fj8CJW5WypvdZbF3rI74RwswfNy3s8=;
        b=eqdFcd0vYi7Sb/0OOGbfYIjYOzVNNbieFj1aHem3dRo0Sue2N+EUIY5Q2v6lmCrDuP
         LxjB+0OtVoqGw53BTPxEJt6bS/yEI8NVJziaIWqUno3i9mOPKk90njT12Z0j0N/7NuMH
         sk9Hrb5wtGKTWGqLUjhPD/iAG+L3i4D5cFOkK9gEe3ZGXetCPl3DWhcYLw/yAz1g2YZp
         tBugu07ixJMz/JvWfkbatnaEjbiQMNVUNKmUt2I08xKsZQVKQkkIm+vFYOt7O3aZj2K9
         /KIzSYBMQtHG/Hab3HHRbHjazVqV2ZBg4jvQVzRmhvcY9VTyaijdecKlfzch15woGDoO
         4Isw==
X-Gm-Message-State: APjAAAUdXrhUlZUyZ99p8mKXBNDK06MdG/yN/bjNtRkHNhMDw9B2Oe5I
        QEYvLGOPdgHUZQCQFbAZbxOg8A==
X-Google-Smtp-Source: APXvYqw3KSJ3ehNU8RQ0M4ocEOtB2IpJ3gJQrhf2sWV4FOnrdHCkkwNpNrnHzJv7qop0/fuwyZ7GaA==
X-Received: by 2002:ac8:2a10:: with SMTP id k16mr28126307qtk.220.1557258190850;
        Tue, 07 May 2019 12:43:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n21sm7704457qkk.30.2019.05.07.12.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:43:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5zY-0007dD-NA; Tue, 07 May 2019 16:43:08 -0300
Date:   Tue, 7 May 2019 16:43:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>,
        mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
Message-ID: <20190507194308.GK6201@ziepe.ca>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
 <20190411190215.2163572e.cohuck@redhat.com>
 <20190415103546.GA6854@lap1>
 <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
 <20190422164527.GF21588@ziepe.ca>
 <20190430171350.GA2763@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430171350.GA2763@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 08:13:54PM +0300, Yuval Shaia wrote:
> On Mon, Apr 22, 2019 at 01:45:27PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> > > On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > > > 
> > > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > > more software runs in virtualized environment.
> > > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > > > 
> > > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > > technology and also because the Virtio specification
> > > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > > achieve bare metal performance.
> > > > > > 
> > > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > > Virtio Specification and a look forward on possible implementation
> > > > > > techniques.
> > > > > > 
> > > > > > Open issues/Todo list:
> > > > > > List is huge, this is only start point of the project.
> > > > > > Anyway, here is one example of item in the list:
> > > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > > >    in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > > >    that this is reasonable so one option is to have one for all and
> > > > > >    multiplex the traffic on it. This is not good approach as by design it
> > > > > >    introducing an optional starvation. Another approach would be multi
> > > > > >    queues and round-robin (for example) between them.
> > > > > > 
> > > Typically there will be a one-to-one mapping between QPs and CPUs (on the
> > > guest). 
> > 
> > Er we are really overloading words here.. The typical expectation is
> > that a 'RDMA QP' will have thousands and thousands of instances on a
> > system.
> > 
> > Most likely I think mapping 1:1 a virtio queue to a 'RDMA QP, CQ, SRQ,
> > etc' is a bad idea...
> 
> We have three options, no virtqueue for QP, 1 to 1 or multiplexing. What
> would be your vote on that?
> I think you are for option #1, right? but in this case there is actually no
> use of having a virtio-driver, isn't it?

The virtio driver is supposed to be a standard, like a hardware
standard, for doing the operation.

It doesn't mean that every single element under the driver needs to
use the virtio format QP.

Jason
