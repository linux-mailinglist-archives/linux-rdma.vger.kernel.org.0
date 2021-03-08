Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC93305F1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Mar 2021 03:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhCHCoj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 21:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhCHCoV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Mar 2021 21:44:21 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F082C06174A
        for <linux-rdma@vger.kernel.org>; Sun,  7 Mar 2021 18:44:21 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j8so7859399otc.0
        for <linux-rdma@vger.kernel.org>; Sun, 07 Mar 2021 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CdzPq+S8Vjt9CBJwR9+w8V/SFjibrunl2AAooa7wIY=;
        b=b5wFdKJh5Sx61TdbdaS7+nvpti2+ilc2kf0Kj67V/y0R+8U8L4BOKpaJevrHJRWHKp
         bY1Bv5iOxapu+9tXtGe3wlTqIN+OrnTI/taO4AuyjfUYvgSQffYECLC/VbKWEG56HHPQ
         oeFl7ZRqaCboYGG5wswEeZH1p03S4Pa2UdGhdgWXzaeF9Y/0GykNq/E4AYi1eiYrNDbQ
         b9Ehy9Q9oEGm9vJe9w47sOfD/Y0IHuYYnj/Dgy2bB7oj2C7xloAQb6zzYwB79EJK28rB
         EgiaiqAftih+Tewh/0oHJu3G/qk1F6xieXzwdz2BsbktxyzJ33p20GwZqQMfaLpM3kaC
         4Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CdzPq+S8Vjt9CBJwR9+w8V/SFjibrunl2AAooa7wIY=;
        b=Ojcp9QxtgXPQv3AOmRJwXls2ZAisphEmSNP8yHZ/ceRUcDnQQVAbHWUwifiHxE0JHn
         Ah00tzEJFBAummRvpbIvKpGplVUQtcsytXFAbClPspOuVSh8j/LUlTQFFNeznwsZO+zl
         m0wWt1lflL7eIe3LPORyVwaty8EUBt78LOLBMdRxhsRS1wetQsPwbf4Qih8lJrTntGP0
         K7B//q2G+XrEr3eOFqpA2htJgUYDkF/3kdpTtUqKhVRtXNY1r9vigAlgN53oVdVLD0Yy
         XvntdpOKai8BKzi0Z9Ba2cluHt/+JWj/mt+580jlmydpIcCR0Xkg9foMRiiVaWY2Ub9k
         8j9g==
X-Gm-Message-State: AOAM530ELwc1WpBgk5sA6pyeUIjiUE2vcyOdi0IUbaeGFde0yn3yDpwo
        G9gBZyrhojjcxY/8ZatUwnndpx7Fboi61vC6A+I=
X-Google-Smtp-Source: ABdhPJytZAd05uyJIq/eYZFpezQ8S5ENn8TsYi9v1FU1tcoYtQmxoANxfOfvtjuQln6Y500Nl67s/EtVLeayfqoqBa8=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr17810651otu.59.1615171461016;
 Sun, 07 Mar 2021 18:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
In-Reply-To: <YEUL2vdlWFEbZqLb@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 8 Mar 2021 10:44:10 +0800
Message-ID: <CAD=hENc0wa59Ms7LCdCDj3qOyQyOnJQarM8YVFnsod70V9w6XQ@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 8, 2021 at 1:22 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Mar 07, 2021 at 10:28:33PM +0800, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > After the commit ("RDMA/umem: Move to allocate SG table from pages"),
> > the sg list from ib_ume_get is like the following:
> > "
> > sg_dma_address(sg):0x4b3c1ce000
> > sg_dma_address(sg):0x4c3c1cd000
> > sg_dma_address(sg):0x4d3c1cc000
> > sg_dma_address(sg):0x4e3c1cb000
> > "
> >
> > But sometimes, we need sg list like the following:
> > "
> > sg_dma_address(sg):0x203b400000
> > sg_dma_address(sg):0x213b200000
> > sg_dma_address(sg):0x223b000000
> > sg_dma_address(sg):0x233ae00000
> > sg_dma_address(sg):0x243ac00000
> > "
> > The function ib_umem_add_sg_table can provide the sg list like the
> > second. And this function is removed in the commit ("RDMA/umem: Move
> > to allocate SG table from pages"). Now I add it back.
> >
> > The new function is ib_umem_get to ib_umem_hugepage_get that calls
> > ib_umem_add_sg_table.
> >
> > This function ib_umem_huagepage_get can get 4K, 2M sg list dma address.
> >
> > Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> >  drivers/infiniband/core/umem.c | 197 +++++++++++++++++++++++++++++++++
> >  include/rdma/ib_umem.h         |   3 +
> >  2 files changed, 200 insertions(+)
>
> You didn't use newly introduced function and didn't really explain why
> it is needed.

OK. I will explain later.

Zhu Yanjun

>
> Thanks
