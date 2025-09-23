Return-Path: <linux-rdma+bounces-13603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F282CB96A1D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58BD324F7A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7E24DD1F;
	Tue, 23 Sep 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="A9cog+ia"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4322259F
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642252; cv=none; b=ZHIw6sGkulTNOxJlih9Yylyqiv4abSb+QZSkrmpxgtEbjxyQENNaXpwwCGsQgwTvEGwYZfQkiVrq28gM7MMAmVjlZilZ75Xjd3QlpbFDV+z/NV8mwvNctHOy8VxsgwjgL3p9nSyuBQzySukpw5NmOkTSbolwL6bgQOnDfBrcHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642252; c=relaxed/simple;
	bh=2CSA34hUwBTAJJm2G/h7Aix3shiB60nNuX0mHdquHFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc/6TTmtLG68KahRxePV2H5vLxmupallVDyxpU6OfDceBu59nxewJcxwSzrzqUcIDwCBiMpo68geoD3b6BetMcztvvBOoRGAy0GRPtv7y9KAnO1tLnF1qtpzeBzjJJywi4SHsbSBpQ1kINrc4nVkMNmpWak8uO8c/zN3WpIHhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=A9cog+ia; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=Hwxro7FIvgwixAuuVIf5uKmlDu1KpQa2WbANPnNd1Gs=; b=A9cog+iaxRXtMlTb4GiCAyTr5e
	kuz9CPiqdJz8zPDoiOL3vVicvsaSzTQxuBN4isa4MWKLUrkKmcubvuAM2scGIM46re7Iv/yO+ymo+
	2syG6+jSTmCldHhBOeEUtj/eFqQpiXYJOF7WQNwnch0mjVcdGBZ07AJIsI7z6+PVNcNfBFbOTnNCB
	WLrsHcs7Fuhg2EVnHvQWG/hdOfx3nLw0CwegnVqbfHVZLgT0Kpc7UyYnEv8KUoTtJOFrL4QIq03q+
	p2GmkMDcJjIX1uya8ixOY5aANyXc90v9vhoLoPP3ejwzSxXEv5Fp3SAs9yQc+8BUl7YhKc757cCBU
	gYLe4b+CAEByeA/OGEiqbAB9bdKk6rVrNh509KN+0s4YOScIWwrWjkOSGE8+nxypIfydSGMbHWdl/
	FY4vAi0kxa+ifn2iYF/KJV/Tz+9n2YHaKRDH6GklLJqp35KMacyrGbnQPvNE+UxmVvcVluGAYlSAW
	MiAC8zJ7zU4xOYXkyWRCodGD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v15BW-005azi-2p;
	Tue, 23 Sep 2025 15:44:06 +0000
Message-ID: <502b6c51-1585-4496-8984-667cef5c3848@samba.org>
Date: Tue, 23 Sep 2025 17:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/siw: Always report immediate post SQ errors
To: bernard.metzler@linux.dev, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20250923144536.103825-1-bernard.metzler@linux.dev>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250923144536.103825-1-bernard.metzler@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.09.25 um 16:45 schrieb bernard.metzler@linux.dev:
> From: Bernard Metzler <bernard.metzler@linux.dev>
> 
> In siw_post_send(), any immediate error encountered during
> processing of the work request list must be reported to the
> caller, even if previous work requests in that list were just
> accepted and added to the send queue.
> Not reporting those errors confuses the caller, which would
> wait indefinitely for the failing and potentially subsequently
> aborted work requests completion.
> This fixes a case where immediate errors were overwritten
> by subsequent code in siw_post_send().
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Suggested-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
>   drivers/infiniband/sw/siw/siw_verbs.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 35c3bde0d00a..efa2f097b582 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   	struct siw_wqe *wqe = tx_wqe(qp);
>   
>   	unsigned long flags;
> -	int rv = 0;
> +	int rv = 0, imm_err = 0;
>   
>   	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>   		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
> @@ -955,9 +955,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   	 * Send directly if SQ processing is not in progress.
>   	 * Eventual immediate errors (rv < 0) do not affect the involved
>   	 * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
> -	 * processing, if new work is already pending. But rv must be passed
> -	 * to caller.
> +	 * processing, if new work is already pending. But rv and pointer
> +	 * to failed work request must be passed to caller.
>   	 */
> +	if (unlikely(rv < 0)) {
> +		/*
> +		 * Immediate error
> +		 */
> +		siw_dbg_qp(qp, "Immediate error %d\n", rv);
> +		imm_err = rv;
> +		*bad_wr = wr;
> +	}
>   	if (wqe->wr_status != SIW_WR_IDLE) {
>   		spin_unlock_irqrestore(&qp->sq_lock, flags);
>   		goto skip_direct_sending;
> @@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   
>   	up_read(&qp->state_lock);
>   
> -	if (rv >= 0)
> -		return 0;
> -	/*
> -	 * Immediate error
> -	 */
> -	siw_dbg_qp(qp, "error %d\n", rv);
> +	if (unlikely(imm_err))
> +		return imm_err;
>   
> -	*bad_wr = wr;
> -	return rv;
> +	return (rv >= 0) ? 0 : rv;
>   }


So the caller needs to set *bad_rw = NULL itself
in order to detect if an immediate error happened or not...

I'm also fine with that, I just hope it's consistent across
all drivers...

Thanks!
metze

