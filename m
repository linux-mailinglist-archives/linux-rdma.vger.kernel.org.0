Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B29395AA1
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhEaMdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 08:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhEaMdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 08:33:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA25C0613ED
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:31:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lz27so16400693ejb.11
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXQLdS59fbL30bBnmeToTKfV0UTTgBIP/vkt1KK2HWU=;
        b=eecje7j2KEpcaIgG+PC2ha1DEA/syXdWn5fKjqb/S2z6kQbYmj2NELTU0hHAAkNxMi
         5cKKgWdR59wozkmUUyN/0m9qEwtIF7Nv6v202rgLqAtCQ9HKX2ifUwRsatWBz1O/z+oH
         SzwX5nt4tGumea+VBRhzEG3BOG9Kfns7rOReNbsNWw7d6LAGMJV/tJVLuXmTR6OmaDNa
         7Yd8+RvfRoXcDNj9NR4ZTf6UP8PUrYFnIFLEsAo3QMzfDKTdmKTGRlQGtOxSRPS8xkUM
         gZyebpW9Ejgtt9byTv0jup2ppPAxw+HG9o/NqecuNtYvJ02maumNvmQ5yulVfU+x9MRX
         z9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXQLdS59fbL30bBnmeToTKfV0UTTgBIP/vkt1KK2HWU=;
        b=Sro98VakS/DkGyXZ0YHJ8HFpKJNlbc5dEj9ijr/Gn0r+NlwCYCutXAW6XKJzBEISD0
         SdAVb8jATBjhuBAWE7egN77LYGXK51VDx00Ck1CUUeSbb3K2O83zgPyF5YHwGCBRSluN
         /ib+TBawnmxpxCf2kG0cBQOW2g9l4vUTinE1SF6qKTCKaeKdwDiA0Tbpwgt+kADddfv1
         akv6DXoFftd0kc30zOmsqVyK8Y/C7VsXiL6uOsGQG7wL/RrQ1b9ieUVCj8KdsgQ5fMXm
         T/5Zj/QL/oX8Tv2v9LNVkti9QM6Htv1aTUzndslkjtwiMPBUeZ5SCoxmASwnzQFHRNze
         OR8A==
X-Gm-Message-State: AOAM5326U6EYvnqM10+Kv3+TOJEX9T92DfRvWeNjLagGQ4Lpw6LWFu8o
        okmPzqAtf+EUxBrI8OMhaGHr1FwxpvMu1FYwsbJ5yg==
X-Google-Smtp-Source: ABdhPJzPbGT4vXgPK/rMHikumyH/h0cvDwDVbvng5Ylt7L2/uY+5yxtdCFykHjeUH2a9KX7GblQvHOmrsHPgBBETsog=
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr22443077ejb.521.1622464301861;
 Mon, 31 May 2021 05:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <635def71048cbffe76e2dd324cf420d8a465ee9d.1622460676.git.leonro@nvidia.com>
In-Reply-To: <635def71048cbffe76e2dd324cf420d8a465ee9d.1622460676.git.leonro@nvidia.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 31 May 2021 14:31:31 +0200
Message-ID: <CAMGffEkNKcpKz_YL6CCrGfRpOh8m9G8ir6p=AkY_UgBd-5Bbpw@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA: Fix kernel-doc warnings about wrong comment
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        target-devel <target-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 2:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Compilation with W=1 produces warnings similar to the below.
>
>   drivers/infiniband/ulp/ipoib/ipoib_main.c:320: warning: This comment
>         starts with '/**', but isn't a kernel-doc comment. Refer
>         Documentation/doc-guide/kernel-doc.rst
>
> All such occurrences were found with the following one line
>  git grep -A 1 "\/\*\*" drivers/infiniband/
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  * Straightforward change to make our CI happy.
> ---
>  drivers/infiniband/core/iwpm_util.h       |  2 +-
>  drivers/infiniband/core/roce_gid_mgmt.c   |  5 +++--
>  drivers/infiniband/hw/hfi1/chip.c         |  4 ++--
>  drivers/infiniband/hw/hfi1/file_ops.c     |  6 +++---
>  drivers/infiniband/hw/hfi1/hfi.h          |  2 +-
>  drivers/infiniband/hw/hfi1/init.c         |  4 ++--
>  drivers/infiniband/hw/hfi1/pio.c          |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw.h       |  3 ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c    | 10 +++++-----
>  drivers/infiniband/hw/i40iw/i40iw_hmc.c   |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_utils.c |  2 +-
>  drivers/infiniband/sw/rdmavt/mr.c         |  4 ++--
>  drivers/infiniband/sw/rdmavt/qp.c         |  3 ++-
>  drivers/infiniband/sw/rdmavt/vt.c         |  4 ++--
>  drivers/infiniband/ulp/ipoib/ipoib_main.c |  7 ++++---
>  drivers/infiniband/ulp/iser/iser_verbs.c  |  2 +-
>  drivers/infiniband/ulp/isert/ib_isert.c   |  4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c    |  4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c    |  2 +-
for rtrs, looks good to me, thx!
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
