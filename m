Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF112E3EE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 09:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgABIlr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 03:41:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41404 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgABIlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 03:41:47 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so34052108ioo.8
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMoljWmBgb5e6B5p/9++As4qYGIq9XMmMz9ABHQzHXU=;
        b=HGY3m+0NRW9HUeN3XL2N9TBj6a4c17qA0Qe1cje/ALXFtOJMwjXIAzpoqiGjb/RgTV
         kYu6TOXl+asz5ElIuJL21BoOyKpU2wSYZI05tQjVVHo0k/wkd3ECEZRg++i4uxk2nZEQ
         Bj86ZwocYdzzfe33oAwfv8wIPRSRP8HlTSWBlRwJKAqOKCMYdHp4G5iMmFVwy2d0Q3QY
         D4h+gpRGhMfWQwdraSN8vxIE6ADidyQC3Ywt4qThMsxrZbZgdsuQN+LtZ+3HU4Fjqhyh
         pNFn4FeJinFNZ4KdRQw7yS/9AvDtjkaMuQ++jFeA4ZL6AFBtSuoC7MnHI1HYwMte5rga
         Q5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMoljWmBgb5e6B5p/9++As4qYGIq9XMmMz9ABHQzHXU=;
        b=pr5+iLIAHvJdNSFmrrOmyPVzWT41Ml6tVwUfKRQdu+OUhy9zSJfbiSPRYd5J2QKePW
         bcdr30kVS4G8OJjTnQQtMsqFfEI+Sm8kF5SGDFk1C1v4LQlrgm0EwVCdBrzo9iBx+Ceh
         CS3iD4ht+qj22f+wrw/k1a6iSNn349wpgcnpMV+RbbRC12rhp1K7TNnWy4mt2sYIitBv
         ZJOLKCdeZhiY8l6VtvvNNJbzV4VS/Gy1Ik0mfG+cUotjy5xVv52oEQG83AKXN/ttvwQZ
         CElow64GkpIQPo17z9bDeHE4P029ziITbrTYFDHeOv+obuG3kiAqQp2tdicAvM1dvhde
         BTxQ==
X-Gm-Message-State: APjAAAX6mwMifCOgaW1WY2ZV4vKc4LBkhuNsGXgSWkF12F++hvLV34SK
        vF69sjaP8bPiA6wui4EUHR7PXX2Kte3UheOlfvc6eA==
X-Google-Smtp-Source: APXvYqwaxIL7M07TJd4WJ7JyuI+xHxVhjujGM7vRjcaNBpGV5I6Iu04IdmP7/ZUuX0Kbg+oFLjEzwyYODkX08XoCEEc=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr55508729ioh.22.1577954506696;
 Thu, 02 Jan 2020 00:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-26-jinpuwang@gmail.com>
 <9b923988-acb3-9a44-255f-47da7609d225@amazon.com>
In-Reply-To: <9b923988-acb3-9a44-255f-47da7609d225@amazon.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 09:41:37 +0100
Message-ID: <CAMGffEnzS_JGhtY9fbd_krku+XsUqzYBCxH+OmmkkXYST6g_hQ@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 30, 2019 at 1:22 PM Gal Pressman <galpress@amazon.com> wrote:
>
> On 30/12/2019 12:29, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Danil and me will maintain RNBD/RTRS modules.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e09bd92a1e44..2ba370d8145d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14125,6 +14125,13 @@ F:   arch/riscv/
> >  K:   riscv
> >  N:   riscv
> >
> > +RNBD BLOCK DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/block/rnbd/
> > +
> >  ROCCAT DRIVERS
> >  M:   Stefan Achatz <erazor_de@users.sourceforge.net>
> >  W:   http://sourceforge.net/projects/roccat/
> > @@ -14192,6 +14199,13 @@ F:   include/net/rose.h
> >  F:   include/uapi/linux/rose.h
> >  F:   net/rose/
> >
> > +RTRS TRANSPORT DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/infiniband/ulp/rtrs/
> > +
> >  RTL2830 MEDIA DRIVER
> >  M:   Antti Palosaari <crope@iki.fi>
> >  L:   linux-media@vger.kernel.org
>
> RTRS should be after RTL, right :)?
Yes, that's right. -.-
Thanks for double-checking, will be fixed.
