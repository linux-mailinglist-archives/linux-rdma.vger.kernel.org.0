Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390542342B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 01:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhJEXMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 19:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhJEXL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 19:11:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA9C061749;
        Tue,  5 Oct 2021 16:10:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t8so2744664wri.1;
        Tue, 05 Oct 2021 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBXKLuBIklAebOb/7/xhhltJLs9mxot7CbToqq09lPc=;
        b=iDyFeXK2NKKvbDXs4VwXnlSl3NkYOyK+zgkM+1mZp15wWXjlE2t+1bXtxcWxPFkvd7
         ruBvWnCORCgBGHUhsG4yvJ08kAGlR7uU0n2IXMYUMNj9hVUolfd5kQxrK4BoMh5b0DLo
         +JNMxOo5Oj6dkboM90sPq/kx7d5W3oGTBUq+AMq6v9QBP6VONttWV6dKH4sx/ojK+xGI
         C7kF+D5WHxOHU+Ktltw+KE3+0+Ta+Jcv20hYx0gW17CoowlyUY+hhkn9eLPvGlUc0oYZ
         E3AGlKuU2t/Vmo25KZKNSTxqZ9wjt9ek8mSqo4zVJb8Z41ETKy3TMb0Ui7CYNYkj81sb
         zXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBXKLuBIklAebOb/7/xhhltJLs9mxot7CbToqq09lPc=;
        b=AKs2II75vIq/Hz164KDpf2vbrb31bhM/ATCg7ubK5UZDJLQa9d7B+q3ZJov9DM2sOJ
         fZYXdcZ/557Y90TxSmmCYrcw6Hbc/sTYQo9PvUJ4h5KQH3xj0GZdt2Xc5bQ2U/aXlpcq
         1K9g0e7VQuErsaUq60h61AuoHlzBz71f155hSFKHcwwNrc1oxajb3n7xa7ti7MdU0Do4
         L4K2D7pyEX1H41CbTHt4l7ESee/2whwpPbu/JFmw2KiJqQl7haREiVEoKpSi1OmVxiFT
         yEDTpydkCs8nYWNXIve2zWTKEchdXMykHSEnVGP+V+i0t8HDwZFmmntPt9JYZy52vnPJ
         ygeg==
X-Gm-Message-State: AOAM533NcViiCGbeeAcWjbe1c3ea2lFmHdfqeIqsWX0CNVfM57EDzJFS
        fL1Ag2UYU7gLWTJ48v8gZAHISLXMiKMXHanLNsU=
X-Google-Smtp-Source: ABdhPJxUh7ugJZkQxkLQppqEtgbagU6X/aob1tAQ6BOTFPzHnXFi1iKRIicSBdGHRcRI0WuN3LX6jl8iVxS582S2Wis=
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr6456296wmr.99.1633475405855;
 Tue, 05 Oct 2021 16:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca> <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
 <20211001120153.GL3544071@ziepe.ca>
In-Reply-To: <20211001120153.GL3544071@ziepe.ca>
From:   Si-Wei Liu <siwliu.kernel@gmail.com>
Date:   Tue, 5 Oct 2021 16:09:54 -0700
Message-ID: <CAPWQSg0wODmw7evfzdtP4gW-toVgoVfigP5t0CVosOAkarNTTg@mail.gmail.com>
Subject: Re: Enabling RO on a VF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 1, 2021 at 6:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Oct 01, 2021 at 11:59:15AM +0000, Haakon Bugge wrote:
> >
> >
> > > On 1 Oct 2021, at 13:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> > >> Hey,
> > >>
> > >>
> > >> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> > >> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> > >> RO can be enabled. This function checks if the Enable Relaxed
> > >> Ordering bit in the Device Control register is set. However, on a
> > >> VF, this bit is RsvdP (Reserved for future RW
> > >> implementations. Register bits are read-only and must return zero
> > >> when read. Software must preserve the value read for writes to
> > >> bits.).
> > >>
> > >> Hence, AFAICT, RO will not be enabled when using a VF.
> > >>
> > >> How can that be fixed?
> > >
> > > When qemu takes a VF and turns it into a PF in a VM it must emulate
> > > the RO bit and return one
> >
> > I have a pass-through VF:
> >
> > # lspci -s ff:00.0 -vvv
> > ff:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex Virtual Function]
> > []
> >               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> >                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
>
> Like I said, it is a problem in the qemu area..
>
> Jason
Can you clarify why this is a problem in the QEMU area?

Even though Mellanox device might well support it (on VF), there's no
way for QEMU to really know if an arbitrary passthrough device may
support RO. It either has to resort to the host kernel to detect all
PCIe device functions up to the root port throughout the PCIe fabric,
or it may follow PF's enabling status if it is at all capable. I don't
see what QEMU can do by just forcefully emulating the bit?

Not to mention the current implementation only takes care of broken
root port but not the intermediate switches.
https://lore.kernel.org/linux-arm-kernel/MWHPR12MB1600255ACFCD3FB3C80EB8B6C88B0@MWHPR12MB1600.namprd12.prod.outlook.com/

-Siwei
