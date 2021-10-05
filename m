Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E298423475
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhJEXa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 19:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhJEXa1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 19:30:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7ECC061753
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 16:28:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c20so801501qtb.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YZtqiNpZkkBjH9PLa+2pg+VWvxuMg2D7NfMsla0iApM=;
        b=W9M/04ikoH0xs+S7XpSkDR2UwXuMr54r1WDEMiLrXADyvj+BVQZ5larNl6JHMBOsgJ
         gi1057s5XCujQy0a8GeabfgF/4AP1j4BkhHMi4+7MT131D4BK4FskSqsvTT4NoLE/F5u
         NjVsItMi+O2rP5j8RLxQ79/oq6B/6EBTEtvNelJDRpl8shFYKdQ/9gArgjLyrmFBWzFK
         J0FW5GstAgSyxV36N+hYUTZRXh0jg2btzSVVF50hXhj8EzFxQBaPNQlEQVEVSO2OOl3k
         8hqHJg7aP8qQKtZgc+6a2E9CcNk+xx3G2R8r/HMH0kiPwGLCxyv7CQafKgZQYknQJOIV
         rj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YZtqiNpZkkBjH9PLa+2pg+VWvxuMg2D7NfMsla0iApM=;
        b=OB7BjCD6brQ2ZB6DVaM5rKpir+U5WaxoKvtkYoivdVQP/u6HPCsvIk1/cyMApV36gX
         miCXMlPr+ojLpGJcTEhX7SRjmPnVrNQQNjxEHfX2/1dqeTyGOKawXSoB6VRKsQWMEImu
         omTioMXuVII4swiqJkhj5cdyMVtydexzKnUpqzMKxyndHL3xS9H+YkCQDXU9EUm8iNhS
         +K9nALGSHXUa6IhTKb6TNFCwRT95qyRR/4xAlFEmGCMcca+bZDQMa3a3pIegN2T4DKU9
         30AJ2ys+AEWv1WMdcsFMKTFkpMN0O7JyNQCp/pyrqGIDJNVLedZtVyzW2PECF2GjUmc9
         F/9Q==
X-Gm-Message-State: AOAM5335htaQd/ZS+IUhs/hSuUZmiDFz+MLofrq1eZsQjkduSjePtXjI
        BPlDVRJH97kkfgPONIpm+iUSPQ==
X-Google-Smtp-Source: ABdhPJxLsGumPYgbsPy+xlzVZoblVHF5PD2wFx2gPiovv1H2BFWEuNX7TLFJw+HZ1DVzpRheZcUi0A==
X-Received: by 2002:ac8:705d:: with SMTP id y29mr9574774qtm.73.1633476515521;
        Tue, 05 Oct 2021 16:28:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b18sm1329682qtq.62.2021.10.05.16.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:28:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXtrO-00BKTt-Fi; Tue, 05 Oct 2021 20:28:34 -0300
Date:   Tue, 5 Oct 2021 20:28:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Si-Wei Liu <siwliu.kernel@gmail.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling RO on a VF
Message-ID: <20211005232834.GB2688930@ziepe.ca>
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca>
 <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
 <20211001120153.GL3544071@ziepe.ca>
 <CAPWQSg0wODmw7evfzdtP4gW-toVgoVfigP5t0CVosOAkarNTTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPWQSg0wODmw7evfzdtP4gW-toVgoVfigP5t0CVosOAkarNTTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 05, 2021 at 04:09:54PM -0700, Si-Wei Liu wrote:
> On Fri, Oct 1, 2021 at 6:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Oct 01, 2021 at 11:59:15AM +0000, Haakon Bugge wrote:
> > >
> > >
> > > > On 1 Oct 2021, at 13:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> > > >> Hey,
> > > >>
> > > >>
> > > >> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> > > >> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> > > >> RO can be enabled. This function checks if the Enable Relaxed
> > > >> Ordering bit in the Device Control register is set. However, on a
> > > >> VF, this bit is RsvdP (Reserved for future RW
> > > >> implementations. Register bits are read-only and must return zero
> > > >> when read. Software must preserve the value read for writes to
> > > >> bits.).
> > > >>
> > > >> Hence, AFAICT, RO will not be enabled when using a VF.
> > > >>
> > > >> How can that be fixed?
> > > >
> > > > When qemu takes a VF and turns it into a PF in a VM it must emulate
> > > > the RO bit and return one
> > >
> > > I have a pass-through VF:
> > >
> > > # lspci -s ff:00.0 -vvv
> > > ff:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex Virtual Function]
> > > []
> > >               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > >                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> >
> > Like I said, it is a problem in the qemu area..
> >
> > Jason
> Can you clarify why this is a problem in the QEMU area?
> 
> Even though Mellanox device might well support it (on VF), there's no
> way for QEMU to really know if an arbitrary passthrough device may
> support RO. 

That isn't what the cap bit means

The cap bit on the PF completely disables generation of RO at the
device at all.

If the PF's cap bit is disabled then no VF can generate RO, and qemu
should expose a wired to zero RO bit in the emulated PF.

If the cap bit is enabled then the VFs could generate RO, depending on
their drivers, and qemu should generate defaulted to 1 bit in the
emulated PF.

> PCIe device functions up to the root port throughout the PCIe fabric,
> or it may follow PF's enabling status if it is at all capable. I don't
> see what QEMU can do by just forcefully emulating the bit?

IMHO Kernel/BIOS should be responsible to clear the RO bit at the PF
if RO is not supportable in the environment. It is proper to prevent
the device from using RO completely if it is broken.

> Not to mention the current implementation only takes care of broken
> root port but not the intermediate switches.
> https://lore.kernel.org/linux-arm-kernel/MWHPR12MB1600255ACFCD3FB3C80EB8B6C88B0@MWHPR12MB1600.namprd12.prod.outlook.com/

Which is what this message suggests doing

Jason
