Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D164150EF5
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 18:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBCRxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 12:53:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45652 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCRxU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 12:53:20 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so17669337ioi.12
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXISGBJN97I8hHWBIcbdCWvHsY52DvLT7bmBRZXGpwg=;
        b=LhLZb8qoNe6QJwx5I+mqXRtyCGQjBC7zcN8IYlwAe52rwXfZcZmgAzxhh2U+MoMxo7
         M+XCvYgbpqhKo4ZTE2yBhQH7ti+jekZc8kaQKhKFc8MGojScOJjnE61XPnDDHl7E4eBZ
         R9OstTdRElHHUNzZuVQ1RBQe5Z+1GGka8novw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXISGBJN97I8hHWBIcbdCWvHsY52DvLT7bmBRZXGpwg=;
        b=uLjCvT9srCCne0205H6ehlJMSR8musW5KiLzHP37vykgxOuMujtYTZr73B9hB+dpin
         7vOjdV8f2SmVVJU/9J1ECZxoN6GXvUkW/vPBm7NzKY7S9R4QLlS07az2Th4ExgEGNvbD
         pDFmZnV0smgKGlE3MbvrvC89iuJi8N10x2nIcFnoa0dKU6ihuExc90SiQFPlAkAqVRWU
         mlIRi2ZmkaH97tLzcr/S3IFJDX71NHFsiepqblI6HUCJX9YRCylp238ssthGhg8JqGA0
         szcYLT4I62WTBUFLa5t8DI0ZS+Gsa/PzHIm9Rx9k+ylZ+mHVq6nzK0W4Qg6iRkTVjNf9
         oYhQ==
X-Gm-Message-State: APjAAAWGZfiHytPJqrwDn+zYUBar+iUOXRAaR3Kmbjznt/lL9Y7faXvo
        LGlVvBBv1lApnSYMkZ9GzpMTAL7uCoPYm6xzPpXGuw==
X-Google-Smtp-Source: APXvYqwLYeBqpv0hnyfaU1d9x0EBPT69pVaYC5gQuqXlLQPZyEmjj/7wxsi0CBdRx9wLyqy+5Aapxxv6zqP59M/3r+w=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr19010455ion.89.1580752397956;
 Mon, 03 Feb 2020 09:53:17 -0800 (PST)
MIME-Version: 1.0
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203160849.GA14732@ziepe.ca> <CANjDDBiA53__MuzqXiAh70YAa_JvWQcm6Sdo0dFsoAs1EgVbjQ@mail.gmail.com>
 <20200203165033.GB14732@ziepe.ca>
In-Reply-To: <20200203165033.GB14732@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 23:22:41 +0530
Message-ID: <CANjDDBgF_zMxo+N=wZjG73VG-MV2=0tbG3VRtH3quGPayZ7U3Q@mail.gmail.com>
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 10:20 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 03, 2020 at 09:57:39PM +0530, Devesh Sharma wrote:
> > On Mon, Feb 3, 2020 at 9:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Feb 03, 2020 at 10:56:55AM -0500, Devesh Sharma wrote:
> > > > It becomes difficult to make out from the output of ibv_devinfo
> > > > if a particular gid index is RoCE v2 or not.
> > > >
> > > > Adding a string to the output of ibv_devinfo -v to display the
> > > > gid type at the end of gid.
> > > >
> > > > The output would look something like below:
> > > > $ ibv_devinfo -v -d bnxt_re2
> > > > hca_id: bnxt_re2
> > > >  transport:             InfiniBand (0)
> > > >  fw_ver:                216.0.220.0
> > > >  node_guid:             b226:28ff:fed3:b0f0
> > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > >   .
> > > >   .
> > > >   .
> > > >   .
> > > >        phys_state:      LINK_UP (5)
> > > >        GID[  0]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> > > >        GID[  1]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> > > >        GID[  2]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> > > >        GID[  3]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
> > >
> > > I think you should display the RoCEv2 GID in IPv6 notation, since it
> > > isn't really a GID anyhmore. The IPv6 notation should automatically
> > > show the IPv4 dotted quad
> >
> > There are many format specifiers, which one are you indicating? are
> > those supported in printf()?
>
> inet_ntop(AF_INET6)
Done!
>
> Jason
