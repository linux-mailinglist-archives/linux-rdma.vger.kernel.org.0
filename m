Return-Path: <linux-rdma+bounces-13789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE529BBEED6
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8FB04F0B6D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674F2DF15B;
	Mon,  6 Oct 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FccwG3B8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958A2DF142;
	Mon,  6 Oct 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774867; cv=none; b=KypNwVhXIBfsJyLjQh5Z5Fwj7w1bifFeNsoXhpf8ExtzsoBjx7oQzjanoHJMta7Klkfg5z4YkGIYtFAzplbGifJyNb9sWPgDnZQZLmacl2effRdjFttzMXDK9PWxXUI5ueeWuSWbOAmzpYDq8EwXae/+rcRiH+Ed+I0zgIbKFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774867; c=relaxed/simple;
	bh=0y6fRGLPsaAkHRl+rStXh6yawp7KVV4geyZJxkKo8CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfvM1/4eizAWf5S7gWX4lMeLhB6qx+Fb02bGMaVycqp8afl6XZmi8SzsaxI/O7/W10L5rLalF5qQNPmPOPzi8n2mEZCg3EASdfFBt6Z8eOlOQIEsuCRVa3X4LXfqGMBFmi2yvRGcE8IgklhosoO0gUsU3b/pSxF8g07rblSPTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FccwG3B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42551C4CEF5;
	Mon,  6 Oct 2025 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774867;
	bh=0y6fRGLPsaAkHRl+rStXh6yawp7KVV4geyZJxkKo8CQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FccwG3B8+HOUanbCPO507Hv5bliRw14wU9HMwJW/HqGu2qd3yjeX2WH/p/qu/x2dC
	 AN6VGxFNP3XuRdPzHasQEpJaTvd8Qb0mj7F04MqLqDUa+ouPQfDj4WzCW3hGGq1U2U
	 jb0XkGlE9lmM3H9IwdHf2VEK4ixxlDMTkUc599xJekL721Z/Nt3bz90I4TIIqACkCB
	 weZwHEG/jV4CLMk/DLLJOkrjHcl7ounQ/Vi1w1EGk81pFcO52NHov1NXb0Vk81BvzQ
	 f225eHW9mx9rExIRiMuzXMaudHGK10BVHWr8OkcEbJ5UNvKPZ6nIrnVYqmQflM09gk
	 xh+Cb+X6/XuCA==
Date: Mon, 6 Oct 2025 11:21:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Patrisious
 Haddad <phaddad@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Michael
 Guralnik <michaelgur@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Naresh
 Kamboju <naresh.kamboju@linaro.org>, Nathan Chancellor <nathan@kernel.org>,
 Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix pre-2.40 binutils assembler error
Message-ID: <20251006112105.3fb129f6@kernel.org>
In-Reply-To: <20251006115640.497169-1-arnd@kernel.org>
References: <20251006115640.497169-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Oct 2025 13:56:34 +0200 Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Old binutils versions require a slightly stricter syntax for the .arch_extension
> directive and fail with the extra semicolon:
> 
> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
> 
> Drop the semicolon to make it work with all supported toolchain version.

Saeed, could you ack? I think we should get this merged quickly since
it's a build fix.

