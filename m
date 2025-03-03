Return-Path: <linux-rdma+bounces-8274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE375A4CDDA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD5A7A51CC
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC91F1301;
	Mon,  3 Mar 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb7YuO3q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA11C5D76;
	Mon,  3 Mar 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039585; cv=none; b=TVVf9cGrc0MzAt1Hg37N2NFuINA5kLAnFSRcx0QhzV+yPBaNxbh/ceBbl8s5xhH1aG09tRNGVAIkysFTurg/zNAWJWrK1u1KjGJ1v51Xy8FGHg8TLvwDFBwaM8xniFSjbA4sTdZo2weyflQ9TkIqwHr+P0OPlXM0KJr+ylkz4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039585; c=relaxed/simple;
	bh=FY/qsZhygWjpuZGgX6rBNXN5tHiCmpxfGg9KBXeSsns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9YUz5r0rHL68whx7gAzLWnjmYEZzepoF86BuWmmw6ufio9HasxcFivzvIR/SoUjhfqw/8d6L5seQAr/ei7G4fYQ463++ArsCtUCUbM5gBHtVnGCs5b9jjjdgH4BXEaKCTHU5zEIJFGSqgyGnG/6fQgG4+5Lh4niEQ7q/g+WPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb7YuO3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7FFC4CED6;
	Mon,  3 Mar 2025 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741039585;
	bh=FY/qsZhygWjpuZGgX6rBNXN5tHiCmpxfGg9KBXeSsns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vb7YuO3qusoeGBK0ko0zGkWzbW0j60MrIHFJCRkty0pmhdHlOLosQneChGVWkCpWK
	 GGWLUAVDRAn3qwttsxsUgO4BQ1NQOTmw3MNsq3KQR1+2ZSuHps9/DDxTNZoMTNZb8l
	 j6DkB+Ww0IQMuCr3apzU9f/i+XRhaLCJmyN2LF3jjGD4Zb1KYZToLE56VK3DNGOSCe
	 CDIQeqGJ1C2EF5QlF++js63NJmHKjfL+QHEVK9goGsKsupXUPcuiJigi1DtXQvinWP
	 FGPvYENokF2qsZj/6cBoT+NVJJQn/I7cx3R4SstAPNx7Dm04z3RNNzurk3zsDZu1/r
	 1kDGhR5Vv3nyQ==
Date: Mon, 3 Mar 2025 14:06:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate
 domains
Message-ID: <20250303140623.5df9f990@kernel.org>
In-Reply-To: <kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
References: <20250213180134.323929-1-tariqt@nvidia.com>
	<20250213180134.323929-4-tariqt@nvidia.com>
	<ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
	<20250218182130.757cc582@kernel.org>
	<qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
	<20250225174005.189f048d@kernel.org>
	<wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
	<20250226185310.42305482@kernel.org>
	<kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 13:22:25 +0100 Jiri Pirko wrote:
> >> I'm not sure how you imagine getting rid of them. One PCI PF
> >> instantiates one devlink now. There are lots of configuration (e.g. params)
> >> that is per-PF. You need this instance for that, how else would you do
> >> per-PF things on shared ASIC instance?  
> >
> >There are per-PF ports, right?  
> 
> Depends. On normal host sr-iov, no. On smartnic where you have PF in
> host, yes.

Yet another "great choice" in mlx5 other drivers have foreseen
problems with and avoided.

> >> Creating SFs is per-PF operation for example. I didn't to thorough
> >> analysis, but I'm sure there are couple of per-PF things like these.  
> >
> >Seems like adding a port attribute to SF creation would be a much
> >smaller extension than adding a layer of objects.
> >  
> >> Also not breaking the existing users may be an argument to keep per-PF
> >> instances.  
> >
> >We're talking about multi-PF devices only. Besides pretty sure we 
> >moved multiple params and health reporters to be per port, so IDK 
> >what changed now.  
> 
> Looks like pretty much all current NICs are multi-PFs, aren't they?

Not in a way which requires cross-port state sharing, no.
You should know this.

