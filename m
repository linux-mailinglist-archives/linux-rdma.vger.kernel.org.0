Return-Path: <linux-rdma+bounces-18321-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCB0Agu9ummqbQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18321-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:56:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838E32BDA34
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7903165077
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B93E3DAB;
	Wed, 18 Mar 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYGmFuPS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6793E3DA8
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845613; cv=none; b=LGjYw4hIM8l7EtVCtRMuy7RyV5IbV+vemauTYp+5O8JOvW/ZeEaL0GAL9XbB0QJhvx7f6wCvSfvW530/00RMU8jqC/tefKsSqkYjjsz39KoplLlqIObVxy9jrvMU8l2xnujdxuUgMf0pnM3JyCh3liJK+bmuOs0D3nJ9wp/O1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845613; c=relaxed/simple;
	bh=MvUwWCRTimsQwPYFOejcvcfWVSi5nyBw+y3ywyY/2cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4l+802iLyB+KlyFp6UbRECzcmybbKIBr5S0MgNBo6NAbh5/hmbNF8KLwn5GMGkEY9icjQAxZpEKU2bDWdmgd6pJ0yuVOeX15uRfdoOskCFtAM7KqSBqjmsPTHdeyc/oNNLc2QJQMFUIW4v7qBrIuILBEX2hiGbdR4phTqP/j5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYGmFuPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6685C19421;
	Wed, 18 Mar 2026 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845612;
	bh=MvUwWCRTimsQwPYFOejcvcfWVSi5nyBw+y3ywyY/2cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYGmFuPSqLwF3xaRcttZsGIRE3R8daPZofrOZrqymfZ4xSzTgCJ5WG6vizunJhYaV
	 ci9emf+x/NuYAWb4VcF8CYz1O1ZgnKgp41287nOB3kzzCD2j3CIca4DntKU9VQJI2t
	 dxcHcpvZS/ut57f1UYMSeBSLuU2aZq22oYiWoTLyuiBVLNQRWNqpPDDJ7f/o6aCnnn
	 AAlQzUWro7MrWogfBM6A3O1bNCx8b4G/MiS79/UhdwC9G5bNLMjdnlk/hmIbJXFU1j
	 j0cJrdmAnEzgLFpqCsze/pGyWuF1X8b4xJq4rrbKl4uXwfsac6KZL4B8RrDzfFk6Km
	 i7fWGe6xASavw==
Date: Wed, 18 Mar 2026 16:53:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Use a dedicated and robust workqueue for
 RXE tasks
Message-ID: <20260318145327.GC352386@unreal>
References: <20260318025739.5058-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318025739.5058-1-yanjun.zhu@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18321-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 838E32BDA34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 03:57:39AM +0100, Zhu Yanjun wrote:
> Currently, the RXE driver uses the system-wide 'system_unbound_wq' for
> auxiliary tasks like ODP prefetching. This can lead to interference
> from other system services and lacks guaranteed forward progress
> under memory pressure.
> 
> Currently make all the tasks queue into the driver-specific 'rxe_wq'.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_odp.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_task.c | 10 +++++++++-
>  drivers/infiniband/sw/rxe/rxe_task.h |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index bc11b1ec59ac..98092dcc1870 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>  		work->frags[i].mr = mr;
>  	}
>  
> -	queue_work(system_unbound_wq, &work->work);
> +	rxe_queue_work(&work->work);
>  
>  	return 0;
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index f522820b950c..4385137eb4d7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -10,7 +10,8 @@ static struct workqueue_struct *rxe_wq;
>  
>  int rxe_alloc_wq(void)
>  {
> -	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,

Why did you add WQ_MEM_RECLAIM flag? rxe_ib_advise_mr_prefetch() doesn't
perform any memory reclaim.

Thanks

