Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42D20662
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfEPLwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 07:52:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37289 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfEPLww (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 07:52:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id e15so3063025wrs.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QYJh4w0v5odxnSqG+yqI5OqUg1ypeKIbbxbIibzOdZI=;
        b=CGS7PdyIFxeC6bynjOly69F1ryJ3T5XYXzVNRWpS7h8lXfxDoB4iLKrcJVSQSXNKDg
         SSuPvzgf4H7rW5NiEEZTrsJ8Kkoeuc5yzXyoI7iNDyleFdOWH5JF0rUPpGuDwSErEucq
         L7APbPlJR4H1NdOjjT77eAXvzKfNuvNa9SvflpYpNkk2Q3b7Iu3VwdV16kYW2TADpMKh
         WLYETow73KbNjj1pHLSQR+MqSmvXd0R7WtMPgRzePZuLN46uGRxLnTqZuqBmjCHoaj8T
         Fkwm0lqWBynngsK4BvZY1LaJVtbEwmn8RvhLlpg3MJ5Pj4nbV75fAMTdhxQBLOX6zT1/
         vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QYJh4w0v5odxnSqG+yqI5OqUg1ypeKIbbxbIibzOdZI=;
        b=VPIvFJaVUvvio1hoWjGvem7r5jSQcaR02iuXhY1sztFYqGCTQ/OIqbysZh0r4Hn9Sj
         F4yzzXIOhBaBWflb1DIdfrmB1U1OnDzNVEi5z8RK2AyD6RdPW1XSbpQ3mEiIRsiuPRrR
         GN1wZXlLhkxeG1HtmdZ485YPIkDcNIjCvAcdSuJbOJzX6O/o6tmRVFNf+yovKlBG0Ltl
         pLAhtF4G+GGdAWq+r5EOpcYtXpfKAFuju2KOqCNEFRgpz+sYcLd/2pnUaD8MqvukDhza
         44chn8fR8Mheje9+T6tjDbzHzHEISEpURQ6o/yCsvRuwcqu0lNM9Pp9ZevCTMJy/1RWo
         3oJg==
X-Gm-Message-State: APjAAAXgmT8jVyfWr1KsJxfk+HANXr3ZWmW9iXmHHXAJFJmhcDc41Sh8
        4VeMa1DBtjjv1VQ62np8GDFvu+mm
X-Google-Smtp-Source: APXvYqwVnQeu28og5ewro0K0eKJ+YX3g+sUk9tjVgimU2l7vK2uK3Z1DV6x1pVKbmevjwtGAsHRPHQ==
X-Received: by 2002:adf:c149:: with SMTP id w9mr19326632wre.40.1558007571176;
        Thu, 16 May 2019 04:52:51 -0700 (PDT)
Received: from kheib-workstation (bzq-79-181-17-143.red.bezeqint.net. [79.181.17.143])
        by smtp.gmail.com with ESMTPSA id s18sm4481152wmc.41.2019.05.16.04.52.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 04:52:50 -0700 (PDT)
Message-ID: <8f4116c03236210e3481fae7e4ff51dfbad6c980.camel@gmail.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Date:   Thu, 16 May 2019 14:52:48 +0300
In-Reply-To: <20190516113750.GB22587@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
         <20190516111607.GA22587@ziepe.ca>
         <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
         <20190516113750.GB22587@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2019-05-16 at 08:37 -0300, Jason Gunthorpe wrote:
> On Thu, May 16, 2019 at 02:28:40PM +0300, Kamal Heib wrote:
> > On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> > > On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > > > For RoCE ports the call for ib_modify_port is not meaningful,
> > > > so
> > > > simplify the providers of RoCE by return OK in ib_core.
> > > > 
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > >  drivers/infiniband/core/device.c              | 23 ++++++-----
> > > >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> > > >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> > > >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> > > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> > > >  drivers/infiniband/hw/qedr/main.c             |  1 -
> > > >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> > > >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 ---------
> > > > ----
> > > >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> > > >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
> > > >  14 files changed, 14 insertions(+), 107 deletions(-)
> > > 
> > > We have more roce only drivers than this, why isn't everything
> > > changed?
> > > 
> > > Jason
> > 
> > Not all of them implements modify_port().
> 
> Then why didn't we just delete modify port from the other drivers?
> 
> Jason

This patch is doing that for all roce drivers that implement modify
port, unless you mean none-roce drivers?

Thanks,
Kamal


