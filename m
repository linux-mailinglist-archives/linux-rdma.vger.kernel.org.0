Return-Path: <linux-rdma+bounces-20254-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAmVNpoL/mm2mQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20254-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:13:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 460994F9452
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC38D305EAB5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996E3E122B;
	Fri,  8 May 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqbVe/7Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245E3BB4A
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256682; cv=none; b=uClhw6zuhF1K/e5zkxPxgHw8Q9jtTIS//G/KV3JQ+KiBPysFZ+ZuJ23qeSPl8s4EeVXstBLZ9Dd5MxOW1Qdn6wM5/I9GHkhBEw7up7YGJ6lrZQlleFIb6yRGDcgENlMWCD91B7FQv918hlNLTT4QKeCoKbcF8vjZjJ8s21P59TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256682; c=relaxed/simple;
	bh=H6Z+8CT3KjwWjNMFY6XYXNpX9S3GKUwrUsjc+V6VlCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk+OX9umkJHZL0zeHRwQTo9/9CJJKBxhkZdZoLF0Qvhyohfzf7jaCiHC+PDpnqirIigvcEW/3M+d419YPTN+t0K0ua+20G9gmRCy0d5wSrpkqc7KQqpQX38WehWc8sGaTr5eO0WT2fsV3FIGNGDjlDaxH2+3KDW41W/RpBqjZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqbVe/7Y; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6313c800372so684382137.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778256679; x=1778861479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vdBcradM8S03iinDWnSXeMPjIWLpbzTHbnVlnltxq4=;
        b=GqbVe/7YgabRsfx+ARki2K+jqMFHzQAg5niJlng8/wpcze/h3pTF4SoatmMJPyHB7D
         /qNTHu1lVyE7mH9yKgbdm4ooIC2WUCq3XMpaXC6iH4j5k/vDldGibNvEIqbVNdLxqiPi
         YH9fqJiGwTGW11itHd7LpOvvPKE1KAXrZK+HUNX6ClakxuHMEw1TnirPzvAhClx7ngGa
         QtNxIliGYzFR29HuAe1iYaPfpSiaUrMr4e92u35Ne0L/R9XWJpz7nJxbNXKfGFNmiofw
         QuowoaDCgsZ7lo7H+UD3MPNCMkZKODcRWgr3UT8n2AnLaBFagpAprzK5tjrQKe1dT9Kj
         d1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778256679; x=1778861479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vdBcradM8S03iinDWnSXeMPjIWLpbzTHbnVlnltxq4=;
        b=jiuYfGdADgO5G8F9k10Jl38kDpw0E65Md7FsyGrbGzhB6BBU74aQx5zq3FGUUyGlk9
         eXPI26frn72QSoJLJqRK1bK2IYUUmT6qIZ48/YlhyMUDGTF8alRJyCx9tn5+jfbHZWm3
         feADFAVJGu6JZiSBsl9UuNAnK8qOovn9dxpAB5LfCXAkjOtcSTUk5aR8kbtygOQg4nUY
         mQenhjPfK895oiL1tR+BxeM9rhLov4uu/VRs7glmcR6n4ZlLyGbINzFN0uzJY2gGOnJW
         AH9+CNo/tvukkwCPkbV8gPYh6BppqZPyhWBaco6H9jZG6tLwhJ5QZih6RxWpr1GPz3nh
         /vWA==
X-Forwarded-Encrypted: i=1; AFNElJ/CDkWJZncZHSHk2QxHPBU5eSeOZmiFbrUCooRE9ZnBHaEa/9mZw9uWsZjXPz0mDvXJ3WHhnBRKp3C2@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSKpRoKEUlx1fexy3OOZgK8Zt4oAQLOyONkFayMSqiDB3+Ktq
	kYeZsmrc6vFLnXpRkh85O0VWG35R5Y57BykdwZWqGZ91PyUqX+4Iti6W
X-Gm-Gg: Acq92OFQG7Oz8Q54CwxmtcSuBt+DrIB9z0yq9B+hbkLT1iWh6NoptlPIVboPUM5qKhF
	dlIOOzMy+8D0+64Ti2GtgS3EUKSNjHt6Sehpq3IIwgeOaZZagiOO0BzVxiMVwRqiIGwGmjJ4D7S
	bxVkCpNK7XCvppo/ZVEqoztZ9xyV+Z1kI2WnZ/j55DYCjXIpE4owTTW1w9oAm3SKcs7fC3V6tZq
	o/cIEvmuI+lR0py8xN7bHjhTtlVaQnLiCUTTk1uEZn7aSqkQ9mXkmBeXTvyGJomcNP69Z6/cgU3
	jYn84u5p8315bo3cVif6n2rvlZe9Mt3HptTMj4j4C0FMcQN5GCYtCoxqaPy35a4UkYPXh8ykFtQ
	IlbAdNJ9V/OSIJ9jlWLqoOIgPVyE/EaSOPoatzj+IGDAOpkZTr/xbuL8RBjnXpLT5pFmhLsBToq
	onCZh+LagJ+mfD9BUjsPFlzgaj8b94uXUWsQmnNn5wEm4zVd0=
X-Received: by 2002:a67:e114:0:b0:631:4e9a:ba3 with SMTP id ada2fe7eead31-6314e9a142fmr1065827137.21.1778256679486;
        Fri, 08 May 2026 09:11:19 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:35::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8bae450sm239133785a.21.2026.05.08.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:11:18 -0700 (PDT)
Date: Fri, 8 May 2026 09:11:12 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 1/8] net: convert netmem_tx flag to enum
Message-ID: <af4LILMY6qEav7Ul@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-1-52821445867c@meta.com>
 <af35ekIjYDXIDWVR@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af35ekIjYDXIDWVR@devvm7509.cco0.facebook.com>
X-Rspamd-Queue-Id: 460994F9452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20254-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 07:56:42AM -0700, Stanislav Fomichev wrote:
> On 05/07, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Devices that support netmem TX previously set dev->netmem_tx = true.
> > This was checked in validate_xmit_unreadable_skb() to drop unreadable
> > skbs (skbs with dmabuf-backed frags) before they reach drivers that
> > would mishandle them or devices that would not have the iommu mappings
> > for them.
> > 
> > A subsequent patch will introduce a third state for virtual devices
> > that forward unreadable skbs without ever performing DMA on them. To
> > prepare for that, convert the boolean dev->netmem_tx into an enum:
> > 
> > NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
> > NETMEM_TX_DMA    - full support, device does DMA
> > 
> > Update the existing NIC drivers (bnxt, gve, mlx5, fbnic) and the
> > validators in net/core to use the new enum. No functional change.
> > 
> > Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - Split NO_DMA changes into subsequent commit (Jakub)
> > - Move !netdev->netmem_tx -> netdev->netmem_tx ==
> >   NETMEM_TX_NONE conversions to this patch (Jakub)
> > 
> > Changes in v2:
> > - Squash driver conversion patches (2-5) into patch 1 (Jakub)
> > ---
> >  Documentation/networking/netmem.rst                    | 5 ++++-
> >  Documentation/translations/zh_CN/networking/netmem.rst | 4 +++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c              | 2 +-
> >  drivers/net/ethernet/google/gve/gve_main.c             | 2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 2 +-
> >  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         | 2 +-
> >  include/linux/netdevice.h                              | 8 +++++++-
> >  net/core/dev.c                                         | 2 +-
> >  net/core/netdev-genl.c                                 | 2 +-
> >  9 files changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> > index b63aded46337..5ccadba4f373 100644
> > --- a/Documentation/networking/netmem.rst
> > +++ b/Documentation/networking/netmem.rst
> > @@ -95,4 +95,7 @@ Driver TX Requirements
> >     netdev@, or reach out to the maintainers and/or almasrymina@google.com for
> >     help adding the netmem API.
> >  
> > -2. Driver should declare support by setting `netdev->netmem_tx = true`
> > +2. Driver should declare support by setting `netdev->netmem_tx` to the
> > +   appropriate mode:
> > +
> > +   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
> > diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
> > index fe351a240f02..9c84423b7528 100644
> > --- a/Documentation/translations/zh_CN/networking/netmem.rst
> > +++ b/Documentation/translations/zh_CN/networking/netmem.rst
> > @@ -89,4 +89,6 @@ dma-mapping API 去处理。
> >  使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
> >  人员或者发送邮件至 almasrymina@google.com 寻求帮助。
> >  
> > -2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
> > +2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
> > +
> > +   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 8c55874f44ca..ed9c22dc4a5a 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
> >  	if (BNXT_SUPPORTS_QUEUE_API(bp))
> >  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> > -	dev->netmem_tx = true;
> > +	dev->netmem_tx = NETMEM_TX_DMA;
> >  
> >  	rc = register_netdev(dev);
> >  	if (rc)
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > index 424d973c97f2..dd2b8f087163 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  		goto abort_with_wq;
> >  
> >  	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > -		dev->netmem_tx = true;
> > +		dev->netmem_tx = NETMEM_TX_DMA;
> >  
> >  	err = register_netdev(dev);
> >  	if (err)
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 5a46870c4b74..fc49aae38807 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >  
> >  	netdev->priv_flags       |= IFF_UNICAST_FLT;
> >  
> > -	netdev->netmem_tx = true;
> > +	netdev->netmem_tx = NETMEM_TX_DMA;
> >  
> >  	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
> >  	mlx5e_set_xdp_feature(priv);
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > index c406a3b56b37..138e522ef9b9 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > @@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
> >  	netdev->netdev_ops = &fbnic_netdev_ops;
> >  	netdev->stat_ops = &fbnic_stat_ops;
> >  	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
> > -	netdev->netmem_tx = true;
> > +	netdev->netmem_tx = NETMEM_TX_DMA;
> >  
> >  	fbnic_set_ethtool_ops(netdev);
> >  
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 0e1e581efc5a..580bccb118a0 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1788,6 +1788,11 @@ enum netdev_stat_type {
> >  	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >  };
> >  
> > +enum netmem_tx_mode {
> > +	NETMEM_TX_NONE,		/* no netmem TX support */
> > +	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
> > +};
> > +
> >  enum netdev_reg_state {
> >  	NETREG_UNINITIALIZED = 0,
> >  	NETREG_REGISTERED,	/* completed register_netdevice */
> > @@ -1809,7 +1814,8 @@ enum netdev_reg_state {
> >   *	@lltx:		device supports lockless Tx. Deprecated for real HW
> >   *			drivers. Mainly used by logical interfaces, such as
> >   *			bonding and tunnels
> > - *	@netmem_tx:	device support netmem_tx.
> > + *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE or
> > + *			NETMEM_TX_DMA).
> 
> 
> nit: if you happen to repost, listing enum values here seems too much?
> 
> "device netmem TX mode" should be enough

Will do!

Thanks,
Bobby

