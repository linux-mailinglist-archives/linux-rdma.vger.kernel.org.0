Return-Path: <linux-rdma+bounces-18311-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PmpNQ9+ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18311-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:27:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402722B9DB2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E0A3011BD8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7534DB66;
	Wed, 18 Mar 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTfIed2l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFA2AE78
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829560; cv=none; b=iB5Jz107O+Tygn0IceXvYvKq1m1nBU1q6PBKpTRlZth8rpScuq4zLvaCgpgw8dhG685vMMkrYnSmLq6J6dNajpjN8Fy501J1EaNG74ov4BiwzCv0/dGypso871kNT6UTz2Ym0f5aVztcY5U5LJbVj100cuXZOwIZnVWuGVKx8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829560; c=relaxed/simple;
	bh=lMyOz6rMUb+HRBf07asSWJPxYYjay5tgd9sE6J3H/QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAClHkpnXNRX3Kt1EkdPCpPb06eHvao0UfiQPfwNnkAna4DaTnghZjtN7kUt+Ao8MZAS4VvugmgPDCTCC32D+uHvEQqULXvr4uhAoDbnaYNpkteV91VlKpqgQPeB4iF7PMPq51/UbTAU2+1daAgvThgZIvGequ52iuAI8R2iKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTfIed2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0524FC19421;
	Wed, 18 Mar 2026 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773829559;
	bh=lMyOz6rMUb+HRBf07asSWJPxYYjay5tgd9sE6J3H/QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTfIed2l6tjgmsEMof1wXnR6ybj2Wh5ikdAxdZ1FscM9qTiRj22Kp0/1fEiz8qqsF
	 r8a1STKvu6Ik/zIas1FXj7W/+ReihLci/kEkmyS0AvkR4W6LUqJsqgCGldwmOHJRCq
	 6icR4HSFi1Kj2qzFS5z1UoNgw0QXV1quLkkNkpG1MYgE/vcI1LzmRuxiI0zC8iXwA3
	 2Ocnxr1ImpQd3kSnNp1RSDExLPS/7Xz3rRCUYsH5uFOSt2+snVbY6bBQ1Qx7RoGJ9j
	 3u3kz3UZifo/ciVdFkBKQuKIAcYI1kvSzJV954i6x52EA01tBdQLn78tSDmdMjGTlY
	 Cnt7N9n9qnP9A==
Date: Wed, 18 Mar 2026 12:25:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: (subset) [for-next 00/12] RDMA/irdma: A few fixes for irdma
Message-ID: <20260318102555.GA352386@unreal>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <177382944206.752471.10465671999149444195.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177382944206.752471.10465671999149444195.b4-ty@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18311-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 402722B9DB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 06:24:02AM -0400, Leon Romanovsky wrote:
> 
> On Mon, 16 Mar 2026 13:39:37 -0500, Tatyana Nikolova wrote:
> > This series includes a few irdma fixes:
> > 
> >  - Change request_done type to atomic
> >  - Change ah_valid type to atomic
> >  - Clean up unnecessary dereference of event->cm_node
> >  - Initialize free_qp completion before using it
> >  - Harden SQ/RQ depth calculation functions
> >  - Update ibqp state to error if QP is already in error state
> >  - Fix deadlock during netdev reset with active connections
> >  - Return EINVAL for invalid arp index error
> >  - Remove a NOP wait_event() in irdma_modify_qp_roce()
> >  - Remove reset check from irdma_modify_qp_to_err() to ensure disconnect
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/12] RDMA/irdma: Initialize free_qp completion before using it
>         (no commit info)
> [04/12] RDMA/irdma: Update ibqp state to error if QP is already in error state
>         (no commit info)
> [05/12] RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
>         (no commit info)
> [06/12] RDMA/irdma: Clean up unnecessary dereference of event->cm_node
>         (no commit info)
> [07/12] RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
>         (no commit info)
> [08/12] RDMA/irdma: Fix deadlock during netdev reset with active connections
>         (no commit info)
> [09/12] RDMA/irdma: Return EINVAL for invalid arp index error
>         (no commit info)
> [10/12] RDMA/irdma: Harden depth calculation functions
>         (no commit info)

Everything above were applied to wip/leon-for-rc

> [11/12] RDMA/irdma: Provide scratch buffers to firmware for internal use
>         (no commit info)
> [12/12] RDMA/irdma: Add support for GEN4 hardware
>         (no commit info)

These were applied to wip/leon-for-next

Thanks

> 
> Best regards,
> -- 
> Leon Romanovsky <leon@kernel.org>
> 
> 

