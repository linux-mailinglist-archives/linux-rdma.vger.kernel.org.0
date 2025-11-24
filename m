Return-Path: <linux-rdma+bounces-14718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B74C2C81A98
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9AAB4E5F79
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863219644B;
	Mon, 24 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMaiDCoZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADA29E113;
	Mon, 24 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002987; cv=none; b=AL7xNLgzhl+xtGw4cHXuU2goBz7eAUJRlMfqgLnxd6qO/BEJrUzo/tjFBWWyhs8KFoBafAaSOZInUGc+7xykMjaOlm5nwK5e3IAJy1KyuJaaK6Q1oaX86My8stOWy5kdLUzk0Iklj3l0RMQ65drvOuC/ysvFzuVuJwQ/1RocR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002987; c=relaxed/simple;
	bh=soT/oaJaaqto1DH1USyPz77kJzDf77otDNCtIQpgYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ5JojBTqUj8ILeTTh92UnBu6i5DaVYCPz2jZ4cYiBjVu1sXwLfysEZGhXJxzOesoaLs5VpoXgI50B8ueZGfH1JAyWgEoSO9k/Gr3rG702Rtl1DXU76uCnLbL/RMUj5ZOf/b+SmgAcHqRncu+vSxfnZfRbkE1J3ORV1171NrZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMaiDCoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F7DC116C6;
	Mon, 24 Nov 2025 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764002987;
	bh=soT/oaJaaqto1DH1USyPz77kJzDf77otDNCtIQpgYkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMaiDCoZZEMKXktZz1tpiY45jCTLYei+MPfK7sl7oVVXm5g2j5PBN5snT2vNQJkE4
	 S/5ZX+sDNCKh2Gre6AOZfm3lAchBSIJ8pIPkPx9Yq7maxwTjqGVX8pZrrH+9owtido
	 l3BggfLaKSCFxACV/ySGW18hZ72rVLFrERnj4o4oAduoommf+affetO/KkasaN9Cgz
	 RDxwrB/AQFsUQoDOUnW8+4D5VtNefi0Qyp3vyitwTHqfxNgOqvciVm5clp/IuxWYU4
	 QL16jjgLzHl61GgZMqJrDfF0mrhcv2MSRKTegmcwEyu/sF8vVBZv6xQG9fe30yVuLZ
	 ZDxWuHhTVZc9A==
Date: Mon, 24 Nov 2025 16:49:43 +0000
From: Simon Horman <horms@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com, anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com
Subject: Re: [PATCH v3 4/8] RDMA/bng_re: Allocate required memory resources
 for Firmware channel
Message-ID: <aSSMpzADtbAOBU2r@horms.kernel.org>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
 <20251117171136.128193-5-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117171136.128193-5-siva.kallam@broadcom.com>

On Mon, Nov 17, 2025 at 05:11:22PM +0000, Siva Reddy Kallam wrote:

...

> +static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> +{
> +	bng_re_free_rcfw_channel(&rdev->rcfw);
> +	bng_re_destroy_chip_ctx(rdev);
> +	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
> +		bnge_unregister_dev(rdev->aux_dev);
> +}
> +
>  static int bng_re_dev_init(struct bng_re_dev *rdev)
>  {
>  	int rc;
> @@ -170,14 +184,18 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  
>  	bng_re_query_hwrm_version(rdev);
>  
> +	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
> +	if (rc) {
> +		ibdev_err(&rdev->ibdev,
> +			  "Failed to allocate RCFW Channel: %#x\n", rc);
> +		goto fail;
> +	}
> +
>  	return 0;
> -}
>  
> -static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> -{
> -	bng_re_destroy_chip_ctx(rdev);
> -	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
> -		bnge_unregister_dev(rdev->aux_dev);
> +fail:
> +	bng_re_dev_uninit(rdev);
> +	return rc;

Hi Siva,

IMHO, I think that it would best to handle unwind using a ladder
of goto statements, that reverse the order of the incremental
initialisation performed by this function.

As is, this may not have much effect, other than seeming to duplicate
bng_re_dev_uninit(). But I think that as bng_re_dev_init() grows,
as it does in this patch-set, this will lead to clearer error handling
(and ideally a lower chance of bugs later).

I would also suggest that it would be best to name the label
after what tit does, rather than somewhat general name 'fail'.

>  }
>  
>  static int bng_re_add_device(struct auxiliary_device *adev)

...

