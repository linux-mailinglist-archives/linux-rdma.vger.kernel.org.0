Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2953D23F2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhGVMRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 08:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhGVMRI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 08:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD57561396;
        Thu, 22 Jul 2021 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958663;
        bh=op21PSd7a+zxoOAwIL7hqqybPQ9/uMct2oZ5oplp9S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eV4gFZL0XReGXoY0pijFDWXMSzFoilReWQkuUpbNlYRe//nVkFjfS4QpfyuB6zwgr
         EDgOxKuQZ4gtKUfWDDY4qh+qynoFblb4m0CxZC+rj/de0uFGKWrXMxnO+D29HffTlz
         KkNbc9b7rPH2FWf2dJLjVdcQn7qBWEYw85UfYJP5d6ML++3sexl2Ie4Pvwohwt5m0e
         DKJ3P/QkM+cx7xs+Y0KfE3odM4ZKhhmDuAaEg5sw+spajia9rWzwe2TTNxp9HBAnco
         fL7tb2KJiFgUzmANLOw9MvNgt3w8+Zn45YTcrOHpzUamzyE5lxX82HuFVnYeJKuUg/
         jECNOhXOpkfdw==
Date:   Thu, 22 Jul 2021 15:57:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dakshaja Uppalapati <dakshaja@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <YPlrQ1Uu+OXxRJBF@unreal>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210722120607.GE1117491@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 09:06:07AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 22, 2021 at 10:43:00AM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 21, 2021 at 04:51:55PM +0530, Dakshaja Uppalapati wrote:
> > > Previous atomic increment decrement logic expects the atomic count
> > > to be '0' after the final decrement. Replacing atomic count with
> > > refcount does not allow that as refcount_dec() considers count of 1 as
> > > underflow. Therefore fix the current refcount logic by decrementing
> > > the refcount if one on the final deref in c4iw_destroy_cq().
> > > 
> > > Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
> > > Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> > > Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > >  drivers/infiniband/hw/cxgb4/cq.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > 
> > Thanks, 
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > We have plenty of such errors, worth to check them:
> > ➜  kernel git:(rdma-next) git grep refcount_read drivers/infiniband/ | grep -v WARN_ON
> > drivers/infiniband/core/device.c:	if (!refcount_read(&ib_dev->refcount))
> > drivers/infiniband/core/device.c:	if (refcount_read(&device->refcount) == 0 ||
> > drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
> > drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
> > drivers/infiniband/core/ucma.c:	if (refcount_read(&ctx->ref))
> > drivers/infiniband/hw/cxgb4/cq.c:	wait_event(chp->wait, !refcount_read(&chp->refcnt));
> > drivers/infiniband/hw/irdma/utils.c:			   refcount_read(&cqp_request->refcnt) == 1, 1000);
> > drivers/infiniband/hw/mlx5/mlx5_ib.h:	wait_event(mmkey->wait, refcount_read(&mmkey->usecount) == 0);
> > drivers/infiniband/hw/mlx5/mr.c:	    refcount_read(&mr->mmkey.usecount) != 0 &&
> 
> It isn't the read that is the problem, it is the naked dec.
> 
> This common pattern is just being done in an obtuse and arguably wrong
> way
> 
> It is supposed to look like this:
> 
> void ib_device_put(struct ib_device *device)
> {
>         if (refcount_dec_and_test(&device->refcount))
>                 complete(&device->unreg_completion);
> }
> 
> [..]
> 
>         ib_device_put(device);
>         wait_for_completion(&device->unreg_completion);
> 
> 
> Not use refcount_read() and a naked work queue
> 
> So I'd say these ones should be looked at:
> 
> drivers/infiniband/hw/cxgb4/cq.c:       refcount_dec(&chp->refcnt);
> drivers/infiniband/hw/hns/hns_roce_db.c:        refcount_dec(&db->u.user_page->refcount);
> drivers/infiniband/hw/irdma/cm.c:       refcount_dec(&cm_node->refcnt);
> drivers/infiniband/hw/irdma/cm.c:               refcount_dec(&listener->refcnt);
> drivers/infiniband/hw/irdma/cm.c:                       refcount_dec(&listener->refcnt);

Jason,

We are talking about two different issues that this refcount_read patch pointed.
You are focused on wrong usage of completion, I saw useless compare of
refcount_t with 0 that can't be.

I prepared series that cleans iwpm from this type of error:
 drivers/infiniband/core/iwpm_util.c:        if (!refcount_read(&iwpm_admin.refcount)) {
 drivers/infiniband/core/iwpm_util.c:        if (!refcount_read(&iwpm_admin.refcount)) {

Thanks

> 
> Jason
