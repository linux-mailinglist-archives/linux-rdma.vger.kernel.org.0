Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC61C43E055
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJ1MA0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 08:00:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F6C061570
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 04:57:59 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u25so3847091qve.2
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCtyrIwOYgM9Jn1ygIVC86iPptr+c3XVWeiylafavWQ=;
        b=bRQQOK1ZR5gNzQab3pPOrg0FTZhT5sUvtgIG6BYenB+C2wLBt9gp7omqAGRh2jInw9
         WbM0ysFYnd4pQs3H4xxTV/7/2PtmjU1FT7uM45m+Kv/noGShuAfYZcA8zgDY2nCz+fb3
         rOC+i+PpAIcZZaRxhQUzGIxTRYTyjC3ahS1uiMQNdashTpxWKku2mlUzAdRCvIeSMLUo
         Wl1m+2yvb6X4uBM6cknAp25IG48oqNWJgSF4kc+CYBAP5FZhKC2dGJP7FalX9sS2p4kM
         NI4ziJCzOQiR2xFCQvtwXHaA83GfT0k+2emLO11mjxstIwsxyNvn0LoKjNnLVrFIDbxL
         36ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCtyrIwOYgM9Jn1ygIVC86iPptr+c3XVWeiylafavWQ=;
        b=iAcYb6NTC1RT2f69bXtkmC6DUT6Kld/VuqDRO2Qt9KKVLjSemEQtoO2Fb7Pwcan501
         BHfSS2PjhTzI/98TVdEBLVamSPHqvlMxgfv3nJ93SPnN+ujMGU/vQlf+208E6zkQqx9s
         OYkNWfK0n68r4JVhOL1ohs0OO0DuQQjmm7bJnMgE4pi3NssmwWN6UG50HivGckGcOa7K
         NpS02XksK7bmx0q72qiX5nYSF9XC1GCzSgfkB8GbuSDhadQ76XA7eOV9u24bwLWUpFp9
         NV+NiIG8JX/5h+UEPNd9Bwrgb1yIgC9Sx++F1mTwgvsbuJwcH9CQuwOEzhw94t4ZQAbE
         Up0g==
X-Gm-Message-State: AOAM5310HOTOzPk9eKcIGUKFF1Gl2he1R9FGiS9/VrLbVNqK/5sf56fn
        WCs90HpE5VnVfytl0WO1lymzsg==
X-Google-Smtp-Source: ABdhPJzgWjy8+FdyDCBG7zYgEemE7uLUpwr0GpReliWZKWpawy0vnFIguXrxM5d0S3JhhyNcWBj6Tg==
X-Received: by 2002:a05:6214:5085:: with SMTP id kk5mr3923970qvb.12.1635422278340;
        Thu, 28 Oct 2021 04:57:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b20sm1950987qtx.89.2021.10.28.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:57:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mg42e-0031Ns-OR; Thu, 28 Oct 2021 08:57:56 -0300
Date:   Thu, 28 Oct 2021 08:57:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <gal.pressman@linux.dev>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [rdma:wip/jgg-for-next 89/95] (.text+0x1320): multiple
 definition of `ib_umem_dmabuf_get_pinned';
 drivers/infiniband/core/nldev.o:(.text+0xc260): first defined here
Message-ID: <20211028115756.GL3686969@ziepe.ca>
References: <202110281246.Ir0VGujy-lkp@intel.com>
 <14c792f4-25eb-d193-a205-1dbadd0e4d22@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c792f4-25eb-d193-a205-1dbadd0e4d22@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 11:26:45AM +0300, Gal Pressman wrote:
> On 28/10/2021 07:46, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
> > head:   c200e6a625c01880074a0c8137361dd8a927fbb4
> > commit: 4f9e1c0814f9ca8002820d4f7a38d0992add454e [89/95] RDMA/umem: Allow pinned dmabuf umem usage
> > config: ia64-defconfig (attached as .config)
> > compiler: ia64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?id=4f9e1c0814f9ca8002820d4f7a38d0992add454e
> >         git remote add rdma https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> >         git fetch --no-tags rdma wip/jgg-for-next
> >         git checkout 4f9e1c0814f9ca8002820d4f7a38d0992add454e
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    In file included from drivers/infiniband/core/uverbs.h:47,
> >                     from drivers/infiniband/core/nldev.c:44:
> >>> include/rdma/ib_umem.h:187:24: warning: no previous prototype for 'ib_umem_dmabuf_get_pinned' [-Wmissing-prototypes]
> >      187 | struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
> >          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> >>> (.text+0x1320): multiple definition of `ib_umem_dmabuf_get_pinned'; drivers/infiniband/core/nldev.o:(.text+0xc260): first defined here
> >>>
> 
> Oh crap, this obviously needs a 'static inline'.. Jason do you want to
> squash it or should I submit a patch?

I fixed it

Jason
 
