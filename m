Return-Path: <linux-rdma+bounces-7359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84352A258E7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5851881681
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA320408E;
	Mon,  3 Feb 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMS8eUQ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA211D618C
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584199; cv=none; b=ZDVmybdnA0+XfiVHFqzuvZq19tetbL+hG0x1xZh9hSALjvjA273vxMN0yfyFaA+04uRWlR/EU4XK6Ckyx9oQDLr6HugtRbGu5gQfD2yqASKqNSj0nb65K2s0kzjGhQqT5Pk3mTkI5G9tgZQBKhOVQKyByjIh7HeHQiAguy/aiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584199; c=relaxed/simple;
	bh=fzaywycdluOdukb4TkRdLi2EOKLCRw5ud14gqzj2rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ypy1TzMEJ2H43mV1GWrDxkHnP0d1v/oAnISdlb3xW6GwCRoJ+9zkPVXv9mS7aNjScXzOdnoPrXiK0FVvwUj4tpZ1G9BhL5lZ0Brea1FU8vLQcmIPNxwJFo3zgqgNP4NgZfdIOyjwzP2v3ftC86UiZEFpl1VuWrZ+IxO8pHGMKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMS8eUQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B8C4CED2;
	Mon,  3 Feb 2025 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738584198;
	bh=fzaywycdluOdukb4TkRdLi2EOKLCRw5ud14gqzj2rcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMS8eUQ/LYjX0gxR9pvEOVyB/g3zYLsu+AnPjM8c91Cs+Maxdc4SCV+bD7l1tbDAu
	 l3qVjMHZtbenJBfFUJ9yDXbWKyHz2I91VuicGYho8X2Tdsxx/uekHyAXgMdB9PZfSh
	 6oHlzv+nBJOOW7Ig3Ef1vG7/q+ExYKMVE2ciPgV6+8u1HczYqj/Ibhy2DdOLB17Nmv
	 01EtBK/DIOfpzGkREEUULzemzDFFryY/cDks+9sNpQa9ytsUm+kOA3lVyM4KvnCsG5
	 fZIy+7li7FUypplWd7ZSLMXRtvZPIcOs57bXFUrUbBW50MNb+37wGR5lzmxzlCkSQ6
	 25nijb/CZbtGg==
Date: Mon, 3 Feb 2025 14:03:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
Message-ID: <20250203120314.GF74886@unreal>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>

On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> Implements routines to set and get different settings  of
> the congestion control. This will enable the users to modify
> the settings according to their network.
> 
> Currently supporting only GEN 0 version of the parameters.
> Reading these files queries the firmware and report the values
> currently programmed. Writing to the files sends commands that
> update the congestion control settings
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1 -> v2:
>   Addressed Leon's comments
>      - rename debugfs file "g" to "run_avg_weight_g"
>      - Fix the indentation errors
>      - Remove the unnecessary error message during the read entry point
>      - Fix the return value
> 
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
>  drivers/infiniband/hw/bnxt_re/debugfs.c | 212 +++++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
>  3 files changed, 228 insertions(+), 1 deletion(-)

We don't have strong policy of what can/can't be in debugfs, so let's
take it.

Thanks

