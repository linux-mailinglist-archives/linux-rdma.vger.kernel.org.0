Return-Path: <linux-rdma+bounces-14860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42AC9BE6B
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCC4E3097
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551F239E6F;
	Tue,  2 Dec 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcU7YjQp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA01EB193;
	Tue,  2 Dec 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688222; cv=none; b=UPa3x6GZQxZqm6CKAKrmpSUCsxFat0ljIFqLy4iTtKTNnA2+nAUQsUhSo2psVzEt68r8HU0UljDKF/nRu139XfZRtFoSOvXOszxDSOuOu9yfZgiWsRqNro+BLraqdZclYf94PfyNCszHSPQoxBENXMHXQJ7Bw/JIK2QT/0SMVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688222; c=relaxed/simple;
	bh=VH9j/YlfCAx45ZkyVMgan3hc8DYV60HSZBBWPJufM3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tASuE2P+g+S2Q0KI8V0cfFwm8vXzGdU+SM9IE1f5+TcYAAecBog/b5AIHWqYJ+D2THpB3XG4Cw6eAummoi7evx17IwEDjyR3RPGW8H/tlE6+WmSk4OBJi5FgWuRnnlBGjMoc+AXnXaajeKvGZiyAmoFzjuUv36KKh5qu4yBBqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcU7YjQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475A4C4CEF1;
	Tue,  2 Dec 2025 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764688222;
	bh=VH9j/YlfCAx45ZkyVMgan3hc8DYV60HSZBBWPJufM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcU7YjQpHG2tryDBHgQL+E5pDCwVKlkKkdXj/CSZNt0Mb1eStmxemT/Iqy1SIio15
	 UKwTSUKa9kJj908VPwp6IbMUzlsGla8xnB5yTNX4TRKgJ5IFHuliutMvBjT+5CkVQk
	 jiCn2LlDp4wEtKYDTjgacRbVuufJ3lY7whfSeun1o6il3njlEKSDXYQIx7iowddYWI
	 igHAGKWpmYL+19VtNHxCZ0F3eOdqGxo7olKhzMFa7hCsRWCHMg6ea++T2yLFxyu9N/
	 qH6nUhpCRJ5UiECMmWpXEKtjGjZGqXu0WMBoVB28rjWmGGR07glLRI6QP9pQ2lfJwv
	 vgrhBqw820JAg==
Date: Tue, 2 Dec 2025 15:10:17 +0000
From: Simon Horman <horms@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	rds-devel@oss.oracle.com, kuba@kernel.org,
	linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net-next v3 2/2] net/rds: Give each connection path its
 own workqueue
Message-ID: <aS8BWWQDiDMjxpGZ@horms.kernel.org>
References: <20251201061036.48865-1-achender@kernel.org>
 <20251201061036.48865-3-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201061036.48865-3-achender@kernel.org>

On Sun, Nov 30, 2025 at 11:10:36PM -0700, Allison Henderson wrote:

...

> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index dc7323707f450..cfe6b50db8a6f 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -269,7 +269,11 @@ static struct rds_connection *__rds_conn_create(struct net *net,
>  		__rds_conn_path_init(conn, &conn->c_path[i],
>  				     is_outgoing);
>  		conn->c_path[i].cp_index = i;
> -		conn->c_path[i].cp_wq = rds_wq;
> +		conn->c_path[i].cp_wq =
> +			alloc_ordered_workqueue("krds_cp_wq#%lu/%d", 0,
> +						rds_conn_count, i);
> +		if (!conn->c_path[i].cp_wq)
> +			conn->c_path[i].cp_wq = rds_wq;
>  	}
>  	rcu_read_lock();
>  	if (rds_destroy_pending(conn))

Hi Allison,

The code following the hunk above looks like this:

		ret = -ENETDOWN;
	else
		ret = trans->conn_alloc(conn, GFP_ATOMIC);
	if (ret) {
		rcu_read_unlock();
		kfree(conn->c_path);
		kmem_cache_free(rds_conn_slab, conn);
		conn = ERR_PTR(ret);
		goto out;
	}

There are no more error paths that free resources in the remainder of
the function. And the out label simply returns conn.

It looks like the ordered workqueue allocation added by this patch
will be leaked if we reach the error condition above.

Flagged by Code Spell with review prompts.

https://netdev-ai.bots.linux.dev/ai-review.html?id=89a5d15b-cd8c-4403-81ff-8577dc0069a6#patch-1

...

Also, please note that net-next is currently closed for the merge window.
So the usual guidance about that applies:

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after 15th December.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: changes-requested

