Return-Path: <linux-rdma+bounces-15129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FADCD3DFF
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCF73004F69
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28727283FCF;
	Sun, 21 Dec 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oawtw/FQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1E2376FD
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310148; cv=none; b=CP5ZKTwkyCLMYHqlzMa5T6P2BN3VGb+3rU3iuTX0QoWU8yQ7YuGOYDi0Ol/flIMcVPz8OdLC+O9Hk1BuKa2Cxi6NguW6FKDpg4KYJuFsehOKW/yvXoV5MWITHQwvOpjO/db3OWzUjrDm5Opq9t3qI9UO4D9P9GOQRbqr4BKRN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310148; c=relaxed/simple;
	bh=mQPjPGvO8bIx/8R+eLf3zERiOQ0zjj7aBJGicnOS2nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCd+15PmeK/6WO6V4KnK7XWVtnMYnw1e3JqzMIV6+1lyvrC7B43rQdpjFDjGMk6huC8YViCoW41lWa19GvltTUR7pLk9CofBGqQMn3umE9PAwFkzjn/u0dL8XO+an/lPc+McjAPCcIeSuBJVE5jYy6OgRmJV76re/DHUdBHnAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oawtw/FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5620C4CEFB;
	Sun, 21 Dec 2025 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766310148;
	bh=mQPjPGvO8bIx/8R+eLf3zERiOQ0zjj7aBJGicnOS2nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oawtw/FQ2jGORCbaeggvABKRLynOjSwir0aA+hfpVR6izYoWHV7T0IOXSASMzkMEp
	 ViALFz3N9HTUYF7Xw0aPpkSnhyZw3AExaGtkgQ4rwXpiP6bI6FnMEziouGkKqnfy0n
	 XjHjn/HGy/4/MfMdGrIU7g4F7R6TOI50Pk5HJCyavm7mmrJqCCLdtWaaLXwHwJdO3d
	 w67aevBNHi6Nl3K7E3UiGVRdYDW5heaBrQVuB6Kpgf97vDL2ISRTed288HWUoTwV/b
	 aYnGnJxyZHZFBNVrfXQ2oAGKHLfQW2LNPNmXFnpGRw2wbZDM3Jg30yqU3UcMELdpI/
	 +Zlu6vRUL+mSA==
Date: Sun, 21 Dec 2025 11:42:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
	jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com,
	selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
Message-ID: <20251221094223.GH13030@unreal>
References: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>

On Fri, Dec 19, 2025 at 01:32:57AM -0800, Alok Tiwari wrote:
> The bnxt_re SEND path checks wr->send_flags to enable features such as
> IP checksum offload. However, send_flags is a bitmask and may contain
> multiple flags (e.g. IB_SEND_SIGNALED | IB_SEND_IP_CSUM), while the
> existing code uses a switch() statement that only matches when
> send_flags is exactly IB_SEND_IP_CSUM.
> 
> As a result, checksum offload is not enabled when additional SEND
> flags are present.
> 
> Replace the switch() with a bitmask test:
> 
>     if (wr->send_flags & IB_SEND_IP_CSUM)
> 
> This ensures IP checksum offload is enabled correctly when multiple
> SEND flags are used.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index f19b55c13d58..ff91511bd338 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2919,14 +2919,9 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
>  				wqe.rawqp1.lflags |=
>  					SQ_SEND_RAWETH_QP1_LFLAGS_ROCE_CRC;
>  			}
> -			switch (wr->send_flags) {
> -			case IB_SEND_IP_CSUM:
> +			if (wr->send_flags & IB_SEND_IP_CSUM)
>  				wqe.rawqp1.lflags |=
>  					SQ_SEND_RAWETH_QP1_LFLAGS_IP_CHKSUM;
> -				break;

> -			default:
> -				break;
> -			}
>  			fallthrough;

The combination of "default with break" and "fallthrough" doesn't make
any sense. Are you sure that we should keep "fallthrough"?

Thanks

>  		case IB_WR_SEND_WITH_INV:
>  			rc = bnxt_re_build_send_wqe(qp, wr, &wqe);
> -- 
> 2.50.1
> 

