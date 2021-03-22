Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA94343825
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVFHW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVFHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 01:07:21 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF76C061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 22:07:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i3so11799980oik.7
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKFj4LRtFKByGih5mwuXygYYcSWHXq6FiyQNztA8Gx8=;
        b=lpr+ZewwMZm9u+0p5iHLXHzS56u7wuGt1gHDD6jYJ3cv5OI0yZDuYWd+ZVnPkx9vVe
         yTCg4PpwEPQW0sZI36F9YRJbaVBzel9ZFDuC9V3NXAIk9FCSpCuMgazSENKjPmIbT2Gh
         JTzgAMxY/UFprFkoCHdejAuTpiB2xH4fCvGrDE46fnnjCfEX1jsT7v39bpPCM4KNPq98
         Ehe0D/YRnenwyI5y0CvcTJAYne08rA6SSwsYqYNkUhnRq+BRRtLbWi5YGIHSPJvfMOYN
         q6vCYur+Xnag3FYCt/nBWn6Pu228A331pQVKIjrS8E0lDf80KdH5jesvUFLCoKjUZD2i
         6Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKFj4LRtFKByGih5mwuXygYYcSWHXq6FiyQNztA8Gx8=;
        b=NURjhFnTbDOZ6fUbNuOUk+1z3TGudtyM+Up1vQ8zykYNI6axW2Qa4MGaHwAuaUo1Gw
         kQUp5lo+OiW4UmV+eLw102ejefs6GuoafDp4tSg3kpzIqIlasArICsSE6qhyFyc5B28m
         FuVHxOvD/4dgpp34rw613xT07frO9aMk3jaLCi8DK0AJU9cpRafBuWGh1BCKg1OTlg6v
         l6xRxXSFE8DEkpZ6hHrwVL+lWuFtXrOqJzmrb2b6rDUIpj1EWqzZO202dnVdEqeCpZ2b
         94xKCKs4c1JoN7IbPeFz4KexXHt7AjVozyTN4g740aaVlbCT4F1OTr51JIkH9Nzn6jNW
         uDTg==
X-Gm-Message-State: AOAM530NE176ZlgrkWsw3eWinZKOpmLzcHypfrlQsk1HI0LGSeqkvm6+
        OzCFFLHt+UMRW6N2YKVB9fGNeOta6rdynF1dMCI=
X-Google-Smtp-Source: ABdhPJzFMHoqjoH0GrKzE0+R8tvrrMbU6O34R58boCa1jMDzpQvKr71YxS1UNBhyf/R7jtFahtCSPwSA3ziVXukXxz8=
X-Received: by 2002:a05:6808:1cb:: with SMTP id x11mr6330000oic.89.1616389640159;
 Sun, 21 Mar 2021 22:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com> <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com> <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
 <20210321120725.GK2356281@nvidia.com> <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
 <20210321130315.GN2356281@nvidia.com> <CAD=hENeekUYEGZszMGs5bOHZ9fb4sahkv5Jy4QW1kWzUBLfYSQ@mail.gmail.com>
 <20210321155207.GR2356281@nvidia.com>
In-Reply-To: <20210321155207.GR2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 22 Mar 2021 13:07:08 +0800
Message-ID: <CAD=hENctVhrdgsA2buZs648=PW9+Hb9WrspaeK7GEQrLfXdTxg@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Got it.  Thanks a lot for your help.

Zhu Yanjun

On Sun, Mar 21, 2021 at 11:52 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sun, Mar 21, 2021 at 10:38:45PM +0800, Zhu Yanjun wrote:
>
> > No. You suppose n_pages is very big, then prv->length will increase to
> > reach max_segment.
> > If n_pages is very small, for example, we suppose n_pages is 1, then
> > prv->length will
> > not reach max_segment.
> >
> > In fact, in my test case, n_pages is very small.
>
> n_pages is an *input* it is the number of pages in the VA range, if it
> is very small it is not a problem with this algorithm
>
> Jason
