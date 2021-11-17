Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4883545464D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 13:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhKQMWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 07:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhKQMWF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 07:22:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412EC061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 04:19:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so7416355lfv.10
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 04:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nQjB+6EgeZqR6BIdqPCZ7wONGV4Mm03Gr6wAkuuSZg=;
        b=igSSX7zLvvrCiUQepddYuLaZo77BHKqv2cZ6Fn3GygSOcpjVWeaBL1a5RuAL54rUmL
         6q95xbYSRJfPDky+1+IdO77Fgj4W4uI7DlFVRXrmcmem7KUC8jkIo8PAlPQdXSMlMvQz
         6ZCV07YFDKOCQQKu4yLrdscQDe8m4QUlms8V0FCKvgTWETQL2l22D/cXEdFeP+NG7dwA
         B818F/7r0jbixEPG4GWiOo5zLOFoQdx7FFX/7ROWCJMQiIToKVbpnKyrLA3QcWDf/F4w
         D5N8lfyqGVNHDMu5JI+wDzd8I3QQ9qKrR2+CVNzn9akUpBlc/qw5xfGPD4BP54Mv79cW
         +hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nQjB+6EgeZqR6BIdqPCZ7wONGV4Mm03Gr6wAkuuSZg=;
        b=U0WdXV3cPDDSiX5l69lkZ0pqKKwvvQPU6d1NvKvnU8LVAGIz+n50RP4tQd+4TVt6XK
         EbfJKbDs7Wb/z9rFgTbSsQq7dRS3rQ2WkmBRLefsLH6FkZeUU+tvJ2xQH4zLC+i4Jncr
         GX4I6xyGh7bwBGBE9h04iyLmiWBTDD856kEB1uiEPjBIjqCvjHsfIyEdEeP2QxrRMuyA
         pG37nJeYH/5rtXeWMKQVWW71jCDgUZ58DuGKswAsqai5RuiJQGvEFiEil8vZX7n5ePJ+
         vjhaLCVCakfq44YXp1gxcgbKsvjnKtfild8K94WGZqV9uuMWUkI6M7xllmvnb73vBGX/
         U9Ag==
X-Gm-Message-State: AOAM5319Ko/8LFWStiFjvGo0e5dSdOck63Xks5PmTrx7T3mnALBet6zN
        MLSjOASJ6eLkOviXfKTLQ4e/QB4HHgmEgsFLV+8Ptg==
X-Google-Smtp-Source: ABdhPJzENhUj8bIjjEHVkG9KHN2bRVriXh/4AW04LQiobtEJy9Jddax8soa4I7dgfxkDKlJSHP0Lqel13MrxH7CC7/s=
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr7411423ljq.251.1637151543892;
 Wed, 17 Nov 2021 04:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20211115101519.27210-1-jinpu.wang@ionos.com> <YZTyuxOCScNeeaTl@unreal>
In-Reply-To: <YZTyuxOCScNeeaTl@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 17 Nov 2021 13:18:52 +0100
Message-ID: <CAMGffEmccCwCWUnnbpgAUPEY5e+fCNGYyQc1W=eNPvbETMgEVg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/mlx4: Do not fail the registration on port stats
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        yishaih@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 1:17 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Nov 15, 2021 at 11:15:19AM +0100, Jack Wang wrote:
> > If the FW doesn't support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT,
> > mlx4 driver will fail the ib_setup_port_attrs, which is called
> > from ib_register_device/enable_device_and_get, in the end leads
> > to device not detected[1][2]
> >
> > To fix it, add a new mlx4_ib_hw_stats_ops1, w/o alloc_hw_port_stats
> > if FW does not support MLX4_DEV_CAP_FLAG2_DIAG_PER_PORT.
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > [2] https://lore.kernel.org/linux-rdma/CAMGffEn2wvEnmzc0xe=xYiCLqpphiHDBxCxqAELrBofbUAMQxw@mail.gmail.com/T/#t
> >
> > Fixes: 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats() ops to port and device variants")
> >
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/hw/mlx4/main.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
>
> Just a nitpick, no need for a blank line between Fixes line and SOB.
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Thanks for the review, I will remember not to add the blank line next time.
