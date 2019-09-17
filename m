Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A55B51D0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfIQPwl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 11:52:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36091 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfIQPwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 11:52:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id t3so3793837wmj.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKP299nn9dAVscWnwEGtfjquUeakNIYf9tui2aZbZM0=;
        b=jdDgDADtN8x3yMOTTXEl9p6of/mhIZcOuq9lDQNLJcyuXfxihEU4kmzF2DeCj3kQcG
         S0ug0mzOtlb/Q7emX2Apa9kF62FVkKObR8J8SrA7J1xJNb0/n6K/jdht9LXmqko5ENrP
         ZzUEiVrKILWSr9+l/tn/pxMxtVtCPxeECujoaFGm5FnCzVFbwDRK3/W3JDH8D+jFteIw
         3/ETBijHdcvNoG933pa6SSs9a0MNM9ZEO6Il/U746bYeateMui/HpGXZD0dc0uMgHOtm
         sCv+06raWPUJw2NH/teoQp+SSM6CJ92nDDXX384+/qypnbECAtweqmMIye5iKsztRoos
         trHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKP299nn9dAVscWnwEGtfjquUeakNIYf9tui2aZbZM0=;
        b=crnIfCmfMCmFxOMV6jyClylD9GvNpkMtFzi9bUyS5L2tFucCKC0HOl06Z6wWwzLRqj
         6o0yLSnkqlIFqMBy+hCkJg/Dgdp9BSyVtRhbRanj32GhOvulwROa2hluPG8Z3GvSmBBu
         PAqgeYio7FlGBnez2nNrx7FGk+lmeAT+1EFEEx2Bj2MVLnQDQ9VC5CL7mejkDbUXdkKD
         zbdC4XgtAygKgnd/EfKKyhCrctWk3kSB0PUnLBD33hV0TdglBITJ0V/7yuGOjCkmwf3k
         ZqUxN6cVC79JvlXE73C+SfYEeS+Iu0BkDUpv4Z5Doxe3+YQZDtnYwLIahGHTZvVznvQK
         cidA==
X-Gm-Message-State: APjAAAX+NUzPZ/mzI+1+AXmvUTuKt8qxEASyeOyo8foaBA5rx/0BAAwg
        qh3tCDuGLU5P4KUynClF/vmoDtQviB7IpS6tV0xFuzFIF16aJA==
X-Google-Smtp-Source: APXvYqy4g+sPWDvtjuzHam2AP/YjYBLiMEbmD1GTZF1aE6eRxGVi944aZKF9bVr2VAzVelcad2qvz8kSYFdA3tCFMmU=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr4559194wma.153.1568735558937;
 Tue, 17 Sep 2019 08:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <20190916052729.GB18203@unreal> <25bd79e1-9523-8354-873a-0ff1db92659a@acm.org>
 <20190917154150.GE18203@unreal>
In-Reply-To: <20190917154150.GE18203@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 17:52:27 +0200
Message-ID: <CAMGffEmK6Crv9e1NWXxo8P2mGVfhVKZ_uZRx6_P63Uts1vu2NQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 17, 2019 at 5:42 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Sep 16, 2019 at 06:45:17AM -0700, Bart Van Assche wrote:
> > On 9/15/19 10:27 PM, Leon Romanovsky wrote:
> > > On Sun, Sep 15, 2019 at 04:30:04PM +0200, Jinpu Wang wrote:
> > > > On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > > > +/* TODO: should be configurable */
> > > > > > +#define IBTRS_PORT 1234
> > > > >
> > > > > How about converting this macro into a kernel module parameter?
> > > > Sounds good, will do.
> > >
> > > Don't rush to do it and defer it to be the last change before merging,
> > > this is controversial request which not everyone will like here.
> >
> > Hi Leon,
> >
> > If you do not agree with changing this macro into a kernel module parameter
> > please suggest an alternative.
>
> I didn't review code so my answer can be not fully accurate, but opening
> some port to use this IB* seems strange from my non-sysadmin POV.
> What about using RDMA-CM, like NVMe?
Hi Leon,

We are using rdma-cm, the port number here is same like addr_trsvcid
in NVMeoF, it controls which port
rdma_listen is listening on.

Currently, it's hardcoded, I've adapted the code to have a kernel
module parameter port_nr in ibnbd_server, so it's possible
to change it if the sysadmin wants.

Thanks,
-- 
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)
