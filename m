Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C692641D42D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348496AbhI3HM2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348502AbhI3HM1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 03:12:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FBC06161C
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 00:10:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so18071829edv.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19ju+SpZExuuJBtPIrqJuN+Pv00UX8aYg9jkHo6Ta4A=;
        b=Fd+5t0jQN8rmPfhrNrj7tbNOCZ6vRzi+/pC/lfpsdOHWa7HLmHf50XiSlEh5ssvBjp
         oep0qInH/z1m23DIWP6uUfc47kFTjKPtLDNHjXuqhSX00Ww1iqFBRAE28km+448EovTO
         dH3kyLJ506qj/IwBVh1+irj9uwmf9NSUDnvc5rRBjnrdB1FUR+4oNtdi05fP9buNVb3A
         K4gdCUeWQZa8yV2X/erzAEeDAOsbZUlGirErRcgFaOuGkcyoRfJhcYna5v3Mral1CU1S
         DaH/uiueKvf1tnOpLazeCyyXLATFMcRl2LP5ik62xXDVeQPbsNUOZrGly8j300G2FK7j
         +VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19ju+SpZExuuJBtPIrqJuN+Pv00UX8aYg9jkHo6Ta4A=;
        b=DxFt0P/YJBR1d412o/yzZ/b+TymTIXm2Tjs7kTdLncrBRN0Ddf+Nbfmyttc3ROJ1xk
         r5Zr8YI4SFqkPEn3xzvzYtEfjZVRPlmPBU16eVyMVqYp3O7+s8yDyVu+m8+vfEhDatA4
         bIpkD2Byk3zWAE5tr6KswnyDKr9vyVyzvnek1Rg+2CmFc3JS2QyBPgTMiPMRopOgmxLd
         jKQF4vT6W2BX8+BygzP3aopmcaXtcEDccbRGb+SQ3/B1NIaO74AdmFIHf4RixJMjD7/G
         4S2RW2/6d5Hd4u7qwOE3wm/XJAVff3VHaXDtTushSIFJdCxJb5acFl6LkzSeueOgl+yM
         qljg==
X-Gm-Message-State: AOAM530WpcSqBKCrz4H/Mbg1DC8lmVL+ckOURcianeoiB9MBSdaXvZr3
        xm34cE283FklNgTnbRcnsR1n+tBNuo4Kid55mfrOng==
X-Google-Smtp-Source: ABdhPJwO1lyRkoQb7+fHOmN+2VtRDYkkyCs/dGLT3eojY97ZdI88pVOtlfxdXwiz1w90EnBAQv4KxFk+RdamCOirUco=
X-Received: by 2002:a17:907:20c8:: with SMTP id qq8mr4743222ejb.339.1632985843959;
 Thu, 30 Sep 2021 00:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com> <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal> <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal> <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal>
In-Reply-To: <YVVgunT1hSIzu1tA@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 30 Sep 2021 09:10:33 +0200
Message-ID: <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 9:01 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Sep 30, 2021 at 08:03:40AM +0200, Jinpu Wang wrote:
> > On Wed, Sep 29, 2021 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=882=
8=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > > > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrot=
e:
> > > > > > > > Allowing these characters in sessname can lead to unexpecte=
d results,
> > > > > > > > particularly because / is used as a separator between files=
 in a path,
> > > > > > > > and . points to the current directory.
> > > > > > > >
> > > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > > > > > ---
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > > > > >  2 files changed, 11 insertions(+)
> > > > > > >
> > > > > > > It will be safer if you check for only allowed symbols and di=
sallow
> > > > > > > everything else. Check for: a-Z, 0-9 and "-".
> > > > > > >
> > > > > > Hi Leon,
> > > > > >
> > > > > > Thanks for your suggestions.
> > > > > > The reasons we choose to do disallow only '/' and '.':
> > > > > > 1 more flexible, most UNIX filenames allow any 8-bit set, excep=
t '/' and null.
> > > > >
> > > > > So you need to add all possible protections and checks that VFS h=
as to allow "random" name.
> > > > It's only about sysfs here, as we use sessname to create dir in sys=
fs,
> > > > and I checked the code, it allows any 8-bit set, and convert '/' to
> > > > '!', see https://elixir.bootlin.com/linux/latest/source/lib/kobject=
.c#L299
> > > > >
> > > > > > 2 matching for 2 characters is faster than checking all the all=
owed
> > > > > > symbols during session establishment.
> > > > >
> > > > > Extra CPU cycles won't make any difference here.
> > > > As we can have hundreds of sessions, in the end, it matters.
> > >
> > > Your rtrs_clt_open() function is far from being optimized for
> > > performance. It allocates memory, iterates over all paths, creates
> > > sysfs and kobject.
> > >
> > > So no, it doesn't matter here.
> > >
> > Let me reiterate, why do we want to further slow it down, what do you
> > anticipate if we only do the disallow approach
> > as we do it now?
>
> It is common practice to sanitize user input and explicitly allow known
> good input, instead of relying on deny of bad input. We don't know the
> future and can't be sure that "deny" is actually closed all holes.

Thanks for the clarification, but still what kind of holes do you have
in mind, the input string length is already checked and it's
not duplicated with other sessname. and sysfs does allow all 8 bit set IIUC=
.

Thanks!

> Thanks
