Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49543DCEA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1I3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 04:29:17 -0400
Received: from out1.migadu.com ([91.121.223.63]:35300 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1I3Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 04:29:16 -0400
Message-ID: <14c792f4-25eb-d193-a205-1dbadd0e4d22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635409607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFHfCXgQUYk8k7QF/5L5pCra8Hd7t0I2Pp+cuZ9OUaQ=;
        b=wpu6H8hiqdAOLArDk4PleuB0PAjz5m72hcAqnfhwqqB8h5+pUHD+zRl7SztuWd3vBQ7MCr
        u3tpg3VftIYKIP8jchjHGdEWiaKQEkXV4Gpvkzc/PhDhdrKvajWtuG3GpbRAgsf7vkYMEb
        63U1ghWDjN0pRfgGmPyXO5V6pJAxb1M=
Date:   Thu, 28 Oct 2021 11:26:45 +0300
MIME-Version: 1.0
Subject: Re: [rdma:wip/jgg-for-next 89/95] (.text+0x1320): multiple definition
 of `ib_umem_dmabuf_get_pinned';
 drivers/infiniband/core/nldev.o:(.text+0xc260): first defined here
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <202110281246.Ir0VGujy-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <202110281246.Ir0VGujy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: gal.pressman@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/10/2021 07:46, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
> head:   c200e6a625c01880074a0c8137361dd8a927fbb4
> commit: 4f9e1c0814f9ca8002820d4f7a38d0992add454e [89/95] RDMA/umem: Allow pinned dmabuf umem usage
> config: ia64-defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?id=4f9e1c0814f9ca8002820d4f7a38d0992add454e
>         git remote add rdma https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
>         git fetch --no-tags rdma wip/jgg-for-next
>         git checkout 4f9e1c0814f9ca8002820d4f7a38d0992add454e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from drivers/infiniband/core/uverbs.h:47,
>                     from drivers/infiniband/core/nldev.c:44:
>>> include/rdma/ib_umem.h:187:24: warning: no previous prototype for 'ib_umem_dmabuf_get_pinned' [-Wmissing-prototypes]
>      187 | struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    ia64-linux-ld: drivers/infiniband/core/ib_core_uverbs.o: in function `ib_umem_dmabuf_get_pinned':
>>> (.text+0x1320): multiple definition of `ib_umem_dmabuf_get_pinned'; drivers/infiniband/core/nldev.o:(.text+0xc260): first defined here
>>>

Oh crap, this obviously needs a 'static inline'.. Jason do you want to
squash it or should I submit a patch?

