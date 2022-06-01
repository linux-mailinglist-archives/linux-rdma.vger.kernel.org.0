Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5723553ABE2
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiFARaM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356333AbiFARaI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 13:30:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAE78EDE
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 10:30:07 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id v5so1932663qvs.10
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jun 2022 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aMQ31BRtxLqprW2PJA3KDD0QoPe/Axlx3wARGwuJL98=;
        b=C7aB2j7BY73/2ByE/3EfRdBfJdDMAeNLiW4a6JR/QsYgOVRXSXcrRK0+IlLmavZZyN
         sERYyJyuAmOkGV7NJ9EoRXVqw2Hlmbxryh+oKiq8UpsTw6uS7yP05IaasNtJ9AmYr6Bt
         mpKVNS3QkFCiSovUzqrz9FzIdtMEx78JZ8EQERW+SGzzHONl8HRkHzqCH/nYhU9tl33E
         6jZ5bdHne+zLzNXveiAJrTcM2Kdnz8TEHX+s+aLaVONMXh8VDgeDVNOZJaPC0GdJMjHm
         uKestBGsT/kJIoQtcmGcNMkYNpBvvN4RYPJ5NYAt/FSU7DnOQgD+b9Gs0OY7gWe5G62h
         vmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMQ31BRtxLqprW2PJA3KDD0QoPe/Axlx3wARGwuJL98=;
        b=tFoN3gdrj+5shsEKYXdFsUuSTqzVD9X4WbvJphLamGoOCSNp/jWSKRvG9ileYiciIJ
         COnFOdtrZ5g/PpQ06s91dgdDYWKKa0UoRU00hWmTb+EHjc5KHDw1JWu0Qz/5qzVZeCf2
         2wvUuAfx+lOJRe9LTLBnwEPoh2PnndH2o0HKC99sFZNF7ELN6bOjaDCm3hAiQrjE7Bsq
         LA5wudKrFedCffx7N2sBYJGjxevVmM4BHa7NTqaSo0SIMJGYxL7KlqeM+vEfy/9xV8pA
         jt4gmmOKJwJs/mdtqPe3EUTW0oa8Jdcy0MgrDCaj9YIS/aDoVb1BotJqOcfVHfJn55MY
         R98g==
X-Gm-Message-State: AOAM531qQEh9+gwvUElwivJUqOgV+bM/EbJTQD9uIVBTiBwXjcdEUY3s
        ++c2NbzeH6kI1yOW9BgkH3Qovg==
X-Google-Smtp-Source: ABdhPJwxXijengjadUc09wmSv0uWM5yg67nxL9gzo/Bi8ukzVRcI9ZIZQiCwW7awUpcU8U+k/eyi9A==
X-Received: by 2002:a05:6214:27c6:b0:464:63cd:3d41 with SMTP id ge6-20020a05621427c600b0046463cd3d41mr7044911qvb.75.1654104606855;
        Wed, 01 Jun 2022 10:30:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a102d00b0069fc13ce217sm1488248qkk.72.2022.06.01.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:30:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwSAX-00G5gY-8O; Wed, 01 Jun 2022 14:30:05 -0300
Date:   Wed, 1 Jun 2022 14:30:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220601173005.GJ2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 01, 2022 at 09:26:52AM -0700, Bart Van Assche wrote:
> On 6/1/22 05:45, Jason Gunthorpe wrote:
> > On Tue, May 31, 2022 at 10:55:46AM -0700, Bart Van Assche wrote:
> > > On 5/31/22 05:35, Jason Gunthorpe wrote:
> > > > On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> > > > > On 5/27/22 14:52, Jason Gunthorpe wrote:
> > > > > > That only works if you can detect actual different lock classes during
> > > > > > lock creation. It doesn't seem applicable in this case.
> > > > > 
> > > > > Why doesn't it seem applicable in this case? The default behavior of
> > > > > mutex_init() and related initialization functions is to create one lock
> > > > > class per synchronization object initialization caller.
> > > > > lockdep_register_key() can be used to create one lock class per
> > > > > synchronization object instance. I introduced lockdep_register_key() myself
> > > > > a few years ago.
> > > > 
> > > > I don't think this should be used to create one key per instance of
> > > > the object which would be required here. The overhead would be very
> > > > high.
> > > 
> > > Are we perhaps referring to different code changes? I'm referring to the
> > > code change below. The runtime and memory overhead of the patch below
> > > should be minimal.
> > 
> > This is not minimal, the lockdep graph will expand now with a node per
> > created CM ID ever created and with all the additional locking
> > arcs. This is an expensive operation.
> > 
> > AFIAK keys should not be created per-object like this but based on
> > object classes known when the object is created - eg a CM listening ID
> > vs a connceting ID as an example
> > 
> > This might be a suitable hack if the # of objects was small???
> 
> Lockdep uses hashing when looking up a lock object so the lookup time
> shouldn't increase significantly if the number of hash collisions stays low.
> I think this is likely since the number of hash entries is identical to the
> maximum number of synchronization objects divided by two. See also the
> definition of the lock_keys_hash[] array in kernel/locking/lockdep.c.

That is just the keys, not the graph arcs. lockdep records an arc
between every key that establishes a locking relationship and
minimizing the number of keys also de-duplicates those arcs.

Jason
