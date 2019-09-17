Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15AB4E60
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfIQMrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 08:47:55 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:7504 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfIQMrz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 08:47:55 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8HClLeg026576;
        Tue, 17 Sep 2019 05:47:22 -0700
Date:   Tue, 17 Sep 2019 18:17:20 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Steve Wise <larrystevenwise@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on
 iw_rem_ref
Message-ID: <20190917124719.GA11070@chelsio.com>
References: <20190916162829.GA22329@ziepe.ca>
 <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
 <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, September 09/17/19, 2019 at 14:34:24 +0530, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
> 
> >To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 09/16/2019 06:28PM
> >Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
> ><BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
> >"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
> >Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
> >disabled lock on iw_rem_ref
> >
> >On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
> >wrote:
> >> Hi Steve & Bernard,
> >> 
> >> Thanks for the review comments.
> >> I will do those formating changes.
> >
> >I don't see anything in patchworks, but the consensus is to drop
> >Sagi's patch pending this future patch?
> >
> >Jason
> >
> This is my impression as well. But consensus should be
> explicit...Sagi, what do you think?
> 
> Best regards,
> Bernard.
> 
While testing iSER(with my proposed patch applied) I see Chelsio iwarp
driver is hitting the below deadlock issue. This is due to iw_rem_ref
reordering changes in IWCM.

Bernard, how about replacing vmalloc/vfree with kmalloc/kfree,
such that freeing of SIW qp resources can be done with spinlocks held?
to fix the orginal vfree issue less invasively..

Steve, any suggestions?


[ 1230.161871] INFO: task kworker/u12:0:11291 blocked for more than 122
seconds.
[ 1230.162147]       Not tainted 5.3.0-rc5+ #19
[ 1230.162417] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1230.162911] kworker/u12:0   D13000 11291      2 0x80004080
[ 1230.163186] Workqueue: iw_cm_wq cm_work_handler
[ 1230.163456] Call Trace:
[ 1230.163718]  ? __schedule+0x297/0x510
[ 1230.163986]  schedule+0x2e/0x90
[ 1230.164253]  schedule_timeout+0x1c0/0x280
[ 1230.164520]  ? xas_store+0x23e/0x500
[ 1230.164789]  wait_for_completion+0xa2/0x110
[ 1230.165067]  ? wake_up_q+0x70/0x70
[ 1230.165336]  c4iw_destroy_qp+0x141/0x260 [iw_cxgb4]
[ 1230.165611]  ? xas_store+0x23e/0x500
[ 1230.165893]  ? _cond_resched+0x10/0x20
[ 1230.166160]  ? wait_for_completion+0x2e/0x110
[ 1230.166432]  ib_destroy_qp_user+0x142/0x230
[ 1230.166699]  rdma_destroy_qp+0x1f/0x40
[ 1230.166966]  iser_free_ib_conn_res+0x52/0x190 [ib_iser]
[ 1230.167241]  iser_cleanup_handler.isra.15+0x32/0x60 [ib_iser]
[ 1230.167510]  iser_cma_handler+0x23b/0x730 [ib_iser]
[ 1230.167776]  cma_iw_handler+0x154/0x1e0
[ 1230.168037]  cm_work_handler+0xb4c/0xd60
[ 1230.168302]  process_one_work+0x155/0x380
[ 1230.168564]  worker_thread+0x41/0x3b0
[ 1230.168827]  kthread+0xf3/0x130
[ 1230.169086]  ? process_one_work+0x380/0x380
[ 1230.169350]  ? kthread_bind+0x10/0x10
[ 1230.169615]  ret_from_fork+0x35/0x40
[ 1230.169885] NMI backtrace for cpu 3

