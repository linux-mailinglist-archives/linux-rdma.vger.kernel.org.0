Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75D3B8804
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhF3RwP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 13:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhF3RwP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 13:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB4961462;
        Wed, 30 Jun 2021 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625075386;
        bh=/QiX33p5bYPVFlmCGcTrcEYCsFrjvItICmc+E7ZuREY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6wtlg0Ujzsh2cKDL5/DRjlc7iNwjeXHqa/c+hhPvO4yq6c5IMviTnnnKAne1lvg8
         s3mUU69+lYuUnIUIAmb3IVIIqqsE4y3s+bILMptpD+pSOcIVE/hEDsQU+cSSm/xLqx
         p4o62Ge/fdBaBa11DID8+teioklVEKEE2IZabfrQztzYaX+Izff52SV8mfBENLBmT6
         5CTtOJ3se3Wd5CVq1Y9ylU6BhyEFfwRw+IOISIv4xs+Ar2w0hxR10C0bqCOQmVj6pY
         BzKQuj5cZYBGqTCbbUPKue1VdwmHH3Ckh+T6fRM/nHFnOWBuTgaqy1tqdoN+EePhoK
         tbyGqwl+As4sw==
Date:   Wed, 30 Jun 2021 20:49:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNyutTbAWRcK7Bgp@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
 <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
 <YNytdbEG9OSHOT1z@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YNytdbEG9OSHOT1z@orome.fritz.box>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 07:44:21PM +0200, Thierry Reding wrote:
> On Wed, Jun 30, 2021 at 01:12:26PM +0200, Marek Szyprowski wrote:
> > Hi Leon,
> >=20
> > On 29.06.2021 10:40, Leon Romanovsky wrote:
> > > From: Maor Gottlieb <maorg@nvidia.com>
> > >
> > > orig_nents should represent the number of entries with pages,
> > > but __sg_alloc_table_from_pages sets orig_nents as the number of
> > > total entries in the table. This is wrong when the API is used for
> > > dynamic allocation where not all the table entries are mapped with
> > > pages. It wasn't observed until now, since RDMA umem who uses this
> > > API in the dynamic form doesn't use orig_nents implicit or explicit
> > > by the scatterlist APIs.
> > >
> > > Fix it by:
> > > 1. Set orig_nents as number of entries with pages also in
> > >     __sg_alloc_table_from_pages.
> > > 2. Add a new field total_nents to reflect the total number of entries
> > >     in the table. This is required for the release flow (sg_free_tabl=
e).
> > >     This filed should be used internally only by scatterlist.
> > >
> > > Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocat=
ion of SG table from pages")
> > > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > This patch landed in linux-next 20210630 as commit a52724456928=20
> > ("lib/scatterlist: Fix wrong update of orig_nents"). It causes serious=
=20
> > regression in DMA-IOMMU integration, which can be observed for example=
=20
> > on ARM Juno board during boot:
> >=20
> > Unable to handle kernel paging request at virtual address 00376f42a6e40=
454
> > Mem abort info:
> >  =A0 ESR =3D 0x96000004
> >  =A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >  =A0 SET =3D 0, FnV =3D 0
> >  =A0 EA =3D 0, S1PTW =3D 0
> >  =A0 FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> >  =A0 ISV =3D 0, ISS =3D 0x00000004
> >  =A0 CM =3D 0, WnR =3D 0
> > [00376f42a6e40454] address between user and kernel address ranges
> > Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.13.0-next-20210630+ #3585
> > Hardware name: ARM Juno development board (r1) (DT)
> > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> > pc : __sg_free_table+0x60/0xa0
> > lr : __sg_free_table+0x7c/0xa0
> > ..
> > Call trace:
> >  =A0__sg_free_table+0x60/0xa0
> >  =A0sg_free_table+0x1c/0x28
> >  =A0iommu_dma_alloc+0xc8/0x388
> >  =A0dma_alloc_attrs+0xcc/0xf0
> >  =A0dmam_alloc_attrs+0x68/0xb8
> >  =A0sil24_port_start+0x60/0xe0
> >  =A0ata_host_start.part.32+0xbc/0x208
> >  =A0ata_host_activate+0x64/0x150
> >  =A0sil24_init_one+0x1e8/0x268
> >  =A0local_pci_probe+0x3c/0xa0
> >  =A0pci_device_probe+0x128/0x1c8
> >  =A0really_probe+0x138/0x2d0
> >  =A0__driver_probe_device+0x78/0xd8
> >  =A0driver_probe_device+0x40/0x110
> >  =A0__driver_attach+0xcc/0x118
> >  =A0bus_for_each_dev+0x68/0xc8
> >  =A0driver_attach+0x20/0x28
> >  =A0bus_add_driver+0x168/0x1f8
> >  =A0driver_register+0x60/0x110
> >  =A0__pci_register_driver+0x5c/0x68
> >  =A0sil24_pci_driver_init+0x20/0x28
> >  =A0do_one_initcall+0x84/0x450
> >  =A0kernel_init_freeable+0x31c/0x38c
> >  =A0kernel_init+0x20/0x120
> >  =A0ret_from_fork+0x10/0x18
> > Code: d37be885 6b01007f 52800004 540000a2 (f8656813)
> > ---[ end trace 4ba4f0c9c48711a1 ]---
> > Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000000=
0b
> >=20
> > It looks that some changes to the scatterlist structures are missing=20
> > outside of the lib/scatterlist.c.
> >=20
> > For now I would suggest to revert this change.
>=20
> I see a very similar crash on Tegra during the HDA driver's probe.
>=20
> Leon, let me know if you need a tester for a replacement patch.

With a great pleasure, I'll contact you offline when we prepare it.

For now, this patch will be dropped.

Thanks

>=20
> Thanks,
> Thierry


