Return-Path: <linux-rdma+bounces-1386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE3877FCA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7271F21FA5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4B3C493;
	Mon, 11 Mar 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU7AuY1I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08613D57D;
	Mon, 11 Mar 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159438; cv=none; b=tV5/bk9+F4USvMIRziRB0Fr1IJT3s17bEzvHaaPbUEILtRojTaeASNsMIKkIKeVz9Fg6QuuDOlX+j3iZ2TyK7CU2c3wjP5N1FBbkjv+VcFHAod3lwvuXfBxxlbnEWAvoN6K3oarRxm5a5DAcgsKbNYX46FFcy374Vf72nlRnzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159438; c=relaxed/simple;
	bh=NMP2UXbhXQeXR5/a88AEqvzN4xBbgLW8HHOoxRUmxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz03VrqBseSLmS9s8xviHZaDE7zGaqi9WVdeY8nufYgLQGlbowwo7AoPsS35KIxYXieuWDQ9GoZt3C+G2NimFQ8dJYbPNjpaVt9lUjOPtP6HWGcOnZnr4s0qbTn4UDGgL+IYoJlQo0EFyqZ8f8L2mIWv6eNjVa9hg+ztkwjwEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU7AuY1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83095C433F1;
	Mon, 11 Mar 2024 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710159437;
	bh=NMP2UXbhXQeXR5/a88AEqvzN4xBbgLW8HHOoxRUmxAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pU7AuY1IuYOk86GJ80t2EfDe7LDmTqOwTKM1IJrUsYV0auWz+TsyNvv/KV2L/CwWR
	 2xBLpofSgmMfJYTfhi0nMcd4RJgYoEgJVLXbaBUmuN1ZU4a17VAcf8sYD0O/s1wvTn
	 bSKZvW6N+6pw0UgFMEQ4of7kNrsmDbDCjR8EvI4+gTTH/56hhjE5lm+Whpe65TkQR3
	 CguHexm7mvf0MqNWM8sPpdxfpqUVzv+vx8wQPNVsyBrnhdo6quJNEqbwmLwHyxP/Qk
	 uqUxDYY8Z2L/61Gvbx2XWuioHtxSRzVDQthCZBBcB8DX9voepNuEDszY3Chrh4esDH
	 roAD8TVQ/WdmA==
Date: Mon, 11 Mar 2024 14:17:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	kuba@kernel.org, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240311121713.GK12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
 <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>

On Mon, Mar 11, 2024 at 08:05:45AM -0400, Dennis Dalessandro wrote:
> On 3/8/24 1:29 PM, Breno Leitao wrote:
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the priv space to embed their state into net_device.
> > 
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from struct iwl_trans_pcie by converting it
> > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > net_device object at iwl_trans_pcie_alloc.
> 
> What does an Omni-Path Architecture driver from Cornelis Networks have to do
> with an Intel wireless driver?
> 
> > The private data of net_device becomes a pointer for the struct
> > iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> > given the net_device object.
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
> >  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)

<...>

> 
> Leon, please don't accept this until the author resubmits a patch that I either
> Ack or Test.

Sure, I will wait for your response.

Thanks

> 
> Thanks
> 
> -Denny

