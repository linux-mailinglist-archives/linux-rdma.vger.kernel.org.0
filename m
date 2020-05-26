Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A721E21A8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgEZMJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgEZMJ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 08:09:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C5C03E96D
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 05:09:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so14743525qkn.8
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hurvk3w+5sCwVq0/cQ/rudfo21YoRb7E0m+XUCO5oTY=;
        b=IUSTkMsfeTNM/+I3asZP53+9lnNL4hLCi8ZlqRUd6PEW//S11kEEwV1ePTj9rx1d/O
         kDbebshqOLvyD+3b0PIMTml59xxVvys7shv6NL3b8LCuN/jI5+94D5BL8undejrDetnn
         RmcjfPrHNnWX+bcSgpNRS3a7TttPZ/U/kgbqqmn+PqVKT6x4HWvZ+aXpdfaWIWac8lm0
         EyXByJK3HDC6goURo23AvTJpUG8Jlnj57oZAdLBPuU0+C6SUSHAY5LqP8LR6inH/IhiZ
         PxPhSOy2cebD63fV+DKlysN1QIB3uJoZvucMcVjyvp1YAZhiOtgB6BDI0ArRUP0+/pDu
         d0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hurvk3w+5sCwVq0/cQ/rudfo21YoRb7E0m+XUCO5oTY=;
        b=bf6qXRpMbW5PF5EiswLTjJg0u2K+shFuKWvqjNaOBr/R64pIy2NHILs727Hjn6+xvy
         wVJ0Zn57o6Trh4Tf0dWrtYrVyhk0kek53eVMNtX8f2zi0hEN35a6LlP7Vq5OMizLkFOD
         +eYnhccvgFezVZB7lf6XZLqfl5b92epy23PWsCs8N/3V+TPfaNqmdxbxsLsvs5SSEeiI
         nWTSNNxOPkur29uD1Mgjbr5OHd75rOcv4HJTsjbdeTJdMHzUKoNPL/aWtr4jMZr2naeJ
         3Sc7SPsvMuZX4SNnJLlzNcNQ6Z0gzf3IfrjNEkMTZhrCGEGeMFSoXDuh5OffmDkVZHWf
         NBAg==
X-Gm-Message-State: AOAM531rEjFhzf4Fo315FFQVSXpT/Y//ZMWq0qR6yJE3iUyiO4HFBTYk
        gotX2LfdJgCmjL2oZpeLhvhenA==
X-Google-Smtp-Source: ABdhPJzar8DpfN384I8Gc5K4T2yNfpPvMN0AD4ahss5/HyewUfZ2vkOETKin+rlDWu6VMMpYViNsVw==
X-Received: by 2002:a37:6346:: with SMTP id x67mr906324qkb.340.1590494996358;
        Tue, 26 May 2020 05:09:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w94sm11006385qte.19.2020.05.26.05.09.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 05:09:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdYP5-0004t9-1W; Tue, 26 May 2020 09:09:55 -0300
Date:   Tue, 26 May 2020 09:09:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200526120955.GM744@ziepe.ca>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <20200525164215.GA3226@ziepe.ca>
 <20200525164713.GF10591@unreal>
 <ce3205eb-44f6-f2b8-6b19-4547092f6a88@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3205eb-44f6-f2b8-6b19-4547092f6a88@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 02:39:33PM +0300, Yamin Friedman wrote:
> 
> On 5/25/2020 7:47 PM, Leon Romanovsky wrote:
> > On Mon, May 25, 2020 at 01:42:15PM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2020 at 03:43:34PM +0300, Yamin Friedman wrote:
> > > 
> > > > +void ib_cq_pool_init(struct ib_device *dev)
> > > > +{
> > > > +	int i;
> > > I generally rather see unsigned types used for unsigned values
> > > 
> > > > +
> > > > +	spin_lock_init(&dev->cq_pools_lock);
> > > > +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> > > > +		INIT_LIST_HEAD(&dev->cq_pools[i]);
> > > > +}
> > > > +
> > > > +void ib_cq_pool_destroy(struct ib_device *dev)
> > > > +{
> > > > +	struct ib_cq *cq, *n;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> > > > +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
> > > > +					 pool_entry) {
> > > > +			cq->shared = false;
> > > > +			ib_free_cq_user(cq, NULL);
> > > WARN_ON cqe_used == 0?
> > An opposite is better - WARN_ON(cqe_used).
> > 
> > <...>
> 
> Is this check really necessary as we are closing the device?

It checks that no ULPs forgot to destroy something

Jason
