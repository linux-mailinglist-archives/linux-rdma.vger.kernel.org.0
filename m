Return-Path: <linux-rdma+bounces-3363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E8910F5A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7191F22A95
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CB1B5831;
	Thu, 20 Jun 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEZpg7BC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4271DDEE;
	Thu, 20 Jun 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905240; cv=none; b=Er7S4rro5Q/ekfkNAyrBApQtoxv0dunBld4T73yERVi5+PB622812bH9uKEFZl+nm6a29NNRY5cNcf/zaIor3xCNZaUxMzlM0TFJiF2NSR2LsTSMLZx9HelO0F39EmMhdKxh55oLIaREHLGC6ooYht6DQwNhQ0MVtpa8L0UYYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905240; c=relaxed/simple;
	bh=T/yfp30QLkswItvLIjhSZVSRq/qaXupa+HCdhVeqDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRaOmfc87zaXnYztv7LEdDbKN9yarHIYYSOc1AEP33Jkmj/4jPutr4zVviWWyCcROp/oBDDsN+8WnerCLU4Ymif4j/oCGTBT8M0KBkLzV0gS4jH/cO0mJyRgYe1i9l2he8HT2QzXnbZKb2j+htsJZV8byv9Yx5Z6N671IO1grtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEZpg7BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10EEC2BD10;
	Thu, 20 Jun 2024 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718905239;
	bh=T/yfp30QLkswItvLIjhSZVSRq/qaXupa+HCdhVeqDI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEZpg7BCWLS3xa4vyX7apo4QMY8P36A7LzltzwEENCRmPe0dCeRU+bssqRinXpt2v
	 k4/F0A8xqMjUbOtgM+D2UUyzpny5Vn2mCfAVZv1eYPIO6PQWksyZBp56/STVoIiEwO
	 T59sJeka0OBoj9ROKGo21i72GXM7edotFvFkDgLFDPe3TAc/Lpo7O2PsaLI1ss1gL7
	 V3vGsuyJzZwkG3en0g4tbS0EnWJKzLpb1XRmk5ELXLErYhECh3I79dwIqUiXYkRLyS
	 LxtCQTDwik+hyF+8qCBZmj2iShEN+F5afjPpgRtpyKNrmZjWFS04Yg//UilHd+PLMq
	 PLzeiUeQXjwlw==
Date: Thu, 20 Jun 2024 18:40:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
Message-ID: <20240620174034.GQ959333@kernel.org>
References: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>

On Wed, Jun 19, 2024 at 11:53:57AM +0800, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:1518:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9361
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


