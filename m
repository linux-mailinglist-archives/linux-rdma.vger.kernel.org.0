Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46DE2645F8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIJM1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 08:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbgIJMZG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 08:25:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2951F208FE;
        Thu, 10 Sep 2020 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599740702;
        bh=HZhllT4V05jsntTn2xHSiHXZT+8hG/vt2ZUpOD42NaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xS7s6stxB+Nk/1pHC1CM/RWPCvf3wBouzIXX0kXEFaPzPHnyY2KYhdjhJ+Rh4U7Bv
         M4iDQQkyjuIqqe74WSTCZDRUkPvCrfoZlxXsK4BSCsRGxZlzlw2wLHgKAjFbxCEJT2
         ZV94qt24nrNoJio8Z66oPBg+OSG+29dIMv4vMOTI=
Date:   Thu, 10 Sep 2020 15:24:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
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
        Yuval Shaia <yuval.shaia@oracle.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 0/9] Restore failure of destroy commands
Message-ID: <20200910122457.GI421756@unreal>
References: <20200907120921.476363-1-leon@kernel.org>
 <20200909180607.GA916941@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909180607.GA916941@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 03:06:07PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:09:12PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Changelog:
> > v2:
> >  * Rebased on top of the 524d8ffd07f0
> >  * Removed "udata" check in destroy flows
> >  * Changed ib_free_cq to return early
> >  * Used Jason's suggestion to implement "RDMA/mlx5: Issue FW command to destroy
> >    SRQ on reentry" patch.
> > v1
> >  * Changed returned value in efa_destroy_ah() from EINVAL to EOPNOTSUPP
> >  * https://lore.kernel.org/lkml/20200830084010.102381-1-leon@kernel.org
> > v0:
> >  * https://lore.kernel.org/lkml/20200824103247.1088464-1-leon@kernel.org
> >
> > Hi,
> >
> > This series restores the ability to fail on destroy commands, due to the
> > fact that mlx5_ib DEVX implementation interleaved ib_core objects
> > with FW objects without sharing reference counters.
> >
> > In retrospect, every part of the mlx5_ib flow is correct.
> >
> > It started from IBTA which was written by HW engineers with HW in mind and
> > they allowed to fail in destruction. FW implemented it with symmetrical
> > interface like any other command and propagated error back to the kernel,
> > which forwarded it to the libibverbs and kernel ULPs.
> >
> > Libibverbs was designed with IBTA spec in hand putting destroy errors in
> > stone. Up till mlx5_ib DEVX, it worked well, because the IB verbs objects
> > are counted by the kernel and ib_core ensures that FW destroy will success
> > by managing various reference counters on such objects.
> >
> > The extension of the mlx5 driver changed this flow when allowed DEVX objects
> > that are not managed by ib_core to be interleaved with the ones under ib_core
> > responsibility.
> >
> > The drivers that want to implement DEVX flows must ensure that FW/HW
> > destroys are performed as early as possible before any other internal
> > cleanup. After HW destroys, drivers are not allowed to fail.
> >
> > This series includes two patches (WQ and "potential race") that will
> > require extra work in mlx5_ib, they both theoretical. WQ is not in use
> > in DEVX, but is needed to make interface symmetrical to other objects.
> > "Potential race" is in ULP flow that ensures that SRQ is destroyed in
> > proper order.
> >
> > Thanks
> >
> > Leon Romanovsky (9):
> >   RDMA: Restore ability to fail on PD deallocate
> >   RDMA: Restore ability to fail on AH destroy
> >   RDMA/mlx5: Issue FW command to destroy SRQ on reentry
> >   RDMA: Restore ability to fail on SRQ destroy
> >   RDMA/core: Delete function indirection for alloc/free kernel CQ
> >   RDMA: Allow fail of destroy CQ
> >   RDMA: Change XRCD destroy return value
> >   RDMA: Restore ability to return error for destroy WQ
> >   RDMA: Make counters destroy symmetrical
>
> Thanks, applied to for-next with the changes I noted:

Thanks for taking care. LGTM.
