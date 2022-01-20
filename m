Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415D494D0C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 12:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiATLcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 06:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiATLcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 06:32:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5591C06173F
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 03:32:24 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id r65so13255844ybc.11
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vFkDs/NcBYlgoHrWrGrB0pmsoewd7rlqVyvmrbskyT8=;
        b=Ji15+VuuPBtoemRSdWpBy0AC0Qk7dasazlkesiFTFcZvhGUNMNr3mWO46HeAbGYcvK
         F/c7xtFujYYsPEfJ5LOVExOF3aXuYgtqInYZwQRDbQkmEozR116oxAh6Cd9wEg0JETZY
         56KICk2MO+PqWHFgoX3mKUDz/r23fIVtzaw6cZnCDi+OxVSJbeLw77Lq3elkt+5TQWYf
         f7fq2+nphXFgdwShblN67+YSGgQa3zKj83tRxrzyIylccR9zE4PiDke/WfaqRYITwbh+
         WVrbIn3UbsP7YZaZDAt1GuywtLH8t5Xav/DT53uh3MF1mn3QwMRRHp3A9BYTfEG4UjwU
         4acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vFkDs/NcBYlgoHrWrGrB0pmsoewd7rlqVyvmrbskyT8=;
        b=m5rsReSTAKia6ZRVCQ4XgEDwNj2UxB2abk1+DpfnvVOxN0xPfO3eWDqu52a9tno6Ci
         7yzUJUpPL0FQRLNctdFBkWuovJM+RWaTU7B08IEoPU39zYuDQ59b7Y1xwSMVSHgH5qWq
         VDk6e4/Z/e27ypGy5s9ac5bSGNu4E3+VrcXjvIP8pZjQkanuJDmmZ/0dQWVNqQ/+injA
         zczInKaCf/HyH1n8580ei2sRdq57cXLHLCfWIw4dDFy5ZzVd3hRE1d+T9uxBc74WPje7
         LqRWUdw6xmldM6UarxxdElaJs1zCYZGw0iFCJ7jdnj7j94lavioJKS+DmSYiT6UBoBb1
         sdeQ==
X-Gm-Message-State: AOAM533qkccqeKsAcvYowKdMgG7+mgiWOATkseMcYj7ttOa/WLvC9m7t
        ou7DlPqQEMmzsy0nYvHK8t8Jh9CVOM0DVQmXsvU=
X-Google-Smtp-Source: ABdhPJyUBO+DsmdpDsJ4Pn5i7Cv49GEzLcYxsQq3Pf2omsAHdn3o6GtAPIxPaNCeZd4qPWOLSWV9DQVv6zmA2cjHFBw=
X-Received: by 2002:a25:1388:: with SMTP id 130mr46889270ybt.321.1642678344119;
 Thu, 20 Jan 2022 03:32:24 -0800 (PST)
MIME-Version: 1.0
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
 <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev> <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
 <PH7PR84MB14880DAC2578D1CBFAC7CC87BC599@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH7PR84MB14880DAC2578D1CBFAC7CC87BC599@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
From:   Alexander Kalentyev <comrad.karlovich@gmail.com>
Date:   Thu, 20 Jan 2022 12:32:12 +0100
Message-ID: <CABrV9Ys2QnOWJo=-m3fgz77=uLxtbKN4HcDgtxzFskXEObmL-Q@mail.gmail.com>
Subject: Re: rdma_rxe usage problem
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Robert,

Thank you for your help!
What I did was :
ipv6calc --in prefix+mac fe80:: XX:XX:XX:XX:XX:XX
(with XX:XX:XX:XX:XX:XX one have to insert the MAC address of the NIC)
And then
udo ip addr add dev <dev> fe80::ZZZZ:ZZZZ:ZZZZ:ZZZZ/64
(with ZZZ:ZZZZ:ZZZZ the address genereted by ipv6calc)
sudo rdma link add rxe0 type rxe netdev <dev>
After that everything is working as expected:
>ibv_rc_pingpong -d rxe0 -g 0 192.168.0.176
  local address:  LID 0x0000, QPN 0x000012, PSN 0xf85048, GID
ZZZZ::ZZZZ:ZZZZ:ZZZZ:ZZZZ
  remote address: LID 0x0000, QPN 0x000011, PSN 0xf7c7b7, GID
ZZZZ::ZZZZ:ZZZZ:ZZZZ:ZZZZ
8192000 bytes in 0.01 seconds =3D 4743.49 Mbit/sec
1000 iters in 0.01 seconds =3D 13.82 usec/iter

So, I think it make sense to include this information in a README on
github. Otherwise somebody like me can spend a week trying to figure
out what is going on!

Thanks once again!
Regards,
Alexander Kalentev

=D1=81=D1=80, 19 =D1=8F=D0=BD=D0=B2. 2022 =D0=B3. =D0=B2 20:54, Pearson, Ro=
bert B <robert.pearson2@hpe.com>:
>
>
>
> -----Original Message-----
> From: Alexander Kalentyev <comrad.karlovich@gmail.com>
> Sent: Wednesday, January 19, 2022 11:53 AM
>
>
> Anyway the ibv_rc_pingpong shows an error:
>
> >ibv_rc_pingpong -d rxe0 -g 0
>   local address:  LID 0x0000, QPN 0x000015, PSN 0x015dd8, GID
> fe80::4a51:c5ff:fef6:e159
> Failed to modify QP to RTR
> Couldn't connect to remote QP
>
> >
> Alexander,
>
> I use a script to restart rxe after changing anything it looks like
>
>         #!/bin/bash
>
>         export LD_LIBRARY_PATH=3D<path to rdma-core>/rdma-core/build/lib:=
/usr/lib
>
>         sudo rmmod rdma_rxe
>         sudo modprobe rdma_rxe
>
>         sudo ip link set dev enp0s3 mtu 4500
>         sudo ip addr add dev enp0s3 fe80::0a00:27ff:fe35:5ea7/64
>         sudo rdma link add rxe0 type rxe netdev enp0s3
>
> The important line is adding the ipv6 address which corresponds with the =
MAC address of
> The ethernet nic which is
>
>         08:00:27:35:5e:a7
>
> Some OSes (like mine) do not create this address automatically but mangle=
 the address.
> But the rdma core driver seems to expect all roce providers to have it.
>
> Hope this helps.
>
> Bob Pearson
> rpearson@hpe.com
