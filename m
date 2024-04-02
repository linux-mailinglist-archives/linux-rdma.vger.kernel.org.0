Return-Path: <linux-rdma+bounces-1745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B38895B8E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D028491C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302615ADB0;
	Tue,  2 Apr 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+yjw4zb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985915AD93;
	Tue,  2 Apr 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081831; cv=none; b=qDW2INzw0z1uaHJtOoF3RDfj1eWoOPRfaykjSgWBNm1b4G0Xs/E6gjA1etdQ5KeUo4Pr7WGhckbv37/Xw1TRMmYSzAzMj27vywnA7xBJNCbGLiSGRqlMHCpadzo4rXwwguVKNXY53R2au8D5jEy7MHiu+ljqC5xXNw+GG9/dMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081831; c=relaxed/simple;
	bh=0ARxQ9cttIE0P2km3rZwYbhh6JliaUfiHYwzzaExkGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl7tryfoaBhtwZg0zYm85HH5uHtvPW2p3xeSIZgChNn1dWNwioTxOokKirEwA+uJVQ1lhYPSXN+LwhBoXKz5ynJFZLUnp3Kh5GwUO6v2HYVCDIgrPaj6wTtHcww0fjDoPOCoDFilWFNmo00KdtwKIsEc5fn6Qge6894vj3MTC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+yjw4zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81759C43390;
	Tue,  2 Apr 2024 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081831;
	bh=0ARxQ9cttIE0P2km3rZwYbhh6JliaUfiHYwzzaExkGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+yjw4zbZrlaNcUDJqfUE1ixZtxbFznrXU41+a50ZKjM18TdEcXy7iCKOK1++lPZC
	 l56y++MenbvUEkO+T8DPS7RkQQTktGT31vMpgMvsDF/TquT2gp6WMPiv9fhhM685A1
	 QWEW/yo54O55Hvv+3X/XoCgOxGGTZrRDzn3HRIi9LYU47NwkPyNor16r7gEFiCaEhK
	 /2PVXeM1GJKFzq44zMrRda/Y1oNWRCm7FVvPshqW+P6tyilCpXVaMbvs7Skvorzf+R
	 iU4CizFo8Y3jtTcCT9gRupQ9keLHAXkwj2zPJ7q3xEiWc3j5WulFe+Ffohs6F28Gc8
	 MDboiPygc/dAQ==
Date: Tue, 2 Apr 2024 11:17:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, quic_jjohnson@quicinc.com, kvalo@kernel.org,
 dennis.dalessandro@cornelisnetworks.com, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Dennis Dalessandro
 <dennis.dalessandro@intel.com>, RDMA mailing list
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <20240402111709.1551dbca@kernel.org>
In-Reply-To: <20240402180155.GM11187@unreal>
References: <20240327200809.512867-1-leitao@debian.org>
	<20240402180155.GM11187@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 21:01:55 +0300 Leon Romanovsky wrote:
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>  
> 
> Exciting read for people who remember this conversation:
> """
> > I prefer to see some new wrapper over plain alloc_netdev, which will
> > create this dummy netdevice. For example, alloc_dummy_netdev(...).  
> 
> Nope, no bona fide APIs for hacky uses.
> """
> https://lore.kernel.org/linux-rdma/20240311112532.71f1cb35@kernel.org/

Still my preference, but there's only so many hours in the day
to keep explaining things. I'd rather we made some progress.

