Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5E257F2F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHaRCp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaRCo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 13:02:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A26C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 10:02:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so925838pgb.8
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Hk3JgELmlmudrRJWmc/NJ06bHmY4/K7dJEWBf7dcams=;
        b=biunx40wPIqhoBYMENQkeNVxTAEPvcZgvGXVn0G20GxjY/wWBs0m1ymHCs9cL16RpT
         fz4TvCt4pY0TruGN2RMYaoPcgrCHXrPa2y8t0/btOI3vfAg4lh5xtZL4G1Qjn1qrqmYY
         G18QYmoMtalCscnDRiyqaYGrtIFf/QudD+lYZLPn27XqZrGf4ypXhY/nLe/QjtWQLUFh
         IeHNJ7q6MOs9chlUFFXVTf2pCnrzYDjAsH2mJXEC5dfXxVAb68vgK2t5o9yTaHGuey48
         1uQ0KoRYWJO2HStU3hbGYXNGB3PSPUezB7zQm7ES63q2qS96o3rjdKRQiGdnmMKMMf6K
         Drvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Hk3JgELmlmudrRJWmc/NJ06bHmY4/K7dJEWBf7dcams=;
        b=BG5UwOtEnAkhPUg6VTWHuUPZwvV+4HrfhvZj8mN9KHoa4pFbXI9pUEG2vUMu6TT4Nb
         vwcpHk0f6fHLzBmmJbFLO2kUqBAdiShvcrwPPxPdIXpFaeKXQV/JT97Ij7UhgTXb4Zsw
         L2opCJzIFw6I4zNGZgJwpu1s9kS9Kz+N75OlwDZvA/Pt6XhXh0VMju8nnz1WAzfa6S5R
         x6QoxbInZP0EzEnBdIwviLdJ94VjQ1/7ndHs6ddIRogbdWqVPpZDYUEhifU9N20FnY/c
         gruzH5D+JoA5EscBt5I1PO7l8WLSpuiST31jG1fhRLD0Ip4Q/4vEhw1irBLugEiotOTr
         B9gg==
X-Gm-Message-State: AOAM533EbM2dQozY6+tN/0m0K/RYl+xw0wHHVcGYFa68rWKfxHdFp+8c
        VJBmY0WzBSWqo8WrbvD2N8HKi39RS/Oc/saIoyc=
X-Google-Smtp-Source: ABdhPJz4AckYnT+RiB96kIeKEiXIbNj4k63OPDwNkst2JW89HNnlnbgvvHK09XU0JR87aAQWffIvECrZ4vN+/fdwEn4=
X-Received: by 2002:a05:6a00:22cc:: with SMTP id f12mr2054128pfj.42.1598893362675;
 Mon, 31 Aug 2020 10:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200830103209.378141-1-sagi@grimberg.me> <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
In-Reply-To: <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
Reply-To: doug@easyco.com
From:   Doug Dumitru <dougdumitruredirect@gmail.com>
Date:   Mon, 31 Aug 2020 10:02:15 -0700
Message-ID: <CAFx4rwRQ7z+sATpKuYNwTWqnepcWQeinxFjsZEEDAQobeSVACQ@mail.gmail.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 9:48 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Currently we allocate rx buffers in a single contiguous buffers
> >> for headers (iser and iscsi) and data trailer. This means
> >> that most likely the data starting offset is aligned to 76
> >> bytes (size of both headers).
> >>
> >> This worked fine for years, but at some point this broke.
> >> To fix this, we should avoid passing unaligned buffers for
> >> I/O.
> >
> > That is a bit vauge - what suddenly broke it?
>
> Somewhere around the multipage bvec work that Ming did. The issue was
> that brd assumed a 512 aligned page vector. IIRC the discussion settled
> that the block layer expects a 512B aligned buffer(s).

I will second that block layers expect "at least" 512B aligned
buffers.  Many of them get less efficient when bvecs are not full, 4K
aligned, pages.

>
> Adding Ming to the thread.



-- 
Doug Dumitru
EasyCo LLC
