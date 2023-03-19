Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F46C013F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCSMCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSMCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 08:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CCD1B322
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 05:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F80C61010
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 12:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539ADC433EF;
        Sun, 19 Mar 2023 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679227339;
        bh=jIGA5EpNi3zGXy7PG9vh6adv0/MzNRJdB6g9PAaywuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEAVA4JyA5hQRShxBUKFb0bbtbefIST7W36RKmp4RDIq7dE6AgXRa8x/XaSJXXrtU
         w3FqFdUpHAs06Vmcm3q6MIuwA6Xv8wR/VlcWFOt8BRSZCkUbKuNiodp6umDMP85vIB
         6bzMNacMqVYm6WQigBJPohEp26/3u0VZp3niV1GjHnOWpnbi+jfvd+BX6gBizb6Ld3
         5L+YlnsbTpGKw3yX6oBOxKFU8kq3Q1nowIQYofOlcdy7ehJt7R2bsMThe2/ZV3ukmQ
         vTYAsKd7u6WHTza17p1l3cXDpef4ZFlYe2BNR13KfVUe1M1cK9RBnrBs6+A6G9e0vV
         1N9hkWeD9vb9Q==
Date:   Sun, 19 Mar 2023 14:02:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
Message-ID: <20230319120215.GD36557@unreal>
References: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
 <2b1e2cd5-4843-b1d9-5ac0-60eefc57d26e@huawei.com>
 <CA+sbYW1TnOwr9EBWfWH76p=KQ6T2naGCYwufoU4j7yfNu9pY2w@mail.gmail.com>
 <0ce9c4fc-c6c7-28e3-7742-cf58782ff7fd@huawei.com>
 <CA+sbYW3tr_NT8daJ6qyLS-7=_2TXDo69HNtbOpzqg=jhvFczCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW3tr_NT8daJ6qyLS-7=_2TXDo69HNtbOpzqg=jhvFczCw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 19, 2023 at 07:37:45AM +0530, Selvin Xavier wrote:
> On Fri, Mar 17, 2023 at 5:53 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >
> > On 2023/3/17 18:17, Selvin Xavier wrote:
> > > On Fri, Mar 17, 2023 at 2:40 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
> > >>
> > >> On 2023/3/15 16:16, Selvin Xavier wrote:
> > >>> Add resize_cq verb support for user space CQs. Resize operation for
> > >>> kernel CQs are not supported now.
> > >>>
> > >>> Driver should free the current CQ only after user library polls
> > >>> for all the completions and switch to new CQ. So after the resize_cq
> > >>> is returned from the driver, user libray polls for existing completions
> > >>
> > >> libray -> library
> > >>
> > >>> and store it as temporary data. Once library reaps all completions in the
> > >>> current CQ, it invokes the ibv_cmd_poll_cq to inform the driver about
> > >>> the resize_cq completion. Adding a check for user CQs in driver's
> > >>> poll_cq and complete the resize operation for user CQs.
> > >>> Updating uverbs_cmd_mask with poll_cq to support this.
> > >>>
> > >>> User library changes are available in this pull request.
> > >>> https://github.com/linux-rdma/rdma-core/pull/1315
> > >>>
> > >>> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > >>> ---
> > >>>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 109 +++++++++++++++++++++++++++++++
> > >>>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
> > >>>  drivers/infiniband/hw/bnxt_re/main.c     |   2 +
> > >>>  drivers/infiniband/hw/bnxt_re/qplib_fp.c |  44 +++++++++++++
> > >>>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |   5 ++
> > >>>  include/uapi/rdma/bnxt_re-abi.h          |   4 ++
> > >>>  6 files changed, 167 insertions(+)
> > >>>
> > >>> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > >>> index 989edc7..e86afec 100644
> > >>> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > >>> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > >>> @@ -2912,6 +2912,106 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > >>>       return rc;
> > >>>  }
> > >>>
> > >>> +static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> > >>> +{
> > >>> +     struct bnxt_re_dev *rdev = cq->rdev;
> > >>> +
> > >>> +     bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> > >>> +
> > >>> +     cq->qplib_cq.max_wqe = cq->resize_cqe;
> > >>> +     if (cq->resize_umem) {
> > >>> +             ib_umem_release(cq->umem);
> > >>> +             cq->umem = cq->resize_umem;
> > >>> +             cq->resize_umem = NULL;
> > >>> +             cq->resize_cqe = 0;
> > >>> +     }
> > >>> +}
> > >>> +
> > >>> +int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
> > >>> +{
> > >>> +     struct bnxt_qplib_sg_info sg_info = {};
> > >>> +     struct bnxt_qplib_dpi *orig_dpi = NULL;
> > >>> +     struct bnxt_qplib_dev_attr *dev_attr;
> > >>> +     struct bnxt_re_ucontext *uctx = NULL;
> > >>> +     struct bnxt_re_resize_cq_req req;
> > >>> +     struct bnxt_re_dev *rdev;
> > >>> +     struct bnxt_re_cq *cq;
> > >>> +     int rc, entries;
> > >>> +
> > >>> +     cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
> > >>> +     rdev = cq->rdev;
> > >>> +     dev_attr = &rdev->dev_attr;
> > >>> +     if (!ibcq->uobject) {
> > >>> +             ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
> > >>> +             return -EOPNOTSUPP;
> > >>> +     }
> > >>> +
> > >>> +     if (cq->resize_umem) {
> > >>> +             ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Busy",
> > >>> +                       cq->qplib_cq.id);
> > >>> +             return -EBUSY;
> > >>> +     }
> > >>
> > >> Does above cq->resize_umem checking has any conconcurrent protection
> > >> again the bnxt_re_resize_cq_complete() called by bnxt_re_poll_cq()?
> > >>
> > >> bnxt_re_resize_cq() seems like a control path operation, while
> > >> bnxt_re_poll_cq() seems like a data path operation, I am not sure
> > >> there is any conconcurrent protection between them.
> > >>
> > > The previous check is to prevent simultaneous  resize_cq context from
> > > the user application.
> > >
> > >  if you see the library implementation (PR
> > > https://github.com/linux-rdma/rdma-core/pull/1315), entire operation
> > > is done in the single resize_cq context from application
> > > i.e.
> > > bnxt_re_resize_cq
> > >  -> ibv_cmd_resize_cq
> > >                   call driver bnxt_re_resize_cq and return
> > >   -> poll out the current completions and store it in a user lib list
> > >   -> issue an ibv_cmd_poll_cq.
> > >         This will invoke bnxt_re_poll_cq in the kernel driver. We free
> > > the previous cq resources.
> > >
> > > So the synchronization between resize_cq and poll_cq is happening in
> > > the user lib. We can free the old CQ  only after user land sees the
> > > final Completion on the previous CQ. So we return from the driver's
> > > bnxt_re_resize_cq and then poll for all completions and then use
> > > ibv_cmd_poll_cq as a hook to reach the kernel driver and free the old
> > > CQ's resource.
> > >
> > > Summarize, driver's bnxt_re_poll_cq for user space CQs will be called
> > > only from resize_cq context and no concurrent protection required in
> > > the driver.
> >
> > Is it acceptable to depend on the user space code to ensure the correct
> > order in the kernel space?
> > Isn't that may utilized by some malicious user to crash the kernel?
> >
> The user space code I mentioned is implemented in the provider/bnxt_re
> user library just
> like any other verb interface. Apps shall always go through this
> library to send request
> to the provider driver.

And if I use my own version of provider/bnxt_re, will kernel crash?

Thanks
