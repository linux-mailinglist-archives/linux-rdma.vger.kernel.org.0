Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4227505B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIWFkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWFkQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 01:40:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hrwgMpumH70YPQDMHjkd+jtxyboQ1LMdg6CKSb7Wbp8=; b=jR4m2fQXqwXz8Ta49lzGp9nn/n
        sy8Kgr7cRGpq1gF/VhdEvclBJSBTchZHyl0UsFTF9xP1qEABpd/l6kZrHDdRayhIjV8Ep9veBAueg
        hg7kuK2WhRrO1RvTP4SiJq6TI3hOrnzYHNv7z4xHrvS3fFfhIQccpqYHJdFgyTE3Cbt1wF8vWKb47
        DX58SLpsYX8B9ON2H6QYDhyerHW4U5XRJysdjTXw/ZMmsE4NCWPAlMNtgOcHTenRDW0k1dD4liZ4x
        5wAalNwRB4VL4OnMWM2Wv/2pV4dQlxZMPSt35AxkmFMliTMrwxqVqFk8JcMWBGWz36fEF7DxeCTHl
        hpRQzirg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKxVT-0001Xo-RF; Wed, 23 Sep 2020 05:39:55 +0000
Date:   Wed, 23 Sep 2020 06:39:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200923053955.GB4809@infradead.org>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922162206.GD3699@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 01:22:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 02:22:01PM +0000, Bernard Metzler wrote:
> > ...
> > 
> > >> >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> > >> >b/drivers/infiniband/sw/siw/siw_main.c
> > >> >index d862bec84376..0362d57b4db8 100644
> > >> >+++ b/drivers/infiniband/sw/siw/siw_main.c
> > >> >@@ -69,7 +69,7 @@ static int siw_device_register(struct siw_device
> > >> >*sdev, const char *name)
> > >> >
> > >> > 	sdev->vendor_part_id = dev_id++;
> > >> >
> > >> >-	rv = ib_register_device(base_dev, name);
> > >> >+	rv = ib_register_device(base_dev, name, NULL);
> > >> > 	if (rv) {
> > >> > 		pr_warn("siw: device registration error %d\n", rv);
> > >> > 		return rv;
> > >> >@@ -386,6 +386,8 @@ static struct siw_device
> > >> >*siw_device_create(struct net_device *netdev)
> > >> > 	base_dev->dev.dma_parms = &sdev->dma_parms;
> > >> > 	sdev->dma_parms = (struct device_dma_parameters)
> > >> > 		{ .max_segment_size = SZ_2G };
> > >> >+	dma_coerce_mask_and_coherent(&base_dev->dev,
> > >> >+				     dma_get_required_mask(&base_dev->dev));
> > >>
> > >> Leon, can you please help me to understand this
> > >> additional logic? Do we need to setup the DMA device
> > >> for (software) RDMA devices which rely on dma_virt_ops
> > >> in the end, or better leave it untouched?
> > >
> > >The logic that driver is responsible to give right DMA device,
> > >so yes, you are setting here mask from dma_virt_ops, as RXE did.
> > >
> > Thanks Leon!
> > 
> > I wonder how this was working w/o that before!
> 
> I wonder if dma_virt_ops ignores the masking.. Still seems best to set
> it consistently when using dma_virt_ops.

dma_virt_ops doesn't look at the mask.  But in retrospective
dma_virt_ops has been a really bad idea.  I'd much rather move the
handling of non-physical devices back into the RDMA core in the long
run.
