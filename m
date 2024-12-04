Return-Path: <linux-rdma+bounces-6236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2A9E3D55
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC48B3D23A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366E1F76A9;
	Wed,  4 Dec 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjZcZ+ZG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AF1F7096
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321466; cv=none; b=Oz3jh2wc10sDhhm5OSCx03LQkDqmtn0Q0BKHPWYQCSQ0P0ML9w4O+3zqFoFHoZFuHonoXpyg95CeJudfzGxfKje1I+sfzzgyAyEmKbn1ul8EqBWTXGf8Ab4rhSPTKZu4FuQLFb4fkO9XWRLEJaI/kQh3qTJ6f94uKY9BDV0zjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321466; c=relaxed/simple;
	bh=363G1GwXoFbm80WIofF7R748cDAP8e8SPyIEcYrdUk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLhdIoAhI2z6c6AvgmLYHHMhG7GscKUE87QOAu4cIMZnnwowENAgxYKKPAcuoOcVHSVTWESyaXJMmiIg6ncg+M4GkpfPFfRSjAg2yuV5j+UMjXLmPqrTQuU33kRHDvJw3akvIfB7+ZaFC6mnsohNuk+hxPJnMljBduwMBct41fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjZcZ+ZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A8C4CECD;
	Wed,  4 Dec 2024 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321466;
	bh=363G1GwXoFbm80WIofF7R748cDAP8e8SPyIEcYrdUk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjZcZ+ZGt0zDC0GsdYNC+KRkpL6HmY+9bzhJi2dJjYodBSsnq9TiNtzGnS7iux2Kk
	 3+CFV6oLA7og5YCIGX2WLDCztUQgc172PkqUOVPWBjvg1D6b/Es3ykpema34At2sWE
	 fOOHG78yRHjDxI/qpyLASGxSeus/y/dEca6fBSFhzx9dv6ND6PISwv3XkcTfbLd2M/
	 vG/kLdWkfnGz/hQUQnyNA06YkSHxTpxeSwdMs9HFlugJlrfngaI1PjogBzFT9Xx5+e
	 HcT3zNGHaoNBx5QcF2Q4pSraTrBnpp08ruKaVseTAjAWhD6BYrV+nhfPqBRK9e4oRn
	 O82qX5ir69vMw==
Date: Wed, 4 Dec 2024 16:11:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: Re: [PATCH for-next 4/8] RDMA/erdma: Add address handle
 implementation
Message-ID: <20241204141102.GP1245331@unreal>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-5-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126070351.92787-5-boshiyu@linux.alibaba.com>

On Tue, Nov 26, 2024 at 02:59:10PM +0800, Boshi Yu wrote:
> The address handle contains the necessary information to transmit
> messages to a remote peer in the RoCEv2 protocol. This commit
> implements the erdma_create_ah(), erdma_destroy_ah(), and
> erdma_query_ah() interfaces, which are used to create, destroy,
> and query an address handle, respectively.
> 
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h       |   4 +-
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  34 ++++++
>  drivers/infiniband/hw/erdma/erdma_main.c  |   4 +
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 135 +++++++++++++++++++++-
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  28 +++++
>  5 files changed, 203 insertions(+), 2 deletions(-)

<...>

> +static void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr)
> +{
> +	attr->type = RDMA_AH_ATTR_TYPE_ROCE;
> +
> +	rdma_ah_set_sl(attr, av->sl);
> +	rdma_ah_set_port_num(attr, av->port);
> +	rdma_ah_set_ah_flags(attr, IB_AH_GRH);
> +
> +	rdma_ah_set_grh(attr, NULL, av->flow_label, av->sgid_index,
> +			av->hop_limit, av->traffic_class);
> +	rdma_ah_set_dgid_raw(attr, av->dgid);
> +}

<...>

> +int erdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
> +{
> +	struct erdma_ah *ah = to_eah(ibah);
> +
> +	memset(ah_attr, 0, sizeof(*ah_attr));
> +	erdma_av_to_attr(&ah->av, ah_attr);

This function is used only once and in this file. There is no need to
create useless indirection. The same comment applicable to other
functions as well.

Thanks

