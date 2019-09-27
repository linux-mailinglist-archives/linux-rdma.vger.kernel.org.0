Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3BC0869
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfI0PTN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 11:19:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0PTN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 11:19:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so3358432wru.11
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxFwwjGIQvGB35tuuIBpdcKCYQ7m9hDDPTadLwgitXM=;
        b=UipgyVpAAVjAaGulHDsikn78p1M5NniK9+odIIu8PDOv9eSGdjW4otvsP2YLs9NrhW
         POgZ1NfThGboMaiM1lrK1KjHllzMgMvAysatWOhQf5zhawyvq+7OReAjMKy6u1rvWJSM
         Lmp4IHzN5I+PciEUDkWhGkhNJ7Wvq7Rb/1uSpBvQvzXmfJGqvZtHlX+N8HDLjM/zfHL6
         Nb0ke4Nh3+8DVPiebqVWsYiMGDeGgWlOPPF1Fy65+9247nIEw+YhU2R3m0EKQDvuHfrw
         YmDt+zt5EFVpHt5yNbdW5xXVBzq4bzGTup2hQlVbkF5xymIxmwd1rrXFRHO856aCpvYf
         Jumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxFwwjGIQvGB35tuuIBpdcKCYQ7m9hDDPTadLwgitXM=;
        b=mxW2W4hfNuqGR3RH4jsgmW1rcQWytJ45YegH80ZEWklZunjIcYL3PmYwKQH0S8CGy7
         D0V1NjrrCwcoI7MTETnwDFM5eda4i/T8Ch9yar1kw3pLOOTDqEpakyEKnZr8CVyQc8ou
         hrJd/9oXf1H2+OH0nABQIsYYMA0VADITa73ptnjiaroaZdf+BDCVScncxVC1ggjawdHB
         vfTJs9J3CuO7y698Jfb5kN/GEiQbg6YP2TZ8nSGOVTD9DKEI8lWYcOsGeZBoNuTZfev5
         kwDmb6E3x6+u43ceWaXS/Uyr2JOn6oOp53ZViyqX25h7AO9ZGxyFfBBGkq8z47+LVsvv
         hq1w==
X-Gm-Message-State: APjAAAV0Q58By/hILbYJr0ZBqNK8WVTnbST/czDOHfZKVF3Udktbi/xd
        k2Mu56uzlWhVReEnQAr4QtO4XgH+H+PrkAcxMogI7w==
X-Google-Smtp-Source: APXvYqzJheU9PEnvAxin9mriP0YyxdX5qB3FgPupSBVknghMWrEyDf85Ash1qXk+9Fys9bWH4kAgH/HAKC4sepowMAs=
X-Received: by 2002:adf:ea10:: with SMTP id q16mr3617247wrm.356.1569597551685;
 Fri, 27 Sep 2019 08:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-11-jinpuwang@gmail.com>
 <ab36427b-a737-9544-fbe8-cd53c0780994@acm.org> <CAMGffEmuY+ebhJz1iff7Cnb=qdHuhBaSs=DAKP_iKTOb2Ao2PA@mail.gmail.com>
 <c8f76dbc-0fb7-e137-3a1c-b72b3ebb5875@acm.org>
In-Reply-To: <c8f76dbc-0fb7-e137-3a1c-b72b3ebb5875@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 17:19:00 +0200
Message-ID: <CAMGffEkJA361624qkOJ0h6NmXFEMc4Vg=JiB7q86wE_a4=JF-g@mail.gmail.com>
Subject: Re: [PATCH v4 10/25] ibtrs: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
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

On Fri, Sep 27, 2019 at 5:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/27/19 8:03 AM, Jinpu Wang wrote:
> > On Tue, Sep 24, 2019 at 1:49 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 6/20/19 8:03 AM, Jack Wang wrote:
> >>> +static char cq_affinity_list[256] = "";
> >>
> >> No empty initializers for file-scope variables please.
>  >
> > Is it guaranteed by the compiler, the file-scope variables will be
> > empty initialized?
>
> That is guaranteed by the C standard. See also
> https://stackoverflow.com/questions/3373108/why-are-static-variables-auto-initialized-to-zero.
>
> Bart.
Thanks, will remove the initializer.
