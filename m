Return-Path: <linux-rdma+bounces-20903-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL8jHeQBC2oH/QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20903-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:11:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E290D56C524
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F88B306E691
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A513FBEA6;
	Mon, 18 May 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeMIMgiD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B613FBB75
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105654; cv=none; b=hCyMJrH3UTShxJPsKVXzs17281OjtI/o77sr6W4oJ+hW6LP+lpmFFD/8gSZDkNamqFXrPPT3LaMu0OKzaxmBJV4r2hev35nMEO7Aro39/p3/NIYtvYmWwsLeJ9jojAFk9wvcpEarPUAHLveeQ8KrwXEU/qQXQMuzw/dsss/agfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105654; c=relaxed/simple;
	bh=20RtVpEORJ/hLutZlvYCxQuHOKcldoGKPQ5Itvx+zP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5skAwHNUZhUPb0ZyuPC/Rq/CiALMRGT8rPeUtenV1IER/Zb1OT/MlbMwcTHPkdgUcGT1Yx4Khcc9NpA7SQak0KYdiEf3QqvDZ3/JIYcRFmXlCPDJrdgtEXieBqO5TpRrmRmJ51iiYZUsAo4ndeTjNRt0y7Bba8xYTBpJb0rj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeMIMgiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD551C2BCB7;
	Mon, 18 May 2026 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105654;
	bh=20RtVpEORJ/hLutZlvYCxQuHOKcldoGKPQ5Itvx+zP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeMIMgiD29D67pgQPuAb985seQ+bCU7/YWtOoyMo0APYrT/ku2+b8xG+YLCFlXkDP
	 ehUbce43NrmYRLLIPZiwYgp2LI/m2FNmQKoxAThMOG3RfhKDMUV5yThnK/mIFIIzfm
	 8dqSx5uIk80IeWPRGBYFtbwu56xtLmzDiAvj76AOMUC6XvdxiqzIR6WndD4yIQWaf9
	 PZg3kbIWemLKM1pY6YDIQ1mjrFwgZGp8aO2MOsnZ8tQa2+JKVLGY1mOG/dPFPV/j/7
	 iqpuAdyLaWmGJPFJZRBQnK1Vn0dJeEdMoTPWN6bI+dUmmO8tWy3TL9fJRn66VUSoIy
	 G7zV6MN6G/pKQ==
Date: Mon, 18 May 2026 15:00:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Validate SQ depth based on WQE size
Message-ID: <20260518120050.GQ33515@unreal>
References: <20260517175216.614494-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517175216.614494-1-ynachum@amazon.com>
X-Rspamd-Queue-Id: E290D56C524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20903-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 05:52:16PM +0000, Yonatan Nachum wrote:
> Change the SQ depth validation to take into account the SQ WQE size.
> This is needed since when using 128-byte WQE the max SQ depth is cut in
> half. On create QP command, userspace provides SQ ring size which is SQ
> depth X WQE size so we can calculate the requested WQE size in the
> kernel.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
> Changelog:
> v2:
>  * Add fixes line.
> v1: https://lore.kernel.org/all/20260507112110.869212-1-ynachum@amazon.com/
> 
>  drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 395290ab0584..9a6cbb70581b 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -597,14 +597,27 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
>  	return -ENOMEM;
>  }
>  
> +static int efa_calc_sq_wqe_size(u32 sq_ring_size, u32 max_send_wr)
> +{
> +	return max_send_wr == 0 ? 0 : sq_ring_size / max_send_wr;
> +}
> +
> +static u32 efa_calc_sq_max_depth(struct efa_dev *dev, u32 sq_wqe_size)
> +{
> +	return sq_wqe_size == 0 ? 0 :
> +		rounddown_pow_of_two(dev->dev_attr.max_llq_size / sq_wqe_size);
> +}

Please review sashiko's findings:
https://sashiko.dev/#/patchset/20260517175216.614494-1-ynachum@amazon.com

It appears that a valid input can trigger rounddown_pow_of_two(0).

Thanks

