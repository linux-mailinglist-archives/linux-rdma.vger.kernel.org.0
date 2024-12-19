Return-Path: <linux-rdma+bounces-6651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F29F7ACD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F506188DDDB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58B223E72;
	Thu, 19 Dec 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSR/MDYM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE522371E;
	Thu, 19 Dec 2024 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609303; cv=none; b=diSj5HIVRh5XeAl4gewNhVd6YjLB++NM2B6BTmENRs3Q6nxP5zIz//UfLMyPK3hklAVH+wyVPCLpmE4PoNqWACYR7eD+Gta1xVabK1d9z63Wnym/fM0YVfceH3a3MMr5TTu4mTab7E6bbXJtNVv3ih/kaZLSnJOEpusrIi8KpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609303; c=relaxed/simple;
	bh=ZG+A7pw5WyLCMGqAp7MPGjlIWQMRDdIScBs/pbcg3PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpApefYHfupvR1VkCmM0kWOAgls0HBmIy+JZPiRKgG4osb/SoFedfrkW+rBXh9mfFYLw3kFhrRk44M261njsCcP58dg2GwIQymtkr4XgYqKznEUghyF34175tm43q8D/TZBqZ78kmdtYlDAwkH3bqI+lPFodtv3zteOpHiGBwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSR/MDYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CEEC4CECE;
	Thu, 19 Dec 2024 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609302;
	bh=ZG+A7pw5WyLCMGqAp7MPGjlIWQMRDdIScBs/pbcg3PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSR/MDYMHNe48RHGsWMAQKnTVvrEMNNEzAywy2gojGbiU8/Hl0IXhWBMBVbNwCYHQ
	 GYExBYVeZKajBRQxNTs6rR6dbM5TIwEx7x4a5bHADOJx7OqiCxQXjDCokOsfa4Ibj2
	 dpVg+eLn65dtdRB1sn7CdVnRapBm1GJ35VcZYHymW9Y4AuIdoVdP+XrjfQPqkQC6W1
	 DuxOmWUTinZoqV20GrFof3ZsjHBPAdvw5soUH8gdMK/g2UfwLQb7WFzJoI95xj6X6v
	 oNFf86xvEG74uFH1h3FM/oO/2ukAEYvpBUWDDWnkoIh1TKUJWfJxFXM/gamsIVPiyo
	 iFkKBy64PvEWw==
Date: Thu, 19 Dec 2024 13:54:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: bvanassche@acm.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/srp: Fix error handling in srp_add_port
Message-ID: <20241219115459.GD82731@unreal>
References: <20241217075538.2909996-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217075538.2909996-1-make_ruc2021@163.com>

On Tue, Dec 17, 2024 at 03:55:38PM +0800, Ma Ke wrote:
> The reference count of the device incremented in device_initialize() is
> not decremented when device_add() fails. Add a put_device() call before
> returning from the function to decrement reference count for cleanup.
> Or it could cause memory leak.
> 
> As comment of device_add() says, if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org

I slightly rewrote commit message and dropped this stable@ tag.

Thanks

> Fixes: c8e4c2397655 ("RDMA/srp: Rework the srp_add_port() error path")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 2916e77f589b..7289ae0b83ac 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3978,7 +3978,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
>  	return host;
>  
>  put_host:
> -	device_del(&host->dev);
>  	put_device(&host->dev);
>  	return NULL;
>  }
> -- 
> 2.25.1
> 

