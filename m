Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52D253E44
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgH0G4t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 02:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0G4s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 02:56:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4301222B4E;
        Thu, 27 Aug 2020 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598511407;
        bh=LG54W6UeTjBcAy+LqlN3dRz2B/4lr0OE/Gqj0BjLL9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzPOp0RDU766jOL4vza2PG9f7g9Xu+0r9a9qTgOAfzDqQRnQf8oXGAVjjAj852/x2
         KuOuH/V05ta2GRol0n9kx9Xt27KLVSXLko7nlFNfASah7hsyCXpoe8tkLkXfiDx+gK
         4tyopUJGfzdI/8rNTmNy44lxO1awxPrNtlIfx+q8=
Date:   Thu, 27 Aug 2020 09:56:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200827065643.GP1362631@unreal>
References: <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
 <20200826114043.GY1152540@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 02:06:03AM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
> > deallocate
> >
> > On Wed, Aug 26, 2020 at 12:49:03AM +0000, Saleem, Shiraz wrote:
> >
> > > The API is quite confusing now. If drivers are not expected to fail
> > > the destroy and there is no way to propagate the device failures, then
> > > the return type should be a void.
> >
> > More or less, drivers can only return -EAGAIN with the idea that a future call during
> > the close process will eventually succeed.
> >
> > Any permanent failure will trigger WARN_ON and a memory leak
> >
> > Maybe we should switch the return code to bool or something to be a little clearer
> > that it is request to retry, not a failure?
> >
> There is no retry for kernel object destroy right? So not sure bool is making It clearer.

Right, kernel verbs users don't know how to deal with destroy failure
and designed to ensure that destroy always success.

>
> I am not very familiar with devx flows but doesn’t it bypass the ib verbs layer altogether?
> i.e. mlx5_ib_dealloc_pd isn’t directly called in the devx flows no? So why changes its return
> type and other provider destroy callbacks?

DevX itself indeed bypasses ib_core and as a standalone feature doesn't
need any changes in destroys. The problem arises when ib_core object is
created with ibv_create_XXX() and forwarded later to DevX context.

FW counts DevX accesses and elevates internal reference counters to
ensure that user will get proper error if he tries to destroy in-use
resources.

This error is returned to mlx5_ib_dealloc_pd() too if DevX is not
cleaned. This call can be executed by user anytime, for example if he
decided to skip DevX cleanup and the ib_core/mlx5_ib can't prevent call
to mlx5_ib_dealloc_pd() at this stage.

The difference between mlx5 device from other providers that HW/FW
guarantees full cleanup during file close.

>
> But lets go down the path that we really need a return code in the destroy APIs to solve this problem.
> For one I don’t see how we can say its meant exclusively for devx drivers to use for a fail.
> Also can we really claim the API contract is that driver can fail a destroy given a future destroy will succeed?
> Since the kernel destroy has no retry.

This is why we have special calls for kernel users with WARN_ON() and
forced cleanup of ib_core resources.

>
> Which then boils down do we just keep a simpler definition of the API contract -- driver can just return whatever the true error code is?
> i.e. if it wants a retry, use EAGAIN. If it has a non recoverable device error, then reset the device, clean up the resources but return ENOTRECOVERABLE.
> ib_core can enable the retry logic for EAGAIN _only_.  For other error codes, Ib_core can trigger a warn_on or something to indicate permanent failure.

We can, but drivers should implement this EAGAIN/ENOTRECOVERABLE logic,
this is why in initial phase we are returning always success.

> It can also pass on ret_code to user-space as its doing today?
>
> Shiraz
>
>
>
>
