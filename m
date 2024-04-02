Return-Path: <linux-rdma+bounces-1740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9F8957FE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A9FB251DA
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FEC12CD8E;
	Tue,  2 Apr 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvdp5qsp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133912C7F8;
	Tue,  2 Apr 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071118; cv=none; b=Ur/0c/CXK9Dzr9DiWdVyk6dc87+ebWnHkMLz6OMRftqndae2li00oMs4fj8fEMe2aPCKWuySGbIZ9PTQbgEbhM5t3ngUrbDXijq63cVqEl0E7K51m2ulWbrD/UtppbIycs7D4kgCCSl0EMTTA03Iek3tor0WCiSK49ox2rVSGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071118; c=relaxed/simple;
	bh=0z0Nf+4jN0fJOzneCEJDpRLKwTEaQmmd/rPXhf/atEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1lQivFlftsAkkwdUxK26DtlUOSFXl7kxLBXpgKO4fCfcHYjGR1hRSypcEHONXamRgpgga2KjgaffQ6z7AxbdLlhf/fwGhz1g+rr39XKf6cHX9XhmP9LCnFJWxaq4SyuWOZ+9MbXermJPk114axqINxpNmrFCPRRln7qOzgR0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvdp5qsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28647C43390;
	Tue,  2 Apr 2024 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712071117;
	bh=0z0Nf+4jN0fJOzneCEJDpRLKwTEaQmmd/rPXhf/atEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gvdp5qspwX69CDj1+qONCt/QZHPFXuZyrELOQVEFdOCLQKVupz5d8gV9NYLh1SFDS
	 3thRIUCKad/PAGPL1XOazsigMcwTJRr3zIiR/r2eUQm2/EjA1GUrNofnIFoJAtr5ib
	 zrx1tmCnbAX5yvouByqA+eZhjBPCXrvxJzzv/b9RCYrRRekv4hsOtT/juaQkn28BvV
	 Fk9Wi6npAimrMBid0etIWCWOYXqf22k2yQabTiZSwmSeIDw/0CVtXEGectjjYrmIJH
	 wx+4fAqF1A+0oyZtoph1/d5LjeJGZtNDS7I4GwI/ju2P4ZroZzqhTUdOVxibSmPtx5
	 VDYKeboo8+7SA==
Date: Tue, 2 Apr 2024 08:18:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>,
 <kalesh-anakkur.purayil@broadcom.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>, <jiri@resnulli.us>, <shayd@nvidia.com>,
 <danielj@nvidia.com>, <dchumak@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next v2 2/2] mlx5/core: Support max_io_eqs for a function
Message-ID: <20240402081836.30912d2c@kernel.org>
In-Reply-To: <20240402112549.598596-3-parav@nvidia.com>
References: <20240402112549.598596-1-parav@nvidia.com>
	<20240402112549.598596-3-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 14:25:49 +0300 Parav Pandit wrote:
> +	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
> +	if (!query_ctx)
> +		return -ENOMEM;
> +
> +	mutex_lock(&esw->state_lock);
> +	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
> +					    MLX5_CAP_GENERAL);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
> +		goto out;

missing unlock

And before someone suggests we need guards, even make coccicheck catches
this...

> +	}
> +
> +	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
> +	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
> +
> +	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
> +					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
> +	mutex_unlock(&esw->state_lock);
> +	if (err)
> +		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
> +
> +out:
> +	kfree(query_ctx);
> +	return err;
-- 
pw-bot: cr

