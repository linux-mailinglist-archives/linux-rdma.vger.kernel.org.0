Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C041EDAC
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJAMmV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJAMmV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 08:42:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5498C061775
        for <linux-rdma@vger.kernel.org>; Fri,  1 Oct 2021 05:40:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dj4so35292612edb.5
        for <linux-rdma@vger.kernel.org>; Fri, 01 Oct 2021 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OOmtX6mJkaDbS5DNm6EbCpXXD5iJSh45SP9r/Bt47XI=;
        b=glNWjM/ZNPQs0n9fOTeEcrgSQce5oOSBcQYTRcr0wIB+sLNYPZxDnlmlS2Vv7zE+Jn
         yG5Al964p/wlBSi6gmxGzZtjBmJ9n0DeGgHRGI+3GyaWBLMvwZTjkng0Ks+7HsVepyVe
         lYOYzVU6WO+G+SsiU7ulIk5uOpvDQ0XMNtBGHujZCvcxQjFx1v3iB1nb/WRRRfhj5VAs
         NHRR2LIBf9I8M0A2kR85bTCaQvFkRMrd5z7M/OQ3GBfsFbKsAN9MVC0hT1qDbwmQvYSv
         S6jCtV0dHNmN7+Ani8HvKFSIn7sGxVD12boqFzfIu2yfBqGhC2dmjVNfJhuR9R7Q1SL5
         klpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OOmtX6mJkaDbS5DNm6EbCpXXD5iJSh45SP9r/Bt47XI=;
        b=yFsU5PAh9AqYL8n838e7D6C24BAHkVSL6CJOR9AXRt6tZ/TU029MxDBKkIdGOCh2IM
         UFxzhrX3NOSD/TMlvsTpNSyi9YuQlRVSoP5dArTMBL7apfjvHvR7tOEBmZYZ8/ztjpcP
         DtWrEaq+MrAmp79abyWJNgl5GGlDdB2RhOoRMdpjQzqYdmfwX0rkkHi0k5XuRGeUsxSE
         p6uo+T/ws3G17LVp7j2hzqQ2dqWuX/+k+8Rdnp/0U5y4kVWiowe9i+Kwsnc1niH6sAP1
         Cr555CqZVf9dlskwALKkUsjcikQd8o07NZX8fRzDiZcs5u2JiqKyHSYn2J1/smRbJs1k
         dHHw==
X-Gm-Message-State: AOAM533gEtuBPNWylj+sMWyYtCurdvED+bXRz+QrmmecZsVNhdvtnfHz
        yvKt6L0Y1BCbVUUgrE5nog8E63mQC9/MtTbTpcf8gA==
X-Google-Smtp-Source: ABdhPJwxomNE9fK6H+7wEVsmWlkpn5PfKOS2ZlkExtFc1XwjkFLfrIWsVlUYiyliPUW+DF96Z8ZhXFySo4kaApCRmdY=
X-Received: by 2002:a05:6402:3133:: with SMTP id dd19mr14606407edb.172.1633092035416;
 Fri, 01 Oct 2021 05:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com> <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal> <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal> <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal> <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
 <YVVtAFtOj0mPzSAR@unreal>
In-Reply-To: <YVVtAFtOj0mPzSAR@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 1 Oct 2021 14:40:24 +0200
Message-ID: <CAMGffEmYObHjk1Fk6jZqBnUPCE5o9=EpHHYqvevA8kKLjQG6aQ@mail.gmail.com>
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

On Thu, Sep 30, 2021 at 9:53 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Sep 30, 2021 at 09:10:33AM +0200, Jinpu Wang wrote:
> > On Thu, Sep 30, 2021 at 9:01 AM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Thu, Sep 30, 2021 at 08:03:40AM +0200, Jinpu Wang wrote:
> > > > On Wed, Sep 29, 2021 at 2:04 PM Leon Romanovsky <leon@kernel.org> w=
rote:
> > > > >
> > > > > On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> > > > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > > > > > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=
=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal =
wrote:
> > > > > > > > > > Allowing these characters in sessname can lead to unexp=
ected results,
> > > > > > > > > > particularly because / is used as a separator between f=
iles in a path,
> > > > > > > > > > and . points to the current directory.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > > > > > > >  2 files changed, 11 insertions(+)
> > > > > > > > >
> > > > > > > > > It will be safer if you check for only allowed symbols an=
d disallow
> > > > > > > > > everything else. Check for: a-Z, 0-9 and "-".
> > > > > > > > >
> > > > > > > > Hi Leon,
> > > > > > > >
> > > > > > > > Thanks for your suggestions.
> > > > > > > > The reasons we choose to do disallow only '/' and '.':
> > > > > > > > 1 more flexible, most UNIX filenames allow any 8-bit set, e=
xcept '/' and null.
> > > > > > >
> > > > > > > So you need to add all possible protections and checks that V=
FS has to allow "random" name.
> > > > > > It's only about sysfs here, as we use sessname to create dir in=
 sysfs,
> > > > > > and I checked the code, it allows any 8-bit set, and convert '/=
' to
> > > > > > '!', see https://elixir.bootlin.com/linux/latest/source/lib/kob=
ject.c#L299
> > > > > > >
> > > > > > > > 2 matching for 2 characters is faster than checking all the=
 allowed
> > > > > > > > symbols during session establishment.
> > > > > > >
> > > > > > > Extra CPU cycles won't make any difference here.
> > > > > > As we can have hundreds of sessions, in the end, it matters.
> > > > >
> > > > > Your rtrs_clt_open() function is far from being optimized for
> > > > > performance. It allocates memory, iterates over all paths, create=
s
> > > > > sysfs and kobject.
> > > > >
> > > > > So no, it doesn't matter here.
> > > > >
> > > > Let me reiterate, why do we want to further slow it down, what do y=
ou
> > > > anticipate if we only do the disallow approach
> > > > as we do it now?
> > >
> > > It is common practice to sanitize user input and explicitly allow kno=
wn
> > > good input, instead of relying on deny of bad input. We don't know th=
e
> > > future and can't be sure that "deny" is actually closed all holes.
> >
> > Thanks for the clarification, but still what kind of holes do you have
> > in mind, the input string length is already checked and it's
> > not duplicated with other sessname. and sysfs does allow all 8 bit set =
IIUC.
>
> As an example, symbols like "/" and "\".
"/" aside, we already disable it.
I did a test, there is no problem to use "\" as sysfs name.

Thanks!
>
> >
> > Thanks!
> >
> > > Thanks
