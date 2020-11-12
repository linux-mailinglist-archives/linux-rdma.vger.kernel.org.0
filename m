Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6B2B0A8D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKLQpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgKLQpT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 11:45:19 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784C621D7F;
        Thu, 12 Nov 2020 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605199518;
        bh=2jxbukIv9oTWkB8v1+kQrgO6FSfiOBI/y/TSNhomr+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=noFnRSg0bpRyqihLrAl4R85zI5kqEv9ij+IncXg4oeNGcXv9P6BG4MPolNIU164eg
         8hFcD3tklxof37MuC5Brv9+jW9ybKYzO2J54puZW2fvU1Wo6nyutjvzRd+x04aT3BS
         xjcX4LHVfji0mcFzO/5Zkn3XzPg5j2qup9SBZ8dk=
Received: by mail-ot1-f54.google.com with SMTP id k3so6162657otp.12;
        Thu, 12 Nov 2020 08:45:18 -0800 (PST)
X-Gm-Message-State: AOAM532yd9D+VusFYpsVd1E6eXkBfVdvMMDDxC2AZZkGMzd/qqC7Hq0M
        UurQIllowmMekwJamlXUMHZovS83GYD+WlJrhd8=
X-Google-Smtp-Source: ABdhPJxOQAs3+2CxnKfx4cmt/6UrxUllEL6x6zbppjUQtLQvcJ3uBJwhuqJJEy0i43A6cPwfPo/XJYGvp/PTDDBGJ3M=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr10475oth.251.1605199517681;
 Thu, 12 Nov 2020 08:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20201026211311.3887003-1-arnd@kernel.org> <20201112155709.GA894300@nvidia.com>
In-Reply-To: <20201112155709.GA894300@nvidia.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 12 Nov 2020 17:45:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Vq4K_pJWCEutvua5GijAL5mgzrCZC-sXWxz4MAOTThg@mail.gmail.com>
Message-ID: <CAK8P3a3Vq4K_pJWCEutvua5GijAL5mgzrCZC-sXWxz4MAOTThg@mail.gmail.com>
Subject: Re: [PATCH] mthca: work around -Wenum-conversion warning
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 4:57 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Oct 26, 2020 at 10:12:30PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc points out a suspicious mixing of enum types in a function that
> > converts from MTHCA_OPCODE_* values to IB_WC_* values:
> >
> > drivers/infiniband/hw/mthca/mthca_cq.c: In function 'mthca_poll_one':
> > drivers/infiniband/hw/mthca/mthca_cq.c:607:21: warning: implicit conversion from 'enum <anonymous>' to 'enum ib_wc_opcode' [-Wenum-conversion]
> >   607 |    entry->opcode    = MTHCA_OPCODE_INVALID;
> >
> > Nothing seems to ever check for MTHCA_OPCODE_INVALID again, no
> > idea if this is meaningful, but it seems harmless as it deals
> > with an invalid input.
> >
> > Add a cast to suppress the warning.
> >
> > Fixes: 2a4443a69934 ("[PATCH] IB/mthca: fill in opcode field for send completions")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >  drivers/infiniband/hw/mthca/mthca_cq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> > index c3cfea243af8..319b8aa63f36 100644
> > +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> > @@ -604,7 +604,7 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
> >                       entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
> >                       break;
> >               default:
> > -                     entry->opcode    = MTHCA_OPCODE_INVALID;
> > +                     entry->opcode    = (u8)MTHCA_OPCODE_INVALID;
> >                       break;
>
> This code is completely bogus, sigh
>
> Is this OK as far as the warning goes?

Yes, I'm sure your patch fixes it and it makes more sense than my version.

Acked-by: Arnd Bergmann <arnd@arndb.de>
