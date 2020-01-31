Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A327D14F144
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAaR2i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 12:28:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42325 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgAaR2h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 12:28:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so7882548ljl.9;
        Fri, 31 Jan 2020 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6E0SrMTwsFq0kOJ7BGsX44u/jTRhZq14wnWl2fxGKa4=;
        b=Qz7JNUFwQFCOSZeQIw7j0/uTT9JpuFca9+UOMYCGZcB9fsdlWN3TTPDc2lNIST6RP6
         YzdnEiMh1x96R/S21vQ96TIIBojuL9PlrE1Wz1qJnGioV89SqoAqK30TL921dFBwTo+K
         ibNk7Ek9q9bc3Dvwc48ER8JP7JcvWZo/RrTr2Jkyzyoih3JSUm3DfYnGfSj4VN7YpyAf
         n8OxjLIcM/OcM/vQAmx03Hfi4qJICWNE9AxcjUWKUJ+gKm/fdqfYZJzoGXqrBevsujXh
         WhJZzAsWd+qV5OZEZz+a6exVhBQZQp/uEOJ8pICn9mM9Pa02rUF3VUj+qu2VOoB427xd
         vWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6E0SrMTwsFq0kOJ7BGsX44u/jTRhZq14wnWl2fxGKa4=;
        b=VPNXx7E9MpcNvpMAMVZLDDhGE3T4VDELInp8FzewpWdwm1C2/Ih3OI1vaZ5SYsb0Zj
         UQJk5jWjbD5q17XxLyyHG4EQA5wfBtm7wzNO7771kqoAxtEjCtJgTl31+1oDlgjiT8mJ
         nrttRBcOMjdPTy2MwIdrOfe9Wvfl9O3xmknpiSv1z1xMxi8/Ev9tTiHP2o6n77hG618T
         09wLc0JjOxzbqmcKymCxbozMbYNXkD1f5kyqXBt2UDCe4xwYMyOJ/dk/uKCeCaELIv9W
         hvXcW9Nc5HG8Jg82WMnOIr1QqdmZtN4dt47h+Pbq+cgDtulPTQQqRSmg9k74gopbq65Y
         z6lg==
X-Gm-Message-State: APjAAAXxF61rX47Y3jiwySILiRkuQm58cYfwQypYAVlVV0tXuMUG7mun
        SCywWm04W05T+DFAAiSVnAz68IfFtCaiQnNoceEdkg==
X-Google-Smtp-Source: APXvYqxvnyU6Ksp6X9ih5vJ8sTJw73U2GWcODZc9dtWJFuVHDYN9XWM3tQU+7oMvaDFxDmhQsysRwZZcg4JOiwLHMHc=
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr6535813ljc.246.1580491714643;
 Fri, 31 Jan 2020 09:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20200124204753.13154-1-jinpuwang@gmail.com> <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca> <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
In-Reply-To: <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Fri, 31 Jan 2020 18:28:21 +0100
Message-ID: <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2020=E5=B9=B41=E6=9C=8831=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> > On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> >> Hi Doug, Hi Jason, Hi Jens, Hi All,
> >>
> >> since we didn't get any new comments for the V8 prepared by Jack a
> >> week ago do you think rnbd/rtrs could be merged in the current merge
> >> window?
> >
> > No, the cut off for something large like this would be rc4ish
>
> Since it's been around for a while, I would have taken it in a bit
> later than that. But not now, definitely too late. If folks are
> happy with it, we can get it queued for 5.7.
>
> --
> Jens Axboe

Thanks Jason, thanks Jens, then we will prepare later another round for 5.7

Regards,
Jack Wang
