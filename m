Return-Path: <linux-rdma+bounces-11951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B421AFC23F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 07:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2B61AA6720
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470B215F5C;
	Tue,  8 Jul 2025 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8JOKpfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755F645
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953828; cv=none; b=JoyUwVgZ4cP3XLdIX7/bckp3atQqJkie7zgWETHGBvzRAgeC1tgiLU1cqjQoKDgrpXBpu3lfDvn9c61o9HHzwOzQiyJ2k9cguDwxual8jNeehkuJd3j1XiUQ+6aeNWZGhj6snTdM8FTVY5hwp3A+/9xZvTxhEA8NoUU6tRbDE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953828; c=relaxed/simple;
	bh=q2jp6HDlPnqsEgOhJ4/yGBLp9QPM2LXVY4j44DW1S4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrBknMKKKjP1hbYN/WWccyAmpBQG8K80MyegsCvXm0qEBYuI5ccj8LJu7MVi+cCkZFQoa9BPTiRv1u/xOT0JDU6H3j5Bg+zEiHDuFcQY4arBQJDlwmo+NscuFq/a9ezU5PmvOwVLdPtLnuyd/j741PgQ1bSbTqKIsZe9JTLYaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8JOKpfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98825C4CEED;
	Tue,  8 Jul 2025 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751953828;
	bh=q2jp6HDlPnqsEgOhJ4/yGBLp9QPM2LXVY4j44DW1S4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8JOKpfZEkJkyFX6UH2dBBskwSR1pb4kQ6nvOH+7M7DcsGr4Ww4YUlGtyrwcZEsJ4
	 HNWL3Z+myQ8zKIjavwMyLWW0ylTlv7kPa1BoSb2TW6MnMGVS8Wtf3faxRIVLuMkcIZ
	 otaY8dUM0RBWTIy9BYF0R3jysAQQ33FBM+X1QBa0lr94gl8KLaTAPSluzIR2DNpFlv
	 dC51yHkHltdC2U4gbxIiwctUgCPOQyUUZRiGfLF9ItOPddg1JBpNDLN6zFnPQso5l2
	 nVo80Lz6aZ49x6OHiL9V2P/KX7ddvF3ExpR1nmftPwoKrMD1vGE4wvdKzkq0llQc1q
	 lxFE5IwgUAtrg==
Date: Tue, 8 Jul 2025 08:50:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Message-ID: <20250708055024.GC592765@unreal>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>

On Tue, Jul 08, 2025 at 10:27:42AM +0800, Junxian Huang wrote:
> 
> 
> On 2025/7/8 1:03, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@nvidia.com>
> > 
> > Extend UVERBS_METHOD_REG_MR to get DMAH and pass it to all drivers.
> > 
> > It will be used in mlx5 driver as part of the next patch from the
> > series.
> > 
> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > Reviewed-by: Edward Srouji <edwards@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c          |  2 +-
> >  drivers/infiniband/core/uverbs_std_types_mr.c | 21 ++++++++++++++++---
> >  drivers/infiniband/core/verbs.c               |  5 ++++-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  8 +++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 ++
> >  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  1 +
> >  drivers/infiniband/hw/cxgb4/mem.c             |  6 +++++-
> >  drivers/infiniband/hw/efa/efa.h               |  2 ++
> >  drivers/infiniband/hw/efa/efa_verbs.c         |  8 +++++++
> >  drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +++++-
> >  drivers/infiniband/hw/erdma/erdma_verbs.h     |  3 ++-
> >  drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
> >  drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 ++++
> >  drivers/infiniband/hw/irdma/verbs.c           |  9 ++++++++
> >  drivers/infiniband/hw/mana/mana_ib.h          |  2 ++
> >  drivers/infiniband/hw/mana/mr.c               |  8 +++++++
> >  drivers/infiniband/hw/mlx4/mlx4_ib.h          |  1 +
> >  drivers/infiniband/hw/mlx4/mr.c               |  4 ++++
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 ++
> >  drivers/infiniband/hw/mlx5/mr.c               |  8 ++++---
> >  drivers/infiniband/hw/mthca/mthca_provider.c  |  6 +++++-
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 +++++-
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  3 ++-
> >  drivers/infiniband/hw/qedr/verbs.c            |  6 +++++-
> >  drivers/infiniband/hw/qedr/verbs.h            |  3 ++-
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 ++++
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  1 +
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  5 +++++
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  1 +
> >  drivers/infiniband/sw/rdmavt/mr.c             |  5 +++++
> >  drivers/infiniband/sw/rdmavt/mr.h             |  1 +
> >  drivers/infiniband/sw/rxe/rxe_verbs.c         |  4 ++++
> >  drivers/infiniband/sw/siw/siw_verbs.c         |  7 ++++++-
> >  drivers/infiniband/sw/siw/siw_verbs.h         |  3 ++-
> >  include/rdma/ib_verbs.h                       |  3 +++
> >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> >  36 files changed, 144 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> > index 25f77b1fa773..78ee04a48a74 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> > +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> > @@ -1219,6 +1219,7 @@ int hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
> >  struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
> >  struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> >  				   u64 virt_addr, int access_flags,
> > +				   struct ib_dmah *dmah,
> >  				   struct ib_udata *udata);
> >  struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
> >  				     u64 length, u64 virt_addr,
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> > index ebef93559225..03af842dd9d3 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> > @@ -231,12 +231,16 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
> >  
> >  struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> >  				   u64 virt_addr, int access_flags,
> > +				   struct ib_dmah *dmah,
> >  				   struct ib_udata *udata)
> >  {
> >  	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
> >  	struct hns_roce_mr *mr;
> >  	int ret;
> >  
> > +	if (dmah)
> > +		return ERR_PTR(-EOPNOTSUPP);
> > +
> 
> Could you change hns part as below? We have an error counter in the err_out label.

Of course, I will do it.

> 
> Thanks
> Junxian
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index ebef93559225..e6ad6de97f10 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -237,6 +237,11 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>         struct hns_roce_mr *mr;
>         int ret;
> 
> +       if (dmah) {
> +               ret = -EOPNOTSUPP;
> +               goto err_out;
> +       }
> +
>         mr = kzalloc(sizeof(*mr), GFP_KERNEL);
>         if (!mr) {
>                 ret = -ENOMEM;
> 
> >  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> >  	if (!mr) {
> >  		ret = -ENOMEM;

