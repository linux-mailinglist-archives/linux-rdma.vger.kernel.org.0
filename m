Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC757351FC6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhDAT1r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhDAT1k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 15:27:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA10C03D20C
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 12:07:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so4429643ejs.3
        for <linux-rdma@vger.kernel.org>; Thu, 01 Apr 2021 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReZVEtM9J61L0fWBmSMtT0TzWlwYXuSxyI0YavUpvwQ=;
        b=Mv2QHDL9GNcBcYCNlNHTwQBEAL9lAnBXNBtDoFCkCOgwvfRMa7MrzMxk+IkLUVZrno
         TYRUdqtpXmDN1Uw4Vtpg0LrJUQiMj6MWK7MQabBVK/XOP70+/z6aRjcXEEHwOXNAr7xC
         itgBOfaaebvHa9i4ciEBrTeCqjJuQLxlxdh4Dclb8E+RAWqWFql6fNcnuPYDBdjULi1o
         keu10LZGQX8UADtDrgn1DdPFlRTrovJjMinXGTC7F9Tyw5cbbljpVZmuWX7GRQpj/bhr
         UCFOboXnKvkH55BcqFRgiStW6tIfEIzi/9qK964rYsAtYIYHYVc08vESj1Ljnis92l21
         Fxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReZVEtM9J61L0fWBmSMtT0TzWlwYXuSxyI0YavUpvwQ=;
        b=oGEcMAy82NxtXCcJSoB+iDqDbEOemu5cawHeEHxS61ZWr4iJ2lFS3w1awELSvLxyYg
         JcEe/fcY0LiqZD1W+5oxmKmSZOJ/hk6aCGlLTZ8O+RAbNbnMwOl5XNZpI8EngGccepBi
         vwHz1tCfwcyOQb9eA4Grav2wZzxL4VEsS+5iE362+M7wV0vV8rhulOItU+TapquOHeWp
         dqigJaEQkhcxV0zl2KEhGGrZlUPZLqKTCM5hPJZVnPRyYIgkUfyOnGMEgLL0mnJImldM
         GyKaZ7B0RjXm67duA5mU+dWfBquTR63VcvoKnDBbPILkPb8Pv8QGLTt0cJ7OMk7XVm1G
         c1Og==
X-Gm-Message-State: AOAM5336FRSY7er89or8GN5zVfBOFKvnkSuNZVkCeg81K+qUjTNcapJo
        R5BLWl+05GU5/nY3GBdMKfC3pZpdVVBdaVdZvxURuA==
X-Google-Smtp-Source: ABdhPJxIbDVV6vy80c1iBiWfVMxU4KIvXF2NZoP48Ho4o6z3qnKmUiosIvv+vIi5v6S5yhlTBzMc4BEBqvd8kOTZfws=
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr10710251ejg.330.1617304036951;
 Thu, 01 Apr 2021 12:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-6-gi-oh.kim@ionos.com>
 <20210401183755.GA1645857@nvidia.com>
In-Reply-To: <20210401183755.GA1645857@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 1 Apr 2021 21:06:41 +0200
Message-ID: <CAJX1YtaPuypchC7hSDt-FF1kQTWBW8v=iBtb1mZzbVmYf30L6Q@mail.gmail.com>
Subject: Re: [PATCH for-next 05/22] docs: fault-injection: Add fault-injection
 manual of RTRS
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 1, 2021 at 8:37 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:32:51PM +0100, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > It describes how to use the fault-injection of RTRS.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > ---
> >  .../fault-injection/rtrs-fault-injection.rst  | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst
>
> You need to break this giant series up and CC the relavent reviewers.
>
> In this case the series should stop here and CC people interested in
> docs and fault injection in general. Look at the maintainer file and
> git history.
>
> Jason

Hi Jason,

Ok, I will send patch series v3 excluding patches for the fault injection.

The patch series for fault injection code and documents will include a CC list
of people relevant to the fault injection feature.

Thank you for the review.
