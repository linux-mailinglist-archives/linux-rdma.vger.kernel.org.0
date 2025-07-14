Return-Path: <linux-rdma+bounces-12112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3892BB037B2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834F0179982
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E122F772;
	Mon, 14 Jul 2025 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6Mp65ze"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF722D4F9
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477426; cv=none; b=AcljSzXladJz7L8dYF1eotFYaqYHp+5DZ8Oo0xFedDA4jGU8K5aHhKN8xWz5rVSxznphL5JuS/2rAJpzy6AMrddRdg7uE7Iqtr7Df6isaKH6gh43xdub0yuqjibOw7wDkSQsAQZnSjZGHfV89a+cgRFJ4oAzr/xeTToiBS/ThTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477426; c=relaxed/simple;
	bh=njTqvO8/DQE/9WrK5oD1UFNMDgHnxAaE4LhjnBIk2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9WlTaMowB6EoLxrZlnFF6Sj82YFcIsd2V96PHY6W9EZBTqJPbqDX9QmZU2nAzzAcK0C/bYckIAo7YexBpjFnW/sZpV2YiugCicvwtSTQylBeql2MTGG14pMNSdkZVc03Y/HVVo1xgqPeBzvfLHhvGFFlDALuxbEEj8GqpPNr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6Mp65ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA4AC4CEED;
	Mon, 14 Jul 2025 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752477426;
	bh=njTqvO8/DQE/9WrK5oD1UFNMDgHnxAaE4LhjnBIk2KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6Mp65zeNah3WpvKRCRrKhCA29xk5Djlu5hwxYY1qRoK/mAsgJbmGIHB1kZO/qw4+
	 SKISykOaDYadxRxzJQlpqttuoh2zEEG2i2tNP95iLsJPPAI8aLSAlIjFtjZJkJ2z3L
	 Exu6ZknzAfDn0xKgUAHzSKlwYk0PQ6abGsSyO62XZjeb047tw1+RmjZGob8kkh66JW
	 PwaoWVgzCXRp/HsbhVbPw87lq8L+8AkCp00fSmSwsviD9LqCZvSYji3iQvhdJ1sO0J
	 zT4aIZtI+0+bHnh14p8yK/j3VDjVFqz7TfPJJQ7qvyr6j1dBW1fBcP6hth7pjk3H66
	 H8dXP0easPVqA==
Date: Mon, 14 Jul 2025 10:17:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
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
Subject: Re: [PATCH rdma-next v1 7/8] IB: Extend UVERBS_METHOD_REG_MR to get
 DMAH
Message-ID: <20250714071700.GB5882@unreal>
References: <cover.1752388126.git.leon@kernel.org>
 <ea27b78b82e06b4de87af8bc12be49221a085c4f.1752388126.git.leon@kernel.org>
 <66203913-b684-4d0f-8689-077e51dfcf54@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66203913-b684-4d0f-8689-077e51dfcf54@linux.dev>

On Sun, Jul 13, 2025 at 03:04:16PM -0700, Zhu Yanjun wrote:
> 在 2025/7/12 23:37, Leon Romanovsky 写道:
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
> >   drivers/infiniband/core/uverbs_cmd.c          |  2 +-
> >   drivers/infiniband/core/uverbs_std_types_mr.c | 27 +++++++++++++++----
> >   drivers/infiniband/core/verbs.c               |  5 +++-
> >   drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  8 ++++++
> >   drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 ++
> >   drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  1 +
> >   drivers/infiniband/hw/cxgb4/mem.c             |  6 ++++-
> >   drivers/infiniband/hw/efa/efa.h               |  2 ++
> >   drivers/infiniband/hw/efa/efa_verbs.c         | 12 +++++++++
> >   drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 ++++-
> >   drivers/infiniband/hw/erdma/erdma_verbs.h     |  3 ++-
> >   drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
> >   drivers/infiniband/hw/hns/hns_roce_mr.c       |  6 +++++
> >   drivers/infiniband/hw/irdma/verbs.c           |  9 +++++++
> >   drivers/infiniband/hw/mana/mana_ib.h          |  2 ++
> >   drivers/infiniband/hw/mana/mr.c               |  8 ++++++
> >   drivers/infiniband/hw/mlx4/mlx4_ib.h          |  1 +
> >   drivers/infiniband/hw/mlx4/mr.c               |  4 +++
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 ++
> >   drivers/infiniband/hw/mlx5/mr.c               |  8 +++---
> >   drivers/infiniband/hw/mthca/mthca_provider.c  |  6 ++++-
> >   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ++++-
> >   drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  3 ++-
> >   drivers/infiniband/hw/qedr/verbs.c            |  6 ++++-
> >   drivers/infiniband/hw/qedr/verbs.h            |  3 ++-
> >   drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  4 +++
> >   drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  1 +
> >   drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  5 ++++
> >   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  1 +
> >   drivers/infiniband/sw/rdmavt/mr.c             |  5 ++++
> >   drivers/infiniband/sw/rdmavt/mr.h             |  1 +
> >   drivers/infiniband/sw/rxe/rxe_verbs.c         |  4 +++
> >   drivers/infiniband/sw/siw/siw_verbs.c         |  7 ++++-
> >   drivers/infiniband/sw/siw/siw_verbs.h         |  3 ++-
> >   include/rdma/ib_verbs.h                       |  3 +++
> >   include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> >   36 files changed, 154 insertions(+), 20 deletions(-)

<...>

> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -1271,6 +1271,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
> >   static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
> >   				     u64 length, u64 iova, int access,
> > +				     struct ib_dmah *dmah,
> >   				     struct ib_udata *udata)
> >   {
> >   	struct rxe_dev *rxe = to_rdev(ibpd->device);
> > @@ -1278,6 +1279,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
> >   	struct rxe_mr *mr;
> >   	int err, cleanup_err;
> > +	if (dmah)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> Thanks. If I get this patchset correctly, this patchset is based on the PCIe
> features TPH(TLP Processing Hints),  Steering Tags and Processing Hints. RXE
> is an emulation RDMA driver. Thus it can not support this DMAH feature
> because rxe does not have PCIe features support (THP, Steering Tags and
> Processing Hints).
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks, and BTW please trim the emails while replying.

