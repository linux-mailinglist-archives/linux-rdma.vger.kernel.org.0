Return-Path: <linux-rdma+bounces-12646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00638B1FB7B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4148C3A541D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AEC24DD13;
	Sun, 10 Aug 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MV/8oOPo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97771BD9C9;
	Sun, 10 Aug 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848034; cv=none; b=QPRc82c3RX7iOqIv5SEynyiOgmoQhDTq15FAI9Gfh38JqUUAExENrUg3kpznRi91wrxymySUGjXR8Hno6asuF4K3DGEanYpFG+mVUtVg0VXhSoWd0szWO6LOZYc7Q7g5i/VeowFDs45rPzdHI7uRYSGiwtbj7OL0PasPTJyuypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848034; c=relaxed/simple;
	bh=rnQuOmgE0KMuPOTpXub7UBK7vP0ELwxG3TxeTDU0yeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPWGO305tl/xCrfd65/KYXK2xykzVKZ1LPqYIPYQTrUGJ8XJ2+wdRL5+D8y0OEFwU3fmvMr1aMzK20ZjqDZIWC+5W4iOe8RSyzwSMZHWHRRcKc1Qa01fuun4MyLK33H3Z0E2RjAQkSpyKtzHyfpZr/9BouxLZhpiQ05HVKYee9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MV/8oOPo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQt8jeiA+TBvJ8iDPPpJpi5l72JLqli8XK+VxXxBsC0=; b=MV/8oOPoToF2oAxPJMtQeXijWX
	zFzhdDXCyyKMCZXPfiPSbSR2443NFKReSiUeH/T5Ov5oe3nbp2PKLolKReVZEHL6Adqz23PU1ThiT
	ek+9cylKMOvIt149M/GOpc6Jug8uIBMIVB7UNj2kb07v1DtgUjx7tqbD96K7RBmEmydPkQcFUfPVS
	sMXiej63ST4yLMGJJDqD9yZobvrIDQchd3ErqoNE0j91BIFvkoj3ANGAzpvDpBKeBJUQEo4kA+KuT
	J+CUgyLOeUwI1M0kdJa2w9HxHWbIB9Qfn4rWr47Aii4Qkbg7riEMIOIp4HIY7ErBZfkR/OovK1Ev5
	a95vbcrQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulA8P-000000092Kz-0ipJ;
	Sun, 10 Aug 2025 17:47:05 +0000
Date: Sun, 10 Aug 2025 18:47:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810174705.GK222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810171155.3263-1-ujwal.kundur@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 10, 2025 at 10:41:55PM +0530, Ujwal Kundur wrote:

> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 086a13170e09..9cd5905d916a 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -242,7 +242,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
>  	if (rs->rs_snd_bytes < rds_sk_sndbuf(rs))
>  		mask |= (EPOLLOUT | EPOLLWRNORM);
>  	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
> -		mask |= POLLERR;
> +		mask |= (__force __poll_t)POLLERR;

EPOLLERR.

>  	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
>  
>  	/* clear state any time we wake a seen-congested socket */
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index d62f486ab29f..0047b76c3c0b 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -62,13 +62,13 @@ static struct hlist_head *rds_conn_bucket(const struct in6_addr *laddr,
>  	net_get_random_once(&rds_hash_secret, sizeof(rds_hash_secret));
>  	net_get_random_once(&rds6_hash_secret, sizeof(rds6_hash_secret));
>  
> -	lhash = (__force u32)laddr->s6_addr32[3];
> +	lhash = (__force __u32)laddr->s6_addr32[3];
>  #if IS_ENABLED(CONFIG_IPV6)
>  	fhash = __ipv6_addr_jhash(faddr, rds6_hash_secret);
>  #else
> -	fhash = (__force u32)faddr->s6_addr32[3];
> +	fhash = (__force __u32)(faddr->s6_addr32[3]);
>  #endif
> -	hash = __inet_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
> +	hash = __inet_ehashfn((__force __be32)lhash, 0, (__force __be32)fhash, 0, rds_hash_secret);

what the...  You have lhash and fhash set to __be32 values, then
feed them to function that expects __be32 argument.  Just turn
these two variables into __be32 and lose the pointless casts.

> diff --git a/net/rds/rds.h b/net/rds/rds.h
> index dc360252c515..c2fb47e1fe07 100644
> --- a/net/rds/rds.h
> +++ b/net/rds/rds.h
> @@ -93,7 +93,7 @@ enum {
>  
>  /* Max number of multipaths per RDS connection. Must be a power of 2 */
>  #define	RDS_MPATH_WORKERS	8
> -#define	RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
> +#define	RDS_MPATH_HASH(rs, n) (jhash_1word((__force __u16)(rs)->rs_bound_port, \
>  			       (rs)->rs_hash_initval) & ((n) - 1))

Reasonable.

>  #define IS_CANONICAL(laddr, faddr) (htonl(laddr) < htonl(faddr))
> diff --git a/net/rds/recv.c b/net/rds/recv.c
> index 5627f80013f8..7fc7a3850a7b 100644
> --- a/net/rds/recv.c
> +++ b/net/rds/recv.c
> @@ -216,10 +216,10 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
>  		switch (type) {
>  		case RDS_EXTHDR_NPATHS:
>  			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
> -					       be16_to_cpu(buffer.rds_npaths));
> +					      (__force __u16)buffer.rds_npaths);

No.  It will break on little-endian.  That's over-the-wire data you are
dealing with; it's *NOT* going to be host-endian.  Fix the buggered
annotations instead.

>  			break;
>  		case RDS_EXTHDR_GEN_NUM:
> -			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
> +			new_peer_gen_num = (__force __u32)buffer.rds_gen_num;
>  			break;

Ditto.

> diff --git a/net/rds/send.c b/net/rds/send.c
> index 42d991bc8543..0d79455c9721 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1454,8 +1454,8 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
>  
>  	if (RDS_HS_PROBE(be16_to_cpu(sport), be16_to_cpu(dport)) &&
>  	    cp->cp_conn->c_trans->t_mp_capable) {
> -		u16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
> -		u32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
> +		u16 npaths = (__force __u16)RDS_MPATH_WORKERS;
> +		u32 my_gen_num = (__force __u32)cp->cp_conn->c_my_gen_num;

Again, over-the-wire data; you are breaking it on l-e.

>  		rds_message_add_extension(&rm->m_inc.i_hdr,
>  					  RDS_EXTHDR_NPATHS, &npaths,

