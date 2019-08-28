Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3E9FD6B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfH1Irk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 04:47:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58062 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1Irj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 04:47:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S8hfVK189517;
        Wed, 28 Aug 2019 08:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=dthyjQiwnbD0xqmRu7owR9l5SDVhHJNeo/jxoXxar7I=;
 b=jRM8vUKhjvMATvjehMMuSlCZf/Gim9o+UyhugWSrAwFVGj1hQb3V8ROIwUKFek/8xX4k
 RSjrcn5mMNLzYCN3uxL+MhwRotmvpgiFA3x1it/aD7Ssq/4AU6E9qDRqM4y3nobWkApR
 o69cTUr17y6pOBJm1Bu95t6wbkqYigs8WmWSkq7Sm3EeggUMggTjuYcSroSO149dId5T
 WIvuc2WvYHWIFBmB4rAFBSBcCUZUCpBSw4KnJe+NGb/Yq6TgIp4TL/wTHpp7iaET1QwC
 fSsnWhhqn/oeeHFrb7/+PSA1c5e/FXZYdZyU6mKYViJVXliSr3gw6yifNtUK6OB/1myX uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2unngagdqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 08:47:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S8hLHQ144493;
        Wed, 28 Aug 2019 08:47:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2un6q2d7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 08:47:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7S8lGcd005114;
        Wed, 28 Aug 2019 08:47:16 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 01:47:15 -0700
Date:   Wed, 28 Aug 2019 11:47:06 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, majd@mellanox.com, markz@mellanox.com,
        swise@opengridcomputing.com, galpress@amazon.com,
        monis@mellanox.com, israelr@mellanox.com, maxg@mellanox.com,
        dan.carpenter@oracle.com, kamalheib1@gmail.com,
        denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH 3/4] IB/{core,hw}: ib_pd should not have ib_uobject
 pointer
Message-ID: <20190828084706.GB5549@lap1>
References: <20190828074134.17042-1-yuval.shaia@oracle.com>
 <20190828074134.17042-4-yuval.shaia@oracle.com>
 <20190828084045.GE4725@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828084045.GE4725@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 11:40:45AM +0300, Leon Romanovsky wrote:
> On Wed, Aug 28, 2019 at 10:41:33AM +0300, Yuval Shaia wrote:
> > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> >
> > As a preparation step to shared PD, where ib_pd object will be pointed
> > by one or more ib_uobjects, remove ib_uobject pointer from ib_pd struct.
> >
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c       | 1 -
> >  drivers/infiniband/core/verbs.c            | 1 -
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
> >  drivers/infiniband/hw/mlx5/main.c          | 1 -
> >  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
> >  include/rdma/ib_verbs.h                    | 1 -
> >  6 files changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 204a93305f1c..d1f0c04f0ae8 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -432,7 +432,6 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
> >  	}
> >
> >  	pd->device  = ib_dev;
> > -	pd->uobject = uobj;
> >  	pd->__internal_mr = NULL;
> >  	atomic_set(&pd->usecnt, 0);
> >  	pd->res.type = RDMA_RESTRACK_PD;
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index f974b6854224..1d0215c1a504 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -263,7 +263,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
> >  		return ERR_PTR(-ENOMEM);
> >
> >  	pd->device = device;
> > -	pd->uobject = NULL;
> >  	pd->__internal_mr = NULL;
> >  	atomic_set(&pd->usecnt, 0);
> >  	pd->flags = flags;
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> > index 0ff5f9617639..bd4a09b2ec1e 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> > @@ -760,7 +760,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
> >
> >  	free_mr->mr_free_pd = to_hr_pd(pd);
> >  	free_mr->mr_free_pd->ibpd.device  = &hr_dev->ib_dev;
> > -	free_mr->mr_free_pd->ibpd.uobject = NULL;
> >  	free_mr->mr_free_pd->ibpd.__internal_mr = NULL;
> >  	atomic_set(&free_mr->mr_free_pd->ibpd.usecnt, 0);
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 98e566acb746..93db6d4c7da4 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -4937,7 +4937,6 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
> >  		return -ENOMEM;
> >
> >  	devr->p0->device  = ibdev;
> > -	devr->p0->uobject = NULL;
> >  	atomic_set(&devr->p0->usecnt, 0);
> >
> >  	ret = mlx5_ib_alloc_pd(devr->p0, NULL);
> > diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
> > index d04c245359eb..b1a9169e3af6 100644
> > --- a/drivers/infiniband/hw/mthca/mthca_qp.c
> > +++ b/drivers/infiniband/hw/mthca/mthca_qp.c
> > @@ -956,7 +956,8 @@ static int mthca_max_data_size(struct mthca_dev *dev, struct mthca_qp *qp, int d
> >  static inline int mthca_max_inline_data(struct mthca_pd *pd, int max_data_size)
> >  {
> >  	/* We don't support inline data for kernel QPs (yet). */
> > -	return pd->ibpd.uobject ? max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
> > +	return !rdma_is_kernel_res(&pd->ibpd.res) ?
> > +		max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
> >  }
> >
> >  static void mthca_adjust_qp_caps(struct mthca_dev *dev,
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 391499008a22..7b429b2e7cf6 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -1509,7 +1509,6 @@ struct ib_pd {
> >  	u32			local_dma_lkey;
> >  	u32			flags;
> >  	struct ib_device       *device;
> > -	struct ib_uobject      *uobject;
> 
> It doesn't compile, you broke nldev.c
> 
> drivers/infiniband/core/nldev.c: In function 'fill_res_pd_entry':
> drivers/infiniband/core/nldev.c:638:6: error: 'struct ib_pd' has no member named 'uobject'
>     pd->uobject->context->res.id))
>       ^~

Oops, looks like i took out by mistake also the RDMA/nldev from the
original patch-set (after i ran build -:)).

Will add it back and send v1.

Thanks,
Yuval

> 
> >  	atomic_t          	usecnt; /* count all resources */
> >
> >  	u32			unsafe_global_rkey;
> > --
> > 2.20.1
> >
