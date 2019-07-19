Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701C26E621
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2019 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfGSNM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jul 2019 09:12:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47005 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfGSNM6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jul 2019 09:12:58 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so58196567iol.13
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jul 2019 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s91tKYIQeKJmNASGzuZv62jiVZtvz7cNLDd/Mhsd4sI=;
        b=Eq21zHlTIxuHyTj24874Uia3TBD6JWRoJBGL8HEpwLYwO0hdt4FpurhceTYVlMceuu
         sP9U8EaERO10hICk89qjaOP5X4UzWG+rM0z9WeO4UO1DgkioRYhU6vqTH+tugxhSOPwE
         MvP+eupf7S88R3RtL/u5B0LFSxabJCoHMbqeDX3C9TtSYw9REmt8wJJp5u2M5ICuc8ru
         PamhdpDm4iWuSCqYszFDWpnsLqlvZxLA72wOdzY3n0iFPxBFh4/enjoHLMni5AowZyfU
         OcRwWSpjcAXnFHQ0V+Yet0W4wc/RYIZzTH1oHviTAcdEhfd3Zd82+LEvr0KbPwUiFZAI
         I2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s91tKYIQeKJmNASGzuZv62jiVZtvz7cNLDd/Mhsd4sI=;
        b=hsfoQb60FlNtxON826ymnpHEhSrmpTr4NI5cmUFFtlxapq+FpWkQubsQbpZncjcXwO
         3/lHW5JZ7BXZv9u7S+3Re4JH41mW/7SNI5l3OSn+1C0LiNtfusP1v4m85dgDGkOFm12M
         moGNFDb3g4eC0Aq08H9SZSxir4oRL5FQo8TjEwmIi55x7z7PXifMeglcmSJ+aI5kRC/k
         eJMYREL/33jHLaOodbaIlg4ictMKPS/fbd/bB5Yk2geJDyCpRmwYy/3ojSi2FBjYM6Hy
         x7gevIB8yHUSI704oz+PWhqeCTtTllrdfN47LkoyA1OvWSkNlzAYP+HWYpwFhMW7aGh7
         46Nw==
X-Gm-Message-State: APjAAAUfn+FSOYkeY7EumX7r22rdsQX48N11paYI9pNK84IgxPZCY8ys
        27ejIGF8NUJ6qyhlmGIb3i1zmTAz+DSFNxX92HKt
X-Google-Smtp-Source: APXvYqx1oWVR2cuAetmaPy1R06U3aM9TtEWw/74jY3DbA4y4W2lGaVACp9491HJ2avHInLSMczhmXCExrEmelimPS54=
X-Received: by 2002:a6b:f216:: with SMTP id q22mr10710978ioh.65.1563541977484;
 Fri, 19 Jul 2019 06:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com> <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
 <20190709131932.GI3436@mellanox.com> <1cd86f4b-7cd1-4e00-7111-5c8e09ba06be@grimberg.me>
In-Reply-To: <1cd86f4b-7cd1-4e00-7111-5c8e09ba06be@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 19 Jul 2019 15:12:46 +0200
Message-ID: <CAHg0HuxJn8Uv7jJKyTd36udqvMF+ajECjpOhnTJcnHV_PFrdRg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi,

thanks a lot for the information. We are doing the right thing
regarding the invalidation (your 2f122e4f5107), but we do use
unsignalled sends and need to fix that. Please correct me if I'm
wrong: The patches (b4b591c87f2b, b4b591c87f2b) fix the problem that
if the ack from target is lost for some reason, the initiators HCA
will resend it even after the request is completed.
But doesn't the same problem persist also other way around: for the
lost acks from client? I mean, target is did a send for the "read"
IOs; client completed the request (after invalidation, refcount
dropped to 0, etc), but the ack is not delivered to the HCA of the
target, so the target will also resend it. This seems unfixable, since
the client can't possible know if the server received his ack or not?
Doesn't the problem go away, if rdma_conn_param.retry_count is just set to 0?

Thanks for your help,
Best,
Danil.

On Tue, Jul 9, 2019 at 11:27 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Thanks Jason for feedback.
> >> Can you be  more specific about  "the invalidation model for MR was wrong"
> >
> > MR's must be invalidated before data is handed over to the block
> > layer. It can't leave MRs open for access and then touch the memory
> > the MR covers.
>
> Jason is referring to these fixes:
> 2f122e4f5107 ("nvme-rdma: wait for local invalidation before completing
> a request")
> 4af7f7ff92a4 ("nvme-rdma: don't complete requests before a send work
> request has completed")
> b4b591c87f2b ("nvme-rdma: don't suppress send completions")
