Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C53F46F7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhHWIy6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhHWIy6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 04:54:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C40B6102A
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629708856;
        bh=5TjLg0Q6ovISQUP2RuleMZX62O3hdYnt8GY1WWFDf4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gysh5b+BL8ukNv1sk5xSu95IiLTgivm4zMynZhV+fKt2SE4ydmZNpgrRrfgKJ/gGL
         VITxSVxaJvjEJdac9+bi8Ho3TwZnrMpJiwuKvKvkuEM8DRwirW67DwFTMqKeD6dkHJ
         a4CcNToHc53aS0mw+JWAd329qO8LYCttxm6adgNGi0mcKiPch5jRuc6i3txty3gqXf
         gMVFzlTefq7Vr/qnBZiuWJWhbeKPtxqY+Ru/Q5SNyyBLSkHhWxtggR8GLD2JtmStHr
         8wqExY9jmXl3YM2XsENvTikRmHkZ9BLfNwPtU6c32CAUfcJCRp9nvkxm8qZwi/d49H
         VCxqokMkK6oJw==
Received: by mail-ot1-f46.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso2772202otv.12
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 01:54:16 -0700 (PDT)
X-Gm-Message-State: AOAM532IaaC6AVzoQGxBIYXPSSOkzhb578wSKKgrvvvtaoQeJBnQpX1b
        bC9hJ3/nZIsSINXZKmxIlvQ6x7BqBZHZhhK3Joc=
X-Google-Smtp-Source: ABdhPJzhygBk5bIlDkN50ny+q1J4SGvCfoE7jNVsiU6jAA1Yw8c6eKHCMPdFC+FQaLiVOWozWmIgqJOnkls68wa9iPA=
X-Received: by 2002:a05:6830:20c4:: with SMTP id z4mr27064548otq.339.1629708855658;
 Mon, 23 Aug 2021 01:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca>
In-Reply-To: <20210822223128.GZ543798@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 23 Aug 2021 11:53:48 +0300
X-Gmail-Original-Message-ID: <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
Message-ID: <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
Subject: Re: Creating new RDMA driver for habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 1:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Aug 22, 2021 at 12:40:26PM +0300, Oded Gabbay wrote:
> > Hi Jason,
> >
> > I think that about a year ago we talked about the custom RDMA code of
> > habanalabs. I tried to upstream it and you, rightfully, rejected that.
> >
> > Now that I have enough b/w to do this work, I want to start writing a
> > proper RDMA driver for the habanalabs Gaudi device, which I will be
> > able to upstream to the infiniband subsystem.
> >
> > I don't know if you remember but the Gaudi h/w is somewhat limited in
> > its RDMA capabilities. We are not selling a stand-alone NIC :) We just
> > use RDMA (or more precisely, ROCEv2) to connect between Gaudi devices.
> >
> > I'm sure I will have more specific questions down the line, but I had
> > hoped you could point me to a basic/not-too-complex existing driver
> > that I can use as a modern template. I'm also aware that I will need
> > to write matching code in rdma-core.
> >
> > Also, I would like to add we will use the auxiliary bus feature to
> > connect between this driver, the main (compute) driver and the
> > Ethernet driver (which we are going to publish soon I hope).
>
> It sounds fine, as Leon mentions EFA is a good starting point for
> something simple but non-spec compliant
>
> If I recall properly you'll want to have some special singular PD for
> the HW and some specialty QPs?
>
> Jason

Yes, we will have a singular PD.
Regarding the QPs, I don't think we have anything special there, but I
might be proven wrong.
I was worried about reg_mr but I think we found a solution for that.

I may be ahead of myself a little, but one of the issues I will need
help with is how to handle ports that are not exposed to the
Networking/Ethernet subsystem.
In a box with Gaudis, some ports are connected back-to-back (between
Gaudi devices) and some are exposed externally.

The ports that are exposed externally will be registered as an
Ethernet device and will be also handled by the Ethernet driver. I
think that is pretty much standard.

However, the "internal" ports won't be registered as an Ethernet
device, as we don't want to expose them to the user as an interface.
They are used only for back-to-back communication between Gaudi
devices inside the same box. You can imagine them to be similar to
NVlink, but instead of a proprietary protocol, they run ROCEv2.
Registering them to netdev creates a very poor user experience and
potentially degrades the host CPU performance (I can elaborate more on
that).

For those ports, we want to prevent the user from sending raw Ethernet
data (opening a socket). We also want to avoid the need for the user
to handle them with ifconfig/ethtool/etc. We only want to expose the
IBverbs interface to those ports.

Do you see any issue with that ?

Thanks,
Oded
