Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D3343934
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVGIY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVGIQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 02:08:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC65C061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 23:08:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jy13so19244514ejc.2
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xzUuzUtmW7DeMoXlR0Oj3tHTl+Hsm4yaYn0GOPghFc=;
        b=fpyuIVNTacbMbS9kJmkrua2ItNQ3F2CwlvmpCJZfU9d5VFKT2m3thDhAK7Ajcor+oD
         B9VdzYDqjJfUYOfci/BfZFQLxXnZ/cQhlmeMJjskcsnHbDFWMqD+lX5A6lCSuJv88WMY
         sfW4R7DEqQlnYbjfSEeOWtTzwTbo4ms2CpyOGD8UDNJT3iv6j51ET/E48rduldfmqu2Y
         hXVGV3JLehpkA07yvt0Axrmk5yYe8MeLMCLD+SNtr3vLvfsmhDe0BjpDo4OSd0cGWSis
         4j4jNk8Q4Lo+z2eZz64vufakwMUNGKO/I59YlW1TgRxGNcFhEb8sAaWJ8jabs554TZj7
         bQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xzUuzUtmW7DeMoXlR0Oj3tHTl+Hsm4yaYn0GOPghFc=;
        b=CGhoJZShH2Xh/EjHmjK4Bv5xFMbm3lpFiWT/FDhM00Z1pHkoM9AVGIbAqb2mMN9hcm
         1IwtMVxq9WP1n+HB6V7onBTQL1N8DFwAnOA+yREn8CA6FWcB2wMycgYGkFawiUODlTkW
         5iy+9eH/h67sr6iaWf0INyXULB3jyFhJdAlQ7BBlYxMz6NJBvFB2jVVW9bGvL/DEI4X/
         zJuhyxmhZXcHwGr8qj++fTi9fquJ0qWIenGDNZbJpe54T3osnKiiloCTUmdH2W+f7SKv
         Q8jU8Derd+i7VLj5oJMnWLrxo+UzRZnPdKp+ZCMttwy/Z4rtXe9JAQzlPmVCsCwNk7BD
         TDhA==
X-Gm-Message-State: AOAM530zZcfwii9hsyRTIDiOe0UjFjoo2Fd288h3FqGZoTpF7VnC8F9f
        npK4zBknjF7qr+kr1Zv0WWDnfJQ5b2J/cW+A86FeHA==
X-Google-Smtp-Source: ABdhPJx/iM0F0GF2fIf7ColAG0rcXW/LqIVzF7YPwJTV/pQ1r/LCv8bga023qi0xg7fdZ5GReImwLfA1779Iw/xBXyE=
X-Received: by 2002:a17:906:cf90:: with SMTP id um16mr17822705ejb.389.1616393291792;
 Sun, 21 Mar 2021 23:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal> <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal>
In-Reply-To: <YFdE9A6oUHLla2Xu@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 22 Mar 2021 07:08:01 +0100
Message-ID: <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
Subject: Re: IPoIB child interfaces not working with mlx5
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <xjtuwjp@gmail.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=
=97=A5 =E5=91=A8=E5=85=AD12:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > Hi Jason and Leon,
> > > >
> > > > We recently switch to use upstream OFED from MLNX-OFED, and we noti=
ce
> > > > IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
> > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel i=
t
> > > > behaves the same.
> > >
> > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?
> > >
> > > Thanks
> >
> >  Yes.
>
> > Is this expected behavor?
>
> Yes, we wanted to make IPoIB behave like any other netdev interfaces and
> if parent interface isn't enabled, no traffic should pass. More on that,
> in our internal implementation of enhanced IPoIB, we are reusing same
> resources for both parent and child, this requires us to wait for "UP"
> event before allowing traffic.
>
> Thanks
Hi Leon,

Thanks for the clarification, is this behavior documented somewhere?
is it specific to "enhanced IPoIB" for CX-5?
Will it work differently if without MLX5_CORE_IPOIB enabled?

I think it would be helpful to add a message if possible to remind
admin to enable parent if only child if configured.

Thanks!

>
> >
> > >
> > >
