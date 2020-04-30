Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943401BF370
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD3Is7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3Is6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 04:48:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88726C035494
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 01:48:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so5833602wrs.6
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2N85JzHhT3Y4BY9fAcFr0L57mikgCC64Ihg7uNMquI=;
        b=hU1MsnYl+lYvkgDTCR+UsWG68DpguLKU4qfQhInJUSOQniJo9kLkmcXSE8n8WjCfTP
         k1HvUHQuhpLQDTQHwgpQRi6CRcPYMPFW8XsxBaA2RcQAxbM0CPlAls9Gzt2VavWbYUv7
         ZS97mhTmWHAWjDvsgkZgWVwXxLVbPC2pjiR25OFJjd79oE14oQoTWRXLuvtwQGst12i/
         gUaU6YoCEJI2gByAcqlnrgQLJ/Wd1Q/gBoRJG2kpKjRCOstrcGw101vD0aHashyIQXsV
         m5b54+M5oVTTv2yb3KYLrP/gR11pV4FY177Hw4OgAASnuy/D6fp0jHifFXBcwJGJ2OHd
         njQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2N85JzHhT3Y4BY9fAcFr0L57mikgCC64Ihg7uNMquI=;
        b=YUePYY8p0GojQUyjM//EQui/jAvJSn8qjNndO+ULkutBl9yEvnyTBjZOKFQoA1bGDu
         QhuehrbesDd8M+KuTVeNZhRKVBsXpTnYBkakem1xHTehsRJd0fzRZ41Alyg/tDaXsR5M
         juFf7YJz9wZfetP4cF0R3EYN+m/Ow7tea2Wp0WjFsqSBfdO6HwKy1RqVQRVYjlkbRbQn
         nocIrOg+dZI4p3QxGzigBmLrkeAwU7aqKR/TG6J60AVFAvST+cTxeXwIP+IbaWzZDQBh
         mmyNOSJdRJBuhFT8FjC7813FETD9GXLpUII78LuPrn2vSjJ2i0regESyWvNvMjM/I3MC
         6zJw==
X-Gm-Message-State: AGi0PuZYYQYIwSo2s6Ce5ZX2+4ZyNJSER4f+bufhpZyVI5DIGjGFAghk
        onL14o4qIA/ZdSnFSLRZt+v9GWijxLoWZEf1LCoz
X-Google-Smtp-Source: APiQypJlqt/TpIXcSvF4MyKh74yfpmvxeZgVTbkQp2IMpjVXF9OQShzPuU97S+e3gzgIzYiMzH+AUkU0R66xb3lLqw0=
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr2526438wrm.192.1588236537205;
 Thu, 30 Apr 2020 01:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-24-danil.kipnis@cloud.ionos.com> <202004292210.aw7c2Yi3%lkp@intel.com>
In-Reply-To: <202004292210.aw7c2Yi3%lkp@intel.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 10:48:46 +0200
Message-ID: <CAHg0HuzGwonGEbRyN03RZ7TiD4NdFWmr+YR7u9EG4VHyTT7V4w@mail.gmail.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 5:01 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Danil,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on block/for-next]
> [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc3 next-20200428]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/block/rnbd/rnbd-clt.c:19:0:
> >> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
>     #include "rtrs.h"
>              ^~~~~~~~
>    compilation terminated.
> --
>    In file included from drivers/block/rnbd/rnbd-srv.c:15:0:
> >> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
>     #include "rtrs.h"
>              ^~~~~~~~
>    compilation terminated.
>
> vim +19 drivers/block/rnbd/rnbd-clt.h
>
> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  18
> 9e3ecd2f9c364e6 Jack Wang 2020-04-27 @19  #include "rtrs.h"
> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  20  #include "rnbd-proto.h"
> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  21  #include "rnbd-log.h"
> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  22
>
> :::::: The code at line 19 was first introduced by commit
> :::::: 9e3ecd2f9c364e67eaa3ad19424b0d7ad6daacaa block/rnbd: client: private header with client structs and functions
>
> :::::: TO: Jack Wang <jinpu.wang@cloud.ionos.com>
> :::::: CC: 0day robot <lkp@intel.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Dear kbuild test robot, dear All,

the mentioned branch with the attached config compiles without errors
on my machine. Does anybody knows how to reproduce this include file
not found error or why does it come up in the kbuild test compilation?

Thank you,
Danil.
