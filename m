Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859B163794
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGIORV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 10:17:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIORV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 10:17:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so21219201wrt.6
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ihAKPWnieId+qKVCfau5qTiytguyF5R9ui15t377qac=;
        b=FiG6jhAtkrn0uWaUNwk3gU//0grYdL1Io1xZAI9A5iUo+wqBhPNCZ50hc3RBVwlkQJ
         HhV2wYJ+qDVSvFp96fanh/ueIcj8EpzMCYqNP2ZPZ84ej3ECWzaGOtcHI294VAW7qKIc
         GXAQHlh1KIVLIKOL7iqo/MVyxyE3tD1An+cQ7pQaS3F6Nb0CQnDYtvDHi+CpzMCJFPyk
         /nRms7K/xWkKfjXhN4kX91mKkMoYLI7bikm4lYAQK+OfWN9YrerZ+yLh8C/J+F5Jszoz
         lBI++OfVoe8LzdxZ9JxfMp23oD6AYoQd2P6xzNmUeDSaDuvJw3Et1C98mNpfLM3+w8RY
         xb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ihAKPWnieId+qKVCfau5qTiytguyF5R9ui15t377qac=;
        b=Nzp/cihVLjNg6Pr/Iy3DNFZiEaQyTnYAIokXOYPBz1Mm6j12aK+frG4K1RfZyXPtOo
         xoZmXBn0HZSTYjJPFqCW6Xk0PUKex0g2DkpqY8HHeOTdqoxTK22x6uam/ZAFqW3wTyqb
         h7iYtVkPjn/MdOq7WD9ZOaqcuXL2/Fro5daKVAgb+k4eVeTOFx1n4lXBhtkgn3UQOJ1k
         ch1KKB+3OiMZZUI//y08hCwwptKzYDox1zYsV9awq4NCKF08tqtoBEg74FPD4CLb0wud
         lJeoocPT0VPovZsgJesYnF6NrAR4ktEdvvVfHRuCETUZqQF5bJ/CirrEDfaUVaX2Ipfh
         XXag==
X-Gm-Message-State: APjAAAUQx7jGSFAIwZ2XgkxRjaoCS31EizSKDKyFnB6RhoF/Z5B5a2qh
        PraByavj0HukD7eeSoJgUBk93mqkRRdCJcvCGuQP5Q==
X-Google-Smtp-Source: APXvYqyT5+VMNZt+6XVpKpLgiY1UhgFDlLrpZz2kfpvy5WmC2hujvZbiDY91aYt9TfIJBBipIWvTPPwpXpt5HiA7ujs=
X-Received: by 2002:adf:ea87:: with SMTP id s7mr26175882wrm.24.1562681838630;
 Tue, 09 Jul 2019 07:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com> <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
 <20190709131932.GI3436@mellanox.com>
In-Reply-To: <20190709131932.GI3436@mellanox.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 9 Jul 2019 16:17:07 +0200
Message-ID: <CAMGffEnhyoxtpu=tHgTfEX5n5=Ckw+jMBYnF6q5cxqkq9UnSVQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>, chuck.lever@oracle.com
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 9, 2019 at 3:19 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Jul 09, 2019 at 03:15:46PM +0200, Jinpu Wang wrote:
> > On Tue, Jul 9, 2019 at 2:06 PM Jason Gunthorpe <jgg@mellanox.com> wrote=
:
> > >
> > > On Tue, Jul 09, 2019 at 01:37:39PM +0200, Jinpu Wang wrote:
> > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > > > > > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> > > > > >
> > > > > > Could you please provide some feedback to the IBNBD driver and =
the
> > > > > > IBTRS library?
> > > > > > So far we addressed all the requests provided by the community =
and
> > > > > > continue to maintain our code up-to-date with the upstream kern=
el
> > > > > > while having an extra compatibility layer for older kernels in =
our
> > > > > > out-of-tree repository.
> > > > > > I understand that SRP and NVMEoF which are in the kernel alread=
y do
> > > > > > provide equivalent functionality for the majority of the use ca=
ses.
> > > > > > IBNBD on the other hand is showing higher performance and more
> > > > > > importantly includes the IBTRS - a general purpose library to
> > > > > > establish connections and transport BIO-like read/write sg-list=
s over
> > > > > > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME=
. While
> > > > > > I believe IBNBD does meet the kernel coding standards, it doesn=
't have
> > > > > > a lot of users, while SRP and NVMEoF are widely accepted. Do yo=
u think
> > > > > > it would make sense for us to rework our patchset and try pushi=
ng it
> > > > > > for staging tree first, so that we can proof IBNBD is well main=
tained,
> > > > > > beneficial for the eco-system, find a proper location for it wi=
thin
> > > > > > block/rdma subsystems? This would make it easier for people to =
try it
> > > > > > out and would also be a huge step for us in terms of maintenanc=
e
> > > > > > effort.
> > > > > > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on=
 top of
> > > > > > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE i=
n the
> > > > > > near future). Do you think it would make sense to rename the dr=
iver to
> > > > > > RNBD/RTRS?
> > > > >
> > > > > It is better to avoid "staging" tree, because it will lack attent=
ion of
> > > > > relevant people and your efforts will be lost once you will try t=
o move
> > > > > out of staging. We are all remembering Lustre and don't want to s=
ee it
> > > > > again.
> > > > >
> > > > > Back then, you was asked to provide support for performance super=
iority.
> > > > > Can you please share any numbers with us?
> > > > Hi Leon,
> > > >
> > > > Thanks for you feedback.
> > > >
> > > > For performance numbers,  Danil did intensive benchmark, and create
> > > > some PDF with graphes here:
> > > > https://github.com/ionos-enterprise/ibnbd/tree/master/performance/v=
4-v5.2-rc3
> > > >
> > > > It includes both single path results also different multipath polic=
y results.
> > > >
> > > > If you have any question regarding the results, please let us know.
> > >
> > > I kind of recall that last time the perf numbers were skewed toward
> > > IBNBD because the invalidation model for MR was wrong - did this get
> > > fixed?
> > >
> > > Jason
> >
> > Thanks Jason for feedback.
> > Can you be  more specific about  "the invalidation model for MR was wro=
ng"
>
> MR's must be invalidated before data is handed over to the block
> layer. It can't leave MRs open for access and then touch the memory
> the MR covers.
>
> IMHO this is the most likely explanation for any performance difference
> from nvme..
>
> > I checked in the history of the email thread, only found
> > "I think from the RDMA side, before we accept something like this, I'd
> > like to hear from Christoph, Chuck or Sagi that the dataplane
> > implementation of this is correct, eg it uses the MRs properly and
> > invalidates at the right time, sequences with dma_ops as required,
> > etc.
> > "
> > And no reply from any of you since then.
>
> This task still needs to happen..
>
> Jason

We did extensive testing and cross-checked how iser and nvmeof does
invalidation of MR,
doesn't find a problem.

+ Chuck
It will be appreciated if Christoph, Chuck, Sagi or Bart could give a
check, thank you in advance.

Thanks
Jack
