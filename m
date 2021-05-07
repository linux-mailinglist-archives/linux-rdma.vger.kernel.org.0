Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202C3760B3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEGGym (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhEGGyj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 02:54:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA94C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 23:53:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s6so8919767edu.10
        for <linux-rdma@vger.kernel.org>; Thu, 06 May 2021 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kpl6550eMTghMhVf9MeKIsfXkg6DjCMhwYd6CcNX9wc=;
        b=fMnwmiUcwtFhu/pYl/zkd2cvsM7jqp3ItDWUYoHSi2FQRtlvt+WjQnaWq4NgicWw+B
         PmKGIvhl0Op+ej5CG1bYb7AVyH/JUeBUS9cdVKCO6olwHZrYrjMYLssMoD4E/cqsJV5g
         6fMOcSpOpWfwIDn+m7mSQ5ruoXJb9Ea753ds35p/51wKsbXBms3MSCafTmsg9hnVu6+l
         rH6L2eJDJmGyuJH0NFeAdOw/a9Vr5PKojt+Are5vQ9/pWl5llQjI3bcB274djNIOQUGM
         HaCestOLF7ntff+xU6Y6XdZrZ90u2VzZq47VSFM9BBuOZI1MVgaZsy3gwbDeMzOH2DTp
         b8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kpl6550eMTghMhVf9MeKIsfXkg6DjCMhwYd6CcNX9wc=;
        b=Vq7rpGsfIlzOP8FqB8p32fhegbqU7B5x3kTmXFDxP/TmxNdmIJsfI3l5JdGUQTmUAT
         8pEpTwwF03rT1gGVZUOnrkUC28m9IL+wkAONJof9CzLJdh0b42pb3FTu5rPjbfTShFVC
         hxinNZWnHUMbuIvCFjO5KyAcRztkQXYw/AFPnMWILEPVKoYQ7C6BcB/zQUG+jKMMMzwF
         tChYAx84V/1tqBJiTuywc5mDGvlkcpdhBIStWy4fUH59/QBLnZz2he9qJ9s+uATMLSaw
         r9BZsSNZ8WschM+t/d6Yz2cEOjfjnLte0VlepeZGqE6Afvaa77ewci/mBPgBTK4KST4y
         zTFg==
X-Gm-Message-State: AOAM530V98xPu03miqOpaOTW1tzW/aAfDmsDNkDKJ+HZYD1R11snQ9uD
        pa7hLII7MBO+ZuJx+Buy/Mv2EdjnI0C1D2ousnADu+CRngWV1g==
X-Google-Smtp-Source: ABdhPJwrJzmwZL6EmVrzSadvMwH5ujtS/YfP6pjl1M7A4bX1lnTMljGeFzKgZ6CVhT1j0Y0imWuFkpIlZOIxAEjFe0c=
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr9697617edc.42.1620370418916;
 Thu, 06 May 2021 23:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal> <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal> <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
 <YFg/sb+vnpIhyh1c@unreal> <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
 <YH67EMmq+Rcd0hLJ@unreal>
In-Reply-To: <YH67EMmq+Rcd0hLJ@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 7 May 2021 08:53:28 +0200
Message-ID: <CAMGffEmKKMS9dX+PTefsuoD7C350JPZ3hBM6ASm9XuzxvV-7pQ@mail.gmail.com>
Subject: Re: IPoIB child interfaces not working with mlx5
To:     Leon Romanovsky <leon@kernel.org>, Itay Aveksis <itayav@nvidia.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <xjtuwjp@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 1:29 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Apr 20, 2021 at 11:14:41AM +0200, Jinpu Wang wrote:
> > On Mon, Mar 22, 2021 at 7:56 AM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> > > > On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org> w=
rote:
> > > > >
> > > > > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > > > > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B43=E6=9C=
=8820=E6=97=A5 =E5=91=A8=E5=85=AD12:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > > > > > Hi Jason and Leon,
> > > > > > > >
> > > > > > > > We recently switch to use upstream OFED from MLNX-OFED, and=
 we notice
> > > > > > > > IPoIB stop working with upstream kernel 5.4.102 with mellan=
ox CX-5
> > > > > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 =
kernel it
> > > > > > > > behaves the same.
> > > > > > >
> > > > > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IP=
OIB?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > >  Yes.
> > > > >
> > > > > > Is this expected behavor?
> > > > >
> > > > > Yes, we wanted to make IPoIB behave like any other netdev interfa=
ces and
> > > > > if parent interface isn't enabled, no traffic should pass. More o=
n that,
> > > > > in our internal implementation of enhanced IPoIB, we are reusing =
same
> > > > > resources for both parent and child, this requires us to wait for=
 "UP"
> > > > > event before allowing traffic.
> > > > >
> > > > > Thanks
> > > > Hi Leon,
> > > >
> > > > Thanks for the clarification, is this behavior documented somewhere=
?
> > > > is it specific to "enhanced IPoIB" for CX-5?
> > >
> > > It is specific to "enhanced IPoIB" and not to device. I don't know wh=
ere
> > > we can document it.
> > >
> > > > Will it work differently if without MLX5_CORE_IPOIB enabled?
> > >
> > > Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IPoIB"=
,
> > > exactly as cx-3. The best thing will be to change IPoIB ULP to behave
> > > like netdev, but we were not comfortable to do it back then due to
> > > user visible nature of such change.
> > >
> > Hi Leon,
> >
> > More testing reveals new problems with MLX5_CORE_IPOIB.
> > w MLX5_CORE_IPOIB, ping wors on both hosts, but iperf3 doens't send any=
 data.

 Just want to give an update, we finally find out the key which leads
to the failure on our side.

we need to set the child interface to same MTU as the parent.
jwang@ps401a-913.nst:/mnt/jwang$ ip link list
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
mode DEFAULT group default qlen 1000
    link/ether 0c:c4:7a:ff:07:ce brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000
    link/ether 0c:c4:7a:ff:07:cf brd ff:ff:ff:ff:ff:ff
6: ha_transport: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether f6:ff:16:93:08:8a brd ff:ff:ff:ff:ff:ff
11: ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
mode DEFAULT group default qlen 1024
    link/infiniband
00:00:00:83:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
12: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
mode DEFAULT group default qlen 1024
    link/infiniband
00:00:01:58:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
13: ib0.dddd@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq
state UP mode DEFAULT group default qlen 1024
    link/infiniband
00:00:10:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
14: ib1.dddd@ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq
state UP mode DEFAULT group default qlen 1024
    link/infiniband
00:00:11:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff

Initially, ib0 mtu is 2044, and ib0.dddd is 4092.
After I reduced ib0.dddd mtu to 2044 on both sides, then iperf3 works fine.

Could you explain why mtu must be set to exactly the same in case of
enhanced IPoIB mode? is there anything else we must treat it special?
I guess it related to

> > > > > in our internal implementation of enhanced IPoIB, we are reusing =
same
> > > > > resources for both parent and child, this requires us to wait for=
 "UP"
> > > > > event before allowing traffic.

Thanks!
Jinpu
