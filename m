Return-Path: <linux-rdma+bounces-16034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIOJBM7Fd2nckgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:51:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899358CC6B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A269C301D68E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9E2877E8;
	Mon, 26 Jan 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQGG1hIn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9D285C9F
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456997; cv=none; b=mYgEeUp1xtZhL/5YJ90vMv4FpPGl6iH/XfQypspeb7KbfXh3DA6ztn7oyxegSgo1/Kl4e86N1GcFLq37LbWZq6KBXCEXDx/XqRbcaLhMft3IUpDrNDKjKqEgD/DXgdPwQpiLWmBBv/R0nfgrCLv02v4uQ4/nWwMSf02OfTd5VoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456997; c=relaxed/simple;
	bh=Ew0wil3rS4MqDg53VyMtrRBkkpZ592JhyvoxrBM5REI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=blz4wZHvGVGQ/BG10pAF2GdhgxPNCaeBEQK1y+4xM65Om83bphatx3mNcKB4lQf8EPOVirUmdx53eZCcwbUaEY8fKGv5d9XBvpgmhWN/QR0hejY9p+LTgJ0V6kg5G3smPNwkLRtHVNuA7SRP2g//eC/+ZNpmf4Zd9MC1kVke/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQGG1hIn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so47407591cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769456995; x=1770061795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DkhtEYlu1cxCF+r3Na88j9n+YMNLVAzK55vGoP2wzQ=;
        b=CQGG1hIn1LsIihcKV68Rf/S0mUf7mSTVoNOdZm6WyulsFxvbUUDOd9jHvW4gfNJIAi
         IeMt+TVRXGzohsGRjqaeAFaFp0zeliJRhsnnjaMPWlLMK7eOwfPdkHW0Wc1G1e0OAJf1
         /WMuYuxJLPpM0En+hB9p4wttaNb/SgMKrZCJtMYeuTgfQnfybfRtyD8vHs6HAW3h1eDq
         H6Wl9I7JBVvcx4S9DcvX8mD9InpLqrIslo1sI+VJZTCzMKaOqpW4eaQk3Eioi+4dI4DP
         3L2m6DsVGhK+f2D5+ad6Nz5TojoSlsFJ5R0Cy103N0YmfppJc8Q2lFUTniMe41U4iXRL
         2SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456995; x=1770061795;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DkhtEYlu1cxCF+r3Na88j9n+YMNLVAzK55vGoP2wzQ=;
        b=SXOQQ99MsWTiuVxdJ8RJ7qV4QpLzfLPAY/1L1mxP7Rm1fWCBHIClXBxW5ve1cJzB1y
         bE6HJBu+QR+YVJbBzFaQK5q3YUHb+PdPrChmuFhFIJ4/EsoToNG8X8v4/jWrW4rAqf3r
         5pnxRJaIGTAhKUdJk5PkVcs0GjSi0H7INC5jF5iZHjGnkOoRwuA7h1D66P0ZJhDHomJR
         eIm5zJBdZUyKwRPqA1e35Z5I7EFcPoYwYBvrOZkeNjnXHZoZtYB1SAJWLYub1P2JTkKX
         pl8V2Gr/rbzTqVuJislz4HpWtvSpg3JYgGxNfcpZpUb6rdP+1Bg+GqH9XDiAu6WG1Gm2
         REog==
X-Forwarded-Encrypted: i=1; AJvYcCXXetoyLetUlq+LHyeio5N2CwRlTdZEsauEI/065bWSkQLyw4bSBNY795DH9rog5hIbg5w2xxOsxxGu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QsLR+SkUVcS+Zd6Yg6/DUfgaHST0vEX72EUrEd3y6wFzowBc
	pxkKBQ+RdnDiGTXTX3KP6KveizLrQZZ1/NDRIJ/jsBws6LN2FkPzQFj+
X-Gm-Gg: AZuq6aL2nereFNuZgyDpXAciZQa5EjoWHZC5VWqRD1QsWkqJw2YPyjq6drUqCxa9m4U
	7JwLcFjIOamjLw8ZCy/wDa5kXsUwzHPo/Rg3LKi9lGIH7u9m7ajIxZj4odVEsjoSj/06iyZ5yR0
	JlVns0UllWpQ5I6xiDIlLitdJ5TEwxXh7WadujmvJP6D/n8aj5ZQOoXo/cwtHavY4vV/9X+D54A
	76o/qzy+9aSkk5OaRAlAICr/iaZxUAa9CgQThgT/7QN6M65/HA5kH4YVvv8DuohwL455zgJtLdr
	WaeH2QLxCQxg1/Y/9s0NPnii1xZzAowOkj+eUqYpwpH500RTMXFfvqhJV+9XrCqQkJTuwBPGzrD
	xE/QTvHfmjiztddYFshKcnqcG817Av6Il3Yfqx8I4QxjXej6o/HJMNPT60Gj9AaVivxt2ofNJHp
	iGgRbsYPYGWrEGXk1JEjKVaWW2dR/1ApPfEXqqnMiIf81NaNFIEANeJtC86mA=
X-Received: by 2002:a05:690e:1503:b0:649:51d8:6f72 with SMTP id 956f58d0204a3-64970b45682mr4014192d50.5.1769450012509;
        Mon, 26 Jan 2026 09:53:32 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6495cfde5ccsm5560600d50.24.2026.01.26.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:53:32 -0800 (PST)
Date: Mon, 26 Jan 2026 12:53:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 linux-rdma@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Message-ID: <willemdebruijn.kernel.218d53621fba7@gmail.com>
In-Reply-To: <20260125121649.778086-2-gal@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-2-gal@nvidia.com>
Subject: Re: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP
 header for GSO_PARTIAL
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16034-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 899358CC6B
X-Rspamd-Action: no action

Gal Pressman wrote:
> In GSO_PARTIAL segmentation, set the UDP length field to the single
> segment size (gso_size + UDP header) instead of the large MSS size.
> This provides hardware with a template length value for final
> segmentation, similar to how tunnel GSO_PARTIAL handles outer headers
> in UDP tunnels.
> 
> This will remove the need to manually adjust the UDP header length in
> the drivers, as can be seen in subsequent patches.
> 
> This was suggested by Alex in 2018:
> https://lore.kernel.org/netdev/CAKgT0UcdnUWgr3KQ=RnLKigokkiUuYefmL-ePpDvJOBNpKScFA@mail.gmail.com/
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This only affects the udp header value when using GSO_PARTIAL, and
these are the only two drivers that adversize USO using GSO_PARTIAL.

> ---
>  net/ipv4/udp_offload.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 19d0b5b09ffa..89e0b48b60ae 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	struct sock *sk = gso_skb->sk;
>  	unsigned int sum_truesize = 0;
>  	struct sk_buff *segs, *seg;
> +	__be16 newlen, msslen;
>  	struct udphdr *uh;
>  	unsigned int mss;
>  	bool copy_dtor;
>  	__sum16 check;
> -	__be16 newlen;
>  	int ret = 0;
>  
>  	mss = skb_shinfo(gso_skb)->gso_size;
> @@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		return segs;
>  	}
>  
> +	msslen = htons(sizeof(*uh) + mss);
> +
>  	/* GSO partial and frag_list segmentation only requires splitting
>  	 * the frame into an MSS multiple and possibly a remainder, both
>  	 * cases return a GSO skb. So update the mss now.
> @@ -584,7 +586,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		if (!seg->next)
>  			break;
>  
> -		uh->len = newlen;
> +		uh->len = msslen;
>  		uh->check = check;
>  
>  		if (seg->ip_summed == CHECKSUM_PARTIAL)
> -- 
> 2.40.1
> 



