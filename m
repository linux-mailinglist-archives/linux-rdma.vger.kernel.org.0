Return-Path: <linux-rdma+bounces-5254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E57991E74
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A43328258A
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D48176240;
	Sun,  6 Oct 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/UXX/7d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792FEC5
	for <linux-rdma@vger.kernel.org>; Sun,  6 Oct 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728220789; cv=none; b=Vd4c+3FHxvo52WlQ5igxB0w/Kdeh5ri1idV6YXXk4urZ9Rvw9tyiAciSiPnL5FBxMeFbxwb477i6DBY8AicUG4x6HzDCkJSLgE2de9agk7qtsmm+NPSccD5HxSued4XdDIORqnfjhXFNosCuA4MfS2qKtlKqvrizvqTaUudP+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728220789; c=relaxed/simple;
	bh=k/QA5hEzXc8L/INLjnRWJitr8bl9kltkh46vFhi0fa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qus8jzA/9HCIlpSFKDZcCjefVWyQSYIp6P4tS0EY2vMFzqj6xIJE/KpaY3y5/ePFzLEGd+Jt76QX2Fs9Fj/7nfSxp8Lqr5tb+xjDtDatql6gUGqKNHlAj9cmqJGRMZLskv/tEemQOpAiAyxx6fBDlD0/uTa8acaG77+G6sWLk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/UXX/7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C01C4CEC5;
	Sun,  6 Oct 2024 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728220789;
	bh=k/QA5hEzXc8L/INLjnRWJitr8bl9kltkh46vFhi0fa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/UXX/7ddTVe+hKohkgTRPnkLiCWOXU8LfJVkVOofcqa5xE7BghraFIDVw+ZsxziO
	 /P2BGOVgm5fnnTzZ0ZHcncclWHuzE0gC8y+ibUmjAqp5rZl3ykFYVBeWs5RhpTVl+h
	 cWO5SgPBSr5LczPJxQWEeTl2mnH4ly+pywPwW7T2+uXj959ZtZgm0J/KybCcxTkQyi
	 726WywvVQF7Y5TGSR3KuTsbFUy2E72pS0iFPvEjgq1ZG5hDMFkNzGoxxphKzzTxhS5
	 qb4aZ4rUNxdJ3Knvjs8Dq2Vbvnq8igj/9Mrxh/cwHLz0FUejfNlc6Jxcs8s2luJw1V
	 GI+6zJ+YNw8Og==
Date: Sun, 6 Oct 2024 16:19:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	kernel test robot <lkp@intel.com>,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Message-ID: <20241006131944.GD4116@unreal>
References: <20240924121603.16006-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924121603.16006-1-mrgolin@amazon.com>

On Tue, Sep 24, 2024 at 12:16:03PM +0000, Michael Margolin wrote:
> The GUID is received in big-endian so align types accordingly to avoid
> compiler warnings.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202409032113.bvyVfsNp-lkp@intel.com/
> 
> Fixes: 04e36fd27a2a ("RDMA/efa: Add support for node guid")
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
>  drivers/infiniband/hw/efa/efa_com_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
> index 5a774925cdea..5754da4e6ff8 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
> @@ -465,7 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
>  	result->db_bar = resp.u.device_attr.db_bar;
>  	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
>  	result->device_caps = resp.u.device_attr.device_caps;
> -	result->guid = resp.u.device_attr.guid;
> +	result->guid = (__force __be64)resp.u.device_attr.guid;

Based on the discussion, I'm dropping this patch.

Thanks

