Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72413761B9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhEGIMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhEGIM3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 04:12:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC844C061574
        for <linux-rdma@vger.kernel.org>; Fri,  7 May 2021 01:11:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so9153761edt.13
        for <linux-rdma@vger.kernel.org>; Fri, 07 May 2021 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=royrZmeDWq7Z8fhpz8iDpMNyCKBBBgnWjC5Dz932S1E=;
        b=WMJ3G0OXnHPNbWOU/bbs+ZW/XQSxfD6BLwfG4pzwUsnZxnuxnOXrEknSi4TFNDEUJi
         hwDNueBp5W4iAMnLMXTmB/iUXYNk+awlm6xLnF51obY8cWhfFA1JbQ3Pc1vjBqPYMfDp
         WUrpsw8ZO5xqfV5QzpFk6mBGaJcX8XnvbQ/PUJxtv3Y0+TQyt/oA2637wFoazWTHoizq
         Q3LKyiwZf3x7ohRibYa+hp2da8FiMfYGFptQHbMT/CKaG7hgnNUwPm1gUBVGEV8zMeLZ
         R4xsDLjvJLM5zcyBVnW2Jgg1xOtx+h013vmIl1nTOh3nUipJ46ejSVFDCZDTzIl9rQKi
         GjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=royrZmeDWq7Z8fhpz8iDpMNyCKBBBgnWjC5Dz932S1E=;
        b=bFk3DuQ7W5VVsrkm11iztk2G+kuzL8AMTP9B7uJ3VgL04rKnszss333NPmefhjSSCT
         VVhuzEu54UHmGjDOaYcduDZg7XU9l1ZpY30jd7fXxrLIBbjjyVm48cL75yYT4Cs2qpBY
         y2Y95Fq0Wghmf50uq+cXwoA91YEf89iFEvLfxoVBgbyOt/dWK05H4bK5DJEGW+lOY33t
         TrRGXuHi2I3Sv9JMP8KtWwyutG8/ElXZA5syRMoRcy5AVXwqvQKA5jA7e5tu1qgk46UA
         Jxiru4KJpxUx8JCaqtRzwmE2pcI81KM1VsavSqvfafNsACsF9NxnOmR3pXWKVhgn7EMF
         zAyA==
X-Gm-Message-State: AOAM53155XvmS+k88aBqOShNx+CUiAigAlCmt/n8sn2nbysaeEP+h532
        NVnT2Q7DbXSLBEnls6LB0pvVYaGAcrYXRfHZRUEKmA==
X-Google-Smtp-Source: ABdhPJwLpdcKNxKslyLANWjZxR5EzfwGFxibg67W2T058D59ej/xgds87PWMu3DygVDMuZQBpSyJhGunqYDB5Tq+Ijc=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr9904441edu.252.1620375088552;
 Fri, 07 May 2021 01:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal> <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal> <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
 <YFg/sb+vnpIhyh1c@unreal> <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
 <YH67EMmq+Rcd0hLJ@unreal> <CAMGffEmKKMS9dX+PTefsuoD7C350JPZ3hBM6ASm9XuzxvV-7pQ@mail.gmail.com>
 <CAD=hENesFYbU7j7CgS9AqKNJ23YT=ceo4yfsQ43h_UuCRXziyA@mail.gmail.com>
In-Reply-To: <CAD=hENesFYbU7j7CgS9AqKNJ23YT=ceo4yfsQ43h_UuCRXziyA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 7 May 2021 10:11:17 +0200
Message-ID: <CAMGffEnrL=15S6ke66j1YaH0R7Rti1Et8-8KDF8=ts-FmVDwjA@mail.gmail.com>
Subject: Re: IPoIB child interfaces not working with mlx5
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
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

On Fri, May 7, 2021 at 10:03 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Fri, May 7, 2021 at 3:53 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > On Tue, Apr 20, 2021 at 1:29 PM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Tue, Apr 20, 2021 at 11:14:41AM +0200, Jinpu Wang wrote:
> > > > On Mon, Mar 22, 2021 at 7:56 AM Leon Romanovsky <leon@kernel.org> w=
rote:
> > > > >
> > > > > On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> > > > > > On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > > > > > >
> > > > > > > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > > > > > > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B43=E6=
=9C=8820=E6=97=A5 =E5=91=A8=E5=85=AD12:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrot=
e:
> > > > > > > > > > Hi Jason and Leon,
> > > > > > > > > >
> > > > > > > > > > We recently switch to use upstream OFED from MLNX-OFED,=
 and we notice
> > > > > > > > > > IPoIB stop working with upstream kernel 5.4.102 with me=
llanox CX-5
> > > > > > > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5=
.11 kernel it
> > > > > > > > > > behaves the same.
> > > > > > > > >
> > > > > > > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_COR=
E_IPOIB?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > >  Yes.
> > > > > > >
> > > > > > > > Is this expected behavor?
> > > > > > >
> > > > > > > Yes, we wanted to make IPoIB behave like any other netdev int=
erfaces and
> > > > > > > if parent interface isn't enabled, no traffic should pass. Mo=
re on that,
> > > > > > > in our internal implementation of enhanced IPoIB, we are reus=
ing same
> > > > > > > resources for both parent and child, this requires us to wait=
 for "UP"
> > > > > > > event before allowing traffic.
> > > > > > >
> > > > > > > Thanks
> > > > > > Hi Leon,
> > > > > >
> > > > > > Thanks for the clarification, is this behavior documented somew=
here?
> > > > > > is it specific to "enhanced IPoIB" for CX-5?
> > > > >
> > > > > It is specific to "enhanced IPoIB" and not to device. I don't kno=
w where
> > > > > we can document it.
> > > > >
> > > > > > Will it work differently if without MLX5_CORE_IPOIB enabled?
> > > > >
> > > > > Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IP=
oIB",
> > > > > exactly as cx-3. The best thing will be to change IPoIB ULP to be=
have
> > > > > like netdev, but we were not comfortable to do it back then due t=
o
> > > > > user visible nature of such change.
> > > > >
> > > > Hi Leon,
> > > >
> > > > More testing reveals new problems with MLX5_CORE_IPOIB.
> > > > w MLX5_CORE_IPOIB, ping wors on both hosts, but iperf3 doens't send=
 any data.
> >
> >  Just want to give an update, we finally find out the key which leads
> > to the failure on our side.
> >
> > we need to set the child interface to same MTU as the parent.
> > jwang@ps401a-913.nst:/mnt/jwang$ ip link list
> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> > mode DEFAULT group default qlen 1000
> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> > mode DEFAULT group default qlen 1000
> >     link/ether 0c:c4:7a:ff:07:ce brd ff:ff:ff:ff:ff:ff
> > 3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> > DEFAULT group default qlen 1000
> >     link/ether 0c:c4:7a:ff:07:cf brd ff:ff:ff:ff:ff:ff
> > 6: ha_transport: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue
> > state UNKNOWN mode DEFAULT group default qlen 1000
> >     link/ether f6:ff:16:93:08:8a brd ff:ff:ff:ff:ff:ff
> > 11: ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
> > mode DEFAULT group default qlen 1024
> >     link/infiniband
> > 00:00:00:83:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
> > 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
> > 12: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP
> > mode DEFAULT group default qlen 1024
> >     link/infiniband
> > 00:00:01:58:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
> > 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
> > 13: ib0.dddd@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq
> > state UP mode DEFAULT group default qlen 1024
> >     link/infiniband
> > 00:00:10:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:12 brd
> > 00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
> > 14: ib1.dddd@ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq
> > state UP mode DEFAULT group default qlen 1024
> >     link/infiniband
> > 00:00:11:8c:fe:80:00:00:00:00:00:00:98:03:9b:03:00:6c:79:13 brd
> > 00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
> >
> > Initially, ib0 mtu is 2044, and ib0.dddd is 4092.
> > After I reduced ib0.dddd mtu to 2044 on both sides, then iperf3 works f=
ine.
>
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/=
html/networking_guide/sec-configuring_ipoib
>
> "
> When using datagram mode, the unreliable, disconnected queue pair type
> does not allow any packets larger than the InfiniBand link-layer=E2=80=99=
s
> MTU. The IPoIB layer adds a 4 byte IPoIB header on top of the IP
> packet being transmitted. As a result, the IPoIB MTU must be 4 bytes
> less than the InfiniBand link-layer MTU. As 2048 is a common
> InfiniBand link-layer MTU, the common IPoIB device MTU in datagram
> mode is 2044.
> "
Thanks for the hint, Yanjun.
>
> >
> > Could you explain why mtu must be set to exactly the same in case of
> > enhanced IPoIB mode? is there anything else we must treat it special?
> > I guess it related to
> >
> > > > > > > in our internal implementation of enhanced IPoIB, we are reus=
ing same
> > > > > > > resources for both parent and child, this requires us to wait=
 for "UP"
> > > > > > > event before allowing traffic.
> >
> > Thanks!
> > Jinpu
