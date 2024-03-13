Return-Path: <linux-rdma+bounces-1415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3387A60C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D801C21607
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510383D0D9;
	Wed, 13 Mar 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFMKzVpf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1FEAC8;
	Wed, 13 Mar 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326577; cv=none; b=E9f4tV88n/crEurv9JfzmndWI0olpg7+HfnS4vFh4JiDXngHFmP+stmyuoPoTpoIbSt7uDnyoIcGlBEQNvoCqURdlz5tKdPzPwxEtLMY5v1MBCbRRcBm2saXiVkf4jPlvivBm28TcE685O4zOJ1HdnFbS1P+yIFHvrZ049+M+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326577; c=relaxed/simple;
	bh=g8tA9wFEag5+QRV7OGwOBW6Yvz6OSanOITK6gWb4Gas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTpHcrTw0DVo++9pteW783we+eaeNQTQ9rCHPbJ6Xed45DSL1Gr4e0yeRNFgX43aBYJPDQOFPgQZI7+6ekowk5W6gS4VvyRvLuuqSDJgFMuOSkh8SgaecSGicPWB0/Vq5wnAWxVJnVdcDT4v6QB9GppAKpIRFNe3NHqVS6fp6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFMKzVpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F9C433C7;
	Wed, 13 Mar 2024 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710326576;
	bh=g8tA9wFEag5+QRV7OGwOBW6Yvz6OSanOITK6gWb4Gas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFMKzVpfMJwgI5O9uxaqtHfik8AA4SYFnbCvIfZBcZZ5MK+IOCPMVWVheckms7N3l
	 FkvK9+KYmWFj6fMX9Vnc/O48nUeF5RnG2j307rQKg304BZfWAkURzcK+E2nIzn3Rja
	 gE6PqwEx76sZ24uqt6KRS9zWkxJMhZRE5ubG302rYwWR4DUH03F5tpILPQzGhG4xzs
	 fi5E7kXbnXqBqpnvAXXnpI356lTcNDiD3zT3+ltYcP5itvJ2xD+F+Q49lR/ncCesiZ
	 o0D9IdGncz1g49C+Ud3v/iMUhbjElpg3cQ1lJOepAazRJaF3ETiC9F1Fg2hr4sxIR+
	 Yallcl0aDj9Ww==
Date: Wed, 13 Mar 2024 12:42:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240313104252.GA12921@unreal>
References: <20240313103311.2926567-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313103311.2926567-1-leitao@debian.org>

On Wed, Mar 13, 2024 at 03:33:10AM -0700, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.

"shouldn't" is a strong word, given the fact that original init_dummy_netdev()
was designed to be used in such way.

> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> ----
> PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> init_dummy_netdev()") in order to apply and build cleanly.

We are in merge window now, so if Dennis approves, I will apply it after the merge window

Thanks

