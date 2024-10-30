Return-Path: <linux-rdma+bounces-5604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537429B589F
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 01:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EF9B22517
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428E1AAD7;
	Wed, 30 Oct 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7d81MN4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2253199B9;
	Wed, 30 Oct 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248171; cv=none; b=MarXMVTkIVQssmqDe3XnGGuqhbtY/aCwh3kPS9kRd9dkeqHR3dZIE6Bb7Zh+VBECTnmMu32VXIjzCANClewTzx1l/6nLO2DCWXGjM4mv1u+Z8m0j4lcbihp/kvV/TOF7f9sY2bhs4w5+iqZ9y5u8U+z6451vaFCAjKiIspYTMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248171; c=relaxed/simple;
	bh=eMi76h+gnkIlCVRKtYeW5iwSbJRftD+3SbTitdjyuxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bA767Txyh9v3xzfaoIdSjFp1NiLuZrG6ioD/GVMtTYhVC6hs3EL2uz7tBZ8X8G3cQJylPjXlxlUFpjv6EWUAf/z1fLyxulJYJoUeBns7MA900DxE1aehclDQ5pQa2ecCoNYEmnBcacsNIpDaHxWGzxgfErm63CSJTglkFQpx/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7d81MN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A836C4CECD;
	Wed, 30 Oct 2024 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248170;
	bh=eMi76h+gnkIlCVRKtYeW5iwSbJRftD+3SbTitdjyuxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7d81MN46wP7bND7cWzO77bysqx5h7Wi+T/VfcdnU1lSxGaNGZ7tOWmODZQvtfoqd
	 Sg5XsHjXiNCFhvvGUU1OR78J6z+RmyBAWq6F86F4ZwMbQJz8lxDD8ib9d9Ri1DRqj6
	 Y6tVTLFNLcghdelK7U2IE16LMCzSJ7hzcbXH6nyC4f5EA7uLkxN0AQ+TNrGfydfWOA
	 TCAXDZuB3R3M/tkQpvwrWn2kT4kAMJ0NxhBTGCo7GLPdWqeeUj0TJoZ+9y/fttt+Bp
	 1HOg5vYSDJ4jXIj5u9T1R82i3A62UtZDmwo90QZ73ljzZpHw7CGBbN9tzyYIZN7H0D
	 W4gUHVpVnynDg==
Date: Tue, 29 Oct 2024 17:29:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: fix typo in "mlx5_cqwq_get_cqe_enahnced_comp"
Message-ID: <20241029172929.497caad4@kernel.org>
In-Reply-To: <20241023164840.140535-1-csander@purestorage.com>
References: <20241023164840.140535-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 10:48:38 -0600 Caleb Sander Mateos wrote:
> "enahnced" looks to be a misspelling of "enhanced".
> Rename "mlx5_cqwq_get_cqe_enahnced_comp" to
> "mlx5_cqwq_get_cqe_enhanced_comp".

Applied, thanks!

