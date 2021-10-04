Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5006842059A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhJDFnJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 01:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhJDFnI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 01:43:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CCC0613EC
        for <linux-rdma@vger.kernel.org>; Sun,  3 Oct 2021 22:41:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so61099711edb.5
        for <linux-rdma@vger.kernel.org>; Sun, 03 Oct 2021 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rd8xcnsTFa2lV7vbFzGBbw5FCADhw+dPxD91iVvSUKY=;
        b=Qv2PV0YDpiWCzYiXADfTL9K8SNPp0Uw5kwG0G/ib5otkjdv+Tc21OCkBCqKGgMsa8h
         qhFoYLDgqtVG4yAJ0goIyVH/SU4cn2oDEt7INIUUIhvy1NSc77jxCwRHqRPzm0+QVdCt
         CNYC0C21UULfDrAOV4HvMS+1jPTU3M/eY6SbkSEVBT+KGmnQ3b5vA9RxehqSNOBND6bl
         +QG6uVZi9JRagimjdtJ0pu/5r4W1AQe0VuCwguuFzgYalwkNbulPNiH6YvSYq/KNgx6U
         waJNYFBQD2ERcDaqPsmwvBtlKpD1fjLZmFQmiBmi6Rtbg969RiKZcictjqpLpHtQ1oPg
         WjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rd8xcnsTFa2lV7vbFzGBbw5FCADhw+dPxD91iVvSUKY=;
        b=rfDj1fPiqKD90LgWkFPW+VP1dvyuZzyqaV7R6Z1KVfjSzYc0N0apWkJFKnNWj2lLOx
         xBhCETQb/i1amPDdjh13zFLS9yf13G2liFaYL0QIXTBOg9pjEmJ6uep896V6/LWzyojj
         EYvPKYdfRjfBw/FRc7ZnCzhNKfE90xVZM3z4rY/P7qbhku5CMSsD7Zad+1kcfzSTMJGP
         ot6YPzFS2+VJ2j0mrcOiFEjgNPoh6QOArKFkWyYmEEn+kdIL6A2ncGw1LNXj1JG8Zm0d
         89mjMTwv3dPOU0XJpVtxborLy+pStLazEFAY58F4UW8VmkFiFzm/Tn0yFXSpKIQHemVB
         /uzQ==
X-Gm-Message-State: AOAM531dX+tkdYoYzDDmkCepcuGNhLAwwwEoi5MaD99w/5UINGM8k1Q7
        iVY2LUm44SBjkH8HtB7NU+iBu9tlEpRzHCnEmMl2mQ==
X-Google-Smtp-Source: ABdhPJzl3UMbndI5wWETM3ftzewJ/Riy/KvWzkATuB36vwIA+6k0yKQLq55v306wK/aAsnN18BPt+EdEJYZIG2DrmrU=
X-Received: by 2002:a05:6402:222b:: with SMTP id cr11mr16424983edb.392.1633326078727;
 Sun, 03 Oct 2021 22:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <YVG3cme0KX9CD4oh@unreal> <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal> <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal> <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal> <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
 <YVVtAFtOj0mPzSAR@unreal> <CAMGffEmYObHjk1Fk6jZqBnUPCE5o9=EpHHYqvevA8kKLjQG6aQ@mail.gmail.com>
 <YVchqF1oHf903+lk@unreal>
In-Reply-To: <YVchqF1oHf903+lk@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 4 Oct 2021 07:41:08 +0200
Message-ID: <CAMGffEk4PJGkL3fufgKGUCmKDUqYOTFgKPisda0OeMN1hTk-iA@mail.gmail.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 1, 2021 at 4:56 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 02:40:24PM +0200, Jinpu Wang wrote:
> > On Thu, Sep 30, 2021 at 9:53 AM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Thu, Sep 30, 2021 at 09:10:33AM +0200, Jinpu Wang wrote:
> > > > On Thu, Sep 30, 2021 at 9:01 AM Leon Romanovsky <leon@kernel.org> w=
rote:
> > > > >
> > > > > On Thu, Sep 30, 2021 at 08:03:40AM +0200, Jinpu Wang wrote:
> > > > > > On Wed, Sep 29, 2021 at 2:04 PM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> > > > > > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote=
:
> > > > > > > > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=
=B49=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=
=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iq=
bal wrote:
> > > > > > > > > > > > Allowing these characters in sessname can lead to u=
nexpected results,
> > > > > > > > > > > > particularly because / is used as a separator betwe=
en files in a path,
> > > > > > > > > > > > and . points to the current directory.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.co=
m>
> > > > > > > > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > > > > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com=
>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > > > > > > > > >  2 files changed, 11 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > It will be safer if you check for only allowed symbol=
s and disallow
> > > > > > > > > > > everything else. Check for: a-Z, 0-9 and "-".
> > > > > > > > > > >
> > > > > > > > > > Hi Leon,
> > > > > > > > > >
> > > > > > > > > > Thanks for your suggestions.
> > > > > > > > > > The reasons we choose to do disallow only '/' and '.':
> > > > > > > > > > 1 more flexible, most UNIX filenames allow any 8-bit se=
t, except '/' and null.
> > > > > > > > >
> > > > > > > > > So you need to add all possible protections and checks th=
at VFS has to allow "random" name.
> > > > > > > > It's only about sysfs here, as we use sessname to create di=
r in sysfs,
> > > > > > > > and I checked the code, it allows any 8-bit set, and conver=
t '/' to
> > > > > > > > '!', see https://elixir.bootlin.com/linux/latest/source/lib=
/kobject.c#L299
> > > > > > > > >
> > > > > > > > > > 2 matching for 2 characters is faster than checking all=
 the allowed
> > > > > > > > > > symbols during session establishment.
> > > > > > > > >
> > > > > > > > > Extra CPU cycles won't make any difference here.
> > > > > > > > As we can have hundreds of sessions, in the end, it matters=
.
> > > > > > >
> > > > > > > Your rtrs_clt_open() function is far from being optimized for
> > > > > > > performance. It allocates memory, iterates over all paths, cr=
eates
> > > > > > > sysfs and kobject.
> > > > > > >
> > > > > > > So no, it doesn't matter here.
> > > > > > >
> > > > > > Let me reiterate, why do we want to further slow it down, what =
do you
> > > > > > anticipate if we only do the disallow approach
> > > > > > as we do it now?
> > > > >
> > > > > It is common practice to sanitize user input and explicitly allow=
 known
> > > > > good input, instead of relying on deny of bad input. We don't kno=
w the
> > > > > future and can't be sure that "deny" is actually closed all holes=
.
> > > >
> > > > Thanks for the clarification, but still what kind of holes do you h=
ave
> > > > in mind, the input string length is already checked and it's
> > > > not duplicated with other sessname. and sysfs does allow all 8 bit =
set IIUC.
> > >
> > > As an example, symbols like "/" and "\".
> > "/" aside, we already disable it.
> > I did a test, there is no problem to use "\" as sysfs name.
>
> It say nothing about future.
>
> Please change your implementation to accept only valid
> symbols and improve connection performance in other places.
>
> Thanks
Sorry, I'm really not convinced, why should we only do allowing, not
disabling in this case?

Jason, what's your suggestion?

Thanks
>
> >
> > Thanks!
> > >
> > > >
> > > > Thanks!
> > > >
> > > > > Thanks
