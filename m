Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3159B16C200
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgBYNVG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 08:21:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34337 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgBYNVG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 08:21:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so6374562wrl.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 05:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w/WveyJr9ieMPqc3UFcQ78+Zmq6uecEjBrJZU6o2Xg=;
        b=buHJlA822KuwPH1YE8jv5VyRy5Em45WHvEghSlFb0WrZgqInSZQqGBW8vNkFDygplZ
         axdL/aKRejAnIoG2pXaSpTTk0L5mJHdDCbWI42vPRJQPLYfjHnwql0cKjJtCwkopEsvX
         qLsGMPubIhhdsmwwVVfyR9H++D8957RbiR0kifNbt+v1Ufq5GLtTSsjU7TSgd6hviwDZ
         +i6N6n7oaixfyJWrNdA+wJ68/FfxCBnS0GA3YU735k7kmm8BZXaUGYdFhR9rU79z7r7S
         fG8ameLxpmxCT8m7/FEwRwGlq2VepJ0+wuKupKgtLu3EY77rV49hCctn7geWdi2bUsYk
         iTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w/WveyJr9ieMPqc3UFcQ78+Zmq6uecEjBrJZU6o2Xg=;
        b=Sw+BM44aIwlshAfcsSLNkPGCHgApkipL+IqXaVfm1MWs+j9KeQZGp4QN1tU5F4wGmc
         +Fbt4QtwYb5EfNHscMEk0Sro6dp3s/AIz5CZPo8tM3xynktr5JEMmh3DT17jWrQiAYNb
         USzl95/jYFDMWeFKBkoIkKoiLdg1QtPwmJUS0BDVqZj1/keuJabMB2sKTG7LO1kyO1b9
         2/AsUDsTWOX753UAnH33O02QCymY0FX3+cntS1UlEjlQtODPs5WRj+jrOdli90xgThpx
         kO6LwuhcuIhL2Id++sDhRPriYEs9OswyOok5Vqzg5NA09PKfVn+QlUK9NAXdwZeutv8/
         To4A==
X-Gm-Message-State: APjAAAUTSUG8fTm3URk5QOCvvnbtrUBBUzKEd9vH6oQ1tkvguokpHutF
        d6QGY6aVxA+JY2nYO5FF2cRX6m0LsLvCj8Ese1Y=
X-Google-Smtp-Source: APXvYqwRjc7D8OVuIsKUIIiAPEIW1G2WGLQCvrMA+bcmF7dEMsLOZC5fidKbGr4dmOje/al/XI6U4R0t60nBLuA66d0=
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr74011168wro.359.1582636864686;
 Tue, 25 Feb 2020 05:21:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com> <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com> <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com> <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com> <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com> <20200219130613.GM31668@ziepe.ca>
 <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com> <c4fc4449-94ed-805e-76d1-6ce856a4fc05@mellanox.com>
 <33f075e2-b5c0-53cd-6954-7ac57eeb008f@talpey.com>
In-Reply-To: <33f075e2-b5c0-53cd-6954-7ac57eeb008f@talpey.com>
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Tue, 25 Feb 2020 15:20:53 +0200
Message-ID: <CAFgAxU_fZUEYrMVpoStQJGD5S5dqrkXOuzWrk0MLHF8niW7ikw@mail.gmail.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Tom Talpey <tom@talpey.com>
Cc:     Mark Zhang <markz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mark and I where playing with your test, and plotting the results
I'm sharing the png's on a temp github here:
https://github.com/rosenbaumalex/hashtest/
[I wasn't sure of a better place to share them]

The README.md explains the port range we used, the 3 hash's used, and
a line about the results.
In general, the higher the 'noise' the worse the distribution is.
It seems like Mark's hash suggestion (src*31 + dst) works best. then
the folding one, and last the non-folding one.

I am trying to cache a few switch related hash experts to get
additional feedback.

Alex

On Fri, Feb 21, 2020 at 4:47 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 2/19/2020 8:04 PM, Mark Zhang wrote:
> > On 2/20/2020 1:41 AM, Tom Talpey wrote:
> >> On 2/19/2020 8:06 AM, Jason Gunthorpe wrote:
> >>> On Wed, Feb 19, 2020 at 02:06:28AM +0000, Mark Zhang wrote:
> >>>> The symmetry is important when calculate flow_label with DstQPn/SrcQPn
> >>>> for non-RDMA CM Service ID (check the first mail), so that the server
> >>>> and client will have same flow_label and udp_sport. But looks like it is
> >>>> not important in this case.
> >>>
> >>> If the application needs a certain flow label it should not rely on
> >>> auto-generation, IMHO.
> >>>
> >>> I expect most networks will not be reversible anyhow, even with the
> >>> same flow label?
> >>
> >> These are network flow labels, not under application control. If they
> >> are under application control, that's a security issue.
> >>
> >
> > As Jason said application is able to control it in ipv6. Besides
> > application is also able to control it for non-RDMA CM Service ID in ipv4.
>
> Ok, well I guess that's a separate issue, let's not rathole on
> it here then.
>
> > Hi Jason, same flow label get same UDP source port, with same UDP source
> > port (along with same sIP/dIP/sPort), are networks reversible?
> >
> >> But I agree, if the symmetric behavior is not needed, it should be
> >> ignored and a better (more uniformly distributed) hash should be chosen.
> >>
> >> I definitely like the simplicity and perfect flatness of the newly
> >> proposed (src * 31) + dst. But that "31" causes overflow into bit 21,
> >> doesn't it? (31 * 0xffff == 0x1f0000) >
> >
> > I think overflow doesn't matter? We have overflow anyway if
> > multiplicative is used.
>
> Hmm, it does seem to matter because dropping bits tilts the
> distribution curve. Plugging ((src * 31) + dst) & 0xFFFFF into
> my little test shows some odd behaviors. It starts out flat,
> then the collisions start to rise around 49000, leveling out
> at 65000 to a value roughly double the initial one (528 -> 1056).
> It sits there until 525700, where it falls back to the start
> value (528). I don't think this is optimal :-)
>
> Tom.
