Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0910339BD7
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFHIcl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfFHIck (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 04:32:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333DD2146E;
        Sat,  8 Jun 2019 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559982759;
        bh=QGQzCk2vBNE4/uGKx1pWrabpGly4Lrgp4w003Zb5hqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfXCgnX94NNiiqpBLhwKBlImpvXTiOMKC3bMQmRZMMzS4JsmRtg7Fs2Bc+5MlAIDk
         GCAtf7OpY0mAboTRI9EPrVe+O8+zXTJzKMA/Eqp+Gy7/qLnVZVUyDdnbs6tru3po8n
         /Oj2DJkh0j+EV6KQDhIHYSPDY+gjvcYja1yrkwiI=
Date:   Sat, 8 Jun 2019 11:32:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v4 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190608083224.GS5261@mtr-leonro.mtl.com>
References: <20190606100511.4489-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606100511.4489-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 01:05:11PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> passed later in post_recv and post_send operations.
>
> On some virtualized environment this is not correct.
>
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
> This datapath interference affects performances.
>
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
>
> Fix it by introducing a new API function which accepts an address from
> guest virtual address space as well, to be used as offset for later
> datapath operations.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
> v0 -> v1:
> 	* Change reg_mr callback signature instead of adding new callback
> 	* Add the new API to libibverbs/libibverbs.map.in
> v1 -> v2:
> 	* Do not modify reg_mr signature for version 1.0
> 	* Add note to man page
> v2 -> v3:
> 	* Rename function to reg_mr_iova (and arg-name to iova)
> 	* Some checkpatch issues not related to this fix but detected now
> 		* s/__FUNCTION__/__func
> 		* WARNING: function definition argument 'void *' should
> 		 also have an identifier name
> v3 -> v4:
> 	* Fix commit message as suggested by Adit Ranadiv
> 	* Add support for efa
> ---
>  libibverbs/driver.h               |  2 +-
>  libibverbs/dummy_ops.c            |  2 +-
>  libibverbs/libibverbs.map.in      |  1 +
>  libibverbs/man/ibv_reg_mr.3       | 15 +++++++++++++--
>  libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
>  libibverbs/verbs.h                |  7 +++++++
>  providers/bnxt_re/verbs.c         |  6 +++---
>  providers/bnxt_re/verbs.h         |  2 +-
>  providers/cxgb3/iwch.h            |  4 ++--
>  providers/cxgb3/verbs.c           |  9 +++++----
>  providers/cxgb4/libcxgb4.h        |  4 ++--
>  providers/cxgb4/verbs.c           |  9 +++++----
>  providers/efa/verbs.c             |  4 ++--
>  providers/efa/verbs.h             |  2 +-
>  providers/hfi1verbs/hfiverbs.h    |  4 ++--
>  providers/hfi1verbs/verbs.c       |  8 ++++----
>  providers/hns/hns_roce_u.h        |  2 +-
>  providers/hns/hns_roce_u_verbs.c  |  6 +++---
>  providers/i40iw/i40iw_umain.h     |  3 ++-
>  providers/i40iw/i40iw_uverbs.c    |  8 ++++----
>  providers/ipathverbs/ipathverbs.h |  4 ++--
>  providers/ipathverbs/verbs.c      |  8 ++++----
>  providers/mlx4/mlx4.h             |  4 ++--
>  providers/mlx4/verbs.c            |  7 +++----
>  providers/mlx5/mlx5.h             |  4 ++--
>  providers/mlx5/verbs.c            |  7 +++----
>  providers/mthca/ah.c              |  3 ++-
>  providers/mthca/mthca.h           |  4 ++--
>  providers/mthca/verbs.c           |  6 +++---
>  providers/nes/nes_umain.h         |  3 ++-
>  providers/nes/nes_uverbs.c        |  9 ++++-----
>  providers/ocrdma/ocrdma_main.h    |  4 ++--
>  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
>  providers/qedr/qelr_main.h        |  4 ++--
>  providers/qedr/qelr_verbs.c       | 11 ++++-------
>  providers/qedr/qelr_verbs.h       |  4 ++--
>  providers/rxe/rxe.c               |  6 +++---
>  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
>  providers/vmw_pvrdma/verbs.c      |  7 +++----
>  39 files changed, 133 insertions(+), 97 deletions(-)

You need to bump PABI in main CmakeList.txt file, otherwise "old
providers" won't work with new libibverbs.

Also I don't see any changes in debian/ folder, which is not right too.

Thanks
