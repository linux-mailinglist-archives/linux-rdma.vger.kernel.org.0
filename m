Return-Path: <linux-rdma+bounces-18185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP6PFLIpuGnhZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:02:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C368F29CF53
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0374030576B7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05693B8BBD;
	Mon, 16 Mar 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbILbqT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955483B8BB4
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676711; cv=none; b=fu6MPZNvTxNNT5q1gOoEcbXBG13CPEs4950NaK8JmWLZe8LCn/hDp7egRgg6VChNSThW3qy3gP1czBVSeeKkSNBKySrWEJ8+VXZ9XwkzgPQreRGQLVqb761Pe1cu1hgydVoFXNTRAwF34iiwQdVxiSU8rx5UFh2laIoZdPcKwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676711; c=relaxed/simple;
	bh=he9g6BTyXD41RMc5Xp4zsldFfeHEycjCy+WQNDU6eC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW0OhUm/tr/POVBTRJRe1YMssnsH5pdpJTUBhXHhD6WsWI0hvPXE7bZqObyI62hsWZPTcCGfUop5/SU2SF4oR3vM/RV6jvQeEbTu5NTRjNDnw/PUOyk6B7kq+twgu4IaPgMYp3eotK4QO/k7pVujm3bR2KstLeigw5JDFfLWL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbILbqT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C9C2BC87;
	Mon, 16 Mar 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676711;
	bh=he9g6BTyXD41RMc5Xp4zsldFfeHEycjCy+WQNDU6eC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbILbqT/Z3KooB3ZyqXZEGirP/eVK3jN3JUZJ/S8KgWRKw0iImVoRB8sJvE32sRmc
	 ljQeUQTThz6hnix24304ABDyPaFqdax6h1lUxH1rfieYKaoc8JDaJDG0wEn1VwBDHe
	 X+eI5yn7gtxIYj2sO/UjHKJOlE9tOpcYYYXtRTeoBgUp7YXyxNAli2bM3LoAyheJVH
	 FTeQPlKjGwRd21qWfBRII9wNfD95BnfFZZws1JQpLg68/TfUll4o2GXiH6moTlw+ma
	 zHKXxDVmkS2Z3kBinysTd/xijb1d70ZSO/0exPky+cgYpoYpszgGv0HpmG5gx/ebdK
	 GdiWQAvgFGqDQ==
Date: Mon, 16 Mar 2026 17:58:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 07/24] RDMA/hfi2: Add system core header
 files
Message-ID: <20260316155826.GD61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325166078.57064.16035123727786325107.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325166078.57064.16035123727786325107.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18185-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C368F29CF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:54:20PM -0400, Dennis Dalessandro wrote:
> Add header files for hooking into the core system, things like IRQs and
> affinity.
> 
> Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi2/affinity.h |   86 +++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hfi2/aspm.h     |   36 ++++++++++++++
>  drivers/infiniband/hw/hfi2/efivar.h   |   17 +++++++
>  drivers/infiniband/hw/hfi2/eprom.h    |   11 ++++
>  drivers/infiniband/hw/hfi2/mmu_rb.h   |   78 ++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hfi2/msix.h     |   31 ++++++++++++
>  6 files changed, 259 insertions(+)
>  create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
>  create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
>  create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
>  create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
>  create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
>  create mode 100644 drivers/infiniband/hw/hfi2/msix.h

<...>

> +/* Can be used for both memory and cpu */
> +enum affinity_flags {
> +	AFF_AUTO,
> +	AFF_NUMA_LOCAL,
> +	AFF_DEV_LOCAL,
> +	AFF_IRQ_LOCAL
> +};

Maybe I'm misremembering, but I recall we already discussed affinity
management in the driver in the context of hfi1, and our position at the
time was that handling affinity belongs in user space.

Thanks

