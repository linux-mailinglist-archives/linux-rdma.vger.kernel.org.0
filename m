Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DAD3AE2EE
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFUF5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFUF5m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:57:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C8C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:55:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so17220093edc.7
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVxW82TZajJoWvfYgmj56Y4NKLditxEUh2I4hEVgGI4=;
        b=Er2Kc/Yu5zRDtTv8WUToOEJPTJiodIBa0lujUJNY+JKKyX1Q+IlrhMMU6VkyOB9cHB
         4+h8SYXsEAcumRgcpI3ZfXdDoU0M/+CH9fjsUbiGNrfV3k3k9z83DgajBGG5hA1Zsi2f
         bE905ywnkr60nclZkDpYIqXT8XKsJuiu/bv2E2N51PZLXW9bwAM/iq6+SdIDYVVJLaZ6
         DRkVK8DIY9t37auKPjP0+l1SHVlLp431dQsqtnhC6MEiXMX0Z6F8HmyTviJE6Q5tQ68X
         J02Y3kM2MP1YVVq9ya/yWj++zSvGD2zxqWDQEx4COuBei8PH7j+f9jIgcUNpfSndRLU/
         HmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVxW82TZajJoWvfYgmj56Y4NKLditxEUh2I4hEVgGI4=;
        b=kfbE6ReOKirBJHE6hbY6+o3wWrDiKS3P4X89lNWmpHpt0kIfbw6im8v5qj29NUPJtD
         d3VfEAaeSh8hfn7mygzHISzvPI49xblIzqL2cSd9Hr+rULSka6rLkNnBHzNqjyuBn0mk
         eU1Vn/GVvZsCSDls3nzCifRohbne9h9J82Db0CD4JKGIbXbBVki63tX5QUnU3Zv1ToI3
         SblXaSrMWkVbsUVVrBcKNKURh1ChdainSK4eMksLlBBftjkr30v1Ilu2aUg2kfexSyZc
         xjhxMMRpNml/0Ct/1zB2PTDIk9o4r4669OyyUykcSHd7NLF4zYXDQG2mxVFCe+0EbueA
         DZZg==
X-Gm-Message-State: AOAM530Mu0oNQuuytwG6Czezr3dxsTwBGtYIYb2ziAMg4LR0ZIORXlQe
        uKEviUFnTlWLa83D+iBSlqZTkzkIuX1FIHGzYCCYUw==
X-Google-Smtp-Source: ABdhPJysWpjDV6IRfun4wf0RgXqcRoFxtC0vQX4615sJ2k3rWyWOVTVozw0Gd80qHWTv5Xk5kj7z2ltqt3PsSfBlq78=
X-Received: by 2002:aa7:d955:: with SMTP id l21mr241145eds.35.1624254927032;
 Sun, 20 Jun 2021 22:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210608113536.42965-1-jinpu.wang@ionos.com> <20210618165400.GA2052769@nvidia.com>
In-Reply-To: <20210618165400.GA2052769@nvidia.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 21 Jun 2021 07:55:16 +0200
Message-ID: <CAMGffEmc+UcuEZAK3vgqmd7bbq2Mv=y-g4jrc7Lk9ozwiP175Q@mail.gmail.com>
Subject: Re: [PATCH for-next 0/5] RTRS enable write path fast memory regitration
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 6:54 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Jun 08, 2021 at 01:35:31PM +0200, Jack Wang wrote:
> > Hi Jason, hi Doug, hi Jens
> >
> > Please consider to include following changes to the next merge window.
> >
> > This enables fast memory registration for write IO patch, so rtrs can
> > support bigger IO than 116k without splitting. With this in place, both
> > read/write request are more symmetric, and we can also reduce the memory
> > usage.
> >
> > The patchset is orgnized as:
> > - patch1 preparation.
> > - patch2 implement fast memory registration for write patch.
> > - patch3 reduce memory usage.
> > - patch4 raise MAX_SGEMENTs
> > - patch5 rnbd-clt to query and use the max_sgements setting.
> >
> > As the main change is in RTRS, so it's easier to go through RDMA tree, hence
> > send this patchset to linux-rdma.
> >
> > This patchset depends on: https://lore.kernel.org/linux-rdma/20210608103039.39080-1-jinpu.wang@ionos.com/T/#t
>
> It doesn't apply - please rebase and resend it
>
> Jason
Sorry for the inconvenience, just rebased and resent.
https://lore.kernel.org/linux-rdma/20210621055340.11789-1-jinpu.wang@ionos.com/T/#t

Thanks!
