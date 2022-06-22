Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E7554373
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiFVGnw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 02:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiFVGnv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 02:43:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8171F34669;
        Tue, 21 Jun 2022 23:43:50 -0700 (PDT)
Date:   Wed, 22 Jun 2022 08:43:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655880228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuGQW+PinnSo/RMeTmXWV63xHcA8hBa5G5YojrHjxY0=;
        b=Mv1MzaVoM2ymsRfN+kldQgUWqNho2Ka1S3nqj2HGHP9Imlp9x2RQCDHn5Aruz1Y+mCDRbn
        iZNvx/8EHGTYU/R+5b1jSvZSQrVKkz1ZLlv2cez7mWhzYDZEN+7y3b9RD01yscWyYvLHH/
        lXJ3qSMCIHsbeyLZx2PLDiPUS0vswN6eCo29JjW2RMqMnsjLo8MD4rgWFGoWkP1pWAPTMo
        a9Nxe/NAMH0Tuky78iDo7SlfU04bDJ+qH3y0ZpEnewXFydi29evKRrrKLCl422y+n8+OEs
        K/DP4dMErj8rSvZ4MOI+BczI/wCThce+EY+IrTkfrcTRaIXbd8CVhqU7WCOvxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655880228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuGQW+PinnSo/RMeTmXWV63xHcA8hBa5G5YojrHjxY0=;
        b=GKuA/Z6kyvwlRLUZQrU7LpH7U7WP83W1yte9QM/vjbOnw4nT7OZOKj1Odn0FJawvv2mGvJ
        Tk4mCfiuL0qNUVBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [locking/lockdep] 4051a81774:
 page_allocation_failure:order:#,mode:#(GFP_KERNEL),nodemask=(null)
Message-ID: <YrK6Iv5jsBa7BRrL@linutronix.de>
References: <20220620020727.GA3669@xsang-OptiPlex-9020>
 <YrBA7ysAif4I9nPv@linutronix.de>
 <CAMGffEksZGQrdHM9CS0H0Tq4TvfQMAbdcFYZej2KNWY=VxuBQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMGffEksZGQrdHM9CS0H0Tq4TvfQMAbdcFYZej2KNWY=VxuBQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022-06-21 17:27:22 [+0200], Jinpu Wang wrote:
> Hi, there
Hi,

> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp=
 2 -m 16G
> > >
> > =E2=80=A6
> > > [   17.451787][    T1] rtrs_server L2256: Loading module rtrs_server,=
 proto 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) , sess_q=
ueue_depth: 512, always_invalidate: 1)
> > > [   17.470894][    T1] swapper: page allocation failure: order:5, mod=
e:0xcc0(GFP_KERNEL), nodemask=3D(null)
> >
> > If I read this right, it allocates "512 * 10" chunks of order 5 / 128KiB
> > of memory (contiguous memory). And this appears to fail.
> > This is either a lot of memory or something that shouldn't be used on
> > i386.
> It allocates 512 * 128 KiB of memory, which is probably to big for
> this VM setup.

why 512 * 128KiB? It is:
|         chunk_pool =3D mempool_create_page_pool(sess_queue_depth * CHUNK_=
POOL_SZ,
|                                               get_order(max_chunk_size));
with
| static int __read_mostly max_chunk_size =3D DEFAULT_MAX_CHUNK_SIZE;
| static int __read_mostly sess_queue_depth =3D DEFAULT_SESS_QUEUE_DEPTH;
| #define CHUNK_POOL_SZ 10

so isn't it (512 * 10) * 128KiB?

> Thanks!

Sebastian
