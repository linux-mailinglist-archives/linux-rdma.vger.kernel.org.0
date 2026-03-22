Return-Path: <linux-rdma+bounces-18498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPRHECf2v2moBgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 15:01:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5452E98D4
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 15:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE27D3005594
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82436309D;
	Sun, 22 Mar 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJGhG57w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA135958;
	Sun, 22 Mar 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774188068; cv=none; b=J/Z45WrSP0fnEwdrwdWURb2b1+7rIvMh+x8Nnj9uZkDagU9WIBhKXmovvCHy5qOskS+HoOyGBJyhQmO9zbaVsIDHnz4vK1t46KdHPm1tEDYxhh+u+OUevFCcD+E6DxVGBPWaLy3QGJAdGJuco/+uQDyR/0c2HJRGYMC0bsf/kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774188068; c=relaxed/simple;
	bh=m9V2ZnuZzKZvw9uxxeL+KR4jnzKrnrmfvPC3w11TG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPSwC0mC9YYMF7is6Nhou49A5GnY/91yZ+d/XCSsA/mfqpXTuISSXpvQUpzc2MNXMogI4s9Tmvn4swwcbfYu3MTSvBH9LBIgj9YKADZQKN5O0kVBJMjy7n9vvsxfDW5W69PjQIolVRKu02hEiOP1HuwiRXjGHJfEXlWzfItGJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJGhG57w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5061C19424;
	Sun, 22 Mar 2026 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774188068;
	bh=m9V2ZnuZzKZvw9uxxeL+KR4jnzKrnrmfvPC3w11TG4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJGhG57wIsOQodaVUWqQvwL7DlQu4fjDE1fqcofMm2te3+cczV5FNF8eqZtE1zZXY
	 Rj9y6N3M5quba/nEqEMIXWMb87QeUOachsywQiopYdhsA40DfQR7aU57TpJa6/TIEq
	 NqYqxaGN3/ToZNNwnxRJFMn4IRZDFAT4qDwRc11Zndj4n/Q8tguLiyXqFZBhCmmHBl
	 UVbVoeSyVOKS0OlcIhgxlpt0Ngw/W193FYt47YrjHAwJM5FJ0+h3N7a4L5bSf+fO95
	 SoGOv7fH70/U3Z84Gm8VPWZauwCbo8AWR9LmijYAqQU0GlwKQn3wrkHmbjEhRmIQiA
	 /NrbM2eTAoMjw==
Date: Sun, 22 Mar 2026 16:01:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Message-ID: <20260322140101.GA814676@unreal>
References: <20260318175455.1419129-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318175455.1419129-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18498-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB5452E98D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:54:55AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
> Create cq->umem if it was not created and use it to create a mana queue.
> The created umem is owned by IB/core and will be deallocated by IB/core.
> 
> To support RDMA objects that own umem, introduce mana_ib_create_queue_with_umem()
> to use the umem provided by the caller and do not de-allocate umem if it was allocted
> by the caller.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v3: Make umem allocation explicit for cq->umem and use a new helper to create mana queue from it.
>     Remove the universal helper that was added in v2
> v2: Rework of Leon's commit. Introduce univesal helper that returned ownership of umem to caller.
>     Added removed u32 overlow check for kernel cq.
>  drivers/infiniband/hw/mana/cq.c      | 131 ++++++++++++++++++---------
>  drivers/infiniband/hw/mana/device.c  |   1 +
>  drivers/infiniband/hw/mana/main.c    |  27 +++---
>  drivers/infiniband/hw/mana/mana_ib.h |   5 +-
>  4 files changed, 106 insertions(+), 58 deletions(-)

<...>

> +int mana_ib_create_queue_from_umem(struct mana_ib_dev *mdev, struct ib_umem *umem,
> +				   struct mana_ib_queue *queue)
> +{
> +	queue->umem = NULL;

Two things. First, I'm waiting for Jason to converge on this  
ib_copy_*() work. Second, I still believe drivers should not cache  
umem.

Thanks

