Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D97229BCD
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgGVPv5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGVPv4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 11:51:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E8C0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 08:51:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a32so2160051qtb.5
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCwQTlNXnobYYKxJqVSwZ9ygF2riTvyRu+xgcGesZdQ=;
        b=HNfpGSD/GFJ/C6TCbP3oyPW3AHpIow+AQR8XPOFEqAJoeWCSQX0xyeW21j2HfqePSn
         ukdi75hG7JnuKuk6Pg63zelqB7r76+u1iXFMZAiqsg3ureCVLwsZWlhL4TTy+Tt9HjII
         ZpRlzjay3Fd0BMff9MHYPdiSTH3V+Wx9Z4ab+fN1jDkN4oADiurSzDZ4bzjY+ytA84gf
         BGvsJUjSV4GL3PWlbMPsLM062U/pKd+FfuT7WtlgHZy0I1Ursjzi02wP8GjqqHa4XzzF
         0/Z2U9nPeVgQ1K0V/QQpcc40nQ0BK3GNXJ8EcDFsIVbojHdIFeLCMRiNp59j7ITd6l/B
         RkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCwQTlNXnobYYKxJqVSwZ9ygF2riTvyRu+xgcGesZdQ=;
        b=R4NOz4N1f0dk3riXat1g56U5S27cLNeCxXf1xLxvYFdN/82iaBSzI9ZPsas5H2Nj6w
         Ka1HYSstFzazb8qDj0VTLS5QrmVh3xTN21M56Y5luL+WlKd659ReAQIUcnndczGwWkjG
         OyNx8HX/8vx9fM7Q/uxjQeA6UA4P3ZAXIGNtrwkWb/bPdD5roJ/e4Rdz17a+n9k8q7zO
         RfKUxJYFJuRNxdZ6hZUvzjxBvH6cFOVgFIoBLjuzLN/mZZEFUjpgKa/3CIjCeLPKVX/u
         52BMe4BcRAWa+oYwWiPHZYPWk0XxDk+oNqmIzFq8GJNR0o+XLpBduaC9Q85T3R0q4nYd
         FIMA==
X-Gm-Message-State: AOAM530s+us/G7B1VCMxKlXtBsXcAdgvrOIZKutPxwmAi7/LF0O0yl8u
        gYGCwfKyunnBhEJRChzmv78=
X-Google-Smtp-Source: ABdhPJwmDhgdF3qSxBhQjGs9DUlLAX6of4DyXV7Y8Y7MtZBWRxs1/iDhca8NHUaoGO0gq2nsdWnPJQ==
X-Received: by 2002:ac8:4301:: with SMTP id z1mr9022qtm.48.1595433115591;
        Wed, 22 Jul 2020 08:51:55 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id g22sm173422qkm.97.2020.07.22.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:51:53 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:51:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200722155152.GA3836710@ubuntu-n2-xlarge-x86>
References: <20200720080113.13055-4-galpress@amazon.com>
 <202007210118.fF0Xv5Jy%lkp@intel.com>
 <99314564-cb73-5a25-3583-1afda323d2b3@amazon.com>
 <CAKwvOdns6+LVqLO_aZgXOYi33xskO860=BEU-=Q7c3nGYkHs2A@mail.gmail.com>
 <2567f2dc-90e7-a0ca-e322-f585bda08e42@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2567f2dc-90e7-a0ca-e322-f585bda08e42@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 09:35:14AM +0300, 'Gal Pressman' via Clang Built Linux wrote:
> On 21/07/2020 20:10, Nick Desaulniers wrote:
> > On Tue, Jul 21, 2020 at 4:27 AM 'Gal Pressman' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> >>
> >> On 20/07/2020 20:08, kernel test robot wrote:
> >>> Hi Gal,
> >>>
> >>> I love your patch! Yet something to improve:
> >>>
> >>> [auto build test ERROR on 5f0b2a6093a4d9aab093964c65083fe801ef1e58]
> >>>
> >>> url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/Add-support-for-0xefa1-device/20200720-160419
> >>> base:    5f0b2a6093a4d9aab093964c65083fe801ef1e58
> >>> config: x86_64-allyesconfig (attached as .config)
> >>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cf1105069648446d58adfb7a6cc590013d6886ba)
> >>
> >> Uh, looks like I use some gcc specific stuff here.. I guess it's time to start
> >> checking clang compilation as well :).
> >>
> >> Will fix and resubmit.
> > 
> >>> drivers/infiniband/hw/efa/efa_verbs.c:1539:18: error: invalid application of 'sizeof' to an incomplete type 'struct (anonymous struct at drivers/infiniband/hw/efa/efa_verbs.c:1529:2) []'
> >            for (i = 0; i < ARRAY_SIZE(user_comp_handshakes); i++) {
> >                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > is user_comp_handshakes forward declared but not defined for an allyesconfig?
> > 
> 
> I don't think that's the issue here, the real problem is the first error:
> 
> >> drivers/infiniband/hw/efa/efa_verbs.c:1533:3: error: function definition is not allowed here
>                    DEFINE_COMP_HANDSHAKE(max_tx_batch, EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
>                    ^
>    drivers/infiniband/hw/efa/efa_verbs.c:1520:4: note: expanded from macro 'DEFINE_COMP_HANDSHAKE'
>                            DEFINE_GET_DEV_ATTR_FUNC(_attr)                        \
>                            ^
>    drivers/infiniband/hw/efa/efa_verbs.c:1506:2: note: expanded from macro 'DEFINE_GET_DEV_ATTR_FUNC'
> 
> 
> Apparently the braced group (is that how its called?) is supported by gcc, but not clang.
> 

I believe you are trying to use nested functions, which are not
supported by clang:

https://gcc.gnu.org/onlinedocs/gcc/Nested-Functions.html

clang supports both scoped statements and GNU C statement expressions
but you are trying to define a function within a GNU C statement
expression and use it in a designated initializer (in
DEFINE_COMP_HANDSHAKE with DEFINE_GET_DEV_ATTR_FUNC and
DEFINE_CHECK_COMP_FUNC), which causes a problem with clang.

Cheers,
Nathan
