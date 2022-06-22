Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9336554371
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351875AbiFVG47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 02:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350036AbiFVG47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 02:56:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC2369DA
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 23:56:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ge10so601903ejb.7
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GVCryb+NZ1RjJur3tYCrgFj4R72wJeWsi7jJvADmLLY=;
        b=KVdIr9FNS2CkgZZdgMYWrs9jPiiqL/Ra10PQ06IHWg9S7jHJXR8hvvZwdASiRXjCnl
         Ws0jBogVMuWPZzTF9gVY4Knxs4ZZBl1oZhBz3cyg2QCwDOrEU1ipd6/7ag7D7NOAGHRU
         wMA7zATaNhTIql4Egm7L8pIrhQKuSI9FwaszCUIM0vbUnFRBfC0d74xTi3hFYE10IcU4
         Jt/k0vDD5x77hpYEZZlc6K6F/R1kqm3oCxVg30Uxs7NDvJUJg44NH+ecEQZlCX6icbJz
         +cVwfM/0av6bunaNQp5cum+6Q79+O/02K0c3qFOYFuBQLy9wrx82RiKlInYLHhdJXOec
         04DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GVCryb+NZ1RjJur3tYCrgFj4R72wJeWsi7jJvADmLLY=;
        b=uiCWB4/dpuFRR6OXZewaQr35NDySZUfExjguK87a4Qjw5sAU2ZgUbOfnwD6wA0z9JH
         7dsiiftyPZpNgfjklZm8kPYAODZ3YWUxHqwl9n+h3VyO2N2gp6djM5rIH2Pq35mNMnja
         +DNlqs8c7wSyA4+f71pkahV7nka3i9iH9MW7iIo/q4SqzZ8m3JtSCA0eA2v1cyXt63OR
         7EV7vfo9yJhcHDhJ63XpSSxBpoEkvD4tEeNsZoRhMqyRVJaDXdXcgEsLn2oupB10ndlK
         06NNUAWLdCH//bX741wZO3ZqdMfbOYgnKqEk5PEVu6qnaYR1T3L6Hk/X3kiYXuVCHqhO
         Useg==
X-Gm-Message-State: AJIora/rDYNiGTPPFJXLOCnXWgLtF1g7UuopepaYi3uRGf/gmPQiYAe7
        tVRW5JVgbYNbMwpCI7K7vUoVuN/zog29qSmcz7cjYQ==
X-Google-Smtp-Source: AGRyM1sVg74726SXM1ZoL6HLHlCRixomOhvot1HwS+fJv8rCvOSjwC9qaYT6H0x6agypdmTW4tgo7pLFBoBi/DvM+34=
X-Received: by 2002:a17:906:5350:b0:711:f866:ed8 with SMTP id
 j16-20020a170906535000b00711f8660ed8mr1604571ejo.441.1655881015882; Tue, 21
 Jun 2022 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220620020727.GA3669@xsang-OptiPlex-9020> <YrBA7ysAif4I9nPv@linutronix.de>
 <CAMGffEksZGQrdHM9CS0H0Tq4TvfQMAbdcFYZej2KNWY=VxuBQg@mail.gmail.com> <YrK6Iv5jsBa7BRrL@linutronix.de>
In-Reply-To: <YrK6Iv5jsBa7BRrL@linutronix.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 08:56:45 +0200
Message-ID: <CAMGffE=qxXNwTeRvzX3YYEgEgB9FJzDhkUM6R=v4BTsVRasH6g@mail.gmail.com>
Subject: Re: [locking/lockdep] 4051a81774: page_allocation_failure:order:#,mode:#(GFP_KERNEL),nodemask=(null)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 22, 2022 at 8:43 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-06-21 17:27:22 [+0200], Jinpu Wang wrote:
> > Hi, there
> Hi,
>
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -s=
mp 2 -m 16G
> > > >
> > > =E2=80=A6
> > > > [   17.451787][    T1] rtrs_server L2256: Loading module rtrs_serve=
r, proto 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) , sess=
_queue_depth: 512, always_invalidate: 1)
> > > > [   17.470894][    T1] swapper: page allocation failure: order:5, m=
ode:0xcc0(GFP_KERNEL), nodemask=3D(null)
> > >
> > > If I read this right, it allocates "512 * 10" chunks of order 5 / 128=
KiB
> > > of memory (contiguous memory). And this appears to fail.
> > > This is either a lot of memory or something that shouldn't be used on
> > > i386.
> > It allocates 512 * 128 KiB of memory, which is probably to big for
> > this VM setup.
>
> why 512 * 128KiB? It is:
> |         chunk_pool =3D mempool_create_page_pool(sess_queue_depth * CHUN=
K_POOL_SZ,
> |                                               get_order(max_chunk_size)=
);
> with
> | static int __read_mostly max_chunk_size =3D DEFAULT_MAX_CHUNK_SIZE;
> | static int __read_mostly sess_queue_depth =3D DEFAULT_SESS_QUEUE_DEPTH;
> | #define CHUNK_POOL_SZ 10
>
> so isn't it (512 * 10) * 128KiB?
eh, you're right, I forgot we have mempool. We discussed internally in
the past to remove that, we should do it.

Sorry
>
> > Thanks!
>
> Sebastian
