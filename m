Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B825BA18
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 07:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgICF2b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 01:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICF2b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 01:28:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E415D20758;
        Thu,  3 Sep 2020 05:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599110910;
        bh=Yfz/PdSME9OctrewKKw/Jw3iI5NLYHPbp7bkn9DAtlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKcIIEDvYtSpJb9K3nEyH+cssw8fRnf5XFBWCPMNvrvbHqzERpiasTuWhOD1s8VSB
         Bd8zN/1ik/VIsuunxG31OYASP937NerZYJcCDsjkrCcyOEp2PK43CCr9/Y0J0q5muQ
         qrQgwcvZ2pvRb7eBnIO8V8w8/fUgwHWRYRfa+nyE=
Date:   Thu, 3 Sep 2020 08:28:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1 05/10] RDMA: Restore ability to fail on SRQ
 destroy
Message-ID: <20200903052826.GQ59010@unreal>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
 <20200903001827.GB1479562@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903001827.GB1479562@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 09:18:27PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
>
> > -void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> > +int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> >  {
> >  	struct mlx5_ib_dev *dev = to_mdev(srq->device);
> >  	struct mlx5_ib_srq *msrq = to_msrq(srq);
> > +	int ret;
> > +
> > +	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > +	if (ret && udata)
> > +		return ret;
> >
> > -	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > -
> > -	if (srq->uobject) {
> > -		mlx5_ib_db_unmap_user(
> > -			rdma_udata_to_drv_context(
> > -				udata,
> > -				struct mlx5_ib_ucontext,
> > -				ibucontext),
> > -			&msrq->db);
> > -		ib_umem_release(msrq->umem);
> > -	} else {
> > -		destroy_srq_kernel(dev, msrq);
> > +	if (udata) {
> > +		destroy_srq_user(srq->pd, msrq, udata);
> > +		return 0;
> >  	}
> > +
> > +	/* We are cleaning kernel resources anyway */
> > +	destroy_srq_kernel(dev, msrq);
>
> Oh, and this isn't right.. If we are going to leak things then we have
> to leak anything exposed for DMA as well, eg the fragbuf under the SRQ
> has to be leaked.

We are leaking for ULPs only, from their perspective everything was
released and WARN_ON() will be the sign of the problem.

>
> If the HW can't guarentee it stopped doing DMA then we can't return
> memory under potentially active DMA back to the system.

ULPs are supposed to guarantee that all operations stopped.

>
> IHMO mlx5, and all the other drivers, get this wrong. Failing to
> eventually destroy an object is a catastrophic failure of the
> device. In the case of a kernel object it must always be destroyed on
> the first attempt.

This is current flow, we are destroying kernel object anyway.

>
> In this case the device should be killed. Disable memory access at the
> PCI config space, trigger a device reset, disassociate the device, and
> allow all destroy commands to fake-succeed.
>
> Since drivers need help to get this right, I'm wonder if we should fix
> this at the core level by introducing a 'your device is screwed up,
> kill it' callback.
>
> Then all the destroys can return failures as Gal wanted.
>
> The core logic would be something like
>
> ret = dev->ops.destroy_foo()
> if (is_kernel_object())
>    dev->ops.device_is_broken()
>    ret = dev->ops.destroy_foo()
>    WARN_ON(ret);
>
> Ie after 'device_is_broken' the driver must always succeed future
> destroys.
>
> Then we have a chance to make this work properly... mlx5 at least
> already has an implementation of 'device_is_broken' that does trigger
> success for future destroys.

I don't know, all those years we relied on the ULPs to do destroy
properly and it worked well. I didn't hear any complain from the field
that HW destroy failed in proper ULP flow.

It looks to me over-engineering.

Thanks

>
> Jason
