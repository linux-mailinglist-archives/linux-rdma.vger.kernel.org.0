Return-Path: <linux-rdma+bounces-4142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0F3944100
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 04:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD201C23ED4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 02:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9BB14885C;
	Thu,  1 Aug 2024 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIVWqgI2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9114882E;
	Thu,  1 Aug 2024 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478111; cv=none; b=C9Lif4PYKHeE8Ow1VKLX9rNoX3tAS6KQaoeOOQTpvXtOtb573SbRnEoCuM1HWuQAFXwxxksGcP/FN+d6ZL3/oNsAOdz7dJizlqjiiiI7zKkzI6kIqp6jVJ9O0QSKatbg1oxinSoDrxfzOYo7v9/0u01YiZjbUB1IcWj+5n23LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478111; c=relaxed/simple;
	bh=nfoZxe8BnAqJ+l7JU6yKUN7J+CqZ+4Wdu6VD6couVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVj1nr5lnzulF73CwOru6HB+ZS8q9PzDiRpe0EK+gdAWah1cQvhFOY5lycrGV24EeQMtqY61UaNtZZ0LQT8DdJ1V+BvKk8Djxl31Pqy//8QC5djjlkWYrUAa9fmYFbdsTHcofBOfDiOFW0HWrA9fod5qnoeKQxvBTOhOT/OQLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIVWqgI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D236FC116B1;
	Thu,  1 Aug 2024 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722478111;
	bh=nfoZxe8BnAqJ+l7JU6yKUN7J+CqZ+4Wdu6VD6couVvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIVWqgI2RMf6pXl/iUaFdwH+ROsDuCK80ky3jVK18hF+GKR+LwMM9NKyHsg/AXEA6
	 40zADRvERbd4EaOiYlAS4Dc7UP3XXU0y5ac/SfL5TC4i92ZOfYyywXuCT+wII+Y9Gc
	 ko6lCn6/ex0VU3Ru1gbDAZSmp5nGSJ/FcYjBHQHpnoiS0bIMTUpXvk8Z3/v9AzrZnK
	 C6YIrASJaU29CcRAZO8R+xCEYqBZRaI5DwN9lEPsqh4OR7kDZAwPsKiHsQ7yBgiDKi
	 3jJ4H6toQuhz3WutOYpZmNOvfaoEDnx4WfaLb2hVAHyDqgJTznBD3qkZQYdzqfio+t
	 Sk3EKlgOKPftw==
Date: Wed, 31 Jul 2024 19:08:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen Pais <allen.lkml@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com,
 mlindner@marvell.com, stephen@networkplumber.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 borisp@nvidia.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, louis.peens@corigine.com,
 richardcochran@gmail.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
 linux-net-drivers@amd.com, netdev@vger.kernel.org, Sunil Goutham
 <sgoutham@marvell.com>
Subject: Re: [net-next v3 05/15] net: cavium/liquidio: Convert tasklet API
 to new bottom half workqueue mechanism
Message-ID: <20240731190829.50da925d@kernel.org>
In-Reply-To: <20240730183403.4176544-6-allen.lkml@gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:33:53 -0700 Allen Pais wrote:
> -	tasklet_enable(&oct_priv->droq_tasklet);
> +	enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
>  
>  	if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
>  		unregister_netdev(netdev);

>  		if (OCTEON_CN23XX_PF(oct))
>  			oct->droq[0]->ops.poll_mode = 0;
>  
> -		tasklet_enable(&oct_priv->droq_tasklet);
> +		enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);

Could you shed some light in the cover letter or this patch why
tasklet_enable() is converted to enable_and_queue_work() at 
the face of it those two do not appear to do the same thing?

I'll apply patches 1-4 already.

