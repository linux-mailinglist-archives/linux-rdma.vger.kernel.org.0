Return-Path: <linux-rdma+bounces-3191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD690A549
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 08:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4798728F49D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A81862B5;
	Mon, 17 Jun 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbfC2Xqg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70626186E29
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605071; cv=none; b=ItmFv3amQGrCPkAsviZcROUS8sG6JwEDVTIguvTv1BSFUIgFIyQ6q/89E3UwRjwYI1T676Sq2caHTg5wdpg5jKbGVnCagoksv3MsiIQLPuhgzxi0ZMjDApVa3N+RECvMT31NzHN9e7cYOhBs41jGCTG1nXpD+Mnf2Iu6Hpyg1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605071; c=relaxed/simple;
	bh=YU8U6QYcR9whIqhHWNgy8lorCJyieeFL0kQrMFPGmDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKMS2zizRRu6UDXBTKXU1D3J6lBuMBxrVnqDJyFV6G+5Sd4k8LXDePlgjfglDyNFfZnXY73bAEMFY3kdq7vXXu2Dqz88+xDd5OsyaNNFdqLcBIQPKMNl5+mikrK8KMVIGrNgzN4BCvgdyorj87UjIF70eOItTwMCYdzYO1vdVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbfC2Xqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB1CC2BD10;
	Mon, 17 Jun 2024 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718605071;
	bh=YU8U6QYcR9whIqhHWNgy8lorCJyieeFL0kQrMFPGmDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbfC2XqgE2dhVZISyrAdRwwMmOAKau/t8W1snLI6ELG1a2HzFEhLFZ1SG5OWiLp1z
	 HPNQTNMOBfxRoG9lRmld252so/xpTh6A0MQZTdjhHr7uQuUsPo+FUCoayyrHIe7qIN
	 54TLJuJCa9NbRtST/Aau0xK7q+1GSn1f27cPY7RHQnCZHr3AQV+d4XfnWjPe+2n6ME
	 kI9H+UbrZTjU5hp0fYjjeNi3to6BvwGqToZvA4zhyX1LeVZtsZok18uZ5RK+JgeAII
	 eSVJK4gaauMlgLLa/q0Yv3jP67tcLwqywG7xFXq4SQkCmR9PtSBr3n6MBpepKLu4c4
	 2vsq1PkfLt47Q==
Date: Mon, 17 Jun 2024 09:17:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240617061746.GA6805@unreal>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>

On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Changes the create_cq verb signature by sending the entire uverbs attr
> bundle as a parameter. This allows drivers to send driver specific attrs
> through ioctl for the create_cq verb and access them in their driver
> specific code.
> 
> Also adds a new enum value for driver specific ioctl attritbutes for
> methods already supporting UHW.
> 
> Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          | 2 +-
>  drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 3 ++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h      | 2 +-
>  drivers/infiniband/hw/cxgb4/cq.c              | 3 ++-
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        | 2 +-
>  drivers/infiniband/hw/efa/efa.h               | 2 +-
>  drivers/infiniband/hw/efa/efa_verbs.c         | 3 ++-
>  drivers/infiniband/hw/erdma/erdma_verbs.c     | 3 ++-
>  drivers/infiniband/hw/erdma/erdma_verbs.h     | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       | 3 ++-
>  drivers/infiniband/hw/hns/hns_roce_device.h   | 2 +-
>  drivers/infiniband/hw/irdma/verbs.c           | 5 +++--
>  drivers/infiniband/hw/mana/cq.c               | 2 +-
>  drivers/infiniband/hw/mana/mana_ib.h          | 2 +-
>  drivers/infiniband/hw/mlx4/cq.c               | 3 ++-
>  drivers/infiniband/hw/mlx4/mlx4_ib.h          | 2 +-
>  drivers/infiniband/hw/mlx5/cq.c               | 3 ++-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          | 2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c  | 3 ++-
>  drivers/infiniband/sw/rxe/rxe_verbs.c         | 3 ++-
>  drivers/infiniband/sw/siw/siw_verbs.c         | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.h         | 2 +-
>  include/rdma/ib_verbs.h                       | 2 +-
>  include/uapi/rdma/ib_user_ioctl_cmds.h        | 1 +
>  25 files changed, 36 insertions(+), 25 deletions(-)

<...>

> --- a/drivers/infiniband/hw/mthca/mthca_provider.c
> +++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -574,7 +574,8 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
>  
>  static int mthca_create_cq(struct ib_cq *ibcq,
>  			   const struct ib_cq_init_attr *attr,
> -			   struct ib_udata *udata)
> +			   struct ib_udata *udata,
> +			   struct uverbs_attr_bundle *attrs)
>  {

This hunk needs to be fixed with the following patch:

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 677ebb145dbf..6a1e2e79ddc3 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -574,9 +574,9 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)

 static int mthca_create_cq(struct ib_cq *ibcq,
                           const struct ib_cq_init_attr *attr,
-                          struct ib_udata *udata,
                           struct uverbs_attr_bundle *attrs)
 {
+       struct ib_udata *udata = &attrs->driver_udata;
        struct ib_device *ibdev = ibcq->device;
        int entries = attr->cqe;
        struct mthca_create_cq ucmd;


Thanks

