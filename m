Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A711D4670E6
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 04:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378361AbhLCDzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 22:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhLCDzU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 22:55:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D0C061757
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 19:51:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id l22so3342987lfg.7
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 19:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Vn1sEJP3rdiLC+VobT2SRCFUa76GT+sV4jtOkk4WpQ=;
        b=k7z3usEdc4wwNetvAxkaV+0JFAzAL5pL6swGTjLadTuWbVQKIwFJobt/wgduuAaAZB
         A7Ih4uAChPccnOc88KF8nOC5bYIkSUuvvGkL2GBxz4WZBXSPf4Fy3Squ1Q3+KL6PzlJl
         DUeDauIZVJFc/MwyZ0DXMeH8p+Ur9poFxpL7h4eytQIeJFVC2juVcjh6f17OxA1Cg4+q
         v2nwb1IuktPHZePZEzk/9WrzWV1U40/fsx+qPxwzW/MEgGwFfQdk0yH2LbVNmxj3Atpq
         fl4Y1aY5WFpnfmLdtmQOc0qpQGXe9us6UEWYeZklRaEbWRg/Ubv2PYXx+MgAiG5C+L52
         jOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Vn1sEJP3rdiLC+VobT2SRCFUa76GT+sV4jtOkk4WpQ=;
        b=OfLiW+8WjgCReuIK4shR2+cY549f6q3nsORLbKTJ36KDr3TeQz2KDLAdD6V+w1b2rg
         Ap8zA5RlBsoWChHatfD9s5av7h+oHRBle/M2Gs2EkkM4UZZzEQqRIp4lLzGr9sVBA2mO
         8axsd1ih8psWdWkrT4jcEmChronVcEJRsh2DqlVNWvjf9s4NtwHL5x7IocjILF9HAcpM
         1JHW6JGn8OK26Ilmc8+rit6L6hHnbnJeHlYQIvUANh4CNVlJHUUdZ91ZLZVj2wbkYC0p
         834Rb9RCM+TUCTi3xOIx13IpGrI8G61n0NhHQucbjiq9xXH8yNV2VTPskb5POZM2Yg6V
         pIYg==
X-Gm-Message-State: AOAM532MSgqYUvgiBDIJX7uoABR9nQN5p+k7HZiNfLxYtfg9jkwH2Y2t
        SAtIPHPj6IZfJjBNoHX25OKHNY9V1kxP9M28mT+WXA==
X-Google-Smtp-Source: ABdhPJzFUp4XBCsuPZlvimfYoc9hTTJ2FHaXf4B6prRnlQV5SWsUZ5WHEPTXjHu7V1T3VfnUy6M3clNJg3DdKipvI6o=
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr15113188lfv.523.1638503515295;
 Thu, 02 Dec 2021 19:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20211122110817.33319-1-mie@igel.co.jp>
In-Reply-To: <20211122110817.33319-1-mie@igel.co.jp>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 3 Dec 2021 12:51:44 +0900
Message-ID: <CANXvt5oB8_2sDGccSiTMqeLYGi3Vuo-6NnHJ9PGgZZMv=fnUVw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] RDMA/rxe: Add dma-buf support
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi maintainers,

Could you please review this patch series?

Regards,
Shunsuke Mie

2021=E5=B9=B411=E6=9C=8822=E6=97=A5(=E6=9C=88) 20:08 Shunsuke Mie <mie@igel=
.co.jp>:
>
> This patch series add a dma-buf support for rxe driver.
>
> A dma-buf based memory registering has beed introduced to use the memory
> region that lack of associated page structures (e.g. device memory and CM=
A
> managed memory) [1]. However, to use the dma-buf based memory, each rdma
> device drivers require add some implementation. The rxe driver has not
> support yet.
>
> [1] https://www.spinics.net/lists/linux-rdma/msg98592.html
>
> To enable to use the dma-buf memory in rxe rdma device, add some changes
> and implementation in this patch series.
>
> This series consists of two patches. The first patch changes the IB core
> to support for rdma drivers that has not dma device. The secound patch ad=
ds
> the dma-buf support to rxe driver.
>
> Related user space RDMA library changes are provided as a separate patch.
>
> v4:
> * Fix warnings, unused variable and casting
> v3: https://www.spinics.net/lists/linux-rdma/msg106776.html
> * Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc6+)
> * Fix to use dma-buf-map helpers
> v2: https://www.spinics.net/lists/linux-rdma/msg105928.html
> * Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc1+)
> * Instead of using a dummy dma_device to attach dma-buf, just store
>   dma-buf to use software RDMA driver
> * Use dma-buf vmap() interface
> * Check to pass tests of rdma-core
> v1: https://www.spinics.net/lists/linux-rdma/msg105376.html
> * The initial patch set
> * Use ib_device as dma_device.
> * Use dma-buf dynamic attach interface
> * Add dma-buf support to rxe device
>
> Shunsuke Mie (2):
>   RDMA/umem: Change for rdma devices has not dma device
>   RDMA/rxe: Add dma-buf support
>
>  drivers/infiniband/core/umem_dmabuf.c |  20 ++++-
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 113 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
>  include/rdma/ib_umem.h                |   1 +
>  5 files changed, 166 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
