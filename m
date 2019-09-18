Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA1B64EE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfIRNoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 09:44:00 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:22993 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfIRNoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 09:44:00 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8IDhQHe002100;
        Wed, 18 Sep 2019 06:43:27 -0700
Date:   Wed, 18 Sep 2019 19:13:25 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Steve Wise <larrystevenwise@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
Message-ID: <20190918134324.GA5734@chelsio.com>
References: <20190916162829.GA22329@ziepe.ca>
 <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
 <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
 <55ece255-b4e2-9bc4-e1ec-039d92a36273@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ece255-b4e2-9bc4-e1ec-039d92a36273@grimberg.me>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, September 09/17/19, 2019 at 22:50:27 +0530, Sagi Grimberg wrote:
> 
> >> To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >> From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> Date: 09/16/2019 06:28PM
> >> Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
> >> <BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
> >> "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
> >> Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
> >> disabled lock on iw_rem_ref
> >>
> >> On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
> >> wrote:
> >>> Hi Steve & Bernard,
> >>>
> >>> Thanks for the review comments.
> >>> I will do those formating changes.
> >>
> >> I don't see anything in patchworks, but the consensus is to drop
> >> Sagi's patch pending this future patch?
> >>
> >> Jason
> >>
> > This is my impression as well. But consensus should be
> > explicit...Sagi, what do you think?
> 
> I don't really care, but given the changes from Krishnamraju cause other
> problems I'd ask if my version is also offending his test.
Hi Sagi,
Your version holds good for rdma_destroy_id() path only, but there are
other places where iw_rem_ref() is being called within spinlocks, here is
the call trace when iw_rem_ref() is called in cm_close_handler() path:
[  627.716339] Call Trace:
[  627.716339]  ? load_new_mm_cr3+0xc0/0xc0
[  627.716339]  on_each_cpu+0x23/0x40
[  627.716339]  flush_tlb_kernel_range+0x74/0x80
[  627.716340]  free_unmap_vmap_area+0x2a/0x40
[  627.716340]  remove_vm_area+0x59/0x60
[  627.716340]  __vunmap+0x46/0x210
[  627.716340]  siw_free_qp+0x88/0x120 [siw]
[  627.716340]  cm_work_handler+0x5b8/0xd00  <=====
[  627.716340]  process_one_work+0x155/0x380
[  627.716341]  worker_thread+0x41/0x3b0
[  627.716341]  kthread+0xf3/0x130
[  627.716341]  ? process_one_work+0x380/0x380
[  627.716341]  ? kthread_bind+0x10/0x10
[  627.716341]  ret_from_fork+0x35/0x40

Hence, I moved all the occurances of iw_rem_ref() outside of spinlocks
critical section.
> 
> In general, I do not think that making resources free routines (both
> explict or implicit via ref dec) under a spinlock is not a robust
> design.
> 
> I would first make it clear and documented what cm_id_priv->lock is
> protecting. In my mind, it should protect *its own* mutations of
> cm_id_priv and by design leave all the ops calls outside the lock.
> 
> I don't understand what is causing the Chelsio issue observed, but
> it looks like c4iw_destroy_qp blocks on a completion that depends on a
> refcount that is taken also by iwcm, which means that I cannot call
> ib_destroy_qp if the cm is not destroyed as well?
> 
> If that is madatory, I'd say that instead of blocking on this
> completion, we can simply convert c4iw_qp_rem_ref if use a kref
> which is not order dependent.

I agree,
I'm exploring best possible ways to address this issue, will update my
final resolution by this Friday.
