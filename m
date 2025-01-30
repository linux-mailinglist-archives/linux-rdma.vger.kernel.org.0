Return-Path: <linux-rdma+bounces-7335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A62AA22A64
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158143A463D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525319DFAB;
	Thu, 30 Jan 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD03vQCH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40B1553A7;
	Thu, 30 Jan 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229816; cv=none; b=cpy6FzCWX0CTYZi5vAS4QZK0saiXr0KtEzo8BIBUI1bDu2YjIZHNCx05l3RYIeF5qwcRyX5ESdOiw0RPOCDZDpKkIvGNRtOyOrqfTBrdZuFoJOgIX3iY33aHM7Cdx9mskuKZkxFAkBOxBSqHOYF9goPnF6Jd632r9vgKMnpswAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229816; c=relaxed/simple;
	bh=V1cZUvvofTc/IT+RjEXFm3iwKdNneKAKmls5cWOk7j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5uCxvj0ffsIK3hPZh3EN9OF0FmkB+sg42zy/7+sftjEoQ7n7/tnWJhhreiZ9veh+ISH8xAbJdDLXhGogSu+4YsFP7ZqQSQCWc9F4Up21UYdvEz3bc4M70BF8m56eFpRKfVS27uxKxh5OIZVdVdj+KShJlie0uzoTrySp+cflps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD03vQCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A2C4CED2;
	Thu, 30 Jan 2025 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738229816;
	bh=V1cZUvvofTc/IT+RjEXFm3iwKdNneKAKmls5cWOk7j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JD03vQCHrZfoIb/LQrzphrzv29e5sHlDEykWbZUyWJJLC3H2RfFNkPU8ZUPCB2A0X
	 /abt6IOk14l2Bp1ua9FaZGzvkUBrX0tWEzgn6MeUQOREjBoUNLlv9Ne+2CFGXbtdPP
	 O5G0XaiAD1bUzJ1HyBNLOjUo0fcW1YJipRdBexIxSAutFZGYHY4FpM0Rwan3tIzQBa
	 h1TNiQVysf94tVFu6ol1bP5UYV3Ksu6WLk1WS+0iOkkyFqBBVHGOORk5xrbTgAmn/U
	 bLQ5QLNjKokicOjoxYu7KUfaKwxR04uvlqvP9I9sy5Jo/mKgkk9R8oe2p8j7sZUyTG
	 RJt8OHVItv7LQ==
Date: Thu, 30 Jan 2025 09:36:51 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yishaih@nvidia.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] mlx4: Remove unused functions
Message-ID: <20250130093651.GB113107@kernel.org>
References: <20250130013927.266260-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130013927.266260-1-linux@treblig.org>

On Thu, Jan 30, 2025 at 01:39:27AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of mlx4_find_cached_mac() was removed in 2014 by
> commit 2f5bb473681b ("mlx4: Add ref counting to port MAC table for RoCE")
> 
> mlx4_zone_free_entries() was added in 2014 by
> commit 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
> but hasn't been used. (The _unique version is used)
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


