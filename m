Return-Path: <linux-rdma+bounces-11600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17523AE6EFD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96031BC5187
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE282E762F;
	Tue, 24 Jun 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0XKRnlR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887D4C74;
	Tue, 24 Jun 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791460; cv=none; b=BfM25aoSN7QgPsDGjXRUh03BD4jKXo6CzITcZdZ8Oj+qZcvdblmoGS/7idwX5WrpuXBORepflNP16FuWXJ68vaVmV4MeL1+27iwEih1CPpawmXJ3VgWO/axXoOkyonSIqZ32c4STXm6fCnqxK3W9jtQNUiBivF70nXe3v+tORJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791460; c=relaxed/simple;
	bh=dKlzfhfYCOk+6oWAgSeZ+UzMvemD6r5lY0TDyUsT4ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBQ0RDU2fR358iIDfWNWWNyRRePUxNGsD02X0kJvTLgJ1tTmZ4T4zwVrgyxHvoWyTIQoFhOZgVkTsKJyZ5gsnS/4LZdQGmgfT8m8oWh7t2xWG225+UJ7gptsmgyleQoVi32YeUliJFm9u4U8IXNBsy5tB6bWRJN4OvFZWekIu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0XKRnlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAF0C4CEE3;
	Tue, 24 Jun 2025 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750791459;
	bh=dKlzfhfYCOk+6oWAgSeZ+UzMvemD6r5lY0TDyUsT4ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0XKRnlRJv6lUxwMp7n3ZO9Zpr0FYgyCOUyS58b1WSVsowpO6mQv2jGpPRzGAzVts
	 iGhWFsfdgnROlbbo1uWvt5kdIDRS7vKP20b2HZWhM0n58GWdN1Q8I902JbGGuexa+k
	 II288MKu0ZobMCqvkK9cuK65QGJXAnmitB3TlDHQyRZuF0PUDb0/S2hOo2GHCFMfF5
	 szvmbdZRG0neE/8KgQu16NIIKOUvrI+OdyNE7EphK+WtzVcHQ0OENAp+3JQqgcbf5y
	 g+yiEnnnPRFwyJWZtv0Pc/bGY4uDY9G06lrcxcP9yiwvw7syiZILhtgh15FIYs0NLf
	 rPQpV5LnM4pfA==
Date: Tue, 24 Jun 2025 19:57:34 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v2 4/8] net/mlx5: HWS, Create STEs directly from
 matcher
Message-ID: <20250624185734.GG1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622172226.4174-5-mbloch@nvidia.com>

On Sun, Jun 22, 2025 at 08:22:22PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Matchers were using the pool abstraction solely as a convenience
> to allocate two STE ranges. The pool's core functionality, that
> of allocating individual items from the range, was unused.
> Matchers rely either on the hardware to hash rules into a table,
> or on a user-provided index.
> 
> Remove the STE pool from the matcher and allocate the STE ranges
> manually instead.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


