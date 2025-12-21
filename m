Return-Path: <linux-rdma+bounces-15125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C3CD3D9C
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9847D300C6D4
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8DB27B50C;
	Sun, 21 Dec 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJe5q7sl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A727B34C;
	Sun, 21 Dec 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309063; cv=none; b=SxBF6+YORkGoai8cK6jDm5KqumYrsGqpWrzKCyiFB34a6tQR4nMC/T42oKBEWcXMCad07t06cmB3qU4rEcAY5oEEnuz/sIHWTkGRBH53M8RBod12WuS9DGCr4rrnvzt9b5TKhRtfGv0RpDh/2RhVBmpyhhTWALbC9h7+sj+JdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309063; c=relaxed/simple;
	bh=sYVf5RWWRR7KECX0Sxv8Hlbq5Mt8Jydf9BX/HIjtVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IinxjJWjTCveaIPzhjlHOJtuqy+F21uIiDYmUH3KPL99FvSRXYicEeQNlb1cSGHaA7g1pUrD0MQcjTJOpwuSsjvMG2kKbBFTJVCngZPEc0965xL9yO0obrpCWYWpljtNw2bDg8jyfL2r66KcHQCvcqo2cV9hUz+g/6t0201gy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJe5q7sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AACC4CEFB;
	Sun, 21 Dec 2025 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309063;
	bh=sYVf5RWWRR7KECX0Sxv8Hlbq5Mt8Jydf9BX/HIjtVqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJe5q7slfDvPrnDEWqK5OKX6Stq2ZZTvQpN3znxcnj8TUnGR1OifTHauskUc5Zx9w
	 zmG/Su/7f78aDigyn745+W8cxHpHZf3wTEhpcngJ28sHGzH8SAA1OK1nU/BqTOydiA
	 5hmgg6z/x3jcVQrTBXn3MamVbJz79HKxn4cqztTacBhCirPlRh7xuVmXBz8bRehvOj
	 Pg/umHZDey7Cvxv0YoKuyP7LE34HKhCpjn0PE6SYkNZvy77KxXlsMvR43HQJWeVZ7n
	 OMBCvtQKj+diuutzfa/plZXeKuaMYNVZ9Zh+/m0630A5oYJMdNJvZ/yccgSCwC6U18
	 /PiKMxRvuFKPQ==
Date: Sun, 21 Dec 2025 11:24:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jang Ingyu <ingyujang25@korea.ac.kr>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/core: Fix logic error in
 ib_get_gids_from_rdma_hdr()
Message-ID: <20251221092418.GF13030@unreal>
References: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>

On Fri, Dec 19, 2025 at 01:15:08PM +0900, Jang Ingyu wrote:
> Fix missing comparison operator for RDMA_NETWORK_ROCE_V1 in the
> conditional statement. The constant was used directly instead of
> being compared with net_type, causing the condition to always
> evaluate to true.

In current code, it doesn't matter as network type can be one of four
possible values, and this "else if" will be always true anyway.

I changed your patch to this and added Fixes line:
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index ee390928511ae..256f81c5803ff 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -737,14 +737,11 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
                ipv6_addr_set_v4mapped(dst_saddr,
                                       (struct in6_addr *)dgid);
                return 0;
-       } else if (net_type == RDMA_NETWORK_IPV6 ||
-                  net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
-               *dgid = hdr->ibgrh.dgid;
-               *sgid = hdr->ibgrh.sgid;
-               return 0;
-       } else {
-               return -EINVAL;
        }
+
+       *dgid = hdr->ibgrh.dgid;
+       *sgid = hdr->ibgrh.sgid;
+       return 0;
 }
 EXPORT_SYMBOL(ib_get_gids_from_rdma_hdr);

> 
> Signed-off-by: Jang Ingyu <ingyujang25@korea.ac.kr>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 11b1a194d..ee3909285 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -738,7 +738,7 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
>  				       (struct in6_addr *)dgid);
>  		return 0;
>  	} else if (net_type == RDMA_NETWORK_IPV6 ||
> -		   net_type == RDMA_NETWORK_IB || RDMA_NETWORK_ROCE_V1) {
> +		   net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
>  		*dgid = hdr->ibgrh.dgid;
>  		*sgid = hdr->ibgrh.sgid;
>  		return 0;
> -- 
> 2.34.1
> 
> 

