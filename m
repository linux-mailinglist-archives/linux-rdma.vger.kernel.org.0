Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB13D1F2C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGVHC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 03:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhGVHC2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 03:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CB9761279;
        Thu, 22 Jul 2021 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626939784;
        bh=7CLwe+Pn1j0AYUmByA/Pt1nJ8d0kwQnH3tJ5uIRi9fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6iSe97Tc0T0ZXeYBLa2ZECwLYWkFrhQy7rJzsD5v8+toov0WT3FhQEAW1DWY/bVs
         b2MLp1vvFrLhkw9EvjpgfnX1sA97kNI2P/gN8DgrDACHnDQEd7yu7h+VbQ7zeJUZKg
         ArHsft6vR+ELH25yUmkKgkBs6Lqnd3RcaX0fs1wcvL2WXDBdgoslJDwzhZhqr+u99I
         0XJi78FsA46/AIWsN85XGeBZi+gyTWGOROc9KzXjbPMca1JLB5mvQwtvjEuoe5GoNP
         huyPFC5BFmXj5mz2yCQ9eP3F17EUHHrJFqTsD63aquvhwgYBPHDsahbEBza69KAOYd
         PmUd50cJI8pFA==
Date:   Thu, 22 Jul 2021 10:43:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <YPkhhDkvYY2JVM+6@unreal>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 04:51:55PM +0530, Dakshaja Uppalapati wrote:
> Previous atomic increment decrement logic expects the atomic count
> to be '0' after the final decrement. Replacing atomic count with
> refcount does not allow that as refcount_dec() considers count of 1 as
> underflow. Therefore fix the current refcount logic by decrementing
> the refcount if one on the final deref in c4iw_destroy_cq().
> 
> Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
> Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)


Thanks, 
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

We have plenty of such errors, worth to check them:
➜  kernel git:(rdma-next) git grep refcount_read drivers/infiniband/ | grep -v WARN_ON
drivers/infiniband/core/device.c:	if (!refcount_read(&ib_dev->refcount))
drivers/infiniband/core/device.c:	if (refcount_read(&device->refcount) == 0 ||
drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
drivers/infiniband/core/iwpm_util.c:	if (!refcount_read(&iwpm_admin.refcount)) {
drivers/infiniband/core/ucma.c:	if (refcount_read(&ctx->ref))
drivers/infiniband/hw/cxgb4/cq.c:	wait_event(chp->wait, !refcount_read(&chp->refcnt));
drivers/infiniband/hw/irdma/utils.c:			   refcount_read(&cqp_request->refcnt) == 1, 1000);
drivers/infiniband/hw/mlx5/mlx5_ib.h:	wait_event(mmkey->wait, refcount_read(&mmkey->usecount) == 0);
drivers/infiniband/hw/mlx5/mr.c:	    refcount_read(&mr->mmkey.usecount) != 0 &&
