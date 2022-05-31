Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54105390D5
	for <lists+linux-rdma@lfdr.de>; Tue, 31 May 2022 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbiEaMfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiEaMfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 08:35:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCEE0C1
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 05:35:47 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv1so11855585qvb.5
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oWHKRM2sjsV9j18Uou7ebvFvnEa+cGbCODGUBQUO3Zs=;
        b=CJiVSYsFKl6g+Bjs8flx+07j1toE98gbAFjy2Nbd41cXr+CnMLWoS7dPVaa5rnkcZz
         KC5L/IeoJ92TATwdKjiJnjjCmqiA03Ua111Y6GJuTo6IZnsbC9ZSmhxQuVUzouaKiVqA
         5MkFu8LPtCkruWN0tyXESY4eTLK4kcThXu4VLnPz93v3fvKsebZkM+1Me5PYUafmwG26
         KzEfMPSNtXlGjvOUEkgZqimUdp2iYvjOSaMMeYFgAgyadXCdBCW9wOAWspzDmmF692n8
         /peRCPgrsfp7FJstrBBpv5iRSm3RQ/yd2+lrSiourql51bFoi7HOWMI3FUdauPtjUIde
         Neyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWHKRM2sjsV9j18Uou7ebvFvnEa+cGbCODGUBQUO3Zs=;
        b=BtqasDHEqb7t9oXBeuGv2byxdQNzEF6Gltd4TOri5jBsjCmo7FAmMccDnQ7hdpp8sP
         E5tfuWutECPZkJPaB9irgAYSLSzlcJZoOy9Timq3RhrZdNSI679DgIWxoBp/hacfYqVI
         OprkFpG/wJU3elFdqdyfLKdve9Iz/uCPTeioESeH6QdBB6uk8RQ3izvnw0J5dutz7hsz
         /pVYNIN5taPfb8tP2YuUZ8G0VthcJK6mYVKf1gNch/Kfe1TYp1jK5OkyIOD7uLI3gPeB
         G0qfR6hbtkAic7J94J5cFuS0AboSZASqG+CXwXqjVOq7gxGYlsfaoaSrjK7qWGL/1xoa
         ImjQ==
X-Gm-Message-State: AOAM5323egTr0b5j2I4t0COgysC5qhF9ru/H2Yj7paqHJ28cz+GPk2Oc
        gCTr+8fhpfb06KzROUPoHsZA3Q==
X-Google-Smtp-Source: ABdhPJxLv8PbM7CzcAnbp12IxYWqILvcPMh+IgosJlvzvyoYOv8OE2hJefvWAcoIgO6PgIt4yp6SAw==
X-Received: by 2002:ad4:5f4c:0:b0:464:4e2f:7876 with SMTP id p12-20020ad45f4c000000b004644e2f7876mr8736979qvg.31.1654000546424;
        Tue, 31 May 2022 05:35:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id az9-20020a05620a170900b0069fc13ce1e7sm9879351qkb.24.2022.05.31.05.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 05:35:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nw168-00FZen-Hd; Tue, 31 May 2022 09:35:44 -0300
Date:   Tue, 31 May 2022 09:35:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220531123544.GH2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> On 5/27/22 14:52, Jason Gunthorpe wrote:
> > On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
> > > On 5/25/22 13:01, Sagi Grimberg wrote:
> > > > iirc this was reported before, based on my analysis lockdep is giving
> > > > a false alarm here. The reason is that the id_priv->handler_mutex cannot
> > > > be the same for both cm_id that is handling the connect and the cm_id
> > > > that is handling the rdma_destroy_id because rdma_destroy_id call
> > > > is always called on a already disconnected cm_id, so this deadlock
> > > > lockdep is complaining about cannot happen.
> > > > 
> > > > I'm not sure how to settle this.
> > > 
> > > If the above is correct, using lockdep_register_key() for
> > > id_priv->handler_mutex instead of a static key should make the lockdep false
> > > positive disappear.
> > 
> > That only works if you can detect actual different lock classes during
> > lock creation. It doesn't seem applicable in this case.
> 
> Why doesn't it seem applicable in this case? The default behavior of
> mutex_init() and related initialization functions is to create one lock
> class per synchronization object initialization caller.
> lockdep_register_key() can be used to create one lock class per
> synchronization object instance. I introduced lockdep_register_key() myself
> a few years ago.

I don't think this should be used to create one key per instance of
the object which would be required here. The overhead would be very
high.

> My opinion is that holding *any* lock around the invocation of a callback
> function is an antipattern, in other words, something that never should be
> done. 

Then you invariably have an API that will be full of races because we
do need to run the callbacks synchronously with the FSM.  Many
syzkaller bugs were fixed by adding this serialization.

> Has it been considered to rework the RDMA/CM such that no locks are held
> around the invocation of callback functions like the event_handler
> callback?

IMHO it is too difficult, maybe impossible.

> There are other mechanisms to report events from one software layer
> (RDMA/CM) to a higher software layer (ULP), e.g. a linked list with event
> information. The RDMA/CM could queue events onto that list and the ULP can
> dequeue events from that list.

Then it is not synchronous, the point of these callbacks is to be
synchronous. If a ULP would like and can tolerate a decoupled
operation then it can implement an event queue, but we can't generally
state that all ULPs are safe to be asynchronous for all events.

This also doesn't actually solve anything because we still have races
with destroying the ID while the event queue is refering to the cm_id,
or while the event queue consumer is processing it. This still
requires locks to solve, even if they may be weaker rw/locks or
refcounting locks.

> [1] Ousterhout, John. "Why threads are a bad idea (for most purposes)." In
> Presentation given at the 1996 Usenix Annual Technical Conference, vol. 5.
> 1996.

Indeed, but we have threads here and we can't wish them away.

Jason
