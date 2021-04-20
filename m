Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23553365517
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhDTJPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhDTJPY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Apr 2021 05:15:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195BAC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 02:14:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so57207342ejc.4
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGkBDGJo78gu/+Pqi/UsBkJmHT/hiWPzZD+R+vMVpF0=;
        b=NcUko+zKpOM+IqNZH1isMfmF0xcnVqPgex7POrvWne5wq2zQJhA4e2uKEIJgLW4pz5
         wgOLGePfHq1qJO2pxzQEecrzD6kzLbjxAEYEAnLNcgRaHyJFQTwsnxP7oWY7EsInOuO0
         QFe7/cv/hWIvftUCpoP43MwK8hXRpBcJyA3CnkA6RS9ouWSfw8eQerhLCZpZGiVbtKXx
         Ydw41NK7KnaMt7lsdmuntomshLCkybEUjWDgJ587kwWW6lnAZxDS5VH8PqgLCfhuAaEl
         2mvGR85gw/6DeyUuG5bwrY5ZqDWlfRK+DvHnBM49HaPja2t25CJ21IeVUJn+rf/KM76t
         cTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGkBDGJo78gu/+Pqi/UsBkJmHT/hiWPzZD+R+vMVpF0=;
        b=UPxZEN6cShCVb2ZY1NwtcD28BXqKSiTw+irLRUgXLa/Lg5McBzwkZ4yb3ab+O/3j0p
         kVlk0An3GvvHeduH3pk5sZAaLaDsdZgwLPf6dnUYtl7R8MQA2dh4eeoFBgzgMrwnNMc4
         IZTviGKj5w6PCqNrr0gBVuog40ub+XMRLYvoEoNmhX0yyJaQRG7ir9d1AOg5At7Nd6IT
         2SxJo9zfvX0QQivqyYjvrqIKaiEafraVDhmtEeSJPb376RviZz7/KAxJZh6jKxUf2C2u
         rBFnQHYUxu6uFrZesY9ye2HympaHMBW9P3qm+C0AHbUYHFMQAzgWEkq5QlQYTXN4WjeJ
         YtPw==
X-Gm-Message-State: AOAM533SHsTQuPNhX9X6nQLQmyB9Qne3bfw8MEcarf9ndaniJP1wjFDZ
        V6pC8/Tkaupil1xksz5tjlOmLe4dH0aitqDhmdSFGg==
X-Google-Smtp-Source: ABdhPJx3jJuj3o1OlmfpRVdmCHPCpVv8gYNW8RUtTnlD5YVy+SwE2tZ1LqwcF6vq1wmGrOT4xzPa0V+TmtmMjsaIFNs=
X-Received: by 2002:a17:906:fca1:: with SMTP id qw1mr26055464ejb.478.1618910091799;
 Tue, 20 Apr 2021 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal> <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal> <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
 <YFg/sb+vnpIhyh1c@unreal>
In-Reply-To: <YFg/sb+vnpIhyh1c@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 20 Apr 2021 11:14:41 +0200
Message-ID: <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
Subject: Re: IPoIB child interfaces not working with mlx5
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <xjtuwjp@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 7:56 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> > On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org> wrote=
:
> > >
> > > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B43=E6=9C=8820=
=E6=97=A5 =E5=91=A8=E5=85=AD12:17=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > > > Hi Jason and Leon,
> > > > > >
> > > > > > We recently switch to use upstream OFED from MLNX-OFED, and we =
notice
> > > > > > IPoIB stop working with upstream kernel 5.4.102 with mellanox C=
X-5
> > > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kern=
el it
> > > > > > behaves the same.
> > > > >
> > > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?
> > > > >
> > > > > Thanks
> > > >
> > > >  Yes.
> > >
> > > > Is this expected behavor?
> > >
> > > Yes, we wanted to make IPoIB behave like any other netdev interfaces =
and
> > > if parent interface isn't enabled, no traffic should pass. More on th=
at,
> > > in our internal implementation of enhanced IPoIB, we are reusing same
> > > resources for both parent and child, this requires us to wait for "UP=
"
> > > event before allowing traffic.
> > >
> > > Thanks
> > Hi Leon,
> >
> > Thanks for the clarification, is this behavior documented somewhere?
> > is it specific to "enhanced IPoIB" for CX-5?
>
> It is specific to "enhanced IPoIB" and not to device. I don't know where
> we can document it.
>
> > Will it work differently if without MLX5_CORE_IPOIB enabled?
>
> Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IPoIB",
> exactly as cx-3. The best thing will be to change IPoIB ULP to behave
> like netdev, but we were not comfortable to do it back then due to
> user visible nature of such change.
>
Hi Leon,

More testing reveals new problems with MLX5_CORE_IPOIB.
w MLX5_CORE_IPOIB, ping wors on both hosts, but iperf3 doens't send any dat=
a.
I'm running on A: "iperf3 -s"
and on B: "sudo iperf3 -t 30000 -c ip6_of_A"
example output

[  5] local 2a02:247f:401:1:2:0:a:391 port 41288 connected to
2a02:247f:401:1:2:0:a:392 port 5201

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd

[  5]   0.00-1.00   sec   165 KBytes  1.35 Mbits/sec    2   3.93 KBytes

[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    1   3.93 KBytes


[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1   3.93 KBytes

While when I disable MLX5_CORE_IPOIB, run the same test above, iperf
run without problem.

[  5] local 2a02:247f:401:1:2:0:a:391 port 51866 connected to
2a02:247f:401:1:2:0:a:392 port 5201

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd

[  5]   0.00-1.00   sec   293 MBytes  2.46 Gbits/sec    0   1.50 MBytes

[  5]   1.00-2.00   sec   290 MBytes  2.43 Gbits/sec    0   1.50 MBytes

[  5]   2.00-3.00   sec   289 MBytes  2.42 Gbits/sec    0   1.50 MBytes

[  5]   3.00-4.00   sec   290 MBytes  2.43 Gbits/sec    0   1.50 MBytes

On both side we have:
jwang@ps401a-913.nst:/mnt/jwang$ ibstat
CA 'mlx5_0'
CA type: MT4119
Number of ports: 1
Firmware version: 16.27.2008
Hardware version: 0
Node GUID: 0x98039b03006c7912
System image GUID: 0x98039b03006c7912
Port 1:
State: Active
Physical state: LinkUp
Rate: 40
Base lid: 14
LMC: 0
SM lid: 19
Capability mask: 0x2651e848
Port GUID: 0x98039b03006c7912
Link layer: InfiniBand
CA 'mlx5_1'
CA type: MT4119
Number of ports: 1
Firmware version: 16.27.2008
Hardware version: 0
Node GUID: 0x98039b03006c7913
System image GUID: 0x98039b03006c7912
Port 1:
State: Active
Physical state: LinkUp
Rate: 40
Base lid: 15
LMC: 0
SM lid: 45
Capability mask: 0x2651e848
Port GUID: 0x98039b03006c7913
Link layer: InfiniBand

The initial tests were done on 5.4.102.
And I did a brief test with ~linux-5.12-rc4 with MLX5_CORE_IPOIB,
iperf3 also doesn't work as same as 5.4.102.

cat /etc/network/interfaces.d/infiniband
auto ib0.beef
iface ib0.beef inet static
    address 10.42.3.145
    netmask 20
    up sysctl -w net.ipv4.conf.ib0/beef.forwarding=3D1
    up ethtool -K $IFACE gro off
    pre-up ip link set ib0 up
    dad-attempts 600

auto ib0.dddd
iface ib0.dddd inet6 static
    address 2a02:247f:401:1:2:0:a:391
    netmask 64
    pre-up ip link set ib0 up
    up sysctl -w net.ipv6.conf.ib0/dddd.forwarding=3D1
net.ipv6.conf.ib0/dddd.proxy_ndp=3D1
    up ip -6 route add fd57:1:0:4::/64 dev $IFACE
    up ethtool -K $IFACE gro off
    dad-attempts 600

auto ib1.beef
iface ib1.beef inet static
    address 10.43.3.145
    netmask 20
    up sysctl -w net.ipv4.conf.ib1/beef.forwarding=3D1
    up ethtool -K $IFACE gro off
    pre-up ip link set ib1 up
    dad-attempts 600

auto ib1.dddd
iface ib1.dddd inet6 static
    address 2a02:247f:402:1:2:0:a:391
    netmask 64
    pre-up ip link set ib1 up
    up sysctl -w net.ipv6.conf.ib1/dddd.forwarding=3D1
net.ipv6.conf.ib1/dddd.proxy_ndp=3D1
    up ip -6 route add fd57:2:0:4::/64 dev $IFACE
    up ethtool -K $IFACE gro off
    dad-attempts 600

Thanks!
