Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427F52B4E4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfE0MVQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 08:21:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfE0MVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 08:21:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RC8vp0075618;
        Mon, 27 May 2019 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lcaT+sGGgjdsTGBSHNgOc1SMze+qsMU4BwuOV9T6Tw8=;
 b=rjKRbJENR9oiXjQXvCO8xVM4ajv5HZpfry2xfkXtq7zbIeqLQVDrrNVczlXKpYd9hfib
 ArYnXX+bR181xwnJbesBxr3WjIcNI4dHXWh5lnx3DI4cupabZChpknv2wBs1iHjawE8a
 FL1ZzHCdoKHBEQwwR8Srr1tgoWQg8BtP3+1cmsgtK3q+v3MOzvp7UgiXD8iSv7dgaCqD
 gRLIlIHyaNbuXl5AhgInNkdvGb2V1WiU8DX42WN+b3QW1X89+DGSDVzAXoXJTmKBQQvs
 DcjR4F/viP8NZxJIkUIzlbtuDzEX8MIH1b4Uw44EKX7PyvT/rvucpyUIzNSQTfMGkg2S Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbpwydg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 12:20:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RCHHB0153558;
        Mon, 27 May 2019 12:18:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sqjjncvd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 12:18:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4RCIjxh029471;
        Mon, 27 May 2019 12:18:45 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 05:18:44 -0700
Date:   Mon, 27 May 2019 15:18:39 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC] verbs: Introduce a new reg_mr API for virtual address space
Message-ID: <20190527121838.GA13891@lap1>
References: <20190526080224.2778-1-yuval.shaia@oracle.com>
 <20190527121134.GC8519@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527121134.GC8519@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270086
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 09:11:34AM -0300, Jason Gunthorpe wrote:
> On Sun, May 26, 2019 at 11:02:24AM +0300, Yuval Shaia wrote:
> > The virtual address that is registered is used as a base for any address
> > used later in post_recv and post_send operations.
> > 
> > On a virtualised environment this is not correct.
> > 
> > A guest cannot register its memory so hypervisor maps the guest physical
> > address to a host virtual address and register it with the HW. Later on,
> > at datapath phase, the guest fills the SGEs with addresses from its
> > address space.
> > Since HW cannot access guest virtual address space an extra translation
> > is needed map those addresses to be based on the host virtual address
> > that was registered with the HW.
> > 
> > To avoid this, a logical separation between the address that is
> > registered and the address that is used as a offset at datapath phase is
> > needed.
> > This separation is already implemented in the lower layer part
> > (ibv_cmd_reg_mr) but blocked at the API level.
> > 
> > Fix it by introducing a new API function that accepts a address from
> > guest virtual address space as well.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> >  libibverbs/driver.h    |  3 +++
> >  libibverbs/dummy_ops.c | 10 ++++++++++
> >  libibverbs/verbs.h     | 26 ++++++++++++++++++++++++++
> >  providers/rxe/rxe.c    | 16 ++++++++++++----
> >  4 files changed, 51 insertions(+), 4 deletions(-)
> > 
> > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > index e4d624b2..73bc10e6 100644
> > +++ b/libibverbs/driver.h
> > @@ -339,6 +339,9 @@ struct verbs_context_ops {
> >  				    unsigned int access);
> >  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
> >  				 int access);
> > +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> > +					 size_t length, uint64_t hca_va,
> > +					 int access);
> 
> I don't want to see a new entry point, all HW already supports it, so
> we should just add the hca_va to the main one and remove the
> assumption that the void *addr should be used as the hca_va from the
> drivers.

So it is better to change the reg_mr signature? That would break API, i.e.
all apps that are using reg_mr would have to be changed accordingly.
I'm a newbie here so i might be talking nonsense.

> 
> 
> >  	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
> >  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
> >  			void *addr, size_t length, int access);
> > diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> > index c861c3a0..aab61a17 100644
> > +++ b/libibverbs/dummy_ops.c
> > @@ -416,6 +416,14 @@ static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
> >  	return NULL;
> >  }
> >  
> > +static struct ibv_mr *reg_mr_virt_as(struct ibv_pd *pd, void *addr,
> > +				     size_t length, uint64_t hca_va,
> > +				     int access)
> > +{
> > +	errno = ENOSYS;
> 
> > +	return NULL;
> > +}
> > +
> >  static int req_notify_cq(struct ibv_cq *cq, int solicited_only)
> >  {
> >  	return ENOSYS;
> > @@ -508,6 +516,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
> >  	read_counters,
> >  	reg_dm_mr,
> >  	reg_mr,
> > +	reg_mr_virt_as,
> >  	req_notify_cq,
> >  	rereg_mr,
> >  	resize_cq,
> > @@ -623,6 +632,7 @@ void verbs_set_ops(struct verbs_context *vctx,
> >  	SET_PRIV_OP(ctx, query_srq);
> >  	SET_OP(vctx, reg_dm_mr);
> >  	SET_PRIV_OP(ctx, reg_mr);
> > +	SET_OP(vctx, reg_mr_virt_as);
> >  	SET_OP(ctx, req_notify_cq);
> >  	SET_PRIV_OP(ctx, rereg_mr);
> >  	SET_PRIV_OP(ctx, resize_cq);
> > diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> > index cb2d8439..8bcc8388 100644
> > +++ b/libibverbs/verbs.h
> > @@ -2037,6 +2037,9 @@ struct verbs_context {
> >  	struct ibv_mr *(*reg_dm_mr)(struct ibv_pd *pd, struct ibv_dm *dm,
> >  				    uint64_t dm_offset, size_t length,
> >  				    unsigned int access);
> > +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> > +					 size_t length, uint64_t hca_va,
> > +					 int access);
> 
> Can't add new functions here, breaks the ABI

My assumption was that it is better to add new function than to change an
existing function's signature.

> 
> Jason
