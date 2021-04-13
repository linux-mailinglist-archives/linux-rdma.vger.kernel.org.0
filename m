Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBD35D814
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 08:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDMGbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhDMGbn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 02:31:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5FC061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 23:31:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id d12so15977493oiw.12
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 23:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZQAkPMnTbdrACDTTOGK5NTUODC4ciuswZoVkoEDR2s=;
        b=OoDIb5LLHtzlblv1OGRazpp+iD+qgE0LtCvFI6NlW6ckMr+BxG+JrCV119GNBAVyan
         KJ/55K07zF1t9UgydU610DFPSZTZYJYn4fyST9w6YD465xw15sWkJchFq2V5IeJVRvST
         zimd2Siq0W2TEg4jZPC1WwgkaBaQVUx4doFoFU+ga3kpJs0WyRDBBZt1YteCqzxZEZ1b
         tWLoFGlUV7WhISiFLlMg22a0ei5QEhOqMgZ9+jXIApdCudhOD5rNi8v4ug4jl1JJSF67
         UQaEClzW90yKUU+dXM3sSeLR5IjtWLE2vJ4Ah5SIBl2O/SQPCTQAFevfGD3RPC6efhJL
         hY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZQAkPMnTbdrACDTTOGK5NTUODC4ciuswZoVkoEDR2s=;
        b=ks00iqy6l2wiWDsOxRbqshLoujsbBDzuoACdTcGf5wJV9sWpY5OoWaIId3Dd88RG/q
         0kDcnOt9Ux+A4fsLf7SYN6x8BCXS4dzrob1vdH8Dz+ZUNrciSdSdytN99MkPh7qsJ35d
         B854L5OHh2cqb8yPk+T3QtKEH4Ftnh3Q8NF3L06q/Mpqq8jBYurywbMnmOlXyP8nQcjA
         R+DBm+PJReGP9pr3SvDXHKOE9IY2ce7rC/tYF8dSZeyXDI51e2zxrKsEpnmxi96Q5Yv7
         m2uMdfuAS3rykzr++HxjwwD5ZiSeq51/8maysSTiseRe3ezkH1J/0+i0IaLtl+0LitbN
         FVPg==
X-Gm-Message-State: AOAM531hCQ/gxhWYPpTnfcU+fkbWc5qK1hRImT09qyHb3g+bAMh8eCCW
        3Aal50CpUugXt0vxMPfTzml64FJiu2I6pkog4R4=
X-Google-Smtp-Source: ABdhPJyjftqtCxzpij4egyE9S2TSGtkhQoJKOwvH7s/g8L1SGddwURIF0XL7eSjte7uc4iwt45BY4y/gU01tSAL4s2I=
X-Received: by 2002:aca:4007:: with SMTP id n7mr2119461oia.163.1618295481989;
 Mon, 12 Apr 2021 23:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210412015641.5016-1-yanjun.zhu@intel.com> <20210412184407.GA1163957@nvidia.com>
 <YHU2FvDsHBFtov1O@unreal>
In-Reply-To: <YHU2FvDsHBFtov1O@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 13 Apr 2021 14:31:10 +0800
Message-ID: <CAD=hENe02-Q8iAd62Suhn8REWyXBfJez_O_VYEt3OJ24RifcSQ@mail.gmail.com>
Subject: Re: [PATCHv4 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 2:11 PM Leon Romanovsky <leonro@nvidia.com> wrote:
>
> On Mon, Apr 12, 2021 at 03:44:07PM -0300, Jason Gunthorpe wrote:
> > On Sun, Apr 11, 2021 at 09:56:41PM -0400, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > >
> > > When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> > > in the stack. As such, the operations of ipv6 in RXE will fail.
> > > So ipv6 features in RXE should also be disabled in RXE.
> > >
> > > Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> > > Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> > > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> >
> > Is this signature block accurate? I'm pretty sure Leon didn't look at
> > this version of the patch.
>
> Yes, I didn't look.

Sorry. This signature block is from the prior version. I will fix it.

>
> >
> > Did Yi test this version, or is this leftover from a prior version?
> >
> > > ---
> > > V3->V4: I do not know how to reproduce Jason's problem. So I just ignore
> > >         the -EAFNOSUPPORT error. Hope this can fix Jason's problem.
> >
> > Who is Jason?
> >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > > index 01662727dca0..b12137257af7 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > > @@ -620,6 +620,11 @@ static int rxe_net_ipv6_init(void)
> > >     recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> > >                                             htons(ROCE_V2_UDP_DPORT), true);
> > >     if (IS_ERR(recv_sockets.sk6)) {
> > > +           /* Though IPv6 is not supported, IPv4 still needs to continue
> > > +            */
> > > +           if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> > > +                   return 0;
> >
> > At least this looks OK to me and the original report certainly said
> > the error was EAFNOSUPPORT
>
> The failure can be received only if udp_sock_create() fails in the
> rxe_setup_udp_tunnel(). It will print an error despite us not want this.
>
> >
> > Please clarify what is going on with the signature block
>
> And fix error print.

Got it. I will fix the signature block and error print.

Zhu Yanjun

>
> Thanks
>
> >
> > Jason
