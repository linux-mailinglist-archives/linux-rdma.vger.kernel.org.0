Return-Path: <linux-rdma+bounces-10492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC766ABF7EA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6455F4E67D8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E31DD543;
	Wed, 21 May 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROoqVqcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE71D88D0;
	Wed, 21 May 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838044; cv=none; b=gM3uB8fTi6L1FtQhfugaXcZ6Db8cM0USaeav8oM51ctjqy2M0nanoSgI0AsjW90YwnsdoOmgXInxywo8PgH/m/tmVNV8Z7srbjKrRG159f8kowyt7Jpk4BIJF8jqPBiuNCLJJw7dXfTu5a1NNmVKFHHIGoxAEGYG3f8LVj2dHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838044; c=relaxed/simple;
	bh=6P7mIPj7B7sJ/vEA58VPqJNIo45jgikPcikO/uSzLsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq+Nf31uK72j6Kks/LWHRq8rJ0HQSZr8ds29Joi7ZirSFAaVH2gHXxQrZvYanHIbai1l6XDOXCxC9neysWPDquABSvtBtQOiCXeNHJ3emdumjyHU7dslfqGOV8WC97mBIBUAEkG7jo+4umXxJJtkApgI9BJnXCL1hTJStdC1uPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROoqVqcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E2C4CEE4;
	Wed, 21 May 2025 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838043;
	bh=6P7mIPj7B7sJ/vEA58VPqJNIo45jgikPcikO/uSzLsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROoqVqcZH42CiPfobRxDgWMXSJf4HEuZ6B1czaH2zeQkFIBOACu3jK8u2NIUfuT6v
	 cYl6uDa7GJEkHJsvzeCIYZcttLv4QoAEOf41rqvjb5Fi38bWgvQWJhiY0AT/e8LBp9
	 Ac1NNbYgfSr6KOmglkrkgrTWucmupgDw+Cuh51tJnNGZgvSPRMUi2sTjnL0i4TGEhe
	 xz78vjUlWFWZ09t83r11c+9EqGCDiQq4psW8ZeLppzE9UZohwQ42LIckZ9attzA8m+
	 q+RLSpOQAhFx+hLxVAW3lVIvpDO79xY6PzqU2fXrwFGMN5nFPnW7Hz2Zl1D6e3X2pF
	 yLD8HBwBPJVkQ==
Date: Wed, 21 May 2025 07:34:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
 shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dsahern@kernel.org, ruanjinjie@huawei.com,
 mheib@redhat.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com, leon@kernel.org
Subject: Re: [PATCH net-next 2/3] udp_tunnel: remove rtnl_lock dependency
Message-ID: <20250521073401.67fbd1bc@kernel.org>
In-Reply-To: <20250520203614.2693870-3-stfomichev@gmail.com>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
	<20250520203614.2693870-3-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 13:36:13 -0700 Stanislav Fomichev wrote:
> Drivers that are using ops lock and don't depend on RTNL lock
> still need to manage it because udp_tunnel's RTNL dependency.
> Introduce new udp_tunnel_nic_lock and use it instead of
> rtnl_lock. Drop non-UDP_TUNNEL_NIC_INFO_MAY_SLEEP mode from
> udp_tunnel infra (udp_tunnel_nic_device_sync_work needs to
> grab udp_tunnel_nic_lock mutex and might sleep).

There is a netdevsim-based test for this that needs to be fixed up.

> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index 2df3b8344eb5..7f5537fdf2c9 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -221,19 +221,17 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
>  #define UDP_TUNNEL_NIC_MAX_TABLES	4
>  
>  enum udp_tunnel_nic_info_flags {
> -	/* Device callbacks may sleep */
> -	UDP_TUNNEL_NIC_INFO_MAY_SLEEP	= BIT(0),

Could we use a different lock for sleeping and non-sleeping drivers?

> @@ -554,11 +543,11 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
>  	struct udp_tunnel_nic *utn;
>  	unsigned int i, j;
>  
> -	ASSERT_RTNL();
> +	mutex_lock(&udp_tunnel_nic_lock);
>  
>  	utn = dev->udp_tunnel_nic;

utn and info's lifetimes are tied to the lifetime of the device
I think their existence can remain protected by the external locks

>  	if (!utn)
> -		return;
> +		goto unlock;
>  
>  	utn->need_sync = false;
>  	for (i = 0; i < utn->n_tables; i++)

> -	rtnl_lock();
> +	mutex_lock(&udp_tunnel_nic_lock);
>  	utn->work_pending = 0;
>  	__udp_tunnel_nic_device_sync(utn->dev, utn);
>  
> -	if (utn->need_replay)
> +	if (utn->need_replay) {
> +		rtnl_lock();
>  		udp_tunnel_nic_replay(utn->dev, utn);
> -	rtnl_unlock();
> +		rtnl_unlock();
> +	}
> +	mutex_unlock(&udp_tunnel_nic_lock);
>  }

What's the lock ordering between the new lock and rtnl lock?

BTW the lock could live in utn, right? We can't use the instance
lock because of sharing, but we could put the lock in utn?

