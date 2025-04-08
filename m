Return-Path: <linux-rdma+bounces-9269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46BA81486
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 20:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC01BA43B6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FD23E35D;
	Tue,  8 Apr 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9i/LVkB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608823E34D;
	Tue,  8 Apr 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136528; cv=none; b=ahz1Sb8tjXKKmzrKCBuDODm1VS3yW/10yzOhG7aQ0Gnalnq447CDfoqvfYUpY/0jqkzuLuMOzEpxMWwaylNvqiTIEFikdma4stT5WgfIoQomCNCIxBIl2cz5Wrp0Z5rHi4cVhv2AjFcgko6uq3RA+YUm2vPwo9um2TGz9pBgV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136528; c=relaxed/simple;
	bh=eafZhOICJ+cb3LT7pXsw6UGWPAlqO78ao+HmwjWd90Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTklcczSLvnVgQEO34H8Eyme8pM+dqqQFaJPmsfflGyekz2g/TlPT3zUxSRAF2FWhIW9FPy27805rT85+taYDVQOqy9APZ/AqJDSMVTZyynVhfW3v9AuQGRwAdTPerL2TD6yvRw7KJTEbwjPCTnly9CM/e3Qq4Z2eaI60nTX7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9i/LVkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0E7C4CEE5;
	Tue,  8 Apr 2025 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136528;
	bh=eafZhOICJ+cb3LT7pXsw6UGWPAlqO78ao+HmwjWd90Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9i/LVkBf6jcyfpfF8IVa5VHgrOvgQJScpcymB3yyefit9ZzSOwJzDGjuX7GiizhW
	 vRs/Ii4xsMvttvOAXRC061cVo+kcLCoJVEcKxpJjWu4yprAI0CaNifaYhj54ba3DUa
	 7rXmlEe3a1GkTpoyaOnUvCwVcCEqib5YZiH6LYg7CHVg4KiUCsUMIPAwfkTDm2p+Yn
	 1CiQN2nD9bsduyfKq+1MGXAHy59IXz2xu2T7I1L9IF9hVilS2wlMQova/1aY/SFGIj
	 h6o5IKEinpVlC8ob9iUw+FQs7ZsMKkRDFUeJ0VH5VbJ5x/+CU55UG4x2n7icn69uBK
	 kxn1c6E3ttheA==
Date: Tue, 8 Apr 2025 19:22:03 +0100
From: Simon Horman <horms@kernel.org>
To: Baris Can Goral <goralbaris@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	allison.henderson@oracle.com, skhan@linuxfoundation.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] net: rds transform strncpy to strscpy
Message-ID: <20250408182203.GH395307@horms.kernel.org>
References: <20250407183052.8763-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407183052.8763-1-goralbaris@gmail.com>

+ linux-rdma@vger.kernel.org

Hi Baris,

On Mon, Apr 07, 2025 at 09:30:53PM +0300, Baris Can Goral wrote:
> Hi,

It's nice to be friendly, but I don't think a salutation
belongs in a commit message. (Please remove the line above.)

> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string,resulting in potential memory

Space after the comma (,) please.

> content exposures, unbounded reads, or crashes.

I think there should be a blank like before the Link tag.

> Link:https://github.com/KSPP/linux/issues/90

But not between it and other tags.

Also, there should be a space after "Link:"

Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
> ---
>  net/rds/connection.c | 4 ++--
>  net/rds/stats.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c749c5525b40..fb2f14a1279a 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>  	cinfo->laddr = conn->c_laddr.s6_addr32[3];
>  	cinfo->faddr = conn->c_faddr.s6_addr32[3];
>  	cinfo->tos = conn->c_tos;
> -	strncpy(cinfo->transport, conn->c_trans->t_name,
> +	strscpy(cinfo->transport, conn->c_trans->t_name,
>  		sizeof(cinfo->transport));

I agree that strscpy() is appropriate as we want null termination
but not padding.

Because the destination, cinfo->transport, is an array I believe
we can omit passing the size argument to strscpy, like this:

	strscpy(cinfo->transport, conn->c_trans->t_name);

Link: https://docs.kernel.org/core-api/kernel-api.html#c.strscpy

>  	cinfo->flags = 0;
>  
> @@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>  	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
>  	cinfo6->laddr = conn->c_laddr;
>  	cinfo6->faddr = conn->c_faddr;
> -	strncpy(cinfo6->transport, conn->c_trans->t_name,
> +	strscpy(cinfo6->transport, conn->c_trans->t_name,
>  		sizeof(cinfo6->transport));
>  	cinfo6->flags = 0;

Ditto.

>  
> diff --git a/net/rds/stats.c b/net/rds/stats.c
> index 9e87da43c004..63c34dbdf97f 100644
> --- a/net/rds/stats.c
> +++ b/net/rds/stats.c
> @@ -89,7 +89,7 @@ void rds_stats_info_copy(struct rds_info_iterator *iter,
>  
>  	for (i = 0; i < nr; i++) {
>  		BUG_ON(strlen(names[i]) >= sizeof(ctr.name));
> -		strncpy(ctr.name, names[i], sizeof(ctr.name) - 1);
> +		strscpy(ctr.name, names[i], sizeof(ctr.name) - 1);
>  		ctr.name[sizeof(ctr.name) - 1] = '\0';
>  		ctr.value = values[i];

This issue appears to have been addressed by
commit c451715d78e3 ("net/rds: Replace deprecated strncpy() with strscpy_pad()")

As a Networking patch please make sure it is based on the net-next tree and
targeted at that tree like this:

  Subject: [PATCH net-next v2] ...

Or the net tree if it is a big fix, which this patch isn't.

Please consider posting a v2 patch to address the above.
And please consider CCing linux-rdma@vger.kernel.org on v2.

-- 
pw-bot: changes-requested

