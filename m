Return-Path: <linux-rdma+bounces-13089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9232CB43F2A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105F8188DD51
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC593101C4;
	Thu,  4 Sep 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caxBkIhM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B630AAC7;
	Thu,  4 Sep 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996425; cv=none; b=Yb8j/N52c7JqG7+CefJ31RNChJq7yXJr+xqkV5Po8vxpk2Z6k6cmzqnLpRLJv3eoqsKIMklQQWIh8AgdKrNpC5vLjGHY1gszLEQjr4TDAkiD2vFosTXi0obLidp6NdKdijzKX93nsSUooyt9tNI2DzNWOovNkc0f0czCKROYNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996425; c=relaxed/simple;
	bh=aF9kWeDpl3fpdV6dkQuM0f9fEHlPUWDVl9sB8BjZwjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5sXZFUHpwnHk57+OpLNwEsnlmbPBWyaaECdE2Q/tazE4NBMOA35J9WGseiEOsgyNZ/H1FAnEs+M5IDWOk5Y6StyfK/m+sC39aPmrF2aL2WXbUcZ17mFXfcbqyXPi9IIGMCVABntPayko3NReO2yOn/r1JeVC12qKRNZOLP6Lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caxBkIhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB8DC4CEF6;
	Thu,  4 Sep 2025 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996424;
	bh=aF9kWeDpl3fpdV6dkQuM0f9fEHlPUWDVl9sB8BjZwjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=caxBkIhMIC4FS5w3ScigznHa5TVb7eRgEn6nOsIk096Ye0DuPFIGbsVfxnn5zPd2i
	 gPv8su2LOd0tZk5hqCUxu9/t3FEZHdcWlAdtyRvneRIhQLIYLe9ooHUiIXq4rIQe/y
	 byfiaJ6l6q504oPccnTeWKUsPOYVwON/tEEL3bQ2Et5BBpEdH2o0I/6Y4PUrWmsxXb
	 AEr5dHZGZ+qITWzJ7BX1sAOt6WBFPsyudOY1sklnYkcJrId5lc6D40WfA2TC/9BecP
	 94qXvXfLQScWDapKcMN73homgB2w+akRHaeUVIj4Bu7d1+aWi2GmsL+l5c+fcM/xH1
	 HjV1UwDc24JrA==
Date: Thu, 4 Sep 2025 07:33:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Allison Henderson <allison.henderson@oracle.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, OFED mailing list
 <linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
 <rds-devel@oss.oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] rds: ib: Remove unused extern definition
Message-ID: <20250904073343.1138ce24@kernel.org>
In-Reply-To: <44A12092-5DA9-4A3C-ACBC-FF1AACB03BD3@oracle.com>
References: <20250904115345.3940851-1-haakon.bugge@oracle.com>
	<20250904065502.13d94569@kernel.org>
	<44A12092-5DA9-4A3C-ACBC-FF1AACB03BD3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 14:22:02 +0000 Haakon Bugge wrote:
> Sorry if I have mis-interpreted the collateral. From [1], I quote:
> 
> "A Fixes: tag indicates that the patch fixes an issue in a previous
> commit." As such, it is an "issue" and I reference the offending
> commit.

You're not the first one to misinterpret it, I guess we should fix the
doc :$

> As to "Cc: stable", you're quite right. My bad. You want a v3 or are
> you (and stable) able to handle it?

Please repost this one without the extra tags, and if you want it to go
via netdev the subject tag should be net-next in this case (it will end
up in 6.18)

