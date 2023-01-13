Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44CB66A6A0
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAMXBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjAMXBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:01:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46007F461
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:01:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x4so13090724pfj.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAQbYGMaML5fa/DHmVz3EfKdwA/KXc1FwDFGQHrppL0=;
        b=lWOjbvh4IuNBwa2ZzT3rgGJypVyC6Zc1Wqnrkimn/SW2ehJDGWbXXULefjgfyeo5Qd
         Ws/jQ8cVwT2F36JNS9xaTdmsIAN7AC/ZZFbjr86PEUU0ytQMeSqtMi+y/vQl+/pgo4U8
         E46GRUr/SaBCvobUxYpqR1y/6gYHKe34xATJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAQbYGMaML5fa/DHmVz3EfKdwA/KXc1FwDFGQHrppL0=;
        b=qk0uNMzkg8EIKNZNHyLzTh3b+qp0tH+HLt7MEUiT9+HemuVTb8Q/srtiwBcr2v7asS
         R9f+LEx9oFLJhWXOYsokxNcjVC2YsypDUX/tZ85cmFI9+JFGoN5yH6dEQogZPUK4kinp
         WaE+jowiYIK+vzqZMJ1D1jmcjCvvAugJeIPf5wvySwJYNAHO9zC+nHx7i1YiFuBU3Z/z
         k5uX4VQMOGjoDLmBvPeKnvjKCqHz9ChwrSD9RT8C2hT35b53mMjZSW0FYvxsH6Y1kHxp
         U4ZYivBtuEZ05frgtsIJE2mwbh/0PPyIebb4MyJbaHUWPrdQvxv2ZlCLxGs6UgYzBA5D
         WdQA==
X-Gm-Message-State: AFqh2kqEWziDSQqlAu5XaR0ba8SeR1IqrKN4oO+F5/cQz/m0gsegw/wH
        ZDliLIAhDCruYaphjuPeVo+PxA==
X-Google-Smtp-Source: AMrXdXuOJHsk34k6YZdu/AFcyBDgW6AnnR45JuuXxTcdyhIWnIr9mExAvL0atVo6SvjzWEr0Ka3Jeg==
X-Received: by 2002:a05:6a00:4212:b0:583:fb14:ddc1 with SMTP id cd18-20020a056a00421200b00583fb14ddc1mr28709488pfb.17.1673650888393;
        Fri, 13 Jan 2023 15:01:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm14121533pfv.153.2023.01.13.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:01:27 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:01:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yupeng Li <liyupeng@zbhlos.com>, tariqt@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caicai <caizp2008@163.com>
Subject: Re: [PATCH 1/1] net/mlx4: Fix build error use array_size() helper in
 copy_to_user()
Message-ID: <202301131453.D93C967D4@keescook>
References: <20230107072725.673064-1-liyupeng@zbhlos.com>
 <Y7wb1hCpJiGEdbav@ziepe.ca>
 <202301131039.7354AD35CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202301131039.7354AD35CF@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 10:41:01AM -0800, Kees Cook wrote:
> On Mon, Jan 09, 2023 at 09:51:18AM -0400, Jason Gunthorpe wrote:
> > On Sat, Jan 07, 2023 at 03:27:25PM +0800, Yupeng Li wrote:
> > > When CONFIG_64BIT was disabled, check_copy_size() was declared with
> > > attribute error: copy source size is too small, array_size() for 32BIT
> > > was wrong size, some compiled msg with error like:
> > > 
> > >   CALL    scripts/checksyscalls.sh
> > >   CC [M]  drivers/net/ethernet/mellanox/mlx4/cq.o
> > > In file included from ./arch/x86/include/asm/preempt.h:7,
> > >                  from ./include/linux/preempt.h:78,
> > >                  from ./include/linux/percpu.h:6,
> > >                  from ./include/linux/context_tracking_state.h:5,
> > >                  from ./include/linux/hardirq.h:5,
> > >                  from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
> > > In function ‘check_copy_size’,
> > >     inlined from ‘copy_to_user’ at ./include/linux/uaccess.h:168:6,
> > >     inlined from ‘mlx4_init_user_cqes’ at drivers/net/ethernet/mellanox/mlx4/cq.c:317:9,
> > >     inlined from ‘mlx4_cq_alloc’ at drivers/net/ethernet/mellanox/mlx4/cq.c:394:10:
> > > ./include/linux/thread_info.h:228:4: error: call to ‘__bad_copy_from’ declared with attribute error: copy source size is too small
> > >   228 |    __bad_copy_from();
> > >       |    ^~~~~~~~~~~~~~~~~
> > > make[6]: *** [scripts/Makefile.build:250：drivers/net/ethernet/mellanox/mlx4/cq.o] 错误 1
> > > make[5]: *** [scripts/Makefile.build:500：drivers/net/ethernet/mellanox/mlx4] 错误 2
> > > make[5]: *** 正在等待未完成的任务....
> > > make[4]: *** [scripts/Makefile.build:500：drivers/net/ethernet/mellanox] 错误 2
> > > make[3]: *** [scripts/Makefile.build:500：drivers/net/ethernet] 错误 2
> > > make[3]: *** 正在等待未完成的任务....
> > > make[2]: *** [scripts/Makefile.build:500：drivers/net] 错误 2
> > > make[2]: *** 正在等待未完成的任务....
> > > make[1]: *** [scripts/Makefile.build:500：drivers] 错误 2
> > > make: *** [Makefile:1992：.] 错误 2
> > > 
> > > Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> > > Reviewed-by: Caicai <caizp2008@163.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx4/cq.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> > > index 4d4f9cf9facb..7dadd7227480 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> > > @@ -315,7 +315,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
> > >  		}
> > >  	} else {
> > >  		err = copy_to_user((void __user *)buf, init_ents,
> > > +#ifdef CONFIG_64BIT
> > >  				   array_size(entries, cqe_size)) ?
> > > +#else
> > > +				   entries * cqe_size) ?
> > > +#endif
> > >  			-EFAULT : 0;
> > 
> > This can't possibly make sense, Kees?
> 
> Uuuuh, that's really weird. What compiler version and arch? I'll see if
> I can reproduce this.

I can't reproduce this. I'm assuming this is being seen on a 32-bit
loongarch build? I have no idea how to get that compiler. Neither Debian
nor Fedora seem to package it. (It looks like it was added in GCC 12?)
Perhaps it's just "mips"? But I also can't figure out how to choose a
32-bit mips build. Wheee.

Anyway, I would assume this is a compiler bug around inlining or the
check_mul_overflow implementation?

static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
{
        size_t bytes;

        if (check_mul_overflow(factor1, factor2, &bytes))
                return SIZE_MAX;

        return bytes;
}

#define array_size(a, b)        size_mul(a, b)


-Kees

-- 
Kees Cook
