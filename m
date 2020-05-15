Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50131D51CB
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOOjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgEOOjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 May 2020 10:39:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E11C05BD09
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 07:39:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h16so2417110eds.5
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2020 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2VffbjNRn/hIG8YGeScI30zMZc3Q8yYP/kX8vo17MQ=;
        b=VmPqDHSrw7woxyrqt8DCU3c7jPIpUxTnoTjE0E349n9Rw0gHx9UnmlRme6+JY0TXS4
         JuMfqhRE9fwgpchjIdDZryx0jBDgf9zXQbFmqw6t52VcWoeODDqtfgd8x9glMAya5NVP
         hK6TOt+ybWxwkKkfs3q96WiQwUvrJ4j/QcgAZZ4nd8bVCGmqLb7RUEtL72q3jFuuexHY
         RIcUhaWwWROCqDrwf2qsYaTMDcAhXG3cp/jnRFFuPOp8lJgAagnPhrvpq+hSq3uYOl6t
         nFAKsXsQkbyT9i/TZhM9BPPqdelH57dUhXvsV/CO0RC4EquiMvmkHKDwQU0NrQt/FmKT
         0pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2VffbjNRn/hIG8YGeScI30zMZc3Q8yYP/kX8vo17MQ=;
        b=SaXUV1qs3XG0PpHg9dZJXpK9rrmdFAQA1wvsd5UyOio/xNGTp3yaSXxCxtvqWy+xAB
         6XScPZ4zr6lDo8Ctbd2+6CqWylb0qvvzdR9f6wwYgHTBqECbO/hRbiX1otm9xNzDuYp6
         5ThfirmUX2NhoHpxQEzyZ8vLd/uF8VjnIu1DuHAfwZp6mYEt02HAuqZXfMV5SHdpPIkv
         sH5+PHNKMg2nrW3mOQMU6ZP/wFX9Lt3uc+ZEJ8Z9q7XYGbVFO9MTbZyLAMW+GfLw8cT0
         PyHz5Ty/y8dZiM9UwhiI3yrZtdVi7D4RKVUFEztnhKhiwUBFGsHeZjg6tuUKOYG0dsEJ
         3VnQ==
X-Gm-Message-State: AOAM530Vizn6PjtxRi+0zxrdCyNdtVa+kXFA0RuZkVABtR0N4w3JhKfU
        FYa4aq84EvR7XC4KLPul/jB2GCMvYW3a6WCX2IDRIg==
X-Google-Smtp-Source: ABdhPJzMJ1q32NljMhLiqfWLMarIBo67FcKd3tUwshX5jswNyqESrr1W012P1tM9iGaWo4h5NGdXDia7Gs0yjXad30k=
X-Received: by 2002:a05:6402:1596:: with SMTP id c22mr3352804edv.100.1589553592331;
 Fri, 15 May 2020 07:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
 <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com> <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
In-Reply-To: <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 15 May 2020 16:39:41 +0200
Message-ID: <CAMGffE=NJfdMzbv7wk0XR902UQPNDdBjCK+ATe+P_JcWbSqoew@mail.gmail.com>
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 15, 2020 at 3:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/20 4:29 AM, Danil Kipnis wrote:
> > Hi Jens,
> >
> > we've fixed the kbuild cross-compile problem identified for our
> > patches for 5.7-rc4. The block part has been reviewed by Bart van
> > Assche (thanks a lot Bart), we also replaced idr by xarray there as
> > Jason suggested. You planned to queue us
> > for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> > you please give Jason an OK to take this through the rdma tree, see
> > https://www.spinics.net/lists/linux-rdma/msg91400.html?
>
> My main worry isn't the current state of it, it's more how it's going
> to be handled going forward. If you're definitely going to maintain
> the upstream code in a suitable fashion, and not maintain an on-the-side
> version that you push to clients, then I'm fine with it going upstream
> and you can add my acked-by to the block part of the series.
>
> But maintaining the upstream version as the canonical version is key
> here.
>
> --
> Jens Axboe

Hi Jens,

Thank you very much for your reply.  As mentioned in the past, we are
committed to maintaining the code once
it's in upstream,  we tried hard to make sure the upstream version is
compatible with our in house version, so
we can switch to the upstream version in the future, the main
difference is the driver name/sysfs, we have to adapt
other in house tools which use the old "ibnbd/ibtrs" names to new
"rnbd/rtrs" names, it will take a bit time, but it will
happen for sure.

And we will follow the upstream process to push RNBD/RTRS further.

Regards!
Jack Wang
