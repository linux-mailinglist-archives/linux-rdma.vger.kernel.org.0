Return-Path: <linux-rdma+bounces-12625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5AB1DBDD
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94020164A49
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98F26F469;
	Thu,  7 Aug 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO52dCIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459711E51E1;
	Thu,  7 Aug 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584627; cv=none; b=UWAWD2n+nsYjTCBDLZZXVKzP1HAtqOPjED1q6Ru0ylyLV8RowaUpZSxmLJ34X+SWoPZ14wS+6q7EueNi55zvAMwkNmUH3erTFJx6qKBzogld2TTxudeJkGhMpQZDHB2Yop5LvJAkEPffW7Pfx1ia3VOCETAcl2QwWpYvQKXZXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584627; c=relaxed/simple;
	bh=zomcDO4/e6tVYDJ09eowMniQElY2LtXTQlGbYTzf2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnxztwqxOralZC2EoIOBfBh3I5NDA9MTW/UDVvYk7hKA+RW49+oXYn/LOevlUjmrR+Pjoy17yO2X+PUQywDmqbXzAETNl8QWX+B+8tQrFspd4njo74uZ86nR4zlZSvjH5KYWy9wL5Z3WKpPcsxGp401cfDLPw0yhuxWzFYtbb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO52dCIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C44AC4CEEB;
	Thu,  7 Aug 2025 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754584626;
	bh=zomcDO4/e6tVYDJ09eowMniQElY2LtXTQlGbYTzf2h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO52dCIaKqa26qqpxLkhG8XwAQ80fNIKVuSaPVpx+Edgoc6cXl+P6huyeiJBe+PhM
	 RFdIqJ6b7PLsYnfHXqkfE1+hw3SqZ8ohukCgPrQAPI3lhMXPzVs6tNyFbDRRCWQSml
	 m6N/kvK7/nrL57PWIRF/pK3558oPZsYEyjT8pQcLKWlLs2YuYu+qC6Q91kLYqRwfqw
	 tGLCQUaeoPMB3B3Io4/ci1XmRUAqrWX+GnRkieIJs3JtH3taNAQ18Nemzya+qLGTyK
	 KtW5LnVziFBlrX45eNzd0xFcTu2pVMG4dfDNLuOx0vgP0fUk1BQIqAFtaIDeYHRKNu
	 8nAjgfz8GM/sg==
Date: Thu, 7 Aug 2025 17:37:00 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
Message-ID: <20250807163700.GL61519@horms.kernel.org>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-9-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-9-wintera@linux.ibm.com>

On Wed, Aug 06, 2025 at 05:41:13PM +0200, Alexandra Winter wrote:
> Register ism devices with the dibs layer. Follow-on patches will move
> functionality to the dibs layer.
> 
> As DIBS is only a shim layer without any dependencies, we can depend ISM
> on DIBS without adding indirect dependencies. A follow-on patch will
> remove implication of SMC by ISM.
> 
> Define struct dibs_dev. Follow-on patches will move more content into
> dibs_dev.  The goal of follow-on patches is that ism_dev will only
> contain fields that are special for this device driver. The same concept
> will apply to other dibs device drivers.
> 
> Define dibs_dev_alloc(), dibs_dev_add() and dibs_dev_del() to be called
> by dibs device drivers and call them from ism_drv.c
> Use ism_dev.dibs for a pointer to dibs_dev.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

...

> diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c

...

> @@ -56,6 +65,33 @@ int dibs_unregister_client(struct dibs_client *client)
>  }
>  EXPORT_SYMBOL_GPL(dibs_unregister_client);
>  
> +struct dibs_dev *dibs_dev_alloc(void)
> +{
> +	struct dibs_dev *dibs;
> +
> +	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);

Hi Alexandra,

It is not the case for x86_64, arm64, or s390 (at least).
But for x86_32 and arm (at least) it seems that linux/slab.h should
be included in order for kzalloc to be available for compilation.


> +	return dibs;
> +}
> +EXPORT_SYMBOL_GPL(dibs_dev_alloc);

...

