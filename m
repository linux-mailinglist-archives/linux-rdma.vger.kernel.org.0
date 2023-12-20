Return-Path: <linux-rdma+bounces-464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB5819A14
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 09:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3041C22280
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A69171DF;
	Wed, 20 Dec 2023 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WroTH63I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF911D698
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 08:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1B6C433CB;
	Wed, 20 Dec 2023 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703059653;
	bh=el8QF7Al+/b5ufWA2YyjtbDaYeYiTUkhzRuWlvelYdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WroTH63Izf607vTjq0MV4F2JZUXu80ZqdBCm32Bxx/ORcuUZ/ZWhnEEK/CWsct3hI
	 EmCRWptZnQj4Cn+TMy0shdLNiW3JCqYeJliNN0E7puzLwRCnrWHJURI+2BQ6E9xa3Q
	 5BbiFOJ3xSGMkDEq3fhG2K0jpxVFh9HI2uG5tst672t6cDFEZ++lijBHTxrsq9/+XY
	 yEebWHqGP4ex+5IgR6IYivKHdk41/AWaa4w9Ha/2p9Lw3shtub8rPHMwp2OwHUtCJ6
	 wCZLE6zlySil4N2Sa12qS0UoDjMTOohdF7v50uG6Wcm27NCwAd3gBoLeEtrqRdCYFZ
	 R8xUpPDmz1p6w==
Date: Wed, 20 Dec 2023 10:07:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: listdansp <listdansp@mail.ru>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: mlx5 attr.max_sge checks
Message-ID: <20231220080729.GB136797@unreal>
References: <c78ab477-5b54-82b5-1d5f-8b0022195f78@mail.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78ab477-5b54-82b5-1d5f-8b0022195f78@mail.ru>

On Tue, Dec 19, 2023 at 09:56:01PM +0300, listdansp wrote:
> Hi,
> 
> While investigating the one report of the static analyzer (svacer), it was
> discovered that attr.max_sge was not checked for the maximum value in the
> mlx5_ib_create_srq function. However, this check is present in
> https://github.com/linux-rdma/rdma-core. Also, checks are present in most
> other infiniband Linux Kernel drivers. This may lead to incorrect driver
> operation for example
> int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void
> *buffer, size_tbuflen, size_t*bc)
> {
> structib_umem*umem= srq->umem;
> size_twqe_size= 1 << srq->msrq.wqe_shift; // integeroverflowhere
> if(buflen< wqe_size)
> return-EINVAL;
> In my opinion, the only possible solution to this problem may be to add a
> check to mlx5_ib_create_srq similar to
> https://github.com/linux-rdma/rdma-core
> <https://github.com/linux-rdma/rdma-core> like
> u32 max_sge= MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
> sizeof(structmlx5_wqe_data_seg);
> if (attr->attr.max_sge > max_sge) {
> mlx5_ib_dbg
> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/mlx5_ib_dbg>(dev,
> "max_sge%d, cap %d\n", init_attr
> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/init_attr>->attr.max_
> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/max_wr>sge, max_sge);
> return -EINVAL <https://elixir.bootlin.com/linux/v5.10.169/C/ident/EINVAL>;
> }
> 
> I would appreciate your suggestions and comments.

Can you please provide an example of such values?

At least in the presented case, the values are supplied by FW and are
supposed to be right without any overflows.

Thanks

> 
> Best regards,
> Danila
> 
> 

