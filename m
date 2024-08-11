Return-Path: <linux-rdma+bounces-4309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5694E092
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5871C20AB5
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7022EF2;
	Sun, 11 Aug 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLWszOcU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95422615
	for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365808; cv=none; b=EO+WtoMKC/6WqqsqERDNyR92PbjimXjItwW++cjMtgYmbcihm6MDTHVoqS+29UCjWnbxZ9Cd+p4fn6iJX7NRueuYAfM1yNVyfZM1U8J8xvqGjPbWneQ00TxHj5+UUP+5zyUaJp40jwMt8zEeBpnhJUWaKXG3B91T06B+Ey3AcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365808; c=relaxed/simple;
	bh=DgL1EWvAnzqLg8CSyeuYMR3DLKUx3A2s+aciURCL9bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLymbMdRmPhcHW9lt1FEUmx6BtR7bbbGTfoAUoyYoFA9uuJn/PoqL3cwrQp7Ei+2hu7vc9xlrWNAsxH9RZCf3jQe3NuuX3yjekMZAFPwSYdBnNkI3K/ojr2oH5IMj/rKGEQYLsvTSlKk1BAfIhb1BSu70o7PbMKIuNLXm53mhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLWszOcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DBCC4AF09;
	Sun, 11 Aug 2024 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723365808;
	bh=DgL1EWvAnzqLg8CSyeuYMR3DLKUx3A2s+aciURCL9bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLWszOcU7eaybjUSvp4xun/j2F4uQhevxKjG7pJIGadpkgCPsvlW61Mbw+vYxrvLp
	 jmjIGcz4y+ggFaOFnvyq5BGd6r6Kshm3sqTJZzVdjbpuGt0l6PZm1oEEXqIxukWj+s
	 8Y7M1XBfMR+UXFkTKVI2xCQtHpfm8TBWKYz4Ewtw3Mu/tfuwkKaDTiuJ/n8QYvbzrP
	 YbsLerF0lSRMa/AGmpOUgZDFI3JdZ2shgqXzkbfed6sLhpLu+difENmKE/zqqWaDZj
	 3IfmLXH0XL8f7o7VNyD85Bq4ora4/koFGMlVLc74+vSlzeQN+chIlAqV3pJ3EJAcK/
	 sQQ63B5uDOfLw==
Date: Sun, 11 Aug 2024 11:43:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com, Alexei Pastuchov <alexei.pastuchov@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 13/13] RDMA/rtrs-clt: Remove an extra space
Message-ID: <20240811084325.GD5925@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-14-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809131538.944907-14-haris.iqbal@ionos.com>

On Fri, Aug 09, 2024 at 03:15:38PM +0200, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@ionos.com>
> 

No empty commit message, please provide a proper description.

Thanks


> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Alexei Pastuchov <alexei.pastuchov@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index fb548d6a0aae..71387811b281 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1208,7 +1208,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
>  		ret = rtrs_map_sg_fr(req, count);
>  		if (ret < 0) {
>  			rtrs_err_rl(s,
> -				     "Read request failed, failed to map  fast reg. data, err: %d\n",
> +				     "Read request failed, failed to map fast reg. data, err: %d\n",
>  				     ret);
>  			ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
>  					req->dir);
> -- 
> 2.25.1
> 

