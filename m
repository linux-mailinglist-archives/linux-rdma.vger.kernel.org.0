Return-Path: <linux-rdma+bounces-20246-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F1rGrv6/WnYlQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20246-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:01:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283A4F83BE
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E420A305B2FB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBDF3F789F;
	Fri,  8 May 2026 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJi9pnPw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77063F54C4
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252206; cv=none; b=m7uFgoGSQBEzSLLVM9wFyIcPA4pd/rXmAyuZM4fGhGlufFmAKounFLX/DJc3r7qb3r7vTakwpENh3g2nqqyjm1VYfzqkZAnNwTLFz6SscmGJgzXFynRqsN9B2h5BQEhEBZXVlX56wL4pLf1VmTMLkVhCw7kz8kdDzFJEhOKQYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252206; c=relaxed/simple;
	bh=ST5lkWfuyXox1p/2s668Qu5NvhdlAzM4i+LjigyNGwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8J6diWQ7+TallD+VaHo7NSyhZ1Lz9Qb3hm9brGzbn16D8bHnbP598P3ltaPNrNPypLBc8SVJZOw9Osk0BWBSq8c8oYrgzMdCvXBNFNQgJGDKfENP4n+we1Rih9GgLzWacTjymvGVrA1zKIb6rZjDHKThB5Kh2eDnzMpofl3Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJi9pnPw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8383fb7143aso1008764b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252204; x=1778857004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSWJGa1a8P8ytmqmY0bXOJYZ37jgE6xppZF6e45wgEA=;
        b=EJi9pnPwCM0Fj4/nh1cAAEl+iwcxt9GixmhXKLamW2OWananPT03KhbOBCMgpXKmXq
         cdfWlERyxEOgtA4fMzlroijZ3BA8fOpMKruFISgfqQnlV9B608RjULm7DoIBRzq6l9iz
         hy2Pah6XuFZlrWWRu9OX/BxP4d6cGVQvuf+2jNMSfgcfvl++RNJ8bfV3IcgvUC/usl5C
         z0MCTH0lGyRAAO3oJH+1cXs1c03p2+yidjCY/yWMlQgJcQdRso5Vbonv071/jwMs8vb1
         WV37vHkZQ4CAPIHIy3SuI0QgGMUDtspNECNwOkRsXCcO1CKHyD6k2NHkZ5DrCT5q54Ig
         uZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252204; x=1778857004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSWJGa1a8P8ytmqmY0bXOJYZ37jgE6xppZF6e45wgEA=;
        b=BLse1qPF/nSwwP+pDdHu5j6AzvOVXNlEMICy88z43CwVUtM3FDXFbn16XoKgxC+2IA
         ZSOUvSFF2FMNjrUg9S0zsLeNeyf7xJ6BVXlVjqz6JFLEW87porLl9fEMO4byimjLfAh/
         ixsOaAZRrGOpSsAronW23UQKK3GgA9wBM4bz93mJm4yPj/YFyxrqv6fShHmxd6bn+qOJ
         zFygtX7LfvodDIeMA3JOBTyFocHahxwXe5/ZIkbfaKnlGHcJslKwwdM/XFw+/gQX99Wv
         sN+CeoLqQFaKStHD14R9I1fD+1My1SMDBfspPCo+a/j3Osp1YYqB2+o6VehDNv/dFZqJ
         2pPQ==
X-Forwarded-Encrypted: i=1; AFNElJ95uObrSbE0buJCygMeEbDjXcci6fU5I9Y6yvbyyHTIHMx65L7UoTLo5uN5oIOHrdNSYPaTbnDe2+T8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1QYrXox35A24stt99Twn6wo6oYqC//cJ+flZd7eyiki/NhRu
	0wsa7M9YPUatLCZJT3TF0rlxb+e8LBuBoVGatQSfzFPb1gPkgG+3yNkG
X-Gm-Gg: Acq92OEoIMJs1TRRy3JCn0tfLFjNFjF6pTG2yZYQH+iZr6t/s4BG2TrJ9D4ds0UkzGu
	mXRn7upmzjqSQ8T5MUstmkVxG5LVWg3qkKj0GdBu51rCgRR4va8kAEXbNcm0kPwZvLro28NNDVt
	JlPHjcW9UEB0LGFBbfG6fAxO4xo8pr1b5W/y4SxJuUV9l+KyJTyAWXKi/Yv7AQZKR85gZ/qYvKW
	Hgq++36n0BBfPkCQk0zcXDWl8xL81Qucy+xr0dUZ+nOFnlgDHFN8Di2ZZcnUYdQ4vF++ZP0PQUQ
	sDzRzwlARcr8QGcuiueule3gYYuimCfX0EgNpxysvqp8jnNSQAtOlZ/M/PllZAz8yPIQeg29PiC
	Y/DoKKrzJwfKgVtps5DL1sP7xrXZuDpqYMaQLFhCBhxqPk3E1Dg3UvsDeI5h88Mrg9NzGbNp6z3
	eBR7TpGBd2WoxRQcGZ
X-Received: by 2002:a05:6a00:124d:b0:835:7c0e:b529 with SMTP id d2e1a72fcca58-83a5bcd244cmr12592060b3a.12.1778252204005;
        Fri, 08 May 2026 07:56:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a272asm12835763b3a.54.2026.05.08.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:56:43 -0700 (PDT)
Date: Fri, 8 May 2026 07:56:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 1/8] net: convert netmem_tx flag to enum
Message-ID: <af35ekIjYDXIDWVR@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-1-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507-tcp-dm-netkit-v3-1-52821445867c@meta.com>
X-Rspamd-Queue-Id: 2283A4F83BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20246-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,meta.com:email,devvm7509.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Devices that support netmem TX previously set dev->netmem_tx = true.
> This was checked in validate_xmit_unreadable_skb() to drop unreadable
> skbs (skbs with dmabuf-backed frags) before they reach drivers that
> would mishandle them or devices that would not have the iommu mappings
> for them.
> 
> A subsequent patch will introduce a third state for virtual devices
> that forward unreadable skbs without ever performing DMA on them. To
> prepare for that, convert the boolean dev->netmem_tx into an enum:
> 
> NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
> NETMEM_TX_DMA    - full support, device does DMA
> 
> Update the existing NIC drivers (bnxt, gve, mlx5, fbnic) and the
> validators in net/core to use the new enum. No functional change.
> 
> Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v3:
> - Split NO_DMA changes into subsequent commit (Jakub)
> - Move !netdev->netmem_tx -> netdev->netmem_tx ==
>   NETMEM_TX_NONE conversions to this patch (Jakub)
> 
> Changes in v2:
> - Squash driver conversion patches (2-5) into patch 1 (Jakub)
> ---
>  Documentation/networking/netmem.rst                    | 5 ++++-
>  Documentation/translations/zh_CN/networking/netmem.rst | 4 +++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c              | 2 +-
>  drivers/net/ethernet/google/gve/gve_main.c             | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 2 +-
>  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         | 2 +-
>  include/linux/netdevice.h                              | 8 +++++++-
>  net/core/dev.c                                         | 2 +-
>  net/core/netdev-genl.c                                 | 2 +-
>  9 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index b63aded46337..5ccadba4f373 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -95,4 +95,7 @@ Driver TX Requirements
>     netdev@, or reach out to the maintainers and/or almasrymina@google.com for
>     help adding the netmem API.
>  
> -2. Driver should declare support by setting `netdev->netmem_tx = true`
> +2. Driver should declare support by setting `netdev->netmem_tx` to the
> +   appropriate mode:
> +
> +   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
> diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
> index fe351a240f02..9c84423b7528 100644
> --- a/Documentation/translations/zh_CN/networking/netmem.rst
> +++ b/Documentation/translations/zh_CN/networking/netmem.rst
> @@ -89,4 +89,6 @@ dma-mapping API 去处理。
>  使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
>  人员或者发送邮件至 almasrymina@google.com 寻求帮助。
>  
> -2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
> +2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
> +
> +   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8c55874f44ca..ed9c22dc4a5a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
>  	if (BNXT_SUPPORTS_QUEUE_API(bp))
>  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> -	dev->netmem_tx = true;
> +	dev->netmem_tx = NETMEM_TX_DMA;
>  
>  	rc = register_netdev(dev);
>  	if (rc)
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 424d973c97f2..dd2b8f087163 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto abort_with_wq;
>  
>  	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> -		dev->netmem_tx = true;
> +		dev->netmem_tx = NETMEM_TX_DMA;
>  
>  	err = register_netdev(dev);
>  	if (err)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 5a46870c4b74..fc49aae38807 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>  
>  	netdev->priv_flags       |= IFF_UNICAST_FLT;
>  
> -	netdev->netmem_tx = true;
> +	netdev->netmem_tx = NETMEM_TX_DMA;
>  
>  	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
>  	mlx5e_set_xdp_feature(priv);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index c406a3b56b37..138e522ef9b9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>  	netdev->netdev_ops = &fbnic_netdev_ops;
>  	netdev->stat_ops = &fbnic_stat_ops;
>  	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
> -	netdev->netmem_tx = true;
> +	netdev->netmem_tx = NETMEM_TX_DMA;
>  
>  	fbnic_set_ethtool_ops(netdev);
>  
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0e1e581efc5a..580bccb118a0 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1788,6 +1788,11 @@ enum netdev_stat_type {
>  	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>  };
>  
> +enum netmem_tx_mode {
> +	NETMEM_TX_NONE,		/* no netmem TX support */
> +	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
> +};
> +
>  enum netdev_reg_state {
>  	NETREG_UNINITIALIZED = 0,
>  	NETREG_REGISTERED,	/* completed register_netdevice */
> @@ -1809,7 +1814,8 @@ enum netdev_reg_state {
>   *	@lltx:		device supports lockless Tx. Deprecated for real HW
>   *			drivers. Mainly used by logical interfaces, such as
>   *			bonding and tunnels
> - *	@netmem_tx:	device support netmem_tx.
> + *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE or
> + *			NETMEM_TX_DMA).


nit: if you happen to repost, listing enum values here seems too much?

"device netmem TX mode" should be enough

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

