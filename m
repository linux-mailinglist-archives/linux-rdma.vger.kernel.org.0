Return-Path: <linux-rdma+bounces-15123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33494CD3CA8
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EB9730041C7
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651A242D62;
	Sun, 21 Dec 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXqwdOwL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0367218AC4;
	Sun, 21 Dec 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304219; cv=none; b=OMLO6+dgPI1/lHY8cSYY6dTaXrJHqLgPrmfbIql3UG7Z+oAT7oja5919YYtncugpnTVHj0K4Zsb0Jh+VzGdoO4i9GWDJe7xw1dSqvGrbF5QbnJZzvktCjesqlecboG9LEOrWo6WP9GfbHrn+OdNuoFFxzmUeqTclC2srvJs/yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304219; c=relaxed/simple;
	bh=+zi1N9VwIHER6WrxiBOiWYKoYPkd9jJMNes2GHR5m70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nirPAXtogrPvuOpzGg/corE4foY/nGu74rNWpRIW1MqTItbJXfAYLJGZ211gQHZ2mngEvL9u3o9oucdoKAGy4CjmYHCcfIs6dnBv2W38REXVnZBL2R2qqA6AAjqxLx+lte0OZeldsJnUjYLMhz6gMoATRCB+GMS2iieytT6iqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXqwdOwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACFC4CEFB;
	Sun, 21 Dec 2025 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766304219;
	bh=+zi1N9VwIHER6WrxiBOiWYKoYPkd9jJMNes2GHR5m70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXqwdOwLJ1ot4Bd4V/La84l2fstRHfEoLIoVohfCehi9MV7T8WvAShPZZ+v8LrZhR
	 3BFIsHFbTumZDqr6Nt25eHtWOr9k9dYWchpzOOj0hdeBDJ/vd8xs89zzxH6CW2emJd
	 V2RHp7g5qD5MXp9fTMoG5A8ow8OutFG5kesc3YZlzaeOgXZp6FmJcyN8ZKhGurL5pb
	 57yprU/oxN25dR5AqrwBziuJ6jAFSwdLredWN/dbii+H7PtMLYJ08cBULM1imNVFvd
	 +2QBcrmWgMiYrEUFNElGnYuOaLq/2tjlIzQtn+i69mf00YLdha1UTTbtKEKq/egmUv
	 vwOTp3WtjzUtg==
Date: Sun, 21 Dec 2025 10:03:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 6/7] RDMA/umem: don't abuse current->group_leader
Message-ID: <20251221080334.GC13030@unreal>
References: <aTV1KYdcDGvjXHos@redhat.com>
 <aTV1pbftBkH8n4kh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1pbftBkH8n4kh@redhat.com>

On Sun, Dec 07, 2025 at 01:40:05PM +0100, Oleg Nesterov wrote:
> Cleanup and preparation to simplify the next changes.
> 
> Use current->tgid instead of current->group_leader->pid.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

