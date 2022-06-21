Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780C553610
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jun 2022 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiFUP1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiFUP1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 11:27:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411962A961
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 08:27:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so17111022edb.5
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jun 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ILeDKuRqs+6KaJKuC3DMca4dsilJZpsBWsm8KWiLros=;
        b=AbMambO1LB7kdSp+mzCc3liOd7EsJg5F43ijIbQsO676JdbpjQwM6qG9aJstavqgan
         JDWtRDT3rlmHkaZn2qh4PAzome2qCoQp+jOuXz10+4rg9rNCYMaOPUjqYRtTqNyar7Xr
         dvKpsKBJ5Z45hzfOiPSeMkMML/++PuAfw9CmA4ZmqfjXpSPizti5IBSH6a1Qg8pnZaFL
         OTfc4glhUCBbHSpamuedswpCnvaSW1cjg35jkPpTfslqXkTXM9xs5SXJZJ7Bf4zbSs8N
         VSOkQsAs6uFohQZPg3YIEoZ+p/0JU1I9ePxw7jQZRJhy2qo7SAr2368NOK25rs1qGLYL
         GFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ILeDKuRqs+6KaJKuC3DMca4dsilJZpsBWsm8KWiLros=;
        b=Ev5B9b/5xJDIzm2jpygxRYuj88/i9i2je8mTePfPAPfMdCnv+l/m7CMUzNc/LbwC+d
         JkMx7zKe3OfuitkP/P6pXHasdf6a9DlTI3cFCm/F9/9nueVIM5gnUhD5TVJSsDQuA2IL
         gHUUnfiZdhKuGRj10RoVaJlZaROGq0qQBYZ3yaq0bA8eYyh5pNjj/SsVtfGhLt/7vclw
         TGcqTK7KoFDgcXI6m/o/iriHxECUcWC6t0cdg+ZEKMLHcGePm0BP+8dwqcYn8N2dPcN8
         3PAOPm8t8311S3UyxmBg1O2xD2LZ2hBYUNIIc1sqnOlhJtp0y8cwDTNj1YD6XE4DduUd
         cUJg==
X-Gm-Message-State: AJIora8w3G1NkOHbFbNOI699h5sdX+MbfX9VyV9Eokq1TYszk4OfBGBs
        HzxwiorY3AKhw9zc76xkjEHpp/Z0MFCU2kt6uKllvJISi1g=
X-Google-Smtp-Source: AGRyM1vl1dj3IZNu9lHHH+Fl3VOH/3vv/c4P3JkjJZilD5Y74fS2cnU0d4C05O4nX9JfwTjrn0FjqcAjfOFzgVau2Bs=
X-Received: by 2002:a05:6402:42d5:b0:433:1727:b31c with SMTP id
 i21-20020a05640242d500b004331727b31cmr36016283edc.9.1655825252741; Tue, 21
 Jun 2022 08:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220620020727.GA3669@xsang-OptiPlex-9020> <YrBA7ysAif4I9nPv@linutronix.de>
In-Reply-To: <YrBA7ysAif4I9nPv@linutronix.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 21 Jun 2022 17:27:22 +0200
Message-ID: <CAMGffEksZGQrdHM9CS0H0Tq4TvfQMAbdcFYZej2KNWY=VxuBQg@mail.gmail.com>
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

Hi, there

On Mon, Jun 20, 2022 at 11:42 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> + rtrs, infiniband folks.
>
> On 2022-06-20 10:07:27 [+0800], kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-11):
> >
> > commit: 4051a81774d6d8e28192742c26999d6f29bc0e68 ("locking/lockdep: Use=
 sched_clock() for random numbers")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
> =E2=80=A6
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> >
> =E2=80=A6
> > [   17.451787][    T1] rtrs_server L2256: Loading module rtrs_server, p=
roto 2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) , sess_que=
ue_depth: 512, always_invalidate: 1)
> > [   17.470894][    T1] swapper: page allocation failure: order:5, mode:=
0xcc0(GFP_KERNEL), nodemask=3D(null)
>
> If I read this right, it allocates "512 * 10" chunks of order 5 / 128KiB
> of memory (contiguous memory). And this appears to fail.
> This is either a lot of memory or something that shouldn't be used on
> i386.
It allocates 512 * 128 KiB of memory, which is probably to big for
this VM setup.
>
> Either way, locking/urgent is innocent.
Agree.

Thanks!
