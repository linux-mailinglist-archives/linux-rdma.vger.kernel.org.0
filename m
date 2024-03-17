Return-Path: <linux-rdma+bounces-1472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CC87DC9C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54741C209FC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292BF9F0;
	Sun, 17 Mar 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/mioa15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F263CF
	for <linux-rdma@vger.kernel.org>; Sun, 17 Mar 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664573; cv=none; b=XrsMizv+F0QOVkGuhdK60S8czDpV+B+WGW4l6nxBKdWawZafvkP/6Bjis3cJCxNwlaTs+W6taD3MOrgsRJsUzIEAYsrEp6tv1hlyv7oDNp+8Szin1urzek6dEzmXsp1noAaPuUDxTaJE71WNZcYgslZn295aKboffj0M96cQm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664573; c=relaxed/simple;
	bh=mGREz5v53Hk1rB660HpOEt5x6evtAZmg1n6Qm9a57V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJVzovS2D7reb99qYASFBBXJfkCth86AqIu4wX3hL91kkaIZmY2KMHonfFTrmWVAo9GWIGKy/vBpULn0qaaOAEKveX7kFVNh+p2k606lSzKdHp0ptSLJgUd91iVkdhgG97PowtqK7AfAxlIH3yDmweA3UYjxklVTD2ho1Kzw0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/mioa15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18250C433F1;
	Sun, 17 Mar 2024 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710664572;
	bh=mGREz5v53Hk1rB660HpOEt5x6evtAZmg1n6Qm9a57V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/mioa15XKgl434ZQA8UZWM7p41uRchIYHrZW/24d7UcfkbBwYTuv35dNaPLnlh30
	 VMmjjuqNEJl22TFSI5XcoWNOojZGpllU2Z0ysYHkgD1slrmU5T1yuGkaTInIy8ItEZ
	 cypRE8xQPIZzsU8geVmXxQdtTVZH1csiF+h7PWHI9cYMpFgOZJBiyXDKiiAQRl0NQG
	 IbNIdKJMeh20boZMChxtO+j23rLzOrWkRgOdd+LNXVLihyZACSfaocLD1YxgmS45xq
	 ZedQbR5ggEJQdfmogkoRzP5BQr+Mql1qwkt7yp1bq7KCUN48JsK73B717VlyNn4XWW
	 XXxJZCvV7qtRg==
Date: Sun, 17 Mar 2024 10:35:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: listdansp <listdansp@mail.ru>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: mlx5 attr.max_sge checks
Message-ID: <20240317083558.GE12921@unreal>
References: <c78ab477-5b54-82b5-1d5f-8b0022195f78@mail.ru>
 <20231220080729.GB136797@unreal>
 <82ba679e-cef5-bd0b-2084-ae601681cdec@mail.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ba679e-cef5-bd0b-2084-ae601681cdec@mail.ru>

On Thu, Mar 14, 2024 at 11:29:49PM +0300, listdansp wrote:
> -------- Original Message  --------
> Subject: Re: mlx5 attr.max_sge checks
> From: Leon Romanovsky <leon@kernel.org>
> To: listdansp <listdansp@mail.ru>
> Date: 20.12.2023
> 
> > On Tue, Dec 19, 2023 at 09:56:01PM +0300, listdansp wrote:
> > > Hi,
> > > 
> > > While investigating the one report of the static analyzer (svacer), it was
> > > discovered that attr.max_sge was not checked for the maximum value in the
> > > mlx5_ib_create_srq function. However, this check is present in
> > > https://github.com/linux-rdma/rdma-core. Also, checks are present in most
> > > other infiniband Linux Kernel drivers. This may lead to incorrect driver
> > > operation for example
> > > int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void
> > > *buffer, size_tbuflen, size_t*bc)
> > > {
> > > structib_umem*umem= srq->umem;
> > > size_twqe_size= 1 << srq->msrq.wqe_shift; // integeroverflowhere
> > > if(buflen< wqe_size)
> > > return-EINVAL;
> > > In my opinion, the only possible solution to this problem may be to add a
> > > check to mlx5_ib_create_srq similar to
> > > https://github.com/linux-rdma/rdma-core
> > > <https://github.com/linux-rdma/rdma-core> like
> > > u32 max_sge= MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
> > > sizeof(structmlx5_wqe_data_seg);
> > > if (attr->attr.max_sge > max_sge) {
> > > mlx5_ib_dbg
> > > <https://elixir.bootlin.com/linux/v5.10.169/C/ident/mlx5_ib_dbg>(dev,
> > > "max_sge%d, cap %d\n", init_attr
> > > <https://elixir.bootlin.com/linux/v5.10.169/C/ident/init_attr>->attr.max_
> > > <https://elixir.bootlin.com/linux/v5.10.169/C/ident/max_wr>sge, max_sge);
> > > return -EINVAL <https://elixir.bootlin.com/linux/v5.10.169/C/ident/EINVAL>;
> > > }
> > > 
> > > I would appreciate your suggestions and comments.
> > 
> > Can you please provide an example of such values?
> > 
> > At least in the presented case, the values are supplied by FW and are
> > supposed to be right without any overflows.
> > 
> > Thanks
> > 
> > > 
> > > Best regards,
> > > Danila
> > > 
> > > 
> 
> Hi,
> 
> In the mlx5_ib_create_srq function, the variable srq->msrq.wqe_shift =
> ilog2(desc_size).
> Value of  desc_size is result of desc_size = sizeof(struct
> mlx5_wqe_srq_next_seg) + srq->msrq.max_gs * sizeof(struct
> mlx5_wqe_data_seg);.
> The init_attr->attr.max_sge parameter can be set to any 4-byte unsigned
> number.
> There is overflow checking
> if (desc_size == 0 || srq->msrq.max_gs > desc_size)
> return -EINVAL;
> but it works correctly only for 32-bit platforms because size_t desc_size;
> and for 64 bits platforms sizeof(size_t) is 8.
> So, result of srq->msrq.wqe_shift = ilog2(desc_size) may be greater than 31
> and will cause overflow in size_t wqe_size = 1 << srq->msrq.wqe_shift;

Let me repeat my question.
Can you please provide an example of such values?

Thanks

> 
> Best regards,
> Danila
> 

