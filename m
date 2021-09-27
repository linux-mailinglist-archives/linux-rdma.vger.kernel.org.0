Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D371141A181
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 23:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhI0Vu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbhI0Vu0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 17:50:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F0C061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 14:48:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g41so83392544lfv.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQziuvBfMARHu13Vd8UtdQcVHSAZAA1BW8ACAK1SnhE=;
        b=NGpFDJkITm1KfPEm3AGsnSRalQF0DwNDYxx0+9BDd5ChQE9kL6NB5KDsHAmMwVhIgP
         ACUY3BOQZVr6hHMpD6sr5qPQZLozbKu6ibg2WhIpWCB9r4XzmqAuaSYsBT/322WUD+gn
         t8lLVz5wiX7/CJTHCNVlutwPKAddZlDG1Dejg+c5P/TrWhUHDXuBN5q1PWTmbTI4VIto
         qsCm/jmnE30fATndaSCtSCkRj9+cQGETpJAdy091YpXA87AUrsFUrbi6wMN7NyuZvYGj
         UIOw6K7hzQFtdWHvMK2T8QFeL10xFIzxJr0+5y1YxIEK0t4MMs8X26ytL8QTcYvhguRp
         qt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQziuvBfMARHu13Vd8UtdQcVHSAZAA1BW8ACAK1SnhE=;
        b=1KDSjxDKlLU1kIP3JEzYiyRO+q9Q7KiQHILl6dt5u78nMUCFoOGnwYjwzqVlHiMnoV
         3y4HEzUtUSKdGnDOJQcABcqvGood8mo2JIEdvk4Dk6tkaXPf5psvrxRZ3xWePOGWPRy8
         TOq65OjAB4uVovh7qzWrQlFtaiYILOuSQHZUPaM2qAy9Gc6iXcswwmU2qWucMf0W8Ax7
         ggPj/BK0Oz/Tlx5468lSg4xvbPyenucaIYVa58dRLm0OjtR/eRcRqmUyLNKzW3+m8PFo
         CbyQ/SoGIncKZ7n+IizRThUVSM5MXCre75lTYbS7wj7npjw9ChnjXLqIuzRaqcEUA7MZ
         VwSA==
X-Gm-Message-State: AOAM5302kraiSKEyls4/8SEWzWZ53V4lBDiH/fe7I2O1Eb8iUsPynarB
        uReXwf1c2ax/rmenXq7NfUa4PCNUUVNd8qRgbXIfBA==
X-Google-Smtp-Source: ABdhPJxP+ChpDdQIABcI5f3CK9us5oK3lnIFxWcqw0cBy+9IUsI6SeIO9UhwDiMik2DcBMb6VXtvjgnuaa+Js+P7ih0=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr2204795ljd.128.1632779325708;
 Mon, 27 Sep 2021 14:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
 <20210927214715.GE964074@nvidia.com>
In-Reply-To: <20210927214715.GE964074@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 27 Sep 2021 14:48:33 -0700
Message-ID: <CAKwvOdnmbLO3+8jwwyoS3Cw_wSfr18Zqf3QyHpEJN5Dok46CQg@mail.gmail.com>
Subject: Re: Linux 5.15-rc3
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 2:47 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Sep 27, 2021 at 10:48:42PM +0200, Sedat Dilek wrote:
> > [ Please CC me I am not subscribed to LKML and linux-rdma ]
> >
> > Hi,
> >
> > with CONFIG_INFINIBAND_QIB=m I observe a build-error since Linux
> > v5.13-rc1 release.
> > This is with LLVM/Clang >= v13.0.0-rc3 on my Debian/unstable AMD64 system.
> >
> > For details see ClangBuiltLinux issue #1452 (see [1]).
> >
> > The fix is pending in rdma.git#for-rc (see [2]):
> >
> > commit  3110b942d36b961858664486d72f815d78c956c3
> > "IB/qib: Fix clang confusion of NULL pointer comparison"
> >
> > Dunno if there was a pull-request from linux-rdma folks.
> > Cannot say if it is worth taking this directly...?
>
> It should come as a PR this week, I don't think we need to do anything
> special urgent here, do we?

I think that should be fine. Thanks Jason for doing so, and Sedat for
help testing/reporting.
-- 
Thanks,
~Nick Desaulniers
