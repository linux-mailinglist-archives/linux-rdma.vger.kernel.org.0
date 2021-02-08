Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC50C31333F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBHN3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 08:29:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBHN1Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Feb 2021 08:27:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8D364DCC;
        Mon,  8 Feb 2021 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612790795;
        bh=zf/pNV0B/X78DdGR2ISpuVfeyWbjux9KoawSHy7kzlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEbIE3vNtOevT3drftRyI+GE85ok4KHAKBzjGZ0G/u2+zqsvDNFNs6OaM/OIqtiMW
         ARZE631BMnZFSq0aSWl1w+VwXxbNUC5einQ3mo0krFO/1JzMO+tJY4wtJOWeu7MhbM
         /D+fmvmV/SIJ4JB9k1iATrZpy/Pbuct6xw3qMAxQQOY8xrU0Pl2cABot0FhF137HeB
         tPU8T3PZY+mjpwKM5rlvN6JvNYhfh+jDlnxM1XOHBCd+WDTRFggVqF4Ndnpq19q3Dp
         ORrh+SOyNKxMcigJsdXfZaXiWhzXA+nGLDYMT/hsn25It2ewxKUsp7i5wvG1u+gSJT
         dyTG+n8/SJMdg==
Date:   Mon, 8 Feb 2021 15:26:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alaa Hleihel <alaa@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Honggang Li <honli@redhat.com>,
        Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208132631.GD20265@unreal>
References: <20210207080649.GB4656@unreal>
 <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal>
 <2779ed9e-4072-fe35-796d-b8102e8378f4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2779ed9e-4072-fe35-796d-b8102e8378f4@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 03:15:52PM +0200, Alaa Hleihel wrote:
> On 08/02/2021 15:10, Leon Romanovsky wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> >> On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> >>> Hi Honggang,
> >>>
> >>> Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> >>> removes protection from rdma-core when user performs "dnf autoremove".
> >>>
> >>> Before your patch, systemd was dependent on libibverbs and latter
> >>> required rdma-core. After your patch, the last link is lost and
> >>> rdma-core marked as orphaned package.
> >>>
> >>> Any attempt to install rdma-core as standalone package will have the
> >>> following errors, due to the library dependency of udevadm.
> >>> [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> >>>     libibverbs.so.1 => not found
> >>
> >> well that makes no sense, since when is udevadm connected to
> >> libibverbs?
> >>
> >> $ ldd `which udevadm`
> >>       linux-vdso.so.1 (0x00007ffcc09ef000)
> >>       libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> >>       libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> >>       libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> >>       libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> >>       libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> >>       libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> >>       /lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> >>       liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> >>       libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> >>       libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> >>       libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> >
> > This is from my laptop and it is connected:
> >
> > ➜  kernel git:(m/msix-v6) ldd /sbin/udevadm
> >         linux-vdso.so.1 (0x00007fffc4bf2000)
> >         libsystemd-shared-246.so => /usr/lib/systemd/libsystemd-shared-246.so (0x00007f70f69ef000)
> >         libkmod.so.2 => /lib64/libkmod.so.2 (0x00007f70f69c0000)
> >         libacl.so.1 => /lib64/libacl.so.1 (0x00007f70f69b6000)
> >         libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f70f6981000)
> >         libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f70f6966000)
> >         libc.so.6 => /lib64/libc.so.6 (0x00007f70f679b000)
> >         libcap.so.2 => /lib64/libcap.so.2 (0x00007f70f6792000)
> >         libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f70f6758000)
> >         libcryptsetup.so.12 => /lib64/libcryptsetup.so.12 (0x00007f70f66e3000)
> >         libgcrypt.so.20 => /lib64/libgcrypt.so.20 (0x00007f70f65be000)
> >         libidn2.so.0 => /lib64/libidn2.so.0 (0x00007f70f659d000)
> >         libip4tc.so.2 => /lib64/libip4tc.so.2 (0x00007f70f6593000)
> >         liblz4.so.1 => /lib64/liblz4.so.1 (0x00007f70f6573000)
> >         libmount.so.1 => /lib64/libmount.so.1 (0x00007f70f6530000)
> >         libcrypto.so.1.1 => /lib64/libcrypto.so.1.1 (0x00007f70f6243000)
> >         libp11-kit.so.0 => /lib64/libp11-kit.so.0 (0x00007f70f6111000)
> >         libpam.so.0 => /lib64/libpam.so.0 (0x00007f70f60ff000)
> >         librt.so.1 => /lib64/librt.so.1 (0x00007f70f60f4000)
> >         libseccomp.so.2 => /lib64/libseccomp.so.2 (0x00007f70f60d0000)
> >         libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f70f60a3000)
> >         libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f70f5fce000)
> >         liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f70f5fa2000)
> >         libdl.so.2 => /lib64/libdl.so.2 (0x00007f70f5f9b000)
> >         libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f70f5f79000)
> >         /lib64/ld-linux-x86-64.so.2 (0x00007f70f6d29000)
> >         libz.so.1 => /lib64/libz.so.1 (0x00007f70f5f5d000)
> >         libattr.so.1 => /lib64/libattr.so.1 (0x00007f70f5f55000)
> >         libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f70f5f4c000)
> >         libdevmapper.so.1.02 => /lib64/libdevmapper.so.1.02 (0x00007f70f5eef000)
> >         libssl.so.1.1 => /lib64/libssl.so.1.1 (0x00007f70f5e53000)
> >         libargon2.so.1 => /lib64/libargon2.so.1 (0x00007f70f5e4a000)
> >         libjson-c.so.5 => /lib64/libjson-c.so.5 (0x00007f70f5e35000)
> >         libgpg-error.so.0 => /lib64/libgpg-error.so.0 (0x00007f70f5e10000)
> >         libunistring.so.2 => /lib64/libunistring.so.2 (0x00007f70f5c8d000)
> >         libpcap.so.1 => /lib64/libpcap.so.1 (0x00007f70f5c3e000)
>
> Check if libpcap was built with rdma support.
> # nm /lib64/libpcap.so.1 | grep ibv
>
> That's probably what pulled the libibverbs dependency.

➜  kernel git:(m/msix-v6) nm /lib64/libpcap.so.1 | grep ibv
nm: /lib64/libpcap.so.1: no symbols

Thanks
