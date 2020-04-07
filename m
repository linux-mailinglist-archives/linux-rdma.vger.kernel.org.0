Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3171A0D0F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgDGLvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 07:51:19 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36156 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDGLvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 07:51:19 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so1641829qvw.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2020 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DgGvpFyYOKi8wIGYRHQghIAFXV9pugTvRfOBwVdCKoY=;
        b=fZIhXWbwIS9//XMFzQM9z6K+jfIE68P1xzCtbj5H2YXennkUpGzZDiV41P8JQtXd9f
         ONW40aHKwAgEBgQD5aPhQWLhi295ewAkrSrf+6JW1GXVqJu2JuMqWfZPW0xB+PfDPwk0
         HK4+Ofxs6OAq6WqOwjB6O/6VIkEVylsrVli7llRscoD3sfuldJwj2ookkLUzYwaW/HTU
         aM2dWMyDLTfucaN8wwK6H52W1dbqpd812mihhgMOZy0XTymvG+oYEXgq8oKTC3d7rJIX
         8JGBMv3V56JqZRHEmq6jEOactXe7bkx7cr37R/JV2pZC9PiQIpt5JF5ghk6jaEcQrEAI
         Kzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgGvpFyYOKi8wIGYRHQghIAFXV9pugTvRfOBwVdCKoY=;
        b=JZHOUhzI/qubDvPB7hePXf9Sv+Mk3dIYbJIy3hvQEIH9KqMrE9q0JaiM9jjD+/aZak
         ugK2DCqM1t3OAlvxdP+t70d7kGu5jPPja5LP+mdTlbcBuQOLGikEABtKNJXMcSFOfK+o
         k6XCwF/lUsytBdxsr4rOoM8X9WJ9twuiHScaQAExHQM6o611lnx2JoTmc6KXEP+fsCUj
         vtL7Wd8GxpNuiiF2+cGjJPK80EcalWwJZ7s5R/OoNmos0rDGe3L6VxrEp2Gp0jRs6xok
         CY/bHcC8eiLmVzmkVfpNIhTTkfLia/Wg16Or09kXjGfHgrNODZ5bNVBktymbgts3V57b
         MKgQ==
X-Gm-Message-State: AGi0PuZdSu8l6VBIHDg8lYiz/OdKtJ0fJ6mdvZ3tZRPcG8vF2eDP5PwO
        5xT47/DGUzvDYlNN+mDmL3TGvggklxTB5g==
X-Google-Smtp-Source: APiQypJaZ8vH9ymCACHwit03NYODmsAMH4UvE9ddzGpzB3Sx6zqGDX3mpS1pT9Drwuax87+g5z0lWg==
X-Received: by 2002:a05:6214:3ea:: with SMTP id cf10mr1746500qvb.6.1586260276111;
        Tue, 07 Apr 2020 04:51:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f21sm17199382qtc.97.2020.04.07.04.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 04:51:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLml9-0007SR-15; Tue, 07 Apr 2020 08:51:15 -0300
Date:   Tue, 7 Apr 2020 08:51:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Make the event_queue fds return POLLERR
 when disassociated
Message-ID: <20200407115115.GT20941@ziepe.ca>
References: <0-v1-ace813388969+48859-uverbs_poll_fix%jgg@mellanox.com>
 <20200407051632.GL80989@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407051632.GL80989@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 08:16:32AM +0300, Leon Romanovsky wrote:
> On Mon, Apr 06, 2020 at 09:44:26PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > If is_closed is set, and the event list is empty, then read() will return
> > -EIO without blocking. After setting is_closed in
> > ib_uverbs_free_event_queue(), we do trigger a wake_up on the poll_wait,
> > but the fops->poll() function does not check it, so poll will continue to
> > sleep on an empty list.
> >
> > Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  drivers/infiniband/core/uverbs_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> > index 2d4083bf4a0487..8710a3427146e7 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -296,6 +296,8 @@ static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
> >  	spin_lock_irq(&ev_queue->lock);
> >  	if (!list_empty(&ev_queue->event_list))
> >  		pollflags = EPOLLIN | EPOLLRDNORM;
> > +	else if (ev_queue->is_closed)
> > +		pollflags = EPOLLERR;
> >  	spin_unlock_irq(&ev_queue->lock);
> 
> Don't you need to set EPOLLHUP too? Probably, it won't change anything,
> just for the sake of the correctness.

HUP means read will return 0, in this case read returns -EIO

Jason
