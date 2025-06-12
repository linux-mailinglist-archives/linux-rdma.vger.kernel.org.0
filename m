Return-Path: <linux-rdma+bounces-11250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14607AD6BA0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E5C1BC06B1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A99223327;
	Thu, 12 Jun 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf3bJRLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045B2248A4;
	Thu, 12 Jun 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719134; cv=none; b=bnxICNS1g8q97ggMypqV5YPP3s3tJmzws4n2vTY95iuXfWms/yJosiQdGER02BivVg/4um3vUZaaCc3dA7HlyvYcg4R2n5DSGeAoUl4O0prCkuW7jxd2aXJsoJYjgIWHk300qut6MZEZtsZ/EvRBFVm8zQC3japSkHxpUb48EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719134; c=relaxed/simple;
	bh=uRr9v6Xv+pJykUSbnzHiJ1zbG+Wh48DPc2ZUVr7PVpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QjZ/S+W3E+1IqF3Ic2XZ1dFtcDD078hn6ePJV4651jQRrtM2xn9IcrYL5I5MfXzDDtvW9y6l357MdF1UIqy7j2UeEDuDrSi3rlx0Z3EAUwCjhy8fQnMEFSzQplzHnff9bMVgtHWJb+XEu9RgPWJ/kytoVxsayIYv4aFuDGkIcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf3bJRLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58ECC4CEF0;
	Thu, 12 Jun 2025 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749719133;
	bh=uRr9v6Xv+pJykUSbnzHiJ1zbG+Wh48DPc2ZUVr7PVpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Uf3bJRLmOeYep9Oa7Gaa2FThJb3mrJQms97Q3EPpD8/sCIDB9gTc1UK69LtxIHUku
	 dw3C+k2zUf9Sc2HWUMRsAAmKpn/XMDFOGR2V/620+KzmkHtAGzFOcQSXWWoOTFK6yw
	 1lw4t2RJswfJVv6G0ki+cLtTvStaS7BOlPDr6SsG/PkUBVae4Akgvghhah60Q0V6w7
	 iEj1uOH0MKuujxQI3fLEIVWGX08WPDUBPv0nYqWoltRXqTLqTWxqsgr37ItIYV6YIN
	 4twOoIlt4Wv7yEOgoJJbAKw8p5VFaF9ekAtGJ7PVIObiPBn+j22+3iUAxa6HLDawWp
	 dVLrM8sHeakCA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Patrisious Haddad <phaddad@nvidia.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 Serge Hallyn <serge@hallyn.com>, Chiara Meiohas <cmeiohas@nvidia.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250610092846.2642535-1-arnd@kernel.org>
References: <20250610092846.2642535-1-arnd@kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: reduce stack usage in
 mlx5_ib_ufile_hw_cleanup
Message-Id: <174971912969.3783933.11490887989460650891.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 05:05:29 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Jun 2025 11:28:42 +0200, Arnd Bergmann wrote:
> This function has an array of eight mlx5_async_cmd structures, which
> often fits on the stack, but depending on the configuration can
> end up blowing the stack frame warning limit:
> 
> drivers/infiniband/hw/mlx5/devx.c:2670:6: error: stack frame size (1392) exceeds limit (1280) in 'mlx5_ib_ufile_hw_cleanup' [-Werror,-Wframe-larger-than]
> 
> Change this to a dynamic allocation instead. While a kmalloc()
> can theoretically fail, a GFP_KERNEL allocation under a page will
> block until memory has been freed up, so in the worst case, this
> only adds extra time in an already constrained environment.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
      https://git.kernel.org/rdma/rdma/c/b26852daaa83f5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


