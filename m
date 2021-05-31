Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB2395A87
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhEaMb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 08:31:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07075C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:29:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lz27so16392063ejb.11
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jb4Z+AjvdPnfhjdG6ljrgOIwgIPkJCbpwwj29e2IazI=;
        b=JF8+d6QKWK+a4Yh7J2Vr/Jt7+EMK8VG4P9xa8h/bbM61tvE94MfTlQEPu3OfXt8Or6
         dXvVRMmBWdik8Xj0hPRFecPQhVCQMq61k2VrcSjG8MUWsdBlvdeeNcRUWC1wjyviSLNU
         1U/gWHfgw+Ac3jgnD3ILDJbKS/CU01gzH54NkXWxYK/MriOiF2bSyrI/w+XyrFr+DsBP
         60EsbPqlpxltEvKbyipJKgQXqektMKY5cuLbhggkHaTpXrqTdd6ixowW6NYw2GFrMRD9
         ioozyLsIZpf33+2/WsCB/Q2s1TmNZ7H4dgxgoc+M9D+AB3sL5+s8/q84tboIj8uWmOtq
         9DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jb4Z+AjvdPnfhjdG6ljrgOIwgIPkJCbpwwj29e2IazI=;
        b=lp8Cyz8P3gLk1OULrc7w2cwS4Yb8RnQiHDycnax9qxvWyJUQnz9zmOvGn8fn3D39jt
         IxT8qtvAbyX1rDZccf+sIQosidH+gzjv1hVxq9/0e6IP3DvlL6CSDhCoXX72vXrm8FSp
         mz1DPxGY6LQ2Jv5Ovyucz5VLJ+I58+Wc4Q8xuteRYJcefnXKZp2euUY+cPCPnVB42z7X
         eicoSQlRcjhS5amtrmMe2r4jukvPN+KKEl9EmLDSq/LsbrOM0IETGTWmTq0weLsxQx9A
         A0tgctuCnpfuiDPtjOnuvPzsj5NOYRPrbhUDIl2UU+ssmHpydWeiouM/k/MJK4k1bBbh
         KoXg==
X-Gm-Message-State: AOAM530JZUHB7pTfzAgvt1ZHATVC2zCbyu2tq72eMw9ChdZZ6wLPlJbd
        ApxzCc8KmgxK1GBDfgJ6T1gnewSTPGl/WO1Rx6GNhA==
X-Google-Smtp-Source: ABdhPJz8y3+1TsTdF0yCWAYMcXb8SJ0nWU4YkIZImYYp/Qv3nQ8k/GD+vOX9zpIrbn/mwuUj14/77cHxmCwjPxDbbLo=
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr22434508ejb.521.1622464184476;
 Mon, 31 May 2021 05:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528113018.52290-6-jinpu.wang@ionos.com> <202105290002.LSBHvezM-lkp@intel.com>
 <CAMGffEnoYGoNwXe75KcP8WCTXAYBKkhJ=cx3aC=4mm77stWzUA@mail.gmail.com> <20210531121725.GK1096940@ziepe.ca>
In-Reply-To: <20210531121725.GK1096940@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 31 May 2021 14:29:33 +0200
Message-ID: <CAMGffE=qe8Ki1e0QjhEpiT7UGB4s+2W3Ov9VpA++wH4uTpGE7g@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 05/20] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kernel test robot <lkp@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 2:17 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, May 31, 2021 at 01:44:22PM +0200, Jinpu Wang wrote:
> > On Fri, May 28, 2021 at 6:20 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Jack,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on rdma/for-next]
> > > [also build test WARNING on v5.13-rc3 next-20210528]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Jack-Wang/RTRS-update-for-5-14/20210528-193313
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> > > config: x86_64-randconfig-a012-20210526 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 6505c630407c5feec818f0bb1c284f9eeebf2071)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # https://github.com/0day-ci/linux/commit/66f95f659060028d1f0f91473ad1c16a6595fcac
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Jack-Wang/RTRS-update-for-5-14/20210528-193313
> > >         git checkout 66f95f659060028d1f0f91473ad1c16a6595fcac
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
> > >                    if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
> > >                        ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
> >  Thanks for the reporting.
> >
> > As the check is checking against u16 max,I think we should reduce
> > MAX_SESS_QUEUE_DEPTH to 65535, and drop the check in line rtrs-clt:
> > 1786
> >
> > Jason, you mentioned v3 is applied in for-next, I guess I'll wait when
> > you push it out, and send the patch to fix this. is it ok?
>
> Send me a fix right away and I'll fix the original patch
ok, it's here:
https://lore.kernel.org/linux-rdma/20210531122835.58329-1-jinpu.wang@ionos.com/T/#u
>
> Jason
Thanks!
