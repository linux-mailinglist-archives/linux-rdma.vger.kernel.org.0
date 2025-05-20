Return-Path: <linux-rdma+bounces-10433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC3BABD318
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A252F4A73D4
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F121264602;
	Tue, 20 May 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMOfEWVA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD625D8E4
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732603; cv=none; b=RfsfbAEgRSEzL9nkCXN0phpF7Y0nNEeBSq6fzxfTv7A2NtV9VrMgJFenO1T5w20nYaNa6vrUm1/kD/I42G/QGRmK6BtLSle5eIUauhP+OQqi2JwuxnvIF/orvaIavvKJJU0XDS6nwejqkRy53GHJaZiAQRl07uiVZXhkWKxYsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732603; c=relaxed/simple;
	bh=0IyP0W/nyym4onsH5sTTxS+N0cmP4rLgTKZYMCTLHFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNRYb0P5kmnmp3lwhGD0VFx9oXJhcFMRB1iDqo53U4xRf+WJbj/l8t1LmxTBem/dOFWkzMkIV5bGJU7cqZYSwP07GSOIMFe6qFSUVHh4/hXAmyrRVLPxWrgUt1lnPFTBjxx3L55OM7xQPw+nMzz3ientONcv0LuJxl1y1NiMoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMOfEWVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E636DC4CEEB;
	Tue, 20 May 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747732602;
	bh=0IyP0W/nyym4onsH5sTTxS+N0cmP4rLgTKZYMCTLHFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMOfEWVAf11esiGLlz/eVSN5GLQvZC0y/mSv8JXvdNbM6lf2ox8rO+PPv0HP5QI09
	 ZLiScXFuCGDOBxrYDAEy6gEzDf98WVvEBVqaDmw9QKSUYusXwbJjU/BmsaBWU+tQfs
	 tE80pcGliMUevoTDLs5VH8E8TUrpNrg9itvNGhSuGtAZe16+Eh6JsSl8h06GPl1zhP
	 ZljpDcXHhLhQpzD7MoYwrDg/1EXYRUxtNYnHtMFvDK6HlCkL61otXHLX9SXkt0l5hh
	 j0eyiCt5qR44CnKCQRuuZkKxqbP4OKKt6A9qNDoIiYoB3te/4IA4CIKATQVEdoLLac
	 xHeIePnpfjjMQ==
Date: Tue, 20 May 2025 12:16:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Message-ID: <20250520091638.GF7435@unreal>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>

On Sun, May 18, 2025 at 11:56:56AM +0300, Margolin, Michael wrote:
> 
> On 5/18/2025 9:42 AM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
> > > Add an option to create CQ using external memory instead of allocating
> > > in the driver. The memory can be passed from userspace by dmabuf fd and
> > > an offset.
> > EFA is unique here. This patch is missing description of why it is
> > needed, and why existing solutions if any exist, can't be used.
> > 
> > Thanks
> 
> I probably should have explained more, the purpose is creating CQs that
> reside in GPU HBM enabling low latency polling directly by the GPU. EFA
> isn't unique in receiving pre-allocated memory from userspace, the extension
> here is the use of dmabuf for that purpose as a general mechanism that
> allows using memory independent of its source. I will add more info in the
> commit message.

I think that this functionality is worth to have as general verb and not DV.
mlx5 has something similar and now EFA needs it too.

Let's wait for Jason's response before rushing to implement it.

Thanks


> 
> Michael
> 

