Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A42E26C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Qmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 12:42:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36426 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Qmd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 12:42:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so3415781qth.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KmaUB/aPhU+wQgyfmgQ5xH9ZFN5Jp1mw8HcvaL7NVhA=;
        b=MEj7oAeYPvP5LRsBAOCm+pLnJrAE28jEBrTLmB0QMu60IJTTQhWv6HnL840rStQUGC
         Z51Pqe0/JvPOb1TbJfBpABBxPczVzs+6fTs8IvqX5I5xAd/gNLqXyXvS+O04Bn31mCJH
         9uSyIUfJP9cRAjWROynmIcRwuFhzihlbWrxNTqRqwpObp2GqiWDBtP7qrDG1La3kaxqV
         YDKTKau+DHMN7829x1VEkzHeAtvXl3+cGTQS5SgqpVDiSTE0UOVI3fI8Zy5tn8ZBB7qn
         +uFbH09w7P3gz6Bsee1VPujfB3TJxd3Z6lx3kvkEULBpKzJjOrxWlep4e48Z42QQryu2
         298w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KmaUB/aPhU+wQgyfmgQ5xH9ZFN5Jp1mw8HcvaL7NVhA=;
        b=pV6uPJMt05vZN5H9EYWyDliAfnV01UOvkefhgnoTa9DZqpY5oASywJQ1VWGZWVyGZx
         YfLnu/KxN4efx0Ug23HEQfC1rt+hxxxZZpAShxhRxCvMQ6iRnAFRvbrh7SYXeHdQXBMZ
         /N5vF2X5y/9/jWzZhEXc2zLPJQMBxh7udash3TYF0OvC/NQX6dQf02zk8fDPxPdxPNf2
         Wm3Y3AlHaUYcWmf10Yn+kZONWdEFnwlGVcj7uP2GU9AufhnJIUcFfjo7GmsA7+KdP1K6
         W5FggD2eGLXlnhVhfTiLBOvM0llzpguJUCSMCzxXfSdQ5sOE7w7ZgBs9akdvtIS2ZjS3
         ykAA==
X-Gm-Message-State: APjAAAV85hYp0PoyrcmcAV+k2RSXstcij7eBuMXXZasTMxdwS7ZZGDqE
        oWOEUFGTmueaflvVRrmgon4EfQ==
X-Google-Smtp-Source: APXvYqwB4atNCpn79hHl523UhgGpghfDOndnBTZG2JP7S+TYLSTXLKUbtRxOakeZoJuonzgmEIy2Dw==
X-Received: by 2002:ac8:2cf4:: with SMTP id 49mr23135312qtx.66.1559148152017;
        Wed, 29 May 2019 09:42:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p37sm1003824qtc.35.2019.05.29.09.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:42:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hW1ep-00058O-2M; Wed, 29 May 2019 13:42:31 -0300
Date:   Wed, 29 May 2019 13:42:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190529164231.GA19540@ziepe.ca>
References: <20190529125132.6471-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529125132.6471-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 03:51:32PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> passed later in post_recv and post_send operations.
> 
> On a virtualized environment this is not correct.
> 
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> 
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
> Fix it by introducing a new API function that accepts an address from
> guest virtual address space as well to be used as offset for later
> datapath operations.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> v0 -> v1: 
> 	* Change reg_mr callback signature instead of adding new callback
> 	* Add the new API to libibverbs/libibverbs.map.in
> v1 -> v2: 
> 	* Do not modify reg_mr signature for version 1.0 
> 	* Add note to man page
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
>  providers/hfi1verbs/hfiverbs.h    |  4 ++--
>  providers/hfi1verbs/verbs.c       |  8 ++++----
>  providers/hns/hns_roce_u.h        |  2 +-
>  providers/hns/hns_roce_u_verbs.c  |  6 +++---
>  providers/i40iw/i40iw_umain.h     |  2 +-
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
>  providers/nes/nes_umain.h         |  2 +-
>  providers/nes/nes_uverbs.c        |  9 ++++-----
>  providers/ocrdma/ocrdma_main.h    |  2 +-
>  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
>  providers/qedr/qelr_main.h        |  2 +-
>  providers/qedr/qelr_verbs.c       | 11 ++++-------
>  providers/qedr/qelr_verbs.h       |  4 ++--
>  providers/rxe/rxe.c               |  6 +++---
>  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
>  providers/vmw_pvrdma/verbs.c      |  7 +++----
>  37 files changed, 126 insertions(+), 92 deletions(-)
> 
> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index e4d624b2..ef27259a 100644
> +++ b/libibverbs/driver.h
> @@ -338,7 +338,7 @@ struct verbs_context_ops {
>  				    uint64_t dm_offset, size_t length,
>  				    unsigned int access);
>  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
> -				 int access);
> +				 uint64_t hca_va, int access);
>  	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
>  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
>  			void *addr, size_t length, int access);
> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> index c861c3a0..61a8fbdf 100644
> +++ b/libibverbs/dummy_ops.c
> @@ -410,7 +410,7 @@ static struct ibv_mr *reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *dm,
>  }
>  
>  static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
> -			     int access)
> +			     uint64_t hca_va,  int access)
>  {
>  	errno = ENOSYS;
>  	return NULL;
> diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
> index 87a1b9fc..523fd424 100644
> +++ b/libibverbs/libibverbs.map.in
> @@ -94,6 +94,7 @@ IBVERBS_1.1 {
>  		ibv_query_srq;
>  		ibv_rate_to_mbps;
>  		ibv_reg_mr;
> +		ibv_reg_mr_virt_as;
>  		ibv_register_driver;
>  		ibv_rereg_mr;
>  		ibv_resize_cq;
> diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
> index 631e5fe8..983b5761 100644
> +++ b/libibverbs/man/ibv_reg_mr.3
> @@ -3,7 +3,7 @@
>  .\"
>  .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
>  .SH "NAME"
> -ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
> +ibv_reg_mr, ibv_reg_mr_virt_as, ibv_dereg_mr \- register or deregister a memory region (MR)
>  .SH "SYNOPSIS"
>  .nf
>  .B #include <infiniband/verbs.h>
> @@ -11,6 +11,10 @@ ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
>  .BI "struct ibv_mr *ibv_reg_mr(struct ibv_pd " "*pd" ", void " "*addr" ,
>  .BI "                          size_t " "length" ", int " "access" );
>  .sp
> +.BI "struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd " "*pd" ", void " "*addr" ,
> +.BI "                                  size_t " "length" ", uint64_t " "hca_va" ,
> +.BI "                                  int " "access" );
> +.sp
>  .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
>  .fi
>  .SH "DESCRIPTION"
> @@ -52,11 +56,18 @@ Local read access is always enabled for the MR.
>  .PP
>  To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND should be set, addr should be 0 and length should be SIZE_MAX.
>  .PP
> +.B ibv_reg_mr_virt_as()
> +Special variant of memory registration used when addresses passed to
> +ibv_post_send and ibv_post_recv are relative to base address from a
> +different address space than
> +.I addr\fR. The argument
> +.I hca_va\fR is the new base address.
> +.PP

This should also block ACCESS_ZERO_BASED for mr_virt_as as ZERO_BASED
is really just hca_va == 0

In fact, I might be inclined to re-implement ZERO_BASED in rdma-core
as just passing hca_va == 0 which would make it work on all drivers
instead of the stupid implementation we have today..

Also, not totally sold on the 'ibv_reg_mr_virt_as' for the
name.. 

How about 'ibv_reg_mr_iova'? And let us call hca_va iova in the public
interface. I think that is an existing convention.

Jason
