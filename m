Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC09EF5C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfH0Pti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 11:49:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46951 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfH0Pti (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 11:49:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so21691045qtl.13
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pvvgSgM9CbdJfaBulsERf+5+2yHIplcG96TA5AmISw=;
        b=eV1MNaGvP7HxNr2esjzckKmVddzEK3y7o8MIrme4Sno04F5ZbnmCDdt1jLLqed8T5x
         v8iKIaKUtUSGNbnyxxGyzJTxXIdBzWKlSZ43Rq/9Pf/2vqnR7w6zd5p2saeIKtEBqatg
         7QPDCEirLtYTsISXIpTvmiTHySnITzmN4dNvB8krvT5hS/7nNJZ3v7+QmSq5Pibvohgm
         CpMRJRA0VPZalQ50kXT4KXcDPiaXdp4FPv+qqHfIy7wCv4kbh8HHCgg1Usu2Wrn9CtEo
         XlaAy3fyNDYxZWCkeR6goHFSLQNbXq93U3RQhpcIcV7vri4KHtCVJoVOtjwHjAOFcsfK
         10kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pvvgSgM9CbdJfaBulsERf+5+2yHIplcG96TA5AmISw=;
        b=MhPQdLhqd2e6HiP4JbLZmxuV5DO3U9uLuWJ7KY2ZRg0S+serDv2wScHxAuqf/7haax
         7FtAUaMQ1CgFovyPn6K5FC3BrOTfz1CWq1xYMvaOoQFzfyc3nRxe3atJDdKzq+CwlVJu
         fanwg1biD8dAHyKq4dSzWBJNA94mKhxPYA9vZnGUOsKip2RlLW08fisdED1dGOuODRdE
         8QbZJngeXv80lSmVtEUMqhebem3X2z/qJ0ty4AJhumH6i3eASbA0s6OYgd1ItS0DwqWY
         23DGu0dl1RBQpaNIUG/wFrwHT3k3UlVgYjReoQyfG4FKSHzAD9knVyw11G9ioURbVG3T
         EXag==
X-Gm-Message-State: APjAAAXxypV+IVzvO/6nJXkYWPtSkR5sOD+Klk458B9Tu6LQB3flj6cn
        o4KZC7EoPYeL9fweQExGIxC5gw==
X-Google-Smtp-Source: APXvYqyu/DYHXP5pxPrBOc9TAqxSuEjtwU6gt2+NCviFunNPjMYicGGmamfkRX2Rl60RbuNuhl7oWg==
X-Received: by 2002:ac8:24ce:: with SMTP id t14mr24042841qtt.246.1566920977057;
        Tue, 27 Aug 2019 08:49:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id u187sm8745056qkh.110.2019.08.27.08.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 08:49:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2dix-0003vR-SQ; Tue, 27 Aug 2019 12:49:35 -0300
Date:   Tue, 27 Aug 2019 12:49:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Message-ID: <20190827154935.GD7149@ziepe.ca>
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
 <20190825194354.GC21239@ziepe.ca>
 <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
 <20190826122055.GA27349@ziepe.ca>
 <CAFqt6zbTm7jA692-Ta9c5rxKoJyMUz2UPBpYGGs69wRtU=itpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbTm7jA692-Ta9c5rxKoJyMUz2UPBpYGGs69wRtU=itpw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 01:48:57AM +0530, Souptick Joarder wrote:
> On Mon, Aug 26, 2019 at 5:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Aug 26, 2019 at 01:32:09AM +0530, Souptick Joarder wrote:
> > > On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > > > > First, length passed to mmap is checked explicitly against
> > > > > PAGE_SIZE.
> > > > >
> > > > > Second, if vma->vm_pgoff is passed as non zero, it would return
> > > > > error. It appears like driver is expecting vma->vm_pgoff to
> > > > > be passed as 0 always.
> > > >
> > > > ? pg_off is not zero
> > >
> > > Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
> > > which means in true scenario driver is expecting vma->vm_pgoff should be passed
> > > as 0.
> >
> > get_index is masking vm_pgoff, it is not 0
> 
> Sorry, I missed this part. Further looking into code,
> in mlx5_ib_mmap(), vma_vm_pgoff is used to get command and
> inside mlx5_ib_mmap_clock_info_page() entire *dev->mdev->clock_info*
> is mapped.
> 
> Consider that, the below modification will only take care of vma length
> error check inside vm_map_pages_zero() and an extra check for vma
> length is not needed.

What is the point of vm_map_pages_zero() Is there some reason we should
prefer it for mapping a single page?

Jason
