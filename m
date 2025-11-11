Return-Path: <linux-rdma+bounces-14389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5FC4D8BC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 12:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19C2188623B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7E31282B;
	Tue, 11 Nov 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcjC579v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFC2DC77F;
	Tue, 11 Nov 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862186; cv=none; b=a0IitiOLQ+kWNkn8mwy3Dj53xWbCjTecJ5hZDx52HZ1FuU70G617DUIxluy9z3l2Khd5QN4mv3mH9W0G9rk/YhUH/L0Bx9nM/XondWOkFDxyWP5yNcK8Fi7JFRuAZNp7+GQtAdbTHrGCkXdoCU1C78Y5kTy/lRm4vmdUGTz9ENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862186; c=relaxed/simple;
	bh=IKB9vWsshzXmfFlZ6Q4oeB5bCq2C+SPZf5IHi6DItvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spFWzWlm5Wtu2lLfWclT3OwcFQQiECcIeUNwkPIGVAWdS5NjLjV22YjqxeCdf70QX0esIUYAvQzMtokv09vpV7tpbl4KWHZf18zdgpaQVwWnDBFbb4Tmx6rA3AlXKDtm5vNQUQwUwm+SVKX++WDktKXb/7/tMENPKiZzoMZU/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcjC579v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8834DC19421;
	Tue, 11 Nov 2025 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762862186;
	bh=IKB9vWsshzXmfFlZ6Q4oeB5bCq2C+SPZf5IHi6DItvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcjC579vfGHO89qGmm51Xn6eLKcxj2OwTQu+k1C7wBw56kRuXOGF/uCxmhjsMiaqL
	 TjcGwd04EDKVIQ7heVY92rzMKriQ5U943jTYrwvGZkoOBPfEtQZAKA4vEGYngD2hQQ
	 pIsuqaAHWjq2xOLN6xce9256Yotlh3Jg0IS+f0cCixgghd5+hNqyVrUM1NvW8feZIw
	 qzrcLzKjT9juF8RoV887FJZJu1AtYldrX4Ya4SVN6BP8a3f1hSWUTEPkWcHUadQh5X
	 aYysnU4XTGbJjWQSi/0tm0IvfbEhDr1/M0suiTV/BAeejbYfYx1AH8yK1jvTZLXAP0
	 GKyo76sFf0Mqg==
Date: Tue, 11 Nov 2025 13:56:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251111115621.GO15456@unreal>
References: <aRKu5lNV04Sq82IG@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRKu5lNV04Sq82IG@kspp>

On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM) and a
> set of MEMBERS that would otherwise follow it.
> 
> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> start of MEMBER aligned.
> 
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after the related structure --no
> blank line in between.
> 
> Lastly, move the conflicting declaration struct rxe_resp_info resp;
> to the end of the corresponding structure.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..6498d61e8956 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>  	u32			rkey;
>  	u32			length;
>  
> -	/* SRQ only */
> -	struct {
> -		struct rxe_recv_wqe	wqe;
> -		struct ib_sge		sge[RXE_MAX_SGE];
> -	} srq_wqe;
> -
>  	/* Responder resources. It's a circular list where the oldest
>  	 * resource is dropped first.
>  	 */
> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>  	unsigned int		res_head;
>  	unsigned int		res_tail;
>  	struct resp_res		*res;
> +
> +	/* SRQ only */
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> +		struct ib_sge		sge[RXE_MAX_SGE];
> +	) srq_wqe;

Will this change be enough?

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..9ab11421a585 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -219,12 +219,6 @@ struct rxe_resp_info {
        u32                     rkey;
        u32                     length;
 
-       /* SRQ only */
-       struct {
-               struct rxe_recv_wqe     wqe;
-               struct ib_sge           sge[RXE_MAX_SGE];
-       } srq_wqe;
-
        /* Responder resources. It's a circular list where the oldest
         * resource is dropped first.
         */
@@ -232,6 +226,12 @@ struct rxe_resp_info {
        unsigned int            res_head;
        unsigned int            res_tail;
        struct resp_res         *res;
+
+       /* SRQ only */
+       struct {
+               struct ib_sge           sge[RXE_MAX_SGE];
+               struct rxe_recv_wqe     wqe;
+       } srq_wqe;
 };
 
 struct rxe_qp {
~

