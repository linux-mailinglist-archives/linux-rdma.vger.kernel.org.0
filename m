Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383FA35EC10
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 07:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbhDNFA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 01:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbhDNFA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 01:00:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F9C061574
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 22:00:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mh2so7826735ejb.8
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 22:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpcp0gw946vR9pywb1QNIL8m+XJv+zoUL+/9q7k8eHQ=;
        b=eHCfzyCKedp3u0qZsWr9793/hfJHscEd6v4mas4yZknTl+4PhEBd06ZEEJ3+ifMyN5
         8HFtryZ/KiKb5HoYiE+3xYpFXATqF5qvjHO/yj6VAVHWBZh4wSBNyULqXpMZXO/89NnZ
         USW63OJKsMBJPIA1fwRp/C+e7WqaCjXbIqUQhPHsCx4PxGwwx5I0D894zQFIzRB9VUyl
         l71Qx2k1enYVK45rYcj7YIqH5krDhbktJZtz6IgpfB+0+9QW7hXH6cRgItZVy245SQRV
         hTZwZU/JyhjpJAnNpc47+k/wlNpA53sBrhzgQc9wQ4euS7O0DGnyRvXIXV3p3k24Xvet
         iZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpcp0gw946vR9pywb1QNIL8m+XJv+zoUL+/9q7k8eHQ=;
        b=tx2SXGITrhScBSjxofc/R5bWkBwkUBBwd4GrXdWwNqQVjZxl+3PsGXVCdGMvngo/5+
         XKa8x/45R7mEcqd4+zbeGtcHVIXsAM7pGxYKU1d3CGbm68aUtKBF7IJY9VB/307c+/04
         iSPUG5iyq4tx10oau909YPo07wrQbHOQcW6rfKyv34EsRGj3pb9Cs+OTlHujvy0LOsOS
         jt61l9muhko3qyRL11M+xuTmJeat2Nl39Vk/txTwrHjM1O16UeXfe7+7y8Fs5I4iEmDh
         smtXPPoVcbPt7Ltg14BcZH0TH1MhnR5TKMNnZPlmORBwyrxcblvU+XitKYUUPeDt1PT+
         Ljyw==
X-Gm-Message-State: AOAM531gNLhbS2aKdSqKmLIP/e/i5y1ukl0nKHVJROqX4wVh0c2zx7V7
        HAxtVNCYVlXxw2wkzQbEZLAcQoID5Rp6OuByNe/pDw==
X-Google-Smtp-Source: ABdhPJxQCdoaRz2Y62qhQCIlNkwmRjZFwkFfv8eXtdkOWZqDmqJQUCnn90qDfX5V7D+GU3wky8NccUL/Nem0+yQrJUI=
X-Received: by 2002:a17:906:b2d8:: with SMTP id cf24mr13913296ejb.305.1618376435966;
 Tue, 13 Apr 2021 22:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210407113444.150961-1-gi-oh.kim@ionos.com> <20210413224723.GA1370930@nvidia.com>
In-Reply-To: <20210413224723.GA1370930@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 14 Apr 2021 06:59:59 +0200
Message-ID: <CAJX1YtYCAy09uvNtdq=UM+rWLo0SWaGC17XxZxUf_9ZcmhBWbw@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 0/4] New multipath policy for RTRS client
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 14, 2021 at 12:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Apr 07, 2021 at 01:34:40PM +0200, Gioh Kim wrote:
> > This patch set introduces new multipath policy 'min-latency'.
> > The latency is a time calculated by the heart-beat messages. Whenever
> > the client sends heart-beat message, it checks the time gap between
> > sending the heart-beat message and receiving the ACK. So this value
> > can be changed regularly.
> > If client has multi-path, it can send IO via a path having the least
> > latency.
> >
> > V3->V2: use sysfs_emit instead of scnprintf
> > V2->V1: use sysfs_emit instead of sprintf
> >
> > Gioh Kim (3):
> >   RDMA/rtrs-clt: Add a minimum latency multipath policy
> >   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
> >   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
>
> Applied to for-next, thanks
>
> Please be mindful about the subjects, rdma subject start with a
> capital letter after the tag
>
> > Md Haris Iqbal (1):
> >   RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
> >     stats
>
> This one was replaced by that other patch

Hi Jason,

"RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats"
This patch is still necessary. Please apply that patch.

As I wrote in the description of patch
"RDMA/rtrs-clt: destroy sysfs after removing session from active list",
each function still should check the session status because closing
or error recovery paths can change the status.

For example, the client sends the heart-beat and does not get the
response, it changes the session status and stops IO processing.
It is ok if the status is changed after checking status because
the error recovery path does not free memory and only tries to
reconnection.

And closing the session changes the session status and flush all IO,
and then free memory.

Thank you for the review.
