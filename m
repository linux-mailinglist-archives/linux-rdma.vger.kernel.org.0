Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95FB00B2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfIKP6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 11:58:41 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:22282 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfIKP6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 11:58:41 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8BFwHoS011088;
        Wed, 11 Sep 2019 08:58:18 -0700
Date:   Wed, 11 Sep 2019 21:28:16 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Steve Wise <larrystevenwise@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on
 iw_rem_ref
Message-ID: <20190911155814.GA12639@chelsio.com>
References: <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Steve & Bernard,

Thanks for the review comments.
I will do those formating changes.

Thanks,
Krishna.
On Wednesday, September 09/11/19, 2019 at 20:12:43 +0530, Steve Wise wrote:
> On Wed, Sep 11, 2019 at 4:38 AM Bernard Metzler <BMT@zurich.ibm.com> wrote:
> >
> > -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> >
> > >To: "Sagi Grimberg" <sagi@grimberg.me>, "Steve Wise"
> > ><larrystevenwise@gmail.com>, "Bernard Metzler" <BMT@zurich.ibm.com>
> > >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >Date: 09/10/2019 09:22PM
> > >Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Jason
> > >Gunthorpe" <jgg@ziepe.ca>
> > >Subject: [EXTERNAL] Re: [PATCH v3] iwcm: don't hold the irq disabled
> > >lock on iw_rem_ref
> > >
> > >Please review the below patch, I will resubmit this in patch-series
> > >after review.
> > >- As kput_ref handler(siw_free_qp) uses vfree, iwcm can't call
> > >  iw_rem_ref() with spinlocks held. Doing so can cause vfree() to
> > >sleep
> > >  with irq disabled.
> > >  Two possible solutions:
> > >  1)With spinlock acquired, take a copy of "cm_id_priv->qp" and
> > >update
> > >    it to NULL. And after releasing lock use the copied qp pointer
> > >for
> > >    rem_ref().
> > >  2)Replacing issue causing vmalloc()/vfree to kmalloc()/kfree in SIW
> > >    driver, may not be a ideal solution.
> > >
> > >  Solution 2 may not be ideal as allocating huge contigous memory for
> > >   SQ & RQ doesn't look appropriate.
> > >
> > >- The structure "siw_base_qp" is getting freed in siw_destroy_qp(),
> > >but
> > >  if cm_close_handler() holds the last reference, then siw_free_qp(),
> > >  via cm_close_handler(), tries to get already freed "siw_base_qp"
> > >from
> > >  "ib_qp".
> > >   Hence, "siw_base_qp" should be freed at the end of siw_free_qp().
> > >
> >
> > Regarding the siw driver, I am fine with that proposed
> > change. Delaying freeing the base_qp is OK. In fact,
> > I'd expect the drivers soon are passing that responsibility
> > to the rdma core anyway -- like for CQ/SRQ/PD/CTX objects,
> > which are already allocated and freed up there.
> >
> > The iwcm changes look OK to me as well.
> >
> 
> Hey Krishna,  Since the iwcm struct/state is still correctly being
> manipulated under the lock, then I think it this patch correct.  Test
> the heck out of it. :)
> 
> Steve.
