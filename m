Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1023D493F65
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356520AbiASRxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 12:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbiASRxP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 12:53:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D962C061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 09:53:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so7169859wmq.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iDyzkv0/APjnfTHOjAbgpoSWcpXiw5tRaH4K86h0F2U=;
        b=V4XeL3IBIE8W4ZHoIMGHm2DpT48hZbjfLlgPSRXhrHZ+lJadBQPOFatGzcgroZTp1C
         FHbgauCJ3k5eINX6nZrKQKWrTcmTq9hD9+QaUWz4w6K7GiwKC0VGQFfmIzGqAcexmo+p
         6YffDHbPnvKv4pIY5a4WC4zOKixysNdHLLrMSqYXNvivQg0XtlXlO0Y4HuZJQzpuBIPb
         GsEyjsz/Of1B5oWlGaa2G8ueowEY25X9yTLUkjstDmW6guBIJGmx5u7G1o/yDJZADHmI
         vbqLaYGDKQcqAQW1xbJppKU7cmkzVubn4zliHM+eTQWNyFMYrusq9vHSjacriP4L9AcP
         9A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iDyzkv0/APjnfTHOjAbgpoSWcpXiw5tRaH4K86h0F2U=;
        b=kCS57Yw5rasqwwiTgX/FNUQL0fBwt9bJR6L7p0ZNFM0bPjEcA75W2GAsR5HSGIdSlN
         sYtzXv4As/C32MK/hm9AzCjPcw/fq5sDtzbKhJbuM22oNqDYgoGXWld7yudOF4KqxV3w
         bmSlnrLKX2q0oS3EnoqutyjwtOw5LtDDYrhEyqMuI/TjrASGhrnrSVFMTQmcoy1RN/93
         7aJ4jJFdWOhKd7eK2HooVmUY4g690HWUtiYZ5TlW/pPeISw8PJr3QHmduYWpz9mIqXIs
         FT1RwdAt6pHHd45+2MhInyOIiM0WpjpJWVelOJb5S9yidU/7oSYr6BWwNDF1jFaaMkWC
         ANow==
X-Gm-Message-State: AOAM530Aa7/7V5cKEEEfKCJznlNLNVpXOEXDedaagqm3huudMj0X8d8V
        uMbe+/JsWpe0ZH15eyeztgVqUsovPntrUcCSm0eZ7vIDxF0=
X-Google-Smtp-Source: ABdhPJzzoYxZevz4vNZ6d+4rzOboT5XDc6gLkrsNECSMqrAMF1+W8X2eqe71osSt6dxk6OOU+ZV1rl87D27y8fDO1S4=
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr2827284wrt.567.1642614794012;
 Wed, 19 Jan 2022 09:53:14 -0800 (PST)
MIME-Version: 1.0
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
 <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
In-Reply-To: <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
From:   Alexander Kalentyev <comrad.karlovich@gmail.com>
Date:   Wed, 19 Jan 2022 18:53:02 +0100
Message-ID: <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
Subject: Re: rdma_rxe usage problem
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With rping everything was fiine, but I had to use a real Ip address.
 >rping -s -C 10 -v
server ping data: rdma-ping-0:
ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
server ping data: rdma-ping-1:
BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
server ping data: rdma-ping-2:
CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
server ping data: rdma-ping-3:
DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
server ping data: rdma-ping-4:
EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
server ping data: rdma-ping-5:
FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
server ping data: rdma-ping-6:
GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
server ping data: rdma-ping-7:
HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
server ping data: rdma-ping-8:
IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
server ping data: rdma-ping-9:
JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
server DISCONNECT EVENT...
wait for RDMA_READ_ADV state 10

>rping -c -a 192.168.0.176 -C 10 -v
ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
ping data: rdma-ping-2: CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
ping data: rdma-ping-3: DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
ping data: rdma-ping-4: EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
ping data: rdma-ping-5: FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
ping data: rdma-ping-6: GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
ping data: rdma-ping-7: HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
ping data: rdma-ping-8: IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
ping data: rdma-ping-9: JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
client DISCONNECT EVENT...

Anyway the ibv_rc_pingpong shows an error:

>ibv_rc_pingpong -d rxe0 -g 0
  local address:  LID 0x0000, QPN 0x000015, PSN 0x015dd8, GID
fe80::4a51:c5ff:fef6:e159
Failed to modify QP to RTR
Couldn't connect to remote QP

>ibv_rc_pingpong -d rxe0 -g 0 192.168.0.176
  local address:  LID 0x0000, QPN 0x000016, PSN 0x007fa7, GID
fe80::4a51:c5ff:fef6:e159
client read/write: No space left on device
Couldn't read/write remote address

=D1=81=D1=80, 19 =D1=8F=D0=BD=D0=B2. 2022 =D0=B3. =D0=B2 15:12, Yanjun Zhu =
<yanjun.zhu@linux.dev>:
>
> =E5=9C=A8 2022/1/19 19:42, Alexander Kalentyev =E5=86=99=E9=81=93:
> > I am trying to install and use soft RoCE for development purposes
> > (right now on a localhost).
> > I installed rdma-core on a MANJARO system from AUR.
> > Then I did:
> >
> > sudo modprobe rdma_rxe
> > sudo rdma link add rxe0 type rxe netdev wlp60s0
> >
> > then ibstat shows:
> > CA 'rxe0'
> >          CA type:
> >          Number of ports: 1
> >          Firmware version:
> >          Hardware version:
> >          Node GUID: 0x4a51c5fffef6e159
> >          System image GUID: 0x4a51c5fffef6e159
> >          Port 1:
> >                  State: Active
> >                  Physical state: LinkUp
> >                  Rate: 2.5
> >                  Base lid: 0
> >                  LMC: 0
> >                  SM lid: 0
> >                  Capability mask: 0x00010000
> >                  Port GUID: 0x4a51c5fffef6e159
> >                  Link layer: Ethernet
>
> Can rping work after you configured this test environment?
>
> Zhu Yanjun
>
> >
> > But launching any example I always get an error by call of: ibv_modify_=
qp
> > with an attempt to modify QP state to RTR (for example by launching
> > .ibv_rc_pingpong)
> > The type of the error is EINVAL.
> > I believe I miss something very obvious.
>
