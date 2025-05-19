Return-Path: <linux-rdma+bounces-10404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99389ABB57D
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 09:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA47A1887A25
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0B25F961;
	Mon, 19 May 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwCv114/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977C35946;
	Mon, 19 May 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638121; cv=none; b=hOLcN9k3IPF5nZVqs0KdPriq9rRtygp+8UD44z8Rubg5cku7Ow5yj6j3cAuemq4ej0B8EmVAz1SrDixIqYq+1y9f1Y9STTQy+KvI7FYTeOB6zns0HMN52vyIpanWMsL7d6MkAP9KQ6Zn1W6xFLXRmf9H2+MrQHl4ixm0PSplz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638121; c=relaxed/simple;
	bh=xUkod8gEgbX3i5MGZ9QfRvlui8/J9hSoRtS3NWtUZbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIYp+DDMPGM9tsWQk2S9tdMo6dLQm6neLYJf+FaFk2DW+yh3QKVdrwGdiYKOlB3SrIl5tT3xMQGIWLnGF/JERWRF8xiuH0sbm+Jl7KfLrfkA0Q4ufoCNLyvFXojSjbHKSwXxU9+1yRQlUGiyPaHoZrZrapbu7IPYmoGybcReHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwCv114/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747638120; x=1779174120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xUkod8gEgbX3i5MGZ9QfRvlui8/J9hSoRtS3NWtUZbI=;
  b=jwCv114/FWOYuRT2EXAHO2czu2Q64z80ZDaDk4aH8WYihTq2bzlcT+Yc
   +KxkUhGicQvb6TrN1qCdkJjeNSNGXXryCYcXLqzyzV2DxwgUfrzgp62UL
   VjrA2IXlIACAuCU5rbjqogPP8AV3JwdNVHYlr5hEIGdmvi2RM1ebKHwSF
   5Sx65pTrOfTloZSuKPionLoGhVNQ71hzOk5oUXITVk6RwE46a7cVOUIhx
   /KOwwMwYUNgYOq0exccU2nRiZ442SXy+L6kSd27L5x6mnxO1AkSf4JQln
   H80YxJrAdIH5dGU59T+bJFZIyS7JkdJpCoYDgW0d1polpBoY5AIb3stgd
   A==;
X-CSE-ConnectionGUID: emfC8L1MS0OX7F7DTZgmIw==
X-CSE-MsgGUID: ZYRKbBa6RrWZixvtpzr52Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49425942"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49425942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:02:00 -0700
X-CSE-ConnectionGUID: S88TpiU7RKWvNFurnzFTxg==
X-CSE-MsgGUID: 5OdMhunZRW2JAMDp2DHnDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="140183475"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:01:57 -0700
Date: Mon, 19 May 2025 09:01:22 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: goralbaris <goralbaris@gmail.com>
Cc: horms@kernel.org, allison.henderson@oracle.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org,
	shankari.ak0208@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next: rds] replace strncpy with strscpy_pad
Message-ID: <aCrXQtrGMIntkcZs@mev-dev.igk.intel.com>
References: <20250518090020.GA366906@horms.kernel.org>
 <20250518195328.14469-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518195328.14469-1-goralbaris@gmail.com>

On Sun, May 18, 2025 at 10:53:29PM +0300, goralbaris wrote:
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string, resulting in potential memory.
> Link: https://github.com/KSPP/linux/issues/90
> 
> In addition, strscpy_pad is more appropriate because it also zero-fills 
> any remaining space in the destination if the source is shorter than 
> the provided buffer size.
> 
> Signed-off-by: goralbaris <goralbaris@gmail.com>

There should be your full name, not nick.

Feel free to add my RB tag
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> ---
>  net/rds/connection.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c749c5525b40..d62f486ab29f 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>  	cinfo->laddr = conn->c_laddr.s6_addr32[3];
>  	cinfo->faddr = conn->c_faddr.s6_addr32[3];
>  	cinfo->tos = conn->c_tos;
> -	strncpy(cinfo->transport, conn->c_trans->t_name,
> -		sizeof(cinfo->transport));
> +	strscpy_pad(cinfo->transport, conn->c_trans->t_name);
>  	cinfo->flags = 0;
>  
>  	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
> @@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>  	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
>  	cinfo6->laddr = conn->c_laddr;
>  	cinfo6->faddr = conn->c_faddr;
> -	strncpy(cinfo6->transport, conn->c_trans->t_name,
> -		sizeof(cinfo6->transport));
> +	strscpy_pad(cinfo6->transport, conn->c_trans->t_name);
>  	cinfo6->flags = 0;
>  
>  	rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
> -- 
> 2.34.1

