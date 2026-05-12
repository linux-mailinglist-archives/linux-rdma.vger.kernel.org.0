Return-Path: <linux-rdma+bounces-20487-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BRIKlgmA2p21AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20487-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:08:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63307520CB6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6657B303D38C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C739EB47;
	Tue, 12 May 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klEKezKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134839E9C9;
	Tue, 12 May 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590707; cv=none; b=h9/WvXK3Yo5JaIEx9s2DDeEuOjYcHUVMtybmtiA0Q4FW5zr1jRccFHJQlCJqggtsifUgDK73fLmr1qIXx6RZyx+wvymWsiqkjqnJkVWFlSqyEpsi4KSqACwjB0lIleoHgQI137X6Muaeiq1ukWAZ0BIVdxECR0tn+5FtHQ1Nbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590707; c=relaxed/simple;
	bh=2mUD8aSz8A/xxdCzNJDIipbswxB+izQNCTm0BuUOJik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG5iWJDbkLsF2fPq5kLbJGVFfJU8EI0r6hcdr6b2ejoc+ZL3L1+Rk2fTkXDRRtshr28G6WRXyLCPEOrV7uXTxv1TQ5l76fIpN9oKR/Ca9DYMVPU76XoqNdIyzqct7klU13wysJOawVm+C4DA4Mo1i6nH0wGArWMSFB5eChU7sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klEKezKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3079FC2BCB0;
	Tue, 12 May 2026 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590707;
	bh=2mUD8aSz8A/xxdCzNJDIipbswxB+izQNCTm0BuUOJik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klEKezKM54n9S5hiFvHl8ohmTtbbrUdDA33zCV5yuuZAImPwhyf36nD1eVROotCyq
	 RheEkVxw35vB/zalgtjXSueqs7AOldrcoKc0h08MDW19Cr1yLKAOyyPJugWsqsXFW1
	 NB2tvImRjw4ikOZOKa+xelOQ5FSAmN2tglBh+CAmv3p1M2Z+artY+YjTFstyMZ7AaZ
	 Gd7DdVZcZVua3cxQ4nm0F9tLbnNqMnw3nr9LcnOvF7fUcabOAZa06VsOB3mlpej8x3
	 sefytCG3otZ/9X4qQvKSC29n0MZFPSVcqfMcprj2bkn7GgqCH61PccphfmOiQxzLDi
	 4kQxHam9Se4/w==
Date: Tue, 12 May 2026 15:58:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, anand.a.khoje@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Message-ID: <20260512125819.GT15586@unreal>
References: <20260506090824.359239-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506090824.359239-1-praveen.kannoju@oracle.com>
X-Rspamd-Queue-Id: 63307520CB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20487-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 09:08:24AM +0000, Praveen Kumar Kannoju wrote:
> During scenarios where a REJ is sent after a REQ or REP, the allocated
> is_map_entry remains in memory, resulting in a memory leak. Scheduling the
> entry for deletion during REJ handling, if it is not NULL, resolves the
> issue.

Do you have kmemleak output to prove the leak?

> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index 63a868a3822f..21f2f401ed61 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -321,10 +321,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  				__func__, slave_id, sl_cm_id);
>  			return PTR_ERR(id);
>  		}
> -	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
> -		   mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
> +	} else if (mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID)
>  		return 0;
> -	} else {
> +	else {

It is now similar to the "if (...  && REJ_REASON(mad) == IB_CM_REJ_TIMEOUT)"
for active-side timeout above.

Thanks

>  		sl_cm_id = get_local_comm_id(mad);
>  		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
>  	}
> @@ -338,7 +337,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  cont:
>  	set_local_comm_id(mad, id->pv_cm_id);
>  
> -	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
> +	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
> +	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
>  		schedule_delayed(ibdev, id);
>  	return 0;
>  }
> -- 
> 2.43.7
> 

