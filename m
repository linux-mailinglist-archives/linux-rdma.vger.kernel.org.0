Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1E36D17F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Apr 2021 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhD1FAp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 01:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1FAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 01:00:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6BC061574
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 22:00:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so553869ejb.11
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTa2rJe57h3m0yApI2QpI6xpEFAcpB1SdNfNFdHFM4g=;
        b=HgEqXdhF3ulHOGm0fZRjNFgnDVMeVDPrGHiWkuwOFfC8QYQiupKmwqKWa0kLFSvbiU
         iNuS4n2NNGh7+Ev/tLSN4uG5KN49QNVezciItqDS5HKMxIBqxUAX0ry8oCCU+Fkwooyl
         VwSgqELx5xXxHFiOSJP2m39m1uCFDF/uEfsddq+gekLoYLZ4GdM9NZQDWTlrJCpQDnqp
         vee49cardY1LqClaTPxmpeBliqGdnLuYDwewWsR9KerGcFpdZTSVDCno0bNeGFfoa48s
         5iaz+wYM6DvvMJmjf/fv1rGzBZtUerYSkVKpU8t73RjHr7ZmG5+1dTYLdGw8v005crvJ
         YZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTa2rJe57h3m0yApI2QpI6xpEFAcpB1SdNfNFdHFM4g=;
        b=c/zXwxxOtl9TUmE62nKTFUJq3JupbSjrarVT6ceV8QcsyMbzqct5cLa+D+pTxTI7Gt
         9+T3lCjb0/pFPJcRki7uxPVeXo/499/LG/E4w2U3xQX4rg7pULGGZR2F6R9nJWShPv+9
         3q0MMVvv2eRdlP6ozmjflV4bhhoerstAXbih8cBm3bBJ9vwPjyazRHEvMgDZ+bJ71r9I
         nGu6G4uCdb6mHhe8VGt9VmY9w0HuyASSFOolRrOWh8Z3umif1xtJaLmlyL3i90Lt9jEk
         va0I4965/WLKxeS/l+r28Qyt3ByD0QH8iCgUNC2nnCcDP8/bpmjIWPkX1yeK+ThATeI4
         DIFA==
X-Gm-Message-State: AOAM530lJcrmtWwDLWgDbsiHl1tPZWosCVc1kF5V7/EmRzht9CS8O419
        xeJEUkq7SLIYVkLoF8SE6asWZhVe09V/82zr9BetAg==
X-Google-Smtp-Source: ABdhPJwFLs1YrU6HlDihyrSL3Ifd6gMSt4SSSxd7khg4arkVZsIJLwf611gIr/t+Zx2Xes7Ha8tp6gzbWHNS/h8DKsQ=
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr27087081ejc.5.1619585999318;
 Tue, 27 Apr 2021 21:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210407113444.150961-1-gi-oh.kim@ionos.com> <20210413224723.GA1370930@nvidia.com>
 <CAJX1YtYCAy09uvNtdq=UM+rWLo0SWaGC17XxZxUf_9ZcmhBWbw@mail.gmail.com> <20210427185959.GN2047089@ziepe.ca>
In-Reply-To: <20210427185959.GN2047089@ziepe.ca>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 28 Apr 2021 06:59:23 +0200
Message-ID: <CAJX1YtY3xPGTVgsF=ZTecQ2P7XL0bWeWEQ2BfAUj9F9fy552Zg@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 0/4] New multipath policy for RTRS client
To:     Jason Gunthorpe <jgg@ziepe.ca>
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

On Tue, Apr 27, 2021 at 9:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Apr 14, 2021 at 06:59:59AM +0200, Gioh Kim wrote:
> > On Wed, Apr 14, 2021 at 12:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Apr 07, 2021 at 01:34:40PM +0200, Gioh Kim wrote:
> > > > This patch set introduces new multipath policy 'min-latency'.
> > > > The latency is a time calculated by the heart-beat messages. Whenever
> > > > the client sends heart-beat message, it checks the time gap between
> > > > sending the heart-beat message and receiving the ACK. So this value
> > > > can be changed regularly.
> > > > If client has multi-path, it can send IO via a path having the least
> > > > latency.
> > > >
> > > > V3->V2: use sysfs_emit instead of scnprintf
> > > > V2->V1: use sysfs_emit instead of sprintf
> > > >
> > > > Gioh Kim (3):
> > > >   RDMA/rtrs-clt: Add a minimum latency multipath policy
> > > >   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
> > > >   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
> > >
> > > Applied to for-next, thanks
> > >
> > > Please be mindful about the subjects, rdma subject start with a
> > > capital letter after the tag
> > >
> > > > Md Haris Iqbal (1):
> > > >   RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
> > > >     stats
> > >
> > > This one was replaced by that other patch
> >
> > Hi Jason,
> >
> > "RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats"
> > This patch is still necessary. Please apply that patch.
> >
> > As I wrote in the description of patch
> > "RDMA/rtrs-clt: destroy sysfs after removing session from active list",
> > each function still should check the session status because closing
> > or error recovery paths can change the status.
> >
> > For example, the client sends the heart-beat and does not get the
> > response, it changes the session status and stops IO processing.
> > It is ok if the status is changed after checking status because
> > the error recovery path does not free memory and only tries to
> > reconnection.
> >
> > And closing the session changes the session status and flush all IO,
> > and then free memory.
>
> You need to resend it with out the oops message, a patch like this
> cannot be correctly fixing an oops like it presents. Confirm you do
> not have the oops now that the other patch is merged.

Yes, that oops is prevented by another patch.
I will change the commit message and send it to you.

>
> Please explain carefully what it is trying to do

Ok, I will.


>
> Jason
