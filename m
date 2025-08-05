Return-Path: <linux-rdma+bounces-12592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68022B1BAE0
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A8624F4E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18F289804;
	Tue,  5 Aug 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayTwqv6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E82749D5;
	Tue,  5 Aug 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421680; cv=none; b=m0KZRL//EKeO2qDS7vjuXW//yxRcUmMGfcZgyN44cPpJUxCcmxXizM8tLm6x/bc8pWffRI1mrhjl6KeRF71AuzaB3rAi7J+5HxEweEjsmjysL/JtePqumxaGBJPFESrj22JH9+3wdwUoL2wxRYGNcAVwWCD53UoxH+NNG8UjZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421680; c=relaxed/simple;
	bh=kiDUfumk7urniobiimJVpztWStswxpnzCCTx7M+MdDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez6M9v1UpOKR/O4f0YpKnOzGqYenNhm/Yz+lrI3WFMzOcxjkMC6YiyfxTYuRaUEq29hVlWMo+O/pUEPcFJcqJlKMTT/hUYspbXWN6y64pvNoE9H6Rju2ECXMBlT4lJkFe6WSzJ9p/OPhP+MYS0GIUZ93vq2Aa6skKQM69oOE4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayTwqv6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA854C4CEF0;
	Tue,  5 Aug 2025 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754421679;
	bh=kiDUfumk7urniobiimJVpztWStswxpnzCCTx7M+MdDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayTwqv6gYMSGIOdqhtZnIq5FUMAuXVEYD9sl3a68Jfa9StEGuCJZRSjnJfperzF1X
	 i7YuRVMWJa1Fl7Dj258V3DozaIzyug6oG5nDeTh+o5g3wIsjv0JAMT4AM/wMAJXKB7
	 54nicvNDf042EFM7VgjoatJeOQdy22b8qnePL1rLQlZAfupYbtZi/BUocAxyuPB+dN
	 6V3JYxMMP66zW96QbPkKZlrOiMNvirL6JJs+6c/IUCwcDoxeu0tR+b254I7GrETO8B
	 8rfNW4xxZIAcRSDeYYGcpMgbiOHkTxunBq+E89yExDpBFsY25RSbsKwk3UJw1X5WzB
	 vb/WFzqgZqI3A==
Date: Tue, 5 Aug 2025 20:21:15 +0100
From: Simon Horman <horms@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
Message-ID: <20250805192115.GZ8494@horms.kernel.org>
References: <20250805025057.3659898-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805025057.3659898-1-linmq006@gmail.com>

On Tue, Aug 05, 2025 at 06:50:57AM +0400, Miaoqian Lin wrote:
> Replace NULL check with IS_ERR() check after calling page_pool_create()
> since this function returns error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.
> 
> Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


