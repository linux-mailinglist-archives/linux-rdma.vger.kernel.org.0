Return-Path: <linux-rdma+bounces-12985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE284B3AA98
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 21:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F291A0357C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E7335BCB;
	Thu, 28 Aug 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0LEEhgP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5523322A2C;
	Thu, 28 Aug 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408155; cv=none; b=QhXQOGART95fgQA7QMS1mI9uUQkUFRKmjZI5iyHtUUJUcCa5H+ZOFqw48UVIQOL1Zl98n9+bqgKjvBVr9AWyQXRuHjHT/QvUu8ATAyplpYD0vRy3RzV0Wvbi8JdQIkwlsMOyKhEtfE8VjsMea8U5dUO2Tva8eLqlDJBXtLHbzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408155; c=relaxed/simple;
	bh=WsHbenj5KwFFzOUaeFvWZ8WFGYghepGFMuFzgg1hvoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGx3Ek+pWyOLLG5IG5k/pmCoc5+EB9Erlz7mYhMmVDw3p2GuJcQmyo6xkCVpmf9su7RG0wNxip4PJR0Um0o3s9Cuock6lwMzpgEq83G/AN/9xTsmqqXYYKdWFCFM6REkpPx3AnVaOpTPnpwABIwcqfUW/WiH+nHgwW9Hqvwr41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0LEEhgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CA0C4CEEB;
	Thu, 28 Aug 2025 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408154;
	bh=WsHbenj5KwFFzOUaeFvWZ8WFGYghepGFMuFzgg1hvoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0LEEhgPXy+04+eP5bD10uPzoef9ViUGTpwSK6kj2BOyvmblYg0xEIWlxfm1vDWSZ
	 a39zqIOqgoyWFmxmy1D3MCEf6DvG1Vrzy1TcrXw2uGuvbRkV/bu93G6j/glYwvXccC
	 CDfPusna8PQvOeMLfcT6d4JZSm/oQK6Fe0oEvqnfaGit6Xetm//zEQY6jCZk//OkS8
	 Eov9VO3gr6IP6lUKrVUOHbhNdI/nms7VSj4IVVlXf7YiSkXGlo4IN3lGx49uivHFWt
	 uqj9xkTXTzxZ9TND61ObklUWZsafiR0kMgKXvioMMPrI7biXL8KDRspOR8yoc3zzqJ
	 Pbnhi/pnELWCg==
Date: Thu, 28 Aug 2025 20:09:10 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <netdev@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/mlx4: Remove redundant ternary operators
Message-ID: <20250828190910.GG31759@horms.kernel.org>
References: <20250827121503.497138-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827121503.497138-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 08:15:03PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


