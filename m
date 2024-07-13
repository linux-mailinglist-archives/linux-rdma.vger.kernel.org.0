Return-Path: <linux-rdma+bounces-3856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390B9307E4
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2753F1F21DCE
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE914EC5E;
	Sat, 13 Jul 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhn84gL/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE031487CC;
	Sat, 13 Jul 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911067; cv=none; b=Bwg1XLld2pES7ZoQxuoa0GM53xEM9SBeTJBEoKGVz5emev0GIdDYxkU93wKJSOib8UltRVaABbK1TpCMrzdDtqQGGkpHMmi1XA0mXl5fxlPvngri3qh1P3qlhfGEqe8/Q63DfXqLlB53XJXPc7dN0CN3SQ0EAfuudDC7WjrG3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911067; c=relaxed/simple;
	bh=XPM/dAuo9BmoeqUluLKdSiEYzO5ZFH7rSKTwCw3ZGBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWS6zMMg9muxrB5swiTHg1bndpwAFu49oJuDapXnuxDJOfwfFOHCOL7eiKpw2hdoqqxwiLqG2y7ngTNG4YzSs79cMaDBnXvhN2iOKcrgnlV2pxvq65SMv3kogxORnnQpAQNY03xFdIba4yxEjWpIvbQ4q6Qi/m/l3b5dskywOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhn84gL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18ACC32781;
	Sat, 13 Jul 2024 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911067;
	bh=XPM/dAuo9BmoeqUluLKdSiEYzO5ZFH7rSKTwCw3ZGBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dhn84gL/JjgpABXLzfrRTNIqT6fp0EYU+HVhJci09rOy7xwdezs7087qR3htdZ13C
	 +Tx2oKPZ/3YXWtzlfYFrnEXV7EzR3Jb2yrxryM7eNxuDX+ro3ZQQgesQjbOXW/4neh
	 J6GEANZFGcdnYIrlaAEOYspcWY2A4nmi24JtU0lVxq7aqg8bgxiWT7qx0plNizJdIo
	 rdgEHoVYgoK5WPzcH2HwFKvbgYhT3iP8xUyVa/5UBMO15CcssGaraIeXp8o1PSTDDd
	 8PyUpIm/gugcH4kQy8/v+eB7yDFVId00NVUQpKR4MqyNr6DmP5jXlYcdPu7sv2t/V+
	 KL0w7JJC8Bzxg==
Date: Sat, 13 Jul 2024 15:51:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Parav Pandit
 <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [GIT PULL mlx5-next] Introduce auxiliary bus IRQs sysfs
Message-ID: <20240713155105.233dd84a@kernel.org>
In-Reply-To: <20240711213140.256997-1-saeed@kernel.org>
References: <20240711213140.256997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 14:31:38 -0700 Saeed Mahameed wrote:
> Following the review of v10 and Greg's request to send this via netdev.
> This is a pull request that includes the 2 patches of adding IRQs sysfs
> to aux dev subsystem based on mlx5-next tree (6.10-rc3).
> 
> v10: https://lore.kernel.org/all/2024071041-frosted-stonework-2c60@gregkh/
> 
> Please pull and let me know if there's any problem.

Hi Saeed, when I pull this I get:

  net/mlx5: Reimplement write combining test
  RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded
  driver core: auxiliary bus: show auxiliary device IRQs
  net/mlx5: Expose SFs IRQs

and the subject says mlx5-next, so please confirm if you want me to
pull this or there's another plan..

