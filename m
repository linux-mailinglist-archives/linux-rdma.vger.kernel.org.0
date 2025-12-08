Return-Path: <linux-rdma+bounces-14915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C5CAC7CF
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 09:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB66302C8F8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E329B8E0;
	Mon,  8 Dec 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ixQkjy7r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B532580DE;
	Mon,  8 Dec 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182233; cv=none; b=ghgTgxuBf8KwAGdMupBym9vFiABUz1AaDBJqcXQYvBDu8m4XfMTXyGh0TUVobG+2JJBcs2my7LvJ/W90ekD9GiSfMFrADzywascdsqMr8bMPLURO9vBrX4DI71IWF/Nv7/3w158CvjpJtymb7nmBct8rg4XCClESO4Uk5ZC3bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182233; c=relaxed/simple;
	bh=HahwClOUPbY8lYOiDnAM6v1rk/QJWpGTlK1cCdtwK0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNgKh38LsGGExaNW078B4i4Y0vL8y9OWHlSZY9+Pfgm/G8FMkDtKNKuGdC2WAKF7Hl8UriASomJi7rUEqUYeUyPfggI1zI7wcwI6MDuW3EC14bXNyoPtiHuADrAgG/qcEcgKpCgw5YQ6bWYHftaoYWAnLCxdNj3BXUsPHsbbiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ixQkjy7r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765182229;
	bh=HahwClOUPbY8lYOiDnAM6v1rk/QJWpGTlK1cCdtwK0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ixQkjy7rJibW29crRfhTQtaul/vOnLCOvAdfgkKV5rrYSpOijD+Sx7VeFnQT12TzM
	 ezC1jZOAPUsDizd7ZeNCEJoZVoL/7yfmHTOAqLBrWCZOQovKxaWpP8R4WIZWPA9fwe
	 5JVYhPylQIle5ukhirviQLjACzt2mwW3u7vovoJ2hYaPppC/yGr/8pzdHr1geXYShE
	 /WN1ipP+MpVOKJkBFIAUXR5dNstvYk38jhvCBJ8d9k20Bd0YdaOAXCeVaXugKAnk64
	 xCouvH8RDyY6nvIWoEHOwio+mo3HpmjNNyPIgfQIkz3Bo7Rh6VJdNLKnPGIcOSxzmm
	 AYOnOT5jFe1Zw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F3C0217E0E30;
	Mon,  8 Dec 2025 09:23:47 +0100 (CET)
Date: Mon, 8 Dec 2025 09:23:43 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan
 <surenb@google.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Steven Price
 <steven.price@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/pan*: don't abuse current->group_leader
Message-ID: <20251208092343.2cbca352@fedora>
In-Reply-To: <aTV1maDfDvqgu1oT@redhat.com>
References: <aTV1KYdcDGvjXHos@redhat.com>
	<aTV1maDfDvqgu1oT@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Dec 2025 13:39:53 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> Cleanup and preparation to simplify the next changes.
> 
> Use current->tgid instead of current->group_leader->pid.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>  drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

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


