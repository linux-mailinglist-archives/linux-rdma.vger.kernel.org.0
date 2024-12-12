Return-Path: <linux-rdma+bounces-6482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5419EF648
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806EB288E1E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99721660B;
	Thu, 12 Dec 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5J57452"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654D176AA1;
	Thu, 12 Dec 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024240; cv=none; b=A7j7D/aZVmk8a2u6y6Boj82mYkwAcEsZwDaJuyPesYx3fyFxO35Vw7IjmTIwW1ZKmsJI637RXvd2T0TDcy+A8vRcLlqP6ueWoKp6JKqQloUo+W+bHdxgOJYsndt2iqCQ3sXNunVJZqkMG1A314XW+LTAs36VPGAjib3eu7DbSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024240; c=relaxed/simple;
	bh=IkZ4ozCDNQxKwa0txWewBwm8vzMhGputwNjuHHX6mrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+RurH0XnS9+fMqp9ExivzF1hBWcoFS/glRcJZ2MdJ3uEurMP4aQz/X6Git7W7KuevvW5HzRq7I7gNI/MgflYtakq8KWWcGhK5WygzwFTT7OV1284N9uiorRVwTeOUkWz5ytOzKl5xJyyLIIFkIlA4eef3u+w2LgiAq4aD05vaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5J57452; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40491C4CECE;
	Thu, 12 Dec 2024 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024239;
	bh=IkZ4ozCDNQxKwa0txWewBwm8vzMhGputwNjuHHX6mrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5J57452abF4jh8tSN4cWp1+SQplenGOJDM5d3swl859m55ILi/dDwwpxfFBOZTZI
	 0lc/xKoOg5FxXzhxt4HEZzMzXwzVyIDrKpeQC5r1jdEd5XD9sDJqbFnsuRjg1hvUBI
	 Jwl1tAvBUfzBm99gpchJN9uyWnNkbUf27ndONVbFezv4BnwTf4HtdtdRBUL3PfVI7n
	 ez2lpbx2Vu48dXgX14kpASjlYPMV9EiXiQ35v4d8gOX54XjxwSLIaY41Qexgc3ebwp
	 ZcmQtqDeAN7jz66zOwjEm2GROhUpKLSc3QKurbVnYDDT9vwNsF1YPPbe3mAWdFUzaH
	 mCF5WiqlmppRA==
Date: Thu, 12 Dec 2024 17:23:55 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net-next 05/12] net/mlx5: fs, add mlx5_fs_pool API
Message-ID: <20241212172355.GE73795@kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211134223.389616-6-tariqt@nvidia.com>

On Wed, Dec 11, 2024 at 03:42:16PM +0200, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Refactor fc_pool API to create generic fs_pool API, as HW steering has
> more flow steering elements which can take advantage of the same pool of
> bulks API. Change fs_counters code to use the fs_pool API.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c

...

> @@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
>  /* Flow counter bluks */
>  
>  struct mlx5_fc_bulk {
> -	struct list_head pool_list;
> +	struct mlx5_fs_bulk fs_bulk;
>  	u32 base_id;
> -	int bulk_len;
> -	unsigned long *bitmask;
> -	struct mlx5_fc fcs[] __counted_by(bulk_len);
> +	struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
>  };

Unfortunately it seems that clang-19 doesn't know how to handle
__counted_by() when used like this:

drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:442:36: error: 'counted_by' argument must be a simple declaration reference
  442 |         struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
      |                                           ^~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:346:62: note: expanded from macro '__counted_by'
  346 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
      |                                                                       ^~~~~~

...

