Return-Path: <linux-rdma+bounces-12628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C99FB1DE62
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D57562C4F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052122A4E4;
	Thu,  7 Aug 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGtRAl2V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52381F63F9;
	Thu,  7 Aug 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598885; cv=none; b=fOTwU/5+NLO/07QG+gDR6BjxXN/heLtWzXakHPDOYaml9N+gXs0Sh3mpcaiB+10OhjoY0FnKY0waj46tLE7ECRqkZXehcG5oOHuQgZyC+3qz6CC994hZkCFi8QkdNFjeLCRYUvtkiIYAfcRALxjLrjRUfRACcfZl5a//61H9YqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598885; c=relaxed/simple;
	bh=CTHF2bfLHWxAICz4XAIr2jbjPAcP4K25/pM82onpA4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWei3t8gmwmN5CwAj8oKSCaM9Hx3vGddTtLftrFeCPPB1AhTnibPrbH1NNopIXSIsoS0ToTS27YuaPN1XOcueHoUNjq1xoya+A2+UzEV/uHrZWGukbRhQgeQ9RGsCdZ8oneJ8vDirOOTHStmRtVUXcgquyT8S1Lwmrra8mBZ6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGtRAl2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23068C4CEEB;
	Thu,  7 Aug 2025 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754598884;
	bh=CTHF2bfLHWxAICz4XAIr2jbjPAcP4K25/pM82onpA4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGtRAl2VlG+N4Y5vl1pGJIVUbqHcsi8gpQ0mLYFb8KsjJ34yy9x+xJKcnpLMd0K6/
	 SC5+R1IDPVS4dRhjA4Y1KzgC/G8WM2yvCaE3zf05iVSsqe3vlXaLMycddMlZKbiQR+
	 EeaMGy+AsaJwy0IvyOuV/szzpTEDyyTut+I+MR9/8uiTCmS/VasdWQizTTU4AvWhMP
	 mNpK8S5fxz+o7jiDtTtcEKoogH1J7E9tY8o8bZiiGhC4ukB/uJDY9th257mTuo3nbZ
	 Te0pxToUyKVFRhwCKYol33CI5MlhjXjB1CRthICLU8pBlsYJnQ7EES8kNmeWfhQZ/J
	 UsBhitv56bg4w==
Date: Thu, 7 Aug 2025 21:34:38 +0100
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
Subject: Re: [RFC net-next 16/17] net/dibs: Move data path to dibs layer
Message-ID: <20250807203438.GR61519@horms.kernel.org>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-17-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-17-wintera@linux.ibm.com>

On Wed, Aug 06, 2025 at 05:41:21PM +0200, Alexandra Winter wrote:

...

> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c

...

> @@ -33,18 +32,18 @@ static void smcd_register_dev(struct dibs_dev *dibs);
>  static void smcd_unregister_dev(struct dibs_dev *dibs);
>  #if IS_ENABLED(CONFIG_ISM)
>  static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event);
> -static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
> +static void smcd_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
>  			    u16 dmbemask);

Hi Alexandria,

smcd_handle_irq is only declared (and defined) if CONFIG_ISM is enabled.

>  
>  static struct ism_client smc_ism_client = {
>  	.name = "SMC-D",
>  	.handle_event = smcd_handle_event,
> -	.handle_irq = smcd_handle_irq,
>  };
>  #endif
>  static struct dibs_client_ops smc_client_ops = {
>  	.add_dev = smcd_register_dev,
>  	.del_dev = smcd_unregister_dev,
> +	.handle_irq = smcd_handle_irq,

But here smcd_handle_irq is used regardless of if CONFIG_ISM is enabled.

I believe this is addressed by the following patch in this series.
However, this does result ina transient build failure.
And they should be avoided as they break bisection.

>  };
>  
>  static struct dibs_client smc_dibs_client = {

...

