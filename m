Return-Path: <linux-rdma+bounces-2060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE988B19B5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 05:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A1F28632E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 03:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B002943C;
	Thu, 25 Apr 2024 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLcZBRSX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F122F0D;
	Thu, 25 Apr 2024 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016817; cv=none; b=eYhz2cKp4Nx77aF31/ZN30zXl5mBk/ln+bTqpA1YAevRf9iXVI9lWYBodnvuDH9GPArBKQmcPYYfqMgbpohe+gM0zE6W28Bme5Ko26nOW3Cikvuvx5AMaQBK3H1MDYn5VIAjloB4jAkd/LNrJ1BsA2vADu38ryczdbzKCyPn4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016817; c=relaxed/simple;
	bh=fSWVkSsgoRD6SMlmpNYA6oLa7Vc1xeL3oLQj477NoBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc23nTR3Qdjf/KujadRf/c33/pk+Ly9nDQWXOxP7hZ8VI2XfF2kLB/Px53gghw7gN2ohx1pSZpTCi68lI2c70BUyLnOyeBDnSrAsl+Q2MsZ+oARr/21Jtbhu733B6mh4nkJBxWtfVOmtcAIPajb0sK/kh+qhT5ffCoR4tyYtB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLcZBRSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D81BC113CC;
	Thu, 25 Apr 2024 03:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016817;
	bh=fSWVkSsgoRD6SMlmpNYA6oLa7Vc1xeL3oLQj477NoBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cLcZBRSXoRYHOTIYGK1XZF+WlxxKrgNCW8WexdZEsK80Le7fbZrWaeVL5FTWrRhsD
	 fJFoDmC3FbjOwiILawqmeytWemyq5obxleRDfauRSCY6Qs8BUVLrSdkqFAGqBiNw8d
	 pzGR1Q8mMYndOoOhBPnWD/3gW29HgBAcwJkhB1ckbKXPDoTUx/qZAgz/YtuN0gzv8e
	 tCAm8snXKoAORd3+UzqEXnpTPOsnDp2nv/V1hkt6v24T0MpgByyBm8vxTxHLKZddZ/
	 lKPpZMAwFRcxZjqtJJkj9SGC9oMD4jYLARcpwW8lLcHfG+75J5QWkLMEpJQd3BP1s3
	 XLvI9608h8/mw==
Date: Wed, 24 Apr 2024 20:46:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <20240424204655.7042c614@kernel.org>
In-Reply-To: <Zik1zCI9W9EUi13T@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
	<20240423194931.97013-4-jdamato@fastly.com>
	<Zig5RZOkzhGITL7V@LQ3V64L9R2>
	<20240423175718.4ad4dc5a@kernel.org>
	<ZiieqiuqNiy_W0mr@LQ3V64L9R2>
	<20240424072818.2c68a1ab@kernel.org>
	<Zik1zCI9W9EUi13T@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 09:39:40 -0700 Joe Damato wrote:
> FWIW, I also attempted to implement this API for i40e (hardware I also
> have):
> 
>   https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

Ah, missed the second patch on that thread initially!

> But there are some complications I haven't resolved, so I'm focusing on
> mlx4 and mlx5, first, and will have to come back to i40e later.

FWIW I hope this series will get ironed out soon and we'll have far
more qstats defined:
https://lore.kernel.org/all/20240423113141.1752-1-xuanzhuo@linux.alibaba.com/

The drop counts in particular could be useful in production, not so
sure about the rest :)

