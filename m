Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFED525BA00
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgICFLS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 01:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICFLP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 01:11:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF18A20665;
        Thu,  3 Sep 2020 05:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599109875;
        bh=lnk/bKQIi5kFV6HJWhde6BoRJ7hjCuqul3+UOz8fU+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYv555DWedqX2liOquPtVKSSKsDJnUqP4UDvQA0FRyRpsWuVvrBcqXcY2Cm9NMbSe
         5XIqcvQTDNwbCsLJJFrEI7kotFcO2EUXK1mQxyWK8wCePM07aoz2VgSKoAbo3vDX6O
         EqDPhNPLC/Kn4iKAqNqpl7Y5mPiep5USbYTAMNzw=
Date:   Thu, 3 Sep 2020 08:11:12 +0300
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
Message-ID: <20200903051112.GP59010@unreal>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
 <20200903000850.GA1479562@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903000850.GA1479562@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 09:08:50PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
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
>
> It is not a big deal but I would like to remove udata as an argument
> to the driver destroy functions, it is completely nonsensical and
> never used.

  197 static void destroy_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
  198                              struct ib_udata *udata)
  199 {
  200         mlx5_ib_db_unmap_user(
  201                 rdma_udata_to_drv_context(
  202                         udata,
                              ^^^^^^ in use

  203                         struct mlx5_ib_ucontext,
  204                         ibucontext),
  205                 &srq->db);
  206         ib_umem_release(srq->umem);
  207 }
  208


>
> Jason
