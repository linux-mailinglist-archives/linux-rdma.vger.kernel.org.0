Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB2397760
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhFAQBl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhFAQBk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 12:01:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D215FC061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 08:59:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b9so14047520ybg.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IAd7y++jm0f+6zWQZvHSFfc8DrqEVKMA8mGXW8yPbNY=;
        b=eqT//sMM33VLmBurTU0rLTZ6O+CtyPYsMR7xyKjglINbbvN8+61343VxK4w9lqoRvv
         Z2NbkAOAMK3plhWlO0O3a577NkHUjMBT4suzq1QFvEqpDFLGwV0+mG54iTKgRbGVoDbc
         qh5ZzLqVgonqyT2jIY8FqQrRdESjYzZlSkeosX63LsCNDdPOkFgQih/2CnMVmCUHAHXa
         yWU1IjY1BiODCLEndS1rOWFMtAO5ZYTia9dZ2KJX1d9YmttvbmvNVIKmtCkcOfqN91CT
         KIO4fCUkhWKNIUQhi0mpiJ1zFJmegf5JpwE4zjxxj/H40Gqidr2NcEbHIi8Qm8z3WRac
         TiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IAd7y++jm0f+6zWQZvHSFfc8DrqEVKMA8mGXW8yPbNY=;
        b=rUa1hLy40SCz0he5ySbTDBrQiZn3iQVByjlJ+spktaWdwHPv9u6UIxgVmseTZ76z1B
         kPsEFyd3qsJ95JNs2VL8qiFgjODG25/KLoYefMZfxvv+eKz8KhmJROoDbJYD6vsRMvQd
         FqFxg2pdK4tH3RcFbFswXXj1MDMl+NyqfW9eQ10fVHQHfxEttuoAEAXKCRkgWOvfuz72
         IMM20kNmfCY3HlGIPKoJnym/djxgCmCBxKLZfEPKKA7lDSe0zhGVssMnktqJznn62Nle
         MQlb3V9gZHF59DBQF1izVBO8QLEZt0ojB/HiJNIMKrGjKZBnTxDqDYqBE2StIP+p8UpA
         znKw==
X-Gm-Message-State: AOAM532joOy+NJvJG0gPKxKhM50sXGjT9mHzll8sKsGZ5p4UgGYPLzhh
        sYaDsC6rC9FdrSrhyHYzp9clUBP1wVUPbdblh8A=
X-Google-Smtp-Source: ABdhPJzSlitPphX9NPKKeBOaAS0xfEbTFOcGp9G4mTI2lVkhjmvsd+RC6JOVWuesmfojQyoUDtEtnRrk940U5OMQqP4=
X-Received: by 2002:a25:bc4e:: with SMTP id d14mr21822919ybk.488.1622563195653;
 Tue, 01 Jun 2021 08:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com> <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation>
In-Reply-To: <YLX5PLZjjoRiDNGN@kheib-workstation>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 1 Jun 2021 23:59:44 +0800
Message-ID: <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 1, 2021 at 5:09 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>
> On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
> > On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
> > >
> > >
> > >
> > > > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > > >
> > > > =EF=BB=BFOn Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmai=
l.com> wrote:
> > > >>
> > > >> To avoid the following failure when trying to load the rdma_rxe mo=
dule
> > > >> while IPv6 is disabled, Add a check to make sure that IPv6 is enab=
led
> > > >> before trying to create the IPv6 UDP tunnel.
> > > >>
> > > >> $ modprobe rdma_rxe
> > > >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permit=
ted
> > > >
> > > > About this problem, this link:
> > > > https://patchwork.kernel.org/project/linux-rdma/patch/2021041323425=
2.12209-1-yanjun.zhu@intel.com/
> > > > also tries to solve ipv6 problem.
> > > >
> > > > Zhu Yanjun
> > > >
> > >
> > > Yes, but this patch is fixing the problem more cleanly and I=E2=80=99=
ve tested it.

Please check this link
https://lore.kernel.org/linux-rdma/20210326012723.41769-1-yanjun.zhu@intel.=
com/T/
carefully.

Please pay attention to the comments from Jason Gunthorpe

Zhu Yanjun

> > >
> > > Could you please review and ACK this patch?
> >
> > https://www.spinics.net/lists/linux-rdma/msg100274.html
> > Compared with the above commit, are the following also needed?
> >
>
> I don't think so, because we aren't going to reach this function.
>
> Do you know about a real bug that fails in this function?!
>
> Thanks,
> Kamal
>
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> > b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 0701bd1ffd1a..6ef092cb575e 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
> > net_device *ndev,
> >         struct dst_entry *ndst;
> >         struct flowi6 fl6 =3D { { 0 } };
> >
> > +       if (!ipv6_mod_enabled()) {
> > +               pr_info("IPv6 is disabled by ipv6.disable=3D1 in cmdlin=
e");
> > +               return NULL;
> > +       }
> > +
> >         memset(&fl6, 0, sizeof(fl6));
> >         fl6.flowi6_oif =3D ndev->ifindex;
> >         memcpy(&fl6.saddr, saddr, sizeof(*saddr));
> >
> > Zhu Yanjun
> >
> > >
> > > Thanks,
> > > Kamal
> > >
> > >
> > > >>
> > > >> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel=
")
> > > >> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > >> ---
> > > >> drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
> > > >> 1 file changed, 8 insertions(+), 6 deletions(-)
> > > >>
> > > >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infinib=
and/sw/rxe/rxe_net.c
> > > >> index 01662727dca0..f353fc18769f 100644
> > > >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > > >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > > >> @@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
> > > >> {
> > > >> #if IS_ENABLED(CONFIG_IPV6)
> > > >>
> > > >> -       recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_net,
> > > >> -                                               htons(ROCE_V2_UDP_=
DPORT), true);
> > > >> -       if (IS_ERR(recv_sockets.sk6)) {
> > > >> -               recv_sockets.sk6 =3D NULL;
> > > >> -               pr_err("Failed to create IPv6 UDP tunnel\n");
> > > >> -               return -1;
> > > >> +       if (ipv6_mod_enabled()) {
> > > >> +               recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_ne=
t,
> > > >> +                                       htons(ROCE_V2_UDP_DPORT), =
true);
> > > >> +               if (IS_ERR(recv_sockets.sk6)) {
> > > >> +                       recv_sockets.sk6 =3D NULL;
> > > >> +                       pr_err("Failed to create IPv6 UDP tunnel\n=
");
> > > >> +                       return -1;
> > > >> +               }
> > > >>        }
> > > >> #endif
> > > >>        return 0;
> > > >> --
> > > >> 2.26.3
> > > >>
