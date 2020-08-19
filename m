Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C357249857
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSIjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSIjD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Aug 2020 04:39:03 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8BC061757;
        Wed, 19 Aug 2020 01:39:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o21so20316172oie.12;
        Wed, 19 Aug 2020 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W71/LrqAlFC3/G6z89zTm/EWsI2g+jB+qB4Bkg6curE=;
        b=IjVvBhVoSR3FYwKueuFpDWuNsDKlq1SR3TQvN4tE+a/yvNtgtHikKf5JvTXr2Armey
         OFo8wZ+MynwWOsPjvyBc1KeW6iOhXZWXYihIjaXi0sjC8jCmJC2CBad9Dwe8UcbEPMa2
         a1ULfEPX730s0meC9XaN8HFs4s8P7MxvHyKlLlAuvson1P3LshQ2tQr5kB/nZ2z7QeyT
         q72qg7KLyN/TkFHoN0S6/Cut+2nYQajIuAZbWpqmFTAYCLFNX8fc1AKLd3ds9DslzsiD
         hIeZuCb/hxEYA/Lp+tcHQsPXg+70+a836jrudMgOyQgSW4wCoBqeLokOd6BuL5GgVpIb
         k05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W71/LrqAlFC3/G6z89zTm/EWsI2g+jB+qB4Bkg6curE=;
        b=ptX6YG/QC7ndZ3owTcgJtBsl8X0u5VWyEHgxe2s+Rm/73DhWM5jOnPnDVoEMLE787l
         tDRnLocIp55zLsRmKlijCIR2xAjz28DUyHDlpAHJxBSSO6tyl8cjXiKLPnKgCpQYzhBx
         UWnXQ38eCELGBILXOCDnxKaj2m5dmlHTUuzeF3yxA/DLD6ti5wcq5nqTpB4UXspEaXOB
         Ax4GStIXIJNucUg3KvKsp2H2Ma45JzayPI/BGfWvtVag42Jtu2uLHT6Zj/QGv5FXRzui
         A+mJYXeIQr3NBw8Hxtiax9xNeXEXgkKKzZK34TRcvUu/xg5EJp1ljn6u77IsTIoXVzPW
         1p0g==
X-Gm-Message-State: AOAM530Ludv4V5OV5OMaAYVPjtBqP2l0QzE8dHHDOIcx1PP+d7y5yzSQ
        BvxIrNsPti30FS81v3eIpPPKbcNBctTCovKMDHE=
X-Google-Smtp-Source: ABdhPJxVA1KzgN4UZOZ2fKohkd/bjyUGON/hZI5e7pOIxlirCnCYNveul3+UeA9M1UocEo8mBES3PsrV0xL0Mn3X1h8=
X-Received: by 2002:aca:5102:: with SMTP id f2mr2377201oib.169.1597826342732;
 Wed, 19 Aug 2020 01:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200819075632.22285-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200819075632.22285-1-dinghao.liu@zju.edu.cn>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 19 Aug 2020 16:38:50 +0800
Message-ID: <CAD=hENdh9Lk1o6cknBptUHnQXLDUD=skuuD4rF+eLt3X4HTt0g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix memleak in rxe_mem_init_user
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When page_address() fails, umem should be freed just
> like when rxe_mem_alloc() fails.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index cdd811a45120..ce24144de16a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -205,6 +205,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
>                         vaddr = page_address(sg_page_iter_page(&sg_iter));
>                         if (!vaddr) {
>                                 pr_warn("null vaddr\n");
> +                               ib_umem_release(umem);
seems reasonable.

Thanks,

Zhu Yanjun
>                                 err = -ENOMEM;
>                                 goto err1;
>                         }
> --
> 2.17.1
>
