Return-Path: <linux-rdma+bounces-17865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFNFHzr9r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 12:15:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF324A3A0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF28C3088EEA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868138423F;
	Tue, 10 Mar 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNAbrHlb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07143803CD
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140891; cv=none; b=L0jXBPhi2QwRvoifkEUMw0dQr9KyVqoNWj6q4BGJID42MwnjOU4vLraxHeHoXMdOGtsN9QcsCTYernZibJ4QpCFJ6TrdcH7zAu/JJDJxl+5lHZW2yibDkhu6JRb15NbV1xyLFgxAsQMdCiMnhHFvGcPKNANwC0SkarA12BfalMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140891; c=relaxed/simple;
	bh=H71UfF8vj1AUJXr+wgRG5Pu18eqivyqQDDQeDDAX2B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4/9r5qvcFbwy6owmJncjjUyjUbXS7RiRc+lmuq1kIK9CBBYtdAiFnGLLkzXRUc89VMEJGiB3RLZvCojwdy8worS11V/Znu8L7dG+Ij4m5eICJNIX/vUURA8M2qdP4JpMZ6JTJV3qPfIIPW6/wNpWezOs/5L+O9+tRYDNt2/DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNAbrHlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FDDC19423;
	Tue, 10 Mar 2026 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140891;
	bh=H71UfF8vj1AUJXr+wgRG5Pu18eqivyqQDDQeDDAX2B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNAbrHlbQoXAMd7MYdeGiE63dMTM6Fzq9CLbzT7Mwt1RT1o63ksmbH6RBl8OJUjuO
	 llbwwIsqoypTboA9E/qFDN7Oyrm4rs+OULkxq1lg2OqBhaK00pcSYtKGolqjNzLX7O
	 3rAkSZRMVmipg3jKt4GO++9IevMFTqI0Lu7a4EzkFdu54iXlj3CLy951oFyuerCCEp
	 vmPVGy4kQzwpr8MjsN+3D1S3QBya5eUlJNgXP06ap+WXM4xsvTgF1rdDUQn23bio2Q
	 njLb7XBS9N4Cfn0o709+5G0hNHys6bb5ksBb0UdIFqlu3XjI/HOYq5ndK7WBXL8WNi
	 0DuTzACSEgkuQ==
Date: Tue, 10 Mar 2026 13:08:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/4] Prepare for hfi2 submission
Message-ID: <20260310110806.GC12611@unreal>
References: <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
X-Rspamd-Queue-Id: E2BF324A3A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17865-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 04:44:39PM -0400, Dennis Dalessandro wrote:
> These 4 patches get rdmavt ready for hfi2 support. This is being split out
> from the previous patch submission [1].
> 
> [1] https://lore.kernel.org/linux-rdma/175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com/
> 
> ---
> 
> Dean Luick (4):
>       RDMA/OPA: Update OPA link speed list
>       RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
>       RDMA/rdmavt: Correct multi-port QP iteration
>       RDMA/rdmavt: Add driver mmap callback

Something went wrong, second patch didn't arrive.
https://lore.kernel.org/all/177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com/

> 
> 
>  drivers/infiniband/sw/rdmavt/mmap.c | 22 +++++++++++++++++-----
>  drivers/infiniband/sw/rdmavt/qp.c   |  2 +-
>  drivers/infiniband/sw/rdmavt/vt.c   |  8 ++++++++
>  include/rdma/opa_port_info.h        |  8 +++++---
>  include/rdma/rdma_vt.h              | 10 ++++++++++
>  5 files changed, 41 insertions(+), 9 deletions(-)
> 
> --
> -Denny
> 

