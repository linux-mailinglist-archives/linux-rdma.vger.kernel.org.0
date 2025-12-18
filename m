Return-Path: <linux-rdma+bounces-15074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F6CCCF63
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940FD302176B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E423590D2;
	Thu, 18 Dec 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d35aqMBr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC433590CF
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073094; cv=none; b=ZppyftSEV0mUhODaVyNSx5y264vMltrKA9OGnE+MJRf+rMq9oQZNmZWAJCtjIRQfRSB4z88+Q8Xr7YDywillJS5e3xTukswCcztzz2bw2Ny2OCrHXTYEYb5ihGpIhUBSY/fOjBRi0F7qHXwWJG/fUUCSIgZddrd54q+kcIw1E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073094; c=relaxed/simple;
	bh=IHQaF9gVjGEG5ms2nAbZsbw5IsYfVV5FbQhM07q5dPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mutvK70RzGMU9n4sdcBvsthFSX2Q48akqf71rCwjNS+g9DJcGapIFMUtCkIdJJrFmab+rBuLJ1hb9/vKW0wOyDLHh1hN4ppM9IMMKp0S8VcQtF1i1NAEdNc3/3ZPvwxoHeYWBTbYTvg5eeFs3X05oLlth6sQ1oY4XYnWCCNy1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d35aqMBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA0C4CEFB;
	Thu, 18 Dec 2025 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073093;
	bh=IHQaF9gVjGEG5ms2nAbZsbw5IsYfVV5FbQhM07q5dPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d35aqMBrmY64G4Nvb10dxNsh+HxH/yIq87DwpLvNYEpaAhu4Qi6Sub5A6FG0uzpAi
	 0cu20vC8sxKIbufxUJbACFl+bJUsvJ+9mW5cUATDcnsPKt1clq2SPiaz2clztpmdjB
	 rJk71adkauIdwJlO+VxXQSxpF0L2ymGSGODwaVrZ3m8N1dhxyklhKFXiKHMOJgGElu
	 E6c8igI18NPhQLOfMS8er77xcaelM0b5BzWy2PI9JdVdv0N++QVavSgXB9cOZlm+0f
	 37ADycDkMsmOCXqzndR5sZaPsV117fiywLQ/3nI2G2EkM6TtCGxqnpKAu32ETrd6n4
	 K9c02MHZ0gyqg==
Date: Thu, 18 Dec 2025 17:51:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: Re: [PATCH 2/9] RDMA/rtrs: Add error description to the logs
Message-ID: <20251218155129.GB400630@unreal>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-3-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208161513.127049-3-haris.iqbal@ionos.com>

On Mon, Dec 08, 2025 at 05:15:06PM +0100, Md Haris Iqbal wrote:
> From: Kim Zhu <zhu.yanjun@ionos.com>
> 
> Print error description besides the error number.
> 
> Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  8 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 89 ++++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 78 ++++++++---------
>  drivers/infiniband/ulp/rtrs/rtrs.c           |  9 +-
>  5 files changed, 101 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> index 4aa80c9388f0..b318acc12b10 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -439,19 +439,19 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
>  				   clt->kobj_paths,
>  				   "%s", str);
>  	if (err) {
> -		pr_err("kobject_init_and_add: %d\n", err);
> +		pr_err("kobject_init_and_add: %d(%pe)\n", err, ERR_PTR(err));

Or print error or print error description, not both.

Thanks

