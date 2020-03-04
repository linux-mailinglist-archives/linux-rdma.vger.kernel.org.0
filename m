Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 573CE1794B0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCDQOE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 11:14:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40935 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCDQOE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 11:14:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so2147843qka.7
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Nlf7Btuijd6MQqzVObrhdC5sVNlQNBpNF0wL7VLwWM=;
        b=KJITJ97rFjPg9xaBrDYp/FEQTOZUoDmk7C8+NggkR3F/FQDauL0Io5oS2efB46w1LV
         BVl9LhR9FKMjAUfrHY24ddOhV10HtX2qPMp2T7O82+65iW2OCZRSxpJHXhMDCIHb1YRO
         2hxq5w4LQUeXgfcNfF6nQGrG9F9WZtAHyZqtHpwDkjDXh4NFkdwByQnpz/B7WCPc+p5U
         haaFmr7U+BxTJaJL3HN9v8G2gX+6BlDGfc70B7iXxnZV1ePoX9uOXd+cAMUNwLdhV725
         J4j420UxwIAN2rCu9f34wnZevRA7Q2HHc0HCh9K4WdbVdvCjAS/h+Zc01KMYwNwnC9R4
         R+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Nlf7Btuijd6MQqzVObrhdC5sVNlQNBpNF0wL7VLwWM=;
        b=g1AskVMoj+KR+BDS4l5jh5neuOKfKpYzX+yviqhYpjb0ALHs+33RHI9WuzMI0G3gQ0
         vG5AuE5pEVivd72OnJTYVUsMXlAyWg+bKma1NGJgtwbs9MfU7R0g1ex+ZyXnoIklNeHq
         D0cWztLl5V+zLk+cl2u8LTQ35e+KVmbACSWM64bd/CMtJEizSVjdIebsT0RaF+QJsodH
         WsV+OVsTSjOE9lxKwRmWD0cnjnX71ti0BhSbD6fun5eR7xTIWo5wHcz29lgNQpxCSoXY
         TLNwYuBaHY9TxADDccW9zUgO1OYNIcSnyuTd9M0A/EyyeQCutxHP2psGf+AUeUcr4/50
         8kLA==
X-Gm-Message-State: ANhLgQ0kZVKhGXV29spEfRTebLMBwoDHJvDCgpj8EO+gXf3rmH58zEZo
        e+Nckufzl/fNEBXCNZYWfE0qAg==
X-Google-Smtp-Source: ADFU+vtazb6dJr0pGNjhTrZ4oFtxyVIEoSs+X7flKi9qYU3YNfvHkV5yMhmOZ48Q59+s8ev2LvU9FA==
X-Received: by 2002:ae9:f012:: with SMTP id l18mr3712713qkg.22.1583338442828;
        Wed, 04 Mar 2020 08:14:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w41sm14401612qtj.49.2020.03.04.08.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 08:14:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Wen-00036b-Lx; Wed, 04 Mar 2020 12:14:01 -0400
Date:   Wed, 4 Mar 2020 12:14:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
Message-ID: <20200304161401.GA5082@ziepe.ca>
References: <20200130082049.463-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130082049.463-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 10:20:49AM +0200, Kamal Heib wrote:
> The proper return code is "-EOPNOTSUPP" when the requested QP type is
> not supported by the provider.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
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

Well, it looks like we already have providers returning EOPNOTSUPP for
various cases under create_qp, so all callers already need to handle
it.

However, there are still lots of cases even within the create_qp flow
where the return codes are wrong. Below is what I thought for mlx5, so
this problem space needs a lot more attention.

But, fixing the obvious places that check qp_type seems like a
reasonable step, so applied to for-next

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a4f8e703078718..daa1b6b370e17b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2023,7 +2023,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	if (init_attr->rwq_ind_tbl) {
 		if (!udata)
-			return -ENOSYS;
+			return -EOPNOTSUPP;
 
 		err = create_rss_raw_qp_tir(dev, qp, pd, init_attr, udata);
 		return err;
@@ -2032,7 +2032,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (init_attr->create_flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 		if (!MLX5_CAP_GEN(mdev, block_lb_mc)) {
 			mlx5_ib_dbg(dev, "block multicast loopback isn't supported\n");
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		} else {
 			qp->flags |= MLX5_IB_QP_BLOCK_MULTICAST_LOOPBACK;
 		}
@@ -2044,7 +2044,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			 IB_QP_CREATE_MANAGED_RECV)) {
 		if (!MLX5_CAP_GEN(mdev, cd)) {
 			mlx5_ib_dbg(dev, "cross-channel isn't supported\n");
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		}
 		if (init_attr->create_flags & IB_QP_CREATE_CROSS_CHANNEL)
 			qp->flags |= MLX5_IB_QP_CROSS_CHANNEL;
@@ -2693,7 +2693,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		if (init_attr->qp_type == IB_QPT_RAW_PACKET) {
 			if (!ucontext) {
 				mlx5_ib_dbg(dev, "Raw Packet QP is not supported for kernel consumers\n");
-				return ERR_PTR(-EINVAL);
+				return ERR_PTR(-EOPNOTSUPP;
 			} else if (!ucontext->cqe_version) {
 				mlx5_ib_dbg(dev, "Raw Packet QP is only supported for CQE version > 0\n");
 				return ERR_PTR(-EINVAL);
@@ -2735,7 +2735,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	case IB_QPT_XRC_INI:
 		if (!MLX5_CAP_GEN(dev->mdev, xrc)) {
 			mlx5_ib_dbg(dev, "XRC not supported\n");
-			return ERR_PTR(-ENOSYS);
+			return ERR_PTR(-EOPNOTSUPP);
 		}
 		init_attr->recv_cq = NULL;
 		if (init_attr->qp_type == IB_QPT_XRC_TGT) {
@@ -2789,7 +2789,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		mlx5_ib_dbg(dev, "unsupported qp type %d\n",
 			    init_attr->qp_type);
 		/* Don't support raw QPs */
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	if (verbs_init_attr->qp_type == IB_QPT_DRIVER)
