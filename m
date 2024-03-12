Return-Path: <linux-rdma+bounces-1396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B7878F40
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 08:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351A61C21216
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF46996E;
	Tue, 12 Mar 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or+eoyVy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DF16FF2B;
	Tue, 12 Mar 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229961; cv=none; b=IlRTs8Ehw7bE67lmA4JG+Ey367rbhWeRn4sqw1reab5Wd2l5x/XZQHAZSwjWfpuQPHGv1ZboqYtEcOeNiRMQuP02f1O+KosxLHcgWJOFZeDU5PlcRTmS/D37lY+8BeSb9R86b1hfPlys7CGsWTG7RnVyiQg1YU9jgOCh0GMjTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229961; c=relaxed/simple;
	bh=pPdblc9BNa6xMJbEOXOEvKiHrD0Gt9YejfwF6KCsXuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez6Fpa52WlnkrVZ5FqpSv3y92ZWMbRNos0T0sdGRZI7+m1cIgCerefVVKyhXXoVS5aH6iU+del96/PxgnX7d8xOTlOUgMVNTVmFHau6E5RAoafRAPZ+y0Paw+3HjYhRfjqAarZ/GYHGms0aazGJ0vy+bNO77UCeNTfzABLX+xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or+eoyVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D43C433C7;
	Tue, 12 Mar 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710229960;
	bh=pPdblc9BNa6xMJbEOXOEvKiHrD0Gt9YejfwF6KCsXuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or+eoyVyA+bhQqmC/ZM64SUyqR6OxiupKbMH+fpY96t+wkRKf4pzKEIBMziijAh0Q
	 bxLxXQa/kNwik8fE91GwuQYtMKUzk3Yd7VD/SB1kR7KQC7Kg+vrZIAKz1bRPlWLUQJ
	 lPZAlOt7l/mRKSSKBv6vo2SUn9smoZOajJX+WWP4yk3l9KPYSw0dX7ysVyhD1Hyr3v
	 vB/ePActrxkDOfY567KAWNvw9dsvLQhAilku7dZeVvzn5tZq68pP7HMUefCDFTmNfd
	 sYbC5wMifEG/r/6xUb5TirohbZaEhNfMTPUmPAmbh/tIwrTDuYsZLXRPniVyu/gcCd
	 SGo5pt5p7/gwA==
Date: Tue, 12 Mar 2024 09:52:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240312075236.GL12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
 <20240310101451.GD12921@unreal>
 <Ze7YNu5TrzClQcxy@gmail.com>
 <20240311102251.GJ12921@unreal>
 <20240311112532.71f1cb35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311112532.71f1cb35@kernel.org>

On Mon, Mar 11, 2024 at 11:25:32AM -0700, Jakub Kicinski wrote:
> On Mon, 11 Mar 2024 12:22:51 +0200 Leon Romanovsky wrote:
> > > From my experience, you can leverage all the helpers to deal with the
> > > relationship between struct net_device and you private structure. Here
> > > are some examples that comes to my mind:
> > > 
> > > * alloc_netdev() allocates the private structure for you
> > > * netdev_priv() gets the private structure for you
> > > * dev->priv_destructor sets the destructure to be called when the
> > >   interface goes away or failures.  
> > 
> > Everything above is true, but it doesn't relevant to HFI1 devices which
> > are not netdev devices.
> 
> Why are they abusing struct net_device then?

Care to explain what is the abuse here?
HFI1 uses init_dummy_netdev() exactly as it should be used according to
the commit message.

This netdevice is controlled by HFI1 lifetime model and used for NAPI.
https://lore.kernel.org/netdev/1231906495.22571.79.camel@pasglop/

> If you're willing to take care of removing the use of NAPI from this
> driver completely, that'd be great.

I have no plans to remove NAPI from HFI1 driver. We are not against to
accept Bruno's removal patch, but we are asking for justification
in commit message.

> 
> > > > Will it create multiple "dummy" netdev in the system? Will all devices
> > > > have the same "dummy" name?  
> > > 
> > > Are these devices visible to userspace?  
> > 
> > HFI devices yes, dummy device no.
> > 
> > > 
> > > This allocation are using NET_NAME_UNKNOWN, which implies that the
> > > device is not expose to userspace.  
> > 
> > Great
> > 
> > > 
> > > Would you prefer a different name?  
> > 
> > I prefer to see some new wrapper over plain alloc_netdev, which will
> > create this dummy netdevice. For example, alloc_dummy_netdev(...).
> 
> Nope, no bona fide APIs for hacky uses.

Interesting position, instead of making simple and self descriptive API
which is impossible to misuse, you prefer complexity.

HFI1 is not alone in using init_dummy_netdev():
➜  kernel git:(rdma-next) ✗ git grep "init_dummy_netdev(&"
rivers/infiniband/hw/hfi1/netdev_rx.c: init_dummy_netdev(&rx->rx_napi);
drivers/net/ethernet/ibm/emac/mal.c:    init_dummy_netdev(&mal->dummy_dev);
drivers/net/ethernet/marvell/prestera/prestera_rxtx.c:  init_dummy_netdev(&sdma->napi_dev);
drivers/net/ethernet/mediatek/mtk_eth_soc.c:    init_dummy_netdev(&eth->dummy_dev);
drivers/net/ipa/gsi.c:  init_dummy_netdev(&gsi->dummy_dev);
drivers/net/wireless/ath/ath10k/core.c: init_dummy_netdev(&ar->napi_dev);
drivers/net/wireless/ath/ath11k/ahb.c:          init_dummy_netdev(&irq_grp->napi_ndev);
drivers/net/wireless/ath/ath11k/pcic.c:         init_dummy_netdev(&irq_grp->napi_ndev);
drivers/net/wireless/ath/ath12k/pci.c:          init_dummy_netdev(&irq_grp->napi_ndev);
drivers/net/wireless/ath/wil6210/netdev.c:      init_dummy_netdev(&wil->napi_ndev);
drivers/net/wireless/intel/iwlwifi/pcie/trans.c:                init_dummy_netdev(&trans_pcie->napi_dev);
drivers/net/wireless/mediatek/mt76/dma.c:       init_dummy_netdev(&dev->napi_dev);
drivers/net/wireless/mediatek/mt76/dma.c:       init_dummy_netdev(&dev->tx_napi_dev);
drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c:     init_dummy_netdev(&bus->mux_dev);
drivers/net/wireless/realtek/rtw88/pci.c:       init_dummy_netdev(&rtwpci->netdev);
drivers/net/wireless/realtek/rtw89/core.c:      init_dummy_netdev(&rtwdev->netdev);
drivers/net/wwan/t7xx/t7xx_netdev.c:    init_dummy_netdev(&ctlb->dummy_dev);
net/mptcp/protocol.c:   init_dummy_netdev(&mptcp_napi_dev);
net/xfrm/xfrm_input.c:  init_dummy_netdev(&xfrm_napi_dev);

Thanks

