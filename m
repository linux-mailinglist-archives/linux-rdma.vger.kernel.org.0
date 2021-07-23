Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866423D3B71
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhGWNMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 09:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhGWNMJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 09:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0D3D60EE6;
        Fri, 23 Jul 2021 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627048362;
        bh=RNXg8/C+IrtgrBMwx3jmxhil9oDOOdRisD6WNe25kt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMsRiFjmrQ/Oae2VOm9ClsBETdG5QUJ4ykX94vi4tX4IvvkM3yn4pDSmP+eJgIg1j
         47QwmbPPKhaS6tssprvP239otj+nuJu+u8C0k74eyvnt5s40FLkcbdAiftzE8b/+tM
         cZZwEK0x511Nj5kGWLAUA7UA1IP9SX26QorVdOIbi7Ru3oQufK2LP3msF+mpyg7Gdg
         v5OgC3yIPOmEFpCoVyfMgDzk4VUaXB5G6dxRLoxnYydCwPWVF6FaT5NzmnGOMPHHAe
         ouD84pFCKnXqKi4uAiFWEYxVx024o8sz/8Pgy0YFIF7SP7gR41nUD+OtQkYSrfQJPF
         HPTBrG0ZwceRw==
Date:   Fri, 23 Jul 2021 16:52:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] docs: Fix infiniband uverbs minor number
Message-ID: <YPrJorr7r9Kd2IzA@unreal>
References: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+ RDMA

On Thu, Jul 22, 2021 at 09:45:07AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Starting from the introduction of infiniband subsystem, the uverbs
> char devices started from 192 as a minor number, see 
> commit bc38a6abdd5a ("[PATCH] IB uverbs: core implementation"), but
> the documentation was slightly different.
> 
> This patch updates the admin guide documentation to reflect it.
> 
> Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/admin-guide/devices.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 9c2be821c225..922c23bb4372 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -2993,10 +2993,10 @@
>  		65 = /dev/infiniband/issm1     Second InfiniBand IsSM device
>  		  ...
>  		127 = /dev/infiniband/issm63    63rd InfiniBand IsSM device
> -		128 = /dev/infiniband/uverbs0   First InfiniBand verbs device
> -		129 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
> +		192 = /dev/infiniband/uverbs0   First InfiniBand verbs device
> +		193 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
>  		  ...
> -		159 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
> +		223 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
>  
>   232 char	Biometric Devices
>  		0 = /dev/biometric/sensor0/fingerprint	first fingerprint sensor on first device
> -- 
> 2.31.1
> 
