Return-Path: <linux-rdma+bounces-13847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360ABBD580D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B304071AE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524E2C0F7F;
	Mon, 13 Oct 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQ1UEGnM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191021B9DE;
	Mon, 13 Oct 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375556; cv=none; b=MzwJCck0Cxs4J4jmp18peFfRJLFxzrFnQQ/LF46ZI3Pkrk5PlDhZXm5BQJL4ioXb+/3rDP0GCxsm0kg3wfLvDiEisRKVEG5fN6NJNHB0PUqyy+Ci5QYFBOBSYgu+tFGUTfNb526+Segwt1DSmHcnUEA4CbT12Me2ozFjS6YKee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375556; c=relaxed/simple;
	bh=717BLPS8TqcgpzXR0dY5x7Gybl2tsULmLFysiGQrXNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTZu0oveoMvHHpeuFfTbBuWT9MUk2QYdYjlz6cWjVHjHEsxjXGR0wm2e+iWMqPdvK3WifLcr+hUtWRGPesgiigvAMMFkU+zPjbO7zQlM4wxoXMtZ2R8FZqZ23vIDlkDwBjoVj33JZ3OcbuML8yy3o8rHMSjaTySzIe6keL1dcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQ1UEGnM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=z2hdWZ0thhVkXt2TsbVzmKj2YSVerRKfrQUAEPsjG+o=; b=XQ1UEGnMfggLK+U6HoAn11DmZo
	ekyxdCXIzLKTYI2Au0FY3mbbQnkS6GVQTS7ot3OGcG+6Wd1nlzssyMW4Zp4XlzftNkvJ8mlefYNUx
	fO8N+LUXigXqrGqI14BFslaizX/UaKuqxPohopAutXpO2qxy8/Pv50UPglC/gG2mA0LktVjyJyTe7
	9gwx1d45jZj4FljtiKV4Qqe88h3SIwB+aKSDYbcVQAuJwRCkC1LiCo3zdwiO4mi4/Gd/74Y4jXtPj
	dE6V9PmIJXALUrAOOxIR9733nd77noaGmhdhCZu/EejZVSYO9kXrtmecdINUi8XNfvyPT11Hx73kQ
	ICXTbfuA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8M63-0000000Dzof-3PUA;
	Mon, 13 Oct 2025 17:12:31 +0000
Message-ID: <572c425e-d29d-43e5-930f-4be7220e89fc@infradead.org>
Date: Mon, 13 Oct 2025 10:12:30 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/24] net: clarify the meaning of
 netdev_config members
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Breno Leitao <leitao@debian.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1760364551.git.asml.silence@gmail.com>
 <fa4a6200c614f9f6652624b03e46b3bfa2539a72.1760364551.git.asml.silence@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <fa4a6200c614f9f6652624b03e46b3bfa2539a72.1760364551.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/13/25 7:54 AM, Pavel Begunkov wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> hds_thresh and hds_config are both inside struct netdev_config
> but have quite different semantics. hds_config is the user config
> with ternary semantics (on/off/unset). hds_thresh is a straight
> up value, populated by the driver at init and only modified by
> user space. We don't expect the drivers to have to pick a special
> hds_thresh value based on other configuration.
> 
> The two approaches have different advantages and downsides.
> hds_thresh ("direct value") gives core easy access to current
> device settings, but there's no way to express whether the value
> comes from the user. It also requires the initialization by
> the driver.
> 
> hds_config ("user config values") tells us what user wanted, but
> doesn't give us the current value in the core.
> 
> Try to explain this a bit in the comments, so at we make a conscious
> choice for new values which semantics we expect.
> 
> Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics.
> Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
> returns a hds_thresh value always as 0.") added the setting for the
> benefit of netdevsim which doesn't touch the value at all on get.
> Again, this is just to clarify the intention, shouldn't cause any
> functional change.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: applied clarification on relationship b/w HDS thresh and config]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/net/netdev_queues.h | 20 ++++++++++++++++++--
>  net/ethtool/common.c        |  3 ++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..9d5dde36c2e5 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -6,11 +6,27 @@
>  
>  /**
>   * struct netdev_config - queue-related configuration for a netdev
> - * @hds_thresh:		HDS Threshold value.
> - * @hds_config:		HDS value from userspace.
>   */
>  struct netdev_config {
> +	/* Direct value
> +	 *
> +	 * Driver default is expected to be fixed, and set in this struct
> +	 * at init. From that point on user may change the value. There is
> +	 * no explicit way to "unset" / restore driver default. Used only
> +	 * when @hds_config is set.
> +	 */
> +	/** @hds_thresh: HDS Threshold value (ETHTOOL_A_RINGS_HDS_THRESH).
> +	 */
>  	u32	hds_thresh;
> +
> +	/* User config values
> +	 *
> +	 * Contain user configuration. If "set" driver must obey.
> +	 * If "unset" driver is free to decide, and may change its choice
> +	 * as other parameters change.
> +	 */
> +	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
> +	 */
>  	u8	hds_config;
>  };

kernel-doc comments should being with
/**
on a separate line. This will prevent warnings like these new ones:

Warning: include/net/netdev_queues.h:36 struct member 'hds_thresh' not described in 'netdev_config'
Warning: include/net/netdev_queues.h:36 struct member 'hds_config' not described in 'netdev_config'
Warning: include/net/netdev_queues.h:36 struct member 'rx_buf_len' not described in 'netdev_config'

(but there are 4 variables that this applies to. I don't know why kernel-doc.py
only reported 3 of them.)


-- 
~Randy


