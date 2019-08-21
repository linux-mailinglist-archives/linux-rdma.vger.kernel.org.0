Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB31C987F4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfHUXhj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 19:37:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:37641 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfHUXhj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 19:37:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 16:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,414,1559545200"; 
   d="scan'208";a="172936554"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2019 16:37:37 -0700
Date:   Wed, 21 Aug 2019 16:37:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> Following patch-set introduce the shared object feature.
> 
> A shared object feature allows one process to create HW objects (currently
> PD and MR) so that a second process can import.

For something this fundamental I think the cover letter should be more
detailed than this.  Questions I have without digging into the code:

What is the use case?

What is the "key" that allows a MR to be shared among 2 processes?  Do you
introduce some PD identifier?  And then some {PDID, lkey} tuple is used to ID
the MR?

I assume you have to share the PD first and then any MR in the shared PD can be
shared?  If so how does the MR get shared?

Again I'm concerned with how this will interact with the RDMA and file system
interaction we have been trying to fix.

Why is SCM_RIGHTS on the rdma context FD not sufficient to share the entire
context, PD, and all MR's?

Ira

> 
> Patch-set is logically splits to 4 parts as the following:
> - patches 1 to 7 and 18 are preparation steps.
> - patches 8 to 14 are the implementation of import PD
> - patches 15 to 17 are the implementation of the verb
> - patches 19 to 24 are the implementation of import MR
> 
> v0 -> v1:
> 	* Delete the patch "IB/uverbs: ufile must be freed only when not
> 	  used anymore". The process can die, the ucontext remains until
> 	  last reference to it is closed.
> 	* Rebase to latest for-next branch
> 
> Shamir Rabinovitch (16):
>   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
>   RDMA/uverbs: Delete the macro uobj_put_obj_read
>   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
>   IB/{core,hw}: ib_pd should not have ib_uobject pointer
>   IB/core: ib_uobject need HW object reference count
>   IB/uverbs: Helper function to initialize ufile member of
>     uverbs_attr_bundle
>   IB/uverbs: Add context import lock/unlock helper
>   IB/verbs: Prototype of HW object clone callback
>   IB/mlx4: Add implementation of clone_pd callback
>   IB/mlx5: Add implementation of clone_pd callback
>   RDMA/rxe: Add implementation of clone_pd callback
>   IB/uverbs: Add clone reference counting to ib_pd
>   IB/uverbs: Add PD import verb
>   IB/mlx4: Enable import from FD verb
>   IB/mlx5: Enable import from FD verb
>   RDMA/rxe: Enable import from FD verb
> 
> Yuval Shaia (8):
>   IB/core: Install clone ib_pd in device ops
>   IB/core: ib_mr should not have ib_uobject pointer
>   IB/core: Install clone ib_mr in device ops
>   IB/mlx4: Add implementation of clone_pd callback
>   IB/mlx5: Add implementation of clone_pd callback
>   RDMA/rxe: Add implementation of clone_pd callback
>   IB/uverbs: Add clone reference counting to ib_mr
>   IB/uverbs: Add MR import verb
> 
>  drivers/infiniband/core/device.c              |   2 +
>  drivers/infiniband/core/nldev.c               | 127 ++++-
>  drivers/infiniband/core/rdma_core.c           |  23 +-
>  drivers/infiniband/core/uverbs.h              |   2 +
>  drivers/infiniband/core/uverbs_cmd.c          | 489 +++++++++++++++---
>  drivers/infiniband/core/uverbs_main.c         |   1 +
>  drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
>  drivers/infiniband/core/verbs.c               |   4 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
>  drivers/infiniband/hw/mlx4/main.c             |  18 +-
>  drivers/infiniband/hw/mlx5/main.c             |  34 +-
>  drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
>  include/rdma/ib_verbs.h                       |  43 +-
>  include/rdma/uverbs_std_types.h               |  11 +-
>  include/uapi/rdma/ib_user_verbs.h             |  15 +
>  include/uapi/rdma/rdma_netlink.h              |   3 +
>  17 files changed, 669 insertions(+), 113 deletions(-)
> 
> -- 
> 2.20.1
> 
