Return-Path: <linux-rdma+bounces-15126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6DCD3DB1
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33916300B929
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E027CCF2;
	Sun, 21 Dec 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvEu/vhJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D61D90DD;
	Sun, 21 Dec 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309442; cv=none; b=ZgyJmyHMpbjGsYsxBQmR/XqUp7uc41QsWoz8zMDHrPzCfa3O6DKYsT9hHMfQ/AXWxr2HJUOTOA+zi3pB7Af6mky4hm/f5UbFQESiYXQj30CV7xvKl6k/bcvVB7O2cgq18SCAo4nnnGMETkv7H7KcE3KIZNiBcai8qY3uoxjyQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309442; c=relaxed/simple;
	bh=valU7+/erzENN3/kCx/CVkyzp948pkICi8gK0ohNFPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvkOpBIhWpV6r0E6aUU91TVTJPh4Hwye7vXWwdSh7nHgTMI8CbGqBKw+Xf4Tp/qJCg/V287cKkvp+cYTx1O/WXBJdQV2ZB8I63JMHpxP16v7TC7mvRw1gGHIBOBmyV4Qn9rwKC36p/O+YKVoP9G6zFdZ9GIlD8ESOuRMDx/Z4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvEu/vhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED1C116B1;
	Sun, 21 Dec 2025 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309442;
	bh=valU7+/erzENN3/kCx/CVkyzp948pkICi8gK0ohNFPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvEu/vhJO0VXeJuISDyMFFX+RKF3TTrZbiNvoxEo041qXZ68kqtwD0Kf/JXn0lDpG
	 ijCbPYI/mV9hLRJmxzQ/T3TaHtP8Nr//Nh7lLEQdrd45lx5fGLEmLzidETVLFBcrQX
	 BfhqM9ENPlQtkfdz2dOlILmefGaPh0OqcyYlvoH/YInIzGdFHp5K5H/NeHgbvK+XdY
	 vZeAOHwQcieFGzt/7xanA8AUosrV2wEXOhJ+OowcJbZlbyQ1FEnG/1WN6mvE6D8gLO
	 uE4mr3i1nx89qNtL1kTTSybUDvOlZMbV16e0aE9vYyfI8w2jdx6QXLS8wHqU61cE6A
	 KvF6dvebzUGbg==
Date: Sun, 21 Dec 2025 11:30:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jang Ingyu <ingyujang25@korea.ac.kr>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/core: Fix logic error in
 ib_get_gids_from_rdma_hdr()
Message-ID: <20251221093038.GG13030@unreal>
References: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
 <20251221092418.GF13030@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251221092418.GF13030@unreal>

On Sun, Dec 21, 2025 at 11:24:18AM +0200, Leon Romanovsky wrote:
> On Fri, Dec 19, 2025 at 01:15:08PM +0900, Jang Ingyu wrote:
> > Fix missing comparison operator for RDMA_NETWORK_ROCE_V1 in the
> > conditional statement. The constant was used directly instead of
> > being compared with net_type, causing the condition to always
> > evaluate to true.
> 
> In current code, it doesn't matter as network type can be one of four
> possible values, and this "else if" will be always true anyway.
> 
> I changed your patch to this and added Fixes line:
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index ee390928511ae..256f81c5803ff 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -737,14 +737,11 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
>                 ipv6_addr_set_v4mapped(dst_saddr,
>                                        (struct in6_addr *)dgid);
>                 return 0;
> -       } else if (net_type == RDMA_NETWORK_IPV6 ||
> -                  net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
> -               *dgid = hdr->ibgrh.dgid;
> -               *sgid = hdr->ibgrh.sgid;
> -               return 0;
> -       } else {
> -               return -EINVAL;
>         }
> +
> +       *dgid = hdr->ibgrh.dgid;
> +       *sgid = hdr->ibgrh.sgid;
> +       return 0;
>  }
>  EXPORT_SYMBOL(ib_get_gids_from_rdma_hdr);

After some additional consideration, I'll keep your patch as is.

My change is technically correct, but it's risky since some drivers  
use non‑conformant values.

Thanks.

> 
> > 
> > Signed-off-by: Jang Ingyu <ingyujang25@korea.ac.kr>
> > ---
> >  drivers/infiniband/core/verbs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index 11b1a194d..ee3909285 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -738,7 +738,7 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
> >  				       (struct in6_addr *)dgid);
> >  		return 0;
> >  	} else if (net_type == RDMA_NETWORK_IPV6 ||
> > -		   net_type == RDMA_NETWORK_IB || RDMA_NETWORK_ROCE_V1) {
> > +		   net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
> >  		*dgid = hdr->ibgrh.dgid;
> >  		*sgid = hdr->ibgrh.sgid;
> >  		return 0;
> > -- 
> > 2.34.1
> > 
> > 
> 

