Return-Path: <linux-rdma+bounces-2950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203E8FF0ED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651ACB313B6
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492B19CCE3;
	Thu,  6 Jun 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJE2V8YE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063019B5AF;
	Thu,  6 Jun 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686360; cv=none; b=Dl84akiRejCVwE/PO96SkKJzvsCc01p83e4G6yezPqqLn3pyyfPHb6Hja1vlrAZC5b84oCaDH+Ur3TiI7ov3sFOuR3eOsr+966CpbJMdvc6rKYENDRsJh/qh0Mo5TzXSKtWg5nKnCps2OZ6GTHAbRJ0xYRbx9RRT+n/dkh0E7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686360; c=relaxed/simple;
	bh=Cx1ASgr5Lh9FnhS81vNXx9ifwngxlnqb6mSkxtlQWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoZiv1i5U2riKVY3i8WIifRLxOqXqz0iXpDceKtP3TNM3hK8yFXFOCdCjrUBSuxkz9iIT1i3aj+zet4CYsJROnOaznuXkM/hdShPK09tYWFTPct9kf77kHnRaOji54TV6z7oaUrBsgGAVIQDf8qUJy4/BVWrDDMi1SYFkH0unkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJE2V8YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE65C32786;
	Thu,  6 Jun 2024 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717686359;
	bh=Cx1ASgr5Lh9FnhS81vNXx9ifwngxlnqb6mSkxtlQWLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LJE2V8YEAvQg7dOKXsKEM5ZXvqkbYqfFpDavrIE6ibwGQcnoFfSGpEp8uH6O2dBXh
	 ry6vAyt/lvcu4dyXJSiclI99AznFEB4pNXp6HGBksXMOjk30byH8gnCE5AR7SIVNSO
	 Kg0dl7aWs5jSK0RUeDauQN0Ju+JQ+594Y3sUss5DvrhtJEsIO+8NAKaHnc/qONUpy6
	 QVyI5Tz4Lqwh7/c3aVSsFsSevkBTGQbRV5t4hOIerNIAtSSu/LDA5j+SLQmBfCxJdI
	 0p31Li9bp4O9xYsLd+rxa4GxL2m314+VzaGe2Q1k0q23qZ3DaiXKR2PQVg7zZ++SsW
	 aMc6qVH8HvpOg==
Date: Thu, 6 Jun 2024 08:05:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>, Itay Avraham
 <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606080557.00f3163e@kernel.org>
In-Reply-To: <20240606144818.GC19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240605135911.GT19897@nvidia.com>
	<d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
	<20240606071811.34767cce@kernel.org>
	<20240606144818.GC19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 11:48:18 -0300 Jason Gunthorpe wrote:
> > An argument can be made that given somewhat mixed switchdev experience
> > we should just stay out of the way and let that happen. But just make
> > that argument then, instead of pretending the use of this API will be
> > limited to custom very vendor specific things.  
> 
> Huh?

I'm sorry, David as been working in netdev for a long time.
I have a tendency to address the person I'm replying to,
assuming their level of understanding of the problem space.
Which makes it harder to understand for bystanders.

> At least mlx5 already has a very robust userspace competition to
> switchdev using RDMA APIs, available in DPDK. This is long since been
> done and is widely deployed.

Yeah, we had this discussion multiple times

> I have no idea where you get this made up idea that fwctl is somehow
> about dataplane SDKs. The acclerated networking industry long ago
> moved pasted netdev in upstream, it is well known to everyone. There
> is no trick here.
> 
> fwctl is not some scheme to sneak dataplane SDKs into the kernel, you
> are just making stuff up.

By dataplane SDK you mean DOCA? I don't even want to go there.
I just meant forwarding offload _which I said_. You didn't understand
and now you're accusing me of "making stuff up".

This whole conversation is such a damn waste of time.

