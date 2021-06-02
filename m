Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906163982E1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFBHYb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 03:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFBHYa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 03:24:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB24C061574
        for <linux-rdma@vger.kernel.org>; Wed,  2 Jun 2021 00:22:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p184so2434868yba.11
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jun 2021 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v7qnnPr/FfX43MlOwkp1NFwMTl/DysPsXOd1d31BKxA=;
        b=QaHCvo0JQaP/d/RxlWpBWu4laCq8uae0ieqXthvl0KXJkvkriTkjEG2VUkFbcLnThl
         MiGozpm6DM82ZDS2SRgDUrA1/1YQm8gJqUjDSO+7BBDas/4peVLF5DUSnqNDFVe/hjIg
         5PyP9phcpAp+T65Tc0isFJngEVq3lwIAWvqlVcOMwAz+aoJx3slYBorUxg1F+40RC5me
         wALVh1U69nwamyJGiiD7YIixqV55p9/clXNDpJ+VjSzF3TrGiu/zyMdbSg2VBCpYZ9j6
         zwvEyn5/SILtGShoxns7UeO5PC+R+zOyymo3eN2JZuZCNRNe1z3ZeW2sWwNoZmOFREaH
         1Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v7qnnPr/FfX43MlOwkp1NFwMTl/DysPsXOd1d31BKxA=;
        b=Wp5PuMsl9IJxXjOt6GHy5/AD/WAbq8ek2DgriM4P74lDhiz6lVu+6GDc+hVomLmw6H
         Oe3y6CX3wTucCJ0bKzWMnNgjNtOG9W8i7ZSCEvijTBubZjUH3OQGs8/K0VhWTkwaQjrE
         2nPCryemvvTDiV+Jhhm5IL+ex2xVtIS6x6P772/WokypgC+NEXyiryWBSnu+oqWSSpt5
         itpk0XxDwuo9r3m+w9H16FgdmQFYIOyV5ZCZqd6zN7sfUgpEk+mmk1FPbZXq3s7nrmg2
         y5gm6z5WslH8URQH5+SASRmPwLFdCJMqGBHpIbzNuJGvWtAVNsIraCB9YiSA9Fkl5Tr7
         wSPQ==
X-Gm-Message-State: AOAM531O7qE/II5E2tkL5EeGoktkNda6lAhiSa+qxI2qawOA7Hiz2ylT
        HGKEV3nYOI/tFjR7swG5aTksNH8847GQfAaOScc=
X-Google-Smtp-Source: ABdhPJyxHM8VIgx7088ddrnRfyB6EX/vDTC1qIcVs24wIu9rou9Tg5hkubSgR+wtnO7GPzFOoZXVeBQUg7/Djq2ziLg=
X-Received: by 2002:a25:d694:: with SMTP id n142mr44518214ybg.349.1622618565831;
 Wed, 02 Jun 2021 00:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com> <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation> <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
 <20210601170132.GN1096940@ziepe.ca>
In-Reply-To: <20210601170132.GN1096940@ziepe.ca>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 2 Jun 2021 15:22:34 +0800
Message-ID: <CAD=hENeRHgHU3mRZqxFHdfUcK=+PczrhSnf4JkYzhXrxLf9L6Q@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 2, 2021 at 1:01 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 01, 2021 at 11:59:44PM +0800, Zhu Yanjun wrote:
> > On Tue, Jun 1, 2021 at 5:09 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> > >
> > > On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
> > > > On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wr=
ote:
> > > > >
> > > > >
> > > > >
> > > > > > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrot=
e:
> > > > > >
> > > > > > =EF=BB=BFOn Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@=
gmail.com> wrote:
> > > > > >>
> > > > > >> To avoid the following failure when trying to load the rdma_rx=
e module
> > > > > >> while IPv6 is disabled, Add a check to make sure that IPv6 is =
enabled
> > > > > >> before trying to create the IPv6 UDP tunnel.
> > > > > >>
> > > > > >> $ modprobe rdma_rxe
> > > > > >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not pe=
rmitted
> > > > > >
> > > > > > About this problem, this link:
> > > > > > https://patchwork.kernel.org/project/linux-rdma/patch/202104132=
34252.12209-1-yanjun.zhu@intel.com/
> > > > > > also tries to solve ipv6 problem.
> > > > > >
> > > > > > Zhu Yanjun
> > > > > >
> > > > >
> > > > > Yes, but this patch is fixing the problem more cleanly and I=E2=
=80=99ve tested it.
> >
> > Please check this link
> > https://lore.kernel.org/linux-rdma/20210326012723.41769-1-yanjun.zhu@in=
tel.com/T/
> > carefully.
> >
> > Please pay attention to the comments from Jason Gunthorpe
>
> I think the comment still holds, the correct fix is to detect the -97

Great! Thanks

Zhu Yanjun

> errno down in the call chain and just ignore ipv6 support in this
> case.
>
> Jason
