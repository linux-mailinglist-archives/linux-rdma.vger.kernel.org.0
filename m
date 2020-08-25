Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E924B25189E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHYMed (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 08:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgHYMec (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 08:34:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059D520738;
        Tue, 25 Aug 2020 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598358872;
        bh=AWFJGdEPegNivs5jXIKL0BxvquXAm7LAf1RISflhyaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBOizBWyS7STExzf8SONwTTCDd0Us3peTFCUFb59RcpbDDZvqX07nKEwfrwyk3XXu
         z3RtNcUEzejACsn0kNvLqxFTl6vc3cbpdE5dqe7ELjTCrDJ9v4raecuCwCVfEKfUMc
         XhDA8BfKaPNE7yxyW1NMsuIsDSPbQv4T/O1TKR2c=
Date:   Tue, 25 Aug 2020 15:34:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
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
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200825123427.GB1362631@unreal>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 03:12:07PM +0300, Gal Pressman wrote:
> On 25/08/2020 14:52, Jason Gunthorpe wrote:
> > On Tue, Aug 25, 2020 at 11:13:25AM +0300, Gal Pressman wrote:
> >> On 24/08/2020 13:32, Leon Romanovsky wrote:
> >>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> >>> index 1889dd172a25..8547f9d543df 100644
> >>> +++ b/drivers/infiniband/hw/efa/efa.h
> >>> @@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
> >>>  int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> >>>  		   u16 *pkey);
> >>>  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> >>>  struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >>>  			    struct ib_qp_init_attr *init_attr,
> >>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >>> index 3f7f19b9f463..660a69943e02 100644
> >>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>> @@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>>  	return err;
> >>>  }
> >>>
> >>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>>  {
> >>>  	struct efa_dev *dev = to_edev(ibpd->device);
> >>>  	struct efa_pd *pd = to_epd(ibpd);
> >>>
> >>>  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> >>>  	efa_pd_dealloc(dev, pd->pdn);
> >>> +	return 0;
> >>>  }
> >>
> >> Nice change, thanks Leon.
> >> At least for EFA, I prefer to return the return value of the destroy command
> >> instead of silently ignoring it (same for the other patches).
> >
> > Drivers can't fail the destroy unless a future destroy will succeed.
> > it breaks everything to do that.
>
> What does it break?

It will break ucontext cleanup flow exactly where you pointed, e.g.
uverbs_destroy_ufile_hw(). We release all objects and memory associated
with that ucontext to ensure that no memory leaks.

>
> > That is why the return codes were removed.
> >
> > Unfortunately there are cases where future destroy will succeed, so
> > here we are :(
>
> I replied in the other thread as well, we can continue the discussion here.
>
> I agree that drivers shouldn't fail destroy commands, but you know.. bugs/errors
> happen (especially when dealing with hardware), and we have a way to propagate
> them, why do it for only some of the drivers?

Because DevX flow guarantees that this second call will succeed.

>
> These kinds of things aren't really expected so I don't mind what we end up
> with, but in the rare cases they do I would prefer not to ignore such errors,
> and yea, give the destroy command another shot when the process is cleaned up.
>
> > If the chip fails a destroy when it should not then it has failed and
> > should be disabled at PCI and reset, continuing to free anyhow.
>
> How do we reset the device when there are active apps using it?

I think that it is not different than any PCI error handling.

Thanks
