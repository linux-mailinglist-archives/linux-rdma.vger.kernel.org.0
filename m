Return-Path: <linux-rdma+bounces-1751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA82896252
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38558B24924
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C71B17995;
	Wed,  3 Apr 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCPbcesp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315F168DE;
	Wed,  3 Apr 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110232; cv=none; b=uDzzqsoIXSKRyvCnx9uAKCsDgHNc++WBMoU3kQBzELeU848uPFqnscA9jLWEw0/xSHsPjZGj4zsmOrIUcN94KZGuK/O/Y4HP0JXkxxgWFXeFNVWD8u4gEd/9EkTmG7bhJ3tiamtjiwdhvGiXiiTc9f2MC7CpjXJO+G1OF+cBnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110232; c=relaxed/simple;
	bh=y6DvVEooFfS6fE42WhsK/UU1M9fwwEQd4IEC65RgZdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI2X7P7hnQMYmZaLe28OuoC+Q4cgsFGwOHBDHXkmeKrYYQwTtX5F2o8ez19/0R0JojALfwvMBZzvu13B/imIgiJok6LBiUMmGfrdcj+lO+Wwg6qJcZhppQAhE5Gn/aRQUqNtAtoiPjia/LaaokoI8QgsPZikPXIdKLM57WLq/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCPbcesp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D029C433C7;
	Wed,  3 Apr 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712110231;
	bh=y6DvVEooFfS6fE42WhsK/UU1M9fwwEQd4IEC65RgZdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCPbcespmCZc8RnSHDEKXToJp4JYVa+JgyFU1TzjuPNUjbSGqIZkhC7AvH3irfGko
	 u9ECvhb6Do9hyYqsSutp9jVnJHzsQ9xzcHRRIGSXg0e1TMG3uL5UD/rqvFDAPatRlj
	 Luyg/ct38rckmpYUPG9EtTaVGaOu012+ZPTqKRAyaMko8Auradq9bGeAIeSrW37jBh
	 V8eZsAOidVQbgbMOUpsN64u4CDZz+3VOMHG66tj+oyHQOr99LHkXZshyCmot2ie9xk
	 G+em7l80Rl/WPk4duNzgrjwQTuQdfrH8gL35lcrASI2OrO4ZogrEy+KYWNISf6JKnf
	 D+fIX6/wF0s0Q==
Date: Tue, 2 Apr 2024 19:10:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Mirko Lindner <mlindner@marvell.com>, Stephen
 Hemminger <stephen@networkplumber.org>, Tariq Toukan <tariqt@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Boris
 Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy
 <maxtram95@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
 <horms@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, "Ahelenia
 =?UTF-8?B?WmllbWlhxYRza2E=?=" <nabijaczleweli@nabijaczleweli.xyz>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells
 <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, Aleksander Lobakin
 <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Liang Chen
 <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Minor cleanups to skb frag ref/unref
Message-ID: <20240402191029.321b1609@kernel.org>
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
References: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 14:50:36 -0700 Mina Almasry wrote:
> This series is largely motivated by a recent discussion where there was
> some confusion on how to properly ref/unref pp pages vs non pp pages:
> 
> https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t
> 
> There is some subtely there because pp uses page->pp_ref_count for
> refcounting, while non-pp uses get_page()/put_page() for ref counting.
> Getting the refcounting pairs wrong can lead to kernel crash.
> 
> Additionally currently it may not be obvious to skb users unaware of
> page pool internals how to properly acquire a ref on a pp frag. It
> requires checking of skb->pp_recycle & is_pp_page() to make the correct
> calls and may require some handling at the call site aware of arguable pp
> internals.

I concluded that Olek's series as good to go in, so you gotta rebase.
-- 
pw-bot: cr

