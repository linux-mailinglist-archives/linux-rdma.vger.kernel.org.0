Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E953842E41A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Oct 2021 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJNWZ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJNWZ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 18:25:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D2C061570
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 15:23:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bj31so4157191qkb.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 Oct 2021 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5FbFHDt82gq72AeamS55JhkriRGh9HPCqy/+ZBXeC8=;
        b=Nv+II/I6Rxp+jIXHB/OwJsgKMS65qDgCi6gcPbaZXLs+93pYfEoJxF4vi3uWdDA4Fc
         NGNxpfY41aiPX/grohsiy8KZKQrNUVyGLG41qrqVeolgEyBNtPhxlvpYagKYkXcuyykW
         N/Dho6hlXzRiGjyXh43MpwD5ukSM3EUlXqrZ+CGdEdu9uHBNLqbS889kP5JzfDXIegAe
         XGeCBWN3rl3qO/IW98eR+MYgWd6rSpaDwavWR+wmZuLFpe6qpQGhzi21SAv9kl8RtEZB
         yh+Sok7hUSKGykFw5vEPjLuu0/+gAjomJXLlW/OVzO6HgI2BQtSM+8WAddAZcL/tFaP5
         022Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5FbFHDt82gq72AeamS55JhkriRGh9HPCqy/+ZBXeC8=;
        b=pwUwffuj7eBLfBmZeBUfw9hSHCm0vqmxYPimtIJCRyWJnd17HBdYGGNOClaebhrX+n
         EZqZG+QoJm7y0RRZZY+liczoNJWcvqJavSRI17QMUEW2ditupyznkndrq+IcWsTJMrHO
         W16kToE0hAGTeGpH1Xxr2OwPlbUYNQs2Z/vpogVi62+Ry0sH6BSK8Ek8rckB4vZuaF3m
         RbJQ6+Hau0zerHSlN/pfUM+6wU+JNXbIfCP5WMp107R5r6Xt2J0LZk0MvI75qz07MQw8
         if1y5HWykuWyqbHP1gys2fFyrWyrXSledWffj9Aqn/2fQ860XH7lMreJtAzkiaFrm8ht
         5JSA==
X-Gm-Message-State: AOAM531fqeN0Yni8Zi2T4z0sElZ62k6G+j4YXXBNpDRG+dhk21rDAAT2
        wB3213wiCrfwWQaPSSP4cCcvIw==
X-Google-Smtp-Source: ABdhPJywYNDaGn9W3ZA4/hE4KjmIX5JIQ4CpRpSHNeloBi0gr4d7dtWd/tNYpyw5lbaV4w5MTOOKHw==
X-Received: by 2002:ae9:ebc2:: with SMTP id b185mr7028681qkg.491.1634250229560;
        Thu, 14 Oct 2021 15:23:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i11sm1850010qki.28.2021.10.14.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:23:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mb98e-00F4b3-4g; Thu, 14 Oct 2021 19:23:48 -0300
Date:   Thu, 14 Oct 2021 19:23:48 -0300
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
Message-ID: <20211014222348.GP2688930@ziepe.ca>
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca>
 <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
 <20211001120153.GL3544071@ziepe.ca>
 <CAPWQSg0wODmw7evfzdtP4gW-toVgoVfigP5t0CVosOAkarNTTg@mail.gmail.com>
 <20211005232834.GB2688930@ziepe.ca>
 <CAPWQSg0EYPcudN9Gc--ges68sLmW4mJ4eYHxmmRq8FAzq8C5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPWQSg0EYPcudN9Gc--ges68sLmW4mJ4eYHxmmRq8FAzq8C5WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 10:57:16AM -0700, Si-Wei Liu wrote:
> On Tue, Oct 5, 2021 at 4:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Oct 05, 2021 at 04:09:54PM -0700, Si-Wei Liu wrote:
> > > On Fri, Oct 1, 2021 at 6:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Oct 01, 2021 at 11:59:15AM +0000, Haakon Bugge wrote:
> > > > >
> > > > >
> > > > > > On 1 Oct 2021, at 13:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > >
> > > > > > On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> > > > > >> Hey,
> > > > > >>
> > > > > >>
> > > > > >> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> > > > > >> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> > > > > >> RO can be enabled. This function checks if the Enable Relaxed
> > > > > >> Ordering bit in the Device Control register is set. However, on a
> > > > > >> VF, this bit is RsvdP (Reserved for future RW
> > > > > >> implementations. Register bits are read-only and must return zero
> > > > > >> when read. Software must preserve the value read for writes to
> > > > > >> bits.).
> > > > > >>
> > > > > >> Hence, AFAICT, RO will not be enabled when using a VF.
> > > > > >>
> > > > > >> How can that be fixed?
> > > > > >
> > > > > > When qemu takes a VF and turns it into a PF in a VM it must emulate
> > > > > > the RO bit and return one
> > > > >
> > > > > I have a pass-through VF:
> > > > >
> > > > > # lspci -s ff:00.0 -vvv
> > > > > ff:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex Virtual Function]
> > > > > []
> > > > >               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > > > >                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
> > > >
> > > > Like I said, it is a problem in the qemu area..
> > > >
> > > > Jason
> > > Can you clarify why this is a problem in the QEMU area?
> > >
> > > Even though Mellanox device might well support it (on VF), there's no
> > > way for QEMU to really know if an arbitrary passthrough device may
> > > support RO.
> >
> > That isn't what the cap bit means
> >
> > The cap bit on the PF completely disables generation of RO at the
> > device at all.
> >
> > If the PF's cap bit is disabled then no VF can generate RO, and qemu
> > should expose a wired to zero RO bit in the emulated PF.
> >
> > If the cap bit is enabled then the VFs could generate RO, depending on
> > their drivers, and qemu should generate defaulted to 1 bit in the
> > emulated PF.
> 
> Set the broken root port and the P2P DMA cases aside, let's say we
> have a RO enabled PF where there's a working root port upstream that
> well supports RO. As VF mostly inherits PF's state/config, no matter
> what value the DevCtl RlxdOrd bit presents in the host it doesn't mean
> anything,

Not quite if the guest sees RlxdOrd enabled then it means the guest
can expect that the device can send TLPs with relaxed ordering sent.

> although we know getting RO disabled on the PF implies
> prohibiting RO TLP being sent by all its child VFs. There's no
> question for this part. The real problem though, is if the RlxdOrd cap
> bit for the VF can be controlled individually similar to the way the
> toggling on PF is done?

It cannot.

Just like today where qemu wrongly reports disabled for a VF RlxdOrd
it doesn't mean that the VF cannot or does not issue Relaxed Ordering
TLPs.

Since the HW cannot have this level of fine grained control a full
emulation of the RlxdOrd bit is not possible for VFs.

> For e.g, suppose the RO cap bit for the VF
> emulated by QEMU defaults to enabled where the backing PF and all
> child VFs have RO enabled. Will a PCI write of zero to the bit be able
> to prevent RO ULP initiated by that specific VF from being sent out,
> which is to resemble PF's behaviour? 

Nope. HW can't do it.

> This being the Mellanox VF's specifics? 

It is not Mellanox specific, this is all PCI spec.

> More broadly, should the VFs for arbitrary PCIe devices have that
> kind of control on an individual VF's level? I don't find it
> anywhere in the PCIe SR-IOV spec that this should be the case.

They don't and for this discussion it doesn't matter.

Your question was about how to enable relaxed ordering in guests, and
the answer is for qemu to report enabled on rlxdord in the VF using
PCI config space emulation and continue to not support changing the
relaxed ordering mode of a VF (ie wired to enabled)

Jason
