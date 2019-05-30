Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB32F71D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE3Fgp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 01:36:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Fgp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 01:36:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U5XQIA129429;
        Thu, 30 May 2019 05:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6LcyLarL54USQpkmaihJ3/MC0JhALtKM641a7vuD2ZI=;
 b=PTB911N6bUGojKjdvaSornK6efCSeFyfgwvMCKVoEMGZ61azyq5xo8nTuMrjmQqD5gp6
 nVyr8dQNKzHn7q/kfhMKQDRMNSCWDJXl81jkM4t50LPkVNlsitsahLHq6SWC7iz93UEr
 s9q/ncTwswgEg+eTvkV9BCa8XC1zC/bxRjnGb4tttP8/z3XX1ibSg+3+ecSh0a9idZwq
 gLM07Mlotw6xPAyFr5FohFrzokjKLGbFpaXOFUQFoThnW7MtNFhXDzbZtyLxR3R8H0Eq
 rDeb7yBMDC7GB7FjGi7W0P36qSAass86MLKB73XsAGqRahaEjvEEXSSUq8h1OazPRRNs Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbqdrnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 05:36:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U5ZNL6144879;
        Thu, 30 May 2019 05:36:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fnv7dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 05:36:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U5a8M9007135;
        Thu, 30 May 2019 05:36:08 GMT
Received: from lap1 (/10.175.33.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 22:36:07 -0700
Date:   Thu, 30 May 2019 08:36:02 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190530053601.GA2635@lap1>
References: <20190529125132.6471-1-yuval.shaia@oracle.com>
 <20190529164231.GA19540@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529164231.GA19540@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300042
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 01:42:31PM -0300, Jason Gunthorpe wrote:
> On Wed, May 29, 2019 at 03:51:32PM +0300, Yuval Shaia wrote:
> > The virtual address that is registered is used as a base for any address
> > passed later in post_recv and post_send operations.
> > 
> > On a virtualized environment this is not correct.
> > 
> > A guest cannot register its memory so hypervisor maps the guest physical
> > address to a host virtual address and register it with the HW. Later on,
> > at datapath phase, the guest fills the SGEs with addresses from its
> > address space.
> > 
> > Since HW cannot access guest virtual address space an extra translation
> > is needed to map those addresses to be based on the host virtual address
> > that was registered with the HW.
> > This datapath interference affects performances.
> > 
> > To avoid this, a logical separation between the address that is
> > registered and the address that is used as a offset at datapath phase is
> > needed.
> > This separation is already implemented in the lower layer part
> > (ibv_cmd_reg_mr) but blocked at the API level.
> > 
> > Fix it by introducing a new API function that accepts an address from
> > guest virtual address space as well to be used as offset for later
> > datapath operations.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > v0 -> v1: 
> > 	* Change reg_mr callback signature instead of adding new callback
> > 	* Add the new API to libibverbs/libibverbs.map.in
> > v1 -> v2: 
> > 	* Do not modify reg_mr signature for version 1.0 
> > 	* Add note to man page
> >  libibverbs/driver.h               |  2 +-
> >  libibverbs/dummy_ops.c            |  2 +-
> >  libibverbs/libibverbs.map.in      |  1 +
> >  libibverbs/man/ibv_reg_mr.3       | 15 +++++++++++++--
> >  libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
> >  libibverbs/verbs.h                |  7 +++++++
> >  providers/bnxt_re/verbs.c         |  6 +++---
> >  providers/bnxt_re/verbs.h         |  2 +-
> >  providers/cxgb3/iwch.h            |  4 ++--
> >  providers/cxgb3/verbs.c           |  9 +++++----
> >  providers/cxgb4/libcxgb4.h        |  4 ++--
> >  providers/cxgb4/verbs.c           |  9 +++++----
> >  providers/hfi1verbs/hfiverbs.h    |  4 ++--
> >  providers/hfi1verbs/verbs.c       |  8 ++++----
> >  providers/hns/hns_roce_u.h        |  2 +-
> >  providers/hns/hns_roce_u_verbs.c  |  6 +++---
> >  providers/i40iw/i40iw_umain.h     |  2 +-
> >  providers/i40iw/i40iw_uverbs.c    |  8 ++++----
> >  providers/ipathverbs/ipathverbs.h |  4 ++--
> >  providers/ipathverbs/verbs.c      |  8 ++++----
> >  providers/mlx4/mlx4.h             |  4 ++--
> >  providers/mlx4/verbs.c            |  7 +++----
> >  providers/mlx5/mlx5.h             |  4 ++--
> >  providers/mlx5/verbs.c            |  7 +++----
> >  providers/mthca/ah.c              |  3 ++-
> >  providers/mthca/mthca.h           |  4 ++--
> >  providers/mthca/verbs.c           |  6 +++---
> >  providers/nes/nes_umain.h         |  2 +-
> >  providers/nes/nes_uverbs.c        |  9 ++++-----
> >  providers/ocrdma/ocrdma_main.h    |  2 +-
> >  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
> >  providers/qedr/qelr_main.h        |  2 +-
> >  providers/qedr/qelr_verbs.c       | 11 ++++-------
> >  providers/qedr/qelr_verbs.h       |  4 ++--
> >  providers/rxe/rxe.c               |  6 +++---
> >  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
> >  providers/vmw_pvrdma/verbs.c      |  7 +++----
> >  37 files changed, 126 insertions(+), 92 deletions(-)
> > 
> > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > index e4d624b2..ef27259a 100644
> > +++ b/libibverbs/driver.h
> > @@ -338,7 +338,7 @@ struct verbs_context_ops {
> >  				    uint64_t dm_offset, size_t length,
> >  				    unsigned int access);
> >  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
> > -				 int access);
> > +				 uint64_t hca_va, int access);
> >  	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
> >  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
> >  			void *addr, size_t length, int access);
> > diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> > index c861c3a0..61a8fbdf 100644
> > +++ b/libibverbs/dummy_ops.c
> > @@ -410,7 +410,7 @@ static struct ibv_mr *reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *dm,
> >  }
> >  
> >  static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
> > -			     int access)
> > +			     uint64_t hca_va,  int access)
> >  {
> >  	errno = ENOSYS;
> >  	return NULL;
> > diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
> > index 87a1b9fc..523fd424 100644
> > +++ b/libibverbs/libibverbs.map.in
> > @@ -94,6 +94,7 @@ IBVERBS_1.1 {
> >  		ibv_query_srq;
> >  		ibv_rate_to_mbps;
> >  		ibv_reg_mr;
> > +		ibv_reg_mr_virt_as;
> >  		ibv_register_driver;
> >  		ibv_rereg_mr;
> >  		ibv_resize_cq;
> > diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
> > index 631e5fe8..983b5761 100644
> > +++ b/libibverbs/man/ibv_reg_mr.3
> > @@ -3,7 +3,7 @@
> >  .\"
> >  .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
> >  .SH "NAME"
> > -ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
> > +ibv_reg_mr, ibv_reg_mr_virt_as, ibv_dereg_mr \- register or deregister a memory region (MR)
> >  .SH "SYNOPSIS"
> >  .nf
> >  .B #include <infiniband/verbs.h>
> > @@ -11,6 +11,10 @@ ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
> >  .BI "struct ibv_mr *ibv_reg_mr(struct ibv_pd " "*pd" ", void " "*addr" ,
> >  .BI "                          size_t " "length" ", int " "access" );
> >  .sp
> > +.BI "struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd " "*pd" ", void " "*addr" ,
> > +.BI "                                  size_t " "length" ", uint64_t " "hca_va" ,
> > +.BI "                                  int " "access" );
> > +.sp
> >  .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
> >  .fi
> >  .SH "DESCRIPTION"
> > @@ -52,11 +56,18 @@ Local read access is always enabled for the MR.
> >  .PP
> >  To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND should be set, addr should be 0 and length should be SIZE_MAX.
> >  .PP
> > +.B ibv_reg_mr_virt_as()
> > +Special variant of memory registration used when addresses passed to
> > +ibv_post_send and ibv_post_recv are relative to base address from a
> > +different address space than
> > +.I addr\fR. The argument
> > +.I hca_va\fR is the new base address.
> > +.PP
> 
> This should also block ACCESS_ZERO_BASED for mr_virt_as as ZERO_BASED
> is really just hca_va == 0
> 
> In fact, I might be inclined to re-implement ZERO_BASED in rdma-core
> as just passing hca_va == 0 which would make it work on all drivers
> instead of the stupid implementation we have today..
> 
> Also, not totally sold on the 'ibv_reg_mr_virt_as' for the
> name.. 

I didn't liked it also, just because it came from virtualization
perspective in mind i choose virt-address-space.

> 
> How about 'ibv_reg_mr_iova'? And let us call hca_va iova in the public
> interface. I think that is an existing convention.

Sending v3.

> 
> Jason
