Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D042622
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbfFLMl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:41:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48202 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437124AbfFLMl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 08:41:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CCdZXO152072;
        Wed, 12 Jun 2019 12:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FFU1AScraNg1fkaxnglNOGTjThYo87jkjG1trzjWNP0=;
 b=QkXnnC4vndWdqtnGhDZimAsuszDGDUuqJoMRQcJfNu++dWoa+lRUmxB1DWIYvaJbqxyj
 nt5oySsitF8XkvMlbA3FRRR7RiP8nCKfoRAWFbEs6Qqb8Wkrgrq7eV5G/30zuq67UsKe
 gDDN/QoYD4KvCcfugW8LnYZ1ZU319thr8Odpi6Y78FgmtF5yTORAoa05aLBnZDJLmM6C
 j7MG8XWcPfx29/yf3d0MV5wfiukMahlSsm77O0HMQEjYEnygKam0Iuix56ZXo9i2DWyC
 eIvy4sAPr46FUFqPuberstUAzQHtjceB0yK/ndltI5QF4Hs6DD5P9dpXj1UVF+1pWFUg Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2t02heu81d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 12:40:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CCeCYe092479;
        Wed, 12 Jun 2019 12:40:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t0p9rujxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 12:40:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CCet1D007069;
        Wed, 12 Jun 2019 12:40:55 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 05:40:55 -0700
Date:   Wed, 12 Jun 2019 15:40:50 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA: Convert destroy_wq to be void
Message-ID: <20190612124049.GA2448@lap1>
References: <20190612122741.22850-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612122741.22850-1-leon@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 03:27:41PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> All callers of destroy WQ are always success and there is no need
> to check their return value, so convert destroy_wq to be void.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/verbs.c      | 12 +++++-------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
>  drivers/infiniband/hw/mlx4/qp.c      |  4 +---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
>  drivers/infiniband/hw/mlx5/qp.c      |  4 +---
>  include/rdma/ib_verbs.h              |  2 +-
>  6 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 2fb834bb146c..d55f491be24f 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2344,19 +2344,17 @@ EXPORT_SYMBOL(ib_create_wq);
>   */
>  int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)

So why this one left out of this change?

>  {
> -	int err;
>  	struct ib_cq *cq = wq->cq;
>  	struct ib_pd *pd = wq->pd;
>  
>  	if (atomic_read(&wq->usecnt))
>  		return -EBUSY;
>  
> -	err = wq->device->ops.destroy_wq(wq, udata);
> -	if (!err) {
> -		atomic_dec(&pd->usecnt);
> -		atomic_dec(&cq->usecnt);
> -	}
> -	return err;
> +	wq->device->ops.destroy_wq(wq, udata);
> +	atomic_dec(&pd->usecnt);
> +	atomic_dec(&cq->usecnt);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(ib_destroy_wq);
>  
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index 81b3d85e5167..eb53bb4c0c91 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -906,7 +906,7 @@ void mlx4_ib_sl2vl_update(struct mlx4_ib_dev *mdev, int port);
>  struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
>  				struct ib_wq_init_attr *init_attr,
>  				struct ib_udata *udata);
> -int mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
> +void mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
>  int mlx4_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
>  		      u32 wq_attr_mask, struct ib_udata *udata);
>  
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index 5221c0794d1d..520364defa28 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -4248,7 +4248,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
>  	return err;
>  }
>  
> -int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
> +void mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
>  {
>  	struct mlx4_ib_dev *dev = to_mdev(ibwq->device);
>  	struct mlx4_ib_qp *qp = to_mqp((struct ib_qp *)ibwq);
> @@ -4259,8 +4259,6 @@ int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
>  	destroy_qp_common(dev, qp, MLX4_IB_RWQ_SRC, udata);
>  
>  	kfree(qp);
> -
> -	return 0;
>  }
>  
>  struct ib_rwq_ind_table
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index b256100d1e52..0bfc14ff8aed 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1222,7 +1222,7 @@ int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
>  struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
>  				struct ib_wq_init_attr *init_attr,
>  				struct ib_udata *udata);
> -int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
> +void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
>  int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
>  		      u32 wq_attr_mask, struct ib_udata *udata);
>  struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index cbd63ea41347..63d8f61e50e0 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -6161,7 +6161,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
>  	return ERR_PTR(err);
>  }
>  
> -int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
> +void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_dev *dev = to_mdev(wq->device);
>  	struct mlx5_ib_rwq *rwq = to_mrwq(wq);
> @@ -6169,8 +6169,6 @@ int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
>  	mlx5_core_destroy_rq_tracked(dev->mdev, &rwq->core_qp);
>  	destroy_user_rq(dev, wq->pd, rwq, udata);
>  	kfree(rwq);
> -
> -	return 0;
>  }
>  
>  struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 255999488693..d902ff49b56e 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2428,7 +2428,7 @@ struct ib_device_ops {
>  	struct ib_wq *(*create_wq)(struct ib_pd *pd,
>  				   struct ib_wq_init_attr *init_attr,
>  				   struct ib_udata *udata);
> -	int (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
> +	void (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
>  	int (*modify_wq)(struct ib_wq *wq, struct ib_wq_attr *attr,
>  			 u32 wq_attr_mask, struct ib_udata *udata);
>  	struct ib_rwq_ind_table *(*create_rwq_ind_table)(
> -- 
> 2.20.1
> 
