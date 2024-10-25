Return-Path: <linux-rdma+bounces-5518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885969AFD8E
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99B01C24C1B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C081D63D9;
	Fri, 25 Oct 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRo5tg5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C21D460E;
	Fri, 25 Oct 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846988; cv=none; b=IqsxDt8UbAnEeQ3hZbBqYSWRZOFgNExfEe67GJc/HVr3QP4iEqtzWKjs6jTSS0Tc4UBBT1IOLUo2RH9CGSbKmrWbR3qjsw7j4FNDvRrNVa/Lu5g5grPs9JpH8bXlpZALHid0F6DJLdwL6fNAFIsN4smzGYK5YVRxFkq1k8BUe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846988; c=relaxed/simple;
	bh=WKmMTBfANmCacReoFHTW1X38nivdbJdP+FhsmVt6+cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/RqUWbKwd/jj0vrs9vh+DCKd+KNIzbiid8t5SvkY7FNpseswdndHGGFEIho4gjJtdE8kR77KbG1k0ZgZiqNn9pMtTz4MQOY2AfwcGVSS3G0MMpdSvjduUweOztVkn2ZuCltF1lcWXuCVxoZo/VNikumn4V1ATD+catyBZ3R0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRo5tg5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2C9C4CEE4;
	Fri, 25 Oct 2024 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729846987;
	bh=WKmMTBfANmCacReoFHTW1X38nivdbJdP+FhsmVt6+cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRo5tg5jwjJ9hS2Rxaf2myofD4rZLjLuf7Az9NZHlnFuygjFBvOg4aU1v0v+xJWWP
	 Xb+9u0TjbAKdGOkBBjMmRzlbDNXM/nISxcgUtOt/vXu78EbhUyetI9I+yb4x36qrHt
	 4WXRZPmxhXwqq3okgaAYSckDQjwVvh+Od9Grawzzb5LDWyfGn37seg+cCM6L1gSy9G
	 s3IEpEsw0s3ZYd+saXzlJ4RM9atdnOHBfMm517FGR9Q+//tHK1hu+hRHgXjW/xT/aT
	 RhxvzXEi53psdKxdtxzef9XEC5lr/Uq5FuxYzFWlGoXL33n2R/rSaog7Im4QPQFDRX
	 v1GZgV2ASepVg==
Date: Fri, 25 Oct 2024 10:03:03 +0100
From: Simon Horman <horms@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: simplify EQ interrupt polling logic
Message-ID: <20241025090303.GH1202098@kernel.org>
References: <20241023205113.255866-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023205113.255866-1-csander@purestorage.com>

On Wed, Oct 23, 2024 at 02:51:12PM -0600, Caleb Sander Mateos wrote:
> Use a while loop in mlx5_eq_comp_int() and mlx5_eq_async_int() to
> clarify the EQE polling logic. This consolidates the next_eqe_sw() calls
> for the first and subequent iterations. It also avoids a goto. Turn the
> num_eqes < MLX5_EQ_POLLING_BUDGET check into a break condition.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Simon Horman <horms@kernel.org>


