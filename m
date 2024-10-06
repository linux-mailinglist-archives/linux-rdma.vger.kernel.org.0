Return-Path: <linux-rdma+bounces-5256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43098991EBC
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EEB1F21B09
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112333612D;
	Sun,  6 Oct 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0X+p0nj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32901CD3F;
	Sun,  6 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223562; cv=none; b=aG14nOQOQOCne8sQMff6KJU3tfGn625z5xS89FYF9QyVl5SHr6CFtlDKzZykDe0YpsDe/ryPAFVkieLc006HisK5VogGjVL1KryOMHTrbpGzQv2tUerh042P/KdHDvX4W6mkn8eVZAVLt+3b16lB2b9Lb7TKyHISYbbruhoyooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223562; c=relaxed/simple;
	bh=OHUKHBAipME0avZ0HeO9bSFTlMU6wbsNCU3M5ClcbkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gngvyaAKj9Hrx5249a+mi5aR/G5DMLWPCVByMMY6ND0WFB0/j9pnWppffOR4GMQuIFe3rchpcCBDN0SBhuUJv0BvmFRJ1pKQlaYr20ZAdcCbNPv5wYeCe6FHBW/hIpm77JJU/0HRzcVc8S70SDVVEZ31Ec3BWqy3gvutBbbqt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0X+p0nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EAEC4CEC5;
	Sun,  6 Oct 2024 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728223562;
	bh=OHUKHBAipME0avZ0HeO9bSFTlMU6wbsNCU3M5ClcbkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0X+p0nj1uusxy5vnsAbLUo1uHXyiRV0O+ht784Z3ohGwRb/iqfb55hbHHO5iwVId
	 57qt8zhENOcOwtCdyAB4yUv8g6Hhgq+eNJfAjUy8qKHnHxeDDqtT3g3jTJlN+t7fs4
	 B28lyzOMOOXLsRguWB7zjX8kq9GqYWyNKWBHcDOJoCDY1zRiXOviQkCHM72WwTnDR1
	 oUw866GygU3IV1FfI0szUsi3SfWkCJsErf0OhB5Tz7H4XKqbs1zye0s5pGUJafTY8u
	 FOTQIZEbglt59k/ENeX2dqvPRuwkvHkh9O4QiQMuBXXZR8eaIgZEuaT4r0nKxpimOL
	 +DFkhd0DDIjQA==
Date: Sun, 6 Oct 2024 17:05:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: maorg@nvidia.com, bharat@chelsio.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: of c4iw_fill_res_qp_entry
Message-ID: <20241006140558.GF4116@unreal>
References: <Zv_4qAxuC0dLmgXP@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv_4qAxuC0dLmgXP@gallifrey>

On Fri, Oct 04, 2024 at 02:16:08PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   One of my scripts noticed that c4iw_fill_res_qp_entry is not called
> anywhere; It came from:
> 
> commit 5cc34116ccec60032dbaa92768f41e95ce2d8ec7
> Author: Maor Gottlieb <maorg@mellanox.com>
> Date:   Tue Jun 23 14:30:38 2020 +0300
> 
>     RDMA: Add dedicated QP resource tracker function
>     
> I was going to send a patch to deadcode it, but is it really a bug and
> it should be assigned in c4iw_dev_ops in cxgb4/provider.c ?
> 
> (Note I know nothing about the innards of your driver, I'm just spotting
> the unused function).

It is a bug, something like that should be done.
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 10a4c738b59f..e059f92d90fd 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -473,6 +473,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
        .fill_res_cq_entry = c4iw_fill_res_cq_entry,
        .fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
        .fill_res_mr_entry = c4iw_fill_res_mr_entry,
+       .fill_res_qp_entry = c4iw_fill_res_qp_entry,
        .get_dev_fw_str = get_dev_fw_str,
        .get_dma_mr = c4iw_get_dma_mr,
        .get_hw_stats = c4iw_get_mib,
(END)


> 
> Thoughts?
> 
> Dave
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 

