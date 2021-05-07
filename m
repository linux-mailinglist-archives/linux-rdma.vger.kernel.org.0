Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B657537619E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEGIEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhEGIEs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 04:04:48 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75DDC061574
        for <linux-rdma@vger.kernel.org>; Fri,  7 May 2021 01:03:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso6453108ots.10
        for <linux-rdma@vger.kernel.org>; Fri, 07 May 2021 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n5lzsMsNTI1attWFM1qp1YCUcPsgEIOycN65eYHoGnk=;
        b=fHv4ALSuOpY8k+/eIof06ZRbr7t7lFSfLcAHzdkAqlyTQMtYTgjD9/1hCdqArR5sAK
         UlZ9ldWhO3DdcKE8/f/rwhNGUqxFWknFmmRcC0mOHPN1d3X5jQ8I+25tsj5YaC11FkU0
         k8xQF9ojFcLj/21eTjoIpjnWO3zmvyO1KYYwrDFxQN8Z9x+u1FODlLo7713rdQmwstS2
         0xOYlq+aXkoMvAfzQ1PK6FiUjH+7kwbQSOsC/pNuctuXUgFlZAOc1e9esqHJDxu/KVaW
         wBu6tqvlutFpHYJ4wClNl6bvkgNbOmtkY0fI7M5VreOaHnG4YoO96SyaNB5RscVGLHdG
         OjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n5lzsMsNTI1attWFM1qp1YCUcPsgEIOycN65eYHoGnk=;
        b=GR3r2euOz2XMQqAjEw9JExOpOysabLtZB0t/o4CNavqLh8kogmDmEzsaL1FfKzQDsj
         HpjtdUDxzUwA1967zitqmj2brp9Qu/KMXFFl04ZiwJWH6TbHGhMFjBByhMOjBxm8hJZr
         DWYyRXvC3RfpaMHWlfiNYbwm28k6cl57T536q7Eg3bkCQ07QQP9U+wKqjR7IgIGT7UvE
         H+LHCOdZDfUF9TjagL6TiJWpL63rORnq1/nUXHXbwASz/7cS5u64cQTL78EXqK3Nbwet
         5ENKDzQhMNfWZWM7RUufHWvD0kxaG8PWnPLa4PlANCmAW0uGyX4vyCqybBN7xqCWm/bk
         eg3g==
X-Gm-Message-State: AOAM5318YkKXq0ohP+B6lCOCvBhwIN0pQSoYExoo5nfdCYdNuoad1f4A
        RB+HuDRmAQhWfvdEZ2PrJ0sQivL8C8pr7I81jm4=
X-Google-Smtp-Source: ABdhPJxFOXk1Gc3bA44naSub50Sul2RP3i//wP79X3ABEhcdUqWAmQrOtdESHHFf/ARlNC8FHXYtOfC+MHNkDkK8K7k=
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr7042665otu.53.1620374628357;
 Fri, 07 May 2021 01:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal> <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal> <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
 <YFg/sb+vnpIhyh1c@unreal> <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
 <YH67EMmq+Rcd0hLJ@unreal> <CAMGffEmKKMS9dX+PTefsuoD7C350JPZ3hBM6ASm9XuzxvV-7pQ@mail.gmail.com>
In-Reply-To: <CAMGffEmKKMS9dX+PTefsuoD7C350JPZ3hBM6ASm9XuzxvV-7pQ@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 7 May 2021 16:03:37 +0800
Message-ID: <CAD=hENesFYbU7j7CgS9AqKNJ23YT=ceo4yfsQ43h_UuCRXziyA@mail.gmail.com>
Subject: Re: IPoIB child interfaces not working with mlx5
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Itay Aveksis <itayav@nvidia.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <xjtuwjp@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 7, 2021 at 3:53 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Tue, Apr 20, 2021 at 1:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Apr 20, 2021 at 11:14:41AM +0200, Jinpu Wang wrote:
> > > On Mon, Mar 22, 2021 at 7:56 AM Leon Romanovsky <leon@kernel.org> wro=
te:
> > > >
> > > > On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> > > > > On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org>=
 wrote:
> > > > > >
> > > > > > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > > > > > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B43=E6=
=9C=8820=E6=97=A5 =E5=91=A8=E5=85=AD12:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > > > > > > Hi Jason and Leon,
> > > > > > > > >
> > > > > > > > > We recently switch to use upstream OFED from MLNX-OFED, a=
nd we notice
> > > > > > > > > IPoIB stop working with upstream kernel 5.4.102 with mell=
anox CX-5
> > > > > > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.1=
1 kernel it
> > > > > > > > > behaves the same.
> > > > > > > >
> > > > > > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_=
IPOIB?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > >  Yes.
> > > > > >
> > > > > > > Is this expected behavor?
> > > > > >
> > > > > > Yes, we wanted to make IPoIB behave like any other netdev inter=
faces and
> > > > > > if parent interface isn't enabled, no traffic should pass. More=
 on that,
> > > > > > in our internal implementation of enhanced IPoIB, we are reusin=
g same
> > > > > > resources for both parent and child, this requires us to wait f=
or "UP"
> > > > > > event before allowing traffic.
> > > > > >
> > > > > > Thanks
> > > > > Hi Leon,
> > > > >
> > > > > Thanks for the clarification, is this behavior documented somewhe=
re?
> > > > > is it specific to "enhanced IPoIB" for CX-5?
> > > >
> > > > It is specific to "enhanced IPoIB" and not to device. I don't know =
where
> > > > we can document it.
> > > >
> > > > > Will it work differently if without MLX5_CORE_IPOIB enabled?
> > > >
> > > > Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IPoI=
B",
> > > > exactly as cx-3. The best thing will be to change IPoIB ULP to beha=
ve
> > > > like netdev, but we were not comfortable to do it back then due to
> > > > user visible nature of such change.
> > > >
> > > Hi Leon,
> > >
> > > More testing reveals new problems with MLX5_CORE_IPOIB.
> > > w MLX5_CORE_IPOIB, ping wors on both hosts, but iperf3 doens't send a=
ny data.
>
>  Just want to give an update, we finally find out the key which leads
> to the failure on our side.
>
> we need to set the child interface to same MTU as the parent.
> jwang@ps401a-913.nst:/mnt/jwang$ ip link list
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> mode DEFAULT group default qlen 1000
>     link/ether 0c:c4:7a:ff:07:ce brd ff:ff:ff:ff:ff:ff
> 3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
>     link/ether 0c:c4:7a:ff:07:cf brd ff:ff:ff:ff:ff:ff
> 6: ha_transport: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UNKNOWN mode DEFAULT group default qlen 1000
>     link/ether f6:ff:16:93:08:8a brd ff:ff:ff:ff:ff:ff
> 11: ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
> mode DEFAULT group default qlen 1024
>     link/infiniband
> 00:00:00:83:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
> 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
> 12: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
> mode DEFAULT group default qlen 1024
>     link/infiniband
> 00:00:01:58:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
> 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
> 13: ib0.dddd@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq
> state UP mode DEFAULT group default qlen 1024
>     link/infiniband
> 00:00:10:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
> 00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
> 14: ib1.dddd@ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq
> state UP mode DEFAULT group default qlen 1024
>     link/infiniband
> 00:00:11:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
> 00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
>
> Initially, ib0 mtu is 2044, and ib0.dddd is 4092.
> After I reduced ib0.dddd mtu to 2044 on both sides, then iperf3 works fin=
e.

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/ht=
ml/networking_guide/sec-configuring_ipoib

"
When using datagram mode, the unreliable, disconnected queue pair type
does not allow any packets larger than the InfiniBand link-layer=E2=80=99s
MTU. The IPoIB layer adds a 4 byte IPoIB header on top of the IP
packet being transmitted. As a result, the IPoIB MTU must be 4 bytes
less than the InfiniBand link-layer MTU. As 2048 is a common
InfiniBand link-layer MTU, the common IPoIB device MTU in datagram
mode is 2044.
"

>
> Could you explain why mtu must be set to exactly the same in case of
> enhanced IPoIB mode? is there anything else we must treat it special?
> I guess it related to
>
> > > > > > in our internal implementation of enhanced IPoIB, we are reusin=
g same
> > > > > > resources for both parent and child, this requires us to wait f=
or "UP"
> > > > > > event before allowing traffic.
>
> Thanks!
> Jinpu
