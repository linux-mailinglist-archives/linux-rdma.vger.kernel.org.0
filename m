Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A836C181
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 21:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGQTdP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 15:33:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42464 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfGQTdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 15:33:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so17336556vsf.9
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4FJeAVQLrNu7ml0nYh7wMNb/DwPOkwgJSwmFEwMymLU=;
        b=GQxU/wSm4uk+cnKNJnT1Y3FZRzV4wVxoJ2fBQgX8xevvoVonfBxVlRsNq95dXMtWuE
         FOotZzKGnGRkYmYEONMPHkXndT8jcSA1wGUkUyM9RrryaVUP5i8oUaB9HLxCcCqJRBic
         IIIDtdRUbcoTHnC0k2wG8wuABVrsHzBSSyRlKpZulW0gZCYFTwBOICxIFky7+zUkaeMR
         5p/r4+mt4MAvMnyh3ApMQPL11gjbgxrWCKBw1MSiwWNaAFfQtTl3fc4c1RYFJMmKPXPS
         OQOjjabHGQ8yRXWeCoLUGSQBS1keAb87l832YC79DLAdFS8IofdVMjmUf+0YNyQ3XFYL
         c/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FJeAVQLrNu7ml0nYh7wMNb/DwPOkwgJSwmFEwMymLU=;
        b=I09UVYQEt8pjbE55J60PwJ3Ok4U7IYo3rbA60UY/Xizkek6FLjDb5XcW4Pa2AqLRga
         Grqh39DQ86IzqP5WuQzKmaxiBgKeSc5dWJb/t7t9yOK0ADH7mtEtW05qLaU2EycQlMrp
         iV0DGiMyTAr+mvd5s/+/fO0i9GRX9K6ZTA79hCHHEU9SwkNLGHE07tZOMFXyTGyFZw+n
         SKhSs/V1b8h3Bm/cvxM4q/vMzOTByYHub5AE4Btn1DIT6j7pRYlI8vPVCaZqs9mlBDQV
         p3ki0yBrNOzh+34/o8bYp0XlkW92W3dWjinP1Ojes2HqFhnNmkmNmkucL55OLUmoQM2s
         xKPA==
X-Gm-Message-State: APjAAAUoHBuY5EcZ9oNsgoJCJoPDZqHNhgpcMJ6NJrcjrHpPh9ovaQAR
        UAVcuIZhrOR0bmXCdLSTy8qAvw==
X-Google-Smtp-Source: APXvYqy/6eYkS6J6Dkton6qiT735Ve3asgwlu77rbsdW7RrOep1xe8F0d9erpaWbF6gSOSvcIvFHLA==
X-Received: by 2002:a67:7cd0:: with SMTP id x199mr27078446vsc.233.1563391994326;
        Wed, 17 Jul 2019 12:33:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o9sm15694230vkd.27.2019.07.17.12.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 12:33:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnpft-0000t4-34; Wed, 17 Jul 2019 16:33:13 -0300
Date:   Wed, 17 Jul 2019 16:33:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, monis@mellanox.com,
        parav@mellanox.com, danielj@mellanox.com, kamalheib1@gmail.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717193313.GN12119@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717192525.GA2515@shamir-ThinkPad-X240>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 10:25:25PM +0300, Shamir Rabinovitch wrote:
> On Wed, Jul 17, 2019 at 08:53:54AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 16, 2019 at 09:11:43PM +0300, Shamir Rabinovitch wrote:
> > > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > 
> > > ufile (&ucontext) with the process who own them must not be released
> > > when there are other ufile (&ucontext) that depens at them.
> > 
> > We already have a kref, why do we need more? Especially wrongly done
> > refcounts with atomics?
> 
> Yes. Will fix in v2.
> 
> > 
> > Trying to sequence the destroy of the ucontext seems inherently wrong
> > to me. If the driver has to link the PD/MR to data in the ucontext it
> > can't support sharing.
> 
> The issue we try to solve here is this:
> 
> [process 1]                     [process 2]
> - alloc mr & point mr to        -
>   context 1                     
> - share context                 -
> -                               - import mr
> - exit                          -
> -                               - exit
> -                               -- ufile_destroy_ucontext
> -                               --- driver dereg_mr is called
> -                               ---- ib_umem_release on umem from
>                                      previously destroyed context 1

Like I said, drivers that require the creating ucontext as part of the
PD and MR cannot support sharing.

> > > +	int wait;
> > > +
> > > +	if (ufile->parent) {
> > > +		pr_debug("%s: release parent ufile. ufile %p parent %p\n",
> > > +			 __func__, ufile, ufile->parent);
> > > +		if (atomic_dec_and_test(&ufile->parent->refcount))
> > > +			complete(&ufile->parent->context_released);
> > > +	}
> > > +
> > > +	if (!atomic_dec_and_test(&ufile->refcount)) {
> > > +wait:
> > > +		wait = wait_for_completion_interruptible_timeout(
> > > +			&ufile->context_released, 3*HZ);
> > > +		if (wait == -ERESTARTSYS) {
> > > +			WARN_ONCE(1,
> > > +			"signal while waiting for context release! ufile %p\n",
> > > +				ufile);
> > 
> > ????
> > 
> > Jason
> 
> I copied the behaviour I saw in the rest of the kernel as for what to do
> when wait_for_completion_interruptible_timeout exit due to interrupt.

It doesn't really make sense here, we can't block release() like this

Jason
