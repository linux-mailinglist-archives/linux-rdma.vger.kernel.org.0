Return-Path: <linux-rdma+bounces-18393-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DiCFoXYu2k6pAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18393-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 12:05:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CADDE2CA04C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C89302418C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDEA3C5DD3;
	Thu, 19 Mar 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQzKtSr+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776D3C5DAA;
	Thu, 19 Mar 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918268; cv=none; b=s4rGsmEQJvkEktgzUCtW/abhVsZsWtZvkY9oUSerUY9E0IICNWc89Y9UMZRMIDGlyS+reiKmt7KCK1daoXg3CJTNuYklTBAqjS9sLCD0uPvJDNgqVq/o+XmbCxZj+iTVXDo+C7xSRcxeVb1glwilZFTIqKmzJjLfNMGSmOPJ3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918268; c=relaxed/simple;
	bh=tLkBiTpiryEVN52bP6JLA+rWBWyBscNcj9bbPA5XWkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrUgA5Bovl0pNlbiuzAslpRQ/aJ8z7RpaFCJo9uXt0Rzvkp82L2iCfKa6E6ve7dhr4y+zUjT1JRzyQD3t2BRgeOVJO3hx+jpvdeWdssDugvwVDzcP8Q8UEEv/vd0PA6z2qSOMJ9pFeP0LNxG5XYuZrIT9O/719Z7MDovnIiGMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQzKtSr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E950EC2BCB0;
	Thu, 19 Mar 2026 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773918268;
	bh=tLkBiTpiryEVN52bP6JLA+rWBWyBscNcj9bbPA5XWkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQzKtSr+6TzPtSAsq3kWzma69O4BMfdkANY/cxHMVYG8ijUeG3vgx2FdDTjorjtM0
	 dauyzSDv997xiRPftU68eJ0yoNqgshUoEtEdA45ovKzXDcln+o5CN+k4JJho79OwXT
	 79JQp7KsKsiVqXGVMyKJ2IrR4ofCONn5I3wZTND2CONkPtcS6PpdKLsuhZC1DVVv+l
	 frmd5tJI8My3ISv1RwRO4FyitbqM0ef2FIdngFqTSO5SGZ/aerfsd1bSkLSWeNBMZs
	 pcpfBYcxgnD7HSe6lmID9QsM7y+s+eEF3Y28rpG0tun5m9fa+3Tao9raM26I1/3iLG
	 V3O2bctg5wP3w==
Date: Thu, 19 Mar 2026 13:04:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: UC QP support for UAPI
Message-ID: <20260319110423.GK352386@unreal>
References: <20260319103901.1472588-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319103901.1472588-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18393-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CADDE2CA04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 03:39:01AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement UC QP creation in the RNIC HW for user API. An UC QP is exposed
> as three work queues: send, receive, and memory management. The latter is
> used for bind and invalidate WQEs to support memory windows.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c    | 41 ++++++++++++-
>  drivers/infiniband/hw/mana/mana_ib.h | 41 ++++++++++++-
>  drivers/infiniband/hw/mana/qp.c      | 92 ++++++++++++++++++++++++++--
>  include/uapi/rdma/mana-abi.h         | 18 ++++++
>  4 files changed, 183 insertions(+), 9 deletions(-)

<...>

> +static int mana_ib_create_uc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata *udata)
> +{

<...>

> +	if (!udata || udata->inlen < sizeof(ucmd))
> +		return -EINVAL;

<...>

> +	if (udata) {

udata is always true.

> diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
> index a75bf32b8..a50d4c012 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -57,6 +57,24 @@ struct mana_ib_create_rc_qp_resp {
>  	__u32 queue_id[4];
>  };
>  
> +enum {
> +	MANA_UC_UDATA_SQR = 0,
> +	MANA_UC_UDATA_RQR = 1,
> +	MANA_UC_UDATA_SMQ = 2,
> +	MANA_UC_UDATA_MAX = 3,
> +};
> +
> +struct mana_ib_create_uc_qp {
> +	__aligned_u64 queue_buf[MANA_UC_UDATA_MAX];
> +	__u32 queue_size[MANA_UC_UDATA_MAX];

This array is not possible to extend. Any addition to enum above will
break ABI. You shouldn't add enum and use 3 directly here.

> +	__u32 reserved;
> +};
> +
> +struct mana_ib_create_uc_qp_resp {
> +	__u32 queue_id[MANA_UC_UDATA_MAX];

Same.

Thanks

> +	__u32 reserved;
> +};
> +
>  struct mana_ib_create_wq {
>  	__aligned_u64 wq_buf_addr;
>  	__u32 wq_buf_size;
> -- 
> 2.43.0
> 

