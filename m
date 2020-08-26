Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232562526E9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 08:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgHZGeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 02:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHZGeQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 02:34:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD8220707;
        Wed, 26 Aug 2020 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598423655;
        bh=UCDUyoLoBgehZLq+AB3aZZHCgNH0fv8iaV86IWgCKuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHgAaGcw16EJ2SNZOB7RICmJbZPCIr3Sn8I1iGMLZx6gNWTWyS9JVJ9tQIPMN8Q+x
         6cLCxrlQXJ8lKjyQBhOF2ZCz0lj2FqC+BsKF8i/QMn0LLIPCBgQ+yMh1mhf5Qcukm4
         odwwuTZKMJlJDzTZ5+rNbWY8D3JzE/3GApCySzfM=
Date:   Wed, 26 Aug 2020 09:34:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20200826063411.GF1362631@unreal>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 12:49:03AM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
> > deallocate
> >
> > On 25/08/2020 16:44, Jason Gunthorpe wrote:
> > > On Tue, Aug 25, 2020 at 04:32:57PM +0300, Gal Pressman wrote:
> > >>> For uverbs it will go into an infinite loop in
> > >>> uverbs_destroy_ufile_hw() if destroy doesn't eventually succeed.
> > >>
> > >> The code breaks the loop in such cases, why infinite loop?
> > >
> > > Oh, that is a bug, it should WARN_ON when that happens, because the
> > > driver has triggered a permanent memory leak.
> >
> > Well, a WARN_ON won't do much good if you're stuck in an infinite loop :), the
> > break is definitely needed there.
> >
> > >>> For kernel it will trigger WARN_ON's and then a permanent memory leak.
> > >>>
> > >>>> I agree that drivers shouldn't fail destroy commands, but you
> > >>>> know.. bugs/errors happen (especially when dealing with hardware),
> > >>>> and we have a way to propagate them, why do it for only some of the
> > drivers?
> > >>>
> > >>> There is no way to propogate them.
> > >>>
> > >>> All destroy must eventually succeed.
> > >>
> > >> There is no way to propagate them on process cleanup, but the destroy
> > >> verbs have a return code all the way back to libibverbs, which we can
> > >> use for error propagation.
> > >
> > > It is sort of OK for a driver to fail during RDMA_REMOVE_DESTROY.
> > >
> > > All other reason codes must eventually succeed.
> > >
> > >> The cleanup flow can either ignore the return value, or we can add
> > >> another parameter that explicitly means the call shouldn't fail and
> > >> all allocated memory/state should be freed.
> > >
> > > I don't really see the value to return the error code to userspace, it
> > > would require churning all the drivers and all the destroy functions
> > > to pass the existing reason in.
> > >
> > > Since all the details of the FW failure reason are lost to some EINVAL
> > > (or already logged to dmesg) I don't see much point.
> >
> > Right, as always, the error code would probably not contain much information, but
> > there's a big difference between returning error code X/Y vs returning success
> > instead of an error. To me that just feels wrong, at least in cases where we can
> > prevent that.
> >
>
> The API is quite confusing now. If drivers are not expected to fail the destroy
> and there is no way to propagate the device failures, then the return type should be a void.
>
> Do we really want to have mixed/ambiguous definition of the API to support the quirks of one type of device?

This is in-kernel API and it can be imperfect, because we are not
bounded to not-break-userspace rule.

I don't like the current situation either, just don't know how to
solve it differently.

Thanks

>
> Shiraz
>
