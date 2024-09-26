Return-Path: <linux-rdma+bounces-5107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE8986C3E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 08:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EF61C22369
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 06:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3B84A2F;
	Thu, 26 Sep 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnZ+mago"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24D1171C
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330726; cv=none; b=qH3Km9B7jUFdp/Uu+316zULx6/Xq7Cl7+jQRo4cQeZeUtrfxK9NDFYRCl/tqN4hbJZMULlTr1sSP/n1Q3vIGGNTkXaOugiXwfEoGQQUESAoZq4r9Khu5EwQ4VaKLATVV6IL+rwMszN3oDto6/n+peCvZ+7zgx/IgGikD9OnG7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330726; c=relaxed/simple;
	bh=L4B7GUMTcAOaC37vrRv7FHfKm1CAydT6EJkocQXC6+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HslfwFjaEstf5eE+/LHOtvUI0yCCeS7tRaQajIXT9Cn0I6AamvIgiGcx5B8u5WHv5apg+pNJccz2tCU8TM3TzssBA0yDn4b7r34wpj/3Ha9zvSPz03q5Z8CR0MtaM+aLGzBTcznPA1QirKng+I3wyv9Ge6pzztjyS3cSwYynWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnZ+mago; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC7BC4CEC5;
	Thu, 26 Sep 2024 06:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727330725;
	bh=L4B7GUMTcAOaC37vrRv7FHfKm1CAydT6EJkocQXC6+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnZ+magooz+emKwdS58PpUoPQEOj4ineck06+RHd2YEeh1qMAjwXphzj4EYCxIDjA
	 FjhEjlJg+rjnDZsf8gRyaZDuLbuR38wcm2D/zXJrrGfqMJcxpcaR4R7GFgfp2opWO5
	 4GGnZF0NV1Z0Cw3YSHMJcQt81oUACN0sVIPTH8QYuWMSITSdMuOHnx0MplI12QKsII
	 UDntaFufRE9QY9dI/A8Fw+jVckbXjjS02Xko9wfvlDlysIb+3Ccs6hbUdm7pjsvcIZ
	 x/GfGtRxubrs5HWU0JTUW5rI+bAwJL70Qn9pAP7IZcv1ln+aRAWRfMxq3BSW8Oedbl
	 Ih663GEF+hAzA==
Date: Thu, 26 Sep 2024 09:05:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: fix kernel panic for RDMA loopback
 test over VLAN
Message-ID: <20240926060520.GF967758@unreal>
References: <20240926055705.77998-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926055705.77998-1-anumula@chelsio.com>

On Thu, Sep 26, 2024 at 11:27:05AM +0530, Anumula Murali Mohan Reddy wrote:
> ip_dev_find() always returns real net_device address, whether traffic is
> running on a vlan or real device, if traffic is over vlan, further
> derefencing real net_device address leads to kernel panic.
> This patch fixes the issue by using vlan_dev_real_dev().

Please add kernel panic message and Fixes tag to the commit message.

Thanks

> 
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

