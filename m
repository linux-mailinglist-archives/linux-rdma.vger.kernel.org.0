Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B574575555
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfGYRXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:23:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42880 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfGYRXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:23:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so37003334qkm.9
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i32w2wAVyyehf6wB6Jc3nUiW8Nc61mU3JB3Ii260K3Q=;
        b=hRRa7+Hiq0zE4C78OsxpkAoMIJKzhBqZ4cwAv2BA7VorrW62k4JHhQbuMxYU7J8Eo2
         vUMVYGx1bih9zqUYlT3Ix+cg+FqFyOffi3DEC+9itXAT36G3GXOPQpqLLOytDUwAn04m
         bNtbRaxs8SzEzlIRlAmyOwXj+T6L+wNuUdIVNRkRF2vPnSdYGweDlFcqYpTJ+DuBuwtT
         0xRKF9fYO0uCBHgsTQRHMmLAL4N+KF4d9Omp5R2i7ODpfrjhg2qc7QAiYCBHtTENCJMG
         riSyr2v3CfO9VDGkYzXsQUyBzuBzi59UP+QFfBXdvkFzeU21d472IqGTlbAGvnQIsMwA
         N2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i32w2wAVyyehf6wB6Jc3nUiW8Nc61mU3JB3Ii260K3Q=;
        b=S/ovrQ9FZc3XGSp390M/xqrVvNncSsj+wxfrVswrg8Y8SGpbNfyKjli429P+lBJf1o
         7GjDeAqt+vs1S4nB4Fwjtqb8qK5JT8uKqs+0gadS9YCi3YxgXZapGfrtTCNHshGGEgLL
         TikDuktZUnzNW+ccdz2w9hm5MrcfohDTLQciefF9kYmJSciRkEffNHqMqsAV2A3Xvp9+
         ksW0yzN79eRb+VWSoqQIgFyXcvyrM0Lk2V2R97uVrdLPKLaGXrAksPJSFt11m/1opaR7
         d5yCL4aRUdhOT7FuB+FTXwC5OKCO/MEWyqfCEmpR0NrPEN7gJuxbTl37RzKa9EWw8gSf
         kbbg==
X-Gm-Message-State: APjAAAUu9JJoGPoCL0PSP5mVJsJhTtio2mBiJ76OQN6YAEVZuTxDNEAd
        qXYXRF6OOB4jGYpDYDBP/nvMlg==
X-Google-Smtp-Source: APXvYqzaX4YBlLyhu1Gab74yJ59I7pm34XggZrLh93dbhUN7fVqo2PZdbgWKSgoDG9BGUW1w5b7ViQ==
X-Received: by 2002:a37:6248:: with SMTP id w69mr59614762qkb.225.1564075382818;
        Thu, 25 Jul 2019 10:23:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e1sm24786827qtb.52.2019.07.25.10.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:23:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqhSH-0001da-Va; Thu, 25 Jul 2019 14:23:01 -0300
Date:   Thu, 25 Jul 2019 14:23:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190725172301.GA6225@ziepe.ca>
References: <20190712085212.3901785-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712085212.3901785-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 10:51:23AM +0200, Arnd Bergmann wrote:
> The new siw driver fails to build on i386 with
> 
> drivers/infiniband/sw/siw/siw_qp.c:1025:3: error: invalid output size for constraint '+q'
>                 smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
>                 ^
> include/asm-generic/barrier.h:141:35: note: expanded from macro 'smp_store_mb'
>  #define smp_store_mb(var, value)  __smp_store_mb(var, value)
>                                   ^
> arch/x86/include/asm/barrier.h:65:47: note: expanded from macro '__smp_store_mb'
>  #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
>                                               ^
> include/asm-generic/atomic-instrumented.h:1648:2: note: expanded from macro 'xchg'
>         arch_xchg(__ai_ptr, __VA_ARGS__);                               \
>         ^
> arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
>  #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
>                                 ^
> arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
>                                       : "+q" (__ret), "+m" (*(ptr))     \
>                                               ^
> drivers/infiniband/sw/siw/siw_qp.o: In function `siw_sqe_complete':
> siw_qp.c:(.text+0x1450): undefined reference to `__xchg_wrong_size'
> drivers/infiniband/sw/siw/siw_qp.o: In function `siw_rqe_complete':
> siw_qp.c:(.text+0x15b0): undefined reference to `__xchg_wrong_size'
> drivers/infiniband/sw/siw/siw_verbs.o: In function `siw_req_notify_cq':
> siw_verbs.c:(.text+0x18ff): undefined reference to `__xchg_wrong_size'
> 
> Since smp_store_mb() has to be an atomic store, but the architecture
> can only do this on 32-bit quantities or smaller, but 'cq->notify'
> is a 64-bit word.
> 
> Apparently the smp_store_mb() is paired with a READ_ONCE() here, which
> seems like an odd choice because there is only a barrier on the writer
> side and not the reader, and READ_ONCE() is already not atomic on
> quantities larger than a CPU register.
> 
> I suspect it is sufficient to use the (possibly nonatomic) WRITE_ONCE()
> and an SMP memory barrier here. If it does need to be atomic as well
> as 64-bit quantities, using an atomic64_set_release()/atomic64_read_acquire()
> may be a better choice.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/sw/siw/siw_qp.c    | 4 +++-
>  drivers/infiniband/sw/siw/siw_verbs.c | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Bernard, please send at patch for whatever solution we settled on
against 5.3-rc1

Thanks,
Jason
