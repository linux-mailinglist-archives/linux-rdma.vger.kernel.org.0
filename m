Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC7166AA9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBTXBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 18:01:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45685 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 18:01:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so6416366wrs.12
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2020 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZdaSwOI+hJBogB/vTzJe43Q5pXDCtWIqPCWoh+xI05o=;
        b=OZBw5h0DJjoJpdGxicclC0aP/Rg7BgdeebFOvbYqg+y5p6P/YSJKf4RY3hnNdlMmlQ
         752nkZ1N/+QlMv2Q0Ot1SpTBeacRk6qyLAwfUSbvSzlZMtsCh/2B/mQWBEvBDejfn7b4
         0pSpezKYBmYIRAZk2Zkf4zRLr+Re9s1vjSid2O2spmZclD653WW0BUNrjs8uh49w+V3w
         N2QBe5OYyAR4ow1TQUebEnii2CorsDnC76/9xWbPgzBY02CRvKUik8Dq2zSJF7NMWkAh
         hN/rxaD06J2IbxHSfE/oJRrFhqOtSy8fVDqvpygt1Gdrf54s47tsFNmwVGu63+7NSNKQ
         /YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZdaSwOI+hJBogB/vTzJe43Q5pXDCtWIqPCWoh+xI05o=;
        b=S/tizdJZgQ3IjU+LcX1gU9BrHFkUd54CNVikThMcO9diFY+FOvTHDkzCjHWW2I4Chj
         uOKeyCmx186VhBREi8mG7zNPZaq3P4PSUmSYNVNTeXNtfjrPuqjrz6kGJNR8brYMVeGa
         7+jBjtdwyK8cHz/RnjjcGw28hCqdz2pZdUHB9lXVtqU6elV+xNi3O5E/sKl1SzsLG7kl
         Yf4vfHcNU6YIa9w+LkdQUDuhIah3FNhn4o1RqUfAwY00Sx+XBbIQeaah6JYn90HMPGvU
         cDFHmnbBTdPVammcYzH35R7Mr3F7XYLiJlZKQ6cWTllQi3poY7tFYm6f+Ilrkf1Fa1Uu
         zoxA==
X-Gm-Message-State: APjAAAXhtibgLdpuLbO5ogx24CvgoER+tVZWpiU8gKmNbZAAcu3yIxE4
        bNyyrDP0ZFmN3znfY3MQOGFNWiPSwkQ=
X-Google-Smtp-Source: APXvYqyWy4fvAZSx1CqrLiTPmHYOG2iqoqSKxnLgWmWxkmq0TNbfEtMPnZT3eN6h+H+zLfP6OzRcxg==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr43778380wrw.311.1582239701201;
        Thu, 20 Feb 2020 15:01:41 -0800 (PST)
Received: from kheib-workstation (bzq-79-183-1-162.red.bezeqint.net. [79.183.1.162])
        by smtp.gmail.com with ESMTPSA id p26sm1035985wmc.24.2020.02.20.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:01:40 -0800 (PST)
Date:   Fri, 21 Feb 2020 01:01:38 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
Message-ID: <20200220230138.GA3489@kheib-workstation>
References: <20200130082049.463-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130082049.463-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 10:20:49AM +0200, Kamal Heib wrote:
> The proper return code is "-EOPNOTSUPP" when the requested QP type is
> not supported by the provider.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>

Anything blocking this patch from getting merged?

> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 2 +-
>  drivers/infiniband/hw/cxgb4/qp.c             | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c      | 2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 2 +-
>  drivers/infiniband/hw/mlx4/qp.c              | 2 +-
>  drivers/infiniband/hw/mlx5/qp.c              | 2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c           | 2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 2 +-
>  drivers/infiniband/sw/rdmavt/qp.c            | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c        | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 52b6a4d85460..f1a75ff44d5a 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -1016,7 +1016,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
>  	if (qp->qplib_qp.type == IB_QPT_MAX) {
>  		dev_err(rdev_to_dev(rdev), "QP type 0x%x not supported",
>  			qp->qplib_qp.type);
> -		rc = -EINVAL;
> +		rc = -EOPNOTSUPP;
>  		goto fail;
>  	}
>  
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index bbcac539777a..708216d82852 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2127,7 +2127,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
>  	pr_debug("ib_pd %p\n", pd);
>  
>  	if (attrs->qp_type != IB_QPT_RC)
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  
>  	php = to_c4iw_pd(pd);
>  	rhp = php->rhp;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 3257ad11be48..3df48bda4185 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -1097,7 +1097,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
>  	default:{
>  		ibdev_err(ibdev, "not support QP type %d\n",
>  			  init_attr->qp_type);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  	}
>  
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index c335de91508f..fa1292932b88 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -617,7 +617,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
>  	iwqp->ctx_info.qp_compl_ctx = (uintptr_t)qp;
>  
>  	if (init_attr->qp_type != IB_QPT_RC) {
> -		err_code = -EINVAL;
> +		err_code = -EOPNOTSUPP;
>  		goto error;
>  	}
>  	if (iwdev->push_mode)
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index 26425dd2d960..2f9f78912267 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -1636,7 +1636,7 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
>  	}
>  	default:
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	return &qp->ibqp;
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index a4f8e7030787..a597c9043b1d 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -2789,7 +2789,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
>  		mlx5_ib_dbg(dev, "unsupported qp type %d\n",
>  			    init_attr->qp_type);
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	if (verbs_init_attr->qp_type == IB_QPT_DRIVER)
> diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
> index ac19d57803b5..69a3e4f62fb1 100644
> --- a/drivers/infiniband/hw/mthca/mthca_provider.c
> +++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -561,7 +561,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
>  	}
>  	default:
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-ENOSYS);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	if (err) {
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index d47ea675734b..10e343894595 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1111,7 +1111,7 @@ static int ocrdma_check_qp_params(struct ib_pd *ibpd, struct ocrdma_dev *dev,
>  	    (attrs->qp_type != IB_QPT_UD)) {
>  		pr_err("%s(%d) unsupported qp type=0x%x requested\n",
>  		       __func__, dev->id, attrs->qp_type);
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  	}
>  	/* Skip the check for QP1 to support CM size of 128 */
>  	if ((attrs->qp_type != IB_QPT_GSI) &&
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 484b555150e0..a5bd3adaf90a 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1186,7 +1186,7 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
>  		DP_DEBUG(dev, QEDR_MSG_QP,
>  			 "create qp: unsupported qp type=0x%x requested\n",
>  			 attrs->qp_type);
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	if (attrs->cap.max_send_wr > qattr->max_sqe) {
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> index 556b8e44a51c..71f82339446c 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> @@ -504,7 +504,7 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
>  	if (init_attr->qp_type != IB_QPT_UD) {
>  		usnic_err("%s asked to make a non-UD QP: %d\n",
>  			  dev_name(&us_ibdev->ib_dev.dev), init_attr->qp_type);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	trans_spec = cmd.spec;
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> index 9de1281f9a3b..afcc2abcf55c 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> @@ -217,7 +217,7 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	    init_attr->qp_type != IB_QPT_GSI) {
>  		dev_warn(&dev->pdev->dev, "queuepair type %d not supported\n",
>  			 init_attr->qp_type);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	if (is_srq && !dev->dsr->caps.max_srq) {
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 3cdf75d0c7a4..762d4dc11c41 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1196,7 +1196,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>  
>  	default:
>  		/* Don't support raw QPs */
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	init_attr->cap.max_inline_data = 0;
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 07e30138aaa1..fab934bdb2a0 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -322,7 +322,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
>  	}
>  	if (attrs->qp_type != IB_QPT_RC) {
>  		siw_dbg(base_dev, "only RC QP's supported\n");
> -		rv = -EINVAL;
> +		rv = -EOPNOTSUPP;
>  		goto err_out;
>  	}
>  	if ((attrs->cap.max_send_wr > SIW_MAX_QP_WR) ||
> -- 
> 2.21.1
> 
