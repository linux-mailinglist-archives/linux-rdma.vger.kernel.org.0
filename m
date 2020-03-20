Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2F18D37E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCTQEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 12:04:49 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42507 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTQEt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 12:04:49 -0400
Received: by mail-ed1-f50.google.com with SMTP id b21so7673270edy.9
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6XH7+aNP82F76dRHC2bx1cO0eSYwasjwoWGU6Gh2sk=;
        b=axCP4Xme3kz7jY4EWgjfOlPw6C2rA2+6kDF7Qo5LpLDDqc+jDoFJ9Qffcr5l0S2UoP
         4kmC4JeigR6Pc2ZeUaFLqhL5IKX+88VnrilR7CIRWM6vLX1MerZsyrLtwI5p14g82ebE
         uekLstM2B4v/bRBtKK0i2ozXf51ztqwwUZeYdw2SQ0pMWVQYM9zGYyXv8cW+JvZeQ5ZH
         xQFzvKyDLwhO1xbOq6FI/25Eq/kJzqjdzIF/y6mSiK2+0tQ57NakO80N6HV8NMOo7luX
         cxFLOSwPfSH7y6giVH7oPnI7q9Bx00WejYvo5n1nTAqRMZCXVsWI+cIxdadC4UKNJcYO
         sg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6XH7+aNP82F76dRHC2bx1cO0eSYwasjwoWGU6Gh2sk=;
        b=Xbv2vHBScO/tV5EpFt/w1zNY8mL1J0HYV1CbEj/j7uKhQ46Hak4JTzzLsT6svUYWEd
         RHrXNVp2pFVIn7gZ3IiL4hy5pd5Pc9aPC4d3bWkmHivng7R7y9G5uCm9t+rmc8xDOT46
         rC2jbjkAfGLvIQjcnf7gKbWg0fmg/IJkPm/XgvRfKA3kBotjMZoDIRVs5p332gKBaFXw
         yu3WizVMTTEYGGpXNRaMxqnr/JfCQWFKo3pjzk0r9//sAPoZG1EyIQzw+0Bh73CGTdU6
         8PbVU6K3m3u0nbMtinJSTp/5fQBnbVN856yG/JJaTQLH3fOJBjLDlh+Ezz3uMsF9DdyA
         NgVw==
X-Gm-Message-State: ANhLgQ3UK7qUnK9z5DOkGas1U4M0t7GdH7abAalkBJRwHUm+p5Pnxexk
        9hvKN4hF2YsnNwPvklvyQGxu5aeVt484O7/pTeGMjZmBwjE=
X-Google-Smtp-Source: ADFU+vvQEuuM3hVULaa2TPg+dtfSUfujXcHvgjxKWqKo30GfCsnpyaUj+Da/SmQ6q0li08X/ydOXkGO48AQVd9h8Axo=
X-Received: by 2002:a50:ab1e:: with SMTP id s30mr8805493edc.336.1584720288079;
 Fri, 20 Mar 2020 09:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com> <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
In-Reply-To: <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Fri, 20 Mar 2020 09:04:34 -0700
Message-ID: <CAOc41xGkcgDZoqPHX8uH4uG6E+FSUHMoZdB1H2cQ1X5LYkuM8g@mail.gmail.com>
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Mark Bloch <markb@mellanox.com>
Cc:     Terry Toole <toole@photodiagnostic.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I should make the question more precise: in a peer to peer setup where
RDMA UC can achieve line rate with no packet drops, can we expect the
same result with UDP with IB verbs ?

Any IB verbs library restrictions that would have us see a difference
in line rate or drop rate ?

Dimitris

On Fri, Mar 20, 2020 at 8:40 AM Dimitris Dimitropoulos
<d.dimitropoulos@imatrex.com> wrote:
>
> Hi Mark,
>
> Just a clarification: when you say reach line rates speeds, you mean
> with no packet drops ?
>
> Thanks
> Dimitris
>
> On Tue, Mar 17, 2020 at 4:40 PM Mark Bloch <markb@mellanox.com> wrote:
> > If you would like to have a look at a highly optimized datapath from userspace:
> > https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c
> >
> > With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs
> >
> > Mark
