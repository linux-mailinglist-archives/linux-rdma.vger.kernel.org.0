Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB53959DA
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEaLqQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhEaLqO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 07:46:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164AC061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 04:44:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t15so3259701eju.3
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EydTfNejvnx1MWte5xgg5ijqPKeq9Yb+Ijh5yt3VAL8=;
        b=CaGMSsuQb9RIynLZIK6i5VQ/yF1Px/VNZW44iFxr0PTJsWtQKqKsNEH/0LFO01AxHq
         A635ySjPrT+aVQ8PJH30Rfc2Yp5F+HwzenY3lQdCq0j/nOp56Dj9vK35Lu127TXsVVT7
         A21yQ4pUzwd0XBRRf0ZixR0aZbSg1VKvXf5N7SKbs0mMvy7Mhazt3ZBXbeZ9OvcvtXlI
         8Qz0rDeFPvA9hSlcBjRJjuVnzEy9ugVG8b95bLt0Qw6DpOmshWHUNSX+qAsAvvfAbPKj
         NKqWde1fKVfkjCs3u7+VJL0f3B2jdR9eEjyFpiWjImpV5UWv8Efz4OwrIDFBtrgso5/j
         GY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EydTfNejvnx1MWte5xgg5ijqPKeq9Yb+Ijh5yt3VAL8=;
        b=sNFG4pbGKWi7DnVcfVtIZ8WbRtqKxYj/Zq/G5jT5ZdnVFZly1iFqPoVkPtdFOVuyLt
         7YOEBtBajqoavtnc90B/c8qgbT30/pFf027Xbf4UIDcGGsKJ3ucXegyfRo5uA2632ekg
         fBrabEGNeNVjQg7UqmnJy1dWAY/GBql/jmKcuAkbFBlstl0oOkw2Hc0fvU8JWyNI0jIy
         j2pPnp9otnRiVvIWGkqjzLSEGn0a0COE62R+Q8xWnQWsomYZewfLK6HsPP37C+g9Mf3m
         9fI67xtTqq8BmU4rADfDU3eyj/Zgjf6ek4uG6/SX4uc6ZnA3+eqv0aWpZiYDOA3+3/G+
         rNww==
X-Gm-Message-State: AOAM5323NHroOtVO9K0i9lue2gczVs2GuwlyPo6siKiIyAKavVa6YLVC
        KDWFVqnA7S7qo6A8NRLSQ+4lMKnkkCNz3CTVKgRAJA==
X-Google-Smtp-Source: ABdhPJzovIDf8QYXAjnVRJ9KDv8o/ayiHBd73wOaHTUiISUhD2liln47gjPlkohSorKGINYAd+b73vKxqL/xzT9V14A=
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr7915454ejc.389.1622461473395;
 Mon, 31 May 2021 04:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210528113018.52290-6-jinpu.wang@ionos.com> <202105290002.LSBHvezM-lkp@intel.com>
In-Reply-To: <202105290002.LSBHvezM-lkp@intel.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 31 May 2021 13:44:22 +0200
Message-ID: <CAMGffEnoYGoNwXe75KcP8WCTXAYBKkhJ=cx3aC=4mm77stWzUA@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 05/20] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
To:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 6:20 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jack,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on v5.13-rc3 next-20210528]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Jack-Wang/RTRS-update-for-5-14/20210528-193313
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: x86_64-randconfig-a012-20210526 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 6505c630407c5feec818f0bb1c284f9eeebf2071)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/66f95f659060028d1f0f91473ad1c16a6595fcac
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jack-Wang/RTRS-update-for-5-14/20210528-193313
>         git checkout 66f95f659060028d1f0f91473ad1c16a6595fcac
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
>                    if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
>                        ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
 Thanks for the reporting.

As the check is checking against u16 max,I think we should reduce
MAX_SESS_QUEUE_DEPTH to 65535, and drop the check in line rtrs-clt:
1786

Jason, you mentioned v3 is applied in for-next, I guess I'll wait when
you push it out, and send the patch to fix this. is it ok?

Thanks!
