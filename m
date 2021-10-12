Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5342AB57
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhJLR7c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJLR7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 13:59:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CDC061570;
        Tue, 12 Oct 2021 10:57:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g14so243601pfm.1;
        Tue, 12 Oct 2021 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECJWVStwj/d34/Vu0G/KUfZcqZpR+ZbRS7rnsGzFc1c=;
        b=kzdxkK4hRFKr5wbPDRf1NCRmj92yC0uCQPW5RZk2BkJG3euReUCUsH/yH7TYZXFZUi
         dTKQ1cHbw00xpK3/bVmFfX76E6CQYYi/MpGlt45vDuzgE2RKZNyUEirNjxx6/vQ9ytT5
         4BC+W0cI+tCOyvrAqA2YcRHbh6rhe9wmTRza0g2FFRPJUp12Jv1tdk6itxvd+QLFlHqC
         PX/1wVUzqWz4lnFMc5HFrWn8JvCP/nZc2W0YTOWHQOHhNYS2lYPz9z13HVOmZnSjCDR6
         +cY8B4HQCLYLRopDeZVCa3K9miC2oEesFFvatzUiAFHnMmBBn+b0/ltJHa03twj3Bauj
         uNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECJWVStwj/d34/Vu0G/KUfZcqZpR+ZbRS7rnsGzFc1c=;
        b=pVVj6gzI7lNHaWVNEq8OhMsXbxJZGPbyaA64efu43yitGIzER3WVdNin4dbzACpmys
         8eucKVDT/TwUOBvrtfisXtQAf22IdXIWrGta9J9DcM4Q6yth8QvjSWuGD+ioBU2HNuhG
         /DeF73GHvNmw0NiyFZEe3kGxWKi5w0xizqcwbrCnciwjFenfuPDqtc2BEq7p91pOdGL4
         17TxJ24cIP9/Qvg4Kd9VdpGy9J/6NjqtmoMMSWFL5Z+y1GotTxgOqFgMO9fiYggNVX85
         RTjdP01KNUEOcz1TogC3jW4pAjxj05ODye3A/1YrpchYzT3ukj0qA2tB4pquarqRty7u
         J/oQ==
X-Gm-Message-State: AOAM532DhL+epxa2ZVssrQUV/eYfpQBqrgUrg0/CTI5prDPaIepkAgEa
        lCs9uHvMSydoc6eijx1kPr25g1LKFzlyx1wu2rw=
X-Google-Smtp-Source: ABdhPJzLGAcADt03gAc/3mvKvnJSmHnaI6ECVFjbVzi0ib48CYvzfdbbQRa3veKIfgqad7RqeOwKQrURY1SUzF/eGlo=
X-Received: by 2002:a05:6a00:198a:b0:44c:ae90:85fc with SMTP id
 d10-20020a056a00198a00b0044cae9085fcmr33097233pfl.1.1634061447877; Tue, 12
 Oct 2021 10:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca> <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
 <20211001120153.GL3544071@ziepe.ca> <CAPWQSg0wODmw7evfzdtP4gW-toVgoVfigP5t0CVosOAkarNTTg@mail.gmail.com>
 <20211005232834.GB2688930@ziepe.ca>
In-Reply-To: <20211005232834.GB2688930@ziepe.ca>
From:   Si-Wei Liu <siwliu.kernel@gmail.com>
Date:   Tue, 12 Oct 2021 10:57:16 -0700
Message-ID: <CAPWQSg0EYPcudN9Gc--ges68sLmW4mJ4eYHxmmRq8FAzq8C5WQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 4:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 05, 2021 at 04:09:54PM -0700, Si-Wei Liu wrote:
> > On Fri, Oct 1, 2021 at 6:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Fri, Oct 01, 2021 at 11:59:15AM +0000, Haakon Bugge wrote:
> > > >
> > > >
> > > > > On 1 Oct 2021, at 13:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> > > > >> Hey,
> > > > >>
> > > > >>
> > > > >> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> > > > >> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> > > > >> RO can be enabled. This function checks if the Enable Relaxed
> > > > >> Ordering bit in the Device Control register is set. However, on a
> > > > >> VF, this bit is RsvdP (Reserved for future RW
> > > > >> implementations. Register bits are read-only and must return zero
> > > > >> when read. Software must preserve the value read for writes to
> > > > >> bits.).
> > > > >>
> > > > >> Hence, AFAICT, RO will not be enabled when using a VF.
> > > > >>
> > > > >> How can that be fixed?
> > > > >
> > > > > When qemu takes a VF and turns it into a PF in a VM it must emulate
> > > > > the RO bit and return one
> > > >
> > > > I have a pass-through VF:
> > > >
> > > > # lspci -s ff:00.0 -vvv
> > > > ff:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex Virtual Function]
> > > > []
> > > >               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > > >                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> > >
> > > Like I said, it is a problem in the qemu area..
> > >
> > > Jason
> > Can you clarify why this is a problem in the QEMU area?
> >
> > Even though Mellanox device might well support it (on VF), there's no
> > way for QEMU to really know if an arbitrary passthrough device may
> > support RO.
>
> That isn't what the cap bit means
>
> The cap bit on the PF completely disables generation of RO at the
> device at all.
>
> If the PF's cap bit is disabled then no VF can generate RO, and qemu
> should expose a wired to zero RO bit in the emulated PF.
>
> If the cap bit is enabled then the VFs could generate RO, depending on
> their drivers, and qemu should generate defaulted to 1 bit in the
> emulated PF.

Set the broken root port and the P2P DMA cases aside, let's say we
have a RO enabled PF where there's a working root port upstream that
well supports RO. As VF mostly inherits PF's state/config, no matter
what value the DevCtl RlxdOrd bit presents in the host it doesn't mean
anything, although we know getting RO disabled on the PF implies
prohibiting RO TLP being sent by all its child VFs. There's no
question for this part. The real problem though, is if the RlxdOrd cap
bit for the VF can be controlled individually similar to the way the
toggling on PF is done? For e.g, suppose the RO cap bit for the VF
emulated by QEMU defaults to enabled where the backing PF and all
child VFs have RO enabled. Will a PCI write of zero to the bit be able
to prevent RO ULP initiated by that specific VF from being sent out,
which is to resemble PF's behaviour? This being the Mellanox VF's
specifics? More broadly, should the VFs for arbitrary PCIe devices
have that kind of control on an individual VF's level? I don't find it
anywhere in the PCIe SR-IOV spec that this should be the case.

-Siwei

>
> > PCIe device functions up to the root port throughout the PCIe fabric,
> > or it may follow PF's enabling status if it is at all capable. I don't
> > see what QEMU can do by just forcefully emulating the bit?
>
> IMHO Kernel/BIOS should be responsible to clear the RO bit at the PF
> if RO is not supportable in the environment. It is proper to prevent
> the device from using RO completely if it is broken.
>
> > Not to mention the current implementation only takes care of broken
> > root port but not the intermediate switches.
> > https://lore.kernel.org/linux-arm-kernel/MWHPR12MB1600255ACFCD3FB3C80EB8B6C88B0@MWHPR12MB1600.namprd12.prod.outlook.com/
>
> Which is what this message suggests doing
>
> Jason
