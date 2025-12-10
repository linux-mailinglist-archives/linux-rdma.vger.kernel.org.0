Return-Path: <linux-rdma+bounces-14949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B6CB2DAC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F8230AEC8D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2231B111;
	Wed, 10 Dec 2025 11:49:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696A3B8D67;
	Wed, 10 Dec 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367377; cv=none; b=HDJD4PALjqdtouUBMscZg1MzoYd0xkeUiGj5adJkKlHBsPiM9KjBp4DH1HqDR+7qX/y6qLSyvioGyuRN9xRrlh2A0KYYI04ANHpdPO8Vfvtb3+kSU1FwznQQXIG1PStLPvNyx5j63+rHKQwLwR3HJEQ9sGDbWmqfAk3oYDURPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367377; c=relaxed/simple;
	bh=KOB54iCbftV4526yBv+6XAewjZUQgJj6wjdObDTABUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6TX6Wr6UIdOzhJ8PlUHCLCBd51JrsYxt7hE/P2y4Fg9a0sgRATRfytAXirdoQscVDhGlLTLzDRpcK9yS8Q0X5CnJaA51bMIIh2VSuGBp7FwiJWDfc/XOajQQujtQs1jJZ0jY7s4PbLj0uBN6BMOjqBZ/wbn3KBSp6m81QUR9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8FB153B;
	Wed, 10 Dec 2025 03:49:27 -0800 (PST)
Received: from [10.57.45.72] (unknown [10.57.45.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77063F762;
	Wed, 10 Dec 2025 03:49:28 -0800 (PST)
Message-ID: <c78de0f8-fc58-4fde-b39f-4b6dcb34a3e5@arm.com>
Date: Wed, 10 Dec 2025 11:49:25 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/pan*: don't abuse current->group_leader
To: Oleg Nesterov <oleg@redhat.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <aTV1maDfDvqgu1oT@redhat.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <aTV1maDfDvqgu1oT@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2025 12:39, Oleg Nesterov wrote:
> Cleanup and preparation to simplify the next changes.
> 
> Use current->tgid instead of current->group_leader->pid.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>  drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 8041b65c6609..1ff1f2c8b726 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -17,7 +17,7 @@
>  static void panfrost_gem_debugfs_bo_add(struct panfrost_device *pfdev,
>  					struct panfrost_gem_object *bo)
>  {
> -	bo->debugfs.creator.tgid = current->group_leader->pid;
> +	bo->debugfs.creator.tgid = current->tgid;
>  	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
>  
>  	mutex_lock(&pfdev->debugfs.gems_lock);
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index fbde78db270a..29cc57efc4b9 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -27,7 +27,7 @@ static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
>  	struct panthor_device *ptdev = container_of(bo->base.base.dev,
>  						    struct panthor_device, base);
>  
> -	bo->debugfs.creator.tgid = current->group_leader->pid;
> +	bo->debugfs.creator.tgid = current->tgid;
>  	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
>  
>  	mutex_lock(&ptdev->gems.lock);


